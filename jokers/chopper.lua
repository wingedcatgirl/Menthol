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
            cardhit_gain = 1,
            trigger_gain = 3,
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
                override = "use",
                id = "use_charged",
                minw = 1.25,
                text = {
                    { ref_table = card.ability.extra, ref_value = "charge" },
                    "/",
                    { ref_table = card.ability.extra, ref_value = "charge_needed" },
                }
            }
            return args
        end }
    },
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
                card.ability.extra.cardhit_gain,
                card.ability.extra.trigger_gain,
            }
        }
    end,
    calculate = function(self, card, context)
        local drawn = context.hand_drawn or context.other_drawn
        if drawn and card.ability.extra.charge < card.ability.extra.charge_needed then
            for i,other_card in ipairs(drawn) do
                if (other_card.debuff or other_card.facing == "back")then
                    card.ability.extra.charge = card.ability.extra.charge + card.ability.extra.cardhit_gain
                end
            end
            if card.ability.extra.charge >= card.ability.extra.charge_needed then
                card.ability.extra.charge = card.ability.extra.charge_needed
                return {
                    message = localize("k_minty_charged")
                }
            end
        end

        if (context.joker_main or context.debuffed_hand) and G.GAME.blind.triggered and card.ability.extra.charge < card.ability.extra.charge_needed then
            card.ability.extra.charge = card.ability.extra.charge + card.ability.extra.trigger_gain
            if card.ability.extra.charge >= card.ability.extra.charge_needed then
                card.ability.extra.charge = card.ability.extra.charge_needed
                return {
                    message = localize("k_minty_charged")
                }
            end
        end

        if context.final_scoring_step and card.ability.extra.ready then
            local amt = SMODS.calculate_round_score()
            card.ability.extra.charge = 0
            card.ability.extra.ready = false

            return {
                score = amt,
                delay = 4,
                remove_default_message = true,
                message = localize{
                    type = "variable",
                    key = "a_score",
                    vars = {amt},
                },
                sound = "gong",
                volume = 0.5,
                extra = {
                    blindsize = -amt,
                    message_card = G.GAME.blind,
                    delay = 4,
                    remove_default_message = true,
                    sound = "gong",
                    volume = 0.5,
                    message = localize{
                        type = "variable",
                        key = "a_blind_size",
                        vars = {"-"..number_format(amt)},
                    },
                }
            }
        end
    end
}
