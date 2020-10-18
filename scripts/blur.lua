blur = {}

function blur.onClientResourceStart()
    blur.m_texture = DxTexture("images/cube.png","argb",false,"clamp")
    blur.m_shader = DxShader("shaders/blur.fx",0,0,false,"other")
    blur.m_offset = { 0.0, 0.0 }
    
    blur.m_shader:setValue("gTexture0",blur.m_texture)
    blur.m_shader:setValue("gImageSize",{ blur.m_texture:getSize() })
    blur.m_shader:setValue("gPixelOffset",blur.m_offset)
    
    addEventHandler("onClientRender",root,blur.onClientRender)
end
addEventHandler("onClientResourceStart",resourceRoot,blur.onClientResourceStart)

function blur.onClientRender()
    local self = blur
    
    local l_offset = math.abs(math.cos((getTickCount()%5000)/5000*math.pi))
    self.m_offset[1] = l_offset
    self.m_offset[2] = l_offset
    
    blur.m_shader:setValue("gPixelOffset",blur.m_offset)
    dxDrawImage(0,256,256,256,blur.m_shader)
end
