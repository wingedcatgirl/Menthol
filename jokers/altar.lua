SMODS.Joker {
    key = "altar",
    name = "Altar",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 4,
        y = 1
    },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            multgain = 5,
            mult = 0
        },
        immutable = {
            rank = "Ace",
            suit = "Spades"
        }
    },
    attributes = {
        "mult", "scaling", "suit", "rank"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.multgain,
                card.ability.extra.mult,
                localize(G.GAME.current_round.idol_card.rank, 'ranks'),
                localize(G.GAME.current_round.idol_card.suit, 'suits_plural'),
                colours = {
                    G.C.SUITS[G.GAME.current_round.idol_card.suit]
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.end_of_round then
            if context.other_card:get_id() == SMODS.Ranks[G.GAME.current_round.idol_card.rank].id and context.other_card:is_suit(G.GAME.current_round.idol_card.suit) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "multgain"
                })
                return nil, true
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.end_of_round and context.cardarea == G.jokers then
            return {
                message = localize("k_reset")
            }
        end
    end
}