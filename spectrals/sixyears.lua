SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "6 Years",
	key = "6years",
	config = {
		mod_conv = "minty_cement_seal",
		max_highlighted = 1,
        seal = {extra = {chips = 50}},
	},
	loc_vars = function(self, info_queue, card)
		local key = self.key
        local main_end = MINTY.flavorize(self.key)
		-- Handle creating a tooltip with set args.
		info_queue[#info_queue + 1] = { set = "Other", key = "minty_cement_seal", specific_vars = { self.config.seal.extra.chips } }
		return {
			key = key,
			main_end = main_end,
			vars = { card.ability.max_highlighted }
		}
	end,
	cost = 4,
	atlas = "spectrals",
	pos = { x = 0, y = 1 },
	use = function(self, card, area, copier) --Good enough
		for i = 1, #G.hand.highlighted do
			local highlighted = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					highlighted:juice_up(0.3, 0.5)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if highlighted then
						highlighted:set_seal("minty_cement")
					end
					return true
				end,
			}))
			delay(0.5)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
}