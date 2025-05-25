ˆºShader "Furby/Eyes" {
Properties {
 _Texture ("Texture (RGBA)", 2D) = "white" {}
 _NumLines ("Num Lines", Float) = 150
 _LineWidth ("Line Width", Range(0,1)) = 0.25
 _GridColour ("Grid Colour", Color) = (0.15,0.15,0.15,1)
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _NumLines;
uniform highp float _LineWidth;
uniform highp vec3 _GridColour;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Texture, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp float ret_3;
  highp float tmpvar_4;
  tmpvar_4 = abs((fract((xlv_TEXCOORD0.x * _NumLines)) - 0.5));
  ret_3 = 0.0;
  if ((tmpvar_4 > _LineWidth)) {
    ret_3 = 0.0;
  } else {
    highp float tmpvar_5;
    tmpvar_5 = (tmpvar_4 / _LineWidth);
    ret_3 = (1.0 - ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5))));
  };
  highp float ret_6;
  highp float tmpvar_7;
  tmpvar_7 = abs((fract((xlv_TEXCOORD0.y * _NumLines)) - 0.5));
  ret_6 = 0.0;
  if ((tmpvar_7 > _LineWidth)) {
    ret_6 = 0.0;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7 / _LineWidth);
    ret_6 = (1.0 - ((tmpvar_8 * tmpvar_8) * (3.0 - (2.0 * tmpvar_8))));
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2.xyz + ((ret_3 + ret_6) * _GridColour));
  c_1.xyz = tmpvar_9;
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