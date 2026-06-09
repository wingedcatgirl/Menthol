SMODS.Back {
    key = "drippy",
    pos = { x = 0, y = 2 },
    atlas = "backs",
    unlocked = true,
    config = {},
    calculate = function(self, back, context)
        if context.modify_scoring_hand then
            return {
                add_to_hand = true,
            }
        end
    end
}

if not not next(SMODS.find_mod("CardSleeves")) then
    CardSleeves.Sleeve({
        key = "drippysleeve",
        name = "Drippy Sleeve",
        atlas = "sleeves",
        pos = { x = 0, y = 2 },
        config = {},
        unlocked = false,
        check_for_unlock = function(self, args)
            if not (G and G.GAME) then return end
            if self.get_current_deck_key() ~= "b_minty_drippy" then return end
            local skey = MINTY.sleeveunlockcheck()
            if args and args.type == 'win_custom' and MINTY.at_least_stake(G.GAME.stake, skey) then
                G.PROFILES[G.SETTINGS.profile].mintysleeves[self.key] = skey
                --unlock_card(self)
                return true
            end
        end,
        locked_loc_vars = function(self, info_queue, card)
            stake_key = MINTY.sleeveunlockcheck(self.key)
            local colours = G.C.GREY
            if stake_key ~= "stake_white" then
                colours = get_stake_col(SMODS.Stakes[stake_key].order)
            end
            return {
                key = "sleeve_locked",
                vars = {
                    localize { type = "name_text", set = "Back", key = "b_minty_drippy" },
                    localize { type = "name_text", set = "Stake", key = stake_key },
                    colours = { colours }
                }
            }
        end,
        loc_vars = function(self)
            MINTY.sleeveunlockcheck()
            local key, vars

            if self.get_current_deck_key() ~= "b_minty_drippy" then
                key = self.key
            else
                key = self.key .. "_alt"
            end

            return { key = key, vars = vars }
        end,
        calculate = function(self, sleeve, context)
            if context.modify_scoring_hand then
                return {
                    add_to_hand = true,
                }
            end

            if self.get_current_deck_key() == "b_minty_drippy" and context.individual and context.cardarea == G.hand and context.scoring_hand then
                local newcontext = {}
                for k, v in pairs(context) do
                    newcontext[k] = v
                end

                if context.other_card.debuff then
                    G.GAME.blind.triggered = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = (function()
                            SMODS.juice_up_blind(); return true
                        end)
                    }))
                    card_eval_status_text(context.other_card, 'debuff')
                else
                    newcontext.cardarea = G.play
                    SMODS.score_card(context.other_card, newcontext)
                end
            end
        end
    })
end
