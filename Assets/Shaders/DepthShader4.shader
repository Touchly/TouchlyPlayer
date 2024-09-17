Shader "Uncharted Limbo/Unlit/MiDaS Depth Visualization Transparent 2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
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

            float _Limit;
            // Depth Exaggeration
            float _DepthMultiplier;

            // Log-Normalization factor
            float _LogNorm;

            // Should vertex displacement be applied?
            int _Displace;

            // Should vertex displacement be applied?
            int _ColorIsDepth;

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
            };

         
            v2f vert (appdata v)
            {
                v2f o;
                
                // Newer versions of Barracuda mess up the X and Y directions. Therefore the UV has to be swapped
                o.uv = lerp(v.uv, float2(1-v.uv.y, v.uv.x), 0);
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //o.uv = lerp(v.uv, float2(v.uv.x, v.uv.y), 0);

                if (_Displace == 1)
                {
                    // Vertex displacement
                    float depth = tex2Dlod(_DepthTex,float4(o.uv.xy,0,0));

                    //float s = clamp(depth, 0.1, 50.0);
                    float s = clamp(depth, 0.001, 50); //*_DepthMultiplier;

                    float _X = (_DepthMultiplier*v.vertex.x*0.3 / depth)+ v.vertex.x*_Offset;
                    float _Y = (_DepthMultiplier*v.vertex.y*0.3 / depth)+ v.vertex.y*_Offset;
                    float _Z = (_DepthMultiplier*v.vertex.z*0.3 / depth)+ v.vertex.z*_Offset;

                    o.vertex = UnityObjectToClipPos(float4(_X,_Y,_Z,1));
                }
                else
                {
                    // Normal vertex conversion
                    o.vertex = UnityObjectToClipPos(v.vertex);
                }
          
             
                return o;
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
                col = tex2D(_MainTex, uv);
                rgb = tex2D(_DepthTex, uv).rgb;

                //derivative= fwidth(tex2D(_DepthTex, uv))>0.023 ? 1 : 0 ;
                
                alpha= ((rgb.r + rgb.g + rgb.b) / 3); //- derivative;

                float smoothing=0.011;

                float center=(30.0-_Center)/100.0;
                float width = _Width/100.0;

                float lowLimit= smoothstep(center-width, center-width+smoothing, alpha);
                //float lowLimit= (alpha>= _Center)? 1:0;
                //float lowLimit=1;
                float highLimit = 1-smoothstep(center+width, center+width+smoothing, alpha);
                //float highLimit=(alpha<= _Center+_Width)? 1:0;

                //float limits=lowLimit*highLimit;

                alpha2= lerp(0.0, 1.0, lowLimit*highLimit*alpha);
                
                //Max Min 0 1 > newMax NewMin 0.3 0.36
                //Center= Width=Max-Min
                
                //float alpha2 = saturate((stepLimit*alpha - _Center)/ (_Width));
                //alpha2 = saturate(highLimit*lowLimit*alpha);
                
                //float alpha2= step(_Center/2, alpha);
                //float alpha2 = saturate(0.06*(alpha)+0.3);
                col.a= alpha2*_Opacity;

                return col;
            }
            ENDCG
        }
    }
}