SMODS.Back({
    name = "Deck of the Heart",
    key = "hearts",
    pos = { x = 0, y = 1 },
    atlas = "backs",
    unlocked = false,
    unlock_req = {
        "j_lusty_joker",
        "j_bloodstone",
        "c_sun",
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
        local heartsleeve = ((G.GAME.selected_sleeve or "sleeve_casl_none") == "sleeve_minty_heartsleeve")
        if not (sleeveexist and fusionexist and heartsleeve) then
            --sendDebugMessage('[Minty] Heart Deck creating Lusty')
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card = SMODS.create_card({
                        set = 'Joker',
                        area = G.jokers,
                        key = 'j_lusty_joker',
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
                    key = 'c_sun',
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
        key = "heartsleeve",
        name = "Sleeve of the Heart",
        atlas = "sleeves",
        pos = { x = 0, y = 1 },
        config = {},
        unlocked = false,
        check_for_unlock = function(self, args)
            if not (G and G.GAME) then return end
            if self.get_current_deck_key() ~= "b_minty_hearts" then return end
            local skey, scount = MINTY.sleeveunlockcheck()
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
                    localize { type = "name_text", set = "Back", key = "b_minty_hearts" },
                    localize { type = "name_text", set = "Stake", key = stake_key },
                    colours = { colours }
                }
            }
        end,
        loc_vars = function(self)
            MINTY.sleeveunlockcheck()
            local key, vars

            if self.get_current_deck_key() ~= "b_minty_hearts" then
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
            if self.get_current_deck_key() ~= "b_minty_hearts" then
                --sendDebugMessage('[Minty] Heart Sleeve creating Lusty')
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = SMODS.create_card({
                            set = 'Joker',
                            area = G.jokers,
                            key = 'j_lusty_joker',
                            stickers = { 'eternal' },
                            force_stickers = true
                        })
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        local tarot = SMODS.create_card({
                            set = 'Tarot',
                            area = G.consumeables,
                            key = 'c_sun',
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
                            key = 'j_fuse_heart_paladin',
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
                            key = 'j_bloodstone',
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
