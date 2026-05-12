local talisman = not not next(SMODS.find_mod("Talisman"))

SMODS.Joker {
    key = "minty",
    name = "Minty",
    pronouns = "it_she",
    atlas = 'legends',
    pos = {
        x = 3,
        y = 0
    },
    soul_pos = {
        x = 3,
        y = 1
    },
    rarity = 4,
    cost = 20,
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["kity"] = true
    },
    config = {
        extra = {
            powmult = 1.3,
            xmult = 3,
            scored = 0,
            target = 3,
            reps = 0,
            moving = 3,
            upgraded = false,
        }
    },
    attributes = {
        "kity", talisman and "emult" or "xmult", "minty_3s", "rank", "suit", "scaling"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        local plural = ""
        if card.ability.extra.reps > 0 then plural = "s" end
        local op = (talisman and "^" or "X")
        local opcol = talisman and G.C.DARK_EDITION or G.C.XMULT
        return {
            key = key,
            vars = {
                talisman and card.ability.extra.powmult or card.ability.extra.xmult,
                card.ability.extra.scored,
                card.ability.extra.target,
                card.ability.extra.reps + 1,
                card.ability.extra.moving,
                plural,
                op,
                colours = {
                    opcol
                }
            }
        }
    end,
    in_pool = function(self, args)
        return true --MINTY.threeSuit_in_pool()
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            MINTY.say("Not yet tested but should be retriggering "..tostring(card.ability.extra.reps).." times", "DEBUG")
            return {
                emult = talisman and card.ability.extra.powmult or nil,
                xmult = (not talisman) and card.ability.extra.xmult or nil,
                repetitions = card.ability.extra.reps,
                card = card
            }
        end
        
        if context.cardarea == G.play and not context.blueprint and context.individual and context.other_card:is_3() and not (context.retrigger_joker or context.retrigger_joker_check) then
            local count = context.other_card:is_3()
            card.ability.extra.scored = card.ability.extra.scored + count
            if card.ability.extra.scored >= card.ability.extra.target then
                card.ability.extra.scored = card.ability.extra.scored - card.ability.extra.target
                card.ability.extra.target = card.ability.extra.target + card.ability.extra.moving
                card.ability.extra.reps = card.ability.extra.reps + 1
                card.ability.extra.upgraded = true
                return {
                    message = localize("k_upgrade_ex"),
                    message_card = card,
                }
            end
        end

        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card and card.ability.extra.reps >= 1 then
            if card.ability.extra.upgraded == true then
                card.ability.extra.upgraded = false --Probably-bad hack to prevent erroneous "Again!" on upgrade
                return
            end
            local addlreps = card.ability.extra.reps - 1
            addlreps = (addlreps > 0) and addlreps or nil
            return {
                repetitions = 1,
                card = card,
                extra = addlreps and {
                    repetitions = addlreps,
                    remove_default_message = true
                }
            }
        end

        if context.joker_main and context.scoring_hand then
            return {
                emult = talisman and card.ability.extra.powmult or nil,
                xmult = (not talisman) and card.ability.extra.xmult or nil,
                card = card
            }
        end
    end
}