FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_shortcut" },
    { name = "j_runner", carry_stat = "chips" },
  }, cost = 12, result_joker = "j_minty_parkour"
}

SMODS.Joker {
    key = "parkour",
    name = "Parkour",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 5
    },
    soul_pos = {
        x = 1,
        y = 5
    },
    rarity = "fuse_fusion",
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            chips = 0,
            chipgain = 15,
            chipgain_base = 5,
            chipgain_gain = 5,
        }
    },
    attributes = {
        "chips", "scaling", "hand_type", "passive"
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = 'Joker', key = 'j_shortcut', config = {} }
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chipgain,
                card.ability.extra.chipgain_gain,
                localize{type = 'name_text', key = "j_shortcut", set = 'Joker'},
                localize{type = 'name_text', key = "j_runner", set = 'Joker'},
            }
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            local chipgain = card.ability.extra.chipgain
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chipgain",
                scaling_message = {
                    message = localize{
                        type='variable',
                        key='a_minty_chipgain',
                        vars={chipgain}
                    }
                }
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chipgain",
                scalar_value = "chipgain_gain",
                no_message = true
            })
            return {
                chips = card.ability.extra.chips,
            }
        end

        if context.before and not context.blueprint then
            if next(context.poker_hands['Straight']) then
                local chipgain = card.ability.extra.chipgain
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chipgain",
                    scaling_message = {
                        message = localize{
                            type='variable',
                            key='a_minty_chipgain',
                            vars={chipgain}
                        }
                    }
                })
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chipgain",
                    scalar_value = "chipgain_gain",
                    no_message = true
                })
                return {
                    chips = card.ability.extra.chips,
                }
            else
                card.ability.extra.chipgain = card.ability.extra.chipgain_base
                return {
                    message = localize('k_minty_stopped'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end

        if context.joker_main then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_chips',
                    vars = {card.ability.extra.chips}
                },
                chips = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end
}

local shortcutref = SMODS.shortcut
function SMODS.shortcut()
    return (not not next(SMODS.find_card('j_minty_parkour'))) or shortcutref()
end