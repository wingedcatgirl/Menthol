local paperback = next(SMODS.find_mod("paperback"))

SMODS.Joker {
    key = "catnipfields",
    name = "Catnip Fields",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 5,
        y = 2
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["Paperback"] = true, --Increase freqency when playing with Paper Deck
    },
    config = { extra = {
        xmult = 1.05,
        xmultgain = 0.05,
        xmultbase = 1.05,
        again = 0
    } },
    attributes = {
        "xmult", "scaling", "reset", "rank", "suit", "minty_3s"
    },
    loc_vars = function(self, info_queue, card)
        if MINTY.in_collection(card) and not (paperback or MINTY.config.dev_mode or G.GAME.minty_crossover) then
            info_queue[#info_queue + 1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Mod", "Paperback" } }
        end
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = { card.ability.extra.xmult, card.ability.extra.xmultgain, card.ability.extra.xmultbase }
        }
    end,
    in_pool = function(self, args)
        return (paperback or MINTY.config.dev_mode or G.GAME.minty_crossover) and MINTY.threeSuit_in_pool()
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultgain
            return {
                xmult = card.ability.extra.xmult,
                card = card
            }
        end

        if context.cardarea == G.play and context.individual then
            if not context.other_card:is_3() then
                card.ability.extra.xmult = card.ability.extra.xmultbase
                return
            end
            -- Give the xMult if the current card is a 3
            if context.other_card:is_3() then
                -- Upgrade the xMult
                local xmult = card.ability.extra.xmult
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultgain

                --Prepare to retrigger if card is a 3 multiple times
                local count = context.other_card:is_3()
                card.ability.extra.again = count - 1

                return {
                    xmult = xmult,
                    card = card
                }
            end
        end

        --Retrigger self if played card was a 3 multiple times
        if context.retrigger_joker_check and card.ability.extra.again ~= 0 and context.other_card == card then
            local again = card.ability.extra.again
            card.ability.extra.again = 0
            return {
                message = localize("k_again_ex"),
                message_card = card,
                repetitions = again,
            }
        end

        -- Quietly reset the xMult for the card at the end of played hand
        if context.after and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmultbase
        end
    end
}
