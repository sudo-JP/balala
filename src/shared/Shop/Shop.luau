--!strict

local Shop = {}
Shop.__index = Shop

export type ShopOffers = {
	jokers: { any }?,
	rerollableCards: { any }?,
	anteVouchers: { any }?,
}

export type Shop = typeof(setmetatable(
	{} :: {
		jokers: { any },
		rerollableCards: { any },
		anteVouchers: { any },
		rerollPrice: number,
	},
	Shop
))

function Shop.new(offers: ShopOffers?): Shop
    local self = setmetatable({}, Shop)
	self.jokers = if offers and offers.jokers then offers.jokers else {}
	self.rerollableCards = if offers and offers.rerollableCards then offers.rerollableCards else {}
	self.anteVouchers = if offers and offers.anteVouchers then offers.anteVouchers else {}
	self.rerollPrice = 5
	return self :: Shop
end

function Shop.reroll(self: Shop): ()
    self.rerollPrice += 1
end

function Shop.getRerollPrice(self: Shop): number
	return self.rerollPrice
end

local function removeOffer(offers: { any }, index: number): any?
	if index < 1 or index > #offers then
		return nil
	end

	return table.remove(offers, index)
end

function Shop.buyJoker(self: Shop, jokerIndex: number): any?
	return removeOffer(self.jokers, jokerIndex)
end

function Shop.buyAnte(self: Shop, anteIndex: number): any?
	return removeOffer(self.anteVouchers, anteIndex)
end

function Shop.buyRerollableCards(self: Shop, cardIndex: number): any?
	return removeOffer(self.rerollableCards, cardIndex)
end

return Shop
