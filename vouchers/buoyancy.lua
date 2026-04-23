SMODS.Voucher{
    key = "buoyancy",
    config = {
        luck = 1,
        odds = 3,
    },
    atlas = "vouchers",
    pos = {
        x = 0,
        y = 0,
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

SMODS.Voucher{
    key = "treading",
    config = {
        req = 0,
        regain = 1
    },
    atlas = "vouchers",
    pos = {
        x = 0,
        y = 1,
    },
    loc_vars = function (self, info_queue, voucher)
        return {
            vars = {
                voucher.ability.req <= 1 and voucher.ability.req or "at most "..voucher.ability.req, --Todo probably localizify this idk
                voucher.ability.regain,
                voucher.ability.req ~= 1 and "s" or "",
                voucher.ability.regain ~= 1 and "s" or "",
            }
        }
    end,
    requires = {"v_minty_buoyancy"},
    calculate = function (self, voucher, context)
        if context.after and G.GAME.current_round.discards_left <= voucher.ability.req then
            return {
                func = function ()
                    MINTY.event(function ()
                        ease_discard(voucher.ability.regain)
                        return true
                    end)
                end
            }
        end
    end
}