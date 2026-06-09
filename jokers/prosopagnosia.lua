SMODS.Joker {
    key = "proso",
    name = "Prosopagnosia",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 3,
        y = 1
    },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {card.ability.extra.xmult}
        }
    end,
    config = {extra = {xmult = 3}},
    attributes = {
        "xmult", "passive", "face", "modify_card", "minty_facerank"
    },
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.joker_main and context.scoring_hand then
            local faces = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() or (context.scoring_hand[i]:get_id() == SMODS.Ranks["minty_face"].id) then
                    faces = 1
                    break
                end
            end

            if faces == 1 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}