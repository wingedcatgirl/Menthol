local function create_modded_card (self, card, i)
    local key = SMODS.poll_object{
        type = "Joker",
        seed = "minty_mod_pack",
        filter = function (pool)
            local newpool = {}
            for _,item in ipairs(pool) do
                local center = G.P_CENTERS[item.key]
                if center and item.type == "Joker" and center.original_mod and center.original_mod.id == card.ability.mod.id then
                    newpool[#newpool+1] = item
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

SMODS.Booster{
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
    set_ability = function (self, card, initial, delay_sprites)
        if (card.ability.mod.shortname == localize("k_mod_singular") or card.ability.mod.shortname == "ERROR") then
            local mod = {}
            while (mod.count or 0) < self.config.extra do
                local id = pseudorandom_element(MINTY.modbag, "minty_modpack_gen")
                mod = copy_table(MINTY.packable_mods[id])
            end

            card.ability.mod = mod
        end
    end,
    loc_vars = function (self, info_queue, card)
        local mod = card.ability.mod
        if MINTY.in_collection(card) then
            mod = {
                shortname = localize("k_mod_singular"),
                name = localize("k_minty_random_mod"),
                colour = G.C.FILTER
            }
        end
        return {
            key = "p_minty_mod_normal",
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
    end,
    in_pool = function (self, args)
        return true
    end,
    create_card = create_modded_card
}

SMODS.Booster{
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
    set_ability = function (self, card, initial, delay_sprites)
        if (card.ability.mod.shortname == localize("k_mod_singular") or card.ability.mod.shortname == "ERROR") then
            local mod = {}
            while (mod.count or 0) < self.config.extra do
                local id = pseudorandom_element(MINTY.modbag, "minty_modpack_gen")
                mod = copy_table(MINTY.packable_mods[id])
            end

            card.ability.mod = mod
        end
    end,
    loc_vars = function (self, info_queue, card)
        local mod = card.ability.mod
        if MINTY.in_collection(card) then
            mod = {
                shortname = localize("k_mod_singular"),
                name = localize("k_minty_random_mod"),
                colour = G.C.FILTER
            }
        end
        return {
            key = "p_minty_mod_normal",
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
    end,
    in_pool = function (self, args)
        return true
    end,
    create_card = create_modded_card
}

SMODS.Booster{
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
    set_ability = function (self, card, initial, delay_sprites)
        if (card.ability.mod.shortname == localize("k_mod_singular") or card.ability.mod.shortname == "ERROR") then
            local mod = {}
            while (mod.count or 0) < self.config.extra do
                local id = pseudorandom_element(MINTY.modbag, "minty_modpack_gen")
                mod = copy_table(MINTY.packable_mods[id])
            end

            card.ability.mod = mod
        end
    end,
    loc_vars = function (self, info_queue, card)
        local mod = card.ability.mod
        if MINTY.in_collection(card) then
            mod = {
                shortname = localize("k_mod_singular"),
                name = localize("k_minty_random_mod"),
                colour = G.C.FILTER
            }
        end
        return {
            key = "p_minty_mod_jumbo",
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
    end,
    in_pool = function (self, args)
        return true
    end,
    create_card = create_modded_card
}

SMODS.Booster{
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
    set_ability = function (self, card, initial, delay_sprites)
        if (card.ability.mod.shortname == localize("k_mod_singular") or card.ability.mod.shortname == "ERROR") then
            local mod = {}
            while (mod.count or 0) < self.config.extra do
                local id = pseudorandom_element(MINTY.modbag, "minty_modpack_gen")
                mod = copy_table(MINTY.packable_mods[id])
            end

            card.ability.mod = mod
        end
    end,
    loc_vars = function (self, info_queue, card)
        local mod = card.ability.mod
        if MINTY.in_collection(card) then
            mod = {
                shortname = localize("k_mod_singular"),
                name = localize("k_minty_random_mod"),
                colour = G.C.FILTER
            }
        end
        return {
            key = "p_minty_mod_mega",
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
    end,
    in_pool = function (self, args)
        return true
    end,
    create_card = create_modded_card
}