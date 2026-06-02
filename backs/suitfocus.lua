SMODS.Back{
    name = "Suit Focus Deck",
    key = "suitfocus",
    pos = { x=2, y=2 },
    atlas = "backs",
    unlocked = false,
    unlock_req = {
        sins = {
            "j_lusty_joker",
            "j_gluttenous_joker",
            "j_wrathful_joker",
            "j_greedy_joker",
            "j_minty_hedonist",
            amount = 4
        },
        minerals = {
            "j_arrowhead",
            "j_onyx_agate",
            "j_bloodstone",
            "j_rough_gem",
            "j_minty_claw",
            amount = 3
        },
        arcana = {
            "c_sun",
            "c_moon",
            "c_world",
            "c_star",
            "c_minty_cat",
            amount = 5
        },
    },
    locked_loc_vars = function (self, info_queue, card)
        local sincount, mineralcount, arcanacount = 0,0,0
        for i,v in ipairs(self.unlock_req.sins) do
            if G.P_CENTERS[v].discovered then sincount = sincount + 1 end
        end
        for i,v in ipairs(self.unlock_req.minerals) do
            if G.P_CENTERS[v].discovered then mineralcount = mineralcount + 1 end
        end
        for i,v in ipairs(self.unlock_req.arcana) do
            if G.P_CENTERS[v].discovered then arcanacount = arcanacount + 1 end
        end
        return {
            vars = {
                self.unlock_req.sins.amount,
                self.unlock_req.minerals.amount,
                self.unlock_req.arcana.amount,
                colours = {
                    sincount >= self.unlock_req.sins.amount and G.C.PURPLE or G.C.FILTER,
                    mineralcount >= self.unlock_req.minerals.amount and G.C.PURPLE or G.C.FILTER,
                    arcanacount >= self.unlock_req.arcana.amount and G.C.PURPLE or G.C.FILTER
                }
            }
        }
    end,
    check_for_unlock = function (self, args)
        local sincount, mineralcount, arcanacount = 0,0,0
        for i,v in ipairs(self.unlock_req.sins) do
            if G.P_CENTERS[v].discovered then sincount = sincount + 1 end
        end
        for i,v in ipairs(self.unlock_req.minerals) do
            if G.P_CENTERS[v].discovered then mineralcount = mineralcount + 1 end
        end
        for i,v in ipairs(self.unlock_req.arcana) do
            if G.P_CENTERS[v].discovered then arcanacount = arcanacount + 1 end
        end
        if sincount >= self.unlock_req.sins.amount and mineralcount >= self.unlock_req.minerals.amount and arcanacount >= self.unlock_req.arcana.amount then
            --unlock_card(self)
            return true
        end
    end,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                localize{ type = "name_text", set = "Joker", key = "j_minty_flexweirdo" },
                localize{ type = "name_text", set = "Tarot", key = "c_minty_focus" },
            }
        }
    end,
    calculate = function (self, back, context)
        if context.before and context.scoring_hand and context.scoring_hand[1] and not G.GAME.minty_focussuit then
            --MINTY.say("Attempting to set focus suit...", "TRACE")
            if SMODS.has_no_suit(context.scoring_hand[1]) then
                G.GAME.minty_focussuit = "suitless"
            elseif SMODS.has_any_suit(context.scoring_hand[1]) then
                G.GAME.minty_focussuit = "all-suit"
            else
                G.GAME.minty_focussuit = context.scoring_hand[1].base.suit
            end
        end
    end,
    apply = function (self, back)
        local sleeveexist = not not next(SMODS.find_mod("CardSleeves"))
        local fusionexist = not not next(SMODS.find_mod("FusionJokers"))
        local focussleeve = ((G.GAME.selected_sleeve or "sleeve_casl_none") == "sleeve_minty_suitfocussleeve")
        MINTY.event(
            function ()
                if not (sleeveexist and fusionexist and focussleeve) then
                    SMODS.add_card{
                        key = "j_minty_flexweirdo",
                        stickers = {
                            "eternal"
                        },
                        no_edition = true,
                        force_stickers = true
                    }
                end
                SMODS.add_card{
                    key = "c_minty_focus",
                    set = "Tarot"
                }
                return true
            end
        )
    end,
}

if not not next(SMODS.find_mod("CardSleeves")) then
    CardSleeves.Sleeve{
        key = "suitfocussleeve",
        name = "Suit Focus Sleeve",
        atlas = "sleeves",
        pos = { x=1, y=2 },
        unlocked = false,
        check_for_unlock = function (self, args)
            if not (G and G.GAME) then return end
            if self.get_current_deck_key() ~= "b_minty_suitfocus" then return end
            local skey = MINTY.sleeveunlockcheck()
            if args and args.type == 'win_custom' and MINTY.at_least_stake(G.GAME.stake, skey) then
                G.PROFILES[G.SETTINGS.profile].mintysleeves[self.key] = skey
                --unlock_card(self)
                return true
            end
        end,
        locked_loc_vars = function (self, info_queue, card)
            stake_key = MINTY.sleeveunlockcheck(self.key)
            local colours = G.C.GREY
            if stake_key ~= "stake_white" then
                colours = get_stake_col(SMODS.Stakes[stake_key].order)
            end
            return {
                key = "sleeve_locked",
                vars = {
                    localize{type = "name_text", set = "Back", key = "b_minty_suitfocus"},
                    localize{type = "name_text", set = "Stake", key = stake_key},
                    colours = {colours}
                }
            }
        end,
        loc_vars = function(self)
            MINTY.sleeveunlockcheck()
            local key, vars

            vars = {
                localize{ type = "name_text", set = "Joker", key = "j_minty_flexweirdo" },
                localize{ type = "name_text", set = "Tarot", key = "c_minty_focus" },
            }

            if self.get_current_deck_key() ~= "b_minty_suitfocus" then
                key = self.key
            else
                if not not next(SMODS.find_mod("FusionJokers")) then
                    key = self.key.."_fusionalt"
                    vars[1] = localize{ type = "name_text", set = "Joker", key = "j_minty_superboss" }
                else
                    key = self.key.."_alt"
                    vars[1] = localize{ type = "name_text", set = "Joker", key = "j_minty_shadowcrystal" }
                end
            end

            return { key = key, vars = vars }
        end,
        calculate = function (self, sleeve, context)
            if context.before and context.full_hand and not G.GAME.minty_focussuit then
                if SMODS.has_no_suit(context.full_hand[1]) then
                    G.GAME.minty_focussuit = "suitless"
                elseif SMODS.has_any_suit(context.full_hand[1]) then
                    G.GAME.minty_focussuit = "all-suit"
                else
                    G.GAME.minty_focussuit = context.full_hand[1].base.suit
                end
            end
        end,
        apply = function (self)

            if self.get_current_deck_key() ~= "b_minty_suitfocus" then
                MINTY.event(
                    function ()
                        SMODS.add_card{
                            key = "j_minty_flexweirdo",
                            stickers = {
                                "eternal"
                            },
                            no_edition = true,
                            force_stickers = true
                        }
                        SMODS.add_card{
                            key = "c_minty_focus",
                            set = "Tarot"
                        }
                        return true
                    end
                )
            elseif not not next(SMODS.find_mod("FusionJokers")) then
                MINTY.event(
                    function ()
                        SMODS.add_card{
                            key = "j_minty_superboss",
                            stickers = {
                                "eternal"
                            },
                            no_edition = true,
                            force_stickers = true
                        }
                        return true
                    end
                )
            else
                MINTY.event(
                    function ()
                        SMODS.add_card{
                            key = "j_minty_shadowcrystal",
                            stickers = {
                                "eternal"
                            },
                            no_edition = true,
                            force_stickers = true
                        }
                        return true
                    end
                )
            end
        end
    }
end