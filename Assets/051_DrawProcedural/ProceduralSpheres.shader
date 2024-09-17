Shader "Tutorial/051_ProceduralSpheres"{
	//show values to edit in inspector
	Properties{
		[HDR] _Color ("Tint", Color) = (0, 0, 0, 1)
	}

	SubShader{
		//the material is completely non-transparent and is rendered at the same time as the other opaque geometry
		Tags{ "RenderType"="Opaque" "Queue"="Geometry" }

		Pass{
			CGPROGRAM

			//include useful shader functions
			#include "UnityCG.cginc"

			//define vertex and fragment shader functions
			#pragma vertex vert
			#pragma fragment frag

			//tint of the texture
			fixed4 _Color;

			//buffers
			StructuredBuffer<float3> SphereLocations;
			StructuredBuffer<int> Triangles;
			StructuredBuffer<float3> Positions;

			struct Atributes{
				uint vertex_id: SV_VertexID;
				uint instance_id: SV_InstanceID;
				UNITY_VERTEX_INPUT_INSTANCE_ID 
			};

			struct v2f
			{
				half4 col : COLOR0;
				float2 pos : TEXCOORD0;
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO 
			};

			//the vertex shader function
			v2f vert(Atributes input) {
				v2f o = (v2f)0;

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_INITIALIZE_OUTPUT(v2f, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				int positionIndex = Triangles[input.vertex_id];
				float3 position = Positions[positionIndex];
				//add sphere position
				position += SphereLocations[input.instance_id/2];
				//convert the vertex position from world space to clip space
				o.vertex = mul(UNITY_MATRIX_VP, float4(position, 1));

				return o;
			}

			//the fragment shader function
			fixed4 frag(v2f i) : SV_TARGET{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				//return the final color to be drawn on screen
				return _Color;
			}
			
			ENDCG
		}
	}
	Fallback "VertexLit"
}
