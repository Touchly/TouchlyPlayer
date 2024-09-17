Shader "Touchly/DepthTransparent"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _Exposition("Exposition", Range(0.18, 2)) = 1.
        _Contrast("Contrast", Range(0.38, 2)) = 1
        _Saturation("Saturation", Range(0, 2)) = 1
        _ChromaKeyColor("Chroma Key Color", Color) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha
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
            // Minimum recorded depth
            float _Width;

            // Maximum recorded depth
            float _Center;
            float _Opacity;
            float _Offset;
            float _Smoothing;
            float _Limit;
            float _Exposition;
            float _Contrast;
            float _Saturation;
            float _RadialLimit;
            float _EdgeSens;

            fixed4 _ChromaKeyColor;
            

            // Depth Exaggeration
            float _DepthMultiplier;

            // Log-Normalization factor
            float _LogNorm;

            // Should vertex displacement be applied?
            int _Displace;
            int _Direction;
            int _Preprocessed;

            int _MattingType;

            // Should vertex displacement be applied?
            int _DepthIsColor;

            int _SwapChannels;
            
            // Depth Texture
            sampler2D _MainTex;
            sampler2D _DepthTex;
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
                float vMaxD : TEXCOORD1;
            };

         
            v2f vert (appdata v)
            {
                v2f o;
                
                // Newer versions of Barracuda mess up the X and Y directions. Therefore the UV has to be swapped
                o.uv = lerp(v.uv, float2(1-v.uv.y, v.uv.x), 0);
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //o.uv = lerp(v.uv, float2(v.uv.x, v.uv.y), 0);

                if (_Direction==2 || _Direction==3){

                    float2 depth_uv = float2(o.uv.x , o.uv.y);

                    const float eps = 2.0 / (32.0 * 18.0);
                    const float eps2 = eps * 2.0;

                    float ds1 = tex2Dlod(_DepthTex, float4(depth_uv + float2(-eps, 0.0), 0.0, 0.0)).r;
                    float ds2 = tex2Dlod(_DepthTex, float4(depth_uv + float2(eps, 0.0), 0.0, 0.0)).r;
                    float ds3 = tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, eps), 0.0, 0.0)).r;
                    float ds4 = tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, -eps), 0.0, 0.0)).r;

                    float ds5 = tex2Dlod(_DepthTex, float4(depth_uv + float2(-eps2, 0.0), 0.0, 0.0)).r;
                    float ds6 = tex2Dlod(_DepthTex, float4(depth_uv + float2(eps2, 0.0), 0.0, 0.0)).r;
                    float ds7 = tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, eps2), 0.0, 0.0)).r;
                    float ds8 = tex2Dlod(_DepthTex, float4(depth_uv + float2(0.0, -eps2), 0.0, 0.0)).r;

                    float max_d =  ds1;
                    max_d = max(max_d, ds2);
                    max_d = max(max_d, ds3);
                    max_d = max(max_d, ds4);

                    float max_d2 =  ds5;
                    max_d2 = max(max_d2, ds6);
                    max_d2 = max(max_d2, ds7);
                    max_d2 = max(max_d2, ds8);

                    float s = clamp(_DepthMultiplier*0.3 / max_d, 0.01, 50.0);

                    o.vertex = UnityObjectToClipPos(v.vertex * s);
                    o.uv = v.uv;
                    o.vMaxD = max_d2;
                }

                else {

                if (_Displace == 1)
                {
                    // Vertex displacement W
                    float depth = tex2Dlod(_DepthTex,float4(o.uv.xy,0,0));
                    
                    //float s = clamp(depth, 0.1, 50.0);
                    float _X;
                    float _Y;
                    float _Z;

                    if (_Direction == 0 || _Direction == 2){
                        depth = clamp(depth, 0.007, 30.0);
                        if (_Preprocessed==1){
                        
                        _X = (_DepthMultiplier*v.vertex.x*0.3 / depth);
                        _Y = (_DepthMultiplier*v.vertex.y*0.3 / depth);
                        _Z = (_DepthMultiplier*v.vertex.z*0.3 / depth);
                        } else {
                            _X = (_DepthMultiplier*v.vertex.x*4*depth);
                            _Y = (_DepthMultiplier*v.vertex.y*4*depth);
                            _Z = (_DepthMultiplier*v.vertex.z*4*depth);
                        }
                    } else {
                        _X = v.vertex.x;
                        _Y = v.vertex.y;
                        _Z = v.vertex.z - depth* _DepthMultiplier;
                    }

                    o.vertex = UnityObjectToClipPos(float4(_X,_Y,_Z,1));

                }
                else
                {
                    // Normal vertex conversion
                    o.vertex = UnityObjectToClipPos(v.vertex);
                }
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
                outputColor.rgb = outputColor.rgb * _Exposition;
                float3 intensity = dot(outputColor.rgb, float3(0.299, 0.587, 0.114));
                outputColor.rgb = lerp(intensity, outputColor.rgb, _Saturation);
                return outputColor;
            }
            inline float3 RGBToHSV(float3 c)
            {
                float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
                float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
                float d = q.x - min(q.w, q.y);
                float e = 1.0e-10;
                return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
            }


            fixed4 frag (v2f i) : SV_Target
            {
                float4 col;
                float3 rgb;
                float alpha;
                float alpha2;
                //float derivative;
                
                // The color texture is sampled normally, so we have to flip the coordinates back
                float2 uv = lerp(i.uv, float2(i.uv.x, 1-i.uv.y), _SwapChannels);
                float2 uv2 = lerp(i.uv, float2(i.uv.x, i.uv.y), _SwapChannels);
                col = tex2D(_MainTex, uv);
                
                float center=(1-_Center);
                

                if (_MattingType==1){
                    float width = _Width;

                    if (_Direction==1){
                        width = width *2; 
                    }
                    
                    rgb = tex2D(_DepthTex, uv2).rgb;
                    alpha= ((rgb.r + rgb.g + rgb.b) / 3);
                    //float smoothing=0.01;
                    
                    float lowLimit= smoothstep(center-width, center-width + _Smoothing, alpha);
                    float highLimit = 1-smoothstep(center+width, center+width+ _Smoothing, alpha);
                    float distanceLimit= 1-smoothstep(_Limit-0.05, _Limit+0.05, alpha);   
                    alpha2= lerp(0.0, 1.0, lowLimit*highLimit*distanceLimit*alpha);
                } else {
                    rgb = col.rgb;
                    float width = (0.35 - _Width)*8;
                    float limit = smoothstep( width , width+_Smoothing*10, distance(RGBToHSV(_ChromaKeyColor.rgb), RGBToHSV(rgb)));
                    alpha2= limit*rgb;
                }
                float radialLimit = 1-smoothstep(_RadialLimit-0.06, _RadialLimit+0.06, distance(uv2, float2(0.5,0.5)));
                
                //col.a= alpha2*_Opacity*radialLimit;
                alpha2 = alpha2*_Opacity*radialLimit;
                
                if (_Direction==2 || _Direction==3){
                    
                    float sam = tex2Dlod(_DepthTex,float4(i.uv.xy,0,0));
                    float a = 1.0 - clamp(_EdgeSens*(i.vMaxD - sam), 0.0, 1.0);
                    a = (tanh(a * 16.0 - 13.0) + 1.0) * 0.5;
                    
                    fixed3 rgb = col.rgb;

                    // Make it so we can't discard texels with zero gradient. This helps avoid
                    // making holes in the vignette.
                    float3 coefs = float3(0.299, 0.587, 0.114);
                    float gray = dot(rgb, coefs);
                    float delta = 4.0/4096.0;
                    float dx = dot(tex2D(_MainTex, uv + float2(delta, 0.0)).rgb, coefs) - gray;
                    float dy = dot(tex2D(_MainTex, uv + float2(0.0, delta)).rgb, coefs) - gray;
                    float grad = dx * dx + dy * dy;

                    if (grad == 0.0) a = 1.0;

                    col = fixed4(rgb, a*alpha2);
                } else {
                    col.a = alpha2;
                }


                float4 hsbColor = applyHSBEffect(col);

                float4 color;

                if (_DepthIsColor==1){
                    //col = tex2D(_DepthTex, uv);
                    float sam = tex2Dlod(_DepthTex,float4(i.uv.xy,0,0));
                    color = float4(sam,sam,sam,1);
                } else {
                    color = hsbColor;
                }

                return color;
            }
            ENDCG
        }
    }
}