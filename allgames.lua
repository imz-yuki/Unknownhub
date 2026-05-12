--[[ 
    HỆ THỐNG KIỂM SOÁT TRUY CẬP - ZENONIX OMNIVERSE
    TRẠNG THÁI: BẢO TRÌ HỆ THỐNG (MAINTENANCE)
]]--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Nội dung thông báo hiển thị khi bị Kick
local LyDoBaoTri = "\n\n[ ZENONIX REBORN thông báo ]\n\n" ..
                   "Script hiện đang vào chế độ BẢO TRÌ KHẨN CẤP.\n" ..
                   "Lý do: Phát hiện lỗi không mong muốn trong bộ lõi Aimlock V4.\n" ..
                   "Thời gian dự kiến hoàn thành: Chưa xác định.\n\n" ..
                   "Vui lòng theo dõi thông tin tại Server để cập nhật bản Fix mới nhất!"

-- Thực thi Kick ngay lập tức khi Script vừa load
if LocalPlayer then
    LocalPlayer:Kick(LyDoBaoTri)
else
    -- Phòng trường hợp script chạy quá nhanh khi player chưa load xong
    Players.PlayerAdded:Connect(function(plr)
        if plr == LocalPlayer then
            plr:Kick(LyDoBaoTri)
        end
    end)
end

-- Dừng toàn bộ code phía sau không cho chạy tiếp
if true then return end 

-- ==========================================================
-- (Đoạn code Aimlock cũ của ông ở phía dưới này sẽ không bao giờ được chạm tới)
-- ==========================================================
