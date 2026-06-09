SMODS.Joker {
    key = "eaten",
    name = "Eaten Joker",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 5,
        y = 1
    },
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {extra = {mult = 7, chips = 17, odds = 7}},
    attributes = {
        "rank", "seven", "mult", "chips", "chance", "destroy_card"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        local luck, odds = SMODS.get_probability_vars(self, 1, card.ability.extra.odds, "minty_eaten_desc", false)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
                odds,
                luck
            }
        }
    end,
    calculate = function(self, card, context)
        --[[ Figure this out later~
        if context.forcetrigger and context.scoring_hand then
            for i = 1, #context.scoring_hand do

            end
        end
        --]]

        if context.cardarea == G.play and context.individual then
            if context.other_card:get_id() == 7 then
                return {
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
        if context.cardarea == G.play and context.destroy_card and not context.destroy_card.ability.eternal and context.destroy_card:get_id() ~= 7 and SMODS.pseudorandom_probability(card, 'minty_eaten', 1, card.ability.extra.odds, 'minty_eaten') then
            return {
                remove = true,
                message = localize('k_minty_drowned'),
                card = card
            }
        end
    end
}