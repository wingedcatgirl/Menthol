local nosuitref = SMODS.has_no_suit
function SMODS.has_no_suit(card)
    if card.edition and card.edition.minty_drained then return true end
    return nosuitref(card)
end

local issuitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if next(find_joker('Treat-o-vision')) then
        if (suit == "minty_3s" or suit == G.GAME.treatovision_suit) and (self.base.suit == "minty_3s" or self.base.suit == G.GAME.treatovision_suit) then
            suit = self.base.suit
        end
    end
    return issuitref(self, suit, bypass_debuff, flush_calc)
end

local isfaceref = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
    if next(find_joker("Prosopagnosia")) and not next(find_joker("Pareidolia")) then
        return false
    end
	return isfaceref(self, from_boss)
end

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

local hasatt = Card.has_attribute
function Card:has_attribute(attribute)
    if attribute == "kity" and self.ability.minty_cat_ears then return true end

    return hasatt(self, attribute)
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

local showman = SMODS.showman
SMODS.showman = function (key)
    if G.GAME.modifiers["minty_infinite_"..key] then return true end
    return showman(key)
end

local gba = get_blind_amount
get_blind_amount = function (ante)
    local amt = gba(ante)
    if G.GAME.blind_size_exponent then
        amt = amt^G.GAME.blind_size_exponent
    end
    return amt
end

local colour = loc_colour
loc_colour = function (_c, _default)
    if not G.ARGS.LOC_COLOURS then
        colour(_c, _default)
    end

    if not G.ARGS.LOC_COLOURS.stake_minty_scarlet then
        G.ARGS.LOC_COLOURS.stake_minty_scarlet = HEX("ff0537")
        G.ARGS.LOC_COLOURS.stake_minty_irrigo = HEX("cb0dff")
        G.ARGS.LOC_COLOURS.stake_minty_void = HEX("001417")
        G.ARGS.LOC_COLOURS.stake_minty_sky = HEX("00c7ff")
        G.ARGS.LOC_COLOURS.stake_minty_mint = HEX("00a156")
        G.ARGS.LOC_COLOURS.stake_minty_tungsten = HEX("667072")
        G.ARGS.LOC_COLOURS.stake_minty_catcat = HEX("CA7CA7")
        G.ARGS.LOC_COLOURS.stake_minty_rose_gold = HEX("ffb2a0")
    end

    return colour(_c, _default)
end