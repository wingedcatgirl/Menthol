SMODS.Joker {
    key = "bonkdice",
    name = "Bonkin' Dice",
    --pronouns = "",
    atlas = 'dice',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            min = 1,
            max = 6,
            gain = 2,
        },
        immutable = {
            x = 0,
            soulx = 0
        }
    },
    attributes = {
        "mult", "scaling", "chance"
    },
    load = function (self, card, card_table, other_card)
        MINTY.event(function ()
            if not card.ability and card.ability.immutable then return false end
            local diceref = card.config.center
            local x, soulx = card.ability.immutable.x, card.ability.immutable.soulx
            diceref.pos = {
                x = x,
                y = 0,
            }
            diceref.soul_pos = {
                x = soulx,
                y = 1,
            }
            card:set_sprites(diceref)
            return true
        end, {blocking = false, blockable = false})
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local min, max = SMODS.get_probability_vars(card, card.ability.extra.min, card.ability.extra.max, "minty_bonk_dice_roll", true)
        min = math.min(min, max)
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                min,
                max,
                card.ability.extra.gain
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local min, max = SMODS.get_probability_vars(card, card.ability.extra.min, card.ability.extra.max, "minty_bonk_dice_roll", true)
            min = math.min(min, max)
            local mult = pseudorandom("minty_bonk_dice_roll", min, max)
            if mult == max then
                SMODS.pseudorandom_probability(card, "minty_bonk_upgrade", 1, 1, nil, true) --Force a successful luck roll so things that care about that can respond
                MINTY.event(function ()
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "max",
                        scalar_value = "gain"
                    })
                    return true
                end)
            else
                SMODS.pseudorandom_probability(card, "minty_bonk_don't_upgrade", 0, max, nil, true) --...or a failed luck roll.
            end
            --Again!
            min, max = SMODS.get_probability_vars(card, card.ability.extra.min, card.ability.extra.max, "minty_bonk_dice_roll", true)
            min = math.min(min, max)
            local mult2 = pseudorandom("minty_bonk_dice_roll", min, max)
            if mult2 == max then
                SMODS.pseudorandom_probability(card, "minty_bonk_upgrade", 1, 1, nil, true)
                MINTY.event(function ()
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "max",
                        scalar_value = "gain"
                    })
                    return true
                end)
            else
                SMODS.pseudorandom_probability(card, "minty_bonk_don't_upgrade", 0, max, nil, true)
            end
            if mult > 0 then
                MINTY.event(function ()
                    local diceref = card.config.center
                    local x, soulx = pseudorandom("minty_bonk_sprite1", 0, 5), pseudorandom("minty_bonk_sprite2", 0, 5)
                    card.ability.immutable.x, card.ability.immutable.soulx = x, soulx
                    diceref.pos = {
                        x = x,
                        y = 0,
                    }
                    diceref.soul_pos = {
                        x = soulx,
                        y = 1,
                    }
                    card:set_sprites(diceref)
                    return true
                end)
                return {
                    mult = mult,
                    func = function ()
                        MINTY.event(function ()
                            local diceref = card.config.center
                            local x, soulx = pseudorandom("minty_bonk_sprite1", 0, 5), pseudorandom("minty_bonk_sprite2", 0, 5)
                            card.ability.immutable.x, card.ability.immutable.soulx = x, soulx
                            diceref.pos = {
                                x = x,
                                y = 0,
                            }
                            diceref.soul_pos = {
                                x = soulx,
                                y = 1,
                            }
                            card:set_sprites(diceref)
                            return true
                        end)
                    end,
                    extra = {
                        mult = mult2,
                    }
                }
            end
        end
    end
}