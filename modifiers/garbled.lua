local mf = SMODS.find_mod("MoreFluff")[1]

local slowdown = 0
local this_card
local string = "+"
local characters = {
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
    "?", "!", "<", ">", "&", "%", "$", "@", "*", "/", "{", "}"
}
local text = {
    text = string
}

SMODS.Enhancement({
    key = "garbled",
    name = "Garbled Card",
    atlas = "enhance",
    set = "Enhanced",
    pos = {
        x = 1,
        y = 0
    },
	object_type = "Enhancement",
	badge_colour = HEX("a3ecc0"), --Magic Mint, according to internet
    config = {
        extra = {
            min = 0,
            max = 23,
            gymboost = "mult"
        },
    },
    valk_hand_buff = {
        title = "fB*&@@Pe%$3%%", --todo, dynatext this misprint style?
        colour = SMODS.Gradients.minty_garbled_handbuff,
        scoring_func = function (power)
            local mult = pseudorandom(pseudoseed("minty_garbled_handbuff"), power, power * 100)

            return {
                mult = mult
            }
        end
    },
    update = function (self, card, dt)
        if this_card ~= card.unique_val then return end
        slowdown = slowdown + 1
        if slowdown > math.random(5, 9) then
            slowdown = 0
            string = "+"
            for i=1,math.random(5,11) do
                local char = characters[math.random(#characters)]
                if math.random(3) == 3 then
                    local mult = {"m", "u", "l", "t"}
                    char = mult[math.random(4)]
                end
                if math.random(2) == 2 then
                    char = char:upper()
                end
                string = string..char
            end
            text.text = string
        end
    end,
    loc_vars = function(self, info_queue, card)
        this_card = card.unique_val
        local main_start = {
            { n = G.UIT.T, config = { ref_table = text, ref_value = "text", colour = G.C.RED, scale = 0.32 } },
        }

        return {
            main_start = main_start
        }
    end,
    get_weight = function (self)
        local default = 10
        return mf and default or default/2
    end,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    calculate = function (self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            local mult = pseudorandom("minty_garbled", card.ability.extra.min, card.ability.extra.max)

            if mult > 0 then
                return {
                    mult = mult
                }
            end
        end
    end,
})