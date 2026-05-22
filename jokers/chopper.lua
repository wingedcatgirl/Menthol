SMODS.Joker {
    key = "chopper",
    name = "Chopper Badstone",
    pronouns = "he_him",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            charge = 0,
            charge_needed = 10,
            ready = false
        }
    },
    buttons = {
        { get_button_args = function(self, card)
            local args = {
                can = "minty_can_use_joker",
                effect = "minty_use_joker",
                handy_insta = "use",
                title = localize("b_use"),
                text = {
                    { ref_table = card.ability.extra, ref_value = "charge" },
                    "/",
                    { ref_table = card.ability.extra, ref_value = "charge_needed" },
                }
            }
            return args
        end }
    },
    hide_use_button = function (self, card)
        return true
    end,
    use = function (self, card)
        card.ability.extra.ready = true
        juice_card_until(card, function ()
            return card.ability.extra.ready
        end)
    end,
    can_use = function (self, card)
        return card.ability.extra.charge >= card.ability.extra.charge_needed and not card.ability.extra.ready
    end,
    attributes = {

    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text and G.localization.descriptions[self.set][self.key.."_flavor"] then
            key = self.key .. "_flavor"
        end
        return {
            key = key,
            vars = {
                
            }
        }
    end,
    calculate = function(self, card, context)
        if context.stay_flipped and context.to_area == G.hand then
            if (context.other_card.debuff or context.other_card.facing == "back") and card.ability.extra.charge < card.ability.extra.charge_needed then
                card.ability.extra.charge = card.ability.extra.charge + 1
                if card.ability.extra.charge >= card.ability.extra.charge_needed then
                    card.ability.extra.charge = card.ability.extra.charge_needed
                    return {
                        message = localize("k_minty_charged")
                    }
                end
            end
        end

        if context.final_scoring_step and card.ability.extra.ready then
            local amt = SMODS.calculate_round_score()
            card.ability.extra.charge = 0
            card.ability.extra.ready = false

            return {
                score = amt,
                delay = 8,
                extra = {
                    blindsize = -amt,
                    message_card = G.GAME.blind,
                    delay = 8
                }
            }
        end
    end
}
