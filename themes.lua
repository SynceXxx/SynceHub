-- SynceScriptHub | Theme System v1.0
-- 6 Beautiful Themes for Your Hub
-- GitHub: https://github.com/SynceXxx/SynceHub
-- File: themes.lua

local ThemeSystem = {}

-- ═══════════════════════════════════════════════════════════════
-- 🎨 THEME DEFINITIONS
-- ═══════════════════════════════════════════════════════════════

ThemeSystem.Themes = {
    -- 🌑 DEFAULT THEME (Dark & Professional)
    ["Default"] = {
        name = "Default",
        icon = "🌑",
        mainBg = Color3.fromRGB(18, 18, 22),
        headerBg = Color3.fromRGB(18, 18, 22),
        sidebarBg = Color3.fromRGB(35, 35, 40),
        contentBg = Color3.fromRGB(28, 28, 33),
        accentColor = Color3.fromRGB(160, 160, 170),
        textColor = Color3.fromRGB(200, 200, 205),
        borderColor = Color3.fromRGB(40, 40, 45),
        headerLine = Color3.fromRGB(45, 45, 50)
    },
    
    -- 🌌 GALAXY THEME (Purple Space)
    ["Galaxy"] = {
        name = "Galaxy",
        icon = "🌌",
        mainBg = Color3.fromRGB(15, 10, 35),
        headerBg = Color3.fromRGB(20, 15, 40),
        sidebarBg = Color3.fromRGB(40, 30, 70),
        contentBg = Color3.fromRGB(30, 20, 55),
        accentColor = Color3.fromRGB(150, 100, 255),
        textColor = Color3.fromRGB(220, 200, 255),
        borderColor = Color3.fromRGB(80, 50, 150),
        headerLine = Color3.fromRGB(100, 60, 180)
    },
    
    -- 🌊 BLUE OCEAN THEME (Deep Blue & Cyan)
    ["Blue Ocean"] = {
        name = "Blue Ocean",
        icon = "🌊",
        mainBg = Color3.fromRGB(10, 20, 35),
        headerBg = Color3.fromRGB(12, 25, 40),
        sidebarBg = Color3.fromRGB(20, 40, 70),
        contentBg = Color3.fromRGB(15, 30, 55),
        accentColor = Color3.fromRGB(0, 180, 255),
        textColor = Color3.fromRGB(180, 220, 255),
        borderColor = Color3.fromRGB(30, 80, 140),
        headerLine = Color3.fromRGB(40, 100, 180)
    },
    
    -- 💗 PINKY THEME (Cute Pink & Rose)
    ["Pinky"] = {
        name = "Pinky",
        icon = "💗",
        mainBg = Color3.fromRGB(30, 15, 25),
        headerBg = Color3.fromRGB(35, 18, 30),
        sidebarBg = Color3.fromRGB(60, 30, 50),
        contentBg = Color3.fromRGB(45, 22, 38),
        accentColor = Color3.fromRGB(255, 100, 180),
        textColor = Color3.fromRGB(255, 200, 230),
        borderColor = Color3.fromRGB(120, 50, 90),
        headerLine = Color3.fromRGB(150, 70, 120)
    },
    
    -- 🍵 GREEN MATCHA THEME (Calm Green)
    ["Green Matcha"] = {
        name = "Green Matcha",
        icon = "🍵",
        mainBg = Color3.fromRGB(15, 25, 18),
        headerBg = Color3.fromRGB(18, 28, 20),
        sidebarBg = Color3.fromRGB(30, 50, 35),
        contentBg = Color3.fromRGB(22, 38, 25),
        accentColor = Color3.fromRGB(120, 200, 140),
        textColor = Color3.fromRGB(200, 230, 210),
        borderColor = Color3.fromRGB(50, 100, 60),
        headerLine = Color3.fromRGB(70, 130, 80)
    },
    
    -- 🦆 YELLOW DUCK THEME (Bright Yellow)
    ["Yellow Duck"] = {
        name = "Yellow Duck",
        icon = "🦆",
        mainBg = Color3.fromRGB(35, 30, 10),
        headerBg = Color3.fromRGB(40, 35, 12),
        sidebarBg = Color3.fromRGB(70, 60, 20),
        contentBg = Color3.fromRGB(55, 48, 15),
        accentColor = Color3.fromRGB(255, 220, 80),
        textColor = Color3.fromRGB(255, 240, 180),
        borderColor = Color3.fromRGB(140, 120, 40),
        headerLine = Color3.fromRGB(180, 160, 60)
    }
}

-- ═══════════════════════════════════════════════════════════════
-- 🔧 THEME FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

-- Get theme by name
function ThemeSystem:GetTheme(themeName)
    return self.Themes[themeName] or self.Themes["Default"]
end

-- Get all theme names
function ThemeSystem:GetThemeNames()
    local names = {}
    for name, _ in pairs(self.Themes) do
        table.insert(names, name)
    end
    return names
end

-- Get theme count
function ThemeSystem:GetThemeCount()
    local count = 0
    for _ in pairs(self.Themes) do
        count = count + 1
    end
    return count
end

-- Apply theme to UI elements
function ThemeSystem:ApplyTheme(themeName, uiElements)
    local theme = self:GetTheme(themeName)
    local T = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Apply to Main Frame
    if uiElements.MainFrame then
        T:Create(uiElements.MainFrame, tweenInfo, {BackgroundColor3 = theme.mainBg}):Play()
    end
    
    -- Apply to Header
    if uiElements.Header then
        T:Create(uiElements.Header, tweenInfo, {BackgroundColor3 = theme.headerBg}):Play()
    end
    
    -- Apply to Header Cover
    if uiElements.HeaderCover then
        T:Create(uiElements.HeaderCover, tweenInfo, {BackgroundColor3 = theme.headerBg}):Play()
    end
    
    -- Apply to Header Line
    if uiElements.HeaderLine then
        T:Create(uiElements.HeaderLine, tweenInfo, {BackgroundColor3 = theme.headerLine}):Play()
    end
    
    -- Apply to Title
    if uiElements.Title then
        T:Create(uiElements.Title, tweenInfo, {TextColor3 = theme.textColor}):Play()
    end
    
    -- Apply to Vertical Line
    if uiElements.VerticalLine then
        T:Create(uiElements.VerticalLine, tweenInfo, {BackgroundColor3 = theme.borderColor}):Play()
    end
    
    -- Apply to Main Stroke
    if uiElements.MainStroke then
        T:Create(uiElements.MainStroke, tweenInfo, {Color = theme.borderColor}):Play()
    end
    
    -- Apply to Sidebar buttons
    if uiElements.Sidebar then
        for _, btn in pairs(uiElements.Sidebar:GetChildren()) do
            if btn:IsA("TextButton") then
                local isActive = (btn.Name == "ActiveTab")
                T:Create(btn, tweenInfo, {
                    BackgroundColor3 = isActive and theme.accentColor or theme.sidebarBg
                }):Play()
                
                local stroke = btn:FindFirstChildOfClass("UIStroke")
                if stroke then
                    T:Create(stroke, tweenInfo, {
                        Color = isActive and theme.accentColor or theme.borderColor
                    }):Play()
                end
                
                local frame = btn:FindFirstChild("Frame")
                if frame then
                    local lbl = frame:FindFirstChildOfClass("TextLabel")
                    if lbl then
                        T:Create(lbl, tweenInfo, {
                            TextColor3 = isActive and Color3.fromRGB(25, 25, 30) or theme.textColor
                        }):Play()
                    end
                    
                    local ico = frame:FindFirstChildOfClass("ImageLabel")
                    if ico then
                        T:Create(ico, tweenInfo, {
                            ImageColor3 = isActive and Color3.fromRGB(25, 25, 30) or theme.textColor
                        }):Play()
                    end
                end
            end
        end
    end
    
    -- Apply to Content Area
    if uiElements.ContentArea then
        for _, item in pairs(uiElements.ContentArea:GetChildren()) do
            if item:IsA("Frame") then
                T:Create(item, tweenInfo, {BackgroundColor3 = theme.contentBg}):Play()
                
                local stroke = item:FindFirstChildOfClass("UIStroke")
                if stroke then
                    T:Create(stroke, tweenInfo, {Color = theme.borderColor}):Play()
                end
                
                -- Apply to all descendants
                for _, child in pairs(item:GetDescendants()) do
                    if child:IsA("TextLabel") then
                        T:Create(child, tweenInfo, {TextColor3 = theme.textColor}):Play()
                    elseif child:IsA("TextButton") then
                        local btnStroke = child:FindFirstChildOfClass("UIStroke")
                        if btnStroke then
                            T:Create(btnStroke, tweenInfo, {Color = theme.borderColor}):Play()
                        end
                        
                        local btnBg = child:FindFirstChild("BackgroundFrame")
                        if btnBg then
                            T:Create(btnBg, tweenInfo, {BackgroundColor3 = theme.sidebarBg}):Play()
                        end
                    elseif child:IsA("TextBox") then
                        T:Create(child, tweenInfo, {TextColor3 = theme.textColor}):Play()
                        
                        local boxBg = child.Parent:FindFirstChild("BackgroundFrame")
                        if boxBg then
                            T:Create(boxBg, tweenInfo, {BackgroundColor3 = theme.sidebarBg}):Play()
                        end
                    elseif child:IsA("Frame") and child.Name:find("Slider") then
                        T:Create(child, tweenInfo, {BackgroundColor3 = theme.sidebarBg}):Play()
                        
                        local fill = child:FindFirstChild("Fill")
                        if fill then
                            T:Create(fill, tweenInfo, {BackgroundColor3 = theme.accentColor}):Play()
                        end
                    end
                end
            end
        end
    end
    
    return true
end

-- Create theme selector dropdown
function ThemeSystem:CreateThemeSelector(parent, currentTheme, onThemeChange)
    local theme = self:GetTheme(currentTheme)
    
    local selectorFrame = Instance.new("Frame")
    selectorFrame.Size = UDim2.new(1, 0, 0, 44)
    selectorFrame.BackgroundColor3 = theme.contentBg
    selectorFrame.BorderSizePixel = 0
    selectorFrame.ZIndex = 3
    selectorFrame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = selectorFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.borderColor
    stroke.Thickness = 1
    stroke.Parent = selectorFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "🎨 Theme"
    label.TextColor3 = theme.textColor
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    label.Parent = selectorFrame
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 140, 0, 28)
    button.Position = UDim2.new(1, -148, 0.5, -14)
    button.BackgroundColor3 = theme.sidebarBg
    button.Text = theme.icon .. " " .. currentTheme
    button.TextColor3 = theme.textColor
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = false
    button.ZIndex = 4
    button.Parent = selectorFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button
    
    -- Dropdown logic
    local isOpen = false
    local dropdown
    
    button.MouseButton1Click:Connect(function()
        if isOpen then
            -- Close dropdown
            if dropdown then
                dropdown:Destroy()
                dropdown = nil
            end
            isOpen = false
        else
            -- Open dropdown
            dropdown = Instance.new("Frame")
            dropdown.Size = UDim2.new(0, 140, 0, self:GetThemeCount() * 36)
            dropdown.Position = UDim2.new(1, -148, 1, 4)
            dropdown.BackgroundColor3 = theme.contentBg
            dropdown.BorderSizePixel = 0
            dropdown.ZIndex = 10
            dropdown.Parent = selectorFrame
            
            local dropCorner = Instance.new("UICorner")
            dropCorner.CornerRadius = UDim.new(0, 6)
            dropCorner.Parent = dropdown
            
            local dropStroke = Instance.new("UIStroke")
            dropStroke.Color = theme.borderColor
            dropStroke.Thickness = 1
            dropStroke.Parent = dropdown
            
            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 2)
            layout.Parent = dropdown
            
            for name, themeData in pairs(self.Themes) do
                local option = Instance.new("TextButton")
                option.Size = UDim2.new(1, -4, 0, 32)
                option.BackgroundColor3 = theme.sidebarBg
                option.Text = themeData.icon .. " " .. name
                option.TextColor3 = theme.textColor
                option.TextSize = 10
                option.Font = Enum.Font.Gotham
                option.AutoButtonColor = false
                option.ZIndex = 11
                option.Parent = dropdown
                
                local optCorner = Instance.new("UICorner")
                optCorner.CornerRadius = UDim.new(0, 4)
                optCorner.Parent = option
                
                option.MouseEnter:Connect(function()
                    option.BackgroundColor3 = themeData.accentColor
                    option.TextColor3 = Color3.fromRGB(25, 25, 30)
                end)
                
                option.MouseLeave:Connect(function()
                    option.BackgroundColor3 = theme.sidebarBg
                    option.TextColor3 = theme.textColor
                end)
                
                option.MouseButton1Click:Connect(function()
                    button.Text = themeData.icon .. " " .. name
                    if onThemeChange then
                        onThemeChange(name)
                    end
                    dropdown:Destroy()
                    dropdown = nil
                    isOpen = false
                end)
            end
            
            isOpen = true
        end
    end)
    
    return selectorFrame
end

-- ═══════════════════════════════════════════════════════════════
-- 📦 RETURN MODULE
-- ═══════════════════════════════════════════════════════════════

print("✅ Theme System Loaded!")
print("📦 Total Themes: " .. ThemeSystem:GetThemeCount())
print("🎨 Available Themes:")
for _, name in pairs(ThemeSystem:GetThemeNames()) do
    local theme = ThemeSystem:GetTheme(name)
    print("   " .. theme.icon .. " " .. name)
end

return ThemeSystem