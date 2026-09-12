--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local JollyJoker = {}
JollyJoker.__index = JollyJoker

export type JollyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    JollyJoker
))

function JollyJoker.new(): JollyJoker
    return setmetatable({ price = 3, rarity = "Common" }, JollyJoker)
end

function JollyJoker.onHandScored(
    _self: JollyJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.Pair) then
        return { kind = "AddMult", amount = 8 }
    end
    return nil
end

return JollyJoker
