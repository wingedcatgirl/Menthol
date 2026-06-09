SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "Reincarnate",
	key = "reincarnate",
	config = {
        max_highlighted = 1
	},
	loc_vars = function(self, info_queue, card)
		local key = self.key
        local plural = false
        if card.ability.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local up = plural and "up to " or ""
		local a = plural and "" or "a "
		local ies = plural and "ies" or "y"
		local them = plural and "them" or "it"
        local main_end = MINTY.flavorize(self.key)
		return {
			key = key,
			main_end = main_end,
			vars = {
				card.ability.max_highlighted,
				up,
				s,
				a,
				ies,
				them,
			},
		}
	end,
	cost = 4,
	atlas = "spectrals",
	pos = { x = 1, y = 0 },
	can_use = function (self, card)
		local count = 0
		for _, v in ipairs(G.jokers.highlighted) do
			if not SMODS.is_eternal(v, card) then
				count = count + 1
			end
		end
		return (count > 0) and (count <= card.ability.max_highlighted)
	end,
	use = function(self, card, area, copier)
		local culprit = copier or card
		for _, v in ipairs(G.jokers.highlighted) do
			if not SMODS.is_eternal(v, culprit) then
				local key = v.config.center.key
				SMODS.destroy_cards(v)
				MINTY.event(function ()
					SMODS.add_card({
					set = "Joker",
					key = key,
				})
				return true
				end, {trigger = "after", delay = 2})
			end
		end
	end,
}