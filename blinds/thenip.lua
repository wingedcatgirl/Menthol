SMODS.Blind {
    key = "thenip",
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX("CA7CA7"),
    atlas = 'blinds',
    pos = { x=0, y=0 },
    discovered = false,
    recalc_debuff = function(self, card, from_blind)
        local k = card:is_3()
        if k and k > 0 then
            return true
        end

        return false
    end,
    in_pool = function (self)
        if G.GAME.modifiers.cry_force_suit == "minty_3s" then return false end

        return G.GAME.round_resets.ante >= self.boss.min
    end
}