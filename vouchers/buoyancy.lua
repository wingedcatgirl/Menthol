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
        if context.stay_flipped and (G.GAME.current_round.discards_left > 0) then
            if context.from_area == G.play and context.to_area == G.discard then
                if SMODS.pseudorandom_probability(voucher, "minty_buoyant", voucher.ability.luck, voucher.ability.odds) then
                    return {
                        modify = {
                            to_area = G.deck
                        }
                    }
                end
                return nil, true
            end
        end
    end
}