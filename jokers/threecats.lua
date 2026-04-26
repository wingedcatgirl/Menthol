FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_minty_hedonist" },
    { name = "j_minty_claw" },
  }, cost = 12, result_joker = "j_minty_threecats"
}

SMODS.Joker {
    dependencies = "FusionJokers",
    key = "threecats",
    pronouns = "they_them", --*Pep of Pig voice* three of you
    name = "Three Cats!",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
        },
    soul_pos = {
        x = 2,
        y = 1
        },
    rarity = 'fuse_fusion',
    cost = 12,
    config = {
        extra = {
            chips = 33,
            mult = 13,
            xmult = 3,
            again = 0
        }
    },
    attributes = {
        "mult", "xmult", "chips", "minty_3s", "suit", "rank", "kity"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        local luck = SMODS.get_probability_vars(card, 1, 3, "minty_threecats_desc", false)
        luck = math.min(luck, 3)
        return {
            key = key,
            vars = {
                luck,
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult
            }
        }
    end,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["kity"] = true
    },
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
                xmult = card.ability.extra.xmult
            }
        end

        if context.cardarea == G.play and context.individual and context.other_card:is_3() then
            local count = context.other_card:is_3()
            card.ability.extra.again = count - 1
            local bonuses = {'mult', 'xmult', 'chips'}
            local result = {card = card}
            local luck = SMODS.get_probability_vars(card, 1, 3, "minty_claw_roll", true)
            luck = math.floor(luck)
            for go=1, math.min(luck, 3) do
                local roll = pseudorandom_element(bonuses)
                for i, v in ipairs(bonuses) do
                    if v == roll then
                        table.remove(bonuses, i) -- Remove the drawn element
                        break
                    end
                end
                if roll == "mult" then
                    result["mult"] = card.ability.extra.mult
                end
                if roll == "xmult" then
                    result["xmult"] = card.ability.extra.xmult
                end
                if roll == "chips" then
                    result["chips"] = card.ability.extra.chips
                end
            end
            return result
        end

        if context.retrigger_joker_check and card.ability.extra.again ~= 0 and context.other_card == card then
            local again = card.ability.extra.again
            card.ability.extra.again = 0
            return {
                message = localize("k_again_ex"),
                message_card = card,
                repetitions = again,
            }
        end
    end
}
