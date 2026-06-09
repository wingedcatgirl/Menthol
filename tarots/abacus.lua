SMODS.Consumable{
    set = 'Tarot',
    key = 'abacus',
    name = "The Abacus",
    atlas = 'tarots',
    pos = {
        x = 3,
        y = 1
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {max_highlighted = 3, mod_conv = 'randomize_rank'},

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
            if not v.face and (not v.in_pool or v:in_pool({abacus = true})) and k~= "Ace" then
                table.insert(ranks,k)
            end
        end

        local used_tarot = copier or card
        MINTY.tarotflip(used_tarot, { random_ranks = ranks, seed = "minty_abacus" })
    end,

    in_pool = function()
        return true
    end
}