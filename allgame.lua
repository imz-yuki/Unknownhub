--[[
==============================================================================
         🌌 UNKNOWN HUB MULTI-HACK SUITE v16.0 [PRIME ARCHITECT] 🌌
==============================================================================
               DEVELOPER : MINH MEO OMNIVERSE (GOD-TIER ARCHITECT)
               STATUS    : GLOBAL USER GUIDE + 3S SPEED CHROMA SEQUENCE
               REVISION  : V16.0 PRIME COMPLETE SPEED FLOW INTEGRITY
               COMPATIBILITY : UNIVERSAL EXECUTOR COMPLIANT (UNC 100%)
==============================================================================
--]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    repeat task.wait() until Players.LocalPlayer
    localPlayer = Players.LocalPlayer
end
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- [[ KHỬ TRÙNG LẶP LOADER TRÁNH XUNG ĐỘT HỆ THỐNG ]]
if CoreGui:FindFirstChild("UnknownLoaderUI_V16") then CoreGui.UnknownLoaderUI_V16:Destroy() end
if playerGui:FindFirstChild("UnknownLoaderUI_V16") then playerGui.UnknownLoaderUI_V16:Destroy() end

-- [[ KHỞI TẠO KHUNG GIAO DIỆN LOADER CYBERPUNK ]]
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "UnknownLoaderUI_V16"
LoaderGui.ResetOnSpawn = false
LoaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() LoaderGui.Parent = CoreGui end)
if not LoaderGui.Parent then LoaderGui.Parent = playerGui end

local Background = Instance.new("Frame")
Background.Size = UDim2.new(0, 520, 0, 420)
Background.Position = UDim2.new(0.5, -260, 0.5, -210)
Background.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
Background.Active = true
Background.Draggable = true
Background.Parent = LoaderGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Background

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Thickness = 2.5
FrameStroke.Color = Color3.fromRGB(255, 0, 128)
FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FrameStroke.Parent = Background

-- Tiêu đề chính đẳng cấp Unknown Hub
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "𝙐𝙣𝙠𝙣𝙤𝙬𝙣 𝙃𝙪𝙗 𝙫16.0 [PRIME ARCHITECT EDITION]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = Background

-- ==============================================================================
-- 📖 KHUNG HƯỚNG DẪN SỬ DỤNG TẤT CẢ LỆNH TRÊN GUI (MỌI NGƯỜI CÙNG ĐỌC)
-- ==============================================================================
local GuideContainer = Instance.new("ScrollingFrame")
GuideContainer.Size = UDim2.new(1, -32, 0, 240)
GuideContainer.Position = UDim2.new(0, 16, 0, 60)
GuideContainer.BackgroundColor3 = Color3.fromRGB(9, 7, 14)
GuideContainer.BorderSizePixel = 0
GuideContainer.CanvasSize = UDim2.new(0, 0, 0, 480)
GuideContainer.ScrollBarThickness = 3
GuideContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 128)
GuideContainer.Parent = Background

local GuideCorner = Instance.new("UICorner")
GuideCorner.CornerRadius = UDim.new(0, 10)
GuideCorner.Parent = GuideContainer

local GuideStroke = Instance.new("UIStroke")
GuideStroke.Thickness = 1.2
GuideStroke.Color = Color3.fromRGB(24, 18, 38)
GuideStroke.Parent = GuideContainer

local GuidePadding = Instance.new("UIPadding")
GuidePadding.PaddingTop = UDim.new(0, 12)
GuidePadding.PaddingBottom = UDim.new(0, 12)
GuidePadding.PaddingLeft = UDim.new(0, 14)
GuidePadding.PaddingRight = UDim.new(0, 14)
GuidePadding.Parent = GuideContainer

local GuideText = Instance.new("TextLabel")
GuideText.Size = UDim2.new(1, 0, 1, 0)
GuideText.BackgroundTransparency = 1
GuideText.Text = "<font color='#FF0080'><b>📖 CẨM NANG VẬN HÀNH UNKNOWN HUB v16.0 PRIME</b></font>\n\n" ..
    "<font color='#00FFFF'><b>⚡ ĐÓNG / MỞ BẢNG ĐIỀU KHIỂN (TOGGLE UI):</b></font>\n" ..
    "• <b>MÁY TÍNH (PC):</b> Ấn phím <font color='#00FFB4'><b>[Right Control]</b></font> (nút Ctrl nằm bên phải bàn phím gần các phím mũi tên).\n" ..
    "• <b>ĐIỆN THOẠI (Mobile):</b> Ấn nhẹ vào <font color='#00FFB4'><b>[Icon Mờ Tròn]</b></font> trôi nổi trên màn hình do Executor tự sinh.\n\n" ..
    "<font color='#00FFFF'><b>🎯 KHÓA TÂM AIMLOCK PROXIMITY V16 (SIÊU GHIM ĐÍCH):</b></font>\n" ..
    "• <b>Trên PC:</b> Bật Aimlock ON -> <font color='#FFEA00'><b>[Nhấn Giữ Chuột Phải]</b></font>. Tâm ngắm tự động khóa cứng kẻ địch/quái vật ở khoảng cách 3D gần nhân vật của bạn nhất. Thả ra để tự do.\n" ..
    "• <b>Trên Mobile:</b> Bật Aimlock ON + Bật Vòng Quét FOV -> Kẻ địch di chuyển vào vòng tròn giữa màn hình sẽ bị <font color='#FFEA00'><b>[Tự Động Khóa Camera]</b></font> đuổi theo mà không cần chạm giữ nút bấm rườm rà.\n" ..
    "• <i>Lời khuyên:</i> Hạ thấp độ mịn (Smoothness = 0.05) để khóa siêu bạo, tăng lên (0.15) để mượt. Luôn bật Check Team khi chơi game chia đội đấu phe.\n\n" ..
    "<font color='#00FFFF'><b>📦 ÉP SIÊU HITBOX ĐA TẦNG (OVERDRIVE):</b></font>\n" ..
    "• <b>Cách dùng chung:</b> Bật ON mục Player Hitbox (Khi PVP) hoặc NPC Hitbox (Khi farm quái) -> Tích chọn mở rộng Đầu (Head) và Thân (Torso).\n" ..
    "• <b>Mẹo chỉnh kích thước:</b> Điền thông số từ <font color='#00FFB4'><b>[30 đến 45]</b></font>. Cơ thể đối phương sẽ phình to ẩn trong không gian, bạn đứng từ khoảng cách xa chỉ cần chém gió hoặc tung kỹ năng diện rộng là tự trúng liên hoàn!\n\n" ..
    "<font color='#00FFFF'><b>👁️ THẤU THỊ MATRIX VISUALS (ESP MẮT THẦN):</b></font>\n" ..
    "• Kích hoạt ESP Master để nhìn xuyên tường: Hiện Box (Khung viền định vị), Tracers (Vạch chỉ hướng từ dưới màn hình thẳng đến địch), Names & Health (Hiện tên, số mét khoảng cách thực tế và thanh máu động đổi màu tương ứng).\n\n" ..
    "<font color='#00FFFF'><b>⚙️ DỊCH VỤ VẬT LÝ & TỐC ĐỘ (MISC OVERCLOCK):</b></font>\n" ..
    "• WalkSpeed / JumpPower: Bật ON rồi tùy chỉnh thanh thông số để chạy nhanh như Flash, nhảy siêu cao né đòn.\n" ..
    "• Noclip (Xuyên tường): Đi xuyên qua địa hình map đấu, chui hang, vượt chướng ngại vật.\n" ..
    "• Fullbright: Xóa bỏ mọi hiệu ứng sương mù, bóng đêm âm u, đưa độ sáng toàn bản đồ lên mức cực đại."
GuideText.TextColor3 = Color3.fromRGB(210, 210, 230)
GuideText.TextSize = 12
GuideText.Font = Enum.Font.GothamSemibold
GuideText.TextXAlignment = Enum.TextXAlignment.Left
GuideText.TextYAlignment = Enum.TextYAlignment.Top
GuideText.RichText = true
GuideText.Parent = GuideContainer

-- Cập nhật CanvasSize tự động căn chỉnh chữ
GuideContainer.CanvasSize = UDim2.new(0, 0, 0, GuideText.TextBounds.Y + 40)
GuideText:GetPropertyChangedSignal("TextBounds"):Connect(function()
    GuideContainer.CanvasSize = UDim2.new(0, 0, 0, GuideText.TextBounds.Y + 40)
end)
-- ==============================================================================

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 315)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Hệ thống Unknown Hub đang đồng bộ cấu hình tối thượng..."
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 175)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.GothamSemibold
SubTitle.Parent = Background

-- Thanh tiến trình Loading Bar cao cấp
local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0, 440, 0, 7)
BarBackground.Position = UDim2.new(0.5, -220, 0, 342)
BarBackground.BackgroundColor3 = Color3.fromRGB(18, 14, 28)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = Background

local BarBackgroundCorner = Instance.new("UICorner")
BarBackgroundCorner.CornerRadius = UDim.new(0, 4)
BarBackgroundCorner.Parent = BarBackground

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = BarBackground

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(0, 4)
ProgressCorner.Parent = ProgressFill

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, 0, 0, 20)
PercentLabel.Position = UDim2.new(0, 0, 0, 362)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(255, 0, 128)
PercentLabel.TextSize = 13
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.Parent = Background

-- Hiệu ứng dải màu Chroma RGB lướt mượt mà bao phủ các đường nét viền UI
task.spawn(function()
    while LoaderGui and LoaderGui.Parent do
        local hue = (tick() % 4) / 4
        local rgbColor = Color3.fromHSV(hue, 0.95, 1)
        FrameStroke.Color = rgbColor
        ProgressFill.BackgroundColor3 = rgbColor
        PercentLabel.TextColor3 = rgbColor
        GuideContainer.ScrollBarImageColor3 = rgbColor
        task.wait(0.02)
    end
end)

-- Vòng lặp đếm ngược bất đồng bộ chính xác 3 giây (3000ms)
local duration = 3.0
local startTick = tick()

while true do
    local elapsed = tick() - startTick
    local ratio = math.clamp(elapsed / duration, 0, 1)
    
    ProgressFill.Size = UDim2.new(ratio, 0, 1, 0)
    PercentLabel.Text = string.format("%d%%", math.floor(ratio * 100))
    
    if ratio >= 1 then break end
    task.wait()
end

SubTitle.Text = "KÍCH HOẠT UNKNOWN HUB v16.0 THÀNH CÔNG!"
task.wait(0.2)
LoaderGui:Destroy()

-- Thực thi tải tệp lệnh chính từ kho lưu trữ GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/imz-yuki/zenonixhub/refs/heads/main/allgames.lua"))()
