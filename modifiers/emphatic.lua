local mf = SMODS.find_mod("MoreFluff")[1]

SMODS.Enhancement({
    key = "emphatic",
    name = "Emphatic Card",
    atlas = "enhance",
    set = "Enhanced",
    pos = {
        x = 1,
        y = 2
    },
	object_type = "Enhancement",
	badge_colour = HEX("a3ecc0"), --Magic Mint, according to internet
    config = {
        extra = {
            xmult = 2,
            chips = 100
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.chips,
            },
        }
    end,
    get_weight = function (self)
        local default = 5
        return mf and default or default/2
    end,
    valk_hand_buff = {
        title = "Mic. Drop.",
        colour = G.C.GREY,
        scoring_func = function (power)
            local _, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
            for _,card in ipairs(scoring_hand) do
                if card.config.center_key == "m_minty_emphatic" then
                    card.kablooied = true
                end
            end
            local meme = "minty_memenoise"..math.random(MINTY.memecount)
            return {
                emult = 1.20 + (power*0.05),
                echips = 1.20 + (power*0.05),
                sound = meme
            }
        end
    },
    calculate = function (self, card, context)
        if context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult,
                chips = card.ability.extra.chips,
                remove_default_message = true,
                remove = true
            }
        end

        if context.main_scoring and context.cardarea == G.play then
            card.kablooied = true
            local meme = "minty_memenoise"..math.random(MINTY.memecount)

            return {
                sound = meme,
                message = localize("k_minty_ratio"),
                remove_default_message = true,
                xmult = card.ability.extra.xmult,
                chips = card.ability.extra.chips,
            }
        end

        if context.destroy_card and context.destroy_card == card and card.kablooied then
            return {
                remove = true
            }
        end
    end
})