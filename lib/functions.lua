---Debug messages
---@param message string Message to send
---@param level? string Log level, DEBUG by default, TRACE won't send unless dev mode is active since DebugPlus doesn't have that filter fsr
function MINTY.say(message, level)
    message = message or "???"
    level = level or "DEBUG"
    while #level < 5 do
        level = level.." "
    end
    if level == "TRACE" and not (MINTY.config.dev_mode and not MINTY.config.suppress_trace) then
        return
    end
    sendMessageToConsole(level, "Menthol", message)
end

---Checks whether a card is in the collection (as opposed to e.g. the hand or Jokers tray)
---@param card table Card to check
---@return boolean
MINTY.in_collection = function (card)
    if G.your_collection then
        for k, v in pairs(G.your_collection) do
            if card.area == v then
                return true
            end
        end
    end
    return false
end

---Enables Bunco's exotics and anything that relies on them
MINTY.enable_exotics = function()
    if G.GAME then G.GAME.Exotic = true end
    MINTY.say("Enabled Bunco's exotic system, for some reason", "TRACE")
end

---Disables Bunco's exotics and anything that relies on them. I don't remember why I wanted these 👍️
MINTY.disable_exotics = function()
    if G.GAME then G.GAME.Exotic = false end
    MINTY.say("Disabled Bunco's exotic system, for some reason", "TRACE")
end

---Checks if Bunco's exotics are enabled
MINTY.exotic_in_pool = function()
    return G.GAME and G.GAME.Exotic
end

---Enables 3 suit and accessories
MINTY.enable_threeSuit = function()
    if not G.GAME then
        MINTY.say("Attempted to enable 3 suit, but there is no game.", "DEBUG")
        return
    end
    G.GAME.threeSuitEnabled = true
    if G.GAME.Exotic then
        MINTY.say("Attempted to enable 3 suit, but Exotic suits are already enabled.", "TRACE")
    else
        MINTY.say("Enabled 3 suit.", "TRACE")
    end
end

---Disables 3 suit and accessories
MINTY.disable_threeSuit = function()
    if not G.GAME then
        MINTY.say("Attempted to disable 3 suit, but there is no game.", "DEBUG")
        return
    end
    G.GAME.threeSuitEnabled = false
    if G.GAME.Exotic then
        MINTY.say("Attempted to disable 3 suit, but Exotic suits are still enabled.", "TRACE")
    else
        MINTY.say("Disabled 3 suit.", "TRACE")
    end
end

---Checks whether 3s and 3 accessories should spawn; a Spectrum has been played or 3s or Exotics have been force-enabled
---@param fallback? boolean Forces true if Spectrum Framework is not active; default false
---@return boolean
MINTY.threeSuit_in_pool = function(fallback)
    if G.GAME.starting_params.start_with_3s then return true end

    local threelock = G.GAME.starting_params.minty_three_lock or MINTY.config.three_lock.current_option

    if threelock == 3 then
        return false
    elseif threelock == 1 then
        return true
    end
    local spectrum = false

    if SPECF then
        spectrum = SPECF.spectrum_played()
    else
        if fallback then return true end
    end
    return G.GAME and (spectrum or G.GAME.threeSuitEnabled or G.GAME.Exotic)
end

---Checks how many times a card counts as a 3
---@param bypass_debuff boolean?
---@return integer|boolean --Number of times the card counts as a 3, or `false` if it doesn't count as a 3 (0 is truthy in lua...)
function Card:is_3(bypass_debuff)
    local count = 0
        if self.debuff and not bypass_debuff then return false end
        if SMODS.has_any_suit(self) or self.base.suit == 'minty_3s' or (next(find_joker("Treat-o-Vision")) and self.base.suit == G.GAME.treatovision_suit) then
            count = count + 1
        end
        if self:get_id() == 3 then
            count = count + 1
        end
        --[[if self.ability.name == "fuzzy enhancement" then
            count = count + 3
        end]]
        --[[if (has kity seal) then
            count = count + 3
        end]]

        local gems = SMODS.find_mod("Gemstone")[1]

        if gems and gems.can_load then
            if self.ability.gemslot_catseye then
                count = count + 2
            end
        end
        --[[if (is feline edition) then
            count = count * 2
        end]]

        local aikoshen = SMODS.find_mod("aikoyorisshenanigans")[1]

        if aikoshen and aikoshen.can_load then
            if self.get_letter_with_pretend and self:get_letter_with_pretend() == "3" then count = count + 1 end --Completely useless bc math deck ignores 98% of mechanics, but funny
        end

        if count == 0 then return false else return count end
end

function Card:is_kity()
    if self.has_attribute then return self:has_attribute("kity") end

    local minty_kity = self.config.center.pools and self.config.center.pools.kity
    local yahicat = self.config.center.pools and self.config.center.pools.Cat
    local valkitty
    if next(SMODS.find_mod("vallkarri")) then
        valkitty = self:is_kitty()
    end
    return minty_kity or valkitty or yahicat
end

MINTY.kity_pool = function(legend, source)
	local stake_index = G.GAME.stake or 1
	local stake_key = SMODS.stake_from_index(stake_index)
    local stake_check = MINTY.at_least_stake(G.GAME.stake, "stake_gold") or MINTY.at_least_stake(G.GAME.stake, "stake_minty_catcat")
	local cat_basket, gold_cats, ungold_cats = {}, {}, {}

	for k,v in pairs(G.P_CENTERS) do
		local is_cat = false
		if v.pools then
			is_cat = v.pools.kity or v.pools.Kitties or v.pools.Cat
		end
        if not is_cat then goto nope end
		local rarity_check = (legend and v.rarity == 4) or ((legend == "ignore" or not legend) and v.rarity ~= 4)
		local pool_check = SMODS.add_to_pool(v, {source = source})
        local dupe_check = not (next(SMODS.find_card(v.key)) and not SMODS.showman(v.key))
        local valid = is_cat and rarity_check and pool_check and dupe_check
		if valid then
            cat_basket[#cat_basket+1] = k
            if stake_check then
                local function getwinsbykey()
                    return G.PROFILES[G.SETTINGS.profile].joker_usage[v.key].wins_by_key
                end
                local wbk = pcall(getwinsbykey) or {}
                local sticker_needed
                if sticker_key then
                    local gold_needed, catcat_needed, current_needed = true, true, true
                    for kk,vv in pairs(wbk) do
                        if gold_needed and MINTY.at_least_stake(kk, "stake_gold") then
                            gold_needed = false
                        end
                        if catcat_needed and MINTY.at_least_stake(kk, "stake_minty_catcat") then
                            catcat_needed = false
                        end
                        if current_needed and MINTY.at_least_stake(kk, G.GAME.stake) then
                            current_needed = false
                            break
                        end
                    end
                    sticker_needed = current_needed and (gold_needed or catcat_needed)
                end

                if not sticker_needed then
                    gold_cats[#gold_cats+1] = k
                else
                    ungold_cats[#ungold_cats+1] = k
                end
            end
        end
        ::nope::
	end

    if #cat_basket == 0 then cat_basket[#cat_basket+1] = "j_lucky_cat" end

	return (legend and stake_check and (#gold_cats > 0) and (#ungold_cats > 0) and ungold_cats) or cat_basket
end

MINTY.getSpecKey = (SPECF and SPECF.getSpecKey) or function(HandName)
    MINTY.say("Using Minty's function for this")
    if not G.GAME then return "ERROR: Hands don't exist yet!" end
    HandName = HandName or "Spectrum"
    local lowest_key = nil
    local lowest_order = math.huge
    local escaped_name = HandName:gsub("([^%w])", "%%%1")  -- escape magic chars

    local suffix_pattern = "_" .. escaped_name .. "$"

    for key, hand in pairs(G.GAME.hands) do
        if key:match(suffix_pattern) and type(hand.order) == "number" then
            if hand.order < lowest_order then
                lowest_order = hand.order
                lowest_key = key
            end
        end
    end

    if lowest_key == nil then return "ERROR: No spectrum mod loaded!" else return lowest_key end
end

---Adds to a global count when lucky cards hit; currently disabled because I can't figure out how to distinguish "unnatural" hits
---@param mod integer
MINTY.luckyCount = function(mod)
    mod = mod or 1
    G.GAME.total_lucky_count = G.GAME.total_lucky_count and (G.GAME.total_lucky_count + mod) or mod
    MINTY.say("Lucky counted", "TRACE")
    --[[if G and G.GAME and not G.GAME.unnatural_lucky then
        G.GAME.natural_lucky_count = G.GAME.natural_lucky_count and (G.GAME.natural_lucky_count + mod) or mod
        MINTY.say("Natural lucky counted", "DEBUG")
    end--]]
end

---Testing function cause I keep forgetting how pairs and ipairs work, don't worry about it 
MINTY.centercount = function (args)
    args = args or {}
    local mod = args.mod or "Menthol"
    local modprefix = SMODS.Mods[mod].prefix.."_"
    local itemprefix = args.itemprefix or "sleeve_"
    local count = 0
    for k,v in pairs(G.P_CENTERS) do
        if string.find(k,itemprefix..modprefix) then
            count = count + 1
            MINTY.say(k)
        end
    end
    MINTY.say(tostring(count))
end

---@param this? string Pass a sleeve key to check if it already got unlocked
---@param debug? boolean Print debugging strings
---@return string result Key of the stake that will unlock next sleeve, or already unlocked sleeve with key passed into `this` 
---@return integer count Count (order) of the same stake as `string`
MINTY.sleeveunlockcheck = function(this, debug)
  G.PROFILES[G.SETTINGS.profile].mintysleeves = G.PROFILES[G.SETTINGS.profile].mintysleeves or {}

  local sleeves = {}
    for k,_ in pairs(G.P_CENTERS) do
        if string.find(k,"sleeve_minty_") then
            table.insert(sleeves, k)
        end
    end
  local count = 1
  for _, sleeve in ipairs(sleeves) do
    if G.P_CENTERS[sleeve] and G.P_CENTERS[sleeve].unlocked == true then
      count = count + 1
    end
  end

  local stakes = {
    "stake_minty_scarlet",
    "stake_minty_irrigo",
    "stake_minty_void",
    "stake_minty_sky",
    "stake_minty_mint",
    "stake_minty_tungsten",
    "stake_minty_catcat",
  }

  local result = stakes[count] or "stake_minty_catcat"
  local index = G.P_STAKES[result].order

  G.PROFILES[G.SETTINGS.profile].mintysleeves.key, G.PROFILES[G.SETTINGS.profile].mintysleeves.result = result, index
  if G.PROFILES[G.SETTINGS.profile].mintysleeves[this] then --put it in the settings?
    result = G.PROFILES[G.SETTINGS.profile].mintysleeves[this]
  end

  G:save_settings()
  return result, index
end

MINTY.rocklist = function ()
    MINTY.rocks = MINTY.rocks or {}
    MINTY.rockbag = {}
    local outside_rocks = {
        m_ortalab_ore = true,
        m_akyrs_brick_card = true,
        m_mf_gemstone = true,
        m_artb_marble = true,
        m_stone = true,
        --Minty rock list patch target

    }

    for k,v in pairs(G.P_CENTERS) do
        if (v.minty_rock) or outside_rocks[k] then
            MINTY.rocks[v.key] = true
            table.insert(MINTY.rockbag, v.key)
        end
    end
end

---Converts a map of enhancements into an info-queue tip
---@param table table A map (list of `key = true`) of the relevant enhancements
---@param name string The name of the enhancement list
---@return table
function MINTY.enhancement_list(table, name)
  local key = 'minty_'..name..'_enhancements'
    local text = {}
    local text_parsed = {}

    for k,_ in pairs(table) do
        if G.P_CENTERS[k] then
            text[#text+1] = localize{type = 'name_text', set = 'Enhanced', key = k}
        end
    end

    for _, v in ipairs(text) do
      text_parsed[#text_parsed + 1] = loc_parse_string(v)
    end

    G.localization.descriptions.Other[key] = G.localization.descriptions.Other[key] or {}
    G.localization.descriptions.Other[key].text = text
    G.localization.descriptions.Other[key].text_parsed = text_parsed

  return {
    set = 'Other',
    key = key,
  }
end

---... from target areas, excluding self
---@param card Card|table The object that's looking at highlighted things (it won't see itself)
---@param areas table List of keys of `CardArea`s in `G`
---@return table cards List of highlighted cards
function MINTY.get_all_highlighted(card, areas)
    local cards = {}

    for _,area in ipairs(areas) do
        for _,v in ipairs(G[area].highlighted or {}) do
            if v~=card then cards[#cards+1] = v end
        end
    end

    return cards
end

---Do the tarot flip thing to all of G.hand.highlighted
---@param card Card
---@param args table|{rank:string?, suit:string?, enh:string?, edi:string?, random_ranks:table?, random_suits:table?, random_enhs:table?, random_edis:table?, seed:string?, sound:string?} Keys of the appropriate target modifications. `random_` tables are lists of same keys to pick one at random, in which case you need `seed` to seed the seed. Note: To clear an edition, pass the string "base", "none", "false", or "remove" as the edition key.
MINTY.tarotflip = function (card, args)
    if not args then
        MINTY.say("hey you forgor to say anything when trying to change these cards", "ERROR")
        return
    end
    local rank = args.rank
    local ranks = args.random_ranks
    local suit = args.suit
    local suits = args.random_suits
    local enh = args.enh
    local enhs = args.random_enhs
    local edi = args.edi
    local edis = args.random_edis
    local seed = args.seed or "minty_tarotflip_seedless_probably_shouldn't_happen_tbh"
    local sound = args.sound
    if not (rank or ranks or suit or suits or enh or enhs or edi or edis) or (rank and ranks) or (suit and suits) or (enh and enhs) or (edi and edis) or ((ranks or suits or enhs or edis) and not args.seed) then
        MINTY.say("hey you didn't type the right arguments?", "ERROR")
        tprint(args or {})
    end

    if card then
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
        end }))
    end

    if (rank or ranks or suit or suits or enh or enhs) then
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[i]:flip()
                play_sound('card1', percent)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true
            end
            }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if ranks then rank = pseudorandom_element(ranks, pseudoseed(seed)) end
                if suits then suit = pseudorandom_element(suits, pseudoseed(seed)) end
                if enhs then enh = SMODS.poll_enhancement({options = enhs, key = seed, guaranteed = true}) end
                if rank or suit then
                    assert(SMODS.change_base(G.hand.highlighted[i], suit, rank))
                end
                if enh then
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[enh])
                end
                return true
            end
            }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[i]:flip()
                play_sound(sound or 'tarot2', percent, 0.6)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true
            end
            }))
        end
    end

    if (edi or edis) then
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if edis then edi = SMODS.poll_edition({options = enhs, key = seed, guaranteed = true}) end
                if edi then
                    if edi == "base" or edi == "none" or edi == "false" or edi == "remove" then edi = nil end
                    G.hand.highlighted[i]:set_edition(edi)
                    G.hand.highlighted[i]:juice_up(0.3,0.3)
                end
                return true
            end
            }))
        end
    end

    G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.15,
    func = function()
        G.hand:unhighlight_all()
        return true
    end
    }))
    delay(0.5)
end

---Get next blind, including custom small/big blinds
---@param round string
---@return string? 
MINTY.get_blind = function (round)
    if not round then
        --figure out current round from G.GAME? Maybe not possible

        MINTY.say("Don't call MINTY.get_blind without specifying a round!", "WARN ")
        return
    elseif round == "Boss" then
        MINTY.say("Boss blind getting not implemented yet, sowwiez; using vanilla's function instead for now", "WARN ")
        return get_new_boss()
    end

    --[[ Nothing uses "perscribing" for small/big blinds yet, so disabling for now
    local perscription == "perscribed_" .. (round == "Boss" and "bosses") or round:lower()
    G.GAME[perscription] = G.GAME[perscription] or {}
    if G.GAME[perscription] and G.GAME[perscription][G.GAME.round_resets.ante] then
        local ret_blind = G.GAME[perscription][G.GAME.round_resets.ante]
        G.GAME[perscription][G.GAME.round_resets.ante] = nil
        if round == "Boss" then
            G.GAME.bosses_used[ret_blind] = G.GAME.bosses_used[ret_blind] + 1
        end
        return ret_blind
    end
    --]]

    if G["FORCE_"..round:upper()] then return G["FORCE_"..round:upper()] end

    local vanillablind = "bl_"..round:lower()

    local eligible_blinds = {[vanillablind] = true}
    for k, v in pairs(G.P_BLINDS) do
        if not v[round:lower()] then
            -- don't add
        elseif v.in_pool and type(v.in_pool) == 'function' then
            local res, options = v:in_pool()
            eligible_blinds[k] = res and true or nil
        elseif v[round:lower()].min <= math.max(1, G.GAME.round_resets.ante) then
            eligible_blinds[k] = true
        end
    end
    for k, v in pairs(G.GAME.banned_keys) do
        if eligible_blinds[k] then eligible_blinds[k] = nil end
    end
    --LOVELY TARGET: FURTHER BLIND CULLING

    --Including this here for now to not break Ortalab's stakes
    if G.GAME.modifiers.ortalab_only then
        for k, v in pairs(eligible_bosses) do
            if v and not G.P_BLINDS[k].mod or (G.P_BLINDS[k].mod.id ~= 'ortalab' and not (G.P_BLINDS[k].pools and G.P_BLINDS[k].pools.Ortalab)) then
                eligible_bosses[k] = nil
            end
        end
    end

    local blindpool = {}
    for k, v in pairs(eligible_blinds) do
        table.insert(blindpool, k)
        if G.GAME.modifiers.mintyallboost and (G.P_BLINDS[k].mod.id == "Menthol" or (G.P_BLINDS[k].pools and (G.P_BLINDS[k].pools.MintysSillyMod or G.P_BLINDS[k].pools.Menthol))) then
            table.insert(blindpool, k)
        end
    end
    --LOVELY TARGET: FURTHER BLIND BOOSTING

    local blind = pseudorandom_element(blindpool, pseudoseed('blind'))

    return blind
end

---Checks whether any of the specified rank exist in the player's entire deck
---@param rank string Key of the rank to find
---@return boolean
function MINTY.find_rank(rank)
    if not G.playing_cards then return true end
    for k, v in ipairs(G.playing_cards) do
        if v:get_id() == SMODS.Ranks[rank].id then
            return true
        end
    end
    return false
end

---Checks if you own an enhancement
---@param enh string Key of the enhancement
---@param quantum? boolean Include quantum enhancements (default false)
---@param count? boolean Return the number of found enhancements instead of a boolean
function MINTY.find_enhancement(enh, quantum, count)
    if not G.playing_cards then return count and 0 or true end
    local num = 0
    for k, v in ipairs(G.playing_cards) do
        if (v.config.center.key == enh) or quantum and SMODS.has_enhancement(v, enh) then
            num = num + 1
            if not count then return true end
        end
    end
    return count and num or num > 0
end

---Counts how many things in a given mod have been discovered
---@param mod? string ID of the mod to check for; Menthol by default
---@param set? string Type of thing to check for; Jokers by default
---@return integer
MINTY.discover_count = function(set, mod, debug)
    mod = (mod or "Menthol")
    if mod:lower() == "vanilla" then mod = "vanilla" end
    set = set or "Joker"
    local found = 0

    if debug then
        MINTY.say("Counting discovered items of set "..set.." from mod with id "..mod)
    end

    for k, v in pairs(G.P_CENTERS) do
        if v.discovered then
            if ((mod == "all") or (mod == "vanilla" and not v.mod) or (v.mod and v.mod.id == mod))
            and ((v.set == set) or (set == "all")) then
                if debug then
                    MINTY.say("Discovered center found with key "..k)
                end
                found = found + 1
            end
        end
    end

    if set:lower() == "blind" then
        for k, v in pairs(G.P_BLINDS) do
            if v.discovered then
                if ((mod == "all") or (mod == "vanilla" and not v.mod) or (v.mod and v.mod.id == mod)) then
                    if debug then
                        MINTY.say("Discovered blind found with key "..k)
                    end
                    found = found + 1
                end
            end
        end
    end

    if set:lower() == "tag" then
        for k, v in pairs(G.P_TAGS) do
            if v.discovered then
                if ((mod == "all") or (mod == "vanilla" and not v.mod) or (v.mod and v.mod.id == mod)) then
                    if debug then
                        MINTY.say("Discovered tag found with key "..k)
                    end
                    found = found + 1
                end
            end
        end
    end

    return found
end

---Faster than typing out all this crap :v 
---Remember to return `true` to resolve the event!
---@param func function The function to queue
---@param args? table Other arguments
MINTY.event = function(func, args)
    args = args or {}
    args.func = args.func or func
    G.E_MANAGER:add_event(Event(args))
end


--Talisman compatibility compatibility
to_big = to_big or function(x)
    return x
end

to_number = to_number or function(x)
    return x
end

function MINTY.select_card_from_deck(args)
    if not G.playing_cards then return nil end
    args = args or {}

    local valid_cards = {}

    for k, v in ipairs(G.playing_cards) do
        local valid = true
        valid = valid and not (args.must_be_ranked and SMODS.has_no_rank(v))
        valid = valid and not (args.must_be_suited and SMODS.has_no_suit(v))
        valid = valid and not (args.exclude_suit and v:is_suit(args.exclude_suit))
        if valid then
            valid_cards[#valid_cards+1] = v
        end
    end
    if valid_cards[1] then
        return pseudorandom_element(valid_cards, pseudoseed((args.seed or "minty_select_random_card")))
    end
end

---Shuffles which suit is made equivalent to 3s by Treat-o-vision; pulls a random card with a non-3 suit from the deck and uses that.
function MINTY.reset_treat_card()
    G.GAME.treatovision_suit = 'Spades'
    local valid_treat_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(v) and v.base.suit ~= 'minty_3s' then
            valid_treat_cards[#valid_treat_cards+1] = v
        end
    end
    if valid_treat_cards[1] then
        local treat_card = pseudorandom_element(valid_treat_cards, pseudoseed('treat'..G.GAME.round_resets.ante))
        G.GAME.treatovision_suit = treat_card.base.suit
    end
    --sendDebugMessage('[Minty] Treat-o-vision suit reset to '..G.GAME.treatovision_suit)
end

function SMODS.current_mod.reset_game_globals(init)
    G.GAME.languageEgg = G.GAME.languageEgg or {}
    local lang = G.SETTINGS.language
    if lang == "suitnames_en" then lang = "en-us" end
    G.GAME.languageEgg[lang] = true

    if init or not G.GAME.starting_params.minty_three_lock then
        G.GAME.starting_params.minty_three_lock = MINTY.config.three_lock.current_option
    end
    if init then
        G.GAME.minty_no_dumb_shit = MINTY.config.no_dumbass_shit
        G.GAME.minty_crossover = MINTY.config.include_crossover
    end

    G.GAME.minty_hyperfix = G.GAME.minty_hyperfix or { active = true, value = 0 }
    if G.GAME.minty_hyperfix.active and not init then
        G.GAME.minty_hyperfix.value = (G.GAME.minty_hyperfix.value or 0) + 1
    end

    MINTY.reset_treat_card()
end

SMODS.current_mod.set_debuff = function (card)
  if
    card.seal == "minty_cement"
    or SMODS.has_enhancement(card, "m_minty_marble")
    or (card.ability or {}).dekaja == G.GAME.round
  then
     return "prevent_debuff"
  end
end


SMODS.current_mod.calculate = function (self, context)
    if context.using_consumeable then
        local legmap = {
            c_soul = true,
            c_minty_wand = true
        }

        local key = context.consumeable.config and context.consumeable.config.center and context.consumeable.config.center.key or "nope"

        if legmap[key] then
            G.GAME.soul_or_wand_used = true
        end
    end

    if context.setting_blind and G.GAME.minty_total_piracy_punishment then
        local final_chips = to_big(G.GAME.blind.chips * (1.03 ^ G.GAME.minty_total_piracy_punishment))
        G.GAME.blind.chips = final_chips
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end

    if G.GAME.real_banned_keys and not G.pack_cards then --Failsafe for mod boosters
        G.GAME.banned_keys = G.GAME.real_banned_keys
        G.GAME.real_banned_keys = nil
    end

    if (G.GAME.modifiers.minty_taxation and G.GAME.modifiers.minty_taxation ~= 0) and context.initial_scoring_step then
        return {
            mult = G.GAME.dollars * -G.GAME.modifiers.minty_taxation
        }
    end
end


MINTY.enhancecheck = function()
    MINTY.say("Building Inkbleed table...")
    MINTY.inkbleedtable = MINTY.inkbleedtable or {}
    for k,v in pairs(G.P_CENTERS) do
        if v.set == "Enhanced" then
            for kk, vv in pairs(G.P_CENTERS) do
                if vv.set == "Enhanced" then
                    if (localize{type = 'name_text', set = 'Enhanced', key = k} == localize{type = 'name_text', set = 'Enhanced', key = kk}) and (k ~= kk) then
                        local k1, k2 = v.key, vv.key
                        MINTY.inkbleedtable[k1] = MINTY.inkbleedtable[k1] or {}
                        MINTY.inkbleedtable[k1][k2] = true

                        MINTY.inkbleedtable[k2] = MINTY.inkbleedtable[k2] or {}
                        MINTY.inkbleedtable[k2][k1] = true
                    end
                end
            end
        end
    end
end

---Checks whether one stake is above another
---@param stake number|string Index or key of stake to evaluate
---@param target number|string Index or key of stake we're checking against
---@return boolean
MINTY.at_least_stake = function (stake, target)
    if not (stake and target) then return false end
    local stake_index, target_index, stake_key, target_key
    if type(stake) == "string" then
        stake_key = stake
        stake_index = SMODS.Stakes[stake].order
    end
    if type(stake) == "number" then
        stake_key = G.P_CENTER_POOLS.Stake[stake].key
        stake_index = stake
    end
    if type(target) == "string" then
        target_key = target
        target_index = SMODS.Stakes[target].order
    end
    if type(target) == "number" then
        target_key = G.P_CENTER_POOLS.Stake[target].key
        target_index = target
    end

    if stake_key == target_key then return true end

    local function get_all_applied_stakes(key, ret)
        ret = ret or {}
        for _,v in ipairs(SMODS.Stakes[key].applied_stakes) do
            ret[v] = true
            get_all_applied_stakes(v, ret)
        end
        return ret
    end

    local stakes = get_all_applied_stakes(stake_key)
    return stakes[target_key] == true--, stakes
end

MINTY.get_all_top_stakes = function()
    local stakes = {}
    for k,v in pairs(SMODS.Stakes) do
        if k ~= "stake_minty_barber" then
            if stakes[k] == nil then stakes[k] = true end
            for _,vv in ipairs(v.applied_stakes) do
                stakes[vv] = false
            end
        end
    end
    local ret = {}
    for k,v in pairs(stakes) do
        if v == true then
            ret[#ret+1] = k
        end
    end

    return ret
end

MINTY.gradient_check = function ()
    if not dp then return end
    loc_colour()
    for k, v in pairs(G.ARGS.LOC_COLOURS) do
        if v[1] and string.find(k, "menthol") then dp.handleLog(v, "INFO", k) end
    end
end

SMODS.current_mod.process_loc_text = function()
    G.localization.descriptions.Enhanced.m_stone_alt = G.localization.descriptions.Enhanced.m_stone_alt or {}
    G.localization.descriptions.Enhanced.m_stone_alt.text = G.localization.descriptions.Enhanced.m_stone.text
end