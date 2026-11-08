SMODS.Blind {
    key = "calico_counter",
    dollars = 8,
    mult = 2,
    boss = { showdown = true },
    boss_colour = HEX("CA7CA7"),
    atlas = 'blinds',
    pos = { x=0, y=2 },
    discovered = false,
    config = {
        extra = {
            odds = 5
        }
    },
    attributes = {
        "debuff", "face_down", "chance"
    },
    loc_vars = function (self)
        local luck, odds = SMODS.get_probability_vars(self, 1, self.config.extra.odds, "minty_calico_desc", false)
        return {
            vars = {
                luck,
                odds
            }
        }
    end,
    collection_loc_vars = function (self)
        local luck, odds = SMODS.get_probability_vars(self, 1, self.config.extra.odds, "minty_calico_desc", false)
        return {
            vars = {
                luck,
                odds
            }
        }
    end,
    recalc_debuff = function(self, card, from_blind)
        if not (card.area and card.area.config) then return false end
        if card.area.config.type ~= "deck" and card.area.config.type ~= "hand" then return false end
        if SMODS.pseudorandom_probability(card, "minty_calico_debuff", 1, self.config.extra.odds, "minty_calico_debuff") then
            card.ability.calicodebuffed = true
            return true
        else
            return false
        end
    end,
    stay_flipped = function (self, area, card)
        if area ~= G.hand then return false end
        if SMODS.pseudorandom_probability(card, "minty_calico_flip", 1, self.config.extra.odds, "minty_calico_flip") then
            card.ability.wheel_flipped = true
            if not next(SMODS.find_card("j_minty_finity_calico")) and card.debuff and card.ability.calicodebuffed and (pseudorandom("calicoundebuff") < 1/2) then
                card.ability.calicodebuffed = nil
                card.debuff = false
            else
                if not next(SMODS.find_card("j_minty_finity_calico")) then
                    card.ability.wheel_flipped = false
                end
            end
        end
        return card.ability.wheel_flipped
    end,
    disable = function (self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].ability.wheel_flipped and G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
                G.hand.cards[i].ability.wheel_flipped = nil
            end
            if G.hand.cards[i].ability.calicodebuffed then
                G.hand.cards[i].debuff = false
                G.hand.cards[i].ability.calicodebuffed = nil
            end
        end
        for k, v in pairs(G.playing_cards) do
            if v.ability.calicodebuffed then
                v.debuff = false
                v.ability.calicodebuffed = nil
            end
            v.ability.wheel_flipped = nil
        end
    end,
    defeat = function (self)
        if G.hand.cards then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].ability.calicodebuffed then
                    G.hand.cards[i].debuff = false
                    G.hand.cards[i].ability.calicodebuffed = nil
                end
                
                if G.hand.cards[i].ability.wheel_flipped and G.hand.cards[i].facing == 'back' then
                    G.hand.cards[i]:flip()
                    G.hand.cards[i].ability.wheel_flipped = nil
                end
            end
        end
        for k, v in pairs(G.playing_cards) do
            if v.ability.calicodebuffed then
                v.debuff = false
                v.ability.calicodebuffed = nil
            end
            v.ability.wheel_flipped = nil
        end
        --unlock_card(G.P_CENTERS.j_minty_finity_calico)
    end
}