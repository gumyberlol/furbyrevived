ŒÈShader "RS Mobile/BRDF/BRDFAtlas Specular" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Ramp2D ("BRDF Ramp", 2D) = "gray" {}
 _NumAtlasesX ("X Atlases", Float) = 8
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture2D (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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
uniform highp vec4 _MainTex_ST;
uniform highp float _NumAtlasesX;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 lightDir_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  lowp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = (dot (tmpvar_3, tmpvar_4) * 0.9);
  tmpvar_6.y = ((dot (tmpvar_3, lightDir_1) * 0.4) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(_NumAtlasesX));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(1.0, 0.0);
  tmpvar_8.x = tmpvar_7;
  tmpvar_8.z = (floor((_glesMultiTexCoord1.x + 0.5)) * tmpvar_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((clamp (tmpvar_6, 0.0, 1.0) * tmpvar_8.xy) + tmpvar_8.zw);
  xlv_TEXCOORD2 = normalize((lightDir_1 + tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp float nh_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD2), 0.0, 1.0);
  nh_2 = tmpvar_4;
  c_1.xyz = ((tmpvar_3.xyz * _LightColor0.xyz) * ((texture (_Ramp2D, xlv_TEXCOORD1).xyz * 2.0) + (pow (nh_2, 20.0) * tmpvar_3.w)));
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