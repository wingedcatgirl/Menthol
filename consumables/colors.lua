SMODS.Consumable({
    object_type = "Consumable",
    set = "Colour",
    name = "Emeowrald Green",
    key = "emeowrald",
    atlas = "colours",
    pos = { x = 0, y = 0 },
    config = {
        val = 0,
        partial_rounds = 0,
        upgrade_rounds = 1,
    },
    attributes = {
        "modify_card", "suit", "minty_3s"
    },
    cost = 4,
    unlocked = true,
    discovered = false,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
        return #G.hand.cards > 1
    end,
    use = function(self, card, area, copier)
        local suit = "minty_3s"
        local rng_seed = "ca7ca7"
        local blacklist = {}
        for i = 1, card.ability.val do
            local temp_pool = {}
            for k, v in pairs(G.hand.cards) do
                if not v:is_suit(suit) and not blacklist[v] then
                    table.insert(temp_pool, v)
                end
            end
            local over = false
            if #temp_pool == 0 then
                break
            end
            local eligible_card = pseudorandom_element(temp_pool, pseudoseed(rng_seed))
            blacklist[eligible_card] = true
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() eligible_card:flip();play_sound('card1', 1);eligible_card:juice_up(0.3, 0.3);return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() eligible_card:flip();play_sound('tarot2', percent);eligible_card:change_suit(suit);return true end }))
            card:juice_up(0.3, 0.5)
        end
        delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
        local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
        return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end
})