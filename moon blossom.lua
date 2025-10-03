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

    -- Основной фрейм (градиентный фон)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 350, 0, 500)
    MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Selectable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = false  -- Начально скрыт для анимации

    -- Градиент для MainFrame
    local MainGradient = Instance.new("UIGradient")
    MainGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 30, 90)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 10, 50))
    }
    MainGradient.Rotation = 45
    MainGradient.Parent = MainFrame

    -- UIStroke для свечения
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(180, 100, 255)
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.5
    MainStroke.Parent = MainFrame

    -- Добавляем округление углов
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame

    -- Анимация входа
    local function animateEntrance()
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.7, 0, 0.5, 0)
        MainFrame.Visible = true
        MainFrame.BackgroundTransparency = 1
        MainGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)}
        MainStroke.Transparency = 1
        
        local tweenIn = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 350, 0, 500),
            Position = UDim2.new(0.7, 0, 0.2, 0),
            BackgroundTransparency = 0
        })
        local tweenGradient = TweenService:Create(MainGradient, TweenInfo.new(0.5), {Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0)}})
        local tweenStroke = TweenService:Create(MainStroke, TweenInfo.new(0.5), {Transparency = 0.5})
        
        tweenIn:Play()
        tweenGradient:Play()
        tweenStroke:Play()
    end

    -- TitleBar для перетаскивания (градиент)
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(70, 40, 100)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 50, 120)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 30, 90))
    }
    TitleGradient.Rotation = 90
    TitleGradient.Parent = TitleBar

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar

    local TitleStroke = Instance.new("UIStroke")
    TitleStroke.Color = Color3.fromRGB(220, 180, 255)
    TitleStroke.Thickness = 1
    TitleStroke.Transparency = 0.3
    TitleStroke.Parent = TitleBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0.05, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Moon Blossom v4.0 Premium"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15
    Title.Parent = TitleBar

    -- Анимация титла (пульсация)
    local titlePulse = TweenService:Create(Title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        TextTransparency = 0.2
    })
    titlePulse:Play()

    -- Кнопка закрытия с анимацией
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 35, 0, 35)
    CloseButton.Position = UDim2.new(0.9, -5, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TitleBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton

    local CloseStroke = Instance.new("UIStroke")
    CloseStroke.Color = Color3.fromRGB(255, 255, 255)
    CloseStroke.Thickness = 1
    CloseStroke.Parent = CloseButton

    -- Hover эффект для CloseButton
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 40, 0, 40)}):Play()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 35, 0, 35)}):Play()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
    end)

    -- Кнопка сворачивания с анимацией
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
    MinimizeButton.Position = UDim2.new(0.8, -5, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 18
    MinimizeButton.Parent = TitleBar

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeButton

    local MinStroke = Instance.new("UIStroke")
    MinStroke.Color = Color3.fromRGB(255, 255, 255)
    MinStroke.Thickness = 1
    MinStroke.Parent = MinimizeButton

    -- Hover эффект для MinimizeButton
    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 40, 0, 40)}):Play()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 35, 0, 35)}):Play()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
    end)

    -- Контейнер для кнопок
    local ButtonsContainer = Instance.new("Frame")
    ButtonsContainer.Name = "ButtonsContainer"
    ButtonsContainer.Size = UDim2.new(1, 0, 1, -35)
    ButtonsContainer.Position = UDim2.new(0, 0, 0, 35)
    ButtonsContainer.BackgroundTransparency = 1
    ButtonsContainer.Parent = MainFrame

    -- Статус с rainbow анимацией
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, 25)
    StatusLabel.Position = UDim2.new(0, 0, 0.95, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Status: Active & Pulsing ✨"
    StatusLabel.TextColor3 = Color3.fromRGB(180, 150, 200)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 13
    StatusLabel.Parent = ButtonsContainer

    -- Rainbow анимация для статуса
    local statusHue = 0
    RunService.Heartbeat:Connect(function()
        statusHue = statusHue + 0.01
        if statusHue > 1 then statusHue = 0 end
        local rainbowColor = Color3.fromHSV(statusHue, 1, 1)
        StatusLabel.TextColor3 = rainbowColor
    end)

    -- Функция создания анимированной кнопки
    local function createAnimatedButton(name, text, posY, parent)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Size = UDim2.new(0, 330, 0, 40)
        button.Position = UDim2.new(0.01, 0, posY, 0)
        button.Text = text
        button.BackgroundColor3 = Color3.fromRGB(50, 30, 70)
        button.TextColor3 = Color3.fromRGB(220, 180, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.Parent = parent

        -- Градиент для кнопки
        local btnGradient = Instance.new("UIGradient")
        btnGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 50, 90)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 20, 60))
        }
        btnGradient.Rotation = 90
        btnGradient.Parent = button

        -- Округление и stroke
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = button

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.fromRGB(180, 100, 255)
        btnStroke.Thickness = 1
        btnStroke.Transparency = 0.7
        btnStroke.Parent = button

        -- Hover анимация
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 340, 0, 42),
                BackgroundColor3 = Color3.fromRGB(70, 50, 90)
            }):Play()
            TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 330, 0, 40),
                BackgroundColor3 = Color3.fromRGB(50, 30, 70)
            }):Play()
            TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
        end)

        return button
    end

    -- Создаём кнопки
    local BHopToggle = createAnimatedButton("BHopToggle", "Bunny Hop: OFF", 0.02, ButtonsContainer)
    local SpinbotToggle = createAnimatedButton("SpinbotToggle", "Spinbot: OFF", 0.09, ButtonsContainer)
    local ChamsToggle = createAnimatedButton("ChamsToggle", "Player Chams: OFF", 0.16, ButtonsContainer)
    local SilentAimToggle = createAnimatedButton("SilentAimToggle", "Silent Aim: OFF", 0.23, ButtonsContainer)
    local ESPToggle = createAnimatedButton("ESPToggle", "ESP: OFF", 0.30, ButtonsContainer)
    local StrafeToggle = createAnimatedButton("StrafeToggle", "Air Strafe: OFF", 0.37, ButtonsContainer)
    local ShadersToggle = createAnimatedButton("ShadersToggle", "Shaders: OFF", 0.44, ButtonsContainer)
    local AimAssistToggle = createAnimatedButton("AimAssistToggle", "Aim Assist: OFF (Toggle: K)", 0.51, ButtonsContainer)
    local WalkSpeedToggle = createAnimatedButton("WalkSpeedToggle", "WalkSpeed: OFF", 0.58, ButtonsContainer)
    local TriggerbotToggle = createAnimatedButton("TriggerbotToggle", "Triggerbot: OFF (Toggle: L)", 0.65, ButtonsContainer)

    -- Анимация появления кнопок (поочерёдно)
    local function animateButtons(delay)
        for i, button in ipairs({BHopToggle, SpinbotToggle, ChamsToggle, SilentAimToggle, ESPToggle, StrafeToggle, ShadersToggle, AimAssistToggle, WalkSpeedToggle, TriggerbotToggle}) do
            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.01, 0, button.Position.Y.Scale, 0),
                BackgroundTransparency = 0
            }):Play()
            wait(delay)
        end
    end

    -- Логика (переменные)
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
    local originalBodyScales = {}

    -- Переменные для Aim Assist и Silent Aim
    local aimAssistTarget = nil
    local aimAssistFOV = 180
    local triggerbotFOV = 10
    local fovCircle = nil

    -- Переменная для хранения исходной скорости
    local originalWalkSpeed = 16

    -- Максимальная дистанция
    local maxDistance = 400

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

    -- Функция для стрельбы (фикс Triggerbot)
    local function fireWeapon()
        local char = Player.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then
            print("[MoonBlossom] Triggerbot: No tool equipped")
            return
        end
        local remote = tool:FindFirstChild("RemoteEvent") or tool:FindFirstChildOfClass("RemoteFunction") or tool:FindFirstChild("Fire")
        if remote and remote:IsA("RemoteEvent") then
            pcall(function()
                remote:FireServer()
                print("[MoonBlossom] Triggerbot: Fired remote event for " .. tool.Name)
            end)
        elseif remote and remote:IsA("RemoteFunction") then
            pcall(function()
                remote:InvokeServer()
                print("[MoonBlossom] Triggerbot: Invoked remote function for " .. tool.Name)
            end)
        else
            if _G.mouse1click then
                _G.mouse1click()
                print("[MoonBlossom] Triggerbot: Used _G.mouse1click fallback")
            else
                print("[MoonBlossom] Triggerbot: No remote or mouse1click - can't fire")
            end
        end
    end

    -- Функция для обновления текста кнопок
    local function updateButtonText(button, enabled)
        local baseText = button.Text:match("^(.*):") or button.Text
        button.Text = baseText .. ": " .. (enabled and "ON" or "OFF")
    end

    -- Анимации переключения
    local function toggleButton(button, state)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local goal = {}
        
        if state then
            goal.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
        else
            goal.BackgroundColor3 = Color3.fromRGB(50, 30, 70)
        end
        
        TweenService:Create(button, tweenInfo, goal):Play()
        updateButtonText(button, state)
    end

    -- Обработчики кнопок GUI
    CloseButton.MouseButton1Click:Connect(function()
        local tweenOut = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.7, 0, 0.5, 0),
            BackgroundTransparency = 1
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            ScreenGui:Destroy()
            GUIEnabled = false
            if fovCircle then
                fovCircle:Remove()
            end
            Camera.CameraType = Enum.CameraType.Custom
            -- Восстанавливаем масштаб тела при закрытии
            if SpinbotEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                local humanoid = Player.Character.Humanoid
                for _, property in pairs({"BodyWidthScale", "BodyDepthScale", "HeadScale", "BodyHeightScale"}) do
                    if originalBodyScales[property] then
                        humanoid[property].Value = originalBodyScales[property]
                    end
                end
            end
        end)
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        ButtonsContainer.Visible = not ButtonsContainer.Visible
        if ButtonsContainer.Visible then
            MainFrame.Size = UDim2.new(0, 350, 0, 500)
        else
            MainFrame.Size = UDim2.new(0, 350, 0, 35)
        end
    end)

    BHopToggle.MouseButton1Click:Connect(function()
        BHopEnabled = not BHopEnabled
        toggleButton(BHopToggle, BHopEnabled)
    end)

    SpinbotToggle.MouseButton1Click:Connect(function()
        SpinbotEnabled = not SpinbotEnabled
        toggleButton(SpinbotToggle, SpinbotEnabled)
        
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            local humanoid = Player.Character.Humanoid
            if SpinbotEnabled then
                originalBodyScales.BodyWidthScale = humanoid.BodyWidthScale.Value
                originalBodyScales.BodyDepthScale = humanoid.BodyDepthScale.Value
                originalBodyScales.HeadScale = humanoid.HeadScale.Value
                originalBodyScales.BodyHeightScale = humanoid.BodyHeightScale.Value
                humanoid.BodyWidthScale.Value = 0.5
                humanoid.BodyDepthScale.Value = 0.5
                humanoid.HeadScale.Value = 0.5
                humanoid.BodyHeightScale.Value = 0.5
                print("[MoonBlossom] Spinbot: Body scale reduced to 0.5")
            else
                humanoid.BodyWidthScale.Value = originalBodyScales.BodyWidthScale or 1
                humanoid.BodyDepthScale.Value = originalBodyScales.BodyDepthScale or 1
                humanoid.HeadScale.Value = originalBodyScales.HeadScale or 1
                humanoid.BodyHeightScale.Value = originalBodyScales.BodyHeightScale or 1
                print("[MoonBlossom] Spinbot: Body scale restored")
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
        -- Toggle only via K
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
        -- Toggle only via L
    end)

    -- Бинд Aim Assist на K, Triggerbot на L
    UIS.InputBegan:Connect(function(input, gameProcessedEvent)
        if input.KeyCode == Enum.KeyCode.K and not gameProcessedEvent then
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
        elseif input.KeyCode == Enum.KeyCode.L and not gameProcessedEvent then
            TriggerbotEnabled = not TriggerbotEnabled
            toggleButton(TriggerbotToggle, TriggerbotEnabled)
            print("[MoonBlossom] Triggerbot toggled: " .. (TriggerbotEnabled and "ON" or "OFF"))
            
            if fovCircle then
                fovCircle.Visible = AimAssistEnabled or SilentAimEnabled or TriggerbotEnabled
            else
                createFOVCircle()
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
    end)

    -- Спинбот с вращением персонажа и уменьшением хитбокса
    RunService.Heartbeat:Connect(function()
        if SpinbotEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = Player.Character.HumanoidRootPart
            spinRotation = spinRotation + 100 * RunService.Heartbeat:Wait()
            if spinRotation > 360 then spinRotation = spinRotation - 360 end
            rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(0, math.rad(spinRotation), 0)
            print("[MoonBlossom] Spinbot: Character rotation updated to " .. math.floor(spinRotation) .. " degrees")
        else
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                local humanoid = Player.Character.Humanoid
                if originalBodyScales.BodyWidthScale then
                    humanoid.BodyWidthScale.Value = originalBodyScales.BodyWidthScale
                    humanoid.BodyDepthScale.Value = originalBodyScales.BodyDepthScale
                    humanoid.HeadScale.Value = originalBodyScales.HeadScale
                    humanoid.BodyHeightScale.Value = originalBodyScales.BodyHeightScale
                    print("[MoonBlossom] Spinbot: Body scale restored")
                end
            end
        end
    end)

    -- Air Strafe
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
                    local currentVelocity = RootPart.Velocity
                    local currentSpeed = Vector3.new(currentVelocity.X, 0, currentVelocity.Z).Magnitude
                    RootPart.Velocity = Vector3.new(moveDirection.X * currentSpeed, currentVelocity.Y, moveDirection.Z * currentSpeed)
                end
            end
        end
    end)

    -- Функция для поиска ближайшего игрока в FOV
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

    -- Aim Assist
    local function handleAimAssist()
        if AimAssistEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
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

    -- FIXED Triggerbot
    local function handleTriggerbot()
        if TriggerbotEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
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
                            fireWeapon()
                            wait(0.1)
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

    -- Silent Aim
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

    Mouse.Button1Down:Connect(function()
        if SilentAimEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local closestPlayer = findClosestPlayerToCursor()
            if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                local targetHead = closestPlayer.Character.Head
                if isTargetVisible(targetHead.Position) then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
                end
            end
        end
    end)

    -- Chams функции
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
                if part:IsA("BasePart") then
                    OriginalMaterials[part] = part.Material
                    OriginalColors[part] = part.Color
                    OriginalTransparencies[part] = part.LocalTransparencyModifier or 0
                    
                    part.Material = Enum.Material.ForceField
                    part.Color = Color3.fromRGB(255, 100, 255)
                    part.LocalTransparencyModifier = 0.2
                    part.CastShadow = false
                    
                    table.insert(parts, part)
                end
            end
            
            ChamsObjects[targetPlayer] = parts
            
            character.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("BasePart") then
                    OriginalMaterials[descendant] = descendant.Material
                    OriginalColors[descendant] = descendant.Color
                    OriginalTransparencies[descendant] = descendant.LocalTransparencyModifier or 0
                    
                    descendant.Material = Enum.Material.ForceField
                    descendant.Color = Color3.fromRGB(255, 100, 255)
                    descendant.LocalTransparencyModifier = 0.2
                    descendant.CastShadow = false
                    
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

    -- ESP функции
    function enableESP()
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= Player then
                createESP(otherPlayer)
            end
        end
        
        table.insert(ESPConnections, Players.PlayerAdded:Connect(function(newPlayer)
            if ESPEnabled then
                createESP(newPlayer)
            end
        end))
        
        table.insert(ESPConnections, Players.PlayerRemoving:Connect(function(leftPlayer)
            if ESPObjects[leftPlayer] then
                for _, obj in pairs(ESPObjects[leftPlayer]) do
                    if obj then
                        obj:Remove()
                    end
                end
                ESPObjects[leftPlayer] = nil
            end
        end))
    end

    function disableESP()
        for _, connection in ipairs(ESPConnections) do
            connection:Disconnect()
        end
        ESPConnections = {}
        
        for player, objects in pairs(ESPObjects) do
            for _, obj in pairs(objects) do
                if obj then
                    obj:Remove()
                end
            end
        end
        ESPObjects = {}
    end

    function createESP(targetPlayer)
        if ESPObjects[targetPlayer] then return end
        
        local espGroup = {}
        
        local box = Drawing.new("Square")
        box.Visible = false
        box.Color = Color3.fromRGB(255, 100, 255)
        box.Thickness = 2
        box.Filled = false
        table.insert(espGroup, box)
        
        local tracer = Drawing.new("Line")
        tracer.Visible = false
        tracer.Color = Color3.fromRGB(180, 100, 255)
        tracer.Thickness = 1
        table.insert(espGroup, tracer)
        
        local name = Drawing.new("Text")
        name.Visible = false
        name.Color = Color3.fromRGB(220, 180, 255)
        name.Size = 16
        name.Center = true
        name.Outline = true
        table.insert(espGroup, name)
        
        local distance = Drawing.new("Text")
        distance.Visible = false
        distance.Color = Color3.fromRGB(220, 180, 255)
        distance.Size = 14
        distance.Center = true
        distance.Outline = true
        table.insert(espGroup, distance)
        
        ESPObjects[targetPlayer] = espGroup
        
        local espUpdate
        espUpdate = RunService.RenderStepped:Connect(function()
            if not ESPEnabled or not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(espGroup) do
                    obj.Visible = false
                end
                return
            end
            
            local rootPart = targetPlayer.Character.HumanoidRootPart
            local head = targetPlayer.Character:FindFirstChild("Head")
            
            if rootPart and head then
                local rootPos, rootVisible = Camera:WorldToViewportPoint(rootPart.Position)
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
                
                if rootVisible then
                    local height = (headPos.Y - rootPos.Y) * 2
                    local width = height / 2
                    
                    box.Size = Vector2.new(width, height)
                    box.Position = Vector2.new(rootPos.X - width/2, rootPos.Y - height/2)
                    box.Visible = true
                    
                    tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                    tracer.Visible = true
                    
                    name.Text = targetPlayer.Name
                    name.Position = Vector2.new(rootPos.X, rootPos.Y - height/2 - 20)
                    name.Visible = true
                    
                    local distanceValue = math.floor((Player.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude)
                    distance.Text = distanceValue .. "m"
                    distance.Position = Vector2.new(rootPos.X, rootPos.Y - height/2 - 40)
                    distance.Visible = true
                else
                    box.Visible = false
                    tracer.Visible = false
                    name.Visible = false
                    distance.Visible = false
                end
            end
        end)
        
        table.insert(ESPConnections, espUpdate)
    end

    -- Shaders функции
    function enableShaders()
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "MoonBlossomBloom"
        bloom.Intensity = 0.5
        bloom.Size = 10
        bloom.Threshold = 0.8
        bloom.Parent = Lighting
        
        local colorCorrection = Instance.new("ColorCorrectionEffect")
        colorCorrection.Name = "MoonBlossomColorCorrection"
        colorCorrection.Brightness = 0.1
        colorCorrection.Contrast = -0.2
        colorCorrection.Saturation = -0.1
        colorCorrection.TintColor = Color3.fromRGB(200, 200, 200)
        colorCorrection.Parent = Lighting
        
        local atmosphere = Instance.new("Atmosphere")
        atmosphere.Name = "MoonBlossomAtmosphere"
        atmosphere.Density = 0.1
        atmosphere.Offset = 0.1
        atmosphere.Color = Color3.fromRGB(50, 50, 50)
        atmosphere.Decay = Color3.fromRGB(30, 30, 30)
        atmosphere.Glare = 0.5
        atmosphere.Haze = 0.3
        atmosphere.Parent = Lighting
        
        local sunRays = Instance.new("SunRaysEffect")
        sunRays.Name = "MoonBlossomSunRays"
        sunRays.Intensity = 0.05
        sunRays.Spread = 0.3
        sunRays.Parent = Lighting
        
        local dof = Instance.new("DepthOfFieldEffect")
        dof.Name = "MoonBlossomDOF"
        dof.FarIntensity = 0.2
        dof.FocusDistance = 10
        dof.InFocusRadius = 20
        dof.NearIntensity = 0.2
        dof.Parent = Lighting
        
        currentShaders = {bloom, colorCorrection, atmosphere, sunRays, dof}
        
        Lighting.Brightness = 1.5
        Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
        Lighting.GlobalShadows = false
        
        local topLight = Instance.new("PointLight")
        topLight.Name = "MoonBlossomTopLight"
        topLight.Brightness = 0.5
        topLight.Range = 10
        topLight.Color = Color3.fromRGB(50, 50, 50)
        topLight.Position = Vector3.new(0, 100, 0)
        topLight.Parent = Workspace.Terrain
        
        local frontLight = Instance.new("PointLight")
        frontLight.Name = "MoonBlossomFrontLight"
        frontLight.Brightness = 0.5
        frontLight.Range = 8
        frontLight.Color = Color3.fromRGB(50, 50, 50)
        frontLight.Position = Vector3.new(0, 5, 50)
        frontLight.Parent = Workspace.Terrain
        
        originalPartProperties = {}
        
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("Part") or part:IsA("MeshPart") or part:IsA("UnionOperation") then
                originalPartProperties[part] = {
                    Material = part.Material,
                    Reflectance = part.Reflectance,
                    Transparency = part.Transparency,
                    Color = part.Color
                }
                
                if part.Name:lower():find("floor") or part.Name:lower():find("ground") or part.Name:lower():find("base") then
                    part.Reflectance = 0.3
                    part.Material = Enum.Material.Slate
                    part.Transparency = 0
                    part.Color = Color3.fromRGB(50, 50, 50)
                end
                
                if part.Name:lower():find("wall") and part.Size.Y > 5 then
                    part.Reflectance = 0.6
                    part.Material = Enum.Material.SmoothPlastic
                    part.Color = Color3.fromRGB(50, 50, 50)
                end
            end
        end
    end

    function disableShaders()
        for _, shader in pairs(currentShaders) do
            if shader and shader.Parent then
                shader:Destroy()
            end
        end
        currentShaders = {}
        
        if Workspace.Terrain:FindFirstChild("MoonBlossomTopLight") then
            Workspace.Terrain.MoonBlossomTopLight:Destroy()
        end
        if Workspace.Terrain:FindFirstChild("MoonBlossomFrontLight") then
            Workspace.Terrain.MoonBlossomFrontLight:Destroy()
        end
        
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.GlobalShadows = true
        
        for part, properties in pairs(originalPartProperties) do
            if part and part.Parent then
                part.Material = properties.Material
                part.Reflectance = properties.Reflectance
                part.Transparency = properties.Transparency
                part.Color = properties.Color
            end
        end
        originalPartProperties = {}
    end

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

    -- Уведомление в чат
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "Moon Blossom v4.0 PREMIUM loaded! Animated GUI, gradients, hovers, pulsing title ✨ Aim Assist on K, Triggerbot on L",
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
        end
        Camera.CameraType = Enum.CameraType.Custom
        -- Восстанавливаем масштаб тела при респавне
        if SpinbotEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then
            local humanoid = Player.Character.Humanoid
            humanoid.BodyWidthScale.Value = 0.5
            humanoid.BodyDepthScale.Value = 0.5
            humanoid.HeadScale.Value = 0.5
            humanoid.BodyHeightScale.Value = 0.5
            print("[MoonBlossom] Spinbot: Body scale reapplied to 0.5 on respawn")
        end
    end)

    -- Анимация входа при запуске
    animateEntrance()
    wait(0.5)
    animateButtons(0.05)

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
