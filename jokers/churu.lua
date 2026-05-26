---Stub function if PB isn't active, so this *can* work without it. Not recommended, but possible!
local plastic_stickmult = (PB_UTIL and PB_UTIL.calculate_stick_xMult) or function (card)
    local xMult_per = card.ability.extra.xMult or 1
    local xMult_if = card.ability.extra.unhidden_xmult
    local sticks = SMODS.find_card("j_minty_plastic_stick") --Assuming no other mod allows PB sticks to exist without PB :v
    local hidden = not (G.GAME.starting_params.start_with_3s or G.GAME.starting_params.minty_three_lock == 1)

    if #sticks > 0 then
        if hidden then
            return (xMult_per * (#sticks-1)) or xMult_if
        else
            return xMult_if
        end
    end
    return 1
end

local pb = next(SMODS.find_mod("paperback"))

SMODS.Joker {
    key = "churutreat",
    config = {
        extra = {
            s_mult = 5,
            odds = 4,
            again = 0
        }
    },
    attributes = {
        "rank", "suit", "mult", "minty_3s", "chance", "food"
    },
    rarity = 1,
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 6,
        y = 0
    },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    pools = {
        ["Food"] = true, -- Cryptid compatibility for refactor
        ["Paperback"] = true, --Increase freqency when playing with Paper Deck
    },
    loc_vars = function(self, info_queue, card)
        if MINTY.in_collection(card) and not (pb or MINTY.config.dev_mode or G.GAME.minty_crossover) then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Mod", "Paperback" } }
        end
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "minty_churu_desc", false)
        return {
            key = key,
            vars = {
                card.ability.extra.s_mult,
                luck,
                odds,
            }
        }
    end,

    in_pool = function(self, args)
        if not (pb or MINTY.config.dev_mode or G.GAME.minty_crossover) then return false end
        if pb and G.GAME.pool_flags.churu_treat_eaten then --The normal gimmick only works if other sticks can spawn, so if they can't...
            return false
        end
        return MINTY.threeSuit_in_pool()
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                mult = card.ability.extra.s_mult,
                card = card
            }
        end

        -- Give the mult during play if card is a 3, and retrigger if it's a 3 of 3s
        if context.cardarea == G.play and context.individual and context.other_card:is_3() then
            local count = context.other_card:is_3()
            card.ability.extra.again = count - 1
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

        -- Check if the Joker needs to be eaten
        if context.end_of_round and not context.blueprint and not (context.individual or context.repetition or context.retrigger_joker_check or context.retrigger_joker) then
            card.ability.extra.again = 0
            if SMODS.pseudorandom_probability(card, "minty_churu_eaten", 1, card.ability.extra.odds, "minty_churu_eaten") then
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
                                -- card = nil

                                -- Remove Churu Treat from the pool
                                G.GAME.pool_flags.churu_treat_eaten = true

                                -- Create Plastic "Stick"
                                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                    local jokers_to_create = math.min(1,
                                        G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create

                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            local card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_minty_plastic_stick', nil)
                                            card:add_to_deck()
                                            G.jokers:emplace(card)
                                            card:start_materialize()
                                            G.GAME.joker_buffer = 0
                                            return true
                                        end
                                    }))
                                end
                                return true;
                            end
                        }))
                        return true
                    end
                }))

                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            else
                return {
                    message = localize('k_safe_ex'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'plastic_stick',
    config = {
        extra = {
            xMult = 1.5,
            unhidden_xmult = 2
        }
    },
    attributes = {
        "xmult"
    },
    rarity = 1,
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 6,
        y = 1
    },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    pools = {
        ["Paperback"] = true, --Increase freqency when playing with Paper Deck. if sticks can spawn which i don't think pb ever actually turns on lol
    },
    in_pool = function (self, args)
        if not (pb or MINTY.config.dev_mode or G.GAME.minty_crossover) then return false end
        if not G.GAME.pool_flags.churu_treat_eaten then return false end
        return G.GAME.pool_flags.sticks_can_spawn
    end,

    loc_vars = function(self, info_queue, card)
        if MINTY.in_collection(card) and not (pb or MINTY.config.dev_mode or G.GAME.minty_crossover) then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Mod", "Paperback" } }
        end
        local key = self.key
        local hidden = not (G.GAME.starting_params.start_with_3s or G.GAME.starting_params.minty_three_lock == 1)
        if not hidden then
            key = key.."_unhidden"
        end
        if MINTY.config.flavor_text then
            key = key.."_flavor"
        end

        local xMult = plastic_stickmult(card)

        return {
            key = key,
            vars = {
                hidden and card.ability.extra.xMult or card.ability.extra.unhidden_xmult,
                xMult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local xMult = plastic_stickmult(card)

            if xMult ~= 1 then
                return {
                    xmult = xMult,
                }
            end
        end
    end
}