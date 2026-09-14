local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameStateChanged = ReplicatedStorage.Remotes.GameStateChanged
local PlayHand = ReplicatedStorage.Remotes.PlayHand

PlayHand:FireServer({1, 2}) 
GameStateChanged.OnClientEvent:Connect(function(result)
    -- TOOD: update UI with score 
end)
