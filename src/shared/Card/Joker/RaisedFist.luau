--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local RaisedFist = {}
RaisedFist.__index = RaisedFist

export type RaisedFist = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    RaisedFist
))

function RaisedFist.new(): RaisedFist
    return setmetatable({ price = 5, rarity = "Common" }, RaisedFist)
end

function RaisedFist.onCardScored(
    _self: RaisedFist,
    handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    cardIndex: number
): JokerTypes.JokerEffect?
    local lowestRank = math.huge
    local lowestCardIndex = 1
    for index, scoredCard in ipairs(handResult.cards) do
        if scoredCard.rank < lowestRank then
            lowestRank = scoredCard.rank
            lowestCardIndex = index
        end
    end

    if cardIndex == lowestCardIndex and card.rank == lowestRank then
        return { kind = "AddMult", amount = lowestRank * 2 }
    end
    return nil
end

return RaisedFist
