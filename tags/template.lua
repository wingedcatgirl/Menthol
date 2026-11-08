SMODS.Tag{
    key = "template",
    atlas = "tags",
    pos = {
        x = 5,
        y = 4,
    },
    in_pool = function (self, args)
        return false
    end,
    attributes = {

    },
    loc_vars = function (self, info_queue, tag)
        
    end,
    apply = function (self, tag, context)
        if not (context and context.type and false) then return end
        local lock = tag.ID

        G.CONTROLLER.locks[lock] = true
        tag:yep("+", HEX("CA7CA7"), function()
            
            G.CONTROLLER.locks[lock] = nil
            return true
        end)
        tag.triggered = true
        return true
    end
}