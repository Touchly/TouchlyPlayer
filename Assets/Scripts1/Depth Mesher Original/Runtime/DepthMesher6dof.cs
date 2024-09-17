using System;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using Unity.Collections.LowLevel.Unsafe;
using Dest.Modeling;
using System.Diagnostics;

using static UnchartedLimbo.Utilities.Meshing.MeshJobs6dof;

namespace UnchartedLimbo.NN.Depth
{
    [RequireComponent(typeof(MeshRenderer), typeof(MeshFilter))]
    public class DepthMesher6dof : MonoBehaviour
    {
        public bool staticScene=false;
        
        public enum MeshQuality
        {
            High,
            Medium,
            Low
        }

        [Range(0.2f, 1.2f)]
        public float distance = 1f;
        public Transform handLeft, handRight;

        [Header("Mesh settings")]
        
        public MeshQuality quality;


        //Size of the "panels" for each hand
        [Range(4, 34)]
        public int sectionSize;


        private int StartXL, StartYL, StartXR, StartYR;

        //[Range(0.1f,1.5f)]
        //public float depthSize = 1.1f; //0.395 for quest/smallest model 0.743 for normal
        [Range(0.1f,1.5f)]
        public float depthSize=0.743f;
        
        //[Range(-1, 1)]
        //public float offset = 0f;

        [Range(0, 0.1f)]
        public float imageScale = 0.009f;

        public float ImageScale
        {
           get => imageScale;
            set => imageScale = value;
        }
        // --------------------------------------------------------------------

        [Header("Depth Visualization")]
        public Material mat, backgroundMat;
        public Texture colorTexture;
        private bool preprocessed;

        // --------------------------------------------------------------------

        // Helper values
        private int                _width, _height;
        private float depthMultiplier;
        private int widthQuality, heightQuality;
        private int count = 0;
        private int format =0;

        // Object references
        private MeshFilter _mf;
        private MeshCollider _col;
        private Mesh       _mesh;
        private Texture2D  _t2d;
        private Mesh baseMesh;
        
        bool updateCol= true, enableCol=true;

        // Native Arrays
        private NativeArray<float3> _vertices;
        private NativeArray<int>    _indices;
        //private NativeArray<float2> _uv;
        private NativeArray<float> depthData;
        //private NativeArray<float>  _depths;
        private NativeArray<float3> baseVertices;
        float aspectRatio;

        float maxAngle = 180f;

        private float3 boundsSize;

        private MeshCollider _meshCollider;

        [Range(0.9f, 1.8f)]
        [SerializeField] float squareFactorY=1f, squareFactorX=1f;

        [Range(-20, 20)]
        [SerializeField] int vertOffset=-5, horOffset=0;

        Stopwatch stopwatch;
        // --------------------------------------------------------------------

        // Shader Properties

        private static readonly int Direction = Shader.PropertyToID("_Direction");
        private static readonly int MainTex         = Shader.PropertyToID("_MainTex");
        private static readonly int Displace        = Shader.PropertyToID("_Displace");
        private static readonly int DepthIsColor = Shader.PropertyToID("_DepthIsColor");
        private static readonly int DepthMultiplier = Shader.PropertyToID("_DepthMultiplier");
        //Color stuff
        private static readonly int Saturation = Shader.PropertyToID("_Saturation");
        private static readonly int Exposition = Shader.PropertyToID("_Exposition");
        private static readonly int Contrast = Shader.PropertyToID("_Contrast");

        private static readonly int EdgeSens = Shader.PropertyToID("_EdgeSens");

        private static readonly int _preprocessed = Shader.PropertyToID("_Preprocessed");
        //private static readonly int offset = Shader.PropertyToID("_Offset");
        private static readonly int DepthTex        = Shader.PropertyToID("_DepthTex");

        // --------------------------------------------------------------------
        // MONOBEHAVIOUR
        // --------------------------------------------------------------------
        //For color, etc
        public void MaterialSetFloat(int name, float value)
        {
            mat.SetFloat(name, value);
            backgroundMat.SetFloat(name, value);
        }

        public void setColorAsDepth(bool set)
        {
            if (mat)
            {
                if (set)
                {
                    mat.SetInt(DepthIsColor, 1);
                    backgroundMat.SetInt(DepthIsColor, 1);
                }
                else
                {
                    mat.SetInt(DepthIsColor, 0);
                    backgroundMat.SetInt(DepthIsColor, 0);
                }
            }
        }
        

        //Disable and enable to update Collider to new mesh.
        /*
        void FixedUpdate()
        {
            if (handRight!=null && handLeft != null)
            {
                // If it does not exist yet, create it
                Vector3 normalizedR = new Vector3();
                Vector3 normalizedL = new Vector3();

                if (format==0 || format==2 || format==3){
                    normalizedR = transform.InverseTransformPoint(handRight.transform.position).normalized;
                    normalizedL = transform.InverseTransformPoint(handLeft.transform.position).normalized;
                } else if (format==1){
                    normalizedR = transform.InverseTransformPoint(handRight.transform.position);
                    normalizedL = transform.InverseTransformPoint(handLeft.transform.position);
                    //So that left side of mesh = -1, right side = 1
                    normalizedR = new Vector3(2*normalizedR.y/(boundsSize.y)*squareFactorY, -2*normalizedR.x/(boundsSize.x)*squareFactorX, 0);
                    normalizedL = new Vector3(2*normalizedL.y/(boundsSize.y)*squareFactorY, -2*normalizedL.x/(boundsSize.x)*squareFactorX, 0);
                }

                if (format==3){
                    if (normalizedR.z < 0)
                    {
                        rightOnBack = true;
                    }
                    else
                    {
                        rightOnBack = false;
                    }

                    if (normalizedL.z < 0)
                    {
                        leftOnBack = true;
                    }
                    else
                    {
                        rightOnBack = false;
                    }
                }
                
                count += 1;
                if (_mesh != null)
                {
                    count = 0;
                    UpdateCollider();
                    //Debug.Log(normalizedVec);
                }
                
                StartXR = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedR.x + 1f) / 2f) + horOffset;
                StartYR = (int)Mathf.Lerp(0f, heightQuality - sectionSize, (normalizedR.y + 1f) / 2f) + vertOffset;

                StartXL = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedL.x + 1f) / 2f) + horOffset;
                StartYL = (int)Mathf.Lerp(0f, heightQuality - sectionSize, (normalizedL.y + 1f) / 2f) + vertOffset;
            }
        }
        */

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

        public void Distance(float _distance)
        {
            distance = _distance;
            gameObject.transform.position = new Vector3(0f, 0f, distance);
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
        public void SetSettings(int quality, int refreshPeriod, bool pre, int _format)
        {
            format = _format;
            mat.SetInt(Direction, format);
            //SetEdgeSens(5f);
            backgroundMat.SetInt(Direction, format);
            
            //(quality, refreshPeriod, debugMesh, preprocessed)
            //Sets the settings defined in the start menu
            _meshCollider = gameObject.GetComponent<MeshCollider>();
            //Preprocessed
            preprocessed = pre;
            mat.SetInt(_preprocessed, 1);
            backgroundMat.SetInt(_preprocessed, 1);
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

        public void setAspectRatio(float _aspectRatio)
        {
            aspectRatio = _aspectRatio;
            UnityEngine.Debug.Log(aspectRatio);
        }

        private void Begin()
        {
            
            stopwatch = new Stopwatch();
            stopwatch.Start();

            if (!preprocessed){
                #if UNITY_ANDROID && !UNITY_EDITOR
                depthSize = 0.395f;
                #else
                depthSize = 0.743f;
                #endif
            }
            
            if (staticScene)
            {
                mat.SetInt(DepthIsColor, 1);
                //backgroundMat.SetInt(DepthIsColor, 1);
            }
            
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


            //Set the pixel width of each Mesh Quality
            baseVertices = GetNativeVertexArrays(baseMesh.vertices);


            _col = gameObject.GetComponent<MeshCollider>();
            //_col.sharedMesh = null;

            _mf            = GetComponent<MeshFilter>();
            _mesh          = new Mesh {indexFormat = IndexFormat.UInt32};

            _mf.sharedMesh = _mesh;
            
            mat.SetInt(Displace, 1);
            backgroundMat.SetInt(Displace, 1);
            
            boundsSize = baseMesh.bounds.size;
            //Material settings.
        }

        private void Update()
        {
            //Set shader properties
            mat.SetFloat(DepthMultiplier, depthMultiplier);
            backgroundMat.SetFloat(DepthMultiplier, depthMultiplier);
           // mat.SetFloat(offset, _offset);

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
            _mesh = null;
            baseMesh = null;
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
            if (depthData.IsCreated) depthData.Dispose();
        }


        // --------------------------------------------------------------------
        // PUBLIC INTERFACES
        // --------------------------------------------------------------------

        /// <summary>
        /// Height / Width ratio of the source footage. Used to scale the mesh properly
        /// </summary>
        public float Ratio { get; set; }

        /// <summary>
        /// Executes when a new texture is received
        /// </summary>
        public void setDepth(float depthValue)
        {
            depthSize = depthValue;
        }

        public void SetEdgeSens(float edgeSensValue)
        {
            mat.SetFloat(EdgeSens, edgeSensValue);
        }

        public void OnTextureReceived(RenderTexture rt)
        {
            if (rt.width * rt.height == 0) return;
            
            mat.SetTexture(DepthTex, rt);

            RenderTexture tempTex;
            tempTex = RenderTexture.GetTemporary(widthQuality, heightQuality, 0, rt.graphicsFormat);
            Graphics.Blit(rt, tempTex);

            _mesh.MarkDynamic();
            

            var jobs = new NativeList<JobHandle>(Allocator.Temp);
            
            if (_width != tempTex.width || _height != tempTex.height)
            {
                _width  = tempTex.width;
                _height = tempTex.height;
                AllocateArrays(tempTex.width, tempTex.height);
                jobs.Add(UpdateIndexBuffer());
            }

            depthData = ReadTextureAsync(tempTex);

            UpdateVertexJob();

            RenderTexture.ReleaseTemporary(tempTex);
            JobHandle.CompleteAll(jobs);
            UpdateMesh(true);
        }


        // --------------------------------------------------------------------
        // MESH UPDATES
        // --------------------------------------------------------------------

        /// <summary>
        /// Update mesh vertices using depth data (JobHandle needs to be completed by the caller)
        /// </summary>
        /// 
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
                    width   = sectionSize,
            }.Schedule(_indices.Length, 64);
        }

        /// <summary>
        /// Update mesh UVs  (JobHandle needs to be completed by the caller)
        /// </summary

        /// <summary>
        /// Update Mesh
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

            if (_col.sharedMesh == null)
            {
                _col.sharedMesh = _mesh;
                //_col.cookingOptions = MeshColliderCookingOptions.CookForFasterSimulation;
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

            //RenderTexture.active = rt;
            //_t2d.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0);
            //_t2d.Apply();

            var req = AsyncGPUReadback.Request(rt, 0, asyncAction =>
            {
                if (_t2d == null) return;
                _t2d.SetPixelData(asyncAction.GetData<byte>(), 0);
                _t2d.Apply();

            });

            if (safe)
                req.WaitForCompletion();

            //Pasa los datos "raw" de la textura al cpu
            return _t2d.GetRawTextureData<float>();
        }
    }
}
