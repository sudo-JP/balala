local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameStateChanged = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GameStateChanged")
local PlayHand = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayHand")

local components = script.Parent.components
local CardGameGui = require(components:FindFirstChild("CardGameGui"))
local CardButton = require(components:FindFirstChild("CardButton"))
local ActionButton = require(components:FindFirstChild("PlayHandButton"))
local ScoreLabel = require(components:FindFirstChild("ScoreLabel"))

GameStateChanged.OnClientEvent:Connect(function(result)
    local screenGui = CardGameGui.new()

    local indices = {}
    for i, card in ipairs(result.hand) do
        indices[i] = false
        CardButton.new(card.display .. "\n" .. card.suit, i, screenGui, function(selected)
            indices[i] = selected
        end)
    end

    ActionButton.new(screenGui, function()
        PlayHand:FireServer(indices)
    end, {
        text = "Play Hand",
    })

    if result.score then
        ScoreLabel.new(screenGui, result.score.chips, result.score.mult, result.score.handResult.handType)
    end
end)
