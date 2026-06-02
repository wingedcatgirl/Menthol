local vanilla_languages = {
    ["en-us"] = true,
    de = true,
    es_419 = true,
    es_ES = true,
    fr = true,
    id = true,
    it = true,
    ja = true,
    ko = true,
    nl = true,
    pl = true,
    pt_BR = true,
    ru = true,
    zh_CN = true,
    zh_TW = true, --15
}

SMODS.Back{
    key = "linguistic",
    loc_vars = function (self, info_queue, back)
        return {
            vars = {
                localize{type = 'name_text', set = 'Joker', key = 'j_minty_languageEgg'},
                localize{type = 'name_text', set = 'Joker', key = 'j_egg'},
            }
        }
    end,
    unlocked = false,
    locked_loc_vars = function (self, info_queue, back)
        local key = self.key
        
        if not G.P_CENTERS.j_minty_languageEgg.unlocked then
            key = "b_minty_hidden_deck"
        end
        return {
            key = key,
            vars = {
                localize{type = 'name_text', set = 'Joker', key = 'j_minty_languageEgg'},
                self.unlock_condition.languages,
            }
        }
    end,
    unlock_condition = {
        languages = 8
    },
    check_for_unlock = function (self, args)
        if args and args.type == "win_custom" then
            if next(SMODS.find_card("j_minty_languageEgg", true)) and G.GAME.languageEgg then
                local count = 0
                for lang in pairs(G.GAME.languageEgg) do
                    if not vanilla_languages[lang] then return true end
                    count = count + 1
                end

                if count > self.unlock_condition.languages then return true end
            end
        end
    end,
    apply = function (self, back)
        MINTY.event(function ()
            if not G.jokers then return false end

            local langegg = SMODS.add_card{
                key = "j_minty_languageEgg"
            }
            local egg = SMODS.add_card{
                key = "j_egg",
                edition = "e_negative"
            }

            langegg.ability.extra.mult = langegg.ability.extra.mult/2
            egg.ability.extra = egg.ability.extra/2

            return true
        end)
    end,
}
        --Dummied out til I decide what the combo will do
if not (false and next(SMODS.find_mod("CardSleeves"))) then return end

CardSleeves.Sleeve{
    key = "linguistic",
    loc_vars = function (self, info_queue, sleeve)
        MINTY.sleeveunlockcheck()
        local key

        if self.get_current_deck_key() ~= "b_minty_linguistic" then
            key = self.key
        else
            key = self.key.."_alt"
        end

        return {
            key = key,
            vars = {
                localize{type = 'name_text', set = 'Joker', key = 'j_minty_languageEgg'},
                localize{type = 'name_text', set = 'Joker', key = 'j_egg'},
            }
        }
    end,
    unlocked = false,
    locked_loc_vars = function (self, info_queue, sleeve)
        local key = self.key
        
        if not G.P_CENTERS.j_minty_languageEgg.unlocked then
            key = "b_minty_hidden_deck"
        end
        return {
            key = key,
            vars = {
                localize{type = 'name_text', set = 'Joker', key = 'j_minty_languageEgg'},
                self.unlock_condition.languages,
            }
        }
    end,
    check_for_unlock = function (self, args)
        if not (G and G.GAME) then return end
        if self.get_current_deck_key() ~= "b_minty_linguistic" then return end
        local skey = MINTY.sleeveunlockcheck()
        if args and args.type == 'win_custom' and MINTY.at_least_stake(G.GAME.stake, skey) then
            G.PROFILES[G.SETTINGS.profile].mintysleeves[self.key] = skey
            --unlock_card(self)
            return true
        end
    end,
    apply = function (self, back)
        MINTY.event(function ()
            if not G.jokers then return false end

            local langegg = SMODS.add_card{
                key = "j_minty_languageEgg"
            }
            local egg = SMODS.add_card{
                key = "j_egg",
                edition = "e_negative"
            }

            langegg.ability.extra.mult = langegg.ability.extra.mult/2
            egg.ability.extra = egg.ability.extra/2

            return true
        end)
    end,
}