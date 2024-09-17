
// This shader is converted by ShaderConverter : 
// https://u3d.as/2Zim 


Shader "Custom/CustomShader"
{
    Properties
    {
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

            #pragma target 3.5

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
            
            static float4 gl_FragCoord;
            static float4 fragColor;

            struct SPIRV_Cross_Input
            {
                float4 gl_FragCoord : VPOS;
            };

            struct SPIRV_Cross_Output
            {
                float4 fragColor : COLOR0;
            };

            void frag_main()
            {
                float2 uv = gl_FragCoord.xy / _ScreenParams.xy;
                float3 col = 0.5f.xxx + (cos((_Time.y.xxx + uv.xyx) + float3(0.0f, 2.0f, 4.0f)) * 0.5f);
                fragColor = float4(col, 1.0f);
            }

            SPIRV_Cross_Output frag(SPIRV_Cross_Input stage_input)
            {
                gl_FragCoord = stage_input.gl_FragCoord + float4(0.5f, 0.5f, 0.0f, 0.0f);
                frag_main();
                SPIRV_Cross_Output stage_output;
                stage_output.fragColor = float4(fragColor);
                return stage_output;
            }


            ENDCG
        }
    }
}