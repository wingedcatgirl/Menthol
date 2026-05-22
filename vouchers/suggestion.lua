SMODS.Voucher{
    key = "suggestion",
    atlas = "vouchers",
    pos = { --Possible art idea: https://x.com/bghtnya/status/2056024715836424364 Estradiol girl?
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
    requires = {"v_minty_suggestion"},
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