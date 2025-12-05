-- SynceScriptHub | Modern Loading Screen v2.0
-- Inspired Design with Custom Theme
-- Created by SynceXxx

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
    
    -- Background with gradient
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Background.BorderSizePixel = 0
    Background.Parent = LoadingGui
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
    }
    Gradient.Rotation = 45
    Gradient.Parent = Background
    
    -- Animated gradient rotation
    task.spawn(function()
        while LoadingGui.Parent do
            TweenService:Create(Gradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                Rotation = Gradient.Rotation + 360
            }):Play()
            task.wait(3)
        end
    end)
    
    -- Main Container
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(0, 500, 0, 400)
    Container.Position = UDim2.new(0.5, -250, 0.5, -200)
    Container.BackgroundTransparency = 1
    Container.Parent = Background
    
    -- Logo/Icon Container (Fish Shape Alternative - Using Star/Shield)
    local IconFrame = Instance.new("Frame")
    IconFrame.Name = "IconFrame"
    IconFrame.Size = UDim2.new(0, 180, 0, 180)
    IconFrame.Position = UDim2.new(0.5, -90, 0, 0)
    IconFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    IconFrame.BorderSizePixel = 0
    IconFrame.Parent = Container
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(1, 0)
    IconCorner.Parent = IconFrame
    
    local IconStroke = Instance.new("UIStroke")
    IconStroke.Color = Color3.fromRGB(100, 100, 255)
    IconStroke.Thickness = 4
    IconStroke.Parent = IconFrame
    
    -- Icon Gradient
    local IconGradient = Instance.new("UIGradient")
    IconGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 200))
    }
    IconGradient.Rotation = 90
    IconGradient.Parent = IconFrame
    
    -- Animated icon gradient
    task.spawn(function()
        while LoadingGui.Parent do
            TweenService:Create(IconGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Rotation = IconGradient.Rotation + 360
            }):Play()
            task.wait(2)
        end
    end)
    
    -- Icon Symbol (S for Synce)
    local IconText = Instance.new("TextLabel")
    IconText.Size = UDim2.new(1, 0, 1, 0)
    IconText.BackgroundTransparency = 1
    IconText.Text = "S"
    IconText.TextColor3 = Color3.fromRGB(100, 100, 255)
    IconText.TextSize = 100
    IconText.Font = Enum.Font.GothamBold
    IconText.TextTransparency = 1
    IconText.Parent = IconFrame
    
    -- Question mark alternative (if you want like the image)
    local QuestionMark = Instance.new("TextLabel")
    QuestionMark.Size = UDim2.new(1, 0, 1, 0)
    QuestionMark.BackgroundTransparency = 1
    QuestionMark.Text = "?"
    QuestionMark.TextColor3 = Color3.fromRGB(100, 200, 255)
    QuestionMark.TextSize = 120
    QuestionMark.Font = Enum.Font.GothamBold
    QuestionMark.TextTransparency = 1
    QuestionMark.Visible = false -- Change to true if you want ?
    QuestionMark.Parent = IconFrame
    
    -- Pulsing animation for icon
    task.spawn(function()
        while LoadingGui.Parent do
            TweenService:Create(IconFrame, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 190, 0, 190)
            }):Play()
            task.wait(1.5)
            TweenService:Create(IconFrame, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 180, 0, 180)
            }):Play()
            task.wait(1.5)
        end
    end)
    
    -- "MODDED" Text or "SYNCE HUB" Text
    local ModdedText = Instance.new("TextLabel")
    ModdedText.Name = "ModdedText"
    ModdedText.Size = UDim2.new(1, 0, 0, 80)
    ModdedText.Position = UDim2.new(0, 0, 0, 200)
    ModdedText.BackgroundTransparency = 1
    ModdedText.Text = "SYNCE HUB"
    ModdedText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ModdedText.TextSize = 48
    ModdedText.Font = Enum.Font.GothamBold
    ModdedText.TextStrokeTransparency = 0.5
    ModdedText.TextStrokeColor3 = Color3.fromRGB(100, 100, 255)
    ModdedText.TextTransparency = 1
    ModdedText.Parent = Container
    
    -- Subtitle
    local SubText = Instance.new("TextLabel")
    SubText.Name = "SubText"
    SubText.Size = UDim2.new(1, 0, 0, 30)
    SubText.Position = UDim2.new(0, 0, 0, 280)
    SubText.BackgroundTransparency = 1
    SubText.Text = "Youtuber Empire Hub"
    SubText.TextColor3 = Color3.fromRGB(150, 150, 180)
    SubText.TextSize = 16
    SubText.Font = Enum.Font.Gotham
    SubText.TextTransparency = 1
    SubText.Parent = Container
    
    -- Animated Dots (like in the image)
    local DotsContainer = Instance.new("Frame")
    DotsContainer.Name = "DotsContainer"
    DotsContainer.Size = UDim2.new(0, 120, 0, 20)
    DotsContainer.Position = UDim2.new(0.5, -60, 0, 330)
    DotsContainer.BackgroundTransparency = 1
    DotsContainer.Parent = Container
    
    local dots = {}
    for i = 1, 3 do
        local dot = Instance.new("Frame")
        dot.Name = "Dot" .. i
        dot.Size = UDim2.new(0, 16, 0, 16)
        dot.Position = UDim2.new(0, (i-1) * 40 + 20, 0.5, -8)
        dot.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
        dot.BorderSizePixel = 0
        dot.BackgroundTransparency = 0.7
        dot.Parent = DotsContainer
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
        
        table.insert(dots, dot)
    end
    
    -- Animate dots
    task.spawn(function()
        while LoadingGui.Parent do
            for i, dot in ipairs(dots) do
                task.spawn(function()
                    task.wait((i-1) * 0.2)
                    while LoadingGui.Parent do
                        -- Scale up
                        TweenService:Create(dot, TweenInfo.new(0.4), {
                            Size = UDim2.new(0, 20, 0, 20),
                            BackgroundTransparency = 0
                        }):Play()
                        task.wait(0.4)
                        -- Scale down
                        TweenService:Create(dot, TweenInfo.new(0.4), {
                            Size = UDim2.new(0, 16, 0, 16),
                            BackgroundTransparency = 0.7
                        }):Play()
                        task.wait(0.8)
                    end
                end)
            end
            task.wait(1.2)
        end
    end)
    
    -- Version text
    local VersionText = Instance.new("TextLabel")
    VersionText.Size = UDim2.new(0, 200, 0, 20)
    VersionText.Position = UDim2.new(0.5, -100, 1, -40)
    VersionText.BackgroundTransparency = 1
    VersionText.Text = "Version V2.1"
    VersionText.TextColor3 = Color3.fromRGB(100, 100, 120)
    VersionText.TextSize = 12
    VersionText.Font = Enum.Font.Gotham
    VersionText.Parent = Background
    
    -- Credits
    local CreditsText = Instance.new("TextLabel")
    CreditsText.Size = UDim2.new(0, 200, 0, 20)
    CreditsText.Position = UDim2.new(0.5, -100, 1, -60)
    CreditsText.BackgroundTransparency = 1
    CreditsText.Text = "Created by Synce"
    CreditsText.TextColor3 = Color3.fromRGB(100, 100, 120)
    CreditsText.TextSize = 11
    CreditsText.Font = Enum.Font.Gotham
    CreditsText.Parent = Background
    
    -- Fade in animations
    task.wait(0.1)
    
    -- Icon appears first
    IconFrame.Size = UDim2.new(0, 0, 0, 0)
    IconFrame.Position = UDim2.new(0.5, 0, 0, 90)
    TweenService:Create(IconFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 180, 0, 180),
        Position = UDim2.new(0.5, -90, 0, 0)
    }):Play()
    TweenService:Create(IconText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    
    task.wait(0.3)
    
    -- Text appears
    TweenService:Create(ModdedText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(0.2)
    TweenService:Create(SubText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    
    -- Loading simulation (1.5 seconds)
    task.wait(1.5)
    
    -- Fade out everything
    TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IconFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IconStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    TweenService:Create(IconText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(ModdedText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(SubText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(VersionText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(CreditsText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    for _, dot in ipairs(dots) do
        TweenService:Create(dot, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    
    task.wait(0.6)
    LoadingGui:Destroy()
end

return LoadingScreen