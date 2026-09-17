local PlayerGameState = require(game.ReplicatedStorage.Shared.Player:FindFirstChild("PlayerGameState"))
local PlayerGameStateBuilder = PlayerGameState.PlayerStateBuilder

local PlayerProfile = {}
PlayerProfile.__index = PlayerProfile

function PlayerProfile.new(name)
    local self = setmetatable({}, PlayerProfile)
    self.name = name
    self.deckTypes = {}
    -- TODO: actually have logic to select state 
    local builder = PlayerGameStateBuilder.new()
    builder:useRedDeck()
    self.state = builder:build()
    return self
end

function PlayerProfile.getGameState(self)
    return self.state
end

return PlayerProfile
