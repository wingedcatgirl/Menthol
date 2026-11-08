SMODS.Atlas {
    key = 'mintygemcards',
    path = "gemstones.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'mintygemslots',
    path = "gemstickers.png",
    px = 71,
    py = 95
}


Gemstones.GemstoneConsumable{
    name = "gem-Cat's Eye",
    key = "catseye",
    atlas = "mintygemcards",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 3,
    discovered = false,
    config = {
        max_highlighted = 1,
        sticker_id = "gemslot_catseye"
    },
    attributes = {
        "modify_card", "gemstone"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", }
        return { vars = { self.config.max_highlighted } }
    end,
}

Gemstones.GemSlot{
    key = "gemslot_catseye",
    badge_colour = HEX("86B723"),
    atlas = "mintygemslots",
    pos = { x = 0, y = 0 },
    discovered = true,
    joker_compat = false,
    card_compat = true,
    config = {  },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}

-- Gem Slots Collection Tab
SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button({
            button = 'your_collection_gemslot', 
            label = {'Gem Slots'}, 
            minw = 5,
            minh = 1, 
            id = 'your_collection_gemslot', 
            focus_args = {snap_to = true}
        })
    }
end