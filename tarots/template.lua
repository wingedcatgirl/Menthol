SMODS.Consumable{
    set = 'Tarot',
    key = 'TAROT',
    name = "The TAROT",
    atlas = 'tarots',
    pos = {
        x = 3,
        y = 2
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

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

    use = function(self, card, area, copier)
        
    end,

    in_pool = function (self, args)
        return true
    end
}