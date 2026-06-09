SMODS.Joker {
    key = "pessimist",
    name = "Pessimist",
    --pronouns = "",
    atlas = 'jokerdoodles',
    pos = {
        x = 4,
        y = 8
    },
    soul_pos = {
        x = 5,
        y = 8
    },
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            chips = 0,
            factor = 2
        }
    },
    attributes = {
        "chips", "scaling", "chance"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.chips,
                card.ability.extra.factor,
                colours = {
                    G.C.UI.TEXT_INACTIVE
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pseudorandom_result and not context.result then
            local num = context.denominator
            if num > 7.5 then
                num = math.sqrt(num) + math.log(num, 2) + 0.5 + 3.708993234 --C to bring f(7.5) to 15 and keep the function continuous
            end
            num = math.floor(num) --... okay it's not continuous *now* but it was!!
            card.ability.extra.chips = card.ability.extra.chips + (num * card.ability.extra.factor)
            return {
                message = localize("k_upgrade_ex")
            }
        end

        if context.joker_main and card.ability.extra.chips >= 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}