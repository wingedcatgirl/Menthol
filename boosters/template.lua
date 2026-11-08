SMODS.Booster{
    key = "template",
    kind = "minty_template",
    group_key = "template_packs",
    atlas = "boosters",
    pos = {
        x = 0,
        y = 2,
    },
    config = {
        extra = 5,
        choose = 1
    },
    attributes = {
        
    },
    in_pool = function (self, args)
        return false
    end,
    create_card = function (self, card, i)
        return {
            set = set,
            key_append = "minty_template_pack",
            skip_materialize = true
        }
    end
}