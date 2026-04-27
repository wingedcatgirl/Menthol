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
    end,
    draw = function(self, card) --Lifted and edited from Paperback's paperclips. Could probably put this on the vremade wiki tbh
        local scalefac = 95
        local px_offset = -15
        if type(card.debug) == "number" then
            px_offset = card.debug
        end
        local y_offset = (card.T.h / scalefac) * px_offset * card.T.scale
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, y_offset)
        --G.shared_stickers[self.key]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center, nil, nil, nil, y_offset)
    end,

}