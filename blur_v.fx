texture tex0;
float2 imageSize = {256.0,256.0};
float pixelDiff = 1.0;
sampler sBase=sampler_state{
    Texture=(tex0);
    AddressU = CLAMP;
    AddressV = CLAMP;
    AddressW = CLAMP;
};
float4 ps_main(in float2 Base:TEXCOORD0):COLOR
{
    float4 color = tex2D(sBase,Base.xy);
    if(color.a != 0.0)
    {
	float4 blur;
	float2 oldBase = Base;
	//
	Base.y = Base.y+1.0/imageSize.y*pixelDiff;
	if(Base.y > 1.0) Base.y = 1.0;
	blur = tex2D(sBase,Base.xy);
	if(blur.a != 0.0) color.rgb = sqrt((color.rgb*color.rgb+blur.rgb*blur.rgb)/2.0);
	//
	Base = oldBase;
	Base.y = Base.y-1.0/imageSize.y*pixelDiff;
	if(Base.y < 0.0) Base.y = 0.0;
	blur = tex2D(sBase,Base.xy);
	if(blur.a != 0.0) color.rgb = sqrt((color.rgb*color.rgb+blur.rgb*blur.rgb)/2.0);
	//
    }
    return color;
}

technique mask
{
    pass p0
    {
	PixelShader=compile ps_2_0 ps_main();
    }
}