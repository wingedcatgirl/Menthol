SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    atlas = 'planets',
    pos = { x = 0, y = 0 },
    key = 'rockplanet',
    name = "Rock Planets",
    effect = 'Hand Upgrade',
    config = {hand_type = 'minty_Handful', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = G.localization.descriptions[self.set][self.key] or {}
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
	loc_vars = function(self, info_queue, card)
        local hand = card.ability.hand_type
		return {
			vars = {
				G.GAME.hands[hand].level,
				localize(hand, "poker_hands"),
				G.GAME.hands[hand].l_mult,
				G.GAME.hands[hand].l_chips,
				colours = {
					(
						G.GAME.hands[hand].level == 1 and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[hand].level)]
					),
				},
			},
		}
	end,
}

SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    atlas = 'planets',
    pos = { x = 1, y = 0 },
    key = 'twinrockplanet',
    name = "Twin Rock Planets",
    effect = 'Hand Upgrade',
    config = {hand_type = 'minty_flush_handful', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = G.localization.descriptions[self.set][self.key] or {}
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planets???", get_type_colour(self or card.config, card), nil, 1.2)
    end,
	loc_vars = function(self, info_queue, card)
        local hand = card.ability.hand_type
		return {
			vars = {
				G.GAME.hands[hand].level,
				localize(hand, "poker_hands"),
				G.GAME.hands[hand].l_mult,
				G.GAME.hands[hand].l_chips,
				colours = {
					(
						G.GAME.hands[hand].level == 1 and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[hand].level)]
					),
				},
			},
		}
	end,
}

SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    atlas = 'planets',
    pos = { x = 2, y = 0 },
    key = 'diffrockplanet',
    name = "Different Rock Planets",
    effect = 'Hand Upgrade',
    config = {hand_type = 'minty_spec_handful', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = G.localization.descriptions[self.set][self.key] or {}
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planets???", get_type_colour(self or card.config, card), nil, 1.2)
    end,
	loc_vars = function(self, info_queue, card)
        local hand = card.ability.hand_type
		return {
			vars = {
				G.GAME.hands[hand].level,
				localize(hand, "poker_hands"),
				G.GAME.hands[hand].l_mult,
				G.GAME.hands[hand].l_chips,
				colours = {
					(
						G.GAME.hands[hand].level == 1 and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[hand].level)]
					),
				},
			},
		}
	end,
}

if not not next(SMODS.find_mod("Cryptid")) then
    SMODS.Consumable{ -- Cryptid triple-planet
        set = 'Planet',
        cost = 4,
        unlocked = true,
        discovered = false,
        atlas = 'planets',
        pos = {x=3, y=2},
        key = 'rockdimension',
        name = "Rock Dimension",
        effect = 'Hand Upgrade',
        config = {
            hand_types = {
                'minty_Handful',
                'minty_flush_handful',
                'minty_spec_handful',
            },
            softlock = true},
        set_card_type_badge = function(self, card, badges)
            badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        end,
        in_pool = function(self, args)
            local handful_played = false
            if G and G.GAME and G.GAME.hands then
                for i, v in ipairs(self.config.hand_types) do
                    if G.GAME.hands[v].played > 0 then
                        handful_played = true
                        break
                    end
                end
            end
            return handful_played
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    localize("minty_Handful", "poker_hands"),
                    localize("minty_flush_handful", "poker_hands"),
                    localize("minty_spec_handful", "poker_hands"),
                    number_format(G.GAME.hands["minty_Handful"].level),
                    number_format(G.GAME.hands["minty_flush_handful"].level),
                    number_format(G.GAME.hands["minty_spec_handful"].level),
                    colours = {
                        (
                            G.GAME.hands["minty_Handful"].level == 1 and G.C.UI.TEXT_DARK
                            or G.C.HAND_LEVELS[math.min(7, G.GAME.hands["spectrum_Straight Spectrum"].level)]
                        ),
                        (
                            G.GAME.hands["minty_flush_handful"].level == 1 and G.C.UI.TEXT_DARK
                            or G.C.HAND_LEVELS[math.min(7, G.GAME.hands["spectrum_Spectrum House"].level)]
                        ),
                        (
                            G.GAME.hands["minty_spec_handful"].level == 1 and G.C.UI.TEXT_DARK
                            or G.C.HAND_LEVELS[math.min(7, G.GAME.hands["spectrum_Spectrum Five"].level)]
                        ),
                    },
                },
            }
        end,
        can_use = function(self, card)
            return true
        end,
        use = function(self, card, area, copier)
            Cryptid.suit_level_up(card, copier, 1, card.config.center.config.hand_types)
        end,
        bulk_use = function(self, card, area, copier, number)
            Cryptid.suit_level_up(card, copier, number, card.config.center.config.hand_types)
        end,
        calculate = function(self, card, context)
            if
                G.GAME.used_vouchers.v_observatory
                and context.joker_main
                and (
                    context.scoring_name == "Handful of Rocks"
                    or context.scoring_name == "Flush Handful"
                    or context.scoring_name == "Spectrum Handful"
                )
            then
                local value = G.P_CENTERS.v_observatory.config.extra
                return {
                    message = localize({ type = "variable", key = "a_xmult", vars = { value } }),
                    Xmult_mod = value,
                }
            end
        end,
    }
end