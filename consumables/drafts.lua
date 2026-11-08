SMODS.Consumable {
    set = "Packet",
    name = "A Little Treat",
    key = "littletreat",
    atlas = 'packets',
    pos = {x = 0, y = 0},
    cost = 0,
    order = 33,
    config = {extra = {cost = -1, amount = 4}},
    loc_vars = function(self, info_queue, card)
        return { vars = {G.FUNCS.format_cost(card.ability.extra.cost), card.ability.extra.amount} }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        MINTY.enable_threeSuit()
        G.FUNCS.packet_effect(card, {suits={SMODS.Suits["minty_3s"]}})
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Drafting", HEX('d7ba89'), G.C.WHITE, 1 )
    end,
}

SMODS.Consumable {
    set = "Packet",
    name = "Illegally Smol Treat",
    key = "smoltreat",
    atlas = 'packets',
    pos = {x = 1, y = 0},
    cost = 0,
    order = 33,
    config = {extra = {cost = -3, amount = 1}},
    attributes = {
        "generation", "minty_3s"
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.FUNCS.format_cost(card.ability.extra.cost), card.ability.extra.amount} }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        MINTY.enable_threeSuit()
        G.FUNCS.packet_effect(card, {ranks={SMODS.Ranks["3"]}, suits={SMODS.Suits["minty_3s"]}})
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Drafting", HEX('d7ba89'), G.C.WHITE, 1 )
    end,
}

SMODS.Consumable {
    set = "Parcel",
    name = "Treat and Mystery",
    key = "treatandmystery",
    pos = {x = 0, y = 0},
    atlas = 'parcels',
    cost = 0,
    order = 1,
    config = {extra = {cost = 0, parcel_amount = 1, amount = 13}},
    attributes = {
        "generation", "minty_3s"
    },
    loc_vars = function(self, info_queue, card)
        local amount = 0
        for key, value in pairs(G.P_CARDS) do
            if value.suit == "minty_3s" then
                amount = amount + card.ability.extra.parcel_amount
            end
        end
        return { vars = {G.FUNCS.format_cost(card.ability.extra.cost), amount, card.ability.extra.amount} }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        MINTY.enable_threeSuit()
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits["minty_3s"]}
        })
        local validsuits = G.FUNCS.filter_suits({exclude={SMODS.Suits["minty_3s"]}})
        local othersuit = pseudorandom_element(validsuits, pseudoseed("treatandmystery"))
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={othersuit}
        })
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Drafting", HEX('d7ba89'), G.C.WHITE, 1 )
    end,
}

SMODS.Consumable {
    set = "Parcel",
    name = "<3",
    key = "lessthanthree",
    pos = {x = 0, y = 1},
    atlas = 'parcels',
    cost = 0,
    order = 1,
    config = {
        extra = {
            cost = 0,
            parcel_amount = 1,
            other_suit = "Hearts"
        }
    },
    attributes = {
        "generation", "minty_3s", "hearts"
    },
    loc_vars = function(self, info_queue, card)
        local threeamount = 0
        local otheramount = 0
        for key, value in pairs(G.P_CARDS) do
            if value.suit == "minty_3s" then
                threeamount = threeamount + card.ability.extra.parcel_amount
            end
            if value.suit == card.ability.extra.other_suit then
                otheramount = otheramount + card.ability.extra.parcel_amount
            end
        end
        return {
            vars = {
                G.FUNCS.format_cost(card.ability.extra.cost),
                threeamount,
                otheramount
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        MINTY.enable_threeSuit()
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits["minty_3s"]}
        })
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits[card.ability.extra.other_suit]}
        })
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Drafting", HEX('d7ba89'), G.C.WHITE, 1 )
    end,
}


SMODS.Consumable {
    set = "Parcel",
    name = "Forbidden Candy",
    key = "forbiddencandy",
    pos = {x = 1, y = 1},
    atlas = 'parcels',
    cost = 0,
    order = 1,
    config = {
        extra = {
            cost = 0,
            parcel_amount = 1,
            other_suit = "Diamonds"
        }
    },
    attributes = {
        "generation", "minty_3s", "diamonds"
    },
    loc_vars = function(self, info_queue, card)
        local threeamount = 0
        local otheramount = 0
        for key, value in pairs(G.P_CARDS) do
            if value.suit == "minty_3s" then
                threeamount = threeamount + card.ability.extra.parcel_amount
            end
            if value.suit == card.ability.extra.other_suit then
                otheramount = otheramount + card.ability.extra.parcel_amount
            end
        end
        return {
            vars = {
                G.FUNCS.format_cost(card.ability.extra.cost),
                threeamount,
                otheramount
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        MINTY.enable_threeSuit()
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits["minty_3s"]}
        })
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits[card.ability.extra.other_suit]}
        })
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Drafting", HEX('d7ba89'), G.C.WHITE, 1 )
    end,
}


SMODS.Consumable {
    set = "Parcel",
    name = "Exclusive Treats",
    key = "exclusivetreats",
    pos = {x = 2, y = 1},
    atlas = 'parcels',
    cost = 0,
    order = 1,
    config = {
        extra = {
            cost = 0,
            parcel_amount = 1,
            other_suit = "Clubs"
        }
    },
    attributes = {
        "generation", "minty_3s", "clubs"
    },
    loc_vars = function(self, info_queue, card)
        local threeamount = 0
        local otheramount = 0
        for key, value in pairs(G.P_CARDS) do
            if value.suit == "minty_3s" then
                threeamount = threeamount + card.ability.extra.parcel_amount
            end
            if value.suit == card.ability.extra.other_suit then
                otheramount = otheramount + card.ability.extra.parcel_amount
            end
        end
        return { 
            vars = {
                G.FUNCS.format_cost(card.ability.extra.cost),
                threeamount,
                otheramount
            } 
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        MINTY.enable_threeSuit()
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits["minty_3s"]}
        })
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits[card.ability.extra.other_suit]}
        })
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Drafting", HEX('d7ba89'), G.C.WHITE, 1 )
    end,
}


SMODS.Consumable {
    set = "Parcel",
    name = "Digging for Treats",
    key = "diggingfortreats",
    pos = {x = 3, y = 1},
    atlas = 'parcels',
    cost = 0,
    order = 1,
    config = {
        extra = {
            cost = 0,
            parcel_amount = 1,
            other_suit = "Spades"
        }
    },
    attributes = {
        "generation", "minty_3s", "spades"
    },
    loc_vars = function(self, info_queue, card)
        local threeamount = 0
        local otheramount = 0
        for key, value in pairs(G.P_CARDS) do
            if value.suit == "minty_3s" then
                threeamount = threeamount + card.ability.extra.parcel_amount
            end
            if value.suit == card.ability.extra.other_suit then
                otheramount = otheramount + card.ability.extra.parcel_amount
            end
        end
        return { 
            vars = {
                G.FUNCS.format_cost(card.ability.extra.cost),
                threeamount,
                otheramount
            } 
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        MINTY.enable_threeSuit()
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits["minty_3s"]}
        })
        G.FUNCS.parcel_effect(card, {
            base_amount=card.ability.extra.parcel_amount,
            suits={SMODS.Suits[card.ability.extra.other_suit]}
        })
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Drafting", HEX('d7ba89'), G.C.WHITE, 1 )
    end,
}