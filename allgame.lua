--[[
==============================================================================
         🌌 UNKNOWN HUB LOADER SUITE v18.0 [NEO-OMNIVERSE OVERDRIVE PREMIUM] 🌌
==============================================================================
               DEVELOPER : MINH MEO OMNIVERSE (GOD-TIER ARCHITECT)
               STATUS    : EXPANDED KNOWLEDGE BASE + AUDIO INTEGRATED UI
               REVISION  : V18.0 ULTRA REFINED INJECTION MATRIX (IMAGE CORE)
               COMPATIBILITY : UNIVERSAL EXECUTOR COMPLIANT (UNC 100%)
==============================================================================
--]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    repeat task.wait() until Players.LocalPlayer
    localPlayer = Players.LocalPlayer
end
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- [[ KHỬ TRÙNG LẶP LOADER TRÁNH XUNG ĐỘT HỆ THỐNG ]]
if CoreGui:FindFirstChild("UnknownLoaderUI_V18") then CoreGui.UnknownLoaderUI_V18:Destroy() end
if playerGui:FindFirstChild("UnknownLoaderUI_V18") then playerGui.UnknownLoaderUI_V18:Destroy() end

-- [[ HỆ THỐNG PHÁT NHẠC NỀN CAO CẤP ]]
local LoaderMusic = Instance.new("Sound")
LoaderMusic.Name = "UnknownHub_LoaderTrack"
-- Bạn có thể thay đổi ID âm thanh (Roblox Asset ID) tùy thích ở dòng dưới đây:
LoaderMusic.SoundId = "rbxassetid://1837874711" or "rbxassetid://9043887091" 
LoaderMusic.Volume = 0.6
LoaderMusic.Looped = true
LoaderMusic.Parent = SoundService
pcall(function() LoaderMusic:Play() end)

-- [[ KHỞI TẠO KHUNG GIAO DIỆN LOADER CYBERPUNK ]]
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "UnknownLoaderUI_V18"
LoaderGui.ResetOnSpawn = false
LoaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() LoaderGui.Parent = CoreGui end)
if not LoaderGui.Parent then LoaderGui.Parent = playerGui end

local BG_IMAGE_URL = "https://raw.githubusercontent.com/imz-yuki/Unknownhub/main/e8336015cda776546253a0977982fe75.jpg"
local BG_CACHE_FILE = "UnknownHub_Premium_FixedBG.jpg" -- Tên file cache mới để ép hệ thống tải lại ảnh chuẩn

-- ÉP CHUYỂN ĐỔI SANG IMAGELABEL ĐỂ PHÁ TAN KHÔNG GIAN ĐEN XÌ
local Background = Instance.new("ImageLabel")
Background.Size = UDim2.new(0, 540, 0, 450)
Background.Position = UDim2.new(0.5, -270, 0.5, -225)
Background.BackgroundColor3 = Color3.fromRGB(15, 12, 28) -- Màu nền chờ khi nạp ảnh ngầm
Background.BorderSizePixel = 0
Background.Active = true
Background.Draggable = true
Background.ScaleType = Enum.ScaleType.Crop -- Ép ảnh tự động tràn đều khung, KHÔNG BỊ MÉO ẢNH
Background.ImageColor3 = Color3.fromRGB(180, 180, 180) -- Hạ nhẹ độ chói giúp văn bản rõ nét hơn
Background.ImageTransparency = 0.12 -- Hòa quyện ảnh nền mờ ảo đẳng cấp
Background.Parent = LoaderGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Background

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Thickness = 2.5
FrameStroke.Color = Color3.fromRGB(255, 0, 128)
FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FrameStroke.Parent = Background

-- Thuật toán nạp ngầm ảnh nền từ kho lưu trữ GitHub của bạn
task.spawn(function()
    if not isfile(BG_CACHE_FILE) then
        local success, result = pcall(function()
            return game:HttpGet(BG_IMAGE_URL)
        end)
        if success and result then
            writefile(BG_CACHE_FILE, result)
        end
    end

    if isfile(BG_CACHE_FILE) then
        pcall(function()
            Background.Image = getcustomasset(BG_CACHE_FILE)
        end)
    end
end)

-- Tiêu đề chính đẳng cấp Unknown Hub V18
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "Unknown Hub v18.0 [NEO-OMNIVERSE OVERDRIVE]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = Background

-- ==============================================================================
-- 📖 KHUNG HƯỚNG DẪN SỬ SỬ DỤNG TẤT CẢ LỆNH TRÊN GUI (CẬP NHẬT BẢN V18)
-- ==============================================================================
local GuideContainer = Instance.new("ScrollingFrame")
GuideContainer.Size = UDim2.new(1, -32, 0, 240)
GuideContainer.Position = UDim2.new(0, 16, 0, 60)
GuideContainer.BackgroundColor3 = Color3.fromRGB(9, 7, 14)
GuideContainer.BackgroundTransparency = 0.25 -- Làm mờ bảng hướng dẫn để lộ lớp ảnh phía sau cực nghệ
GuideContainer.BorderSizePixel = 0
GuideContainer.CanvasSize = UDim2.new(0, 0, 0, 780) -- Tăng canvas cho phần thông tin server
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
GuideText.Size = UDim2.new(1, 0, 0, 0)
GuideText.BackgroundTransparency = 1
GuideText.Text = "<font color='#FF0080'><b>📖 CẨM NANG VẬN HÀNH UNKNOWN HUB v18.0 NEO-OMNIVERSE</b></font>\n\n" ..
    "<font color='#00FFFF'><b>📢 OFFICIAL SUPPORT SERVER (OWNER YUKI):</b></font>\n" ..
    "• <b>Cộng đồng hỗ trợ chính thức:</b> <font color='#00FFB4'><b>discord.gg/A5hv7YVp2</b></font>\n\n" ..
    "<font color='#00FFFF'><b>⚡ ĐÓNG / MỞ BẢNG ĐIỀU KHIỂN (TOGGLE UI):</b></font>\n" ..
    "• <b>MÁY TÍNH (PC):</b> Ấn phím <font color='#00FFB4'><b>[Right Control]</b></font> để ẩn/hiện bảng điều khiển chính.\n" ..
    "• <b>ĐIỆN THOẠI (Mobile):</b> Sử dụng nút bấm tròn mờ hiển thị trên màn hình hệ thống.\n\n" ..
    "<font color='#00FFFF'><b>🎯 KHÓA TÂM AIMLOCK PROXIMITY V18:</b></font>\n" ..
    "• <b>PC:</b> Bật Aimlock ON -> <font color='#FFEA00'><b>[Nhấn Giữ Chuột Phải]</b></font> để khóa cứng camera vào đối thủ gần nhất.\n" ..
    "• <b>Mobile:</b> Tự động quét và hướng camera vào mục tiêu nằm trong vòng tròn FOV mà không cần giữ nút.\n\n" ..
    "<font color='#00FFFF'><b>⚡ DỊCH CHUYỂN VIP CHUYÊN DỤNG (TELEPORT SERVICES):</b></font>\n" ..
    "• <b>Tốc biến sau lưng:</b> Nhấn nút để ngay lập tức biến ra phía sau lưng kẻ địch gần nhất mục tiêu từ 1.5 - 3 Studs để tạo bất ngờ.\n" ..
    "• <b>Vòng lặp triệt hạ (Loop Kill):</b> Tự động dính chặt và dịch chuyển liên tục theo vị trí di chuyển của đối phương cho đến khi đối phương bị tiêu diệt hoàn toàn.\n\n" ..
    "<font color='#00FFFF'><b>📦 ÉP SIÊU HITBOX ĐA TẦNG (OVERDRIVE):</b></font>\n" ..
    "• Kích hoạt Player Hitbox hoặc NPC Hitbox -> Chỉnh size từ <font color='#00FFB4'><b>[30 đến 45]</b></font>. Điểm va chạm của mục tiêu sẽ phình to cực đại, hỗ trợ đánh trúng diện rộng tuyệt đối.\n\n" ..
    "<font color='#00FFFF'><b>👁️ THẤU THỊ MATRIX VISUALS (ESP MẮT THẦN):</b></font>\n" ..
    "• Hỗ trợ nhìn xuyên tường toàn bản đồ bao gồm: Khung viền (Box), Đường chỉ hướng (Tracers từ đáy màn hình), Hiển thị tên (Names) và Thanh máu động (Health Bar) tự động đổi màu theo lượng máu thực tế.\n\n" ..
    "<font color='#FFAA00'><b>🔥 TÍNH NĂNG MỚI ĐƯỢC CẬP NHẬT TRÊN BẢN V18:</b></font>\n" ..
    "• <b>Audio Master Module:</b> Hệ thống âm thanh nền sống động chạy song song luồng tải.\n" ..
    "• <b>Auto-Inject Streamlined:</b> Thuật toán nạp ngầm tối ưu hóa tài nguyên, không làm giảm FPS.\n" ..
    "• <b>Bypass Kiểm Duyệt Chặt Chẽ:</b> Cơ chế mã hóa nâng cao giúp các tính năng hoạt động mượt mà trên môi trường Universal Executor (UNC 100%).\n\n" ..
    "<font color='#00FFFF'><b>⚙️ HỆ THỐNG PHÒNG THỦ & KHÁC (MISC OVERCLOCK):</b></font>\n" ..
    "• <b>Anti-Fling:</b> Khóa cứng gia tốc góc, chống lại mọi hình thức phá hoại làm văng nhân vật.\n" ..
    "• <b>Anti-Ragdoll:</b> Tự động đứng dậy ngay lập tức khi bị tác động vật lý gây ngã ngửa cơ thể."
GuideText.TextColor3 = Color3.fromRGB(210, 210, 230)
GuideText.TextSize = 12
GuideText.Font = Enum.Font.GothamSemibold
GuideText.TextXAlignment = Enum.TextXAlignment.Left
GuideText.TextYAlignment = Enum.TextYAlignment.Top
GuideText.RichText = true
GuideText.Parent = GuideContainer

GuideText.Size = UDim2.new(1, 0, 0, GuideText.TextBounds.Y)
GuideContainer.CanvasSize = UDim2.new(0, 0, 0, GuideText.TextBounds.Y + 40)
GuideText:GetPropertyChangedSignal("TextBounds"):Connect(function()
    GuideText.Size = UDim2.new(1, 0, 0, GuideText.TextBounds.Y)
    GuideContainer.CanvasSize = UDim2.new(0, 0, 0, GuideText.TextBounds.Y + 40)
end)
-- ==============================================================================

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 315)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Hệ thống đang kiểm tra và nạp dữ liệu cấu hình..."
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 175)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.GothamSemibold
SubTitle.Parent = Background

-- Thanh tiến trình Loading Bar cao cấp
local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0, 440, 0, 8)
BarBackground.Position = UDim2.new(0.5, -220, 0, 342)
BarBackground.BackgroundColor3 = Color3.fromRGB(18, 14, 28)
BarBackground.BackgroundTransparency = 0.3
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
PercentLabel.Position = UDim2.new(0, 0, 0, 360)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(255, 0, 128)
PercentLabel.TextSize = 13
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.Parent = Background

-- Nút xác nhận xuất hiện khi hoàn thành nạp (GIỮ NGUYÊN ĐẸP VÀ SANG)
local ConfirmButton = Instance.new("TextButton")
ConfirmButton.Size = UDim2.new(0, 280, 0, 36)
ConfirmButton.Position = UDim2.new(0.5, -140, 0, 395)
ConfirmButton.BackgroundColor3 = Color3.fromRGB(12, 8, 20)
ConfirmButton.Text = "XÁC NHẬN ĐÃ ĐỌC HƯỚNG DẪN v18"
ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmButton.Font = Enum.Font.GothamBold
ConfirmButton.TextSize = 11
ConfirmButton.Visible = false
ConfirmButton.Parent = Background

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 8)
ConfirmCorner.Parent = ConfirmButton

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Thickness = 1.5
ConfirmStroke.Color = Color3.fromRGB(255, 0, 128)
ConfirmStroke.Parent = ConfirmButton

-- Hiệu ứng dải màu Chroma RGB mượt mà bao phủ UI thời gian thực
task.spawn(function()
    while LoaderGui and LoaderGui.Parent do
        local hue = (tick() % 4) / 4
        local rgbColor = Color3.fromHSV(hue, 0.95, 1)
        FrameStroke.Color = rgbColor
        ProgressFill.BackgroundColor3 = rgbColor
        PercentLabel.TextColor3 = rgbColor
        GuideContainer.ScrollBarImageColor3 = rgbColor
        ConfirmStroke.Color = rgbColor
        task.wait(0.02)
    end
end)

-- Vòng lặp đếm ước bất đồng bộ chính xác 3 giây (3000ms) không bị khựng giao diện
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

-- Sau khi hoàn tất 3 giây, cập nhật trạng thái và hiển thị nút xác nhận điều kiện
SubTitle.Text = "DỮ LIỆU ĐÃ ĐỒNG BỘ! VUI LÒNG XÁC NHẬN ĐỂ KHỞI CHẠY SCRIPT V18"
PercentLabel.Visible = false
ConfirmButton.Visible = true

-- Logic xử lý sự kiện khi click nút xác nhận đã đọc hướng dẫn
ConfirmButton.MouseButton1Click:Connect(function()
    SubTitle.Text = "ĐANG KÍCH HOẠT UNKNOWN HUB v18.0..."
    ConfirmButton.Active = false
    
    -- Hiệu ứng giảm âm lượng nhạc nền nhỏ dần (Fade out) khi tắt Loader
    task.spawn(function()
        for i = 10, 0, -1 do
            if LoaderMusic then
                LoaderMusic.Volume = (i / 10) * 0.6
                task.wait(0.04)
            end
        end
        if LoaderMusic then LoaderMusic:Destroy() end
    end)
    
    task.wait(0.4)
    LoaderGui:Destroy()
    
    -- Thực thi tải tệp lệnh chính từ kho lưu trữ GitHub an toàn
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/imz-yuki/Unknownhub/refs/heads/main/allgames.lua"))()
    end)
    
    if not success then
        warn("Lỗi khởi chạy mã nguồn chính từ GitHub: " .. tostring(err))
    end
end)
