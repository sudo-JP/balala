local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScoreCalculator = require(script.Parent.ScoreCalc)
local PlayerProfile = require(game.ReplicatedStorage.Shared.Player:FindFirstChild("PlayerProfile"))
local GameStateChanged = ReplicatedStorage.Remotes.GameStateChanged

local Players = game:GetService("Players")
local PlayHand = ReplicatedStorage.Remotes.PlayHand

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

    local result = ScoreCalculator.calculateHand(gameState)

    -- draw replacements
    gameState:drawMoreCards()

    -- send result back to client
    GameStateChanged:FireClient(player, {
        score = result,
        hand = gameState:getCurrentHand()
    })
end)


Players.PlayerRemoving:Connect(function(player)
    sessions[player] = nil
end)
