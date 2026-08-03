SMODS.Blind({
    key = "tail",
    atlas = 'blinds',
    pos = { x=0, y=7 },
    dollars = 5,
    mult = 1.5,
    big = { min = 1 },
    boss_colour = HEX("e778db"),
    config = {
        extra = {
            disc = 4,
            origdisc = 5,
        },
    },
    loc_vars = function (self)
        return {
            vars = {
                self.config.extra.disc
            }
        }
    end,
    collection_loc_vars = function (self)
        return self:loc_vars()
    end,
    set_blind = function (self)
        self.config.extra.origdisc = G.GAME.starting_params.discard_limit
        G.GAME.round_resets.taildisc = self.config.extra.origdisc - self.config.extra.disc
        SMODS.change_discard_limit(-G.GAME.round_resets.taildisc)
    end,
    calculate = function (self, blind, context)
        if context.pre_discard and G.GAME.round_resets.taildisc and not context.hook then
            SMODS.change_discard_limit(G.GAME.round_resets.taildisc)
            G.GAME.round_resets.taildisc = nil
            return {
                message = localize('k_reset'),
            }
        end
    end,
    disable = function (self)
        if G.GAME.round_resets.taildisc then
            SMODS.change_discard_limit(G.GAME.round_resets.taildisc)
            G.GAME.round_resets.taildisc = nil
        end
    end,
    defeat = function (self)
        self:disable()
    end
})