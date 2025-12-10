-- SynceScriptHub | Main Loader v3.0 (UNIVERSAL - NO GAME DETECTION)
-- Usage: loadstring(game:HttpGet('https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/loaderqhub.lua'))()
-- Updated: Universal support, Executor features

print("🚀 SynceScriptHub Loader Starting...")

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
local EXECUTOR_FEATURES_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/featureq.lua"
local TAB_CONTENTS_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/tabq-content.lua"
local LOADING_SCREEN_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/screenhub.lua"
local MAIN_HUB_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/mainqhub.lua"

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
-- 🚀 LOAD EXECUTOR FEATURES
-- ═══════════════════════════════════════════════════════════════

print("📥 Loading Executor Features...")
local executorFeaturesCode = safeLoad(EXECUTOR_FEATURES_URL, "Executor Features")

if not executorFeaturesCode then
    warn("⚠️ Executor Features not loaded - Executor tab will show error")
else
    local executorSuccess, ExecutorFeatures = pcall(function()
        return loadstring(executorFeaturesCode)()
    end)

    if executorSuccess then
        _G.SynceExecutorFeatures = ExecutorFeatures
        print("✅ Executor Features loaded with " .. ExecutorFeatures:GetExecutorCount() .. " executors")
    else
        warn("❌ Failed to execute Executor Features")
        warn("Error: " .. tostring(ExecutorFeatures))
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
local mainHubCode = safeLoad(MAIN_HUB_URL, "Main Hub (mainqhub.lua)")

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
    print("✅ SynceScriptHub v3.0 (UNIVERSAL EDITION) Successfully Loaded!")
    print("🎮 Synce Script Hub is ready!")
    print("🎨 Themes: " .. ThemeSystem:GetThemeCount() .. " available")
    print("📦 Tab Contents: Externalized & Modular")
    if _G.SynceExecutorFeatures then
        print("🚀 Executors: " .. _G.SynceExecutorFeatures:GetExecutorCount() .. " loaded")
    else
        print("⚠️ Executors: Not Available")
    end
else
    warn("❌ Failed to execute Main Hub")
    warn("Error: " .. tostring(hubError))
    showNotif("❌ Execution Failed", "Failed to run Main Hub", 5)
end