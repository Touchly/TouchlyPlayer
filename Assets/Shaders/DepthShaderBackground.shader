Shader "Uncharted Limbo/Unlit/MiDaS Depth Visualization Background"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _DepthTex ("Depth Texture", 2D) = "black" {}
        _Exposition("Exposition", Range(0.18, 2)) = 1.
        _Contrast("Contrast", Range(0.38, 2)) = 1
        _Saturation("Saturation", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Cull Off    
       
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            // ----------------------------------------------------------------
            // PROPERTIES
            // ----------------------------------------------------------------

            // Depth Exaggeration
            float _DepthMultiplier;


            // Should vertex displacement be applied?
            int _Displace;
            int _SwapChannels;
            int _DepthIsColor;
            
            // Depth Texture
            sampler2D _MainTex;
            sampler2D _DepthTex;
            
            float _Exposition;
            float _Contrast;
            float _Saturation;

            float4 _MainTex_ST;
            
            // ----------------------------------------------------------------
            // VANILLA STRUCTS - NOTHING TO SEE HERE
            // ----------------------------------------------------------------
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

         
            v2f vert (appdata v)
            {
                v2f o;
                
                // Newer versions of Barracuda mess up the X and Y directions. Therefore the UV has to be swapped
                o.uv = lerp(v.uv, float2(1-v.uv.y, v.uv.x), 0);
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //o.uv = lerp(v.uv, float2(v.uv.x, v.uv.y), 0);

                if (_Displace == 1)
                {
                    // Vertex displacement W
                    float depth = tex2Dlod(_DepthTex,float4(o.uv.xy,0,0));
                    //float3 depthrgb = tex2Dlod(_DepthTex,float4(o.uv.xy,0,0)).rgb;
                    //float depth = (depthrgb.r + depthrgb.g + depthrgb.b)/3;

                    
                    //float s = clamp(depth, 0.1, 50.0);
                    float _X;
                    float _Y;
                    float _Z;

                    _X = (_DepthMultiplier*v.vertex.x*0.31 / depth);
                    _Y = (_DepthMultiplier*v.vertex.y*0.31 / depth);
                    _Z = (_DepthMultiplier*v.vertex.z*0.31 / depth);

                
                    o.vertex = UnityObjectToClipPos(float4(_X,_Y,_Z,1));

                }
                else
                {
                    // Normal vertex conversion
                    o.vertex = UnityObjectToClipPos(v.vertex);
                }
          
             
                return o;
            }

            half3 AdjustContrast(half3 color, half contrast) {
            #if !UNITY_COLORSPACE_GAMMA
                color = LinearToGammaSpace(color);
            #endif
                color = saturate(lerp(half3(0.5, 0.5, 0.5), color, contrast));
            #if !UNITY_COLORSPACE_GAMMA
                color = GammaToLinearSpace(color);
            #endif
                return color;
            }

            inline float4 applyHSBEffect(float4 startColor)
            {
                float4 outputColor = startColor;
                outputColor.rgb = AdjustContrast(outputColor, _Contrast);
                outputColor.rgb = outputColor.rgb*_Exposition;
                float3 intensity = dot(outputColor.rgb, float3(0.299, 0.587, 0.114));
                outputColor.rgb = lerp(intensity, outputColor.rgb, _Saturation);
                return outputColor;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // The color texture is sampled normally, so we have to flip the coordinates back
                float2 uv = lerp(i.uv, float2(i.uv.x, 1- i.uv.y), _SwapChannels);

                float4 col;
                
                if (_DepthIsColor==1){ //1
                    //col = tex2D(_DepthTex, uv);
                    float sam = tex2Dlod(_DepthTex,float4(i.uv.xy,0,0));
                    col = float4(sam,sam,sam,1);
                } else  {
                    col = tex2D(_MainTex, uv);
                }

                float4 hsbColor = applyHSBEffect(col);
                
                return hsbColor;
            }
            ENDCG
        }
    }
}