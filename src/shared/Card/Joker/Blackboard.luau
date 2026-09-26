--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local Blackboard = {}
Blackboard.__index = Blackboard

export type Blackboard = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    Blackboard
))

function Blackboard.new(): Blackboard
    return setmetatable({ price = 6, rarity = "Uncommon" }, Blackboard)
end

function Blackboard.onHandScored(
    _self: Blackboard,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    for _, card in ipairs(handResult.cards) do
        if card.suit ~= "Spade" and card.suit ~= "Club" then
            return nil
        end
    end
    return { kind = "AddMult", amount = 3 }
end

return Blackboard
