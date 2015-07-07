texture tex0;
float2 imageSize = {256.0,256.0};
float pixelDiff = 1.0;
sampler sBase=sampler_state{
    Texture=(tex0);
};
float4 ps_h(in float2 Base:TEXCOORD0):COLOR
{
    float4 color = tex2D(sBase,Base.xy);
    if(color.a != 0.0)
    {
	float4 blur;
	float2 oldBase = Base;
	//
	Base = oldBase;
	Base.x = Base.x+1.0/imageSize.x*pixelDiff;
	if(Base.x > 1.0) Base.x = 1.0;
	blur = tex2D(sBase,Base.xy);
	if(blur.a != 0.0) color.rgb = sqrt((color.rgb*color.rgb+blur.rgb*blur.rgb)/2.0);
	//
	Base = oldBase;
	Base.x = Base.x-1.0/imageSize.x*pixelDiff;
	if(Base.x < 0.0) Base.x = 0.0;
	blur = tex2D(sBase,Base.xy);
	if(blur.a != 0.0) color.rgb = sqrt((color.rgb*color.rgb+blur.rgb*blur.rgb)/2.0);
	//
	//
	Base = oldBase;
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
float4 ps_v(in float2 Base:TEXCOORD0):COLOR
{
    float4 color = tex2D(sBase,Base.xy);
    if(color.a != 0.0)
    {
	float4 blur;
	float2 oldBase = Base;
	//
	Base = oldBase;
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
	PixelShader=compile ps_2_0 ps_h();
    }
//    pass p1
//    {
//	PixelShader=compile ps_2_0 ps_v();
//    }
}