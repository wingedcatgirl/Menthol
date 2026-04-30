SMODS.Joker {
    key = "prism",
    name = "//cat.exe -prism",
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 4,
        y = 0
    },
    rarity = 3,
    cost = 9,
    pools = {
        kity = true
    },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            xmult = 0.25
        }
    },
    attributes = {
        "xmult", "generation", "suit", "kity", "space", "cobalt"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if MINTY.config.flavor_text then
            key = self.key.."_flavor"
        end
        info_queue[#info_queue+1] = G.P_CENTERS.c_minty_backup_plan
        local estimate
        if card.area.config.collection or not (G.hand and G.hand.cards and #G.hand.cards > 0) then
            estimate = "?"
        else
            local cards = {}
            local suits = 0
            local wilds = 0
            local unknown
            for i,v in ipairs(G.hand.cards) do
                if not v.highlighted then
                    if v.facing == "back" then
                        unknown = true
                    elseif SMODS.has_any_suit(v) then
                        wilds = wilds + 1
                    elseif not SMODS.has_no_suit(v) and not card.ability.minty_hooked then
                        cards[#cards+1] = v
                    end
                end
            end
            for k,v in pairs(SMODS.Suits) do --This can break in cases of suit patches or similar. Too bad!
                for ii,vv in ipairs(cards) do
                    if vv:is_suit(k) then
                        suits = suits + 1
                        table.remove(cards, ii)
                        break
                    end
                end
                if not next(cards) then break end
            end
            estimate = 1+((suits + wilds) * card.ability.extra.xmult)
            if G.GAME.blind and G.GAME.blind.name == "The Hook" and not G.GAME.blind.disabled then
                unknown = true
            end
            if unknown then estimate = estimate.."?" end
        end
        return {
            key = key,
            vars = {
                card.ability.extra.xmult,
                estimate
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not next(SMODS.find_card("c_minty_backup_plan")) then
            SMODS.add_card{
                set = "minty_cobalt",
                key = "c_minty_backup_plan",
                area = G.consumeables
            }
            return {
                message = localize("k_minty_bouyant")
            }
        end

        if context.joker_main then
            local cards = {}
            local suits = 0
            local wilds = 0
            for i,v in ipairs(G.hand.cards) do
                if not v.highlighted then
                    if SMODS.has_any_suit(v) then
                        wilds = wilds + 1
                    elseif not SMODS.has_no_suit(v) and not card.ability.minty_hooked then
                        cards[#cards+1] = v
                    end
                end
            end
            for k,v in pairs(SMODS.Suits) do --This can break in cases of suit patches or similar. Too bad!
                for ii,vv in ipairs(cards) do
                    if vv:is_suit(k) then
                        suits = suits + 1
                        table.remove(cards, ii)
                        break
                    end
                end
                if not next(cards) then break end
            end
            if suits + wilds > 1 then
                return {
                    xmult = 1+((suits + wilds) * card.ability.extra.xmult)
                }
            end
        end
    end
}