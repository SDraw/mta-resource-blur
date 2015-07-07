local texture = dxCreateTexture("blur/image.png","argb",false,"clamp")
local target = dxCreateRenderTarget(256,256,false)
local shader1 = dxCreateShader("blur/blur_h.fx")
local shader2 = dxCreateShader("blur/blur_v.fx")

dxSetShaderValue(shader1,"tex0",texture)
dxSetShaderValue(shader1,"imageSize",{ 256.0,256.0 })
dxSetShaderValue(shader2,"tex0",target)
dxSetShaderValue(shader2,"imageSize",{ 256.0,256.0 })

if(shader1 and shader2) then
        addEventHandler("onClientRender",root,function()
            local val = getTickCount()/1000%5
            
            dxSetShaderValue(shader1,"pixelDiff",val)
            dxSetRenderTarget(target)
            dxDrawImage(0,0,256,256,shader1)
            dxSetRenderTarget()
            
            dxSetShaderValue(shader2,"pixelDiff",val)
            dxDrawText(tostring(val),0,256,256,272,tocolor(255,255,255),1,"default")
            dxDrawImage(0,0,256,256,shader2)
            dxDrawImage(256,0,256,256,texture)
        end
    )
end
outputDebugString("Good?")
