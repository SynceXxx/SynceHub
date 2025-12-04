-- SynceScriptHub | Main Loader v1.1
-- Usage: loadstring(game:HttpGet('https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/loaders.lua'))()
-- Updated: Matching notification style with ming.lua

print("🚀 SynceScriptHub Loader Starting...")

-- Hub-Style Notification Function (EXACT match with ming.lua)
local function showNotif(title, msg, duration)
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
    -- Find or create notification container
    local notifGui = PlayerGui:FindFirstChild("SynceNotifications")
    if not notifGui then
        notifGui = Instance.new("ScreenGui")
        notifGui.Name = "SynceNotifications"
        notifGui.ResetOnSpawn = false
        notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notifGui.DisplayOrder = 9999
        notifGui.IgnoreGuiInset = true
        notifGui.Parent = PlayerGui
        
        local notifContainer = Instance.new("Frame")
        notifContainer.Name = "NotificationContainer"
        notifContainer.Size = UDim2.new(0, 200, 1, 0)
        notifContainer.Position = UDim2.new(1, -210, 0, 10)
        notifContainer.BackgroundTransparency = 1
        notifContainer.ZIndex = 100
        notifContainer.Parent = notifGui
        
        local notifLayout = Instance.new("UIListLayout")
        notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
        notifLayout.Padding = UDim.new(0, 6)
        notifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        notifLayout.Parent = notifContainer
    end
    
    local notifContainer = notifGui:FindFirstChild("NotificationContainer")
    
    -- Create notification frame (EXACT style from ming.lua)
    local nf = Instance.new("Frame")
    nf.Size = UDim2.new(1, 0, 0, 0)
    nf.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    nf.BorderSizePixel = 0
    nf.ZIndex = 101
    nf.AutomaticSize = Enum.AutomaticSize.Y
    nf.BackgroundTransparency = 1
    nf.Parent = notifContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = nf
    
    local nfs = Instance.new("UIStroke")
    nfs.Color = Color3.fromRGB(60, 60, 70)
    nfs.Thickness = 1
    nfs.Transparency = 1
    nfs.Parent = nf
    
    local nt = Instance.new("TextLabel")
    nt.Size = UDim2.new(1, -16, 0, 0)
    nt.Position = UDim2.new(0, 8, 0, 6)
    nt.BackgroundTransparency = 1
    nt.Text = title .. " - " .. msg
    nt.TextColor3 = Color3.fromRGB(200, 200, 210)
    nt.TextSize = 11
    nt.Font = Enum.Font.GothamBold
    nt.TextXAlignment = Enum.TextXAlignment.Left
    nt.TextWrapped = true
    nt.AutomaticSize = Enum.AutomaticSize.Y
    nt.TextTransparency = 1
    nt.ZIndex = 102
    nt.Parent = nf
    
    local pad = Instance.new("UIPadding")
    pad.PaddingBottom = UDim.new(0, 6)
    pad.Parent = nf
    
    -- Animations (EXACT from ming.lua)
    TweenService:Create(nf, TweenInfo.new(0.25), {BackgroundTransparency = 0.3}):Play()
    TweenService:Create(nfs, TweenInfo.new(0.25), {Transparency = 0.3}):Play()
    TweenService:Create(nt, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
    
    -- Sound (EXACT from ming.lua)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://6895079853"
    s.Volume = 0.3
    s.Pitch = 1.3
    s.Parent = game:GetService("SoundService")
    s:Play()
    game:GetService("Debris"):AddItem(s, 2)
    
    -- Fade out
    task.delay(duration or 2, function()
        TweenService:Create(nf, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(nfs, TweenInfo.new(0.2), {Transparency = 1}):Play()
        TweenService:Create(nt, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        task.wait(0.25)
        nf:Destroy()
        
        -- Cleanup if no more notifications
        if #notifContainer:GetChildren() == 1 then -- Only UIListLayout left
            task.wait(0.5)
            if #notifContainer:GetChildren() == 1 then
                notifGui:Destroy()
            end
        end
    end)
end

-- Check if already loaded
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SynceHub") then
    warn("⚠️ SynceHub is already loaded!")
    showNotif("⚠️ Already Loaded", "SynceHub is already running!", 3)
    return
end

-- URLs
local LOADING_SCREEN_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/loads.lua"
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
    showNotif("❌ Load Failed", "Failed to load Loading Screen", 5)
    return
end

-- Execute Loading Screen
local success, LoadingScreen = pcall(function()
    return loadstring(loadingScreenCode)()
end)

if not success then
    warn("❌ Failed to execute Loading Screen")
    warn("Error: " .. tostring(LoadingScreen))
    showNotif("❌ Execution Failed", "Loading Screen error", 5)
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
    showNotif("❌ Load Failed", "Failed to load Main Hub", 5)
    return
end

-- Wait for loading screen to finish (now 2 seconds total)
task.wait(2)

-- Execute Main Hub
print("🚀 Executing Main Hub...")
local hubSuccess, hubError = pcall(function()
    loadstring(mainHubCode)()
end)

if hubSuccess then
    print("✅ SynceScriptHub v1.8 Successfully Loaded!")
    print("🎮 Youtuber Empire Hub is ready!")
    -- Note: Hub will show its own "Loaded" notification
else
    warn("❌ Failed to execute Main Hub")
    warn("Error: " .. tostring(hubError))
    showNotif("❌ Execution Failed", "Failed to run Main Hub", 5)
end
