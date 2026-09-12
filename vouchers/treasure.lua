SMODS.Voucher{
    name = "Treasure",
    key = "treasure",
    atlas = "vouchers",
    unlocked = false,
    check_for_unlock = function (self, args)
        if args and args.type == "discover_amount" then
            local vouchers = { "v_nacho_tong", "v_palette", "v_recyclomancy", "v_antimatter", "v_minty_catspaws" }
            local result = true
            for i,v in ipairs(vouchers) do
                result = result and G.P_CENTERS[v].unlocked
            end
            return result
        end
    end,
    locked_loc_vars = function (self, info_queue, voucher)
        local vouchers = { "v_nacho_tong", "v_palette", "v_recyclomancy", "v_antimatter", "v_minty_catspaws" }
        local vars = {
            colours = {}
        }
        local colours = {}
        for i,v in ipairs(vouchers) do
            vars[i] = G.P_CENTERS[v].discovered and localize({key = v, type = 'name_text', set = "Voucher"}) or "???"
            vars.colours[i] = G.P_CENTERS[v].unlocked and G.C.PURPLE or G.C.FILTER
        end
        return { vars = vars }
    end,
    pos = {
        x = 1,
        y = 2,
    },
    cost = 15,
    config = {
        extra = {
            amount = 1
        }
    },
    loc_vars = function (self, info_queue, voucher)
        local option
        if MINTY.in_collection(voucher) then
            option = "k_minty_treasureplaceholder"
        else
            option = "k_minty_"..voucher.ability.extra.option
        end

        return {
            vars = {
                voucher.ability.extra.amount,
                localize(option)
            }
        }
    end,
    requires = { "v_grabber", "v_paint_brush", "v_wasteful", "v_blank", "v_minty_tabletopple" },
    in_pool = function (self, args)
        return true, { allow_duplicates = true }
    end,
    set_ability = function (self, voucher, initial, delay_sprites)
        local option = pseudorandom_element({ "hands", "size", "discards", "jokers", "selection" }, "minty_treasure")
        local count = #SMODS.find_card(self.key, true)
        voucher.ability.extra.option = option
        if not MINTY.in_collection(voucher) then
            MINTY.event(function ()
                voucher.cost = voucher.cost + (count*5)
                return true
            end, {trigger = "after", delay = 0.5})
        end
    end,
    redeem = function (self, voucher)
        local option = voucher.ability.extra.option
        if option == "hands" then
            --MINTY.say("Increasing hands")
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + voucher.ability.extra.amount
        elseif option == "size" then
            G.hand:change_size(voucher.ability.extra.amount)
            --MINTY.say("Increasing hand size")
        elseif option == "discards" then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + voucher.ability.extra.amount
            ease_discard(voucher.ability.extra.amount)
            --MINTY.say("Increasing discards")
        elseif option == "jokers" then
            G.E_MANAGER:add_event(Event({func = function() --This is an event in vanilla and I don't know why but I'm replicating it just in case :shrug:
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + voucher.ability.extra.amount
                end
                return true end }))
            --MINTY.say("Increasing joker limit")
        elseif option == "selection" then
            SMODS.change_discard_limit(voucher.ability.extra.disc)
            SMODS.change_play_limit(voucher.ability.extra.disc)
            --MINTY.say("Increasing selection limit")
        else
            MINTY.say("Failed to select option for Treasure voucher?!", "ERROR")
        end
    end,
    unredeem = function (self, voucher)
        local option = voucher.ability.extra.option
        if option == "hands" then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - voucher.ability.extra.amount
        elseif option == "size" then
            G.hand:change_size(-voucher.ability.extra.amount)
        elseif option == "discards" then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - voucher.ability.extra.amount
            ease_discard(-voucher.ability.extra.amount)
        elseif option == "jokers" then
            G.E_MANAGER:add_event(Event({func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit - voucher.ability.extra.amount
                end
                return true end }))
        elseif option == "selection" then
            SMODS.change_discard_limit(-voucher.ability.extra.disc)
            SMODS.change_play_limit(-voucher.ability.extra.disc)
        else
            MINTY.say("Unredeemed Treasure voucher has no option?!", "ERROR")
        end
    end
}