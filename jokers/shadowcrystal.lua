SMODS.Joker {
    key = "shadowcrystal",
    name = "Shadow Crystal",
    pronouns = "it_its",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 4,
        y = 7
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    no_collection = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            dollars = 1,
            chips = 50,
            mult = 7,
            xmult = 1.25,
        }
    },
    attributes = {
        "suit", "economy", "chips", "mult", "xmult"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
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
            main_end = main_end,
            vars = {
                suit,
                card.ability.extra.dollars,
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult
            }
        }
    end,
    in_pool = function (self, args)
        local deck = (CardSleeves and CardSleeves.Sleeve.get_current_deck_key() == "b_minty_suitfocus")
        local sleeve = G.GAME.selected_sleeve == "sleeve_minty_suitfocussleeve"
        local fused = not not next(SMODS.find_mod("FusionJokers")) and FusionJokers.fusionconfig.block_components and not not next(SMODS.find_card("j_minty_superboss"))
        return (deck or sleeve) and not fused
    end,
    calculate = function(self, card, context)
        local results = {
            {
                mult = card.ability.extra.mult
            },
            {
                dollars = card.ability.extra.dollars
            },
            {
                xmult = card.ability.extra.xmult
            },
            {
                chips = card.ability.extra.chips
            }
        }
        local result = pseudorandom_element(results, "minty_shadowcrystal")

        if context.forcetrigger then
            return {
                mult = card.ability.extra.mult,
                dollars = card.ability.extra.dollars,
                xmult = card.ability.extra.xmult,
                chips = card.ability.extra.chips,
            }
        end

        if not G.GAME.minty_focussuit then return end

        if context.cardarea == G.play and context.individual and context.other_card then
            if (G.GAME.minty_focussuit == "suitless" and SMODS.has_no_suit(context.other_card))
            or (G.GAME.minty_focussuit == "all-suit" and SMODS.has_any_suit(context.other_card))
            or context.other_card:is_suit(G.GAME.minty_focussuit) then
                return result
            end
        end
    end
}