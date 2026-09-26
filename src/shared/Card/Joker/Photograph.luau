--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local Photograph = {}
Photograph.__index = Photograph

export type Photograph = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    Photograph
))

function Photograph.new(): Photograph
    return setmetatable({ price = 5, rarity = "Common" }, Photograph)
end

function Photograph.onCardScored(
    _self: Photograph,
    handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank < 11 or card.rank > 13 then
        return nil
    end

    for index = 1, cardIndex - 1 do
        local previousCard = handResult.cards[index]
        if previousCard.rank >= 11 and previousCard.rank <= 13 then
            return nil
        end
    end

    return { kind = "MultiplyMult", amount = 2 }
end

return Photograph
