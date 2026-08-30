SMODS.Blind({
    key = "tooth",
    atlas = 'blinds',
    pos = { x=0, y=5 },
    dollars = 4,
    mult = 1,
    small = { min = 1, allow_duplicates = true },
    boss_colour = HEX("93ca86"),
    config = {
        extra = {
            flip = 2
        },
    },
    loc_vars = function (self)
        local plural = (self.config.extra.flip > 1)
        return {
            vars = {
                plural and (" "..self.config.extra.flip) or "",
                plural and "s" or "",
            }
        }
    end,
    collection_loc_vars = function (self)
        return self:loc_vars()
    end,
    set_blind = function (self)
        G.GAME.round_resets.toothflip = self.config.extra.flip
    end,
    stay_flipped = function (self, area, card)
        if G.GAME.round_resets.toothflip > 0 then
            G.GAME.round_resets.toothflip = G.GAME.round_resets.toothflip - 1
            card.ability.wheel_flipped = true
            return true
        end
        return false
    end,
    disable = function (self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].ability.wheel_flipped and G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
                G.hand.cards[i].ability.wheel_flipped = nil
            end
        end
        for k, v in pairs(G.playing_cards) do
            v.ability.wheel_flipped = nil
        end
        G.GAME.round_resets.toothflip = nil
    end,
    defeat = function (self)
        self:disable()
    end,
    weight = 5, --Half default
})