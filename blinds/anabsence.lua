SMODS.Blind{
    key="absence",
    atlas = 'blinds',
    boss_colour = HEX("00FFFFFF"),
    pos = { x=0, y=50 },
    small = { min = 2 },
    big = { min = 1 },
    weight = 5,
    dollars = 0,
    mult = 0,
    set_blind = function (self)
        --Fallback into instant game over if skip isn't forced properly
        MINTY.event(function ()
            G.STATE = G.STATES.GAME_OVER
            if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
            end
            G:save_settings()
            G.FILE_HANDLER.force = true
            G.STATE_COMPLETE = false
            return true
        end)
    end
}