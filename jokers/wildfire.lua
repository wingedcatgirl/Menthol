FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_campfire" },
    { name = "j_madness" },
  }, cost = 12, result_joker = "j_minty_wildfire"
}

SMODS.Joker {
    key = "wildfire",
    name = "Wildfire",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 7
    },
    soul_pos = {
        x = 1,
        y = 7
    },
    rarity = "fuse_fusion",
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            xmult = 3,
            xmult_gain = 0.25,
            perish_count = 2
        }
    },
    attributes = {
        "spread_this_like_wildfire", "xmult", "scaling"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        info_queue[#info_queue+1] = { set = "Other", key = "minty_spread2", specific_vars = { card.ability.extra.perish_count, card.ability.extra.perish_count == 1 and "" or "s" } }
        return {
            key = key,
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_gain,
                card.ability.extra.perish_count,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.ending_shop and context.cardarea == G.jokers and not context.blueprint then
            local mypos = 0
            for i = 1,#G.jokers.cards do
                if G.jokers.cards[i] == card then mypos = i break end
            end
            if mypos == 1 then return end
            local target = G.jokers.cards[mypos-1]
            if target.config.center.key == self.key or SMODS.is_eternal(target, card) then return end
            target:set_ability(self.key)
            local newvals = {}
            for k,v in pairs(target.ability.extra) do
                newvals[k] = math.max(target.ability.extra[k], card.ability.extra[k])
            end
            target.ability.extra = newvals
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_gain",
                no_message = true
            })
            if not target.ability.perishable then target:add_sticker("perishable", true) end
            target.ability.perish_tally = card.ability.extra.perish_count
            SMODS.calculate_effect({message = localize("k_minty_spread") }, target)
        end

        if context.joker_main and context.scoring_hand then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
