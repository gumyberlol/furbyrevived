¾Shader "Furby/Hose Shader (A-B mix)" {
Properties {
 _TextureA ("Texture A (RGBA)", 2D) = "white" {}
 _TextureB ("Texture B (RGBA)", 2D) = "white" {}
 _TextureMix ("Texture Mix", Range(0,1)) = 1
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Opaque" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _TextureA_ST;
uniform highp vec4 _TextureB_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _TextureA_ST.xy) + _TextureA_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _TextureB_ST.xy) + _TextureB_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp float _TextureMix;
uniform sampler2D _TextureA;
uniform sampler2D _TextureB;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_TextureA, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_TextureB, xlv_TEXCOORD1);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_2 * _TextureMix) + (tmpvar_3 * (1.0 - _TextureMix)));
  c_1 = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _TextureA_ST;
uniform highp vec4 _TextureB_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _TextureA_ST.xy) + _TextureA_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _TextureB_ST.xy) + _TextureB_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp float _TextureMix;
uniform sampler2D _TextureA;
uniform sampler2D _TextureB;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_TextureA, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_TextureB, xlv_TEXCOORD1);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_2 * _TextureMix) + (tmpvar_3 * (1.0 - _TextureMix)));
  c_1 = tmpvar_4;
  _glesFragData[0] = c_1;
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