local PlayerProfile = {}
PlayerProfile.__index = PlayerProfile

function PlayerProfile.new(name)
    local self = setmetatable({}, PlayerProfile)
    self.name = name
    self.deckTypes = {}
end
