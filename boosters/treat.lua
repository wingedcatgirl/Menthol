SMODS.Booster{
    key = "treat_normal_1",
    group_key = "k_minty_treat_packs",
    kind = "minty_treat",
    atlas = "boosters",
    pos = {
        x = 1,
        y = 2,
    },
    config = {
        extra = 2,
        choose = 1
    },
    attributes = {"minty_treat"},
    in_pool = function (self, args)
        return false
    end,
    create_card = function (self, card, i)
        return {
            set = "minty_treat",
            key_append = "minty_treat_pack",
            soulable = true,
            skip_materialize = true
        }
    end
}