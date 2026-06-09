SMODS.Joker {
    key = "gymbuddy",
    name = "Gym Buddies",
    pronouns = "they_them", -- there's literally two of them :V
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 6,
        y = 2
    },
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = {
            chips = 3,
            xchips = 0.2,
            hchips = 2,
            hxchips = 0.15,
            mult = .4,
            xmult = 0.2,
            hmult = 0.3,
            hxmult = 0.15,
            cash = 0.10,
            hcash = 0.30,
        }
    },
    attributes = {
        "chips", "xchips", "mult", "xmult", "economy", "enhancements", "modify_card", "perma_bonus"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger and context.scoring_hand then
            for i = 1, #context.scoring_hand do
                local gain = pseudorandom_element({
                    "chips", "xchips", "mult", "xmult", "cash", "hchips", "hxchips", "hmult", "hxmult", "hcash",
                    })
                local gain_map = {
                    chips = "perma_bonus",
                    hchips = "perma_h_chips",
                    xchips = "perma_x_chips",
                    hxchips = "perma_h_x_chips",
                    mult = "perma_mult",
                    hmult = "perma_h_mult",
                    xmult = "perma_x_mult",
                    hxmult = "perma_h_x_mult",
                    cash = "perma_p_dollars",
                    hcash = "perma_h_dollars",
                }
                local ability_key = gain_map[gain]
                local extra_value = card.ability.extra[gain]
                local ability_table = context.scoring_hand[i].ability
                ability_table[ability_key] = (ability_table[ability_key] or 0) + extra_value
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.scoring_hand[i]:juice_up()
                        return true
                    end,
                    blocking = false
                }))
            end
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.set == "Enhanced" then
                local buff = context.other_card.ability.name
                local gain = "unset"
                local buff_to_gain = {
                    ["Bonus"] = "chips",
                    ["Stone Card"] = "chips",
                    ["Mult Card"] = "mult",
                    ["Glass Card"] = "xmult",
                    ["Steel Card"] = "hxmult",
                    ["Lucky Card"] = "cash",
                    ["Gold Card"] = "hcash"
                }
                gain = buff_to_gain[buff] or "unset"

                if gain == "unset" and type(context.other_card.ability.extra) == "table" then -- Table check avoids crashing on glass cards, because :thunk: momence
                    gain = context.other_card.ability.extra.gymboost or "unset"
                end
                gain = gain:gsub("_", ""):lower() -- Remove underscores and force to lowercase
                local valid_gains = {
                    chips = true,
                    hchips = true,
                    xchips = true,
                    hxchips = true,
                    mult = true,
                    hmult = true,
                    xmult = true,
                    hxmult = true,
                    cash = true,
                    hcash = true,
                }
                if gain == "none" then return end
                if (gain == "money" or gain == "dollars" or gain == "pmoney" or gain == "pdollars" or gain == "pcash") then gain = "cash" end
                if (gain == "hmoney" or gain == "hdollars") then gain = "hcash" end
                if not valid_gains[gain] then gain = pseudorandom_element({
                        "chips", "xchips", "mult", "xmult", "cash", "hchips", "hxchips", "hmult", "hxmult", "hcash",
                    })
                end
                --MINTY.say("Gain is "..gain)
                for i = 1, #context.scoring_hand do
                    local juice = true
                    if context.scoring_hand[i].ability.name ~= buff then
                        local gain_map = {
                            chips = "perma_bonus",
                            hchips = "perma_h_chips",
                            xchips = "perma_x_chips",
                            hxchips = "perma_h_x_chips",
                            mult = "perma_mult",
                            hmult = "perma_h_mult",
                            xmult = "perma_x_mult",
                            hxmult = "perma_h_x_mult",
                            cash = "perma_p_dollars",
                            hcash = "perma_h_dollars",
                        }
                        local ability_key = gain_map[gain]
                        local extra_value = card.ability.extra[gain]
                        if ability_key then
                            local ability_table = context.scoring_hand[i].ability
                            ability_table[ability_key] = (ability_table[ability_key] or 0) + extra_value
                        else
                            juice = false
                        end
                        if juice then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    context.scoring_hand[i]:juice_up()
                                    return true
                                end,
                                blocking = false
                            }))
                        end
                    end
                end
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
                    card = card
                }
            end
        end
    end
}