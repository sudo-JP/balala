--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local GreedyJoker = {}
GreedyJoker.__index = GreedyJoker

export type GreedyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    GreedyJoker
))

function GreedyJoker.new(): GreedyJoker
    return setmetatable({ price = 5, rarity = "Common" }, GreedyJoker)
end

function GreedyJoker.onCardScored(
    _self: GreedyJoker,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.suit == "Diamond" then
        return { kind = "AddMult", amount = 3 }
    end
    return nil
end

return GreedyJoker
