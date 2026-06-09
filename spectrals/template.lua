SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "SPECTRAL",
	key = "SPECTRAL",
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
	cost = 4,
	atlas = "spectrals",
	pos = { x = 3, y = 2 },
	use = function(self, card, area, copier)

	end,
}