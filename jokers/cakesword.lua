SMODS.Joker {
    key = "cakesword",
    name = "Cake Sword",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 5,
        y = 4
    },
    rarity = 2,
    cost = 6,
    pools = {
        ["Food"] = true,
    },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = true,
    config = {
        extra = {
            basepct = 35,
            percent = 35,
            fallpct = 5,
        }
    },
    attributes = {
        "food", "xblindsize", "scaling"
    },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {
            set = "Other",
            key = "minty_percent",
        }
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.percent,
                card.ability.extra.fallpct,
            }
        }
    end,
    in_pool = function (self, args)
        return not G.GAME.pool_flags.cake_sword_eaten
    end,
    calculate = function(self, card, context)
        local final_chips = to_big((G.GAME.blind.chips / 100) * (100 - card.ability.extra.percent))
        if (context.setting_blind or context.forcetrigger) and not context.blueprint then
            G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
                play_sound('minty_swordnoise', 1)
                card:juice_up()
                G.GAME.blind.chips = final_chips
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                return true
            end}))

            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "percent",
                scalar_value = "fallpct",
                operation = "-",
                scaling_message = {
                    message = localize("k_minty_sliced"),
                    message_card = G.GAME.blind,
                }
            })
            if (to_big(card.ability.extra.percent) <= to_big(0)) then
                G.GAME.pool_flags.cake_sword_eaten = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            end

            return {}
        end
    end
}