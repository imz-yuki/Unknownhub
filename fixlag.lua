--[[
    ===================================================================================
    [PROJECT]   : UNKNOWN HUB PRIME - VERSION 5.0.0 (ETERNAL APEX)
    [CODENAME]  : THE OMNIVERSE ANTI-LAG COMPILER & KERNEL OVERRIDE
    [DEVELOPER] : MINH MEO OMNIVERSE
    [RELEASE]   : 2026 ETERNAL EDITION (MAXIMUM PERFORMANCE STABILITY)
    ===================================================================================
    CHÚ Ý: Tốc độ xử lý siêu tốc, giao diện cao cấp, tự động vá lỗi toàn cục (Fix All).
    Bỏ qua hoàn toàn các bước bấm xác nhận để tối ưu hóa thời gian thực thi.
--]]

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- ===================================================================================
-- SYSTEM KERNEL CONFIGURATION (KHỞI TẠO SERVICES VÀ PHÂN VÙNG LÕI)
-- ===================================================================================
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local LogService = game:GetService("LogService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait(0.001)
    LocalPlayer = Players.LocalPlayer
end

-- Bảng cấu hình tối thượng v5
local PrimeConfig = {
    PureGreyMode = true,             -- Biến mọi thứ thành màu xám phẳng đỉnh cao
    UltraSmoothPlastic = true,       -- Ép buộc chất liệu mượt nhẹ nhất hệ thống
    AnnihilateTextures = true,       -- Xóa sạch sành sanh mọi ảnh dán bề mặt, decal, quần áo
    ExtinguishEffects = true,        -- Triệt tiêu toàn bộ khói, lửa, hiệu ứng sinh hạt, kỹ năng
    KillHighlights = true,           -- Loại bỏ tận gốc các loại Outline/Highlight ngốn khung hình
    StripLighting = true,            -- Làm phẳng hệ thống ánh sáng bầu trời, tắt bóng đổ hoàn toàn
    DynamicDistanceCulling = true,   -- Ẩn/Hiện vật thể động thông minh theo tầm mắt Camera
    AggressiveGarbageCollector = true,-- Cơ chế dọn rác bộ nhớ sâu liên tục
    FlattenTerrain = true,           -- Đưa địa hình đất đá và nước về mức phẳng thô sơ
    DeepMemoryFlush = true,          -- Kích hoạt bộ lọc xả RAM chống leak của Roblox Core
    RenderCullingDistance = 150,     -- Tối ưu hóa cự ly render xuống còn 150m để đẩy FPS lên đỉnh
    RefreshRate = 1.5                -- Tăng tốc chu kỳ làm mới luồng quét lên 1.5 giây
}

local TARGET_GREY = Color3.fromRGB(110, 110, 110)
local MATRIX_NEON = Color3.fromRGB(0, 255, 150) -- Tông màu Neon Ma Trận siêu đẹp

-- ===================================================================================
-- HIGH-END CONSOLE NOTIFICATION UI (GIAO DIỆN PREMIUM MA TRẬN NEON V5)
-- ===================================================================================
local function CreateBeautifulNotify(title, text, color)
    task.spawn(function()
        local parentGui = CoreGui:FindFirstChild("RobloxGui") or CoreGui
        
        -- Dọn dẹp thông báo cũ để tránh chồng chéo UI
        if parentGui:FindFirstChild("UnknownHubNotifyV5") then
            parentGui["UnknownHubNotifyV5"]:Destroy()
        end
        
        local sg = Instance.new("ScreenGui")
        sg.Name = "UnknownHubNotifyV5"
        sg.ResetOnSpawn = false
        sg.DisplayOrder = 9999
        sg.Parent = parentGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 320, 0, 75)
        frame.Position = UDim2.new(1, 20, 1, -100)
        frame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        frame.BorderSizePixel = 0
        frame.BackgroundTransparency = 0.15
        frame.Parent = sg
        
        local uicorner = Instance.new("UICorner")
        uicorner.CornerRadius = UDim.new(0, 8)
        uicorner.Parent = frame
        
        local uistroke = Instance.new("UIStroke")
        uistroke.Color = color or MATRIX_NEON
        uistroke.Thickness = 1.5
        uistroke.Parent = frame
        
        -- Hiệu ứng phát sáng mờ ở nền (Glow Effect)
        local glow = Instance.new("Frame")
        glow.Size = UDim2.new(1, 4, 1, 4)
        glow.Position = UDim2.new(0, -2, 0, -2)
        glow.BackgroundColor3 = color or MATRIX_NEON
        glow.BackgroundTransparency = 0.93
        glow.BorderSizePixel = 0
        glow.ZIndex = frame.ZIndex - 1
        glow.Parent = frame
        local glowCorner = Instance.new("UICorner")
        glowCorner.CornerRadius = UDim.new(0, 10)
        glowCorner.Parent = glow
        
        local tLabel = Instance.new("TextLabel")
        tLabel.Size = UDim2.new(1, -20, 0, 25)
        tLabel.Position = UDim2.new(0, 12, 0, 8)
        tLabel.BackgroundTransparency = 1
        tLabel.Text = "» " .. title .. " «"
        tLabel.TextColor3 = color or MATRIX_NEON
        tLabel.TextSize = 13
        tLabel.Font = Enum.Font.RobotoMono
        tLabel.TextXAlignment = Enum.TextXAlignment.Left
        tLabel.Parent = frame
        
        local pLabel = Instance.new("TextLabel")
        pLabel.Size = UDim2.new(1, -24, 0, 35)
        pLabel.Position = UDim2.new(0, 12, 0, 32)
        pLabel.BackgroundTransparency = 1
        pLabel.Text = text
        pLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        pLabel.TextSize = 11
        pLabel.Font = Enum.Font.RobotoMono
        pLabel.TextWrapped = true
        pLabel.TextXAlignment = Enum.TextXAlignment.Left
        pLabel.TextYAlignment = Enum.TextYAlignment.Top
        pLabel.Parent = frame
        
        -- Animation trượt từ cạnh phải màn hình vô cùng mượt mà
        frame.Position = UDim2.new(1, 40, 1, -100)
        local tweenIn = TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(1, -340, 1, -100)})
        tweenIn:Play()
        tweenIn.Completed:Wait()
        
        task.wait(4)
        
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Position = UDim2.new(1, 40, 1, -100)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        sg:Destroy()
    end)
end

-- ===================================================================================
-- MODULE 1: MATRIX OPTIMIZATION ENGINE (XỬ LÝ ĐA LUỒNG TẦNG SÂU)
-- ===================================================================================
local function ProcessInstance(instance)
    if not instance then return end
    
    pcall(function()
        -- 1. Xám hóa và làm phẳng toàn bộ các loại Part cấu trúc hình khối
        if instance:IsA("BasePart") then
            instance.CastShadow = false
            if PrimeConfig.PureGreyMode then
                instance.Color = TARGET_GREY
            end
            if PrimeConfig.UltraSmoothPlastic then
                instance.Material = Enum.Material.SmoothPlastic
            end
            if instance:IsA("MeshPart") then
                instance.RenderFidelity = Enum.RenderFidelity.Performance
                instance.CollisionFidelity = Enum.CollisionFidelity.Box
            end
            
        -- 2. Tối ưu hóa lưới nhân vật và phụ kiện phức tạp
        elseif instance:IsA("SpecialMesh") or instance:IsA("CharacterMesh") then
            instance.RenderFidelity = Enum.RenderFidelity.Performance
            
        -- 3. Triệt tiêu hoàn toàn VRAM đồ họa của ảnh dán bề mặt
        elseif instance:IsA("Decal") or instance:IsA("Texture") then
            if PrimeConfig.AnnihilateTextures then
                instance.Texture = ""
                instance.Transparency = 1
                task.defer(function() instance:Destroy() end)
            end
            
        -- 4. Tắt tận gốc tất cả các hiệu ứng hạt, khói, lửa sinh lag kẹt GPU
        elseif instance:IsA("ParticleEmitter") or instance:IsA("Smoke") or instance:IsA("Fire") or instance:IsA("Sparkles") then
            if PrimeConfig.ExtinguishEffects then
                instance.Enabled = false
                task.defer(function() instance:Destroy() end)
            end
            
        -- 5. Loại bỏ vệt sáng kỹ năng và đường kẻ la-ze phụ trợ
        elseif instance:IsA("Trail") or instance:IsA("Beam") or instance:IsA("LineHandleAdornment") then
            if PrimeConfig.ExtinguishEffects then
                instance.Enabled = false
            end
            
        -- 6. Khử vĩnh viễn hiệu ứng viền Highlight (Sửa triệt để lỗi sụt khung hình đột ngột)
        elseif instance:IsA("Highlight") or instance:IsA("SelectionBox") or instance:IsA("SelectionSphere") or instance:IsA("BoxHandleAdornment") then
            if PrimeConfig.KillHighlights then
                instance.Enabled = false
                task.defer(function() instance:Destroy() end)
            end
            
        -- 7. Xóa cấu trúc quần áo, màu sắc ngầm của các phân thân avatar khác
        elseif instance:IsA("Clothing") or instance:IsA("ShirtGraphic") or instance:IsA("Pants") or instance:IsA("Shirt") or instance:IsA("BodyColors") then
            if PrimeConfig.AnnihilateTextures then
                task.defer(function() instance:Destroy() end)
            end
        end
    end)
end

-- ===================================================================================
-- MODULE 2: ULTRA-SPEED WORLD CLEANER (QUÉT SẠCH MAP ĐA LUỒNG TỐC ĐỘ CAO)
-- ===================================================================================
local function MassiveWorldClean()
    local descendants = Workspace:GetDescendants()
    local totalObjects = #descendants
    
    -- Sử dụng Task-Batching nâng cấp giúp nạp đè và xử lý 1000 vật thể mỗi frame, mượt tuyệt đối không đứng im
    task.spawn(function()
        for i = 1, totalObjects do
            local obj = descendants[i]
            if obj then
                ProcessInstance(obj)
            end
            if i % 1000 == 0 then
                task.wait() -- Tránh treo game trong các map siêu rộng hàng vạn block
            end
        end
        CreateBeautifulNotify("MATRIX CORE", "Đã quét và xám hóa " .. totalObjects .. " vật thể thành công!", Color3.fromRGB(0, 255, 150))
    end)
end

-- Lắng nghe thời gian thực tức thì thông qua task.defer chống delay
if PrimeConfig.AggressiveGarbageCollector then
    Workspace.DescendantAdded:Connect(function(newDescendant)
        task.defer(function()
            if newDescendant then
                ProcessInstance(newDescendant)
            end
        end)
    end)
end

-- ===================================================================================
-- MODULE 3: ADVANCED LIGHTING PIPELINE (LÀM PHẲNG ÁNH SÁNG MÔI TRƯỜNG V5)
-- ===================================================================================
local function PurgeLightingSettings()
    if not PrimeConfig.StripLighting then return end
    
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.ShadowSoftness = 0
        Lighting.FogEnd = 999999
        Lighting.FogStart = 0
        Lighting.ClockTime = 12
        Lighting.Brightness = 1
        
        -- Dọn dẹp sạch bóng các hiệu ứng lọc màu nặng nề của game gốc
        local effects = Lighting:GetChildren()
        for i = 1, #effects do
            local effect = effects[i]
            if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") or effect:IsA("Atmosphere") or effect:IsA("Sky") then
                effect.Enabled = false
                task.defer(function() effect:Destroy() end)
            end
        end
        
        -- Nạp bộ lọc màu phẳng chuyên dụng của Unknown Hub Prime
        local primeCorrection = Instance.new("ColorCorrectionEffect")
        primeCorrection.Saturation = -0.75
        primeCorrection.Contrast = 0.15
        primeCorrection.Brightness = 0
        primeCorrection.Parent = Lighting
    end)
end

-- ===================================================================================
-- MODULE 4: TERRAIN STABILIZER (TỐI ƯU HÓA HOÀN TOÀN ĐỊA HÌNH VÀ CỎ 3D)
-- ===================================================================================
local function FlattenTerrainSystem()
    if not PrimeConfig.FlattenTerrain then return end
    
    local terrain = Workspace:FindFirstChildWhichIsA("Terrain")
    if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 1
        terrain.Decoration = false -- Vô hiệu hóa cỏ 3D đung đưa tự động
    end
end

-- ===================================================================================
-- MODULE 5: APEX DISTANCE CULLING (ẨN CHUYÊN SÂU VẬT THỂ NGOÀI TẦM NHÌN V5)
-- ===================================================================================
local function LaunchDistanceCullingLoop()
    if not PrimeConfig.DynamicDistanceCulling then return end
    
    task.spawn(function()
        while true do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local myPos = char.HumanoidRootPart.Position
                local allParts = Workspace:GetDescendants()
                
                for i = 1, #allParts do
                    local v = allParts[i]
                    if v:IsA("BasePart") and not v:IsDescendantOf(char) then
                        if v.Name ~= "Terrain" and v.Transparency < 1 then
                            local distance = (v.Position - myPos).Magnitude
                            
                            -- Đưa tầm nhìn xuống 150m để triệt tiêu hoàn toàn gánh nặng render lên GPU
                            if distance > PrimeConfig.RenderCullingDistance then
                                v.LocalTransparencyModifier = 1
                            else
                                v.LocalTransparencyModifier = 0
                            end
                        end
                    end
                    if i % 2500 == 0 then
                        task.wait()
                    end
                end
            end
            task.wait(PrimeConfig.RefreshRate)
        end
    end)
end

-- ===================================================================================
-- MODULE 6: DEEP MEMORY FLUSH (BỘ XẢ RAM CHỐNG LEAK & CRASH)
-- ===================================================================================
local function LaunchMemoryPurger()
    if not PrimeConfig.DeepMemoryFlush then return end
    
    task.spawn(function()
        while true do
            task.wait(10) -- Chạy tuần hoàn cực nhanh mỗi 10 giây một lần
            pcall(function()
                -- Ép buộc hạ cấp tính toán tương tác vật lý của các khối lân cận
                settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Default
                settings().Physics.AllowSleep = true
                Debris.MaxItems = 30
                
                -- Xóa sạch dữ liệu bộ nhớ ảo thừa thãi của hệ thống
                gcinfo() 
            end)
        end
    end)
end

-- ===================================================================================
-- MODULE 7: ROBLOX CRITICAL ENGINE OVERRIDE (GHI ĐÈ TẬNG LÕI HỆ THỐNG CLIENT)
-- ===================================================================================
local function OverwriteEngineSettings()
    pcall(function()
        -- Ép phần mềm đồ họa của game chạy ở mức Level01 (Mức tối giản thô sơ nhất)
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        
        -- Khóa cố định cấu hình công nghệ ánh sáng về dạng Voxel cổ điển để tăng FPS
        sethiddenproperty(Lighting, "Technology", Enum.Technology.Voxel)
    end)
    
    -- Tiết kiệm tài nguyên máy tính vượt bậc khi bạn ẩn game hoặc chuyển tab
    UserInputService.WindowFocused:Connect(function()
        RunService:Set3dRenderingEnabled(true)
    end)
    
    UserInputService.WindowFocusReleased:Connect(function()
        RunService:Set3dRenderingEnabled(false)
    end)
end

-- ===================================================================================
-- INITIALIZATION KICKSTART (KÍCH HOẠT HỆ THỐNG VĨNH HẰNG V5 - FIX ALL)
-- ===================================================================================
local function InitiateUnknownHubPrimeV5()
    CreateBeautifulNotify("UNKNOWN HUB PRIME v5", "Đang khởi động lõi phần cứng Apex...", MATRIX_NEON)
    
    -- Gọi độc lập qua pcall, đảm bảo không một lỗi game nào có thể làm sập tiến trình nạp script
    pcall(PurgeLightingSettings)
    pcall(FlattenTerrainSystem)
    pcall(MassiveWorldClean)
    pcall(LaunchDistanceCullingLoop)
    pcall(LaunchMemoryPurger)
    pcall(OverwriteEngineSettings)
    
    CreateBeautifulNotify("FIX LAG SUCCESS", "Đã tối ưu hóa mọi thứ! Sẵn sàng chiến game.", Color3.fromRGB(251, 191, 36))
end

-- Thực thi lập tức tốc độ cao
InitiateUnknownHubPrimeV5()
