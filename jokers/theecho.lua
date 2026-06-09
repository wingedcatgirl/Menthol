SMODS.Joker {
    key = "theecho",
    name = "The Echo",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 3,
        y = 3
    },
    rarity = "minty_challenge",
    cost = 0,
    unlocked = true,
    discovered = false,
    no_collection = true,
    no_doe = true,    --
    no_aeq = true,    -- Disable Cryptid features
    immutable = true, --
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            charges = 3,
            ante = 1
        }
    },
    attributes = {
        "nonstandard", "prevents_death", "ante", "ante_change"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.charges,
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        local valid = true
        if next(SMODS.find_card('j_minty_theecho')) then
            --MINTY.say("Two Echoes?! Madness!")
            valid = false
        end
        if G.GAME.round_resets.ante >= G.GAME.win_ante then
            --MINTY.say("You already won!")
            valid = false
        end

        --[[ Dummy this out for now, I feel like it'll cause more problems than it solves
        if not (G.GAME and G.GAME.challenge_index and (G.GAME.challenge_index.id == "c_minty_raidnight" or G.GAME.challenge_index.id == "c_minty_raidnightsavage")) then
            MINTY.say("Echo outside Raid Night? That shouldn't happen!")
            valid = false
        end
        ]]


        if not valid then
			G.E_MANAGER:add_event(Event({
				func = function()
                    card_eval_status_text(
                        card,
                        "jokers",
                        nil,
                        nil,
                        nil,
                        { message = localize("k_nope_ex"), colour = G.C.RARITY[4] }
                    )
					return true
				end,
			}))
            SMODS.destroy_cards(card, nil, nil, true)
        end
    end,
    calculate = function(self, card, context)
        if context.blueprint or context.forcetrigger then return end

        if context.game_over and card.ability.extra.charges > 0 then
            if G.GAME.blind:get_type() == 'Boss' and G.GAME.round_resets.blind ~= G.P_BLINDS[G.GAME.last_chdp_blind] then --if we just lost to the second boss
                card.ability.extra.charges = card.ability.extra.charges - 1
                card.ability.extra.ante = G.GAME.round_resets.ante
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if (card.ability.extra.ante == G.GAME.round_resets.ante) and (G.GAME.round_resets.ante ~= G.GAME.win_ante) then return false end
                        ease_ante(-1)
                        return true
                    end,
                    blocking = false,
                }))
            end
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					play_sound("tarot1")
                    if card.ability.extra.charges == 0 then
                        SMODS.destroy_cards(card, nil, nil, true)
                    end
					return true
				end,
			}))
            local message = "k_minty_forward"
            if card.ability.extra.charges == 0 then
                message = "k_minty_abandon"
            end
			return {
				message = localize("k_minty_wiped"),
				saved = message,
				colour = G.C.RED,
			}
		end
        if context.end_of_round and not context.game_over and G.GAME.blind:get_type() == 'Boss' and (G.GAME.round_resets.ante >= G.GAME.win_ante) and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					play_sound("tarot1")
                    SMODS.destroy_cards(card, nil, nil, true)
					return true
				end,
			}))
			return {
				message = localize("k_minty_victory"),
				colour = G.C.RED,
                card = card,
			}
        end
    end
}