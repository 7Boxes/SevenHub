-- JMX Executor UI Script
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Main UI Setup
local JMX = Instance.new("ScreenGui")
JMX.Name = "JMXExecutor"
JMX.ResetOnSpawn = false
JMX.ZIndexBehavior = Enum.ZIndexBehavior.Global
JMX.DisplayOrder = 999
JMX.Parent = game:GetService("CoreGui")

-- Main background frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.Position = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderSizePixel = 0
MainFrame.Parent = JMX

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame

-- Game title
local GameTitle = Instance.new("TextLabel")
GameTitle.Name = "GameTitle"
GameTitle.Size = UDim2.new(0.3, 0, 1, 0)
GameTitle.Position = UDim2.new(0.35, 0, 0, 0)
GameTitle.BackgroundTransparency = 1
GameTitle.Text = "JMX - " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
GameTitle.TextColor3 = Color3.new(1, 1, 1)
GameTitle.Font = Enum.Font.GothamBold
GameTitle.TextSize = 14
GameTitle.ZIndex = 3
GameTitle.Parent = TitleBar

-- Username display (with asterisks)
local username = localPlayer.Name
local hiddenUsername = string.sub(username, 1, -6):gsub(".", "*") .. string.sub(username, -5)
local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Name = "Username"
UsernameLabel.Size = UDim2.new(0.2, 0, 1, 0)
UsernameLabel.Position = UDim2.new(0, 10, 0, 0)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = hiddenUsername
UsernameLabel.TextColor3 = Color3.new(1, 1, 1)
UsernameLabel.Font = Enum.Font.Gotham
UsernameLabel.TextSize = 14
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.ZIndex = 3
UsernameLabel.Parent = TitleBar

-- Stats button
local StatsButton = Instance.new("TextButton")
StatsButton.Name = "StatsButton"
StatsButton.Size = UDim2.new(0.1, 0, 0.8, 0)
StatsButton.Position = UDim2.new(0.2, 10, 0.1, 0)
StatsButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
StatsButton.BorderSizePixel = 0
StatsButton.Text = "Stats"
StatsButton.TextColor3 = Color3.new(1, 1, 1)
StatsButton.Font = Enum.Font.Gotham
StatsButton.TextSize = 14
StatsButton.ZIndex = 3
StatsButton.Parent = TitleBar

-- Stats frame (initially hidden)
local StatsFrame = Instance.new("Frame")
StatsFrame.Name = "StatsFrame"
StatsFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
StatsFrame.Position = UDim2.new(0, 10, 0, 35)
StatsFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
StatsFrame.BorderSizePixel = 0
StatsFrame.Visible = false
StatsFrame.ZIndex = 10 -- Highest ZIndex to ensure it's on top
StatsFrame.Parent = MainFrame

-- Minimize button for stats
local MinimizeStats = Instance.new("TextButton")
MinimizeStats.Name = "MinimizeButton"
MinimizeStats.Size = UDim2.new(0, 20, 0, 20)
MinimizeStats.Position = UDim2.new(1, -25, 0, 5)
MinimizeStats.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MinimizeStats.BorderSizePixel = 0
MinimizeStats.Text = "-"
MinimizeStats.TextColor3 = Color3.new(1, 1, 1)
MinimizeStats.Font = Enum.Font.GothamBold
MinimizeStats.TextSize = 14
MinimizeStats.ZIndex = 11
MinimizeStats.Parent = StatsFrame

-- Stats scroll frame
local StatsScroll = Instance.new("ScrollingFrame")
StatsScroll.Name = "StatsScroll"
StatsScroll.Size = UDim2.new(1, -10, 1, -30)
StatsScroll.Position = UDim2.new(0, 5, 0, 25)
StatsScroll.BackgroundTransparency = 1
StatsScroll.BorderSizePixel = 0
StatsScroll.ScrollBarThickness = 5
StatsScroll.ZIndex = 11
StatsScroll.Parent = StatsFrame

local StatsLayout = Instance.new("UIListLayout")
StatsLayout.Parent = StatsScroll

-- Function to update stats
local function updateStats()
    local leaderstats = localPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        StatsScroll:ClearAllChildren()
        
        for _, stat in pairs(leaderstats:GetChildren()) do
            local statFrame = Instance.new("Frame")
            statFrame.Size = UDim2.new(1, 0, 0, 30)
            statFrame.BackgroundTransparency = 1
            statFrame.ZIndex = 12
            
            local statName = Instance.new("TextLabel")
            statName.Size = UDim2.new(0.5, 0, 1, 0)
            statName.Position = UDim2.new(0, 0, 0, 0)
            statName.BackgroundTransparency = 1
            statName.Text = stat.Name
            statName.TextColor3 = Color3.new(1, 1, 1)
            statName.Font = Enum.Font.Gotham
            statName.TextSize = 14
            statName.TextXAlignment = Enum.TextXAlignment.Left
            statName.ZIndex = 12
            statName.Parent = statFrame
            
            local statValue = Instance.new("TextLabel")
            statValue.Size = UDim2.new(0.5, 0, 1, 0)
            statValue.Position = UDim2.new(0.5, 0, 0, 0)
            statValue.BackgroundTransparency = 1
            statValue.Text = tostring(stat.Value)
            statValue.TextColor3 = Color3.new(1, 1, 1)
            statValue.Font = Enum.Font.Gotham
            statValue.TextSize = 14
            statValue.TextXAlignment = Enum.TextXAlignment.Right
            statValue.ZIndex = 12
            statValue.Parent = statFrame
            
            statFrame.Parent = StatsScroll
        end
    end
end

-- Track if stats are minimized
local statsMinimized = false
local originalStatsHeight = StatsFrame.Size.Y

-- Toggle stats visibility
StatsButton.MouseButton1Click:Connect(function()
    if statsMinimized then
        -- If minimized, restore to original size
        StatsFrame.Size = UDim2.new(StatsFrame.Size.X, originalStatsHeight)
        StatsScroll.Visible = true
        MinimizeStats.Text = "-"
        statsMinimized = false
    end
    StatsFrame.Visible = not StatsFrame.Visible
    if StatsFrame.Visible then
        updateStats()
    end
end)

-- Minimize stats
MinimizeStats.MouseButton1Click:Connect(function()
    statsMinimized = not statsMinimized
    if statsMinimized then
        StatsFrame.Size = UDim2.new(StatsFrame.Size.X, UDim.new(0, 30))
        StatsScroll.Visible = false
        MinimizeStats.Text = "+"
    else
        StatsFrame.Size = UDim2.new(StatsFrame.Size.X, originalStatsHeight)
        StatsScroll.Visible = true
        MinimizeStats.Text = "-"
    end
end)

-- Tab system
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(1, 0, 0, 40)
TabsFrame.Position = UDim2.new(0, 0, 0, 30)
TabsFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
TabsFrame.BorderSizePixel = 0
TabsFrame.ZIndex = 2
TabsFrame.Parent = MainFrame

local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 1, 0)
Tabs.Position = UDim2.new(0, 10, 0, 0)
Tabs.BackgroundTransparency = 1
Tabs.ZIndex = 3
Tabs.Parent = TabsFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = Tabs

-- Content frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -70)
ContentFrame.Position = UDim2.new(0, 10, 0, 70)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 2
ContentFrame.Parent = MainFrame

-- UI Templates Module
local JMXTemplates = {}

-- Button with label template
function JMXTemplates.CreateButtonWithLabel(parent, labelText, buttonText, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundTransparency = 1
    container.ZIndex = 3
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = container
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.3, 0, 0.8, 0)
    button.Position = UDim2.new(0.7, 0, 0.1, 0)
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.BorderSizePixel = 0
    button.Text = buttonText
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.ZIndex = 3
    button.Parent = container
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return container
end

-- Text input template
function JMXTemplates.CreateTextInput(parent, labelText, placeholderText, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundTransparency = 1
    container.ZIndex = 3
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = container
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.3, 0, 0.8, 0)
    textBox.Position = UDim2.new(0.7, 0, 0.1, 0)
    textBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    textBox.BorderSizePixel = 0
    textBox.PlaceholderText = placeholderText
    textBox.Text = ""
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.ZIndex = 3
    textBox.Parent = container
    
    if callback then
        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(textBox.Text)
            end
        end)
    end
    
    return container
end

-- Scrolling menu template
function JMXTemplates.CreateScrollingMenu(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.ZIndex = 3
    container.Parent = parent
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 5
    scrollFrame.ZIndex = 3
    scrollFrame.Parent = container
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = scrollFrame
    
    return scrollFrame
end

-- Minimizable frame template
function JMXTemplates.CreateMinimizableFrame(parent, title, defaultMinimized)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 30)
    container.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    container.BorderSizePixel = 0
    container.ZIndex = 3
    container.Parent = parent
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.Gotham
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 4
    titleLabel.Parent = container
    
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 20, 0, 20)
    minimizeButton.Position = UDim2.new(1, -25, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 14
    minimizeButton.ZIndex = 4
    minimizeButton.Parent = container
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 0, 0)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ClipsDescendants = true
    contentFrame.ZIndex = 3
    contentFrame.Parent = container
    
    local minimized = defaultMinimized or false
    
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            minimizeButton.Text = "+"
            contentFrame.Size = UDim2.new(1, 0, 0, 0)
        else
            minimizeButton.Text = "-"
            contentFrame.Size = UDim2.new(1, 0, 0, 200) -- Default height
        end
    end)
    
    if defaultMinimized then
        minimizeButton.Text = "+"
        contentFrame.Size = UDim2.new(1, 0, 0, 0)
    end
    
    return contentFrame, function(newHeight)
        if not minimized then
            contentFrame.Size = UDim2.new(1, 0, 0, newHeight)
        end
    end
end

-- Function to add a new tab
function JMXTemplates.AddTab(tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "Tab"
    tabButton.Size = UDim2.new(0, 100, 0.8, 0)
    tabButton.Position = UDim2.new(0, 0, 0.1, 0)
    tabButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.ZIndex = 3
    tabButton.Parent = Tabs
    
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Position = UDim2.new(0, 0, 0, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.ScrollBarThickness = 5
    tabContent.ZIndex = 3
    tabContent.Parent = ContentFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = tabContent
    
    tabButton.MouseButton1Click:Connect(function()
        -- Hide all tab contents
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        
        -- Show this tab's content
        tabContent.Visible = true
        
        -- Highlight this tab
        for _, child in pairs(Tabs:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            end
        end
        tabButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    end)
    
    -- Select first tab by default
    if #Tabs:GetChildren() == 1 then
        tabButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        tabContent.Visible = true
    end
    
    return tabContent
end

-- Make templates available to other scripts
return JMXTemplates
