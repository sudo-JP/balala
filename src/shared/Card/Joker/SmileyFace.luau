--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local SmileyFace = {}
SmileyFace.__index = SmileyFace

export type SmileyFace = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    SmileyFace
))

function SmileyFace.new(): SmileyFace
    return setmetatable({ price = 4, rarity = "Common" }, SmileyFace)
end

function SmileyFace.onCardScored(
    _self: SmileyFace,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank >= 11 and card.rank <= 13 then
        return { kind = "AddMult", amount = 5 }
    end
    return nil
end

return SmileyFace
