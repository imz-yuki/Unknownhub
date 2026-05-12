--[[
    ╔══════════════════════════════════════════════════════╗
    ║  ⌬  ZENONIX HUB V2.0 // OMNIVERSE PERFORMANCE RE-EVO ║
    ║  >> OPTIMIZED BY GEMINI // PC & MOBILE ANTI-LAG      ║
    ╚══════════════════════════════════════════════════════╝
]]--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Cập nhật Camera khi hồi sinh
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = workspace.CurrentCamera
end)

-- ==================== [ CONFIGURATION ] ====================
local Settings = {
    Aimlock = false, ShowFOV = false, FOVRadius = 130, Prediction = 0.15, Smoothing = 0.15,
    Hitbox = false, HitboxSize = 12, KillAura = false, AutoAttack = false,
    ESP = false, Tracers = false, ESPColor = Color3.fromRGB(0, 255, 255),
    SpeedHack = false, SpeedValue = 80, InfJump = false, Noclip = false, Spinbot = false,
    FullBright = false, NightMode = false,
    MenuKey = Enum.KeyCode.RightControl
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(191, 0, 255)
FOVCircle.Thickness = 1.5
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8
FOVCircle.Visible = false

local ESPBoxes = {}
local Tracers = {}

-- ==================== [ CORE UI SYSTEM ] ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Zenonix_Hub_V2"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer.PlayerGui end)

local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    RunService.Heartbeat:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Notification Engine
local function Notify(title, msg, color)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 260, 0, 55)
    f.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    f.BackgroundTransparency = 0.1
    f.Parent = ScreenGui

    local stroke = Instance.new("UIStroke", f)
    stroke.Color = color or Color3.fromRGB(0, 255, 255)
    stroke.Thickness = 1.5
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, -20, 1, 0)
    t.Position = UDim2.new(0, 10, 0, 0)
    t.Text = "<b>" .. title .. "</b>\n" .. msg
    t.RichText = true
    t.TextColor3 = Color3.new(1,1,1)
    t.Font = Enum.Font.GothamMedium
    t.TextSize = 12
    t.BackgroundTransparency = 1
    t.TextXAlignment = Enum.TextXAlignment.Left

    f.Position = UDim2.new(1.2, 0, 0.85, 0)
    TweenService:Create(f, TweenInfo.new(0.4, Enum.EasingStyle.BackOut), {Position = UDim2.new(1, -280, 0.85, 0)}):Play()
    task.delay(2.5, function()
        pcall(function()
            TweenService:Create(f, TweenInfo.new(0.4, Enum.EasingStyle.QuartIn), {Position = UDim2.new(1.2, 0, 0.85, 0)}):Play()
            task.wait(0.4) f:Destroy()
        end)
    end)
end

-- ==================== [ MAIN INTERFACE ] ====================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 330)
Main.Position = UDim2.new(0.5, -275, 0.5, -165)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.Visible = false
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
MakeDraggable(Main)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 1.5
local Gradient = Instance.new("UIGradient", MainStroke)
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 0, 255))
}

local Title = Instance.new("TextLabel", Main)
Title.Text = "⌬ ZENONIX REVOLUTION"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 18
Title.Position = UDim2.new(0, 20, 0, 12)
Title.Size = UDim2.new(0, 250, 0, 30)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -38, 0, 14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(240, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, -60)
Sidebar.Position = UDim2.new(0, 12, 0, 48)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -175, 1, -60)
Container.Position = UDim2.new(0, 162, 0, 48)
Container.BackgroundTransparency = 1

local ActiveTabButton = nil
local TabsCount = 0

local function AddTab(name, icon)
    local page = Instance.new("ScrollingFrame", Container)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (TabsCount == 0)
    page.ScrollBarThickness = 0
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 36)
    btn.Position = UDim2.new(0.05, 0, 0, TabsCount * 40 + 8)
    btn.BackgroundColor3 = (TabsCount == 0) and Color3.fromRGB(35, 35, 48) or Color3.fromRGB(22, 22, 30)
    btn.Text = icon .. "  " .. name
    btn.TextColor3 = (TabsCount == 0) and Color3.new(1,1,1) or Color3.new(0.7,0.7,0.7)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    if TabsCount == 0 then ActiveTabButton = btn end

    btn.MouseButton1Click:Connect(function()
        if ActiveTabButton then
            TweenService:Create(ActiveTabButton, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(22, 22, 30), TextColor3 = Color3.new(0.7,0.7,0.7)}):Play()
        end
        ActiveTabButton = btn
        TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(35, 35, 48), TextColor3 = Color3.new(1,1,1)}):Play()
        
        for _, v in pairs(Container:GetChildren()) do 
            if v:IsA("ScrollingFrame") then v.Visible = false end 
        end
        page.Visible = true
    end)
    
    TabsCount = TabsCount + 1
    return page
end

-- Tạo lại hệ thống Tab thực tế thay vì bảo trì
local CombatTab = AddTab("Tự Động Chiến Đấu", "⚔️")
local VisualTab = AddTab("Hiển Thị / ESP", "👁️")
local PlayerTab = AddTab("Nhân Vật Mod", "🏃")
local WorldTab  = AddTab("Thế Giới / Map", "🌍")

local function AddToggle(text, parent, key, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.96, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    btn.Text = "    " .. text
    btn.TextColor3 = Color3.new(0.8,0.8,0.8)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local dot = Instance.new("Frame", btn)
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(1, -22, 0.5, -5)
    dot.BackgroundColor3 = Settings[key] and color or Color3.fromRGB(50, 50, 65)
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        TweenService:Create(dot, TweenInfo.new(0.2), {BackgroundColor3 = Settings[key] and color or Color3.fromRGB(50, 50, 65)}):Play()
        Notify("ZENONIX", text .. " -> " .. (Settings[key] and "BẬT" or "TẮT"), Settings[key] and color or Color3.new(1,0.3,0.3))
    end)
end

-- Đăng ký Toggles vào các trang chức năng
AddToggle("Silent Aimlock (Khóa mục tiêu)", CombatTab, "Aimlock", Color3.fromRGB(0, 255, 255))
AddToggle("Show Aim FOV (Vòng ngắm)", CombatTab, "ShowFOV", Color3.fromRGB(191, 0, 255))
AddToggle("Hitbox Expander (Mở rộng tâm)", CombatTab, "Hitbox", Color3.fromRGB(255, 0, 150))
AddToggle("Kill Aura (Tự sát thương cận chiến)", CombatTab, "KillAura", Color3.fromRGB(255, 50, 50))
AddToggle("Auto Click/Attack (Tự đánh)", CombatTab, "AutoAttack", Color3.fromRGB(255, 150, 0))

AddToggle("ESP Boxes (Khung xương người)", VisualTab, "ESP", Color3.fromRGB(0, 255, 100))
AddToggle("Tracer Lines (Đường định vị)", VisualTab, "Tracers", Color3.fromRGB(0, 255, 255))

AddToggle("Speedhack Ultra (Tốc độ x100)", PlayerTab, "SpeedHack", Color3.fromRGB(255, 100, 0))
AddToggle("Infinite Jump (Nhảy vô tận)", PlayerTab, "InfJump", Color3.fromRGB(255, 255, 255))
AddToggle("Noclip Bypass (Đi xuyên tường)", PlayerTab, "Noclip", Color3.fromRGB(150, 150, 150))
AddToggle("Spinbot (Xoay chống ngắm độc độc)", PlayerTab, "Spinbot", Color3.fromRGB(255, 255, 255))

AddToggle("Night Mode (Chế độ ban đêm)", WorldTab, "NightMode", Color3.fromRGB(50, 50, 255))
AddToggle("Full Bright (Bật sáng bản đồ)", WorldTab, "FullBright", Color3.fromRGB(255, 255, 100))

-- ==================== [ MOBILE TOGGLE BTN ] ====================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 46, 0, 46)
ToggleBtn.Position = UDim2.new(0, 15, 0.35, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
ToggleBtn.Text = "⌬"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.TextSize = 24
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local TStroke = Instance.new("UIStroke", ToggleBtn)
TStroke.Color = Color3.fromRGB(191, 0, 255)
TStroke.Thickness = 1.5
MakeDraggable(ToggleBtn)

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
UserInputService.InputBegan:Connect(function(input) if input.KeyCode == Settings.MenuKey then Main.Visible = not Main.Visible end end)

-- ==================== [ OPTIMIZED ENGINE LOGIC ] ====================

-- Luồng render hình ảnh (RenderStepped) chỉ xử lý vẽ FOV/ESP để mượt FPS
RunService.RenderStepped:Connect(function()
    if Settings.ShowFOV then
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOVCircle.Radius = Settings.FOVRadius
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end

    local localChar = LocalPlayer.Character
    if not localChar then return end

    -- Tối ưu hóa render ESP/Tracers bằng cách giảm thiểu phép tính trùng lặp
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pChar = p.Character
            local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
            
            if pRoot then
                local pos, onScreen = Camera:WorldToViewportPoint(pRoot.Position)
                
                if Settings.Tracers and onScreen then
                    local tracer = Tracers[p] or Drawing.new("Line")
                    Tracers[p] = tracer
                    tracer.Visible = true
                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(pos.X, pos.Y)
                    tracer.Color = Settings.ESPColor
                elseif Tracers[p] then 
                    Tracers[p].Visible = false 
                end

                if Settings.ESP and onScreen then
                    local box = ESPBoxes[p] or Drawing.new("Square")
                    ESPBoxes[p] = box
                    local sizeX = 2000 / pos.Z
                    local sizeY = 3000 / pos.Z
                    box.Visible = true
                    box.Size = Vector2.new(sizeX, sizeY)
                    box.Position = Vector2.new(pos.X - sizeX / 2, pos.Y - sizeY / 2)
                    box.Color = Color3.fromRGB(0, 255, 100)
                    box.Thickness = 1.2
                elseif ESPBoxes[p] then 
                    ESPBoxes[p].Visible = false 
                end
            else
                if Tracers[p] then Tracers[p].Visible = false end
                if ESPBoxes[p] then ESPBoxes[p].Visible = false end
            end
        end
    end
end)

-- Luồng vật lý cố định (Heartbeat) xử lý dữ liệu game gốc
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local root = char economics and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    -- Quản lý môi trường Thế giới
    if Settings.NightMode then Lighting.TimeOfDay = "00:00:00" end
    if Settings.FullBright then Lighting.Ambient = Color3.new(1,1,1) end
    
    -- Tốc độ & Spinbot
    if Settings.SpeedHack then hum.WalkSpeed = Settings.SpeedValue else hum.WalkSpeed = 16 end
    if Settings.Spinbot then root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(45), 0) end

    -- Quét mục tiêu Aimlock tối ưu
    local target = nil
    local shortestDist = Settings.FOVRadius

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pChar = p.Character
            local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
            local pHum = pChar and pChar:FindFirstChildOfClass("Humanoid")

            if pRoot and pHum and pHum.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(pRoot.Position)
                
                if onScreen then
                    local mouseDist = (Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) - Vector2.new(pos.X, pos.Y)).Magnitude
                    if mouseDist < shortestDist then
                        shortestDist = mouseDist
                        target = p
                    end
                end

                -- Xử lý Hitbox an toàn - Tránh cập nhật kích thước liên tục nếu trùng cấu hình
                if Settings.Hitbox then
                    if pRoot.Size.X ~= Settings.HitboxSize then
                        pRoot.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        pRoot.Transparency = 0.6
                        pRoot.CanCollide = false
                    end
                else
                    if pRoot.Size.X ~= 2 then
                        pRoot.Size = Vector3.new(2, 2, 1)
                        pRoot.Transparency = 1
                    end
                end
            end
        end
    end

    -- Thực thi tính năng Combat lên Target đã lọc
    if target and target.Character then
        local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if tRoot then
            if Settings.Aimlock then
                local targetPredict = tRoot.Position + (tRoot.Velocity * Settings.Prediction)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, targetPredict), Settings.Smoothing)
            end
            if Settings.KillAura and (root.Position - tRoot.Position).Magnitude < 22 then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
    end

    if Settings.AutoAttack then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end
end)

-- Thay thế cơ chế GetDescendants liên tục bằng vòng lặp Stepped tối ưu cục bộ cho Noclip
RunService.Stepped:Connect(function()
    if Settings.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Nhảy liên tục không lag hoãn
UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

Notify("ZENONIX CODES", "Hệ thống tối ưu Anti-Lag PC/Mobile đã kích hoạt thành công!", Color3.fromRGB(191, 0, 255))
