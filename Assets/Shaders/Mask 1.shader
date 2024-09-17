Shader "Custom/TextureStencil" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Exposition("Exposition", Range(0.18, 2)) = 1.
        _Contrast("Contrast", Range(0.38, 2)) = 1
        _Saturation("Saturation", Range(0, 2)) = 1
        _GradientCenter("Gradient Center", Vector) = (0.5, 0.5, 0, 0)
        _GradientRadius("Gradient Radius", Range(0, 1)) = 0.5
    }
    SubShader {
        Tags { "RenderType"="Opaque"}
        //LOD 100
 
        CGPROGRAM
        #pragma surface surf Lambert
         
        sampler2D _MainTex;
 
        struct Input {
            float2 uv_MainTex;
        };

        float _Exposition;
        float _Contrast;
        float _Saturation;
        float3 _GradientCenter;
        float _GradientRadius;

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
        
        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);
            c = applyHSBEffect(c);
            o.Albedo = c.rgb;
            o.Alpha = c.a;

            // Calculate distance from current pixel to gradient center
            float2 center = _GradientCenter.xy;
            float2 pos = IN.uv_MainTex;
            float dist = distance(pos, center);

            // Calculate gradient value based on distance and radius
            float gradient = 1.0 - smoothstep(0.0, _GradientRadius, dist);

            // Apply gradient to alpha channel
            o.Albedo *= gradient;
        }
        ENDCG
    }
    FallBack "Diffuse"
}