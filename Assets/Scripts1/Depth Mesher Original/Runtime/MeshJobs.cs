using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
namespace UnchartedLimbo.Utilities.Meshing
{
    /// <summary>
    /// Contains Parallel Jobs that facilitate the fast generation of meshes.
    /// </summary>
    public static class MeshJobs
    {
        [BurstCompile]
        public struct GridVerticesJob : IJob
        {
            public NativeArray<float> depth;
            public NativeArray<float3> vertices;
            //public NativeList<float3>.ParallelWriter keys;
            public int gridResolution_X;
            public float2 xyMultiplier;
            public float depthMultiplier;
            public float4 Start; //[StartXL,StartYL, StartXR, StartYR]
            public NativeArray<float3> baseVertices;
            public int direction;
            public int sectionSize;

            public void Execute()
            {
                var iL = 0;
                var iR = vertices.Length / 2;

                for (var index = 0; index < depth.Length; index++)
                {
                    var z = baseVertices[index].z;
                    var x = baseVertices[index].x;
                    var y = baseVertices[index].y;

                    var ix = index % gridResolution_X;
                    var iy = index / gridResolution_X;

                    if (direction == 0)
                    {
                        var realDepth = depth[index] * depthMultiplier;

                        if (realDepth < 0.1f)
                        {
                            realDepth = 0.1f;
                        }

                        z = realDepth * baseVertices[index].z;
                        x = realDepth * baseVertices[index].x;
                        y = realDepth * baseVertices[index].y;
                    }
                    else if (direction == 1)
                    {
                        z = baseVertices[index].z + depth[index] * depthMultiplier;
                        x = baseVertices[index].x;
                        y = baseVertices[index].y;
                    }
                    else
                    {
                        //Right hand mesh section

                        //If index is in range. sectionSize*sectionSize Panel
                        if ((ix >= Start[2]) && (ix <= Start[2] + sectionSize - 1) && (iy >= Start[3]) && (iy <= Start[3] + sectionSize - 1))
                        {
                            var _depth = depth[index];

                            if (_depth > 50f)
                            {
                                _depth = 50f;
                            }
                            else if (_depth < 0.015f)
                            {
                                _depth = 0.015f;
                            }

                            z = depthMultiplier * baseVertices[index].z * 0.3f / _depth; //+ baseVertices[index].z * offset;
                            x = depthMultiplier * baseVertices[index].x * 0.3f / _depth; //+ baseVertices[index].x * offset;
                            y = depthMultiplier * baseVertices[index].y * 0.3f / _depth; //+ baseVertices[index].y * offset;

                            //var point = new float3(x, y, z);
                            //vertices.AddNoResize(point);

                            vertices[iR] = new float3(x, y, z);
                            iR += 1;
                            //keys.AddNoResize(index);
                        }

                        //Left hand mesh section

                        //If index is in range.
                        if ((ix >= Start[0]) && (ix <= Start[0] + sectionSize - 1) && (iy >= Start[1]) && (iy <= Start[1] + sectionSize - 1))
                        {
                            var _depth = depth[index];

                            if (_depth > 50f)
                            {
                                _depth = 50f;
                            }
                            else if (_depth < 0.015f)
                            {
                                _depth = 0.015f;
                            }

                            z = depthMultiplier * baseVertices[index].z * 0.3f / _depth; //+ baseVertices[index].z * offset;
                            x = depthMultiplier * baseVertices[index].x * 0.3f / _depth; //+ baseVertices[index].x * offset;
                            y = depthMultiplier * baseVertices[index].y * 0.3f / _depth; //+ baseVertices[index].y * offset;

                            //var point = new float3(x, y, z);
                            //vertices.AddNoResize(point);

                            vertices[iL] = new float3(x, y, z);
                            iL += 1;
                            //keys.AddNoResize(index);
                        }
                    }
                }
            }
        }

        [BurstCompile]
        public struct GridIndicesJob : IJobParallelFor
        {
            public NativeArray<int> indices;
            public int              width;

            public void Execute(int index)
            {
                var x = (index / 4) % (width - 1);
                var y = (index / 4) / (width - 1);

                var vertexIndex = x + y * width;
                var cornerIndex = index % 4;

                if (y != width - 1)
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
            public int                 width;

            public void Execute(int index)
            {
                var x = (uv.Length - index) % width;
                var y = (index) / width;
                uv[index] = new float2(x,y) / new float2(uv.Length / (float) width, width);
            }
        }
    }
}