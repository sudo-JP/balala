local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameStateChanged = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GameStateChanged")
local PlayHand = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayHand")

local components = script.Parent.components
local CardGameGui = require(components:FindFirstChild("CardGameGui"))
local CardButton = require(components:FindFirstChild("CardButton"))
local ActionButton = require(components:FindFirstChild("ActionButton"))
local ScoreLabel = require(components:FindFirstChild("ScoreLabel"))

GameStateChanged.OnClientEvent:Connect(function(result)
    local screenGui = CardGameGui.CardGameGuiBuilder.new()
        :build()

    local indices = {}
    for i, card in ipairs(result.hand) do
        indices[i] = false
        CardButton.CardButtonBuilder.new(screenGui)
            :withDisplay(card.display .. "\n" .. card.suit)
            :withCardIndex(i)
            :onClick(function(selected)
                indices[i] = selected
            end)
            :build()
    end

    ActionButton.ActionButtonBuilder.new(screenGui)
        :withText("Play Hand")
        :onClick(function()
            PlayHand:FireServer(indices)
        end)
        :build()

    if result.score then
        ScoreLabel.ScoreLabelBuilder.new(screenGui)
            :withChips(result.score.chips)
            :withMult(result.score.mult)
            :withHandType(result.score.handResult.handType)
            :build()
    end
end)
