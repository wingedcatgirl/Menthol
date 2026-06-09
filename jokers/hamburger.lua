SMODS.Joker {
    key = "hamburger",
    name = "Delicious Hamburger",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 4,
        y = 0
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = true,
    config = {
        extra = {
            hands = 3
        }
    },
    attributes = {
        "food", "hands", "scaling"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.hands
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger and not card.getting_sliced then
            return {
                func = function ()
                    ease_hands_played(card.ability.extra.hands)
                    card.ability.extra.hands = card.ability.extra.hands - 1
                    if card.ability.extra.hands <= 0 then
                        SMODS.destroy_cards(card, true, false, true)
                    end
                end,
                message = localize("k_minty_nommed")
            }
        end
    end
}