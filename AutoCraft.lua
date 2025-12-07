-- Modern Game Automation UI
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerStatsFolder = nil
local settingsFolder = nil

-- Wait for game data
task.spawn(function()
    local stats = ReplicatedStorage:WaitForChild("Stats", 10)
    if not stats then return end
    playerStatsFolder = stats:WaitForChild(player.Name, 10)
    if not playerStatsFolder then return end
    settingsFolder = playerStatsFolder:WaitForChild("Settings", 10)
end)

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernAutomationUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame with modern gradient
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 450, 0, 580)
Main.Position = UDim2.new(0.5, -225, 0.5, -290)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

-- Gradient overlay
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
Gradient.Rotation = 45
Gradient.Parent = Main

-- Glow effect
local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.Size = UDim2.new(1, 40, 1, 40)
Glow.Position = UDim2.new(0.5, -20, 0.5, -20)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Color3.fromRGB(100, 150, 255)
Glow.ImageTransparency = 0.8
Glow.ZIndex = 0
Glow.Parent = Main

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 60)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Automation Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 300, 0, 20)
Subtitle.Position = UDim2.new(0, 20, 0, 35)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Advanced Game Controls"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 12
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 170)
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -100, 0, 10)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
MinimizeBtn.Text = "–"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 24
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Parent = TopBar

local MinimizeBtnCorner = Instance.new("UICorner")
MinimizeBtnCorner.CornerRadius = UDim.new(0, 8)
MinimizeBtnCorner.Parent = MinimizeBtn

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = TopBar

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 8)
CloseBtnCorner.Parent = CloseBtn


-- ⭐ REMOVED the old minimize code here (it referenced ScrollFrame before creation)


-- Scroll Frame for content
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -30, 1, -80)
ScrollFrame.Position = UDim2.new(0, 15, 0, 70)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = ScrollFrame


-- ⭐ FIXED MINIMIZE SYSTEM (correct placement)
local isMinimized = false
local normalSize = UDim2.new(0, 450, 0, 580)
local minimizedSize = UDim2.new(0, 450, 0, 60)

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized

    TweenService:Create(Main, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {
        Size = isMinimized and minimizedSize or normalSize
    }):Play()

    ScrollFrame.Visible = not isMinimized
    MinimizeBtn.Text = isMinimized and "+" or "–"
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)



-- Helper Functions
local function CreateSection(name)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, -10, 0, 40)
    Section.BackgroundTransparency = 1
    Section.Parent = ScrollFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "▶ " .. name
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.TextColor3 = Color3.fromRGB(100, 150, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section
    
    return Section
end

local function CreateToggle(name, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, -10, 0, 50)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    Toggle.BorderSizePixel = 0
    Toggle.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Toggle
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.Font = Enum.Font.GothamSemibold
    ToggleLabel.TextSize = 14
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = Toggle
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 30)
    ToggleButton.Position = UDim2.new(1, -60, 0.5, -15)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    ToggleButton.Text = ""
    ToggleButton.Parent = Toggle
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0)
    BtnCorner.Parent = ToggleButton
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 22, 0, 22)
    Indicator.Position = UDim2.new(0, 4, 0.5, -11)
    Indicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Indicator.Parent = ToggleButton
    
    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = Indicator
    
    local isEnabled = false
    
    ToggleButton.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        
        if isEnabled then
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 200, 100)}):Play()
            TweenService:Create(Indicator, TweenInfo.new(0.2), {Position = UDim2.new(1, -26, 0.5, -11), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}):Play()
            TweenService:Create(Indicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 4, 0.5, -11), BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        end
        
        callback(isEnabled)
    end)
    
    return {Toggle = isEnabled, SetState = function(state)
        isEnabled = state
        if isEnabled then
            ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            Indicator.Position = UDim2.new(1, -26, 0.5, -11)
            Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
            Indicator.Position = UDim2.new(0, 4, 0.5, -11)
            Indicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        end
    end}
end

local function CreateButton(name, desc, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 60)
    Button.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    local ButtonLabel = Instance.new("TextLabel")
    ButtonLabel.Size = UDim2.new(1, -20, 0, 25)
    ButtonLabel.Position = UDim2.new(0, 10, 0, 8)
    ButtonLabel.BackgroundTransparency = 1
    ButtonLabel.Text = name
    ButtonLabel.Font = Enum.Font.GothamBold
    ButtonLabel.TextSize = 15
    ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
    ButtonLabel.Parent = Button
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 20)
    DescLabel.Position = UDim2.new(0, 10, 0, 33)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = desc
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 12
    DescLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 120, 220)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 100, 200)}):Play()
    end)
    
    return {UpdateText = function(newDesc) DescLabel.Text = newDesc end}
end

-- Storage for original values
local originalValues = {}
local function StoreOriginalValue(path, valueName)
    task.spawn(function()
        local obj = path:WaitForChild(valueName, 10)
        if obj then
            originalValues[valueName] = obj.Value
        end
    end)
end

task.spawn(function()
    repeat task.wait() until settingsFolder
    if settingsFolder then
        StoreOriginalValue(settingsFolder, "AutoRebirth")
        StoreOriginalValue(settingsFolder, "AutoTrain")
    end
end)

-- Create UI Elements
CreateSection("Core Features")

CreateToggle("Auto Rebirth", function(state)
    if not settingsFolder then return end
    local setting = settingsFolder:FindFirstChild("AutoRebirth")
    if setting then setting.Value = state end
end)

CreateToggle("Auto Train", function(state)
    if not settingsFolder then return end
    local setting = settingsFolder:FindFirstChild("AutoTrain")
    if setting then setting.Value = state end
end)

-- Egg Hatch Speed with visible selection
local speeds = {"OFF", 1.2, 2, 4, 6, 8}
local currentSpeedIndex = 1
local speedButtonObj = nil

speedButtonObj = CreateButton("Egg Hatch Speed (1.2x is the fast hatch pass)", "Current: OFF - Click to cycle", function()
    task.spawn(function()
        task.wait(0.1) -- Small delay to ensure stats are loaded
        local stats = ReplicatedStorage:WaitForChild("Stats", 5)
        if not stats then 
            warn("Stats not found")
            return 
        end
        
        local playerStats = stats:FindFirstChild(player.Name)
        if not playerStats then 
            warn("Player stats not found")
            return 
        end
        
        local eggStats = playerStats:FindFirstChild("EggStats")
        if not eggStats then
            warn("EggStats not found")
            return
        end
        
        local hatchSpeed = eggStats:FindFirstChild("HatchSpeed")
        if not hatchSpeed then
            warn("HatchSpeed not found")
            return
        end
        
        if hatchSpeed:IsA("NumberValue") then
            currentSpeedIndex = currentSpeedIndex % #speeds + 1
            local speed = speeds[currentSpeedIndex]
            
            if speed == "OFF" then
                hatchSpeed.Value = 1
                if speedButtonObj and speedButtonObj.UpdateText then
                    speedButtonObj.UpdateText("Current: OFF - Click to cycle")
                end
            else
                hatchSpeed.Value = speed
                if speedButtonObj and speedButtonObj.UpdateText then
                    speedButtonObj.UpdateText("Current: " .. tostring(speed) .. "x - Click to cycle")
                end
            end
            
            print("Egg Hatch Speed set to:", speed == "OFF" and 1 or speed)
        else
            warn("HatchSpeed is not a NumberValue")
        end
    end)
end)

CreateSection("Premium Features")

task.spawn(function()
    local analytics = ReplicatedStorage.Stats:WaitForChild(player.Name, 10)
    if analytics then
        analytics = analytics:WaitForChild("Analytics", 10)
        if analytics then
            local premium = analytics:WaitForChild("IsPremium", 10)
            if premium then
                CreateToggle("Premium Status", function(state)
                    if premium then premium.Value = state end
                end)
            end
            
            local inGroup = analytics:WaitForChild("IsInGroup", 10)
            if inGroup then
                CreateToggle("In Group Status", function(state)
                    if inGroup then inGroup.Value = state end
                end)
            end
        end
    end
end)

CreateSection("Automation")

local autoRewardEnabled = false
CreateToggle("Auto Reward Egg", function(state)
    autoRewardEnabled = state
    if state then
        task.spawn(function()
            local Paper = ReplicatedStorage:WaitForChild("Paper")
            while autoRewardEnabled do
                task.wait(1)
                pcall(function()
                    local rewardTimer = ReplicatedStorage:FindFirstChild("Stats")
                    if rewardTimer then
                        rewardTimer = rewardTimer:FindFirstChild(player.Name)
                        if rewardTimer then
                            rewardTimer = rewardTimer:FindFirstChild("RewardTimer")
                            if rewardTimer and rewardTimer.Value == 0 then
                                require(Paper).Network.InvokeServer("Claim Time Reward")
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

local miningSpeedEnabled = false
CreateToggle("Mining Speed Boost (2x)", function(state)
    miningSpeedEnabled = state
    local boost = ReplicatedStorage.Stats:FindFirstChild(player.Name)
    if boost then
        boost = boost:FindFirstChild("MiningSpeedBoost")
        if boost and boost:IsA("NumberValue") then
            boost.Value = state and 2 or 1
        end
    end
end)

local autoGoldenEnabled = false
CreateToggle("Auto Golden Pets", function(state)
    autoGoldenEnabled = state
    if state then
        task.spawn(function()
            local Paper = ReplicatedStorage:WaitForChild("Paper")
            while autoGoldenEnabled do
                task.wait(2)
                pcall(function()
                    local pets = ReplicatedStorage.Stats:FindFirstChild(player.Name)
                    if pets then
                        pets = pets:FindFirstChild("Pets")
                        if pets then
                            local petCounts = {}
                            for _, pet in pairs(pets:GetChildren()) do
                                local petName = pet:GetAttribute("PetName")
                                local tier = pet:GetAttribute("Tier")
                                local locked = pet:GetAttribute("Locked")
                                if petName and tier == 1 and not locked then
                                    if not petCounts[petName] then
                                        petCounts[petName] = {count = 0, pets = {}}
                                    end
                                    petCounts[petName].count = petCounts[petName].count + 1
                                    table.insert(petCounts[petName].pets, pet.Name)
                                end
                            end
                            for petName, data in pairs(petCounts) do
                                if data.count >= 8 then
                                    local craftPets = {}
                                    for i = 1, 8 do
                                        table.insert(craftPets, data.pets[i])
                                    end
                                    require(Paper).Network.InvokeServer("Pet", {
                                        ["Action"] = "CraftGolden",
                                        ["Pets"] = craftPets
                                    })
                                    break
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

local autoRainbowEnabled = false
CreateToggle("Auto Rainbow Pets", function(state)
    autoRainbowEnabled = state
    if state then
        task.spawn(function()
            local Paper = ReplicatedStorage:WaitForChild("Paper")
            while autoRainbowEnabled do
                task.wait(2)
                pcall(function()
                    local pets = ReplicatedStorage.Stats:FindFirstChild(player.Name)
                    if pets then
                        pets = pets:FindFirstChild("Pets")
                        if pets then
                            local petCounts = {}
                            for _, pet in pairs(pets:GetChildren()) do
                                local petName = pet:GetAttribute("PetName")
                                local tier = pet:GetAttribute("Tier")
                                local locked = pet:GetAttribute("Locked")
                                if petName and tier == 2 and not locked then
                                    if not petCounts[petName] then
                                        petCounts[petName] = {count = 0, pets = {}}
                                    end
                                    petCounts[petName].count = petCounts[petName].count + 1
                                    table.insert(petCounts[petName].pets, pet.Name)
                                end
                            end
                            for petName, data in pairs(petCounts) do
                                if data.count >= 8 then
                                    local craftPets = {}
                                    for i = 1, 8 do
                                        table.insert(craftPets, data.pets[i])
                                    end
                                    require(Paper).Network.InvokeServer("Pet", {
                                        ["Action"] = "CraftRainbow",
                                        ["Pets"] = craftPets
                                    })
                                    break
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

CreateSection("Ore Management")

local autoLockEnabled = false
CreateToggle("Auto Lock Burnables", function(state)
    autoLockEnabled = state
    if state then
        task.spawn(function()
            local Paper = ReplicatedStorage:WaitForChild("Paper")
            local OresTable = require(ReplicatedStorage:WaitForChild("Tables"):WaitForChild("Ores"))
            while autoLockEnabled do
                task.wait(1)
                pcall(function()
                    local ores = ReplicatedStorage.Stats:FindFirstChild(player.Name)
                    if ores then
                        ores = ores:FindFirstChild("Ores")
                        if ores then
                            for _, ore in pairs(ores:GetChildren()) do
                                local oreId = tonumber(ore.Name)
                                local oreData = OresTable[oreId]
                                if oreData and oreData.BurnTime and not ore:GetAttribute("Locked") then
                                    require(Paper).Network.FireServer("Lock Ore", oreId)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

CreateSection("Chest Automation")

local autoChestEnabled = false
CreateToggle("Auto Claim Chests", function(state)
    autoChestEnabled = state
    if state then
        task.spawn(function()
            local Paper = ReplicatedStorage:WaitForChild("Paper")
            local TimedChests = require(Paper).Instanceless.Get("TimedChests")
            
            while autoChestEnabled do
                task.wait(5)
                pcall(function()
                    local chests = {"DailyChest", "GroupChest"}
                    for _, chestName in ipairs(chests) do
                        local chestTime = TimedChests.Value[chestName]
                        local timeLeft = 0
                        if chestTime then
                            timeLeft = math.max(chestTime - require(Paper).Misc.GetUnixTime(), 0)
                        end
                        if timeLeft == 0 then
                            require(Paper).Network.InvokeServer("Claim Chest", chestName)
                            print("Auto claimed:", chestName)
                            task.wait(1)
                        end
                    end
                end)
            end
        end)
    end
end)

print("✅ Modern Automation UI Loaded!")