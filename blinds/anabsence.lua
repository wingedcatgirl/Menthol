SMODS.Blind{
    key="absence",
    atlas = 'blinds',
    boss_colour = HEX("00FFFFFF"),
    pos = { x=0, y=50 },
    small = { min = 2, allow_duplicates = true },
    big = { min = 1, allow_duplicates = true },
    weight = 5,
    dollars = 0,
    mult = 0,
    collection_loc_vars = function (self)
        if not self.discovered then
            return { --This doesn't actually seem to work but I'm leaving it here for in case I try to figure out how to make it work
                key = "bl_minty_undiscovered_alt_desc"
            }
        end
    end,
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
    end,
    loc_vars = function (self)
        if G.STAGE == G.STAGES.RUN then
            if G.GAME["minty_absence_alt_text"..(G.GAME.round_resets.ante)] == nil then
                G.GAME["minty_absence_alt_text"..(G.GAME.round_resets.ante)] = pseudorandom("minty_absence_alt_text", 1, 8) == 8
            end
            if G.GAME["minty_absence_alt_text"..(G.GAME.round_resets.ante)] then
                return {
                    key = self.key.."_alt"
                }
            end
        end
    end
}