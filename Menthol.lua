MINTY = MINTY or {}
MINTY.prefix = SMODS.current_mod.prefix
MINTY.config = SMODS.current_mod.config

SMODS.current_mod.debug_info = {}

local fujo = SMODS.find_mod("FusionJokers")[1]
local bunco = SMODS.find_mod("Bunco")[1]

if fujo and not fujo.version then
    SMODS.current_mod.debug_info = {
        "You're using an outdated and abandoned version of Fusion Jokers!",
        "Please update to the version we're maintaining, located here:",
        "https://github.com/wingedcatgirl/Fusion-Jokers"
    }
end

if bunco then --Not sure this one actually works, but worth putting it in just to see
    local ver = bunco.version
    if not (ver and string.find(ver, "JumboFork")) then
        SMODS.current_mod.debug_info[#SMODS.current_mod.debug_info+1] = "You're using an outdated and abandoned version of Bunco!"
        SMODS.current_mod.debug_info[#SMODS.current_mod.debug_info+1] = "Please update to the version JumboCarrot is maintaining, located here:"
        SMODS.current_mod.debug_info[#SMODS.current_mod.debug_info+1] = "https://github.com/jumbocarrot0/Bunco"
    end
end

if not SMODS.current_mod.lovely then
    NFS.write(SMODS.current_mod.path .. '.lovelyignore', '')
    error("Menthol: Lovely patches failed! Please make sure the file structure is not nested. The mod will be automatically disabled on restart.")
end

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    post_trigger = true,
    quantum_enhancements = true,
    cardareas = {
        unscored = true,
    },
}

SMODS.ObjectType({ --Kity pool (Legendary and otherwise)
    key = "kity",
    default = "j_lucky_cat",
	cards = {
        ["j_lucky_cat"] = true,
        ["j_pl_black_cat"] = true,
        ["j_neat_tabbycat"] = true,
        ["j_ortalab_black_cat"] = true,
    },
})

if not SMODS.ObjectType.Food then
    SMODS.ObjectType({
        key = "Food",
        default = "j_popcorn",
        cards = {
            ["j_gros_michel"] = true,
            ["j_egg"] = true,
            ["j_ice_cream"] = true,
            ["j_cavendish"] = true,
            ["j_turtle_bean"] = true,
            ["j_diet_cola"] = true,
            ["j_popcorn"] = true,
            ["j_ramen"] = true,
            ["j_selzer"] = true,
        },
    })
end

SMODS.ConsumableType{
    key = "minty_treat",
    default = "c_minty_funnel_cake",
    select_card = function (self, card, pack)
        if pack.kind == "minty_everycard" then return "consumeables" end
        return false
    end,
    primary_colour = G.C.PURPLE,
    secondary_colour = HEX("ca7ca7")
}

SMODS.ConsumableType{
    key = "minty_cobalt",
    default = "c_minty_backup_plan",
    primary_colour = G.C.CHIPS,
    secondary_colour = G.C.SECONDARY_SET.Spectral
}

local files = {
    { name = "lib", contents = {
        { name = "atlases" },
        { name = "attributes" },
        { name = "gradience" },
        { name = "functions" },
        { name = "hooks" },
        { name = "achievements" },
        { name = "sounds" },
        { name = "configui" },
        { name = "rarity" },
        { name = "quips" },
        { name = "bluehairand", mods = { { id = "cardpronouns" } } },
    } },
    { name = "suits", contents = {
        { name = "3suit" }
    } },
    { name = "ranks", contents = {
        { name = "face" },
        { name = "number" },
    } },
    { name = "jokers", contents = {
        --Tweaks to existing Jokers 
        { name = "vanillatweaks" },
        --Common Jokers
        { name = "froyo" },
        { name = "hedonist" },
        { name = "languageegg" },
        { name = "prosopagnosia" },
        { name = "phasebus" },
        { name = "slowtiger" },
        { name = "cube" },
        { name = "eaten" },
        { name = "excited" },
        { name = "chisel" },
        { name = "bucket" },
        { name = "chocobar" },
        { name = "duckhat" },
        { name = "bonkdice",  },
        { name = "optimist" },
        --{ name = "ascetic" }, --Disabled til we replay Ortalab again
        { name = "churu",  },
        { name = "flexweirdo" },
        { name = "numberslop" },
        --Uncommon Jokers
        { name = "altar" },
        { name = "atheismcorner" },
        { name = "bigpockets" },
        { name = "cakesword" },
        { name = "catcafe" },
        { name = "catnipfields" },
        { name = "claw" },
        { name = "clock" },
        { name = "contraption" },
        { name = "fatcat-l" }, --Literal (Tubbs)
        { name = "fatcat-m" }, --Metaphorical (Jeff Bezos catgirl)
        { name = "hamburger" },
        { name = "nucleation" },
        { name = "treatovision" },
        { name = "obsession" },
        { name = "printer" },
        { name = "peywet", },
        --{ name = "inkbleed" }, --Dummied for now cause it's really janky
        { name = "copycat" },
        { name = "shadowcrystal" },
        { name = "fate" },
        --{ name = "sabertooth" }, --Disabled til we replay Ortalab again
        { name = "neko" },
        { name = "catpicmachine", },
        --Rare Jokers
        { name = "wildsupport" },
        { name = "gymbuddy" },
        { name = "scoundrel" },
        { name = "cakegun" },
        { name = "youtube" },
        { name = "manacompressor" }, --Allowed to stay because it's less janky than Inkbleed, but comment this line if it gives you trouble
        { name = "pessimist" },
        { name = "doctor" },
        { name = "hyperfix" },
        { name = "lazarus" },
        { name = "jacobsladder" },
        { name = "prism" },
        --Fusion Jokers
        { name = "threecats", mods = { {id = "FusionJokers"} } },
        { name = "parkour", mods = { {id = "FusionJokers"} } },
        { name = "wildfire", mods = { {id = "FusionJokers"} } },
        { name = "superboss", mods = { {id = "FusionJokers"} } },
        { name = "wettiger", mods = { {id = "FusionJokers"}, {id = "Tsunami"} } },
        { name = "shakegun", mods = { {id = "FusionJokers"}, {id = "Tsunami"} } },
        --{ name = "ninethlion", mods = { {id = "FusionJokers"} }, dev = true },
        --Special Jokers
        { name = "theecho", mods = { { id = "ChDp" } } },
        --Showdown Jokers (become Legendary if Finity is not active)
        { name = "calico" },
        --Legendary Jokers
        { name = "lucky" },
        { name = "stormy" },
        { name = "patchy" },
        { name = "minty" },
        { name = "garfielf" },
        --{ name = "lune" }
    } },
    { name = "tarots", contents = {
        { name = "abacus", },
        { name = "battery" },
        { name = "bitz" },
        { name = "boredchild" },
        { name = "cat" },
        { name = "dorf" },
        { name = "focus" },
        { name = "grin", },
        { name = "gleam" },
        { name = "geologist" },
        { name = "headband" },
        { name = "magnet" },
    } },
    { name = "spectrals", contents = {
        { name = "sixyears" },
        { name = "dekaja" },
        { name = "delicacy" },
        { name = "piracy" },
        { name = "reincarnate" },
        { name = "wand" },
        --{ name = "testcard" },
    } },
    { name = "treats", contents = {
        { name = "choccy" },
        { name = "mint ice cream" },
        { name = "blueberry pie" },
        { name = "funnel cake" },
    } },
    { name = "boosters", contents = {
        { name = "modpacks" },
        { name = "packofeverycard" },
        { name = "treat" },
    } },
    { name = "consumables", contents = {
        { name = "colors", mods = { { id = "MoreFluff", cfg = "Colour Cards" } } },
        { name = "rotarots", mods = { { id = "MoreFluff", cfg = "45 Degree Rotated Tarot Cards" } } },
        { name = "gemstones", mods = { { id = "Gemstone" } } },
        { name = "drafts", mods = { { id = "draft", version = "0.6.0" } } },
    } },
    { name = "tags", contents = {
        { name = "goading" },
        { name = "menu" },
    } },
    { name = "vouchers", contents = {
        { name = "topplepaws" },
        { name = "buoyancy" },
        { name = "suggestion" },
        { name = "treasure" },
    } },
    { name = "modifiers", contents = {
        { name = "marble" }, --Enhancements
        { name = "microcline" },
        { name = "crystal" },
        { name = "hematite" },
        { name = "static" },
        { name = "garbled" }, --Rotarot enhancements
        { name = "pistol" },
        { name = "spline" },
        { name = "dynamite" },
        { name = "emphatic" },
        { name = "drained" }, --Editions
        { name = "cementseal" }, --Seals
        { name = "counterfeit" }, --Stickers
        { name = "hooked" },
        { name = "pirated" },
        { name = "catears" },
    } },
    { name = "backs", contents = {
        { name = "treat" },
        --{ name = "club" },    --
        --{ name = "diamond" }, --
        --{ name = "heart" },   -- Yeah, you can bring them back if you really want to. Don't recommend it, but you can!
        --{ name = "spade" },   --
        --{ name = "3" },       --
        { name = "plasmaathome" },
        { name = "suitfocus" },
        { name = "drippy" },
        { name = "silly" },
    } },
    { name = "blinds", contents = {
        { name = "aclaw"},
        { name = "atooth"},
        { name = "apaw"},
        { name = "atail"},
        { name = "thenip" },
        --{ name = "thetree" }, Disabled til we play Ortalab again
        { name = "theclowder" },
        { name = "calico" },
        { name = "thenipdx" },
    } },
    { name = "hands", contents = {
        { name = "handful" },
    } },
    { name = "planets", contents = {
        { name = "handfuls" },
    } },
    { name = "stakes", contents = {
        { name = "stakes" },
    } },
    { name = "challenge", contents = {
        { name = "raidnight" },
        { name = "backalley" },
        { name = "cosmoport" },
        { name = "taxfraud" },
    } },
    { name = "etc", contents = {
        { name = "backupplan" }
    } },
}

for _, folder in ipairs(files) do
    for _, data in ipairs(folder.contents) do
        if data.dummy then goto nvm end
        local load = true
        local name = data.name
        local mods = data.mods
        local incompat = data.incompat
        if mods then
            sendTraceMessage("Checking required mods for "..folder.name..'/'..name..".lua", "Menthol")
            for _, mod in ipairs(mods) do
                load = load and (SMODS.Mods[mod.id] or {}).can_load
                if mod.cfg then
                    sendTraceMessage("Checking config "..mod.cfg.." for "..folder.name..'/'..name..".lua", "Menthol")
                    load = load and SMODS.Mods[mod.id].config[mod.cfg]
                end
                if mod.version then load = load and ((SMODS.Mods[mod.id] or {}).version >= mod.version) end
            end
        end
        if load and incompat then
            sendTraceMessage("Checking conflicting mods for "..folder.name..'/'..name..".lua", "Menthol")
            for _, mod in ipairs(incompat) do
                load = load and not (SMODS.Mods[mod.id] or {}).can_load
            end
        end
        if load and data.dev then
            sendTraceMessage("Checking dev mode option for "..folder.name..'/'..name..".lua", "Menthol")
            load = load and MINTY.config.dev_mode
        end
        if load then
            sendTraceMessage("Loading file: "..folder.name..'/'..name..'.lua', "Menthol")
            local loaded,errormessage = pcall(SMODS.load_file(folder.name..'/'..name..'.lua'))
            if not loaded then
                local disable = not MINTY.config.dev_mode and "\nThe mod will be automatically disabled on restart." or ""
                if not MINTY.config.dev_mode then
                    NFS.write(SMODS.current_mod.path .. '.lovelyignore', '')
                end
                sendErrorMessage(errormessage, "Menthol")
                error("Menthol: File '"..folder.name.."/"..name..".lua' failed to load!\n   "..errormessage.."\nPlease make sure there's nothing fucky with your file structure."..disable)
            end


        else
            sendTraceMessage("Skipping file: "..folder.name..'/'..name..'.lua', "Menthol")
        end
        ::nvm::
    end
end

SMODS.current_mod.menu_cards = function ()
    return {
        func = function ()
            local enh = SMODS.poll_enhancement{
                guaranteed = true,
                options = {
                    "m_minty_spline",
                    "m_minty_pistol",
                    "m_minty_emphatic",
                    "m_minty_dynamite",
                    "m_minty_static"
                },
                key = tostring(os.time())
            }
            local card
            for i,v in ipairs(G.title_top.cards) do
                if v.is_suit and v:is_suit("Spades") then --Probably the vanilla ace of spades
                    card = v
                    card:set_ability(enh)
                    assert(SMODS.change_base(card, "minty_3s", "3"))
                    if next(SMODS.find_mod("Gemstone")) then
                        Gemstones.set_gemslot(card, "gemslot_catseye")
                    end
                    card.click = function(self)
                        if self.is_3 and self:is_3() then --Only as long as it still counts as a 3
                            G.FUNCS["openModUI_Menthol"]()
                        end
                    end
                    break
                end
            end
        end
    }
end

MINTY.lastmoment = function ()
    MINTY.say("Running last-moment code...")
    MINTY.rocklist()
    if G.P_CENTERS.j_minty_inkbleed then --No point actually *doing* this if Inkbleed is still dummied
        MINTY.enhancecheck()
    end

    MINTY.packable_mods = {}
    MINTY.modbag = {}
    MINTY.vjokers = {}
    for k,v in pairs(G.P_CENTERS) do
        local normal = {
            [1] = true,
            [2] = true,
            [3] = true,
        }
        if v.set == "Joker" and normal[v.rarity] then
            if v.original_mod then
                if not MINTY.packable_mods[v.original_mod.id] then
                    MINTY.packable_mods[v.original_mod.id] = {
                        id = v.original_mod.id,
                        name = v.original_mod.name,
                        shortname = v.original_mod.display_name,
                        colour = v.original_mod.badge_colour,
                        count = 1
                    }
                else
                    MINTY.packable_mods[v.original_mod.id].count = MINTY.packable_mods[v.original_mod.id].count + 1
                end
            else
                MINTY.vjokers[#MINTY.vjokers+1] = k
            end
        end
    end
    for k,v in pairs(copy_table(MINTY.packable_mods)) do
        if v.count < 6 then
            MINTY.packable_mods[k] = nil
        else
            for _=1,math.ceil(math.log(v.count, 7)) do
                MINTY.modbag[#MINTY.modbag+1] = k
            end
        end
    end

    --Set applied stakes of the "applies every stake" stake. If we invent that.
    --[[
    if G.P_STAKES.stake_minty_barber then
        G.P_STAKES.stake_minty_barber.applied_stakes = {}
        local stakes = MINTY.get_all_top_stakes()
        G.P_STAKES.stake_minty_barber.applied_stakes = stakes
    end
    --]]

    --Put vanilla ranks in first slot of prev table, where they belong.
    for k,v in pairs(SMODS.Ranks) do
        if v.prev and type(v.prev[1]) == "string" and v.prev[2] and string.find(v.prev[1], "minty_") then
            for ii,vv in ipairs(v.prev) do
                if SMODS.Ranks[vv] and not SMODS.Ranks[vv].original_mod then
                    v.prev[1], v.prev[ii] = v.prev[ii], v.prev[1]
                    break
                end
            end
        end
    end

    if Cryptid and cry_best_interest_cap and not MINTY.cbic_override then --Gotta put it here cause priority~ Cryptid will probably fix this on their end soon-ish but for now this at least makes sure ducks are accounted for
        MINTY.cbic_override = true --Only do it once
        local cbic = cry_best_interest_cap
        function cry_best_interest_cap()
            local best = cbic()
            if next(SMODS.find_card("j_minty_duckhat")) then
                for i,v in ipairs(SMODS.find_card("j_minty_duckhat")) do
                    if v.ability.immutable.actualinterestchange > 0 then
                        best = best + (v.ability.immutable.actualinterestchange * 5) --:thunk: momence; he hardcoded the interest rate
                    end
                end
            end
            return best
        end
    end

    -- Reassociate fallback for custom ranks for mods that load after this one
    MINTY.build_face_rank()
    MINTY.build_number_rank()

    SMODS.Ranks["minty_face"].next = MINTY.face_rank_all_faces
    SMODS.Ranks["minty_face"].suit_map = MINTY.face_rank_suit_map
    SMODS.Ranks["minty_number"].next = MINTY.number_rank_all_numbers
    SMODS.Ranks["minty_number"].suit_map = MINTY.number_rank_suitmap

    for p_card, data in pairs(G.P_CARDS) do
        if string.find(p_card, "_minty_F") then
            data.lc_atlas = SMODS.Ranks["minty_face"].lc_atlas
            data.hc_atlas = SMODS.Ranks["minty_face"].hc_atlas
            data.pos = {
                x = SMODS.Ranks["minty_face"].pos.x,
                y = MINTY.face_rank_suitmap[data.suit]
            }
        end
        if string.find(p_card, "_minty_N") then
            data.lc_atlas = SMODS.Ranks["minty_number"].lc_atlas
            data.hc_atlas = SMODS.Ranks["minty_number"].hc_atlas
            data.pos = {
                x = SMODS.Ranks["minty_number"].pos.x,
                y = MINTY.number_rank_suitmap[data.suit]
            }
        end
    end


end
----