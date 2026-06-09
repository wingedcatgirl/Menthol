local function do_suit_shit_but_3(card, copier)
    local used_tarot = copier or card
    local target_area = G.hand
    if G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL then
        target_area = G.deck
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.7,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            local cards = {}
            for i=1, card.ability.val do
                cards[i] = true
            local _suit, _rank = nil, nil
            local roll = pseudorandom("catrot")
            if roll < 1/9 then
                _rank = "3"
                _suit = card.ability.suit
            elseif roll < 1/3 then
                _rank = "3"
                _suit = pseudorandom_element({"H", "C", "D", "S"}, pseudoseed('suitarot'))
            else
                _rank = pseudorandom_element({'A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K'}, pseudoseed('suitarot'))
                _suit = card.ability.suit
            end
            local cen_pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if v.key ~= 'm_stone' and not v.overrides_base_rank then
                cen_pool[#cen_pool+1] = v
                end
            end
            create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('suitarot'))}, target_area, nil, i ~= 1, {G.C.SECONDARY_SET.Rotarot})
            end
            playing_card_joker_effects(cards)
            return true end
        }))
end

SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "The Cat!",
    key = "rot_cat",
    pos = { x = 0, y = 0 },
    config = {
        val = 3,
        suit = "minty_THREE"
    },
    cost = 3,
    atlas = "rotarots",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        do_suit_shit_but_3(card, copier)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.val} }
    end
})

SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "The Bored Child!",
    key = "rot_boredkid",
    pos = { x = 1, y = 0 },
    config = {
        max_highlighted = 1,
        mod_conv = "m_minty_garbled"
    },
    cost = 3,
    atlas = "rotarots",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },
    can_use = function(self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

        return { vars = {
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
        } }
    end
})


SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "The Gleam!",
    key = "rot_gleam",
    pos = { x = 3, y = 0 },
    config = {
        max_highlighted = 1,
        mod_conv = "m_minty_pistol",
    },
    cost = 3,
    atlas = "rotarots",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },
    can_use = function(self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

        return { vars = {
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
        } }
    end
})


SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "The Dwarf!",
    key = "rot_dorf",
    pos = { x = 0, y = 1 },
    config = {
        max_highlighted = 1,
        mod_conv = "m_minty_spline",
    },
    cost = 3,
    atlas = "rotarots",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },
    can_use = function(self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
        local key = self.key
        --local luck, odds = SMODS.get_probability_vars(card, 1, 3, "minty_spline_desc", false)
        local plural = false
        if self.config.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "

        return {
            key = key,
            main_end = main_end,
            vars = {
                card and card.ability.max_highlighted or self.config.max_highlighted,
                localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv},
                s,
                a,
        } }
    end
})


SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "The Magnet!",
    key = "rot_magnet",
    pos = { x = 2, y = 1 },
    config = {
        max_highlighted = 1,
        mod_conv = "m_minty_dynamite",
    },
    cost = 3,
    atlas = "rotarots",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },
    can_use = function(self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
        local key = self.key
        local plural = false
        if self.config.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "

        return {
            key = key,
            main_end = main_end,
            vars = {
                card and card.ability.max_highlighted or self.config.max_highlighted,
                localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv},
                s,
                a,
        } }
    end
})


SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "The Battery!",
    key = "rot_battery",
    pos = { x = 3, y = 1 },
    config = {
        max_highlighted = 1,
        mod_conv = "m_minty_emphatic",
    },
    cost = 3,
    atlas = "rotarots",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },
    can_use = function(self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
        local key = self.key
        local plural = false
        if self.config.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "an "

        return {
            key = key,
            main_end = main_end,
            vars = {
                card and card.ability.max_highlighted or self.config.max_highlighted,
                localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv},
                s,
                a,
        } }
    end
})