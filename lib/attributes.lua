if not SMODS.Attribute then return nil end

SMODS.Attribute{ --Cards with the Spread mechanic
    key = "spread_this_like_wildfire"
}

SMODS.Attribute{ --Cards that care about the 3 suit
    key = "minty_3s",
    keys = {
        "j_fibonacci", "j_odd_todd", "j_hack"
    }
}

SMODS.Attribute{ --Cards which care about Faces (the rank)
    key = "minty_facerank"
}

SMODS.Attribute{ --Second verse same as the first
    key = "minty_numberrank"
}

SMODS.Attribute{ --Cards with triangle ears and meow meow
    key = "kity",
    keys = {
        "j_lucky_cat", "j_pl_black_cat", "j_neat_tabbycat", "j_ortalab_black_cat"
    },
    alias = {
        "kitty", "cat"
    }
}

SMODS.Attribute{ --Cards which distinctly don't act like normal cards
    key = "nonstandard"
}

SMODS.Attribute{ --Related to Cobalt cards (consumeable type)
    key = "cobalt"
}

SMODS.Attribute{ --Cards which modify ante
    key = "ante"
}

SMODS.Attribute{ --Cards which may do something when the ante changes
    key = "ante_change"
}

SMODS.Attribute{ --Cards which care about the "Rock Card" classification
    key = "minty_rocks"
}

SMODS.Attribute{ --Cards which are stupid
    key = "stupid"
}

SMODS.Attribute{ --Cards which care about unscored cards
    key = "unscored"
}

SMODS.Attribute{ --Cards which grant exponential mult, or cause other cards to do so
    key = "emult",
    alias = {
        "e_mult", "exp_mult", "expmult", "powmult", "pow_mult"
    }
}

SMODS.Attribute{ --Cards which grant mult with operations above exponentiation, or cause other cards to do so
    key = "hypermult"
}

SMODS.Attribute{ --Cards which care about something outside what would normally be recognized as the "game"
    key = "meta"
}