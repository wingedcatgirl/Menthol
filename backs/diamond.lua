SMODS.Back({
    name = "Deck of the Diamond",
    key = "diamonds",
    pos = { x = 1, y = 1 },
    atlas = "backs",
    unlocked = false,
    unlock_req = {
        "j_greedy_joker",
        "j_rough_gem",
        "c_star",
    },
    locked_loc_vars = function(self, info_queue, card)
        local vars = {
            colours = {

            }
        }
        for i, v in ipairs(self.unlock_req) do
            vars.colours[i] = G.P_CENTERS[v].discovered and G.C.PURPLE or G.C.FILTER
        end
        return {
            vars = vars
        }
    end,
    check_for_unlock = function(self, args)
        local result = false
        if args and args.type == "discover_amount" then
            result = true
            for i, v in ipairs(self.unlock_req) do
                result = result and G.P_CENTERS[v].discovered
            end
            if result then
                --unlock_card(self)
                return true
            end
        end
        return result
    end,
    config = {},

    apply = function()
        local sleeveexist = not not next(SMODS.find_mod("CardSleeves"))
        local fusionexist = not not next(SMODS.find_mod("FusionJokers"))
        local diamondsleeve = ((G.GAME.selected_sleeve or "sleeve_casl_none") == "sleeve_minty_diamondsleeve")
        if not (sleeveexist and fusionexist and diamondsleeve) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card = SMODS.create_card({
                        set = 'Joker',
                        area = G.jokers,
                        key = 'j_greedy_joker',
                        stickers = { 'eternal' },
                        force_stickers = true
                    })
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                local tarot = SMODS.create_card({
                    set = 'Tarot',
                    area = G.consumeables,
                    key = 'c_star',
                })
                tarot:add_to_deck()
                G.consumeables:emplace(tarot)
                return true
            end
        }))
    end,
})

if not not next(SMODS.find_mod("CardSleeves")) then
    CardSleeves.Sleeve({
        key = "diamondsleeve",
        name = "Sleeve of the Diamond",
        atlas = "sleeves",
        pos = { x = 1, y = 1 },
        config = {},
        unlocked = false,
        check_for_unlock = function(self, args)
            if not (G and G.GAME) then return end
            if self.get_current_deck_key() ~= "b_minty_diamonds" then return end
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
                    localize { type = "name_text", set = "Back", key = "b_minty_diamonds" },
                    localize { type = "name_text", set = "Stake", key = stake_key },
                    colours = { colours }
                }
            }
        end,
        loc_vars = function(self)
            MINTY.sleeveunlockcheck()
            local key, vars

            if self.get_current_deck_key() ~= "b_minty_diamonds" then
                key = self.key
            else
                if not not next(SMODS.find_mod("FusionJokers")) then
                    key = self.key .. "_fusionalt"
                else
                    key = self.key .. "_alt"
                end
            end

            return { key = key, vars = vars }
        end,
        apply = function(self)
            if self.get_current_deck_key() ~= "b_minty_diamonds" then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = SMODS.create_card({
                            set = 'Joker',
                            area = G.jokers,
                            key = 'j_greedy_joker',
                            stickers = { 'eternal' },
                            force_stickers = true
                        })
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        local tarot = SMODS.create_card({
                            set = 'Tarot',
                            area = G.consumeables,
                            key = 'c_star',
                        })
                        tarot:add_to_deck()
                        G.consumeables:emplace(tarot)
                        return true
                    end
                }))
            elseif not not next(SMODS.find_mod("FusionJokers")) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = SMODS.create_card({
                            set = 'Joker',
                            area = G.jokers,
                            key = 'j_fuse_diamond_bard',
                            stickers = { 'eternal' },
                            force_stickers = true
                        })
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = SMODS.create_card({
                            set = 'Joker',
                            area = G.jokers,
                            key = 'j_rough_gem',
                            stickers = { 'eternal' },
                            force_stickers = true
                        })
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        return true
                    end
                }))
            end
        end,
    })
end
