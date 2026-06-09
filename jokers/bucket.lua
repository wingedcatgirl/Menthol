SMODS.Joker {
    key = "bucket",
    name = "Bucket of Cement",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 3,
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
    config = {},
    attributes = {
        "minty_rocks", "enhancements", "modify_card"
    },
	loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        info_queue[#info_queue+1] = MINTY.enhancement_list(MINTY.rocks, "rock")
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
            for i = 1,#context.scoring_hand do
                if context.scoring_hand[i].ability.set ~= "Enhanced" then
                    local enh = SMODS.poll_enhancement({options = MINTY.rockbag, key = "minty_bucket", guaranteed = true})
                    MINTY.say(enh, "TRACE")
                    context.scoring_hand[i]:set_ability(G.P_CENTERS[enh], nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.scoring_hand[i]:juice_up()
                            return true
                        end
                    }))
                end
            end
        end
    end
}