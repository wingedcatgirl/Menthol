SMODS.Consumable{
    set = 'Tarot',
    key = 'cat',
    name = "The Cat",
    atlas = 'tarots',
    pos = {
        x = 0,
        y = 0
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {max_highlighted = 3, suit_conv = 'minty_3s'},

    loc_vars = function(self, info_queue, card)
		local key = self.key
        local plural = false
        if card.ability.consumeable.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "
        local suit = localize(card.ability.suit_conv, plural and "suits_plural" or "suits_singular")
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.consumeable.max_highlighted,
                s,
                a,
                suit
            }
        }
    end,

    use = function(self, card, area, copier)
        if not MINTY.threeSuit_in_pool() then MINTY.enable_threeSuit() end
        local used_tarot = copier or card

        MINTY.tarotflip(used_tarot, { suit = card.ability.suit_conv })
    end,

    in_pool = function()
        return MINTY.threeSuit_in_pool(true)
    end
}