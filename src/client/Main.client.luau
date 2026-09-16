local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameStateChanged = ReplicatedStorage.Remotes.GameStateChanged

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


GameStateChanged.OnClientEvent:Connect(function(result)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = playerGui

    local indices = {}
    for i, card in ipairs(result.hand) do
        indices[i] = false
        local cardButton = Instance.new("TextButton")
        cardButton.Parent = screenGui

        cardButton.MouseButton1Click:connect(function()
            indices[i] = not indices[i]
        end)
    end

    local playHand = Instance.new("PlayHandButton")
    playHand:FireServer(indices)

end)


