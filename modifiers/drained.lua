SMODS.Shader{
    key = "drained",
    path = "drained.fs"
}

SMODS.Edition{
    key = "drained",
    shader = "drained",
    atlas = "fake3",
    sound = {sound = "minty_drain4", vol = 0.6},
    pos = {
        x = 0,
        y = 0
    },
    unlocked = true,
    discovered = true,
    no_suit = true,
    weight = 0,
    in_pool = function (self, args)
        return false
    end,
    calculate = function (self, card, context)
        if context.attempted_suit_change and context.card == card then
            card:set_edition()
        end
    end
}