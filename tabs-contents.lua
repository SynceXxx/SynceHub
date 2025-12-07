-- SynceScriptHub | Tab Contents v1.1
-- All Tab Contents in One External File
-- GitHub: https://github.com/SynceXxx/SynceHub
-- File: tabs-content.lua

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
    -- 🎮 MOUNT TAB
    -- ═══════════════════════════════════════════════════════════════
    
    csb("Mount","mount",function()cc()setActiveTab("Mount")if not _G.MountSystem then _G.MountSystem={RecordedPositions={},IsRecording=false,IsReplaying=false,AutoCPEnabled=false,CurrentSpeed=16}end;local M=_G.MountSystem;cinfo("🎮 Mount System","Advanced path recording and auto checkpoint system. Record your movements and replay them automatically!")cspace(4)cinfo("📹 Path Recording","Record your character's movement path to replay later.")cbtn("🔴 Start Recording",function()if M.IsRecording then showNotif("⚠️ Already Recording","Stop current recording first!",2)return end;M.IsRecording=true;M.RecordedPositions={}local p=game.Players.LocalPlayer;local c=p.Character or p.CharacterAdded:Wait()task.spawn(function()while M.IsRecording do if not c or not c.Parent then c=p.Character or p.CharacterAdded:Wait()end;local h=c:FindFirstChild("HumanoidRootPart")if h then table.insert(M.RecordedPositions,{Position=h.CFrame.Position,Orientation=h.CFrame.LookVector,Time=tick()})end;task.wait(0.1)end end)playSound(6895079853,0.4,1.2)showNotif("🔴 Recording","Path recording started!",2)end)cbtn("⏹️ Stop Recording",function()if not M.IsRecording then showNotif("⚠️ Not Recording","No active recording to stop!",2)return end;M.IsRecording=false;local w=#M.RecordedPositions;local d=0;if w>0 then d=M.RecordedPositions[w].Time-M.RecordedPositions[1].Time end;playSound(6895079853,0.4,0.9)showNotif("⏹️ Stopped",string.format("Recorded %d waypoints (%.1fs)",w,d),3)end)cspace(8)cinfo("▶️ Path Replay","Replay your recorded path. You can loop it or play once.")cslider("⚡ Replay Speed",1,100,16,function(v)M.CurrentSpeed=v end)cbtn("▶️ Play Once",function()if #M.RecordedPositions==0 then showNotif("❌ No Recording","Record a path first!",2)return end;if M.IsReplaying then showNotif("⚠️ Already Playing","Stop current replay first!",2)return end;M.IsReplaying=true;task.spawn(function()local p=game.Players.LocalPlayer;local c=p.Character or p.CharacterAdded:Wait()local h=c:WaitForChild("HumanoidRootPart")local hu=c:WaitForChild("Humanoid")local o=hu.WalkSpeed;hu.WalkSpeed=M.CurrentSpeed;for i,w in ipairs(M.RecordedPositions)do if not M.IsReplaying then break end;h.CFrame=CFrame.new(w.Position,w.Position+w.Orientation)task.wait(0.1)end;hu.WalkSpeed=o;M.IsReplaying=false;showNotif("✅ Finished","Replay completed!",2)end)playSound(6895079853,0.4,1.3)showNotif("▶️ Playing","Replaying recorded path...",2)end)ctg("🔁 Loop Replay",false,function(v)if v then if #M.RecordedPositions==0 then showNotif("❌ No Recording","Record a path first!",2)return end;M.IsReplaying=true;task.spawn(function()local p=game.Players.LocalPlayer;while M.IsReplaying do local c=p.Character;if not c then c=p.CharacterAdded:Wait()end;local h=c:FindFirstChild("HumanoidRootPart")local hu=c:FindFirstChild("Humanoid")if h and hu then hu.WalkSpeed=M.CurrentSpeed;for i,w in ipairs(M.RecordedPositions)do if not M.IsReplaying then break end;h.CFrame=CFrame.new(w.Position,w.Position+w.Orientation)task.wait(0.1)end end;task.wait(0.5)end end)showNotif("🔁 Loop ON","Looping replay started!",2)else M.IsReplaying=false;showNotif("⏹️ Loop OFF","Loop replay stopped!",2)end end)cbtn("⏹️ Stop Replay",function()if not M.IsReplaying then showNotif("⚠️ Not Playing","No active replay to stop!",2)return end;M.IsReplaying=false;local p=game.Players.LocalPlayer;if p.Character then local hu=p.Character:FindFirstChild("Humanoid")if hu then hu.WalkSpeed=16 end end;playSound(6895079853,0.4,0.8)showNotif("⏹️ Stopped","Replay stopped!",2)end)cspace(8)cinfo("🎯 Auto Checkpoint","Automatically touch nearby checkpoints. Works in most obby/parkour games.")ctg("🎯 Auto Touch Checkpoints",false,function(v)M.AutoCPEnabled=v;if v then task.spawn(function()local p=game.Players.LocalPlayer;while M.AutoCPEnabled do local c=p.Character;if c then local h=c:FindFirstChild("HumanoidRootPart")if h then local f={workspace:FindFirstChild("Checkpoints"),workspace:FindFirstChild("Stages"),workspace:FindFirstChild("Parts"),workspace:FindFirstChild("Checkpoint")}for _,folder in pairs(f)do if folder then for _,cp in pairs(folder:GetChildren())do if cp:IsA("BasePart")then local d=(h.Position-cp.Position).Magnitude;if d<50 then h.CFrame=cp.CFrame;task.wait(0.1)pcall(function()firetouchinterest(h,cp,0)task.wait(0.05)firetouchinterest(h,cp,1)end)end end end end end end end;task.wait(0.5)end end)showNotif("🎯 Auto CP ON","Auto checkpoint enabled!",2)else showNotif("⏹️ Auto CP OFF","Auto checkpoint disabled!",2)end end)cspace(8)cinfo("💾 Recording Management","Export and import your recorded paths for later use.")cbtn("📤 Export Recording",function()if #M.RecordedPositions==0 then showNotif("❌ No Recording","Nothing to export!",2)return end;local H=game:GetService("HttpService")local s,j=pcall(function()return H:JSONEncode(M.RecordedPositions)end)if s then pcall(function()setclipboard(j)end)print("📋 Recording exported:")print(j)showNotif("✅ Exported","Recording copied to clipboard!",3)else showNotif("❌ Export Failed","Failed to export recording!",2)end end)local ibox=ctxinp("📥 Import Recording","Paste JSON here...",function(t)if t==""then showNotif("⚠️ Empty","Paste recording data first!",2)return end;local H=game:GetService("HttpService")local s,r=pcall(function()return H:JSONDecode(t)end)if s and type(r)=="table"then M.RecordedPositions=r;showNotif("✅ Imported",string.format("Loaded %d waypoints!",#r),3)ibox.Text=""else showNotif("❌ Import Failed","Invalid recording data!",2)end end)cbtn("🗑️ Clear Recording",function()if #M.RecordedPositions==0 then showNotif("⚠️ Already Empty","No recording to clear!",2)return end;local w=#M.RecordedPositions;M.RecordedPositions={}showNotif("🗑️ Cleared",string.format("Cleared %d waypoints!",w),2)end)cspace(8)cinfo("ℹ️ Current Recording Info",string.format("Waypoints: %d\nRecording: %s\nReplaying: %s\nAuto CP: %s",#M.RecordedPositions,M.IsRecording and"🔴 Yes"or"⚪ No",M.IsReplaying and"▶️ Yes"or"⚪ No",M.AutoCPEnabled and"🎯 Enabled"or"⚪ Disabled"))cspace(4)cinfo("💡 Tips & Usage","• Press 'Start Recording' and walk your desired path\n• Press 'Stop Recording' when done\n• Use 'Play Once' to test your recording\n• Enable 'Loop Replay' for continuous farming\n• Adjust 'Replay Speed' for faster/slower movement\n• Export your recording to save it for later\n• Auto Touch Checkpoints works independently")cthank()end)
    
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
        
        cinfo("⚡ Current Features", "Player Modifications:\n• WalkSpeed (16-500)\n• JumpPower (50-500)\n• Infinite Jump\n• Fly Mode with Mobile UI\n• Noclip (Walk through walls)\n• Invisible Character\n• Teleport to Player (Dropdown List)\n\nMount System:\n• Path Recording & Replay\n• Loop Replay Mode\n• Adjustable Replay Speed\n• Auto Touch Checkpoints\n• Export/Import Recordings\n\nVisual Enhancements:\n• Fullbright with Slider (0-100)\n• Remove Fog Toggle\n• Custom Nametag with RGB + Rainbow\n\nThemes (" .. ThemeSystem:GetThemeCount() .. " Available):\n" .. themeList .. "\nServer Options:\n• Rejoin Current Server\n• Server Hop to New Server\n• Anti-AFK Protection")
        
        cinfo("📌 Version Information", "Version: 2.6 (MOUNT UPDATE)\nLast Updated: December 2024\nStatus: Stable Release\n\nNew in v2.6:\n✅ Mount Tab Added (Auto CP System)\n✅ Path Recording & Replay\n✅ Auto Touch Checkpoints\n✅ Export/Import Recordings\n\nAll features:\n• Client-side features\n• Mobile-friendly UI\n• Smooth performance\n• Multi-theme support\n• Full feature reset on destroy")
        
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
                F.DestroyGUI()
            end
        end)
        
        cthank()
    end)
    
    print("✅ Tab Contents Loaded!")
    print("📦 Total Tabs: 6 (Player, Visual, Mount, Themes, Info, Settings)")
end

-- ═══════════════════════════════════════════════════════════════
-- 📦 RETURN MODULE
-- ═════════════════════════════════════════════════════════

return TabContents
