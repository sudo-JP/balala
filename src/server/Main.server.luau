
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScoreCalculator = require(game.ReplicatedStorage.Shared.Deck:FindFirstChild("ScoreCalculator "))
local PlayerProfile = require(game.ReplicatedStorage.Shared.Player:FindFirstChild("PlayerProfile"))
local GameStateChanged = ReplicatedStorage.Remotes.GameStateChanged



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
    GameStateChanged:FireClient(player, result)
end)


Players.PlayerRemoving:Connect(function(player)
    sessions[player] = nil
end)


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local indices = {}
for i, card in ipairs(sessions[player]:getCards()) do
    setmetatable(indices, { i = card})
    local cardButton = Instance.new("Card " .. i)
    cardButton.MouseButton1Click:connect(function()
        sessions[player]:selectCard(i)
    end)
end
