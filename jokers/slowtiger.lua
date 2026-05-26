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
    attributes = {
        "mult", "scaling"
    },
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.mult = G.GAME.round or 1
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {card.ability.extra.mult, card.ability.extra.multgain}
        }
    end,
    calculate = function(self, card, context)
        if (context.joker_main and context.scoring_hand) or context.forcetrigger then
            return {
                    mult = card.ability.extra.mult,
            }
        end

        --if a food card just got consumed, convert to fast tiger?

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