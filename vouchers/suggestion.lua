SMODS.Voucher{
    key = "suggestion",
    atlas = "vouchers",
    pos = {
        x = 0,
        y = 0,
    },
    config = {
        percent = 13
    },
    loc_vars = function (self, info_queue, voucher)
        info_queue[#info_queue+1] = {set = "Other", key = "minty_cat_ears"}
        return {
            vars = {
                voucher.ability.percent
            }
        }
    end,
    calculate = function (self, voucher, context)
        if context.create_shop_card and context.set == "Joker" then
            if SMODS.pseudorandom_probability(voucher, "minty_suggestion", voucher.ability.percent, 100) then
                return {
                    shop_create_flags = {
                        stickers = {
                            "minty_cat_ears"
                        },
                        force_stickers = true
                    }
                }
            end
            return nil, true
        end
    end
}

SMODS.Voucher{
    key = "mandate",
    atlas = "vouchers",
    pos = {
        x = 0,
        y = 1,
    },
    loc_vars = function (self, info_queue, voucher)
        info_queue[#info_queue+1] = {set = "Other", key = "minty_cat_ears"}
    end,
    redeem = function (self, voucher)
        if not next(SMODS.find_card(self.key)) then
            G.GAME.banned_keys = G.GAME.banned_keys or {}
            G.GAME.banned_keys["c_minty_headband"] = true
        end
    end,
    unredeem = function (self, voucher)
        local key = self.key
        BIBLIO.event(function ()
            if not next(SMODS.find_card(key)) then
                G.GAME.banned_keys["c_minty_headband"] = nil
            end
            return true
        end)
    end,
    calculate = function (self, voucher, context)
        if context.create_shop_card and context.set == "Joker" then
            return {
                shop_create_flags = {
                    stickers = {
                        "minty_cat_ears"
                    },
                    force_stickers = true
                }
            }
        end
    end
}