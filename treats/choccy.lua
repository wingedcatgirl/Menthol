SMODS.Consumable{
    key = "choccytreat",
    name = "Choccy Treat",
    set = "minty_treat",
    atlas = "treats",
    pos = {
        x = 0,
        y = 0,
    },
    soul_pos = {
        x = 1,
        y = 0,
    },
    config = {
        max_highlighted = 1
    },
    loc_vars = function (self, info_queue, card)
		local key = self.key
        local plural = false
        if card.ability.consumeable.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {
                card.ability.consumeable.max_highlighted,
                s,
                a,
            }
        }
    end,
    in_pool = function (self, args)
        if pseudorandom("minty_choccychance", 1, 5) ~= 1 then return false end
        if args and args.source then
            return not not (string.find(args.source, "minty_treat") or string.find(args.source, "every_card"))
        end
        return false
    end,
    can_use = function (self, card)
        if #G.jokers.highlighted > card.ability.consumeable.max_highlighted or #G.jokers.highlighted <= 0 then return false end
        for i,v in ipairs(G.jokers.highlighted) do
            if not v.edition then return true end
        end
        return false
    end,
    use = function (self, card, area, copier)
        delay(1)
        SMODS.calculate_effect({message = "Negative!", func = function ()
            MINTY.event(function ()
                for i,v in ipairs(G.jokers.highlighted) do
                    if not v.edition then
                        v:set_edition("e_negative")
                        v:juice_up(0.3,0.3)
                    end
                end
                return true
            end)
        end, delay = 0.5}, card)
    end
}