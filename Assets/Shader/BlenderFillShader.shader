ƝShader "Furby/BlenderFillShader" {
Properties {
 _Texture ("Texture (RGBA)", 2D) = "white" {}
 _DebugColour1 ("In #1", Color) = (1,1,1,1)
 _DebugColour2 ("In #2", Color) = (1,1,1,1)
 _DebugColour3 ("In #3", Color) = (1,1,1,1)
 _DebugColourMix ("Mix", Color) = (1,1,1,1)
 _Hue ("Colorize Hue", Float) = 0.5
 _Sat ("Colorize Saturation", Float) = 0.5
 _Val ("Colorize Value", Float) = 0.5
 _SatA ("Amount Saturation", Float) = 0
 _ValA ("Amount Value", Float) = 0
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Texture_ST;
uniform highp vec4 unity_LightmapST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform sampler2D unity_Lightmap;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  gl_FragData[0] = c_2;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Texture_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  lightDir_4 = _WorldSpaceLightPos0.xyz;
  lowp float diff_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (dot ((tmpvar_2 * normalize(_glesNormal)), lightDir_4), 0.0, 1.0);
  diff_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (_LightColor0.xyz * diff_5);
  tmpvar_3 = tmpvar_7;
  tmpvar_1 = tmpvar_3;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz + glstate_lightmodel_ambient.xyz);
  tmpvar_1.xyz = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Texture;
uniform highp float _Hue;
uniform highp float _Sat;
uniform highp float _Val;
uniform highp float _SatA;
uniform highp float _ValA;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 hsl_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_Texture, xlv_TEXCOORD0) * xlv_COLOR);
  c_2.w = tmpvar_3.w;
  c_2.xyz = (tmpvar_3.xyz * 2.0);
  highp vec3 RGB_4;
  RGB_4 = c_2.xyz;
  highp vec3 HSV_5;
  HSV_5.xy = vec2(0.0, 0.0);
  HSV_5.z = max (RGB_4.x, max (RGB_4.y, RGB_4.z));
  highp float tmpvar_6;
  tmpvar_6 = (HSV_5.z - min (RGB_4.x, min (RGB_4.y, RGB_4.z)));
  if ((tmpvar_6 != 0.0)) {
    highp vec3 Delta_7;
    HSV_5.y = (tmpvar_6 / HSV_5.z);
    highp vec3 tmpvar_8;
    tmpvar_8 = ((HSV_5.z - RGB_4) / tmpvar_6);
    Delta_7 = (tmpvar_8 - tmpvar_8.zxy);
    Delta_7.xy = (Delta_7.xy + vec2(2.0, 4.0));
    if ((RGB_4.x >= HSV_5.z)) {
      HSV_5.x = Delta_7.z;
    } else {
      if ((RGB_4.y >= HSV_5.z)) {
        HSV_5.x = Delta_7.x;
      } else {
        HSV_5.x = Delta_7.y;
      };
    };
    HSV_5.x = fract((HSV_5.x / 6.0));
  };
  hsl_1.z = HSV_5.z;
  hsl_1.x = _Hue;
  hsl_1.y = (HSV_5.y * (1.0 - _SatA));
  hsl_1.y = ((hsl_1.y * (1.0 - _SatA)) + (_Sat * _SatA));
  hsl_1.z = ((HSV_5.z * (1.0 - _ValA)) + (_Val * _ValA));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = (abs(((_Hue * 6.0) - 3.0)) - 1.0);
  tmpvar_10.y = (2.0 - abs(((_Hue * 6.0) - 2.0)));
  tmpvar_10.z = (2.0 - abs(((_Hue * 6.0) - 4.0)));
  tmpvar_9 = ((((clamp (tmpvar_10, 0.0, 1.0) - 1.0) * hsl_1.y) + 1.0) * hsl_1.z);
  c_2.xyz = tmpvar_9;
  c_2.w = 0.0;
  _glesFragData[0] = c_2;
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