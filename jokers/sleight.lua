SMODS.Joker {
    key = "sleight",
    name = "Sleight of Hand",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {

    },
    attributes = {
        "discard", "passive", "unscored"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            local fake_discard = {}
            for i,v in ipairs(G.play.cards) do
                if not SMODS.in_scoring(v, context.scoring_hand) then
                    fake_discard[#fake_discard+1] = v
                end
            end
            for i,v in ipairs(G.hand.cards) do
                fake_discard[#fake_discard+1] = v
            end

            SMODS.calculate_context{pre_discard = true, full_hand = fake_discard, fake_discard = true, hook = true}
        end

        if context.discard and not context.fake_discard then
            local cloned_context = {}
            for k,v in pairs(context) do
                cloned_context[k] = v
            end
            cloned_context.individual = true
            cloned_context.discard = nil

            cloned_context.fake_unscored = true
            cloned_context.cardarea = "unscored"
            SMODS.calculate_context(cloned_context)
            cloned_context.fake_unscored = nil

            cloned_context.fake_held = true
            cloned_context.cardarea = G.hand
            SMODS.calculate_context(cloned_context)
        end

        if context.final_scoring_step then
            local sleighted = {}
            for i,v in ipairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) then
                    sleighted[#sleighted+1] = v
                end
            end
            for i,v in ipairs(G.hand.cards) do
                sleighted[#sleighted+1] = v
            end
            
            for i,v in ipairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) then
                    SMODS.calculate_context{discard = true, other_card = v, full_hand = sleighted, fake_discard = true}
                    v:calculate_seal{discard = true, other_card = v, fake_discard = true}
                    SMODS.calculate_context{individual = true, other_card = v, full_hand = sleighted, fake_held = true, cardarea = G.hand}
                    v:calculate_seal{individual = true, other_card = v, fake_held = true, cardarea = G.hand}
                end
            end

            for i,v in ipairs(G.hand.cards) do
                SMODS.calculate_context{discard = true, other_card = v, full_hand = held, fake_discard = true}
                v:calculate_seal{discard = true, other_card = v, fake_discard = true}
                SMODS.calculate_context{individual = true, other_card = v, full_hand = held, fake_unscored = true, cardarea = "unscored"}
                v:calculate_seal{individual = true, other_card = v, fake_unscored = true, cardarea = "unscored"}
            end
            return nil, true
        end
    end
}