-- user_weather_updater.lua
return function(JMXTemplates, tabContent)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = tabContent
    
    -- Title
    local title = JMXTemplates.CreateTextInput(mainFrame, "User & Weather Info", "Active", function() end)
    title.TextLabel.TextColor3 = Color3.new(1, 1, 0)
    
    -- User info
    local username = LocalPlayer.Name
    local shortUsername = string.rep("*", #username - 5) .. (#username > 5 and string.sub(username, -5) or username)
    
    local userInfo = JMXTemplates.CreateTextInput(mainFrame, "Username", shortUsername, function() end)
    userInfo.TextBox.Editable = false
    
    local shecklesInfo = JMXTemplates.CreateTextInput(mainFrame, "Sheckles", "¢0", function() end)
    shecklesInfo.TextBox.Editable = false
    
    -- Weather info
    local weatherInfo = JMXTemplates.CreateTextInput(mainFrame, "Weather", "Loading...", function() end)
    weatherInfo.TextBox.Editable = false
    
    -- Format weather name
    local function formatWeatherName(name)
        local result = ""
        for i = 1, #name do
            local c = name:sub(i,i)
            if i > 1 and c:match("%u") then
                result = result .. " " .. c
            else
                result = result .. c
            end
        end
        return result
    end

    -- Update user info
    local function updateUserInfo()
        local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            local sheckles = leaderstats:FindFirstChild("Sheckles") or leaderstats:FindFirstChild("sheckles")
            if sheckles then
                shecklesInfo.TextBox.Text = "¢" .. tostring(sheckles.Value)
            end
        end
    end

    -- Update weather info
    local function updateWeather()
        local weatherFrame = PlayerGui:WaitForChild("Bottom_UI"):WaitForChild("BottomFrame"):WaitForChild("Holder"):WaitForChild("List")
        local activeWeather = {}
        
        for _, child in ipairs(weatherFrame:GetChildren()) do
            if (child:IsA("Frame") or child:IsA("ImageButton")) and child.Visible then
                table.insert(activeWeather, formatWeatherName(child.Name))
            end
        end
        
        weatherInfo.TextBox.Text = #activeWeather > 0 and table.concat(activeWeather, ", ") or "None"
    end

    -- Refresh button
    local refreshButton = JMXTemplates.CreateButtonWithLabel(mainFrame, "", "Refresh Info", function()
        updateUserInfo()
        updateWeather()
    end).TextButton
    
    -- Initialize
    updateUserInfo()
    updateWeather()
    
    -- Periodic update
    spawn(function()
        while true do
            task.wait(5)
            updateUserInfo()
            updateWeather()
        end
    end)
end
