// fastMedian
//
// Somewhat inspired by Oilify effect in oilArt shader
// https://www.shadertoy.com/view/lsKGDW
//
// Once in a while there is a need to perform median filtering in
// real-time at high frame rate on the GPU. Exact solution can be
// quite complicated and involves array sorting.
// However, if the exact solution is not needed, it is possible
// to estimate median using histogram only. Also, it turns out
// that you can get away with relatively low bin count if histogram
// is built knowing minimum and maximum values upfront via pre-pass.
//
// In real-world applications when shared/thread local storage
// is available such histogram calculation is trivial. In this
// shader due to WebGL limitations the inner loop is unrolled.
//
// Created by Dmitry Andreev - and'2019
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// This shader is converted by ShaderConverter : 
// https://u3d.as/2Zim 


Shader "Filters/MedianFiltering"
{
    Properties
    {
        _iMouse ("_iMouse", Vector) = (0,0,0,0)
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
            
            uniform float4 _MainTex_TexelSize;
            uniform sampler2D _MainTex;
            uniform float4 _iMouse;

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

            float3 readInput(inout float2 uv, int dx, int dy)
            {
                float2 img_res = _MainTex_TexelSize.zw;
                uv = (0.5f.xx + floor(uv * img_res)) / img_res;
                return tex2Dbias(_MainTex, float4(uv + (float2(float(dx), float(dy)) / img_res), 0.0, -10.0f)).xyz;
            }

            void frag_main()
            {
                float2 img_res = _MainTex_TexelSize.zw;
                float2 res = _ScreenParams.xy / img_res;
                float2 img_size = img_res * max(res.x, res.y);
                float2 img_org = (_ScreenParams.xy - img_size) * 0.5f;
                float2 uv = (gl_FragCoord.xy - img_org) / img_size;
                float2 param = uv;
                int param_1 = 0;
                int param_2 = 0;
                float3 _96 = readInput(param, param_1, param_2);
                float3 ocol = _96;
                float3 col = ocol;
                float4 bins[12];
                bins[0] = 0.0f.xxxx;
                bins[1] = 0.0f.xxxx;
                bins[2] = 0.0f.xxxx;
                bins[3] = 0.0f.xxxx;
                bins[4] = 0.0f.xxxx;
                bins[5] = 0.0f.xxxx;
                bins[6] = 0.0f.xxxx;
                bins[7] = 0.0f.xxxx;
                bins[8] = 0.0f.xxxx;
                bins[9] = 0.0f.xxxx;
                bins[10] = 0.0f.xxxx;
                bins[11] = 0.0f.xxxx;
                float vmin = 1.0f;
                float vmax = 0.0f;
                for (int y = -2; y <= 2; y++)
                {
                    for (int x = -2; x <= 2; x++)
                    {
                        float2 param_3 = uv;
                        int param_4 = x;
                        int param_5 = y;
                        float3 _157 = readInput(param_3, param_4, param_5);
                        float3 img = _157;
                        float v = ((img.x + img.y) + img.z) / 3.0f;
                        vmin = min(vmin, v);
                        vmax = max(vmax, v);
                    }
                }
                for (int y_1 = -2; y_1 <= 2; y_1++)
                {
                    for (int x_1 = -2; x_1 <= 2; x_1++)
                    {
                        float2 param_6 = uv;
                        int param_7 = x_1;
                        int param_8 = y_1;
                        float3 _203 = readInput(param_6, param_7, param_8);
                        float3 img_1 = _203;
                        float v_1 = ((img_1.x + img_1.y) + img_1.z) / 3.0f;
                        int i = int(0.5f + (((v_1 - vmin) / (vmax - vmin)) * 12.0f));
                        if (i == 0)
                        {
                            bins[0] += float4(img_1, 1.0f);
                        }
                        if (i == 1)
                        {
                            bins[1] += float4(img_1, 1.0f);
                        }
                        if (i == 2)
                        {
                            bins[2] += float4(img_1, 1.0f);
                        }
                        if (i == 3)
                        {
                            bins[3] += float4(img_1, 1.0f);
                        }
                        if (i == 4)
                        {
                            bins[4] += float4(img_1, 1.0f);
                        }
                        if (i == 5)
                        {
                            bins[5] += float4(img_1, 1.0f);
                        }
                        if (i == 6)
                        {
                            bins[6] += float4(img_1, 1.0f);
                        }
                        if (i == 7)
                        {
                            bins[7] += float4(img_1, 1.0f);
                        }
                        if (i == 8)
                        {
                            bins[8] += float4(img_1, 1.0f);
                        }
                        if (i == 9)
                        {
                            bins[9] += float4(img_1, 1.0f);
                        }
                        if (i == 10)
                        {
                            bins[10] += float4(img_1, 1.0f);
                        }
                        if (i == 11)
                        {
                            bins[11] += float4(img_1, 1.0f);
                        }
                    }
                }
                float mid = 12.0f;
                float pos = 0.0f;
                bool _390 = pos <= mid;
                bool _397 = false;
                if (_390)
                {
                    _397 = bins[0].w > 0.0f;
                }
                else
                {
                    _397 = _390;
                }
                float3 _398 = 0.0f.xxx;
                if (_397)
                {
                    _398 = bins[0].xyz / bins[0].www;
                }
                else
                {
                    _398 = col;
                }
                col = _398;
                pos += bins[0].w;
                bool _417 = pos <= mid;
                bool _423 = false;
                if (_417)
                {
                    _423 = bins[1].w > 0.0f;
                }
                else
                {
                    _423 = _417;
                }
                float3 _424 = 0.0f.xxx;
                if (_423)
                {
                    _424 = bins[1].xyz / bins[1].www;
                }
                else
                {
                    _424 = col;
                }
                col = _424;
                pos += bins[1].w;
                bool _443 = pos <= mid;
                bool _449 = false;
                if (_443)
                {
                    _449 = bins[2].w > 0.0f;
                }
                else
                {
                    _449 = _443;
                }
                float3 _450 = 0.0f.xxx;
                if (_449)
                {
                    _450 = bins[2].xyz / bins[2].www;
                }
                else
                {
                    _450 = col;
                }
                col = _450;
                pos += bins[2].w;
                bool _469 = pos <= mid;
                bool _475 = false;
                if (_469)
                {
                    _475 = bins[3].w > 0.0f;
                }
                else
                {
                    _475 = _469;
                }
                float3 _476 = 0.0f.xxx;
                if (_475)
                {
                    _476 = bins[3].xyz / bins[3].www;
                }
                else
                {
                    _476 = col;
                }
                col = _476;
                pos += bins[3].w;
                bool _495 = pos <= mid;
                bool _501 = false;
                if (_495)
                {
                    _501 = bins[4].w > 0.0f;
                }
                else
                {
                    _501 = _495;
                }
                float3 _502 = 0.0f.xxx;
                if (_501)
                {
                    _502 = bins[4].xyz / bins[4].www;
                }
                else
                {
                    _502 = col;
                }
                col = _502;
                pos += bins[4].w;
                bool _521 = pos <= mid;
                bool _527 = false;
                if (_521)
                {
                    _527 = bins[5].w > 0.0f;
                }
                else
                {
                    _527 = _521;
                }
                float3 _528 = 0.0f.xxx;
                if (_527)
                {
                    _528 = bins[5].xyz / bins[5].www;
                }
                else
                {
                    _528 = col;
                }
                col = _528;
                pos += bins[5].w;
                bool _547 = pos <= mid;
                bool _553 = false;
                if (_547)
                {
                    _553 = bins[6].w > 0.0f;
                }
                else
                {
                    _553 = _547;
                }
                float3 _554 = 0.0f.xxx;
                if (_553)
                {
                    _554 = bins[6].xyz / bins[6].www;
                }
                else
                {
                    _554 = col;
                }
                col = _554;
                pos += bins[6].w;
                bool _573 = pos <= mid;
                bool _579 = false;
                if (_573)
                {
                    _579 = bins[7].w > 0.0f;
                }
                else
                {
                    _579 = _573;
                }
                float3 _580 = 0.0f.xxx;
                if (_579)
                {
                    _580 = bins[7].xyz / bins[7].www;
                }
                else
                {
                    _580 = col;
                }
                col = _580;
                pos += bins[7].w;
                bool _599 = pos <= mid;
                bool _605 = false;
                if (_599)
                {
                    _605 = bins[8].w > 0.0f;
                }
                else
                {
                    _605 = _599;
                }
                float3 _606 = 0.0f.xxx;
                if (_605)
                {
                    _606 = bins[8].xyz / bins[8].www;
                }
                else
                {
                    _606 = col;
                }
                col = _606;
                pos += bins[8].w;
                bool _625 = pos <= mid;
                bool _631 = false;
                if (_625)
                {
                    _631 = bins[9].w > 0.0f;
                }
                else
                {
                    _631 = _625;
                }
                float3 _632 = 0.0f.xxx;
                if (_631)
                {
                    _632 = bins[9].xyz / bins[9].www;
                }
                else
                {
                    _632 = col;
                }
                col = _632;
                pos += bins[9].w;
                bool _651 = pos <= mid;
                bool _657 = false;
                if (_651)
                {
                    _657 = bins[10].w > 0.0f;
                }
                else
                {
                    _657 = _651;
                }
                float3 _658 = 0.0f.xxx;
                if (_657)
                {
                    _658 = bins[10].xyz / bins[10].www;
                }
                else
                {
                    _658 = col;
                }
                col = _658;
                pos += bins[10].w;
                bool _677 = pos <= mid;
                bool _683 = false;
                if (_677)
                {
                    _683 = bins[11].w > 0.0f;
                }
                else
                {
                    _683 = _677;
                }
                float3 _684 = 0.0f.xxx;
                if (_683)
                {
                    _684 = bins[11].xyz / bins[11].www;
                }
                else
                {
                    _684 = col;
                }
                col = _684;
                pos += bins[11].w;
                if (_iMouse.w > 0.0f)
                {
                    col = ocol;
                }
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