// Based on https://github.com/Jam3/glsl-fast-gaussian-blur
const float4 gBase = { 1.3846153846,1.3846153846, 3.2307692308,3.2307692308 };

texture gTexture0;
float2 gImageSize = { 256.0,256.0 };
float2 gPixelOffset = { 0.0, 0.0 };

sampler gSampler=sampler_state{
    Texture=(gTexture0);
    AddressU = CLAMP;
    AddressV = CLAMP;
    AddressW = CLAMP;
};

float4 ps_main(in float2 Base:TEXCOORD0):COLOR
{
    float4 l_color = { 0.0, 0.0, 0.0, 0.0 };
    float2 l_offsetA = gBase.xy * gPixelOffset;
    float2 l_offsetB = gBase.zw * gPixelOffset;
    
    l_color += tex2D(gSampler,Base.xy) * 0.2270270270;
    l_color += tex2D(gSampler,Base.xy + l_offsetA/gImageSize)* 0.3162162162;
    l_color += tex2D(gSampler,Base.xy - l_offsetA/gImageSize)* 0.3162162162;
    l_color += tex2D(gSampler,Base.xy + l_offsetB/gImageSize)* 0.0702702703;
    l_color += tex2D(gSampler,Base.xy - l_offsetB/gImageSize)* 0.0702702703;
    
    return l_color;
}

technique mask
{
    pass p0
    {
	PixelShader=compile ps_2_0 ps_main();
    }
}