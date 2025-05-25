×óShader "RS Mobile/BRDF/BRDFAtlas CubeMapSpecular" {
Properties {
 _MainTex ("Diffuse (RGB) Alpha (A)", 2D) = "white" {}
 _Ramp2D ("BRDF Ramp", 2D) = "gray" {}
 _NumAtlasesX ("X Atlases", Float) = 1
 _CubeTex ("Reflection Cubemap", CUBE) = "black" {}
 _SpecularHighlightColor ("Specular Color", Color) = (1,1,1,1)
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Geometry" "RenderType"="Opaque" }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (textureCube (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
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
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec3 worldSpaceLightDir_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  worldSpaceLightDir_2 = tmpvar_5;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * tmpvar_1));
  highp vec3 tmpvar_8;
  highp vec3 i_9;
  i_9 = -(tmpvar_4);
  tmpvar_8 = (i_9 - (2.0 * (dot (tmpvar_7, i_9) * tmpvar_7)));
  tmpvar_3.yz = tmpvar_8.yz;
  tmpvar_3.x = -(tmpvar_8.x);
  highp vec3 tmpvar_10;
  tmpvar_10.x = _World2Object[0].x;
  tmpvar_10.y = _World2Object[0].y;
  tmpvar_10.z = _World2Object[0].z;
  highp vec3 tmpvar_11;
  tmpvar_11.x = _World2Object[1].x;
  tmpvar_11.y = _World2Object[1].y;
  tmpvar_11.z = _World2Object[1].z;
  highp vec3 tmpvar_12;
  tmpvar_12.x = _World2Object[2].x;
  tmpvar_12.y = _World2Object[2].y;
  tmpvar_12.z = _World2Object[2].z;
  highp vec3 tmpvar_13;
  tmpvar_13.x = dot (tmpvar_1, tmpvar_10);
  tmpvar_13.y = dot (tmpvar_1, tmpvar_11);
  tmpvar_13.z = dot (tmpvar_1, tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (dot (tmpvar_4, tmpvar_13) * 0.9);
  tmpvar_14.y = ((dot (worldSpaceLightDir_2, tmpvar_13) * 0.4) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_16;
  tmpvar_16.yw = vec2(1.0, 0.0);
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_15);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_14, 0.0, 1.0) * tmpvar_16.xy) + tmpvar_16.zw);
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform lowp samplerCube _CubeTex;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Ramp2D, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_CubeTex, xlv_TEXCOORD2).xyz * tmpvar_3.w).x;
  highp vec3 tmpvar_5;
  tmpvar_5 = ((2.0 * _LightColor0.xyz) * ((tmpvar_2.xyz * tmpvar_3.xyz) + (tmpvar_4 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_5;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }
}
Fallback "Diffuse"
}