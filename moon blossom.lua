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

    -- Основной фрейм (увеличенный размер, серый тон)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 350, 0, 500)
    MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Selectable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = true

    -- Добавляем округление углов
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = MainFrame

    -- TitleBar для перетаскивания (серый тон)
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0.05, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Moon Blossom v4.1"
    Title.TextColor3 = Color3.fromRGB(220, 180, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.Parent = TitleBar

    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 16
    CloseButton.Parent = TitleBar

    -- Кнопка сворачивания
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 16
    MinimizeButton.Parent = TitleBar

    -- Контейнер для кнопок
    local ButtonsContainer = Instance.new("Frame")
    ButtonsContainer.Name = "ButtonsContainer"
    ButtonsContainer.Size = UDim2.new(1, 0, 1, -30)
    ButtonsContainer.Position = UDim2.new(0, 0, 0, 30)
    ButtonsContainer.BackgroundTransparency = 1
    ButtonsContainer.Parent = MainFrame

    -- Кнопки переключателей (серый тон)
    local BHopToggle = Instance.new("TextButton")
    BHopToggle.Name = "BHopToggle"
    BHopToggle.Size = UDim2.new(0, 330, 0, 35)
    BHopToggle.Position = UDim2.new(0.035, 0, 0.03, 0)
    BHopToggle.Text = "Bunny Hop: OFF"
    BHopToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    BHopToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    BHopToggle.Font = Enum.Font.Gotham
    BHopToggle.TextSize = 14
    BHopToggle.Parent = ButtonsContainer

    local SpinbotToggle = Instance.new("TextButton")
    SpinbotToggle.Name = "SpinbotToggle"
    SpinbotToggle.Size = UDim2.new(0, 330, 0, 35)
    SpinbotToggle.Position = UDim2.new(0.035, 0, 0.10, 0)
    SpinbotToggle.Text = "Body Aligner: OFF"
    SpinbotToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    SpinbotToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    SpinbotToggle.Font = Enum.Font.Gotham
    SpinbotToggle.TextSize = 14
    SpinbotToggle.Parent = ButtonsContainer

    local ChamsToggle = Instance.new("TextButton")
    ChamsToggle.Name = "ChamsToggle"
    ChamsToggle.Size = UDim2.new(0, 330, 0, 35)
    ChamsToggle.Position = UDim2.new(0.035, 0, 0.17, 0)
    ChamsToggle.Text = "Player Chams: OFF"
    ChamsToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    ChamsToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    ChamsToggle.Font = Enum.Font.Gotham
    ChamsToggle.TextSize = 14
    ChamsToggle.Parent = ButtonsContainer

    local SilentAimToggle = Instance.new("TextButton")
    SilentAimToggle.Name = "SilentAimToggle"
    SilentAimToggle.Size = UDim2.new(0, 330, 0, 35)
    SilentAimToggle.Position = UDim2.new(0.035, 0, 0.24, 0)
    SilentAimToggle.Text = "Silent Aim: OFF"
    SilentAimToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    SilentAimToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    SilentAimToggle.Font = Enum.Font.Gotham
    SilentAimToggle.TextSize = 14
    SilentAimToggle.Parent = ButtonsContainer

    local ESPToggle = Instance.new("TextButton")
    ESPToggle.Name = "ESPToggle"
    ESPToggle.Size = UDim2.new(0, 330, 0, 35)
    ESPToggle.Position = UDim2.new(0.035, 0, 0.31, 0)
    ESPToggle.Text = "ESP: OFF"
    ESPToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    ESPToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    ESPToggle.Font = Enum.Font.Gotham
    ESPToggle.TextSize = 14
    ESPToggle.Parent = ButtonsContainer

    local StrafeToggle = Instance.new("TextButton")
    StrafeToggle.Name = "StrafeToggle"
    StrafeToggle.Size = UDim2.new(0, 330, 0, 35)
    StrafeToggle.Position = UDim2.new(0.035, 0, 0.38, 0)
    StrafeToggle.Text = "Air Strafe: OFF"
    StrafeToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    StrafeToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    StrafeToggle.Font = Enum.Font.Gotham
    StrafeToggle.TextSize = 14
    StrafeToggle.Parent = ButtonsContainer

    local ShadersToggle = Instance.new("TextButton")
    ShadersToggle.Name = "ShadersToggle"
    ShadersToggle.Size = UDim2.new(0, 330, 0, 35)
    ShadersToggle.Position = UDim2.new(0.035, 0, 0.45, 0)
    ShadersToggle.Text = "Shaders: OFF"
    ShadersToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    ShadersToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    ShadersToggle.Font = Enum.Font.Gotham
    ShadersToggle.TextSize = 14
    ShadersToggle.Parent = ButtonsContainer

    local AimAssistToggle = Instance.new("TextButton")
    AimAssistToggle.Name = "AimAssistToggle"
    AimAssistToggle.Size = UDim2.new(0, 330, 0, 35)
    AimAssistToggle.Position = UDim2.new(0.035, 0, 0.52, 0)
    AimAssistToggle.Text = "Aim Assist: OFF (LMB)"
    AimAssistToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    AimAssistToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    AimAssistToggle.Font = Enum.Font.Gotham
    AimAssistToggle.TextSize = 14
    AimAssistToggle.Parent = ButtonsContainer

    local WalkSpeedToggle = Instance.new("TextButton")
    WalkSpeedToggle.Name = "WalkSpeedToggle"
    WalkSpeedToggle.Size = UDim2.new(0, 330, 0, 35)
    WalkSpeedToggle.Position = UDim2.new(0.035, 0, 0.59, 0)
    WalkSpeedToggle.Text = "WalkSpeed: OFF"
    WalkSpeedToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    WalkSpeedToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    WalkSpeedToggle.Font = Enum.Font.Gotham
    WalkSpeedToggle.TextSize = 14
    WalkSpeedToggle.Parent = ButtonsContainer

    local TriggerbotToggle = Instance.new("TextButton")
    TriggerbotToggle.Name = "TriggerbotToggle"
    TriggerbotToggle.Size = UDim2.new(0, 330, 0, 35)
    TriggerbotToggle.Position = UDim2.new(0.035, 0, 0.66, 0)
    TriggerbotToggle.Text = "Triggerbot: OFF (LMB)"
    TriggerbotToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    TriggerbotToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    TriggerbotToggle.Font = Enum.Font.Gotham
    TriggerbotToggle.TextSize = 14
    TriggerbotToggle.Parent = ButtonsContainer

    local TeleportToggle = Instance.new("TextButton")
    TeleportToggle.Name = "TeleportToggle"
    TeleportToggle.Size = UDim2.new(0, 330, 0, 35)
    TeleportToggle.Position = UDim2.new(0.035, 0, 0.73, 0)
    TeleportToggle.Text = "CTRL+Click TP: OFF"
    TeleportToggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    TeleportToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
    TeleportToggle.Font = Enum.Font.Gotham
    TeleportToggle.TextSize = 14
    TeleportToggle.Parent = ButtonsContainer

    -- Статус
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    StatusLabel.Position = UDim2.new(0, 0, 0.95, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Status: Active"
    StatusLabel.TextColor3 = Color3.fromRGB(180, 150, 200)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 12
    StatusLabel.Parent = ButtonsContainer

    -- Стилизация кнопок
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = BHopToggle
    buttonCorner:Clone().Parent = SpinbotToggle
    buttonCorner:Clone().Parent = ChamsToggle
    buttonCorner:Clone().Parent = SilentAimToggle
    buttonCorner:Clone().Parent = ESPToggle
    buttonCorner:Clone().Parent = StrafeToggle
    buttonCorner:Clone().Parent = ShadersToggle
    buttonCorner:Clone().Parent = AimAssistToggle
    buttonCorner:Clone().Parent = WalkSpeedToggle
    buttonCorner:Clone().Parent = TriggerbotToggle
    buttonCorner:Clone().Parent = TeleportToggle

    -- Принудительно показываем GUI
    ScreenGui.Enabled = true
    MainFrame.Visible = true

    -- Логика
    local BHopEnabled = false
    local SpinbotEnabled = false
    local ChamsEnabled = false
    local SilentAimEnabled = false
    local ESPEnabled = false
    local StrafeEnabled = false
    local ShadersEnabled = false
    local AimAssistEnabled = false
    local WalkSpeedEnabled = false
    local TriggerbotEnabled = false
    local TeleportEnabled = false
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

    -- Переменные для спинбота
    local spinRotation = 0

    -- Переменные для Aim Assist и Silent Aim
    local aimAssistTarget = nil
    local aimAssistFOV = 800 -- Увеличена дистанция до 800
    local triggerbotFOV = 10
    local fovCircle = nil

    -- Переменная для хранения исходной скорости
    local originalWalkSpeed = 16

    -- Максимальная дистанция для Aim Assist, Silent Aim и Triggerbot
    local maxDistance = 800 -- Увеличена до 800

    -- Функция для создания визуального FOV
    local function createFOVCircle()
        if fovCircle then
            fovCircle:Remove()
        end
        
        fovCircle = Drawing.new("Circle")
        fovCircle.Visible = AimAssistEnabled or SilentAimEnabled or TriggerbotEnabled
        fovCircle.Radius = math.max(aimAssistFOV, triggerbotFOV)
        fovCircle.Color = Color3.fromRGB(255, 100, 255)
        fovCircle.Thickness = 2
        fovCircle.Filled = false
        fovCircle.Transparency = 0.7
        fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 50)
        
        return fovCircle
    end

    -- Функция проверки стены с помощью Raycast
    local function isTargetVisible(targetPos)
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then 
            return false 
        end
        local origin = Camera.CFrame.Position
        local direction = (targetPos - origin).Unit * maxDistance
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {Player.Character}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        local result = Workspace:Raycast(origin, direction, raycastParams)
        if result then
            local hitPart = result.Instance
            if hitPart and hitPart:IsDescendantOf(Workspace) and not hitPart:IsDescendantOf(Player.Character) then
                local hitCharacter = hitPart:FindFirstAncestorOfClass("Model")
                if hitCharacter and hitCharacter:IsA("Model") and Players:GetPlayerFromCharacter(hitCharacter) then
                    return true
                end
                return false
            end
        end
        return true
    end

    -- Функция для обновления текста кнопок
    local function updateButtonText(button, enabled)
        if button.Name == "BHopToggle" then
            button.Text = "Bunny Hop: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "SpinbotToggle" then
            button.Text = "Body Aligner: " .. (enabled and "ON" or "OFF")
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
            button.Text = "Aim Assist: " .. (enabled and "ON" or "OFF") .. " (LMB)"
        elseif button.Name == "WalkSpeedToggle" then
            button.Text = "WalkSpeed: " .. (enabled and "ON" or "OFF")
        elseif button.Name == "TriggerbotToggle" then
            button.Text = "Triggerbot: " .. (enabled and "ON" or "OFF") .. " (LMB)"
        elseif button.Name == "TeleportToggle" then
            button.Text = "CTRL+Click TP: " .. (enabled and "ON" or "OFF")
        end
    end

    -- Анимации переключения
    local function toggleButton(button, state)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local goal = {}
        
        if state then
            goal.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        else
            goal.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
        end
        
        TweenService:Create(button, tweenInfo, goal):Play()
        updateButtonText(button, state)
    end

    -- Функция для выравнивания тела на уровень ног
    local function alignBodyToFeet()
        if not Player.Character then return end
        
        local humanoid = Player.Character:FindFirstChild("Humanoid")
        local rootPart = Player.Character:FindFirstChild("HumanoidRootPart")
        local leftLeg = Player.Character:FindFirstChild("LeftLowerLeg") or Player.Character:FindFirstChild("LeftFoot")
        local rightLeg = Player.Character:FindFirstChild("RightLowerLeg") or Player.Character:FindFirstChild("RightFoot")
        
        if not humanoid or not rootPart then return end
        
        -- Находим среднюю точку между ногами
        local legPosition = rootPart.Position
        if leftLeg and rightLeg then
            legPosition = (leftLeg.Position + rightLeg.Position) / 2
        elseif leftLeg then
            legPosition = leftLeg.Position
        elseif rightLeg then
            legPosition = rightLeg.Position
        end
        
        -- Перемещаем части тела на уровень ног
        for _, part in pairs(Player.Character:GetChildren()) do
            if part:IsA("BasePart") and part ~= rootPart then
                if part.Name:find("Head") or part.Name:find("Torso") or part.Name:find("Hand") or part.Name:find("Arm") then
                    local offset = part.Position - rootPart.Position
                    part.CFrame = CFrame.new(legPosition + offset)
                end
            end
        end
    end

    -- Обработчики кнопок GUI
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        GUIEnabled = false
        if fovCircle then
            fovCircle:Remove()
        end
        Camera.CameraType = Enum.CameraType.Custom
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        ButtonsContainer.Visible = not ButtonsContainer.Visible
        if ButtonsContainer.Visible then
            MainFrame.Size = UDim2.new(0, 350, 0, 500)
        else
            MainFrame.Size = UDim2.new(0, 350, 0, 30)
        end
    end)

    BHopToggle.MouseButton1Click:Connect(function()
        BHopEnabled = not BHopEnabled
        toggleButton(BHopToggle, BHopEnabled)
    end)

    SpinbotToggle.MouseButton1Click:Connect(function()
        SpinbotEnabled = not SpinbotEnabled
        toggleButton(SpinbotToggle, SpinbotEnabled)
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
        
        if fovCircle then
            fovCircle.Visible = AimAssistEnabled or SilentAimEnabled or TriggerbotEnabled
        end
        if not SilentAimEnabled then
            Camera.CameraType = Enum.CameraType.Custom
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
        
        if ShadersEnabled then
            enableShaders()
        else
            disableShaders()
        end
    end)

    AimAssistToggle.MouseButton1Click:Connect(function()
        AimAssistEnabled = not AimAssistEnabled
        toggleButton(AimAssistToggle, AimAssistEnabled)
        
        if not AimAssistEnabled then
            aimAssistTarget = nil
            Camera.CameraType = Enum.CameraType.Custom
        end
        
        if fovCircle then
            fovCircle.Visible = AimAssistEnabled or SilentAimEnabled or TriggerbotEnabled
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

    TriggerbotToggle.MouseButton1Click:Connect(function()
        TriggerbotEnabled = not TriggerbotEnabled
        toggleButton(TriggerbotToggle, TriggerbotEnabled)
        
        if fovCircle then
            fovCircle.Visible = AimAssistEnabled or SilentAimEnabled or TriggerbotEnabled
        else
            createFOVCircle()
        end
    end)

    TeleportToggle.MouseButton1Click:Connect(function()
        TeleportEnabled = not TeleportEnabled
        toggleButton(TeleportToggle, TeleportEnabled)
    end)

    -- CTRL + Click телепортация
    Mouse.Button1Down:Connect(function()
        if TeleportEnabled and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            local target = Mouse.Hit.Position
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(target)
            end
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
        
        if WalkSpeedEnabled and Humanoid.WalkSpeed ~= 50 then
            Humanoid.WalkSpeed = 50
        end

        -- Body Aligner (вместо Spinbot)
        if SpinbotEnabled then
            alignBodyToFeet()
        end
    end)

    -- Функция для поиска ближайшего игрока в FOV с проверкой дистанции
    local function findClosestPlayerInFOV(fov)
        local closestPlayer = nil
        local closestDistance = math.huge
        local mousePos = Vector2.new(Mouse.X, Mouse.Y)
        
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= Player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local head = otherPlayer.Character.Head
                local humanoid = otherPlayer.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local distanceToPlayer = (Player.Character.HumanoidRootPart.Position - head.Position).Magnitude
                    
                    if distanceToPlayer <= maxDistance then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        
                        if onScreen then
                            local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            
                            if distance <= fov and distance < closestDistance then
                                if isTargetVisible(head.Position) then
                                    closestDistance = distance
                                    closestPlayer = otherPlayer
                                end
                            end
                        end
                    end
                end
            end
        end
        
        return closestPlayer
    end

    -- Aim Assist с лёгкой плавностью (FOV 800, работает только при LMB)
    local function handleAimAssist()
        if AimAssistEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local closestPlayer = findClosestPlayerInFOV(aimAssistFOV)
                
                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                    local targetHead = closestPlayer.Character.Head
                    local cameraPosition = Camera.CFrame.Position
                    local targetPosition = targetHead.Position
                    
                    if isTargetVisible(targetPosition) then
                        local direction = (targetPosition - cameraPosition).Unit
                        local currentLook = Camera.CFrame.LookVector
                        local smoothFactor = 0.85
                        local newLook = currentLook:Lerp(direction, smoothFactor)
                        Camera.CFrame = CFrame.new(cameraPosition, cameraPosition + newLook)
                    end
                end
            end
        end
    end

    -- Triggerbot работает только при LMB
    local function handleTriggerbot()
        if TriggerbotEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                if not Player.Character:FindFirstChildOfClass("Tool") then
                    return
                end
                local closestPlayer = findClosestPlayerInFOV(triggerbotFOV)
                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                    local targetHead = closestPlayer.Character.Head
                    local humanoid = closestPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(targetHead.Position)
                        
                        if onScreen then
                            local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                            local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            
                            if distance <= 10 and isTargetVisible(targetHead.Position) then
                                pcall(function()
                                    if _G.mouse1click then
                                        _G.mouse1click()
                                    else
                                        mouse1press()
                                        wait(0.05)
                                        mouse1release()
                                    end
                                end)
                                wait(0.1)
                            end
                        end
                    end
                end
            end
        end
    end

    -- Обновление FOV круга, Aim Assist и Triggerbot
    RunService.RenderStepped:Connect(function()
        if fovCircle then
            fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 50)
            fovCircle.Radius = math.max(aimAssistFOV, triggerbotFOV)
            fovCircle.Visible = AimAssistEnabled or SilentAimEnabled or TriggerbotEnabled
        end
        
        if not AimAssistEnabled and not SilentAimEnabled then
            Camera.CameraType = Enum.CameraType.Custom
        end
        
        handleAimAssist()
        handleTriggerbot()
    end)

    -- Улучшенный Silent Aim с FOV 800
    local function findClosestPlayerToCursor()
        local closestPlayer = nil
        local closestDistance = math.huge
        local mousePos = Vector2.new(Mouse.X, Mouse.Y)
        
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= Player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local head = otherPlayer.Character.Head
                local humanoid = otherPlayer.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local distanceToPlayer = (Player.Character.HumanoidRootPart.Position - head.Position).Magnitude
                    
                    if distanceToPlayer <= maxDistance then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        
                        if onScreen then
                            local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            
                            if distance <= aimAssistFOV and distance < closestDistance then
                                if isTargetVisible(head.Position) then
                                    closestDistance = distance
                                    closestPlayer = otherPlayer
                                end
                            end
                        end
                    end
                end
            end
        end
        
        return closestPlayer
    end

    -- Обработчик Silent Aim (только при LMB)
    Mouse.Button1Down:Connect(function()
        if SilentAimEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local closestPlayer = findClosestPlayerToCursor()
                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                    local targetHead = closestPlayer.Character.Head
                    if isTargetVisible(targetHead.Position) then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
                    end
                end
            end
        end
    end)

    -- [Остальные функции Chams, ESP, Shaders остаются без изменений]
    -- ... (код функций enableChams, disableChams, createChams, enableESP, disableESP, createESP, enableShaders, disableShaders)

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
    updateButtonText(SpinbotToggle, SpinbotEnabled)
    updateButtonText(ChamsToggle, ChamsEnabled)
    updateButtonText(SilentAimToggle, SilentAimEnabled)
    updateButtonText(ESPToggle, ESPEnabled)
    updateButtonText(StrafeToggle, StrafeEnabled)
    updateButtonText(ShadersToggle, ShadersEnabled)
    updateButtonText(AimAssistToggle, AimAssistEnabled)
    updateButtonText(WalkSpeedToggle, WalkSpeedEnabled)
    updateButtonText(TriggerbotToggle, TriggerbotEnabled)
    updateButtonText(TeleportToggle, TeleportEnabled)

    -- Уведомление в чат
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "Moon Blossom v4.1 loaded! Features: 800 distance, LMB-only aim, CTRL+Click TP, Body Aligner",
        Color = Color3.fromRGB(180, 100, 255),
        Font = Enum.Font.GothamBold,
        FontSize = Enum.FontSize.Size18
    })

    -- Автоматическое восстановление при respawn
    Players.LocalPlayer.CharacterAdded:Connect(function()
        if not GUIEnabled then return end
        
        wait(1)
        
        if not CoreGui:FindFirstChild("MoonBlossomGUI") then
            local newScreenGui = ScreenGui:Clone()
            newScreenGui.Parent = CoreGui
            newScreenGui.Enabled = true
            
            createFOVCircle()
        end
        Camera.CameraType = Enum.CameraType.Custom
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
