Shader "Uncharted Limbo/Unlit/MiDaS Depth Visualization"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Color ("Color (RGBA)", Color) = (1, 1, 1, 1) // add _Color property
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
            #pragma vertex vert alpha
            #pragma fragment frag alpha

            #include "UnityCG.cginc"

            // ----------------------------------------------------------------
            // PROPERTIES
            // ----------------------------------------------------------------
            // Minimum recorded depth
            float _Min;

            // Maximum recorded depth
            float _Max;

            // Depth Exaggeration
            float _DepthMultiplier;

            // Log-Normalization factor
            float _LogNorm;

            // Should vertex displacement be applied?
            int _Displace;

            // Should vertex displacement be applied?
            int _ColorIsDepth;

            int _SwapChannels;

            int _preprocessed;
            
            // Depth Texture
            sampler2D _MainTex;
            sampler2D _DepthTex;
            
            
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

                    o.vertex = UnityObjectToClipPos(float4(_DepthMultiplier*v.vertex.x*0.3 / depth, _DepthMultiplier*v.vertex.y*0.3 / depth,_DepthMultiplier*v.vertex.z*0.3 / depth,1));
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
                
                if (_ColorIsDepth == 1)
                {
                 // sample the texture
                //loat depth = tex2D(_MainTex, i.uv).x*1000;
                float depth = _preprocessed==true ? tex2D(_MainTex, i.uv).x*1000 : tex2D(_MainTex, i.uv).x;

                
                float normalizedDepth = saturate((depth - _Min)/ (_Max-_Min)) ;

                float a = normalizedDepth;
                float b = log( _LogNorm * (normalizedDepth + 1))  / log(_LogNorm + 1);
                
                // Log normalization
                 col = _LogNorm >= 1.0 ? b : a;
                }
                else
                {
                    // The color texture is sampled normally, so we have to flip the coordinates back
                    float2 uv = lerp(i.uv, float2(1- i.uv.y, 1-i.uv.x), _SwapChannels);
                    
                    col = tex2D(_MainTex, uv);
                }

                return col;
            }
            ENDCG
        }
    }
}
