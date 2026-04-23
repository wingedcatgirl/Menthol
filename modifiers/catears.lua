SMODS.Sticker{
    key = "cat_ears",
    name = "Cat Ears",
    atlas = "stickers",
    pos = {
        x = 3,
        y = 0,
    },
    badge_colour = HEX("CA7CA7"),
    default_compat = true,
    should_apply = function (self, card, center, area, bypass_roll)
        --Should only ever be applied manually
        return bypass_roll or false
    end,
    apply = function (self, card, val)
        card.ability.minty_cat_ears = val or nil
    end,
    calculate = function (self, card, context)
        --Calculation is done in Card:has_attribute; see hooks.lua
    end
}