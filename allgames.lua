--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║      ⌬  ZENONIX HYBRID ENGINE V9.0 // OMNIVERSE OVERLORD SYSTEM           ║
    ║      >> CORE DEVELOPER: MINH MEO OMNIVERSE ETERNAL                        ║
    ║      >> UPGRADE: FULL UTILITY V4.5 + ULTRA AIMLOCK V9 (ZERO-SHAKE CORE)   ║
    ║      >> DESIGN: CYBERPUNK HUD - NO VERIFICATION - MAXIMUM PERFORMANCE     ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]--

-- ==================== [ HỆ THỐNG DỊCH VỤ CỐT LÕI ] ====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

-- Đồng bộ Camera liên tục chống lỗi khi hồi sinh
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = workspace.CurrentCamera
end)

-- ==================== [ BẢNG CẤU HÌNH TOÀN NĂNG V9.0 OVERLORD ] ====================
local Settings = {
    -- LÕI SIÊU AIMLOCK V9 (TỐI THƯỢNG)
    AimlockEnabled = true,
    AimType = "Tâm Màn Hình", -- Tâm Màn Hình / Khoảng Cách Thực
    TargetPartMode = "Quét Khớp Thông Minh V9", -- Quét Khớp Thông Minh V9 / Head / HumanoidRootPart
    PredictionMode = "Ma Trận Gia Tốc V9", -- Tắt / Tuyến Tính / Ma Trận Gia Tốc V9 / Bù Trừ Ping
    PredictionAmount = 0.138,
    SmoothingMode = "Nội Suy Bezier Đa Điểm", -- Tuyến Tính / Nội Suy Bezier Đa Điểm / Exponential
    Smoothness = 0.045, -- Thấp hơn = Dính chặt hơn
    DynamicFOV = true, -- Tự động co giãn vòng FOV theo khoảng cách mục tiêu
    StickyLock = true, -- Giữ chặt mục tiêu cũ cho đến khi chết/khuất tầm nhìn
    
    -- BỘ LỌC ĐIỀU KIỆN AN TOÀN
    TeamCheck = false,
    WallCheck = true,
    AliveCheck = true,
    KnockedCheck = true,

    -- VÒNG QUET FOV CHUYÊN NGHIỆP
    ShowFOV = true,
    FOVRadius = 160,
    FOVThickness = 2,
    FOVColor = Color3.fromRGB(0, 255, 255),
    FOVTransparency = 0.8,
    RainbowFOV = true,
    
    -- TIỆN ÍCH COMBAT & PHÓNG HITBOX (V4.5)
    Hitbox = false,
    HitboxSize = 15,
    HitboxPart = "HumanoidRootPart",
    HitboxTrans = 0.6,
    KillAura = false,
    AuraRange = 25,
    AutoAttack = false,
    
    -- SIÊU THẤU THỊ VISUAL ESP (V4.5)
    ESP_Boxes = false,
    ESP_Tracers = false,
    ESP_Names = false,
    ESP_Distance = false,
    BoxColor = Color3.fromRGB(255, 0, 128),
    TracerColor = Color3.fromRGB(0, 255, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    
    -- MOD DI CHUYỂN GIAN LẬN (V4.5)
    SpeedHack = false,
    SpeedValue = 100,
    JumpHack = false,
    JumpValue = 80,
    InfJump = false,
    Noclip = false,
    Spinbot = false,
    SpinSpeed = 60,
    
    -- KHÔNG GIAN MÔI TRƯỜNG & KHỬ LAG (V4.5)
    FullBright = false,
    NightMode = false,
    AntiLag = false,
    NoTextures = false,
    
    -- CẤU HÌNH PHÍM BẤM KÍCH HOẠT DỄ DÙNG
    LockKey = Enum.KeyCode.Q,
    IsHoldMode = false, -- false = Bấm phát bật/tắt khóa mục tiêu
    MenuKey = Enum.KeyCode.RightControl
}

-- Biến Trạng Thái Hệ Thống Toàn Cục
local AimlockActive = false
local LockedTargetPlayer = nil
local LockedTargetPart = nil
local RainbowHue = 0
local Cache_ESP = {}

-- Khởi tạo các đối tượng đồ họa Drawing API siêu tốc
local FOVCircle = Drawing.new("Circle")
FOVCircle.Filled = false
local TargetV9Line = Drawing.new("Line")
TargetV9Line.Visible = false

-- Hàm giải phóng bộ nhớ Drawing tránh giật lag RAM
local function ClearPlayerDrawing(player)
    if Cache_ESP[player] then
        pcall(function()
            if Cache_ESP[player].Box then Cache_ESP[player].Box:Remove() end
            if Cache_ESP[player].Tracer then Cache_ESP[player].Tracer:Remove() end
            if Cache_ESP[player].NameLabel then Cache_ESP[player].NameLabel:Remove() end
            if Cache_ESP[player].DistLabel then Cache_ESP[player].DistLabel:Remove() end
        end)
        Cache_ESP[player] = nil
    end
end

Players.PlayerRemoving:Connect(ClearPlayerDrawing)

-- ==================== [ THƯ VIỆN ĐỘNG CƠ KIỂM TRA VẬT LÝ ] ====================
local CorePhysics = {}

function CorePhysics.IsVisible(targetPart, character)
    if not Settings.WallCheck then return true end
    local origin = Camera.CFrame.Position
    local destination = targetPart.Position
    local direction = destination - origin
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local ignoreList = {LocalPlayer.Character, Camera}
    if character then table.insert(ignoreList, character) end
    raycastParams.FilterDescendantsInstances = ignoreList
    
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    return raycastResult == nil
end

function CorePhysics.CheckTargetValid(player)
    local character = player.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    if Settings.AliveCheck and humanoid.Health <= 0 then return false end
    if Settings.KnockedCheck then
        if character:FindFirstChild("KO") or character:FindFirstChild("Knocked") or character:FindFirstChild("Downed") or humanoid:GetState() == Enum.HumanoidStateType.Dead then
            return false
        end
    end
    return true
end

-- ==================== [ MÔ-ĐUN KÉO THẢ GIAO DIỆN KHÔNG TRỄ TẦN SỐ ] ====================
local function RegisterDragEngine(guiFrame)
    local dragging, dragInput, dragStart, startPos
    guiFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    guiFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    RunService.Heartbeat:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            guiFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==================== [ KHỞI TẠO FRAMEWORK UI CYBERPUNK TRỰC QUAN ] ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Zenonix_Overlord_V9"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui") end)

-- Thông báo nổi không rườm rà thực thi siêu tốc
local function BuildNotification(title, message, accentColor)
    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 285, 0, 58)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    notifyFrame.BackgroundTransparency = 0.1
    notifyFrame.Parent = ScreenGui

    local stroke = Instance.new("UIStroke", notifyFrame)
    stroke.Color = accentColor or Color3.fromRGB(0, 255, 255)
    stroke.Thickness = 1.5
    Instance.new("UICorner", notifyFrame).CornerRadius = UDim.new(0, 6)

    local textLabel = Instance.new("TextLabel", notifyFrame)
    textLabel.Size = UDim2.new(1, -20, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.Text = "<b>" .. title .. "</b>\n" .. message
    textLabel.RichText = true
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextSize = 11.5
    textLabel.BackgroundTransparency = 1
    textLabel.TextXAlignment = Enum.TextXAlignment.Left

    notifyFrame.Position = UDim2.new(1.3, 0, 0.82, 0)
    TweenService:Create(notifyFrame, TweenInfo.new(0.3, Enum.EasingStyle.BackOut), {Position = UDim2.new(1, -305, 0.82, 0)}):Play()
    
    task.delay(1.6, function()
        pcall(function()
            TweenService:Create(notifyFrame, TweenInfo.new(0.25, Enum.EasingStyle.QuartIn), {Position = UDim2.new(1.3, 0, 0.82, 0)}):Play()
            task.wait(0.25)
            notifyFrame:Destroy()
        end)
    end)
end

-- Khung bảng điều khiển tổng (Main Dashboard)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 610, 0, 380)
Main.Position = UDim2.new(0.5, -305, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
Main.Visible = false
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
RegisterDragEngine(Main)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 1.5
local GradientAccent = Instance.new("UIGradient", MainStroke)
GradientAccent.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 128))
}

local HeaderTitle = Instance.new("TextLabel", Main)
HeaderTitle.Text = "⌬ ZENONIX HYBRID OVERLORD v9.0 // CORES EDITION"
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextSize = 13
HeaderTitle.Position = UDim2.new(0, 18, 0, 14)
HeaderTitle.Size = UDim2.new(0, 450, 0, 22)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton", Main)
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -36, 0, 14)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 45, 75)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 10
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 5)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() FOVCircle:Remove() TargetV9Line:Remove() end)

local NavigationBar = Instance.new("Frame", Main)
NavigationBar.Size = UDim2.new(0, 145, 1, -60)
NavigationBar.Position = UDim2.new(0, 12, 0, 48)
NavigationBar.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Instance.new("UICorner", NavigationBar).CornerRadius = UDim.new(0, 6)

local ContainerDeck = Instance.new("Frame", Main)
ContainerDeck.Size = UDim2.new(1, -182, 1, -60)
ContainerDeck.Position = UDim2.new(0, 170, 0, 48)
ContainerDeck.BackgroundTransparency = 1

local CurrentActiveTabBtn = nil
local TabCountRegister = 0

local function CreateTabChannel(tabName, tabIcon)
    local pageScroll = Instance.new("ScrollingFrame", ContainerDeck)
    pageScroll.Size = UDim2.new(1, 0, 1, 0)
    pageScroll.BackgroundTransparency = 1
    pageScroll.Visible = (TabCountRegister == 0)
    pageScroll.ScrollBarThickness = 2
    pageScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
    pageScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local listLayout = Instance.new("UIListLayout", pageScroll)
    listLayout.Padding = UDim.new(0, 6)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pageScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15)
    end)

    local tabBtn = Instance.new("TextButton", NavigationBar)
    tabBtn.Size = UDim2.new(0.92, 0, 0, 35)
    tabBtn.Position = UDim2.new(0.04, 0, 0, TabCountRegister * 38 + 8)
    tabBtn.BackgroundColor3 = (TabCountRegister == 0) and Color3.fromRGB(25, 25, 35) or Color3.fromRGB(15, 15, 20)
    tabBtn.Text = "  " .. tabIcon .. "  " .. tabName
    tabBtn.TextColor3 = (TabCountRegister == 0) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 10.5
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 5)

    if TabCountRegister == 0 then CurrentActiveTabBtn = tabBtn end

    tabBtn.MouseButton1Click:Connect(function()
        if CurrentActiveTabBtn then
            TweenService:Create(CurrentActiveTabBtn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(15, 15, 20), TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        end
        CurrentActiveTabBtn = tabBtn
        TweenService:Create(tabBtn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(25, 25, 35), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        
        for _, v in pairs(ContainerDeck:GetChildren()) do 
            if v:IsA("ScrollingFrame") then v.Visible = false end 
        end
        pageScroll.Visible = true
    end)
    
    TabCountRegister = TabCountRegister + 1
    return pageScroll
end

-- Phân mục Tab điều khiển dễ dùng cho người mới
local TabAimlockCore = CreateTabChannel("Siêu Aimlock V9", "🔥")
local TabVisuals = CreateTabChannel("Thấu Thị ESP V4.5", "🔮")
local TabMovement = CreateTabChannel("Di Chuyển Mod", "⚡")
local TabWorldMap = CreateTabChannel("Thế Giới / Khử Lag", "🌐")

-- ==================== [ CHẾ TẠO THÀNH PHẦN COMPONENT ĐIỀU KHIỂN CHUẨN ] ====================

local function InjectToggle(text, parent, configKey, colorTheme)
    local toggleFrame = Instance.new("TextButton", parent)
    toggleFrame.Size = UDim2.new(0.96, 0, 0, 36)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    toggleFrame.Text = "     " .. text
    toggleFrame.TextColor3 = Color3.fromRGB(225, 225, 225)
    toggleFrame.TextXAlignment = Enum.TextXAlignment.Left
    toggleFrame.Font = Enum.Font.GothamSemibold
    toggleFrame.TextSize = 10.5
    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 5)

    local stateDot = Instance.new("Frame", toggleFrame)
    stateDot.Size = UDim2.new(0, 12, 0, 12)
    stateDot.Position = UDim2.new(1, -24, 0.5, -6)
    stateDot.BackgroundColor3 = Settings[configKey] and colorTheme or Color3.fromRGB(35, 35, 45)
    Instance.new("UICorner", stateDot).CornerRadius = UDim.new(1, 0)

    toggleFrame.MouseButton1Click:Connect(function()
        Settings[configKey] = not Settings[configKey]
        TweenService:Create(stateDot, TweenInfo.new(0.15), {BackgroundColor3 = Settings[configKey] and colorTheme or Color3.fromRGB(35, 35, 45)}):Play()
        BuildNotification("ZENONIX SYSTEM", text .. " -> " .. (Settings[configKey] and "BẬT" or "TẮT"), Settings[configKey] and colorTheme or Color3.fromRGB(255, 50, 50))
    end)
end

local function InjectSlider(text, parent, minVal, maxVal, configKey, defaultVal, suffix)
    Settings[configKey] = defaultVal
    suffix = suffix or ""
    
    local sliderBox = Instance.new("Frame", parent)
    sliderBox.Size = UDim2.new(0.96, 0, 0, 46)
    sliderBox.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    Instance.new("UICorner", sliderBox).CornerRadius = UDim.new(0, 5)

    local infoLabel = Instance.new("TextLabel", sliderBox)
    infoLabel.Size = UDim2.new(0.8, 0, 0, 20)
    infoLabel.Position = UDim2.new(0, 12, 0, 4)
    infoLabel.Text = text .. ": " .. tostring(defaultVal) .. suffix
    infoLabel.Font = Enum.Font.GothamSemibold
    infoLabel.TextSize = 10.5
    infoLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left

    local trackBtn = Instance.new("TextButton", sliderBox)
    trackBtn.Size = UDim2.new(0.94, 0, 0, 4)
    trackBtn.Position = UDim2.new(0.03, 0, 1, -10)
    trackBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    trackBtn.Text = ""
    Instance.new("UICorner", trackBtn)

    local progressFill = Instance.new("Frame", trackBtn)
    progressFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    Instance.new("UICorner", progressFill)

    local function RecalculateSlider(input)
        local ratioX = math.clamp((input.Position.X - trackBtn.AbsolutePosition.X) / trackBtn.AbsoluteSize.X, 0, 1)
        local targetValue = minVal + (maxVal - minVal) * ratioX
        if maxVal <= 2 then
            targetValue = math.round(targetValue * 1000) / 1000
        else
            targetValue = math.floor(targetValue)
        end
        Settings[configKey] = targetValue
        infoLabel.Text = text .. ": " .. tostring(targetValue) .. suffix
        progressFill.Size = UDim2.new(ratioX, 0, 1, 0)
    end

    local isSliding = false
    trackBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isSliding = true; RecalculateSlider(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            RecalculateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isSliding = false
        end
    end)
end

local function InjectDropdown(text, parent, optionsList, configKey)
    local dropFrame = Instance.new("Frame", parent)
    dropFrame.Size = UDim2.new(0.96, 0, 0, 36)
    dropFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 5)
    dropFrame.ClipsDescendants = true

    local mainTrigger = Instance.new("TextButton", dropFrame)
    mainTrigger.Size = UDim2.new(1, 0, 0, 36)
    mainTrigger.BackgroundTransparency = 1
    mainTrigger.Text = "     " .. text .. ": " .. tostring(Settings[configKey])
    mainTrigger.TextColor3 = Color3.fromRGB(170, 0, 255)
    mainTrigger.Font = Enum.Font.GothamBold
    mainTrigger.TextSize = 10.5
    mainTrigger.TextXAlignment = Enum.TextXAlignment.Left

    local isExpanded = false
    mainTrigger.MouseButton1Click:Connect(function()
        isExpanded = not isExpanded
        TweenService:Create(dropFrame, TweenInfo.new(0.18), {Size = isExpanded and UDim2.new(0.96, 0, 0, 36 + (#optionsList * 26)) or UDim2.new(0.96, 0, 0, 36)}):Play()
    end)

    for idx, selection in ipairs(optionsList) do
        local optBtn = Instance.new("TextButton", dropFrame)
        optBtn.Size = UDim2.new(0.94, 0, 0, 22)
        optBtn.Position = UDim2.new(0.03, 0, 0, 36 + (idx - 1) * 26)
        optBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
        optBtn.Text = selection
        optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        optBtn.Font = Enum.Font.GothamMedium
        optBtn.TextSize = 10
        Instance.new("UICorner", optBtn)

        optBtn.MouseButton1Click:Connect(function()
            Settings[configKey] = selection
            mainTrigger.Text = "     " .. text .. ": " .. selection
            isExpanded = false
            TweenService:Create(dropFrame, TweenInfo.new(0.18), {Size = UDim2.new(0.96, 0, 0, 36)}):Play()
            BuildNotification("HỆ THỐNG V9", "Thay đổi chế độ: " .. selection, Color3.fromRGB(0, 255, 255))
        end)
    end
end

-- ==================== [ PHÂN PHỐI TÀI NGUYÊN ĐIỀU KHIỂN CÁC TÁP UI ] ====================

-- TÁP 1: SIÊU LÕI AIMLOCK V9 TỐI THƯỢNG
InjectToggle("Kích Hoạt Luồng Ngắm Siêu Cấp V9", TabAimlockCore, "AimlockEnabled", Color3.fromRGB(0, 255, 255))
InjectDropdown("Chế Độ Quét Điểm Ưu Tiên", TabAimlockCore, {"Tâm Màn Hình", "Khoảng Cách Thực"}, "AimType")
InjectDropdown("Vị Trí Khóa Khớp Xương", TabAimlockCore, {"Quét Khớp Thông Minh V9", "Head", "HumanoidRootPart"}, "TargetPartMode")
InjectDropdown("Thuật Toán Dự Đoán Vector Đạn", TabAimlockCore, {"Ma Trận Gia Tốc V9", "Tuyến Tính", "Bù Trừ Ping", "Tắt"}, "PredictionMode")
InjectSlider("Hệ Số Tính Tính Quỹ Đạo Đạn", TabAimlockCore, 0.01, 0.4, "PredictionAmount", 0.138, " giây")
InjectDropdown("Chế Độ Nội Suy Mượt Góc Quay", TabAimlockCore, {"Nội Suy Bezier Đa Điểm", "Exponential", "Tuyến Tính"}, "SmoothingMode")
InjectSlider("Độ Mượt Ngắm Chống Rung (Smooth)", TabAimlockCore, 0.005, 0.3, "Smoothness", 0.045, " (Thấp = Khóa dính chết)")
InjectToggle("Khóa Chặt Mục Tiêu Cũ (Sticky Lock)", TabAimlockCore, "StickyLock", Color3.fromRGB(0, 255, 128))
InjectToggle("Tự Co Giãn FOV Theo Khoảng Cách", TabAimlockCore, "DynamicFOV", Color3.fromRGB(255, 0, 128))
InjectToggle("Lọc Đồng Đội (Team Check)", TabAimlockCore, "TeamCheck", Color3.fromRGB(255, 165, 0))
InjectToggle("Kiểm Tra Tường Chắn (Wall Check)", TabAimlockCore, "WallCheck", Color3.fromRGB(0, 255, 128))
InjectToggle("Bỏ Qua Đối Tượng Bị Gục (Knocked)", TabAimlockCore, "KnockedCheck", Color3.fromRGB(255, 60, 100))
InjectToggle("Hiển Thị Vòng Tròn Giới Hạn FOV", TabAimlockCore, "ShowFOV", Color3.fromRGB(170, 0, 255))
InjectToggle("Hiệu Ứng Vòng Tròn Đổi Màu RGB", TabAimlockCore, "RainbowFOV", Color3.fromRGB(0, 255, 255))
InjectSlider("Bán Kính Quét Vùng FOV", TabAimlockCore, 30, 600, "FOVRadius", 160, " pixels")

-- TÁP 2: KHO VŨ KHÍ THẤU THỊ ĐA NĂNG ESP V4.5 & HITBOX
InjectToggle("Hiện Khung Hình Kẻ Địch (Box)", TabVisuals, "ESP_Boxes", Color3.fromRGB(0, 255, 128))
InjectToggle("Hiện Đường Chỉ Chỉ Hướng (Tracer)", TabVisuals, "ESP_Tracers", Color3.fromRGB(0, 255, 255))
InjectToggle("Hiện Tên Người Chơi (Names)", TabVisuals, "ESP_Names", Color3.fromRGB(255, 255, 255))
InjectToggle("Hiện Khoảng Cách Định Định (Distance)", TabVisuals, "ESP_Distance", Color3.fromRGB(255, 215, 0))
InjectToggle("Phóng Đại Kích Thước Hitbox Địch", TabVisuals, "Hitbox", Color3.fromRGB(255, 0, 128))
InjectSlider("Kích Thước Khối Hitbox Săn Địch", TabVisuals, 2, 40, "HitboxSize", 15, " studs")
InjectDropdown("Bộ Phận Phóng Đại Hitbox", TabVisuals, {"HumanoidRootPart", "Head"}, "HitboxPart")
InjectToggle("Kill Aura Tự Sát Thương Diện Rộng", TabVisuals, "KillAura", Color3.fromRGB(255, 40, 40))
InjectSlider("Phạm Vi Vòng Quét Aura Cận Chiến", TabVisuals, 10, 60, "AuraRange", 25, " studs")
InjectToggle("Auto Clicker / Tự Động Tấn Công", TabVisuals, "AutoAttack", Color3.fromRGB(255, 120, 0))

-- TÁP 3: BỘ SỬA ĐỔI DI CHUYỂN NHÂN VẬT GIAN LẬN MECHANICS (V4.5)
InjectToggle("Sử Dụng Siêu Tốc Độ Chạy", TabMovement, "SpeedHack", Color3.fromRGB(255, 100, 0))
InjectSlider("Tốc Độ WalkSpeed Tùy Chỉnh", TabMovement, 16, 300, "SpeedValue", 100, " studs/s")
InjectToggle("Sử Dụng Siêu Lực Nhảy Cao", TabMovement, "JumpHack", Color3.fromRGB(0, 255, 150))
InjectSlider("Lực Nhảy JumpPower Tùy Chỉnh", TabMovement, 50, 250, "JumpValue", 80, " lực")
InjectToggle("Kích Hoạt Nhảy Vô Hạn Trên Không", TabMovement, "InfJump", Color3.fromRGB(255, 255, 255))
InjectToggle("Đi Xuyên Mọi Địa Hình Tường (Noclip)", TabMovement, "Noclip", Color3.fromRGB(150, 150, 150))
InjectToggle("Xoay Thân Tránh Đạn Né Khóa (Spinbot)", TabMovement, "Spinbot", Color3.fromRGB(200, 0, 255))
InjectSlider("Tốc Độ Vòng Xoay Thân Spinbot", TabMovement, 10, 200, "SpinSpeed", 60)

-- TÁP 4: THAY ĐỔI KHÔNG GIAN BẢN ĐỒ & TỐI ƯU GIẢM LAG CỰC ĐẠI (V4.5)
InjectToggle("Bật Sáng Toàn Bản Đồ (Fullbright)", TabWorldMap, "FullBright", Color3.fromRGB(255, 255, 100))
InjectToggle("Ép Buộc Chế Độ Ban Đêm (Night)", TabWorldMap, "NightMode", Color3.fromRGB(50, 50, 200))
InjectToggle("Kích Hoạt Luồng Giảm Tải Lag RAM", TabWorldMap, "AntiLag", Color3.fromRGB(0, 255, 0))
InjectToggle("Xóa Sạch Vật Liệu Cấu Trúc Bản Đồ", TabWorldMap, "NoTextures", Color3.fromRGB(255, 0,  Red))

-- ==================== [ NÚT BẬT TẮT GIAO DIỆN TRÊN MOBILE (ĐIỆN THOẠI) ] ====================
local MobileMenuButton = Instance.new("TextButton", ScreenGui)
MobileMenuButton.Size = UDim2.new(0, 46, 0, 46)
MobileMenuButton.Position = UDim2.new(0, 15, 0.4, 0)
MobileMenuButton.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
MobileMenuButton.Text = "⌬"
MobileMenuButton.TextColor3 = Color3.fromRGB(0, 255, 255)
MobileMenuButton.Font = Enum.Font.GothamBlack
MobileMenuButton.TextSize = 24
Instance.new("UICorner", MobileMenuButton).CornerRadius = UDim.new(1, 0)
local TransStroke = Instance.new("UIStroke", MobileMenuButton)
TransStroke.Color = Color3.fromRGB(255, 0, 128)
TransStroke.Thickness = 1.2
RegisterDragEngine(MobileMenuButton)

MobileMenuButton.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
UserInputService.InputBegan:Connect(function(k) 
    if k.KeyCode == Settings.MenuKey then Main.Visible = not Main.Visible end 
end)

-- ==================== [ THUẬT TOÁN SĂN ĐỊCH LÕI V9 SIÊU CẤP ĐA ĐIỂM ] ====================
local function ScanV9OptimalTarget()
    -- Cơ chế Sticky Lock: Giữ chặt mục tiêu cũ nếu vẫn hợp lệ
    if Settings.StickyLock and LockedTargetPlayer and LockedTargetPart then
        if LockedTargetPlayer.Character and LockedTargetPart:IsDescendantOf(LockedTargetPlayer.Character) then
            if CorePhysics.CheckTargetValid(LockedTargetPlayer) and CorePhysics.IsVisible(LockedTargetPart, LockedTargetPlayer.Character) then
                local sCoord, inView = Camera:WorldToViewportPoint(LockedTargetPart.Position)
                if inView then
                    if not Settings.ShowFOV or (Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) - Vector2.new(sCoord.X, sCoord.Y)).Magnitude <= Settings.FOVRadius then
                        return LockedTargetPlayer, LockedTargetPart
                    end
                end
            end
        end
    end

    local finalTarget = nil
    local minimumValue = math.huge
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, nil end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local enemyRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if enemyRoot and CorePhysics.CheckTargetValid(p) then
                if Settings.TeamCheck and p.Team == LocalPlayer.Team then continue end
                
                local scanPart = enemyRoot
                -- Luồng quét đa điểm thông minh bản v9 tìm vị trí dễ bắn nhất
                if Settings.TargetPartMode == "Quét Khớp Thông Minh V9" then
                    local lowestJointDist = math.huge
                    for _, jointName in ipairs({"Head", "HumanoidRootPart", "UpperTorso"}) do
                        local jointObj = p.Character:FindFirstChild(jointName)
                        if jointObj then
                            local sPos, inBound = Camera:WorldToViewportPoint(jointObj.Position)
                            if inBound and CorePhysics.IsVisible(jointObj, p.Character) then
                                local cDist = (Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) - Vector2.new(sPos.X, sPos.Y)).Magnitude
                                if cDist < lowestJointDist then
                                    lowestJointDist = cDist
                                    scanPart = jointObj
                                end
                            end
                        end
                    end
                else
                    local forcedPart = p.Character:FindFirstChild(Settings.TargetPartMode)
                    if forcedPart then scanPart = forcedPart end
                end

                if not CorePhysics.IsVisible(scanPart, p.Character) then continue end

                local screenPos, isValidPos = Camera:WorldToViewportPoint(scanPart.Position)
                if not isValidPos then continue end

                local distFromCursor = (Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                
                -- Tính toán Dynamic FOV dựa trên khoảng cách (Mục tiêu ở xa -> thu hẹp vòng ngắm để chuẩn xác)
                local dynamicRadius = Settings.FOVRadius
                if Settings.DynamicFOV then
                    local actualRange = (myRoot.Position - scanPart.Position).Magnitude
                    dynamicRadius = math.clamp((Settings.FOVRadius * 120) / actualRange, 35, Settings.FOVRadius * 1.5)
                end

                if Settings.ShowFOV and distFromCursor > dynamicRadius then continue end

                if Settings.AimType == "Khoảng Cách Thực" then
                    local absoluteWorldDist = (myRoot.Position - scanPart.Position).Magnitude
                    if absoluteWorldDist < minimumValue then
                        minimumValue = absoluteWorldDist; finalTarget = {Player = p, Part = scanPart}
                    end
                elseif Settings.AimType == "Tâm Màn Hình" then
                    if distFromCursor < minimumValue then
                        minimumValue = distFromCursor; finalTarget = {Player = p, Part = scanPart}
                    end
                end
            end
        end
    end
    if finalTarget then return finalTarget.Player, finalTarget.Part end
    return nil, nil
end

-- ==================== [ ĐỘNG CƠ GIẢM TẢI ĐỒ HỌA TRÁNH RÒ RỈ RAM ] ====================
local function PurgeTexturesEngine()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and Settings.NoTextures then
            obj.Material = Enum.Material.SmoothPlastic
        elseif (obj:IsA("Decal") or obj:IsA("Texture")) and Settings.AntiLag then
            obj:Destroy()
        elseif (obj:IsA("Atmosphere") or obj:IsA("Sky")) and Settings.AntiLag then
            obj:Destroy()
        end
    end
end

-- ==================== [ QUẢN LÝ BẮT PHÍM KÍCH HOẠT NHẤP GIỮ KHÓA NGẮM ] ====================
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Settings.LockKey then
        if Settings.IsHoldMode then
            AimlockActive = true
        else
            AimlockActive = not AimlockActive
            BuildNotification("LÕI NGẮM V9", AimlockActive and "ĐANG KHÓA CHẶT ĐỊCH 🎯" or "ĐÃ XẢ KHÓA MỤC TIÊU ✕", AimlockActive and Color3.fromRGB(0,255,255) or Color3.fromRGB(255,50,50))
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Settings.LockKey and Settings.IsHoldMode then
        AimlockActive = false
    end
end)

-- ==================== [ VÒNG LẶP KẾT XUẤT ĐỒ HỌA SÚT ĐẠN CAO CẤP (RENDERSTEPPED) ] ====================
RunService.RenderStepped:Connect(function()
    RainbowHue = (RainbowHue + 0.005) % 1
    local dynamicColor = Color3.fromHSV(RainbowHue, 0.9, 1)

    -- Cập nhật vòng quét mục tiêu
    if Settings.ShowFOV and Settings.AimlockEnabled then
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        
        local dynamicRadius = Settings.FOVRadius
        if Settings.DynamicFOV and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LockedTargetPart then
            local actualRange = (LocalPlayer.Character.HumanoidRootPart.Position - LockedTargetPart.Position).Magnitude
            dynamicRadius = math.clamp((Settings.FOVRadius * 120) / actualRange, 35, Settings.FOVRadius * 1.5)
        end

        FOVCircle.Radius = dynamicRadius
        FOVCircle.Thickness = Settings.FOVThickness
        FOVCircle.Color = Settings.RainbowFOV and dynamicColor or Settings.FOVColor
        FOVCircle.Transparency = Settings.FOVTransparency
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end

    -- Động cơ kết xuất luồng thấu thị ESP siêu tốc từ bản v4.5
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if root and hum and hum.Health > 0 then
                local vectorCoord, isPointVisible = Camera:WorldToViewportPoint(root.Position)
                
                if isPointVisible then
                    local buildCache = Cache_ESP[p] or {
                        Box = Drawing.new("Square"), Tracer = Drawing.new("Line"),
                        NameLabel = Drawing.new("Text"), DistLabel = Drawing.new("Text")
                    }
                    Cache_ESP[p] = buildCache
                    
                    if Settings.ESP_Boxes then
                        local scaleFactor = 2200 / vectorCoord.Z
                        buildCache.Box.Visible = true
                        buildCache.Box.Size = Vector2.new(scaleFactor, scaleFactor * 1.4)
                        buildCache.Box.Position = Vector2.new(vectorCoord.X - scaleFactor / 2, vectorCoord.Y - (scaleFactor * 1.4) / 2)
                        buildCache.Box.Color = Settings.BoxColor
                        buildCache.Box.Thickness = 1.5
                    else buildCache.Box.Visible = false end

                    if Settings.ESP_Tracers then
                        buildCache.Tracer.Visible = true
                        buildCache.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        buildCache.Tracer.To = Vector2.new(vectorCoord.X, vectorCoord.Y)
                        buildCache.Tracer.Color = Settings.TracerColor
                        buildCache.Tracer.Thickness = 1
                    else buildCache.Tracer.Visible = false end

                    if Settings.ESP_Names then
                        buildCache.NameLabel.Visible = true
                        buildCache.NameLabel.Text = p.Name
                        buildCache.NameLabel.Position = Vector2.new(vectorCoord.X, vectorCoord.Y - (1800 / vectorCoord.Z) / 2 - 16)
                        buildCache.NameLabel.Color = Settings.TextColor
                        buildCache.NameLabel.Size = 13
                        buildCache.NameLabel.Center = true; buildCache.NameLabel.Outline = true
                    else buildCache.NameLabel.Visible = false end

                    if Settings.ESP_Distance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distanceCalculated = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude)
                        buildCache.DistLabel.Visible = true
                        buildCache.DistLabel.Text = "[" .. tostring(distanceCalculated) .. "m]"
                        buildCache.DistLabel.Position = Vector2.new(vectorCoord.X, vectorCoord.Y + (1800 / vectorCoord.Z) / 2 + 4)
                        buildCache.DistLabel.Color = Color3.fromRGB(255, 230, 100)
                        buildCache.DistLabel.Size = 11
                        buildCache.DistLabel.Center = true; buildCache.DistLabel.Outline = true
                    else buildCache.DistLabel.Visible = false end
                else ClearPlayerDrawing(p) end
            else ClearPlayerDrawing(p) end
        end
    end

    -- Xử lý thuật toán siêu Aimlock v9 bám đuổi triệt tiêu độ giật lệch tâm
    if Settings.AimlockEnabled and AimlockActive then
        local pTarget, partTarget = ScanV9OptimalTarget()
        LockedTargetPlayer = pTarget
        LockedTargetPart = partTarget
        
        if pTarget and partTarget then
            local finalAimedPosition = partTarget.Position
            local velocityComp = partTarget.Velocity
            
            -- Các lớp lọc ma trận dự đoán bước chạy của địch chống xịt đạn
            if Settings.PredictionMode == "Ma Trận Gia Tốc V9" then
                finalAimedPosition = finalAimedPosition + (velocityComp * Settings.PredictionAmount) + (partTarget.AssemblyLinearVelocity * 0.015)
            elseif Settings.PredictionMode == "Bù Trừ Ping" then
                local playerPing = 0.05
                pcall(function() playerPing = LocalPlayer:GetNetworkPing() end)
                finalAimedPosition = finalAimedPosition + (velocityComp * playerPing * (Settings.PredictionAmount * 7))
            elseif Settings.PredictionMode == "Tuyến Tính" then
                finalAimedPosition = finalAimedPosition + (velocityComp * 0.1)
            end
            
            -- Bảo vệ Camera khỏi sập gãy ma trận vị trí trùng lặp (Fix NaN)
            local targetLookCFrame = CFrame.lookAt(Camera.CFrame.Position, finalAimedPosition)
            if (finalAimedPosition - Camera.CFrame.Position).Magnitude > 0.01 then
                -- Lõi lọc nội suy làm mượt Bezier đa điểm v9 dính như keo chống rung lắc
                if Settings.SmoothingMode == "Nội Suy Bezier Đa Điểm" then
                    local lerpedRotation = Camera.CFrame:Lerp(targetLookCFrame, Settings.Smoothness)
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position) * lerpedRotation.Rotation
                elseif Settings.SmoothingMode == "Exponential" then
                    local expFactor = 1 - math.exp(-Settings.Smoothness * 65 * RunService.RenderStepped:Wait())
                    Camera.CFrame = Camera.CFrame:Lerp(targetLookCFrame, math.clamp(expFactor, 0, 1))
                elseif Settings.SmoothingMode == "Tuyến Tính" then
                    Camera.CFrame = Camera.CFrame:Lerp(targetLookCFrame, Settings.Smoothness)
                end
            end

            -- Hiển thị sợi dây ngắm laser khóa dính kết nối Cyberpunk v9
            local screenCoord, visibleOnViewport = Camera:WorldToViewportPoint(partTarget.Position)
            if visibleOnViewport then
                TargetV9Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                TargetV9Line.To = Vector2.new(screenCoord.X, screenCoord.Y)
                TargetV9Line.Color = Settings.RainbowFOV and dynamicColor or Color3.fromRGB(255, 0, 128)
                TargetV9Line.Thickness = 1.8
                TargetV9Line.Transparency = 0.85
                TargetV9Line.Visible = true
            else TargetV9Line.Visible = false end
        else TargetV9Line.Visible = false end
    else
        LockedTargetPlayer = nil; LockedTargetPart = nil
        TargetV9Line.Visible = false
    end
end)

-- ==================== [ VÒNG LẶP ĐỒNG BỘ VẬT LÝ NHÂN VẬT HOÀN CHỈNH (HEARTBEAT) ] ====================
RunService.Heartbeat:Connect(function()
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not myHum then return end

    -- Thiết lập đồng bộ ánh sáng thế giới & Khử lag
    if Settings.NightMode then Lighting.TimeOfDay = "00:00:00" end
    if Settings.FullBright then Lighting.Ambient = Color3.fromRGB(255, 255, 255) end
    if Settings.AntiLag or Settings.NoTextures then PurgeTexturesEngine() end

    -- Đồng bộ sửa đổi gian lận di chuyển Walkspeed / JumpPower của v4.5
    if Settings.SpeedHack then myHum.WalkSpeed = Settings.SpeedValue else myHum.WalkSpeed = 16 end
    if Settings.JumpHack then myHum.JumpPower = Settings.JumpValue else myHum.JumpPower = 50 end
    if Settings.Spinbot then myRoot.CFrame = myRoot.CFrame * CFrame.Angles(0, math.rad(Settings.SpinSpeed), 0) end

    -- Vòng lặp liên tục quét và kích hoạt phóng hitbox kẻ địch diện rộng
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local enemyRoot = p.Character:FindFirstChild(Settings.HitboxPart)
            if enemyRoot and enemyRoot:IsA("BasePart") then
                if Settings.Hitbox then
                    enemyRoot.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    enemyRoot.Transparency = Settings.HitboxTrans
                    enemyRoot.CanCollide = false
                else
                    if enemyRoot.Size.X ~= 2 and enemyRoot.Size.X ~= 1 then
                        enemyRoot.Size = (Settings.HitboxPart == "Head") and Vector3.new(2, 1, 1) or Vector3.new(2, 2, 1)
                        enemyRoot.Transparency = 1
                    end
                end
            end
        end
    end

    -- Kích hoạt hệ thống tự sấy tự chém diện rộng (Kill Aura / Auto Click)
    if Settings.AutoAttack or (Settings.KillAura and LockedTargetPlayer) then
        local equipTool = myChar:FindFirstChildOfClass("Tool")
        if equipTool then equipTool:Activate() end
    end
end)

-- Luồng thực thi đi xuyên vật cản (Stepped Noclip)
RunService.Stepped:Connect(function()
    if Settings.Noclip and LocalPlayer.Character then
        for _, objectPart in ipairs(LocalPlayer.Character:GetChildren()) do
            if objectPart:IsA("BasePart") then objectPart.CanCollide = false end
        end
    end
end)

-- Luồng thực thi nhảy liên tục trên không không chạm đất
UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and LocalPlayer.Character then
        local currentHum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if currentHum then currentHum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Phát tín hiệu khởi chạy động cơ tối cao thành công tuyệt đối lên màn hình HUD
BuildNotification("MINH MEO OMNIVERSE", "Zenonix Hybrid Overlord v9.0 Loaded! Phím Q để kích hoạt khóa tâm v9 siêu dính.", Color3.fromRGB(0, 255, 255))
