local cry = next(SMODS.find_mod("Cryptid"))

SMODS.Joker {
    key = "catpicmachine",
    name = "ilo pi sitelen soweli",
    atlas = 'jokerdoodles',
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"tag_cry_cat",
		},
	},
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 3
    },
    rarity = 2,
    cost = 11,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            modnumber = 3,
            mainnumber = math.sqrt(3),
            madnumber = math.sqrt(3),
            reps = 0
        }
    },
    attributes = {
        "mult", "xmult", "emult", "hypermult"
    },
    loc_vars = function(self, info_queue, card)
        if not finity or crossover then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Mod", "Cryptid" } }
        end
        local key = self.key
        local gameset = cry and Cryptid.gameset(self) or "mainline"
        key = key.."_"..gameset
        local main_end = MINTY.flavorize(key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.modnumber,
                card.ability.extra.mainnumber,
                card.ability.extra.madnumber,
            }
        }
    end,
    in_pool = function()
        if not cry then return false end
        if (not G.GAME) or (#G.GAME.tags == 0) then return false end
        if next(SMODS.find_card("j_cry_energia")) and next(SMODS.find_card("j_cry_kittyprinter")) then --little too powerful a combo, so I'm making it slightly inconvenient to assemble :p
            return false
        end
        for meow = 1, #G.GAME.tags do
            if G.GAME.tags[meow].key == "tag_cry_cat" then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if not cry then return end --Don't crash if a player cheats this into play without Cryptid active
        if ((context.joker_main and context.scoring_hand) or context.forcetrigger) and #G.GAME.tags ~= 0 then
            --MINTY.say("score time", "TRACE")
            local gameset = Cryptid.gameset(self)
            local number = 3
            if gameset == "modest" then
                number = card.ability.extra.modnumber
            elseif gameset == "mainline" then
                number = card.ability.extra.mainnumber
            elseif gameset == "madness" then
                number = card.ability.extra.madnumber
            end
            local result = {}
            local l1, l2, l3, l4, l5, reps = 0, 0, 0, 0, 0, 0
            card.ability.extra.reps = 0
            --MINTY.say("card.ability.extra.reps == "..card.ability.extra.reps, "TRACE")
            --count cat tags and their level
                for meow = 1, #G.GAME.tags do
                    --MINTY.say("Tag #"..meow..":"..G.GAME.tags[meow].key, "TRACE")
                    if G.GAME.tags[meow].key == "tag_cry_cat" then
                        local level = G.GAME.tags[meow].ability.level or 1
                        --MINTY.say("kity found :3; level is "..level, "TRACE")
                        if gameset == "modest" then
                            return {
                                xmult = number
                            }
                        elseif gameset == "mainline" then
                            card.ability.extra.reps = card.ability.extra.reps + (2^(level-1))
                            --MINTY.say("card.ability.extra.reps == "..card.ability.extra.reps, "TRACE")
                        elseif gameset == "madness" then
                            if level == 1 then l1 = l1 + 1
                            elseif level == 2 or level == 3 then l2 = l2 + (level - 1)
                            elseif level == 4 or level == 5 then l3 = l3 + (level - 3)
                            elseif level == 6 or level == 7 then l4 = l4 + (level - 5)
                            elseif level == 8 or level == 9 then l5 = l5 + (level - 7)
                            elseif level >= 10 then
                                l5 = l5 + 1
                                reps = reps + (2^(level-10)) -- l10 == 2^0 == 1, l11 == 2^1 == 2, l12 == 2^2 == 4, etc
                            end
                        end
                    end
                end
            if gameset == "mainline" then
                result = {
                    xmult = number
                }
                card.ability.extra.reps = card.ability.extra.reps - 1
            elseif gameset == "madness" then
                local levels = {l1, l2, l3, l4, l5}
                local keys = {"mult", "xmult", "emult", "eemult", "eeemult"}
                for i, level in ipairs(levels) do
                    if level ~= 0 then
                        result[keys[i]] = number * level
                    end
                end
                card.ability.extra.reps = reps
            end

            return result
        end

        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card and card.ability.extra.reps >= 1 then
            local reps = card.ability.extra.reps
            card.ability.extra.reps = 0
            --MINTY.say("card.ability.extra.reps == "..card.ability.extra.reps.."; local reps == "..reps, "TRACE")
            return {
                repetitions = reps,
                card = card,
            }
        end
    end
}