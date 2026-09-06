--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local HalfJoker = {}
HalfJoker.__index = HalfJoker

export type HalfJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    HalfJoker
))

function HalfJoker.new(): HalfJoker
    return setmetatable({ price = 5, rarity = "Common" }, HalfJoker)
end

function HalfJoker.onHandScored(
    _self: HalfJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if handResult.playedCardCount <= 3 then
        return { kind = "AddMult", amount = 20 }
    end
    return nil
end

return HalfJoker
