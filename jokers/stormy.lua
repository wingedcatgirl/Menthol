SMODS.Joker {
    key = "stormy",
    name = "Stormy",
    pronouns = "she_her",
    atlas = 'legends',
    pos = {
        x = 1,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 1
    },
    rarity = 4,
    cost = 20,
    unlocked = false,
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
            xmult = math.sqrt(3),
            stormcount = 0,
        }
    },
    attributes = {
        "xmult", "kity", "retrigger", "minty_3s", "suit", "rank"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {card.ability.extra.xmult, card.ability.extra.stormcount}
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            local storm = card.ability.extra.stormcount
            MINTY.say("Not yet tested but should be retriggering "..tostring(storm).." times", "DEBUG")
            return {
                xmult = card.ability.extra.xmult,
                repetitions = storm,
            }
        end

        if (context.post_trigger and not context.other_context.fixed_probability and not context.other_context.mod_probability and context.other_card ~= card) then
            card.ability.extra.stormcount = card.ability.extra.stormcount + 1
            --sendDebugMessage('[Minty] Storm count: '..card.ability.extra.stormcount)
        end

        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card and card.ability.extra.stormcount >= 1 then
            --sendDebugMessage('[Minty] Stormy repetitions')
            local storm = card.ability.extra.stormcount
            card.ability.extra.stormcount = 0
            return {
                message = localize("k_minty_storm"),
                repetitions = 1,
                extra = {
                    repetitions = storm-1,
                    remove_default_message = true
                }
            }
        end

        if context.joker_main and context.scoring_hand then
            --sendDebugMessage('[Minty] Stormy Xmult')
            return {
                xmult = card.ability.extra.xmult,
            }
        end

        if context.after then
            card.ability.extra.stormcount = 0
            --sendDebugMessage('[Minty] Storm count cleared (end of hand)')
        end
    end
}