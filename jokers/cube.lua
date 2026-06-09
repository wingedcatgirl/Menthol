local counters = {
    { boss = "bl_psychic" },
    { boss = "bl_akyrs_the_thought", mod = "aikoyorisshenanigans"},
    --CUBE LOVELY PATCH TARGET

}


SMODS.Joker {
    key = "cube",
    name = "Cube Joker",
    atlas = 'jokerdoodles',
    pos = {
        x = 5,
        y = 0
    },
    rarity = 3,
    cost = 9,
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {extra = {Xmult = 4}},
    attributes = {
        "xmult" --Poker hand size?
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {card.ability.extra.Xmult}
        }
    end,
    check_for_unlock = function (self, args)
        if args and args.type == "win_custom" then
            local fours = 0
            local fournt = 0
            fours = fours + G.GAME.hands["Two Pair"].played
            fours = fours + G.GAME.hands["Four of a Kind"].played
            fournt = fournt + G.GAME.hands["Full House"].played
            fournt = fournt + G.GAME.hands["Flush House"].played
            fournt = fournt + G.GAME.hands["Five of a Kind"].played
            fournt = fournt + G.GAME.hands["Flush Five"].played
            for k, v in pairs(G.GAME.hands) do
                if string.find(k, "Spectrum", nil, true) or string.find(k, "Specflush", nil, true) then
                    if G.GAME.hands[k].played > 0 then
                        fournt = fournt + G.GAME.hands[k].played
                    end
                end
            end
            if fours > fournt then
                unlock_card(self)
                return true
            end
        end
    end,

    calculate = function(self, card, context)
        if context.debuff_hand and (#context.full_hand ~= 4) then
            local warning = localize("k_minty_cube")
            local ge = ((G.GAME.blind.config or {}).blind or {}).debuff and (G.GAME.blind.config.blind.debuff.h_size_ge or 4 >= 5)
            local le = ((G.GAME.blind.config or {}).blind or {}).debuff and (G.GAME.blind.config.blind.debuff.h_size_le or 4 <= 3)
            if ge or le then
                warning = localize("k_minty_psycube")
            end
            return {
                debuff = true,
                debuff_text = warning,
                debuff_source = card
            }
        end

        if (context.joker_main and context.scoring_hand) or context.forcetrigger then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,


    add_to_deck = function(self, card, from_debuff)
        if not (card.ability and card.ability.eternal) then return end -- only if eternal
        if G.GAME.bosses_used["bl_psychic"] >= 1e300 then return end -- not if already banned
        for _,v in ipairs(counters) do
            local boss = v.boss
            local mod = v.mod
            if (not mod) or next(SMODS.find_mod(mod)) then
                G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] + 1e300
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if (not next(SMODS.find_card('j_minty_cube'))) then
            for _,v in ipairs(counters) do
                local boss = v.boss
                local mod = v.mod
                if (not mod) or next(SMODS.find_mod(mod)) then
                    if G.GAME.bosses_used[boss] >= 1e300 then
                        G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] - 1e300
                    end
                end
            end
        end
    end,
}