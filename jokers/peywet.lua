SMODS.Joker {
    key = "peywet",
    name = "Smack Barm Pey Wet",
    atlas = 'jokerdoodles',
    pos = {
        x = 2,
        y = 5
    },
    soul_pos = {
        x = 3,
        y = 5
    },
    rarity = 2,
    cost = 7,
    pools = {
        ["Food"] = true,
        ["Meme"] = true,
    },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            odds = 5,
            life = 3
        }
    },
    attributes = {
        "food", "mod_chance", "meme"
    },
    loc_vars = function(self, info_queue, card)
        if not G.PROFILES[G.SETTINGS.profile].career_stats["minty_peywet"] then G.PROFILES[G.SETTINGS.profile].career_stats["minty_peywet"] = 0 end
        local comprehension = G.PROFILES[G.SETTINGS.profile].career_stats["minty_peywet"]
        local infokey = "minty_peywet_exp_"
        local _, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "minty_peywet_desc", false)

        if comprehension >= 2 then
            infokey = infokey.."3"
            if MINTY.config.flavor_text then
                infokey = infokey.."_flavor"
            end
        elseif comprehension > 0 then
            infokey = infokey.."2"
        else
            infokey = infokey.."1"
        end

		info_queue[#info_queue + 1] = {
            set = "Other",
            key = infokey,
            specific_vars = {
                odds,
                card.ability.extra.life
            }
        }

        local key = self.key
        return {
            key = key,
            vars = {
                odds,
                card.ability.extra.life
            }
        }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
	        return {
                numerator = context.numerator * 5
            }
        end

        if context.end_of_round and not context.blueprint and not (context.individual or context.repetition or context.retrigger_joker_check or context.retrigger_joker) then
            card.ability.extra.life = card.ability.extra.life - 1
            if card.ability.extra.life < 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end}))
                        return true
                    end
                }))
                if pseudorandom(pseudoseed("peywet")) < 1/3 then
                    inc_career_stat("minty_peywet", 1)
                elseif G.PROFILES[G.SETTINGS.profile].career_stats["minty_peywet"] <= 0 then
                    inc_career_stat("minty_peywet", 0.1)
                end
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.GREEN
                }
            else
                return {
                    message = localize('k_minty_nommed'),
                    colour = G.C.GREEN
                }
            end
        end
    end
}