-- [[ MODULE 15: FLOATING CIRCLE BUTTON + TOGGLE (PC + Mobile)]]

local scriptEnabled = true
local FloatingButton = nil

local function createFloatingButton()
    if FloatingButton then FloatingButton:Destroy() end
    
    FloatingButton = Instance.new("TextButton")
    FloatingButton.Name = "UnknownHub_FloatingBtn"
    FloatingButton.Size = UDim2.new(0, 55, 0, 55)
    FloatingButton.Position = UDim2.new(0, 20, 0.5, -80)  -- Có thể kéo di chuyển
    FloatingButton.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
    FloatingButton.Text = "🌌"
    FloatingButton.TextColor3 = Color3.new(1, 1, 1)
    FloatingButton.TextSize = 28
    FloatingButton.Font = Enum.Font.GothamBold
    FloatingButton.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)  -- Làm nút tròn
    corner.Parent = FloatingButton
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Parent = FloatingButton
    
    -- Làm nút có thể kéo di chuyển (PC + Mobile)
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    FloatingButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = FloatingButton.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    FloatingButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            FloatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Bấm nút tròn để hiện GUI
    FloatingButton.MouseButton1Click:Connect(function()
        scriptEnabled = true
        MainFrame.Visible = true
        IS_UI_OPEN = true
        FloatingButton.Visible = false
    end)
end

-- Tạo nút điều khiển trong Header
local function createControlButtons()
    local ControlFrame = Instance.new("Frame")
    ControlFrame.Size = UDim2.new(0, 155, 0, 40)
    ControlFrame.Position = UDim2.new(1, -170, 0, 8)
    ControlFrame.BackgroundColor3 = CFG.Theme.CardBg
    ControlFrame.Parent = Header

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 8)
    cc.Parent = ControlFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0.5, -4, 1, -8)
    ToggleBtn.Position = UDim2.new(0, 4, 0, 4)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
    ToggleBtn.Text = "🔴 ON"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.Parent = ControlFrame

    local DestroyBtn = Instance.new("TextButton")
    DestroyBtn.Size = UDim2.new(0.5, -4, 1, -8)
    DestroyBtn.Position = UDim2.new(0.5, 0, 0, 4)
    DestroyBtn.BackgroundColor3 = Color3.fromRGB(190, 40, 40)
    DestroyBtn.Text = "🗑️ XÓA"
    DestroyBtn.TextColor3 = Color3.new(1,1,1)
    DestroyBtn.Font = Enum.Font.GothamBold
    DestroyBtn.TextSize = 12
    DestroyBtn.Parent = ControlFrame

    local function updateToggleUI()
        if scriptEnabled then
            ToggleBtn.Text = "🔴 ON"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
        else
            ToggleBtn.Text = "⚪ OFF"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end
    end

    ToggleBtn.MouseButton1Click:Connect(function()
        scriptEnabled = not scriptEnabled
        MainFrame.Visible = scriptEnabled
        IS_UI_OPEN = scriptEnabled
        updateToggleUI()
        
        if not scriptEnabled and FloatingButton then
            FloatingButton.Visible = true
        end
    end)

    DestroyBtn.MouseButton1Click:Connect(function()
        if FloatingButton then FloatingButton:Destroy() end
        ScreenGui:Destroy()
        print("Unknown Hub v18.0 đã bị xóa.")
    end)

    updateToggleUI()
end

-- Khởi tạo
createControlButtons()
createFloatingButton()

-- Ẩn nút tròn khi GUI đang mở
MainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    if FloatingButton then
        FloatingButton.Visible = not MainFrame.Visible
    end
end)
