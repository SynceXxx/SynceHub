-- SynceScriptHub | Tab Contents v2.8
-- All Tab Contents in One External File
-- GitHub: https://github.com/SynceXxx/SynceHub
-- File: tabx-content.lua
-- Updates: Egg Hatch Slider (1.75-7), Auto Craft Gold, Auto Craft Rainbow

local TabContents = {}

-- ═══════════════════════════════════════════════════════════════
-- 📦 INITIALIZE TAB CONTENTS
-- ═══════════════════════════════════════════════════════════════

function TabContents:Initialize(UI)
    local cc = UI.ClearContent
    local csb = UI.CreateTabButton
    local setActiveTab = UI.SetActiveTab
    local cbtn = UI.CreateButton
    local ctg = UI.CreateToggle
    local cinp = UI.CreateInput
    local cslider = UI.CreateSlider
    local cplrlist = UI.CreatePlayerList
    local cinfo = UI.CreateInfo
    local cspace = UI.CreateSpace
    local crgb = UI.CreateRGB
    local ctxinp = UI.CreateTextInput
    local cthank = UI.CreateThankYou
    local F = UI.Features
    local ca = UI.ContentArea
    local applyTheme = UI.ApplyTheme
    local getThemeColors = UI.GetThemeColors
    local showNotif = UI.ShowNotification
    local playSound = UI.PlaySound
    local ThemeSystem = UI.ThemeSystem
    local T = UI.TweenService
    
    -- Get Pickaxe Features if loaded
    local PickaxeFeatures = _G.SyncePickaxeFeatures
    
    -- ═══════════════════════════════════════════════════════════════
    -- 🎨 THEME CARD CREATOR
    -- ═══════════════════════════════════════════════════════════════
    
    local function cthemecard(themeName, themeData)
        local theme = getThemeColors()
        local tc = Instance.new("Frame")
        tc.Size = UDim2.new(1, 0, 0, 80)
        tc.BackgroundColor3 = theme.contentBg
        tc.BorderSizePixel = 0
        tc.ZIndex = 3
        tc.Parent = ca
        
        Instance.new("UICorner", tc).CornerRadius = UDim.new(0, 8)
        
        local tcs = Instance.new("UIStroke")
        tcs.Color = theme.borderColor
        tcs.Thickness = 1
        tcs.Parent = tc
        
        local tcb = Instance.new("TextButton")
        tcb.Size = UDim2.new(1, -12, 1, -12)
        tcb.Position = UDim2.new(0, 6, 0, 6)
        tcb.BackgroundColor3 = themeData.mainBg
        tcb.Text = ""
        tcb.AutoButtonColor = false
        tcb.ZIndex = 4
        tcb.Parent = tc
        
        Instance.new("UICorner", tcb).CornerRadius = UDim.new(0, 6)
        
        local tcbs = Instance.new("UIStroke")
        tcbs.Color = themeData.accentColor
        tcbs.Thickness = UI.CurrentTheme() == themeName and 3 or 1
        tcbs.Parent = tcb
        
        local tci = Instance.new("TextLabel")
        tci.Size = UDim2.new(0, 50, 1, 0)
        tci.Position = UDim2.new(0, 12, 0, 0)
        tci.BackgroundTransparency = 1
        tci.Text = themeData.icon
        tci.TextSize = 32
        tci.Font = Enum.Font.GothamBold
        tci.ZIndex = 5
        tci.Parent = tcb
        
        local tcn = Instance.new("TextLabel")
        tcn.Size = UDim2.new(1, -75, 0, 24)
        tcn.Position = UDim2.new(0, 65, 0, 10)
        tcn.BackgroundTransparency = 1
        tcn.Text = themeName
        tcn.TextColor3 = themeData.textColor
        tcn.TextSize = 13
        tcn.Font = Enum.Font.GothamBold
        tcn.TextXAlignment = Enum.TextXAlignment.Left
        tcn.ZIndex = 5
        tcn.Parent = tcb
        
        local tcd = Instance.new("TextLabel")
        tcd.Size = UDim2.new(1, -75, 0, 32)
        tcd.Position = UDim2.new(0, 65, 0, 32)
        tcd.BackgroundTransparency = 1
        tcd.Text = themeData.description or "A beautiful theme"
        tcd.TextColor3 = themeData.textColor
        tcd.TextSize = 10
        tcd.Font = Enum.Font.Gotham
        tcd.TextXAlignment = Enum.TextXAlignment.Left
        tcd.TextWrapped = true
        tcd.TextTransparency = 0.3
        tcd.ZIndex = 5
        tcd.Parent = tcb
        
        local preview = Instance.new("Frame")
        preview.Size = UDim2.new(0, 4, 1, -16)
        preview.Position = UDim2.new(1, -8, 0, 8)
        preview.BackgroundColor3 = themeData.accentColor
        preview.BorderSizePixel = 0
        preview.ZIndex = 5
        preview.Parent = tcb
        
        Instance.new("UICorner", preview).CornerRadius = UDim.new(1, 0)
        
        tcb.MouseEnter:Connect(function()
            if UI.CurrentTheme() ~= themeName then
                T:Create(tcb, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.new(themeData.mainBg.R * 0.9, themeData.mainBg.G * 0.9, themeData.mainBg.B * 0.9)
                }):Play()
                T:Create(tcbs, TweenInfo.new(0.15), {Thickness = 2}):Play()
            end
        end)
        
        tcb.MouseLeave:Connect(function()
            if UI.CurrentTheme() ~= themeName then
                T:Create(tcb, TweenInfo.new(0.15), {BackgroundColor3 = themeData.mainBg}):Play()
                T:Create(tcbs, TweenInfo.new(0.15), {Thickness = 1}):Play()
            end
        end)
        
        tcb.MouseButton1Click:Connect(function()
            playSound(6895079853, 0.4, 1.2)
            applyTheme(themeName)
            showNotif("Theme", themeData.icon .. " " .. themeName, 2)
            
            for _, card in pairs(ca:GetChildren()) do
                if card:IsA("Frame") and card ~= tc then
                    local btn = card:FindFirstChildOfClass("TextButton")
                    if btn then
                        local stroke = btn:FindFirstChildOfClass("UIStroke")
                        if stroke then
                            T:Create(stroke, TweenInfo.new(0.15), {Thickness = 1}):Play()
                        end
                    end
                end
            end
            
            T:Create(tcbs, TweenInfo.new(0.2), {Thickness = 3}):Play()
        end)
    end
    
    -- ═══════════════════════════════════════════════════════════════
    -- 🏠 MAIN TAB (PICKAXE SIMULATOR)
    -- ═══════════════════════════════════════════════════════════════
    
    csb("Main", "farm", function()
        cc()
        setActiveTab("Main")
        
        if not PickaxeFeatures then
            cinfo("❌ Features Not Loaded", "Pickaxe Simulator features are not available. Please restart the script.")
            return
        end
        
        cinfo("⛏️ Pickaxe Simulator", "Special features for Pickaxe Simulator. Boost your mining speed, auto-farm, and unlock premium benefits!")
        
        cspace(8)
        
        ctg("⛏️ Mining Speed Boost (x2)", false, function(v)
            local success, message = PickaxeFeatures:SetMiningSpeed(v and 2 or 1)
            if success then
                showNotif(v and "⚡ Boosted" or "⚪ Reset", message, 2)
            else
                showNotif("⚠️ Error", message, 2)
            end
        end)
        
        ctg("🔄 Auto Rebirth", false, function(v)
            local success, message = PickaxeFeatures:SetAutoRebirth(v)
            if not success then
                showNotif("⚠️ Error", message, 2)
            end
        end)
        
        ctg("💪 Auto Train", false, function(v)
            local success, message = PickaxeFeatures:SetAutoTrain(v)
            if not success then
                showNotif("⚠️ Error", message, 2)
            end
        end)
        
        -- EGG HATCH SPEED SLIDER (UPDATED)
        cslider("🥚 Egg Hatch Speed", 1, 7, 1, function(v)
            local success, message = PickaxeFeatures:SetEggHatchSpeed(v)
            if success then
                showNotif("🥚 Hatch Speed", message, 2)
            else
                showNotif("⚠️ Error", message, 2)
            end
        end)
        
        ctg("👑 Active 10% Premium", false, function(v)
            PickaxeFeatures:SetPremium(v)
            showNotif(v and "👑 Premium ON" or "⚪ Premium OFF", "Premium " .. (v and "activated" or "deactivated"), 2)
        end)
        
        ctg("👥 Claim Reward Group Chest", false, function(v)
            PickaxeFeatures:SetInGroup(v)
            showNotif(v and "👥 Group ON" or "⚪ Group OFF", "Group reward " .. (v and "claimable" or "disabled"), 2)
        end)
        
        ctg("🎁 Auto Reward Egg", false, function(v)
            PickaxeFeatures:SetAutoRewardEgg(v)
            showNotif(v and "🎁 Auto ON" or "⚪ Auto OFF", "Auto reward egg " .. (v and "enabled" or "disabled"), 2)
        end)
        
        cspace(8)
        
        -- AUTO CRAFT FEATURES (NEW)
        cinfo("🔨 Auto Craft", "Automatically craft blocks to higher tiers. Enable the features below to start auto-crafting.")
        
        cspace(4)
        
        ctg("🟡 Auto Craft Gold", false, function(v)
            local success, message = PickaxeFeatures:SetAutoCraftGold(v)
            showNotif(v and "🟡 Gold ON" or "⚪ Gold OFF", message, 2)
        end)
        
        ctg("🌈 Auto Craft Rainbow", false, function(v)
            local success, message = PickaxeFeatures:SetAutoCraftRainbow(v)
            showNotif(v and "🌈 Rainbow ON" or "⚪ Rainbow OFF", message, 2)
        end)
        
        cspace(8)
        cthank()
    end)
    
    -- ═══════════════════════════════════════════════════════════════
    -- 🎮 PLAYER TAB
    -- ═══════════════════════════════════════════════════════════════
    
    csb("Player", "player", function()
        cc()
        setActiveTab("Player")
        
        cinfo("⚙️ Player Modifications", "Customize your character's abilities and enhance your gameplay experience with various modifications.")
        
        cinp("🏃 WalkSpeed", 16, 500, 16, function(v)
            if F then F.WalkSpeed(v) end
        end)
        
        cinp("⬆️ JumpPower", 50, 500, 50, function(v)
            if F then F.JumpPower(v) end
        end)
        
        ctg("🦘 Infinite Jump", false, function(v)
            if F then F.InfJump(v) end
        end)
        
        ctg("✈️ Fly", false, function(v)
            if F then F.Fly(v) end
        end)
        
        ctg("🚫 Noclip", false, function(v)
            if F then F.Noclip(v) end
        end)
        
        ctg("👁️ Invisible", false, function(v)
            if F then F.Invisible(v) end
        end)
        
        cspace(8)
        cplrlist()
        cthank()
    end)
    
    -- ═══════════════════════════════════════════════════════════════
    -- 🎨 VISUAL TAB
    -- ═══════════════════════════════════════════════════════════════
    
    csb("Visual", "visual", function()
        cc()
        setActiveTab("Visual")
        
        cinfo("🎨 Visual Enhancements", "Improve your visibility and customize your appearance in the game with various visual modifications.")
        
        cslider("💡 Fullbright", 0, 100, 50, function(v)
            if F then F.Fullbright(v) end
        end)
        
        ctg("🌫️ Remove Fog", false, function(v)
            if F then F.RemoveFog(v) end
        end)
        
        cspace(8)
        cinfo("✨ Custom Nametag (Local Only)", "Create a custom nametag above your character. Only YOU can see this!")
        
        local nametagEnabled = false
        local nametagText = "👑 OWNER 👑"
        local nametagR, nametagG, nametagB = 255, 255, 255
        local rainbowEnabled = false
        
        local nametagTextBox = ctxinp("📝 Nametag Text", "Enter your custom text...", function(txt)
            nametagText = txt
            if nametagEnabled and F then
                F.CustomNametag(true, nametagText, nametagR, nametagG, nametagB)
            end
        end)
        nametagTextBox.Text = nametagText
        
        cspace(4)
        
        crgb("🎨 Nametag Color (RGB)", nametagR, nametagG, nametagB, function(r, g, b)
            nametagR, nametagG, nametagB = r, g, b
            if nametagEnabled and F and not rainbowEnabled then
                F.CustomNametag(true, nametagText, nametagR, nametagG, nametagB)
            end
        end)
        
        cspace(4)
        
        ctg("🌈 Rainbow Mode", false, function(v)
            rainbowEnabled = v
            if F then F.RainbowNametag(v) end
        end)
        
        ctg("✨ Enable Nametag", false, function(v)
            nametagEnabled = v
            if F then
                F.CustomNametag(v, nametagText, nametagR, nametagG, nametagB)
                if not v and rainbowEnabled then
                    F.RainbowNametag(false)
                    rainbowEnabled = false
                end
            end
        end)
        
        cthank()
    end)
    
    -- ═══════════════════════════════════════════════════════════════
    -- 🎨 THEMES TAB
    -- ═══════════════════════════════════════════════════════════════
    
    csb("Themes", "themes", function()
        cc()
        setActiveTab("Themes")
        
        cinfo("🎨 Theme Selection", "Choose your favorite theme! Click any theme card below to apply it instantly. Your selection will be applied across all tabs.")
        
        cspace(4)
        
        local themeNames = ThemeSystem:GetThemeNames()
        for _, themeName in ipairs(themeNames) do
            local themeData = ThemeSystem:GetTheme(themeName)
            cthemecard(themeName, themeData)
        end
        
        cspace(8)
        cinfo("ℹ️ About Themes", "• " .. ThemeSystem:GetThemeCount() .. " unique themes available\n• Themes persist across all tabs\n• Changes apply instantly\n• Each theme has unique colors and style")
        cthank()
    end)
    
    -- ═══════════════════════════════════════════════════════════════
    -- ℹ️ INFORMATION TAB
    -- ═══════════════════════════════════════════════════════════════
    
    csb("Information", "info", function()
        cc()
        setActiveTab("Information")
        
        cinfo("👑 Developer", "This script is created and maintained by SynceScriptHub. A dedicated developer focused on creating high-quality Roblox scripts.")
        
        local themeList = "Available Themes:\n"
        for _, name in ipairs(ThemeSystem:GetThemeNames()) do
            local theme = ThemeSystem:GetTheme(name)
            themeList = themeList .. "• " .. theme.icon .. " " .. name .. "\n"
        end
        
        cinfo("⚡ Current Features", "Pickaxe Simulator:\n• Mining Speed Boost (1-9x)\n• Auto Rebirth System\n• Auto Training Mode\n• Egg Hatch Speed (1.75-7x)\n• Premium Benefits (10%)\n• Group Reward Claim\n• Auto Reward Egg\n• Auto Craft Gold\n• Auto Craft Rainbow\n\nPlayer Modifications:\n• WalkSpeed (16-500)\n• JumpPower (50-500)\n• Infinite Jump\n• Fly Mode with Mobile UI\n• Noclip (Walk through walls)\n• Invisible Character\n• Teleport to Player\n\nVisual Enhancements:\n• Fullbright Slider (0-100)\n• Remove Fog Toggle\n• Custom Nametag with RGB + Rainbow\n\nThemes (" .. ThemeSystem:GetThemeCount() .. " Available):\n" .. themeList .. "\nServer Options:\n• Rejoin Current Server\n• Server Hop to New Server\n• Anti-AFK Protection")
        
        cinfo("📌 Version Information", "Version: 2.8 (GAME DETECTION + EGG SLIDER + AUTO CRAFT)\nLast Updated: December 2024\nStatus: Stable Release\n\nNew in v2.8:\n✅ Game Detection (Place ID Check)\n✅ Egg Hatch Speed Slider (1.75-7)\n✅ Auto Craft Gold Feature\n✅ Auto Craft Rainbow Feature\n✅ Improved Error Handling\n\nAll features:\n• Game-specific features\n• Mobile-friendly UI\n• Smooth performance\n• Multi-theme support\n• Full feature reset on destroy")
        
        cthank()
    end)
    
    -- ═══════════════════════════════════════════════════════════════
    -- ⚙️ SETTINGS TAB
    -- ═══════════════════════════════════════════════════════════════
    
    csb("Settings", "settings", function()
        cc()
        setActiveTab("Settings")
        
        cinfo("⚙️ Settings", "Configure your script preferences and server options here.")
        
        ctg("⏰ Anti-AFK", false, function(v)
            if F then F.AntiAFK(v) end
        end)
        
        cinfo("🌐 Server Management", "Manage your server connection with quick rejoin and server hopping features.")
        
        cbtn("🔄 Rejoin Server", function()
            if F then
                showNotif("🔄 Rejoining", "Please wait...", 2)
                wait(1)
                F.Rejoin()
            end
        end)
        
        cbtn("🎲 Server Hop", function()
            if F then
                showNotif("🎲 Server Hop", "Finding new server...", 2)
                wait(1)
                F.ServerHop()
            end
        end)
        
        cspace(12)
        cinfo("🗑️ GUI Management", "Remove the script GUI completely. This will close the hub and reset ALL features to default.")
        
        cbtn("❌ Destroy GUI", function()
            if F then
                showNotif("🗑️ Destroying", "Resetting all features...", 2)
                wait(1)
                if PickaxeFeatures then
                    PickaxeFeatures:Cleanup()
                end
                F.DestroyGUI()
            end
        end)
        
        cthank()
    end)
    
    print("✅ Tab Contents Loaded!")
    print("📦 Total Tabs: 6 (Main, Player, Visual, Themes, Info, Settings)")
end

-- ═══════════════════════════════════════════════════════════════
-- 📦 RETURN MODULE
-- ═══════════════════════════════════════════════════════════════

return TabContents