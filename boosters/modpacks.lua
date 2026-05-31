local function poll_mod(args)
    args = args or {}
    if not MINTY.mod_pool then
        MINTY.mod_pool = {}
        local mod_counter = {}
        local mod_pool = {}
        for k, center in pairs(G.P_CENTERS) do
            local normal = { --Can't find an elegant way to distinguish between rarities that can or can't ever spawn naturally, so
                [1] = true,
                [2] = true,
                [3] = true,
            }
            if center.original_mod and center.set == "Joker" and normal[center.rarity] then
                if not mod_counter[center.original_mod.id] then
                    mod_counter[center.original_mod.id] = {
                        id = center.original_mod.id,
                        key = center.original_mod.id,
                        name = center.original_mod.name,
                        shortname = center.original_mod.display_name,
                        colour = center.original_mod.badge_colour,
                        count = 1
                    }
                else
                    mod_counter[center.original_mod.id].count = mod_counter[center.original_mod.id].count + 1
                end
            end
        end
        for k, v in pairs(mod_counter) do
            v.weight = 10 * math.ceil(math.log(v.count, 7))
            MINTY.mod_pool[v.key] = v
        end
    end

    if args.init then return end

    local current_counts = {}
    for k, center in pairs(G.P_CENTERS) do
        if center.original_mod and center.set == "Joker" and SMODS.add_to_pool(center, { source = args.card_seed or "minty_mod_pack" }) then
            current_counts[center.original_mod.id] = (current_counts[center.original_mod.id] or 0) + 1
        end
    end

    local mod_pool = {}
    for k, v in pairs(MINTY.mod_pool) do
        if (args.min or 0) < current_counts[v.id] then
            v.weight = 10 * math.ceil(math.log(current_counts[v.id], 7))
            mod_pool[#mod_pool + 1] = v
        end
    end

    MINTY.modcount = #mod_pool

    if args.count_only then return end

    local modkey = SMODS.poll_object {
        pool = mod_pool,
        force_weight = true,
        print = args.print,
        seed = args.seed or "minty_modpack_gen"
    }

    return MINTY.mod_pool[modkey]
end

MINTY.poll_mod = poll_mod

local function create_modded_card(self, card, i)
    local key = SMODS.poll_object {
        type = "Joker",
        seed = "minty_mod_pack",
        filter = function(pool)
            local newpool = {}
            for _, item in ipairs(pool) do
                local center = G.P_CENTERS[item.key]
                if center and item.type == "Joker" and center.original_mod and center.original_mod.id == card.ability.mod.id then
                    newpool[#newpool + 1] = item
                end
            end
            return newpool
        end
    }

    return {
        set = "Joker",
        key = key,
        skip_materialize = true
    }
end

local function modpack_in_pool(self, args)
    MINTY.poll_mod { count_only = true }
    return (#MINTY.modcount or 0) > 3
end

local function set_modpack_ability(self, card, initial, delay_sprites)
    if (card.ability.mod.shortname == localize("k_mod_singular") or card.ability.mod.shortname == "ERROR") then
        card.ability.mod = poll_mod { min = self.config.extra }
    end
end

local function modpack_loc_vars(self, info_queue, card)
    local mod = card.ability.mod
    if MINTY.in_collection(card) then
        mod = {
            shortname = localize("k_mod_singular"),
            name = localize("k_minty_random_mod"),
            colour = G.C.FILTER
        }
    end
    local key = self.key:gsub("_[12]$", "")
    return {
        key = key,
        vars = {
            mod.shortname,
            mod.name,
            card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0),
            card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0),
            colours = {
                mod.colour
            }
        }
    }
end

SMODS.Booster {
    key = "mod_normal_1",
    kind = "mod_packs",
    group_key = "k_minty_mod_packs",
    atlas = "boosters",
    pos = {
        x = 0,
        y = 1,
    },
    config = {
        extra = 2,
        choose = 1,
        mod = {
            shortname = localize("k_mod_singular"),
            name = localize("k_minty_random_mod"),
        }
    },
    cost = 5,
    weight = 1,
    set_ability = set_modpack_ability,
    loc_vars = modpack_loc_vars,
    in_pool = modpack_in_pool,
    create_card = create_modded_card
}

SMODS.Booster {
    key = "mod_normal_2",
    kind = "mod_packs",
    group_key = "k_minty_mod_packs",
    atlas = "boosters",
    pos = {
        x = 1,
        y = 1,
    },
    config = {
        extra = 2,
        choose = 1,
        mod = {
            shortname = localize("k_mod_singular"),
            name = localize("k_minty_random_mod"),
        }
    },
    cost = 5,
    weight = 1,
    set_ability = set_modpack_ability,
    loc_vars = modpack_loc_vars,
    in_pool = modpack_in_pool,
    create_card = create_modded_card
}

SMODS.Booster {
    key = "mod_jumbo",
    kind = "mod_packs",
    group_key = "k_minty_mod_packs",
    atlas = "boosters",
    pos = {
        x = 2,
        y = 1,
    },
    config = {
        extra = 4,
        choose = 1,
        mod = {
            shortname = localize("k_mod_singular"),
            name = localize("k_minty_random_mod"),
        }
    },
    cost = 7,
    weight = 0.5,
    set_ability = set_modpack_ability,
    loc_vars = modpack_loc_vars,
    in_pool = modpack_in_pool,
    create_card = create_modded_card
}

SMODS.Booster {
    key = "mod_mega",
    kind = "mod_packs",
    group_key = "k_minty_mod_packs",
    atlas = "boosters",
    pos = {
        x = 3,
        y = 1,
    },
    config = {
        extra = 4,
        choose = 2,
        mod = {
            shortname = localize("k_mod_singular"),
            name = localize("k_minty_random_mod"),
        }
    },
    cost = 9,
    weight = 0.125,
    set_ability = set_modpack_ability,
    loc_vars = modpack_loc_vars,
    in_pool = modpack_in_pool,
    create_card = create_modded_card
}
