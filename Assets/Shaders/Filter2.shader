Shader "Unlit/Filter2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            #define kernelSize 8

            float neighbors[kernelSize*kernelSize];

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
            
            // Sort neighbors array
            void sortNeighbors()
            {
                for (int i = 0; i < kernelSize*kernelSize; i++)
                {
                    for (int j = i; j < kernelSize*kernelSize; j++)
                    {
                        if (neighbors[i] > neighbors[j])
                        {
                            float temp = neighbors[i];
                            neighbors[i] = neighbors[j];
                            neighbors[j] = temp;
                        }
                    }
                }
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                float2 uv = i.uv;

                //Texel size
                //uint width, height;
                //PostTex.GetDimensions(width, height);
                //float2 step = 1/float2(width, height);
                float2 step = 1/float2(512, 512);

                for (int i =0 ; i < kernelSize*kernelSize; i++)
                {
                    fixed4 color = tex2D(_MainTex, uv + step*float2(i/kernelSize, i%kernelSize));
                    neighbors[i] = (color.r + color.g + color.b);
                }

                sortNeighbors();

                col.rgb = fixed3(neighbors[kernelSize*kernelSize/2], neighbors[kernelSize*kernelSize/2], neighbors[kernelSize*kernelSize/2]);

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
