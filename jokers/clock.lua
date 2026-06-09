local function get_time_numbers()
    local hour = tonumber(os.date("%H"))
    local minute = tonumber(os.date("%M"))
    local second = tonumber(os.date("%S"))
    return hour, minute, second
end

SMODS.Joker {
    key = "clock",
    name = "The Time Being",
    pronouns = "it_its",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 8
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            dollars = 30
        }
    },
    attributes = {
        "mult", "chips", "economy", "meta"
    },
    loc_vars = function(self, info_queue, card)
        local hour, minute, second = get_time_numbers()
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                hour,
                minute,
                card.ability.extra.dollars
            }
        }
    end,
    calc_dollar_bonus = function (self, card)
        local hour, minute, second = get_time_numbers()
        local dollars = card.ability.extra.dollars
        if hour == second or minute == second then
            MINTY.event(function ()
                SMODS.destroy_cards(card)
                return true
            end)
            return dollars
        end
        if card.debug then MINTY.say(hour..":"..minute..":"..second) end
    end,
    set_ability = function (self, card, initial, delay_sprites)
        juice_card_until(card, function ()
            return MINTY.config.ticking_splines
        end)
    end,
    load = function (self, card, card_table, other_card)
        juice_card_until(card, function ()
            return MINTY.config.ticking_splines
        end)
    end,
    calculate = function(self, card, context)
        local hour, minute, second = get_time_numbers()
        if (context.joker_main and context.scoring_hand) then
            if card.debug then MINTY.say(hour..":"..minute..":"..second) end
            return {
                mult = hour,
                chips = minute
            }
        end
        if context.forcetrigger then
            local dollars = card.ability.extra.dollars
            MINTY.event(function ()
                SMODS.destroy_cards(card)
                return true
            end)
            return {
                mult = hour,
                chips = minute,
                dollars = dollars
            }
        end
    end
}