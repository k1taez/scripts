-- TeleportHub.lua (для ввода в Solara Executor)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Проверка PlayerGui
if not player:FindFirstChild("PlayerGui") then
    warn("PlayerGui not found!")
    return
end
print("PlayerGui found")

-- Создаем ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportHub"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false
screenGui.Enabled = true -- Хаб видим сразу
print("ScreenGui created")

-- Создаем закругленное окно (хаб)
local frame = Instance.new("Frame")
frame.Name = "HubWindow"
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.Parent = screenGui
print("Frame created")

-- Закругленные углы
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame
print("UICorner added")

-- Градиент
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 50, 50))
}
gradient.Rotation = 45
gradient.Parent = frame
print("UIGradient added")

-- Создаем таскбар
local taskbar = Instance.new("Frame")
taskbar.Name = "Taskbar"
taskbar.Size = UDim2.new(1, 0, 0, 30)
taskbar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
taskbar.BorderSizePixel = 0
taskbar.Parent = frame
print("Taskbar created")

-- Закругленные углы для таскбара
local taskbarCorner = Instance.new("UICorner")
taskbarCorner.CornerRadius = UDim.new(0, 15)
taskbarCorner.Parent = taskbar

-- Текст в таскбаре
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Teleport Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = taskbar
print("TitleLabel created")

-- Создаем кнопку-переключатель телепортации
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleTeleport"
toggleButton.Size = UDim2.new(0.8, 0, 0.25, 0)
toggleButton.Position = UDim2.new(0.1, 0, 0.25, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Text = "TELEPORT: OFF"
toggleButton.Parent = frame
print("ToggleButton created")

-- Закругленные углы для кнопки телепортации
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = toggleButton

-- Создаем кнопку заморозки
local freezeButton = Instance.new("TextButton")
freezeButton.Name = "FreezeButton"
freezeButton.Size = UDim2.new(0.8, 0, 0.25, 0)
freezeButton.Position = UDim2.new(0.1, 0, 0.45, 0)
freezeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeButton.TextScaled = true
freezeButton.Text = "FREEZE: OFF"
freezeButton.Parent = frame
print("FreezeButton created")

-- Закругленные углы для кнопки заморозки
local freezeButtonCorner = Instance.new("UICorner")
freezeButtonCorner.CornerRadius = UDim.new(0, 10)
freezeButtonCorner.Parent = freezeButton

-- Создаем кнопку бинда на фриз
local bindFreezeButton = Instance.new("TextButton")
bindFreezeButton.Name = "BindFreezeButton"
bindFreezeButton.Size = UDim2.new(0.8, 0, 0.25, 0)
bindFreezeButton.Position = UDim2.new(0.1, 0, 0.65, 0)
bindFreezeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
bindFreezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
bindFreezeButton.TextScaled = true
bindFreezeButton.Text = "BIND FREEZE: OFF"
bindFreezeButton.Parent = frame
print("BindFreezeButton created")

-- Закругленные углы для кнопки бинда
local bindButtonCorner = Instance.new("UICorner")
bindButtonCorner.CornerRadius = UDim.new(0, 10)
bindButtonCorner.Parent = bindFreezeButton

-- Координаты для телепортации
local positions = {
    Vector3.new(0, 3, 0), -- Позиция для OFF
    Vector3.new(-5000, 3, 3) -- Позиция для ON
}
local isTeleporting = false
local freezeEnabled = false
local bindFreezeEnabled = false
local currentBindKey = nil
local TELEPORT_INTERVAL = 0.01 -- Кулдаун 0.1 секунды

-- Функция для телепортации
local function teleportToPosition(position)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        print("Waiting for character or HumanoidRootPart")
        player.CharacterAdded:Wait()
        if not player.Character then
            warn("No character after respawn")
            return
        end
    end
    local success, errorMsg = pcall(function()
        local humanoidRootPart = player.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(position)
        print("Teleported to", position)
    end)
    if not success then
        warn("Teleport failed:", errorMsg)
    end
end

-- Функция для управления заморозкой
local function toggleFreeze(enabled)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        print("Waiting for character or HumanoidRootPart for freeze")
        player.CharacterAdded:Wait()
        if not player.Character then
            warn("No character after respawn")
            return
        end
    end
    local success, errorMsg = pcall(function()
        local humanoidRootPart = player.Character.HumanoidRootPart
        humanoidRootPart.Anchored = enabled
        print("Player", enabled and "frozen" or "unfrozen")
    end)
    if not success then
        warn("Freeze failed:", errorMsg)
    end
end

-- Функция для установки бинда на фриз
local function setupBindFreeze()
    if not bindFreezeEnabled or not currentBindKey then
        return
    end
    
    -- Обработка нажатия клавиши бинда
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentBindKey then
            freezeEnabled = not freezeEnabled
            toggleFreeze(freezeEnabled)
            
            -- Обновляем текст кнопки фриза
            freezeButton.Text = freezeEnabled and "FREEZE: ON" or "FREEZE: OFF"
            freezeButton.BackgroundColor3 = freezeEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
            
            print("Freeze toggled via bind to", freezeEnabled and "ON" or "OFF")
        end
    end)
    
    return connection
end

-- Цикл для телепортации на вторую координату
local function teleportLoop()
    while isTeleporting do
        teleportToPosition(positions[2]) -- Телепортация на (-5000, 3, 3)
        wait(TELEPORT_INTERVAL)
    end
end

-- Функция для телепортации 15-16 раз на первую координату
local function teleportOff()
    local teleportCount = math.random(15, 16) -- Случайное число от 15 до 16
    print("Teleporting to", positions[1], teleportCount, "times")
    for i = 1, teleportCount do
        teleportToPosition(positions[1]) -- Телепортация на (0, 3, 0)
        wait(TELEPORT_INTERVAL)
    end
end

-- Обработка нажатия на кнопку телепортации
toggleButton.MouseButton1Click:Connect(function()
    isTeleporting = not isTeleporting
    toggleButton.Text = isTeleporting and "TELEPORT: ON" or "TELEPORT: OFF"
    toggleButton.BackgroundColor3 = isTeleporting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    print("Teleport toggled to", isTeleporting and "ON" or "OFF")
    
    if isTeleporting then
        spawn(teleportLoop)
    else
        spawn(teleportOff) -- Телепортация 15-16 раз на первую координату
    end
end)

-- Обработка нажатия на кнопку заморозки
freezeButton.MouseButton1Click:Connect(function()
    freezeEnabled = not freezeEnabled
    freezeButton.Text = freezeEnabled and "FREEZE: ON" or "FREEZE: OFF"
    freezeButton.BackgroundColor3 = freezeEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
    print("Freeze toggled to", freezeEnabled and "ON" or "OFF")
    
    toggleFreeze(freezeEnabled)
end)

-- Обработка нажатия на кнопку бинда на фриз
local bindConnection
bindFreezeButton.MouseButton1Click:Connect(function()
    bindFreezeEnabled = not bindFreezeEnabled
    
    if bindFreezeEnabled then
        -- Запрос клавиши для бинда
        bindFreezeButton.Text = "PRESS A KEY..."
        bindFreezeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        
        -- Ждем нажатия клавиши
        local keyConnection
        keyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            if gameProcessedEvent then return end
            
            if input.UserInputType == Enum.UserInputType.Keyboard then
                currentBindKey = input.KeyCode
                bindFreezeButton.Text = "BIND: " .. tostring(currentBindKey):gsub("Enum.KeyCode.", "")
                bindFreezeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                
                -- Настраиваем бинд
                if bindConnection then
                    bindConnection:Disconnect()
                end
                bindConnection = setupBindFreeze()
                
                print("Bind freeze set to key:", currentBindKey)
                keyConnection:Disconnect()
            end
        end)
    else
        -- Выключаем бинд
        bindFreezeButton.Text = "BIND FREEZE: OFF"
        bindFreezeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        
        if bindConnection then
            bindConnection:Disconnect()
            bindConnection = nil
        end
        currentBindKey = nil
        
        print("Bind freeze disabled")
    end
end)

-- Перетаскивание окна через таскбар
local dragging
local dragInput
local dragStart
local startPos

taskbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

taskbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Упрощённая система клавиш для открытия/закрытия хаба (K)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end -- Игнорируем ввод в чате или интерфейсе
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.K then
        screenGui.Enabled = not screenGui.Enabled
        print("Teleport Hub", screenGui.Enabled and "opened" or "closed")
    end
end)

print("Teleport Hub loaded successfully!")
print("Press K to open/close the hub")
print("Use BIND FREEZE to set a key for quick freeze toggle")
