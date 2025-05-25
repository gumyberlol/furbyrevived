¨—Shader "RS Mobile/Specular/Texture/Alpha" {
Properties {
 _Texture ("Texture (RGBA)", 2D) = "white" {}
 _CubeTex ("Reflection Cubemap", CUBE) = "black" {}
}
SubShader { 
 LOD 80
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * normalize(_glesNormal)));
  highp vec3 tmpvar_4;
  highp vec3 i_5;
  i_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (i_5 - (2.0 * (dot (tmpvar_3, i_5) * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec4 tmpvar_5;
  highp vec3 lightDir_6;
  lightDir_6 = _WorldSpaceLightPos0.xyz;
  lowp float diff_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (tmpvar_4, lightDir_6), 0.0, 1.0);
  diff_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (_LightColor0.xyz * diff_7);
  tmpvar_5 = tmpvar_9;
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 i_12;
  i_12 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_11 = (i_12 - (2.0 * (dot (tmpvar_4, i_12) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_11.yz;
  tmpvar_2.x = -(tmpvar_11.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
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
}