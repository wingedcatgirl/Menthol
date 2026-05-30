---@diagnostic disable: duplicate-set-field
-- Modified code from https://github.com/Foo54/SynthB/blob/main/src/api/useable_joker.lua
-- which in turn modified it from spectrallib https://github.com/SpectralPack/Spectrallib/blob/main/Entropy/card_buttons.lua ahahaha there is so much going on in here i am NOT touching that

local myprefix = SMODS.current_mod.prefix

G.FUNCS[myprefix .. "_can_use_joker"] = function(e)
    local center = e.config.ref_table.config.center
    local card = e.config.ref_table

    if not center.use then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
    
    if
        (not center.can_use or center:can_use(e.config.ref_table)) and not e.config.ref_table.debuff
        and G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT
        and not (((G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)))
    then
        e.config.colour = G.C.ORANGE
        e.config.button = myprefix .. "_use_joker"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS[myprefix .. "_use_joker"] = function(e)
    local int = G.TAROT_INTERRUPT
    G.TAROT_INTERRUPT = true
    local center = e.config.ref_table.config.center
    if center.use then
        center:use(e.config.ref_table)
    end
    e.config.ref_table:juice_up()
    G.TAROT_INTERRUPT = int
end

local function gen_button(args, card)
    card = card or args.card
    local button_config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = args.one_press, button = args.effect, func = args.can, handy_insta_action = args.handy_insta }
    local title = args.title and {
        n = G.UIT.R,
        config = { align = "cm", maxw = 1.25, debug = "gentitle" },
        nodes = {
            { n = G.UIT.T, config = { text = args.title, colour = args.title_colour or G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
        }
    } or nil
    local text = {}
    if type(args.text) == "string" then
        text[1] = { n = G.UIT.T, config = { text = args.text, colour = args.text_colour or G.C.WHITE, scale = args.text_scale or 0.55, shadow = true } }
    else
        for i, subtext in ipairs(args.text) do
            local node = { n = G.UIT.T, config = { colour = subtext.colour or G.C.WHITE, scale = subtext.scale or 0.4, shadow = true } }
            if type(subtext) == "string" then
                node.config.text = subtext
            elseif type(subtext) == "table" then
                for k, v in pairs(subtext) do
                    local key, arg = k, v
                    if string.find(k, "_arg$") then
                        key = string.gsub(arg, "_arg$", "")
                        arg = args[v]
                    end
                    node.config[key] = arg
                end
            end
            text[i] = node
        end
    end
    local all_text = {}
    if title then all_text[#all_text+1] = title end
    all_text[#all_text+1] = {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = text
    }

    local locs = {
        top = "t",
        high = "t",
        center = "c",
        middle = "c",
        mid = "c",
        bottom = "b",
        bot = "b",
        low = "b",
    }

    return {
        n = G.UIT.R,
        config = { align = 'cl' },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cr" },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = button_config,
                        nodes = {
                            { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                            {
                                n = G.UIT.C,
                                config = { align = "tm" },
                                nodes = all_text
                            }
                        }
                    },
                }
            }
        }
    }
end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local orig_btns = G_UIDEF_use_and_sell_buttons_ref(card)
    if card.config.center.set ~= "Joker" or (card.area and card.area.config.collection) then return orig_btns end

    local center = card.config.center

    local sell_args = {
        card = card,
        id = "sell",
        can = "can_sell_card",
        effect = "sell_card",
        handy_insta = "sell",
        title = localize("b_sell"),
        one_press = true,
        text = {
            localize("$"),
            { ref_table = card, ref_value = "sell_cost_label", scale = 0.55 }
        }
    }
    local use_args = {
        card = card,
        id = "use",
        can = myprefix .. "_can_use_joker",
        effect = myprefix .. "_use_joker",
        handy_insta = "use",
        text = localize("b_use")
    }
    local fuse_args = {
        card = card,
        id = "fuse",
        can = "can_fuse_card",
        effect = "fuse_card",
        title = localize("b_fuse"),
        text = {
            localize("$"),
            { ref_table = card, ref_value = "fusion_cost" }
        }
    }

    local pre_buttons = {}

    if not (center.hide_sell_button and center:hide_sell_button(card)) then
        pre_buttons[#pre_buttons+1] = sell_args
    end
    if center.use and not (center.hide_use_button and center:hide_use_button(card)) then
        print("Creating use button")
        pre_buttons[#pre_buttons+1] = use_args
    end

    if center.buttons then
        local to_override = {}
        for i,button in ipairs(center.buttons) do
            args = button.get_button_args(center, card)
            if not (button.hide and button.hide(center, card)) then
                if to_override[args.id or ""] then
                    args = to_override[args.id]
                    to_override[args.id] = nil
                    args.override = nil
                end
                
                if type(args.override) == "string" then
                    overridden = false
                    for ii,vv in ipairs(pre_buttons) do
                        if vv.id == args.override then
                            pre_buttons[ii] = args
                            break
                        end
                    end
                    if not overridden then
                        to_override[args.override] = args
                    end
                elseif #pre_buttons < 3 then
                    pre_buttons[#pre_buttons+1] = args
                else
                    pre_buttons[math.random(1,3)] = args --Horribly, horribly inelegant, but at least ensures excess buttons can appear at all. Probably avoid causing this situation if you can!!!
                end
            end
        end
    end

    local indiv_buttons = {}
    for i,args in ipairs(pre_buttons) do
        local locs = {"top", "middle", "bottom"}
        args.loc = locs[i]
        indiv_buttons[i] = gen_button(args, card)
    end
    
    local final_nodes = {
        n = G.UIT.ROOT,
        config = { padding = 0, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.15, align = 'cl' },
                nodes = indiv_buttons
            },
        }
    }




    return final_nodes
end