-- [[ ╔═══════════════════════════════════════════════╗ ]] --
-- [[     ZENONIX HUB v4 - ULTIMATE ESP SYSTEM        ]] --
-- [[               DEVELOPED BY: ʏᴜᴋɪ                ]] --
-- [[ ╚═══════════════════════════════════════════════╝ ]] --

-- Khởi tạo Rayfield UI Library (Độ ổn định cao hơn Orion)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌸 Zenonix Hub | Ultimate ESP",
   LoadingTitle = "Zenonix Loading...",
   LoadingSubtitle = "by Yuki",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false -- Tắt key để thực thi nhanh nhất
})

-- Khai báo Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Cấu hình hệ thống toàn cục
getgenv().ZenonixESP = {
    Master = false,
    Box = true,
    Name = true,
    Health = true,
    Tracer = true,
    TracerMode = "Bottom", -- "Bottom", "Center", "Top"
    Color = Color3.fromRGB(255, 105, 180), -- Hồng Zenonix
    OutlineColor = Color3.fromRGB(255, 255, 255) -- Viền trắng
}

local Cache = {}

-- Hàm khởi tạo các nét vẽ cho từng người chơi
local function CreateESP(player)
    if Cache[player] then return end
    
    local structures = {
        Box = Drawing.new("Square"),
        BoxOutline = Drawing.new("Square"),
        Tracer = Drawing.new("Line"),
        HealthBar = Drawing.new("Square"),
        HealthOutline = Drawing.new("Square"),
        Name = Drawing.new("Text")
    }
    
    Cache[player] = structures
end

local function RemoveESP(player)
    if Cache[player] then
        for _, drawing in pairs(Cache[player]) do
            drawing:Remove()
        end
        Cache[player] = nil
    end
end

-- Vòng lặp tối ưu hóa hiệu năng, cập nhật vị trí từng Frame hình
RunService.RenderStepped:Connect(function()
    for player, drawing in pairs(Cache) do
        if not getgenv().ZenonixESP.Master or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Character:FindFirstChild("Humanoid") then
            for _, d in pairs(drawing) do d.Visible = false end
            continue
        end

        local hrp = player.Character.HumanoidRootPart
        local hum = player.Character.Humanoid
        
        if hum.Health <= 0 then
            for _, d in pairs(drawing) do d.Visible = false end
            continue
        end

        local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        
        if onScreen then
            -- Tính toán kích thước Box chuẩn theo khoảng cách xa gần
            local scaleFactor = 1 / (hrpPos.Z * math.tan(math.rad(Camera.FieldOfView * 0.5))) * 100
            local width, height = 30 * scaleFactor, 50 * scaleFactor
            local x, y = hrpPos.X - width / 2, hrpPos.Y - height / 2

            -- 1. BOX ESP (Hồng + Viền Trắng)
            if getgenv().ZenonixESP.Box then
                drawing.BoxOutline.Size = Vector2.new(width, height)
                drawing.BoxOutline.Position = Vector2.new(x, y)
                drawing.BoxOutline.Color = getgenv().ZenonixESP.OutlineColor
                drawing.BoxOutline.Thickness = 3
                drawing.BoxOutline.Filled = false
                drawing.BoxOutline.Visible = true

                drawing.Box.Size = Vector2.new(width, height)
                drawing.Box.Position = Vector2.new(x, y)
                drawing.Box.Color = getgenv().ZenonixESP.Color
                drawing.Box.Thickness = 1
                drawing.Box.Filled = false
                drawing.Box.Visible = true
            else
                drawing.Box.Visible = false
                drawing.BoxOutline.Visible = false
            end

            -- 2. TRACER ESP (3 Kiểu chọn từ UI)
            if getgenv().ZenonixESP.Tracer then
                if getgenv().ZenonixESP.TracerMode == "Bottom" then
                    drawing.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                elseif getgenv().ZenonixESP.TracerMode == "Center" then
                    drawing.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                elseif getgenv().ZenonixESP.TracerMode == "Top" then
                    drawing.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                end
                
                drawing.Tracer.To = Vector2.new(hrpPos.X, hrpPos.Y + height / 2)
                drawing.Tracer.Color = getgenv().ZenonixESP.Color
                drawing.Tracer.Thickness = 1.5
                drawing.Tracer.Visible = true
            else
                drawing.Tracer.Visible = false
            end

            -- 3. HEALTH BAR (Thanh máu thông minh tự co giãn)
            if getgenv().ZenonixESP.Health then
                local healthPercentage = hum.Health / hum.MaxHealth
                local barHeight = height * healthPercentage
                
                drawing.HealthOutline.Size = Vector2.new(4, height)
                drawing.HealthOutline.Position = Vector2.new(x - 6, y)
                drawing.HealthOutline.Color = Color3.fromRGB(0, 0, 0)
                drawing.HealthOutline.Filled = true
                drawing.HealthOutline.Visible = true

                drawing.HealthBar.Size = Vector2.new(2, barHeight)
                drawing.HealthBar.Position = Vector2.new(x - 5, y + height - barHeight)
                drawing.HealthBar.Color = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(50, 255, 50), healthPercentage) -- Đỏ hóa Xanh tùy lượng máu
                drawing.HealthBar.Filled = true
                drawing.HealthBar.Visible = true
            else
                drawing.HealthBar.Visible = false
                drawing.HealthOutline.Visible = false
            end

            -- 4. NAME ESP (Chữ sắc nét)
            if getgenv().ZenonixESP.Name then
                drawing.Name.Text = player.Name .. " [" .. math.floor(player:DistanceFromCharacter(hrp.Position)) .. "m]"
                drawing.Name.Position = Vector2.new(hrpPos.X, y - 15)
                drawing.Name.Color = getgenv().ZenonixESP.Color
                drawing.Name.Outline = true
                drawing.Name.OutlineColor = Color3.fromRGB(0, 0, 0)
                drawing.Name.Center = true
                drawing.Name.Size = 14
                drawing.Name.Visible = true
            else
                drawing.Name.Visible = false
            end
        else
            for _, d in pairs(drawing) do d.Visible = false end
        end
    end
end)

-- Quản lý vòng đời người chơi trong Server
for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

-- ==========================================
-- [          CÀI ĐẶT GIAO DIỆN UI          ]
-- ==========================================

local VisualsTab = Window:CreateTab("👁️ Visuals ESP", 4483362458)

VisualsTab:CreateToggle({
   Name = "KÍCH HOẠT HỆ THỐNG ESP",
   CurrentValue = false,
   Callback = function(Value) getgenv().ZenonixESP.Master = Value end,
})

VisualsTab:CreateSection("Bộ Lọc Hiển Thị")

VisualsTab:CreateToggle({
   Name = "Hiện Khung (Box ESP)",
   CurrentValue = true,
   Callback = function(Value) getgenv().ZenonixESP.Box = Value end,
})

VisualsTab:CreateToggle({
   Name = "Hiện Tên & Khoảng Cách",
   CurrentValue = true,
   Callback = function(Value) getgenv().ZenonixESP.Name = Value end,
})

VisualsTab:CreateToggle({
   Name = "Hiện Cột Máu",
   CurrentValue = true,
   Callback = function(Value) getgenv().ZenonixESP.Health = Value end,
})

VisualsTab:CreateSection("Tùy Chỉnh Đường Kẻ (Tracer)")

VisualsTab:CreateToggle({
   Name = "Hiện Tia Định Vị (Tracer)",
   CurrentValue = true,
   Callback = function(Value) getgenv().ZenonixESP.Tracer = Value end,
})

VisualsTab:CreateDropdown({
   Name = "Kiểu Tia Quét",
   Options = {"Bottom","Center","Top"},
   CurrentOption = {"Bottom"},
   MultipleOptions = false,
   Callback = function(Option)
       getgenv().ZenonixESP.TracerMode = Option[1]
   end,
})
