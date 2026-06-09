SMODS.Joker {
    key = "contraption",
    name = "The Contraption",
    --pronouns = "",
    atlas = 'jokerdoodles',
    pos = {
        x = 5,
        y = 7
    },
    soul_pos = {
        x = 6,
        y = 7
    },
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            chips = 0,
            luck = 1,
            odds = 6,
        }
    },
    attributes = {
        "enhancements", "chips", "chance"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local _, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "minty_contraption", false)
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.chips,
                localize({type = "name_text", set = "Enhanced", key = "m_minty_spline"}),
                odds,
            }
        }
    end,
    in_pool = function (self, args)
        local spline = MINTY.find_enhancement("m_minty_spline", true)
        local mf = not not next(SMODS.find_mod("MoreFluff"))
        if not mf then
            if not (pseudorandom("minty_contraption_weight", 1, 2) == 1) then return false end
        end
        return spline
    end,
    calculate = function(self, card, context)
        if context.before then
            local splinecount = 0
            for i,v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(context.scoring_hand[i], "m_minty_spline") then
                    splinecount = splinecount + 1
                end
            end
            card.ability.extra.luck = splinecount
        end

        if context.cardarea == G.play and context.individual and SMODS.has_enhancement(context.other_card, "m_minty_spline") and context.other_card.ability.perma_bonus > 0 then
            if SMODS.pseudorandom_probability(card, "minty_contraption_scoring", card.ability.extra.luck, card.ability.extra.odds) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_table = context.other_card.ability,
                    scalar_value = "perma_bonus"
                })
                return nil, true
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}