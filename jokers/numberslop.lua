SMODS.Joker {
    key = "numberslop",
    name = "Ugh, more numberslop",
    pronouns = "she_her",
    atlas = 'jokerdoodles2',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            mult = 5
        }
    },
    attributes = {
        "mult", "stupid"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.in_collection(card) and ((G.STAGE == G.STAGES.RUN and G.GAME.minty_no_dumb_shit) or (G.STAGE == G.STAGES.MAIN_MENU and MINTY.config.no_dumbass_shit)) then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_config", specific_vars = { localize("option_minty_nodumbshit"), } }
        end
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    in_pool = function (self, args)
        return not G.GAME.minty_no_dumb_shit
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}