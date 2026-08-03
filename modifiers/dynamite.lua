local mf = SMODS.find_mod("MoreFluff")[1]

SMODS.Enhancement({
    key = "dynamite",
    name = "Dynamite Card",
    atlas = "enhance",
    set = "Enhanced",
    pos = {
        x = 3,
        y = 1
    },
	object_type = "Enhancement",
	badge_colour = HEX("a3ecc0"), --Magic Mint, according to internet
    config = {
        extra = {
            percent = 20,
            gymboost = "random"
        }
    },
    valk_hand_buff = {
        title = "EXPLOSIVE",
        colour = HEX("ab1f07"),
        scoring_func = function (power)
            return {
                sound = "minty_explosion",
                message = localize("k_minty_kaboom"),
                func = function ()
                    local final_chips = (G.GAME.blind.chips / 100) * (70 - power*5)
                    final_chips = math.max(final_chips, 1)
                    G.GAME.blind.chips = final_chips
                    G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
                        G.GAME.blind:juice_up()
                        G.GAME.blind.chip_text = number_format(final_chips)
                        return true
                    end}))
                end
            }
        end
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.percent
            },
        }
    end,
    get_weight = function (self)
        local default = 5
        return mf and default or default/2
    end,
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            card.kablooied = true
            return {
                remove = true,
                message = localize("k_minty_kaboom"),
                sound = "minty_explosion",
                func = function ()
                    local final_chips = (G.GAME.blind.chips / 100) * (100 - card.ability.extra.percent)
                    final_chips = math.max(final_chips, 1)
                    G.GAME.blind.chips = final_chips
                    G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
                        G.GAME.blind:juice_up()
                        G.GAME.blind.chip_text = number_format(final_chips)
                        return true
                    end}))
                end
            }
        end

        if context.destroy_card and context.destroy_card == card and card.kablooied then
            return {
                remove = true
            }
        end
    end
})