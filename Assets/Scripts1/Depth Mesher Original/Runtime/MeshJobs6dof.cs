using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using System.Collections.Generic;
namespace UnchartedLimbo.Utilities.Meshing
{
    /// <summary>
    /// Contains Parallel Jobs that facilitate the fast generation of meshes.
    /// </summary>
    public static class MeshJobs6dof
    {
        //[BurstCompile]
        public struct GridVerticesJob : IJob
        {
            public NativeArray<float> depth;
            public NativeArray<float3> vertices;
            public int gridResolution_X;
            //public int gridResolution_Y;
            public float2 xyMultiplier;
            public float depthMultiplier;
            public float4 Start; //[StartXL,StartYL, StartXR, StartYR]
            public NativeArray<float3> baseVertices;
            public int format;
            public int sectionSize;

            //public float offset;
            public bool preprocessed;

            public void Execute()
            {
                var iL = 0;
                var iR = vertices.Length/2;

                for (var index=0; index<depth.Length; index++)
                {
                    var z = baseVertices[index].z;
                    var x = baseVertices[index].x;
                    var y = baseVertices[index].y;

                    var ix = index % gridResolution_X;
                    var iy = index / gridResolution_X;

                    //Right hand mesh section

                    //If index is in range. sectionSize*sectionSize Panel
                    if ((ix >= Start[2]) && (ix <= Start[2] + sectionSize-1) && (iy >= Start[3]) && (iy <= Start[3] + sectionSize-1))
                    {
                        var _depth = depth[index];

                        if (_depth > 50f)
                        {
                            _depth = 50f;
                        }
                        else if (_depth < 0.007f)
                        {
                            _depth = 0.007f;
                        }

                        if (format==0 || format==2 || format==3){
                            if (preprocessed){
                            z = depthMultiplier * baseVertices[index].z * 0.3f / _depth;
                            x = depthMultiplier * baseVertices[index].x * 0.3f / _depth; 
                            y = depthMultiplier * baseVertices[index].y * 0.3f / _depth; 
                            } else {
                                z = 4*depthMultiplier * baseVertices[index].z * _depth; 
                                x = 4*depthMultiplier * baseVertices[index].x * _depth; 
                                y = 4*depthMultiplier * baseVertices[index].y * _depth;
                            }
                        } else if (format==1){
                            z= baseVertices[index].z + depthMultiplier * _depth; // Change to intrinsic matrix
                        }
                        
                        vertices[iR] = new float3(x, y, z);
                        iR += 1;
                    }

                    //Left hand mesh section

                    //If index is in range.
                    if ((ix >= Start[0]) && (ix <= Start[0] + sectionSize-1) && (iy >= Start[1]) && (iy <= Start[1] + sectionSize-1))
                    {
                        var _depth = depth[index];

                        if (_depth > 50f)
                        {
                            _depth = 50f;
                        }
                        else if (_depth < 0.007f)
                        {
                            _depth = 0.007f;
                        }

                        if (format==0 || format==2 || format==3){
                            if (preprocessed){
                            z = depthMultiplier * baseVertices[index].z * 0.3f / _depth;
                            x = depthMultiplier * baseVertices[index].x * 0.3f / _depth; 
                            y = depthMultiplier * baseVertices[index].y * 0.3f / _depth; 
                            } else {
                                z = 4*depthMultiplier * baseVertices[index].z * _depth; 
                                x = 4*depthMultiplier * baseVertices[index].x * _depth; 
                                y = 4*depthMultiplier * baseVertices[index].y * _depth;
                            }
                        } else if (format==1){
                            z= baseVertices[index].z + depthMultiplier * _depth;
                        }
                        
                        //var point = new float3(x, y, z);
                        //vertices.AddNoResize(point);

                        vertices[iL] = new float3(x, y, z);
                        iL += 1;
                        //keys.AddNoResize(index);
                    }

                }
                
            }
        }
        [BurstCompile]
        public struct GridIndicesJob : IJobParallelFor
        {
            public NativeArray<int> indices;
            public int width;

            public void Execute(int index)
            {
                var x = (index / 4) % (width - 1);
                var y = (index / 4) / (width - 1);

                var vertexIndex = x + y * width;
                var cornerIndex = index % 4;

                //So both panels dont connnect with each other.
                if (y != width-1)
                {
                    switch (cornerIndex)
                    {
                        case 0:
                            indices[index] = vertexIndex;
                            break;
                        case 1:
                            indices[index] = vertexIndex + 1;
                            break;
                        case 2:
                            indices[index] = vertexIndex + 1 + width;
                            break;
                        case 3:
                            indices[index] = vertexIndex + width;
                            break;
                        default:
                            indices[index] = vertexIndex;
                            break;
                    }
                }
            }
        }

        [BurstCompile]
        public struct GridUVJob : IJobParallelFor
        {
            public NativeArray<float2> uv;
            public int width;
            public bool preprocessed;

            public void Execute(int index)
            {
                var x = 0;
                var y = 0;

                if (preprocessed)
                {
                    x = (index) % width;
                    y = (index) / width;
                }
                else
                {
                    x = (uv.Length - index) % width;
                    y = (uv.Length - index) / width;
                }

                uv[index] = new float2(x, y) / new float2(uv.Length / (float)width, width);
            }
        }

    }
}