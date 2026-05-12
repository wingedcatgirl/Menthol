SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "The Wand",
	key = "wand",
	effect = "Unlocker",
	config = {},
	loc_vars = function(self, info_queue, card)
		local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
		return {
			key = key,
		}
	end,
	cost = 4,
	hidden = true,
	soul_set = 'Tarot',
	soul_rate = 0.0015, --Half the Soul's rate cause we don't want to flood the pool with these things
	atlas = "placeholder",
	pos = { x = 2, y = 9 },
	soul_pos = { x = 2, y = 8},
	can_use = function(self, card)
		if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
			return true
		else
			return false
		end
	end,
	in_pool = function (self, args)
		return true
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			SMODS.add_card({
				attributes = {"kity"},
				area = G.jokers,
				key_append = "minty_wand",
				rarity = 4,
				filter = function (pool)
					print(pool)
					local gold_available, catcat_available = MINTY.at_least_stake(G.GAME.stake, "stake_gold"), MINTY.at_least_stake(G.GAME.stake, "stake_minty_catcat")
					if not (gold_available or catcat_available) then return pool end
					local needs_gold, needs_catcat = {}, {}
					for i,v in ipairs(pool) do
						local key = v.key
						local not_gold, not_catcat = true, true
						local function getwinsbykey()
							return G.PROFILES[G.SETTINGS.profile].joker_usage[key].wins_by_key
						end
						local wbk = pcall(getwinsbykey) or {}

						for kk,vv in pairs(wbk) do
							if gold_available and not_gold and MINTY.at_least_stake(kk, "stake_gold") then
								not_gold = false
							end
							if catcat_available and not_catcat and MINTY.at_least_stake(kk, "stake_minty_catcat") then
								not_catcat = false
							end
						end
						if gold_available and not_gold then
							needs_gold[#needs_gold+1] = v
						end
						if catcat_available and not_catcat then
							needs_catcat[#needs_catcat+1] = v
						end
					end
					local basket = SMODS.merge_lists(gold_available and #needs_gold > 0 and needs_gold or {}, catcat_available and #needs_catcat > 0 and needs_catcat or {})

					return #basket > 0 and basket or pool
				end
			})
			return true end }))
		delay(0.6)
	end,
}

local soul_soul_rate = G.P_CENTERS.c_soul.soul_rate or 0.003

SMODS.Consumable:take_ownership("c_soul", {
	soul_rate = soul_soul_rate/2, --... and halve the Soul's rate because, again, no flooding the pool.
	soul_set = "Tarot", --Setting the soul set in case setting the soul rate without it breaks anything
}, true)