--Hook: Drained cards have no suit
local nosuitref = SMODS.has_no_suit
function SMODS.has_no_suit(card)
    if card.edition and card.edition.minty_drained then return true end
    return nosuitref(card)
end

--Hook: Treat-o-vision
local issuitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if next(find_joker('Treat-o-vision')) then
        if (suit == "minty_3s" or suit == G.GAME.treatovision_suit) and (self.base.suit == "minty_3s" or self.base.suit == G.GAME.treatovision_suit) then
            suit = self.base.suit
        end
    end
    return issuitref(self, suit, bypass_debuff, flush_calc)
end

--Hook: Prosopagnosia and Face rank
local isfaceref = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
    if self.base.id == SMODS.Ranks.minty_face.id then return true end
    if next(find_joker("Prosopagnosia")) and not next(find_joker("Pareidolia")) then
        return false
    end
	return isfaceref(self, from_boss)
end

--Hook: Run a calculation if a card tries to change suit
local setbaseref = Card.set_base
function Card:set_base(card, initial, manual_sprites)
    if self.playing_card and self.base then
        local new_rank = card and card.value and SMODS.Ranks[card.value] and SMODS.Ranks[card.value].id
        if card and ((card.suit and self.base.suit ~= card.suit) or (self.base.id and self.base.id == new_rank)) then
            SMODS.calculate_context{attempted_suit_change = true, card = self}
        end
    end

    setbaseref(self, card, initial, manual_sprites)
end

---Slapdash patch for #CA7CA7 stake name; replaces "<hash>" with "#"
local oldparser = loc_parse_string
loc_parse_string = function (line)
    local parsed = oldparser(line)
    if parsed then
        for _, segment in ipairs(parsed) do
            for i, part in ipairs(segment.strings) do
                if type(part) == "string" then
                    segment.strings[i] = part:gsub("<hash>", "#")
                end
            end
        end
    end
    return parsed
end

--Hook: Check infinity modifiers
local showman = SMODS.showman
SMODS.showman = function (key)
    if G.GAME.modifiers["minty_infinite_"..key] then return true end
    return showman(key)
end

--Hook: Calculate blind size exponents
local gba = get_blind_amount
get_blind_amount = function (ante)
    local amt = gba(ante)
    if G.GAME.blind_size_exponent then
        amt = amt^G.GAME.blind_size_exponent
    end
    return amt
end

--Hook: Add Menthol stake colors
local colour = loc_colour
loc_colour = function (_c, _default)
    if not G.ARGS.LOC_COLOURS then
        colour(_c, _default)
    end

    local colours = {
        stake_minty_scarlet = HEX("ff0537"),
        stake_minty_irrigo = HEX("cb0dff"),
        stake_minty_void = HEX("001417"),
        stake_minty_sky = HEX("00c7ff"),
        stake_minty_mint = HEX("00a156"),
        stake_minty_tungsten = HEX("667072"),
        stake_minty_catcat = HEX("CA7CA7"),
        stake_minty_rose_gold = HEX("ffb2a0")
    }

    if not G.ARGS.LOC_COLOURS.stake_minty_scarlet then
        for k,v in pairs(colours) do
            G.ARGS.LOC_COLOURS[k] = v
        end
    end

    return colour(_c, _default)
end

--Hook: Preserve passed object weights even if they aren't objects that exist
local getweightof = SMODS.get_weight_of_object
function SMODS.get_weight_of_object(obj, opt_weight, args)
    if args and args.force_weight then
        if not obj then return opt_weight or 10, opt_weight or 10 end
    end
    return getweightof(obj, opt_weight, args)
end

--Hook: An Absence can't be selected
local bch = G.FUNCS.blind_choice_handler
G.FUNCS.blind_choice_handler = function(e)
    local ret = bch(e)

    --get attached blind, disable select button if it is An Absence
    local slot = e.config.id
    local blind_key = G.GAME.round_resets.blind_choices[slot]
    if slot == G.GAME.blind_on_deck and blind_key == "bl_minty_absence" then
        local top_button = e.UIBox:get_UIE_by_ID('select_blind_button')
        if top_button then
            top_button.config.colour = G.C.UI.BACKGROUND_INACTIVE
            top_button.config.button = nil
            top_button.config.hover = false
            top_button.children[1].config.colour = G.C.UI.TEXT_INACTIVE
        end
    end

    return ret
end

--Hook: An Absence has no score
local cbc = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info)
    local t = cbc(type, run_info)

    if G.GAME.round_resets.blind_choices[type] == "bl_minty_absence" then
        t.nodes[1].nodes[3].nodes[1].nodes[2] = nil
    end
    return t
end

--Hook: Skipping An Absence isn't an "or" question
local cbt = create_UIBox_blind_tag
function create_UIBox_blind_tag(blind_choice, run_info)
    local t = cbt(blind_choice, run_info)

    if G.GAME.round_resets.blind_choices[blind_choice] == "bl_minty_absence" then
        t.nodes[1].nodes[1].config.text = ""
    end

    return t
end

--Hook: Mythic Rares count as Rares
local israrity = Card.is_rarity
function Card:is_rarity(rarity)
    local own = self.config.center.rarity
    if own == "minty_mythic" and (rarity == "Rare" or rarity == 3) then
        return true
    end

    return israrity(self, rarity)
end

--Hook: Mythic Rares have a chance to replace Rares, such that each individual Mythic is about half as common as each individual Rare
--[[ --... once we invent some.
local pollrarity = SMODS.poll_rarity
function SMODS.poll_rarity(...)
    local res = pollrarity(...)

    if res == 3 and #SMODS.get_clean_pool("Joker", "minty_mythic") > 0 then
        local allowdupes = SMODS.poll_object_allow_duplicates
        SMODS.poll_object_allow_duplicates = false
        local rares = #SMODS.get_clean_pool("Joker", "Rare")
        local mythics = #SMODS.get_clean_pool("Joker", "minty_mythic")
        SMODS.poll_object_allow_duplicates = allowdupes
        if SMODS.pseudorandom_probability(nil, "minty_mythic_rare_poll", mythics, (rares*2)+mythics, nil, true) then
            res = "minty_mythic"
        end
    end

    return res
end
--]]