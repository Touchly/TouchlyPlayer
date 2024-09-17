Shader "Uncharted Limbo/Unlit/STATIC"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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

            // Depth Exaggeration
            float _DepthMultiplier;

            
            // Depth Texture
            sampler2D _MainTex;
            
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
                //o.uv = lerp(v.uv, float2(1-v.uv.y, v.uv.x), 0);

                // Vertex displacement
                //float depth = tex2Dlod(_MainTex, float4(o.uv.xy,0,0)).r;
                float depth = 0.1;
                
                float _X;
                float _Y;
                float _Z;

                _X = (_DepthMultiplier*v.vertex.x*0.3 / depth);
                _Y = (_DepthMultiplier*v.vertex.y*0.3 / depth);
                _Z = (_DepthMultiplier*v.vertex.z*0.3 / depth);

                o.vertex = UnityObjectToClipPos(float4(_X,_Y,_Z,1));
                //o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }


            fixed4 frag (v2f i) : SV_Target
            {
                // The color texture is sampled normally, so we have to flip the coordinates back
                float4 col;
                col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}