SMODS.Joker {
    key = "fatcat-m",
    name = "Fat Cat",
    pronouns = "she_her",
    atlas = 'jokerdoodles',
    pos = {
        x = 6,
        y = 5
    },
    soul_pos = {
        x = 6,
        y = 4
    },
    rarity = 3,
    cost = 11,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["kity"] = true
    },
    config = {
        extra = {
            cost = 5
        },
    },
    attributes = {
        "kity", "generation", "joker", "joker"
    },
    loc_vars = function(self, info_queue, card)
        if not (card.edition and card.edition.negative) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        end
        if not (card.ability and card.ability.rental) then
            info_queue[#info_queue+1] = { set = "Other", key = "rental", specific_vars = { G.GAME.rental_rate or 3 } }
        end
        if not (card.ability and card.ability.perishable) then
            info_queue[#info_queue+1] = { set = "Other", key = "perishable", specific_vars = {G.GAME.perishable_rounds or 5, G.GAME.perishable_rounds or 5} }
        end
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.cost
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind and (to_big(G.GAME.dollars) - to_big(card.ability.extra.cost)) >= to_big(G.GAME.bankrupt_at)) or context.forcetrigger then
                local copier = context.blueprint and context.blueprint_card or card
                G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({
                                set = "Joker",
                                area = G.jokers,
                                key_append = "minty_fatcat",
                                edition = "e_negative",
                                stickers = {
                                    "rental",
                                    "perishable"
                                },
                                force_stickers = true
                            })
                            card:juice_up(0.3, 0.5)
                            card_eval_status_text(copier, 'extra', nil, nil, nil, {message = localize('k_minty_ordered'), delay = 0.35})
                            ease_dollars(-card.ability.extra.cost)
                            return true
                        end}))
        end
    end
}