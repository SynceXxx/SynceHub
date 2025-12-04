-- SynceScriptHub | Professional Loading Screen v1.0
-- Created by SynceXxx
-- Upload this to GitHub and use with loadstring

local LoadingScreen = {}

function LoadingScreen:Create()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
    -- Create ScreenGui
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "SynceLoadingScreen"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    LoadingGui.DisplayOrder = 10000
    LoadingGui.IgnoreGuiInset = true
    LoadingGui.Parent = PlayerGui
    
    -- Background
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    Background.BorderSizePixel = 0
    Background.Parent = LoadingGui
    
    -- Gradient Background
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 18)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 20, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 18))
    }
    Gradient.Rotation = 45
    Gradient.Parent = Background
    
    -- Main Container
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(0, 400, 0, 350)
    Container.Position = UDim2.new(0.5, -200, 0.5, -175)
    Container.BackgroundTransparency = 1
    Container.Parent = Background
    
    -- Logo Container
    local LogoContainer = Instance.new("Frame")
    LogoContainer.Name = "LogoContainer"
    LogoContainer.Size = UDim2.new(0, 100, 0, 100)
    LogoContainer.Position = UDim2.new(0.5, -50, 0, 0)
    LogoContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    LogoContainer.BorderSizePixel = 0
    LogoContainer.Parent = Container
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(0, 20)
    LogoCorner.Parent = LogoContainer
    
    local LogoStroke = Instance.new("UIStroke")
    LogoStroke.Color = Color3.fromRGB(100, 100, 255)
    LogoStroke.Thickness = 3
    LogoStroke.Transparency = 0
    LogoStroke.Parent = LogoContainer
    
    -- Logo Text
    local LogoText = Instance.new("TextLabel")
    LogoText.Name = "LogoText"
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.Position = UDim2.new(0, 0, 0, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "S"
    LogoText.TextColor3 = Color3.fromRGB(100, 100, 255)
    LogoText.TextSize = 60
    LogoText.Font = Enum.Font.GothamBold
    LogoText.Parent = LogoContainer
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 120)
    Title.BackgroundTransparency = 1
    Title.Text = "SynceScriptHub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 28
    Title.Font = Enum.Font.GothamBold
    Title.TextTransparency = 1
    Title.Parent = Container
    
    -- Subtitle
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Size = UDim2.new(1, 0, 0, 25)
    Subtitle.Position = UDim2.new(0, 0, 0, 165)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Youtuber Empire Hub"
    Subtitle.TextColor3 = Color3.fromRGB(150, 150, 155)
    Subtitle.TextSize = 16
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextTransparency = 1
    Subtitle.Parent = Container
    
    -- Loading Bar Background
    local BarBackground = Instance.new("Frame")
    BarBackground.Name = "BarBackground"
    BarBackground.Size = UDim2.new(0.8, 0, 0, 6)
    BarBackground.Position = UDim2.new(0.1, 0, 0, 220)
    BarBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    BarBackground.BorderSizePixel = 0
    BarBackground.Parent = Container
    
    local BarBackgroundCorner = Instance.new("UICorner")
    BarBackgroundCorner.CornerRadius = UDim.new(1, 0)
    BarBackgroundCorner.Parent = BarBackground
    
    -- Loading Bar Fill
    local BarFill = Instance.new("Frame")
    BarFill.Name = "BarFill"
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.Position = UDim2.new(0, 0, 0, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarBackground
    
    local BarFillCorner = Instance.new("UICorner")
    BarFillCorner.CornerRadius = UDim.new(1, 0)
    BarFillCorner.Parent = BarFill
    
    -- Bar Gradient
    local BarGradient = Instance.new("UIGradient")
    BarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 200))
    }
    BarGradient.Rotation = 90
    BarGradient.Parent = BarFill
    
    -- Loading Text
    local LoadingText = Instance.new("TextLabel")
    LoadingText.Name = "LoadingText"
    LoadingText.Size = UDim2.new(1, 0, 0, 20)
    LoadingText.Position = UDim2.new(0, 0, 0, 240)
    LoadingText.BackgroundTransparency = 1
    LoadingText.Text = "Initializing..."
    LoadingText.TextColor3 = Color3.fromRGB(150, 150, 155)
    LoadingText.TextSize = 14
    LoadingText.Font = Enum.Font.Gotham
    LoadingText.TextTransparency = 1
    LoadingText.Parent = Container
    
    -- Percentage Text
    local PercentText = Instance.new("TextLabel")
    PercentText.Name = "PercentText"
    PercentText.Size = UDim2.new(1, 0, 0, 25)
    PercentText.Position = UDim2.new(0, 0, 0, 265)
    PercentText.BackgroundTransparency = 1
    PercentText.Text = "0%"
    PercentText.TextColor3 = Color3.fromRGB(100, 100, 255)
    PercentText.TextSize = 18
    PercentText.Font = Enum.Font.GothamBold
    PercentText.TextTransparency = 1
    PercentText.Parent = Container
    
    -- Version Text
    local VersionText = Instance.new("TextLabel")
    VersionText.Name = "VersionText"
    VersionText.Size = UDim2.new(1, 0, 0, 20)
    VersionText.Position = UDim2.new(0, 0, 1, -30)
    VersionText.BackgroundTransparency = 1
    VersionText.Text = "Version 1.8 (FINAL)"
    VersionText.TextColor3 = Color3.fromRGB(80, 80, 85)
    VersionText.TextSize = 12
    VersionText.Font = Enum.Font.Gotham
    VersionText.Parent = Background
    
    -- Credits Text
    local CreditsText = Instance.new("TextLabel")
    CreditsText.Name = "CreditsText"
    CreditsText.Size = UDim2.new(1, 0, 0, 20)
    CreditsText.Position = UDim2.new(0, 0, 1, -50)
    CreditsText.BackgroundTransparency = 1
    CreditsText.Text = "Created by SynceXxx"
    CreditsText.TextColor3 = Color3.fromRGB(80, 80, 85)
    CreditsText.TextSize = 11
    CreditsText.Font = Enum.Font.Gotham
    CreditsText.Parent = Background
    
    -- Animations
    local function fadeIn(object, duration)
        TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play()
    end
    
    local function scaleIn(object, duration)
        object.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 100, 0, 100)
        }):Play()
    end
    
    -- Pulse Animation for Logo
    local function pulseLogo()
        spawn(function()
            while LoadingGui.Parent do
                TweenService:Create(LogoStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Transparency = 0.5
                }):Play()
                wait(1)
                TweenService:Create(LogoStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Transparency = 0
                }):Play()
                wait(1)
            end
        end)
    end
    
    -- Gradient Animation
    local function animateGradient()
        spawn(function()
            while LoadingGui.Parent do
                TweenService:Create(Gradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Rotation = Gradient.Rotation + 360
                }):Play()
                wait(3)
            end
        end)
    end
    
    -- Bar Gradient Animation
    local function animateBarGradient()
        spawn(function()
            while LoadingGui.Parent do
                TweenService:Create(BarGradient, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Offset = Vector2.new(1, 0)
                }):Play()
                wait(2)
                BarGradient.Offset = Vector2.new(-1, 0)
            end
        end)
    end
    
    -- Start Animations
    task.wait(0.1)
    scaleIn(LogoContainer, 0.5)
    task.wait(0.3)
    fadeIn(Title, 0.4)
    task.wait(0.2)
    fadeIn(Subtitle, 0.4)
    task.wait(0.2)
    fadeIn(LoadingText, 0.3)
    fadeIn(PercentText, 0.3)
    
    pulseLogo()
    animateGradient()
    animateBarGradient()
    
    -- Loading Stages
    local stages = {
        {text = "Initializing script...", percent = 15, duration = 0.3},
        {text = "Loading features...", percent = 30, duration = 0.4},
        {text = "Setting up UI...", percent = 50, duration = 0.5},
        {text = "Configuring functions...", percent = 70, duration = 0.4},
        {text = "Finalizing setup...", percent = 90, duration = 0.3},
        {text = "Almost ready...", percent = 100, duration = 0.3}
    }
    
    -- Progress through stages
    for i, stage in ipairs(stages) do
        LoadingText.Text = stage.text
        
        local targetSize = UDim2.new(stage.percent / 100, 0, 1, 0)
        TweenService:Create(BarFill, TweenInfo.new(stage.duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = targetSize
        }):Play()
        
        -- Animate percentage counting
        local startPercent = i == 1 and 0 or stages[i-1].percent
        local endPercent = stage.percent
        local steps = 20
        local increment = (endPercent - startPercent) / steps
        
        for j = 1, steps do
            local currentPercent = math.floor(startPercent + (increment * j))
            PercentText.Text = currentPercent .. "%"
            task.wait(stage.duration / steps)
        end
    end
    
    -- Completion
    task.wait(0.3)
    LoadingText.Text = "Complete! ✓"
    TweenService:Create(LoadingText, TweenInfo.new(0.3), {
        TextColor3 = Color3.fromRGB(100, 255, 100)
    }):Play()
    
    task.wait(0.5)
    
    -- Fade out
    TweenService:Create(Background, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play()
    
    for _, obj in pairs(Container:GetDescendants()) do
        if obj:IsA("TextLabel") then
            TweenService:Create(obj, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        elseif obj:IsA("Frame") then
            TweenService:Create(obj, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        elseif obj:IsA("UIStroke") then
            TweenService:Create(obj, TweenInfo.new(0.5), {Transparency = 1}):Play()
        end
    end
    
    TweenService:Create(VersionText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(CreditsText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    task.wait(0.6)
    LoadingGui:Destroy()
end

return LoadingScreen