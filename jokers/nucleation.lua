SMODS.Joker {
    key = "nucleation",
    name = "Nucleation",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 5,
        y = 0
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            chips = 25,
            count = 0
        },
        immutable = {
            inc = 1
        }
    },
    attributes = {
        "enhancements", "modify_card", "unscored", "full_deck", "chips"
    },
    in_pool = function (self, args)
        return MINTY.find_enhancement("m_minty_crystal", true)
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local cryscount = MINTY.find_enhancement("m_minty_crystal", true, true)
        local total = (cryscount + card.ability.extra.count) * card.ability.extra.chips
        local luck,odds = SMODS.get_probability_vars(card, 1, cryscount, "minty_nucleation_desc", false)
        odds = math.max(odds, 2)
        odds = math.min(odds, ((G.playing_cards and #G.playing_cards or 52) / 2))
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.chips,
                total,
                luck,
                odds
            }
        }
    end,
    calculate = function(self, card, context)
        local cryscount = MINTY.find_enhancement("m_minty_crystal", true, true)
        local total = (cryscount + card.ability.extra.count) * card.ability.extra.chips
        if context.joker_main then
            return {
                chips = total
            }
        end

        if context.individual and context.cardarea == "unscored" then
            local luck,odds = SMODS.get_probability_vars(card, 1, cryscount, "minty_nucleation_prechance", true)
            odds = math.max(odds, 2)
            odds = math.min(odds, ((G.playing_cards and #G.playing_cards or 52) / 2))

            if SMODS.pseudorandom_probability(card, "minty_nucleation_chance", luck, odds, card, true) then --no mod here cause already modded above
                local crystalizing = context.other_card
                return {
                    func = MINTY.event(function ()
                        crystalizing:set_ability("m_minty_crystal", nil, false)
                        return true
                    end),
                    message = localize("k_minty_crystal"),
                    message_card = crystalizing
                }
            end
        end

        if context.remove_playing_cards and not context.blueprint then
            local crystal = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered and SMODS.has_enhancement(removed_card, "m_minty_crystal") then crystal = crystal + 1 end
            end
            local message = true
            local inc = { inc = 1 }
            while crystal > 0 do
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "count",
                    scalar_table = inc,
                    scalar_value = "inc",
                    no_message = not message
                })
                crystal = crystal - 1
                message = false
            end
            return nil, true
        end
    end
}