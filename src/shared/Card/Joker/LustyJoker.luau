--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local LustyJoker = {}
LustyJoker.__index = LustyJoker

export type LustyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    LustyJoker
))

function LustyJoker.new(): LustyJoker
    return setmetatable({ price = 5, rarity = "Common" }, LustyJoker)
end

function LustyJoker.onCardScored(
    _self: LustyJoker,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.suit == "Heart" then
        return { kind = "AddMult", amount = 3 }
    end
    return nil
end

return LustyJoker
