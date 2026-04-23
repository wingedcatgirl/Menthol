SMODS.Consumable{
    set = 'Tarot',
    key = 'magnet',
    name = "The Magnet",
    atlas = 'tarots',
    pos = {
        x = 0,
        y = 2
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {max_highlighted = 1, enh_conv = 'm_minty_hematite'},

    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.enh_conv]
		local key = self.key
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
            }
        }
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        MINTY.tarotflip(used_tarot, { enh = card.ability.enh_conv })
    end,

    in_pool = function (self, args)
        return true
    end
}