FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_minty_ascetic" },
    { name = "j_minty_sabertooth" },
  }, cost = 12, result_joker = "j_minty_ninethlion"
}
local ortalab = next(SMODS.find_mod("ortalab"))

SMODS.Joker {
    key = "ninethlion",
    name = "Nineth Lion",
    atlas = 'ortalabplaceholder',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 0
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    pools = {
        ["Ortalab"] = true, --Can appear on Ortalab Stakes; technically irrelevant as this can't naturally spawn anyway
        ["kity"] = true,
    },
    config = {
        extra = {
            odds = 3,
            suit = 'minty_3s',
            xmult = 2,
            again = 0
        }
    },
    attributes = {
        "kity", "suit", "rank", "minty_3s", "fuckin not done yet lmao"
    },
    loc_vars = function(self, info_queue, card)
        if MINTY.in_collection(card) and not (ortalab or MINTY.config.dev_mode --[[or G.GAME.minty_crossover]]) then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Mod", "Ortalab" } }
        end
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        local unluck, odds = SMODS.get_probability_vars(self, 1, card.ability.extra.odds, "minty_nineth_desc", false)
        return {
            key = key,
            vars = {
                unluck,
                odds,
                localize(card.ability.extra.suit, "suits_plural"),
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Calculation goes here
    end
}