
local PlayerProfile = require(game.ReplicatedStorage.Shared.Player:FindFirstChild("PlayerProfile"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Players = game:GetService("Players")

local sessions: {[Player]: PlayerProfile} = {}

Players.PlayerAdded:Connect(function(player)
    sessions[player] = PlayerProfile.new(player.Name)
end)

Players.PlayerRemoving:Connect(function(player)
    sessions[player] = nil
end)
