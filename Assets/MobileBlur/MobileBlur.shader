Shader "RufatShaderlab/Blur"
{
	
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "" {}
		_MaskTex("Base (RGB)", 2D) = "white" {}
	}
	CGINCLUDE
	#include "UnityCG.cginc"

	static const half4 curve[6] = {
		half4(3.0h, 3.0h, 3.0h, 3.0h),
		half4(2.0h, 2.0h, 2.0h, 2.0h),
		half4(0.0667h, 0.0667h, 0.0667h, 0.0667h),
		half4(0.091h, 0.091h, 0.091h, 0.091h),
		half4(0.1111h, 0.1111h, 0.1111h, 0.1111h),
		half4(0.2h, 0.2h, 0.2h, 0.2h)
	};

	struct appdata 
	{
		half4 pos : POSITION;
		half2 uv : TEXCOORD0;
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};

	struct v2f
	{
		half4 pos : SV_POSITION;
#if UNITY_UV_STARTS_AT_TOP
		half4 uv : TEXCOORD0;
#else 
		half2 uv : TEXCOORD0;
#endif	
		half2 uv1 : TEXCOORD1;
		UNITY_VERTEX_OUTPUT_STEREO
	};

	struct v2fb
	{
		half4 pos : SV_POSITION;
		half4  uv : TEXCOORD0;
		half2  uv1 : TEXCOORD1;
		UNITY_VERTEX_OUTPUT_STEREO
	};

	UNITY_DECLARE_SCREENSPACE_TEXTURE(_MainTex);
	UNITY_DECLARE_SCREENSPACE_TEXTURE(_MaskTex);
	UNITY_DECLARE_SCREENSPACE_TEXTURE(_BlurTex);
	half4 _MainTex_TexelSize;
	half4 _MainTex_ST;
	half _BlurAmount;

	v2f vert(appdata i)
	{
		v2f o;
		UNITY_SETUP_INSTANCE_ID(i);
		UNITY_INITIALIZE_OUTPUT(v2f, o);
		UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
		o.pos = UnityObjectToClipPos(i.pos);
		o.uv.xy = UnityStereoScreenSpaceUVAdjust(i.uv, _MainTex_ST);
#if UNITY_UV_STARTS_AT_TOP
		o.uv.zw = o.uv.xy;
		UNITY_BRANCH
		if (_MainTex_TexelSize.y < 0.0)
			o.uv.w = 1.0 - o.uv.w;
#endif
		o.uv1 = i.uv;
		return o;
	}

	v2fb vertb(appdata i)
	{
		v2fb o;
		UNITY_SETUP_INSTANCE_ID(i);
		UNITY_INITIALIZE_OUTPUT(v2fb, o);
		UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
		o.pos = UnityObjectToClipPos(i.pos);
		o.uv1 = UnityStereoScreenSpaceUVAdjust(i.uv, _MainTex_ST);
		half2 offset = _MainTex_TexelSize.xy * _BlurAmount.xx * (1.0h / _MainTex_ST.xy);
		o.uv = half4(UnityStereoScreenSpaceUVAdjust(i.uv - offset, _MainTex_ST), UnityStereoScreenSpaceUVAdjust(i.uv + offset, _MainTex_ST));
		return o;
	}

	fixed4 fragb(v2fb i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		half4 c = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv1);
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv1.x, i.uv.y));
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv.x, i.uv1.y));
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv1.x, i.uv.w));
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv.z, i.uv1.y));
#ifdef KERNEL
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.xy);
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.xw);
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.zy);
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.zw);
		return c * curve[4];
#endif
		return c * curve[5];
	}
		
	fixed4 fragg(v2fb i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		half4 c = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv1) * curve[0];
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv1.x, i.uv.y)) * curve[1];
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv.x, i.uv1.y)) * curve[1];
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv1.x, i.uv.w)) * curve[1];
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, half2(i.uv.z, i.uv1.y)) * curve[1];
#ifdef KERNEL
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.xy);
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.xw);
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.zy);
		c += UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.zw);
		return c * curve[2];
#endif
		return c * curve[3];
	}

	fixed4 frag(v2f i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
#if UNITY_UV_STARTS_AT_TOP
		fixed4 c = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv.zw);
#else
		fixed4 c = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MainTex, i.uv);
#endif
		fixed4 b = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_BlurTex, i.uv.xy);
		fixed4 m = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_MaskTex, i.uv1);
		return lerp(c, b, m.r);
	}

	ENDCG

	Subshader
	{
		Pass //0
		{
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }
			CGPROGRAM
			#pragma shader_feature KERNEL
			#pragma vertex vertb
			#pragma fragment fragb
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}
		Pass //1
		{
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }
			CGPROGRAM
			#pragma shader_feature KERNEL
			#pragma vertex vertb
			#pragma fragment fragg
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}
		Pass //2
		{
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}
	}
	Fallback off
}