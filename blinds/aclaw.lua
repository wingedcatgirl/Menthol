SMODS.Blind({
    key = "claw",
    atlas = 'blinds',
    pos = { x=0, y=4 },
    dollars = 4,
    mult = 1,
    small = { min = 1, allow_duplicates = true },
    boss_colour = HEX("797dc3"),
    config = {
        extra = {
            debuff = 1
        },
    },
    loc_vars = function (self)
        local plural = self.config.extra.debuff > 1
        return {
            vars = {
                plural and (" "..self.config.extra.debuff) or "",
                plural and "s" or "",
            }
        }
    end,
    collection_loc_vars = function (self)
        return self:loc_vars()
    end,
    set_blind = function (self)
        G.GAME.round_resets.clawdebuff = self.config.extra.debuff
    end,
    stay_flipped = function (self, area, card)
        if G.GAME.round_resets.clawdebuff > 0 then
            G.GAME.round_resets.clawdebuff = G.GAME.round_resets.clawdebuff - 1
            SMODS.debuff_card(card, true, self.key)
        end
    end,
    disable = function (self)
        G.GAME.round_resets.clawdebuff = 0
        for i = 1, #G.hand.cards do
            SMODS.debuff_card(card, false, self.key)
        end
        for k, card in pairs(G.playing_cards) do
            SMODS.debuff_card(card, false, self.key)
        end
        G.GAME.round_resets.clawdebuff = nil
    end,
    defeat = function (self)
        self:disable()
    end,
    weight = 5, --Half default
})