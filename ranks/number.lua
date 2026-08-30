function MINTY.build_number_rank()
    local suitmap = { --Uncomment these as the art gets arted
        Hearts = 1,
        Clubs = 2,
        Diamonds = 3,
        Spades = 4,
        minty_3s = 5,
        --bunc_halberds = 6,
        --bunc_fleurons = 7,
        --paperback_Crowns = 8,
        --paperback_Stars = 9,
        --six_moons = 10,
        --six_stars = 11,
        --Fallback = 0
    }

    if SMODS.Suits then
        for k,v in pairs(SMODS.Suits) do
            if not suitmap[k] and not v.minty_numberrank then
                suitmap[k] = 0
            end
        end
    end

    local all_numbers = { }

    if SMODS.Ranks then
        for k,v in pairs(SMODS.Ranks) do
            if not v.face and k ~= "Ace" then
                table.insert(all_numbers, k)
            end
        end
    end

    MINTY.number_rank_all_numbers = all_numbers
    MINTY.number_rank_suitmap = suitmap
end

SMODS.Rank{
    key = "number",
    card_key = "N",
    pos = {x = 0},
    nominal = 15,
    face_nominal = -14.1, --To make it sort below 2 
    number = true,
    lc_atlas = "numberrank",
    hc_atlas = "numberrank",
    shorthand = "N",
    next = MINTY.number_rank_all_numbers,
    strength_effect = { random = true },
    in_pool = function (self, args)
        if args and args.initial_deck then
            return args.start_with_numbers
        end
        if args and args.abacus then
            return true
        end
        return MINTY.find_rank("minty_number")
    end,
    suit_map = MINTY.number_rank_suitmap,
    loc_vars = function (self, info_queue, card)
        local suit = card.base.suit
        local key = "minty_placeholder"
        if self.suit_map[suit] == 0 then
            key = key.."_ex"
        end
        info_queue[#info_queue+1] = {
            set = "Other",
            key = key,
        }
    end
}

if AKYRS_CROSSMOD then
    AKYRS_CROSSMOD.rank_to_atlas_map["minty_number"] = {
        "minty_purenumber", {x=0, y=0}
    }
end