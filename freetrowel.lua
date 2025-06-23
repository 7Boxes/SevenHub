-- auto_trowel.lua
return function(JMXTemplates, tabContent)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    
    -- Create UI elements
    local title = JMXTemplates.CreateTextInput(tabContent, "Auto Trowel Purchaser", "Active", function() end)
    title.TextLabel.TextColor3 = Color3.new(0, 1, 1)
    
    local statusLabel = JMXTemplates.CreateTextInput(tabContent, "Status", "Running", function() end)
    statusLabel.TextBox.Editable = false
    
    -- Variables
    local running = true
    
    -- Buy trowel function
    local function buyTrowelLoop()
        while true do
            task.wait(6000)
            if running then
                local buyGearEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyGearStock")
                buyGearEvent:FireServer("Trowel")
                statusLabel.TextBox.Text = "Bought Trowel at " .. os.date("%X")
            end
        end
    end

    -- Toggle button
    local toggleButton = JMXTemplates.CreateButtonWithLabel(tabContent, "Auto-Buy Status", "Running", function(btn)
        running = not running
        if running then
            btn.Text = "Running"
            btn.BackgroundColor3 = Color3.new(0, 0.5, 0)
            statusLabel.TextBox.Text = "Running"
        else
            btn.Text = "Stopped"
            btn.BackgroundColor3 = Color3.new(0.5, 0, 0)
            statusLabel.TextBox.Text = "Stopped"
        end
    end).TextButton
    toggleButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
    
    -- Start the loop
    spawn(buyTrowelLoop)
end
