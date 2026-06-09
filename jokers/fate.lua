SMODS.Joker {
    key = "fate",
    name = "Fate",
    pronouns = "she_her",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 6,
        y = 8
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            luck1 = 2,
            odds1 = 2,
            luck2 = 0,
            odds2 = 2,
        }
    },
    attributes = {
        "chance"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local luck1, odds1 = SMODS.get_probability_vars(card, card.ability.extra.luck1, card.ability.extra.odds1, "minty_fate_desc_good", false, true)
        local luck2, odds2 = SMODS.get_probability_vars(card, card.ability.extra.luck2, card.ability.extra.odds2, "minty_fate_desc_bad", false, true)
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                luck1, odds1,
                luck2, odds2,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local ret
            if SMODS.pseudorandom_probability(card, "minty_fate_good", card.ability.extra.luck1, card.ability.extra.odds1, card, true) then
                ret = {
                    message = localize("k_minty_yep")
                }
                if SMODS.pseudorandom_probability(card, "minty_fate_bad", card.ability.extra.luck2, card.ability.extra.odds2, card, true) then
                    ret.extra = {
                        message = localize("k_minty_yep")
                    }
                else
                    ret.extra = {
                        message = localize("k_nope_ex")
                    }
                end
                return ret
            else
                return {
                    message = localize("k_nope_ex")
                }
            end
            return {
                message = localize("k_nope_ex")
            }
        end
    end
}