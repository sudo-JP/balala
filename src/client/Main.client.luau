local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameStateChanged = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GameStateChanged")
local PlayHand = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayHand")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


GameStateChanged.OnClientEvent:Connect(function(result)
    -- Clear any previous UI
    local existingGui = playerGui:FindFirstChild("CardGameGui")
    if existingGui then
        existingGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CardGameGui"
    screenGui.Parent = playerGui

    local indices = {}
    for i, card in ipairs(result.hand) do
        indices[i] = false
        local cardButton = Instance.new("TextButton")
        cardButton.Parent = screenGui
        cardButton.Size = UDim2.new(0, 100, 0, 140)
        cardButton.Position = UDim2.new(0, 20 + (i - 1) * 120, 0.5, -70)
        cardButton.Text = card.display .. "\n" .. card.suit
        cardButton.Parent = screenGui

        cardButton.MouseButton1Click:Connect(function()
            indices[i] = not indices[i]
            -- Visual feedback for selection
            if indices[i] then
                cardButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            else
                cardButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)
    end

    -- Create a "Play Hand" button that fires the PlayHand RemoteEvent when clicked
    local playHandButton = Instance.new("TextButton")
    playHandButton.Parent = screenGui
    playHandButton.Size = UDim2.new(0, 200, 0, 50)
    playHandButton.Position = UDim2.new(0.5, -100, 0.9, -50)
    playHandButton.Text = "Play Hand"
    playHandButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
    playHandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    playHandButton.TextScaled = true

    -- Show score if available
    if result.score then
        local scoreLabel = Instance.new("TextLabel")
        scoreLabel.Parent = screenGui
        scoreLabel.Size = UDim2.new(0, 300, 0, 40)
        scoreLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
        scoreLabel.Text = "Score: " .. tostring(result.score.score) .. " (" .. tostring(result.score.handResult.handType) .. ")"
        scoreLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        scoreLabel.BackgroundTransparency = 1
        scoreLabel.TextScaled = true
    end

    playHandButton.MouseButton1Click:Connect(function()
        PlayHand:FireServer(indices)
    end)
end)


