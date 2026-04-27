SMODS.Joker {
    key = "excited",
    name = "Overly Excited",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 2
    },
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {["Meme"] = true}, -- Cryptid compatibility for refactor
    config = {extra = {chips = 0, chipgain = 1, mult = 0, multgain = 1, odds = 32}},
    attributes = {
        "chips", "mult", "chance", "scaling"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "minty_excited_desc", false)
        return {
            key = key,
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chipgain,
                card.ability.extra.mult,
                card.ability.extra.multgain,
                odds,
                luck,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chipgain",
                scaling_message = {
                    message = localize {
                        type = 'variable',
                        key = 'a_minty_chipgain',
                        vars = { card.ability.extra.chipgain },
                    },
                    colour = G.C.CHIPS,
                    delay = 0.2,
                }
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "multgain",
                scaling_message = {
                    message = localize {
                        type = 'variable',
                        key = 'a_mult',
                        vars = { card.ability.extra.multgain },
                    },
                    colour = G.C.RED,
                    delay = 0.2,
                }
            })
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
            }
        end

        if context.joker_main and context.scoring_hand then
            local result = {}
            if (card.ability.extra.mult == 0 and card.ability.extra.chips == 0) then --Is this even possible?
                return
            end
            if card.ability.extra.mult ~= 0 then
                result["mult"] = card.ability.extra.mult
            end
            if card.ability.extra.chips ~= 0 then
                result["chips"] = card.ability.extra.chips
            end
            return result
        end
        if
			(-- Mostly copied from Cryptid's "sob" and "Duplicare"
                (context.post_trigger and (context.other_context.main_eval or context.other_context.individual) and (context.other_card ~= card))
                or (context.cardarea == G.play and context.individual)
				or context.discard
				or context.reroll_shop
				or context.buying_card
				or context.skip_blind
				or context.using_consumeable
				or context.selling_card
				or context.setting_blind
				or context.skipping_booster
				or context.open_booster
			)
			and not context.retrigger_joker
            and not context.create_shop_card
			and not context.blueprint
		then
            --[[]]
            for k,v in pairs(context) do
                if v == true then
                    MINTY.say(k, "TRACE")
                end
            end
            --]]
            if not SMODS.pseudorandom_probability(card, "minty_excited", 1, card.ability.extra.odds, "minty_excited") then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chipgain",
                    scaling_message = {
                        message = localize {
                            type = 'variable',
                            key = 'a_minty_chipgain',
                            vars = { card.ability.extra.chipgain },
                        },
                        colour = G.C.CHIPS,
                        delay = 0.2,
                    }
                })
                return {}
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "multgain",
                    scaling_message = {
                        message = localize {
                            type = 'variable',
                            key = 'a_mult',
                            vars = { card.ability.extra.multgain },
                        },
                        colour = G.C.RED,
                        delay = 0.2,
                    }
                })
                return {}
            end
		end
    end
}

if not not next(SMODS.find_mod("Cryptid")) then
    table.insert(Cryptid.memepack, "j_minty_excited")
end
