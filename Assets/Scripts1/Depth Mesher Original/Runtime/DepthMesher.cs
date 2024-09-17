using System;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using Dest.Modeling;
//using UnityEditor;
using Unity.Collections.LowLevel.Unsafe;

using static UnchartedLimbo.Utilities.Meshing.MeshJobs;

namespace UnchartedLimbo.NN.Depth
{
    [RequireComponent(typeof(MeshRenderer), typeof(MeshFilter))]
    public class DepthMesher : MonoBehaviour
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
            ThreePanelScreen,
            FivePanelScreen,
            Plane
        };
        public enum Direction
        {
            Radial,
            Perpendicular,
            Lifecast
        };

        public GameObject screenDepth;

        [Header("Mesh settings")]
        
        private DisplacementMethod method;
        public MeshQuality quality;
        public ProjectorType type;
        public Direction direction;
        
        [Range(0.5f,1.2f)]
        public float depthSize = 1f; // 0.52 for MADNet small, 0.743 for MADNet large

        // --------------------------------------------------------------------

        [Header("Depth Visualization")]
        private Texture colorTexture;
        private bool preprocessed;

        private NativeArray<float> depthData;

        // --------------------------------------------------------------------

        // Helper values
        private int                _width, _height;
        private DisplacementMethod _previousMethod;
        private float              _previousRatio;
        private float depthMultiplier;
        private int widthQuality;
        private int displacementDirection;
        public Transform handLeft, handRight;
        private Material mat;

        public int interval=2;
        private int count = 0;

        [Range(4, 34)]
        public int sectionSize;

        // Object references
        private MeshFilter _mf;
        private MeshCollider _col;
        private Mesh       _mesh;
        private Texture2D  _t2d;
        private Mesh baseMesh;
        // Native Arrays
        private NativeArray<float3> _vertices;
        private NativeArray<int>    _indices;
        private NativeArray<float>  _depths;
        private NativeArray<float3> baseVertices;

        private int StartXL, StartYL, StartXR, StartYR;

        // --------------------------------------------------------------------

        // Shader Properties
        private static readonly int MainTex         = Shader.PropertyToID("_MainTex");
        private static readonly int Displace        = Shader.PropertyToID("_Displace");
        private static readonly int DepthMultiplier = Shader.PropertyToID("_DepthMultiplier");
        private static readonly int _preprocessed = Shader.PropertyToID("_Preprocessed");
        private static readonly int DepthTex        = Shader.PropertyToID("_DepthTex");

        // --------------------------------------------------------------------
        // MONOBEHAVIOUR
        // --------------------------------------------------------------------

        //Disable and enable to update Collider to new mesh.
        void FixedUpdate()
        {
            Vector3 normalizedR = transform.InverseTransformPoint(handRight.transform.position).normalized;
            Vector3 normalizedL = transform.InverseTransformPoint(handLeft.transform.position).normalized;

            count += 1;
            if (count == interval && _mesh != null)
            {
                count = 0;
                UpdateCollider();
                //Debug.Log(normalizedVec);
            }

            StartXR = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedR.x + 1f) / 2f);
            StartYR = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedR.y + 1f) / 2f);

            StartXL = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedL.x + 1f) / 2f);
            StartYL = (int)Mathf.Lerp(0f, widthQuality - sectionSize, (normalizedL.y + 1f) / 2f);
        }

        private void UpdateCollider()
        {
            gameObject.GetComponent<MeshCollider>().enabled=false;
            gameObject.GetComponent<MeshCollider>().enabled=true;
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
        public void SetSettings(int quality, int refreshPeriod, bool _preprocessed)
        {
            //(quality, refreshPeriod, debugMesh, preprocessed)
            //Sets the settings defined in the start menu

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
            

            //Set the displacement direction.
            if (direction==Direction.Radial) 
            {
                displacementDirection = 0;
            } 
            else if (direction==Direction.Perpendicular)
            {
                displacementDirection = 1;
            }
            else
            {
                displacementDirection = 2;
            }

            //Set the pixel width of each Mesh Quality


            if (type==ProjectorType.Plane)
            {
                baseMesh = Resources.Load<Mesh>("Meshes/Plane"+ widthQuality.ToString());
            }
            else if ((type == ProjectorType.ThreePanelScreen) || (type == ProjectorType.FivePanelScreen))
            {
                baseMesh  = Instantiate(Resources.Load<Mesh>("Meshes/Plane" + widthQuality.ToString()));
            }
            else if (type == ProjectorType.HalfSphere)
            {
                baseMesh = MeshGenerator.CreateSphere(-1f, widthQuality - 1, widthQuality - 1, 180f, 180f, false, false, true);
            }
            else
            {
                baseMesh = MeshGenerator.CreateSphere(-1f, widthQuality - 1, widthQuality - 1, 360f, 180f, false, false, true);
            }

            baseVertices = GetNativeVertexArrays(baseMesh.vertices);
            
            
            MeshCollider _col = gameObject.GetComponent<MeshCollider>();
            _col.sharedMesh = null;

            _mf            = GetComponent<MeshFilter>();
            _mesh          = new Mesh {indexFormat = IndexFormat.UInt32};

            _mf.sharedMesh = _mesh;
            _col.sharedMesh = _mesh;
            _col.cookingOptions= MeshColliderCookingOptions.CookForFasterSimulation;

            //*Moved to fixed update*
            //InvokeRepeating("UpdateCollider", 2.0f, reconstructionRate);

        }

        void OnEnable()
        {
            mat = screenDepth.GetComponent<Renderer>().material;
        }

        private void Update()
        {
            //gameObject.transform.localScale = new Vector3(distance, distance, distance);  Changes the scale. Visually the same, can be helpful for other things.
            
            depthMultiplier = depthSize;
            mat.SetFloat(DepthMultiplier, depthMultiplier);

            // In Barracuda 1.0.4 the output of MiDaS can be passed  directly to a texture as it is shaped correctly.
            // In later versions we have to swap X and Y axes, and also flip the X axis...
            // We need to inform the shader of this change.

        }

        private void OnDestroy()
        {
            DeallocateArrays();

            Destroy(_mesh);
            
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

        /// <summary>
        /// Executes when a new texture is received
        /// </summary>
        public void setDepth(float depthValue)
        {
            depthSize = depthValue;
        }

        public void OnTextureReceived(RenderTexture rt)
        {
            if (rt.width * rt.height == 0) return;

            RenderTexture tempTex;
            tempTex = RenderTexture.GetTemporary(widthQuality, widthQuality, 0, RenderTextureFormat.RFloat);

            if (screenDepth.activeSelf)
            {
                mat.SetTexture(DepthTex, rt);
                mat.SetTexture(MainTex, colorTexture);
            }
            

            Graphics.Blit(rt, tempTex);
            rt = tempTex;
            RenderTexture.ReleaseTemporary(tempTex);

            // Vertex Displacement on the CPU - Mesh gets updated at every frame
            if (method == DisplacementMethod.Mesh)
            {
                _mesh.MarkDynamic();

                var jobs = new NativeList<JobHandle>(Allocator.Temp);

                if (_width != rt.width || _height != rt.height)
                {
                    _width  = rt.width;
                    _height = rt.height;

                    AllocateArrays(rt.width, rt.height);

                    jobs.Add(UpdateIndexBuffer());
                    //jobs.Add(UpdateUVBuffer());
                }

                depthData = ReadTextureAsync(rt);
                UpdateVertexJob();

                JobHandle.CompleteAll(jobs);
                UpdateMesh(true);
                //nderTexture.ReleaseTemporary(tempTex);
            }
            // Vertex Displacement on the GPU - Mesh only needs to be created once
            else
            {
                // Generate mesh only if necessary
                if (_width != rt.width || _height != rt.height || _previousMethod != method || Math.Abs(_previousRatio - Ratio) > 0.001F)
                {
                    _width  = rt.width;
                    _height = rt.height;

                    var tempDepth = new NativeArray<float>(rt.width * rt.height, Allocator.TempJob);
                    var jobs      = new NativeList<JobHandle>(Allocator.Temp);
                    
                    // Flat plane
                    AllocateArrays(rt.width, rt.height);

                    depthData = tempDepth;
                    UpdateVertexJob();

                    jobs.Add(UpdateIndexBuffer());
                    //jobs.Add(UpdateUVBuffer());
                    JobHandle.CompleteAll(jobs);

                    UpdateMesh(true);

                    tempDepth.Dispose();
                }
            }

            _previousMethod = method;
            _previousRatio  = Ratio;
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
            jobData.direction = displacementDirection;
            jobData.Start = new float4(StartXL, StartYL, StartXR, StartYR);
            //offset = _offset,
            //jobData.preprocessed = preprocessed;

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
