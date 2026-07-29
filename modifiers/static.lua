SMODS.Enhancement({
    key = "static",
    name = "Static Card",
    atlas = "enhance",
    set = "Enhanced",
    pos = {
        x = 0,
        y = 2
    },
	object_type = "Enhancement",
	badge_colour = HEX("a3ecc0"), --Magic Mint, according to internet
    config = {
        extra = {
            balancepct = 10
        },
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.balancepct
            },
        }
    end,
    valk_hand_buff = {
        title = "ZzZzzzZZtTzt",
        colour = G.C.YELLOW,
        scoring_func = function (n)
            local ret = {
                extra = {
                    balance = true
                }
            }
            if hand_chips > mult then
                ret.echips = 1 + (n * 0.1)
            else
                ret.emult = 1 + (n * 0.1)
            end
            return ret
        end
    },
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            local diff = math.abs(mult - hand_chips)
            diff = math.min(diff*(card.ability.extra.balancepct/100), diff)
            if diff < 1 then goto nvm end

            if mult > hand_chips then
                mult = mod_mult(mult - (diff/2))
                hand_chips = mod_chips(hand_chips + (diff/2))
            else
                mult = mod_mult(mult + (diff/2))
                hand_chips = mod_chips(hand_chips - (diff/2))
            end

            ::nvm::


            return {
                func = G.E_MANAGER:add_event(Event({
                    func = (function()
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
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
                message = localize('k_balanced'),
                colour = G.C.PURPLE
            }
        end
    end,
})