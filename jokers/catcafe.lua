SMODS.Joker {
    key = "catcafe",
    name = "Cat Cafe",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 6
    },
    soul_pos = {
        x = 1,
        y = 6
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            chips = 333
        }
    },
    attributes = {
        "chips"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    in_pool = function (self, args)
        return true
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
            }
        end

        if context.other_joker and context.other_joker:is_kity() then
            
            return {
                chips = card.ability.extra.chips,
                juice_card = context.other_card
            }
        end
    end
}