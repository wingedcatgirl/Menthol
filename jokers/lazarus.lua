MINTY.edition_values = {
    e_foil = 1,
    e_holographic = 1,
    e_polychrome = 2,
    e_negative = 4,
    e_minty_drained = 0
}

SMODS.Joker {
    key = "lazarus",
    name = "Lazarus Machine",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    rarity = 3,
    cost = 15,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            charge = 0,
            needed = 30,
            amount = 2,
        }
    },
    attributes = {
        "editions", "modify_card", "generation"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        
        info_queue[#info_queue+1] = G.P_CENTERS.e_minty_drained
        info_queue[#info_queue+1] = G.P_CENTERS.c_soul

        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.amount,
                card.ability.extra.charge,
                card.ability.extra.needed,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local targets = {}
            for i,v in ipairs(G.play.cards) do
                if not (v.edition and v.edition.minty_drained) then
                    targets[#targets+1] = v
                end
            end
            if #targets > 1 then
                local sounded = false
                for i=1,math.min(#targets, card.ability.extra.amount) do
                    MINTY.event(function ()
                        if not next(targets) then return true end
                        ---@type Card
                        local nom = table.remove(targets, pseudorandom("minty_lazarus_draining", 1, #targets))
                        if nom.edition then
                            card.ability.extra.charge = card.ability.extra.charge + (MINTY.edition_values[nom.edition.key] or 1)
                        end
                        if not (nom.edition and nom.edition.minty_drained) then
                            card.ability.extra.charge = card.ability.extra.charge + 1
                            nom:set_edition("e_minty_drained", true, not sounded)
                            sounded = true
                            nom:juice_up()
                            card:juice_up()
                        end
                        return true
                    end)
                end
            end
        end
        if context.after then
            MINTY.event(function ()
                if card.ability.extra.charge >= card.ability.extra.needed then
                    SMODS.destroy_cards(card, true, true, true)
                    SMODS.add_card{
                        set = "Spectral",
                        key = "c_soul",
                        area = G.consumeables
                    }
                end
                return true
            end)
        end
    end
}