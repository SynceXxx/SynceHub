-- SynceScriptHub | Main Loader
-- Usage: loadstring(game:HttpGet('https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/loader.lua'))()

print("🚀 SynceScriptHub Loader Starting...")

-- Check if already loaded
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SynceHub") then
    warn("⚠️ SynceHub is already loaded!")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚠️ Already Loaded",
        Text = "SynceHub is already running!",
        Duration = 3
    })
    return
end

-- URLs
local LOADING_SCREEN_URL = "https://raw.githubusercontent.com/SynceXxx/SynceHub/refs/heads/main/loading.lua"
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
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Load Failed",
        Text = "Failed to load Loading Screen",
        Duration = 5
    })
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
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Load Failed",
        Text = "Failed to load Main Hub",
        Duration = 5
    })
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
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Execution Failed",
        Text = "Failed to run Main Hub",
        Duration = 5
    })
end