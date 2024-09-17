// ***********************************************************
// Alcatraz / Rhodium 4k Intro liquid carbon
// by Jochen "Virgill" Feldkötter
//
// 4kb executable: http://www.pouet.net/prod.php?which=68239
// Youtube: https://www.youtube.com/watch?v=YK7fbtQw3ZU
// ***********************************************************

// This shader is converted by ShaderConverter : 
// https://u3d.as/2Zim 


Shader "Custom/CustomShaderMultipass"
{
    Properties
    {
        _MainTex ("_MainTex / iChannel0", 2D) = "black" {}
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
            
            uniform sampler2D _MainTex;

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

            float3 dof(sampler2D tex, float2 uv, inout float rad)
            {
                float3 acc = 0.0f.xxx;
                float2 pixel = float2((0.00200000009499490261077880859375f * _ScreenParams.y) / _ScreenParams.x, 0.00200000009499490261077880859375f);
                float2 angle = float2(0.0f, rad);
                rad = 1.0f;
                for (int j = 0; j < 80; j++)
                {
                    rad += (1.0f / rad);
                    angle = mul(float2x2(float2(-0.736717879772186279296875f, 0.676200211048126220703125f), float2(-0.676200211048126220703125f, -0.736717879772186279296875f)), angle);
                    float4 col = tex2D(tex, uv + ((pixel * (rad - 1.0f)) * angle));
                    acc += col.xyz;
                }
                return acc / 80.0f.xxx;
            }

            void frag_main()
            {
                float2 uv = gl_FragCoord.xy / _ScreenParams.xy;
                float2 param = uv;
                float param_1 = tex2D(_MainTex, uv).w;
                float3 _114 = dof(_MainTex, param, param_1);
                fragColor = float4(_114, 1.0f);
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