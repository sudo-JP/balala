local GameState = {}
GameState.__index = GameState

function GameState.new(players, maxRound)
    local self = setmetatable({}, GameState)
    self.currentRound = 1
    self.currentBlind = 300
    self.playerRanking = {}
    return self
end

return GameState


