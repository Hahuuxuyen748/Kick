local function createESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        local existingESP = head:FindFirstChild("ESP")

        if not existingESP then
            -- Tạo ESP mới
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP"
            billboard.Adornee = head
            billboard.Size = UDim2.new(1, 0, 1, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = head

            local label = Instance.new("TextLabel", billboard)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = player.Name
            label.TextScaled = true
            label.Font = Enum.Font.SourceSansBold

            -- Hiệu ứng 7 màu
            local colors = {
                Color3.fromRGB(255, 0, 0),   -- Đỏ
                Color3.fromRGB(255, 165, 0), -- Cam
                Color3.fromRGB(255, 255, 0), -- Vàng
                Color3.fromRGB(0, 255, 0),   -- Xanh lá
                Color3.fromRGB(0, 255, 255), -- Xanh dương nhạt
                Color3.fromRGB(0, 0, 255),   -- Xanh dương
                Color3.fromRGB(128, 0, 128)  -- Tím
            }

            -- Vòng lặp đổi màu
            task.spawn(function()
                local index = 1
                while label.Parent do
                    label.TextColor3 = colors[index]
                    index = (index % #colors) + 1 -- Lặp qua các màu
                    wait(0.5) -- Đổi màu mỗi 0.5 giây
                end
            end)
        end
    end
end

local function updateESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            createESP(player)
        end
    end
end

-- Gắn ESP khi có người chơi mới vào
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1) -- Chờ nhân vật load hoàn toàn
        createESP(player)
    end)
end)

-- Lần đầu khởi chạy
updateESP()

-- Cập nhật ESP mỗi khung hình
game:GetService("RunService").RenderStepped:Connect(updateESP)
