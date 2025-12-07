-- SynceScriptHub | Main Loader v2.8 (GAME DETECTION + PICKAXE UPDATE)
-- Usage: loadstring(game:HttpGet('https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/loaderkhub.lua'))()
-- Updated: Game Detection, Egg Slider, Auto Craft Features

print("🚀 SynceScriptHub Loader Starting...")

-- ═══════════════════════════════════════════════════════════════
-- 🎮 GAME DETECTION (CRITICAL)
-- ═══════════════════════════════════════════════════════════════

local REQUIRED_PLACE_ID = 82013336390273
local currentPlaceId = game.PlaceId

if currentPlaceId ~= REQUIRED_PLACE_ID then
    warn("❌ WRONG GAME DETECTED!")
    warn("Required Place ID: " .. REQUIRED_PLACE_ID)
    warn("Current Place ID: " .. currentPlaceId)
    
    -- Create error notification
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local errorGui = Instance.new("ScreenGui")
    errorGui.Name = "SynceHubError"
    errorGui.ResetOnSpawn = false
    errorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    errorGui.DisplayOrder = 99999
    errorGui.IgnoreGuiInset = true
    errorGui.Parent = playerGui
    
    local errorFrame = Instance.new("Frame")
    errorFrame.Size = UDim2.new(0, 400, 0, 250)
    errorFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    errorFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
    errorFrame.BorderSizePixel = 0
    errorFrame.Parent = errorGui
    
    Instance.new("UICorner", errorFrame).CornerRadius = UDim.new(0, 12)
    
    local errorStroke = Instance.new("UIStroke")
    errorStroke.Color = Color3.fromRGB(200, 50, 50)
    errorStroke.Thickness = 2
    errorStroke.Parent = errorFrame
    
    local errorIcon = Instance.new("TextLabel")
    errorIcon.Size = UDim2.new(1, 0, 0, 60)
    errorIcon.Position = UDim2.new(0, 0, 0, 20)
    errorIcon.BackgroundTransparency = 1
    errorIcon.Text = "⛔"
    errorIcon.TextSize = 48
    errorIcon.Font = Enum.Font.GothamBold
    errorIcon.TextColor3 = Color3.fromRGB(255, 100, 100)
    errorIcon.Parent = errorFrame
    
    local errorTitle = Instance.new("TextLabel")
    errorTitle.Size = UDim2.new(1, -40, 0, 30)
    errorTitle.Position = UDim2.new(0, 20, 0, 85)
    errorTitle.BackgroundTransparency = 1
    errorTitle.Text = "WRONG GAME DETECTED"
    errorTitle.TextSize = 16
    errorTitle.Font = Enum.Font.GothamBold
    errorTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
    errorTitle.TextWrapped = true
    errorTitle.Parent = errorFrame
    
    local errorMsg = Instance.new("TextLabel")
    errorMsg.Size = UDim2.new(1, -40, 0, 80)
    errorMsg.Position = UDim2.new(0, 20, 0, 120)
    errorMsg.BackgroundTransparency = 1
    errorMsg.Text = "This script only works in:\n⛏️ PICKAXE SIMULATOR\n\nPlace ID: " .. REQUIRED_PLACE_ID
    errorMsg.TextSize = 12
    errorMsg.Font = Enum.Font.Gotham
    errorMsg.TextColor3 = Color3.fromRGB(200, 150, 150)
    errorMsg.TextWrapped = true
    errorMsg.TextYAlignment = Enum.TextYAlignment.Top
    errorMsg.Parent = errorFrame
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 120, 0, 35)
    closeBtn.Position = UDim2.new(0.5, -60, 1, -50)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "Close"
    closeBtn.TextSize = 13
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Parent = errorFrame
    
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        errorGui:Destroy()
    end)
    
    -- Play error sound
    local errorSound = Instance.new("Sound")
    errorSound.SoundId = "rbxassetid://2865227271"
    errorSound.Volume = 0.5
    errorSound.Parent = game:GetService("SoundService")
    errorSound:Play()
    game:GetService("Debris"):AddItem(errorSound, 3)
    
    -- STOP EXECUTION
    error("❌ Script stopped: Wrong game detected!")
    return
end

print("✅ Game Detection Passed: Pickaxe Simulator")

-- ═══════════════════════════════════════════════════════════════
-- 📢 NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════════

local function showNotif(title, msg, duration)
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
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
    
    TweenService:Create(nf, TweenInfo.new(0.25), {BackgroundTransparency = 0.3}):Play()
    TweenService:Create(nfs, TweenInfo.new(0.25), {Transparency = 0.3}):Play()
    TweenService:Create(nt, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
    
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://6895079853"
    s.Volume = 0.3
    s.Pitch = 1.3
    s.Parent = game:GetService("SoundService")
    s:Play()
    game:GetService("Debris"):AddItem(s, 2)
    
    task.delay(duration or 2, function()
        TweenService:Create(nf, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(nfs, TweenInfo.new(0.2), {Transparency = 1}):Play()
        TweenService:Create(nt, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        task.wait(0.25)
        nf:Destroy()
        
        if #notifContainer:GetChildren() == 1 then
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

-- ═══════════════════════════════════════════════════════════════
-- 📦 FILE URLS
-- ═══════════════════════════════════════════════════════════════

local THEME_SYSTEM_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/themes.lua"
local PICKAXE_FEATURES_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/featurek.lua"
local TAB_CONTENTS_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/tabk-content.lua"
local LOADING_SCREEN_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/screenhub.lua"
local MAIN_HUB_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/mainkhub.lua"

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

-- ═══════════════════════════════════════════════════════════════
-- 🎨 LOAD THEME SYSTEM
-- ═══════════════════════════════════════════════════════════════

print("📥 Loading Theme System...")
local themeSystemCode = safeLoad(THEME_SYSTEM_URL, "Theme System")

if not themeSystemCode then
    showNotif("❌ Load Failed", "Failed to load Theme System", 5)
    return
end

local themeSuccess, ThemeSystem = pcall(function()
    return loadstring(themeSystemCode)()
end)

if not themeSuccess then
    warn("❌ Failed to execute Theme System")
    warn("Error: " .. tostring(ThemeSystem))
    showNotif("❌ Execution Failed", "Theme System error", 5)
    return
end

_G.SynceThemeSystem = ThemeSystem
print("✅ Theme System loaded with " .. ThemeSystem:GetThemeCount() .. " themes")

-- ═══════════════════════════════════════════════════════════════
-- ⛏️ LOAD PICKAXE FEATURES
-- ═══════════════════════════════════════════════════════════════

print("📥 Loading Pickaxe Simulator Features...")
local pickaxeFeaturesCode = safeLoad(PICKAXE_FEATURES_URL, "Pickaxe Features")

if not pickaxeFeaturesCode then
    warn("⚠️ Pickaxe Features not loaded - Main tab will show error")
else
    local pickaxeSuccess, PickaxeFeatures = pcall(function()
        return loadstring(pickaxeFeaturesCode)()
    end)

    if pickaxeSuccess then
        _G.SyncePickaxeFeatures = PickaxeFeatures
        print("✅ Pickaxe Simulator Features loaded")
    else
        warn("❌ Failed to execute Pickaxe Features")
        warn("Error: " .. tostring(PickaxeFeatures))
    end
end

-- ═══════════════════════════════════════════════════════════════
-- 📑 LOAD TAB CONTENTS
-- ═══════════════════════════════════════════════════════════════

print("📥 Loading Tab Contents System...")
local tabContentsCode = safeLoad(TAB_CONTENTS_URL, "Tab Contents")

if not tabContentsCode then
    showNotif("❌ Load Failed", "Failed to load Tab Contents", 5)
    return
end

local tabSuccess, TabContents = pcall(function()
    return loadstring(tabContentsCode)()
end)

if not tabSuccess then
    warn("❌ Failed to execute Tab Contents")
    warn("Error: " .. tostring(TabContents))
    showNotif("❌ Execution Failed", "Tab Contents error", 5)
    return
end

_G.SynceTabContents = TabContents
print("✅ Tab Contents System loaded")

-- ═══════════════════════════════════════════════════════════════
-- 🎬 LOAD LOADING SCREEN
-- ═══════════════════════════════════════════════════════════════

print("📥 Loading Loading Screen...")
local loadingScreenCode = safeLoad(LOADING_SCREEN_URL, "Loading Screen")

if not loadingScreenCode then
    showNotif("❌ Load Failed", "Failed to load Loading Screen", 5)
    return
end

local success, LoadingScreen = pcall(function()
    return loadstring(loadingScreenCode)()
end)

if not success then
    warn("❌ Failed to execute Loading Screen")
    warn("Error: " .. tostring(LoadingScreen))
    showNotif("❌ Execution Failed", "Loading Screen error", 5)
    return
end

print("🎬 Starting Loading Screen...")
task.spawn(function()
    pcall(function()
        LoadingScreen:Create()
    end)
end)

task.wait(0.5)

-- ═══════════════════════════════════════════════════════════════
-- 🏠 LOAD MAIN HUB
-- ═══════════════════════════════════════════════════════════════

print("📥 Loading Main Hub...")
local mainHubCode = safeLoad(MAIN_HUB_URL, "Main Hub (mainkhub.lua)")

if not mainHubCode then
    showNotif("❌ Load Failed", "Failed to load Main Hub", 5)
    return
end

task.wait(2)

print("🚀 Executing Main Hub...")
local hubSuccess, hubError = pcall(function()
    loadstring(mainHubCode)()
end)

if hubSuccess then
    print("✅ SynceScriptHub v2.8 (GAME DETECTION + PICKAXE UPDATE) Successfully Loaded!")
    print("🎮 Synce Script Hub is ready!")
    print("🎨 Themes: " .. ThemeSystem:GetThemeCount() .. " available")
    print("📦 Tab Contents: Externalized & Modular")
    if _G.SyncePickaxeFeatures then
        print("⛏️ Pickaxe Simulator: Features Loaded")
    else
        print("⚠️ Pickaxe Simulator: Features Not Available")
    end
else
    warn("❌ Failed to execute Main Hub")
    warn("Error: " .. tostring(hubError))
    showNotif("❌ Execution Failed", "Failed to run Main Hub", 5)
end