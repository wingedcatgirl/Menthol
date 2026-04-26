FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_minty_cakegun", carry_stat = "shots" },
  }, cost = 10, result_joker = "j_minty_shakegun"
}

SMODS.Joker {
    key = "shakegun",
    name = "Milkshake Gun",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 7
    },
    rarity = "fuse_fusion",
    cost = 10,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            percent = 12,
            shots = 6
        }
    },
    attributes = {
        "xblindsize", "food"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        return {
            key = key,
            vars = {
                card.ability.extra.percent
            }
        }
    end,
    set_ability = function (self, card, initial, delay_sprites)
        G.E_MANAGER:add_event(Event({trigger = 'after', --[[delay = 1,]] blocking = false, func = function()
                        card.ability.extra.percent = card.ability.extra.shots * 2
                        return true
                    end}))
    end,
    calculate = function(self, card, context)
        if context.modify_scoring_hand then
            return {
                add_to_hand = true,
            }
        end

        if context.individual and not context.blueprint and context.cardarea == G.play and card_is_splashed(context.other_card) then
            return {
                message = localize("k_minty_shaked"),
                message_card = G.GAME.blind,
                sound = "minty_squirt",
                func = function ()
                    local final_chips = to_big((G.GAME.blind.chips / 100) * (100 - card.ability.extra.percent))
                    G.GAME.blind.chips = final_chips
                    G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
                        G.GAME.blind:juice_up()
                        G.GAME.blind.chip_text = number_format(final_chips)
                        return true
                    end}))
                end
            }
        end
    end
}