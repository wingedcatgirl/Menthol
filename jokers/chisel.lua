SMODS.Joker {
    key = "chisel",
    name = "Chisel",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 2
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        seal = {extra = {chips = 50}},
        stone = {extra = {chips = 50}}
    },
    attributes = {
        "minty_rocks", "enhancements", "seals", "modify_card"
    },
	loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
		info_queue[#info_queue+1] = MINTY.enhancement_list(MINTY.bag_to_map(SMODS.get_attribute_pool("minty_rock_card")), "rock")
		info_queue[#info_queue + 1] = { set = "Other", key = "minty_cement_seal", specific_vars = { self.config.seal.extra.chips } }
		return {
            key = key,
            main_end = main_end,
            vars = {
                localize{type = 'name_text', set = 'Other', key = "minty_stone_cards"}
            }
        }
	end,
    calculate = function(self, card, context)
        if context.before then
            for i,v in ipairs(context.scoring_hand) do
                if v:has_attribute("minty_rock_card") and not v.seal then
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    v:set_seal("minty_cement")
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
        end
    end
}