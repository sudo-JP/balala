--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local SlyJoker = {}
SlyJoker.__index = SlyJoker

export type SlyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    SlyJoker
))

function SlyJoker.new(): SlyJoker
    return setmetatable({ price = 3, rarity = "Common" }, SlyJoker)
end

function SlyJoker.onHandScored(
    _self: SlyJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.Pair) then
        return { kind = "AddChips", amount = 50 }
    end
    return nil
end

return SlyJoker
