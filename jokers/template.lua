SMODS.Joker {
    key = "newjoker",
    name = "New Joker",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            mult = 5
        }
    },
    attributes = {

    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text and G.localization.descriptions[self.set][self.key.."_flavor"] then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Calculation goes here
    end
}