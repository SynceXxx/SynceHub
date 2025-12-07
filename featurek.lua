-- Pickaxe Simulator Features Module v2.8 (FIXED)
-- GitHub: https://github.com/SynceXxx/SynceHub
-- File: featurek.lua (FIXED VERSION)
-- Game: Pickaxe Simulator

local PickaxeFeatures = {}

-- ═══════════════════════════════════════════════════════════════
-- 🔧 SERVICES & VARIABLES
-- ═══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local playerStatsFolder = nil
local settingsFolder = nil
local autoRewardEnabled = false

-- Auto Craft Variables
local autoCraftGoldEnabled = false
local autoCraftRainbowEnabled = false

-- ═══════════════════════════════════════════════════════════════
-- 🎯 INITIALIZATION
-- ═══════════════════════════════════════════════════════════════

function PickaxeFeatures:Initialize()
    print("🚀 Initializing Pickaxe Simulator Features...")
    
    task.spawn(function()
        local stats = ReplicatedStorage:WaitForChild("Stats", 10)
        if not stats then 
            warn("❌ Failed to find Stats folder")
            return 
        end

        playerStatsFolder = stats:WaitForChild(player.Name, 10)
        if not playerStatsFolder then 
            warn("❌ Failed to find player stats folder")
            return 
        end

        settingsFolder = playerStatsFolder:WaitForChild("Settings", 10)
        if settingsFolder then
            print("✅ Player stats folder loaded successfully")
        end
    end)
    
    -- Start Auto Systems
    self:StartAutoRewardLoop()
    self:StartAutoCraftLoop()
    
    print("✅ Pickaxe Simulator Features Initialized!")
end

-- ═══════════════════════════════════════════════════════════════
-- ⛏️ MINING FEATURES
-- ═══════════════════════════════════════════════════════════════

function PickaxeFeatures:SetMiningSpeed(value)
    if type(value) ~= "number" then
        return false, "Invalid input: Please enter a number"
    end
    
    if value < 1 or value > 9 then
        return false, "Out of range: Value must be between 1-9"
    end
    
    local boost = ReplicatedStorage.Stats:FindFirstChild(player.Name)
    if boost then
        boost = boost:FindFirstChild("MiningSpeedBoost")
        if boost and boost:IsA("NumberValue") then
            boost.Value = value
            return true, "Mining Speed set to " .. value .. "x"
        end
    end
    
    return false, "Failed to find MiningSpeedBoost"
end

-- ═══════════════════════════════════════════════════════════════
-- 🔄 AUTO FEATURES
-- ═══════════════════════════════════════════════════════════════

function PickaxeFeatures:SetAutoRebirth(enabled)
    if not settingsFolder then
        return false, "Settings folder not loaded yet"
    end
    
    local setting = settingsFolder:FindFirstChild("AutoRebirth")
    if setting and setting:IsA("BoolValue") then
        setting.Value = enabled
        return true, "Auto Rebirth " .. (enabled and "enabled" or "disabled")
    end
    
    return false, "Failed to find AutoRebirth setting"
end

function PickaxeFeatures:SetAutoTrain(enabled)
    if not settingsFolder then
        return false, "Settings folder not loaded yet"
    end
    
    local setting = settingsFolder:FindFirstChild("AutoTrain")
    if setting and setting:IsA("BoolValue") then
        setting.Value = enabled
        return true, "Auto Train " .. (enabled and "enabled" or "disabled")
    end
    
    return false, "Failed to find AutoTrain setting"
end

-- ═══════════════════════════════════════════════════════════════
-- 🥚 EGG FEATURES (TOGGLE - NO SPAM)
-- ═══════════════════════════════════════════════════════════════

function PickaxeFeatures:SetEggHatchSpeed(speed)
    if type(speed) ~= "number" then
        return false, "Invalid input: Please enter a number"
    end
    
    local eggStats = ReplicatedStorage.Stats:FindFirstChild(player.Name)
    if eggStats then
        eggStats = eggStats:FindFirstChild("EggStats")
        if eggStats then
            local stat = eggStats:FindFirstChild("HatchSpeed")
            if stat and stat:IsA("NumberValue") then
                stat.Value = speed
                return true, "Egg Hatch Speed " .. (speed == 1 and "reset to 1x" or "set to " .. speed .. "x")
            end
        end
    end
    
    return false, "Failed to find EggStats"
end

function PickaxeFeatures:SetAutoRewardEgg(enabled)
    autoRewardEnabled = enabled
    return true, "Auto Reward Egg " .. (enabled and "enabled" or "disabled")
end

function PickaxeFeatures:StartAutoRewardLoop()
    task.spawn(function()
        while true do
            task.wait(0.25)
            if autoRewardEnabled then
                local menus = player.PlayerGui:FindFirstChild("Menus")
                if not menus then continue end
                
                local rewardUI = menus:FindFirstChild("Reward")
                if not rewardUI then continue end
                
                local main = rewardUI.Frame.Main
                local available = main.Claim.Main:FindFirstChild("Available")
                
                if available and available.Visible == true then
                    pcall(function()
                        main.Claim:Activate()
                    end)
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- 👑 PREMIUM & GROUP FEATURES
-- ═══════════════════════════════════════════════════════════════

function PickaxeFeatures:SetPremium(enabled)
    task.spawn(function()
        local success, result = pcall(function()
            local analytics = ReplicatedStorage.Stats:WaitForChild(player.Name, 5):WaitForChild("Analytics", 5)
            local isPremium = analytics:WaitForChild("IsPremium", 5)
            
            if isPremium and isPremium:IsA("BoolValue") then
                isPremium.Value = enabled
                return true, "Premium (10%) " .. (enabled and "activated" or "deactivated")
            end
        end)
        
        if not success then
            return false, "Failed to toggle Premium"
        end
        return result
    end)
    
    return true, "Premium toggle initiated"
end

function PickaxeFeatures:SetInGroup(enabled)
    task.spawn(function()
        local success, result = pcall(function()
            local analytics = ReplicatedStorage.Stats:WaitForChild(player.Name, 5):WaitForChild("Analytics", 5)
            local isInGroup = analytics:WaitForChild("IsInGroup", 5)
            
            if isInGroup and isInGroup:IsA("BoolValue") then
                isInGroup.Value = enabled
                return true, "Group Reward " .. (enabled and "claimable" or "disabled")
            end
        end)
        
        if not success then
            return false, "Failed to toggle InGroup"
        end
        return result
    end)
    
    return true, "Group toggle initiated"
end

-- ═══════════════════════════════════════════════════════════════
-- 🔨 AUTO CRAFT FEATURES (FIXED)
-- ═══════════════════════════════════════════════════════════════

function PickaxeFeatures:SetAutoCraftGold(enabled)
    autoCraftGoldEnabled = enabled
    return true, "Auto Craft Gold " .. (enabled and "enabled" or "disabled")
end

function PickaxeFeatures:SetAutoCraftRainbow(enabled)
    autoCraftRainbowEnabled = enabled
    return true, "Auto Craft Rainbow " .. (enabled and "enabled" or "disabled")
end

function PickaxeFeatures:StartAutoCraftLoop()
    task.spawn(function()
        while true do
            task.wait(1)
            
            -- Auto Craft Gold (FIXED)
            if autoCraftGoldEnabled then
                pcall(function()
                    -- Try to find the crafting event
                    local events = ReplicatedStorage:FindFirstChild("Events")
                    if events then
                        local craftGold = events:FindFirstChild("CraftGold")
                        if craftGold and craftGold:IsA("RemoteEvent") then
                            craftGold:FireServer()
                        else
                            -- Alternative method: look for generic craft event
                            local craft = events:FindFirstChild("Craft")
                            if craft and craft:IsA("RemoteEvent") then
                                craft:FireServer("Gold") -- Try with parameter
                            end
                        end
                    end
                end)
            end
            
            -- Auto Craft Rainbow (FIXED)
            if autoCraftRainbowEnabled then
                pcall(function()
                    -- Try to find the crafting event
                    local events = ReplicatedStorage:FindFirstChild("Events")
                    if events then
                        local craftRainbow = events:FindFirstChild("CraftRainbow")
                        if craftRainbow and craftRainbow:IsA("RemoteEvent") then
                            craftRainbow:FireServer()
                        else
                            -- Alternative method: look for generic craft event
                            local craft = events:FindFirstChild("Craft")
                            if craft and craft:IsA("RemoteEvent") then
                                craft:FireServer("Rainbow") -- Try with parameter
                            end
                        end
                    end
                end)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- 🗑️ CLEANUP
-- ═══════════════════════════════════════════════════════════════

function PickaxeFeatures:Cleanup()
    print("🧹 Cleaning up Pickaxe Features...")
    
    -- Disable all features
    autoRewardEnabled = false
    autoCraftGoldEnabled = false
    autoCraftRainbowEnabled = false
    
    print("✅ Cleanup complete!")
end

-- ═══════════════════════════════════════════════════════════════
-- 📦 AUTO-INITIALIZE & RETURN
-- ═══════════════════════════════════════════════════════════════

PickaxeFeatures:Initialize()

return PickaxeFeatures