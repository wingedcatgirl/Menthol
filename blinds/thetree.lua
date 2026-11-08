local ortalab = next(SMODS.find_mod("ortalab"))

SMODS.Blind {
    key = "thetree",
    dollars = 6,
    mult = 1.75,
    boss = { min = 3 },
    boss_colour = HEX("CA7CA7"),
    atlas = 'blinds',
    pos = { x=0, y=1 },
    discovered = false,
    config = {extra = {suit = 'minty_3s'}},
    attributes = {
        "debuff_hand", "minty_3s", "suit", "rank", "three"
    },
    loc_vars = function(self)
        return {vars = {self.config.extra.suit}}
    end,
    collection_loc_vars = function(self)
        return {vars = {self.config.extra.suit}}
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        for _, card in pairs(cards) do
            if card:is_3() then return false end
        end
        return true
    end,
    in_pool = function(self)
        if not (ortalab or MINTY.config.dev_mode or G.GAME.minty_crossover) then return false end
        if G.GAME.round_resets.ante < 3 then return false end
        for _, card in pairs(G.playing_cards or {}) do
            if card:is_3() then return true end
        end
        return false
    end
}