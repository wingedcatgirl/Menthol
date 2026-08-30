SMODS.Rank{
    key = "no",
    card_key = "X",
    --pos = {x = 0},
    nominal = 0,
    lc_atlas = "facerank",
    hc_atlas = "facerank",
    shorthand = "X",
    face = false,
    strength_effect = { random = true },
    in_pool = function (self, args)
        if args and args.initial_deck then
            return args.start_with_the_rank_named_no
        end
        if args and args.grin then
            return true
        end
        return MINTY.find_rank("no")
    end,
}
