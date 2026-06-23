if not SMODS.find_mod("UnStable")[1] then --UnStable tweaks all these for its own ranks, 3petition will have to be reimplemented entirely to combine with that
    SMODS.Joker:take_ownership('hack', {
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.repetition then
                local count = 0
                if context.other_card:is_3() then
                    count = context.other_card:is_3()
                end

                if (context.other_card:get_id() == 2 or 
                context.other_card:get_id() == 4 or 
                context.other_card:get_id() == 5) then
                    count = count + 1
                end

                if count >= 1 then 
                    return {
                        message = localize('k_again_ex'),
                        repetitions = count,
                        card = card
                    }
                end
            end
        end
    }, true)

    SMODS.Joker:take_ownership('fibonacci', {
        config = {
            extra = 8,
            again = 0,
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = {card.ability.extra}
            }
        end,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.individual then
                if (context.other_card:get_id() == 2 or 
                context.other_card:get_id() == 5 or 
                context.other_card:get_id() == 8 or 
                context.other_card:get_id() == 14) or context.other_card:is_3() then
                    local count = context.other_card:is_3() or 0
                    if (context.other_card:get_id() == 2 or 
                    context.other_card:get_id() == 5 or 
                    context.other_card:get_id() == 8 or 
                    context.other_card:get_id() == 14) then
                        count = count + 1
                    end
                    card.ability.again = count - 1
                    return {
                        mult = card.ability.extra,
                        card = card
                    }
                end
            end
            
            if context.retrigger_joker_check and card.ability.again ~= 0 and context.other_card == card then
                local again = card.ability.again
                card.ability.again = 0
                return {
                    message = localize("k_again_ex"),
                    message_card = card,
                    repetitions = again,
                }
            end
        end
    }, true)

    SMODS.Joker:take_ownership('even_steven', {
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.individual then
                if context.other_card:is_even()
                then
                    return {
                        mult = card.ability.extra,
                        card = card
                    }
                end
            end
        end
    }, true)

    SMODS.Joker:take_ownership('odd_todd', {
        config = {
            extra = {
                chips = 31,
                again = 0,
            },
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = {card.ability.extra.chips}
            }
        end,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.individual then
                if context.other_card:is_odd() or context.other_card:is_3() then
                local count = context.other_card:is_3() or 0
                if context.other_card:is_odd() and (context.other_card:get_id() ~= 3) then --Don't double count 3 rank
                    count = count + 1
                end
                card.ability.extra.again = count - 1
                    return {
                        chips = card.ability.extra.chips,
                        card = card
                    }
                end
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
    }, true)
end

function Card:is_numbercard(bypass_debuff)
    if self.debuff and not bypass_debuff then return false end
    if SMODS.has_no_rank(self) then return false end
    local id = self:get_id()
    local face = self:is_face()
    if face then return false end
    if id > 0 then return true end 
end

function Card:is_odd(bypass_debuff)
    if self.debuff and not bypass_debuff then return false end
    if not self:is_numbercard() then return false end
    local id = self:get_id()
    if (id == 14) or (id%2 == 1) then return true end
    return false
end

function Card:is_even(bypass_debuff)
    if self.debuff and not bypass_debuff then return false end
    if not self:is_numbercard() then return false end
    local id = self:get_id()
    if (id ~= 14) and (id%2 == 0) then return true end
    return false
end

SMODS.Enhancement:take_ownership("m_stone",{
    loc_vars = function (self, info_queue, card)
        local key = self.key
        if MINTY.config.stone_rename then
            key = key.."_alt"
        end

        return {
            key = key,
            vars = {
                card.ability.bonus
            }
        }
    end
}, true)