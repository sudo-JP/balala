--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local Fibonacci = {}
Fibonacci.__index = Fibonacci

export type Fibonacci = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    Fibonacci
))

function Fibonacci.new(): Fibonacci
    return setmetatable({ price = 8, rarity = "Uncommon" }, Fibonacci)
end

function Fibonacci.onCardScored(
    _self: Fibonacci,
    _handResult: PokerHands.HandResult,
    card: CardTypes.CardValue,
    _cardIndex: number
): JokerTypes.JokerEffect?
    if card.rank == 14 or card.rank == 2 or card.rank == 3 or card.rank == 5 or card.rank == 8 then
        return { kind = "AddMult", amount = 8 }
    end
    return nil
end

return Fibonacci
