SMODS.Consumable{
    set = 'minty_cobalt',
    key = 'backup_plan',
    name = "Backup Plan",
    atlas = 'tarots',
    pos = {
        x = 3,
        y = 2
    },
    config = {
        
    },

    loc_vars = function(self, info_queue, card)
		local key = self.key
        --[[
        local main_end = MINTY.flavorize(self.key)
        ]]
        return {
            key = key,
            main_end = main_end,
            vars = {

            }
        }
    end,

    can_use = function (self, card)
        if G.STATE == G.STATES.SELECTING_HAND then
            return true
        end
    end,

    use = function(self, card, area, copier)
        local suits = {}
        local wilds = {}
        for k,v in pairs(SMODS.Suits) do
            suits[k] = true
        end

        for i,v in ipairs(G.deck.cards) do
            for k,_ in pairs(suits) do
                if v:is_suit(k) then
                    if not SMODS.has_any_suit(v) then
                        draw_card(G.deck, G.hand, nil, nil, nil, v)
                        suits[k] = nil
                        break
                    else
                        wilds[#wilds+1] = v
                    end
                end
            end
            if not next(suits) then break end
        end
        if next(suits) and next(wilds) then
            local i = 1
            for _ in pairs(suits) do
                draw_card(G.deck, G.hand, nil, nil, nil, wilds[i])
                i = i + 1
                if not wilds[i] then break end
            end
        end
    end,

    in_pool = function (self, args)
        return false
    end
}