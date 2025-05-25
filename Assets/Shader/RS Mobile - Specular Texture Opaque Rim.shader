тсShader "RS Mobile/Specular/Texture/Opaque/Rim" {
Properties {
 _Texture ("Texture (RGBA)", 2D) = "white" {}
 _CubeTex ("Reflection Cubemap", CUBE) = "black" {}
 _RimColor ("Rim Color", Color) = (0.26,0.19,0.16,0)
 _RimPower ("Rim Power", Range(0.5,8)) = 3
}
SubShader { 
 LOD 80
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
uniform sampler2D unity_Lightmap;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump float rim_1;
  highp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * normalize(_glesNormal)));
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (dot (normalize(tmpvar_5), tmpvar_4), 0.0, 1.0));
  rim_1 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 i_8;
  i_8 = -(tmpvar_5);
  tmpvar_7 = (i_8 - (2.0 * (dot (tmpvar_4, i_8) * tmpvar_4)));
  tmpvar_2.yz = tmpvar_7.yz;
  tmpvar_2.x = -(tmpvar_7.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (textureCube (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float rim_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((tmpvar_4 * normalize(_glesNormal)));
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (dot (normalize(tmpvar_6), tmpvar_5), 0.0, 1.0));
  rim_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec3 lightDir_9;
  lightDir_9 = _WorldSpaceLightPos0.xyz;
  lowp float diff_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (dot (tmpvar_5, lightDir_9), 0.0, 1.0);
  diff_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (_LightColor0.xyz * diff_10);
  tmpvar_8 = tmpvar_12;
  tmpvar_2 = tmpvar_8;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_2.xyz = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 i_15;
  i_15 = -(tmpvar_6);
  tmpvar_14 = (i_15 - (2.0 * (dot (tmpvar_5, i_15) * tmpvar_5)));
  tmpvar_3.yz = tmpvar_14.yz;
  tmpvar_3.x = -(tmpvar_14.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (_RimColor.xyz * pow (rim_1, _RimPower));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform lowp samplerCube _CubeTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * 2.0);
  c_1.xyz = (c_1.xyz + (texture (_CubeTex, xlv_TEXCOORD1).xyz * tmpvar_2.w));
  highp vec3 tmpvar_3;
  tmpvar_3 = (c_1.xyz + xlv_TEXCOORD2);
  c_1.xyz = tmpvar_3;
  c_1.w = 0.0;
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