FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_minty_slowtiger", carry_stat = "mult" },
  }, cost = 6, result_joker = "j_minty_wettiger"
}

SMODS.Joker {
    key = "wettiger",
    name = "Wet Tiger",
    pronouns = "it_its",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 3,
        y = 6
    },
    rarity = "fuse_fusion",
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            mult = 0,
            gain = 1,
        }
    },
    attributes = {
        "mult", "scaling", "extra_scored_cards", "passive"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {
                card.ability.extra.mult,
                card.ability.extra.gain
            }
        }
    end,
    calculate = function(self, card, context)
        if context.modify_scoring_hand then
            return {
                add_to_hand = true,
            }
        end

        if (context.individual and not context.blueprint and context.cardarea == G.play and card_is_splashed(context.other_card)) or (context.end_of_round and context.main_eval) then
            SMODS.scale_card(card,{
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "gain",
            })
            return {}
        end

        if context.joker_main and context.scoring_hand then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end
}