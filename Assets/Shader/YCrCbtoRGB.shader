æShader "Color Space/YCbCrtoRGB" {
Properties {
 _YTex ("Y (RGB)", 2D) = "black" {}
 _CrTex ("Cr (RGB)", 2D) = "gray" {}
 _CbTex ("Cb (RGB)", 2D) = "gray" {}
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog {
   Color (0,0,0,0)
  }
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _YTex_ST;
uniform highp vec4 _CbTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _YTex_ST.xy) + _YTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CbTex_ST.xy) + _CbTex_ST.zw);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _YTex;
uniform sampler2D _CbTex;
uniform sampler2D _CrTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.x = texture2D (_YTex, xlv_TEXCOORD0).x;
  tmpvar_1.y = texture2D (_CrTex, xlv_TEXCOORD1).y;
  tmpvar_1.z = texture2D (_CbTex, xlv_TEXCOORD1).z;
  lowp vec4 rgbVec_2;
  rgbVec_2.x = dot (vec4(1.16438, 1.59603, 0.0, -0.870785), tmpvar_1);
  rgbVec_2.y = dot (vec4(1.16438, -0.812969, -0.391762, 0.529594), tmpvar_1);
  rgbVec_2.z = dot (vec4(1.16438, 0.0, 2.01723, -1.08139), tmpvar_1);
  rgbVec_2.w = 1.0;
  gl_FragData[0] = rgbVec_2;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _YTex_ST;
uniform highp vec4 _CbTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _YTex_ST.xy) + _YTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CbTex_ST.xy) + _CbTex_ST.zw);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _YTex;
uniform sampler2D _CbTex;
uniform sampler2D _CrTex;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.x = texture (_YTex, xlv_TEXCOORD0).x;
  tmpvar_1.y = texture (_CrTex, xlv_TEXCOORD1).y;
  tmpvar_1.z = texture (_CbTex, xlv_TEXCOORD1).z;
  lowp vec4 rgbVec_2;
  rgbVec_2.x = dot (vec4(1.16438, 1.59603, 0.0, -0.870785), tmpvar_1);
  rgbVec_2.y = dot (vec4(1.16438, -0.812969, -0.391762, 0.529594), tmpvar_1);
  rgbVec_2.z = dot (vec4(1.16438, 0.0, 2.01723, -1.08139), tmpvar_1);
  rgbVec_2.w = 1.0;
  _glesFragData[0] = rgbVec_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
}