// ***********************************************************
// Alcatraz / Rhodium 4k Intro liquid carbon
// by Jochen "Virgill" Feldkötter
//
// 4kb executable: http://www.pouet.net/prod.php?which=68239
// Youtube: https://www.youtube.com/watch?v=YK7fbtQw3ZU
// ***********************************************************

// This shader is converted by ShaderConverter : 
// https://u3d.as/2Zim 


Shader "Custom/CustomShaderMultipass-BufferA"
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

            static float bounce = 0.0f;

            void pR(inout float2 p, float a)
            {
                p = (p * cos(a)) + (float2(p.y, -p.x) * sin(a));
            }

            float sdBox(float3 p, float3 b)
            {
                float3 d = abs(p) - b;
                return min(max(d.x, max(d.y, d.z)), 0.0f) + length(max(d, 0.0f.xxx));
            }

            float _noise(inout float3 p)
            {
                float3 ip = floor(p);
                p -= ip;
                float3 s = float3(7.0f, 157.0f, 113.0f);
                float4 h = float4(0.0f, s.yz, s.y + s.z) + dot(ip, s).xxxx;
                p = (p * p) * (3.0f.xxx - (p * 2.0f));
                h = lerp(frac(sin(h) * 43758.5f), frac(sin(h + s.x.xxxx) * 43758.5f), p.x.xxxx);
                float4 _147 = h;
                float4 _149 = h;
                float2 _154 = lerp(_147.xz, _149.yw, p.y.xx);
                h.x = _154.x;
                h.y = _154.y;
                return lerp(h.x, h.y, p.z);
            }

            float map(inout float3 p)
            {
                p.z -= 1.0f;
                p *= 0.89999997615814208984375f;
                float2 param = p.yz;
                float param_1 = (bounce * 1.0f) + (0.4000000059604644775390625f * p.x);
                pR(param, param_1);
                p.y = param.x;
                p.z = param.y;
                float3 param_2 = p + float3(0.0f, sin(1.60000002384185791015625f * _Time.y), 0.0f);
                float3 param_3 = float3(20.0f, 0.0500000007450580596923828125f, 1.2000000476837158203125f);
                float3 param_4 = (p * 8.0f) + (3.0f * bounce).xxx;
                float _219 = _noise(param_4);
                return sdBox(param_2, param_3) - (0.4000000059604644775390625f * _219);
            }

            float castRayx(float3 ro, float3 rd)
            {
                float3 param = ro;
                float _261 = map(param);
                float function_sign = (_261 < 0.0f) ? (-1.0f) : 1.0f;
                float precis = 9.9999997473787516355514526367188e-05f;
                float h = precis * 2.0f;
                float t = 0.0f;
                for (int i = 0; i < 120; i++)
                {
                    if ((abs(h) < precis) || (t > 12.0f))
                    {
                        break;
                    }
                    float3 param_1 = ro + (rd * t);
                    float _301 = map(param_1);
                    h = function_sign * _301;
                    t += h;
                }
                return t;
            }

            float3 calcNormal(float3 pos)
            {
                float eps = 9.9999997473787516355514526367188e-05f;
                float3 param = pos;
                float _229 = map(param);
                float d = _229;
                float3 param_1 = pos + float3(eps, 0.0f, 0.0f);
                float _235 = map(param_1);
                float3 param_2 = pos + float3(0.0f, eps, 0.0f);
                float _243 = map(param_2);
                float3 param_3 = pos + float3(0.0f, 0.0f, eps);
                float _251 = map(param_3);
                return normalize(float3(_235 - d, _243 - d, _251 - d));
            }

            float softshadow(float3 ro, float3 rd)
            {
                float sh = 1.0f;
                float t = 0.0199999995529651641845703125f;
                float h = 0.0f;
                for (int i = 0; i < 22; i++)
                {
                    if (t > 20.0f)
                    {
                        continue;
                    }
                    float3 param = ro + (rd * t);
                    float _393 = map(param);
                    h = _393;
                    sh = min(sh, (4.0f * h) / t);
                    t += h;
                }
                return sh;
            }

            float refr(float3 pos, float3 lig, float3 dir, float3 nor, float angle, inout float t2, inout float3 nor2)
            {
                float h = 0.0f;
                t2 = 2.0f;
                float3 dir2 = refract(dir, nor, angle);
                for (int i = 0; i < 50; i++)
                {
                    if (abs(h) > 3.0f)
                    {
                        break;
                    }
                    float3 param = pos + (dir2 * t2);
                    float _339 = map(param);
                    h = _339;
                    t2 -= h;
                }
                float3 param_1 = pos + (dir2 * t2);
                nor2 = calcNormal(param_1);
                return (0.5f * clamp(dot(-lig, nor2), 0.0f, 1.0f)) + pow(max(dot(reflect(dir2, nor2), lig), 0.0f), 8.0f);
            }

            void frag_main()
            {
                bounce = abs(frac(0.0500000007450580596923828125f * _Time.y) - 0.5f) * 20.0f;
                float2 uv = gl_FragCoord.xy / _ScreenParams.xy;
                float2 p = (uv * 2.0f) - 1.0f.xx;
                float _437 = 0.0f;
                if (frac(0.100000001490116119384765625f * (_Time.y - 1.0f)) >= 0.89999997615814208984375f)
                {
                    _437 = (frac(-_Time.y) * 0.100000001490116119384765625f) * sin(30.0f * _Time.y);
                }
                else
                {
                    _437 = 0.0f;
                }
                float wobble = _437;
                float3 dir = normalize(float3((gl_FragCoord.xy * 2.0f) - _ScreenParams.xy, _ScreenParams.y));
                float3 org = float3(0.0f, 2.0f * wobble, -3.0f);
                float3 color = 0.0f.xxx;
                float3 color2 = 0.0f.xxx;
                float3 param = org;
                float3 param_1 = dir;
                float t = castRayx(param, param_1);
                float3 pos = org + (dir * t);
                float3 param_2 = pos;
                float3 nor = calcNormal(param_2);
                float3 lig = float3(0.0331998802721500396728515625f, 0.995996415615081787109375f, 0.082999698817729949951171875f);
                float depth = clamp(1.0f - (0.0900000035762786865234375f * t), 0.0f, 1.0f);
                float3 pos2 = 0.0f.xxx;
                float3 nor2 = 0.0f.xxx;
                if (t < 12.0f)
                {
                    color2 = (max(dot(lig, nor), 0.0f) + pow(max(dot(reflect(dir, nor), lig), 0.0f), 16.0f)).xxx;
                    float3 param_3 = pos;
                    float3 param_4 = lig;
                    color2 *= clamp(softshadow(param_3, param_4), 0.0f, 1.0f);
                    float3 param_5 = pos;
                    float3 param_6 = lig;
                    float3 param_7 = dir;
                    float3 param_8 = nor;
                    float param_9 = 0.89999997615814208984375f;
                    float param_10 = 0.0f;
                    float3 param_11 = 0.0f.xxx;
                    float _539 = refr(param_5, param_6, param_7, param_8, param_9, param_10, param_11);
                    float t2 = param_10;
                    nor2 = param_11;
                    color2 += (_539 * depth).xxx;
                    color2 -= clamp(0.100000001490116119384765625f * t2, 0.0f, 1.0f).xxx;
                }
                float tmp = 0.0f;
                float T = 1.0f;
                float intensity = (0.100000001490116119384765625f * (-sin((0.20900000631809234619140625f * _Time.y) + 1.0f))) + 0.0500000007450580596923828125f;
                for (int i = 0; i < 128; i++)
                {
                    float density = 0.0f;
                    float3 param_12 = org + bounce.xxx;
                    float _580 = _noise(param_12);
                    float nebula = _580;
                    float3 param_13 = org + (nor2 * 0.5f);
                    float _587 = map(param_13);
                    density = intensity - (_587 * nebula);
                    if (density > 0.0f)
                    {
                        tmp = density / 128.0f;
                        T *= (1.0f - (tmp * 100.0f));
                        if (T <= 0.0f)
                        {
                            break;
                        }
                    }
                    org += (dir * 0.078000001609325408935546875f);
                }
                float3 basecol = float3(1.0f, 0.25f, 0.0625f);
                T = clamp(T, 0.0f, 1.5f);
                color += (basecol * exp((4.0f * (0.5f - T)) - 0.800000011920928955078125f));
                color2 *= depth;
                float3 param_14 = (dir * 6.0f) + (0.300000011920928955078125f * _Time.y).xxx;
                float _647 = _noise(param_14);
                color2 += (((1.0f - depth) * _647) * 0.100000001490116119384765625f).xxx;
                fragColor = float4(float3((color * 1.0f) + (color2 * 0.800000011920928955078125f)) * 1.2999999523162841796875f, (abs(0.670000016689300537109375f - depth) * 2.0f) + (4.0f * wobble));
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