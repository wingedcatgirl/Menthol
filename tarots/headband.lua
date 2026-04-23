SMODS.Consumable{
    set = 'Tarot',
    key = 'headband',
    name = "The Headband",
    atlas = 'tarots',
    pos = {
        x = 4,
        y = 1
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {
        max_highlighted = 1
    },

    loc_vars = function(self, info_queue, card)
		local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end

        info_queue[#info_queue+1] = {set = "Other", key = "minty_cat_ears"}

        return {
            key = key,
            vars = {
                card.ability.max_highlighted,
                card.ability.max_highlighted ~= 1 and "up to " or "",
                card.ability.max_highlighted ~= 1 and "s" or "",
            }
        }
    end,

    can_use = function (self, card)
        local jokers = MINTY.get_all_highlighted(card, {"jokers"})

        return jokers and #jokers > 0 and #jokers <= card.ability.max_highlighted
    end,

    use = function(self, card, area, copier)
        local jokers = MINTY.get_all_highlighted(card, {"jokers"})

        for i,v in ipairs(jokers) do
            v:add_sticker("minty_cat_ears", true)
            v:juice_up()
        end

        play_sound("minty_meow"..math.random(1,3))
        G.jokers:unhighlight_all()
    end,

    in_pool = function (self, args)
        return true
    end
}