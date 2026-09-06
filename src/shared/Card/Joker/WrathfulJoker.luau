--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local WrathfulJoker = {}
WrathfulJoker.__index = WrathfulJoker

export type WrathfulJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    WrathfulJoker
))

function WrathfulJoker.new(): WrathfulJoker
    return setmetatable({ price = 5, rarity = "Common" }, WrathfulJoker)
end

function WrathfulJoker.onCardScored(
    _self: WrathfulJoker,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.suit == "Spade" then
        return { kind = "AddMult", amount = 3 }
    end
    return nil
end

return WrathfulJoker
