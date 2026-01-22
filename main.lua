-- =============================================
-- BLOX FRUIT AUTO FRUIT SELECTOR
-- Enhancement for HOHO_H Script
-- Author: DarkForge-X
-- =============================================

-- First, load the original HOHO_H script
local OriginalScriptLoaded = false
local OriginalScriptError = nil

-- Try to load original script
pcall(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ascn123/HOHO_H/main/Loading_UI'))()
    OriginalScriptLoaded = true
    print("[Auto Fruit] Original HOHO_H script loaded successfully!")
end)

if not OriginalScriptLoaded then
    warn("[Auto Fruit] Failed to load original HOHO_H script")
    warn("[Auto Fruit] Loading standalone version...")
    
    -- Fallback: Create basic GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloxFruitAuto"
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    
    ScreenGui.Parent = game:GetService("CoreGui")
    MainFrame.Parent = ScreenGui
end

-- =============================================
-- FRUIT DATABASE FOR BLOX FRUIT
-- =============================================

local FruitDatabase = {
    -- Common Fruits
    ["Bomb"] = {
        Name = "Bomb",
        Rarity = "Common",
        Skills = {"Explosion", "Bomb Rush"},
        Priority = 1
    },
    ["Spike"] = {
        Name = "Spike",
        Rarity = "Common",
        Skills = {"Spike Barrage", "Spike Field"},
        Priority = 2
    },
    ["Chop"] = {
        Name = "Chop",
        Rarity = "Common",
        Skills = {"Chop Barrage", "Chop Tornado"},
        Priority = 3
    },
    ["Spring"] = {
        Name = "Spring",
        Rarity = "Common",
        Skills = {"Spring Shot", "Spring Jump"},
        Priority = 4
    },
    ["Kilo"] = {
        Name = "Kilo",
        Rarity = "Common",
        Skills = {"Kilo Press", "Kilo Rush"},
        Priority = 5
    },
    ["Smoke"] = {
        Name = "Smoke",
        Rarity = "Common",
        Skills = {"Smoke Bomb", "Smoke Cloud"},
        Priority = 6
    },
    ["Spin"] = {
        Name = "Spin",
        Rarity = "Common",
        Skills = {"Spin Slash", "Spin Rush"},
        Priority = 7
    },
    
    -- Uncommon Fruits
    ["Flame"] = {
        Name = "Flame",
        Rarity = "Uncommon",
        Skills = {"Fire Beam", "Fire Fist"},
        Priority = 8
    },
    ["Ice"] = {
        Name = "Ice",
        Rarity = "Uncommon",
        Skills = {"Ice Shard", "Ice Floor"},
        Priority = 9
    },
    ["Sand"] = {
        Name = "Sand",
        Rarity = "Uncommon",
        Skills = {"Sand Shower", "Sand Clone"},
        Priority = 10
    },
    ["Dark"] = {
        Name = "Dark",
        Rarity = "Uncommon",
        Skills = {"Dark Ball", "Dark Flight"},
        Priority = 11
    },
    ["Diamond"] = {
        Name = "Diamond",
        Rarity = "Uncommon",
        Skills = {"Diamond Storm", "Diamond Armor"},
        Priority = 12
    },
    ["Light"] = {
        Name = "Light",
        Rarity = "Uncommon",
        Skills = {"Light Beam", "Light Speed"},
        Priority = 13
    },
    ["Rubber"] = {
        Name = "Rubber",
        Rarity = "Uncommon",
        Skills = {"Rubber Ball", "Rubber Storm"},
        Priority = 14
    },
    ["Barrier"] = {
        Name = "Barrier",
        Rarity = "Uncommon",
        Skills = {"Barrier Wall", "Barrier Push"},
        Priority = 15
    },
    ["Ghost"] = {
        Name = "Ghost",
        Rarity = "Uncommon",
        Skills = {"Ghost Dash", "Ghost Form"},
        Priority = 16
    },
    
    -- Rare Fruits
    ["Magma"] = {
        Name = "Magma",
        Rarity = "Rare",
        Skills = {"Magma Fist", "Magma Rain"},
        Priority = 17
    },
    ["Quake"] = {
        Name = "Quake",
        Rarity = "Rare",
        Skills = {"Quake Slam", "Quake Wave"},
        Priority = 18
    },
    ["Buddha"] = {
        Name = "Buddha",
        Rarity = "Rare",
        Skills = {"Buddha Palm", "Buddha Form"},
        Priority = 19
    },
    ["Love"] = {
        Name = "Love",
        Rarity = "Rare",
        Skills = {"Love Beam", "Love Heart"},
        Priority = 20
    },
    ["Spider"] = {
        Name = "Spider",
        Rarity = "Rare",
        Skills = {"Spider Web", "Spider Climb"},
        Priority = 21
    },
    ["Sound"] = {
        Name = "Sound",
        Rarity = "Rare",
        Skills = {"Sound Wave", "Sound Rush"},
        Priority = 22
    },
    ["Phoenix"] = {
        Name = "Phoenix",
        Rarity = "Rare",
        Skills = {"Phoenix Flame", "Phoenix Flight"},
        Priority = 23
    },
    ["Portal"] = {
        Name = "Portal",
        Rarity = "Rare",
        Skills = {"Portal Launch", "Portal Warp"},
        Priority = 24
    },
    ["Rumble"] = {
        Name = "Rumble",
        Rarity = "Rare",
        Skills = {"Rumble Slam", "Rumble Storm"},
        Priority = 25
    },
    ["Pain"] = {
        Name = "Pain",
        Rarity = "Rare",
        Skills = {"Pain Ball", "Pain Field"},
        Priority = 26
    },
    ["Blizzard"] = {
        Name = "Blizzard",
        Rarity = "Rare",
        Skills = {"Blizzard Wind", "Blizzard Storm"},
        Priority = 27
    },
    ["Gravity"] = {
        Name = "Gravity",
        Rarity = "Rare",
        Skills = {"Gravity Push", "Gravity Crush"},
        Priority = 28
    },
    
    -- Legendary Fruits
    ["Dragon"] = {
        Name = "Dragon",
        Rarity = "Legendary",
        Skills = {"Dragon Breath", "Dragon Flight"},
        Priority = 29
    },
    ["Soul"] = {
        Name = "Soul",
        Rarity = "Legendary",
        Skills = {"Soul Punishment", "Soul Absorption"},
        Priority = 30
    },
    ["Venom"] = {
        Name = "Venom",
        Rarity = "Legendary",
        Skills = {"Venom Spray", "Venom Pool"},
        Priority = 31
    },
    ["Shadow"] = {
        Name = "Shadow",
        Rarity = "Legendary",
        Skills = {"Shadow Slash", "Shadow Clone"},
        Priority = 32
    },
    ["Control"] = {
        Name = "Control",
        Rarity = "Legendary",
        Skills = {"Control Throw", "Control Flight"},
        Priority = 33
    },
    
    -- Mythical Fruits
    ["Dough"] = {
        Name = "Dough",
        Rarity = "Mythical",
        Skills = {"Dough Ball", "Dough Flight"},
        Priority = 34
    },
    ["Leopard"] = {
        Name = "Leopard",
        Rarity = "Mythical",
        Skills = {"Leopard Slash", "Leopard Rush"},
        Priority = 35
    },
    ["Kitsune"] = {
        Name = "Kitsune",
        Rarity = "Mythical",
        Skills = {"Kitsune Flame", "Kitsune Form"},
        Priority = 36
    },
    ["T-Rex"] = {
        Name = "T-Rex",
        Rarity = "Mythical",
        Skills = {"T-Rex Bite", "T-Rex Rush"},
        Priority = 37
    },
    ["Mammoth"] = {
        Name = "Mammoth",
        Rarity = "Mythical",
        Skills = {"Mammoth Slam", "Mammoth Charge"},
        Priority = 38
    },
    
    -- Special Fruits
    ["Human: Buddha"] = {
        Name = "Human: Buddha",
        Rarity = "Special",
        Skills = {"Buddha Transformation"},
        Priority = 39
    },
    ["Gum"] = {
        Name = "Gum",
        Rarity = "Special",
        Skills = {"Gum Shot", "Gum Ball"},
        Priority = 40
    },
    ["Falcon"] = {
        Name = "Falcon",
        Rarity = "Special",
        Skills = {"Falcon Dive", "Falcon Rush"},
        Priority = 41
    },
    ["Electric"] = {
        Name = "Electric",
        Rarity = "Special",
        Skills = {"Electric Beam", "Electric Storm"},
        Priority = 42
    }
}

-- =============================================
-- AUTO FRUIT SELECTOR MODULE
-- =============================================

local FruitSelector = {
    SelectedFruit = nil,
    AutoUse = false,
    AutoUseInterval = 0.5, -- seconds
    UseKey = Enum.KeyCode.F, -- Default key for fruit ability
    AvailableFruits = {},
    
    -- Scan player's inventory for fruits
    ScanInventory = function(self)
        self.AvailableFruits = {}
        
        local player = game:GetService("Players").LocalPlayer
        if not player then return end
        
        -- Check backpack
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, item in pairs(backpack:GetChildren()) do
                if item:IsA("Tool") then
                    local fruitName = item.Name
                    if FruitDatabase[fruitName] then
                        table.insert(self.AvailableFruits, {
                            Tool = item,
                            Data = FruitDatabase[fruitName],
                            Instance = item
                        })
                    end
                end
            end
        end
        
        -- Check character
        local character = player.Character
        if character then
            for _, item in pairs(character:GetChildren()) do
                if item:IsA("Tool") then
                    local fruitName = item.Name
                    if FruitDatabase[fruitName] then
                        table.insert(self.AvailableFruits, {
                            Tool = item,
                            Data = FruitDatabase[fruitName],
                            Instance = item
                        })
                    end
                end
            end
        end
        
        return self.AvailableFruits
    end,
    
    -- Select a fruit by name
    SelectFruitByName = function(self, fruitName)
        self:ScanInventory()
        
        for _, fruitData in pairs(self.AvailableFruits) do
            if fruitData.Data.Name == fruitName then
                self.SelectedFruit = fruitData
                print("[Fruit Selector] Selected:", fruitName)
                return true
            end
        end
        
        print("[Fruit Selector] Fruit not found:", fruitName)
        return false
    end,
    
    -- Select fruit by tool instance
    SelectFruitByTool = function(self, tool)
        self:ScanInventory()
        
        for _, fruitData in pairs(self.AvailableFruits) do
            if fruitData.Tool == tool or fruitData.Instance == tool then
                self.SelectedFruit = fruitData
                print("[Fruit Selector] Selected:", fruitData.Data.Name)
                return true
            end
        end
        
        return false
    end,
    
    -- Auto-use selected fruit
    AutoUseSelectedFruit = function(self)
        if not self.SelectedFruit or not self.AutoUse then
            return
        end
        
        local tool = self.SelectedFruit.Tool
        if not tool or not tool.Parent then
            print("[Fruit Selector] Tool not available")
            self.AutoUse = false
            return
        end
        
        -- Equip the fruit tool
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if not character then return end
        
        -- Make sure tool is equipped
        if tool.Parent ~= character then
            tool.Parent = character
            task.wait(0.2)
        end
        
        -- Activate the tool (use fruit ability)
        local success = pcall(function()
            tool:Activate()
        end)
        
        if not success then
            -- Try alternative activation method
            pcall(function()
                -- Simulate key press for fruit ability
                game:GetService("VirtualInputManager"):SendKeyEvent(true, self.UseKey, false, game)
                task.wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, self.UseKey, false, game)
            end)
        end
        
        return success
    end,
    
    -- Start auto-use loop
    StartAutoUse = function(self)
        if self.AutoUse then return end
        
        self.AutoUse = true
        print("[Fruit Selector] Auto-use started")
        
        spawn(function()
            while self.AutoUse do
                if self.SelectedFruit then
                    self:AutoUseSelectedFruit()
                end
                task.wait(self.AutoUseInterval)
            end
        end)
    end,
    
    -- Stop auto-use
    StopAutoUse = function(self)
        self.AutoUse = false
        print("[Fruit Selector] Auto-use stopped")
    end,
    
    -- Get fruit rarity color
    GetRarityColor = function(self, rarity)
        local colors = {
            ["Common"] = Color3.fromRGB(180, 180, 180),
            ["Uncommon"] = Color3.fromRGB(0, 170, 0),
            ["Rare"] = Color3.fromRGB(0, 112, 221),
            ["Legendary"] = Color3.fromRGB(163, 53, 238),
            ["Mythical"] = Color3.fromRGB(255, 128, 0),
            ["Special"] = Color3.fromRGB(255, 215, 0)
        }
        return colors[rarity] or Color3.fromRGB(255, 255, 255)
    end
}

-- =============================================
-- ENHANCED GUI FOR FRUIT SELECTION
-- =============================================

local function CreateEnhancedGUI()
    -- Wait for original GUI to load
    task.wait(2)
    
    -- Create our enhanced GUI
    local EnhancedGUI = Instance.new("ScreenGui")
    EnhancedGUI.Name = "FruitSelectorGUI"
    EnhancedGUI.ResetOnSpawn = false
    EnhancedGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if syn and syn.protect_gui then
        syn.protect_gui(EnhancedGUI)
    elseif gethui then
        EnhancedGUI.Parent = gethui()
    else
        EnhancedGUI.Parent = game:GetService("CoreGui")
    end
    
    -- Main Container
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Size = UDim2.new(0, 350, 0, 500)
    MainContainer.Position = UDim2.new(0, 20, 0.5, -250)
    MainContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainContainer.BackgroundTransparency = 0.1
    MainContainer.BorderSizePixel = 0
    
    -- Stroke
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255, 0, 255)
    Stroke.Thickness = 2
    Stroke.Parent = MainContainer
    
    -- Corner
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.05, 0)
    Corner.Parent = MainContainer
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(45, 0, 75)
    TitleBar.BackgroundTransparency = 0.2
    TitleBar.Parent = MainContainer
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0.05, 0, 0, 0)
    TitleCorner.Parent = TitleBar
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(0, 250, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🍎 AUTO FRUIT SELECTOR"
    TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 1, 0)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    
    -- Toggle Button
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 40, 1, 0)
    ToggleButton.Position = UDim2.new(1, -80, 0, 0)
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Text = "─"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 100)
    ToggleButton.TextSize = 18
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Parent = TitleBar
    
    -- Content Area
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Size = UDim2.new(1, -20, 1, -60)
    ScrollFrame.Position = UDim2.new(0, 10, 0, 50)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.ScrollBarThickness = 5
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollFrame.Parent = MainContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = ScrollFrame
    
    -- Section: Selected Fruit Display
    local SelectedSection = Instance.new("Frame")
    SelectedSection.Name = "SelectedSection"
    SelectedSection.Size = UDim2.new(1, 0, 0, 80)
    SelectedSection.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    SelectedSection.BackgroundTransparency = 0.3
    SelectedSection.BorderSizePixel = 0
    
    local SelectedCorner = Instance.new("UICorner")
    SelectedCorner.CornerRadius = UDim.new(0.05, 0)
    SelectedCorner.Parent = SelectedSection
    
    local SelectedTitle = Instance.new("TextLabel")
    SelectedTitle.Name = "SelectedTitle"
    SelectedTitle.Size = UDim2.new(1, -20, 0, 25)
    SelectedTitle.Position = UDim2.new(0, 10, 0, 5)
    SelectedTitle.BackgroundTransparency = 1
    SelectedTitle.Text = "SELECTED FRUIT:"
    SelectedTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    SelectedTitle.TextSize = 14
    SelectedTitle.Font = Enum.Font.GothamBold
    SelectedTitle.TextXAlignment = Enum.TextXAlignment.Left
    SelectedTitle.Parent = SelectedSection
    
    local SelectedName = Instance.new("TextLabel")
    SelectedName.Name = "SelectedName"
    SelectedName.Size = UDim2.new(1, -20, 0, 30)
    SelectedName.Position = UDim2.new(0, 10, 0, 30)
    SelectedName.BackgroundTransparency = 1
    SelectedName.Text = "None"
    SelectedName.TextColor3 = Color3.fromRGB(255, 255, 255)
    SelectedName.TextSize = 20
    SelectedName.Font = Enum.Font.GothamBold
    SelectedName.TextXAlignment = Enum.TextXAlignment.Left
    SelectedName.Parent = SelectedSection
    
    local SelectedRarity = Instance.new("TextLabel")
    SelectedRarity.Name = "SelectedRarity"
    SelectedRarity.Size = UDim2.new(0.5, -10, 0, 20)
    SelectedRarity.Position = UDim2.new(0, 10, 0, 60)
    SelectedRarity.BackgroundTransparency = 1
    SelectedRarity.Text = "Rarity: -"
    SelectedRarity.TextColor3 = Color3.fromRGB(180, 180, 180)
    SelectedRarity.TextSize = 12
    SelectedRarity.Font = Enum.Font.Gotham
    SelectedRarity.TextXAlignment = Enum.TextXAlignment.Left
    SelectedRarity.Parent = SelectedSection
    
    SelectedSection.Parent = ScrollFrame
    
    -- Section: Auto-Use Controls
    local ControlSection = Instance.new("Frame")
    ControlSection.Name = "ControlSection"
    ControlSection.Size = UDim2.new(1, 0, 0, 120)
    ControlSection.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    ControlSection.BackgroundTransparency = 0.3
    ControlSection.BorderSizePixel = 0
    
    local ControlCorner = Instance.new("UICorner")
    ControlCorner.CornerRadius = UDim.new(0.05, 0)
    ControlCorner.Parent = ControlSection
    
    local ControlTitle = Instance.new("TextLabel")
    ControlTitle.Name = "ControlTitle"
    ControlTitle.Size = UDim2.new(1, -20, 0, 25)
    ControlTitle.Position = UDim2.new(0, 10, 0, 5)
    ControlTitle.BackgroundTransparency = 1
    ControlTitle.Text = "AUTO-USE CONTROLS"
    ControlTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    ControlTitle.TextSize = 14
    ControlTitle.Font = Enum.Font.GothamBold
    ControlTitle.TextXAlignment = Enum.TextXAlignment.Left
    ControlTitle.Parent = ControlSection
    
    -- AUTO-USE TOGGLE BUTTON (Anak panah komputer)
    local AutoUseToggle = Instance.new("TextButton")
    AutoUseToggle.Name = "AutoUseToggle"
    AutoUseToggle.Size = UDim2.new(0, 180, 0, 40)
    AutoUseToggle.Position = UDim2.new(0.5, -90, 0, 35)
    AutoUseToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    AutoUseToggle.Text = "▶ AUTO USE: OFF"
    AutoUseToggle.TextColor3 = Color3.new(1, 1, 1)
    AutoUseToggle.TextSize = 14
    AutoUseToggle.Font = Enum.Font.GothamBold
    
    local AutoUseCorner = Instance.new("UICorner")
    AutoUseCorner.CornerRadius = UDim.new(0.1, 0)
    AutoUseCorner.Parent = AutoUseToggle
    
    local AutoUseStroke = Instance.new("UIStroke")
    AutoUseStroke.Color = Color3.fromRGB(255, 255, 255)
    AutoUseStroke.Thickness = 2
    AutoUseStroke.Parent = AutoUseToggle
    
    -- Auto-use status
    local AutoUseStatus = Instance.new("TextLabel")
    AutoUseStatus.Name = "AutoUseStatus"
    AutoUseStatus.Size = UDim2.new(1, -20, 0, 20)
    AutoUseStatus.Position = UDim2.new(0, 10, 0, 85)
    AutoUseStatus.BackgroundTransparency = 1
    AutoUseStatus.Text = "Status: Ready"
    AutoUseStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
    AutoUseStatus.TextSize = 12
    AutoUseStatus.Font = Enum.Font.Gotham
    AutoUseStatus.TextXAlignment = Enum.TextXAlignment.Left
    AutoUseStatus.Parent = ControlSection
    
    AutoUseToggle.Parent = ControlSection
    ControlSection.Parent = ScrollFrame
    
    -- Section: Available Fruits
    local FruitsSection = Instance.new("Frame")
    FruitsSection.Name = "FruitsSection"
    FruitsSection.Size = UDim2.new(1, 0, 0, 250)
    FruitsSection.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    FruitsSection.BackgroundTransparency = 0.3
    FruitsSection.BorderSizePixel = 0
    
    local FruitsCorner = Instance.new("UICorner")
    FruitsCorner.CornerRadius = UDim.new(0.05, 0)
    FruitsCorner.Parent = FruitsSection
    
    local FruitsTitle = Instance.new("TextLabel")
    FruitsTitle.Name = "FruitsTitle"
    FruitsTitle.Size = UDim2.new(1, -20, 0, 25)
    FruitsTitle.Position = UDim2.new(0, 10, 0, 5)
    FruitsTitle.BackgroundTransparency = 1
    FruitsTitle.Text = "AVAILABLE FRUITS"
    FruitsTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    FruitsTitle.TextSize = 14
    FruitsTitle.Font = Enum.Font.GothamBold
    FruitsTitle.TextXAlignment = Enum.TextXAlignment.Left
    FruitsTitle.Parent = FruitsSection
    
    local FruitsScroll = Instance.new("ScrollingFrame")
    FruitsScroll.Name = "FruitsScroll"
    FruitsScroll.Size = UDim2.new(1, -20, 0, 215)
    FruitsScroll.Position = UDim2.new(0, 10, 0, 35)
    FruitsScroll.BackgroundTransparency = 1
    FruitsScroll.ScrollBarThickness = 4
    FruitsScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
    FruitsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    FruitsScroll.Parent = FruitsSection
    
    local FruitsListLayout = Instance.new("UIListLayout")
    FruitsListLayout.Padding = UDim.new(0, 5)
    FruitsListLayout.Parent = FruitsScroll
    
    FruitsSection.Parent = ScrollFrame
    
    -- Refresh Button
    local RefreshButton = Instance.new("TextButton")
    RefreshButton.Name = "RefreshButton"
    RefreshButton.Size = UDim2.new(1, -20, 0, 35)
    RefreshButton.Position = UDim2.new(0, 10, 0, 10)
    RefreshButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    RefreshButton.BackgroundTransparency = 0.3
    RefreshButton.Text = "🔄 REFRESH FRUITS LIST"
    RefreshButton.TextColor3 = Color3.new(1, 1, 1)
    RefreshButton.TextSize = 14
    RefreshButton.Font = Enum.Font.GothamBold
    
    local RefreshCorner = Instance.new("UICorner")
    RefreshCorner.CornerRadius = UDim.new(0.1, 0)
    RefreshCorner.Parent = RefreshButton
    
    RefreshButton.Parent = ScrollFrame
    
    -- Function to create fruit button
    local function CreateFruitButton(fruitData, index)
        local FruitButton = Instance.new("TextButton")
        FruitButton.Name = fruitData.Data.Name
        FruitButton.Size = UDim2.new(1, 0, 0, 40)
        FruitButton.BackgroundColor3 = FruitSelector:GetRarityColor(fruitData.Data.Rarity)
        FruitButton.BackgroundTransparency = 0.4
        FruitButton.Text = ""
        
        local FruitCorner = Instance.new("UICorner")
        FruitCorner.CornerRadius = UDim.new(0.05, 0)
        FruitCorner.Parent = FruitButton
        
        local FruitName = Instance.new("TextLabel")
        FruitName.Name = "FruitName"
        FruitName.Size = UDim2.new(0.7, 0, 1, 0)
        FruitName.BackgroundTransparency = 1
        FruitName.Text = fruitData.Data.Name
        FruitName.TextColor3 = Color3.new(1, 1, 1)
        FruitName.TextSize = 14
        FruitName.Font = Enum.Font.GothamBold
        FruitName.TextXAlignment = Enum.TextXAlignment.Left
        FruitName.TextYAlignment = Enum.TextYAlignment.Center
        FruitName.Parent = FruitButton
        
        local FruitRarity = Instance.new("TextLabel")
        FruitRarity.Name = "FruitRarity"
        FruitRarity.Size = UDim2.new(0.3, 0, 0.5, 0)
        FruitRarity.Position = UDim2.new(0.7, 0, 0, 0)
        FruitRarity.BackgroundTransparency = 1
        FruitRarity.Text = fruitData.Data.Rarity
        FruitRarity.TextColor3 = FruitSelector:GetRarityColor(fruitData.Data.Rarity)
        FruitRarity.TextSize = 10
        FruitRarity.Font = Enum.Font.Gotham
        FruitRarity.TextXAlignment = Enum.TextXAlignment.Right
        FruitRarity.Parent = FruitButton
        
        local SelectButton = Instance.new("TextButton")
        SelectButton.Name = "SelectButton"
        SelectButton.Size = UDim2.new(0.3, 0, 0.5, 0)
        SelectButton.Position = UDim2.new(0.7, 0, 0.5, 0)
        SelectButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        SelectButton.BackgroundTransparency = 0.3
        SelectButton.Text = "SELECT"
        SelectButton.TextColor3 = Color3.new(1, 1, 1)
        SelectButton.TextSize = 10
        SelectButton.Font = Enum.Font.GothamBold
        SelectButton.Parent = FruitButton
        
        -- Select fruit when clicked
        SelectButton.MouseButton1Click:Connect(function()
            if FruitSelector:SelectFruitByName(fruitData.Data.Name) then
                SelectedName.Text = fruitData.Data.Name
                SelectedName.TextColor3 = FruitSelector:GetRarityColor(fruitData.Data.Rarity)
                SelectedRarity.Text = "Rarity: " .. fruitData.Data.Rarity
                SelectedRarity.TextColor3 = FruitSelector:GetRarityColor(fruitData.Data.Rarity)
                
                -- Enable auto-use button
                AutoUseToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                AutoUseToggle.Text = "▶ AUTO USE: READY"
                AutoUseStatus.Text = "Status: Selected - " .. fruitData.Data.Name
                AutoUseStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
            end
        end)
        
        FruitButton.Parent = FruitsScroll
        return FruitButton
    end
    
    -- Function to refresh fruits list
    local function RefreshFruitsList()
        -- Clear current list
        for _, child in pairs(FruitsScroll:GetChildren()) do
            if child:IsA("TextButton") and child.Name ~= "RefreshButton" then
                child:Destroy()
            end
        end
        
        -- Scan for available fruits
        local availableFruits = FruitSelector:ScanInventory()
        
        if #availableFruits == 0 then
            local NoFruitsLabel = Instance.new("TextLabel")
            NoFruitsLabel.Size = UDim2.new(1, 0, 0, 40)
            NoFruitsLabel.BackgroundTransparency = 1
            NoFruitsLabel.Text = "No fruits found in inventory"
            NoFruitsLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
            NoFruitsLabel.TextSize = 14
            NoFruitsLabel.Font = Enum.Font.Gotham
            NoFruitsLabel.Parent = FruitsScroll
        else
            for i, fruitData in pairs(availableFruits) do
                CreateFruitButton(fruitData, i)
            end
        end
    end
    
    -- Auto-use toggle functionality
    AutoUseToggle.MouseButton1Click:Connect(function()
        if not FruitSelector.SelectedFruit then
            AutoUseStatus.Text = "Status: No fruit selected!"
            AutoUseStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
            return
        end
        
        if FruitSelector.AutoUse then
            -- Stop auto-use
            FruitSelector:StopAutoUse()
            AutoUseToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            AutoUseToggle.Text = "▶ AUTO USE: READY"
            AutoUseStatus.Text = "Status: Stopped"
            AutoUseStatus.TextColor3 = Color3.fromRGB(255, 150, 0)
        else
            -- Start auto-use
            FruitSelector:StartAutoUse()
            AutoUseToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            AutoUseToggle.Text = "⏸ AUTO USE: ACTIVE"
            AutoUseStatus.Text = "Status: Using " .. FruitSelector.SelectedFruit.Data.Name
            AutoUseStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
        end
    end)
    
    -- Refresh button click
    RefreshButton.MouseButton1Click:Connect(function()
        RefreshFruitsList()
        AutoUseStatus.Text = "Status: Refreshed list"
        AutoUseStatus.TextColor3 = Color3.fromRGB(0, 200, 255)
    end)
    
    -- Close button
    CloseButton.MouseButton1Click:Connect(function()
        EnhancedGUI:Destroy()
    end)
    
    -- Toggle button
    ToggleButton.MouseButton1Click:Connect(function()
        MainContainer.Visible = not MainContainer.Visible
        ToggleButton.Text = MainContainer.Visible and "─" or "☐"
    end)
    
    -- Drag functionality
    local dragging = false
    local dragInput, dragStart, startPos
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainContainer.Position
        end
    end)
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainContainer.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Keybind for toggle (F2)
    game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.F2 then
            MainContainer.Visible = not MainContainer.Visible
            ToggleButton.Text = MainContainer.Visible and "─" or "☐"
        end
    end)
    
    -- Initial refresh
    task.wait(1)
    RefreshFruitsList()
    
    MainContainer.Parent = EnhancedGUI
    return EnhancedGUI
end

-- =============================================
-- INTEGRATION WITH HOHO_H SCRIPT
-- =============================================

-- Wait for original script to fully load
task.wait(3)

-- Create enhanced GUI
local EnhancedGUI = CreateEnhancedGUI()

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Auto Fruit Selector",
    Text = "Enhanced GUI Loaded!\nF2 to hide/show",
    Duration = 5,
    Icon = "rbxassetid://4483345998"
})

print("\n" .. string.rep("=", 50))
print("BLOX FRUIT AUTO FRUIT SELECTOR v2.0")
print(string.rep("=", 50))
print("✅ Enhanced HOHO_H Script with:")
print("  • Fruit database (42+ fruits)")
print("  • Auto-scan inventory")
print("  • Fruit rarity colors")
print("  • SELECT toggle button")
print("  • ▶ AUTO-USE button (anak panah)")
print("  • Modern GUI with drag & toggle")
print(string.rep("=", 50))
print("🎮 How to use:")
print("  1. Click SELECT on any fruit")
print("  2. Click ▶ button to auto-use")
print("  3. Click again to stop")
print("  4. F2 to hide/show GUI")
print(string.rep("=", 50))

-- Auto-refresh every 30 seconds
spawn(function()
    while true do
        task.wait(30)
        if EnhancedGUI and EnhancedGUI.Parent then
            -- Refresh fruits list automatically
            local fruitsScroll = EnhancedGUI:FindFirstChild("MainContainer")
            if fruitsScroll then
                fruitsScroll = fruitsScroll:FindFirstChild("ScrollFrame")
                if fruitsScroll then
                    fruitsScroll = fruitsScroll:FindFirstChild("FruitsSection")
                    if fruitsScroll then
                        fruitsScroll = fruitsScroll:FindFirstChild("FruitsScroll")
                        if fruitsScroll then
                            -- Trigger refresh
                            pcall(function()
                                local availableFruits = FruitSelector:ScanInventory()
                                print("[Auto Refresh] Found", #availableFruits, "fruits")
                            end)
                        end
                    end
                end
            end
        end
    end
end)
