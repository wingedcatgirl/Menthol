local root3 = math.floor(math.sqrt(3)*100)/100

SMODS.Blind{
    key = "clowder",
    dollars = 7,
    mult = root3,
    boss = {min = 2},
    boss_colour = HEX("489148"),
    --[[]]
    atlas = 'blinds',
    pos = { x=0, y=0 },
    --]]
    recalc_debuff = function (self, card, from_blind)
        if card.config.center.set == "Joker" and not card:is_kity() then return true end
    end
}