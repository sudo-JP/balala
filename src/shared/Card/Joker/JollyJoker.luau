--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local JollyJoker = {}
JollyJoker.__index = JollyJoker

export type JollyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    JollyJoker
))

function JollyJoker.new(): JollyJoker
    return setmetatable({ price = 3, rarity = "Common" }, JollyJoker)
end

function JollyJoker.onHandScored(
    _self: JollyJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.Pair) then
        return { kind = "AddMult", amount = 8 }
    end
    return nil
end

return JollyJoker
