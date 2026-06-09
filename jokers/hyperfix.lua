local talisman = not not next(SMODS.find_mod("Talisman"))

SMODS.Joker {
    key = "hyperfix",
    name = "Angel of Hyperfixation",
    pronouns = "she_her",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 4
    },
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            expmult_base = 1,
            expmult_boost = 0.25,
            xmult_rate = 2.5,
            talisman = talisman,
        }
    },
    attributes = {
        talisman and "emult" or "xmult", "scaling"
    },
    in_pool = function (self, args) --Don't spawn if locked at 0 (not sure that's actually possible but hey)
        if not (G and G.GAME and G.GAME.minty_hyperfix) then return false end
        if G.GAME.minty_hyperfix.active or (G.GAME.minty_hyperfix.value > 0) then
            return true
        else
            return false
        end
    end,
    loc_vars = function(self, info_queue, card)
        local val = G.GAME and G.GAME.minty_hyperfix and G.GAME.minty_hyperfix.value or 0
        local key = self.key
        local base = card.ability.extra.talisman and card.ability.extra.expmult_base or card.ability.extra.xmult_rate
        local rate = card.ability.extra.talisman and card.ability.extra.expmult_boost or card.ability.extra.xmult_rate
        local total = base+(rate*val)
        local op = (card.ability.extra.talisman and "^" or "X")
        local opcol = card.ability.extra.talisman and G.C.DARK_EDITION or G.C.XMULT
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                op,
                rate,
                total,
                colours = {
                    opcol
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.joker_main and context.scoring_hand) or context.forcetrigger then
            local val = G.GAME and G.GAME.minty_hyperfix and G.GAME.minty_hyperfix.value or 0
            local base = card.ability.extra.talisman and card.ability.extra.expmult_base or card.ability.extra.xmult_rate
            local inc = (card.ability.extra.talisman and card.ability.extra.expmult_boost or card.ability.extra.xmult_rate) * val
            local op = card.ability.extra.talisman and "emult" or "xmult"
            if to_big(base + inc) <= to_big(1) then return end
            local ret = {}
            ret[op] = base+inc
            return ret
        end

        if context.end_of_round and G.GAME.minty_hyperfix.active and not context.blueprint and not context.repetition and not context.individual then
            return {
                message = localize("k_upgrade_ex")
            }
        end
    end
}