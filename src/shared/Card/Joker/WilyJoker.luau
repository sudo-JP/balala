--!strict
local CardTypes = require(script.Parent.Parent:FindFirstChild("Types"))
local PokerHands = require(script.Parent.Parent.Parent.Deck:FindFirstChild("PokerHands"))
local JokerTypes = require(script.Parent:FindFirstChild("Types"))

local WilyJoker = {}
WilyJoker.__index = WilyJoker

export type WilyJoker = typeof(setmetatable(
    {} :: {
        price: number,
        rarity: CardTypes.Rarity,
    },
    WilyJoker
))

function WilyJoker.new(): WilyJoker
    return setmetatable({ price = 4, rarity = "Common" }, WilyJoker)
end

function WilyJoker.onHandScored(
    _self: WilyJoker,
    handResult: PokerHands.HandResult
): JokerTypes.JokerEffect?
    if PokerHands.contains(handResult.handType, PokerHands.ThreeOfAKind) then
        return { kind = "AddChips", amount = 100 }
    end
    return nil
end

return WilyJoker
