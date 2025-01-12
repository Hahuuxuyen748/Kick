local Players = game:GetService("Players")
local ChatService = game:GetService("Chat")

local Detected = {} -- Lưu danh sách người chơi bị phát hiện

Players.PlayerAdded:Connect(function(player)
    local actionCount = 0
    local lastActionTime = tick()
    
    player.CharacterAdded:Connect(function(character)
        character.HumanoidRootPart.Touched:Connect(function()
            local currentTime = tick()
            actionCount = actionCount + 1
            
            if currentTime - lastActionTime < 0.1 then
                actionCount = actionCount + 1
            else
                actionCount = 0
            end
            
            lastActionTime = currentTime
            
            if actionCount > 20 then
                if not Detected[player.Name] then
                    Detected[player.Name] = true
                    -- Gửi tin nhắn cảnh báo
                    ChatService:Chat(player.Character.Head, "Cảnh báo! Bạn bị phát hiện dùng auto. Dừng lại ngay!", Enum.ChatColor.Red)
                    
                    -- Đếm ngược 5 giây trước khi kick
                    for i = 5, 1, -1 do
                        ChatService:Chat(player.Character.Head, "Bạn sẽ bị đá khỏi game sau " .. i .. " giây!", Enum.ChatColor.Red)
                        task.wait(1)
                    end
                    
                    -- Kick người chơi
                    player:Kick("Bạn đã bị phát hiện sử dụng auto. Không gian lận!")
                end
            end
        end)
    end)
end)
