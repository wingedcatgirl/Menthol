SMODS.Joker {
    key = "fatcat-l",
    name = "Fat cat",
    atlas = 'jokerdoodles',
    pronouns = "he_him",
    pos = {
        x = 4,
        y = 5
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
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
            xmultgain = .5,
        }
    },
    attributes = {
        "kity", "destroy_cards", "xmult", "scaling"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmultgain
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.forcetrigger or context.setting_blind) and not context.blueprint then
            local foodjokers = {}
            local jokerpos = {}
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i].config.center.pools or {}).Food and not SMODS.is_eternal(G.jokers.cards[i], card) then --Food should always be eternal-incompatible anyway but roll with it if it somehow happens
                    --MINTY.say("Found compatible Joker in slot #"..tostring(i))
                    foodjokers[#foodjokers+1] = G.jokers.cards[i]
                    jokerpos[#foodjokers] = i
                end
            end

            if #foodjokers == 0 then return end
            local targetpos = jokerpos[pseudorandom("minty_fatcat_nom", 1, #foodjokers)]
            --MINTY.say("Selected compatible Joker in slot #"..tostring(targetpos))
            SMODS.destroy_cards(G.jokers.cards[targetpos], nil, nil, true)
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmultgain",
                scaling_message = {
                    message = localize("k_minty_nommed"),
                }
            })
        end

        if context.forcetrigger or context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end
}