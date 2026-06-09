local ortalab = next(SMODS.find_mod("ortalab"))

SMODS.Joker {
    key = "sabertooth",
    name = "Saber Tooth",
    atlas = 'ortalabdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 1
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["Ortalab"] = true, --Can appear on Ortalab Stakes
    },
    config = {
        extra = {
            odds = 3,
            suit = 'minty_3s',
            xmult = 2,
            again = 0
        }
    },
    attributes = {
        "chance", "xmult", "minty_3s", "suit", "rank"
    },
    loc_vars = function(self, info_queue, card)
        if MINTY.in_collection(card) and not (ortalab or MINTY.config.dev_mode or G.GAME.minty_crossover) then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Mod", "Ortalab" } }
        end
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        local unluck, odds = SMODS.get_probability_vars(self, 1, card.ability.extra.odds, "minty_sabertooth_desc", false)
        return {
            key = key,
            main_end = main_end,
            vars = {
                unluck,
                odds,
                localize(card.ability.extra.suit, "suits_plural"),
                card.ability.extra.xmult
            }
        }
    end,
    in_pool = function(self, args)
        return (ortalab or MINTY.config.dev_mode or G.GAME.minty_crossover) and MINTY.threeSuit_in_pool()
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult,
                card = card
            }
        end

        if context.cardarea == G.hand and context.individual and not context.end_of_round and context.other_card:is_3() then
            local trycount = context.other_card:is_3()
            local repcount = 0
            for _try=1,trycount do
                if not SMODS.pseudorandom_probability(card, 'tooth', 1, card.ability.extra.odds, 'tooth') then
                    repcount = repcount + 1
                end
            end
            card.ability.extra.again = repcount
            --sendDebugMessage('Count (individual): '..card.ability.extra.again)
            if card.ability.extra.again ~= 0 then
                return {
                    xmult = card.ability.extra.xmult,
                    card = card
                }
            end
        end

        if context.retrigger_joker_check and card.ability.extra.again ~= 0 and context.other_card == card then
            local reps = card.ability.extra.again-1
            card.ability.extra.again = 0
            if reps >= 1 then
                return {
                    message = localize('k_again_ex'),
                    message_card = card,
                    repetitions = reps
                }
            end
        end
    end
}