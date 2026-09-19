local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScoreCalculator = require(script.Parent.ScoreCalculator)
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

    -- Send initial game state so the client can show the UI
    local gameState = playerProfile:getGameState()
    GameStateChanged:FireClient(player, {
        score = nil,
        hand = gameState:getCurrentHand()
    })
end)

-- Handle players already in the game
for _, player in Players:GetPlayers() do
    local playerProfile = PlayerProfile.new(player.Name)
    sessions[player] = playerProfile

    local gameState = playerProfile:getGameState()
    GameStateChanged:FireClient(player, {
        score = nil,
        hand = gameState:getCurrentHand()
    })
end

PlayHand.OnServerEvent:Connect(function(player, selectedIndices)
    local profile = sessions[player]
    if not profile then
        return
    end

    local gameState = profile:getGameState()

    -- validate client input
    if typeof(selectedIndices) ~= "table" or #selectedIndices == 0 or #selectedIndices > 5 then
        return
    end

    -- mark which cards the player selected from their hand
    gameState:setSelectedCards(selectedIndices)

    -- play the selected hand: removes selected cards from currentHand, decrements hands remaining
    local selectedHand = gameState:playSelectedHand()

    -- calculate the score for the played hand
    local result = ScoreCalculator.calculateHand(gameState)

    -- draw replacement cards to refill the hand
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
