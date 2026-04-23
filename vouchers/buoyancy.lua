SMODS.Voucher{
    key = "buoyancy",
    config = {
        luck = 1,
        odds = 3
    },
    loc_vars = function (self, info_queue, voucher)
        local luck, odds = SMODS.get_probability_vars(voucher, voucher.ability.luck, voucher.ability.odds, "minty_buoyant", false)
        return {
            vars = {
                luck, odds
            }
        }
    end,
    calculate = function (self, voucher, context)
        if context.minty_card_is_drawing then
            if context.draw_args.from == G.play and context.draw_args.to == G.discard then
                if SMODS.pseudorandom_probability(voucher, "minty_buoyant", voucher.ability.luck, voucher.ability.odds) then
                    context.draw_args.to = G.deck
                    return nil, true
                end
            end
        end
    end
}