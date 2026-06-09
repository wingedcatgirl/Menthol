
SMODS.Joker {
    key = "lucky",
    name = "Lucky",
    pronouns = "he_him",
    atlas = 'legends',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    rarity = 4,
    cost = 20,
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    pools = {
        ["kity"] = true
    },
    config = {
        extra = {
            boost = 33
        }
    },
    attributes = {
        "kity", "mod_chance", "passive"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.boost,
            },
        }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
	        return {
                numerator = context.numerator * card.ability.extra.boost
            }
        end
    end
}