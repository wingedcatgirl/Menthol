SMODS.Sticker{
    key = "ethereal",
    should_apply = function (self, card, center, area, bypass_roll)
        return bypass_roll
    end,
    apply = function (self, card, val)
        card.ability.minty_ethereal = val
        card.ability.extra_slots_used = val and -1 or nil
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval then
            SMODS.destroy_cards(card, {
                bypass_eternal = true,
                pinch_anim = true,
                skip_calc = true
            })
        end
    end
}