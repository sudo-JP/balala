local Shop = {}
Shop.__index = Shop

function Shop.new()
    local self = setmetatable(Shop, {})
    self.jokers = {}
    self.rerollableCards = {}
    self.anteVouchers = {}
    self.rerollPrice = 5
end


function Shop:reroll()
    self.rerollPrice *= 0.2
    --self.rerollableCards
end

function Shop:buyJoker(jokerIndex)
    return self.jokers[jokerIndex]
end

function Shop:buyAnte(anteIndex)
    return self.anteVouchers[anteIndex]
end

function Shop:buyRerollableCards(cardIndex)
    return self.rerollableCards[cardIndex]
end
