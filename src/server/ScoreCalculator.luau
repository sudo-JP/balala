--!strict
local PokerHands = require("@game/ReplicatedStorage/Shared/deck/PokerHands")
local JokerTypes = require("@game/ReplicatedStorage/Shared/Card/Joker/Types")

local ScoreCalculator = {}

local BASE_HAND_SCORES: {[PokerHands.PokerHandType]: {chips: number, mult: number}} = {
    HighCard = { chips = 5, mult = 1 },
    Pair = { chips = 10, mult = 2 },
    TwoPair = { chips = 20, mult = 2 },
    ThreeOfAKind = { chips = 30, mult = 3 },
    Straight = { chips = 30, mult = 4 },
    Flush = { chips = 35, mult = 4 },
    FullHouse = { chips = 40, mult = 4 },
    FourOfAKind = { chips = 60, mult = 7 },
    StraightFlush = { chips = 100, mult = 8 },
    RoyalFlush = { chips = 100, mult = 8 },
}

type HandLike = {
    read getHandResult: (self: any) -> PokerHands.HandResult,
}

type ScoreState = {
    chips: number,
    mult: number,
}

export type ScoreResult = {
    handResult: PokerHands.HandResult,
    chips: number,
    mult: number,
    score: number,
    effects: {JokerTypes.AppliedJokerEffect},
}

local function applyEffect(state: ScoreState, effect: JokerTypes.JokerEffect)
    if effect.kind == "AddChips" then
        state.chips += effect.amount
    elseif effect.kind == "AddMult" then
        state.mult += effect.amount
    elseif effect.kind == "MultiplyMult" then
        state.mult *= effect.amount
    else
        error(`unsupported Joker effect kind: {effect.kind}`)
    end
end

function ScoreCalculator.calculateHand(hand: HandLike, jokers: {JokerTypes.Joker}): ScoreResult
    local handResult = hand:getHandResult()
    local baseScore = BASE_HAND_SCORES[handResult.handType]
    local state: ScoreState = {
        chips = baseScore.chips,
        mult = baseScore.mult,
    }
    local effects: {JokerTypes.AppliedJokerEffect} = {}

    for cardIndex, card in ipairs(handResult.cards) do
        state.chips += card.points

        for jokerIndex, joker in ipairs(jokers) do
            local onCardScored = joker.onCardScored
            if onCardScored ~= nil then
                local effect = onCardScored(joker, handResult, card, cardIndex)
                if effect ~= nil then
                    applyEffect(state, effect)
                    table.insert(effects, {
                        kind = effect.kind,
                        amount = effect.amount,
                        jokerIndex = jokerIndex,
                        cardIndex = cardIndex,
                    })
                end
            end
        end
    end

    for jokerIndex, joker in ipairs(jokers) do
        local onHandScored = joker.onHandScored
        if onHandScored ~= nil then
            local effect = onHandScored(joker, handResult)
            if effect ~= nil then
                applyEffect(state, effect)
                table.insert(effects, {
                    kind = effect.kind,
                    amount = effect.amount,
                    jokerIndex = jokerIndex,
                    cardIndex = nil,
                })
            end
        end
    end

    return {
        handResult = handResult,
        chips = state.chips,
        mult = state.mult,
        score = state.chips * state.mult,
        effects = effects,
    }
end

return ScoreCalculator
