FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_minty_flexweirdo" },
    { name = "j_minty_shadowcrystal" },
  }, cost = 12, result_joker = "j_minty_superboss"
}

SMODS.Joker {
    key = "superboss",
    name = "Superboss",
    pronouns = "he_him",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 1
    },
    rarity = "fuse_fusion",
    cost = 12,
    unlocked = true,
    discovered = true,
    no_collection = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            dollars = 1,
            chips = 50,
            mult = 7,
            xmult = 1.25,
            dollarsgain = 1,
            chipsgain = 10,
            multgain = 2,
            xmultgain = 0.1,
            req = 5,
        }
    },
    attributes = {
        "suit", "economy", "chips", "mult", "xmult", "scaling"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        local suit
        if G.GAME.minty_focussuit == nil then
            suit = localize("k_minty_first_suit")
        elseif G.GAME.minty_focussuit == "suitless" then
            suit = localize("k_minty_no_suit")
        elseif G.GAME.minty_focussuit == "all-suit" then
            suit = localize("k_minty_all_suits")
        else
            suit = localize(G.GAME.minty_focussuit, "suits_plural").." suit"
        end
        return {
            key = key,
            vars = {
                suit,
                card.ability.extra.dollars,
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult,
                card.ability.extra.req,
            }
        }
    end,
    calculate = function(self, card, context)
        local results = {
            "mult", "chips", "dollars", "xmult"
        }
        local result = pseudorandom_element(results, "minty_shadowcrystal")

        if context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "multgain",
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmultgain",
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chipsgain",
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "dollarsgain",
            })
            return {
                mult = card.ability.extra.mult,
                dollars = card.ability.extra.dollars,
                xmult = card.ability.extra.xmult,
                chips = card.ability.extra.chips,
            }
        end

        if not G.GAME.minty_focussuit then return end

        if context.initial_scoring_step and #context.scoring_hand >= card.ability.extra.req then
            local hitcount = 0
            local misscount = 0
            for i,v in ipairs(context.scoring_hand) do
                if (G.GAME.minty_focussuit == "suitless" and SMODS.has_no_suit(context.scoring_hand[i]))
                or (G.GAME.minty_focussuit == "all-suit" and SMODS.has_any_suit(context.scoring_hand[i]))
                or context.scoring_hand[i]:is_suit(G.GAME.minty_focussuit) then
                    hitcount = hitcount + 1
                else
                    misscount = misscount + 1
                end

                if (#context.scoring_hand - misscount) < card.ability.extra.req then break end
            end
            if hitcount >= card.ability.extra.req then
                for i=card.ability.extra.req,hitcount do
                    local result2 = pseudorandom_element(results, "minty_shadowcrystal_scale")
                    SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = result2,
                    scalar_value = result2.."gain",
                    })
                end
            end
        end

        if context.cardarea == G.play and context.individual and context.other_card then
            if (G.GAME.minty_focussuit == "suitless" and SMODS.has_no_suit(context.other_card))
            or (G.GAME.minty_focussuit == "all-suit" and SMODS.has_any_suit(context.other_card))
            or context.other_card:is_suit(G.GAME.minty_focussuit) then
                local ret = {}
                ret[result] = card.ability.extra[result]
                return ret
            end
        end
    end
}