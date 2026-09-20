local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameStateChanged = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GameStateChanged")
local PlayHand = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayHand")
local DiscardHand = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DiscardHand")

local components = script.Parent.components
local CardGameGui = require(components:FindFirstChild("CardGameGui"))
local CardButton = require(components:FindFirstChild("CardButton"))
local ActionButton = require(components:FindFirstChild("ActionButton"))
local ScoreLabel = require(components:FindFirstChild("ScoreLabel"))

local function getSelectedIndices(indices)
    local selected = {}
    for i, isSelected in pairs(indices) do
        if isSelected then
            table.insert(selected, i)
        end
    end
    return selected
end

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
            local selected = getSelectedIndices(indices)
            if #selected > 0 then
                PlayHand:FireServer(selected)
            end
        end)
        :build()

    ActionButton.ActionButtonBuilder.new(screenGui)
        :withText("Discard")
        :withPosition(UDim2.new(0.5, -100, 0.9, 10))
        :withBackgroundColor(Color3.fromRGB(200, 80, 80))
        :onClick(function()
            local selected = getSelectedIndices(indices)
            if #selected > 0 then
                DiscardHand:FireServer(selected)
            end
        end)
        :build()

    if result.score then
        ScoreLabel.ScoreLabelBuilder.new(screenGui)
            :withChips(result.score.chips)
            :withMult(result.score.mult)
            :withHandType(result.score.handResult.handType)
            :build()
    end

    -- Stats label at bottom left corner
    local handsLeft = result.handsLeft or 0
    local discardsLeft = result.discardsLeft or 0
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Name = "StatsLabel"
    statsLabel.Parent = screenGui
    statsLabel.Size = UDim2.new(0, 250, 0, 50)
    statsLabel.Position = UDim2.new(0, 10, 1, -60)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = `Hands: {handsLeft}  |  Discards: {discardsLeft}`
    statsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statsLabel.TextScaled = true
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
end)
