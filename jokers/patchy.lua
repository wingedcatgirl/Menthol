SMODS.Joker {
    key = "patchy",
    name = "Patchy",
    pronouns = "she_her",
    atlas = 'legends',
    pos = {
        x = 2,
        y = 0
        },
    soul_pos = {
        x = 2,
        y = 1
        },
    rarity = 4,
    cost = 20,
    unlocked = false,
    discovered = false,
    config = {
        extra = {
            xmult = math.sqrt(3),
            again = 0,
        }
    },
    attributes = {
        "xmult", "retrigger", "suit", "rank", "minty_3s", "kity"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {card.ability.extra.xmult}
        }
    end,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["kity"] = true
    },
    in_pool = function(self, args)
        return true --MINTY.threeSuit_in_pool()
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult,
                card = card
            }
        end

        if context.cardarea == G.play then
            if context.individual and context.other_card:is_3() then
            local count = context.other_card:is_3()
            card.ability.extra.again = count - 1
                return {
                    xmult = card.ability.extra.xmult,
                    card = card
                }
            end
            if context.repetition and context.other_card:is_3() then
                local count = context.other_card:is_3()
                return {
                    message = localize('k_again_ex'),
                    repetitions = count,
                    card = card
                }
            end
        end
        if context.retrigger_joker_check and card.ability.extra.again ~= 0 and context.other_card == card then
            local again = card.ability.extra.again
            card.ability.extra.again = 0
            return {
                message = localize("k_again_ex"),
                message_card = card,
                repetitions = again,
            }
        end
    end
}