SMODS.Consumable{
    set = 'Tarot',
    key = 'grin',
    name = "The Grin",
    atlas = 'tarots',
    pos = {
        x = 2,
        y = 1
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {max_highlighted = 2, mod_conv = 'randomize_rank'},

    loc_vars = function(self, info_queue, card)
		local key = self.key
        local plural = false
        if card.ability.consumeable.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.consumeable.max_highlighted,
                s,
                a,
            }
        }
    end,

    use = function(self, card, area, copier)
        local ranks = {}
        for k,v in pairs(SMODS.Ranks) do
            if v.face and (not v.in_pool or v:in_pool({grin = true})) then
                table.insert(ranks,k)
            end
        end

        local used_tarot = copier or card
        MINTY.tarotflip(used_tarot, { random_ranks = ranks, seed = "minty_grin" })
        if math.random(25) == 1 then
            play_sound("minty_DRIVING", nil, 0.15)
        end
    end,

    in_pool = function()
        return true
    end
}