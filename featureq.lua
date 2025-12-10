-- SynceScriptHub | Features Module v3.0
-- GitHub: https://github.com/SynceXxx/SynceHub
-- File: featureq.lua
-- Universal Executor Collection + FE Scripts

local Features = {}

-- ═══════════════════════════════════════════════════════════════
-- 🚀 EXECUTOR LINKS
-- ═══════════════════════════════════════════════════════════════

Features.Executors = {
    {
        name = "Trigon Executor",
        status = "OLD",
        url = "https://raw.githubusercontent.com/SuperHackerYT/Trigon/refs/heads/main/Trigon.txt",
        description = "Classic Trigon executor with basic features"
    },
    {
        name = "Codex Executor",
        status = "NEW",
        url = "https://raw.githubusercontent.com/CodexScripts/CodexUI/refs/heads/main/CodexMain",
        description = "Modern Codex executor with improved UI"
    },
    {
        name = "Delta Executor",
        status = "NEW",
        url = "https://pastefy.app/iXvqMv4G/raw",
        description = "Delta executor - Latest version"
    },
    {
        name = "Arceus X",
        status = "OLD",
        url = "https://rawscripts.net/raw/Universal-Script-Arceus-X-Executor-22878",
        description = "Popular Arceus X mobile executor"
    },
    {
        name = "KRNL",
        status = "OLD",
        url = "https://raw.githubusercontent.com/wtfplayer/redemption/main/krnlnoui.lua",
        description = "KRNL executor without UI"
    },
    {
        name = "Hydrogen",
        status = "REMAKE",
        url = "https://raw.githubusercontent.com/dnezero/hydrogen_remake/refs/heads/main/.lua",
        description = "Hydrogen executor remake version"
    },
    {
        name = "Synapse X",
        status = "REMAKE",
        url = "https://pastefy.app/tB1McyJv/raw",
        description = "Synapse X remake - Premium features"
    }
}

-- ═══════════════════════════════════════════════════════════════
-- 🎭 FE SCRIPTS (Front End Scripts)
-- ═══════════════════════════════════════════════════════════════

Features.FEScripts = {
    {
        name = "FE Trolling GUI",
        url = "https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau",
        description = "Full trolling GUI with multiple features",
        category = "Trolling"
    },
    {
        name = "FE Tool Giver",
        url = "https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua",
        description = "Give yourself any game tools",
        category = "Tools"
    },
    {
        name = "FE Animations Hub (R6 / R15)",
        url = "https://raw.githubusercontent.com/Dvrknvss/UniversalFEScriptHub/main/UFE",
        description = "Universal animation hub for R6 and R15",
        category = "Animations"
    },
    {
        name = "FE Animations Player",
        url = "https://raw.githubusercontent.com/Idk12384/Animation-Player-Script/refs/heads/main/Main%20Code",
        description = "Play custom animations",
        category = "Animations"
    },
    {
        name = "FE Super Lag",
        url = "https://pastebin.com/raw/GBmWn4eZ",
        description = "Lag the server (use carefully)",
        category = "Trolling"
    },
    {
        name = "FE Gun",
        url = "https://pastebin.com/raw/pYMbRb7w",
        description = "FE Gun script (needs hats equipped)",
        category = "Weapons",
        requirements = "Requires hats"
    },
    {
        name = "FE Control NPC",
        url = "https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau",
        description = "Control NPCs in the game",
        category = "Control"
    },
    {
        name = "FE Jerk Off R6",
        url = "https://raw.githubusercontent.com/imalwaysad/universal-gui/refs/heads/main/jerk%20off%20r6",
        description = "R6 animation script",
        category = "Animations",
        requirements = "R6 only"
    },
    {
        name = "FE Equip Multiple Tools",
        url = "https://raw.githubusercontent.com/zephyr10101/MultiToolsV1/main/script",
        description = "Equip multiple tools at once",
        category = "Tools"
    },
    {
        name = "FE Face Bang R6",
        url = "https://rawscripts.net/raw/Universal-Script-FE-FACEBANG-28199",
        description = "Face bang animation for R6",
        category = "Animations",
        requirements = "R6 only"
    },
    {
        name = "FE Seraphic Blade",
        url = "https://pastefy.app/59mJGQGe/raw",
        description = "Seraphic blade weapon script",
        category = "Weapons"
    },
    {
        name = "FE Ragdoll",
        url = "https://raw.githubusercontent.com/MrArgy/MrArgyRobloxScripts/refs/heads/main/ragdoll_buttons_secured.txt",
        description = "Ragdoll physics script",
        category = "Physics"
    },
    {
        name = "FE Rewind",
        url = "https://raw.githubusercontent.com/0Ben1/fe./main/L",
        description = "Rewind time effect",
        category = "Effects"
    }
}

-- ═══════════════════════════════════════════════════════════════
-- 🔧 EXECUTOR FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

function Features:LoadExecutor(executorData, callback)
    if not executorData or not executorData.url then
        return false, "Invalid executor data"
    end
    
    local success, result = pcall(function()
        local script = game:HttpGet(executorData.url, true)
        if script and script ~= "" then
            loadstring(script)()
            return true, executorData.name .. " loaded successfully!"
        else
            return false, "Failed to fetch executor script"
        end
    end)
    
    if success and result then
        if callback then callback(true, result) end
        return true, result
    else
        local errorMsg = "Failed to load " .. executorData.name
        if callback then callback(false, errorMsg) end
        return false, errorMsg
    end
end

function Features:GetExecutorByName(name)
    for _, executor in ipairs(self.Executors) do
        if executor.name == name then
            return executor
        end
    end
    return nil
end

function Features:GetExecutorCount()
    return #self.Executors
end

function Features:GetExecutorsByStatus(status)
    local filtered = {}
    for _, executor in ipairs(self.Executors) do
        if executor.status == status then
            table.insert(filtered, executor)
        end
    end
    return filtered
end

-- ═══════════════════════════════════════════════════════════════
-- 🎭 FE SCRIPT FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

function Features:LoadFEScript(feScriptData, callback)
    if not feScriptData or not feScriptData.url then
        return false, "Invalid FE script data"
    end
    
    local success, result = pcall(function()
        local script = game:HttpGet(feScriptData.url, true)
        if script and script ~= "" then
            loadstring(script)()
            return true, feScriptData.name .. " loaded successfully!"
        else
            return false, "Failed to fetch FE script"
        end
    end)
    
    if success and result then
        if callback then callback(true, result) end
        return true, result
    else
        local errorMsg = "Failed to load " .. feScriptData.name
        if callback then callback(false, errorMsg) end
        return false, errorMsg
    end
end

function Features:GetFEScriptByName(name)
    for _, script in ipairs(self.FEScripts) do
        if script.name == name then
            return script
        end
    end
    return nil
end

function Features:GetFEScriptCount()
    return #self.FEScripts
end

function Features:GetFEScriptsByCategory(category)
    local filtered = {}
    for _, script in ipairs(self.FEScripts) do
        if script.category == category then
            table.insert(filtered, script)
        end
    end
    return filtered
end

function Features:GetFEScriptCategories()
    local categories = {}
    local seen = {}
    for _, script in ipairs(self.FEScripts) do
        if script.category and not seen[script.category] then
            table.insert(categories, script.category)
            seen[script.category] = true
        end
    end
    return categories
end

-- ═══════════════════════════════════════════════════════════════
-- 🎯 INITIALIZATION
-- ═══════════════════════════════════════════════════════════════

function Features:Initialize()
    print("🚀 Initializing Features Module...")
    
    -- Executor stats
    print("✅ Loaded " .. self:GetExecutorCount() .. " executors")
    local newCount = #self:GetExecutorsByStatus("NEW")
    local oldCount = #self:GetExecutorsByStatus("OLD")
    local remakeCount = #self:GetExecutorsByStatus("REMAKE")
    
    print("📊 Executor breakdown:")
    print("   🆕 NEW: " .. newCount)
    print("   📦 OLD: " .. oldCount)
    print("   🔄 REMAKE: " .. remakeCount)
    
    -- FE Scripts stats
    print("✅ Loaded " .. self:GetFEScriptCount() .. " FE scripts")
    local categories = self:GetFEScriptCategories()
    print("📊 FE Script categories: " .. table.concat(categories, ", "))
    
    print("✅ Features Module Initialized!")
end

-- ═══════════════════════════════════════════════════════════════
-- 🗑️ CLEANUP
-- ═══════════════════════════════════════════════════════════════

function Features:Cleanup()
    print("🧹 Cleaning up Features Module...")
    print("✅ Cleanup complete!")
end

-- ═══════════════════════════════════════════════════════════════
-- 📦 AUTO-INITIALIZE & RETURN
-- ═══════════════════════════════════════════════════════════════

Features:Initialize()

return Features