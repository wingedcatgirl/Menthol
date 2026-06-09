local cryptid = next(SMODS.find_mod("Cryptid"))

SMODS.Joker {
    key = "copycat",
    name = "Copy Cat",
    pronouns = "mirror",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 4,
        y = 4
    },
    rarity = 2,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["kity"] = true
    },
    config = {
        immutable = {
            targetname = "None",
            targetkey = "",
            targetid = 0,
            targetcard = {}
        }
    },
    attributes = {
        "copying", "kity"
    },
    loc_vars = function(self, info_queue, card)
        if MINTY.in_collection(card) and cryptid then
            if not MINTY.config.dev_mode then
                info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Disabling Mod", "Cryptid" } }
            else
                info_queue[#info_queue+1] = { set = "Other", key = "minty_dev_warning", specific_vars = { "Mod", "Cryptid" } }
            end
        end
        if next(SMODS.find_mod("cardpronouns")) then
            local mirrorkey = "minty_mirror"..(MINTY.config.flavor_text and "_flavor" or "")
            info_queue[#info_queue+1] = { set = "Other", key = mirrorkey, specific_vars = { localize{type = "name_text", set = "Joker", key = self.key } } }
        end
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        local target
        if card.ability.immutable.targetkey ~= "" then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].unique_val == card.ability.immutable.targetid then
                    target = G.jokers.cards[i]
                end
            end
        end
        if target then
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.immutable.targetkey]
            card.ability.immutable.targetname = localize{type = "name_text", set = "Joker", key = card.ability.immutable.targetkey}
        else
            card.ability.immutable.targetname = "None"
        end
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.immutable.targetname
            }
        }
    end,
    --[[]]
    in_pool = function (self, args) ----Crashes a bunch with Cryptid fsr 👍️
        return not (cryptid and not MINTY.config.dev_mode)
    end,
    --]]
    calculate = function(self, card, context)
        if context.forcetrigger and next(card.ability.immutable.targetcard) and card.ability.immutable.targetcard.config.center.demicoloncompat then
            MINTY.say("Calculating force-triggered blueprint effect of "..card.ability.immutable.targetname.." copied by Copy Cat", "TRACE")
            local ret = SMODS.blueprint_effect(card, target, context)
            if ret then return ret end
        end

        if context.ending_shop and context.cardarea == G.jokers and not context.blueprint then
            --go through jokers, pick a random bp-compatible one, put its unique id in targetid
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i] ~= card) and G.jokers.cards[i].config.center.blueprint_compat then
                    --MINTY.say("Found a compatible Joker")
                    jokers[#jokers+1] = G.jokers.cards[i]
                end
            end
            if not next(jokers) then return end
            local target = pseudorandom_element(jokers, pseudoseed("copycat"))
            --MINTY.say("attempting to copy")
            card.ability.immutable.targetcard = target
            card.ability.immutable.targetkey = target.config.center.key
            card.ability.immutable.targetid = target.unique_val
            card.ability.immutable.targetname = localize{type = "name_text", set = "Joker", key = card.ability.immutable.targetkey}
            --MINTY.say("Joker copied: "..card.ability.immutable.targetname)
            return {
                message = localize("k_copied_ex"),
                message_card = card,
            }
        end

        if context.selling_card and (context.card.unique_val == card.ability.immutable.targetid) then
            card.ability.immutable = {
                targetname = "None",
                targetkey = "",
                targetcard = {},
                targetid = 0,
            }
            return {
                message = localize("k_minty_bye"),
                message_card = card,
            }
        end

        --MINTY.say("Considering calculation context")
        if card.ability.immutable.targetname == "None" then return end
        if context.no_blueprint then return end
        --MINTY.say("Calculation context allowed")
        local target
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].unique_val == card.ability.immutable.targetid then
                target = G.jokers.cards[i]
                break
            end
        end
        if target and target ~= card then
            --MINTY.say("Calculating blueprint effect of "..card.ability.immutable.targetname.." copied by Copy Cat", "TRACE")
            local ret = SMODS.blueprint_effect(card, target, context)
            if ret and next(ret) then return ret end
        end
    end
}