Shader "Record3d"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _DepthTex ("Texture", 2D) = "black" {}
        _Exposition("Exposition", Range(0.18, 2)) = 1.
        _Contrast("Contrast", Range(0.38, 2)) = 1
        _Saturation("Saturation", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha
        Cull Off
        
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile __ _STENCIL_ON

            #include "UnityCG.cginc"

            // Depth Exaggeration
            float _DepthMultiplier;


            // Should vertex displacement be applied?
            int _Displace;
            int _Preprocessed;
            int _SwapChannels;
            int _DepthIsColor;
            int _Direction;
            
            // Depth Texture 
            sampler2D _MainTex;
            sampler2D _DepthTex;
            
            float _Exposition;
            float _Contrast;
            float _Saturation;
            float _EdgeSens;

            float4 _MainTex_ST;
            float4 iK;
            
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
                float vMaxD : TEXCOORD1;
            };

            float rgb2hue(half3 c)
            {
                half4 K = half4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                half4 p = lerp(half4(c.bg, K.wz), half4(c.gb, K.xy), step(c.b, c.g));
                half4 q = lerp(half4(p.xyw, c.r), half4(c.r, p.yzx), step(p.x, c.r));
            
                float d = q.x - min(q.w, q.y);
                float e = 1.0e-10;
                float value = abs(q.z + (q.w - q.y) / (6.0 * d + e));
                if (value<0.02){
                    value= 1.0;
                }
                return value;
            }

         
            v2f vert (appdata v)
            {
                v2f o;
                
                o.uv = lerp(v.uv, float2(1-v.uv.y, v.uv.x), 0);

                float2 depth_uv = float2(o.uv.x , o.uv.y);

                const float eps = 2.0 / (32.0 * 18.0);

                //iK = float4(1000 / 1514.2147, 1000 / 1514.214, 0, 0);
                iK = float4(1, 1, 0, 0);
                //fixed2 texelSize = _MainTex_TexelSize
                const float eps2 = eps * 2.0;
                
                float ds1 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(-eps, 0.0), 0.0, 0.0)));
                float ds2 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(eps, 0.0), 0.0, 0.0)));
                float ds3 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, eps), 0.0, 0.0)));
                float ds4 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, -eps), 0.0, 0.0)));

                float ds5 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(-eps2, 0.0), 0.0, 0.0)));
                float ds6 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(eps2, 0.0), 0.0, 0.0)));
                float ds7 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, eps2), 0.0, 0.0)));
                float ds8 = rgb2hue(tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, -eps2), 0.0, 0.0)));
                
                float max_d =  ds1;
                max_d = max(max_d, ds2);
                max_d = max(max_d, ds3);
                max_d = max(max_d, ds4);

                float max_d2 =  ds5;
                max_d2 = max(max_d2, ds6);
                max_d2 = max(max_d2, ds7);
                max_d2 = max(max_d2, ds8);

                float s = 3 * max_d;
                float scale = 1;
                
                float3 pos = v.vertex + scale  * float3( s * (iK.x* v.vertex.x + iK.z), s * (iK.y* v.vertex.y + iK.w) , - s);
                //float3 pos = float3(v.vertex * s)
                //float3 pos = v.vertex;
                o.vertex = UnityObjectToClipPos(pos);
                //o.vertex = v.vertex;

                o.uv = v.uv;
                o.vMaxD = max_d2;

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
                float2 uv = lerp(i.uv, float2(i.uv.x, 1- i.uv.y), _SwapChannels);
                float4 col;
                float3 rgb;
                
                col = tex2D(_MainTex, uv);
                rgb = col.rgb;
                float sam = rgb2hue(tex2Dlod(_DepthTex,float4(i.uv.xy,0,0)));
                
                float a = 1.0 - clamp(5.0 * (i.vMaxD - sam), 0.0, 1.0);
                a = (tanh(a * 16.0 - 13.0) + 1.0) * 0.5;
                
                if (i.vMaxD > 0.99){
                    a = 0.0;
                }

                col = fixed4(rgb, a); 

                float4 hsbColor = applyHSBEffect(col);

                return hsbColor;
            }
            ENDCG
        }
    }
}