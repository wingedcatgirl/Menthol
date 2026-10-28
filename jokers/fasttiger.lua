local set_card_type_badge
if next(SMODS.find_mod("Bibliography")) then
    set_card_type_badge = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[1] = create_badge(localize("k_biblio_evolved", "labels"), SMODS.Gradients.biblio_evolved, nil, 1.2)
    end
end

SMODS.Joker {
    key = "fasttiger",
    name = "Fast Tiger",
    pronouns = "it_its",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    cost = 7,
    set_card_type_badge = set_card_type_badge,
    unlocked = true,
    discovered = false,
    no_collection = function (self)
        return not self.discovered
    end,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            xmult = 1,
            xmultiplier = 0.25
        }
    },
    in_pool = function (self, args)
        return false
    end,
    attributes = {
        "xmult", "kity"
    },
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.xmult = (G.GAME.round or 1) * card.ability.extra.xmultiplier --for direct creation; should be overwritten when evolving
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}