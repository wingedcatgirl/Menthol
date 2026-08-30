SMODS.Blind({
    key = "paw",
    atlas = 'blinds',
    pos = { x=0, y=6 },
    dollars = 5,
    mult = 1.5,
    big = { min = 1, allow_duplicates = true },
    boss_colour = HEX("82cfcb"),
    config = {
        extra = {
            play = 4,
            origplay = 5
        },
    },
    loc_vars = function (self)
        return {
            vars = {
                self.config.extra.play
            }
        }
    end,
    collection_loc_vars = function (self)
        return self:loc_vars()
    end,
    calculate = function (self, blind, context)
        if context.setting_blind then
            self.config.extra.origplay = G.GAME.starting_params.play_limit
            G.GAME.round_resets.pawplay = self.config.extra.origplay - self.config.extra.play
            SMODS.change_play_limit(-G.GAME.round_resets.pawplay)
        end
        if (context.after or context.selling_card) and G.GAME.round_resets.pawplay then
            SMODS.change_play_limit(G.GAME.round_resets.pawplay)
            G.GAME.round_resets.pawplay = nil
            if context.selling_card then
                return {
                    message = localize('k_reset'),
                    message_card = context.card
                }
            else
                return {
                    message = localize('k_reset'),
                }
            end
        end
    end,
    disable = function (self)
        if G.GAME.round_resets.pawplay then
            SMODS.change_play_limit(G.GAME.round_resets.pawplay)
            G.GAME.round_resets.pawplay = nil
        end
    end,
    defeat = function (self)
        self:disable()
    end,
    weight = 5, --Half default
})