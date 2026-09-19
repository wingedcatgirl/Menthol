if not SMODS.Attribute then return nil end

SMODS.Attribute{ --Objects with the Spread mechanic
    key = "spread_this_like_wildfire"
}

SMODS.Attribute{ --Objects that care about the 3 suit
    key = "minty_3s",
    keys = {
        "j_fibonacci", "j_odd_todd", "j_hack"
    }
}

SMODS.Attribute{ --Objects which care about Faces (the rank)
    key = "minty_facerank"
}

SMODS.Attribute{ --Second verse same as the first
    key = "minty_numberrank"
}

SMODS.Attribute{ --Objects with triangle ears and meow meow
    key = "kity",
    keys = {
        "j_lucky_cat", "j_pl_black_cat", "j_neat_tabbycat", "j_ortalab_black_cat"
    },
    alias = {
        "kitty", "cat"
    }
}

SMODS.Attribute{ --For crossmodding; objects whose frequency is boosted by The Silliest, Littlest Deck and Sleeve
    key = "Menthol",
    alias = {
        "MintysSillyMod", "minty"
    }
}

SMODS.Attribute{ --Objects which distinctly don't act like normal objects
    key = "nonstandard"
}

SMODS.Attribute{ --Related to Cobalt cards (consumeable type)
    key = "cobalt"
}

SMODS.Attribute{ --Objects which may do something when the ante changes
    key = "ante_change"
}

SMODS.Attribute{ --Objects which care about the "Rock Card" classification
    key = "minty_rocks"
}

SMODS.Attribute{ --Objects which are stupid, and also suck bad
    key = "stupid"
}

SMODS.Attribute{ --Objects which care about unscored cards
    key = "unscored"
}

SMODS.Attribute{ --Objects which care about cards held in hand
    key = "held_in_hand",
    keys = {
        "j_mime", "j_raised_fist", "j_blackboard", "j_baron", "j_reserved_parking", "j_shoot_the_moon"
    }
}

SMODS.Attribute{ --Objects which grant exponential mult, or cause other objects to do so
    key = "emult",
    alias = {
        "e_mult", "exp_mult", "expmult", "powmult", "pow_mult"
    }
}

SMODS.Attribute{ --Objects which grant mult with operations above exponentiation, or cause other objects to do so
    key = "hypermult"
}

SMODS.Attribute{ --Objects which care about something outside what would normally be recognized as the "game"
    key = "meta"
}