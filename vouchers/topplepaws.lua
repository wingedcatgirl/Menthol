SMODS.Voucher{
    name = "Table Topple",
    key = "tabletopple",
    atlas = "vouchers",
    pos = {
        x = 1,
        y = 0,
    },
    soul_pos = {
        x = 2,
        y = 0,
    },
    cost = 10,
    config = {
        extra = {
            disc = 3
        }
    },
    loc_vars = function (self, info_queue, card)
        local disclimit = G.GAME and G.GAME.starting_params and G.GAME.starting_params.discard_limit or 5
        local increase = card.ability.extra.disc
        if next(SMODS.find_card(self.key)) and card.area.config.type == "voucher" then increase = 0 end
        return {
            vars = {
                disclimit + increase,
                card.ability.extra.disc
            }
        }
    end,
    in_pool = function (self, args)
        local disclimit = G.GAME and G.GAME.starting_params and G.GAME.starting_params.discard_limit or false
        local decksize = G.deck and G.deck.config and G.deck.config.card_count or false
        return disclimit and decksize and (disclimit < decksize)
    end,
    redeem = function (self, voucher)
        SMODS.change_discard_limit(voucher.ability.extra.disc)
    end,
    unredeem = function (self, voucher)
        SMODS.change_discard_limit(-voucher.ability.extra.disc)
    end
}

SMODS.Voucher{
    name = "Cat's Paws",
    key = "catspaws",
    atlas = "vouchers",
    pos = {
        x = 1,
        y = 1,
    },
    cost = 10,
    config = {
        extra = {
            disc = 999,
            play = 2,
        }
    },
    requires = {"v_minty_tabletopple"},
    unlocked = false,
    unlockreq = 20,
    check_for_unlock = function (self, args)
        if args and args.type == "career_stat" and args.statname == "minty_large_discards" then
            if (G.PROFILES[G.SETTINGS.profile].career_stats["minty_large_discards"] or 0) >= self.unlockreq then
                return true
            end
        end
    end,
    loc_vars = function (self, info_queue, card)
        local playlimit = G.GAME and G.GAME.starting_params and G.GAME.starting_params.play_limit or 5
        local increase = card.ability.extra.play
        if next(SMODS.find_card(self.key)) and card.area.config.type == "voucher" then increase = 0 end
        return {
            vars = {
                playlimit + increase,
                card.ability.extra.play
            }
        }
    end,
    locked_loc_vars = function (self, info_queue, card)
        local disccount = G.PROFILES[G.SETTINGS.profile].career_stats["minty_large_discards"] or 0
        return {
            vars = {
                self.unlockreq,
                disccount
            }
        }
    end,
    in_pool = function (self, args)
        local disclimit = G.GAME and G.GAME.starting_params and G.GAME.starting_params.discard_limit or false
        local playlimit = G.GAME and G.GAME.starting_params and G.GAME.starting_params.play_limit or false
        local limit = (disclimit and playlimit and math.max(disclimit, playlimit)) or disclimit or playlimit
        local decksize = G.deck and G.deck.config and G.deck.config.card_count or false
        return limit and decksize and (limit < decksize)
    end,
    redeem = function (self, voucher)
        SMODS.change_discard_limit(voucher.ability.extra.disc)
        SMODS.change_play_limit(voucher.ability.extra.play)
    end,
    unredeem = function (self, voucher)
        SMODS.change_discard_limit(-voucher.ability.extra.disc)
        SMODS.change_play_limit(-voucher.ability.extra.play)
    end
}