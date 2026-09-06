--!strict
local CardTypes = require("../Types")
local PokerHands = require("../../deck/PokerHands")
local JokerTypes = require("./Types")

local GluttonousJoker = {}
GluttonousJoker.__index = GluttonousJoker

export type GluttonousJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    GluttonousJoker
))

function GluttonousJoker.new(): GluttonousJoker
    return setmetatable({ price = 5, rarity = "Common" }, GluttonousJoker)
end

function GluttonousJoker.onCardScored(
    _self: GluttonousJoker,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.suit == "Club" then
        return { kind = "AddMult", amount = 3 }
    end
    return nil
end

return GluttonousJoker
