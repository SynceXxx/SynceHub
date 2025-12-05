-- SynceScriptHub | GALAXY THEME Loading Screen v3.0
-- Complete Redesign with Galaxy Theme
-- Created by SynceXxx
-- Duration: 3 seconds

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
    
    -- GALAXY Background (Deep Space Purple/Blue)
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = Color3.fromRGB(10, 5, 25)
    Background.BorderSizePixel = 0
    Background.Parent = LoadingGui
    
    -- Animated Galaxy Gradient
    local GalaxyGradient = Instance.new("UIGradient")
    GalaxyGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 10, 50)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(60, 20, 100)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 30, 150)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(60, 20, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 10, 50))
    }
    GalaxyGradient.Rotation = 45
    GalaxyGradient.Parent = Background
    
    -- Rotating galaxy gradient
    task.spawn(function()
        while LoadingGui.Parent do
            TweenService:Create(GalaxyGradient, TweenInfo.new(4, Enum.EasingStyle.Linear), {
                Rotation = GalaxyGradient.Rotation + 360
            }):Play()
            task.wait(4)
        end
    end)
    
    -- Create STARS (50 stars randomly placed)
    for i = 1, 50 do
        local star = Instance.new("Frame")
        star.Name = "Star" .. i
        star.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        star.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        star.BackgroundTransparency = math.random(0, 60) / 100
        star.BorderSizePixel = 0
        star.ZIndex = 2
        star.Parent = Background
        
        local starCorner = Instance.new("UICorner")
        starCorner.CornerRadius = UDim.new(1, 0)
        starCorner.Parent = star
        
        -- Twinkling animation
        task.spawn(function()
            task.wait(math.random(0, 200) / 100)
            while LoadingGui.Parent do
                local duration = math.random(10, 25) / 10
                TweenService:Create(star, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = math.random(30, 90) / 100
                }):Play()
                task.wait(duration)
            end
        end)
    end
    
    -- Main Container
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(0, 550, 0, 500)
    Container.Position = UDim2.new(0.5, -275, 0.5, -250)
    Container.BackgroundTransparency = 1
    Container.ZIndex = 3
    Container.Parent = Background
    
    -- GIANT GLOWING ORB (Planet/Moon)
    local GlowOrb = Instance.new("Frame")
    GlowOrb.Name = "GlowOrb"
    GlowOrb.Size = UDim2.new(0, 220, 0, 220)
    GlowOrb.Position = UDim2.new(0.5, -110, 0, 0)
    GlowOrb.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
    GlowOrb.BorderSizePixel = 0
    GlowOrb.ZIndex = 4
    GlowOrb.Parent = Container
    
    local OrbCorner = Instance.new("UICorner")
    OrbCorner.CornerRadius = UDim.new(1, 0)
    OrbCorner.Parent = GlowOrb
    
    -- Orb Gradient (Galaxy colors)
    local OrbGradient = Instance.new("UIGradient")
    OrbGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 50, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 150, 255))
    }
    OrbGradient.Rotation = 90
    OrbGradient.Parent = GlowOrb
    
    -- Rotating orb gradient
    task.spawn(function()
        while LoadingGui.Parent do
            TweenService:Create(OrbGradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                Rotation = OrbGradient.Rotation + 360
            }):Play()
            task.wait(3)
        end
    end)
    
    -- OUTER GLOW EFFECT (Multiple layers)
    for i = 1, 3 do
        local glowRing = Instance.new("Frame")
        glowRing.Name = "GlowRing" .. i
        glowRing.Size = UDim2.new(0, 220 + (i * 40), 0, 220 + (i * 40))
        glowRing.Position = UDim2.new(0.5, -(110 + (i * 20)), 0, -(i * 20))
        glowRing.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
        glowRing.BackgroundTransparency = 0.7 + (i * 0.1)
        glowRing.BorderSizePixel = 0
        glowRing.ZIndex = 3
        glowRing.Parent = Container
        
        local ringCorner = Instance.new("UICorner")
        ringCorner.CornerRadius = UDim.new(1, 0)
        ringCorner.Parent = glowRing
        
        -- Pulsing animation
        task.spawn(function()
            while LoadingGui.Parent do
                TweenService:Create(glowRing, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 220 + (i * 40) + 20, 0, 220 + (i * 40) + 20),
                    BackgroundTransparency = 0.9
                }):Play()
                task.wait(1.5)
                TweenService:Create(glowRing, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 220 + (i * 40), 0, 220 + (i * 40)),
                    BackgroundTransparency = 0.7 + (i * 0.1)
                }):Play()
                task.wait(1.5)
            end
        end)
    end
    
    -- CENTER LOGO/ICON (S with glow)
    local CenterIcon = Instance.new("TextLabel")
    CenterIcon.Name = "CenterIcon"
    CenterIcon.Size = UDim2.new(0, 180, 0, 180)
    CenterIcon.Position = UDim2.new(0.5, -90, 0, 20)
    CenterIcon.BackgroundTransparency = 1
    CenterIcon.Text = "✨"
    CenterIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    CenterIcon.TextSize = 100
    CenterIcon.Font = Enum.Font.GothamBold
    CenterIcon.TextTransparency = 1
    CenterIcon.ZIndex = 6
    CenterIcon.Parent = Container
    
    -- Spinning particles around orb
    for i = 1, 8 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        particle.Size = UDim2.new(0, 8, 0, 8)
        particle.BackgroundColor3 = Color3.fromRGB(200, 150, 255)
        particle.BorderSizePixel = 0
        particle.ZIndex = 5
        particle.Parent = Container
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(1, 0)
        pCorner.Parent = particle
        
        -- Orbital animation
        task.spawn(function()
            local angle = (i - 1) * (360 / 8)
            local radius = 130
            while LoadingGui.Parent do
                angle = angle + 2
                local rad = math.rad(angle)
                local x = math.cos(rad) * radius
                local y = math.sin(rad) * radius
                particle.Position = UDim2.new(0.5, x - 4, 0, 110 + y - 4)
                task.wait(0.03)
            end
        end)
    end
    
    -- TITLE TEXT with glow effect
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "TitleText"
    TitleText.Size = UDim2.new(1, 0, 0, 70)
    TitleText.Position = UDim2.new(0, 0, 0, 250)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = "✨ SYNCE GALAXY ✨"
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.TextSize = 48
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextStrokeTransparency = 0
    TitleText.TextStrokeColor3 = Color3.fromRGB(150, 100, 255)
    TitleText.TextTransparency = 1
    TitleText.ZIndex = 7
    TitleText.Parent = Container
    
    -- Subtitle
    local SubtitleText = Instance.new("TextLabel")
    SubtitleText.Name = "SubtitleText"
    SubtitleText.Size = UDim2.new(1, 0, 0, 30)
    SubtitleText.Position = UDim2.new(0, 0, 0, 320)
    SubtitleText.BackgroundTransparency = 1
    SubtitleText.Text = "Youtuber Empire • Enhanced Edition"
    SubtitleText.TextColor3 = Color3.fromRGB(200, 180, 255)
    SubtitleText.TextSize = 16
    SubtitleText.Font = Enum.Font.Gotham
    SubtitleText.TextTransparency = 1
    SubtitleText.ZIndex = 7
    SubtitleText.Parent = Container
    
    -- Loading bar container
    local BarContainer = Instance.new("Frame")
    BarContainer.Name = "BarContainer"
    BarContainer.Size = UDim2.new(0, 350, 0, 8)
    BarContainer.Position = UDim2.new(0.5, -175, 0, 370)
    BarContainer.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    BarContainer.BorderSizePixel = 0
    BarContainer.ZIndex = 7
    BarContainer.Parent = Container
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = BarContainer
    
    -- Loading bar fill
    local BarFill = Instance.new("Frame")
    BarFill.Name = "BarFill"
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
    BarFill.BorderSizePixel = 0
    BarFill.ZIndex = 8
    BarFill.Parent = BarContainer
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = BarFill
    
    -- Bar gradient
    local BarGradient = Instance.new("UIGradient")
    BarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 50, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 50, 200))
    }
    BarGradient.Parent = BarFill
    
    -- Animated bar gradient
    task.spawn(function()
        while LoadingGui.Parent do
            TweenService:Create(BarGradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
                Offset = Vector2.new(1, 0)
            }):Play()
            task.wait(1.5)
            BarGradient.Offset = Vector2.new(-1, 0)
        end
    end)
    
    -- Loading percentage text
    local PercentText = Instance.new("TextLabel")
    PercentText.Name = "PercentText"
    PercentText.Size = UDim2.new(1, 0, 0, 30)
    PercentText.Position = UDim2.new(0, 0, 0, 395)
    PercentText.BackgroundTransparency = 1
    PercentText.Text = "0%"
    PercentText.TextColor3 = Color3.fromRGB(200, 180, 255)
    PercentText.TextSize = 18
    PercentText.Font = Enum.Font.GothamBold
    PercentText.TextTransparency = 1
    PercentText.ZIndex = 7
    PercentText.Parent = Container
    
    -- Status text
    local StatusText = Instance.new("TextLabel")
    StatusText.Name = "StatusText"
    StatusText.Size = UDim2.new(1, 0, 0, 25)
    StatusText.Position = UDim2.new(0, 0, 0, 430)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Initializing..."
    StatusText.TextColor3 = Color3.fromRGB(150, 130, 200)
    StatusText.TextSize = 14
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextTransparency = 1
    StatusText.ZIndex = 7
    StatusText.Parent = Container
    
    -- Version & Credits
    local VersionText = Instance.new("TextLabel")
    VersionText.Size = UDim2.new(0, 200, 0, 20)
    VersionText.Position = UDim2.new(0.5, -100, 1, -40)
    VersionText.BackgroundTransparency = 1
    VersionText.Text = "Galaxy Edition • V2.1"
    VersionText.TextColor3 = Color3.fromRGB(150, 130, 200)
    VersionText.TextSize = 12
    VersionText.Font = Enum.Font.Gotham
    VersionText.ZIndex = 10
    VersionText.Parent = Background
    
    local CreditsText = Instance.new("TextLabel")
    CreditsText.Size = UDim2.new(0, 200, 0, 20)
    CreditsText.Position = UDim2.new(0.5, -100, 1, -60)
    CreditsText.BackgroundTransparency = 1
    CreditsText.Text = "Created by Synce"
    CreditsText.TextColor3 = Color3.fromRGB(150, 130, 200)
    CreditsText.TextSize = 11
    CreditsText.Font = Enum.Font.Gotham
    CreditsText.ZIndex = 10
    CreditsText.Parent = Background
    
    -- ANIMATIONS START
    task.wait(0.1)
    
    -- Fade in orb
    GlowOrb.Size = UDim2.new(0, 0, 0, 0)
    GlowOrb.Position = UDim2.new(0.5, 0, 0, 110)
    TweenService:Create(GlowOrb, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 220, 0, 220),
        Position = UDim2.new(0.5, -110, 0, 0)
    }):Play()
    
    task.wait(0.3)
    TweenService:Create(CenterIcon, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    
    task.wait(0.2)
    TweenService:Create(TitleText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(0.2)
    TweenService:Create(SubtitleText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    TweenService:Create(PercentText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    TweenService:Create(StatusText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    
    -- Loading stages (3 seconds total)
    local stages = {
        {text = "Connecting to galaxy...", percent = 25, duration = 0.7},
        {text = "Loading cosmic features...", percent = 50, duration = 0.7},
        {text = "Initializing starfield...", percent = 75, duration = 0.7},
        {text = "Finalizing universe...", percent = 100, duration = 0.7}
    }
    
    for i, stage in ipairs(stages) do
        StatusText.Text = stage.text
        
        local targetSize = UDim2.new(stage.percent / 100, 0, 1, 0)
        TweenService:Create(BarFill, TweenInfo.new(stage.duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = targetSize
        }):Play()
        
        -- Animate percentage
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
    
    -- Complete message
    StatusText.Text = "✨ Galaxy Loaded! ✨"
    TweenService:Create(StatusText, TweenInfo.new(0.3), {
        TextColor3 = Color3.fromRGB(200, 255, 200)
    }):Play()
    
    task.wait(0.3)
    
    -- Fade out everything
    TweenService:Create(Background, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(GlowOrb, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(CenterIcon, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(TitleText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(SubtitleText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(PercentText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(StatusText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(BarContainer, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BarFill, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(VersionText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(CreditsText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    
    task.wait(0.7)
    LoadingGui:Destroy()
end

return LoadingScreen