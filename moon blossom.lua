local success, err = pcall(function()
    -- Сервисы Roblox
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local Workspace = game:GetService("Workspace")
    local Camera = Workspace.CurrentCamera
    local Lighting = game:GetService("Lighting")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local Player = Players.LocalPlayer
    local Mouse = Player:GetMouse()

    -- Диагностика загрузки сервисов
    print("[MoonBlossom] Services loaded successfully")

    -- Удаляем старый GUI если существует
    if CoreGui:FindFirstChild("MoonBlossomGUI") then
        CoreGui.MoonBlossomGUI:Destroy()
    end

    -- Создаем новый GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MoonBlossomGUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- Основной фрейм (увеличиваем размер)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 320, 0, 500)
    MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(50, 40, 60)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Selectable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = true

    -- Добавляем округление углов
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame

    -- TitleBar для перетаскивания
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0.05, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Moon Blossom v2.1"
    Title.TextColor3 = Color3.fromRGB(220, 180, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = TitleBar

    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 35, 0, 35)
    CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TitleBar

    -- Кнопка сворачивания
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
    MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 18
    MinimizeButton.Parent = TitleBar

    -- Контейнер для кнопок
    local ButtonsContainer = Instance.new("Frame")
    ButtonsContainer.Name = "ButtonsContainer"
    ButtonsContainer.Size = UDim2.new(1, 0, 1, -35)
    ButtonsContainer.Position = UDim2.new(0, 0, 0, 35)
    ButtonsContainer.BackgroundTransparency = 1
    ButtonsContainer.Parent = MainFrame

    -- Кнопки переключателей
    local BHopToggle = Instance.new("TextButton")
    BHopToggle.Name = "BHopToggle"
    BHopToggle.Size = UDim2.new(0, 290, 0, 35)
    BHopToggle.Position = UDim2.new(0.045, 0, 0.025, 0)
    BHopToggle.Text = "Bunny Hop: OFF"
    BHopToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    BHopToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    BHopToggle.Font = Enum.Font.Gotham
    BHopToggle.TextSize = 14
    BHopToggle.Parent = ButtonsContainer

    local SitWalkToggle = Instance.new("TextButton")
    SitWalkToggle.Name = "SitWalkToggle"
    SitWalkToggle.Size = UDim2.new(0, 290, 0, 35)
    SitWalkToggle.Position = UDim2.new(0.045, 0, 0.095, 0)
    SitWalkToggle.Text = "Sit Walk: OFF"
    SitWalkToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    SitWalkToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    SitWalkToggle.Font = Enum.Font.Gotham
    SitWalkToggle.Parent = ButtonsContainer

    local ChamsToggle = Instance.new("TextButton")
    ChamsToggle.Name = "ChamsToggle"
    ChamsToggle.Size = UDim2.new(0, 290, 0, 35)
    ChamsToggle.Position = UDim2.new(0.045, 0, 0.165, 0)
    ChamsToggle.Text = "Player Chams: OFF"
    ChamsToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    ChamsToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    ChamsToggle.Font = Enum.Font.Gotham
    ChamsToggle.Parent = ButtonsContainer

    local SilentAimToggle = Instance.new("TextButton")
    SilentAimToggle.Name = "SilentAimToggle"
    SilentAimToggle.Size = UDim2.new(0, 290, 0, 35)
    SilentAimToggle.Position = UDim2.new(0.045, 0, 0.235, 0)
    SilentAimToggle.Text = "Silent Aim: OFF"
    SilentAimToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    SilentAimToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    SilentAimToggle.Font = Enum.Font.Gotham
    SilentAimToggle.Parent = ButtonsContainer

    local ESPToggle = Instance.new("TextButton")
    ESPToggle.Name = "ESPToggle"
    ESPToggle.Size = UDim2.new(0, 290, 0, 35)
    ESPToggle.Position = UDim2.new(0.045, 0, 0.305, 0)
    ESPToggle.Text = "ESP: OFF"
    ESPToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    ESPToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    ESPToggle.Font = Enum.Font.Gotham
    ESPToggle.Parent = ButtonsContainer

    local StrafeToggle = Instance.new("TextButton")
    StrafeToggle.Name = "StrafeToggle"
    StrafeToggle.Size = UDim2.new(0, 290, 0, 35)
    StrafeToggle.Position = UDim2.new(0.045, 0, 0.375, 0)
    StrafeToggle.Text = "Air Strafe: OFF"
    StrafeToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    StrafeToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    StrafeToggle.Font = Enum.Font.Gotham
    StrafeToggle.Parent = ButtonsContainer

    local ShadersToggle = Instance.new("TextButton")
    ShadersToggle.Name = "ShadersToggle"
    ShadersToggle.Size = UDim2.new(0, 290, 0, 35)
    ShadersToggle.Position = UDim2.new(0.045, 0, 0.445, 0)
    ShadersToggle.Text = "Shaders: OFF"
    ShadersToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    ShadersToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    ShadersToggle.Font = Enum.Font.Gotham
    ShadersToggle.Parent = ButtonsContainer

    local AimAssistToggle = Instance.new("TextButton")
    AimAssistToggle.Name = "AimAssistToggle"
    AimAssistToggle.Size = UDim2.new(0, 290, 0, 35)
    AimAssistToggle.Position = UDim2.new(0.045, 0, 0.515, 0)
    AimAssistToggle.Text = "Aim Assist: OFF"
    AimAssistToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    AimAssistToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    AimAssistToggle.Font = Enum.Font.Gotham
    AimAssistToggle.Parent = ButtonsContainer

    local WalkSpeedToggle = Instance.new("TextButton")
    WalkSpeedToggle.Name = "WalkSpeedToggle"
    WalkSpeedToggle.Size = UDim2.new(0, 290, 0, 35)
    WalkSpeedToggle.Position = UDim2.new(0.045, 0, 0.585, 0)
    WalkSpeedToggle.Text = "WalkSpeed: OFF"
    WalkSpeedToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    WalkSpeedToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    WalkSpeedToggle.Font = Enum.Font.Gotham
    WalkSpeedToggle.Parent = ButtonsContainer

    local FreezeToggle = Instance.new("TextButton")
    FreezeToggle.Name = "FreezeToggle"
    FreezeToggle.Size = UDim2.new(0, 290, 0, 35)
    FreezeToggle.Position = UDim2.new(0.045, 0, 0.655, 0)
    FreezeToggle.Text = "Freeze: OFF"
    FreezeToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    FreezeToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    FreezeToggle.Font = Enum.Font.Gotham
    FreezeToggle.Parent = ButtonsContainer

    local BindFreezeToggle = Instance.new("TextButton")
    BindFreezeToggle.Name = "BindFreezeToggle"
    BindFreezeToggle.Size = UDim2.new(0, 290, 0, 35)
    BindFreezeToggle.Position = UDim2.new(0.045, 0, 0.725, 0)
    BindFreezeToggle.Text = "Bind Freeze: OFF"
    BindFreezeToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    BindFreezeToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    BindFreezeToggle.Font = Enum.Font.Gotham
    BindFreezeToggle.Parent = ButtonsContainer

    -- Статус
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, 25)
    StatusLabel.Position = UDim2.new(0, 0, 0.95, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Status: Active"
    StatusLabel.TextColor3 = Color3.fromRGB(180, 150, 200)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 14
    StatusLabel.Parent = ButtonsContainer

    -- Стилизация кнопок
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    for _, button in ipairs(ButtonsContainer:GetChildren()) do
        if button:IsA("TextButton") then
            buttonCorner:Clone().Parent = button
        end
    end

    -- Принудительно показываем GUI
    ScreenGui.Enabled = true
    MainFrame.Visible = true

    -- Логика
    local BHopEnabled = false
    local SitWalkEnabled = false
    local ChamsEnabled = false
    local SilentAimEnabled = false
    local ESPEnabled = false
    local StrafeEnabled = false
    local ShadersEnabled = false
    local AimAssistEnabled = false
    local WalkSpeedEnabled = false
    local FreezeEnabled = false
    local BindFreezeEnabled = false
    local GUIEnabled = true

    -- Переменные для баннихопа
    local lastJumpTime = 0
    local isOnGround = false
    local groundContactStartTime = 0

    -- Переменные для ESP
    local ESPObjects = {}
    local ESPConnections = {}

    -- Переменные для Chams
    local ChamsObjects = {}
    local ChamsConnections = {}
    local OriginalMaterials = {}
    local OriginalColors = {}
    local OriginalTransparencies = {}

    -- Переменные для шейдеров
    local currentShaders = {}
    local originalPartProperties = {}

    -- Переменные для Aim Assist
    local aimAssistTarget = nil
    local aimAssistFOV = 180
    local fovCircle = nil

    -- Переменная для хранения исходной скорости
    local originalWalkSpeed = 16

    -- Переменные для Freeze
    local freezeEnabled = false
    local bindFreezeEnabled = false
    local currentBindKey = nil
    local bindConnection = nil

    -- Функция для создания визуального FOV
    local function createFOVCircle()
        if fovCircle then
            fovCircle:Remove()
        end
        
        fovCircle = Drawing.new("Circle")
        fovCircle.Visible = AimAssistEnabled or SilentAimEnabled
        fovCircle.Radius = aimAssistFOV
        fovCircle.Color = Color3.fromRGB(255, 100, 255)
        fovCircle.Thickness = 2
        fovCircle.Filled = false
        fovCircle.Transparency = 0.7
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        
        return fovCircle
    end

    -- Функция для обновления текста кнопок
    local function updateButtonText(button, enabled)
        if button.Name == "BHopToggle" then
            button.Text = "Bunny Hop: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "SitWalkToggle" then
            button.Text = "Sit Walk: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "ChamsToggle" then
            button.Text = "Player Chams: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "SilentAimToggle" then
            button.Text = "Silent Aim: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "ESPToggle" then
            button.Text = "ESP: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "StrafeToggle" then
            button.Text = "Air Strafe: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "ShadersToggle" then
            button.Text = "Shaders: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "AimAssistToggle" then
            button.Text = "Aim Assist: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "WalkSpeedToggle" then
            button.Text = "WalkSpeed: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "FreezeToggle" then
            button.Text = "Freeze: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "BindFreezeToggle" then
            button.Text = "Bind Freeze: " .. (enabled and "ON" or "OFF")
        end
    end

    -- Анимации переключения
    local function toggleButton(button, state)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local goal = {}
        
        if state then
            goal.BackgroundColor3 = Color3.fromRGB(140, 100, 180)
        else
            goal.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
        end
        
        TweenService:Create(button, tweenInfo, goal):Play()
        updateButtonText(button, state)
    end

    -- Функция для управления заморозкой
    local function toggleFreeze(enabled)
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
            print("Waiting for character or HumanoidRootPart for freeze")
            Player.CharacterAdded:Wait()
            if not Player.Character then
                warn("No character after respawn")
                return
            end
        end
        local success, errorMsg = pcall(function()
            local humanoidRootPart = Player.Character.HumanoidRootPart
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
        connection = UIS.InputBegan:Connect(function(input, gameProcessedEvent)
            if gameProcessedEvent then return end
            
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentBindKey then
                freezeEnabled = not freezeEnabled
                toggleFreeze(freezeEnabled)
                
                -- Обновляем текст кнопки фриза
                FreezeToggle.Text = freezeEnabled and "Freeze: ON" or "Freeze: OFF"
                FreezeToggle.BackgroundColor3 = freezeEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(80, 60, 100)
                
                print("Freeze toggled via bind to", freezeEnabled and "ON" or "OFF")
            end
        end)
        
        return connection
    end

    -- Улучшенная система Chams
    function enableChams()
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= Player then
                createChams(otherPlayer)
            end
        end
        
        table.insert(ChamsConnections, Players.PlayerAdded:Connect(function(newPlayer)
            if ChamsEnabled then
                createChams(newPlayer)
            end
        end))
        
        table.insert(ChamsConnections, Players.PlayerRemoving:Connect(function(leftPlayer)
            if ChamsObjects[leftPlayer] then
                for _, part in pairs(ChamsObjects[leftPlayer]) do
                    if part and part.Parent then
                        if OriginalMaterials[part] then
                            part.Material = OriginalMaterials[part]
                        end
                        if OriginalColors[part] then
                            part.Color = OriginalColors[part]
                        end
                        if OriginalTransparencies[part] then
                            part.LocalTransparencyModifier = OriginalTransparencies[part]
                        end
                    end
                end
                ChamsObjects[leftPlayer] = nil
            end
        end))
    end

    function disableChams()
        for _, connection in ipairs(ChamsConnections) do
            connection:Disconnect()
        end
        ChamsConnections = {}
        
        for player, parts in pairs(ChamsObjects) do
            for _, part in pairs(parts) do
                if part and part.Parent then
                    if OriginalMaterials[part] then
                        part.Material = OriginalMaterials[part]
                    end
                    if OriginalColors[part] then
                        part.Color = OriginalColors[part]
                    end
                    if OriginalTransparencies[part] then
                        part.LocalTransparencyModifier = OriginalTransparencies[part]
                    end
                end
            end
        end
        ChamsObjects = {}
        OriginalMaterials = {}
        OriginalColors = {}
        OriginalTransparencies = {}
    end

    function createChams(targetPlayer)
        if ChamsObjects[targetPlayer] then return end
        
        local function applyChams(character)
            if not character then return end
            
            local parts = {}
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Transparency < 1 then
                    OriginalMaterials[part] = part.Material
                    OriginalColors[part] = part.Color
                    OriginalTransparencies[part] = part.Transparency
                    
                    part.Material = Enum.Material.ForceField
                    part.Color = Color3.fromRGB(0, 150, 255)
                    part.Transparency = 0.3
                    
                    table.insert(parts, part)
                end
            end
            
            ChamsObjects[targetPlayer] = parts
            
            character.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                    OriginalMaterials[descendant] = descendant.Material
                    OriginalColors[descendant] = descendant.Color
                    OriginalTransparencies[descendant] = descendant.Transparency
                    
                    descendant.Material = Enum.Material.ForceField
                    descendant.Color = Color3.fromRGB(0, 150, 255)
                    descendant.Transparency = 0.3
                    
                    table.insert(ChamsObjects[targetPlayer], descendant)
                end
            end)
        end
        
        if targetPlayer.Character then
            applyChams(targetPlayer.Character)
        end
        
        targetPlayer.CharacterAdded:Connect(function(character)
            if ChamsEnabled then
                applyChams(character)
            end
        end)
    end

    -- ИСПРАВЛЕННАЯ ESP система с правильным управлением
    local ESPLoop = nil

    function enableESP()
        if ESPLoop then
            ESPLoop:Disconnect()
            ESPLoop = nil
        end
        
        ESPLoop = RunService.RenderStepped:Connect(function()
            if not ESPEnabled then
                disableESP()
                return
            end
            
            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                if otherPlayer ~= Player then
                    updateESP(otherPlayer)
                end
            end
        end)
    end

    function disableESP()
        if ESPLoop then
            ESPLoop:Disconnect()
            ESPLoop = nil
        end
        
        for player, objects in pairs(ESPObjects) do
            for _, obj in pairs(objects) do
                if obj then
                    obj:Remove()
                end
            end
        end
        ESPObjects = {}
    end

    function updateESP(targetPlayer)
        if not ESPEnabled or not targetPlayer or not targetPlayer.Parent then
            if ESPObjects[targetPlayer] then
                for _, obj in pairs(ESPObjects[targetPlayer]) do
                    if obj then
                        obj:Remove()
                    end
                end
                ESPObjects[targetPlayer] = nil
            end
            return
        end
        
        local character = targetPlayer.Character
        if not character then
            if ESPObjects[targetPlayer] then
                for _, obj in pairs(ESPObjects[targetPlayer]) do
                    if obj then
                        obj:Remove()
                    end
                end
                ESPObjects[targetPlayer] = nil
            end
            return
        end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if not (rootPart and head and humanoid and humanoid.Health > 0) then
            if ESPObjects[targetPlayer] then
                for _, obj in pairs(ESPObjects[targetPlayer]) do
                    if obj then
                        obj:Remove()
                    end
                end
                ESPObjects[targetPlayer] = nil
            end
            return
        end
        
        local rootPos, rootVisible = Camera:WorldToViewportPoint(rootPart.Position)
        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
        
        if not ESPObjects[targetPlayer] then
            ESPObjects[targetPlayer] = {}
            
            local box = Drawing.new("Square")
            box.Visible = false
            box.Color = Color3.fromRGB(255, 100, 255)
            box.Thickness = 2
            box.Filled = false
            table.insert(ESPObjects[targetPlayer], box)
            
            local tracer = Drawing.new("Line")
            tracer.Visible = false
            tracer.Color = Color3.fromRGB(255, 100, 255)
            tracer.Thickness = 1
            table.insert(ESPObjects[targetPlayer], tracer)
            
            local name = Drawing.new("Text")
            name.Visible = false
            name.Color = Color3.fromRGB(255, 100, 255)
            name.Size = 14
            name.Center = true
            name.Outline = true
            table.insert(ESPObjects[targetPlayer], name)
        end
        
        local espGroup = ESPObjects[targetPlayer]
        local box = espGroup[1]
        local tracer = espGroup[2]
        local name = espGroup[3]
        
        if rootVisible then
            local height = math.abs(headPos.Y - rootPos.Y) * 2
            local width = height * 1.5
            
            box.Size = Vector2.new(width, height)
            box.Position = Vector2.new(rootPos.X - width/2, rootPos.Y - height/2)
            box.Visible = true
            
            tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
            tracer.To = Vector2.new(rootPos.X, rootPos.Y)
            tracer.Visible = true
            
            name.Text = targetPlayer.Name
            name.Position = Vector2.new(rootPos.X, rootPos.Y - height/2 - 20)
            name.Visible = true
        else
            box.Visible = false
            tracer.Visible = false
            name.Visible = false
        end
    end

    -- Функция для поиска ближайшего игрока в FOV
    local function findClosestPlayerInFOV(fov, checkWalls)
        local closestPlayer = nil
        local closestDistance = math.huge
        local mousePos = Vector2.new(Mouse.X, Mouse.Y)
        
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= Player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = otherPlayer.Character.HumanoidRootPart
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    
                    if distance <= fov and distance < closestDistance then
                        if checkWalls then
                            -- Check if there's a wall between player and target
                            local cameraPos = Camera.CFrame.Position
                            local targetPos = rootPart.Position
                            
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                            raycastParams.FilterDescendantsInstances = {Player.Character, otherPlayer.Character}
                            local raycastResult = Workspace:Raycast(cameraPos, (targetPos - cameraPos).Unit * (targetPos - cameraPos).Magnitude, raycastParams)
                            
                            if not raycastResult then
                                closestDistance = distance
                                closestPlayer = otherPlayer
                            end
                        else
                            closestDistance = distance
                            closestPlayer = otherPlayer
                        end
                    end
                end
            end
        end
        
        return closestPlayer
    end

    -- ИСПРАВЛЕННЫЙ Aim Assist с правильным управлением
    local AimAssistLoop = nil

    local function startAimAssist()
        if AimAssistLoop then
            AimAssistLoop:Disconnect()
        end
        
        AimAssistLoop = RunService.RenderStepped:Connect(function()
            if not AimAssistEnabled then
                if AimAssistLoop then
                    AimAssistLoop:Disconnect()
                    AimAssistLoop = nil
                end
                return
            end
            
            if fovCircle then
                fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                fovCircle.Visible = true
            end
            
            if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local closestPlayer = findClosestPlayerInFOV(aimAssistFOV, true)
                    
                    if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                        local targetHead = closestPlayer.Character.Head
                        local cameraPosition = Camera.CFrame.Position
                        local targetPosition = targetHead.Position
                        
                        local direction = (targetPosition - cameraPosition).Unit
                        local currentLook = Camera.CFrame.LookVector
                        local smoothFactor = 0.3
                        
                        local newLook = currentLook:Lerp(direction, smoothFactor)
                        Camera.CFrame = CFrame.new(cameraPosition, cameraPosition + newLook)
                    end
                end
            end
        end)
    end

    -- ИСПРАВЛЕННЫЙ Silent Aim с правильным управлением
    local SilentAimLoop = nil

    local function startSilentAim()
        if SilentAimLoop then
            SilentAimLoop:Disconnect()
        end
        
        SilentAimLoop = RunService.Heartbeat:Connect(function()
            if not SilentAimEnabled then
                if SilentAimLoop then
                    SilentAimLoop:Disconnect()
                    SilentAimLoop = nil
                end
                return
            end
            
            if fovCircle then
                fovCircle.Visible = true
            end
            
            if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local closestPlayer = findClosestPlayerInFOV(180, true)
                    if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
                    end
                end
            end
        end)
    end

    -- Обработчики кнопок GUI
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        GUIEnabled = false
        if fovCircle then
            fovCircle:Remove()
        end
        if SilentAimLoop then
            SilentAimLoop:Disconnect()
        end
        if AimAssistLoop then
            AimAssistLoop:Disconnect()
        end
        if ESPLoop then
            ESPLoop:Disconnect()
        end
        if bindConnection then
            bindConnection:Disconnect()
        end
        disableChams()
        disableESP()
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        ButtonsContainer.Visible = not ButtonsContainer.Visible
        if ButtonsContainer.Visible then
            MainFrame.Size = UDim2.new(0, 320, 0, 500)
        else
            MainFrame.Size = UDim2.new(0, 320, 0, 35)
        end
    end)

    BHopToggle.MouseButton1Click:Connect(function()
        BHopEnabled = not BHopEnabled
        toggleButton(BHopToggle, BHopEnabled)
    end)

    SitWalkToggle.MouseButton1Click:Connect(function()
        SitWalkEnabled = not SitWalkEnabled
        toggleButton(SitWalkToggle, SitWalkEnabled)
        
        if Player.Character then
            local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.Sit = SitWalkEnabled
            end
        end
    end)

    ChamsToggle.MouseButton1Click:Connect(function()
        ChamsEnabled = not ChamsEnabled
        toggleButton(ChamsToggle, ChamsEnabled)
        
        if ChamsEnabled then
            enableChams()
        else
            disableChams()
        end
    end)

    SilentAimToggle.MouseButton1Click:Connect(function()
        SilentAimEnabled = not SilentAimEnabled
        toggleButton(SilentAimToggle, SilentAimEnabled)
        
        if SilentAimEnabled then
            startSilentAim()
        else
            if SilentAimLoop then
                SilentAimLoop:Disconnect()
                SilentAimLoop = nil
            end
        end
        
        if fovCircle then
            fovCircle.Visible = AimAssistEnabled or SilentAimEnabled
        end
    end)

    ESPToggle.MouseButton1Click:Connect(function()
        ESPEnabled = not ESPEnabled
        toggleButton(ESPToggle, ESPEnabled)
        
        if ESPEnabled then
            enableESP()
        else
            disableESP()
        end
    end)

    StrafeToggle.MouseButton1Click:Connect(function()
        StrafeEnabled = not StrafeEnabled
        toggleButton(StrafeToggle, StrafeEnabled)
    end)

    ShadersToggle.MouseButton1Click:Connect(function()
        ShadersEnabled = not ShadersEnabled
        toggleButton(ShadersToggle, ShadersEnabled)
    end)

    AimAssistToggle.MouseButton1Click:Connect(function()
        AimAssistEnabled = not AimAssistEnabled
        toggleButton(AimAssistToggle, AimAssistEnabled)
        
        if AimAssistEnabled then
            startAimAssist()
        else
            if AimAssistLoop then
                AimAssistLoop:Disconnect()
                AimAssistLoop = nil
            end
        end
        
        if fovCircle then
            fovCircle.Visible = AimAssistEnabled or SilentAimEnabled
        else
            createFOVCircle()
        end
    end)

    WalkSpeedToggle.MouseButton1Click:Connect(function()
        WalkSpeedEnabled = not WalkSpeedEnabled
        toggleButton(WalkSpeedToggle, WalkSpeedEnabled)
        
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            local humanoid = Player.Character.Humanoid
            
            if WalkSpeedEnabled then
                originalWalkSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = 50
            else
                humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end)

    FreezeToggle.MouseButton1Click:Connect(function()
        freezeEnabled = not freezeEnabled
        toggleButton(FreezeToggle, freezeEnabled)
        toggleFreeze(freezeEnabled)
    end)

    BindFreezeToggle.MouseButton1Click:Connect(function()
        bindFreezeEnabled = not bindFreezeEnabled
        
        if bindFreezeEnabled then
            -- Запрос клавиши для бинда
            BindFreezeToggle.Text = "PRESS A KEY..."
            BindFreezeToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
            
            -- Ждем нажатия клавиши
            local keyConnection
            keyConnection = UIS.InputBegan:Connect(function(input, gameProcessedEvent)
                if gameProcessedEvent then return end
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    currentBindKey = input.KeyCode
                    BindFreezeToggle.Text = "BIND: " .. tostring(currentBindKey):gsub("Enum.KeyCode.", "")
                    BindFreezeToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    
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
            BindFreezeToggle.Text = "Bind Freeze: OFF"
            BindFreezeToggle.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
            
            if bindConnection then
                bindConnection:Disconnect()
                bindConnection = nil
            end
            currentBindKey = nil
            
            print("Bind freeze disabled")
        end
    end)

    -- Улучшенный баннихоп с walkspeed 50
    RunService.Heartbeat:Connect(function()
        local Char = Player.Character
        if not Char or not Char:FindFirstChild("Humanoid") then return end
        
        local Humanoid = Char.Humanoid
        
        local currentlyOnGround = Humanoid.FloorMaterial ~= Enum.Material.Air
        
        if currentlyOnGround and not isOnGround then
            isOnGround = true
            groundContactStartTime = tick()
        elseif not currentlyOnGround and isOnGround then
            isOnGround = false
            groundContactStartTime = 0
        end
        
        if BHopEnabled and UIS:IsKeyDown(Enum.KeyCode.Space) then
            if currentlyOnGround then
                local currentTime = tick()
                if currentTime - lastJumpTime > 0.1 then
                    lastJumpTime = currentTime
                    
                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    
                    Humanoid.WalkSpeed = 50
                end
            end
        end
        
        -- Обновляем только если WalkSpeed включен
        if WalkSpeedEnabled and Humanoid.WalkSpeed ~= 50 then
            Humanoid.WalkSpeed = 50
        end
    end)

    -- Air Strafe функция
    RunService.Heartbeat:Connect(function()
        if StrafeEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local Char = Player.Character
            local RootPart = Char.HumanoidRootPart
            local Humanoid = Char.Humanoid
            
            if Humanoid.FloorMaterial == Enum.Material.Air then
                local moveDirection = Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + RootPart.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - RootPart.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - RootPart.CFrame.RightVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + RootPart.CFrame.RightVector
                end
                
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit
                    RootPart.Velocity = RootPart.Velocity + moveDirection * 30
                end
            end
        end
    end)

    -- Делаем окно перетаскиваемым через TitleBar
    local dragging = false
    local dragInput, dragStart, startPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Принудительно активируем видимость
    ScreenGui.Enabled = true
    MainFrame.Visible = true
    ButtonsContainer.Visible = true

    -- Создаем FOV круг при запуске
    createFOVCircle()

    -- Обновляем текст кнопок при запуске
    updateButtonText(BHopToggle, BHopEnabled)
    updateButtonText(SitWalkToggle, SitWalkEnabled)
    updateButtonText(ChamsToggle, ChamsEnabled)
    updateButtonText(SilentAimToggle, SilentAimEnabled)
    updateButtonText(ESPToggle, ESPEnabled)
    updateButtonText(StrafeToggle, StrafeEnabled)
    updateButtonText(ShadersToggle, ShadersEnabled)
    updateButtonText(AimAssistToggle, AimAssistEnabled)
    updateButtonText(WalkSpeedToggle, WalkSpeedEnabled)
    updateButtonText(FreezeToggle, FreezeEnabled)
    updateButtonText(BindFreezeToggle, BindFreezeEnabled)

    -- Уведомление в чат
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "Moon Blossom v2.1 loaded!",
        Color = Color3.fromRGB(180, 100, 255),
        Font = Enum.Font.GothamBold,
        FontSize = Enum.FontSize.Size18
    })

    -- Автоматическое восстановление позиции при respawn
    Players.LocalPlayer.CharacterAdded:Connect(function()
        if not GUIEnabled then return end
        
        wait(1)
        
        if not CoreGui:FindFirstChild("MoonBlossomGUI") then
            local newScreenGui = ScreenGui:Clone()
            newScreenGui.Parent = CoreGui
            newScreenGui.Enabled = true
            
            createFOVCircle()
            
            -- Восстанавливаем функции если они были включены
            if ChamsEnabled then
                enableChams()
            end
            if ESPEnabled then
                enableESP()
            end
            if SilentAimEnabled then
                startSilentAim()
            end
            if AimAssistEnabled then
                startAimAssist()
            end
            if freezeEnabled then
                toggleFreeze(freezeEnabled)
            end
            if bindFreezeEnabled and currentBindKey then
                bindConnection = setupBindFreeze()
            end
        end
    end)

    -- Гарантируем отображение GUI
    wait(1)
    ScreenGui.Enabled = true
    for _, child in ipairs(ScreenGui:GetDescendants()) do
        if child:IsA("GuiObject") then
            child.Visible = true
        end
    end
end)

if not success then
    warn("[MoonBlossom] Initialization failed: ", err)
end
