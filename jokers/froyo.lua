SMODS.Joker {
    key = "froyo",
    name = "Frozen Yogurt",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 0
    },
    rarity = 1,
    cost = 1,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {["Food"] = true}, -- Cryptid compatibility for refactor
    config = {
        extra = {
            chips = 50,
            chip_mod = 5
        }
    },
    attributes = {
        "chips", "food", "scaling"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {card.ability.extra.chips, card.ability.extra.chip_mod}
        }
    end,
    calculate = function(self, card, context)
        if (context.after and not context.blueprint) or context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chip_mod",
                operation = "-",
                no_message = true
            })
            if to_big(card.ability.extra.chips) > to_big(0) then
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize {
                        type = 'variable',
                        key = 'a_chips_minus',
                        vars = {card.ability.extra.chip_mod}
                    },
                    colour = G.C.CHIPS
                });
            else
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.FILTER
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end
}

if not not next(SMODS.find_mod("Cryptid")) then
    table.insert(Cryptid.food, "j_minty_froyo")
end