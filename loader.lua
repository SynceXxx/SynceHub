-- SynceScriptHub | Main Loader
-- Usage: loadstring(game:HttpGet('https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/loader.lua'))()

print("🚀 SynceScriptHub Loader Starting...")

-- Custom Notification Function (matching hub style)
local function showCustomNotif(title, message, duration)
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
    -- Create notification GUI
    local NotifGui = Instance.new("ScreenGui")
    NotifGui.Name = "SynceNotification"
    NotifGui.ResetOnSpawn = false
    NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotifGui.DisplayOrder = 9999
    NotifGui.Parent = PlayerGui
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 0, 0, 0)
    NotifFrame.Position = UDim2.new(1, -210, 0, 10)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.BackgroundTransparency = 1
    NotifFrame.Parent = NotifGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = NotifFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(60, 60, 70)
    Stroke.Thickness = 1
    Stroke.Transparency = 1
    Stroke.Parent = NotifFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -16, 0, 20)
    TitleLabel.Position = UDim2.new(0, 8, 0, 6)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title .. " - " .. message
    TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    TitleLabel.TextSize = 11
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextWrapped = true
    TitleLabel.TextTransparency = 1
    TitleLabel.Parent = NotifFrame
    
    -- Animate in
    TweenService:Create(NotifFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 200, 0, 40),
        BackgroundTransparency = 0.3
    }):Play()
    TweenService:Create(Stroke, TweenInfo.new(0.3), {Transparency = 0.3}):Play()
    TweenService:Create(TitleLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    
    -- Play sound
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853"
    sound.Volume = 0.3
    sound.Pitch = 1.3
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)
    
    -- Animate out
    task.delay(duration or 3, function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
        TweenService:Create(TitleLabel, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        task.wait(0.3)
        NotifGui:Destroy()
    end)
end

-- Check if already loaded
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SynceHub") then
    warn("⚠️ SynceHub is already loaded!")
    showCustomNotif("⚠️ Already Loaded", "SynceHub is already running!", 3)
    return
end

-- URLs
local LOADING_SCREEN_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/load.lua"
local MAIN_HUB_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/ming.lua"

-- Function to safely load scripts
local function safeLoad(url, name)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        print("✅ Loaded: " .. name)
        return result
    else
        warn("❌ Failed to load: " .. name)
        warn("Error: " .. tostring(result))
        return nil
    end
end

-- Load Loading Screen
print("📥 Loading Loading Screen...")
local loadingScreenCode = safeLoad(LOADING_SCREEN_URL, "Loading Screen")

if not loadingScreenCode then
    showCustomNotif("❌ Load Failed", "Failed to load Loading Screen", 5)
    return
end

-- Execute Loading Screen
local success, LoadingScreen = pcall(function()
    return loadstring(loadingScreenCode)()
end)

if not success then
    warn("❌ Failed to execute Loading Screen")
    warn("Error: " .. tostring(LoadingScreen))
    return
end

-- Start Loading Screen
print("🎬 Starting Loading Screen...")
task.spawn(function()
    pcall(function()
        LoadingScreen:Create()
    end)
end)

-- Wait a bit for loading screen to show
task.wait(0.5)

-- Load Main Hub
print("📥 Loading Main Hub...")
local mainHubCode = safeLoad(MAIN_HUB_URL, "Main Hub (ming.lua)")

if not mainHubCode then
    showCustomNotif("❌ Load Failed", "Failed to load Main Hub", 5)
    return
end

-- Wait for loading screen to finish (approximately 2.5 seconds total)
task.wait(2.5)

-- Execute Main Hub
print("🚀 Executing Main Hub...")
local hubSuccess, hubError = pcall(function()
    loadstring(mainHubCode)()
end)

if hubSuccess then
    print("✅ SynceScriptHub v1.8 Successfully Loaded!")
    print("🎮 Youtuber Empire Hub is ready!")
else
    warn("❌ Failed to execute Main Hub")
    warn("Error: " .. tostring(hubError))
    showCustomNotif("❌ Execution Failed", "Failed to run Main Hub", 5)
end