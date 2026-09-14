
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScoreCalculator = require(game.ReplicatedStorage.Shared.Deck:FindFirstChild("ScoreCalculator "))
local PlayerProfile = require(game.ReplicatedStorage.Shared.Player:FindFirstChild("PlayerProfile"))
local GameStateChanged = ReplicatedStorage.Remotes.GameStateChanged

local Players = game:GetService("Players")

local sessions: {[Player]: PlayerProfile} = {}

-- For now these events are hardcoded here
Players.PlayerAdded:Connect(function(player)
    -- Save and init player
    local playerProfile = PlayerProfile.new(player.Name)
    sessions[player] = playerProfile
end)

PlayHand.OnServerEvent:Connect(function(player, selectedIndices)
    local profile = sessions[player]
    local gameState = profile:getGameState()

    local selectedHand = gameState:getSelectedHand()
    local result = ScoreCalculator.calculateHand(selectedHand)

    -- draw replacements
    gameState:drawMoreCards()

    -- send result back to client
    GameStateChanged:FireClient(player, result)
end)


Players.PlayerRemoving:Connect(function(player)
    sessions[player] = nil
end)
