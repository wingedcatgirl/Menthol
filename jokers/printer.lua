SMODS.Joker {
    key = "printer",
    name = "Printer",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 3,
        y = 1
    },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {

        }
    },
    attributes = {
        "generation", "enhancements"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if (context.first_hand_drawn or context.forcetrigger) and not card.getting_sliced then
            local printed
            G.E_MANAGER:add_event(Event({
                func = function()
                    printed = SMODS.add_card{
                        set = 'Enhanced',
                        area = G.play,
                        key_append = "minty_printer"
                    }
                    return true
                end}))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_minty_printed'), colour = G.C.SECONDARY_SET.Enhanced})

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    return true
                end}))
            draw_card(G.play,G.hand, 90,'up', nil, printed)

            playing_card_joker_effects({printed})
        end
    end
}