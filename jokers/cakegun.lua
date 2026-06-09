SMODS.Joker {
    key = "cakegun",
    name = "Cake Gun",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 5,
        y = 6
    },
    rarity = 3,
    cost = 7,
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
            percent = 50,
            shots = 6,
        }
    },
    attributes = {
        "food", "xblindsize"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.percent,
                card.ability.extra.shots,
                (card.ability.extra.shots == 1) and "" or "s",
                (card.ability.extra.shots == 1) and "s" or "",
            }
        }
    end,
    in_pool = function (self, args)
        return G.GAME.pool_flags.cake_sword_eaten
    end,
    calculate = function(self, card, context)
        local final_chips = to_big((G.GAME.blind.chips / 100) * (100 - card.ability.extra.percent))
        if (context.setting_blind or context.forcetrigger) and not context.blueprint then
            G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
                play_sound('minty_gunshot', 1)
                card:juice_up()
                G.GAME.blind.chips = final_chips
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                return true
            end}))

            card.ability.extra.shots = card.ability.extra.shots - 1
            if (card.ability.extra.shots <= 0) then
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

            return {
                    message = localize("k_minty_bang"),
                    message_card = G.GAME.blind,
            }
        end
    end
}