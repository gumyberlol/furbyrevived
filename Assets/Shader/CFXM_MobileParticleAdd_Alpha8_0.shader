Shader "Cartoon FX/Mobile Particles Additive Alpha8" {
Properties {
 _MainTex ("Particle Texture (Alpha8)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Overlay+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Overlay+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest False
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  SetTexture [_MainTex] { combine primary, texture alpha * primary alpha }
 }
}
}