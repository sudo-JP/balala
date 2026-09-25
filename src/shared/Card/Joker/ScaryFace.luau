--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local ScaryFace = {}
ScaryFace.__index = ScaryFace

export type ScaryFace = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    ScaryFace
))

function ScaryFace.new(): ScaryFace
    return setmetatable({ price = 4, rarity = "Common" }, ScaryFace)
end

function ScaryFace.onCardScored(
    _self: ScaryFace,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank >= 11 and card.rank <= 13 then
        return { kind = "AddChips", amount = 30 }
    end
    return nil
end

return ScaryFace
