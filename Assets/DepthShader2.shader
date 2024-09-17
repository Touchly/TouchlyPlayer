Shader "Touchly/DepthMain"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _Exposition("Exposition", Range(0.18, 2)) = 1.
        _Contrast("Contrast", Range(0.38, 2)) = 1
        _Saturation("Saturation", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}
        LOD 100
        
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

                if (_Direction==2 || _Direction==0 || _Direction==3){

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

                    _X = v.vertex.x;
                    _Y = v.vertex.y;
                    _Z = v.vertex.z - depth* _DepthMultiplier;


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
                outputColor.rgb = outputColor.rgb*_Exposition;
                float3 intensity = dot(outputColor.rgb, float3(0.299, 0.587, 0.114));
                outputColor.rgb = lerp(intensity, outputColor.rgb, _Saturation);
                return outputColor;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // The color texture is sampled normally, so we have to flip the coordinates back
                float2 uv = lerp(i.uv, float2(i.uv.x, 1- i.uv.y), _SwapChannels);

                float4 col;
                
                if (_Direction==2 || _Direction==0 || _Direction==3){
                    
                    float sam = tex2Dlod(_DepthTex,float4(i.uv.xy,0,0));
                    float a = 1.0 - clamp(_EdgeSens*(i.vMaxD - sam), 0.0, 1.0);
                    a = (tanh(a * 16.0 - 13.0) + 1.0) * 0.5;

                    fixed3 rgb = tex2D(_MainTex, uv).rgb;

                    // Make it so we can't discard texels with zero gradient. This helps avoid
                    // making holes in the vignette.
                    float3 coefs = float3(0.299, 0.587, 0.114);
                    float gray = dot(rgb, coefs);
                    float delta = 4.0/4096.0;
                    float dx = dot(tex2D(_MainTex, uv + float2(delta, 0.0)).rgb, coefs) - gray;
                    float dy = dot(tex2D(_MainTex, uv + float2(0.0, delta)).rgb, coefs) - gray;
                    float grad = dx * dx + dy * dy;

                    if (grad == 0.0) a = 1.0;

                    col = fixed4(rgb, a);

                } else {
                    col = tex2D(_MainTex, uv);
                }

                if (_DepthIsColor==1){
                    float sam = tex2Dlod(_DepthTex,float4(i.uv.xy,0,0));
                    col = float4(sam,sam,sam,1);
                }
                

                float4 hsbColor = applyHSBEffect(col);
                
                return hsbColor;
            }
            ENDCG
        }
    }
}