SMODS.Tag{
    key = "menu",
    atlas = "tags",
    pos = {
        x = 1,
        y = 0,
    },
    in_pool = function (self, args)
        return false
    end,
    loc_vars = function (self, info_queue, tag)
        info_queue[#info_queue+1] = G.P_CENTERS.p_minty_treat_normal_1
    end,
    apply = function (self, tag, context)
        if not (context and (context.type == "new_blind_choice" or context.type == "shop_start_once")) then return end
        local lock = tag.ID

        G.CONTROLLER.locks[lock] = true
        tag:yep("+", HEX("CA7CA7"), function()
            local key = 'p_minty_treat_normal_1'  --..(math.random(1,2))

            local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
            G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})

            --[[ Doing it this way causes it to appear in the wrong size and location, todo find a way around that?
            local card = SMODS.create_card{
                set = "Booster",
                key = key,
                bypass_discovery_center = true
            }
            --]]
            card.cost = 0
            card.from_tag = true
            G.FUNCS.use_card({config = {ref_table = card}})
            card:start_materialize()
            G.CONTROLLER.locks[lock] = nil
            return true
        end)
        tag.triggered = true
        return true
    end
}