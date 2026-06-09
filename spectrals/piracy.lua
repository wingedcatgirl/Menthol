SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "Piracy",
	key = "piracy",
    select_card = "consumeables",
	config = {
        max_highlighted = 1
	},
	loc_vars = function(self, info_queue, card)
		local key = self.key
        local main_end = MINTY.flavorize(self.key)
		return {
			key = key,
			main_end = main_end,
			vars = {
                max_highlighted = 1
            }
		}
	end,
	cost = 4,
	atlas = "spectrals",
	pos = { x = 2, y = 0 },
    can_use = function (self, card)
		local count = 0

		for _, v in ipairs((G.shop_jokers or {}).highlighted or {}) do
            count = count + 1
		end
		for _, v in ipairs((G.pack_cards or {}).highlighted or {}) do
            count = count + 1
		end
		return (count > 0) and (count <= card.ability.max_highlighted)
    end,
	use = function(self, card, area, copier)
        local all_highlighted = {}
        for _, v in ipairs((G.shop_jokers or {}).highlighted or {}) do
            all_highlighted[#all_highlighted+1] = v
		end
		for _, v in ipairs((G.pack_cards or {}).highlighted or {}) do
            all_highlighted[#all_highlighted+1] = v
		end

		for _, v in ipairs(all_highlighted) do
            local _area, _set
            if v.config.center.set == "Enhanced" or v.config.center.set == "Base" then
                _area = G.deck
                _set = v.config.center.set
            end
            SMODS.add_card{
                key = v.config.center.key,
                stickers = {
                    "minty_pirated"
                },
                force_stickers = true,
                area = _area,
                set = _set,
            }
		end
	end,
}