SMODS.JimboQuip{
    key = "de_ref",
    type = "loss",
    filter = function (self, quip_type)
        local most = {
            type = "None",
            amount = 0
        }
        for k, v in pairs(G.GAME.hands) do
            if G.GAME.hands[k].played > most.amount then
                most = {
                    type = k,
                    amount = G.GAME.hands[k].played
                }
            end
        end
        local check = false
        local centrist_hands = {
            ["Three of a Kind"] = true,
            ["Flush"] = true,
            ["Straight"] = true,
            ["Straight Flush"] = true,
            ["Two Pair"] = true,
            ["Full House"] = true,
        }
        if centrist_hands[most.type] or string.find(most.type, "Spectrum") then check = true end
        local weight = 2
        return check, {weight = weight}
    end
}

SMODS.JimboQuip{
    key = "unskipped_absence",
    type = "loss",
    filter = function (self, quip_type)
        local check
        pcall(function ()
            check = G.GAME.blind.config.blind.key == "bl_minty_absence"
        end)

        return check, {weight = 100000}
    end
}