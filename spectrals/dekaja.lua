SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "Dekaja",
	key = "dekaja",
	effect = "Dispel",
	config = {
		max_highlighted = 4
	},
	loc_vars = function(self, info_queue, card)
		local key = self.key
        local plural = false
        if card.ability.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "up to "
        local main_end = MINTY.flavorize(self.key)
		return {
			key = key,
			main_end = main_end,
			vars = {
				card.ability.max_highlighted,
				a,
				s,
			},
		}
	end,
	cost = 4,
	atlas = "spectrals",
	pos = { x = 0, y = 0 },
	can_use = function(self, card)
        local total = (#G.jokers.highlighted + #G.hand.highlighted)
        return (total <= self.config.max_highlighted) and (total ~= 0)
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local count1 = 0
		local count2 = 0
		local stickers = SMODS.Stickers
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		if #G.hand.highlighted > 0 then
			for i = 1, #G.hand.highlighted do
				count1 = count1 + 1
				local percent = 1.15 - (i - 0.999) / (count1 - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						G.hand.highlighted[i]:flip()
						play_sound("card1", percent)
						G.hand.highlighted[i]:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
		end
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				count1 = count1 + 1
				local percent = 1.15 - (i - 0.999) / (count1 - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						G.jokers.highlighted[i]:flip()
						play_sound("card1", percent)
						G.jokers.highlighted[i]:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
		end
		delay(0.2)
		if #G.hand.highlighted > 0 then
			for i = 1, #G.hand.highlighted do
				count2 = count2 + 1
				local target = G.hand.highlighted[i]
				local percent = 0.85 + (i - 0.999) / (count2 - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						target:flip()
						target:set_ability(G.P_CENTERS.c_base, true, nil)
						target:set_edition(nil, true)
						target:set_seal(nil, true)
						for k,v in pairs(stickers) do
							if target.ability[k] then
								if v.removed then v:removed(target) end --Patch for Gemstones; I don't think this is universal
								target:remove_sticker(k)
							end
						end
						target.ability.dekaja = G.GAME.round
						SMODS.recalc_debuff(target)
						play_sound("tarot2", percent)
						target:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
		end
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				count2 = count2 + 1
				local target = G.jokers.highlighted[i]
				local percent = 0.85 + (i - 0.999) / (count2 - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						target:flip()
						target:set_edition(nil, true)
						for k,v in pairs(stickers) do
							if target.ability[k] then
								if v.removed then v:removed(target) end --Patch for Gemstones; I don't think this is universal
								target:remove_sticker(k)
							end
						end
						play_sound("tarot2", percent)
						target:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
		end

		G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.15,
		func = function()
			G.hand:unhighlight_all()
			G.jokers:unhighlight_all()
			return true
		end
		}))

	end,
}