Shader "Uncharted Limbo/Unlit/Skybox Depth Shader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
        _DepthMultiplier("Depth Multiplier", Float) = 1
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

            #include "UnityCG.cginc"

            // Depth Exaggeration
            float _DepthMultiplier;


            // Should vertex displacement be applied?            
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
                float vMaxD : TEXCOORD1;
            };

         
            v2f vert (appdata v)
            {
                v2f o;
                
                //o.uv = lerp(v.uv, float2(1-v.uv.y, v.uv.x), 0);
                float2 depth_uv = float2(v.uv.x , v.uv.y*0.5+0.5);

                float depth = tex2D(_MainTex, depth_uv).r;

                o.vertex = UnityObjectToClipPos(v.vertex * _DepthMultiplier);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float4 col;
                float2 image_uv = float2(i.uv.x , i.uv.y*0.5);

                col = tex2D(_MainTex, i.uv);
                col.a = 1;

                return col;
            }
            ENDCG
        }
    }
}