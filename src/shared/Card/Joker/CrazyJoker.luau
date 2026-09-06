--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local CrazyJoker = {}
CrazyJoker.__index = CrazyJoker

export type CrazyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    CrazyJoker
))

function CrazyJoker.new(): CrazyJoker
    return setmetatable({ price = 4, rarity = "Common" }, CrazyJoker)
end

function CrazyJoker.onHandScored(
    _self: CrazyJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.Straight) then
        return { kind = "AddMult", amount = 12 }
    end
    return nil
end

return CrazyJoker
