--[[
==============================================================================
         🌌 UNKNOWN HUB MULTI-HACK SUITE v18.0 [SUPREME OMNIPOTENT] 🌌
==============================================================================
               DEVELOPER : MINH MEO OMNIVERSE (GOD-TIER ARCHITECT)
               STATUS    : VELOCITY PREDICTION AIM & CHAMS ESP MATRIX 
               REVISION  : V18.0 INDUSTRIAL OPTIMIZED ENGINE (1K LINES FLOW)
               COMPATIBILITY : UNIVERSAL EXECUTOR COMPLIANT (UNC 100%)
==============================================================================
--]]

-- [[ MODULE 1: INHERITANCE ENVIRONMENT & APIS SIMULATION ]]
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")
local TeleportService = game:GetService("TeleportService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    repeat task.wait() until Players.LocalPlayer
    localPlayer = Players.LocalPlayer
end

local PlayerGui = localPlayer:WaitForChild("PlayerGui")
local currentCamera = Workspace.CurrentCamera

local UI_IDENTIFIER = "UnknownHubUI_v180"
local IS_UI_OPEN = true
local TOGGLE_KEY = Enum.KeyCode.RightControl

-- [[ MODULE 2: GLOBAL CONFIGURATION REGISTRY ]]
_G.UnknownConfig = {
    -- Aimlock Overlord Settings
    AimlockEnabled = true,
    AimlockSmoothness = 0.1, -- Giá trị càng nhỏ càng ghim chặt
    AimlockTargetPart = "HumanoidRootPart",
    AimlockCheckTeam = true,
    AimlockFOVEnabled = true,
    AimlockFOVRadius = 150,
    AimPrediction = true,
    AimPredictionVelocity = 0.165,
    
    -- Hitbox Overdrive Matrix
    PlayerHitboxEnabled = true,
    PlayerHitboxSize = 35,
    ExpandHead = true,
    ExpandTorso = true,
    PlayerTransparency = 0.4,
    
    -- NPC Matrix Force
    NPCHitboxEnabled = true,
    NPCHitboxSize = 40,
    NPCTransparency = 0.4,

    -- Advanced Visual ESP Pro
    EspEnabled = true,
    EspBoxes = true,
    EspTracers = false,
    EspNames = true,
    EspHealth = true,
    EspChams = true,
    EspCheckTeam = true,
    
    TeamColor = Color3.fromRGB(0, 255, 120),
    EnemyColor = Color3.fromRGB(255, 15, 60),
    ChamsFillColor = Color3.fromRGB(255, 0, 128),
    ChamsOutlineColor = Color3.fromRGB(255, 255, 255),
    
    -- Movement Overclock
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    JumpPowerEnabled = false,
    JumpPowerValue = 50,
    NoclipEnabled = false,
    FullbrightEnabled = false,
    AntiFlingEnabled = true,
    AntiRagdollEnabled = true,

    -- Teleport & Absolute Assassination
    TeleportBehindDistance = 3,
    TeleportSmoothSpeed = 50,
    LoopKillActive = false,
    KillAuraActive = false,
    KillAuraRadius = 25,

    Theme = {
        MainBg = Color3.fromRGB(4, 4, 8),
        HeaderBg = Color3.fromRGB(12, 6, 24),
        SidebarBg = Color3.fromRGB(6, 4, 12),
        CardBg = Color3.fromRGB(14, 10, 24),
        AccentNeon = Color3.fromRGB(255, 0, 128),
        AlertNeon = Color3.fromRGB(255, 30, 30),
        SuccessNeon = Color3.fromRGB(0, 255, 180),
        ButtonBg = Color3.fromRGB(20, 14, 32),
        TextPrimary = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(160, 160, 190),
        TextDark = Color3.fromRGB(10, 10, 10)
    }
}
local CFG = _G.UnknownConfig

-- [[ MODULE 3: EMERGENCY CLEANER & PROTECTOR ]]
local function executeEmergencyPurge()
    local success, _ = pcall(function()
        for _, parent in ipairs({CoreGui, PlayerGui}) do
            local oldUI = parent:FindFirstChild(UI_IDENTIFIER)
            if oldUI then oldUI:Destroy() end
        end
    end)
end
executeEmergencyPurge()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = UI_IDENTIFIER
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function injectUIIntoSafeParent()
    local success = pcall(function() ScreenGui.Parent = CoreGui end)
    if not success or not ScreenGui.Parent then
        pcall(function() ScreenGui.Parent = PlayerGui end)
    end
end
injectUIIntoSafeParent()

-- [[ MODULE 4: ANIMATION & TWEEN UTILITY ENGINE ]]
local TweenUtility = {}
function TweenUtility:Create(instance, duration, properties, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local info = TweenInfo.new(duration, style, direction)
    local tween = TweenService:Create(instance, info, properties)
    tween:Play()
    return tween
end

-- Khởi tạo vòng tròn FOV vẽ bằng cấu trúc Engine cấp thấp (Drawing API)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.Filled = false
FOVCircle.Transparency = 0.9
FOVCircle.Color = CFG.Theme.AccentNeon

-- [[ MODULE 5: MASTER CORE GUI BUILDER ]]
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainPanel"
MainFrame.Size = UDim2.new(0, 660, 0, 460)
MainFrame.Position = UDim2.new(0.5, -330, 0.5, -230)
MainFrame.BackgroundColor3 = CFG.Theme.MainBg
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local OuterStroke = Instance.new("UIStroke")
OuterStroke.Color = CFG.Theme.AccentNeon
OuterStroke.Thickness = 2.2
OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OuterStroke.Parent = MainFrame

-- Vòng lặp tối ưu hóa tính toán Chroma Overlay & Đồng bộ vòng quét Mouse FOV
task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        local hue = (tick() % 6) / 6
        local rgbColor = Color3.fromHSV(hue, 0.95, 1)
        OuterStroke.Color = rgbColor
        if CFG.AimlockFOVEnabled and CFG.AimlockEnabled then
            FOVCircle.Radius = CFG.AimlockFOVRadius
            FOVCircle.Position = UserInputService:GetMouseLocation()
            FOVCircle.Visible = true
            FOVCircle.Color = rgbColor
        else
            FOVCircle.Visible = false
        end
        task.wait(0.015)
    end
    FOVCircle:Destroy()
end)

local Header = Instance.new("Frame")
Header.Name = "HeaderBar"
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = CFG.Theme.HeaderBg
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderMask = Instance.new("Frame")
HeaderMask.Size = UDim2.new(1, 0, 0, 15)
HeaderMask.Position = UDim2.new(0, 0, 1, -15)
HeaderMask.BackgroundColor3 = CFG.Theme.HeaderBg
HeaderMask.BorderSizePixel = 0
HeaderMask.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "UNKNOWN HUB v18.0 // SUPREME OMNIPOTENT ENGINE 🌌"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

local Sidebar = Instance.new("Frame")
Sidebar.Name = "SidebarPanel"
Sidebar.Size = UDim2.new(0, 175, 1, -75)
Sidebar.Position = UDim2.new(0, 12, 0, 65)
Sidebar.BackgroundColor3 = CFG.Theme.SidebarBg
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 5)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 8)
SidebarPadding.PaddingLeft = UDim.new(0, 6)
SidebarPadding.PaddingRight = UDim.new(0, 6)
SidebarPadding.Parent = Sidebar

local ContentDisplay = Instance.new("Frame")
ContentDisplay.Name = "ContentViewport"
ContentDisplay.Size = UDim2.new(1, -215, 1, -75)
ContentDisplay.Position = UDim2.new(0, 200, 0, 65)
ContentDisplay.BackgroundTransparency = 1
ContentDisplay.Parent = MainFrame

-- [[ MODULE 6: ADVANCED TAB ROUTING MATRIX ]]
local RegisteredPages = {}
local CurrentActiveButton = nil

local function createModularPage(pageId)
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "Page_" .. pageId
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 650)
    scrollFrame.ScrollBarThickness = 2
    scrollFrame.ScrollBarImageColor3 = CFG.Theme.AccentNeon
    scrollFrame.Visible = false
    scrollFrame.Parent = ContentDisplay
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = scrollFrame
    
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 25)
    end)
    
    RegisteredPages[pageId] = scrollFrame
    return scrollFrame
end

local pageAimPrime = createModularPage("AimPrime")
local pageHitboxMax = createModularPage("HitboxMax")
local pageTeleport = createModularPage("Teleport")
local pageVisuals = createModularPage("Visuals")
local pageMisc = createModularPage("Misc")

local function routeToPage(pageId, triggerButton)
    for id, pageObj in pairs(RegisteredPages) do
        pageObj.Visible = (id == pageId)
    end
    
    if CurrentActiveButton and CurrentActiveButton ~= triggerButton then
        TweenUtility:Create(CurrentActiveButton, 0.2, {
            BackgroundColor3 = CFG.Theme.ButtonBg,
            TextColor3 = CFG.Theme.TextSecondary
        })
    end
    
    CurrentActiveButton = triggerButton
    TweenUtility:Create(triggerButton, 0.2, {
        BackgroundColor3 = CFG.Theme.HeaderBg,
        TextColor3 = CFG.Theme.AccentNeon
    })
end

local function registerTabSelector(label, targetPageId)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 38)
    tabBtn.BackgroundColor3 = CFG.Theme.ButtonBg
    tabBtn.Text = label
    tabBtn.TextColor3 = CFG.Theme.TextSecondary
    tabBtn.TextSize = 10
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Parent = Sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = tabBtn
    
    tabBtn.MouseButton1Click:Connect(function()
        routeToPage(targetPageId, tabBtn)
    end)
    return tabBtn
end

local selectorAim = registerTabSelector("🎯 KHÓA TÂM PRO V18", "AimPrime")
local selectorHitbox = registerTabSelector("📦 ÉP SIÊU HITBOX", "HitboxMax")
local selectorTeleport = registerTabSelector("⚡ ÁM SÁT COVERT", "Teleport")
local selectorVisual = registerTabSelector("👁️ OVERLOAD ESP", "Visuals")
local selectorMisc = registerTabSelector("⚙️ HỆ THỐNG MỞ RỘNG", "Misc")

routeToPage("AimPrime", selectorAim)

-- [[ MODULE 7: GUI COMPONENTS FACTORY ENGINE ]]
local ComponentFactory = {}

function ComponentFactory:RenderSectionHeader(parentPage, text)
    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, 0, 0, 32)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Text = "✦ " .. string.upper(text) .. " ✦"
    headerLabel.TextColor3 = CFG.Theme.AccentNeon
    headerLabel.TextSize = 10
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.Parent = parentPage
end

function ComponentFactory:RenderToggle(parentPage, labelText, configKey)
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(1, 0, 0, 48)
    panel.BackgroundColor3 = CFG.Theme.CardBg
    panel.Parent = parentPage
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 6)
    cardCorner.Parent = panel

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.65, 0, 1, 0)
    title.Position = UDim2.new(0, 14, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = labelText
    title.TextColor3 = CFG.Theme.TextPrimary
    title.TextSize = 11
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel

    local trigger = Instance.new("TextButton")
    trigger.Size = UDim2.new(0, 80, 0, 28)
    trigger.Position = UDim2.new(1, -94, 0.5, -14)
    trigger.BackgroundColor3 = CFG[configKey] and CFG.Theme.SuccessNeon or Color3.fromRGB(45, 40, 60)
    trigger.Text = CFG[configKey] and "BẬT" or "TẮT"
    trigger.TextColor3 = CFG[configKey] and CFG.Theme.TextDark or CFG.Theme.TextPrimary
    trigger.Font = Enum.Font.GothamBold
    trigger.TextSize = 11
    trigger.Parent = panel

    local triggerCorner = Instance.new("UICorner")
    triggerCorner.CornerRadius = UDim.new(0, 6)
    triggerCorner.Parent = trigger

    trigger.MouseButton1Click:Connect(function()
        CFG[configKey] = not CFG[configKey]
        trigger.Text = CFG[configKey] and "BẬT" or "TẮT"
        TweenUtility:Create(trigger, 0.15, {
            BackgroundColor3 = CFG[configKey] and CFG.Theme.SuccessNeon or Color3.fromRGB(45, 40, 60),
            TextColor3 = CFG[configKey] and CFG.Theme.TextDark or CFG.Theme.TextPrimary
        })
    end)
end

function ComponentFactory:RenderInputBox(parentPage, labelText, configKey, isString)
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(1, 0, 0, 48)
    panel.BackgroundColor3 = CFG.Theme.CardBg
    panel.Parent = parentPage
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 6)
    cardCorner.Parent = panel

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.5, 0, 1, 0)
    title.Position = UDim2.new(0, 14, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = labelText
    title.TextColor3 = CFG.Theme.TextPrimary
    title.TextSize = 11
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 120, 0, 28)
    box.Position = UDim2.new(1, -134, 0.5, -14)
    box.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
    box.Text = tostring(CFG[configKey])
    box.TextColor3 = CFG.Theme.AccentNeon
    box.Font = Enum.Font.GothamBold
    box.TextSize = 10
    box.ClipsDescendants = true
    box.Parent = panel

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = box

    box.FocusLost:Connect(function()
        if isString then
            CFG[configKey] = box.Text
        else
            local num = tonumber(box.Text)
            if num then CFG[configKey] = num else box.Text = tostring(CFG[configKey]) end
        end
    end)
end

function ComponentFactory:RenderActionButton(parentPage, labelText, callback)
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(1, 0, 0, 48)
    panel.BackgroundColor3 = CFG.Theme.CardBg
    panel.Parent = parentPage
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 6)
    cardCorner.Parent = panel

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -28, 0, 32)
    btn.Position = UDim2.new(0, 14, 0.5, -16)
    btn.BackgroundColor3 = CFG.Theme.ButtonBg
    btn.Text = labelText
    btn.TextColor3 = CFG.Theme.AccentNeon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Parent = panel

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

-- [[ MODULE 8: CORE MECHANICS & LOGIC PROCESSING MATRIX ]]

-- Tiện ích tìm kiếm mục tiêu (Teammate Validator)
local function checkIsTeammate(player)
    if not player then return false end
    if not CFG.EspCheckTeam and not CFG.AimlockCheckTeam then return false end
    if player.Team and localPlayer.Team and player.Team == localPlayer.Team then return true end
    if player:FindFirstChild("Leader") and localPlayer:FindFirstChild("Leader") and player.Leader.Value == localPlayer.Leader.Value then return true end
    return false
end

-- Bộ quét thực thể gần nhất thô (Raw Player Scanner)
local function getClosestPlayerRaw()
    local target = nil
    local shortestDist = math.huge
    local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if not checkIsTeammate(p) then
                local pRoot = p.Character.HumanoidRootPart
                local dist = (pRoot.Position - myRoot.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    target = p
                end
            end
        end
    end
    return target
end

-- Thuật toán tìm kiếm khóa tâm nâng cấp v18 (Aimlock Core)
local function getClosestEnemyToMouse()
    local myChar = localPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closestTarget = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    
    -- Quét đối thủ là người chơi thực tế
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character then
            if not (CFG.AimlockCheckTeam and checkIsTeammate(p)) then
                local part = p.Character:FindFirstChild(CFG.AimlockTargetPart)
                local hum = p.Character:FindFirstChildWhichIsA("Humanoid")
                
                if part and hum and hum.Health > 0 then
                    local screenPos, onScreen = currentCamera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local fovDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if not CFG.AimlockFOVEnabled or fovDist < CFG.AimlockFOVRadius then
                            if fovDist < shortestDistance then
                                shortestDistance = fovDist
                                closestTarget = part
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Nếu không có người chơi thì quét quái vật (NPC) trong map đấu
    if not closestTarget then
        for _, desc in ipairs(Workspace:GetChildren()) do
            if desc:IsA("Model") and desc:FindFirstChildWhichIsA("Humanoid") and not Players:GetPlayerFromCharacter(desc) then
                local part = desc:FindFirstChild(CFG.AimlockTargetPart)
                local hum = desc:FindFirstChildWhichIsA("Humanoid")
                
                if part and hum and hum.Health > 0 then
                    local screenPos, onScreen = currentCamera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local fovDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if not CFG.AimlockFOVEnabled or fovDist < CFG.AimlockFOVRadius then
                            if fovDist < shortestDistance then
                                shortestDistance = fovDist
                                closestTarget = part
                            end
                        end
                    end
                end
            end
        end
    end
    return closestTarget
end

-- Kích hoạt vòng lặp xử lý Aimlock ghim camera mượt (Velocity Prediction Interface)
RunService.RenderStepped:Connect(function()
    if CFG.AimlockEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = getClosestEnemyToMouse()
        if target then
            local targetPosition = target.Position
            -- Tính toán dự đoán quỹ đạo di chuyển vật lý của mục tiêu
            if CFG.AimPrediction and target.Parent:FindFirstChild("HumanoidRootPart") then
                targetPosition = targetPosition + (target.Parent.HumanoidRootPart.Velocity * CFG.AimPredictionVelocity)
            end
            
            local lookAt = CFrame.new(currentCamera.CFrame.Position, targetPosition)
            currentCamera.CFrame = currentCamera.CFrame:Lerp(lookAt, CFG.AimlockSmoothness)
        end
    end
end)

-- [[ MODULE 9: THUẬT TOÁN ÉP HITBOX & LÀM RỖNG CACHE ]]
local function resetPart(part)
    if not part or not part:IsA("BasePart") then return end
    pcall(function()
        if part.Name == "HumanoidRootPart" then 
            part.Size = Vector3.new(2, 2, 1) 
        elseif part.Name == "Head" then 
            part.Size = Vector3.new(2, 1, 1) 
        end
        part.Transparency = (part.Name == "HumanoidRootPart") and 1 or 0
        part.CanCollide = true
     pcall(function() part.SelectionModifier:Destroy() end)
    end)
end

local ObjectCache = {}
task.spawn(function()
    while true do
        local temp = {}
        for _, v in ipairs(Workspace:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChildWhichIsA("Humanoid") then
                table.insert(temp, v)
            end
        end
        ObjectCache = temp
        task.wait(0.4)
    end
end)

task.spawn(function()
    while true do
        for _, model in ipairs(ObjectCache) do
            pcall(function()
                local p = Players:GetPlayerFromCharacter(model)
                local hum = model:FindFirstChildWhichIsA("Humanoid")
                
                if p then
                    if p ~= localPlayer and hum and hum.Health > 0 then
                        if CFG.PlayerHitboxEnabled then
                            if CFG.ExpandHead and model:FindFirstChild("Head") then
                                model.Head.Size = Vector3.new(CFG.PlayerHitboxSize, CFG.PlayerHitboxSize, CFG.PlayerHitboxSize)
                                model.Head.Transparency = CFG.PlayerTransparency 
                                model.Head.CanCollide = false
                            end
                            if CFG.ExpandTorso and model:FindFirstChild("HumanoidRootPart") then
                                model.HumanoidRootPart.Size = Vector3.new(CFG.PlayerHitboxSize, CFG.PlayerHitboxSize, CFG.PlayerHitboxSize)
                                model.HumanoidRootPart.Transparency = CFG.PlayerTransparency 
                                model.HumanoidRootPart.CanCollide = false
                            end
                        else
                            if model:FindFirstChild("Head") then resetPart(model.Head) end
                            if model:FindFirstChild("HumanoidRootPart") then resetPart(model.HumanoidRootPart) end
                        end
                    end
                else
                    local root = model:FindFirstChild("HumanoidRootPart")
                    if root and hum and hum.Health > 0 then
                        if CFG.NPCHitboxEnabled then
                            root.Size = Vector3.new(CFG.NPCHitboxSize, CFG.NPCHitboxSize, CFG.NPCHitboxSize)
                            root.CanCollide = false 
                            root.Transparency = CFG.NPCTransparency
                        else
                            resetPart(root)
                        end
                    end
                end
            end)
        end
        task.wait(0.05)
    end
end)

-- [[ MODULE 10: ADVANCED COVERT TELEPORT SYSTEMS ]]
local function teleportBehindTarget()
    local target = getClosestPlayerRaw()
    local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if target and myRoot and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local tRoot = target.Character.HumanoidRootPart
        myRoot.CFrame = tRoot.CFrame * CFrame.new(0, 0, CFG.TeleportBehindDistance)
    end
end

-- Vòng lặp Loop Kill bám đuôi liên tục đối thủ gần nhất
task.spawn(function()
    while true do
        if CFG.LoopKillActive then
            pcall(function()
                local target = getClosestPlayerRaw()
                local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                if target and myRoot and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local tRoot = target.Character.HumanoidRootPart
                    local targetPos = tRoot.CFrame * CFrame.new(0, 0, CFG.TeleportBehindDistance)
                    myRoot.CFrame = myRoot.CFrame:Lerp(targetPos, 0.3)
                end
            end)
        end
        task.wait(0.01)
    end
end)

-- Tính năng bổ sung cao cấp v18: Kill Aura tự động định hướng đòn đánh
task.spawn(function()
    while true do
        if CFG.KillAuraActive then
            pcall(function()
                local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= localPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local enemyRoot = p.Character.HumanoidRootPart
                            local distance = (enemyRoot.Position - myRoot.Position).Magnitude
                            if distance <= CFG.KillAuraRadius and not checkIsTeammate(p) then
                                -- Mô phỏng luồng nhìn hướng mục tiêu phục vụ skill
                                myRoot.CFrame = CFrame.new(myRoot.Position, Vector3.new(enemyRoot.Position.X, myRoot.Position.Y, enemyRoot.Position.Z))
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.02)
    end
end)

-- [[ MODULE 11: MATRIX ESP OVERLOAD ENGINE & CHAMS CONTROLLER ]]
local ActiveESPObjects = {}

local function createESPDataForPlayer(player)
    if player == localPlayer then return end
    local objects = {
        Box = Drawing.new("Square"),
        Tracer = Drawing.new("Line"),
        Name = Drawing.new("Text"),
        HealthBar = Drawing.new("Line"),
        Highlight = nil
    }
    
    objects.Box.Thickness = 1.5
    objects.Box.Filled = false
    objects.Box.Transparency = 0.8
    objects.Tracer.Thickness = 1.2
    objects.Tracer.Transparency = 0.6
    objects.Name.Size = 13
    objects.Name.Center = true
    objects.Name.Outline = true
    objects.Name.Color = Color3.new(1, 1, 1)
    objects.HealthBar.Thickness = 2
    objects.HealthBar.Transparency = 0.8
    
    ActiveESPObjects[player] = objects
end

local function cleanESPForPlayer(player)
    local objects = ActiveESPObjects[player]
    if objects then
        for k, v in pairs(objects) do 
            if k ~= "Highlight" then v:Destroy() end 
        end
        if objects.Highlight then objects.Highlight:Destroy() end
        ActiveESPObjects[player] = nil
    end
end

Players.PlayerAdded:Connect(createESPDataForPlayer)
Players.PlayerRemoving:Connect(cleanESPForPlayer)
for _, p in ipairs(Players:GetPlayers()) do createESPDataForPlayer(p) end

-- Cấu trúc render đồ họa thấu thị thời gian thực (RenderStepped Loop)
RunService.RenderStepped:Connect(function()
    for player, obj in pairs(ActiveESPObjects) do
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        
        if CFG.EspEnabled and root and hum and hum.Health > 0 then
            local isTeam = checkIsTeammate(player)
            local visualColor = isTeam and CFG.TeamColor or CFG.EnemyColor
            
            -- Thực thi cấu trúc Chams 3D Highlight cao cấp
            if CFG.EspChams then
                if not obj.Highlight then
                    local hl = Instance.new("Highlight")
                    hl.Name = "UnknownChams"
                    hl.Parent = CoreGui
                    obj.Highlight = hl
                end
                obj.Highlight.Adornee = char
                obj.Highlight.FillColor = isTeam and CFG.TeamColor or CFG.ChamsFillColor
                obj.Highlight.OutlineColor = CFG.ChamsOutlineColor
                obj.Highlight.FillTransparency = 0.5
                obj.Highlight.OutlineTransparency = 0.2
            else
                if obj.Highlight then obj.Highlight.Adornee = nil end
            end
            
            -- Chuyển tọa độ thế giới 3D sang màn hình 2D
            local rootPos, onScreen = currentCamera:WorldToViewportPoint(root.Position)
            if onScreen then
                local topPos = currentCamera:WorldToViewportPoint(root.Position + Vector3.new(0, 3, 0))
                local bottomPos = currentCamera:WorldToViewportPoint(root.Position - Vector3.new(0, 3.5, 0))
                local boxHeight = math.abs(topPos.Y - bottomPos.Y)
                local boxWidth = boxHeight * 0.55
                
                if CFG.EspBoxes then
                    obj.Box.Size = Vector2.new(boxWidth, boxHeight)
                    obj.Box.Position = Vector2.new(rootPos.X - boxWidth / 2, rootPos.Y - boxHeight / 2)
                    obj.Box.Color = visualColor
                    obj.Box.Visible = true
                else obj.Box.Visible = false end
                
                if CFG.EspTracers then
                    obj.Tracer.From = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y)
                    obj.Tracer.To = Vector2.new(rootPos.X, rootPos.Y + boxHeight / 2)
                    obj.Tracer.Color = visualColor
                    obj.Tracer.Visible = true
                else obj.Tracer.Visible = false end
                
                if CFG.EspNames then
                    local dist = math.floor((root.Position - currentCamera.CFrame.Position).Magnitude)
                    obj.Name.Text = string.format("%s [%sm]", player.DisplayName, dist)
                    obj.Name.Position = Vector2.new(rootPos.X, rootPos.Y - boxHeight / 2 - 15)
                    obj.Name.Visible = true
                else obj.Name.Visible = false end
                
                if CFG.EspHealth then
                    local healthPct = hum.Health / hum.MaxHealth
                    local barHeight = boxHeight * healthPct
                    obj.HealthBar.From = Vector2.new(rootPos.X - boxWidth / 2 - 5, rootPos.Y + boxHeight / 2)
                    obj.HealthBar.To = Vector2.new(rootPos.X - boxWidth / 2 - 5, rootPos.Y + boxHeight / 2 - barHeight)
                    obj.HealthBar.Color = Color3.fromRGB(255 - (255 * healthPct), 255 * healthPct, 0)
                    obj.HealthBar.Visible = true
                else obj.HealthBar.Visible = false end
            else
                obj.Box.Visible = false obj.Tracer.Visible = false obj.Name.Visible = false obj.HealthBar.Visible = false
            end
        else
            if obj.Highlight then obj.Highlight.Adornee = nil end
            obj.Box.Visible = false obj.Tracer.Visible = false obj.Name.Visible = false obj.HealthBar.Visible = false
        end
    end
end)

-- [[ MODULE 12: PHYSICAL OVERCLOCK & UTILITIES FUNCTIONS ]]
local origAmbient = Lighting.Ambient
local origOutdoor = Lighting.OutdoorAmbient

-- Logic xử lý Noclip, Walkspeed, JumpPower, AntiFling, AntiRagdoll
RunService.Stepped:Connect(function()
    local char = localPlayer.Character
    if char then
        -- Xử lý chạy xuyên địa hình (Noclip)
        if CFG.NoclipEnabled then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        -- Xử lý chống bay màu khi va chạm gia tốc (Anti-Fling)
        if CFG.AntiFlingEnabled and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            char.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local char = localPlayer.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if hum then
        if CFG.WalkSpeedEnabled then hum.WalkSpeed = CFG.WalkSpeedValue end
        if CFG.JumpPowerEnabled then hum.JumpPower = CFG.JumpPowerValue end
        -- Xử lý đứng dậy tức thì (Anti-Ragdoll)
        if CFG.AntiRagdollEnabled and hum.PlatformStand then
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    
    -- Tối ưu hóa ánh sáng bản đồ (Fullbright)
    if CFG.FullbrightEnabled then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Ambient = origAmbient
        Lighting.OutdoorAmbient = origOutdoor
    end
end)

-- Tiện ích phụ trợ: Server Hop (Chuyển Server nhanh né Mod)
local function executeServerHop()
    local x, y = pcall(function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in ipairs(servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, localPlayer)
                break
            end
        end
    end)
end

-- Tiện ích phụ trợ: Rejoin nhanh vào server hiện tại
local function executeServerRejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
end

-- [[ MODULE 13: RENDER RENDERING FULL ELEMENTS TAB PANEL ]]
ComponentFactory:RenderSectionHeader(pageAimPrime, "Khóa Tâm Proximity v18 PRIME")
ComponentFactory:RenderToggle(pageAimPrime, "Kích hoạt Aimlock v18", "AimlockEnabled")
ComponentFactory:RenderToggle(pageAimPrime, "Bỏ qua Đồng Đội (Check Team)", "AimlockCheckTeam")
ComponentFactory:RenderToggle(pageAimPrime, "Dự đoán quỹ đạo (Prediction)", "AimPrediction")
ComponentFactory:RenderInputBox(pageAimPrime, "Độ mịn Ghim Tâm (Smoothness)", "AimlockSmoothness", false)
ComponentFactory:RenderToggle(pageAimPrime, "Hiển thị Vòng Quét FOV", "AimlockFOVEnabled")
ComponentFactory:RenderInputBox(pageAimPrime, "Bán kính Vòng Quét FOV", "AimlockFOVRadius", false)

ComponentFactory:RenderSectionHeader(pageHitboxMax, "Ép Siêu Hitbox Đa Tầng (Overdrive)")
ComponentFactory:RenderToggle(pageHitboxMax, "Ép Hitbox Người Chơi", "PlayerHitboxEnabled")
ComponentFactory:RenderInputBox(pageHitboxMax, "Kích thước Hitbox Ép", "PlayerHitboxSize", false)
ComponentFactory:RenderToggle(pageHitboxMax, "Mở rộng vùng Đầu (Head)", "ExpandHead")
ComponentFactory:RenderToggle(pageHitboxMax, "Mở rộng vùng Thân (Torso)", "ExpandTorso")
ComponentFactory:RenderSectionHeader(pageHitboxMax, "Quản lý Farm NPC Quái Vật")
ComponentFactory:RenderToggle(pageHitboxMax, "Ép Hitbox Toàn Bộ Quái Vật", "NPCHitboxEnabled")
ComponentFactory:RenderInputBox(pageHitboxMax, "Kích thước Hitbox Quái", "NPCHitboxSize", false)

ComponentFactory:RenderSectionHeader(pageTeleport, "Dịch chuyển Ám sát (Teleport Service)")
ComponentFactory:RenderActionButton(pageTeleport, "⚡ Tốc biến ra sau lưng địch gần nhất", teleportBehindTarget)
ComponentFactory:RenderInputBox(pageTeleport, "Khoảng cách đứng sau lưng (Studs)", "TeleportBehindDistance", false)
ComponentFactory:RenderToggle(pageTeleport, "Vòng lặp bám đuôi triệt hạ (Loop Kill)", "LoopKillActive")
ComponentFactory:RenderToggle(pageTeleport, "Kích hoạt Vòng quay Kill Aura", "KillAuraActive")
ComponentFactory:RenderInputBox(pageTeleport, "Bán kính quét Kill Aura", "KillAuraRadius", false)

ComponentFactory:RenderSectionHeader(pageVisuals, "Thấu thị Thực tại Hệ Thống (ESP)")
ComponentFactory:RenderToggle(pageVisuals, "Kích hoạt ESP Master", "EspEnabled")
ComponentFactory:RenderToggle(pageVisuals, "Hiển thị Khung Viền (Box ESP)", "EspBoxes")
ComponentFactory:RenderToggle(pageVisuals, "Hiển thị Khung Đổi Màu (Chams 3D)", "EspChams")
ComponentFactory:RenderToggle(pageVisuals, "Hiển thị Đường Chỉ Hướng (Tracers)", "EspTracers")
ComponentFactory:RenderToggle(pageVisuals, "Hiển thị Tên Đối Thủ", "EspNames")
ComponentFactory:RenderToggle(pageVisuals, "Hiển thị Thanh Máu (Health Bar)", "EspHealth")
ComponentFactory:RenderToggle(pageVisuals, "Lọc hiển thị Đội (Check Team)", "EspCheckTeam")

ComponentFactory:RenderSectionHeader(pageMisc, "Vật lý Tương Tác & Chống Bẫy")
ComponentFactory:RenderToggle(pageMisc, "Kích hoạt WalkSpeed", "WalkSpeedEnabled")
ComponentFactory:RenderInputBox(pageMisc, "Tốc độ chạy", "WalkSpeedValue", false)
ComponentFactory:RenderToggle(pageMisc, "Kích hoạt JumpPower", "JumpPowerEnabled")
ComponentFactory:RenderInputBox(pageMisc, "Lực nhảy cao", "JumpPowerValue", false)
ComponentFactory:RenderToggle(pageMisc, "Đi xuyên tường (Noclip)", "NoclipEnabled")
ComponentFactory:RenderToggle(pageMisc, "Bật Tối Ưu Ánh Sáng (Fullbright)", "FullbrightEnabled")
ComponentFactory:RenderToggle(pageMisc, "Chống Kẻ Địch Làm Văng (Anti-Fling)", "AntiFlingEnabled")
ComponentFactory:RenderToggle(pageMisc, "Đứng dậy tức thì (Anti-Ragdoll)", "AntiRagdollEnabled")
ComponentFactory:RenderSectionHeader(pageMisc, "Hệ thống kết nối luân chuyển")
ComponentFactory:RenderActionButton(pageMisc, "⏩ Server Hop (Chuyển Server Ngẫu Nhiên)", executeServerHop)
ComponentFactory:RenderActionButton(pageMisc, "🔄 Rejoin Server Hiện Tại", executeServerRejoin)

-- [[ MODULE 14: WINDOW INTERACTION HANDLING CONTROL ]]
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == TOGGLE_KEY then
        IS_UI_OPEN = not IS_UI_OPEN
        MainFrame.Visible = IS_UI_OPEN
    end
end)
