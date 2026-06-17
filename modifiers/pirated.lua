SMODS.Sticker{
    key = "pirated",
    name = "Pirated",
    atlas = "stickers",
    pos = {
        x = 2,
        y = 0,
    },
    badge_colour = HEX("CA7CA7"),
    default_compat = true,
    compat_exceptions = {
        --TBA?
    },
    sets = {
        --All
    },
    should_apply = function (self, card, center, area, bypass_roll)
        --Should only ever be applied manually
        return bypass_roll or false
    end,
    apply = function (self, card, val)
        card.ability.minty_pirated = val or nil
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            if SMODS.pseudorandom_probability(self, "minty_piracy_punishment", 1, 15, "minty_piracy_punishment", true) or card.ability.debug then
                G.GAME.minty_piracy_punishment = (G.GAME.minty_piracy_punishment or 0) + 1
                G.GAME.minty_total_piracy_punishment = (G.GAME.minty_total_piracy_punishment or 0) + 1
                local first = G.GAME.minty_piracy_punishment == 1
                SMODS.calculate_effect({message = localize("k_minty_confiscated") }, card)
                --card:juice_up()

                G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
                    local final_chips = to_big(G.GAME.blind.chips * 1.25)
                    if first then
                        play_sound('minty_warning', 1)
                        local amt = (G.GAME.minty_piracy_punishment or 0) ~= 1 and "pl" or "sing"
                        attention_text({
                            scale = 0.7, text = localize("k_minty_cease_"..amt), hold = 11, align = 'cm', offset = {x = 0,y = -2.5},major = G.play
                        })
                        attention_text({
                            scale = 0.7, text = localize("k_minty_desist_"..amt), hold = 11, align = 'cm', offset = {x = 0,y = -1.8},major = G.play
                        })
                    end
                    SMODS.destroy_cards(card, true, nil, true)
                    G.GAME.blind.chips = final_chips

                    if G.GAME.minty_piracy_punishment == 1 then
                        G.GAME.blind:juice_up()
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    end
                    G.GAME.minty_piracy_punishment = G.GAME.minty_piracy_punishment - 1
                    return true
                end}))
            elseif SMODS.pseudorandom_probability(self, "minty_piracy_caution", 3, 15, "minty_piracy_caution", true) then
                G.GAME.minty_piracy_caution = (G.GAME.minty_piracy_caution or 0) + 1
                MINTY.event(function ()
                    G.GAME.minty_piracy_caution = G.GAME.minty_piracy_caution - 1
                    if (G.GAME.minty_piracy_punishment or 0) > 0 then return true end
                    if G.GAME.minty_piracy_caution == 0 then
                        play_sound("minty_caution", 1)
                    end
                    return true
                end)
            end
        end
    end
}