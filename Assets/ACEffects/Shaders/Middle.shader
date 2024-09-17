// Compiled shader for all platforms, uncompressed size: 541.1KB

Shader "ACEffects/Shaders/Middle" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TexWidth ("Texture Width", Float) = 128
 _TexHeight ("Texture Height", Float) = 128
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 20 avg math (6..47)
 //        d3d9 : 26 avg math (6..63)
 //      opengl : 26 avg math (6..63)
 // Stats for Fragment shader:
 //       d3d11 : 16 avg math (13..19), 2 avg texture (1..3), 2 branch
 //        d3d9 : 33 avg math (31..36), 6 avg texture (5..7), 5 branch
 //      opengl : 129 avg math (126..132), 26 avg texture (25..27)
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  c_1.xyz = (tmpvar_2 * ((8.0 * tmpvar_28.w) * tmpvar_28.xyz));
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
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  mediump vec3 lm_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_28 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_2 * lm_28);
  c_1.xyz = tmpvar_30;
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_28.w) * tmpvar_28.xyz);
  lm_29 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_2 * lm_29);
  c_1.xyz = tmpvar_31;
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
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  mediump vec3 lm_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_28 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_2 * lm_28);
  c_1.xyz = tmpvar_30;
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  lowp vec4 c_34;
  c_34.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_28) * 2.0));
  c_34.w = tmpvar_3;
  c_1.w = c_34.w;
  c_1.xyz = (c_34.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = textureProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  lowp vec4 c_34;
  c_34.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_28) * 2.0));
  c_34.w = tmpvar_3;
  c_1.w = c_34.w;
  c_1.xyz = (c_34.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((tmpvar_28 * 2.0))));
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_29.w) * tmpvar_29.xyz);
  c_1.xyz = (tmpvar_2 * max (min (tmpvar_30, ((tmpvar_28.x * 2.0) * tmpvar_29.xyz)), (tmpvar_30 * tmpvar_28.x)));
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
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = textureProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((tmpvar_28 * 2.0))));
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump vec3 lm_34;
  lowp vec3 tmpvar_35;
  tmpvar_35 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_34 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = vec3((tmpvar_28 * 2.0));
  mediump vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_2 * min (lm_34, tmpvar_36));
  c_1.xyz = tmpvar_37;
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = ((8.0 * tmpvar_29.w) * tmpvar_29.xyz);
  lm_30 = tmpvar_31;
  lowp vec3 arg1_32;
  arg1_32 = ((tmpvar_28.x * 2.0) * tmpvar_29.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_2 * max (min (lm_30, arg1_32), (lm_30 * tmpvar_28.x)));
  c_1.xyz = tmpvar_33;
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
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = textureProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump vec3 lm_34;
  lowp vec3 tmpvar_35;
  tmpvar_35 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_34 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = vec3((tmpvar_28 * 2.0));
  mediump vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_2 * min (lm_34, tmpvar_36));
  c_1.xyz = tmpvar_37;
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  lowp vec4 c_34;
  c_34.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_28) * 2.0));
  c_34.w = tmpvar_3;
  c_1.w = c_34.w;
  c_1.xyz = (c_34.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp vec4 c_28;
  c_28.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x) * 2.0));
  c_28.w = tmpvar_3;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = textureProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  lowp vec4 c_34;
  c_34.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * tmpvar_28) * 2.0));
  c_34.w = tmpvar_3;
  c_1.w = c_34.w;
  c_1.xyz = (c_34.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_28) * 2.0));
  c_31.w = tmpvar_3;
  c_1.w = c_31.w;
  c_1.xyz = (c_31.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  mediump float tmpvar_29;
  tmpvar_29 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  shadow_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (shadow_28 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_28) * 2.0));
  c_31.w = tmpvar_3;
  c_1.w = c_31.w;
  c_1.xyz = (c_31.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_28 * 2.0))));
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
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  mediump float tmpvar_29;
  tmpvar_29 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  shadow_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (shadow_28 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_28 * 2.0))));
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
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_31 = tmpvar_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = vec3((shadow_28 * 2.0));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_2 * min (lm_31, tmpvar_33));
  c_1.xyz = tmpvar_34;
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
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  mediump float tmpvar_29;
  tmpvar_29 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  shadow_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (shadow_28 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_31 = tmpvar_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = vec3((shadow_28 * 2.0));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_2 * min (lm_31, tmpvar_33));
  c_1.xyz = tmpvar_34;
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture2D (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture2D (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture2D (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture2D (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture2D (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_28) * 2.0));
  c_31.w = tmpvar_3;
  c_1.w = c_31.w;
  c_1.xyz = (c_31.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 c_4;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  int y_6;
  highp float v_offset_7;
  highp float h_offset_8;
  highp vec4 final_color_9;
  final_color_9 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_8 = (1.0/(_TexWidth));
  v_offset_7 = (1.0/(_TexHeight));
  y_6 = 0;
  for (int y_6 = 0; y_6 < 5; ) {
    highp vec2 tmpvar_10;
    tmpvar_10.x = (h_offset_8 * -2.0);
    tmpvar_10.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_11;
    highp vec2 P_12;
    P_12 = (uv_5 + tmpvar_10);
    tmpvar_11 = texture (_MainTex, P_12);
    final_color_9 = (final_color_9 + tmpvar_11);
    highp vec2 tmpvar_13;
    tmpvar_13.x = (h_offset_8 * -1.0);
    tmpvar_13.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (uv_5 + tmpvar_13);
    tmpvar_14 = texture (_MainTex, P_15);
    final_color_9 = (final_color_9 + tmpvar_14);
    highp vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_17;
    highp vec2 P_18;
    P_18 = (uv_5 + tmpvar_16);
    tmpvar_17 = texture (_MainTex, P_18);
    final_color_9 = (final_color_9 + tmpvar_17);
    highp vec2 tmpvar_19;
    tmpvar_19.x = h_offset_8;
    tmpvar_19.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_20;
    highp vec2 P_21;
    P_21 = (uv_5 + tmpvar_19);
    tmpvar_20 = texture (_MainTex, P_21);
    final_color_9 = (final_color_9 + tmpvar_20);
    highp vec2 tmpvar_22;
    tmpvar_22.x = (h_offset_8 * 2.0);
    tmpvar_22.y = (v_offset_7 * float((y_6 - 2)));
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (uv_5 + tmpvar_22);
    tmpvar_23 = texture (_MainTex, P_24);
    final_color_9 = (final_color_9 + tmpvar_23);
    y_6 = (y_6 + 1);
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (final_color_9 * 0.04);
  final_color_9 = tmpvar_25;
  c_4 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = c_4.xyz;
  tmpvar_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = c_4.w;
  tmpvar_3 = tmpvar_27;
  lowp float shadow_28;
  mediump float tmpvar_29;
  tmpvar_29 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  shadow_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (shadow_28 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * shadow_28) * 2.0));
  c_31.w = tmpvar_3;
  c_1.w = c_31.w;
  c_1.xyz = (c_31.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 128 math, 25 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ -2, 0, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[3].x;
MUL R3.y, R1, c[4].x;
RCP R1.x, c[2].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[4].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[4].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[4];
MUL R0.w, R1.y, c[4].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[4].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[4];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[4];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[4];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[4];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[4].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R4;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[4].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
TEX R0, R0, texture[0], 2D;
ADD R0, R1, R0;
MUL R1, R0, c[4].w;
MUL R0.xyz, R1, fragment.texcoord[2];
DP3 R0.w, fragment.texcoord[1], c[0];
MUL R1.xyz, R1, c[1];
MAX R0.w, R0, c[4].y;
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R1, c[4].z, R0;
MOV result.color.w, R1;
END
# 128 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 34 math, 5 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c4, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c5, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r1, c4.x
rcp r3.x, c2.x
rcp r3.y, c3.x
mov r3.z, c4.x
loop aL, i0
add r0.x, r3.z, c4.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c4.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c4.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c4.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c4.w
endloop
mul r1, r1, c5.x
mul_pp r0.xyz, r1, v2
dp3_pp r0.w, v1, c0
mul_pp r1.xyz, r1, c1
max_pp r0.w, r0, c4.x
mul_pp r1.xyz, r0.w, r1
mad_pp oC0.xyz, r1, c4.z, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 16 math, 1 textures, 2 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 16 [_LightColor0]
Float 48 [_TexWidth]
Float 52 [_TexHeight]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedcpfgbepabdpijgdipdobnienbcchpnpiabaaaaaagmaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchmadaaaaeaaaaaaanpaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaadaaaaaadgaaaaaipcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaafecaabaaa
aaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaaboaaaaakmcaabaaa
aaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapopppppp
claaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaacaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaaadaaaaaaegaobaaa
abaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
aaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaah
jcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaabgaaaaabdgaaaaaf
pcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnbaaaaaai
bcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaiocaabaaa
abaaaaaaagajbaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaa
abaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 126 math, 26 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R4.x, c[0].x;
RCP R3.w, c[1].x;
MUL R3.y, R3.w, c[2].x;
MUL R3.z, R4.x, c[2];
MUL R4.z, R4.x, c[2].x;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R4;
ADD R0.zw, fragment.texcoord[0].xyxy, R0.xyxy;
TEX R1, R0.zwzw, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, R4.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R1, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R4;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R1, R1, R0;
TEX R0, R2, texture[0], 2D;
MOV R3.y, R3.w;
ADD R1, R1, R0;
MOV R3.x, R4;
MOV R2.y, -R3.w;
MOV R2.x, R4.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R1, R1, R0;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, c[2].y;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, R4;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, c[2];
MOV R2.x, R4.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
MOV R2.y, c[2];
MOV R2.x, -R4;
ADD R4.yw, fragment.texcoord[0].xxzy, R2.xxzy;
ADD R2, R1, R0;
TEX R0, R4.ywzw, texture[0], 2D;
ADD R0, R2, R0;
TEX R1, fragment.texcoord[0], texture[0], 2D;
ADD R2, R0, R1;
MOV R0.w, c[2].y;
MOV R0.z, R3;
ADD R1.xy, fragment.texcoord[0], R0.zwzw;
TEX R1, R1, texture[0], 2D;
MOV R0.y, c[2];
MOV R0.x, R4;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R2, R0;
ADD R2, R0, R1;
MOV R0.w, R3;
MOV R0.z, -R4.x;
ADD R1.xy, fragment.texcoord[0], R0.zwzw;
TEX R1, R1, texture[0], 2D;
MOV R0.y, R3.w;
MOV R0.x, R4.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R2, R0;
ADD R0, R0, R1;
ADD R2.xy, fragment.texcoord[0], R3;
TEX R2, R2, texture[0], 2D;
MOV R1.y, R3.w;
MOV R1.x, c[2].y;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R1;
MOV R1.y, R3.w;
MUL R3.w, R3, c[2].z;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R2;
ADD R0, R0, R1;
MOV R4.w, R3;
MOV R1.w, R3;
MOV R1.z, -R4.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
ADD R1.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R1;
TEX R2, R2, texture[0], 2D;
ADD R1, R0, R2;
MOV R4.y, R3.w;
ADD R2.xy, fragment.texcoord[0], R4;
MOV R0.y, R3.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R1, R0;
TEX R1, R2, texture[0], 2D;
ADD R2, R0, R1;
ADD R3.xy, fragment.texcoord[0], R3.zwzw;
TEX R0, R3, texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
ADD R0, R2, R0;
MUL R0, R0, c[2].w;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, R1;
MOV result.color.w, R0;
MUL result.color.xyz, R0, c[3].x;
END
# 126 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 31 math, 6 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
mul r1, r1, c3.x
texld r0, v1, s1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, c3.y
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 13 math, 2 textures, 2 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedigoholcdahmedpamfdchnichnabfcpolabaaaaaabeaeaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdmadaaaaeaaaaaaampaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaadaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 126 math, 26 textures
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R4.x, c[0].x;
RCP R3.w, c[1].x;
MUL R3.y, R3.w, c[2].x;
MUL R3.z, R4.x, c[2];
MUL R4.z, R4.x, c[2].x;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R4;
ADD R0.zw, fragment.texcoord[0].xyxy, R0.xyxy;
TEX R1, R0.zwzw, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, R4.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R1, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R4;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R1, R1, R0;
TEX R0, R2, texture[0], 2D;
MOV R3.y, R3.w;
ADD R1, R1, R0;
MOV R3.x, R4;
MOV R2.y, -R3.w;
MOV R2.x, R4.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R1, R1, R0;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, c[2].y;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, R4;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, c[2];
MOV R2.x, R4.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
MOV R2.y, c[2];
MOV R2.x, -R4;
ADD R4.yw, fragment.texcoord[0].xxzy, R2.xxzy;
ADD R2, R1, R0;
TEX R0, R4.ywzw, texture[0], 2D;
ADD R0, R2, R0;
TEX R1, fragment.texcoord[0], texture[0], 2D;
ADD R2, R0, R1;
MOV R0.w, c[2].y;
MOV R0.z, R3;
ADD R1.xy, fragment.texcoord[0], R0.zwzw;
TEX R1, R1, texture[0], 2D;
MOV R0.y, c[2];
MOV R0.x, R4;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R2, R0;
ADD R2, R0, R1;
MOV R0.w, R3;
MOV R0.z, -R4.x;
ADD R1.xy, fragment.texcoord[0], R0.zwzw;
TEX R1, R1, texture[0], 2D;
MOV R0.y, R3.w;
MOV R0.x, R4.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R2, R0;
ADD R0, R0, R1;
ADD R2.xy, fragment.texcoord[0], R3;
TEX R2, R2, texture[0], 2D;
MOV R1.y, R3.w;
MOV R1.x, c[2].y;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R1;
MOV R1.y, R3.w;
MUL R3.w, R3, c[2].z;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R2;
ADD R0, R0, R1;
MOV R4.w, R3;
MOV R1.w, R3;
MOV R1.z, -R4.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
ADD R1.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R1;
TEX R2, R2, texture[0], 2D;
ADD R1, R0, R2;
MOV R4.y, R3.w;
ADD R2.xy, fragment.texcoord[0], R4;
MOV R0.y, R3.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R1, R0;
TEX R1, R2, texture[0], 2D;
ADD R2, R0, R1;
ADD R3.xy, fragment.texcoord[0], R3.zwzw;
TEX R0, R3, texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
ADD R0, R2, R0;
MUL R0, R0, c[2].w;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, R1;
MOV result.color.w, R0;
MUL result.color.xyz, R0, c[3].x;
END
# 126 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 31 math, 6 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
mul r1, r1, c3.x
texld r0, v1, s1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, c3.y
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 13 math, 2 textures, 2 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedigoholcdahmedpamfdchnichnabfcpolabaaaaaabeaeaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdmadaaaaeaaaaaaampaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaadaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 130 math, 26 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"3.0-!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ -2, 0, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[3].x;
MUL R3.y, R1, c[4].x;
RCP R1.x, c[2].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[4].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[4].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[4];
MUL R0.w, R1.y, c[4].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[4].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[4];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[4];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[4];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[4];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[4].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R4;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[4].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
TEX R0, R0, texture[0], 2D;
ADD R0, R1, R0;
MUL R0, R0, c[4].w;
MUL R1.xyz, R0, fragment.texcoord[2];
MUL R2.xyz, R0, c[1];
DP3 R0.y, fragment.texcoord[1], c[0];
MAX R0.y, R0, c[4];
TXP R0.x, fragment.texcoord[3], texture[1], 2D;
MUL R0.x, R0.y, R0;
MUL R0.xyz, R0.x, R2;
MAD result.color.xyz, R0, c[4].z, R1;
MOV result.color.w, R0;
END
# 130 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 35 math, 6 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_TexWidth]
Float 3 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c4, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c5, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
mov r1, c4.x
rcp r3.x, c2.x
rcp r3.y, c3.x
mov r3.z, c4.x
loop aL, i0
add r0.x, r3.z, c4.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c4.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c4.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c4.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c4.w
endloop
mul r0, r1, c5.x
mul_pp r1.xyz, r0, v2
mul_pp r2.xyz, r0, c1
dp3_pp r0.y, v1, c0
max_pp r0.y, r0, c4.x
texldp r0.x, v3, s1
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mad_pp oC0.xyz, r0, c4.z, r1
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
// Stats: 17 math, 2 textures, 2 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefieceddgfbjebienikgjclojmeckhmddaeeookabaaaaaaomaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoeadaaaaeaaaaaaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaahaaaaaadgaaaaaipcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaafecaabaaa
aaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaaboaaaaakmcaabaaa
aaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapopppppp
claaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaacaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaaadaaaaaaegaobaaa
abaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
aaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaah
jcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaah
pcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaabgaaaaabdgaaaaaf
pcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddnaknhcddnaoaaaaah
dcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaai
ccaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaapaaaaahbcaabaaa
abaaaaaafgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 132 math, 27 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[1].x;
MUL R3.y, R1, c[2].x;
RCP R1.x, c[0].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[2].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[2];
MUL R0.w, R1.y, c[2].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[2].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[2];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[2];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[2].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
TEX R0, R0, texture[0], 2D;
ADD R0, R1, R0;
TEX R1, fragment.texcoord[1], texture[2], 2D;
TXP R4.x, fragment.texcoord[2], texture[1], 2D;
MUL R3.xyz, R1, R4.x;
MUL R2.xyz, R1.w, R1;
MUL R1.xyz, R2, c[3].x;
MUL R0, R0, c[2].w;
MUL R2.xyz, R1, R4.x;
MUL R3.xyz, R3, c[2].z;
MIN R1.xyz, R1, R3;
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 132 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 36 math, 7 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord2 v2
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
texld r2, v1, s2
mul_pp r0.xyz, r2.w, r2
texldp r3.x, v2, s1
mul_pp r2.xyz, r2, r3.x
mul_pp r0.xyz, r0, c3.y
mul r1, r1, c3.x
mul_pp r3.xyz, r0, r3.x
mul_pp r2.xyz, r2, c2.z
min_pp r0.xyz, r0, r2
max_pp r0.xyz, r0, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 19 math, 3 textures, 2 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 160
Float 112 [_TexWidth]
Float 116 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlcaefdkljcgfcgjlhpkhckedhdecagffabaaaaaacaafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaaeaaaaeaaaaaaaamabaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaahaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaa
aaaaaaahicaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaddaaaaahhcaabaaa
acaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
// Stats: 132 math, 27 textures
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[1].x;
MUL R3.y, R1, c[2].x;
RCP R1.x, c[0].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[2].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[2];
MUL R0.w, R1.y, c[2].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[2].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[2];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[2];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[2].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
TEX R0, R0, texture[0], 2D;
ADD R0, R1, R0;
TEX R1, fragment.texcoord[1], texture[2], 2D;
TXP R4.x, fragment.texcoord[2], texture[1], 2D;
MUL R3.xyz, R1, R4.x;
MUL R2.xyz, R1.w, R1;
MUL R1.xyz, R2, c[3].x;
MUL R0, R0, c[2].w;
MUL R2.xyz, R1, R4.x;
MUL R3.xyz, R3, c[2].z;
MIN R1.xyz, R1, R3;
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 132 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 36 math, 7 textures, 5 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ShadowMapTexture] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
dcl_texcoord2 v2
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
texld r2, v1, s2
mul_pp r0.xyz, r2.w, r2
texldp r3.x, v2, s1
mul_pp r2.xyz, r2, r3.x
mul_pp r0.xyz, r0, c3.y
mul r1, r1, c3.x
mul_pp r3.xyz, r0, r3.x
mul_pp r2.xyz, r2, c2.z
min_pp r0.xyz, r0, r2
max_pp r0.xyz, r0, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 19 math, 3 textures, 2 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 160
Float 112 [_TexWidth]
Float 116 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlcaefdkljcgfcgjlhpkhckedhdecagffabaaaaaacaafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaaeaaaaeaaaaaaaamabaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaahaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaa
aaaaaaahicaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaddaaaaahhcaabaaa
acaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
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
 //       d3d11 : 18 avg math (15..25), 2 avg texture (1..3), 2 branch
 //        d3d9 : 37 avg math (34..43), 6 avg texture (5..7), 5 branch
 //      opengl : 133 avg math (128..139), 26 avg texture (25..27)
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_30)).w) * 2.0));
  c_31.w = tmpvar_4;
  c_1.xyz = c_31.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_30)).w) * 2.0));
  c_31.w = tmpvar_4;
  c_1.xyz = c_31.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture (_LightTexture0, vec2(tmpvar_30)).w) * 2.0));
  c_31.w = tmpvar_4;
  c_1.xyz = c_31.xyz;
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_29;
  c_29.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_29.w = tmpvar_4;
  c_1.xyz = c_29.xyz;
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
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_29;
  c_29.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_29.w = tmpvar_4;
  c_1.xyz = c_29.xyz;
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
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_29;
  c_29.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_29.w = tmpvar_4;
  c_1.xyz = c_29.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_32;
  atten_32 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_30).w) * texture2D (_LightTextureB0, vec2(tmpvar_31)).w);
  lowp vec4 c_33;
  c_33.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_32) * 2.0));
  c_33.w = tmpvar_4;
  c_1.xyz = c_33.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_32;
  atten_32 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_30).w) * texture2D (_LightTextureB0, vec2(tmpvar_31)).w);
  lowp vec4 c_33;
  c_33.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_32) * 2.0));
  c_33.w = tmpvar_4;
  c_1.xyz = c_33.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_32;
  atten_32 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture (_LightTexture0, P_30).w) * texture (_LightTextureB0, vec2(tmpvar_31)).w);
  lowp vec4 c_33;
  c_33.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_32) * 2.0));
  c_33.w = tmpvar_4;
  c_1.xyz = c_33.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_30)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_31.w = tmpvar_4;
  c_1.xyz = c_31.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_30)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_31.w = tmpvar_4;
  c_1.xyz = c_31.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_31;
  c_31.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture (_LightTextureB0, vec2(tmpvar_30)).w * texture (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_31.w = tmpvar_4;
  c_1.xyz = c_31.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_29;
  c_29.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_29.w = tmpvar_4;
  c_1.xyz = c_29.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture2D (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_29;
  c_29.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_29.w = tmpvar_4;
  c_1.xyz = c_29.xyz;
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
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump vec4 c_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  int y_7;
  highp float v_offset_8;
  highp float h_offset_9;
  highp vec4 final_color_10;
  final_color_10 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_9 = (1.0/(_TexWidth));
  v_offset_8 = (1.0/(_TexHeight));
  y_7 = 0;
  for (int y_7 = 0; y_7 < 5; ) {
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_9 * -2.0);
    tmpvar_11.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_6 + tmpvar_11);
    tmpvar_12 = texture (_MainTex, P_13);
    final_color_10 = (final_color_10 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = (h_offset_9 * -1.0);
    tmpvar_14.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_6 + tmpvar_14);
    tmpvar_15 = texture (_MainTex, P_16);
    final_color_10 = (final_color_10 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_6 + tmpvar_17);
    tmpvar_18 = texture (_MainTex, P_19);
    final_color_10 = (final_color_10 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = h_offset_9;
    tmpvar_20.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_6 + tmpvar_20);
    tmpvar_21 = texture (_MainTex, P_22);
    final_color_10 = (final_color_10 + tmpvar_21);
    highp vec2 tmpvar_23;
    tmpvar_23.x = (h_offset_9 * 2.0);
    tmpvar_23.y = (v_offset_8 * float((y_7 - 2)));
    lowp vec4 tmpvar_24;
    highp vec2 P_25;
    P_25 = (uv_6 + tmpvar_23);
    tmpvar_24 = texture (_MainTex, P_25);
    final_color_10 = (final_color_10 + tmpvar_24);
    y_7 = (y_7 + 1);
  };
  highp vec4 tmpvar_26;
  tmpvar_26 = (final_color_10 * 0.04);
  final_color_10 = tmpvar_26;
  c_5 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = c_5.xyz;
  tmpvar_3 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = c_5.w;
  tmpvar_4 = tmpvar_28;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_29;
  c_29.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_29.w = tmpvar_4;
  c_1.xyz = c_29.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 133 math, 26 textures
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 0, -2, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.w, c[1].x;
RCP R2.w, c[2].x;
MUL R3.y, R2.w, c[3];
MUL R3.z, R0.w, c[3];
MUL R1.w, R0, c[3].y;
MUL R3.w, R2, c[3].z;
MOV R0.y, R3;
MOV R0.x, c[3];
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2.xyz, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R0.w;
ADD R1.xy, fragment.texcoord[0], R0;
MOV R0.y, R3;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R1.xyz, R1, texture[0], 2D;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R1.xyz, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R0.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R3.x, R0.w;
MOV R3.y, R2.w;
MOV R2.y, -R2.w;
MOV R2.x, R1.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0.xyz, R2, texture[0], 2D;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, R0.w;
MOV R2.y, -R2.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, c[3].x;
MOV R2.x, R1.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
MOV R2.x, -R0.w;
MOV R2.y, c[3].x;
ADD R4.xy, fragment.texcoord[0], R2;
ADD R2.xyz, R0, R1;
TEX R0.xyz, R4, texture[0], 2D;
ADD R0.xyz, R2, R0;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[3].x;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
MOV R1.y, c[3].x;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R1.x, -R0.w;
MOV R1.y, R2.w;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
MOV R0.y, R2.w;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R1;
ADD R2.xy, fragment.texcoord[0], R3;
TEX R2.xyz, R2, texture[0], 2D;
MOV R1.y, R2.w;
MOV R1.x, c[3];
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R0.xyz, R0, R2;
MOV R1.y, R2.w;
MOV R1.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R2;
MOV R1.x, R3.w;
ADD R1.xy, fragment.texcoord[0], R1.wxzw;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, -R0.w;
MOV R2.y, R3.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R0.x, R3.w;
ADD R0.xy, fragment.texcoord[0], R0.wxzw;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.w;
MOV R2.y, R3.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R2.xyz, R2, texture[0], 2D;
ADD R1.xyz, R1, R2;
ADD R2.xy, fragment.texcoord[0], R3.zwzw;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
MUL R1.xyz, R0.w, fragment.texcoord[2];
TEX R2.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R2;
MUL R0.xyz, R0, c[3].w;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[1], R1;
MUL R0.xyz, R0, c[0];
TEX R0.w, R0.w, texture[1], 2D;
MAX R1.x, R1, c[3];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[3].z;
MOV result.color.w, c[3].x;
END
# 133 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 38 math, 6 textures, 5 branches
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c4, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r1.xyz, c3.x
rcp r0.w, c1.x
rcp r1.w, c2.x
mov r2.w, c3.x
loop aL, i0
add r0.x, r2.w, c3.y
mul r3.y, r1.w, r0.x
mov r0.y, r3
mul r0.x, r0.w, c3.y
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r2.xyz, r1, r0
mov r0.y, r3
mov r0.x, -r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
mov r1.y, r3
mov r1.x, c3
add r1.xy, v0, r1
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mul r3.x, r0.w, c3.z
add r1.xy, v0, r3
mov r0.y, r3
mov r0.x, r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
texld r1.xyz, r1, s0
add r0.xyz, r2, r0
add r1.xyz, r0, r1
add r2.w, r2, c3
endloop
mul r0.xyz, r1, c4.x
mul_pp r1.xyz, r0, c0
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v2
dp3 r0.x, v3, v3
dp3_pp r0.y, v1, r2
max_pp r0.y, r0, c3.x
texld r0.x, r0.x, s1
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c3.z
mov_pp oC0.w, c3.x
"
}
SubProgram "d3d11 " {
// Stats: 19 math, 2 textures, 2 branches
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedplipmodfplhnmajlhhoigoopffcbnciiabaaaaaaaaafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiadaaaaeaaaaaaapoaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaal
dcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaa
aaaaaaaaahaaaaaadgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaab
cbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaead
dkaabaaaabaaaaaaboaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafhcaabaaaadaaaaaaegacbaaaabaaaaaadgaaaaafecaabaaaacaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaa
abeaaaaaafaaaaaaadaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaa
kgakbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaf
icaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaa
agbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabgaaaaabdgaaaaafhcaabaaaabaaaaaaegacbaaaadaaaaaa
bgaaaaabdiaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddn
aknhcddnaknhcddnaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaa
pgapbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaabaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
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
// Stats: 128 math, 25 textures
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 0, -2, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.w, c[1].x;
RCP R2.w, c[2].x;
MUL R3.y, R2.w, c[3];
MUL R3.z, R0.w, c[3];
MUL R1.w, R0, c[3].y;
MUL R3.w, R2, c[3].z;
MOV R0.y, R3;
MOV R0.x, c[3];
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2.xyz, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R0.w;
ADD R1.xy, fragment.texcoord[0], R0;
MOV R0.y, R3;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R1.xyz, R1, texture[0], 2D;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R1.xyz, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R0.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R3.x, R0.w;
MOV R3.y, R2.w;
MOV R2.y, -R2.w;
MOV R2.x, R1.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0.xyz, R2, texture[0], 2D;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, R0.w;
MOV R2.y, -R2.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, c[3].x;
MOV R2.x, R1.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
MOV R2.x, -R0.w;
MOV R2.y, c[3].x;
ADD R4.xy, fragment.texcoord[0], R2;
ADD R2.xyz, R0, R1;
TEX R0.xyz, R4, texture[0], 2D;
ADD R0.xyz, R2, R0;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[3].x;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
MOV R1.y, c[3].x;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R1.x, -R0.w;
MOV R1.y, R2.w;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
MOV R0.y, R2.w;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R1;
ADD R2.xy, fragment.texcoord[0], R3;
TEX R2.xyz, R2, texture[0], 2D;
MOV R1.y, R2.w;
MOV R1.x, c[3];
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R0.xyz, R0, R2;
MOV R1.y, R2.w;
MOV R1.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R2;
MOV R1.x, R3.w;
ADD R1.xy, fragment.texcoord[0], R1.wxzw;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, -R0.w;
MOV R2.y, R3.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R0.x, R3.w;
ADD R0.xy, fragment.texcoord[0], R0.wxzw;
MOV R2.y, R3.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R2.xyz, R2, texture[0], 2D;
ADD R1.xyz, R1, R2;
ADD R2.xy, fragment.texcoord[0], R3.zwzw;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
TEX R2.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R2;
MOV R0.xyz, fragment.texcoord[2];
DP3 R0.w, fragment.texcoord[1], R0;
MUL R1.xyz, R1, c[3].w;
MUL R0.xyz, R1, c[0];
MAX R0.w, R0, c[3].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[3].z;
MOV result.color.w, c[3].x;
END
# 128 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 34 math, 5 textures, 5 branches
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c4, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r1.xyz, c3.x
rcp r0.w, c1.x
rcp r1.w, c2.x
mov r2.w, c3.x
loop aL, i0
add r0.x, r2.w, c3.y
mul r3.y, r1.w, r0.x
mov r0.y, r3
mul r0.x, r0.w, c3.y
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r2.xyz, r1, r0
mov r0.y, r3
mov r0.x, -r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
mov r1.y, r3
mov r1.x, c3
add r1.xy, v0, r1
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mul r3.x, r0.w, c3.z
add r1.xy, v0, r3
mov r0.y, r3
mov r0.x, r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
texld r1.xyz, r1, s0
add r0.xyz, r2, r0
add r1.xyz, r0, r1
add r2.w, r2, c3
endloop
mov_pp r0.xyz, v2
dp3_pp r0.x, v1, r0
mul r1.xyz, r1, c4.x
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c3
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c3.z
mov_pp oC0.w, c3.x
"
}
SubProgram "d3d11 " {
// Stats: 15 math, 1 textures, 2 branches
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 16 [_LightColor0]
Float 48 [_TexWidth]
Float 52 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefieceddnmadnnpbneakcgdofaimnbiopogfkobabaaaaaadeaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceeadaaaaeaaaaaaanbaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaal
dcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaa
aaaaaaaaadaaaaaadgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaab
cbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaead
dkaabaaaabaaaaaaboaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafhcaabaaaadaaaaaaegacbaaaabaaaaaadgaaaaafecaabaaaacaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaa
abeaaaaaafaaaaaaadaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaa
kgakbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaf
icaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaa
agbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabgaaaaabdgaaaaafhcaabaaaabaaaaaaegacbaaaadaaaaaa
bgaaaaabdiaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddn
aknhcddnaknhcddnaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
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
// Stats: 139 math, 27 textures
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
"3.0-!!ARBfp1.0
PARAM c[5] = { program.local[0..2],
		{ 0, -2, 2, 0.039999999 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.w, c[1].x;
RCP R2.w, c[2].x;
MUL R3.y, R2.w, c[3];
MUL R3.z, R0.w, c[3];
MUL R1.w, R0, c[3].y;
MUL R3.w, R2, c[3].z;
MOV R0.y, R3;
MOV R0.x, c[3];
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2.xyz, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R0.w;
ADD R1.xy, fragment.texcoord[0], R0;
MOV R0.y, R3;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R1.xyz, R1, texture[0], 2D;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R1.xyz, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R0.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R3.x, R0.w;
MOV R2.x, R1.w;
MOV R2.y, -R2.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0.xyz, R2, texture[0], 2D;
MOV R3.y, R2.w;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, R0.w;
MOV R2.y, -R2.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, R1.w;
MOV R2.y, c[3].x;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
MOV R2.x, -R0.w;
MOV R2.y, c[3].x;
ADD R4.xy, fragment.texcoord[0], R2;
ADD R2.xyz, R0, R1;
TEX R0.xyz, R4, texture[0], 2D;
ADD R0.xyz, R2, R0;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[3].x;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
MOV R1.y, c[3].x;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R0.x, R1.w;
MOV R0.y, R2.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
ADD R2.xy, fragment.texcoord[0], R3;
TEX R2.xyz, R2, texture[0], 2D;
MOV R1.x, -R0.w;
MOV R1.y, R2.w;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R1.y, R2.w;
MOV R1.x, c[3];
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R0.xyz, R0, R2;
MOV R1.y, R2.w;
MOV R1.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R2;
MOV R1.x, R3.w;
ADD R1.xy, fragment.texcoord[0], R1.wxzw;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, -R0.w;
MOV R2.y, R3.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R0.x, R3.w;
ADD R0.xy, fragment.texcoord[0], R0.wxzw;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.w;
MOV R2.y, R3.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R2.xyz, R2, texture[0], 2D;
ADD R1.xyz, R1, R2;
ADD R2.xy, fragment.texcoord[0], R3.zwzw;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
MUL R1.xyz, R0.w, fragment.texcoord[2];
DP3 R1.x, fragment.texcoord[1], R1;
RCP R0.w, fragment.texcoord[3].w;
MAD R1.zw, fragment.texcoord[3].xyxy, R0.w, c[4].x;
TEX R2.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R2;
MUL R0.xyz, R0, c[3].w;
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R1.zwzw, texture[1], 2D;
TEX R1.w, R1.y, texture[2], 2D;
SLT R1.y, c[3].x, fragment.texcoord[3].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MAX R0.w, R1.x, c[3].x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[3].z;
MOV result.color.w, c[3].x;
END
# 139 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 43 math, 7 textures, 5 branches
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c4, 0.04000000, 0.50000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
mov r1.xyz, c3.x
rcp r0.w, c1.x
rcp r1.w, c2.x
mov r2.w, c3.x
loop aL, i0
add r0.x, r2.w, c3.y
mul r3.y, r1.w, r0.x
mov r0.y, r3
mul r0.x, r0.w, c3.y
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r2.xyz, r1, r0
mov r0.y, r3
mov r0.x, -r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
mov r1.y, r3
mov r1.x, c3
add r1.xy, v0, r1
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mul r3.x, r0.w, c3.z
add r1.xy, v0, r3
mov r0.y, r3
mov r0.x, r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
texld r1.xyz, r1, s0
add r0.xyz, r2, r0
add r1.xyz, r0, r1
add r2.w, r2, c3
endloop
mul r0.xyz, r1, c4.x
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0, c0
mul_pp r0.xyz, r0.w, v2
dp3_pp r0.z, v1, r0
rcp r0.w, v3.w
mad r1.xy, v3, r0.w, c4.y
dp3 r0.x, v3, v3
texld r0.w, r1, s1
cmp r0.y, -v3.z, c3.x, c3.w
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s2
mul_pp r0.x, r0.y, r0
max_pp r0.y, r0.z, c3.x
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c3.z
mov_pp oC0.w, c3.x
"
}
SubProgram "d3d11 " {
// Stats: 25 math, 3 textures, 2 branches
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhbcncpgbbdcmahpjclildcdndoeadjpkabaaaaaapeafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcomaeaaaaeaaaaaaadlabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaa
ahaaaaaadgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
abaaaaaaboaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
hcaabaaaadaaaaaaegacbaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaa
afaaaaaaadaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaabgaaaaabdgaaaaafhcaabaaaabaaaaaaegacbaaaadaaaaaabgaaaaab
diaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddnaknhcddn
aknhcddnaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaadbaaaaahicaabaaaaaaaaaaa
abeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaahdcaabaaaacaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaapgapbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
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
// Stats: 135 math, 27 textures
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 2
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 0, -2, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.w, c[1].x;
RCP R2.w, c[2].x;
MUL R3.y, R2.w, c[3];
MUL R3.z, R0.w, c[3];
MUL R1.w, R0, c[3].y;
MUL R3.w, R2, c[3].z;
MOV R0.y, R3;
MOV R0.x, c[3];
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2.xyz, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R0.w;
ADD R1.xy, fragment.texcoord[0], R0;
MOV R0.y, R3;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R1.xyz, R1, texture[0], 2D;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R1.xyz, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R0.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R3.x, R0.w;
MOV R2.x, R1.w;
MOV R2.y, -R2.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0.xyz, R2, texture[0], 2D;
MOV R3.y, R2.w;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, R0.w;
MOV R2.y, -R2.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, R1.w;
MOV R2.y, c[3].x;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
MOV R2.x, -R0.w;
MOV R2.y, c[3].x;
ADD R4.xy, fragment.texcoord[0], R2;
ADD R2.xyz, R0, R1;
TEX R0.xyz, R4, texture[0], 2D;
ADD R0.xyz, R2, R0;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[3].x;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
MOV R1.y, c[3].x;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R0.x, R1.w;
MOV R0.y, R2.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R1.x, -R0.w;
MOV R1.y, R2.w;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
TEX R2.xyz, R2, texture[0], 2D;
MOV R1.y, R2.w;
MOV R1.x, c[3];
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R0.xyz, R0, R2;
MOV R1.z, -R0.w;
MOV R1.y, R2.w;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R1, texture[0], 2D;
MOV R1.x, R3.w;
ADD R1.xy, fragment.texcoord[0], R1.wxzw;
ADD R0.xyz, R0, R2;
MOV R1.w, R3;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
TEX R2.xyz, R2, texture[0], 2D;
ADD R2.xyz, R0, R2;
MOV R0.y, R3.w;
MOV R0.x, c[3];
ADD R1.xy, fragment.texcoord[0], R0;
MOV R0.x, R3.w;
ADD R0.xy, fragment.texcoord[0], R0.wxzw;
TEX R1.xyz, R1, texture[0], 2D;
ADD R1.xyz, R2, R1;
TEX R0.xyz, R0, texture[0], 2D;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
ADD R1.xyz, R1, R0;
ADD R2.xy, fragment.texcoord[0], R3.zwzw;
TEX R0.xyz, R2, texture[0], 2D;
ADD R0.xyz, R1, R0;
MUL R1.xyz, R0, c[3].w;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[1], R0;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
MUL R1.xyz, R1, c[0];
TEX R0.w, fragment.texcoord[3], texture[2], CUBE;
TEX R1.w, R0.y, texture[1], 2D;
MUL R0.y, R1.w, R0.w;
MAX R0.x, R0, c[3];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[3].z;
MOV result.color.w, c[3].x;
END
# 135 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 39 math, 7 textures, 5 branches
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c3, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c4, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r1.xyz, c3.x
rcp r0.w, c1.x
rcp r1.w, c2.x
mov r2.w, c3.x
loop aL, i0
add r0.x, r2.w, c3.y
mul r3.y, r1.w, r0.x
mov r0.y, r3
mul r0.x, r0.w, c3.y
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r2.xyz, r1, r0
mov r0.y, r3
mov r0.x, -r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
mov r1.y, r3
mov r1.x, c3
add r1.xy, v0, r1
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mul r3.x, r0.w, c3.z
add r1.xy, v0, r3
mov r0.y, r3
mov r0.x, r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
texld r1.xyz, r1, s0
add r0.xyz, r2, r0
add r1.xyz, r0, r1
add r2.w, r2, c3
endloop
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
dp3_pp r0.y, v1, r0
mul r1.xyz, r1, c4.x
dp3 r0.x, v3, v3
max_pp r0.y, r0, c3.x
mul_pp r1.xyz, r1, c0
texld r0.w, v3, s2
texld r0.x, r0.x, s1
mul r0.x, r0, r0.w
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c3.z
mov_pp oC0.w, c3.x
"
}
SubProgram "d3d11 " {
// Stats: 20 math, 3 textures, 2 branches
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkccfgpfddopobeojmdodbabjadoajkppabaaaaaafmafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfeaeaaaaeaaaaaaabfabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaa
ahaaaaaadgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
abaaaaaaboaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
hcaabaaaadaaaaaaegacbaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaa
afaaaaaaadaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaabgaaaaabdgaaaaafhcaabaaaabaaaaaaegacbaaaadaaaaaabgaaaaab
diaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddnaknhcddn
aknhcddnaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaapgapbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbcbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaa
pgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
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
// Stats: 130 math, 26 textures
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 0, -2, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.w, c[1].x;
RCP R2.w, c[2].x;
MUL R3.y, R2.w, c[3];
MUL R3.z, R0.w, c[3];
MUL R1.w, R0, c[3].y;
MUL R3.w, R2, c[3].z;
MOV R0.y, R3;
MOV R0.x, c[3];
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2.xyz, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R0.w;
ADD R1.xy, fragment.texcoord[0], R0;
MOV R0.y, R3;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R1.xyz, R1, texture[0], 2D;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R1.xyz, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R0.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R3.x, R0.w;
MOV R3.y, R2.w;
MOV R2.y, -R2.w;
MOV R2.x, R1.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0.xyz, R2, texture[0], 2D;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R0.xyz, R1, R0;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, R0.w;
MOV R2.y, -R2.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, -R2.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.y, c[3].x;
MOV R2.x, R1.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
MOV R2.x, -R0.w;
MOV R2.y, c[3].x;
ADD R4.xy, fragment.texcoord[0], R2;
ADD R2.xyz, R0, R1;
TEX R0.xyz, R4, texture[0], 2D;
ADD R0.xyz, R2, R0;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[3].x;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
MOV R1.y, c[3].x;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R2.xyz, R0, R1;
MOV R1.x, -R0.w;
MOV R1.y, R2.w;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
MOV R0.y, R2.w;
MOV R0.x, R1.w;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R1;
ADD R2.xy, fragment.texcoord[0], R3;
TEX R2.xyz, R2, texture[0], 2D;
MOV R1.y, R2.w;
MOV R1.x, c[3];
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R0.xyz, R0, R2;
MOV R1.y, R2.w;
MOV R1.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R1;
TEX R2.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R2;
MOV R1.x, R3.w;
ADD R1.xy, fragment.texcoord[0], R1.wxzw;
TEX R1.xyz, R1, texture[0], 2D;
ADD R0.xyz, R0, R1;
MOV R2.x, -R0.w;
MOV R2.y, R3.w;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R1.xyz, R2, texture[0], 2D;
ADD R1.xyz, R0, R1;
MOV R0.x, R3.w;
ADD R0.xy, fragment.texcoord[0], R0.wxzw;
MOV R2.y, R3.w;
MOV R2.x, c[3];
ADD R2.xy, fragment.texcoord[0], R2;
TEX R2.xyz, R2, texture[0], 2D;
ADD R1.xyz, R1, R2;
ADD R2.xy, fragment.texcoord[0], R3.zwzw;
TEX R0.xyz, R0, texture[0], 2D;
ADD R0.xyz, R1, R0;
TEX R2.xyz, R2, texture[0], 2D;
ADD R0.xyz, R0, R2;
MUL R1.xyz, R0, c[3].w;
MOV R0.xyz, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[1], R0;
MUL R1.xyz, R1, c[0];
TEX R0.w, fragment.texcoord[3], texture[1], 2D;
MAX R0.x, R0, c[3];
MUL R0.x, R0, R0.w;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[3].z;
MOV result.color.w, c[3].x;
END
# 130 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 35 math, 6 textures, 5 branches
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_TexWidth]
Float 2 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightTexture0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c4, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mov r1.xyz, c3.x
rcp r0.w, c1.x
rcp r1.w, c2.x
mov r2.w, c3.x
loop aL, i0
add r0.x, r2.w, c3.y
mul r3.y, r1.w, r0.x
mov r0.y, r3
mul r0.x, r0.w, c3.y
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r2.xyz, r1, r0
mov r0.y, r3
mov r0.x, -r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
mov r1.y, r3
mov r1.x, c3
add r1.xy, v0, r1
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mul r3.x, r0.w, c3.z
add r1.xy, v0, r3
mov r0.y, r3
mov r0.x, r0.w
add r0.xy, v0, r0
texld r0.xyz, r0, s0
texld r1.xyz, r1, s0
add r0.xyz, r2, r0
add r1.xyz, r0, r1
add r2.w, r2, c3
endloop
mov_pp r0.xyz, v2
dp3_pp r0.x, v1, r0
mul r1.xyz, r1, c4.x
mul_pp r1.xyz, r1, c0
texld r0.w, v3, s1
max_pp r0.x, r0, c3
mul_pp r0.x, r0, r0.w
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c3.z
mov_pp oC0.w, c3.x
"
}
SubProgram "d3d11 " {
// Stats: 15 math, 2 textures, 2 branches
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Float 112 [_TexWidth]
Float 116 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoialnhmhkidhoikilfeipdhaeenfbaeeabaaaaaajiaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaal
dcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaa
aaaaaaaaahaaaaaadgaaaaaihcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaab
cbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaead
dkaabaaaabaaaaaaboaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dgaaaaafhcaabaaaadaaaaaaegacbaaaabaaaaaadgaaaaafecaabaaaacaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaa
abeaaaaaafaaaaaaadaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaa
kgakbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaf
icaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaa
agbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabgaaaaabdgaaaaafhcaabaaaabaaaaaaegacbaaaadaaaaaa
bgaaaaabdiaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaknhcddn
aknhcddnaknhcddnaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaapgapbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
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
 //        d3d9 : 2 math, 5 branch
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
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  highp vec2 tmpvar_2;
  highp vec2 uv_3;
  uv_3 = tmpvar_2;
  int y_4;
  highp float v_offset_5;
  highp float h_offset_6;
  highp vec4 final_color_7;
  final_color_7 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_6 = (1.0/(_TexWidth));
  v_offset_5 = (1.0/(_TexHeight));
  y_4 = 0;
  for (int y_4 = 0; y_4 < 5; ) {
    highp vec2 tmpvar_8;
    tmpvar_8.x = (h_offset_6 * -2.0);
    tmpvar_8.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_9;
    highp vec2 P_10;
    P_10 = (uv_3 + tmpvar_8);
    tmpvar_9 = texture2D (_MainTex, P_10);
    final_color_7 = (final_color_7 + tmpvar_9);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_6 * -1.0);
    tmpvar_11.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_3 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_7 = (final_color_7 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = 0.0;
    tmpvar_14.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_3 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_7 = (final_color_7 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = h_offset_6;
    tmpvar_17.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_3 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_7 = (final_color_7 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = (h_offset_6 * 2.0);
    tmpvar_20.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_3 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_7 = (final_color_7 + tmpvar_21);
    y_4 = (y_4 + 1);
  };
  final_color_7 = (final_color_7 * 0.04);
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
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  highp vec2 tmpvar_2;
  highp vec2 uv_3;
  uv_3 = tmpvar_2;
  int y_4;
  highp float v_offset_5;
  highp float h_offset_6;
  highp vec4 final_color_7;
  final_color_7 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_6 = (1.0/(_TexWidth));
  v_offset_5 = (1.0/(_TexHeight));
  y_4 = 0;
  for (int y_4 = 0; y_4 < 5; ) {
    highp vec2 tmpvar_8;
    tmpvar_8.x = (h_offset_6 * -2.0);
    tmpvar_8.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_9;
    highp vec2 P_10;
    P_10 = (uv_3 + tmpvar_8);
    tmpvar_9 = texture2D (_MainTex, P_10);
    final_color_7 = (final_color_7 + tmpvar_9);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_6 * -1.0);
    tmpvar_11.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_3 + tmpvar_11);
    tmpvar_12 = texture2D (_MainTex, P_13);
    final_color_7 = (final_color_7 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = 0.0;
    tmpvar_14.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_3 + tmpvar_14);
    tmpvar_15 = texture2D (_MainTex, P_16);
    final_color_7 = (final_color_7 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = h_offset_6;
    tmpvar_17.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_3 + tmpvar_17);
    tmpvar_18 = texture2D (_MainTex, P_19);
    final_color_7 = (final_color_7 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = (h_offset_6 * 2.0);
    tmpvar_20.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_3 + tmpvar_20);
    tmpvar_21 = texture2D (_MainTex, P_22);
    final_color_7 = (final_color_7 + tmpvar_21);
    y_4 = (y_4 + 1);
  };
  final_color_7 = (final_color_7 * 0.04);
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
in lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  highp vec2 tmpvar_2;
  highp vec2 uv_3;
  uv_3 = tmpvar_2;
  int y_4;
  highp float v_offset_5;
  highp float h_offset_6;
  highp vec4 final_color_7;
  final_color_7 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_6 = (1.0/(_TexWidth));
  v_offset_5 = (1.0/(_TexHeight));
  y_4 = 0;
  for (int y_4 = 0; y_4 < 5; ) {
    highp vec2 tmpvar_8;
    tmpvar_8.x = (h_offset_6 * -2.0);
    tmpvar_8.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_9;
    highp vec2 P_10;
    P_10 = (uv_3 + tmpvar_8);
    tmpvar_9 = texture (_MainTex, P_10);
    final_color_7 = (final_color_7 + tmpvar_9);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (h_offset_6 * -1.0);
    tmpvar_11.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (uv_3 + tmpvar_11);
    tmpvar_12 = texture (_MainTex, P_13);
    final_color_7 = (final_color_7 + tmpvar_12);
    highp vec2 tmpvar_14;
    tmpvar_14.x = 0.0;
    tmpvar_14.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_15;
    highp vec2 P_16;
    P_16 = (uv_3 + tmpvar_14);
    tmpvar_15 = texture (_MainTex, P_16);
    final_color_7 = (final_color_7 + tmpvar_15);
    highp vec2 tmpvar_17;
    tmpvar_17.x = h_offset_6;
    tmpvar_17.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (uv_3 + tmpvar_17);
    tmpvar_18 = texture (_MainTex, P_19);
    final_color_7 = (final_color_7 + tmpvar_18);
    highp vec2 tmpvar_20;
    tmpvar_20.x = (h_offset_6 * 2.0);
    tmpvar_20.y = (v_offset_5 * float((y_4 - 2)));
    lowp vec4 tmpvar_21;
    highp vec2 P_22;
    P_22 = (uv_3 + tmpvar_20);
    tmpvar_21 = texture (_MainTex, P_22);
    final_color_7 = (final_color_7 + tmpvar_21);
    y_4 = (y_4 + 1);
  };
  final_color_7 = (final_color_7 * 0.04);
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
PARAM c[3] = { program.local[0..1],
		{ 0, 0.5 } };
MAD result.color.xyz, fragment.texcoord[0], c[2].y, c[2].y;
MOV result.color.w, c[2].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 2 math, 5 branches
"ps_3_0
defi i0, 5, 0, 1, 0
def c0, 0.50000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
loop aL, i0
endloop
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
 //       d3d11 : 16 avg math (13..22), 3 avg texture (2..4), 2 branch
 //        d3d9 : 34 avg math (30..42), 7 avg texture (6..8), 5 branch
 //      opengl : 130 avg math (125..139), 27 avg texture (26..28)
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_31.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_32;
  lowp vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * light_3.xyz);
  c_33.xyz = tmpvar_34;
  c_33.w = tmpvar_5;
  c_2 = c_33;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_31.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_32;
  lowp vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * light_3.xyz);
  c_33.xyz = tmpvar_34;
  c_33.w = tmpvar_5;
  c_2 = c_33;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_31.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_32;
  lowp vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * light_3.xyz);
  c_33.xyz = tmpvar_34;
  c_33.w = tmpvar_5;
  c_2 = c_33;
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
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = 0.0;
  mediump vec4 c_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  int y_11;
  highp float v_offset_12;
  highp float h_offset_13;
  highp vec4 final_color_14;
  final_color_14 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_13 = (1.0/(_TexWidth));
  v_offset_12 = (1.0/(_TexHeight));
  y_11 = 0;
  for (int y_11 = 0; y_11 < 5; ) {
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_13 * -2.0);
    tmpvar_15.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_10 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_14 = (final_color_14 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = (h_offset_13 * -1.0);
    tmpvar_18.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_10 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_14 = (final_color_14 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = 0.0;
    tmpvar_21.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_10 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_14 = (final_color_14 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = h_offset_13;
    tmpvar_24.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_10 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_14 = (final_color_14 + tmpvar_25);
    highp vec2 tmpvar_27;
    tmpvar_27.x = (h_offset_13 * 2.0);
    tmpvar_27.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = (uv_10 + tmpvar_27);
    tmpvar_28 = texture2D (_MainTex, P_29);
    final_color_14 = (final_color_14 + tmpvar_28);
    y_11 = (y_11 + 1);
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (final_color_14 * 0.04);
  final_color_14 = tmpvar_30;
  c_9 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = c_9.xyz;
  tmpvar_7 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = c_9.w;
  tmpvar_8 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_34.w;
  highp float tmpvar_35;
  tmpvar_35 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_37;
  light_6.xyz = (tmpvar_34.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_7 * light_6.xyz);
  c_38.xyz = tmpvar_39;
  c_38.w = tmpvar_8;
  c_2 = c_38;
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
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = 0.0;
  mediump vec4 c_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  int y_11;
  highp float v_offset_12;
  highp float h_offset_13;
  highp vec4 final_color_14;
  final_color_14 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_13 = (1.0/(_TexWidth));
  v_offset_12 = (1.0/(_TexHeight));
  y_11 = 0;
  for (int y_11 = 0; y_11 < 5; ) {
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_13 * -2.0);
    tmpvar_15.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_10 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_14 = (final_color_14 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = (h_offset_13 * -1.0);
    tmpvar_18.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_10 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_14 = (final_color_14 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = 0.0;
    tmpvar_21.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_10 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_14 = (final_color_14 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = h_offset_13;
    tmpvar_24.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_10 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_14 = (final_color_14 + tmpvar_25);
    highp vec2 tmpvar_27;
    tmpvar_27.x = (h_offset_13 * 2.0);
    tmpvar_27.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = (uv_10 + tmpvar_27);
    tmpvar_28 = texture2D (_MainTex, P_29);
    final_color_14 = (final_color_14 + tmpvar_28);
    y_11 = (y_11 + 1);
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (final_color_14 * 0.04);
  final_color_14 = tmpvar_30;
  c_9 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = c_9.xyz;
  tmpvar_7 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = c_9.w;
  tmpvar_8 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_34.w;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  highp float tmpvar_37;
  tmpvar_37 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = ((8.0 * tmpvar_35.w) * tmpvar_35.xyz);
  lmFull_4 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = ((8.0 * tmpvar_36.w) * tmpvar_36.xyz);
  lmIndirect_3 = tmpvar_39;
  light_6.xyz = (tmpvar_34.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_7 * light_6.xyz);
  c_40.xyz = tmpvar_41;
  c_40.w = tmpvar_8;
  c_2 = c_40;
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
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = 0.0;
  mediump vec4 c_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  int y_11;
  highp float v_offset_12;
  highp float h_offset_13;
  highp vec4 final_color_14;
  final_color_14 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_13 = (1.0/(_TexWidth));
  v_offset_12 = (1.0/(_TexHeight));
  y_11 = 0;
  for (int y_11 = 0; y_11 < 5; ) {
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_13 * -2.0);
    tmpvar_15.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_10 + tmpvar_15);
    tmpvar_16 = texture (_MainTex, P_17);
    final_color_14 = (final_color_14 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = (h_offset_13 * -1.0);
    tmpvar_18.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_10 + tmpvar_18);
    tmpvar_19 = texture (_MainTex, P_20);
    final_color_14 = (final_color_14 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = 0.0;
    tmpvar_21.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_10 + tmpvar_21);
    tmpvar_22 = texture (_MainTex, P_23);
    final_color_14 = (final_color_14 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = h_offset_13;
    tmpvar_24.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_10 + tmpvar_24);
    tmpvar_25 = texture (_MainTex, P_26);
    final_color_14 = (final_color_14 + tmpvar_25);
    highp vec2 tmpvar_27;
    tmpvar_27.x = (h_offset_13 * 2.0);
    tmpvar_27.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = (uv_10 + tmpvar_27);
    tmpvar_28 = texture (_MainTex, P_29);
    final_color_14 = (final_color_14 + tmpvar_28);
    y_11 = (y_11 + 1);
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (final_color_14 * 0.04);
  final_color_14 = tmpvar_30;
  c_9 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = c_9.xyz;
  tmpvar_7 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = c_9.w;
  tmpvar_8 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_34.w;
  highp float tmpvar_35;
  tmpvar_35 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_37;
  light_6.xyz = (tmpvar_34.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_7 * light_6.xyz);
  c_38.xyz = tmpvar_39;
  c_38.w = tmpvar_8;
  c_2 = c_38;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_31 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = lm_31;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_33);
  light_3 = tmpvar_34;
  lowp vec4 c_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_4 * tmpvar_34.xyz);
  c_35.xyz = tmpvar_36;
  c_35.w = tmpvar_5;
  c_2 = c_35;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  mediump vec3 lm_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = ((8.0 * tmpvar_31.w) * tmpvar_31.xyz);
  lm_32 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = lm_32;
  mediump vec4 tmpvar_35;
  tmpvar_35 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_34);
  light_3 = tmpvar_35;
  lowp vec4 c_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_4 * tmpvar_35.xyz);
  c_36.xyz = tmpvar_37;
  c_36.w = tmpvar_5;
  c_2 = c_36;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_31 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = lm_31;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_33);
  light_3 = tmpvar_34;
  lowp vec4 c_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_4 * tmpvar_34.xyz);
  c_35.xyz = tmpvar_36;
  c_35.w = tmpvar_5;
  c_2 = c_35;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_31.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_32;
  lowp vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * light_3.xyz);
  c_33.xyz = tmpvar_34;
  c_33.w = tmpvar_5;
  c_2 = c_33;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_31.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_32;
  lowp vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * light_3.xyz);
  c_33.xyz = tmpvar_34;
  c_33.w = tmpvar_5;
  c_2 = c_33;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_31.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_32;
  lowp vec4 c_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_4 * light_3.xyz);
  c_33.xyz = tmpvar_34;
  c_33.w = tmpvar_5;
  c_2 = c_33;
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
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = 0.0;
  mediump vec4 c_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  int y_11;
  highp float v_offset_12;
  highp float h_offset_13;
  highp vec4 final_color_14;
  final_color_14 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_13 = (1.0/(_TexWidth));
  v_offset_12 = (1.0/(_TexHeight));
  y_11 = 0;
  for (int y_11 = 0; y_11 < 5; ) {
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_13 * -2.0);
    tmpvar_15.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_10 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_14 = (final_color_14 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = (h_offset_13 * -1.0);
    tmpvar_18.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_10 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_14 = (final_color_14 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = 0.0;
    tmpvar_21.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_10 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_14 = (final_color_14 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = h_offset_13;
    tmpvar_24.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_10 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_14 = (final_color_14 + tmpvar_25);
    highp vec2 tmpvar_27;
    tmpvar_27.x = (h_offset_13 * 2.0);
    tmpvar_27.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = (uv_10 + tmpvar_27);
    tmpvar_28 = texture2D (_MainTex, P_29);
    final_color_14 = (final_color_14 + tmpvar_28);
    y_11 = (y_11 + 1);
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (final_color_14 * 0.04);
  final_color_14 = tmpvar_30;
  c_9 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = c_9.xyz;
  tmpvar_7 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = c_9.w;
  tmpvar_8 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_34.w;
  highp float tmpvar_35;
  tmpvar_35 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_37;
  light_6.xyz = (tmpvar_34.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_7 * light_6.xyz);
  c_38.xyz = tmpvar_39;
  c_38.w = tmpvar_8;
  c_2 = c_38;
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
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = 0.0;
  mediump vec4 c_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  int y_11;
  highp float v_offset_12;
  highp float h_offset_13;
  highp vec4 final_color_14;
  final_color_14 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_13 = (1.0/(_TexWidth));
  v_offset_12 = (1.0/(_TexHeight));
  y_11 = 0;
  for (int y_11 = 0; y_11 < 5; ) {
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_13 * -2.0);
    tmpvar_15.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_10 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_14 = (final_color_14 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = (h_offset_13 * -1.0);
    tmpvar_18.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_10 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_14 = (final_color_14 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = 0.0;
    tmpvar_21.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_10 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_14 = (final_color_14 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = h_offset_13;
    tmpvar_24.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_10 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_14 = (final_color_14 + tmpvar_25);
    highp vec2 tmpvar_27;
    tmpvar_27.x = (h_offset_13 * 2.0);
    tmpvar_27.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = (uv_10 + tmpvar_27);
    tmpvar_28 = texture2D (_MainTex, P_29);
    final_color_14 = (final_color_14 + tmpvar_28);
    y_11 = (y_11 + 1);
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (final_color_14 * 0.04);
  final_color_14 = tmpvar_30;
  c_9 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = c_9.xyz;
  tmpvar_7 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = c_9.w;
  tmpvar_8 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_34.w;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  highp float tmpvar_37;
  tmpvar_37 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = ((8.0 * tmpvar_35.w) * tmpvar_35.xyz);
  lmFull_4 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = ((8.0 * tmpvar_36.w) * tmpvar_36.xyz);
  lmIndirect_3 = tmpvar_39;
  light_6.xyz = (tmpvar_34.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = (tmpvar_7 * light_6.xyz);
  c_40.xyz = tmpvar_41;
  c_40.w = tmpvar_8;
  c_2 = c_40;
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
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = 0.0;
  mediump vec4 c_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  int y_11;
  highp float v_offset_12;
  highp float h_offset_13;
  highp vec4 final_color_14;
  final_color_14 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_13 = (1.0/(_TexWidth));
  v_offset_12 = (1.0/(_TexHeight));
  y_11 = 0;
  for (int y_11 = 0; y_11 < 5; ) {
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_13 * -2.0);
    tmpvar_15.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_10 + tmpvar_15);
    tmpvar_16 = texture (_MainTex, P_17);
    final_color_14 = (final_color_14 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = (h_offset_13 * -1.0);
    tmpvar_18.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_10 + tmpvar_18);
    tmpvar_19 = texture (_MainTex, P_20);
    final_color_14 = (final_color_14 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = 0.0;
    tmpvar_21.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_10 + tmpvar_21);
    tmpvar_22 = texture (_MainTex, P_23);
    final_color_14 = (final_color_14 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = h_offset_13;
    tmpvar_24.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_10 + tmpvar_24);
    tmpvar_25 = texture (_MainTex, P_26);
    final_color_14 = (final_color_14 + tmpvar_25);
    highp vec2 tmpvar_27;
    tmpvar_27.x = (h_offset_13 * 2.0);
    tmpvar_27.y = (v_offset_12 * float((y_11 - 2)));
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = (uv_10 + tmpvar_27);
    tmpvar_28 = texture (_MainTex, P_29);
    final_color_14 = (final_color_14 + tmpvar_28);
    y_11 = (y_11 + 1);
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (final_color_14 * 0.04);
  final_color_14 = tmpvar_30;
  c_9 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = c_9.xyz;
  tmpvar_7 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = c_9.w;
  tmpvar_8 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_34.w;
  highp float tmpvar_35;
  tmpvar_35 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_37;
  light_6.xyz = (tmpvar_34.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_7 * light_6.xyz);
  c_38.xyz = tmpvar_39;
  c_38.w = tmpvar_8;
  c_2 = c_38;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_31 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = lm_31;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_33);
  light_3 = tmpvar_34;
  lowp vec4 c_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_4 * tmpvar_34.xyz);
  c_35.xyz = tmpvar_36;
  c_35.w = tmpvar_5;
  c_2 = c_35;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture2D (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture2D (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture2D (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture2D (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture2D (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  mediump vec3 lm_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = ((8.0 * tmpvar_31.w) * tmpvar_31.xyz);
  lm_32 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = lm_32;
  mediump vec4 tmpvar_35;
  tmpvar_35 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_34);
  light_3 = tmpvar_35;
  lowp vec4 c_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_4 * tmpvar_35.xyz);
  c_36.xyz = tmpvar_37;
  c_36.w = tmpvar_5;
  c_2 = c_36;
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
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec4 c_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  int y_8;
  highp float v_offset_9;
  highp float h_offset_10;
  highp vec4 final_color_11;
  final_color_11 = vec4(0.0, 0.0, 0.0, 0.0);
  h_offset_10 = (1.0/(_TexWidth));
  v_offset_9 = (1.0/(_TexHeight));
  y_8 = 0;
  for (int y_8 = 0; y_8 < 5; ) {
    highp vec2 tmpvar_12;
    tmpvar_12.x = (h_offset_10 * -2.0);
    tmpvar_12.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (uv_7 + tmpvar_12);
    tmpvar_13 = texture (_MainTex, P_14);
    final_color_11 = (final_color_11 + tmpvar_13);
    highp vec2 tmpvar_15;
    tmpvar_15.x = (h_offset_10 * -1.0);
    tmpvar_15.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_16;
    highp vec2 P_17;
    P_17 = (uv_7 + tmpvar_15);
    tmpvar_16 = texture (_MainTex, P_17);
    final_color_11 = (final_color_11 + tmpvar_16);
    highp vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (uv_7 + tmpvar_18);
    tmpvar_19 = texture (_MainTex, P_20);
    final_color_11 = (final_color_11 + tmpvar_19);
    highp vec2 tmpvar_21;
    tmpvar_21.x = h_offset_10;
    tmpvar_21.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_22;
    highp vec2 P_23;
    P_23 = (uv_7 + tmpvar_21);
    tmpvar_22 = texture (_MainTex, P_23);
    final_color_11 = (final_color_11 + tmpvar_22);
    highp vec2 tmpvar_24;
    tmpvar_24.x = (h_offset_10 * 2.0);
    tmpvar_24.y = (v_offset_9 * float((y_8 - 2)));
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = (uv_7 + tmpvar_24);
    tmpvar_25 = texture (_MainTex, P_26);
    final_color_11 = (final_color_11 + tmpvar_25);
    y_8 = (y_8 + 1);
  };
  highp vec4 tmpvar_27;
  tmpvar_27 = (final_color_11 * 0.04);
  final_color_11 = tmpvar_27;
  c_6 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = c_6.xyz;
  tmpvar_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = c_6.w;
  tmpvar_5 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_31 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = lm_31;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_33);
  light_3 = tmpvar_34;
  lowp vec4 c_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_4 * tmpvar_34.xyz);
  c_35.xyz = tmpvar_36;
  c_35.w = tmpvar_5;
  c_2 = c_35;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 128 math, 26 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"3.0-!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[1].x;
MUL R3.y, R1, c[2].x;
RCP R1.x, c[0].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[2].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[2];
MUL R0.w, R1.y, c[2].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[2].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[2];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[2];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[2].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R4;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
TEX R0, R0, texture[0], 2D;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
ADD R1, R1, R0;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R1, R1, c[2].w;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[2];
MOV result.color.w, R1;
MUL result.color.xyz, R1, R0;
END
# 128 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 33 math, 6 textures, 5 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
texldp r0.xyz, v1, s1
mul r1, r1, c3.x
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, v2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 14 math, 2 textures, 2 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkkdmkgkljeijccdojndpolcijdiebpbaabaaaaaafaaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgaadaaaaeaaaaaaaniaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaa
adaaaaaadgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaa
acaaaaaaboaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
pcaabaaaadaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaa
afaaaaaaadaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
aeaaaaaabgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaab
diaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddn
aknhcddnaknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaadaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 139 math, 28 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"3.0-!!ARBfp1.0
PARAM c[5] = { program.local[0..2],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[1].x;
MUL R3.y, R1, c[3].x;
RCP R1.x, c[0].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[3].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[3].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[3];
MUL R0.w, R1.y, c[3].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[3].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[3];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[3];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[3];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[3];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[3].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R4;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[3].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
TEX R0, R0, texture[0], 2D;
ADD R1, R1, R0;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MUL R0.xyz, R0.w, R0;
MUL R1, R1, c[3].w;
TEX R2, fragment.texcoord[2], texture[3], 2D;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[4].x;
MAD R3.xyz, R0, c[4].x, -R2;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
DP4 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MAD_SAT R0.w, R0, c[2].z, c[2];
MAD R2.xyz, R0.w, R3, R2;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R2;
MUL result.color.xyz, R1, R0;
MOV result.color.w, R1;
END
# 139 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 42 math, 8 textures, 5 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c4, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
mov r2, c3.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c3.x
loop aL, i0
add r0.x, r3.z, c3.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c3.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r2, r0
mov r0.w, r4.y
mov r0.z, c3.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c3.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r2, r0, r1
add r3.z, r3, c3.w
endloop
texld r0, v2, s2
mul_pp r0.xyz, r0.w, r0
texld r1, v2, s3
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c4.y
mad_pp r3.xyz, r0, c4.y, -r1
texldp r0.xyz, v1, s1
dp4 r0.w, v3, v3
rsq r0.w, r0.w
rcp r0.w, r0.w
mad_sat r0.w, r0, c2.z, c2
mad_pp r1.xyz, r0.w, r3, r1
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r0.xyz, -r0, r1
mul r1, r2, c4.x
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 22 math, 4 textures, 2 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Vector 96 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmcmnonpldkppijepnclgfagjfconpogeabaaaaaapaafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiaeaaaaeaaaaaaadkabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaadaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
bbaaaaahicaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaelaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadccaaaalicaabaaaabaaaaaadkaabaaa
abaaaaaackiacaaaaaaaaaaaagaaaaaadkiacaaaaaaaaaaaagaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahicaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaapgapbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaajhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 130 math, 27 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[1].x;
MUL R3.y, R1, c[2].x;
RCP R1.x, c[0].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[2].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[2];
MUL R0.w, R1.y, c[2].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[2].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[2];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[2];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[2].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R4;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
TEX R0, R0, texture[0], 2D;
ADD R1, R1, R0;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R1, R1, c[2].w;
TEX R2, fragment.texcoord[2], texture[2], 2D;
MUL R2.xyz, R2.w, R2;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
MAD R0.xyz, R2, c[3].x, -R0;
MUL result.color.xyz, R1, R0;
MOV result.color.w, R1;
END
# 130 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 34 math, 7 textures, 5 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
texldp r2.xyz, v1, s1
mul r1, r1, c3.x
texld r0, v2, s2
mul_pp r0.xyz, r0.w, r0
log_pp r2.x, r2.x
log_pp r2.z, r2.z
log_pp r2.y, r2.y
mad_pp r0.xyz, r0, c3.y, -r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 15 math, 3 textures, 2 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkclcmkgckmdoiaaajfohfmfdgojelepbabaaaaaaleaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeadaaaaeaaaaaaapbaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaadaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 125 math, 26 textures
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"3.0-!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[1].x;
MUL R3.y, R1, c[2].x;
RCP R1.x, c[0].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[2].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[2];
MUL R0.w, R1.y, c[2].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[2].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[2];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[2];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[2].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R4;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
TEX R0, R0, texture[0], 2D;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
ADD R1, R1, R0;
MUL R1, R1, c[2].w;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
ADD R0.xyz, R0, fragment.texcoord[2];
MOV result.color.w, R1;
MUL result.color.xyz, R1, R0;
END
# 125 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 30 math, 6 textures, 5 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
mul r1, r1, c3.x
texldp r0.xyz, v1, s1
add_pp r0.xyz, r0, v2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 13 math, 2 textures, 2 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 96
Float 48 [_TexWidth]
Float 52 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkcbcakbmdmcjogfjhdpojjkdofldooonabaaaaaadiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceiadaaaaeaaaaaaancaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaa
adaaaaaadgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaa
acaaaaaaboaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
pcaabaaaadaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaa
afaaaaaaadaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
aeaaaaaabgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaab
diaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddn
aknhcddnaknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaa
adaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 136 math, 28 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"3.0-!!ARBfp1.0
PARAM c[5] = { program.local[0..2],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R4.x, c[0].x;
RCP R3.w, c[1].x;
MUL R3.y, R3.w, c[3].x;
MUL R3.z, R4.x, c[3];
MUL R4.z, R4.x, c[3].x;
MOV R0.y, R3;
MOV R0.x, c[3].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R2, R0, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, -R4;
ADD R0.zw, fragment.texcoord[0].xyxy, R0.xyxy;
TEX R1, R0.zwzw, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, R4.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R1, R0, R2;
MOV R3.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R3;
MOV R0.y, R3;
MOV R0.x, R4;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R1, R1, R0;
TEX R0, R2, texture[0], 2D;
MOV R3.y, R3.w;
ADD R1, R1, R0;
MOV R3.x, R4;
MOV R2.y, -R3.w;
MOV R2.x, R4.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R2.xy, fragment.texcoord[0], -R3;
ADD R1, R1, R0;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, c[3].y;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, R4;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, -R3.w;
MOV R2.x, R3.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
ADD R1, R1, R0;
MOV R2.y, c[3];
MOV R2.x, R4.z;
ADD R2.xy, fragment.texcoord[0], R2;
TEX R0, R2, texture[0], 2D;
MOV R2.y, c[3];
MOV R2.x, -R4;
ADD R4.yw, fragment.texcoord[0].xxzy, R2.xxzy;
ADD R2, R1, R0;
TEX R0, R4.ywzw, texture[0], 2D;
ADD R0, R2, R0;
TEX R1, fragment.texcoord[0], texture[0], 2D;
ADD R2, R0, R1;
MOV R0.w, c[3].y;
MOV R0.z, R3;
ADD R1.xy, fragment.texcoord[0], R0.zwzw;
TEX R1, R1, texture[0], 2D;
MOV R0.y, c[3];
MOV R0.x, R4;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R2, R0;
ADD R2, R0, R1;
MOV R0.w, R3;
MOV R0.z, -R4.x;
ADD R1.xy, fragment.texcoord[0], R0.zwzw;
TEX R1, R1, texture[0], 2D;
MOV R0.y, R3.w;
MOV R0.x, R4.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R2, R0;
ADD R0, R0, R1;
ADD R2.xy, fragment.texcoord[0], R3;
TEX R2, R2, texture[0], 2D;
MOV R1.y, R3.w;
MOV R1.x, c[3].y;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R1;
MOV R1.y, R3.w;
MUL R3.w, R3, c[3].z;
MOV R1.x, R3.z;
ADD R1.xy, fragment.texcoord[0], R1;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R2;
ADD R0, R0, R1;
MOV R4.w, R3;
MOV R1.w, R3;
MOV R1.z, -R4.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
ADD R1.xy, fragment.texcoord[0], R4.zwzw;
TEX R1, R1, texture[0], 2D;
ADD R0, R0, R1;
TEX R2, R2, texture[0], 2D;
ADD R1, R0, R2;
MOV R4.y, R3.w;
ADD R2.xy, fragment.texcoord[0], R4;
MOV R0.y, R3.w;
MOV R0.x, c[3].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R0, R1, R0;
TEX R1, R2, texture[0], 2D;
ADD R2, R0, R1;
ADD R3.xy, fragment.texcoord[0], R3.zwzw;
TEX R0, R3, texture[0], 2D;
ADD R0, R2, R0;
TEX R1, fragment.texcoord[2], texture[2], 2D;
MUL R2.xyz, R1.w, R1;
TEX R1, fragment.texcoord[2], texture[3], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[4].x;
MUL R0, R0, c[3].w;
DP4 R2.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[4].x, -R1;
MAD_SAT R1.w, R1, c[2].z, c[2];
MAD R2.xyz, R1.w, R2, R1;
TXP R1.xyz, fragment.texcoord[1], texture[1], 2D;
ADD R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 136 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 39 math, 8 textures, 5 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c4, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
mov r1, c3.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c3.x
loop aL, i0
add r0.x, r3.z, c3.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c3.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c3.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c3.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c3.w
endloop
texld r0, v2, s2
mul_pp r2.xyz, r0.w, r0
texld r0, v2, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c4.y
mul r1, r1, c4.x
dp4 r2.w, v3, v3
rsq r0.w, r2.w
rcp r0.w, r0.w
mad_pp r2.xyz, r2, c4.y, -r0
mad_sat r0.w, r0, c2.z, c2
mad_pp r2.xyz, r0.w, r2, r0
texldp r0.xyz, v1, s1
add_pp r0.xyz, r0, r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 21 math, 4 textures, 2 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
Vector 96 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecediaelfoeabmjbgcjdckhbmmlmhmepcmgmabaaaaaaniafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnaaeaaaaeaaaaaaadeabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaadaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaabbaaaaahicaabaaaabaaaaaaegbobaaaadaaaaaa
egbobaaaadaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadccaaaal
icaabaaaabaaaaaadkaabaaaabaaaaaackiacaaaaaaaaaaaagaaaaaadkiacaaa
aaaaaaaaagaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaadaaaaaadcaaaaak
hcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaajhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
// Stats: 127 math, 27 textures
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[4] = { program.local[0..1],
		{ -2, 0, 2, 0.039999999 },
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R1.y, c[1].x;
MUL R3.y, R1, c[2].x;
RCP R1.x, c[0].x;
MOV R1.w, R3.y;
MOV R1.z, -R1.x;
ADD R2.xy, fragment.texcoord[0], R1.zwzw;
MUL R1.z, R1.x, c[2].x;
MOV R2.w, R3.y;
MOV R2.z, R1;
ADD R3.zw, fragment.texcoord[0].xyxy, R2;
TEX R4, R3.zwzw, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MOV R0.y, R3;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R0, R0, texture[0], 2D;
ADD R2, R4, R2;
ADD R2, R2, R0;
MUL R0.z, R1.x, c[2];
MUL R0.w, R1.y, c[2].z;
MOV R3.x, R0.z;
MOV R1.w, R0;
MOV R0.y, R3;
MOV R0.x, R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R4, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R4;
ADD R2, R2, R3;
MOV R0.y, -R1;
MOV R0.x, R1.z;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R1;
ADD R4.xy, fragment.texcoord[0], -R0;
ADD R2, R2, R3;
TEX R3, R4, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, c[2].y;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R1;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.y, -R1;
MOV R4.x, R0.z;
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R2, R2, R3;
MOV R4.x, R1.z;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R3, R4, texture[0], 2D;
ADD R3, R2, R3;
MOV R4.x, -R1;
MOV R4.y, c[2];
ADD R4.xy, fragment.texcoord[0], R4;
TEX R4, R4, texture[0], 2D;
ADD R3, R3, R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
ADD R2, R3, R2;
MOV R3.x, R1;
MOV R3.y, c[2];
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.x, R0.z;
MOV R3.y, c[2];
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, R1.z;
ADD R3.zw, fragment.texcoord[0].xyxy, R3.xyxy;
TEX R4, R3.zwzw, texture[0], 2D;
ADD R2, R2, R4;
MOV R3.y, R1;
MOV R3.x, -R1;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R3, R3, texture[0], 2D;
ADD R2, R2, R3;
MOV R3.y, R1;
MOV R3.x, c[2].y;
ADD R3.xy, fragment.texcoord[0], R3;
TEX R4, R3, texture[0], 2D;
TEX R3, R0, texture[0], 2D;
MOV R0.y, R1;
MOV R0.x, R0.z;
ADD R2, R2, R4;
ADD R2, R2, R3;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R1.zwzw;
ADD R2, R2, R3;
TEX R3, R0, texture[0], 2D;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, -R1;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
MOV R1.y, R0.w;
ADD R1.xy, fragment.texcoord[0], R1;
ADD R2, R2, R3;
MOV R0.y, R0.w;
MOV R0.x, c[2].y;
ADD R0.xy, fragment.texcoord[0], R0;
TEX R3, R0, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R0.zwzw;
ADD R2, R2, R3;
TEX R1, R1, texture[0], 2D;
ADD R1, R2, R1;
TEX R0, R0, texture[0], 2D;
ADD R1, R1, R0;
MUL R1, R1, c[2].w;
TEX R2, fragment.texcoord[2], texture[2], 2D;
TXP R0.xyz, fragment.texcoord[1], texture[1], 2D;
MUL R2.xyz, R2.w, R2;
MAD R0.xyz, R2, c[3].x, R0;
MUL result.color.xyz, R1, R0;
MOV result.color.w, R1;
END
# 127 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 31 math, 7 textures, 5 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_TexWidth]
Float 1 [_TexHeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 0.00000000, -2.00000000, 2.00000000, 1.00000000
defi i0, 5, 0, 1, 0
def c3, 0.04000000, 8.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
mov r1, c2.x
rcp r3.x, c0.x
rcp r3.y, c1.x
mov r3.z, c2.x
loop aL, i0
add r0.x, r3.z, c2.y
mul r4.y, r3, r0.x
mov r0.y, r4
mul r0.x, r3, c2.y
add r0.xy, v0, r0
texld r0, r0, s0
add r2, r1, r0
mov r0.w, r4.y
mov r0.z, c2.x
add r1.xy, v0, r0.zwzw
texld r1, r1, s0
mov r0.y, r4
mov r0.x, -r3
add r0.xy, v0, r0
texld r0, r0, s0
add r0, r2, r0
add r2, r0, r1
mul r4.x, r3, c2.z
add r1.xy, v0, r4
mov r0.y, r4
mov r0.x, r3
add r0.xy, v0, r0
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r1, r0, r1
add r3.z, r3, c2.w
endloop
mul r1, r1, c3.x
texld r0, v2, s2
texldp r2.xyz, v1, s1
mul_pp r0.xyz, r0.w, r0
mad_pp r0.xyz, r0, c3.y, r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 14 math, 3 textures, 2 branches
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_TexWidth]
Float 52 [_TexHeight]
BindCB  "$Globals" 0
"ps_4_0
eefiecedomaobjapkkabgkpkagdmgekbheboaiogabaaaaaajmaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckmadaaaaeaaaaaaaolaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaaldcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiacaaaaaaaaaaaadaaaaaa
dgaaaaaipcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeadakaabaaaacaaaaaa
boaaaaakmcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
abaaaaaapoppppppclaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaaabeaaaaaafaaaaaa
adaaaeaddkaabaaaaaaaaaaaboaaaaakmcaabaaaacaaaaaakgakbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaabaaaaaapoppppppclaaaaaficaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahjcaabaaaacaaaaaaagaebaaaacaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaa
bgaaaaabdgaaaaafpcaabaaaabaaaaaaegaobaaaadaaaaaabgaaaaabdiaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaknhcddnaknhcddnaknhcddn
aknhcddnaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdcaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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