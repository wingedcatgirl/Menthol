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
            MINTY.event(function ()
                local key = 'p_minty_treat_normal_1'  --..(math.random(1,2))

                local card = SMODS.create_card{
                    set = "Booster",
                    key = key,
                    bypass_discovery_center = true,
                    scale = {
                        w = 1.27,
                        h = 1.27
                    },
                    area = G.play
                }
                
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            return true
        end)
        tag.triggered = true
        return true
    end
}