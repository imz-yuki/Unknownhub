--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║          ⌬  ZENONIX ELITE V4.0 // PHIÊN BẢN HOÀN CHỈNH FIX FULL           ║
    ║          >> TỐI ƯU HOÁ BỞI: MINH MEO OMNIVERSE                            ║
    ║          >> ĐẶC ĐIỂM: SIÊU NHẸ, KHÔNG UI RÁC, XOÁ BỎ HOÀN TOÀN LAG CODE    ║
    ║          >> CHỨC NĂNG: LERP CAMERA, WALL CHECK, PING PREDICTION, FOV      ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]--

-- ==================== [ BẢNG CẤU HÌNH TÙY CHỈNH CHUẨN ] ====================
local CấuHình = {
    Phím_Aimlock = Enum.KeyCode.Q,          -- Phím giữ để khóa tâm
    Bộ_Phận_Khóa = "Head",                 -- Vị trí khóa: "Head" (Đầu) hoặc "HumanoidRootPart" (Người)
    
    -- THUẬT TOÁN CAMERA (FIX MƯỢT)
    Độ_Mượt = 0.12,                         -- Từ 0.01 đến 1 (Càng cao khóa càng cứng, 1 là dính tuyệt đối)
    Giữ_Mục_Tiêu = true,                    -- Sticky Lock: Giữ chặt 1 đứa cho đến khi nó chết hoặc khuất tường
    
    -- BỘ LỌC ĐIỀU KIỆN (FIX XUYÊN TƯỜNG / ĐỒNG ĐỘI)
    Kiểm_Tra_Tường = true,                  -- Wall Check: Không khóa mục tiêu đứng sau vật cản
    Kiểm_Tra_Đồng_Đội = false,               -- Team Check: Bật true nếu muốn bỏ qua đồng đội
    Kiểm_Tra_Gục = true,                    -- Không lock người chơi đã bị knock/gục
    
    -- DỰ ĐOÁN ĐƯỜNG ĐẠN (PREDICTION FIX BÙ PING)
    Dự_Đoán_Quỹ_Đạo = true,                 -- Tự động tính toán trước vị trí di chuyển dựa trên tốc độ đối thủ
    Hệ_Số_Dự_Đoán = 0.135,                  -- Điều chỉnh theo độ giật của súng (Khoảng 0.1 - 0.15)
    
    -- PHẠM VI QUÉT (FOV)
    Hiển_Thị_FOV = true,                    -- Hiện vòng tròn giới hạn vùng khóa tâm
    Bán_Kính_FOV = 150,                     -- Kích thước vòng quét (pixels)
    Màu_FOV = Color3.fromRGB(0, 255, 150),   -- Màu xanh neon cyber
    Độ_Dày_FOV = 1.5                        -- Độ nét của nét vẽ FOV
}

-- ==================== [ BỘ LÕI HỆ THỐNG GỐC ] ====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Mục_Tiêu_Hiện_Tại = nil
local Đang_Giữ_Phím = false

-- Đồng bộ camera liên tục khi hồi sinh chống lỗi mất CFrame
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = workspace.CurrentCamera
end)

-- Khởi tạo vòng tròn FOV tối ưu (Tránh tạo lại liên tục gây lag RAM)
local VòngTrònFOV = Drawing.new("Circle")
VòngTrònFOV.Filled = false
VòngTrònFOV.Transparency = 0.8

-- ==================== [ THUẬT TOÁN KIỂM TRA CHUYÊN SÂU ] ====================
local function KiểmTraHợpLệ(Khớp_Xương, Kẻ_Địch)
    if not Khớp_Xương or not Kẻ_Địch.Character then return false end
    
    local Hum = Kẻ_Địch.Character:FindFirstChildOfClass("Humanoid")
    if not Hum or Hum.Health <= 0 then return false end
    
    -- Check gục (Dành cho các game có cơ chế Knockdown)
    if CấuHình.Kiểm_Tra_Gục and (Kẻ_Địch.Character:FindFirstChild("KO") or Kẻ_Địch.Character:FindFirstChild("Knocked")) then
        return false
    end
    
    -- Check tường cản (Raycast hiệu năng cao)
    if CấuHình.Kiểm_Tra_Tường then
        local CamPos = Camera.CFrame.Position
        local Params = RaycastParams.new()
        Params.FilterType = Enum.RaycastFilterType.Exclude
        Params.FilterDescendantsInstances = {LocalPlayer.Character, Camera, Kẻ_Địch.Character}
        Params.IgnoreWater = true
        
        local KếtQuả = workspace:Raycast(CamPos, Khớp_Xương.Position - CamPos, Params)
        if KếtQuả then return false end -- Bị cản bởi địa hình
    end
    
    return true
end

local function TìmMụcTiêuTốtNhất()
    -- Cơ chế Sticky Lock: Nếu mục tiêu cũ vẫn hợp lệ thì giữ nguyên không quét lại tránh loạn tâm
    if CấuHình.Giữ_Mục_Tiêu and Mục_Tiêu_Hiện_Tại then
        if Mục_Tiêu_Hiện_Tại.Parent and KiểmTraHợpLệ(Mục_Tiêu_Hiện_Tại, Players:GetPlayerFromCharacter(Mục_Tiêu_Hiện_Tại.Parent)) then
            local ToaDoManHinh, TrenManHinh = Camera:WorldToViewportPoint(Mục_Tiêu_Hiện_Tại.Position)
            if TrenManHinh then
                local KhoangCachChuot = (Vector2.new(ToaDoManHinh.X, ToaDoManHinh.Y) - UserInputService:GetMouseLocation()).Magnitude
                if KhoangCachChuot <= CấuHình.Bán_Kính_FOV then
                    return Mục_Tiêu_Hiện_Tại
                end
            end
        end
    end

    local KhớpXuơngGầnNhất = nil
    local KhoảngCáchNhỏNhất = math.huge
    local VịTríChuột = UserInputService:GetMouseLocation()

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character then
            if CấuHình.Kiểm_Tra_Đồng_Đội and Player.Team == LocalPlayer.Team then continue end
            
            local Khớp_Xương = Player.Character:FindFirstChild(CấuHình.Bộ_Phận_Khóa)
            if Khớp_Xương and KiểmTraHợpLệ(Khớp_Xương, Player) then
                local ToaDoManHinh, TrenManHinh = Camera:WorldToViewportPoint(Khớp_Xương.Position)
                
                if TrenManHinh then
                    local KhoangCachChuot = (Vector2.new(ToaDoManHinh.X, ToaDoManHinh.Y) - VịTríChuột).Magnitude
                    
                    -- Nằm trong phạm vi vòng FOV và gần tâm chuột nhất
                    if KhoangCachChuot <= CấuHình.Bán_Kính_FOV and KhoangCachChuot < KhoảngCáchNhỏNhất then
                        KhoảngCáchNhỏNhất = KhoangCachChuot
                        KhớpXuơngGầnNhất = Khớp_Xương
                    end
                end
            end
        end
    end
    return KhớpXuơngGầnNhất
end

-- ==================== [ LẮNG NGHE SỰ KIỆN INPUT ] ====================
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end
    if Input.KeyCode == CấuHình.Phim_Aimlock then
        Đang_Giữ_Phím = true
        Mục_Tiêu_Hiện_Tại = TìmMụcTiêuTốtNhất()
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.KeyCode == CấuHình.Phim_Aimlock then
        Đang_Giữ_Phím = false
        Mục_Tiêu_Hiện_Tại = nil
    end
end)

-- ==================== [ VÒNG LẶP XỬ LÝ FRAME SIÊU TỐC ] ====================
RunService.RenderStepped:Connect(function()
    -- Đồng bộ hóa vòng tròn FOV đồ họa
    if CấuHình.Hiển_Thị_FOV then
        VòngTrònFOV.Position = UserInputService:GetMouseLocation()
        VòngTrònFOV.Radius = CấuHình.Bán_Kính_FOV
        VòngTrònFOV.Color = CấuHình.Màu_FOV
        VòngTrònFOV.Thickness = CấuHình.Độ_Dày_FOV
        VòngTrònFOV.Visible = true
    else
        VòngTrònFOV.Visible = false
    end

    -- Xử lý khóa tâm và tính toán vị trí di chuyển nâng cao
    if Đang_Giữ_Phím and Mục_Tiêu_Hiện_Tại then
        local Player_MucTieu = Players:GetPlayerFromCharacter(Mục_Tiêu_Hiện_Tại.Parent)
        
        if Player_MucTieu and KiểmTraHợpLệ(Mục_Tiêu_Hiện_Tại, Player_MucTieu) then
            local Vị_Trí_Khóa = Mục_Tiêu_Hiện_Tại.Position
            
            -- Thuật toán ma trận bù tốc độ di chuyển nâng cao (Prediction Fix)
            if CấuHình.Dự_Đoán_Quỹ_Đạo then
                local Vận_Tốc = Mục_Tiêu_Hiện_Tại.Velocity
                local Ping = 0.03
                pcall(function() Ping = LocalPlayer:GetNetworkPing() end)
                
                -- Tính toán điểm đón đầu dựa trên vận tốc thực và độ trễ mạng lưới (Ping)
                Vị_Trí_Khóa = Vị_Trí_Khóa + (Vận_Tốc * CấuHình.Hệ_Số_Dự_Đoán) + (Mục_Tiêu_Hiện_Tại.AssemblyLinearVelocity * Ping * 0.5)
            end
            
            -- Nội suy góc nhìn mượt mà, triệt tiêu hoàn toàn hiện tượng khựng khung hình
            local MaTrậnGócNhìn = CFrame.lookAt(Camera.CFrame.Position, Vị_Trí_Khóa)
            Camera.CFrame = Camera.CFrame:Lerp(MaTrậnGócNhìn, CấuHình.Độ_Mượt)
        else
            -- Nếu mục tiêu chết hoặc khuất tường, ngay lập tức chuyển sang đứa tiếp theo
            Mục_Tiêu_Hiện_Tại = TìmMụcTiêuTốtNhất()
        end
    end
end)
