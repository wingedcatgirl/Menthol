local debuginfo = SMODS.current_mod.debug_info

--Math! \o/
local function gcd(a, b)
    while b ~= 0 do
        a, b = b, a % b
    end
    return math.abs(a)
end
local function lcm(a, b)
    return math.floor(math.abs(a * b) / gcd(a, b))
end
-- convert float → rational approximation
local function to_rational(x)
    -- high resolution denominator
    local max_den = 10000

    local num = math.floor(x * max_den + 0.5)
    local den = max_den

    local g = gcd(num, den)
    return num / g, den / g
end

local function select_from_every_card(self, card, pack)
    local predefs = {
        Joker = 'jokers',
        Base = false,
        Default = false,
        ["Default Base"] = false, --Why do regular playing cards have three names.
        Enhanced = false,
        Tarot = 'consumeables',
        Spectral = 'consumeables',
        Planet = 'consumeables',
        Voucher = false,
        --minty_treat = false
    }
    local center = card.config.center

    if center.hidden then return nil end --No Perkeo-ing your SOULs or Ultimate Delicacies :v

    local can_use = false
    if (card.use and (not center.can_use or center:can_use(card))) then can_use = true end

    local set = card.ability.set or center.set
    if predefs[set] ~= nil then return predefs[set], can_use end

    return "consumeables", can_use --Last guess if they didn't specify it in the card nor consumeable type
end

local function create_every_card (self, card, i)
    local set
    local sets = {}
    local ctype_buffer = copy_table(SMODS.ConsumableType.ctype_buffer)
    ctype_buffer[#ctype_buffer+1] = "Joker"         --These aren't consumeables but we're putting them in the pool
    ctype_buffer[#ctype_buffer+1] = "Playing Card"  --cause it's a Pack of _Every_ Card
    ctype_buffer[#ctype_buffer+1] = "Voucher"
                                                    --TODO maybe reinvent polterjen's tokens so you can also get tags :v

    local baseweight = 2
    local denominators = {}
    local rates = {}
    for _,v in ipairs(ctype_buffer) do
        local rate = G.GAME[v:lower() .. "_rate"] or 0
        if rate == 0 then --Pack of EVERY Card!
            if v == "Playing Card" then rate = G.P_CENTERS.v_magic_trick.config.extra --aka 4
            else rate = 0.5 end
        end
        if v == "Joker" then rate = rate*0.25 end --They're already super common :v
        if v == "Voucher" then rate = 1 end -- 1/4 as common as planets/tarots, seems fine?
        rates[v] = rate
        local _, den = to_rational(rate)
        table.insert(denominators, den)
    end
    for _, den in ipairs(denominators) do
        baseweight = lcm(baseweight, den)
    end

    for _,v in ipairs(ctype_buffer) do
        local modrate = rates[v] * baseweight
        if modrate ~= math.floor(modrate) then
            MINTY.say("argh, no, the mathematics... (somehow failed to normalize consumeable "..v.."'s appearance rate of "..rates[v]..")", "WARN ")
            modrate = math.max(math.floor(modrate), 1)
        end
        for __=1,modrate do
            sets[#sets+1] = v
        end
    end
    set = pseudorandom_element(sets, "minty_pack_of_every_card_set")

    return {
        set = set,
        area = G.pack_cards,
        soulable = true,
        skip_materialize = true,
        key_append = "minty_pack_of_every_card_card"
    }
end

local function every_card_loc_vars(self, info_queue, card)
    local key = self.key:gsub("_[12]$", "")
    return {
        key = key,
        vars = {
            card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0),
            card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0),
        }
    }
end

SMODS.Booster{
    key = "everycard_normal_1",
    group_key = "k_minty_everycard_packs",
    kind = "minty_everycard",
    atlas = "boosters",
    pos = {
        x = 0,
        y = 0,
    },
    config = {
        extra = 5,
        choose = 1,
    },
    loc_vars = every_card_loc_vars,
    cost = 10,
    weight = 2,
    draw_hand = true,
    select_card = select_from_every_card,
    create_card = create_every_card
}

SMODS.Booster{
    key = "everycard_normal_2",
    group_key = "k_minty_everycard_packs",
    kind = "minty_everycard",
    atlas = "boosters",
    pos = {
        x = 1,
        y = 0,
    },
    config = {
        extra = 5,
        choose = 1,
    },
    loc_vars = every_card_loc_vars,
    cost = 10,
    weight = 2,
    draw_hand = true,
    select_card = select_from_every_card,
    create_card = create_every_card
}

SMODS.Booster{
    key = "everycard_jumbo",
    group_key = "k_minty_everycard_packs",
    kind = "minty_everycard",
    atlas = "boosters",
    pos = {
        x = 2,
        y = 0,
    },
    config = {
        extra = 7,
        choose = 1,
    },
    loc_vars = every_card_loc_vars,
    cost = 13,
    weight = 1,
    draw_hand = true,
    select_card = select_from_every_card,
    create_card = create_every_card
}

SMODS.Booster{
    key = "everycard_mega",
    group_key = "k_minty_everycard_packs",
    kind = "minty_everycard",
    atlas = "boosters",
    pos = {
        x = 3,
        y = 0,
    },
    config = {
        extra = 7,
        choose = 2,
    },
    loc_vars = every_card_loc_vars,
    cost = 16,
    weight = 0.5,
    draw_hand = true,
    select_card = select_from_every_card,
    create_card = create_every_card
}