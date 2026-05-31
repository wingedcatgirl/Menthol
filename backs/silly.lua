SMODS.Back {
    key = "sillylittledeck",
    pos = { x = 2, y = 0 },
    atlas = "backs",
    unlocked = true,
    config = {},
    apply = function(self, back)
        G.GAME.modifiers.mintyjokerboost = true
    end,
    calculate = function(self, back, context)
        if context.modify_weights then
            for i,item in ipairs(context.pool) do
                local center = G.P_CENTERS[center.key]
                if center.key:find('_minty_') or (center.pools and (center.pools.MintysSillyMod or center.pools.Menthol)) then
                    if (center.set and center.set.Joker) or center.key:find("j_minty_") then
                        item.weight = item.weight * 3
                    elseif G.GAME.modifiers.mintyallboost then
                        item.weight = item.weight * 2
                    end
                end
            end
        end
    end
}

if not not next(SMODS.find_mod("CardSleeves")) then
    CardSleeves.Sleeve({
        key = "sillylittlesleeve",
        name = "The Silliest, Littlest Sleeve",
        atlas = "sleeves",
        pos = { x = 1, y = 0 },
        config = {},
        unlocked = false,
        check_for_unlock = function(self, args)
            if not (G and G.GAME) then return end
            if self.get_current_deck_key() ~= "b_minty_sillylittledeck" then return end
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
                    localize { type = "name_text", set = "Back", key = "b_minty_sillylittledeck" },
                    localize { type = "name_text", set = "Stake", key = stake_key },
                    colours = { colours }
                }
            }
        end,
        loc_vars = function(self)
            MINTY.sleeveunlockcheck()
            local key, vars

            if self.get_current_deck_key() ~= "b_minty_sillylittledeck" then
                key = self.key
            else
                key = self.key .. "_alt"
            end

            return { key = key, vars = vars }
        end,
        apply = function()
            if self.get_current_deck_key() ~= "b_minty_sillylittledeck" then
                G.GAME.modifiers.mintyjokerboost = true
            else
                G.GAME.modifiers.mintyallboost = true
            end
        end,
        calculate = function (self, sleeve, context)
            --Sleeve only needs to do things if deck isn't active
            if not G.GAME.modifiers.mintyallboost then return end

            if context.modify_weights then
                for i,item in ipairs(context.pool) do
                    local center = G.P_CENTERS[center.key]
                    if center.key:find('_minty_') or (center.pools and (center.pools.MintysSillyMod or center.pools.Menthol)) then
                        if (center.set and center.set.Joker) or center.key:find("j_minty_") then
                            item.weight = item.weight * 3
                        end
                    end
                end
            end
        end
    })
end
