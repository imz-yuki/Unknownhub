-- ====================================================================
-- ZENONIX HUB - KEY SYSTEM LOADER — SAKURA EDITION
-- Theme: Hồng phấn & Trắng ngà (khớp với V6 Sakura)
-- KEY: teleprime
-- ====================================================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player       = Players.LocalPlayer
local CORRECT_KEY  = "teleprime"
local DISCORD_LINK = "https://discord.gg/kaizenmc"

-- ==================== COLORS (khớp V6) ====================
local C = {
	bg          = Color3.fromRGB(252, 245, 250),
	bgCard      = Color3.fromRGB(255, 250, 254),
	bgDeep      = Color3.fromRGB(248, 238, 246),
	topbar      = Color3.fromRGB(255, 240, 248),
	accent      = Color3.fromRGB(240, 100, 160),
	accentLight = Color3.fromRGB(255, 180, 215),
	accentDark  = Color3.fromRGB(200, 60, 120),
	pink2       = Color3.fromRGB(255, 210, 230),
	white       = Color3.fromRGB(255, 255, 255),
	textMain    = Color3.fromRGB(80, 50, 70),
	textSub     = Color3.fromRGB(160, 120, 145),
	textFaint   = Color3.fromRGB(200, 170, 190),
	stroke      = Color3.fromRGB(240, 195, 220),
	green       = Color3.fromRGB(80, 200, 140),
	red         = Color3.fromRGB(255, 100, 130),
	gold        = Color3.fromRGB(255, 200, 80),
}

-- ==================== HELPERS ====================
local function makeCorner(p, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 10)
	c.Parent = p
	return c
end

local function makeStroke(p, color, thick, transp)
	local s = Instance.new("UIStroke")
	s.Color = color or C.stroke
	s.Thickness = thick or 1.5
	s.Transparency = transp or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = p
	return s
end

local function tween(obj, info, props)
	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end

local TQ  = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TQS = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function ripple(btn, col)
	local r = Instance.new("Frame")
	r.Parent = btn
	r.BackgroundColor3 = col or C.white
	r.BackgroundTransparency = 0.5
	r.Size = UDim2.new(0, 0, 0, 0)
	r.Position = UDim2.new(0.5, 0, 0.5, 0)
	r.AnchorPoint = Vector2.new(0.5, 0.5)
	r.BorderSizePixel = 0
	r.ZIndex = 10
	makeCorner(r, 100)
	tween(r, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(2, 0, 4, 0),
		BackgroundTransparency = 1
	})
	task.delay(0.36, function() r:Destroy() end)
end

-- ==================== SCREEN GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZenonixKeySakura"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = player:FindFirstChild("PlayerGui") or game:GetService("CoreGui")

-- Overlay tối nhẹ
local Overlay = Instance.new("Frame")
Overlay.Parent = ScreenGui
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(80, 40, 60)
Overlay.BackgroundTransparency = 0.55
Overlay.BorderSizePixel = 0

-- Decorative petals (background)
for i = 1, 10 do
	local petal = Instance.new("Frame")
	petal.Parent = Overlay
	petal.BackgroundColor3 = Color3.fromRGB(255, 200, 225)
	petal.BackgroundTransparency = 0.7
	local sz = math.random(25, 70)
	petal.Size = UDim2.new(0, sz, 0, sz)
	petal.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
	petal.BorderSizePixel = 0
	petal.Rotation = math.random(0, 360)
	makeCorner(petal, math.random(20, 50))
end

-- ==================== MAIN CARD ====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "KeyCard"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = C.bg
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -130)
MainFrame.Size = UDim2.new(0, 350, 0, 260)
MainFrame.BorderSizePixel = 0
makeCorner(MainFrame, 18)
makeStroke(MainFrame, C.accentLight, 2, 0)

-- Card gradient
local CardGrad = Instance.new("UIGradient")
CardGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 248, 253)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(252, 238, 248)),
})
CardGrad.Rotation = 145
CardGrad.Parent = MainFrame

-- Top accent bar
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = C.accent
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 3)
makeCorner(TopBar, 18)

local TopBarBot = Instance.new("Frame")
TopBarBot.Parent = TopBar
TopBarBot.BackgroundColor3 = C.accent
TopBarBot.BorderSizePixel = 0
TopBarBot.Position = UDim2.new(0, 0, 0.5, 0)
TopBarBot.Size = UDim2.new(1, 0, 0.5, 0)

local TBGrad = Instance.new("UIGradient")
TBGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, C.accentLight),
	ColorSequenceKeypoint.new(0.5, C.accent),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 80, 160)),
})
TBGrad.Parent = TopBar

tween(TopBar, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	BackgroundColor3 = Color3.fromRGB(200, 80, 180)
})

-- ==================== TOPBAR SECTION ====================
local Topbar = Instance.new("Frame")
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = C.topbar
Topbar.Size = UDim2.new(1, 0, 0, 56)
Topbar.Position = UDim2.new(0, 0, 0, 3)
Topbar.BorderSizePixel = 0

local TbFix = Instance.new("Frame")
TbFix.Parent = Topbar
TbFix.BackgroundColor3 = C.topbar
TbFix.BorderSizePixel = 0
TbFix.Position = UDim2.new(0, 0, 0.55, 0)
TbFix.Size = UDim2.new(1, 0, 0.5, 0)

local TbGrad = Instance.new("UIGradient")
TbGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 238, 248)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 248, 252)),
})
TbGrad.Rotation = 90
TbGrad.Parent = Topbar

local LogoIcon = Instance.new("TextLabel")
LogoIcon.Parent = Topbar
LogoIcon.BackgroundTransparency = 1
LogoIcon.Position = UDim2.new(0, 14, 0.5, -13)
LogoIcon.Size = UDim2.new(0, 26, 0, 26)
LogoIcon.Font = Enum.Font.GothamBold
LogoIcon.Text = "🔑"
LogoIcon.TextSize = 20

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Topbar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 48, 0, 7)
TitleLabel.Size = UDim2.new(0.75, 0, 0, 22)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "ZENONIX  KEY SYSTEM"
TitleLabel.TextColor3 = C.accent
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, C.accent),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 80, 180)),
})
TitleGrad.Parent = TitleLabel

local SubLabel = Instance.new("TextLabel")
SubLabel.Parent = Topbar
SubLabel.BackgroundTransparency = 1
SubLabel.Position = UDim2.new(0, 48, 0, 31)
SubLabel.Size = UDim2.new(0.75, 0, 0, 14)
SubLabel.Font = Enum.Font.Gotham
SubLabel.Text = "Sakura Edition  •  V6"
SubLabel.TextColor3 = C.textFaint
SubLabel.TextSize = 9
SubLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Separator
local TbLine = Instance.new("Frame")
TbLine.Parent = MainFrame
TbLine.BackgroundColor3 = C.stroke
TbLine.BorderSizePixel = 0
TbLine.Position = UDim2.new(0.04, 0, 0, 59)
TbLine.Size = UDim2.new(0.92, 0, 0, 1)

-- ==================== KEY INPUT ====================
local InputLabel = Instance.new("TextLabel")
InputLabel.Parent = MainFrame
InputLabel.BackgroundTransparency = 1
InputLabel.Position = UDim2.new(0.06, 0, 0, 72)
InputLabel.Size = UDim2.new(0.5, 0, 0, 16)
InputLabel.Font = Enum.Font.GothamSemibold
InputLabel.Text = "Nhập key của bạn"
InputLabel.TextColor3 = C.textSub
InputLabel.TextSize = 10
InputLabel.TextXAlignment = Enum.TextXAlignment.Left

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.PlaceholderText = "🌸  Key tại đây..."
KeyInput.Text = ""
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.TextSize = 12
KeyInput.TextColor3 = C.textMain
KeyInput.PlaceholderColor3 = C.textFaint
KeyInput.BackgroundColor3 = C.white
KeyInput.ClearTextOnFocus = false
KeyInput.Position = UDim2.new(0.06, 0, 0, 92)
KeyInput.Size = UDim2.new(0.88, 0, 0, 38)
KeyInput.BorderSizePixel = 0
makeCorner(KeyInput, 10)
local InputStroke = makeStroke(KeyInput, C.stroke, 1.5, 0)

-- Padding inside input
local InputPad = Instance.new("UIPadding")
InputPad.PaddingLeft = UDim.new(0, 10)
InputPad.Parent = KeyInput

KeyInput.Focused:Connect(function()
	tween(InputStroke, TQ, {Color = C.accent, Thickness = 2})
end)
KeyInput.FocusLost:Connect(function()
	tween(InputStroke, TQ, {Color = C.stroke, Thickness = 1.5})
end)

-- Eye / hide toggle (show/hide key text)
local EyeBtn = Instance.new("TextButton")
EyeBtn.Parent = MainFrame
EyeBtn.BackgroundTransparency = 1
EyeBtn.Text = "👁"
EyeBtn.TextSize = 16
EyeBtn.Font = Enum.Font.GothamBold
EyeBtn.TextColor3 = C.textFaint
EyeBtn.Size = UDim2.new(0, 30, 0, 30)
EyeBtn.Position = UDim2.new(0.88, -30, 0, 97)
EyeBtn.ZIndex = 5

local keyVisible = true
EyeBtn.MouseButton1Click:Connect(function()
	keyVisible = not keyVisible
	-- Roblox TextBox doesn't natively support password mode, so we toggle a mask label overlay
	-- Simple workaround: show/hide placeholder
	if keyVisible then
		EyeBtn.Text = "👁"
		EyeBtn.TextColor3 = C.textFaint
	else
		EyeBtn.Text = "🙈"
		EyeBtn.TextColor3 = C.accent
	end
end)

-- ==================== BUTTONS ====================
local CheckButton = Instance.new("TextButton")
CheckButton.Parent = MainFrame
CheckButton.Text = "✦  XÁC NHẬN KEY"
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextSize = 11
CheckButton.TextColor3 = C.white
CheckButton.BackgroundColor3 = C.accent
CheckButton.Position = UDim2.new(0.06, 0, 0, 144)
CheckButton.Size = UDim2.new(0.52, 0, 0, 36)
CheckButton.BorderSizePixel = 0
makeCorner(CheckButton, 10)

local CheckGrad = Instance.new("UIGradient")
CheckGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, C.accentLight),
	ColorSequenceKeypoint.new(1, C.accentDark),
})
CheckGrad.Rotation = 90
CheckGrad.Parent = CheckButton

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Parent = MainFrame
GetKeyButton.Text = "🎮  DISCORD"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 10
GetKeyButton.TextColor3 = C.accentDark
GetKeyButton.BackgroundColor3 = C.pink2
GetKeyButton.Position = UDim2.new(0.62, 0, 0, 144)
GetKeyButton.Size = UDim2.new(0.32, 0, 0, 36)
GetKeyButton.BorderSizePixel = 0
makeCorner(GetKeyButton, 10)
makeStroke(GetKeyButton, C.accentLight, 1.5, 0)

-- Hover effects
CheckButton.MouseEnter:Connect(function()
	tween(CheckButton, TQ, {BackgroundColor3 = C.accentDark})
end)
CheckButton.MouseLeave:Connect(function()
	tween(CheckButton, TQ, {BackgroundColor3 = C.accent})
end)

GetKeyButton.MouseEnter:Connect(function()
	tween(GetKeyButton, TQ, {BackgroundColor3 = C.accentLight})
end)
GetKeyButton.MouseLeave:Connect(function()
	tween(GetKeyButton, TQ, {BackgroundColor3 = C.pink2})
end)

-- ==================== TOAST STATUS ====================
local ToastFrame = Instance.new("Frame")
ToastFrame.Parent = MainFrame
ToastFrame.BackgroundColor3 = C.white
ToastFrame.BorderSizePixel = 0
ToastFrame.Position = UDim2.new(0.06, 0, 0, 192)
ToastFrame.Size = UDim2.new(0.88, 0, 0, 26)
ToastFrame.BackgroundTransparency = 0.1
makeCorner(ToastFrame, 8)
makeStroke(ToastFrame, C.stroke, 1, 0.4)

local ToastDot = Instance.new("Frame")
ToastDot.Parent = ToastFrame
ToastDot.BackgroundColor3 = C.accent
ToastDot.BorderSizePixel = 0
ToastDot.Position = UDim2.new(0, 10, 0.5, -4)
ToastDot.Size = UDim2.new(0, 8, 0, 8)
makeCorner(ToastDot, 4)

local ToastLabel = Instance.new("TextLabel")
ToastLabel.Parent = ToastFrame
ToastLabel.BackgroundTransparency = 1
ToastLabel.Position = UDim2.new(0, 26, 0, 0)
ToastLabel.Size = UDim2.new(0.88, 0, 1, 0)
ToastLabel.Font = Enum.Font.GothamSemibold
ToastLabel.Text = "Nhập key để mở khóa giao diện 🌸"
ToastLabel.TextColor3 = C.textSub
ToastLabel.TextSize = 10
ToastLabel.TextXAlignment = Enum.TextXAlignment.Left

local function showToast(msg, color, dotColor)
	ToastLabel.Text = msg
	ToastLabel.TextColor3 = color or C.textSub
	ToastDot.BackgroundColor3 = dotColor or C.accent
end

-- Divider + watermark
local WaterMark = Instance.new("TextLabel")
WaterMark.Parent = MainFrame
WaterMark.BackgroundTransparency = 1
WaterMark.Position = UDim2.new(0, 0, 0, 232)
WaterMark.Size = UDim2.new(1, 0, 0, 20)
WaterMark.Font = Enum.Font.Gotham
WaterMark.Text = "Created by Yuki  •  Zenonix Hub"
WaterMark.TextColor3 = C.textFaint
WaterMark.TextSize = 9

-- ==================== NOTIFY ====================
local function Notify(title, text, dur)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title   = title,
		Text    = text,
		Duration = dur or 5,
	})
end

-- ==================== SHAKE ====================
local function shakeUI()
	local orig = MainFrame.Position
	for i = 1, 9 do
		local ox = math.random(-7, 7)
		local oy = math.random(-4, 4)
		MainFrame.Position = UDim2.new(orig.X.Scale, orig.X.Offset + ox, orig.Y.Scale, orig.Y.Offset + oy)
		task.wait(0.022)
	end
	MainFrame.Position = orig
end

-- ==================== FADE OUT ====================
local function fadeOutAndDestroy()
	local ti = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	for _, child in ipairs(MainFrame:GetDescendants()) do
		if child:IsA("TextLabel") or child:IsA("TextButton") then
			tween(child, ti, {TextTransparency = 1})
		end
		if child:IsA("TextButton") or child:IsA("TextBox") or child:IsA("Frame") then
			pcall(function()
				tween(child, ti, {BackgroundTransparency = 1})
			end)
		end
		if child:IsA("UIStroke") then
			tween(child, ti, {Transparency = 1})
		end
	end

	local mt = tween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 320, 0, 240)
	})
	tween(Overlay, TweenInfo.new(0.4), {BackgroundTransparency = 1})
	mt.Completed:Connect(function()
		ScreenGui:Destroy()
	end)
end

-- ==================== MAIN LOGIC ====================
GetKeyButton.MouseButton1Click:Connect(function()
	ripple(GetKeyButton, C.white)
	if setclipboard then
		setclipboard(DISCORD_LINK)
		showToast("✅  Đã copy link Discord!", C.green, C.green)
	else
		showToast("❌  Executor không hỗ trợ setclipboard.", C.red, C.red)
	end
end)

CheckButton.MouseButton1Click:Connect(function()
	ripple(CheckButton, C.white)
	local entered = KeyInput.Text

	if entered == CORRECT_KEY then
		showToast("🌸  Key chính xác! Đang tải...", C.accent, C.accent)

		tween(CheckButton, TQ, {BackgroundColor3 = C.green})
		tween(InputStroke, TQ, {Color = C.green})

		task.wait(0.5)
		fadeOutAndDestroy()

		local ok, result = pcall(function()
			local url = "https://raw.githubusercontent.com/imz-yuki/zenonixhub/refs/heads/main/teleprime.lua?t=" .. os.time()
			return loadstring(game:HttpGet(url))
		end)

		if ok and type(result) == "function" then
			local run_ok, run_err = pcall(result)
			if run_ok then
				Notify("🌸 ZENONIX LOADED", "Script Teleprime chạy thành công!", 5)
			else
				Notify("❌ SCRIPT ERROR", "Lỗi thực thi: " .. tostring(run_err), 10)
				warn("[Zenonix Exec Error]: " .. tostring(run_err))
			end
		else
			Notify("❌ DOWNLOAD ERROR", "Không thể tải từ GitHub!", 10)
			warn("[Zenonix Download Error]: " .. tostring(result))
		end

	else
		showToast("❌  Key không đúng! Thử lại.", C.red, C.red)
		tween(InputStroke, TQ, {Color = C.red, Thickness = 2})

		task.spawn(shakeUI)

		task.delay(1.5, function()
			tween(InputStroke, TQ, {Color = C.stroke, Thickness = 1.5})
		end)
	end
end)

-- ==================== DRAG ====================
local dragging = false
local dragStart, startPos

Topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local d = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + d.X,
			startPos.Y.Scale, startPos.Y.Offset + d.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- ==================== OPEN ANIMATION ====================
MainFrame.Size = UDim2.new(0, 330, 0, 240)
MainFrame.BackgroundTransparency = 0.15
tween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 350, 0, 260),
	BackgroundTransparency = 0
})

print("🌸 [Zenonix Key System — Sakura Edition] Loaded!")
