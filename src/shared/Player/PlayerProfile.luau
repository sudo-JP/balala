local PlayerGameStateBuilder = require(game.ReplicatedStorage.Shared.Player:FindFirstChild("PlayerGameStateBuilder"))

local PlayerProfile = {}
PlayerProfile.__index = PlayerProfile

function PlayerProfile.new(name)
    local self = setmetatable({}, PlayerProfile)
    self.name = name
    self.deckTypes = {}
    -- TODO: actually have logic to select state 
    local builder = PlayerGameStateBuilder.new()
    self.state = builder:useRedDeck()
    return self
end

return PlayerProfile
