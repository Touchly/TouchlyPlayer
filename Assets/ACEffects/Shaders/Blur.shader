// Compiled shader for all platforms, uncompressed size: 667.2KB

Shader "ACEffects/Shaders/Blur" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TexWidth ("Texture Width", Float) = 128
 _TexHeight ("Texture Height", Float) = 128
 _GlowSize ("Glow Size", Float) = 1
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 20 avg math (6..47)
 //        d3d9 : 26 avg math (6..63)
 //      opengl : 26 avg math (6..63)
 // Stats for Fragment shader:
 //       d3d11 : 35 avg math (32..38), 18 avg texture (17..19)
 //        d3d9 : 48 avg math (46..51), 18 avg texture (17..19)
 //      opengl : 67 avg math (64..70), 18 avg texture (17..19)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
// Stats: 27 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Vector 16 [unity_Scale]
Vector 17 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[18] = { { 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[16].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[14];
DP4 R3.y, R1, c[13];
DP4 R3.x, R1, c[12];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[15];
ADD R2.xyz, R2, R3;
ADD result.texcoord[2].xyz, R2, R1;
MOV result.texcoord[1].z, R2.w;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 27 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_SHAr]
Vector 9 [unity_SHAg]
Vector 10 [unity_SHAb]
Vector 11 [unity_SHBr]
Vector 12 [unity_SHBg]
Vector 13 [unity_SHBb]
Vector 14 [unity_SHC]
Vector 15 [unity_Scale]
Vector 16 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c15.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c13
dp4 r3.y, r1, c12
dp4 r3.x, r1, c11
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c14
add r2.xyz, r2, r3
add o3.xyz, r2, r1
mov o2.z, r2.w
mov o2.y, r3.w
mov o2.x, r0
mad o1.xy, v2, c16, c16.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 20 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 64 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmeamhaemlcgfalnjhgkobjjhfnaajhajabaaaaaaaaafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
hmadaaaaeaaaabaanpaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
mad o1.xy, v2, c9, c9.zwzw
mad o2.xy, v3, c8, c8.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 96
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcfkcpnmicbbciekgpppgkdiffapeadpoabaaaaaanmacaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchaabaaaaeaaaabaafmaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  c_1.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  c_1.xyz = (tmpvar_2 * ((8.0 * tmpvar_47.w) * tmpvar_47.xyz));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  c_1.xyz = (tmpvar_2 * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
mad o1.xy, v2, c9, c9.zwzw
mad o2.xy, v3, c8, c8.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 96
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcfkcpnmicbbciekgpppgkdiffapeadpoabaaaaaanmacaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchaabaaaaeaaaabaafmaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  mediump vec3 lm_47;
  lowp vec3 tmpvar_48;
  tmpvar_48 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_47 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (tmpvar_2 * lm_47);
  c_1.xyz = tmpvar_49;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_48;
  lowp vec3 tmpvar_49;
  tmpvar_49 = ((8.0 * tmpvar_47.w) * tmpvar_47.xyz);
  lm_48 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_2 * lm_48);
  c_1.xyz = tmpvar_50;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  mediump vec3 lm_47;
  lowp vec3 tmpvar_48;
  tmpvar_48 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_47 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (tmpvar_2 * lm_47);
  c_1.xyz = tmpvar_49;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 32 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[19] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xyz, vertex.normal, c[17].w;
DP3 R3.w, R0, c[6];
DP3 R2.w, R0, c[7];
DP3 R1.w, R0, c[5];
MOV R1.x, R3.w;
MOV R1.y, R2.w;
MOV R1.z, c[0].x;
MUL R0, R1.wxyy, R1.xyyw;
DP4 R2.z, R1.wxyz, c[12];
DP4 R2.y, R1.wxyz, c[11];
DP4 R2.x, R1.wxyz, c[10];
DP4 R1.z, R0, c[15];
DP4 R1.y, R0, c[14];
DP4 R1.x, R0, c[13];
MUL R3.x, R3.w, R3.w;
MAD R0.x, R1.w, R1.w, -R3;
ADD R3.xyz, R2, R1;
MUL R2.xyz, R0.x, c[16];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MOV result.texcoord[1].z, R2.w;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R1.w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 32 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c17.w
dp3 r3.w, r0, c5
dp3 r2.w, r0, c6
dp3 r1.w, r0, c4
mov r1.x, r3.w
mov r1.y, r2.w
mov r1.z, c19.x
mul r0, r1.wxyy, r1.xyyw
dp4 r2.z, r1.wxyz, c12
dp4 r2.y, r1.wxyz, c11
dp4 r2.x, r1.wxyz, c10
dp4 r1.z, r0, c15
dp4 r1.y, r0, c14
dp4 r1.x, r0, c13
mul r3.x, r3.w, r3.w
mad r0.x, r1.w, r1.w, -r3
add r3.xyz, r2, r1
mul r2.xyz, r0.x, c16
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c8.x
add o3.xyz, r3, r2
mad o4.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o4.zw, r0
mov o2.z, r2.w
mov o2.y, r3.w
mov o2.x, r1.w
mad o1.xy, v2, c18, c18.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjdljnlhejhgmdifnjjfjcgldiofnppggabaaaaaamaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcceaeaaaaeaaaabaa
ajabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  lowp vec4 c_53;
  c_53.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_47) * 2.0));
  c_53.w = tmpvar_3;
  c_1.w = c_53.w;
  c_1.xyz = (c_53.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_23;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = textureProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  lowp vec4 c_53;
  c_53.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_47) * 2.0));
  c_53.w = tmpvar_3;
  c_1.w = c_53.w;
  c_1.xyz = (c_53.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[12] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
mad o3.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o1.xy, v2, c11, c11.zwzw
mad o2.xy, v3, c10, c10.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 128 [unity_LightmapST]
Vector 144 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedafhpfajigmklogiabkpbjcondfkgjlbjabaaaaaajmadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
biacaaaaeaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((tmpvar_47 * 2.0))));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = o_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_49;
  tmpvar_49 = ((8.0 * tmpvar_48.w) * tmpvar_48.xyz);
  c_1.xyz = (tmpvar_2 * max (min (tmpvar_49, ((tmpvar_47.x * 2.0) * tmpvar_48.xyz)), (tmpvar_49 * tmpvar_47.x)));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = textureProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((tmpvar_47 * 2.0))));
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[12] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 11 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c8.x
mad o3.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o1.xy, v2, c11, c11.zwzw
mad o2.xy, v3, c10, c10.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 128 [unity_LightmapST]
Vector 144 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedafhpfajigmklogiabkpbjcondfkgjlbjabaaaaaajmadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
biacaaaaeaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  mediump vec3 lm_53;
  lowp vec3 tmpvar_54;
  tmpvar_54 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_53 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = vec3((tmpvar_47 * 2.0));
  mediump vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_2 * min (lm_53, tmpvar_55));
  c_1.xyz = tmpvar_56;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = o_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_49;
  lowp vec3 tmpvar_50;
  tmpvar_50 = ((8.0 * tmpvar_48.w) * tmpvar_48.xyz);
  lm_49 = tmpvar_50;
  lowp vec3 arg1_51;
  arg1_51 = ((tmpvar_47.x * 2.0) * tmpvar_48.xyz);
  mediump vec3 tmpvar_52;
  tmpvar_52 = (tmpvar_2 * max (min (lm_49, arg1_51), (lm_49 * tmpvar_47.x)));
  c_1.xyz = tmpvar_52;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = textureProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  mediump vec3 lm_53;
  lowp vec3 tmpvar_54;
  tmpvar_54 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_53 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = vec3((tmpvar_47 * 2.0));
  mediump vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_2 * min (lm_53, tmpvar_55));
  c_1.xyz = tmpvar_56;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 57 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [unity_Scale]
Vector 25 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[26] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[24].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[10];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[9];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[11];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[12];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[19];
DP4 R2.y, R4, c[18];
DP4 R2.x, R4, c[17];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[14];
MAD R1.xyz, R0.x, c[13], R1;
MAD R0.xyz, R0.z, c[15], R1;
MAD R1.xyz, R0.w, c[16], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[22];
DP4 R4.z, R0, c[21];
DP4 R4.y, R0, c[20];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[23];
ADD R2.xyz, R2, R4.yzww;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV result.texcoord[1].z, R3.x;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R4;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 57 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 57 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_4LightPosX0]
Vector 9 [unity_4LightPosY0]
Vector 10 [unity_4LightPosZ0]
Vector 11 [unity_4LightAtten0]
Vector 12 [unity_LightColor0]
Vector 13 [unity_LightColor1]
Vector 14 [unity_LightColor2]
Vector 15 [unity_LightColor3]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c25, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c23.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c9
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c8
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c25.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c10
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c11
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c25.x
dp4 r2.z, r4, c18
dp4 r2.y, r4, c17
dp4 r2.x, r4, c16
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c25.y
mul r0, r0, r1
mul r1.xyz, r0.y, c13
mad r1.xyz, r0.x, c12, r1
mad r0.xyz, r0.z, c14, r1
mad r1.xyz, r0.w, c15, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c21
dp4 r4.z, r0, c20
dp4 r4.y, r0, c19
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c22
add r2.xyz, r2, r4.yzww
add r0.xyz, r2, r0
add o3.xyz, r0, r1
mov o2.z, r3.x
mov o2.y, r3.w
mov o2.x, r4
mad o1.xy, v2, c24, c24.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 44 math
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 64 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedfbigkjmadelpjkpcmmkgojebjnhpomeeabaaaaaafaaiaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
mmagaaaaeaaaabaaldabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
fgafbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 63 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [unity_Scale]
Vector 26 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[27] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[25].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[11];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[10];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[12];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[13];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[20];
DP4 R2.y, R4, c[19];
DP4 R2.x, R4, c[18];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[15];
MAD R1.xyz, R0.x, c[14], R1;
MAD R0.xyz, R0.z, c[16], R1;
MAD R1.xyz, R0.w, c[17], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[23];
DP4 R4.z, R0, c[22];
DP4 R4.y, R0, c[21];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[24];
ADD R2.xyz, R2, R4.yzww;
ADD R4.yzw, R2.xxyz, R0.xxyz;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].z;
ADD result.texcoord[2].xyz, R4.yzww, R1;
MOV R1.x, R2;
MUL R1.y, R2, c[9].x;
ADD result.texcoord[3].xy, R1, R2.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MOV result.texcoord[1].z, R3.x;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R4;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 63 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 63 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [unity_Scale]
Vector 26 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c27, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c25.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c11
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c10
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c27.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c12
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c13
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c27.x
dp4 r2.z, r4, c20
dp4 r2.y, r4, c19
dp4 r2.x, r4, c18
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c27.y
mul r0, r0, r1
mul r1.xyz, r0.y, c15
mad r1.xyz, r0.x, c14, r1
mad r0.xyz, r0.z, c16, r1
mad r1.xyz, r0.w, c17, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c23
dp4 r4.z, r0, c22
dp4 r4.y, r0, c21
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c24
add r2.xyz, r2, r4.yzww
add r4.yzw, r2.xxyz, r0.xxyz
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c27.z
add o3.xyz, r4.yzww, r1
mov r1.x, r2
mul r1.y, r2, c8.x
mad o4.xy, r2.z, c9.zwzw, r1
mov o0, r0
mov o4.zw, r0
mov o2.z, r3.x
mov o2.y, r3.w
mov o2.x, r4
mad o1.xy, v2, c26, c26.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 47 math
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfpmbmbacfcpchkhlhickfdhaekjadnmhabaaaaaabaajaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcheahaaaaeaaaabaa
nnabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaa
diaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaah
pcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaa
agaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
pcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaa
dcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaa
agaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaa
adaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaa
adaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  lowp vec4 c_53;
  c_53.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_47) * 2.0));
  c_53.w = tmpvar_3;
  c_1.w = c_53.w;
  c_1.xyz = (c_53.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_23;
  tmpvar_23 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_23.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_23.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_23.z);
  highp vec4 tmpvar_27;
  tmpvar_27 = (((tmpvar_24 * tmpvar_24) + (tmpvar_25 * tmpvar_25)) + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_24 * tmpvar_6.x) + (tmpvar_25 * tmpvar_6.y)) + (tmpvar_26 * tmpvar_6.z)) * inversesqrt(tmpvar_27))) * (1.0/((1.0 + (tmpvar_27 * unity_4LightAtten0)))));
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_28.x) + (unity_LightColor[1].xyz * tmpvar_28.y)) + (unity_LightColor[2].xyz * tmpvar_28.z)) + (unity_LightColor[3].xyz * tmpvar_28.w)));
  tmpvar_3 = tmpvar_29;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_30;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp vec4 c_47;
  c_47.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x) * 2.0));
  c_47.w = tmpvar_3;
  c_1.w = c_47.w;
  c_1.xyz = (c_47.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = textureProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  lowp vec4 c_53;
  c_53.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_47) * 2.0));
  c_53.w = tmpvar_3;
  c_1.w = c_53.w;
  c_1.xyz = (c_53.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  lowp float tmpvar_48;
  tmpvar_48 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (tmpvar_48 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_47) * 2.0));
  c_50.w = tmpvar_3;
  c_1.w = c_50.w;
  c_1.xyz = (c_50.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  mediump float tmpvar_48;
  tmpvar_48 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  shadow_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (shadow_47 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_47) * 2.0));
  c_50.w = tmpvar_3;
  c_1.w = c_50.w;
  c_1.xyz = (c_50.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  lowp float tmpvar_48;
  tmpvar_48 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (tmpvar_48 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_47 * 2.0))));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  mediump float tmpvar_48;
  tmpvar_48 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  shadow_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (shadow_47 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_47 * 2.0))));
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  lowp float tmpvar_48;
  tmpvar_48 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (tmpvar_48 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  mediump vec3 lm_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_50 = tmpvar_51;
  lowp vec3 tmpvar_52;
  tmpvar_52 = vec3((shadow_47 * 2.0));
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_2 * min (lm_50, tmpvar_52));
  c_1.xyz = tmpvar_53;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  mediump float tmpvar_48;
  tmpvar_48 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  shadow_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (shadow_47 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  mediump vec3 lm_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_50 = tmpvar_51;
  lowp vec3 tmpvar_52;
  tmpvar_52 = vec3((shadow_47 * 2.0));
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_2 * min (lm_50, tmpvar_52));
  c_1.xyz = tmpvar_53;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture2D (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  lowp float tmpvar_48;
  tmpvar_48 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (tmpvar_48 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_47) * 2.0));
  c_50.w = tmpvar_3;
  c_1.w = c_50.w;
  c_1.xyz = (c_50.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + tmpvar_4);
  tmpvar_8 = texture (_MainTex, P_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (tmpvar_4 * 2.0));
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_4 * 3.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_4 * 4.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_4 * -1.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_4 * -2.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_4 * -3.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_4 * -4.0));
  tmpvar_22 = texture (_MainTex, P_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = ((((((((blur_color_6 + (tmpvar_8 * 0.16)) + (tmpvar_10 * 0.12)) + (tmpvar_12 * 0.08)) + (tmpvar_14 * 0.04)) + (tmpvar_16 * 0.16)) + (tmpvar_18 * 0.12)) + (tmpvar_20 * 0.08)) + (tmpvar_22 * 0.04));
  blur_color_6 = tmpvar_24;
  highp vec4 blur_color_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_25 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_41 = texture (_MainTex, P_42);
  highp vec4 tmpvar_43;
  tmpvar_43 = ((((((((blur_color_25 + (tmpvar_27 * 0.16)) + (tmpvar_29 * 0.12)) + (tmpvar_31 * 0.08)) + (tmpvar_33 * 0.04)) + (tmpvar_35 * 0.16)) + (tmpvar_37 * 0.12)) + (tmpvar_39 * 0.08)) + (tmpvar_41 * 0.04));
  blur_color_25 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_24 + tmpvar_43) * 0.5);
  highp vec3 tmpvar_45;
  tmpvar_45 = tmpvar_44.xyz;
  tmpvar_2 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = tmpvar_44.w;
  tmpvar_3 = tmpvar_46;
  lowp float shadow_47;
  mediump float tmpvar_48;
  tmpvar_48 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  shadow_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (shadow_47 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_47) * 2.0));
  c_50.w = tmpvar_3;
  c_1.w = c_50.w;
  c_1.xyz = (c_50.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 66 math, 17 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
Float 4 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..4],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[2].x;
MUL R4.w, R0.x, c[4].x;
MOV R4.z, c[5].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[5];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[5].z;
MAD R2, R0, c[5].x, R1;
MAD R3.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[6].y, fragment.texcoord[0];
MAD R2, R1, c[6].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[6].w, fragment.texcoord[0];
MAD R2, R1, c[6].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[7].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[7].y, fragment.texcoord[0];
MAD R2, R1, c[5].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[6].x, R2;
MAD R3.xy, R4.zwzw, c[7].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[6].z, R2;
RCP R1.x, c[3].x;
MUL R4.x, R1, c[4];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[7].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[7].x, R3;
MUL R1, R1, c[5].z;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R1, R0, c[6].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
MAD R1, R0, c[6].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[7].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[7].y, fragment.texcoord[0];
MAD R1, R0, c[5].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[7].z, fragment.texcoord[0];
MAD R1, R0, c[6].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[6].z, R1;
MAD R3.xy, R4, c[7].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[7].x, R1;
ADD R0, R0, R2;
MUL R1, R0, c[8].x;
MUL R0.xyz, R1, fragment.texcoord[2];
DP3 R0.w, fragment.texcoord[1], c[0];
MUL R1.xyz, R1, c[1];
MAX R0.w, R0, c[5].y;
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R1, c[5].w, R0;
MOV result.color.w, R1;
END
# 66 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 49 math, 17 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
Float 4 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c5, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c6, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c7, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c8, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
rcp r0.x, c2.x
mul r4.w, r0.x, c4.x
mov r4.z, c5.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c5.x
texld r0, v0, s0
mul r1, r1, c5.y
mad r2, r0, c7.x, r1
mad r3.xy, r4.zwzw, c5.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c5.w, v0
mad r2, r1, c7.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c6.x, v0
mad r2, r1, c7.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c7.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c6.y, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r2, r1, c7.y, r2
mad r3.xy, r4.zwzw, c6.z, v0
texld r1, r3, s0
mad r3, r1, c7.z, r2
rcp r1.x, c3.x
mul r4.x, r1, c4
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c6.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c7.w, r3
mul r1, r1, c5.y
mad r3.xy, r4, c5.z, v0
mad r1, r0, c7.x, r1
texld r0, r3, s0
mad r3.xy, r4, c5.w, v0
mad r1, r0, c7.y, r1
texld r0, r3, s0
mad r3.xy, r4, c6.x, v0
mad r1, r0, c7.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c7.w, r1
texld r0, r3, s0
mad r3.xy, r4, c6.y, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c6.z, v0
mad r1, r0, c7.y, r1
texld r0, r3, s0
mad r1, r0, c7.z, r1
mad r3.xy, r4, c6.w, v0
texld r0, r3, s0
mad r0, r0, c7.w, r1
add r0, r0, r2
mul r0, r0, c8.x
mul_pp r1.xyz, r0, v2
mul_pp r2.xyz, r0, c1
dp3_pp r1.w, v1, c0
max_pp r0.x, r1.w, c5
mul_pp r0.xyz, r0.x, r2
mad_pp oC0.xyz, r0, c5.z, r1
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 35 math, 17 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 16 [_LightColor0]
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedcghjelfonndlakjohdigiepiakjhegdmabaaaaaabaakaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefccaajaaaaeaaaaaaaeiacaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdodgaaaaaimcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaoaaaaajdcaabaaa
abaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaaaaaaaaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
acaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
ipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaadcaaaaampcaabaaa
adaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaiaeaaaaaiaea
egbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddnaknhcddn
aknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaaadaaaaaaigagbaia
ebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaaabaaaaaaaceaaaaa
aaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaadcaaaaampcaabaaa
afaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiamaaaaaaaaaaaaaeaea
egbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
agaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
acaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaadgaaaaaincaabaaa
abaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeamadcaaaaampcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaamaegagbaaaabaaaaaa
egbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaa
afaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaaaceaaaaaaknhcddn
aknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaa
egaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddoegaobaaa
acaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaaaceaaaaaipmcpfdn
ipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaa
egaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddnegaobaaa
acaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiamadcaaaaamdcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaaegaabaaaabaaaaaa
egbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadp
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 64 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[1].x;
RCP R4.x, c[0].x;
MUL R4.y, R4.x, c[2].x;
MUL R4.z, R0.x, c[2].x;
MOV R4.w, c[3].y;
ADD R0.xy, R4.zwzw, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R4.x, c[3].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, -R4.zwzw, fragment.texcoord[0];
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
ADD R1.zw, fragment.texcoord[0].xyxy, R4.xyxy;
TEX R2, R1.zwzw, texture[0], 2D;
MAD R1.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
MAD R1, R1, c[5].x, R3;
MUL R2, R2, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R2, R0, c[3].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R2, R0, c[4].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R2, R0, c[4].z, R2;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4;
MAD R2, R0, c[5].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R2, R0, c[3].z, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R2, R0, c[4].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R2, R0, c[4].z, R2;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R2, R0, c[5].x, R2;
TEX R0, fragment.texcoord[1], texture[1], 2D;
ADD R1, R1, R2;
MUL R1, R1, c[6].x;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R1, R0;
MOV result.color.w, R1;
MUL result.color.xyz, R0, c[6].y;
END
# 64 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 46 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
rcp r0.x, c1.x
rcp r4.z, c0.x
mul r4.w, r4.z, c2.x
mul r4.x, r0, c2
mov r4.y, c3.x
add r0.xy, r4, v0
texld r0, r0, s0
mov r4.z, c3.x
texld r1, v0, s0
mul r0, r0, c3.y
mad r2, r1, c5.x, r0
mad r3.xy, r4, c3.z, v0
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r2, r0, c5.y, r2
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r2, r0, c5.z, r2
texld r0, r3, s0
add r3.xy, -r4, v0
mad r2, r0, c5.w, r2
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r2, r0, c3.y, r2
texld r0, r3, s0
mad r2, r0, c5.y, r2
mad r3.xy, r4, c4.z, v0
texld r0, r3, s0
mad r3, r0, c5.z, r2
add r2.xy, v0, r4.zwzw
mad r0.xy, r4, c4.w, v0
texld r2, r2, s0
texld r0, r0, s0
mad r0, r0, c5.w, r3
mul r2, r2, c3.y
mad r3.xy, r4.zwzw, c3.z, v0
mad r2, r1, c5.x, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.z, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r2, r1, c5.z, r2
mad r3.xy, r4.zwzw, c4.w, v0
texld r1, r3, s0
mad r2, r1, c5.w, r2
texld r1, v1, s1
add r0, r0, r2
mul r0, r0, c6.x
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r0, r1
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, c6.y
"
}
SubProgram "d3d11 " {
// Stats: 32 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedehebojannolepgkfpablidjkifoecolkabaaaaaaliajaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaaiaaaaeaaaaaaadiacaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaaaaaaaaaa
adaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 64 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[1].x;
RCP R4.x, c[0].x;
MUL R4.y, R4.x, c[2].x;
MUL R4.z, R0.x, c[2].x;
MOV R4.w, c[3].y;
ADD R0.xy, R4.zwzw, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R4.x, c[3].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, -R4.zwzw, fragment.texcoord[0];
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
ADD R1.zw, fragment.texcoord[0].xyxy, R4.xyxy;
TEX R2, R1.zwzw, texture[0], 2D;
MAD R1.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
MAD R1, R1, c[5].x, R3;
MUL R2, R2, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R2, R0, c[3].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R2, R0, c[4].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R2, R0, c[4].z, R2;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4;
MAD R2, R0, c[5].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R2, R0, c[3].z, R2;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R2, R0, c[4].x, R2;
TEX R0, R3, texture[0], 2D;
MAD R2, R0, c[4].z, R2;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R2, R0, c[5].x, R2;
TEX R0, fragment.texcoord[1], texture[1], 2D;
ADD R1, R1, R2;
MUL R1, R1, c[6].x;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R1, R0;
MOV result.color.w, R1;
MUL result.color.xyz, R0, c[6].y;
END
# 64 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 46 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
rcp r0.x, c1.x
rcp r4.z, c0.x
mul r4.w, r4.z, c2.x
mul r4.x, r0, c2
mov r4.y, c3.x
add r0.xy, r4, v0
texld r0, r0, s0
mov r4.z, c3.x
texld r1, v0, s0
mul r0, r0, c3.y
mad r2, r1, c5.x, r0
mad r3.xy, r4, c3.z, v0
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r2, r0, c5.y, r2
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r2, r0, c5.z, r2
texld r0, r3, s0
add r3.xy, -r4, v0
mad r2, r0, c5.w, r2
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r2, r0, c3.y, r2
texld r0, r3, s0
mad r2, r0, c5.y, r2
mad r3.xy, r4, c4.z, v0
texld r0, r3, s0
mad r3, r0, c5.z, r2
add r2.xy, v0, r4.zwzw
mad r0.xy, r4, c4.w, v0
texld r2, r2, s0
texld r0, r0, s0
mad r0, r0, c5.w, r3
mul r2, r2, c3.y
mad r3.xy, r4.zwzw, c3.z, v0
mad r2, r1, c5.x, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.z, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r2, r1, c5.z, r2
mad r3.xy, r4.zwzw, c4.w, v0
texld r1, r3, s0
mad r2, r1, c5.w, r2
texld r1, v1, s1
add r0, r0, r2
mul r0, r0, c6.x
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r0, r1
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, c6.y
"
}
SubProgram "d3d11 " {
// Stats: 32 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedehebojannolepgkfpablidjkifoecolkabaaaaaaliajaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaaiaaaaeaaaaaaadiacaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaaaaaaaaaa
adaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 68 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
Float 4 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..4],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[2].x;
MUL R4.w, R0.x, c[4].x;
MOV R4.z, c[5].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[5];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[5].z;
MAD R2, R0, c[5].x, R1;
MAD R3.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[6].y, fragment.texcoord[0];
MAD R2, R1, c[6].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[6].w, fragment.texcoord[0];
MAD R2, R1, c[6].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[7].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[7].y, fragment.texcoord[0];
MAD R2, R1, c[5].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[6].x, R2;
MAD R3.xy, R4.zwzw, c[7].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[6].z, R2;
RCP R1.x, c[3].x;
MUL R4.x, R1, c[4];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[7].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[7].x, R3;
MUL R1, R1, c[5].z;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R1, R0, c[6].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
MAD R1, R0, c[6].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[7].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[7].y, fragment.texcoord[0];
MAD R1, R0, c[5].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[7].z, fragment.texcoord[0];
MAD R1, R0, c[6].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[6].z, R1;
MAD R3.xy, R4, c[7].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[7].x, R1;
ADD R0, R0, R2;
MUL R0, R0, c[8].x;
MUL R1.xyz, R0, fragment.texcoord[2];
MUL R2.xyz, R0, c[1];
DP3 R0.y, fragment.texcoord[1], c[0];
MAX R0.y, R0, c[5];
TXP R0.x, fragment.texcoord[3], texture[1], 2D;
MUL R0.x, R0.y, R0;
MUL R0.xyz, R0.x, R2;
MAD result.color.xyz, R0, c[5].w, R1;
MOV result.color.w, R0;
END
# 68 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 50 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
Float 4 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c6, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c7, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c8, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
rcp r0.x, c2.x
mul r4.w, r0.x, c4.x
mov r4.z, c5.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c5.x
texld r0, v0, s0
mul r1, r1, c5.y
mad r2, r0, c7.x, r1
mad r3.xy, r4.zwzw, c5.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c5.w, v0
mad r2, r1, c7.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c6.x, v0
mad r2, r1, c7.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c7.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c6.y, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r2, r1, c7.y, r2
mad r3.xy, r4.zwzw, c6.z, v0
texld r1, r3, s0
mad r3, r1, c7.z, r2
rcp r1.x, c3.x
mul r4.x, r1, c4
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c6.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c7.w, r3
mul r1, r1, c5.y
mad r3.xy, r4, c5.z, v0
mad r1, r0, c7.x, r1
texld r0, r3, s0
mad r3.xy, r4, c5.w, v0
mad r1, r0, c7.y, r1
texld r0, r3, s0
mad r3.xy, r4, c6.x, v0
mad r1, r0, c7.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c7.w, r1
texld r0, r3, s0
mad r3.xy, r4, c6.y, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c6.z, v0
mad r1, r0, c7.y, r1
texld r0, r3, s0
mad r1, r0, c7.z, r1
mad r3.xy, r4, c6.w, v0
texld r0, r3, s0
mad r0, r0, c7.w, r1
add r0, r0, r2
mul r0, r0, c8.x
mul_pp r1.xyz, r0, v2
mul_pp r2.xyz, r0, c1
dp3_pp r0.y, v1, c0
max_pp r0.y, r0, c5.x
texldp r0.x, v3, s1
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mad_pp oC0.xyz, r0, c5.z, r1
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 36 math, 18 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
Float 120 [_GlowSize]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecednnbeibakfndihgdpdfibmaapcpffhgceabaaaaaajaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciiajaaaaeaaaaaaagcacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdodgaaaaaimcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaoaaaaajdcaabaaa
abaaaaaakgikcaaaaaaaaaaaahaaaaaabgifcaaaaaaaaaaaahaaaaaaaaaaaaah
pcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaa
acaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
ipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaadcaaaaampcaabaaa
adaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaiaeaaaaaiaea
egbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddnaknhcddn
aknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaaadaaaaaaigagbaia
ebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaaabaaaaaaaceaaaaa
aaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaadcaaaaampcaabaaa
afaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiamaaaaaaaaaaaaaeaea
egbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
agaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaa
acaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaadgaaaaaincaabaaa
abaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeamadcaaaaampcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaamaegagbaaaabaaaaaa
egbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaa
afaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaaaceaaaaaaknhcddn
aknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaa
egaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddoegaobaaa
acaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaaaceaaaaaipmcpfdn
ipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaa
egaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddnegaobaaa
acaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiamadcaaaaamdcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaaegaabaaaabaaaaaa
egbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadp
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaa
agaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 70 math, 19 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[3].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[3];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[5].x, R3;
MUL R1, R1, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R1, R0, c[3].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[3].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[5].x, R1;
ADD R0, R0, R2;
MUL R0, R0, c[6].x;
TEX R2, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R2.w, R2;
TXP R3.x, fragment.texcoord[2], texture[1], 2D;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[6].y;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[3].w;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 70 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 51 math, 19 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord2 v2
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c3.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c3.x
texld r0, v0, s0
mul r1, r1, c3.y
mad r2, r0, c5.x, r1
mad r3.xy, r4.zwzw, c3.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r2, r1, c5.y, r2
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3, r1, c5.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c4.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c5.w, r3
mul r1, r1, c3.y
mad r3.xy, r4, c3.z, v0
mad r1, r0, c5.x, r1
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c5.w, r1
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r1, r0, c3.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.z, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.w, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
mad r0, r0, c5.w, r1
add r0, r0, r2
mul r0, r0, c6.x
texld r2, v1, s2
mul_pp r1.xyz, r2.w, r2
texldp r3.x, v2, s1
mul_pp r2.xyz, r2, r3.x
mul_pp r1.xyz, r1, c6.y
mul_pp r3.xyz, r1, r3.x
mul_pp r2.xyz, r2, c3.z
min_pp r1.xyz, r1, r2
max_pp r1.xyz, r1, r3
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}
SubProgram "d3d11 " {
// Stats: 38 math, 19 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 160
Float 112 [_TexWidth]
Float 116 [_TexHeight]
Float 120 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedahmpmgffkfjgogijjkpjdklaiapekcakabaaaaaameakaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcneajaaaaeaaaaaaahfacaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaabgifcaaaaaaaaaaa
ahaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaa
acaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaddaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaaabaaaaaa
jgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 70 math, 19 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[3].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[3];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[5].x, R3;
MUL R1, R1, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R1, R0, c[3].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[3].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[5].x, R1;
ADD R0, R0, R2;
MUL R0, R0, c[6].x;
TEX R2, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R2.w, R2;
TXP R3.x, fragment.texcoord[2], texture[1], 2D;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[6].y;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[3].w;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 70 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 51 math, 19 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord2 v2
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c3.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c3.x
texld r0, v0, s0
mul r1, r1, c3.y
mad r2, r0, c5.x, r1
mad r3.xy, r4.zwzw, c3.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r2, r1, c5.y, r2
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3, r1, c5.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c4.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c5.w, r3
mul r1, r1, c3.y
mad r3.xy, r4, c3.z, v0
mad r1, r0, c5.x, r1
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c5.w, r1
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r1, r0, c3.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.z, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.w, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
mad r0, r0, c5.w, r1
add r0, r0, r2
mul r0, r0, c6.x
texld r2, v1, s2
mul_pp r1.xyz, r2.w, r2
texldp r3.x, v2, s1
mul_pp r2.xyz, r2, r3.x
mul_pp r1.xyz, r1, c6.y
mul_pp r3.xyz, r1, r3.x
mul_pp r2.xyz, r2, c3.z
min_pp r1.xyz, r1, r2
max_pp r1.xyz, r1, r3
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}
SubProgram "d3d11 " {
// Stats: 38 math, 19 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 160
Float 112 [_TexWidth]
Float 116 [_TexHeight]
Float 120 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedahmpmgffkfjgogijjkpjdklaiapekcakabaaaaaameakaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcneajaaaaeaaaaaaahfacaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaabgifcaaaaaaaaaaa
ahaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaa
acaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaddaaaaah
ocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaaabaaaaaa
jgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 18 avg math (9..22)
 //        d3d9 : 15 avg math (10..18)
 //      opengl : 15 avg math (10..18)
 // Stats for Fragment shader:
 //       d3d11 : 37 avg math (34..44), 18 avg texture (17..19)
 //        d3d9 : 52 avg math (49..58), 18 avg texture (17..19)
 //      opengl : 71 avg math (66..77), 18 avg texture (17..19)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
// Stats: 17 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[3].z, R0, c[11];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
add o3.xyz, -r0, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmkdnfadlcmlmbhgmpcelnmiiknkjgdhiabaaaaaaieafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiadaaaaeaaaabaa
pkaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_49)).w) * 2.0));
  c_50.w = tmpvar_4;
  c_1.xyz = c_50.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_49)).w) * 2.0));
  c_50.w = tmpvar_4;
  c_1.xyz = c_50.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture (_LightTexture0, vec2(tmpvar_49)).w) * 2.0));
  c_50.w = tmpvar_4;
  c_1.xyz = c_50.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 10 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[10].w;
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
MOV result.texcoord[2].xyz, c[9];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 10 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c9.w
dp3 o2.z, r0, c6
dp3 o2.y, r0, c5
dp3 o2.x, r0, c4
mov o3.xyz, c8
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 9 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 64 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkdiibmphijljogdpglnnmdhehdcpiijgabaaaaaaimadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aiacaaaaeaaaabaaicaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_48;
  c_48.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_48.w = tmpvar_4;
  c_1.xyz = c_48.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_48;
  c_48.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_48.w = tmpvar_4;
  c_1.xyz = c_48.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_48;
  c_48.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_48.w = tmpvar_4;
  c_1.xyz = c_48.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 18 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[3].w, R0, c[12];
DP4 result.texcoord[3].z, R0, c[11];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 18 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 o4.w, r0, c11
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
add o3.xyz, -r0, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecediofjddpdclcpgaobidggikdkcbdonpomabaaaaaaieafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiadaaaaeaaaabaa
pkaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_51;
  atten_51 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_49).w) * texture2D (_LightTextureB0, vec2(tmpvar_50)).w);
  lowp vec4 c_52;
  c_52.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_51) * 2.0));
  c_52.w = tmpvar_4;
  c_1.xyz = c_52.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_51;
  atten_51 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_49).w) * texture2D (_LightTextureB0, vec2(tmpvar_50)).w);
  lowp vec4 c_52;
  c_52.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_51) * 2.0));
  c_52.w = tmpvar_4;
  c_1.xyz = c_52.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_51;
  atten_51 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture (_LightTexture0, P_49).w) * texture (_LightTextureB0, vec2(tmpvar_50)).w);
  lowp vec4 c_52;
  c_52.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_51) * 2.0));
  c_52.w = tmpvar_4;
  c_1.xyz = c_52.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 17 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[3].z, R0, c[11];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
add o3.xyz, -r0, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmkdnfadlcmlmbhgmpcelnmiiknkjgdhiabaaaaaaieafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiadaaaaeaaaabaa
pkaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_49)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_50.w = tmpvar_4;
  c_1.xyz = c_50.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_49)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_50.w = tmpvar_4;
  c_1.xyz = c_50.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_50;
  c_50.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture (_LightTextureB0, vec2(tmpvar_49)).w * texture (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_50.w = tmpvar_4;
  c_1.xyz = c_50.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 16 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MOV result.texcoord[2].xyz, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
mov o3.xyz, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 17 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedafeefeikmibbonepheebhknfbildklbaabaaaaaaoaaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceeadaaaaeaaaabaa
nbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakmccabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
agaebaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_48;
  c_48.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_48.w = tmpvar_4;
  c_1.xyz = c_48.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture2D (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture2D (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_48;
  c_48.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_48.w = tmpvar_4;
  c_1.xyz = c_48.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_6;
  tmpvar_6.x = 0.0;
  tmpvar_6.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + tmpvar_5);
  tmpvar_9 = texture (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD0 + (tmpvar_5 * 2.0));
  tmpvar_11 = texture (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + (tmpvar_5 * 3.0));
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_5 * 4.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_5 * -1.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_5 * -2.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_5 * -3.0));
  tmpvar_21 = texture (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_5 * -4.0));
  tmpvar_23 = texture (_MainTex, P_24);
  highp vec4 tmpvar_25;
  tmpvar_25 = ((((((((blur_color_7 + (tmpvar_9 * 0.16)) + (tmpvar_11 * 0.12)) + (tmpvar_13 * 0.08)) + (tmpvar_15 * 0.04)) + (tmpvar_17 * 0.16)) + (tmpvar_19 * 0.12)) + (tmpvar_21 * 0.08)) + (tmpvar_23 * 0.04));
  blur_color_7 = tmpvar_25;
  highp vec4 blur_color_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_26 = tmpvar_27;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_28 = texture (_MainTex, P_29);
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_30 = texture (_MainTex, P_31);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_32 = texture (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_34 = texture (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_36 = texture (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_38 = texture (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_40 = texture (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_42 = texture (_MainTex, P_43);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((((((((blur_color_26 + (tmpvar_28 * 0.16)) + (tmpvar_30 * 0.12)) + (tmpvar_32 * 0.08)) + (tmpvar_34 * 0.04)) + (tmpvar_36 * 0.16)) + (tmpvar_38 * 0.12)) + (tmpvar_40 * 0.08)) + (tmpvar_42 * 0.04));
  blur_color_26 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = ((tmpvar_25 + tmpvar_44) * 0.5);
  highp vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45.xyz;
  tmpvar_3 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = tmpvar_45.w;
  tmpvar_4 = tmpvar_47;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_48;
  c_48.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_48.w = tmpvar_4;
  c_1.xyz = c_48.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 71 math, 18 textures
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 0, 0.2, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[1].x;
RCP R0.w, c[2].x;
MUL R4.x, R0.w, c[3];
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
MUL R1.y, R0.x, c[3].x;
MOV R1.x, c[4];
ADD R0.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R0, texture[0], 2D;
MOV R4.y, c[4].x;
MAD R1.zw, R1.xyxy, c[4].w, fragment.texcoord[0].xyxy;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[4].z;
MAD R3.xyz, R0, c[4].y, R2;
TEX R2.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R2, c[5].x, R3;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].w, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[5].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
ADD R1.zw, fragment.texcoord[0].xyxy, -R1.xyxy;
MAD R2.xyz, R3, c[6].x, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[6].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[4].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R2.xyz, R3, c[5].x, R2;
MAD R1.zw, R1.xyxy, c[6].z, fragment.texcoord[0].xyxy;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R3.xyz, R3, c[5].z, R2;
MAD R2.xy, R1, c[6].w, fragment.texcoord[0];
ADD R1.zw, R4.xyxy, fragment.texcoord[0].xyxy;
TEX R1.xyz, R1.zwzw, texture[0], 2D;
MUL R1.xyz, R1, c[4].z;
TEX R2.xyz, R2, texture[0], 2D;
MAD R2.xyz, R2, c[6].x, R3;
MAD R0.xyz, R0, c[4].y, R1;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R0.xyz, R1, c[6].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[4].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].z, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[5].z, R0;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[6].x, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, fragment.texcoord[2];
ADD R0.xyz, R0, R2;
MUL R0.xyz, R0, c[7].x;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[1], R1;
MUL R0.xyz, R0, c[0];
TEX R0.w, R0.w, texture[1], 2D;
MAX R1.x, R1, c[4];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].w;
MOV result.color.w, c[4].x;
END
# 71 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 53 math, 18 textures
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c4, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c5, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c6, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c7, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
rcp r0.x, c1.x
mul r1.w, r0.x, c3.x
mov r1.z, c4.x
add r0.xy, v0, r1.zwzw
texld r2.xyz, r0, s0
mad r1.xy, r1.zwzw, c4.z, v0
texld r3.xyz, r1, s0
mad r4.xy, r1.zwzw, c5.w, v0
mad r1.xy, r1.zwzw, c4.w, v0
texld r0.xyz, v0, s0
mul r2.xyz, r2, c4.y
mad r2.xyz, r0, c6.x, r2
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.x, v0
mad r2.xyz, r3, c6.z, r2
texld r3.xyz, r1, s0
add r1.xy, v0, -r1.zwzw
mad r2.xyz, r3, c6.w, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.y, v0
mad r2.xyz, r3, c4.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.z, v0
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
rcp r0.w, c2.x
mul r1.x, r0.w, c3
dp3_pp r0.w, v2, v2
mov r1.y, c4.x
mad r2.xyz, r3, c6.z, r2
add r3.xy, r1, v0
texld r4.xyz, r4, s0
texld r3.xyz, r3, s0
mad r2.xyz, r4, c6.w, r2
mul r4.xyz, r3, c4.y
mad r0.xyz, r0, c6.x, r4
mad r3.xy, r1, c4.z, v0
texld r3.xyz, r3, s0
mad r4.xy, r1, c4.w, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.x, v0
mad r0.xyz, r3, c6.z, r0
texld r3.xyz, r4, s0
add r4.xy, -r1, v0
mad r0.xyz, r3, c6.w, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.y, v0
mad r0.xyz, r3, c4.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.z, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r1.xy, r1, c5.w, v0
texld r1.xyz, r1, s0
mad r0.xyz, r3, c6.z, r0
mad r0.xyz, r1, c6.w, r0
add r0.xyz, r0, r2
mul r0.xyz, r0, c7.x
mul_pp r1.xyz, r0, c0
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v2
dp3 r0.x, v3, v3
dp3_pp r0.y, v1, r2
max_pp r0.y, r0, c4.x
texld r0.x, r0.x, s1
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c4.z
mov_pp oC0.w, c4.x
"
}
SubProgram "d3d11 " {
// Stats: 38 math, 18 textures
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
Float 120 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaljhclnmhopgfllinjmklkjdfoilmjpmabaaaaaakeakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjmajaaaaeaaaaaaaghacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdomnmmemdo
mnmmemdoaaaaaaaadgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaeaeaaoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaa
bgifcaaaaaaaaaaaahaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaa
egbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaa
ipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaa
egacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
adaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaaaaaaaaaa
aaaaaaaipcaabaaaadaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaa
aeaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeama
egbebaaaabaaaaaadcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaa
aaaaiamaaaaaiamaaaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
aeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaa
egacbaaaaaaaaaaadgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaa
aaaaaamaaaaaeamadcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaea
aaaaaaaaaaaaaamaegagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaa
agbebaaaabaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaagaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddo
aknhcddoaknhcddoaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaaaknhkddn
aknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaa
abeaaaaaaaaaiamadcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiama
aaaaaaaaaaaaaaaaegaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 66 math, 17 textures
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 0, 0.2, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[1].x;
RCP R0.w, c[2].x;
MUL R1.y, R0.x, c[3].x;
MOV R1.x, c[4];
ADD R0.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R0, texture[0], 2D;
MUL R4.x, R0.w, c[3];
MOV R4.y, c[4].x;
MAD R1.zw, R1.xyxy, c[4].w, fragment.texcoord[0].xyxy;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[4].z;
MAD R3.xyz, R0, c[4].y, R2;
TEX R2.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R2, c[5].x, R3;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].w, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[5].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
ADD R1.zw, fragment.texcoord[0].xyxy, -R1.xyxy;
MAD R2.xyz, R3, c[6].x, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[6].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[4].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R2.xyz, R3, c[5].x, R2;
MAD R1.zw, R1.xyxy, c[6].z, fragment.texcoord[0].xyxy;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R3.xyz, R3, c[5].z, R2;
MAD R2.xy, R1, c[6].w, fragment.texcoord[0];
ADD R1.zw, R4.xyxy, fragment.texcoord[0].xyxy;
TEX R1.xyz, R1.zwzw, texture[0], 2D;
MUL R1.xyz, R1, c[4].z;
TEX R2.xyz, R2, texture[0], 2D;
MAD R2.xyz, R2, c[6].x, R3;
MAD R0.xyz, R0, c[4].y, R1;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R0.xyz, R1, c[6].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[4].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].z, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[5].z, R0;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[6].x, R0;
ADD R1.xyz, R0, R2;
MOV R0.xyz, fragment.texcoord[2];
DP3 R0.w, fragment.texcoord[1], R0;
MUL R1.xyz, R1, c[7].x;
MUL R0.xyz, R1, c[0];
MAX R0.w, R0, c[4].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].w;
MOV result.color.w, c[4].x;
END
# 66 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 49 math, 17 textures
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c4, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c5, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c6, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c7, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
rcp r0.x, c1.x
mul r1.w, r0.x, c3.x
mov r1.z, c4.x
add r0.xy, v0, r1.zwzw
texld r2.xyz, r0, s0
mad r1.xy, r1.zwzw, c4.z, v0
texld r3.xyz, r1, s0
mad r4.xy, r1.zwzw, c5.w, v0
mad r1.xy, r1.zwzw, c4.w, v0
texld r0.xyz, v0, s0
mul r2.xyz, r2, c4.y
mad r2.xyz, r0, c6.x, r2
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.x, v0
mad r2.xyz, r3, c6.z, r2
texld r3.xyz, r1, s0
add r1.xy, v0, -r1.zwzw
mad r2.xyz, r3, c6.w, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.y, v0
mad r2.xyz, r3, c4.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.z, v0
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
rcp r0.w, c2.x
mul r1.x, r0.w, c3
mov r1.y, c4.x
mad r2.xyz, r3, c6.z, r2
add r3.xy, r1, v0
texld r4.xyz, r4, s0
texld r3.xyz, r3, s0
mad r2.xyz, r4, c6.w, r2
mul r4.xyz, r3, c4.y
mad r0.xyz, r0, c6.x, r4
mad r3.xy, r1, c4.z, v0
texld r3.xyz, r3, s0
mad r4.xy, r1, c4.w, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.x, v0
mad r0.xyz, r3, c6.z, r0
texld r3.xyz, r4, s0
add r4.xy, -r1, v0
mad r0.xyz, r3, c6.w, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.y, v0
mad r0.xyz, r3, c4.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.z, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r1.xy, r1, c5.w, v0
texld r1.xyz, r1, s0
mad r0.xyz, r3, c6.z, r0
mad r0.xyz, r1, c6.w, r0
add r1.xyz, r0, r2
mov_pp r0.xyz, v2
dp3_pp r0.w, v1, r0
mul r1.xyz, r1, c7.x
mul_pp r0.xyz, r1, c0
max_pp r0.w, r0, c4.x
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c4.z
mov_pp oC0.w, c4.x
"
}
SubProgram "d3d11 " {
// Stats: 34 math, 17 textures
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 16 [_LightColor0]
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpodikimebciggelinfpdidnfgfbcccdhabaaaaaaniajaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoiaiaaaaeaaaaaaadkacaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdomnmmemdo
mnmmemdoaaaaaaaadgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaeaeaaoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaa
bgifcaaaaaaaaaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaa
egbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaa
ipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaa
egacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
adaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaaaaaaaaaa
aaaaaaaipcaabaaaadaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaa
aeaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeama
egbebaaaabaaaaaadcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaa
aaaaiamaaaaaiamaaaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
aeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaa
egacbaaaaaaaaaaadgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaa
aaaaaamaaaaaeamadcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaea
aaaaaaaaaaaaaamaegagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaa
agbebaaaabaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaagaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddo
aknhcddoaknhcddoaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaaaknhkddn
aknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaa
abeaaaaaaaaaiamadcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiama
aaaaaaaaaaaaaaaaegaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 77 math, 19 textures
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 0, 0.2, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[1].x;
RCP R0.w, c[2].x;
MUL R4.x, R0.w, c[3];
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
MUL R1.y, R0.x, c[3].x;
MOV R1.x, c[4];
ADD R0.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R0, texture[0], 2D;
MOV R4.y, c[4].x;
MAD R1.zw, R1.xyxy, c[4].w, fragment.texcoord[0].xyxy;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[4].z;
MAD R3.xyz, R0, c[4].y, R2;
TEX R2.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R2, c[5].x, R3;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].w, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[5].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
ADD R1.zw, fragment.texcoord[0].xyxy, -R1.xyxy;
MAD R2.xyz, R3, c[6].x, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[6].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[4].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R2.xyz, R3, c[5].x, R2;
MAD R1.zw, R1.xyxy, c[6].z, fragment.texcoord[0].xyxy;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R3.xyz, R3, c[5].z, R2;
MAD R2.xy, R1, c[6].w, fragment.texcoord[0];
ADD R1.zw, R4.xyxy, fragment.texcoord[0].xyxy;
TEX R1.xyz, R1.zwzw, texture[0], 2D;
MUL R1.xyz, R1, c[4].z;
TEX R2.xyz, R2, texture[0], 2D;
MAD R2.xyz, R2, c[6].x, R3;
MAD R0.xyz, R0, c[4].y, R1;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R0.xyz, R1, c[6].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[4].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].z, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[5].z, R0;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[6].x, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, fragment.texcoord[2];
DP3 R1.x, fragment.texcoord[1], R1;
RCP R0.w, fragment.texcoord[3].w;
MAD R1.zw, fragment.texcoord[3].xyxy, R0.w, c[7].x;
ADD R0.xyz, R0, R2;
MUL R0.xyz, R0, c[7].x;
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R1.zwzw, texture[1], 2D;
TEX R1.w, R1.y, texture[2], 2D;
SLT R1.y, c[4].x, fragment.texcoord[3].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MAX R0.w, R1.x, c[4].x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].w;
MOV result.color.w, c[4].x;
END
# 77 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 58 math, 19 textures
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c5, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c6, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c7, 0.50000000, 0.00000000, 1.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
rcp r0.x, c1.x
mul r1.w, r0.x, c3.x
mov r1.z, c4.x
add r0.xy, v0, r1.zwzw
texld r2.xyz, r0, s0
mad r1.xy, r1.zwzw, c4.z, v0
texld r3.xyz, r1, s0
mad r4.xy, r1.zwzw, c5.w, v0
mad r1.xy, r1.zwzw, c4.w, v0
texld r0.xyz, v0, s0
mul r2.xyz, r2, c4.y
mad r2.xyz, r0, c6.x, r2
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.x, v0
mad r2.xyz, r3, c6.z, r2
texld r3.xyz, r1, s0
add r1.xy, v0, -r1.zwzw
mad r2.xyz, r3, c6.w, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.y, v0
mad r2.xyz, r3, c4.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.z, v0
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
rcp r0.w, c2.x
mul r1.x, r0.w, c3
dp3_pp r0.w, v2, v2
mov r1.y, c4.x
mad r2.xyz, r3, c6.z, r2
add r3.xy, r1, v0
texld r4.xyz, r4, s0
texld r3.xyz, r3, s0
mad r2.xyz, r4, c6.w, r2
mul r4.xyz, r3, c4.y
mad r0.xyz, r0, c6.x, r4
mad r3.xy, r1, c4.z, v0
texld r3.xyz, r3, s0
mad r4.xy, r1, c4.w, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.x, v0
mad r0.xyz, r3, c6.z, r0
texld r3.xyz, r4, s0
add r4.xy, -r1, v0
mad r0.xyz, r3, c6.w, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.y, v0
mad r0.xyz, r3, c4.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.z, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r1.xy, r1, c5.w, v0
texld r1.xyz, r1, s0
mad r0.xyz, r3, c6.z, r0
mad r0.xyz, r1, c6.w, r0
add r0.xyz, r0, r2
mul r0.xyz, r0, c7.x
mul_pp r2.xyz, r0, c0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
dp3_pp r0.z, v1, r1
rcp r0.x, v3.w
mad r1.xy, v3, r0.x, c7.x
dp3 r0.x, v3, v3
texld r0.w, r1, s1
cmp r0.y, -v3.z, c7, c7.z
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s2
mul_pp r0.x, r0.y, r0
max_pp r0.y, r0.z, c4.x
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c4.z
mov_pp oC0.w, c4.x
"
}
SubProgram "d3d11 " {
// Stats: 44 math, 19 textures
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
Float 120 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddjglljhjjkpnelcohbemhohlclickcmnabaaaaaajialaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjaakaaaaeaaaaaaakeacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdo
aaaaaaaadgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaeaeaaoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaabgifcaaa
aaaaaaaaahaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaacaaaaaa
aceaaaaaaknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaipmcpfdn
ipmcpfdnipmcpfdnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaa
aaaaaaaadcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaadaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaaaaaaaaaaaaaaaaai
pcaabaaaadaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhcddo
aknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
igaibaaaabaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaa
abaaaaaadcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiama
aaaaiamaaaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdn
aaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaa
aceaaaaaaknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaaaknhkddn
aknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaaeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaa
aaaaaaaadgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaama
aaaaeamadcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaa
aaaaaamaegagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
agaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaaacaaaaaa
dcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaaacaaaaaa
dcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaaaaaaaaegacbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaa
aaaaiamadcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaa
aaaaaaaaegaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaa
egacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
abeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegbcbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 73 math, 19 textures
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 2
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 0, 0.2, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[2].x;
RCP R0.w, c[1].x;
MUL R4.y, R0.w, c[3].x;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
MUL R1.x, R0, c[3];
MOV R1.y, c[4].x;
ADD R0.xy, R1, fragment.texcoord[0];
TEX R2.xyz, R0, texture[0], 2D;
MOV R4.x, c[4];
MAD R1.zw, R1.xyxy, c[4].w, fragment.texcoord[0].xyxy;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[4].z;
MAD R3.xyz, R0, c[4].y, R2;
TEX R2.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R2, c[5].x, R3;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].w, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[5].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
ADD R1.zw, -R1.xyxy, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[6].x, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[6].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[4].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[6].z, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[5].x, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R3.xyz, R3, c[5].z, R2;
ADD R1.zw, fragment.texcoord[0].xyxy, R4.xyxy;
TEX R2.xyz, R1.zwzw, texture[0], 2D;
MUL R2.xyz, R2, c[4].z;
MAD R1.xy, R1, c[6].w, fragment.texcoord[0];
TEX R1.xyz, R1, texture[0], 2D;
MAD R1.xyz, R1, c[6].x, R3;
MAD R0.xyz, R0, c[4].y, R2;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
TEX R2.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R0.xyz, R2, c[5].x, R0;
TEX R2.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R0.xyz, R2, c[5].z, R0;
TEX R2.xyz, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4;
MAD R0.xyz, R2, c[6].x, R0;
TEX R2.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R0.xyz, R2, c[4].z, R0;
TEX R2.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].z, fragment.texcoord[0];
MAD R0.xyz, R2, c[5].x, R0;
TEX R2.xyz, R3, texture[0], 2D;
MAD R0.xyz, R2, c[5].z, R0;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
TEX R2.xyz, R3, texture[0], 2D;
MAD R0.xyz, R2, c[6].x, R0;
ADD R0.xyz, R1, R0;
MUL R1.xyz, R0, c[7].x;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[1], R0;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
MUL R1.xyz, R1, c[0];
TEX R0.w, fragment.texcoord[3], texture[2], CUBE;
TEX R1.w, R0.y, texture[1], 2D;
MUL R0.y, R1.w, R0.w;
MAX R0.x, R0, c[4];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[4].w;
MOV result.color.w, c[4].x;
END
# 73 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 54 math, 19 textures
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c4, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c5, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c6, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c7, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
rcp r0.x, c2.x
mov r0.y, c4.x
mul r0.x, r0, c3
add r1.xy, r0, v0
texld r2.xyz, r1, s0
mul r3.xyz, r2, c4.y
texld r1.xyz, v0, s0
mad r2.xy, r0, c4.z, v0
mad r3.xyz, r1, c6.x, r3
texld r2.xyz, r2, s0
mad r4.xy, r0, c4.w, v0
mad r2.xyz, r2, c6.y, r3
texld r3.xyz, r4, s0
mad r4.xy, r0, c5.x, v0
mad r2.xyz, r3, c6.z, r2
texld r3.xyz, r4, s0
add r4.xy, -r0, v0
mad r2.xyz, r3, c6.w, r2
texld r3.xyz, r4, s0
mad r4.xy, r0, c5.y, v0
mad r2.xyz, r3, c4.y, r2
texld r3.xyz, r4, s0
mad r4.xy, r0, c5.z, v0
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r4, s0
rcp r0.z, c1.x
mul r4.y, r0.z, c3.x
mad r0.xy, r0, c5.w, v0
mov r4.x, c4
mad r3.xyz, r3, c6.z, r2
add r2.xy, v0, r4
texld r2.xyz, r2, s0
mul r2.xyz, r2, c4.y
texld r0.xyz, r0, s0
mad r0.xyz, r0, c6.w, r3
mad r1.xyz, r1, c6.x, r2
mad r3.xy, r4, c4.z, v0
texld r2.xyz, r3, s0
mad r3.xy, r4, c4.w, v0
mad r1.xyz, r2, c6.y, r1
texld r2.xyz, r3, s0
mad r3.xy, r4, c5.x, v0
mad r1.xyz, r2, c6.z, r1
texld r2.xyz, r3, s0
add r3.xy, v0, -r4
mad r1.xyz, r2, c6.w, r1
texld r2.xyz, r3, s0
mad r3.xy, r4, c5.y, v0
mad r1.xyz, r2, c4.y, r1
texld r2.xyz, r3, s0
mad r3.xy, r4, c5.z, v0
mad r1.xyz, r2, c6.y, r1
texld r2.xyz, r3, s0
mad r1.xyz, r2, c6.z, r1
mad r3.xy, r4, c5.w, v0
texld r2.xyz, r3, s0
mad r1.xyz, r2, c6.w, r1
add r1.xyz, r0, r1
dp3_pp r0.w, v2, v2
rsq_pp r0.x, r0.w
mul_pp r0.xyz, r0.x, v2
dp3_pp r0.y, v1, r0
mul r1.xyz, r1, c7.x
dp3 r0.x, v3, v3
texld r0.x, r0.x, s1
texld r0.w, v3, s2
mul r0.z, r0.x, r0.w
max_pp r0.x, r0.y, c4
mul_pp r1.xyz, r1, c0
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c4.z
mov_pp oC0.w, c4.x
"
}
SubProgram "d3d11 " {
// Stats: 39 math, 19 textures
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
Float 120 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlcpnbmlmcoemdomcplgikohapaelmcneabaaaaaaaaalaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiajaaaaeaaaaaaahoacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdo
aaaaaaaadgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaeaeaaoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaabgifcaaa
aaaaaaaaahaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaacaaaaaa
aceaaaaaaknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaipmcpfdn
ipmcpfdnipmcpfdnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaa
aaaaaaaadcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaadaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaaaaaaaaaaaaaaaaai
pcaabaaaadaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhcddo
aknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
igaibaaaabaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaa
abaaaaaadcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiama
aaaaiamaaaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdn
aaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaa
aceaaaaaaknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaaaknhkddn
aknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaaeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaa
aaaaaaaadgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaama
aaaaeamadcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaa
aaaaaamaegagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
agaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaaacaaaaaa
dcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaaacaaaaaa
dcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaaaaaaaaegacbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaa
aaaaiamadcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaa
aaaaaaaaegaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaa
egacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 68 math, 18 textures
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 0, 0.2, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[1].x;
RCP R0.w, c[2].x;
MUL R4.x, R0.w, c[3];
MUL R1.y, R0.x, c[3].x;
MOV R1.x, c[4];
ADD R0.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R0, texture[0], 2D;
MOV R4.y, c[4].x;
MAD R1.zw, R1.xyxy, c[4].w, fragment.texcoord[0].xyxy;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[4].z;
MAD R3.xyz, R0, c[4].y, R2;
TEX R2.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R2, c[5].x, R3;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[5].w, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[5].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
ADD R1.zw, fragment.texcoord[0].xyxy, -R1.xyxy;
MAD R2.xyz, R3, c[6].x, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R1.zw, R1.xyxy, c[6].y, fragment.texcoord[0].xyxy;
MAD R2.xyz, R3, c[4].z, R2;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R2.xyz, R3, c[5].x, R2;
MAD R1.zw, R1.xyxy, c[6].z, fragment.texcoord[0].xyxy;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
MAD R3.xyz, R3, c[5].z, R2;
MAD R2.xy, R1, c[6].w, fragment.texcoord[0];
ADD R1.zw, R4.xyxy, fragment.texcoord[0].xyxy;
TEX R1.xyz, R1.zwzw, texture[0], 2D;
MUL R1.xyz, R1, c[4].z;
TEX R2.xyz, R2, texture[0], 2D;
MAD R2.xyz, R2, c[6].x, R3;
MAD R0.xyz, R0, c[4].y, R1;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R0.xyz, R1, c[6].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R0.xyz, R1, c[4].z, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].z, fragment.texcoord[0];
MAD R0.xyz, R1, c[5].x, R0;
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[5].z, R0;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
TEX R1.xyz, R3, texture[0], 2D;
MAD R0.xyz, R1, c[6].x, R0;
ADD R0.xyz, R0, R2;
MUL R1.xyz, R0, c[7].x;
MOV R0.xyz, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[1], R0;
MUL R1.xyz, R1, c[0];
TEX R0.w, fragment.texcoord[3], texture[1], 2D;
MAX R0.x, R0, c[4];
MUL R0.x, R0, R0.w;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[4].w;
MOV result.color.w, c[4].x;
END
# 68 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 50 math, 18 textures
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
Float 3 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c4, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c5, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c6, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c7, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
rcp r0.x, c1.x
mul r1.w, r0.x, c3.x
mov r1.z, c4.x
add r0.xy, v0, r1.zwzw
texld r2.xyz, r0, s0
mad r1.xy, r1.zwzw, c4.z, v0
texld r3.xyz, r1, s0
mad r4.xy, r1.zwzw, c5.w, v0
mad r1.xy, r1.zwzw, c4.w, v0
texld r0.xyz, v0, s0
mul r2.xyz, r2, c4.y
mad r2.xyz, r0, c6.x, r2
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.x, v0
mad r2.xyz, r3, c6.z, r2
texld r3.xyz, r1, s0
add r1.xy, v0, -r1.zwzw
mad r2.xyz, r3, c6.w, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.y, v0
mad r2.xyz, r3, c4.y, r2
texld r3.xyz, r1, s0
mad r1.xy, r1.zwzw, c5.z, v0
mad r2.xyz, r3, c6.y, r2
texld r3.xyz, r1, s0
rcp r0.w, c2.x
mul r1.x, r0.w, c3
mov r1.y, c4.x
mad r2.xyz, r3, c6.z, r2
add r3.xy, r1, v0
texld r4.xyz, r4, s0
texld r3.xyz, r3, s0
mad r2.xyz, r4, c6.w, r2
mul r4.xyz, r3, c4.y
mad r0.xyz, r0, c6.x, r4
mad r3.xy, r1, c4.z, v0
texld r3.xyz, r3, s0
mad r4.xy, r1, c4.w, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.x, v0
mad r0.xyz, r3, c6.z, r0
texld r3.xyz, r4, s0
add r4.xy, -r1, v0
mad r0.xyz, r3, c6.w, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.y, v0
mad r0.xyz, r3, c4.y, r0
texld r3.xyz, r4, s0
mad r4.xy, r1, c5.z, v0
mad r0.xyz, r3, c6.y, r0
texld r3.xyz, r4, s0
mad r1.xy, r1, c5.w, v0
texld r1.xyz, r1, s0
mad r0.xyz, r3, c6.z, r0
mad r0.xyz, r1, c6.w, r0
add r0.xyz, r0, r2
mul r1.xyz, r0, c7.x
mov_pp r0.xyz, v2
dp3_pp r0.x, v1, r0
mul_pp r1.xyz, r1, c0
texld r0.w, v3, s1
max_pp r0.x, r0, c4
mul_pp r0.x, r0, r0.w
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c4.z
mov_pp oC0.w, c4.x
"
}
SubProgram "d3d11 " {
// Stats: 34 math, 18 textures
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
Float 120 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddlmcfaldmichlcldoiihdjdkfpgpgjbgabaaaaaadmakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdeajaaaaeaaaaaaaenacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdomnmmemdo
mnmmemdoaaaaaaaadgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaeaeaaoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaa
bgifcaaaaaaaaaaaahaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaa
egbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaa
ipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaa
egacbaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
adaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaaaaaaaaaa
aaaaaaaipcaabaaaadaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaeaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaaaaaaaaegacbaaaaaaaaaaadcaaaaampcaabaaa
aeaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeama
egbebaaaabaaaaaadcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaa
aaaaiamaaaaaiamaaaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
aeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaa
egacbaaaaaaaaaaadgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaa
aaaaaamaaaaaeamadcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaea
aaaaaaaaaaaaaamaegagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaa
agbebaaaabaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaagaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaaaaaaaaegacbaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaaknhcddo
aknhcddoaknhcddoaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnaaaaaaaaegacbaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaafaaaaaaaceaaaaaaknhkddn
aknhkddnaknhkddnaaaaaaaaegacbaaaacaaaaaadgaaaaafbcaabaaaabaaaaaa
abeaaaaaaaaaiamadcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiama
aaaaaaaaaaaaaaaaegaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaa
pgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 8 math
 //      opengl : 8 math
 // Stats for Fragment shader:
 //       d3d11 : 1 math
 //        d3d9 : 2 math
 //      opengl : 2 math
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 8 math
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c8.w
dp3 o1.z, r0, c6
dp3 o1.y, r0, c5
dp3 o1.x, r0, c4
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 8 math
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefieceddgoflhcgfinoonoplgmdiabihpafgdafabaaaaaaneacaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaae
egiocaaaaaaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaaaaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaaaaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, tmpvar_2) * 0.2);
  blur_color_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (tmpvar_2 + tmpvar_3);
  tmpvar_7 = texture2D (_MainTex, P_8);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (tmpvar_2 + (tmpvar_3 * 2.0));
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (tmpvar_2 + (tmpvar_3 * 3.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (tmpvar_2 + (tmpvar_3 * 4.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (tmpvar_2 + (tmpvar_3 * -1.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_2 + (tmpvar_3 * -2.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (tmpvar_2 + (tmpvar_3 * -3.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_2 + (tmpvar_3 * -4.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  blur_color_5 = ((((((((blur_color_5 + (tmpvar_7 * 0.16)) + (tmpvar_9 * 0.12)) + (tmpvar_11 * 0.08)) + (tmpvar_13 * 0.04)) + (tmpvar_15 * 0.16)) + (tmpvar_17 * 0.12)) + (tmpvar_19 * 0.08)) + (tmpvar_21 * 0.04));
  highp vec4 blur_color_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = (texture2D (_MainTex, tmpvar_2) * 0.2);
  blur_color_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (tmpvar_2 + tmpvar_4);
  tmpvar_25 = texture2D (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_2 + (tmpvar_4 * 2.0));
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (tmpvar_2 + (tmpvar_4 * 3.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (tmpvar_2 + (tmpvar_4 * 4.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (tmpvar_2 + (tmpvar_4 * -1.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_2 + (tmpvar_4 * -2.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (tmpvar_2 + (tmpvar_4 * -3.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (tmpvar_2 + (tmpvar_4 * -4.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  blur_color_23 = ((((((((blur_color_23 + (tmpvar_25 * 0.16)) + (tmpvar_27 * 0.12)) + (tmpvar_29 * 0.08)) + (tmpvar_31 * 0.04)) + (tmpvar_33 * 0.16)) + (tmpvar_35 * 0.12)) + (tmpvar_37 * 0.08)) + (tmpvar_39 * 0.04));
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, tmpvar_2) * 0.2);
  blur_color_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (tmpvar_2 + tmpvar_3);
  tmpvar_7 = texture2D (_MainTex, P_8);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (tmpvar_2 + (tmpvar_3 * 2.0));
  tmpvar_9 = texture2D (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (tmpvar_2 + (tmpvar_3 * 3.0));
  tmpvar_11 = texture2D (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (tmpvar_2 + (tmpvar_3 * 4.0));
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (tmpvar_2 + (tmpvar_3 * -1.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_2 + (tmpvar_3 * -2.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (tmpvar_2 + (tmpvar_3 * -3.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_2 + (tmpvar_3 * -4.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  blur_color_5 = ((((((((blur_color_5 + (tmpvar_7 * 0.16)) + (tmpvar_9 * 0.12)) + (tmpvar_11 * 0.08)) + (tmpvar_13 * 0.04)) + (tmpvar_15 * 0.16)) + (tmpvar_17 * 0.12)) + (tmpvar_19 * 0.08)) + (tmpvar_21 * 0.04));
  highp vec4 blur_color_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = (texture2D (_MainTex, tmpvar_2) * 0.2);
  blur_color_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (tmpvar_2 + tmpvar_4);
  tmpvar_25 = texture2D (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_2 + (tmpvar_4 * 2.0));
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (tmpvar_2 + (tmpvar_4 * 3.0));
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (tmpvar_2 + (tmpvar_4 * 4.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (tmpvar_2 + (tmpvar_4 * -1.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_2 + (tmpvar_4 * -2.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (tmpvar_2 + (tmpvar_4 * -3.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (tmpvar_2 + (tmpvar_4 * -4.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  blur_color_23 = ((((((((blur_color_23 + (tmpvar_25 * 0.16)) + (tmpvar_27 * 0.12)) + (tmpvar_29 * 0.08)) + (tmpvar_31 * 0.04)) + (tmpvar_33 * 0.16)) + (tmpvar_35 * 0.12)) + (tmpvar_37 * 0.08)) + (tmpvar_39 * 0.04));
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
in lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, tmpvar_2) * 0.2);
  blur_color_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (tmpvar_2 + tmpvar_3);
  tmpvar_7 = texture (_MainTex, P_8);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (tmpvar_2 + (tmpvar_3 * 2.0));
  tmpvar_9 = texture (_MainTex, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (tmpvar_2 + (tmpvar_3 * 3.0));
  tmpvar_11 = texture (_MainTex, P_12);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (tmpvar_2 + (tmpvar_3 * 4.0));
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (tmpvar_2 + (tmpvar_3 * -1.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_2 + (tmpvar_3 * -2.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (tmpvar_2 + (tmpvar_3 * -3.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_2 + (tmpvar_3 * -4.0));
  tmpvar_21 = texture (_MainTex, P_22);
  blur_color_5 = ((((((((blur_color_5 + (tmpvar_7 * 0.16)) + (tmpvar_9 * 0.12)) + (tmpvar_11 * 0.08)) + (tmpvar_13 * 0.04)) + (tmpvar_15 * 0.16)) + (tmpvar_17 * 0.12)) + (tmpvar_19 * 0.08)) + (tmpvar_21 * 0.04));
  highp vec4 blur_color_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = (texture (_MainTex, tmpvar_2) * 0.2);
  blur_color_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (tmpvar_2 + tmpvar_4);
  tmpvar_25 = texture (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_2 + (tmpvar_4 * 2.0));
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (tmpvar_2 + (tmpvar_4 * 3.0));
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (tmpvar_2 + (tmpvar_4 * 4.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (tmpvar_2 + (tmpvar_4 * -1.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_2 + (tmpvar_4 * -2.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (tmpvar_2 + (tmpvar_4 * -3.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (tmpvar_2 + (tmpvar_4 * -4.0));
  tmpvar_39 = texture (_MainTex, P_40);
  blur_color_23 = ((((((((blur_color_23 + (tmpvar_25 * 0.16)) + (tmpvar_27 * 0.12)) + (tmpvar_29 * 0.08)) + (tmpvar_31 * 0.04)) + (tmpvar_33 * 0.16)) + (tmpvar_35 * 0.12)) + (tmpvar_37 * 0.08)) + (tmpvar_39 * 0.04));
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = 0.0;
  _glesFragData[0] = res_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 2 math
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 0, 0.5 } };
MAD result.color.xyz, fragment.texcoord[0], c[3].y, c[3].y;
MOV result.color.w, c[3].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 2 math
"ps_3_0
def c0, 0.50000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
mad_pp oC0.xyz, v0, c0.x, c0.x
mov_pp oC0.w, c0.y
"
}
SubProgram "d3d11 " {
// Stats: 1 math
"ps_4_0
eefiecedhbdiiogganilkmhhpogjlnaalcliljppabaaaaaadeabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheaaaaaa
eaaaaaaabnaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
dcaaaaaphccabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "glesdesktop " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 17 avg math (9..23)
 //        d3d9 : 19 avg math (11..28)
 //      opengl : 19 avg math (11..28)
 // Stats for Fragment shader:
 //       d3d11 : 35 avg math (32..41), 19 avg texture (18..20)
 //        d3d9 : 49 avg math (45..57), 19 avg texture (18..20)
 //      opengl : 68 avg math (63..77), 19 avg texture (18..20)
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
// Stats: 28 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[19] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 28 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 28 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c19.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c19.x
mul r0.y, r0, c8.x
add o3.xyz, r3, r2
mad o2.xy, r0.z, c9.zwzw, r0
mov o0, r1
mov o2.zw, r1
mad o1.xy, v2, c18, c18.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 64 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedhippgmepgkjikaohgkookbblfcljhlkfabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aeaeaaaaeaaaabaaababaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_50.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_50.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_51;
  lowp vec4 c_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_4 * light_3.xyz);
  c_52.xyz = tmpvar_53;
  c_52.w = tmpvar_5;
  c_2 = c_52;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_50.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_50.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_51;
  lowp vec4 c_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_4 * light_3.xyz);
  c_52.xyz = tmpvar_53;
  c_52.w = tmpvar_5;
  c_2 = c_52;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_50.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_50.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_51;
  lowp vec4 c_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_4 * light_3.xyz);
  c_52.xyz = tmpvar_53;
  c_52.w = tmpvar_5;
  c_2 = c_52;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad o2.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o2.zw, r0
mul o4.xyz, r1, c14.w
mad o1.xy, v1, c16, c16.zwzw
mad o3.xy, v2, c15, c15.zwzw
mul o4.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfbhpmajgbflmcfmgdobeepijmokhpkbgabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcomadaaaaeaaaabaa
plaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + tmpvar_9);
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_9 * 2.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_9 * 3.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_9 * 4.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_9 * -1.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_9 * -2.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + (tmpvar_9 * -3.0));
  tmpvar_25 = texture2D (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + (tmpvar_9 * -4.0));
  tmpvar_27 = texture2D (_MainTex, P_28);
  highp vec4 tmpvar_29;
  tmpvar_29 = ((((((((blur_color_11 + (tmpvar_13 * 0.16)) + (tmpvar_15 * 0.12)) + (tmpvar_17 * 0.08)) + (tmpvar_19 * 0.04)) + (tmpvar_21 * 0.16)) + (tmpvar_23 * 0.12)) + (tmpvar_25 * 0.08)) + (tmpvar_27 * 0.04));
  blur_color_11 = tmpvar_29;
  highp vec4 blur_color_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + tmpvar_10);
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_10 * 2.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_10 * 3.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_10 * 4.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_10 * -1.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_10 * -2.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (xlv_TEXCOORD0 + (tmpvar_10 * -3.0));
  tmpvar_44 = texture2D (_MainTex, P_45);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + (tmpvar_10 * -4.0));
  tmpvar_46 = texture2D (_MainTex, P_47);
  highp vec4 tmpvar_48;
  tmpvar_48 = ((((((((blur_color_30 + (tmpvar_32 * 0.16)) + (tmpvar_34 * 0.12)) + (tmpvar_36 * 0.08)) + (tmpvar_38 * 0.04)) + (tmpvar_40 * 0.16)) + (tmpvar_42 * 0.12)) + (tmpvar_44 * 0.08)) + (tmpvar_46 * 0.04));
  blur_color_30 = tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = ((tmpvar_29 + tmpvar_48) * 0.5);
  highp vec3 tmpvar_50;
  tmpvar_50 = tmpvar_49.xyz;
  tmpvar_7 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = tmpvar_49.w;
  tmpvar_8 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_53.w;
  highp float tmpvar_54;
  tmpvar_54 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_55;
  lowp vec3 tmpvar_56;
  tmpvar_56 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_56;
  light_6.xyz = (tmpvar_53.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_57;
  mediump vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_7 * light_6.xyz);
  c_57.xyz = tmpvar_58;
  c_57.w = tmpvar_8;
  c_2 = c_57;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + tmpvar_9);
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_9 * 2.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_9 * 3.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_9 * 4.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_9 * -1.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_9 * -2.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + (tmpvar_9 * -3.0));
  tmpvar_25 = texture2D (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + (tmpvar_9 * -4.0));
  tmpvar_27 = texture2D (_MainTex, P_28);
  highp vec4 tmpvar_29;
  tmpvar_29 = ((((((((blur_color_11 + (tmpvar_13 * 0.16)) + (tmpvar_15 * 0.12)) + (tmpvar_17 * 0.08)) + (tmpvar_19 * 0.04)) + (tmpvar_21 * 0.16)) + (tmpvar_23 * 0.12)) + (tmpvar_25 * 0.08)) + (tmpvar_27 * 0.04));
  blur_color_11 = tmpvar_29;
  highp vec4 blur_color_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + tmpvar_10);
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_10 * 2.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_10 * 3.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_10 * 4.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_10 * -1.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_10 * -2.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (xlv_TEXCOORD0 + (tmpvar_10 * -3.0));
  tmpvar_44 = texture2D (_MainTex, P_45);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + (tmpvar_10 * -4.0));
  tmpvar_46 = texture2D (_MainTex, P_47);
  highp vec4 tmpvar_48;
  tmpvar_48 = ((((((((blur_color_30 + (tmpvar_32 * 0.16)) + (tmpvar_34 * 0.12)) + (tmpvar_36 * 0.08)) + (tmpvar_38 * 0.04)) + (tmpvar_40 * 0.16)) + (tmpvar_42 * 0.12)) + (tmpvar_44 * 0.08)) + (tmpvar_46 * 0.04));
  blur_color_30 = tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = ((tmpvar_29 + tmpvar_48) * 0.5);
  highp vec3 tmpvar_50;
  tmpvar_50 = tmpvar_49.xyz;
  tmpvar_7 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = tmpvar_49.w;
  tmpvar_8 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_53.w;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  highp float tmpvar_56;
  tmpvar_56 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_56;
  lowp vec3 tmpvar_57;
  tmpvar_57 = ((8.0 * tmpvar_54.w) * tmpvar_54.xyz);
  lmFull_4 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = ((8.0 * tmpvar_55.w) * tmpvar_55.xyz);
  lmIndirect_3 = tmpvar_58;
  light_6.xyz = (tmpvar_53.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_59;
  mediump vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_7 * light_6.xyz);
  c_59.xyz = tmpvar_60;
  c_59.w = tmpvar_8;
  c_2 = c_59;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + tmpvar_9);
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_9 * 2.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_9 * 3.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_9 * 4.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_9 * -1.0));
  tmpvar_21 = texture (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_9 * -2.0));
  tmpvar_23 = texture (_MainTex, P_24);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + (tmpvar_9 * -3.0));
  tmpvar_25 = texture (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + (tmpvar_9 * -4.0));
  tmpvar_27 = texture (_MainTex, P_28);
  highp vec4 tmpvar_29;
  tmpvar_29 = ((((((((blur_color_11 + (tmpvar_13 * 0.16)) + (tmpvar_15 * 0.12)) + (tmpvar_17 * 0.08)) + (tmpvar_19 * 0.04)) + (tmpvar_21 * 0.16)) + (tmpvar_23 * 0.12)) + (tmpvar_25 * 0.08)) + (tmpvar_27 * 0.04));
  blur_color_11 = tmpvar_29;
  highp vec4 blur_color_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + tmpvar_10);
  tmpvar_32 = texture (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_10 * 2.0));
  tmpvar_34 = texture (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_10 * 3.0));
  tmpvar_36 = texture (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_10 * 4.0));
  tmpvar_38 = texture (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_10 * -1.0));
  tmpvar_40 = texture (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_10 * -2.0));
  tmpvar_42 = texture (_MainTex, P_43);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (xlv_TEXCOORD0 + (tmpvar_10 * -3.0));
  tmpvar_44 = texture (_MainTex, P_45);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + (tmpvar_10 * -4.0));
  tmpvar_46 = texture (_MainTex, P_47);
  highp vec4 tmpvar_48;
  tmpvar_48 = ((((((((blur_color_30 + (tmpvar_32 * 0.16)) + (tmpvar_34 * 0.12)) + (tmpvar_36 * 0.08)) + (tmpvar_38 * 0.04)) + (tmpvar_40 * 0.16)) + (tmpvar_42 * 0.12)) + (tmpvar_44 * 0.08)) + (tmpvar_46 * 0.04));
  blur_color_30 = tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = ((tmpvar_29 + tmpvar_48) * 0.5);
  highp vec3 tmpvar_50;
  tmpvar_50 = tmpvar_49.xyz;
  tmpvar_7 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = tmpvar_49.w;
  tmpvar_8 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_53.w;
  highp float tmpvar_54;
  tmpvar_54 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_55;
  lowp vec3 tmpvar_56;
  tmpvar_56 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_56;
  light_6.xyz = (tmpvar_53.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_57;
  mediump vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_7 * light_6.xyz);
  c_57.xyz = tmpvar_58;
  c_57.w = tmpvar_8;
  c_2 = c_57;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 11 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
Vector 7 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[8] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[7], c[7].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 11 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
Vector 7 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c8, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c8.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c7, c7.zwzw
mad o3.xy, v2, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 9 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedcmlgcniljfjjfohjdpeckhepfcbllckeabaaaaaajmadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
biacaaaaeaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec3 lm_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_50 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.w = 0.0;
  tmpvar_52.xyz = lm_50;
  mediump vec4 tmpvar_53;
  tmpvar_53 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_52);
  light_3 = tmpvar_53;
  lowp vec4 c_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_4 * tmpvar_53.xyz);
  c_54.xyz = tmpvar_55;
  c_54.w = tmpvar_5;
  c_2 = c_54;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  mediump vec3 lm_51;
  lowp vec3 tmpvar_52;
  tmpvar_52 = ((8.0 * tmpvar_50.w) * tmpvar_50.xyz);
  lm_51 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = lm_51;
  mediump vec4 tmpvar_54;
  tmpvar_54 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_53);
  light_3 = tmpvar_54;
  lowp vec4 c_55;
  mediump vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_4 * tmpvar_54.xyz);
  c_55.xyz = tmpvar_56;
  c_55.w = tmpvar_5;
  c_2 = c_55;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec3 lm_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_50 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.w = 0.0;
  tmpvar_52.xyz = lm_50;
  mediump vec4 tmpvar_53;
  tmpvar_53 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_52);
  light_3 = tmpvar_53;
  lowp vec4 c_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_4 * tmpvar_53.xyz);
  c_54.xyz = tmpvar_55;
  c_54.w = tmpvar_5;
  c_2 = c_54;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 28 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[19] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 28 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 28 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c19.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c19.x
mul r0.y, r0, c8.x
add o3.xyz, r3, r2
mad o2.xy, r0.z, c9.zwzw, r0
mov o0, r1
mov o2.zw, r1
mad o1.xy, v2, c18, c18.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 23 math
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 64 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedhippgmepgkjikaohgkookbblfcljhlkfabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aeaeaaaaeaaaabaaababaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_50.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_50.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_51;
  lowp vec4 c_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_4 * light_3.xyz);
  c_52.xyz = tmpvar_53;
  c_52.w = tmpvar_5;
  c_2 = c_52;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_50.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_50.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_51;
  lowp vec4 c_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_4 * light_3.xyz);
  c_52.xyz = tmpvar_53;
  c_52.w = tmpvar_5;
  c_2 = c_52;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_50.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_50.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_51;
  lowp vec4 c_52;
  mediump vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_4 * light_3.xyz);
  c_52.xyz = tmpvar_53;
  c_52.w = tmpvar_5;
  c_2 = c_52;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad o2.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o2.zw, r0
mul o4.xyz, r1, c14.w
mad o1.xy, v1, c16, c16.zwzw
mad o3.xy, v2, c15, c15.zwzw
mul o4.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfbhpmajgbflmcfmgdobeepijmokhpkbgabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcomadaaaaeaaaabaa
plaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + tmpvar_9);
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_9 * 2.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_9 * 3.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_9 * 4.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_9 * -1.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_9 * -2.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + (tmpvar_9 * -3.0));
  tmpvar_25 = texture2D (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + (tmpvar_9 * -4.0));
  tmpvar_27 = texture2D (_MainTex, P_28);
  highp vec4 tmpvar_29;
  tmpvar_29 = ((((((((blur_color_11 + (tmpvar_13 * 0.16)) + (tmpvar_15 * 0.12)) + (tmpvar_17 * 0.08)) + (tmpvar_19 * 0.04)) + (tmpvar_21 * 0.16)) + (tmpvar_23 * 0.12)) + (tmpvar_25 * 0.08)) + (tmpvar_27 * 0.04));
  blur_color_11 = tmpvar_29;
  highp vec4 blur_color_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + tmpvar_10);
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_10 * 2.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_10 * 3.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_10 * 4.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_10 * -1.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_10 * -2.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (xlv_TEXCOORD0 + (tmpvar_10 * -3.0));
  tmpvar_44 = texture2D (_MainTex, P_45);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + (tmpvar_10 * -4.0));
  tmpvar_46 = texture2D (_MainTex, P_47);
  highp vec4 tmpvar_48;
  tmpvar_48 = ((((((((blur_color_30 + (tmpvar_32 * 0.16)) + (tmpvar_34 * 0.12)) + (tmpvar_36 * 0.08)) + (tmpvar_38 * 0.04)) + (tmpvar_40 * 0.16)) + (tmpvar_42 * 0.12)) + (tmpvar_44 * 0.08)) + (tmpvar_46 * 0.04));
  blur_color_30 = tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = ((tmpvar_29 + tmpvar_48) * 0.5);
  highp vec3 tmpvar_50;
  tmpvar_50 = tmpvar_49.xyz;
  tmpvar_7 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = tmpvar_49.w;
  tmpvar_8 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_53.w;
  highp float tmpvar_54;
  tmpvar_54 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_55;
  lowp vec3 tmpvar_56;
  tmpvar_56 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_56;
  light_6.xyz = (tmpvar_53.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_57;
  mediump vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_7 * light_6.xyz);
  c_57.xyz = tmpvar_58;
  c_57.w = tmpvar_8;
  c_2 = c_57;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + tmpvar_9);
  tmpvar_13 = texture2D (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_9 * 2.0));
  tmpvar_15 = texture2D (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_9 * 3.0));
  tmpvar_17 = texture2D (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_9 * 4.0));
  tmpvar_19 = texture2D (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_9 * -1.0));
  tmpvar_21 = texture2D (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_9 * -2.0));
  tmpvar_23 = texture2D (_MainTex, P_24);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + (tmpvar_9 * -3.0));
  tmpvar_25 = texture2D (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + (tmpvar_9 * -4.0));
  tmpvar_27 = texture2D (_MainTex, P_28);
  highp vec4 tmpvar_29;
  tmpvar_29 = ((((((((blur_color_11 + (tmpvar_13 * 0.16)) + (tmpvar_15 * 0.12)) + (tmpvar_17 * 0.08)) + (tmpvar_19 * 0.04)) + (tmpvar_21 * 0.16)) + (tmpvar_23 * 0.12)) + (tmpvar_25 * 0.08)) + (tmpvar_27 * 0.04));
  blur_color_11 = tmpvar_29;
  highp vec4 blur_color_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + tmpvar_10);
  tmpvar_32 = texture2D (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_10 * 2.0));
  tmpvar_34 = texture2D (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_10 * 3.0));
  tmpvar_36 = texture2D (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_10 * 4.0));
  tmpvar_38 = texture2D (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_10 * -1.0));
  tmpvar_40 = texture2D (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_10 * -2.0));
  tmpvar_42 = texture2D (_MainTex, P_43);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (xlv_TEXCOORD0 + (tmpvar_10 * -3.0));
  tmpvar_44 = texture2D (_MainTex, P_45);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + (tmpvar_10 * -4.0));
  tmpvar_46 = texture2D (_MainTex, P_47);
  highp vec4 tmpvar_48;
  tmpvar_48 = ((((((((blur_color_30 + (tmpvar_32 * 0.16)) + (tmpvar_34 * 0.12)) + (tmpvar_36 * 0.08)) + (tmpvar_38 * 0.04)) + (tmpvar_40 * 0.16)) + (tmpvar_42 * 0.12)) + (tmpvar_44 * 0.08)) + (tmpvar_46 * 0.04));
  blur_color_30 = tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = ((tmpvar_29 + tmpvar_48) * 0.5);
  highp vec3 tmpvar_50;
  tmpvar_50 = tmpvar_49.xyz;
  tmpvar_7 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = tmpvar_49.w;
  tmpvar_8 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_53.w;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  highp float tmpvar_56;
  tmpvar_56 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_56;
  lowp vec3 tmpvar_57;
  tmpvar_57 = ((8.0 * tmpvar_54.w) * tmpvar_54.xyz);
  lmFull_4 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = ((8.0 * tmpvar_55.w) * tmpvar_55.xyz);
  lmIndirect_3 = tmpvar_58;
  light_6.xyz = (tmpvar_53.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_59;
  mediump vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_7 * light_6.xyz);
  c_59.xyz = tmpvar_60;
  c_59.w = tmpvar_8;
  c_2 = c_59;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (xlv_TEXCOORD0 + tmpvar_9);
  tmpvar_13 = texture (_MainTex, P_14);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + (tmpvar_9 * 2.0));
  tmpvar_15 = texture (_MainTex, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 + (tmpvar_9 * 3.0));
  tmpvar_17 = texture (_MainTex, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 + (tmpvar_9 * 4.0));
  tmpvar_19 = texture (_MainTex, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + (tmpvar_9 * -1.0));
  tmpvar_21 = texture (_MainTex, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + (tmpvar_9 * -2.0));
  tmpvar_23 = texture (_MainTex, P_24);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + (tmpvar_9 * -3.0));
  tmpvar_25 = texture (_MainTex, P_26);
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + (tmpvar_9 * -4.0));
  tmpvar_27 = texture (_MainTex, P_28);
  highp vec4 tmpvar_29;
  tmpvar_29 = ((((((((blur_color_11 + (tmpvar_13 * 0.16)) + (tmpvar_15 * 0.12)) + (tmpvar_17 * 0.08)) + (tmpvar_19 * 0.04)) + (tmpvar_21 * 0.16)) + (tmpvar_23 * 0.12)) + (tmpvar_25 * 0.08)) + (tmpvar_27 * 0.04));
  blur_color_11 = tmpvar_29;
  highp vec4 blur_color_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (xlv_TEXCOORD0 + tmpvar_10);
  tmpvar_32 = texture (_MainTex, P_33);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (xlv_TEXCOORD0 + (tmpvar_10 * 2.0));
  tmpvar_34 = texture (_MainTex, P_35);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (xlv_TEXCOORD0 + (tmpvar_10 * 3.0));
  tmpvar_36 = texture (_MainTex, P_37);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (xlv_TEXCOORD0 + (tmpvar_10 * 4.0));
  tmpvar_38 = texture (_MainTex, P_39);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD0 + (tmpvar_10 * -1.0));
  tmpvar_40 = texture (_MainTex, P_41);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = (xlv_TEXCOORD0 + (tmpvar_10 * -2.0));
  tmpvar_42 = texture (_MainTex, P_43);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (xlv_TEXCOORD0 + (tmpvar_10 * -3.0));
  tmpvar_44 = texture (_MainTex, P_45);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + (tmpvar_10 * -4.0));
  tmpvar_46 = texture (_MainTex, P_47);
  highp vec4 tmpvar_48;
  tmpvar_48 = ((((((((blur_color_30 + (tmpvar_32 * 0.16)) + (tmpvar_34 * 0.12)) + (tmpvar_36 * 0.08)) + (tmpvar_38 * 0.04)) + (tmpvar_40 * 0.16)) + (tmpvar_42 * 0.12)) + (tmpvar_44 * 0.08)) + (tmpvar_46 * 0.04));
  blur_color_30 = tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = ((tmpvar_29 + tmpvar_48) * 0.5);
  highp vec3 tmpvar_50;
  tmpvar_50 = tmpvar_49.xyz;
  tmpvar_7 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = tmpvar_49.w;
  tmpvar_8 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_53.w;
  highp float tmpvar_54;
  tmpvar_54 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_55;
  lowp vec3 tmpvar_56;
  tmpvar_56 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_56;
  light_6.xyz = (tmpvar_53.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_57;
  mediump vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_7 * light_6.xyz);
  c_57.xyz = tmpvar_58;
  c_57.w = tmpvar_8;
  c_2 = c_57;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 11 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
Vector 7 [_MainTex_ST]
"3.0-!!ARBvp1.0
PARAM c[8] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[7], c[7].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 11 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
Vector 7 [_MainTex_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c8, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c8.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c7, c7.zwzw
mad o3.xy, v2, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 9 math
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedcmlgcniljfjjfohjdpeckhepfcbllckeabaaaaaajmadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
biacaaaaeaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec3 lm_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_50 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.w = 0.0;
  tmpvar_52.xyz = lm_50;
  mediump vec4 tmpvar_53;
  tmpvar_53 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_52);
  light_3 = tmpvar_53;
  lowp vec4 c_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_4 * tmpvar_53.xyz);
  c_54.xyz = tmpvar_55;
  c_54.w = tmpvar_5;
  c_2 = c_54;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture2D (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture2D (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture2D (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture2D (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture2D (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture2D (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture2D (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture2D (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture2D (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture2D (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture2D (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture2D (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture2D (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture2D (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture2D (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture2D (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture2D (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  mediump vec3 lm_51;
  lowp vec3 tmpvar_52;
  tmpvar_52 = ((8.0 * tmpvar_50.w) * tmpvar_50.xyz);
  lm_51 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = lm_51;
  mediump vec4 tmpvar_54;
  tmpvar_54 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_53);
  light_3 = tmpvar_54;
  lowp vec4 c_55;
  mediump vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_4 * tmpvar_54.xyz);
  c_55.xyz = tmpvar_56;
  c_55.w = tmpvar_5;
  c_2 = c_55;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _TexWidth;
uniform highp float _TexHeight;
uniform highp float _GlowSize;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (_GlowSize / _TexHeight);
  highp vec2 tmpvar_7;
  tmpvar_7.x = 0.0;
  tmpvar_7.y = (_GlowSize / _TexWidth);
  highp vec4 blur_color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + tmpvar_6);
  tmpvar_10 = texture (_MainTex, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (tmpvar_6 * 2.0));
  tmpvar_12 = texture (_MainTex, P_13);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + (tmpvar_6 * 3.0));
  tmpvar_14 = texture (_MainTex, P_15);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 + (tmpvar_6 * 4.0));
  tmpvar_16 = texture (_MainTex, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + (tmpvar_6 * -1.0));
  tmpvar_18 = texture (_MainTex, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + (tmpvar_6 * -2.0));
  tmpvar_20 = texture (_MainTex, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 + (tmpvar_6 * -3.0));
  tmpvar_22 = texture (_MainTex, P_23);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + (tmpvar_6 * -4.0));
  tmpvar_24 = texture (_MainTex, P_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = ((((((((blur_color_8 + (tmpvar_10 * 0.16)) + (tmpvar_12 * 0.12)) + (tmpvar_14 * 0.08)) + (tmpvar_16 * 0.04)) + (tmpvar_18 * 0.16)) + (tmpvar_20 * 0.12)) + (tmpvar_22 * 0.08)) + (tmpvar_24 * 0.04));
  blur_color_8 = tmpvar_26;
  highp vec4 blur_color_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = (texture (_MainTex, xlv_TEXCOORD0) * 0.2);
  blur_color_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (xlv_TEXCOORD0 + tmpvar_7);
  tmpvar_29 = texture (_MainTex, P_30);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (xlv_TEXCOORD0 + (tmpvar_7 * 2.0));
  tmpvar_31 = texture (_MainTex, P_32);
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = (xlv_TEXCOORD0 + (tmpvar_7 * 3.0));
  tmpvar_33 = texture (_MainTex, P_34);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (xlv_TEXCOORD0 + (tmpvar_7 * 4.0));
  tmpvar_35 = texture (_MainTex, P_36);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (xlv_TEXCOORD0 + (tmpvar_7 * -1.0));
  tmpvar_37 = texture (_MainTex, P_38);
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = (xlv_TEXCOORD0 + (tmpvar_7 * -2.0));
  tmpvar_39 = texture (_MainTex, P_40);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (tmpvar_7 * -3.0));
  tmpvar_41 = texture (_MainTex, P_42);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (tmpvar_7 * -4.0));
  tmpvar_43 = texture (_MainTex, P_44);
  highp vec4 tmpvar_45;
  tmpvar_45 = ((((((((blur_color_27 + (tmpvar_29 * 0.16)) + (tmpvar_31 * 0.12)) + (tmpvar_33 * 0.08)) + (tmpvar_35 * 0.04)) + (tmpvar_37 * 0.16)) + (tmpvar_39 * 0.12)) + (tmpvar_41 * 0.08)) + (tmpvar_43 * 0.04));
  blur_color_27 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = ((tmpvar_26 + tmpvar_45) * 0.5);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_46.xyz;
  tmpvar_4 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = tmpvar_46.w;
  tmpvar_5 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_49;
  mediump vec3 lm_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_50 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.w = 0.0;
  tmpvar_52.xyz = lm_50;
  mediump vec4 tmpvar_53;
  tmpvar_53 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_52);
  light_3 = tmpvar_53;
  lowp vec4 c_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_4 * tmpvar_53.xyz);
  c_54.xyz = tmpvar_55;
  c_54.w = tmpvar_5;
  c_2 = c_54;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 66 math, 18 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[3].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[3];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[5].x, R3;
MUL R1, R1, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R1, R0, c[3].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[3].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[4].z, R1;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[5].x, R1;
ADD R1, R0, R2;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R1, R1, c[6].x;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[2];
MOV result.color.w, R1;
MUL result.color.xyz, R1, R0;
END
# 66 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 48 math, 18 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c3.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c3.x
texld r0, v0, s0
mul r1, r1, c3.y
mad r2, r0, c5.x, r1
mad r3.xy, r4.zwzw, c3.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r2, r1, c5.y, r2
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3, r1, c5.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c4.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c5.w, r3
mul r1, r1, c3.y
mad r3.xy, r4, c3.z, v0
mad r1, r0, c5.x, r1
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c5.w, r1
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r1, r0, c3.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.z, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r1, r0, c5.z, r1
mad r3.xy, r4, c4.w, v0
texld r0, r3, s0
mad r0, r0, c5.w, r1
add r1, r0, r2
texldp r0.xyz, v1, s1
mul r1, r1, c6.x
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, v2
mov_pp oC0.w, r1
mul_pp oC0.xyz, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 33 math, 18 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmdamfmlhgbipeeianphiholmokajlffdabaaaaaapeajaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaeajaaaaeaaaaaaaebacaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdo
mnmmemdodgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaeaeaaoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaa
aaaaaaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaa
aceaaaaaaknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdn
ipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaa
aaaaaaaadcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaai
pcaabaaaadaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddo
aknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
igaibaaaabaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaa
abaaaaaadcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiama
aaaaiamaaaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdn
ipmcpfdnegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaa
aceaaaaaaknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddn
aknhkddnaknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaaeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
aaaaaaaadgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaama
aaaaeamadcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaa
aaaaaamaegagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaa
agaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaa
aaaaiamadcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaa
aaaaaaaaegaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddn
egaobaaaacaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaadpaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaadaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 77 math, 20 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[4].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[4];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[4].z;
MAD R2, R0, c[4].x, R1;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
MAD R2, R1, c[5].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[6].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[6].y, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[5].x, R2;
MAD R3.xy, R4.zwzw, c[6].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[5].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[6].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[6].x, R3;
MUL R1, R1, c[4].z;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R1, R0, c[5].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[6].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].z, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[5].z, R1;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[6].x, R1;
ADD R0, R0, R2;
MUL R2, R0, c[7].x;
TEX R0, fragment.texcoord[2], texture[3], 2D;
MUL R0.xyz, R0.w, R0;
TEX R1, fragment.texcoord[2], texture[2], 2D;
DP4 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, c[7].y;
MAD R3.xyz, R1, c[7].y, -R0;
TXP R1.xyz, fragment.texcoord[1], texture[1], 2D;
MAD_SAT R0.w, R0, c[3].z, c[3];
MAD R0.xyz, R0.w, R3, R0;
LG2 R1.x, R1.x;
LG2 R1.y, R1.y;
LG2 R1.z, R1.z;
ADD R0.xyz, -R1, R0;
MOV result.color.w, R2;
MUL result.color.xyz, R2, R0;
END
# 77 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 57 math, 20 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c5, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c6, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c7, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c4.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c4.x
texld r0, v0, s0
mul r1, r1, c4.y
mad r2, r0, c6.x, r1
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.w, v0
mad r2, r1, c6.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c5.x, v0
mad r2, r1, c6.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c6.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c5.y, v0
mad r2, r1, c4.y, r2
texld r1, r3, s0
mad r2, r1, c6.y, r2
mad r3.xy, r4.zwzw, c5.z, v0
texld r1, r3, s0
mad r3, r1, c6.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c5.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c6.w, r3
mul r1, r1, c4.y
mad r3.xy, r4, c4.z, v0
mad r1, r0, c6.x, r1
texld r0, r3, s0
mad r3.xy, r4, c4.w, v0
mad r1, r0, c6.y, r1
texld r0, r3, s0
mad r3.xy, r4, c5.x, v0
mad r1, r0, c6.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c6.w, r1
texld r0, r3, s0
mad r3.xy, r4, c5.y, v0
mad r1, r0, c4.y, r1
texld r0, r3, s0
mad r3.xy, r4, c5.z, v0
mad r1, r0, c6.y, r1
texld r0, r3, s0
mad r1, r0, c6.z, r1
mad r3.xy, r4, c5.w, v0
texld r0, r3, s0
mad r0, r0, c6.w, r1
add r0, r0, r2
mul r2, r0, c7.x
texld r0, v2, s2
mul_pp r0.xyz, r0.w, r0
texld r1, v2, s3
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c7.y
mad_pp r3.xyz, r0, c7.y, -r1
texldp r0.xyz, v1, s1
dp4 r0.w, v3, v3
rsq r0.w, r0.w
rcp r0.w, r0.w
mad_sat r0.w, r0, c3.z, c3
mad_pp r1.xyz, r0.w, r3, r1
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r0.xyz, -r0, r1
mov_pp oC0.w, r2
mul_pp oC0.xyz, r2, r0
"
}
SubProgram "d3d11 " {
// Stats: 41 math, 20 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
Vector 96 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedckcmhoggfnehmehalkdcdhmgoikjndpbabaaaaaajealaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcimakaaaaeaaaaaaakdacaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaaaaaaaaaa
adaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpbbaaaaahbcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaa
adaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaalbcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaagaaaaaadkiacaaaaaaaaaaa
agaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaajgahbaia
ebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 68 math, 19 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[3].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[3];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[5].x, R3;
MUL R1, R1, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R1, R0, c[3].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[3].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[4].z, R1;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[5].x, R1;
ADD R0, R0, R2;
TXP R2.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R1, R0, c[6].x;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0.w, R0;
LG2 R2.x, R2.x;
LG2 R2.z, R2.z;
LG2 R2.y, R2.y;
MAD R0.xyz, R0, c[6].y, -R2;
MOV result.color.w, R1;
MUL result.color.xyz, R1, R0;
END
# 68 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 49 math, 19 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c3.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c3.x
texld r0, v0, s0
mul r1, r1, c3.y
mad r2, r0, c5.x, r1
mad r3.xy, r4.zwzw, c3.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r2, r1, c5.y, r2
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3, r1, c5.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c4.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c5.w, r3
mul r1, r1, c3.y
mad r3.xy, r4, c3.z, v0
mad r1, r0, c5.x, r1
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c5.w, r1
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r1, r0, c3.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.z, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r1, r0, c5.z, r1
mad r3.xy, r4, c4.w, v0
texld r0, r3, s0
mad r0, r0, c5.w, r1
add r0, r0, r2
texldp r2.xyz, v1, s1
mul r1, r0, c6.x
texld r0, v2, s2
mul_pp r0.xyz, r0.w, r0
log_pp r2.x, r2.x
log_pp r2.z, r2.z
log_pp r2.y, r2.y
mad_pp r0.xyz, r0, c6.y, -r2
mov_pp oC0.w, r1
mul_pp oC0.xyz, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 34 math, 19 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecediljiagghehgfjindbjknablgklhocmkhabaaaaaafiakaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgiajaaaaeaaaaaaafkacaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaaaaaaaaaa
adaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaak
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 63 math, 18 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[3].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[3];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[5].x, R3;
MUL R1, R1, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R1, R0, c[3].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[3].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[4].z, R1;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[5].x, R1;
ADD R1, R0, R2;
MUL R1, R1, c[6].x;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
ADD R0.xyz, R0, fragment.texcoord[2];
MOV result.color.w, R1;
MUL result.color.xyz, R1, R0;
END
# 63 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 45 math, 18 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c3.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c3.x
texld r0, v0, s0
mul r1, r1, c3.y
mad r2, r0, c5.x, r1
mad r3.xy, r4.zwzw, c3.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r2, r1, c5.y, r2
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3, r1, c5.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c4.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c5.w, r3
mul r1, r1, c3.y
mad r3.xy, r4, c3.z, v0
mad r1, r0, c5.x, r1
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c5.w, r1
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r1, r0, c3.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.z, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r1, r0, c5.z, r1
mad r3.xy, r4, c4.w, v0
texld r0, r3, s0
mad r0, r0, c5.w, r1
add r1, r0, r2
mul r1, r1, c6.x
texldp r0.xyz, v1, s1
add_pp r0.xyz, r0, v2
mov_pp oC0.w, r1
mul_pp oC0.xyz, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 32 math, 18 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedengllochhgaeginmikdfkjhbmbgefgcfabaaaaaanmajaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcomaiaaaaeaaaaaaadlacaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdo
mnmmemdodgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaeaeaaoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaa
aaaaaaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaa
aceaaaaaaknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdn
ipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaaeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaa
aaaaaaaadcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaai
pcaabaaaadaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddo
aknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
igaibaaaabaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaa
abaaaaaadcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiama
aaaaiamaaaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdn
ipmcpfdnegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaa
aceaaaaaaknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddn
aknhkddnaknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaaeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
aaaaaaaadgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaama
aaaaeamadcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaa
aaaaaamaegagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaa
agaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaa
aaaaiamadcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaa
aaaaaaaaegaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddn
egaobaaaacaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaadpaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egbcbaaaadaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 74 math, 20 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[4].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[4];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[4].z;
MAD R2, R0, c[4].x, R1;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
MAD R2, R1, c[5].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[6].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[6].y, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[5].x, R2;
MAD R3.xy, R4.zwzw, c[6].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[5].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[6].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[6].x, R3;
MUL R1, R1, c[4].z;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
MAD R1, R0, c[5].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[6].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].y, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[6].z, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[5].z, R1;
MAD R3.xy, R4, c[6].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[6].x, R1;
ADD R1, R0, R2;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MUL R1, R1, c[7].x;
MUL R2.xyz, R0.w, R0;
TEX R0, fragment.texcoord[2], texture[3], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[7].y;
DP4 R2.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R2.w;
RCP R0.w, R0.w;
MAD R2.xyz, R2, c[7].y, -R0;
MAD_SAT R0.w, R0, c[3].z, c[3];
MAD R2.xyz, R0.w, R2, R0;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
ADD R0.xyz, R0, R2;
MOV result.color.w, R1;
MUL result.color.xyz, R1, R0;
END
# 74 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 54 math, 20 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c5, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c6, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c7, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c4.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c4.x
texld r0, v0, s0
mul r1, r1, c4.y
mad r2, r0, c6.x, r1
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.w, v0
mad r2, r1, c6.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c5.x, v0
mad r2, r1, c6.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c6.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c5.y, v0
mad r2, r1, c4.y, r2
texld r1, r3, s0
mad r2, r1, c6.y, r2
mad r3.xy, r4.zwzw, c5.z, v0
texld r1, r3, s0
mad r3, r1, c6.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c5.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c6.w, r3
mul r1, r1, c4.y
mad r3.xy, r4, c4.z, v0
mad r1, r0, c6.x, r1
texld r0, r3, s0
mad r3.xy, r4, c4.w, v0
mad r1, r0, c6.y, r1
texld r0, r3, s0
mad r3.xy, r4, c5.x, v0
mad r1, r0, c6.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c6.w, r1
texld r0, r3, s0
mad r3.xy, r4, c5.y, v0
mad r1, r0, c4.y, r1
texld r0, r3, s0
mad r3.xy, r4, c5.z, v0
mad r1, r0, c6.y, r1
texld r0, r3, s0
mad r1, r0, c6.z, r1
mad r3.xy, r4, c5.w, v0
texld r0, r3, s0
mad r0, r0, c6.w, r1
add r1, r0, r2
texld r0, v2, s2
mul r1, r1, c7.x
mul_pp r2.xyz, r0.w, r0
texld r0, v2, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c7.y
dp4 r2.w, v3, v3
rsq r0.w, r2.w
rcp r0.w, r0.w
mad_pp r2.xyz, r2, c7.y, -r0
mad_sat r0.w, r0, c3.z, c3
mad_pp r2.xyz, r0.w, r2, r0
texldp r0.xyz, v1, s1
add_pp r0.xyz, r0, r2
mov_pp oC0.w, r1
mul_pp oC0.xyz, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 40 math, 20 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
Vector 96 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedglmgcfhmlmefkabgkkgllbnngkigkcmpabaaaaaahmalaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcheakaaaaeaaaaaaajnacaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaaaaaaaaaa
adaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpbbaaaaahbcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaa
adaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaalbcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaagaaaaaadkiacaaaaaaaaaaa
agaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaajgahbaia
ebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 65 math, 19 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 0.2, 0, 0.16, 2 },
		{ 0.12, 3, 0.079999998, 4 },
		{ 0.039999999, -2, -3, -4 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, c[0].x;
MUL R4.w, R0.x, c[2].x;
MOV R4.z, c[3].y;
ADD R0.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R0, texture[0], 2D;
MOV R4.y, c[3];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[3].z;
MAD R2, R0, c[3].x, R1;
MAD R3.xy, R4.zwzw, c[3].w, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].y, fragment.texcoord[0];
MAD R2, R1, c[4].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[4].w, fragment.texcoord[0];
MAD R2, R1, c[4].z, R2;
TEX R1, R3, texture[0], 2D;
ADD R3.xy, fragment.texcoord[0], -R4.zwzw;
MAD R2, R1, c[5].x, R2;
TEX R1, R3, texture[0], 2D;
MAD R3.xy, R4.zwzw, c[5].y, fragment.texcoord[0];
MAD R2, R1, c[3].z, R2;
TEX R1, R3, texture[0], 2D;
MAD R2, R1, c[4].x, R2;
MAD R3.xy, R4.zwzw, c[5].z, fragment.texcoord[0];
TEX R1, R3, texture[0], 2D;
MAD R3, R1, c[4].z, R2;
RCP R1.x, c[1].x;
MUL R4.x, R1, c[2];
ADD R1.xy, R4, fragment.texcoord[0];
MAD R2.xy, R4.zwzw, c[5].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MAD R2, R2, c[5].x, R3;
MUL R1, R1, c[3].z;
MAD R3.xy, R4, c[3].w, fragment.texcoord[0];
MAD R1, R0, c[3].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].y, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[4].w, fragment.texcoord[0];
MAD R1, R0, c[4].z, R1;
TEX R0, R3, texture[0], 2D;
ADD R3.xy, -R4, fragment.texcoord[0];
MAD R1, R0, c[5].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].y, fragment.texcoord[0];
MAD R1, R0, c[3].z, R1;
TEX R0, R3, texture[0], 2D;
MAD R3.xy, R4, c[5].z, fragment.texcoord[0];
MAD R1, R0, c[4].x, R1;
TEX R0, R3, texture[0], 2D;
MAD R1, R0, c[4].z, R1;
MAD R3.xy, R4, c[5].w, fragment.texcoord[0];
TEX R0, R3, texture[0], 2D;
MAD R0, R0, c[5].x, R1;
ADD R0, R0, R2;
MUL R1, R0, c[6].x;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R2.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R0.xyz, R0.w, R0;
MAD R0.xyz, R0, c[6].y, R2;
MOV result.color.w, R1;
MUL result.color.xyz, R1, R0;
END
# 65 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 46 math, 19 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Float 2 [_GlowSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.00000000, 0.16000000, 2.00000000, 3.00000000
def c4, 4.00000000, -2.00000000, -3.00000000, -4.00000000
def c5, 0.20000000, 0.12000000, 0.08000000, 0.04000000
def c6, 0.50000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
rcp r0.x, c0.x
mul r4.w, r0.x, c2.x
mov r4.z, c3.x
add r0.xy, v0, r4.zwzw
texld r1, r0, s0
mov r4.y, c3.x
texld r0, v0, s0
mul r1, r1, c3.y
mad r2, r0, c5.x, r1
mad r3.xy, r4.zwzw, c3.z, v0
texld r1, r3, s0
mad r3.xy, r4.zwzw, c3.w, v0
mad r2, r1, c5.y, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.x, v0
mad r2, r1, c5.z, r2
texld r1, r3, s0
add r3.xy, v0, -r4.zwzw
mad r2, r1, c5.w, r2
texld r1, r3, s0
mad r3.xy, r4.zwzw, c4.y, v0
mad r2, r1, c3.y, r2
texld r1, r3, s0
mad r2, r1, c5.y, r2
mad r3.xy, r4.zwzw, c4.z, v0
texld r1, r3, s0
mad r3, r1, c5.z, r2
rcp r1.x, c1.x
mul r4.x, r1, c2
add r1.xy, r4, v0
mad r2.xy, r4.zwzw, c4.w, v0
texld r1, r1, s0
texld r2, r2, s0
mad r2, r2, c5.w, r3
mul r1, r1, c3.y
mad r3.xy, r4, c3.z, v0
mad r1, r0, c5.x, r1
texld r0, r3, s0
mad r3.xy, r4, c3.w, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.x, v0
mad r1, r0, c5.z, r1
texld r0, r3, s0
add r3.xy, -r4, v0
mad r1, r0, c5.w, r1
texld r0, r3, s0
mad r3.xy, r4, c4.y, v0
mad r1, r0, c3.y, r1
texld r0, r3, s0
mad r3.xy, r4, c4.z, v0
mad r1, r0, c5.y, r1
texld r0, r3, s0
mad r1, r0, c5.z, r1
mad r3.xy, r4, c4.w, v0
texld r0, r3, s0
mad r0, r0, c5.w, r1
add r0, r0, r2
mul r1, r0, c6.x
texld r0, v2, s2
texldp r2.xyz, v1, s1
mul_pp r0.xyz, r0.w, r0
mad_pp r0.xyz, r0, c6.y, r2
mov_pp oC0.w, r1
mul_pp oC0.xyz, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 33 math, 19 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Float 56 [_GlowSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecednjakdbnnllggmnnmicalecceocbgokgeabaaaaaaeaakaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaajaaaaeaaaaaaafeacaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdo
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaea
aoaaaaajdcaabaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaabgifcaaaaaaaaaaa
adaaaaaaaaaaaaahpcaabaaaacaaaaaaigagbaaaabaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aknhcddoaknhcddoaknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddoaknhcddo
egaobaaaaaaaaaaadcaaaaampcaabaaaadaaaaaaigagbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaipmcpfdnipmcpfdn
ipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaaaaaaaaa
dcaaaaampcaabaaaadaaaaaaigaibaaaabaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaiaeaaaaaiaeaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddnaknhkddn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
aknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaaaaaaaaaipcaabaaa
adaaaaaaigagbaiaebaaaaaaabaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaaaknhcddoaknhcddo
aknhcddoaknhcddoegaobaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaigaibaaa
abaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaampcaabaaaafaaaaaaigahbaaaabaaaaaaaceaaaaaaaaaiamaaaaaiama
aaaaaaaaaaaaeaeaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaagaaaaaaaceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdn
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaaaceaaaaa
aknhkddnaknhkddnaknhkddnaknhkddnegaobaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddn
aknhkddnaknhkddnegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
aeaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaaaaaaaaa
dgaaaaaincaabaaaabaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaaamaaaaaeama
dcaaaaampcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaama
egagbaaaabaaaaaaegbebaaaabaaaaaadcaaaaammcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaeamapgahbaaaabaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaagaaaaaa
aceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaadaaaaaaaceaaaaaaknhcddoaknhcddoaknhcddo
aknhcddoegaobaaaacaaaaaadcaaaaampcaabaaaacaaaaaaegaobaaaaeaaaaaa
aceaaaaaipmcpfdnipmcpfdnipmcpfdnipmcpfdnegaobaaaacaaaaaadcaaaaam
pcaabaaaacaaaaaaegaobaaaafaaaaaaaceaaaaaaknhkddnaknhkddnaknhkddn
aknhkddnegaobaaaacaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaiama
dcaaaaamdcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiamaaaaaaaaaaaaaaaaa
egaabaaaabaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaadpaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
}
 }
}
Fallback "Diffuse"
}