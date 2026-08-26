local PlayerGameState = {}
PlayerGameState.__index = PlayerGameState

function PlayerGameState.new(builder)
    local self = setmetatable({}, PlayerGameState)
    self.currentCredit = 0
    self.hand = builder.Hand
    self.handSize = builder.handSize
    self.discardCounter = builder.discardCounter
end

local PlayerGameStyleBuilder = {}
PlayerGameStyleBuilder.__index = PlayerGameStyleBuilder

function PlayerGameStyleBuilder.new(name: string)
    local self = setmetatable({}, PlayerGameStyleBuilder)
    self.currentCredit = 0
    self.handSize = 5
end

function PlayerGameStyleBuilder:setDiscardCount(n)
    self.cardCounter = n
end

function PlayerGameStyleBuilder:setHandSize(n)
    self.handSize = n
end

function PlayerGameStyleBuilder:build()
    return PlayerGameStyleBuilder.new(self)
end
