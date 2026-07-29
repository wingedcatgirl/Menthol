SMODS.Stake{
    key = "scarlet",
    atlas = "stakes",
    pos = {
        x = 0,
        y = 0,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 0,
        y = 0,
    },
    unlocked = false,
    prefix_config = {
        above_stake = false,
        applied_stakes = false
    },
    applied_stakes = { "stake_white" },
    above_stake = "stake_red",
    colour = HEX("ff0537"),
    calculate = function (self, context)
        if context.starting_shop then
            return {
                dollars = -1
            }
        end
    end
}

SMODS.Stake{
    key = "irrigo",
    atlas = "stakes",
    pos = {
        x = 1,
        y = 0,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 1,
        y = 0,
    },
    unlocked = false,
    prefix_config = {
        above_stake = false
    },
    applied_stakes = { "scarlet" },
    above_stake = "stake_green",
    colour = HEX("cb0dff"),
    calculate = function (self, context)
        if context.final_scoring_step and G.GAME.current_round.hands_played == 2 and (G.GAME and G.GAME.hands and G.GAME.hands[G.GAME.last_hand_played] and G.GAME.hands[G.GAME.last_hand_played].level > 0) then
            return {
                level_up = -1
            }
        end
    end
}

SMODS.Stake{
    key = "void",
    atlas = "stakes",
    pos = {
        x = 2,
        y = 0,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 2,
        y = 0,
    },
    unlocked = false,
    prefix_config = {
        above_stake = false
    },
    applied_stakes = { "irrigo" },
    above_stake = "stake_black",
    colour = HEX("001417"),
    modifiers = function ()
        G.GAME.modifiers.enable_minty_counterfeit = true
        G.GAME.modifiers.enable_minty_counterfeit_consumeables = true
    end
}

SMODS.Stake{
    key = "sky",
    atlas = "stakes",
    pos = {
        x = 3,
        y = 0,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 3,
        y = 0,
    },
    unlocked = false,
    prefix_config = {
        above_stake = false
    },
    applied_stakes = { "void" },
    above_stake = "stake_blue",
    colour = HEX("00c7ff"),
    modifiers = function ()
        G.GAME.showdown_rate = (G.GAME.showdown_rate or 1) * 2
    end
}

SMODS.Stake{
    key = "mint", --Hee hee hoo hoo.
    atlas = "stakes",
    pos = {
        x = 0,
        y = 1,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 0,
        y = 1,
    },
    unlocked = false,
    prefix_config = {
        above_stake = false
    },
    applied_stakes = { "sky" },
    above_stake = "stake_purple",
    colour = HEX("00a156"),
    modifiers = function ()
        G.GAME.minty_unbalance = 0.10
        G.GAME.minty_unbalance_base = 0.05
        G.GAME.minty_unbalance_rate = 0.05
    end,
    calculate = function (self, context)
        if context.ante_change and context.ante_end then
            G.GAME.minty_unbalance = math.min(G.GAME.minty_unbalance_base + (G.GAME.minty_unbalance_rate*(G.GAME.round_resets.ante+1)), 0.5)
        end

        if context.final_scoring_step then
            if mult > hand_chips then
                local diff = hand_chips * G.GAME.minty_unbalance
                mult = mod_mult(mult + diff)
                hand_chips = mod_chips(hand_chips - diff)
            else
                local diff = mult * G.GAME.minty_unbalance
                mult = mod_mult(mult - diff)
                hand_chips = mod_chips(hand_chips + diff)
            end

            return {
                func = G.E_MANAGER:add_event(Event({
                    func = (function()
                    play_sound("minty_unbalance")
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    attention_text({
                        scale = 1.4, text = localize('k_minty_unbalanced'), hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  0.8,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                                ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  1.3,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                    end)
                })),
            }
        end
    end
}

SMODS.Stake{
    key = "tungsten",
    atlas = "stakes",
    pos = {
        x = 1,
        y = 1,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 1,
        y = 1,
    },
    unlocked = false,
    prefix_config = {
        above_stake = false
    },
    applied_stakes = { "mint" },
    above_stake = "stake_orange",
    colour = HEX("667072"),
    modifiers = function ()
        G.GAME.modifiers.enable_minty_hooked = true
    end,
    calculate = function (self, context)
        local center = (context.other_card and context.other_card.config and context.other_card.config.center) or {}
        if (context.setting_ability and (center.set == "Default" or center.set == "Enhanced")) or context.change_rank or context.change_suit then
            MINTY.say("Modifying playing card...")
            if SMODS.Stickers.minty_hooked:should_apply(context.other_card, center, context.other_card.area) then
                SMODS.Stickers.minty_hooked:apply(context.other_card, true)
            end
        end
    end
}

SMODS.Stake{
    key = "catcat",
    atlas = "stakes",
    pos = {
        x = 2,
        y = 1,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 2,
        y = 1,
    },
    unlocked = false,
    prefix_config = {
        above_stake = false
    },
    applied_stakes = { "tungsten" },
    above_stake = "stake_gold",
    colour = HEX("CA7CA7"),
    modifiers = function ()
        G.GAME.win_ante = G.GAME.win_ante + 1
    end
}

SMODS.Stake{
    key = "rose_gold",
    atlas = "stakes",
    pos = {
        x = 3,
        y = 1,
    },
    sticker_atlas = "stake_stickers",
    sticker_pos = {
        x = 3,
        y = 1,
    },
    unlocked = false,
    prefix_config = {
        applied_stakes = false
    },
    applied_stakes = { 
        "stake_minty_catcat",
        "stake_gold"
    },
    above_stake = "catcat",
    colour = HEX("ffb2a0")
}

do return end --Dummy out Barber Stake for now.

SMODS.Stake{
    key = "barber",
    unlocked = false,
    applied_stakes = {}
}