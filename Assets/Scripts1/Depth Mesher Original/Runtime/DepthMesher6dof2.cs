using System;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using Unity.Collections.LowLevel.Unsafe;
using Dest.Modeling;

using static UnchartedLimbo.Utilities.Meshing.MeshJobs6dof;

namespace UnchartedLimbo.NN.Depth
{
    [RequireComponent(typeof(MeshRenderer), typeof(MeshFilter))]
    public class DepthMesher6dof2 : MonoBehaviour
    {
        public enum DisplacementMethod
        {
            Mesh,
            Shader
        }
        
        public enum MeshQuality
        {
            High,
            Medium,
            Low
        }

        public enum ProjectorType 
        { 
            HalfSphere,
            Sphere,
            Plane
        };


        [Header("Mesh settings")]
        
        private DisplacementMethod method;
        public MeshQuality quality;
        public Transform handLeft, handRight;
        private int format = 0;


        [Range(0.7f,1.1f)]
        public float depthSize = 1.1f;

        //[Range(-1, 1)]
        //public float offset = 0f;


        // --------------------------------------------------------------------

        [Header("Depth Visualization")]
        private Material mat;
        public GameObject Screen;
        public Texture colorTexture;
        private bool preprocessed;
        [SerializeField] float squareFactorY=1f, squareFactorX=1f;

        [Range(0, 1)]
        public float _offset = 0.3f;

        private int StartXL, StartYL, StartXR, StartYR;


        [Range(4, 34)]
        public int sectionSize;

        [Range(0, 2)]
        public float LogNormalizationFactor = 1;

        //private float reconstructionRate = 1f;
        // --------------------------------------------------------------------

        // Helper values
        private int                _width, _height;
        private float depthMultiplier;
        private int widthQuality, heightQuality;
        public int interval=2;
        private int count = 0;

        // Object references
        private MeshFilter _mf;
        private MeshCollider _col;
        private Mesh       _mesh;
        private Texture2D  _t2d;
        private Mesh baseMesh;
        float aspectRatio;

        // Native Arrays
        private NativeArray<float3> _vertices;
        private NativeList<float3>.ParallelWriter _verticesWriter;

        private NativeArray<int>    _indices;
        //private NativeArray<float2> _uv;
        private NativeArray<float3> baseVertices;
        private NativeArray<float> depthData;

        private MeshCollider _meshCollider;
        bool updateCol=true, enableCol=true;

        private float3 boundsSize;

        float maxAngle = 180f;

        [SerializeField] int vertOffset=-5, horOffset=0;


        // --------------------------------------------------------------------

        // Shader Properties
        private static readonly int MainTex         = Shader.PropertyToID("_MainTex");
        private static readonly int Displace        = Shader.PropertyToID("_Displace");
        private static readonly int Direction        = Shader.PropertyToID("_Direction");
        private static readonly int DepthMultiplier = Shader.PropertyToID("_DepthMultiplier");
        private static readonly int Preprocessed = Shader.PropertyToID("_Preprocessed");
        private static readonly int DepthTex        = Shader.PropertyToID("_DepthTex");
        private static readonly int offset = Shader.PropertyToID("_Offset");
        private static readonly int EdgeSens = Shader.PropertyToID("_EdgeSens");


        // --------------------------------------------------------------------
        // MONOBEHAVIOUR
        // --------------------------------------------------------------------

        void OnEnable()
        {
            mat=Screen.GetComponent<Renderer>().material;
            _meshCollider = gameObject.GetComponent<MeshCollider>();
            
        }
        
        public void setAspectRatio(float _aspectRatio)
        {
            aspectRatio = _aspectRatio;
            Debug.Log(aspectRatio);
        }
        
        public void SetEdgeSens(float edgeSensValue)
        {
            mat.SetFloat(EdgeSens, edgeSensValue);
        }

        void FixedUpdate()
        {
            if (handRight!=null && handLeft != null)
            {
                // If it does not exist yet, create it
                float rightTheta = 0f;
                float leftTheta = 0f;
                float rightPhi = 0f;
                float leftPhi = 0f;
                
                if (format==0 || format==2 || format==3){

                    Vector3 normalizedR = new Vector3();
                    Vector3 normalizedL = new Vector3();
                    normalizedR = transform.InverseTransformPoint(handRight.transform.position);
                    normalizedL = transform.InverseTransformPoint(handLeft.transform.position);

                    rightPhi = Vector3.Angle(-transform.up, Vector3.ProjectOnPlane(handRight.transform.position, transform.right));
                    leftPhi = Vector3.Angle(-transform.up, Vector3.ProjectOnPlane(handLeft.transform.position, transform.right));

                    rightTheta = Vector3.Angle(transform.right, Vector3.ProjectOnPlane(handRight.transform.position, transform.up));
                    leftTheta = Vector3.Angle(transform.right, Vector3.ProjectOnPlane(handLeft.transform.position, transform.up));

                    if (normalizedL.z > 0)
                    {
                        leftTheta = 360f - leftTheta;
                    }
                    
                    if (normalizedR.z > 0)
                    {
                        rightTheta = 360f - rightTheta;
                    }

                    StartXR = (int)Mathf.Lerp(0f, widthQuality - sectionSize, rightTheta/maxAngle) + horOffset;
                    StartYR = (int)Mathf.Lerp(0f, heightQuality - sectionSize, rightPhi/180f ) + vertOffset;

                    StartXL = (int)Mathf.Lerp(0f, widthQuality - sectionSize, leftTheta/maxAngle) + horOffset;
                    StartYL = (int)Mathf.Lerp(0f, heightQuality - sectionSize, leftPhi/180f) + vertOffset;
                    
                    

                } else if (format==1){

                    Vector3 normalizedR = new Vector3();
                    Vector3 normalizedL = new Vector3();

                    normalizedR = transform.InverseTransformPoint(handRight.transform.position);
                    normalizedL = transform.InverseTransformPoint(handLeft.transform.position);

                    //So that left side of mesh = -1, right side = 1
                    normalizedR = new Vector3(2*normalizedR.y/(boundsSize.y)*squareFactorY, -2*normalizedR.x/(boundsSize.x)*squareFactorX, 0);
                    normalizedL = new Vector3(2*normalizedL.y/(boundsSize.y)*squareFactorY, -2*normalizedL.x/(boundsSize.x)*squareFactorX, 0);

                    StartXR = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedR.x + 1f) / 2f) + horOffset;
                    StartYR = (int)Mathf.Lerp(0f, heightQuality - sectionSize, (normalizedR.y + 1f) / 2f) + vertOffset;

                    StartXL = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedL.x + 1f) / 2f) + horOffset;
                    StartYL = (int)Mathf.Lerp(0f, heightQuality - sectionSize, (normalizedL.y + 1f) / 2f) + vertOffset;
                }
                
                count += 1;
                if (_mesh != null)
                {
                    count = 0;
                    UpdateCollider();
                }
            }
        }

        public void ToggleCollider(bool toggle){
            updateCol = toggle;
        }
        public void EnableCollider(bool toggle){
            enableCol = toggle;
        }

        private void UpdateCollider()
        {
            if (updateCol && enableCol)
            {
                _meshCollider.enabled=false;
                _meshCollider.enabled=true;
            } else {
                if (_meshCollider.enabled)
                {
                    _meshCollider.enabled=false;
                }
            }
            
        }

        private void SetMeshQuality()
        {
            if (quality == MeshQuality.High)
            {
                widthQuality = 256;
            }
            else if (quality == MeshQuality.Medium)
            {
                widthQuality = 128;
            }
            else
            {
                widthQuality = 64;
            }
        }
        //Sets settings before starting, Runs before Begin()
        public void SetSettings(int quality, int refreshPeriod, bool _preprocessed, int _format)
        {
            //(quality, refreshPeriod, debugMesh, preprocessed)
            //Sets the settings defined in the start menu
            format = _format;
            mat.SetInt(Direction, format);
            SetEdgeSens(5f);

            mat.SetInt(Preprocessed, 1);

            //Preprocessed
            preprocessed = _preprocessed;

            //Quality. Pixel density of the generated mesh, in one axis.
            if (quality == 0)
            {
                widthQuality = 64;
            }
            else if (quality == 1)
            {
                widthQuality = 128;
            }
            else if (quality == 2)
            {
                widthQuality = 256;
            }

            Begin();
        }

        private void Begin()
        {
            

            mat.SetInt(Displace, 1);
            //Set the pixel width of each Mesh Quality

            //Set the displacement direction.
            if (format == 1)
            {
                //baseMesh = Resources.Load<Mesh>("Meshes/Plane" + widthQuality.ToString());
                heightQuality = (int)(widthQuality/aspectRatio);
                baseMesh = MeshGenerator.CreatePlane(MeshGenerator.Directions.Forward, 1f, aspectRatio, heightQuality - 1, widthQuality - 1, true, true);
                transform.localScale = new Vector3(1f, 1f, 1f);
                transform.localPosition = new Vector3(0f, 0f, 0f);
                transform.parent.localPosition = new Vector3(0f, 0f, 2f);
                transform.localEulerAngles = new Vector3(0f, 180f, 90f);
            }
            else if (format == 0 || format == 2)
            {
                maxAngle = 180f;
                heightQuality = widthQuality;
                transform.localPosition = new Vector3(0f, 0f, -0.013f);
                baseMesh = MeshGenerator.CreateSphere(-1f, widthQuality - 1, widthQuality - 1, 180f, 180f, false, false, true);
            }
            else if (format ==3) 
            {
                maxAngle = 360f;
                heightQuality = widthQuality/2;
                transform.localPosition = new Vector3(0f, 0f, -0.013f);
                baseMesh = MeshGenerator.CreateSphere(-1f, heightQuality - 1, widthQuality - 1, 360f, 180f, false, false, true);
            }


            baseVertices = GetNativeVertexArrays(baseMesh.vertices);
            boundsSize = baseMesh.bounds.size;
            
            MeshCollider _col = gameObject.GetComponent<MeshCollider>();
            _col.sharedMesh = null;

            _mf            = GetComponent<MeshFilter>();
            _mesh          = new Mesh {indexFormat = IndexFormat.UInt32};

            _mf.sharedMesh = _mesh;
            _col.sharedMesh = _mesh;
            //_col.cookingOptions= MeshColliderCookingOptions.CookForFasterSimulation;
        }

        private void Update()
        {
            //Set shader properties
            mat.SetFloat(DepthMultiplier, depthMultiplier);

            //gameObject.transform.localScale = new Vector3(distance, distance, distance);  Changes the scale. Visually the same, can be helpful for other things.

            depthMultiplier = depthSize;

            #if _CHANNEL_SWAP
                            mat.SetInt("_SwapChannels",1);
            #else
                        mat.SetInt("_SwapChannels", 0);
            #endif
        }

        private void OnDestroy()
        {
            DeallocateArrays();

            Destroy(_mesh);
            Destroy(baseMesh);
            baseMesh = null;
            _mesh = null;

            Destroy(_t2d);
            _t2d = null;
        }

        private void OnApplicationQuit()
        {
            baseVertices.Dispose();
        }

        //Convert Vector3 to NativeArray
        unsafe NativeArray<float3> GetNativeVertexArrays(Vector3[] vertexArray)
        {
            NativeArray<float3> verts = new NativeArray<float3>(vertexArray.Length, Allocator.Persistent,
                NativeArrayOptions.UninitializedMemory);

            fixed (void* vertexBufferPointer = vertexArray)
            {
                UnsafeUtility.MemCpy(NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(verts),
                    vertexBufferPointer, vertexArray.Length * (long)UnsafeUtility.SizeOf<float3>());
            }

            return verts;
        }

        unsafe void SetNativeVertexArray(Vector3[] vertexArray, NativeArray<float3> vertexBuffer)
        {
            // pin the target vertex array and get a pointer to it
            fixed (void* vertexArrayPointer = vertexArray)
            {
                // memcopy the native array over the top
                UnsafeUtility.MemCpy(vertexArrayPointer, NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(vertexBuffer), vertexArray.Length * (long)UnsafeUtility.SizeOf<float3>());
            }
        }

        // --------------------------------------------------------------------
        // MEMORY MANAGEMENT
        // --------------------------------------------------------------------

        //Función seleccionar el asset baseMesh

        private void AllocateArrays(int width, int height)
        {
            DeallocateArrays();

            _vertices = new NativeArray<float3>(2 * sectionSize * sectionSize, Allocator.Persistent);
            _indices = new NativeArray<int>((sectionSize - 1) * (sectionSize - 1) * 4 * 2, Allocator.Persistent);
            //_uv       = new NativeArray<float2>(_vertices.Length, Allocator.Persistent);
        }

        private void DeallocateArrays()
        {
            if (_vertices.IsCreated) _vertices.Dispose();
            if (_indices.IsCreated) _indices.Dispose();
            //if (_uv.IsCreated) _uv.Dispose();
        }


        // --------------------------------------------------------------------
        // PUBLIC INTERFACES
        // --------------------------------------------------------------------

        /// <summary>
        /// Height / Width ratio of the source footage. Used to scale the mesh properly
        /// </summary>
        public float Ratio { get; set; }


        public void setDepth(float depthValue)
        {
            depthSize = depthValue;
        }
        /// <summary>
        /// Executes when a new texture is received
        /// </summary>
        public void OnTextureReceived(RenderTexture rt)
        {
            if (rt.width * rt.height == 0) return;
            
            mat.SetTexture(MainTex, colorTexture);
            mat.SetTexture(DepthTex, rt);

            RenderTexture tempTex;
            tempTex = RenderTexture.GetTemporary(widthQuality, heightQuality, 0, rt.graphicsFormat);
            Graphics.Blit(rt, tempTex);
            rt = tempTex;
            RenderTexture.ReleaseTemporary(tempTex);

            // Vertex Displacement on the CPU - Mesh gets updated at every frame

            _mesh.MarkDynamic();
            

            var jobs = new NativeList<JobHandle>(Allocator.Temp);
            
            if (_width != rt.width || _height != rt.height)
            {
                _width  = rt.width;
                _height = rt.height;
               // var tempDepth = new NativeArray<float>(rt.width * rt.height, Allocator.TempJob);
                AllocateArrays(rt.width, rt.height);
               // jobs.Add(UpdateVertexBuffer(tempDepth));
                jobs.Add(UpdateIndexBuffer());
                //jobs.Add(UpdateUVBuffer());
                
                //tempDepth.Dispose();
            }
            depthData = ReadTextureAsync(rt);
            UpdateVertexJob();

            JobHandle.CompleteAll(jobs);
            UpdateMesh(true);
        }


        // --------------------------------------------------------------------
        // MESH UPDATES
        // --------------------------------------------------------------------

        /// <summary>
        /// Update mesh vertices using depth data (JobHandle needs to be completed by the caller)
        /// </summary>
        private void UpdateVertexJob()
        {
            GridVerticesJob jobData = new GridVerticesJob();

            jobData.vertices = _vertices;
            jobData.depth = depthData;
            jobData.sectionSize = sectionSize;
            jobData.gridResolution_X = _width;
            jobData.depthMultiplier = depthMultiplier;
            jobData.baseVertices = baseVertices;
            jobData.format = format;
            jobData.Start = new float4(StartXL, StartYL,StartXR,StartYR);
            //offset = _offset,
            jobData.preprocessed = true;

            JobHandle handle = jobData.Schedule();
            handle.Complete();

        }

        /// <summary>
        /// Update mesh indices (JobHandle needs to be completed by the caller)
        /// </summary>
        private JobHandle UpdateIndexBuffer()
        {
            return new GridIndicesJob
            {
                    indices = _indices,
                    width   = sectionSize
            }.Schedule(_indices.Length, 64);
        }

        /// <summary>
        /// Update Mesh
        /// </summary>
        private void UpdateMesh(bool topologyChanged = false)
        {
            if (topologyChanged)
            {
                _mesh.Clear();
                _mesh.SetVertices(_vertices);
                _mesh.SetIndices(_indices, MeshTopology.Quads, 0);
                //_mesh.SetUVs(0, _uv);
            }
            else
            {
                _mesh.SetVertices(_vertices);
            }

            //_mesh.RecalculateNormals();
            _mesh.RecalculateBounds();
        }


        // --------------------------------------------------------------------
        // TEXTURE IO
        // --------------------------------------------------------------------
        /// <summary>
        ///  Read a RenderTexture back to CPU
        /// </summary>
        /// Lee la textura -> Esto se lo entrega al updateVertex
        private NativeArray<float> ReadTextureAsync(RenderTexture rt, bool safe = false)
        {
            // Create or resize texture2D
            if (_t2d == null)
            {
                _t2d = new Texture2D(rt.width, rt.height, rt.graphicsFormat, TextureCreationFlags.None);
            }
            else if (_t2d.width != rt.width || _t2d.height != rt.height)
            {
                _t2d.Reinitialize(rt.width, rt.height);
            }
            
            // Asynchronously read the data from the GPU
            // No check whether the data has been fully received
            // Quite possible data mixups
            var req = AsyncGPUReadback.Request(rt, 0, asyncAction =>
            {
                if (_t2d == null) return;
                _t2d.SetPixelData(asyncAction.GetData<byte>(), 0);
                _t2d.Apply();
             
            });

            if (safe)
                req.WaitForCompletion();
            //Pasa los datos "raw" de la textura
            return _t2d.GetRawTextureData<float>();
        }


    }
}
