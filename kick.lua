
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Giả sử phát hiện hack, bạn sẽ trigger thông báo dưới đây
        local suspicious = false -- Thay bằng điều kiện kiểm tra hack
        
        -- Ví dụ kiểm tra tốc độ
        local humanoid = character:WaitForChild("Humanoid")
        if humanoid.WalkSpeed > 16 then -- WalkSpeed mặc định là 16
            suspicious = true
        end

        if suspicious then
            -- Tạo GUI cảnh báo
            local gui = Instance.new("ScreenGui")
            gui.Name = "WarningGUI"

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0.5, 0, 0.4, 0)
            frame.Position = UDim2.new(0.25, 0, 0.3, 0)
            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            frame.Parent = gui

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0.7, 0)
            label.Position = UDim2.new(0, 0, 0, 0)
            label.Text = "Cảnh báo: Đừng hack nữa!\nBạn sẽ bị đá ra khỏi game trong:"
            label.TextColor3 = Color3.new(1, 0, 0)
            label.TextScaled = true
            label.BackgroundTransparency = 1
            label.Parent = frame

            local countdownLabel = Instance.new("TextLabel")
            countdownLabel.Size = UDim2.new(1, 0, 0.3, 0)
            countdownLabel.Position = UDim2.new(0, 0, 0.7, 0)
            countdownLabel.Text = "5"
            countdownLabel.TextColor3 = Color3.new(1, 1, 0)
            countdownLabel.TextScaled = true
            countdownLabel.BackgroundTransparency = 1
            countdownLabel.Parent = frame

            gui.Parent = player:WaitForChild("PlayerGui")

            -- Đếm ngược 5 giây
            for i = 5, 1, -1 do
                countdownLabel.Text = tostring(i)
                wait(1)
            end

            -- Đá người chơi ra khỏi game
            player:Kick("Đừng hack nữa! Bạn đã bị đá khỏi game.")
        end
    end)
end)