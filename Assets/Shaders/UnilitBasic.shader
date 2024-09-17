Shader "Unlit/ExampleShader" {
    Properties{
        _MainTex("Base (RGB)", 2D) = "black" {}
        _Exposition("Exposition", Range(0.18, 2)) = 1.
        _Contrast("Contrast", Range(0.38, 2)) = 1
        _Saturation("Saturation", Range(0, 2)) = 1
    }

        SubShader{
            Tags { "RenderType" = "Opaque" }
            
            LOD 100  

            Pass {
                CGPROGRAM
                    #pragma vertex vert
                    #pragma fragment frag
                    #pragma target 2.0
                    #pragma multi_compile_fog

                    #include "UnityCG.cginc"

                    struct appdata_t {
                        float4 vertex : POSITION;
                        float2 texcoord : TEXCOORD0;
                        UNITY_VERTEX_INPUT_INSTANCE_ID
                    };

                    struct v2f {
                        float4 vertex : SV_POSITION;
                        float2 texcoord : TEXCOORD0;
                        UNITY_FOG_COORDS(1)
                        UNITY_VERTEX_OUTPUT_STEREO
                    };

                    float _Exposition;
                    float _Contrast;
                    float _Saturation;

                    sampler2D _MainTex;
                    float4 _MainTex_ST;

                    v2f vert(appdata_t v)
                    {
                        v2f o;
                        UNITY_SETUP_INSTANCE_ID(v);
                        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                        o.vertex = UnityObjectToClipPos(v.vertex);
                        o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                        UNITY_TRANSFER_FOG(o,o.vertex);
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
                        outputColor.rgb = outputColor.rgb * _Exposition;
                        float3 intensity = dot(outputColor.rgb, float3(0.299, 0.587, 0.114));
                        outputColor.rgb = lerp(intensity, outputColor.rgb, _Saturation);
                        return outputColor;
                    }

                    fixed4 frag(v2f i) : SV_Target
                    {
                        fixed4 col = tex2D(_MainTex, i.texcoord);
                        UNITY_APPLY_FOG(i.fogCoord, col);
                        UNITY_OPAQUE_ALPHA(col.a);
                        float4 hsbColor = applyHSBEffect(col);

                        return hsbColor;
                    }
                ENDCG
            }
    }

}