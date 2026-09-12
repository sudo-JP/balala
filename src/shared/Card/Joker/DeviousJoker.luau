--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local DeviousJoker = {}
DeviousJoker.__index = DeviousJoker

export type DeviousJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    DeviousJoker
))

function DeviousJoker.new(): DeviousJoker
    return setmetatable({ price = 4, rarity = "Common" }, DeviousJoker)
end

function DeviousJoker.onHandScored(
    _self: DeviousJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.Straight) then
        return { kind = "AddChips", amount = 100 }
    end
    return nil
end

return DeviousJoker
