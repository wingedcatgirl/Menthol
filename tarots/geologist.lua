SMODS.Consumable{
    set = 'Tarot', atlas = 'tarots',
    key = 'geologist',
    name = "The Geologist",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    pos = {
        x = 0,
        y = 1
    },

    config = {max_highlighted = 3},
    
    attributes = {"modify_card", "minty_rocks", "enhancements"},

    loc_vars = function (self, info_queue, card)
		info_queue[#info_queue+1] = MINTY.enhancement_list(MINTY.bag_to_map(SMODS.get_attribute_pool("minty_rock_card")), "rock")
        key = self.key
        local plural = false
        if card.ability.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.max_highlighted,
                s,
                a,
                localize{type = 'name_text', set = 'Other', key = "minty_stone_cards"}
            }
        }
    end,

    use = function(self)
        local used_tarot = copier or card
        MINTY.tarotflip(used_tarot, { random_enhs = SMODS.get_attribute_pool("minty_rock_card"), seed = "minty_geologist" })
    end,

    in_pool = function (self, args)
        return true
    end
}