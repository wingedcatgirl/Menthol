SMODS.Consumable{
    set = 'Tarot', atlas = 'tarots',
    key = 'geologist',
    name = "The Geologist",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {max_highlighted = 3},
    pos = {
        x = 0,
        y = 1
    },

    loc_vars = function (self, info_queue, card)
		info_queue[#info_queue+1] = MINTY.enhancement_list(MINTY.rocks, "rock")
        key = self.key
        local plural = false
        if card.ability.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
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
        MINTY.tarotflip(used_tarot, { random_enhs = MINTY.rockbag, seed = "minty_geologist" })
    end,

    in_pool = function (self, args)
        return true
    end
}