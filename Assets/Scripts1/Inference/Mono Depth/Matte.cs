namespace NatML.Vision {

    using System;
    using UnityEngine;
    using Unity.Collections.LowLevel.Unsafe;

    public sealed partial class MonoNetPredictor {

        /// <summary>
        /// Hair segmentation map.
        /// </summary>
        public readonly struct Matte {

            #region --Client API--
            /// <summary>
            /// Map width.
            /// </summary>
            public readonly int width;

            /// <summary>
            /// Map height.
            /// </summary>
            public readonly int height;

            /// <summary>
            /// Render the probability map to a texture.
            /// Each pixel will have value `(p, p, p, 1.0)` where `p` is the hair matte alpha.
            /// </summary>
            /// <param name="destination">Destination texture.</param>
            public void Render (RenderTexture destination) {
                // Check texture

                // Get approximate max and min
                int sampleRate = 1000;
                float max = Mathf.NegativeInfinity;
                float min = Mathf.Infinity;

                for (int i = 0; i < data.Length; i += sampleRate)
                {
                    max = Mathf.Max(max, data[i]);
                    min = Mathf.Min(min, data[i]);
                }


                if (!destination)
                    throw new ArgumentNullException(nameof(destination));
                // Create buffer
                using var mapBuffer = new ComputeBuffer(width * height, 2 * sizeof(float));
                // Upload
                mapBuffer.SetData(data);
                // Create temporary
                var descriptor = new RenderTextureDescriptor(width, height, RenderTextureFormat.ARGB32, 0);
                descriptor.enableRandomWrite = true;
                var tempBuffer = RenderTexture.GetTemporary(descriptor);
                tempBuffer.Create();
                // Render
                renderer = renderer ?? (ComputeShader)Resources.Load(@"ComputeShaders/MonoRenderer");
                renderer.SetBuffer(0, @"Map", mapBuffer);
                
                renderer.SetFloat(@"MaxValue", max);
                renderer.SetFloat(@"MinValue", min);

                renderer.SetTexture(0, @"Result", tempBuffer);
                renderer.GetKernelThreadGroupSizes(0, out var gx, out var gy, out var _);
                renderer.Dispatch(0, Mathf.CeilToInt((float)width / gx), Mathf.CeilToInt((float)height / gy), 1);
                // Blit to destination
                Graphics.Blit(tempBuffer, destination);
                RenderTexture.ReleaseTemporary(tempBuffer);
            }
            #endregion


            #region --Operations--
            private readonly float[] data;
            private static ComputeShader renderer;

            internal Matte (int width, int height, float[] data) {
                this.width = width;
                this.height = height;
                this.data = data;
            }
            #endregion
        }
    }
}