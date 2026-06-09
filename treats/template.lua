SMODS.Consumable{
    key = "template",
    name = "",
    set = "minty_treat",
    atlas = "treats",
    pos = {
        x = 0,
        y = 0,
    },
    config = {
        
    },
    loc_vars = function (self, info_queue, card)
		local key = self.key
        local plural = false
        if card.ability.consumeable.max_highlighted ~= 1 then plural = true end
        local s = plural and "s" or ""
        local a = plural and "" or "a "
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.consumeable.max_highlighted,
                s,
                a,
            }
        }
    end,
    in_pool = function (self, args)
        if args and args.source then
            return not not (string.find(args.source, "minty_treat") or string.find(args.source, "every_card"))
        end
        return false
    end,
    can_use = function (self, card)
        
    end,
    use = function (self, card, area, copier)
        
    end
}