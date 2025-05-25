á‡Shader "RS Mobile/BRDF/BRDFAtlas AnisotropicSpecular" {
Properties {
 _MainTex ("Diffuse (RGB) Alpha (A)", 2D) = "white" {}
 _Specular ("Specular", Float) = 1
 _Gloss ("Gloss", Float) = 0.06
 _AnisoOffset ("Anisotropic Highlight Offset", Range(-1,1)) = -0.2
 _Ramp2D ("BRDF Ramp", 2D) = "gray" {}
 _NumAtlasesX ("X Atlases", Float) = 1
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
varying highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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
out highp vec3 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_6;
  tmpvar_6.x = _World2Object[0].x;
  tmpvar_6.y = _World2Object[0].y;
  tmpvar_6.z = _World2Object[0].z;
  highp vec3 tmpvar_7;
  tmpvar_7.x = _World2Object[1].x;
  tmpvar_7.y = _World2Object[1].y;
  tmpvar_7.z = _World2Object[1].z;
  highp vec3 tmpvar_8;
  tmpvar_8.x = _World2Object[2].x;
  tmpvar_8.y = _World2Object[2].y;
  tmpvar_8.z = _World2Object[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_1, tmpvar_6);
  tmpvar_9.y = dot (tmpvar_1, tmpvar_7);
  tmpvar_9.z = dot (tmpvar_1, tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (dot (tmpvar_4, tmpvar_9) * 0.9);
  tmpvar_10.y = ((dot (worldSpaceLightDir_2, tmpvar_9) * 0.4) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(1.0, 0.0);
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_11);
  tmpvar_3.xy = ((clamp (tmpvar_10, 0.0, 1.0) * tmpvar_12.xy) + tmpvar_12.zw);
  tmpvar_3.z = dot (normalize((tmpvar_4 + worldSpaceLightDir_2)), tmpvar_9);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform highp float _AnisoOffset;
uniform highp vec3 _SpecularHighlightColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float spec_2;
  lowp float aniso_3;
  lowp float HdotA_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Ramp2D, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.z;
  HdotA_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (0.0, sin((3.14159 * (HdotA_4 + _AnisoOffset))));
  aniso_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD1.z;
  spec_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = mix (spec_2, aniso_3, tmpvar_6.w);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((pow (tmpvar_10, (_Gloss * 128.0)) * _Specular), 0.0, 1.0);
  spec_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = ((2.0 * _LightColor0.xyz) * ((tmpvar_5.xyz * tmpvar_6.xyz) + (spec_2 * _SpecularHighlightColor)));
  c_1.xyz = tmpvar_12;
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