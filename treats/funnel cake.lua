SMODS.Consumable{
    key = "funnel_cake",
    name = "Funnel Cake",
    set = "minty_treat",
    atlas = "treats",
    pos = {
        x = 0,
        y = 0,
    },
    soul_pos = {
        x = 4,
        y = 0
    },
    config = {
        dollars_base = 4,
        dollars_rate = 6
    },
    loc_vars = function (self, info_queue, card)
		local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        local ante = G.GAME.round_resets.ante or 1
        return {
            key = key,
            vars = {
                card.ability.consumeable.dollars_base + (card.ability.consumeable.dollars_rate * ante),
                card.ability.consumeable.dollars_rate
            }
        }
    end,
    can_use = function (self, card)
        return true
    end,
    in_pool = function (self, args)
        --[[    --Debug stuff
        if args then
            MINTY.say("Attempting to spawn a Funnel Cake card...")
            for k,v in pairs(args) do
                MINTY.say("Argument "..k.." passed with value "..tostring(v))
            end
        end
        ]]
        if args and args.source then
            return not not (string.find(args.source, "minty_treat") or string.find(args.source, "every_card"))
        end
        return false
    end,
    use = function (self, card, area, copier)
        local ante = G.GAME.round_resets.ante or 1
        delay(1)
        SMODS.calculate_effect({dollars = card.ability.consumeable.dollars_base + (card.ability.consumeable.dollars_rate * ante)}, card)
    end
}