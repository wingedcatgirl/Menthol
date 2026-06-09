SMODS.Joker {
    key = "inkbleed",
    name = "Inkbleed",
    atlas = 'jokers',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    cost = 7,
    unlocked = false,
    locked_loc_vars = function (self, info_queue, card)
        local count = 0
        for k,v in pairs(SMODS.Mods) do
            if k ~= "Balatro" and k ~= "Steamodded" and k ~= "Lovely" and v.can_load then
                count = count+1
            end
        end
        return {
            vars = {
                self.unlock_condition.count,
                count
            }
        }
    end,
    unlock_condition = {
        count = 30
    },
    check_for_unlock = function (self, args)
        local count = 0
        for k,v in pairs(SMODS.Mods) do
            if k ~= "Balatro" and k ~= "Steamodded" and k ~= "Lovely" and v.can_load then
                count = count+1
            end
        end
        if count >= self.unlock_condition.count then
            unlock_card(self)
            return true
        end
    end,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
        }
    },
    attributes = {
        "enhancements", "meta"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if not SMODS.optional_features.quantum_enhancements then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Feature", "Quantum Enhancements" } }
        elseif not next(MINTY.inkbleedtable) then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Enhancements", "to have some name overlap" } }
        end
        --TODO: Infoqueue a list of enhancements with name overlap?
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
            }
        }
    end,
    in_pool = function (self, args) --Only if we actually *have* name collisions
        return SMODS.optional_features.quantum_enhancements and not not next(MINTY.inkbleedtable)
    end,
    calculate = function(self, card, context)
        local function copy_table(t)
            local out = {}
            for k,v in pairs(t) do
                out[k] = v
            end
            return out
        end

        if context.check_enhancement then
            local enh = context.other_card.config.center.key
            --MINTY.say("Enhancement is "..enh)
            if enh == "c_base" then return end
            if MINTY.inkbleedtable and MINTY.inkbleedtable[enh] and next(MINTY.inkbleedtable[enh]) then
                --MINTY.say(enh.." has name overlap")
                return copy_table(MINTY.inkbleedtable[enh])
            end
        end
    end
}