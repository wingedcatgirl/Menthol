SMODS.Enhancement({
    key = "microcline",
    name = "Microcline Card",
    atlas = "enhance",
    set = "Enhanced",
    pos = {
        x = 2,
        y = 0
    },
	object_type = "Enhancement",
	badge_colour = HEX("a3ecc0"), --Magic Mint, according to internet
    config = {
        h_chips = 100,
        extra = {
            gymboost = "hchips"
        },
    },
    attributes = { "minty_rock_card", "chips" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.h_chips,
            },
        }
    end,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    valk_hand_buff = {
        title = "DWARF JOKE", --technically this name is a placeholder but so was Leaf story
        colour = HEX("CA7CA7"),
        scoring_func = function (n)
            return {
                echips = 1.2 + ((n-1)*0.1)
            }
        end
    },
    calculate = function (self, card, context)
        if context.forcetrigger then
            return {
                chips = card.ability.h_chips
            }
        end
    end
})