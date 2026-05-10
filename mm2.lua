-- [[ ZENONIX HUB PREMIUM LOADER ]] --
-- Owner: Yuki | Power: 9999

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- 1. Tạo Giao Diện Tải (Loader UI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZenonixLoader"
local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = success and coreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Hiệu ứng mờ màn hình phía sau (Blur)
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting
TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 15}):Play()

-- Khung chính của Loader
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 180)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 1 -- Sẽ fade-in sau
MainFrame.Parent = ScreenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = MainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(58, 134, 255) -- Màu xanh Neon đại diện cho Zenonix
stroke.Thickness = 1.5
stroke.Transparency = 1
stroke.Parent = MainFrame

-- Thêm Gradient đổi màu cho viền thêm "đẹp"
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(58, 134, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 120))
})
UIGradient.Parent = stroke

-- Tiêu đề chính (Zenonix Hub)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "ZENONIX HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextTransparency = 1
Title.Parent = MainFrame

-- Tiêu đề phụ (Owner & Power Level)
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 50)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Power Level: 9999 | Owner: Yuki"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.TextTransparency = 1
SubTitle.Parent = MainFrame

-- Thanh hiển thị tiến trình (Progress Bar Background)
local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0, 300, 0, 8)
BarBackground.Position = UDim2.new(0.5, -150, 0.65, 0)
BarBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
BarBackground.BorderSizePixel = 0
BarBackground.BackgroundTransparency = 1
BarBackground.Parent = MainFrame
addCorner = Instance.new("UICorner")
addCorner.CornerRadius = UDim.new(0, 4)
addCorner.Parent = BarBackground

-- Thanh chạy thực tế (Progress Bar Fill)
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0) -- Bắt đầu từ 0%
BarFill.BackgroundColor3 = Color3.fromRGB(58, 134, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBackground
addCorner2 = Instance.new("UICorner")
addCorner2.CornerRadius = UDim.new(0, 4)
addCorner2.Parent = BarFill

local BarGradient = UIGradient:Clone()
BarGradient.Parent = BarFill

-- Trạng thái tải (Loading Status Text)
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0.78, 5)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Đang kết nối..."
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextTransparency = 1
StatusLabel.Parent = MainFrame

-- ==========================================
-- 2. HIỆU ỨNG XUẤT HIỆN (FADE IN TWEEN)
-- ==========================================

TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0.05}):Play()
TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 0}):Play()
TweenService:Create(Title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(SubTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(StatusLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(BarBackground, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
task.wait(0.6)

-- ==========================================
-- 3. CHẠY TIẾN TRÌNH GIẢ LẬP (SMOOTH PROGRESS)
-- ==========================================

local steps = {
    {status = "Checking Whitelist...", progress = 0.15, duration = 0.4},
    {status = "Verifying Yuki's Power (9999/9999)...", progress = 0.40, duration = 0.6},
    {status = "Bypassing MM2 Security Layers...", progress = 0.65, duration = 0.8},
    {status = "Fetching mm2.lua from GitHub...", progress = 0.85, duration = 0.5},
    {status = "Loading Zenonix Modules...", progress = 1.00, duration = 0.4}
}

for _, step in ipairs(steps) do
    StatusLabel.Text = step.status
    local tween = TweenService:Create(BarFill, TweenInfo.new(step.duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(step.progress, 0, 1, 0)
    })
    tween:Play()
    tween.Completed:Wait()
    task.wait(0.1)
end

StatusLabel.Text = "Zenonix Hub Loaded Successfully!"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
task.wait(0.8)

-- ==========================================
-- 4. HIỆU ỨNG BIẾN MẤT (FADE OUT TWEEN)
-- ==========================================

TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 0}):Play()
TweenService:Create(MainFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1, Size = UDim2.new(0, 300, 0, 150), Position = UDim2.new(0.5, -150, 0.5, -75)}):Play()
TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
TweenService:Create(Title, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
TweenService:Create(SubTitle, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
TweenService:Create(StatusLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
TweenService:Create(BarBackground, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
TweenService:Create(BarFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
task.wait(0.5)

-- Dọn dẹp Loader UI
ScreenGui:Destroy()
Blur:Destroy()

-- ==========================================
-- 5. CHẠY SCRIPT CHÍNH CỦA YUKI
-- ==========================================

local successRun, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/imz-yuki/zenonixhub/refs/heads/main/mm2.lua"))()
end)

if not successRun then
    warn("Lỗi khi chạy Zenonix Hub: " .. tostring(err))
end
