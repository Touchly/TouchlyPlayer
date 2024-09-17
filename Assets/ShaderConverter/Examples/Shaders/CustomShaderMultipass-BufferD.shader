Shader "Custom/CustomShaderMultipass-BufferD"
{
    Properties
    {
        _MainTex ("_MainTex / iChannel0", 2D) = "black" {}
        _SecondTex ("_SecondTex / iChannel1", 2D) = "black" {}
        //To Add Properties
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderQueue" = "Geometry"}

        Pass
        {
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #pragma target 4.0

            #include "UnityCG.cginc"

            //////////////////////////////////////////////////////////////////////////

            //Vertex Shader Begin
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            //Vertex Shader End

            //////////////////////////////////////////////////////////////////////////
            
            Texture2D<float4> _MainTex : register(t1);
            SamplerState sampler_MainTex : register(s1);
            Texture2D<float4> _SecondTex : register(t2);
            SamplerState sampler_SecondTex : register(s2);

            static float4 gl_FragCoord;
            static float4 fragColor;

            struct SPIRV_Cross_Input
            {
                float4 gl_FragCoord : SV_Position;
            };

            struct SPIRV_Cross_Output
            {
                float4 fragColor : SV_Target0;
            };

            void frag_main()
            {
                float2 r = _ScreenParams.xy;
                float pl = _MainTex.Sample(sampler_MainTex, (gl_FragCoord.xy - float2(-1.0f, 0.0f)) / r).x;
                float pr = _MainTex.Sample(sampler_MainTex, (gl_FragCoord.xy - float2(1.0f, 0.0f)) / r).x;
                float pt = _MainTex.Sample(sampler_MainTex, (gl_FragCoord.xy - float2(0.0f, -1.0f)) / r).x;
                float pb = _MainTex.Sample(sampler_MainTex, (gl_FragCoord.xy - float2(0.0f, 1.0f)) / r).x;
                float2 grad = float2(pr - pl, pb - pt) / 2.0f.xx;
                float4 bufOld = _SecondTex.Sample(sampler_SecondTex, gl_FragCoord.xy / r);
                fragColor = float4(bufOld.xy - grad, bufOld.z, 1.0f);
            }

            SPIRV_Cross_Output frag(SPIRV_Cross_Input stage_input)
            {
                gl_FragCoord = stage_input.gl_FragCoord;
                gl_FragCoord.w = 1.0 / gl_FragCoord.w;
                frag_main();
                SPIRV_Cross_Output stage_output;
                stage_output.fragColor = fragColor;
                return stage_output;
            }


            ENDCG
        }
    }
}