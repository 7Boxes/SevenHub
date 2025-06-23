-- seed_autobuyer.lua
return function(JMXTemplates, tabContent)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = tabContent
    
    -- Title
    local title = JMXTemplates.CreateTextInput(mainFrame, "Seed Auto-Buyer", "Select seeds to buy", function() end)
    title.TextLabel.TextColor3 = Color3.new(0, 1, 0)
    
    -- Seed list container
    local seedsContainer = JMXTemplates.CreateScrollingMenu(mainFrame)
    
    -- Variables
    local seedButtons = {}
    local selectedSeeds = {}
    local running = false
    
    -- Get seeds from the shop
    local function getSeeds()
        local seedShop = PlayerGui:WaitForChild("Seed_Shop"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
        local seeds = {}
        
        for _, child in ipairs(seedShop:GetChildren()) do
            if not string.find(child.Name, "_") and not string.find(child.Name:upper(), "UI") then
                table.insert(seeds, child.Name)
            end
        end
        
        return seeds
    end

    -- Create seed buttons
    local function createSeedButtons()
        for _, button in ipairs(seedButtons) do
            button:Destroy()
        end
        seedButtons = {}
        
        local seeds = getSeeds()
        table.sort(seeds)
        
        for _, seedName in ipairs(seeds) do
            local seedButton = JMXTemplates.CreateButtonWithLabel(seedsContainer, seedName, "Select", function(btn)
                if selectedSeeds[seedName] then
                    selectedSeeds[seedName] = nil
                    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                    btn.Text = "Select"
                else
                    selectedSeeds[seedName] = true
                    btn.BackgroundColor3 = Color3.new(0, 0.5, 0)
                    btn.Text = "Selected"
                end
            end)
            
            table.insert(seedButtons, seedButton.TextButton)
        end
    end

    -- Buy seeds
    local function buySeeds()
        local buySeedEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuySeedStock")
        
        while running do
            for seedName, _ in pairs(selectedSeeds) do
                if not running then break end
                
                for i = 1, 5 do
                    if not running then break end
                    buySeedEvent:FireServer(seedName)
                    task.wait(0.5)
                end
            end
            
            if not running then break end
            task.wait(1)
        end
    end

    -- Create control buttons
    local controlFrame = Instance.new("Frame")
    controlFrame.Size = UDim2.new(1, 0, 0, 40)
    controlFrame.BackgroundTransparency = 1
    controlFrame.Parent = mainFrame
    
    -- Toggle button
    local toggleButton = JMXTemplates.CreateButtonWithLabel(controlFrame, "Auto-Buy Status", "Stopped", function(btn)
        running = not running
        
        if running then
            btn.Text = "Running"
            btn.BackgroundColor3 = Color3.new(0, 0.5, 0)
            spawn(buySeeds)
        else
            btn.Text = "Stopped"
            btn.BackgroundColor3 = Color3.new(0.5, 0, 0)
        end
    end).TextButton
    toggleButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
    
    -- Refresh button
    local refreshButton = JMXTemplates.CreateButtonWithLabel(controlFrame, "", "Refresh Seeds", function()
        createSeedButtons()
    end).TextButton
    refreshButton.Position = UDim2.new(0.5, 5, 0, 0)
    
    -- Initialize
    createSeedButtons()
end
