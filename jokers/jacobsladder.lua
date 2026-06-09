SMODS.Joker {
    key = "jacobsladder",
    name = "Jacob's Ladder",
    atlas = 'jokerdoodles',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 3,
        y = 4
    },
    rarity = 3,
    cost = 8,
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        immutable = {
            req = 5
        }
    },
    attributes = {
        "balance", "suit"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.immutable.req
            },
        }
    end,
    in_pool = function (self, args)
        if G and (G.GAME.selected_back.effect.center.key == "b_plasma") then return false else return true end
    end,
    check_for_unlock = function (self, args)
        if args and args.type == 'hand' and args.scoring_hand then
            local spectrum = string.find(args.disp_text, "Spectrum") --The easy way: detect a Spectrum being scored
            if spectrum then
                unlock_card(self)
                return true
            end
            -- If no Spectrum mod is installed, do it the hard way and detect a five-suited hand manually
            local wild_cards = {}
            local locked_cards = {}
            local locked_suits = {}
            local flex_cards = {}

            for _, card in ipairs(args.scoring_hand) do
                if not SMODS.has_no_suit(card) then
                    if SMODS.has_any_suit(card) then
                        table.insert(wild_cards, card)
                    else
                        local suits = {}
                        for _, suit in ipairs(SMODS.Suit.obj_buffer) do
                            if card:is_suit(suit, nil, true) then
                                table.insert(suits, suit)
                            end
                        end

                        if #suits == 1 then
                            local s = suits[1]
                            locked_suits[s] = true
                            table.insert(locked_cards, card)
                        else
                            table.insert(flex_cards, {card = card, suits = suits})
                        end
                    end
                end
            end

            local function count_keys(tbl)
                local n = 0
                for _ in pairs(tbl) do n = n + 1 end
                return n
            end

            local total_possible = count_keys(locked_suits) + #flex_cards + #wild_cards
            if total_possible < 5 then
                return
            end

            local initial_suit_count = count_keys(locked_suits)
            local needed = 5 - initial_suit_count

            if needed <= #wild_cards then
                unlock_card(self)
                return true
            end

            -- need to find (needed) more unique suits from flex cards
            local all_suits = {}
            for _, suit in ipairs(SMODS.Suit.obj_buffer) do
                if not locked_suits[suit] then
                    table.insert(all_suits, suit)
                end
            end

            local function assign(i, used_cards, assigned_suits)
                if i > needed then return true end
                local suit = all_suits[i]

                for j, flex in ipairs(flex_cards) do
                    if not used_cards[j] then
                        for _, s in ipairs(flex.suits) do
                            if s == suit then
                                used_cards[j] = true
                                assigned_suits[suit] = true
                                if assign(i + 1, used_cards, assigned_suits) then
                                    return true
                                end
                                used_cards[j] = false
                                assigned_suits[suit] = nil
                                break
                            end
                        end
                    end
                end

                return false
            end

            if needed <= #flex_cards and assign(1, {}, {}) then
                unlock_card(self)
                return true
            end
        end
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                balance = true
            }
        end

        if context.final_scoring_step then
            local suits = {}
            for _,v in ipairs(SMODS.Suit.obj_buffer) do
                suits[v] = false
            end
            for i = 1, #context.scoring_hand do
                local looking = context.scoring_hand[i]
                if not SMODS.has_any_suit(looking) then
                    for k,_ in pairs(suits) do
                        if looking:is_suit(k) and suits[k] == false then
                            suits[k] = true
                            break
                        end
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                local looking = context.scoring_hand[i]
                if SMODS.has_any_suit(looking) then
                    for k,_ in pairs(suits) do
                        if suits[k] == false then
                            suits[k] = true
                            break
                        end
                    end
                end
            end
            local count = 0
            for k,_ in pairs(suits) do
                if suits[k] then count = count+1 end
            end
            MINTY.say(tostring(count))
            if count >= card.ability.immutable.req then
                return {
                    balance = true
                }
            end
        end
    end
}