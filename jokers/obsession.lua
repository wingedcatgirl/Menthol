SMODS.Joker {
    key = "obsession",
    name = "Obsession",
    --pronouns = "",
    atlas = 'jokerdoodles2',
    pos = {
        x = 0,
        y = 1
    },
    soul_pos = {
        x = 1,
        y = 1
    },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            rank = "Ace",
            reps = 1
        }
    },
    attributes = {
        "retrigger", "rank"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local rank = localize(card.ability.extra.rank, "ranks")
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                rank,
                card.ability.extra.reps,
                card.ability.extra.reps == 1 and "" or "s"
            }
        }
    end,
    set_ability = function (self, card, initial, delay_sprites)
        local seed = "minty_obsession_rank"
        if MINTY.in_collection(card) then seed = "fake collection bs" end
        local target = MINTY.select_card_from_deck({must_be_ranked = true, seed = seed})
        card.ability.extra.rank = target and target.base.value or card.ability.extra.rank
    end,
    calculate = function(self, card, context)
        if context.repetition and context.other_card:get_id() == SMODS.Ranks[card.ability.extra.rank].id then
            return {
                repetitions = card.ability.extra.reps
            }
        end
    end
}