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

-- Основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 280, 0, 400)
MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
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

-- TitleBar для перетаскивания
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(60, 40, 80)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Moon Blossom v1.8"
Title.TextColor3 = Color3.fromRGB(220, 180, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14 -- Заменили 极 на 14
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
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200) -- Заменили TextColor极 на TextColor3
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TitleBar

-- Контейнер для кнопок (будет скрываться при сворачивании)
local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Name = "ButtonsContainer"
ButtonsContainer.Size = UDim2.new(1, 0, 1, -30) -- Заменили 极 на 0
ButtonsContainer.Position = UDim2.new(0, 0, 0, 30)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Parent = MainFrame -- Заменили Buttons极.Parent на ButtonsContainer.Parent

-- Кнопки переключателей (увеличили отступы между кнопками)
local BHopToggle = Instance.new("TextButton")
BHopToggle.Name = "BHopToggle"
BHopToggle.Size = UDim2.new(0, 260, 0, 30)
BHopToggle.Position = UDim2.new(0.035, 0, 0.03, 0)
BHopToggle.Text = "Bunny Hop: OFF"
BHopToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
BHopToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
BHopToggle.Font = Enum.Font.Gotham
BHopToggle.Parent = ButtonsContainer

local SpinbotToggle = Instance.new("TextButton")
SpinbotToggle.Name = "SpinbotToggle"
SpinbotToggle.Size = UDim2.new(0, 260, 0, 30) -- Заменили UDim极 на UDim2
SpinbotToggle.Position = UDim2.new(0.035, 0, 0.10, 0)
SpinbotToggle.Text = "Spinbot: OFF"
SpinbotToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
SpinbotToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
SpinbotToggle.Font = Enum.Font.Gotham
SpinbotToggle.Parent = ButtonsContainer

local ChamsToggle = Instance.new("TextButton")
ChamsToggle.Name = "ChamsToggle"
ChamsToggle.Size = UDim2.new(0, 260, 0, 30)
ChamsToggle.Position = UDim2.new(0.035, 0, 0.17, 0)
ChamsToggle.Text = "Player Chams: OFF"
ChamsToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
ChamsToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
ChamsToggle.Font = Enum.Font.Gotham
ChamsToggle.Parent = ButtonsContainer

local SilentAimToggle = Instance.new("TextButton")
SilentAimToggle.Name = "SilentAimToggle"
SilentAimToggle.Size = UDim2.new(0, 260, 0, 30)
SilentAimToggle.Position = UDim2.new(0.035, 0, 0.24, 0)
SilentAimToggle.Text = "Silent Aim: OFF"
SilentAimToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
SilentAimToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
SilentAimToggle.Font = Enum.Font.Gotham
SilentAimToggle.Parent = ButtonsContainer

local ESPToggle = Instance.new("TextButton") -- Заменили 极Button на TextButton
ESPToggle.Name = "ESPToggle"
ESPToggle.Size = UDim2.new(0, 260, 0, 30)
ESPToggle.Position = UDim2.new(0.035, 0, 0.31, 0)
ESPToggle.Text = "ESP: OFF"
ESPToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
ESPToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
ESPToggle.Font = Enum.Font.Gotham
ESPToggle.Parent = ButtonsContainer

local StrafeToggle = Instance.new("TextButton")
StrafeToggle.Name = "StrafeToggle"
StrafeToggle.Size = UDim2.new(0, 260, 0, 30)
StrafeToggle.Position = UDim2.new(0.035, 0, 0.38, 0)
StrafeToggle.Text = "Air Strafe: OFF"
StrafeToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
StrafeToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
StrafeToggle.Font = Enum.Font.Gotham
StrafeToggle.Parent = ButtonsContainer

local ShadersToggle = Instance.new("TextButton")
ShadersToggle.Name = "ShadersToggle"
ShadersToggle.Size = UDim2.new(0, 260, 0, 30)
ShadersToggle.Position = UDim2.new(0.035, 0, 0.45, 0)
ShadersToggle.Text = "Shaders: OFF"
ShadersToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
ShadersToggle.TextColor3 = Color3.fromRGB(220, 180, 255) -- Заменили 极 на 180
ShadersToggle.Font = Enum.Font.Gotham
ShadersToggle.Parent = ButtonsContainer

-- Новая кнопка Aim Assist
local AimAssistToggle = Instance.new("TextButton")
AimAssistToggle.Name = "AimAssistToggle"
AimAssistToggle.Size = UDim2.new(0, 260, 0, 30)
AimAssistToggle.Position = UDim2.new(0.035, 0, 0.52, 0) -- Заменили A极.Position на AimAssistToggle.Position
AimAssistToggle.Text = "Aim Assist: OFF"
AimAssistToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
AimAssistToggle.TextColor3 = Color3.fromRGB(220, 180, 255) -- Заменили Text极3 на TextColor3
AimAssistToggle.Font = Enum.Font.Gotham
AimAssistToggle.Parent = ButtonsContainer

-- Новая кнопка WalkSpeed
local WalkSpeedToggle = Instance.new("TextButton")
WalkSpeedToggle.Name = "WalkSpeedToggle" -- Заменили Walk极Toggle на WalkSpeedToggle
WalkSpeedToggle.Size = UDim2.new(0, 260, 0, 30)
WalkSpeedToggle.Position = UDim2.new(0.035, 0, 0.59, 0)
WalkSpeedToggle.Text = "WalkSpeed: OFF"
WalkSpeedToggle.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
WalkSpeedToggle.TextColor3 = Color3.fromRGB(220, 180, 255)
WalkSpeedToggle.Font = Enum.Font.Gotham
WalkSpeedToggle.Parent = ButtonsContainer

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
local ChamsConnections = {} -- Заменили ChamsConn极 на ChamsConnections
local OriginalMaterials = {}
local OriginalColors = {}
local OriginalTransparencies = {}

-- Переменные для шейдеров
local currentShaders = {}
local originalPartProperties = {}

-- Переменные для спинбота
local spinRotation = 0
local originalWalkSpeed = 16
local originalJumpPower = 50
local totalSpinbotOffset = Vector3.new(0, 0, 0)

-- Переменные для Aim Assist
local aimAssistTarget = nil
local aimAssistFOV = 180
local fovCircle = nil

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
    
    fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
    
    return fovCircle
end

-- Функция для обновления текста кнопок
function updateButtonText(button, enabled)
    if button.Name == "BHopToggle" then
        button.Text = "Bunny Hop: " .. (enabled and "ON" or "OFF")
    elseif button.Name == "SpinbotToggle" then
        button.Text = "Spinbot: " .. (enabled and "ON" or "OFF")
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
        button.Text = "WalkSpeed: " .. (enabled and "ON" or "OFF") -- Заменили 极 на OFF
    end
end

-- Анимации переключения
function toggleButton(button, state)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) -- Заменили Tween极 на TweenInfo
    local goal = {}
    
    if state then
        goal.BackgroundColor3 = Color3.fromRGB(120, 80, 160)
    else
        goal.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
    end
    
    TweenService:Create(button, tweenInfo, goal):Play()
    updateButtonText(button, state)
end

-- Обработчики кнопок GUI
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    GUIEnabled = false
    if fovCircle then
        fovCircle:Remove()
    end
end)

MinimizeButton.MouseButton1Click:Connect(function()
    ButtonsContainer.Visible = not ButtonsContainer.Visible
    if ButtonsContainer.Visible then
        MainFrame.Size = UDim2.new(0, 280, 0, 400)
    else
        MainFrame.Size = UDim2.new(0, 280, 0, 30)
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
    
    if ChamsEnabled then -- Заменили if极 на if ChamsEnabled
        enableChams()
    else
        disableChams()
    end
end)

SilentAimToggle.MouseButton1Click:Connect(function()
    SilentAimEnabled = not SilentAimEnabled
    toggleButton(SilentAimToggle, SilentAimEnabled)
    
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
    
    if ShadersEnabled then
        enableShaders()
    else
        disableShaders()
    end
end)

-- Обработчик для Aim Assist
AimAssistToggle.MouseButton1Click:Connect(function()
    AimAssistEnabled = not AimAssistEnabled
    toggleButton(AimAssistToggle, AimAssistEnabled)
    
    if not AimAssistEnabled then
        aimAssistTarget = nil
    end
    
    if fovCircle then
        fovCircle.Visible = AimAssistEnabled or SilentAimEnabled
    else
        createFOVCircle()
    end
end)

-- Обработчик для WalkSpeed
WalkSpeedToggle.MouseButton1Click:Connect(function()
    WalkSpeedEnabled = not WalkSpeedEnabled
    toggleButton(WalkSpeedToggle, WalkSpeedEnabled)
    
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        if WalkSpeedEnabled then
            Player.Character.Humanoid.WalkSpeed = 50
        else
            Player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Улучшенный баннихоп с walkspeed 50
RunService.Heartbeat:Connect(function()
    pcall(function()
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
        
        if isOnGround and groundContactStartTime > 0 and (tick() - groundContactStartTime) >= 0.5 then -- Заменили groundContact极Time на groundContactStartTime
            if Humanoid.WalkSpeed > 16 and not WalkSpeedEnabled then
                Humanoid.WalkSpeed = 16
            end
        end
        
        if BHopEnabled and UIS:IsKeyDown(Enum.KeyCode.Space) then -- Заменили UIS:极KeyDown на UIS:IsKeyDown
            if currentlyOnGround then
                local currentTime = tick()
                if currentTime - lastJumpTime > 0.1 then
                    lastJumpTime = currentTime
                    
                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    
                    Humanoid.WalkSpeed = 50
                end
            end
        end
        
        if WalkSpeedEnabled and Humanoid.WalkSpeed ~= 50 then -- Заменили ~极 на ~=
            Humanoid.WalkSpeed = 50
        elseif not WalkSpeedEnabled and not BHopEnabled and Humanoid.WalkSpeed ~= 16 then
            Humanoid.WalkSpeed = 16
        end
    end)
end)

-- Улучшенный спинбот с уходом под землю на 2.5
RunService.Heartbeat:Connect(function()
    pcall(function()
        if SpinbotEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local Char = Player.Character
            local RootPart = Char.HumanoidRootPart
            
            RootPart.CFrame = RootPart.CFrame - totalSpinbotOffset
            
            local newOffset = Vector3.new(0, -2.5, 0)
            totalSpinbotOffset = newOffset
            
            spinRotation = spinRotation + 100
            if spinRotation > 180 then spinRotation = 90 end
            
            RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.rad(spinRotation), 0) + newOffset
        else
            if totalSpinbotOffset ~= Vector3.new(0, 0, 0) then
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame - totalSpinbotOffset
                end
                totalSpinbotOffset = Vector3.new(0, 0, 0)
            end
        end
    end)
end)

-- Air Strafe функция
RunService.Heartbeat:Connect(function()
    pcall(function()
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
end)

-- Функция для поиска ближайшего игрока в FOV
local function findClosestPlayerInFOV(fov)
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
                    closestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    end
    
    return closestPlayer
end

-- Исправленный Aim Assist с FOV 180
RunService.RenderStepped:Connect(function()
    if fovCircle then
        fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
        fovCircle.Visible = AimAssistEnabled or SilentAimEnabled
    end
    
    if AimAssistEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local closestPlayer = findClosestPlayerInFOV(aimAssistFOV)
            
            if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                local targetHead = closestPlayer.Character.Head
                local cameraPosition = Camera.CFrame.Position
                local targetPosition = targetHead.Position
                
                local direction = (targetPosition - cameraPosition).Unit
                local currentLook = Camera.CFrame.LookVector
                local smoothFactor = 0.3
                
                local newLook = currentLook:Lerp(direction, smoothFactor) -- Заменили new极 на newLook
                Camera.CFrame = CFrame.new(cameraPosition, cameraPosition + newLook)
            end
        end
    end
end)

-- Улучшенный Silent Aim с FOV 180
local function findClosestPlayerToCursor()
    return findClosestPlayerInFOV(180)
end

-- Обработчик Silent Aim
Mouse.Button1Down:Connect(function()
    if SilentAimEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local closestPlayer = findClosestPlayerToCursor()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
        end
    end
end)

-- Улучшенная система Chams (видно через стены)
function enableChams()
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= Player then
            createChams(otherPlayer) -- Заменили create极 на createChams
        end
    end
    
    table.insert(ChamsConnections, Players.PlayerAdded:Connect(function(newPlayer)
        if ChamsEnabled then
            createChams(newPlayer)
        end
    end))
    
    table.insert(ChamsConnections, Players.PlayerRemoving:Connect(function(leftPlayer) -- Заменили PlayerRemoving极Connect на PlayerRemoving:Connect
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
                if OriginalTransparencies[part] then -- Заменили OriginalTransparencies极part] на OriginalTransparencies[part]
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

function createChams(targetPlayer) -- Заменили create极 на createChams
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
            applyChams(character) -- Заменили apply极 на applyChams
        end
    end)
end

-- ESP система
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
    name.Color = Color3.fromRGB(220, 180, 255) -- Заменили 极 на 220
    name.Size = 16
    name.Center = true
    name.Outline = true
    table.insert(espGroup, name)
    
    ESPObjects[targetPlayer] = espGroup
    
    local espUpdate
    espUpdate = RunService.RenderStepped:Connect(function() -- Заменили esp极 на espUpdate
        if not ESPEnabled or not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then -- Заменили targetPlayer.极 на targetPlayer.Character
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
                
                tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y) -- Заменили Camera.ViewportSize.X/极 на Camera.ViewportSize.X/2
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
    end)
    
    table.insert(ESPConnections, espUpdate)
end

-- Темные мрачные шейдеры
function enableShaders()
    local bloom = Instance.new("BloomEffect")
    bloom.Name = "MoonBlossomBloom"
    bloom.Intensity = 10
    bloom.Size = 6
    bloom.Threshold = 0.6
    bloom.Parent = Lighting
    
    local colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.Name = "MoonBlossomColorCorrection"
    colorCorrection.Brightness = 6
    colorCorrection.Contrast = 0.5
    colorCorrection.Saturation = 10
    colorCorrection.TintColor = Color3.fromRGB(200, 200, 200)
    colorCorrection.Parent = Lighting
    
    local atmosphere = Instance.new("Atmosphere")
    atmosphere.Name = "MoonBlossomAtmosphere"
    atmosphere.Density = 0.1
    atmosphere.Offset = 0.1
    atmosphere.Color = Color3.fromRGB(50, 50, 50)
    atmosphere.Decay = Color3.fromRGB(30, 30, 30)
    atmosphere.Glare = 22
    atmosphere.Haze = 14
    atmosphere.Parent = Lighting -- Заменили atmosphere.P极 на atmosphere.Parent
    
    local sunRays = Instance.new("SunRaysEffect")
    sunRays.Name = "MoonBlossomSunRays"
    sunRays.Intensity = 2 -- Заменили 0.极 на 0.05
    sunRays.Spread = 3
    sunRays.Parent = Lighting -- Заменили sun极.Parent на sunRays.Parent
    
    local dof = Instance.new("DepthOfFieldEffect")
    dof.Name = "MoonBlossomDOF"
    dof.FarIntensity = 2
    dof.FocusDistance = 1
    dof.InFocusRadius = 20
    dof.NearIntensity = 0.2
    dof.Parent = Lighting
    
    currentShaders = {bloom, colorCorrection, atmosphere, sunRays, dof}
    
    Lighting.Brightness = 0.5
    Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
    Lighting.GlobalShadows = false
    
    local topLight = Instance.new("PointLight")
    topLight.Name = "MoonBlossomTopLight" -- Заменили Name极 на Name
    topLight.Brightness = 0.1
    topLight.Range = 100
    topLight.Color = Color3.fromRGB(50, 50, 50)
    topLight.Position = Vector3.new(0, 100, 0)
    topLight.Parent = Workspace.Terrain
    
    local frontLight = Instance.new("PointLight")
    frontLight.Name = "MoonBlossomFrontLight"
    frontLight.Brightness = 0.1
    frontLight.Range = 80
    frontLight.Color = Color3.fromRGB(50, 50, 50)
    frontLight.Position = Vector3.new(0, 5, 50)
    frontLight.Parent = Workspace.Terrain
    
    originalPartProperties = {}
    
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("Part") or part:IsA("MeshPart") or part:IsA("UnionOperation") then
            originalPartProperties[part] = { -- Заменили originalPartProperties[极] на originalPartProperties[part]
                Material = part.Material,
                Reflectance = part.Reflectance,
                Transparency = part.Transparency,
                Color = part.Color
            }
            
            if part.Name:lower():find("floor") or part.Name:lower():find("ground") or part.Name:lower():find("base") then
                part.Reflectance = 0.9
                part.Material = Enum.Material.Slate
                part.Transparency = 0
                part.Color = Color3.fromRGB(50, 50, 50)
            end
            
            if part.Name:lower():find("wall") and part.Size.Y > 5 then
                part.Reflectance = 0.9
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
    if input == dragInput and dragging then -- Заменили input == drag极 на input == dragInput
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
updateButtonText(AimAssistToggle, AimAssistEnabled) -- Заменили AimAss极Enabled на AimAssistEnabled
updateButtonText(WalkSpeedToggle, WalkSpeedEnabled)

-- Уведомление в чат
game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "Moon Blossom v1.8 loaded! FOV 180 & fixed positioning",
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
end)

-- Гарантируем отображение GUI
wait(1)
ScreenGui.Enabled = true
for _, child in ipairs(ScreenGui:GetDescendants()) do
    if child:IsA("GuiObject") then
        child.Visible = true
    end
end


