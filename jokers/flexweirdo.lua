SMODS.Joker {
    key = "flexweirdo",
    name = "Joker Who Constantly Makes Cracks About How Good Someone Must Be In Bed If They Stretch A Slightly Unusual Distance (Like Come On Man They're Not Even A Contortionist That's Just Normal Human Variation)", --or JWCMCAHGSMBIBITSASUD for short.
    pronouns = "he_him",
    atlas = 'jokers',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    no_collection = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            s_mult = 3
        }
    },
    attributes = {
        "suit", "mult"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local namekey = "minty_flexweirdo_full_name"
        local main_end = MINTY.flavorize(key)
        if MINTY.config.flavor_text then
            namekey = namekey.."_flavor"
        end
        info_queue[#info_queue + 1] = {
            set = "Other",
            key = namekey,
        }
        local suit
        if G.GAME.minty_focussuit == nil then
            suit = localize("k_minty_first_suit")
        elseif G.GAME.minty_focussuit == "suitless" then
            suit = localize("k_minty_no_suit")
        elseif G.GAME.minty_focussuit == "all-suit" then
            suit = localize("k_minty_all_suits")
        else
            suit = localize(G.GAME.minty_focussuit, "suits_plural").." suit" --TODO localizify this phrase; figure out how v_dictionary works again
        end
        return {
            key = key,
            main_end = main_end,
            vars = {
                suit,
                card.ability.extra.s_mult
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
        if context.forcetrigger then
            return {
                mult = card.ability.extra.s_mult,
            }
        end

        if not G.GAME.minty_focussuit then return end

        if context.cardarea == G.play and context.individual and context.other_card then
            if (G.GAME.minty_focussuit == "suitless" and SMODS.has_no_suit(context.other_card))
            or (G.GAME.minty_focussuit == "all-suit" and SMODS.has_any_suit(context.other_card))
            or context.other_card:is_suit(G.GAME.minty_focussuit) then
                return {
                    mult = card.ability.extra.s_mult,
                }
            end
        end
    end
}