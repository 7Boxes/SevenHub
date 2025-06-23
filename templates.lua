local scriptConfigs = {
    -- Simple Toggle Button Example
    {
        tabName = "Toggle Example",
        githubUrl = "https://raw.githubusercontent.com/yourusername/yourrepo/main/toggle_example.lua",
        initFunction = function(JMXTemplates, tabContent)
            local button = JMXTemplates.CreateButtonWithLabel(tabContent, "Toggle Feature", "OFF", function(btn)
                if btn.Text == "OFF" then
                    btn.Text = "ON"
                    btn.BackgroundColor3 = Color3.new(0, 0.5, 0)
                    print("Feature enabled!")
                else
                    btn.Text = "OFF"
                    btn.BackgroundColor3 = Color3.new(0.5, 0, 0)
                    print("Feature disabled!")
                end
            end)
        end
    },
    
    -- Text Input Example
    {
        tabName = "Input Example",
        githubUrl = "https://raw.githubusercontent.com/yourusername/yourrepo/main/input_example.lua",
        initFunction = function(JMXTemplates, tabContent)
            local input = JMXTemplates.CreateTextInput(tabContent, "Enter Value", "Type here", function(text)
                print("Submitted value:", text)
            end)
        end
    },
    
    -- Scrolling Menu Example
    {
        tabName = "Scrolling Menu",
        githubUrl = "https://raw.githubusercontent.com/yourusername/yourrepo/main/scrolling_menu.lua",
        initFunction = function(JMXTemplates, tabContent)
            local scrollFrame = JMXTemplates.CreateScrollingMenu(tabContent)
            
            for i = 1, 20 do
                local item = Instance.new("TextButton")
                item.Size = UDim2.new(1, 0, 0, 30)
                item.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
                item.BorderSizePixel = 0
                item.Text = "Item " .. i
                item.TextColor3 = Color3.new(1, 1, 1)
                item.Font = Enum.Font.Gotham
                item.TextSize = 14
                item.Parent = scrollFrame
                
                item.MouseButton1Click:Connect(function()
                    print("Selected item " .. i)
                end)
            end
        end
    },
    
    -- Minimizable Frame Example
    {
        tabName = "Minimizable Frame",
        githubUrl = "https://raw.githubusercontent.com/yourusername/yourrepo/main/minimizable_frame.lua",
        initFunction = function(JMXTemplates, tabContent)
            local contentFrame, setHeight = JMXTemplates.CreateMinimizableFrame(tabContent, "Collapsible Section", false)
            setHeight(100)
            
            for i = 1, 3 do
                JMXTemplates.CreateButtonWithLabel(contentFrame, "Option " .. i, "Select", function()
                    print("Selected option " .. i)
                end)
            end
        end
    },
    
    -- Farming Suite Example
    {
        tabName = "Farming Suite",
        githubUrl = "https://raw.githubusercontent.com/yourusername/yourrepo/main/farming_suite.lua",
        initFunction = function(JMXTemplates, tabContent)
            -- Title
            local title = JMXTemplates.CreateTextInput(tabContent, "Farming Suite", "Active", function() end)
            title.TextLabel.TextColor3 = Color3.new(0, 1, 0)
            
            -- Status toggle
            local statusButton = JMXTemplates.CreateButtonWithLabel(tabContent, "Auto-Buy Status", "Running", function(btn)
                if btn.Text == "Running" then
                    btn.Text = "Stopped"
                    btn.BackgroundColor3 = Color3.new(0.5, 0, 0)
                else
                    btn.Text = "Running"
                    btn.BackgroundColor3 = Color3.new(0, 0.5, 0)
                end
            end).TextButton
            statusButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
            
            -- Stats frame
            local statsFrame, setStatsHeight = JMXTemplates.CreateMinimizableFrame(tabContent, "Farming Stats", false)
            setStatsHeight(150)
            
            -- Create stats display
            local statNames = {"User", "Sheckles", "Weather", "Seeds", "Plants", "Runtime", "Bought", "Spent"}
            local statDisplays = {}
            
            for _, name in ipairs(statNames) do
                local display = JMXTemplates.CreateTextInput(statsFrame, name, "0", function() end)
                display.TextBox.Text = "Loading..."
                display.TextBox.Editable = false
                statDisplays[name] = display.TextBox
            end
            
            -- Format username with asterisks
            local username = Players.LocalPlayer.Name
            local shortUsername = string.rep("*", #username - 5) .. (#username > 5 and string.sub(username, -5) or username)
            statDisplays["User"].Text = shortUsername
            
            -- Plants frame
            local plantsFrame, setPlantsHeight = JMXTemplates.CreateMinimizableFrame(tabContent, "Plants to Buy", false)
            setPlantsHeight(200)
            
            local plantsScroll = JMXTemplates.CreateScrollingMenu(plantsFrame)
            
            -- Add plants to buy
            local buyPlants = {
                "Green Apple", "Avocado", "Banana", "Pineapple", "Kiwi", 
                "Bell Pepper", "Prickly Pear", "Loquat", "Sugar Apple", "Feijoa"
            }
            
            for _, plant in ipairs(buyPlants) do
                local plantButton = JMXTemplates.CreateButtonWithLabel(plantsScroll, plant, "Buy", function(btn)
                    print("Buying " .. plant)
                    btn.Text = "Buying..."
                    wait(1)
                    btn.Text = "Buy"
                end)
            end
            
            -- Pets frame
            local petsFrame, setPetsHeight = JMXTemplates.CreateMinimizableFrame(tabContent, "Pet Status", false)
            setPetsHeight(150)
            
            local petsScroll = JMXTemplates.CreateScrollingMenu(petsFrame)
            
            -- Add sample pets
            local samplePets = {
                "Golden Retriever: Level 5",
                "Siamese Cat: Level 3",
                "Parrot: Level 7",
                "Husky: Level 4"
            }
            
            for _, pet in ipairs(samplePets) do
                local petLabel = Instance.new("TextLabel")
                petLabel.Size = UDim2.new(1, 0, 0, 25)
                petLabel.BackgroundTransparency = 1
                petLabel.Text = "• " .. pet
                petLabel.TextColor3 = Color3.new(1, 1, 1)
                petLabel.Font = Enum.Font.Gotham
                petLabel.TextSize = 12
                petLabel.TextXAlignment = Enum.TextXAlignment.Left
                petLabel.Parent = petsScroll
            end
        end
    }
}
