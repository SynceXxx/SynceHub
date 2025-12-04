-- SynceScriptHub | Professional Loading Screen v2.0
-- Created by SynceXxx | Optimized by AI Assistant
-- Last Updated: 2025

local LoadingScreen = {}
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")

-- Configuration (MUDAH DIKUSTOMISASI)
local CONFIG = {
    THEME = {
        PRIMARY = Color3.fromRGB(100, 100, 255),
        SECONDARY = Color3.fromRGB(18, 18, 22),
        TEXT_PRIMARY = Color3.fromRGB(255, 255, 255),
        TEXT_SECONDARY = Color3.fromRGB(150, 150, 155),
        SUCCESS = Color3.fromRGB(100, 255, 100)
    },
    
    PERFORMANCE = {
        PARTICLE_COUNT_LOW = 5,
        PARTICLE_COUNT_MEDIUM = 10,
        PARTICLE_COUNT_HIGH = 15,
        MOBILE_MODE = RunService:IsMobile() or RunService:IsTablet()
    },
    
    TIMING = {
        FADE_IN_DELAY = 0.1,
        STAGE_DELAY = 0.2,
        COMPLETION_DELAY = 0.4,
        FADE_OUT_DURATION = 0.5,
        TOTAL_DURATION = 2.5 -- Target total loading time
    },
    
    CONTENT = {
        TITLE = "SynceScriptHub",
        SUBTITLE = "Youtuber Empire Hub",
        VERSION = "Version V2.1",
        CREDITS = "Created by SynceXxx",
        
        STAGES = {
            {text = "Initializing script...", percent = 20, duration = 0.3},
            {text = "Loading features...", percent = 40, duration = 0.3},
            {text = "Setting up UI...", percent = 60, duration = 0.4},
            {text = "Configuring functions...", percent = 80, duration = 0.3},
            {text = "Almost ready...", percent = 100, duration = 0.3}
        }
    }
}

-- Promise-like async handler untuk Roblox
local Async = {}
function Async.wait(duration)
    local start = tick()
    while tick() - start < duration do
        RunService.Heartbeat:Wait()
    end
end

function Async.createThread(callback)
    return task.spawn(callback)
end

-- Main LoadingScreen Class
function LoadingScreen:Create(options)
    -- Merge custom options
    if options then
        for category, settings in pairs(options) do
            if CONFIG[category] then
                for key, value in pairs(settings) do
                    CONFIG[category][key] = value
                end
            end
        end
    end
    
    -- Error handling wrapper
    local success, result = pcall(function()
        return self:_createInternal()
    end)
    
    if not success then
        warn("[LoadingScreen] Error:", result)
        return false
    end
    
    return result
end

-- Internal creation function
function LoadingScreen:_createInternal()
    local loadingData = {
        Gui = nil,
        Connections = {},
        Particles = {},
        IsDestroyed = false
    }
    
    -- Helper untuk cleanup
    local function safeDisconnect(connection)
        if connection and typeof(connection) == "RBXScriptConnection" then
            connection:Disconnect()
        end
    end
    
    local function addConnection(connection)
        table.insert(loadingData.Connections, connection)
        return connection
    end
    
    -- Setup Player GUI
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
    -- Create ScreenGui dengan ZIndex tinggi
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "SynceLoadingScreen"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    LoadingGui.DisplayOrder = 9999
    LoadingGui.IgnoreGuiInset = true
    
    loadingData.Gui = LoadingGui
    
    -- Background dengan gradient animasi
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = CONFIG.THEME.SECONDARY
    Background.BorderSizePixel = 0
    Background.BackgroundTransparency = 1 -- Start transparent
    Background.Parent = LoadingGui
    
    -- Animated Gradient
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, CONFIG.THEME.SECONDARY),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(25, 25, 30)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(22, 22, 27)),
        ColorSequenceKeypoint.new(1, CONFIG.THEME.SECONDARY)
    }
    Gradient.Rotation = 135
    Gradient.Parent = Background
    
    -- Skip Button (opsional)
    local SkipButton = Instance.new("TextButton")
    SkipButton.Name = "SkipButton"
    SkipButton.Size = UDim2.new(0, 100, 0, 30)
    SkipButton.Position = UDim2.new(1, -110, 1, -40)
    SkipButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    SkipButton.BackgroundTransparency = 0.7
    SkipButton.TextColor3 = CONFIG.THEME.TEXT_SECONDARY
    SkipButton.Text = "SKIP"
    SkipButton.TextSize = 12
    SkipButton.Font = Enum.Font.Gotham
    SkipButton.AutoButtonColor = false
    SkipButton.Visible = false -- Default hidden
    SkipButton.Parent = Background
    
    local SkipCorner = Instance.new("UICorner")
    SkipCorner.CornerRadius = UDim.new(0, 4)
    SkipCorner.Parent = SkipButton
    
    -- Particle system dengan performance awareness
    local function createParticles()
        local particleCount = CONFIG.PERFORMANCE.PARTICLE_COUNT_MEDIUM
        if CONFIG.PERFORMANCE.MOBILE_MODE then
            particleCount = CONFIG.PERFORMANCE.PARTICLE_COUNT_LOW
        elseif settings().Rendering.QualityLevel >= 10 then
            particleCount = CONFIG.PERFORMANCE.PARTICLE_COUNT_HIGH
        end
        
        for i = 1, particleCount do
            local Particle = Instance.new("Frame")
            Particle.Name = "Particle" .. i
            Particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
            Particle.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
            Particle.BackgroundColor3 = CONFIG.THEME.PRIMARY
            Particle.BackgroundTransparency = math.random(50, 80) / 100
            Particle.BorderSizePixel = 0
            Particle.ZIndex = 1
            Particle.Parent = Background
            
            local ParticleCorner = Instance.new("UICorner")
            ParticleCorner.CornerRadius = UDim.new(1, 0)
            ParticleCorner.Parent = Particle
            
            table.insert(loadingData.Particles, Particle)
            
            -- Optimized particle animation menggunakan Heartbeat
            local particleConnection
            local function animateParticle()
                if not Particle.Parent or loadingData.IsDestroyed then
                    safeDisconnect(particleConnection)
                    return
                end
                
                local duration = math.random(3, 6)
                local targetX = math.random(0, 100) / 100
                local targetY = math.random(0, 100) / 100
                
                TweenService:Create(Particle, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
                    Position = UDim2.new(targetX, 0, targetY, 0)
                }):Play()
                
                task.wait(duration)
            end
            
            -- Start animation di thread terpisah
            task.spawn(function()
                while Particle.Parent and not loadingData.IsDestroyed do
                    animateParticle()
                    if loadingData.IsDestroyed then break end
                end
            end)
        end
    end
    
    -- Main Container dengan responsive design
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.Size = UDim2.new(0, 400, 0, 250)
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.BackgroundTransparency = 1
    Container.Parent = Background
    
    -- Responsive scaling untuk mobile
    if CONFIG.PERFORMANCE.MOBILE_MODE then
        Container.Size = UDim2.new(0, 320, 0, 200)
    end
    
    -- Title dengan efek glow
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = CONFIG.CONTENT.TITLE
    Title.TextColor3 = CONFIG.THEME.TEXT_PRIMARY
    Title.TextSize = CONFIG.PERFORMANCE.MOBILE_MODE and 28 or 32
    Title.Font = Enum.Font.GothamBold
    Title.TextTransparency = 1
    Title.TextStrokeTransparency = 0.8
    Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    Title.Parent = Container
    
    -- Subtitle
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Size = UDim2.new(1, 0, 0, 30)
    Subtitle.Position = UDim2.new(0, 0, 0, 55)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = CONFIG.CONTENT.SUBTITLE
    Subtitle.TextColor3 = CONFIG.THEME.TEXT_SECONDARY
    Subtitle.TextSize = CONFIG.PERFORMANCE.MOBILE_MODE and 16 or 18
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextTransparency = 1
    Subtitle.Parent = Container
    
    -- Loading Text
    local LoadingText = Instance.new("TextLabel")
    LoadingText.Name = "LoadingText"
    LoadingText.Size = UDim2.new(1, 0, 0, 25)
    LoadingText.Position = UDim2.new(0, 0, 0, 100)
    LoadingText.BackgroundTransparency = 1
    LoadingText.Text = "Initializing..."
    LoadingText.TextColor3 = CONFIG.THEME.TEXT_SECONDARY
    LoadingText.TextSize = CONFIG.PERFORMANCE.MOBILE_MODE and 14 or 15
    LoadingText.Font = Enum.Font.Gotham
    LoadingText.TextTransparency = 1
    LoadingText.Parent = Container
    
    -- Percentage Text
    local PercentText = Instance.new("TextLabel")
    PercentText.Name = "PercentText"
    PercentText.Size = UDim2.new(1, 0, 0, 30)
    PercentText.Position = UDim2.new(0, 0, 0, 130)
    PercentText.BackgroundTransparency = 1
    PercentText.Text = "0%"
    PercentText.TextColor3 = CONFIG.THEME.PRIMARY
    PercentText.TextSize = CONFIG.PERFORMANCE.MOBILE_MODE and 18 or 20
    PercentText.Font = Enum.Font.GothamBold
    PercentText.TextTransparency = 1
    PercentText.Parent = Container
    
    -- Loading Bar Background
    local BarBackground = Instance.new("Frame")
    BarBackground.Name = "BarBackground"
    BarBackground.Size = UDim2.new(0.8, 0, 0, 6)
    BarBackground.AnchorPoint = Vector2.new(0.5, 0)
    BarBackground.Position = UDim2.new(0.5, 0, 0, 175)
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
    BarFill.BackgroundColor3 = CONFIG.THEME.PRIMARY
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
    BarGradient.Offset = Vector2.new(-1, 0)
    BarGradient.Parent = BarFill
    
    -- Version Text
    local VersionText = Instance.new("TextLabel")
    VersionText.Name = "VersionText"
    VersionText.Size = UDim2.new(1, 0, 0, 20)
    VersionText.Position = UDim2.new(0, 0, 1, -30)
    VersionText.BackgroundTransparency = 1
    VersionText.Text = CONFIG.CONTENT.VERSION
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
    CreditsText.Text = CONFIG.CONTENT.CREDITS
    CreditsText.TextColor3 = Color3.fromRGB(80, 80, 85)
    CreditsText.TextSize = 11
    CreditsText.Font = Enum.Font.Gotham
    CreditsText.Parent = Background
    
    -- Parent GUI setelah semua element dibuat
    LoadingGui.Parent = PlayerGui
    
    -- Animation Functions
    local function fadeIn(object, duration, property)
        property = property or "TextTransparency"
        TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            [property] = 0
        }):Play()
    end
    
    local function fadeOut(object, duration, property)
        property = property or "TextTransparency"
        TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            [property] = 1
        }):Play()
    end
    
    -- Gradient Animation
    local gradientAnimationConnection
    local function animateGradient()
        gradientAnimationConnection = addConnection(RunService.Heartbeat:Connect(function(deltaTime)
            Gradient.Rotation = Gradient.Rotation + (10 * deltaTime)
            if Gradient.Rotation >= 360 then
                Gradient.Rotation = 0
            end
        end))
    end
    
    -- Bar Gradient Animation
    local barGradientAnimationConnection
    local function animateBarGradient()
        barGradientAnimationConnection = addConnection(RunService.Heartbeat:Connect(function(deltaTime)
            local currentOffset = BarGradient.Offset
            BarGradient.Offset = Vector2.new(currentOffset.X + (0.5 * deltaTime), currentOffset.Y)
            if BarGradient.Offset.X >= 1 then
                BarGradient.Offset = Vector2.new(-1, 0)
            end
        end))
    end
    
    -- Preload assets untuk performance
    local function preloadAssets()
        ContentProvider:PreloadAsync({
            "rbxasset://fonts/GothamBold.ttf",
            "rbxasset://fonts/Gotham.ttf"
        })
    end
    
    -- Skip functionality
    local skipRequested = false
    addConnection(SkipButton.MouseButton1Click:Connect(function()
        skipRequested = true
        SkipButton.Visible = false
    end))
    
    -- Main loading sequence
    local function runLoadingSequence()
        -- Step 1: Initial fade in
        fadeIn(Background, 0.3, "BackgroundTransparency")
        task.wait(CONFIG.TIMING.FADE_IN_DELAY)
        
        -- Step 2: Create particles
        createParticles()
        
        -- Step 3: Start animations
        animateGradient()
        animateBarGradient()
        
        -- Step 4: Fade in text elements
        fadeIn(Title, 0.5)
        task.wait(0.2)
        fadeIn(Subtitle, 0.4)
        task.wait(0.1)
        fadeIn(LoadingText, 0.3)
        fadeIn(PercentText, 0.3)
        
        -- Step 5: Show skip button after 1 second
        task.wait(1)
        if not skipRequested then
            SkipButton.Visible = true
            fadeIn(SkipButton, 0.3, "BackgroundTransparency")
        end
        
        -- Step 6: Progress through stages
        local totalStages = #CONFIG.CONTENT.STAGES
        local completedStages = 0
        
        for i, stage in ipairs(CONFIG.CONTENT.STAGES) do
            if skipRequested then break end
            
            LoadingText.Text = stage.text
            
            -- Animate progress bar
            local targetWidth = stage.percent / 100
            local targetSize = UDim2.new(targetWidth, 0, 1, 0)
            
            TweenService:Create(BarFill, TweenInfo.new(stage.duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = targetSize
            }):Play()
            
            -- Animate percentage counter
            local startPercent = (i - 1) * (100 / totalStages)
            local endPercent = stage.percent
            local steps = 10
            local increment = (endPercent - startPercent) / steps
            
            for j = 1, steps do
                if skipRequested then break end
                
                local currentPercent = math.floor(startPercent + (increment * j))
                PercentText.Text = currentPercent .. "%"
                
                -- Check for skip setiap frame
                task.wait(stage.duration / steps)
            end
            
            completedStages = i
            if skipRequested then break end
        end
        
        -- Step 7: Completion
        if skipRequested then
            LoadingText.Text = "Skipping..."
            PercentText.Text = "100%"
            BarFill.Size = UDim2.new(1, 0, 1, 0)
        else
            LoadingText.Text = "Complete! ✓"
            PercentText.Text = "100%"
        end
        
        TweenService:Create(LoadingText, TweenInfo.new(0.3), {
            TextColor3 = CONFIG.THEME.SUCCESS
        }):Play()
        
        task.wait(CONFIG.TIMING.COMPLETION_DELAY)
        
        -- Step 8: Fade out
        local fadeOutTweens = {}
        
        table.insert(fadeOutTweens, TweenService:Create(Background, TweenInfo.new(
            CONFIG.TIMING.FADE_OUT_DURATION, 
            Enum.EasingStyle.Quad, 
            Enum.EasingDirection.In
        ), {
            BackgroundTransparency = 1
        }))
        
        for _, obj in pairs(Container:GetDescendants()) do
            if obj:IsA("TextLabel") then
                table.insert(fadeOutTweens, TweenService:Create(obj, TweenInfo.new(
                    CONFIG.TIMING.FADE_OUT_DURATION
                ), {
                    TextTransparency = 1
                }))
            elseif obj:IsA("Frame") and obj ~= BarFill then
                table.insert(fadeOutTweens, TweenService:Create(obj, TweenInfo.new(
                    CONFIG.TIMING.FADE_OUT_DURATION
                ), {
                    BackgroundTransparency = 1
                }))
            end
        end
        
        fadeOut(VersionText, CONFIG.TIMING.FADE_OUT_DURATION)
        fadeOut(CreditsText, CONFIG.TIMING.FADE_OUT_DURATION)
        
        -- Play all fade out tweens
        for _, tween in ipairs(fadeOutTweens) do
            tween:Play()
        end
        
        task.wait(CONFIG.TIMING.FADE_OUT_DURATION + 0.1)
        
        -- Cleanup
        loadingData.IsDestroyed = true
        
        for _, conn in ipairs(loadingData.Connections) do
            safeDisconnect(conn)
        end
        
        for _, particle in ipairs(loadingData.Particles) do
            particle:Destroy()
        end
        
        LoadingGui:Destroy()
        
        return {
            skipped = skipRequested,
            completedStages = completedStages,
            totalStages = totalStages
        }
    end
    
    -- Start preloading dan loading sequence
    preloadAssets()
    return runLoadingSequence()
end

-- Function untuk update config secara dinamis
function LoadingScreen:UpdateConfig(newConfig)
    for category, settings in pairs(newConfig) do
        if CONFIG[category] then
            for key, value in pairs(settings) do
                CONFIG[category][key] = value
            end
        end
    end
end

-- Function untuk mendapatkan config saat ini
function LoadingScreen:GetConfig()
    return table.clone(CONFIG)
end

return LoadingScreen