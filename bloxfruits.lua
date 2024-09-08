-- Create ScreenGui for Main Features
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.Parent = screenGui

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(0, 250, 0, 10)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("Script Closed")
end)

-- Create Toggle Buttons
local function createToggleButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 280, 0, 50)
    button.Position = position
    button.Text = name
    button.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Parent = mainFrame

    button.MouseButton1Click:Connect(callback)
end

-- Toggle Variables
local autoFarmEnabled = false
local findFruitsEnabled = false

-- Button Callbacks
createToggleButton("Toggle Auto Farm", UDim2.new(0, 10, 0, 70), function()
    autoFarmEnabled = not autoFarmEnabled
    print("Auto Farm " .. (autoFarmEnabled and "Enabled" or "Disabled"))
end)

createToggleButton("Toggle Find Fruits", UDim2.new(0, 10, 0, 130), function()
    findFruitsEnabled = not findFruitsEnabled
    print("Find Fruits " .. (findFruitsEnabled and "Enabled" or "Disabled"))
end)

-- Teleport Places
local teleportPlaces = {
    ["1st Sea"] = {
        ["Island1"] = 12345678, -- Replace with actual Place ID
        ["Island2"] = 23456789, -- Replace with actual Place ID
    },
    ["2nd Sea"] = {
        ["Island1"] = 34567890, -- Replace with actual Place ID
        ["Island2"] = 45678901, -- Replace with actual Place ID
    },
    ["3rd Sea"] = {
        ["Island1"] = 56789012, -- Replace with actual Place ID
        ["Island2"] = 67890123, -- Replace with actual Place ID
    }
}

local function teleportToPlace(sea, placeName)
    local placeID = teleportPlaces[sea][placeName]
    if placeID then
        game:GetService("TeleportService"):Teleport(placeID, game.Players.LocalPlayer)
    else
        print("Place ID not found for " .. placeName)
    end
end

-- ESP for Fruits
local function createFruitESP(fruit)
    local esp = Instance.new("BillboardGui")
    esp.Adornee = fruit
    esp.Size = UDim2.new(0, 100, 0, 50)
    esp.StudsOffset = Vector3.new(0, 2, 0)
    esp.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = fruit.Name
    label.TextColor3 = Color3.new(1, 0, 0)
    label.TextStrokeTransparency = 0.5
    label.TextScaled = true
    label.Parent = esp
end

-- Fruit Finder
local function findFruits()
    for _, fruit in pairs(workspace:GetChildren()) do
        if fruit:IsA("Model") and fruit.Name:find("Fruit") then
            createFruitESP(fruit)
        end
    end
end

-- Auto Farm Function
local function autoFarm()
    if autoFarmEnabled then
        -- Add your auto-farming logic here
        print("Auto Farming...")
    end
end

-- Call functions periodically
while true do
    if findFruitsEnabled then
        findFruits()
    end
    autoFarm()
    wait(1) -- Adjust the delay as needed
end
