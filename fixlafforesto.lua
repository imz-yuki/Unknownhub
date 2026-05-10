-- [[ ZENONIX HUB - SUPER POTATO MODE (FORESTO) ]] --
-- ✮-> yuki.dev

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- ==========================================
-- 1. CAN THIỆP SÂU VÀO SETTINGS CỦA ENGINE (FPS BOOST)
-- ==========================================
local settings = settings()
pcall(function()
    settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings.Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
end)

-- ==========================================
-- 2. KHÓA BẢO VỆ NHÂN VẬT (GIỮ SKIN & ANIMATION)
-- ==========================================
local function isPlayerAsset(instance)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and instance:IsDescendantOf(player.Character) then
            return true
        end
    end
    return false
end

-- ==========================================
-- 3. THUẬT TOÁN HỦY DIỆT ĐỒ HỌA (CLAY & POTATO)
-- ==========================================
local function superOptimize(obj)
    if isPlayerAsset(obj) then return end -- Giữ nguyên Skin/Anim/Clothing của người chơi
    
    -- Xóa màu, khử răng cưa và chuyển về SmoothPlastic
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
        obj.Color = Color3.fromRGB(110, 110, 112) -- Đưa về màu xám đất sét siêu tối giản
        obj.CastShadow = false
        obj.Reflectance = 0
        
        -- Nếu là MeshPart, hạ cấu hình dựng hình và xóa Texture gốc
        if obj:IsA("MeshPart") then
            obj.TextureID = ""
            obj.RenderFidelity = Enum.RenderFidelity.Performance
        end
        
    -- Xóa các file Texture dán, Decal vẽ trên tường/đất
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj:Destroy()
        
    -- Xóa lưới Mesh phụ của các Part thường
    elseif obj:IsA("SpecialMesh") then
        obj.TextureId = ""
        
    -- Xóa sạch nguồn sáng trong map (Giảm tải đổ bóng GPU)
    elseif obj:IsA("Light") then -- Gồm PointLight, SpotLight, SurfaceLight
        obj:Destroy()
        
    -- Hủy diệt mọi loại hiệu ứng hạt, khói, lửa, tia sáng
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or 
           obj:IsA("Sparkles") or obj:IsA("Trail") or obj:IsA("Beam") then
        obj:Destroy()
    end
end

-- ==========================================
-- 4. TRIỂN KHAI DỌN DẸP TOÀN BỘ WORKSPACE
-- ==========================================
task.spawn(function()
    local descendants = Workspace:GetDescendants()
    local batchLimit = 300 -- Xử lý 300 objects mỗi đợt để không đơ game
    local count = 0
    
    for _, desc in ipairs(descendants) do
        superOptimize(desc)
        count = count + 1
        if count >= batchLimit then
            count = 0
            task.wait()
        end
    end
    
    -- Quét thời gian thực (Real-time sweep) cho map load động
    Workspace.DescendantAdded:Connect(function(newObj)
        task.wait(0.05)
        superOptimize(newObj)
    end)
end)

-- ==========================================
-- 5. TRIỆT TIÊU ĐỒ HỌA NƯỚC & ĐỊA HÌNH
-- ==========================================
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
if Terrain then
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 1
end

-- ==========================================
-- 6. HACK ÁNH SÁNG MÔI TRƯỜNG (SÁNG RÕ NHƯ BAN NGÀY - KHÔNG LAG)
-- ==========================================
task.spawn(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9 -- Xóa sương mù hoàn toàn
    Lighting.FogStart = 0
    Lighting.Brightness = 0 -- Tắt độ chói mặt trời
    
    -- Hack độ sáng Ambient để dù không có đèn vẫn nhìn rõ map Clay xám
    Lighting.Ambient = Color3.fromRGB(180, 180, 180)
    Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
    
    -- Xóa toàn bộ hiệu ứng hậu kỳ nặng nề trong Lighting
    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("Atmosphere") or effect:IsA("Sky") or effect:IsA("Clouds") then
            effect:Destroy()
        end
    end
    
    -- Chặn game tự hồi phục hiệu ứng ánh sáng
    Lighting.ChildAdded:Connect(function(child)
        if child:IsA("PostEffect") or child:IsA("Atmosphere") or child:IsA("Sky") then
            task.wait()
            child:Destroy()
        end
    end)
end)

print("------------------------------------------")
print("🚀 Zenonix Ultra Potato Mode Activated!")
print("👑 Built by: Yuki")
print("🔥 Specs: Clay Mode [ON] | Lights [OFF] | Skins Saved")
print("------------------------------------------")
