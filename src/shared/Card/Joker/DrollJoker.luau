--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local DrollJoker = {}
DrollJoker.__index = DrollJoker

export type DrollJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    DrollJoker
))

function DrollJoker.new(): DrollJoker
    return setmetatable({ price = 4, rarity = "Common" }, DrollJoker)
end

function DrollJoker.onHandScored(
    _self: DrollJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.Flush) then
        return { kind = "AddMult", amount = 10 }
    end
    return nil
end

return DrollJoker
