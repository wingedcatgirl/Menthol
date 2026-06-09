if not SMODS.current_mod.optional_features.quantum_enhancements then return end

local function enhancement_list(table)
  local key = 'minty_compressed_enhancements'
    local text = {}
    local text_parsed = {}

    for k,_ in pairs(table) do
        text[#text+1] = localize{type = 'name_text', set = 'Enhanced', key = k}
    end

    for _, v in ipairs(text) do
      text_parsed[#text_parsed + 1] = loc_parse_string(v)
    end

    G.localization.descriptions.Other[key].text = text
    G.localization.descriptions.Other[key].text_parsed = text_parsed

  return {
    set = 'Other',
    key = key,
  }
end

local function copy_table(t)
    local out = {}
    for k,v in pairs(t) do
        out[k] = v
    end
    return out
end

SMODS.Joker {
    key = "manacompressor",
    name = "Mana Compressor",
    pronouns = "it_its",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 3,
        y = 0
    },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            eaten = {

            },
            count = 0,
            current = "m_bonus",
            hungry = true
        }
    },
    attributes = {
        "enhancements", "modify_card"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        if next(card.ability.extra.eaten) then
            info_queue[#info_queue+1] = enhancement_list(card.ability.extra.eaten)
        end
        return {
            key = key,
            main_end = main_end,
            vars = {
                localize{type = 'name_text', set = 'Enhanced', key = card.ability.extra.current}
            }
        }
    end,
    in_pool = function (self, args)
        return SMODS.optional_features.quantum_enhancements
    end,
    set_ability = function (self, card, initial, delay_sprites)
        if MINTY.in_collection(card) then return end
        card.ability.extra.current = SMODS.poll_enhancement{guaranteed = true}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not (context.individual or context.repetition or context.retrigger_joker_check or context.retrigger_joker) then
            card.ability.extra.current = SMODS.poll_enhancement{guaranteed = true}
            local retries = 0
            if card.ability.extra.eaten[card.ability.extra.current] or not MINTY.find_enhancement(card.ability.extra.current) then
                retries = card.ability.extra.count or 0 --Get some retries if it's already eaten or you don't have it
            end
            while retries > 0 and (card.ability.extra.eaten[card.ability.extra.current] or not MINTY.find_enhancement(card.ability.extra.current)) do
                --Retry until it's new and you own it, or you run out of retries
                card.ability.extra.current = SMODS.poll_enhancement{guaranteed = true}
                retries = retries - 1
            end
            card.ability.extra.hungry = true
            return {
                message = localize("k_reset")
            }
        end

        if context.individual and context.cardarea == G.play and not context.end_of_round and card.ability.extra.hungry and (context.other_card.config.center.key == card.ability.extra.current) then
            context.other_card:set_ability(G.P_CENTERS.c_base, nil, true)
            if not card.ability.extra.eaten[card.ability.extra.current] then card.ability.extra.count = (card.ability.extra.count or 0) + 1 end
            card.ability.extra.eaten[card.ability.extra.current] = true
            card.ability.extra.hungry = false
            return {
                message = localize('k_minty_nommed'),
            }
        end

        if context.check_enhancement and next(card.ability.extra.eaten) then
            local enh = context.other_card.config.center.key
            if card.ability.extra.eaten[enh] then
                return copy_table(card.ability.extra.eaten)
            end
        end
    end
}