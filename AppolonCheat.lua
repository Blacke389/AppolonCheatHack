return function()
    -- Appolon Ultra Cheat Menu
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")

    -- Проверка на повторный запуск
    if _G.AppolonUltraLoaded then return end
    _G.AppolonUltraLoaded = true

    -- Ожидаем загрузку персонажа
    repeat task.wait() until LocalPlayer.Character

    -- Создаем основное меню
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AppolonUltraMenu"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 220, 0, 200)
    mainFrame.Position = UDim2.new(0.1, 0, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    -- Эффект стекла
    local glassEffect = Instance.new("ImageLabel")
    glassEffect.Image = "rbxassetid://1493288030"
    glassEffect.ScaleType = Enum.ScaleType.Slice
    glassEffect.SliceCenter = Rect.new(100, 100, 100, 100)
    glassEffect.Size = UDim2.new(1, 0, 1, 0)
    glassEffect.BackgroundTransparency = 1
    glassEffect.Parent = mainFrame

    -- Скругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    -- Тень
    local shadow = Instance.new("ImageLabel")
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = -1
    shadow.Parent = mainFrame

    -- Заголовок (перемещаемая область)
    local dragArea = Instance.new("TextButton")
    dragArea.Text = ""
    dragArea.Size = UDim2.new(1, 0, 0, 40)
    dragArea.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    dragArea.BorderSizePixel = 0
    dragArea.AutoButtonColor = false
    dragArea.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Text = "APPOLON ULTRA"
    title.Size = UDim2.new(0.8, 0, 1, 0)
    title.Position = UDim2.new(0.1, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = dragArea

    -- Анимация заголовка (неоновая подсветка)
    spawn(function()
        local hue = 0
        while title.Parent do
            hue = (hue + 0.01) % 1
            local r, g, b = Color3.fromHSV(hue, 0.8, 1):ToRGB()
            title.TextColor3 = Color3.new(r, g, b)
            task.wait(0.05)
        end
    end)

    -- Кнопка-стрелка для сворачивания
    local arrowBtn = Instance.new("TextButton")
    arrowBtn.Text = "▼"
    arrowBtn.Size = UDim2.new(0, 30, 0, 30)
    arrowBtn.Position = UDim2.new(1, -35, 0.5, -15)
    arrowBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    arrowBtn.TextColor3 = Color3.new(1, 1, 1)
    arrowBtn.Font = Enum.Font.GothamBold
    arrowBtn.TextSize = 16
    arrowBtn.ZIndex = 2
    arrowBtn.Parent = dragArea

    local arrowCorner = Instance.new("UICorner")
    arrowCorner.CornerRadius = UDim.new(0, 8)
    arrowCorner.Parent = arrowBtn

    -- Анимация стрелки
    spawn(function()
        while arrowBtn.Parent do
            TweenService:Create(arrowBtn, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = 5
            }):Play()
            task.wait(0.8)
            TweenService:Create(arrowBtn, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = -5
            }):Play()
            task.wait(0.8)
        end
    end)

    -- Кнопки
    local buttons = {}
    local states = {
        speed = false,
        noclip = false,
        infinitejump = false
    }

    -- Цвета для обводок кнопок
    local rainbowColors = {
        Color3.fromRGB(255, 0, 0),    -- Красный
        Color3.fromRGB(255, 127, 0),  -- Оранжевый
        Color3.fromRGB(255, 255, 0),  -- Желтый
        Color3.fromRGB(0, 255, 0),    -- Зеленый
        Color3.fromRGB(0, 0, 255),    -- Синий
        Color3.fromRGB(75, 0, 130),   -- Индиго
        Color3.fromRGB(148, 0, 211)   -- Фиолетовый
    }

    -- Функция создания кнопки
    local function createButton(yPos, text, key, icon)
        local buttonFrame = Instance.new("Frame")
        buttonFrame.Size = UDim2.new(0.9, 0, 0, 40)
        buttonFrame.Position = UDim2.new(0.05, 0, 0, yPos)
        buttonFrame.BackgroundTransparency = 1
        buttonFrame.Parent = mainFrame
        
        local button = Instance.new("TextButton")
        button.Text = ""
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        button.BackgroundTransparency = 0.3
        button.Parent = buttonFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = button
        
        -- Обводка с анимацией радуги
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = rainbowColors[1]
        stroke.Transparency = 0.3
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = button
        
        -- Анимация радуги для обводки
        spawn(function()
            local index = 1
            while button.Parent do
                stroke.Color = rainbowColors[index]
                index = (index % #rainbowColors) + 1
                task.wait(0.3)
            end
        end)
        
        -- Эффект стекла для кнопки
        local buttonGlass = Instance.new("ImageLabel")
        buttonGlass.Image = "rbxassetid://1493288030"
        buttonGlass.ScaleType = Enum.ScaleType.Slice
        buttonGlass.SliceCenter = Rect.new(100, 100, 100, 100)
        buttonGlass.Size = UDim2.new(1, 0, 1, 0)
        buttonGlass.BackgroundTransparency = 1
        buttonGlass.Parent = button
        
        -- Иконка
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Text = icon
        iconLabel.Size = UDim2.new(0, 30, 1, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.Font = Enum.Font.GothamBold
        iconLabel.TextSize = 20
        iconLabel.Parent = buttonFrame
        
        -- Текст
        local textLabel = Instance.new("TextLabel")
        textLabel.Text = text
        textLabel.Size = UDim2.new(0.7, 0, 1, 0)
        textLabel.Position = UDim2.new(0.3, 0, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.Font = Enum.Font.GothamMedium
        textLabel.TextSize = 14
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = buttonFrame
        
        -- Индикатор состояния
        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 10, 0, 10)
        indicator.Position = UDim2.new(1, -15, 0.5, -5)
        indicator.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        indicator.BorderSizePixel = 0
        indicator.Parent = buttonFrame
        local indCorner = Instance.new("UICorner")
        indCorner.CornerRadius = UDim.new(1, 0)
        indCorner.Parent = indicator
        
        buttons[key] = {
            frame = buttonFrame,
            button = button,
            text = textLabel,
            icon = iconLabel,
            indicator = indicator,
            stroke = stroke
        }
        
        -- Анимация при наведении
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.2), {
                TextColor3 = Color3.new(0.9, 0.9, 1)
            }):Play()
            TweenService:Create(stroke, TweenInfo.new(0.2), {
                Thickness = 3,
                Transparency = 0
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundTransparency = 0.3
            }):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.3), {
                TextColor3 = Color3.new(1, 1, 1)
            }):Play()
            TweenService:Create(stroke, TweenInfo.new(0.3), {
                Thickness = 2,
                Transparency = 0.3
            }):Play()
        end)
        
        -- Обработчик клика
        button.MouseButton1Click:Connect(function()
            states[key] = not states[key]
            local color = states[key] and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(200, 40, 40)
            
            TweenService:Create(indicator, TweenInfo.new(0.2), {
                BackgroundColor3 = color
            }):Play()
            
            -- Анимация нажатия
            TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(0.95, 0, 0.95, 0),
                Position = UDim2.new(0.025, 0, 0.025, 0)
            }):Play()
            task.wait(0.1)
            TweenService:Create(button, TweenInfo.new(0.2), {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            -- Активация функций
            if key == "speed" then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.WalkSpeed = states.speed and 80 or 16
                end
                
            elseif key == "noclip" then
                -- Обрабатывается ниже
                
            elseif key == "infinitejump" then
                -- Обрабатывается ниже
            end
        end)
    end

    -- Создаем кнопки
    createButton(45, "БЫСТРЫЙ БЕГ", "speed", "🏃")
    createButton(95, "NO CLIP", "noclip", "👻")
    createButton(145, "БЕСКОНЕЧНЫЕ ПРЫЖКИ", "infinitejump", "♾️")

    -- Обработка NoClip
    RunService.Stepped:Connect(function()
        if states.noclip and LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)

    -- Бесконечные прыжки
    local function infiniteJump()
        if states.infinitejump then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end

    UserInputService.JumpRequest:Connect(infiniteJump)

    -- Перемещение меню
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Сворачивание меню
    local minimized = false
    local originalSize = mainFrame.Size
    local originalPosition = mainFrame.Position

    arrowBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        
        if minimized then
            -- Сворачиваем
            arrowBtn.Text = "▲"
            
            TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
                Size = UDim2.new(0, 40, 0, 40),
                Position = UDim2.new(1, -50, 0, 20)
            }):Play()
            
            -- Скрываем содержимое
            for _, btnData in pairs(buttons) do
                btnData.frame.Visible = false
            end
        else
            -- Разворачиваем
            arrowBtn.Text = "▼"
            
            TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
                Size = originalSize,
                Position = originalPosition
            }):Play()
            
            -- Показываем содержимое
            for _, btnData in pairs(buttons) do
                btnData.frame.Visible = true
            end
        end
    end)

    -- Анимация появления
    mainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
    TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.1, 0, 0.5, -100)
    }):Play()

    print("Appolon Ultra Cheat loaded! | Speed | NoClip | InfiniteJump")
end