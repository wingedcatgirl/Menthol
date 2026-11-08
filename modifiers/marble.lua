SMODS.Enhancement({
    key = "marble",
    name = "Marble Card",
    atlas = "enhance",
    set = "Enhanced",
    pos = {
        x = 0,
        y = 0
    },
	object_type = "Enhancement",
	badge_colour = HEX("a3ecc0"), --Magic Mint, according to internet
    config = {
        p_dollars = 1,
        bonus = 15,
        mult = 1,
        extra = {
            gymboost = "cash"
        },
    },
    attributes = { "minty_rock_card", "suit", "economy", "chips", "mult" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.p_dollars,
                card.ability.bonus,
                card.ability.mult,
            },
        }
    end,
    replace_base_card = true,
    no_rank = true,
    any_suit = true,
    always_scores = true,
    valk_hand_buff = {
        title = "AMALGAMATED",
        colour = G.C.BLUE,
        scoring_func = function (power)
            return {
                dollars = 4 + power,
                xchips = 4 + power,
                xmult = 4 + power
            }
        end
    },
    calculate = function (self, card, context)
        if context.forcetrigger then
            return {
                dollars = card.ability.p_dollars,
                chips = card.ability.bonus,
                mult = card.ability.mult
            }
        end
    end
})