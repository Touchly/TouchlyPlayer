
// This shader is converted by ShaderConverter : 
// https://u3d.as/2Zim 


Shader "Custom/Median2"
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

            static float neighborhoods[9];

            void sortNeighborhoods()
            {
                for (int i = 1; i < 9; i++)
                {
                    for (int j = 0; j < 8; j++)
                    {
                        if (neighborhoods[j + 1] > neighborhoods[j])
                        {
                            float temp = neighborhoods[j];
                            neighborhoods[j] = neighborhoods[j + 1];
                            neighborhoods[j + 1] = temp;
                        }
                    }
                }
            }

            void frag_main()
            {
                float2 uv = gl_FragCoord.xy / _ScreenParams.xy;
                float2 step1 = 1.0f.xx / _ScreenParams.xy;
                for (int i = 0; i < 9; i++)
                {
                    float4 color = tex2D(_MainTex, uv + (float2(float(i / 3), float(i - (3 * (i / 3)))) * step1));
                    neighborhoods[i] = ((color.x + color.y) + color.z) / 3.0f;
                }
                sortNeighborhoods();
                float3 _141 = neighborhoods[4].xxx;
                fragColor.x = _141.x;
                fragColor.y = _141.y;
                fragColor.z = _141.z;
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