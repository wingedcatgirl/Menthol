SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "Test Card",
	key = "testcard",
	config = {
        max_highlighted = 1
	},
	loc_vars = function(self, info_queue, card)
		local key = self.key
		return {
			key = key,
			main_end = main_end,
			vars = {

            }
		}
	end,
    loc_txt =  {
        name = "Test Card",
        text = {"Does whatever I'm", "testing right now!"}
    },
	cost = 4,
	atlas = "spectrals",
	pos = { x = 3, y = 2 },
	--soul_pos = { x = 1, y = 0},
    no_collection = not MINTY.config.dev_mode,
    in_pool = function (self, args)
        return false
    end,
	use = function(self, card, area, copier)
		local used_card = copier or card
        MINTY.tarotflip(used_card, { edi = "remove", enh = "m_wild", suit = "minty_3s", rank = "Ace" })
	end,
}