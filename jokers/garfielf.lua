SMODS.Joker {
    key = "garfielf",
    name = "Garfielf",
    pronouns = "he_him",
    atlas = 'legends',
    pos = {
        x = 0,
        y = 2
    },
    soul_pos = {
        x = 0,
        y = 3
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
            xmult = 1,
            xmultgain = 0.5,
            found = false
        }
    },
    attributes = {
        "kity", "destroy_card", "xmult", "scaling", "rank", "suit", "unscored"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local ranks = {}
        local suits = {}
        for k,v in pairs(SMODS.Ranks) do
            if k ~= "3" then
                table.insert(ranks, k)
            end
        end
        for k,v in pairs(SMODS.Suits) do
            if k ~= "minty_3s" then
                table.insert(suits, k)
            end
        end

        local rank = localize(pseudorandom_element(ranks), "ranks")
        local suit = localize(pseudorandom_element(suits), "suits_singular")
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmultgain,
                rank,
                suit,
            }
        }
    end,
    in_pool = function(self, args)
        return MINTY.threeSuit_in_pool()
    end,
    calculate = function(self, card, context)
        if (context.joker_main and context.scoring_hand) or context.forcetrigger then
            --MINTY.say("xMult time :3")
            return {
                    xmult = card.ability.extra.xmult
            }
        end

        if context.cardarea == G.play and context.individual then
            --MINTY.say("Observing card")
            if context.other_card:is_3() then
                --MINTY.say("3 detected!")
                card.ability.extra.found = true
            end
        end

        if context.destroy_card and context.cardarea == "unscored" and card.ability.extra.found == true and not context.blueprint then
            --MINTY.say("Attempting to destroy card")
            if context.destroy_card.ability.eternal then
                --MINTY.say("Card is eternal, no destruaction")
                return
            elseif context.destroy_card:is_3() then
                --MINTY.say("Card is a 3, no destruaction")
                return
            end
            --MINTY.say("Destruaction time >:3")
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmultgain",
                no_message = true
            })
            return {
                delay = 0.4,
                remove = true,
                message = localize('k_minty_nommed'),
                card = card,
            }
        end

        if context.after then
            --MINTY.say("3 forgotten")
            card.ability.extra.found = false
        end

    end
}