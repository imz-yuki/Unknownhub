-- [[ ZENONIX HUB - FIX LAG LOADER ]] --
-- ✮-> yuki.dev

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Giao diện Loader
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YukiFixLagLoader"
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 100)
Main.Position = UDim2.new(0.5, -150, 0.5, -50)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "ZENONIX HUB | FIX LAG"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 35)
Status.BackgroundTransparency = 1
Status.Text = "Đang xác nhận: yuki.dev..."
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.TextSize = 12
Status.Font = Enum.Font.Gotham
Status.Parent = Main

-- Thanh Progress Bar
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 240, 0, 6)
BarBg.Position = UDim2.new(0.5, -120, 0.75, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
BarBg.BorderSizePixel = 0
BarBg.Parent = Main
local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 4)
corner2.Parent = BarBg

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(58, 134, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg
local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 4)
corner3.Parent = BarFill

-- [[ LOGIC CHẠY 3 GIÂY ]] --
task.spawn(function()
    -- Chạy thanh bar trong 3 giây
    local tween = TweenService:Create(BarFill, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
    tween:Play()
    
    task.wait(1.5)
    Status.Text = "Xác nhận thành công! Đang tải..."
    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    tween.Completed:Wait()
    
    Status.Text = "Khởi chạy Fix Lag..."
    task.wait(0.5)
    
    -- Xóa UI Loader và chạy script chính
    ScreenGui:Destroy()
    
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/imz-yuki/zenonixhub/refs/heads/main/fixlafforesto.lua"))()
    end)
    
    if not success then
        warn("Lỗi tải script: " nil .. tostring(err))
    end
end)
