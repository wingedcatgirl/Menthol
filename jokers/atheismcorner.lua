SMODS.Joker {
    key = "atheismcorner",
    name = "Atheism Corner",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 3
    },
    soul_pos = {
        x = 1,
        y = 4
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            base = 50,
            chips = 50,
            chipgain = 20,
        }
    },
    attributes = {
        "scaling", "chips", "spectral", "reset"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chipgain,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
            }
        end
        if context.end_of_round and not (context.individual or context.repetition or context.retrigger_joker_check or context.retrigger_joker) and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chipgain",
                scaling_message = {
                    message = localize {
                        type = 'variable',
                        key = 'a_chips',
                        vars = {card.ability.extra.chipgain}
                    },
                    colour = G.C.CHIPS
                }
            })
        end
        if context.using_consumeable and (context.consumeable.ability.set == "Spectral") and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.base
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize {
                    key = 'k_reset'
                },
                colour = G.C.CHIPS
            });
        end
    end
}