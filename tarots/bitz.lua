SMODS.Consumable {
	object_type = "Consumable",
	set = "Tarot",
	name = "The Bitz",
	key = "bitz",
	effect = "Random Joker",
	config = {},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "normal_jokers", specific_vars = { } }
		local key = self.key
        local main_end = MINTY.flavorize(self.key)
		return {
			key = key,
			main_end = main_end,
			}
	end,
	cost = 4,
	atlas = "tarots",
	pos = { x = 2, y = 0 },
	can_use = function(self, card)
		if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
			return true
		else
			return false
		end
	end,
    in_pool = function (self, args) --Make this artificially rarer until we have more kity jokers for it to summon
        if pseudorandom("bitzchance") > 1/3 then return false end
        return true
    end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			local newcat = SMODS.add_card({
				attributes = {"kity"},
				area = G.jokers,
				key_append = "minty_bitz",
				filter = function (pool) --temp fix for the pool culling bug
					local res = {}
					local vanillas = {
						"Common", "Uncommon", "Rare", "Legendary"
					}
					for i,v in ipairs(pool) do
						if v.key ~= "UNAVAILABLE" then
							print(v.key)
							local _,rarity = pcall(function ()
								return G.P_CENTERS[v.key].rarity
							end)
							rarity = vanillas[rarity] or rarity
							local weight = SMODS.Rarities[rarity].default_weight
							weight = SMODS.Rarities[rarity].get_weight and SMODS.Rarities[rarity]:get_weight(weight, SMODS.ObjectTypes.kity) or weight
							if weight > 0 then
								res[#res+1] = v
							end
						end
					end

					return #res > 0 and res or {"j_lucky_cat"}
				end
			})
			return true end }))
		delay(0.6)
	end,
}