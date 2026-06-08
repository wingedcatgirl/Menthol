SMODS.Joker {
    key = "hedonist",
    name = "Hedonist Joker",
    pronouns = "he_any",
    atlas = 'jokers',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    effect = "Suit Mult",
    cost_mult = 1.0,
    config = {
        extra = {
            s_mult = 3,
            suit = 'minty_3s',
            again = 0
        }
    },
    attributes = {
        "mult", "suit", "rank", "minty_3s"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end
        if MINTY.config.flavor_text and G.localization.descriptions.Flavor[self.key] then
            local text = { {
                n = G.UIT.R,
                config = { colour = G.C.CLEAR, align = "cm" },
                nodes = {{ n = G.UIT.T, config = { text = " ", colour = G.C.CLEAR, scale = 0.256 } }}
            } }
            main_end = { {
                n = G.UIT.C,
                config = { colour = G.C.CLEAR, align = "cm" },
                nodes = text
            } }

            for i, lines in ipairs(G.localization.descriptions.Flavor[self.key].text_parsed) do
                local final_line = SMODS.localize_box(lines, {})
                text[#text + 1] = {
                    n = G.UIT.R,
                    config = { colour = G.C.CLEAR, align = "cm" },
                    nodes = final_line
                }
            end
        end
        return {
            key = key,
            main_end = main_end,
            vars = { card.ability.extra.s_mult, card.ability.extra.suit }
        }
    end,
    in_pool = function(self, args)
        return MINTY.threeSuit_in_pool()
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                mult = card.ability.extra.s_mult,
                card = card
            }
        end

        if context.cardarea == G.play and context.individual and context.other_card:is_3() then
            local count = context.other_card:is_3()
            card.ability.extra.again = count - 1
            --sendDebugMessage('[Minty] Count set to '..count)
            return {
                mult = card.ability.extra.s_mult,
                card = card
            }
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
