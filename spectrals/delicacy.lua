SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "Ultimate Delicacy",
	key = "delicacy",
	config = {
	},
	loc_vars = function(self, info_queue, card)
		local key = self.key
        local main_end = MINTY.flavorize(self.key)
		return {
			key = key,
			main_end = main_end,
			vars = {
            }
		}
	end,
	cost = 10,
	hidden = true,
	soul_set = 'minty_treat',
	soul_rate = 0.002,
	atlas = "spectrals",
	pos = {
        x = 3,
        y = 0
    },
    soul_pos = {
        x = 4,
        y = 0
    },
    in_pool = function (self, args)
        return G.GAME.ever_successfully_goaded and not G.GAME.minty_delicacy_consumed
    end,
    can_use = function (self, card)
        if #G.jokers.cards <= 0 then return false end
        for i,v in ipairs(G.jokers.cards) do
            if not v.edition then
                return true
            end
        end
        return false
    end,
	use = function(self, card, area, copier)
        for i,v in ipairs(G.jokers.cards) do
            if not v.edition then
                v:set_edition("e_negative")
                v:juice_up(0.3,0.3)
            end
        end
        G.GAME.minty_delicacy_consumed = true
	end,
}