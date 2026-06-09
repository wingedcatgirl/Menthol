SMODS.Joker {
    key = "phasebus",
    name = "Phase Bus",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 4,
        y = 0
    },
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = true,
    config = { extra = {status = 'Active'} },
    attributes = {
        "generation", "spectral", "face"
    },
    loc_vars = function(self, info_queue, card)
        local active = card.ability.extra.status == "Active" and localize("k_active_ex") or localize("k_minty_inactive")
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {active}
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            if card.ability.extra.status == 'Active' then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        SMODS.add_card{
                            set = "Spectral",
                            key_append = "minty_phase_bus",
                            area = G.consumeables
                        }
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end)}))
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral,
                    card = card
                }
            else
                card.ability.extra.status = 'Active'
                return {
                    message = localize('k_reset'),
                    colour = G.C.SECONDARY_SET.Spectral,
                    card = card
                }
            end
        end

        if context.joker_main and context.scoring_hand and card.ability.extra.status == 'Active' and not context.blueprint and not context.end_of_round then
            local faces = 0
            if not context.end_of_round then
                if type(context.scoring_hand) == 'table' then
                    for i = 1, #context.scoring_hand do
                        if context.scoring_hand[i]:is_face() then
                            faces = 1
                        end
                    end
                end
            end

            if faces == 1 then
                card.ability.extra.status = 'Inactive'
                return {
                    message = localize('k_minty_stopped'),
                    colour = G.C.MONEY,
                    card = card,
                }
            end
            return
        end


        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if card.ability.extra.status == 'Active' then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            SMODS.add_card{
                                set = "Spectral",
                                key_append = "minty_phase_bus",
                                area = G.consumeables
                            }
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true
                        end)}))
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                        card = card
                    }
                end
            else
                card.ability.extra.status = 'Active'
                return {
                    message = localize('k_reset'),
                    card = card
                }
            end
        end
    end
}