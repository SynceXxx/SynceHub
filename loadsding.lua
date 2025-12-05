-- SynceScriptHub | Modern Loading Screen v2.1
-- Fish Shape Design (Like Roblox MODDED)
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
    
    -- Background
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = Color3.fromRGB(85, 140, 180) -- Sky blue like the image
    Background.BorderSizePixel = 0
    Background.Parent = LoadingGui
    
    -- Main Container
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(0, 600, 0, 500)
    Container.Position = UDim2.new(0.5, -300, 0.5, -250)
    Container.BackgroundTransparency = 1
    Container.Parent = Background
    
    -- Fish Body (Main oval shape)
    local FishBody = Instance.new("Frame")
    FishBody.Name = "FishBody"
    FishBody.Size = UDim2.new(0, 280, 0, 200)
    FishBody.Position = UDim2.new(0.5, -140, 0, 50)
    FishBody.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FishBody.BorderSizePixel = 0
    FishBody.Parent = Container
    
    local FishBodyCorner = Instance.new("UICorner")
    FishBodyCorner.CornerRadius = UDim.new(0.5, 0)
    FishBodyCorner.Parent = FishBody
    
    -- Fish Tail (Triangle-ish shape using rotation)
    local FishTail = Instance.new("Frame")
    FishTail.Name = "FishTail"
    FishTail.Size = UDim2.new(0, 100, 0, 120)
    FishTail.Position = UDim2.new(0, 240, 0, 90)
    FishTail.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FishTail.BorderSizePixel = 0
    FishTail.Rotation = 45
    FishTail.Parent = Container
    
    local TailCorner = Instance.new("UICorner")
    TailCorner.CornerRadius = UDim.new(0.3, 0)
    TailCorner.Parent = FishTail
    
    -- Fish Top Fin
    local TopFin = Instance.new("Frame")
    TopFin.Name = "TopFin"
    TopFin.Size = UDim2.new(0, 60, 0, 80)
    TopFin.Position = UDim2.new(0.5, -30, 0, 0)
    TopFin.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TopFin.BorderSizePixel = 0
    TopFin.Rotation = -10
    TopFin.Parent = Container
    
    local TopFinCorner = Instance.new("UICorner")
    TopFinCorner.CornerRadius = UDim.new(0.4, 0)
    TopFinCorner.Parent = TopFin
    
    -- Fish Bottom Fin
    local BottomFin = Instance.new("Frame")
    BottomFin.Name = "BottomFin"
    BottomFin.Size = UDim2.new(0, 50, 0, 70)
    BottomFin.Position = UDim2.new(0.5, -80, 0, 220)
    BottomFin.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BottomFin.BorderSizePixel = 0
    BottomFin.Rotation = 20
    BottomFin.Parent = Container
    
    local BottomFinCorner = Instance.new("UICorner")
    BottomFinCorner.CornerRadius = UDim.new(0.4, 0)
    BottomFinCorner.Parent = BottomFin
    
    -- Question Mark on Fish Body
    local QuestionMark = Instance.new("TextLabel")
    QuestionMark.Name = "QuestionMark"
    QuestionMark.Size = UDim2.new(0, 150, 0, 150)
    QuestionMark.Position = UDim2.new(0.5, -75, 0, 75)
    QuestionMark.BackgroundTransparency = 1
    QuestionMark.Text = "?"
    QuestionMark.TextColor3 = Color3.fromRGB(85, 170, 220) -- Cyan blue
    QuestionMark.TextSize = 120
    QuestionMark.Font = Enum.Font.GothamBold
    QuestionMark.Parent = Container
    
    -- "SYNCE HUB" Text (below fish)
    local ModdedText = Instance.new("TextLabel")
    ModdedText.Name = "ModdedText"
    ModdedText.Size = UDim2.new(1, 0, 0, 80)
    ModdedText.Position = UDim2.new(0, 0, 0, 300)
    ModdedText.BackgroundTransparency = 1
    ModdedText.Text = "SYNCE HUB"
    ModdedText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ModdedText.TextSize = 56
    ModdedText.Font = Enum.Font.GothamBold
    ModdedText.TextStrokeTransparency = 0.3
    ModdedText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    ModdedText.Parent = Container
    
    -- Animated Dots Container
    local DotsContainer = Instance.new("Frame")
    DotsContainer.Name = "DotsContainer"
    DotsContainer.Size = UDim2.new(0, 150, 0, 25)
    DotsContainer.Position = UDim2.new(0.5, -75, 0, 400)
    DotsContainer.BackgroundTransparency = 1
    DotsContainer.Parent = Container
    
    -- Create 3 dots
    local dots = {}
    for i = 1, 3 do
        local dot = Instance.new("Frame")
        dot.Name = "Dot" .. i
        dot.Size = UDim2.new(0, 20, 0, 20)
        dot.Position = UDim2.new(0, (i-1) * 50 + 15, 0.5, -10)
        dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dot.BorderSizePixel = 0
        dot.Parent = DotsContainer
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
        
        table.insert(dots, dot)
    end
    
    -- Version text
    local VersionText = Instance.new("TextLabel")
    VersionText.Size = UDim2.new(0, 200, 0, 20)
    VersionText.Position = UDim2.new(0.5, -100, 1, -40)
    VersionText.BackgroundTransparency = 1
    VersionText.Text = ""
    VersionText.TextColor3 = Color3.fromRGB(255, 255, 255)
    VersionText.TextSize = 13
    VersionText.Font = Enum.Font.Gotham
    VersionText.TextTransparency = 0.3
    VersionText.Parent = Background
    
    -- Credits
    local CreditsText = Instance.new("TextLabel")
    CreditsText.Size = UDim2.new(0, 200, 0, 20)
    CreditsText.Position = UDim2.new(0.5, -100, 1, -60)
    CreditsText.BackgroundTransparency = 1
    CreditsText.Text = ""
    CreditsText.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreditsText.TextSize = 12
    CreditsText.Font = Enum.Font.Gotham
    CreditsText.TextTransparency = 0.3
    CreditsText.Parent = Background
    
    -- Floating animation for fish
    task.spawn(function()
        while LoadingGui.Parent do
            TweenService:Create(Container, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = UDim2.new(0.5, -300, 0.5, -270)
            }):Play()
            task.wait(2)
            TweenService:Create(Container, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = UDim2.new(0.5, -300, 0.5, -230)
            }):Play()
            task.wait(2)
        end
    end)
    
    -- Animate dots (loading indicator)
    task.spawn(function()
        while LoadingGui.Parent do
            for i, dot in ipairs(dots) do
                task.spawn(function()
                    task.wait((i-1) * 0.15)
                    while LoadingGui.Parent do
                        TweenService:Create(dot, TweenInfo.new(0.3), {
                            Size = UDim2.new(0, 25, 0, 25),
                            BackgroundTransparency = 0
                        }):Play()
                        task.wait(0.3)
                        TweenService:Create(dot, TweenInfo.new(0.3), {
                            Size = UDim2.new(0, 20, 0, 20),
                            BackgroundTransparency = 0.3
                        }):Play()
                        task.wait(0.6)
                    end
                end)
            end
            task.wait(0.9)
        end
    end)
    
    -- Initial fade in
    Container.Position = UDim2.new(0.5, -300, 0.5, -300)
    for _, part in pairs({FishBody, FishTail, TopFin, BottomFin}) do
        part.BackgroundTransparency = 1
    end
    QuestionMark.TextTransparency = 1
    ModdedText.TextTransparency = 1
    
    task.wait(0.1)
    
    -- Fade in fish
    TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -300, 0.5, -250)
    }):Play()
    
    for _, part in pairs({FishBody, FishTail, TopFin, BottomFin}) do
        TweenService:Create(part, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
    end
    TweenService:Create(QuestionMark, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(0.3)
    TweenService:Create(ModdedText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    
    -- Wait for loading
    task.wait(1.5)
    
    -- Fade out
    TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Container, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -300, 0.5, -200)}):Play()
    
    for _, part in pairs({FishBody, FishTail, TopFin, BottomFin}) do
        TweenService:Create(part, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    TweenService:Create(QuestionMark, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(ModdedText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(VersionText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(CreditsText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    for _, dot in ipairs(dots) do
        TweenService:Create(dot, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    
    task.wait(0.6)
    LoadingGui:Destroy()
end

return LoadingScreen