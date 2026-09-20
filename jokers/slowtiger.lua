SMODS.Joker {
    key = "slowtiger",
    name = "Slow Tiger",
    pronouns = "it_its",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 4,
        y = 1
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["kity"] = true
    },
    config = { extra = {mult = 1, multgain = 1} },
    in_pool = function (self, args)
        return not next(SMODS.find_card("j_minty_fasttiger", true))
    end,
    attributes = {
        "mult", "scaling", "kity"
    },
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.mult = G.GAME.round or 1
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {card.ability.extra.mult, card.ability.extra.multgain}
        }
    end,
    calculate = function(self, card, context)
        if (context.joker_main and context.scoring_hand) or context.forcetrigger then
            return {
                mult = card.ability.extra.mult,
            }
        end

        if context.minty_card_shaken and not MINTY.in_collection(card) and (card.ability.extra.mult * G.P_CENTERS.j_minty_fasttiger.config.extra.xmultiplier > 1) then
            discover_card(G.P_CENTERS.j_minty_fasttiger)

            card.states.drag.can = false
            card.states.drag.is = false

            local amt = card.ability.extra.mult

            return {
                message = "!", --todo better message
                sound = "tarot1",
                extra = {
                    func = function()
                        MINTY.event(function()
                            card:set_ability(G.P_CENTERS.j_minty_fasttiger)
                            card.ability.extra.xmult = amt * card.ability.extra.xmultiplier
                            card:juice_up(5)
                            play_sound("tarot1")
                            card.states.drag.can = true
                            return true
                        end, { trigger = "after", delay = 1.5 })
                    end
                }
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            SMODS.scale_card(card,{
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "multgain",
            })
            return {}
        end
    end
}