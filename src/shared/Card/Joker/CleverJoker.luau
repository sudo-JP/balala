--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local CleverJoker = {}
CleverJoker.__index = CleverJoker

export type CleverJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    CleverJoker
))

function CleverJoker.new(): CleverJoker
    return setmetatable({ price = 4, rarity = "Common" }, CleverJoker)
end

function CleverJoker.onHandScored(
    _self: CleverJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.TwoPair) then
        return { kind = "AddChips", amount = 80 }
    end
    return nil
end

return CleverJoker
