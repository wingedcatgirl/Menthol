local toga = next(SMODS.find_mod("TOGAPack"))

SMODS.Joker {
    key = "neko",
    name = "neko.exe",
    pronouns = "it_its",
    atlas = 'neko',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },
    display_size = { w = 48, h = 65 },
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    pools = {
        ["kity"] = true
    },
    config = {
        extra = {
            chips = 133,
            state = "wait",
            lastsprite = {
                "wait", 0
            },
            timer = 0,
            motion = {
                dir = "none",
                duration = 0
            },
        }
    },
    attributes = {
        "kity", "chips"
    },
    loc_vars = function(self, info_queue, card)
        if MINTY.in_collection(card) and not (toga or MINTY.config.dev_mode or G.GAME.minty_crossover) then
            info_queue[#info_queue+1] = { set = "Other", key = "minty_disabled_object_requirement", specific_vars = { "Mod", "TOGA's Stuff" } }
        end
        local key = self.key
        local main_end = MINTY.flavorize(self.key)
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    in_pool = function (self, args)
        if AKYRS and AKYRS.card_any_drag() then return false end --Aikoyori if you want to put in a PR to let the kitty run in all zones please do, because I do not know how to begin figuring that out 
        return ((not not toga) or MINTY.config.dev_mode or G.GAME.minty_crossover)
    end,
    calculate = function(self, card, context)
        if (context.joker_main and context.scoring_hand) or context.forcetrigger then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    update = function (self, card, dt)
        local succ,vis = pcall(function ()return card.states.visible end)
        if not (succ and vis) then
            MINTY.say("neko's update is being called when it is not visible, probably bad?", "WARN ")
            return
        end
        local area = card.area
        if G.your_collection then
            for k, v in pairs(G.your_collection) do
                if area == v then
                    return --Neko can theoretically chase in collection but its timer doesn't update there, TODO fix this probably
                end
            end
        end
        card.ability.extra.timer = (card.ability.extra.timer or 0) + dt
        if card.ability.extra.timer > (G.SETTINGS.GAMESPEED * 0.25) then
            card.ability.extra.timer = 0
            card.ability.extra.motion.duration = card.ability.extra.motion.duration + 1
        else
            return
        end
        if card.ability.extra.state == "alert" and card.ability.extra.motion.duration <= 5 then
            return
        end

        local states = {
            --state name = soul x pos 
            wait = 1,
            wash = 2,
            scratchself = 3,
            yawn = 4,
            nap = 5,
            alert = 6,
            chasedown = 7,
            chasedownright = 8,
            chaseright = 9,
            chaseupright = 10,
            chaseup = 11,
            chaseupleft = 12,
            chaseleft = 13,
            chasedownleft = 14,
            scratchd = 15,
            scratchr = 16,
            scratchu = 17,
            scratchl = 18,
        }
        local jokerref = card.config.center


        -- get positions of mouse and joker
        local mousepos = {}
        mousepos.x, mousepos.y = math.floor(G.CURSOR.T.x*4)/4, math.floor(G.CURSOR.T.y*4)/4
        local jokerpos = {}
        jokerpos.x, jokerpos.y = math.floor((card.T.x+2.5)*4)/4, math.floor((card.T.y+2)*4)/4
        --math out the direction
        local dx = jokerpos.x - mousepos.x
        local dy = jokerpos.y - mousepos.y

        local angle_rad = math.atan2(dy, dx)
        local angle_deg = math.deg(angle_rad)
        angle_deg = (angle_deg + 360) % 360

        local index = math.floor((angle_deg + 22.5) / 45) % 8
        local compass = { "left", "upleft", "up", "upright", "right", "downright", "down", "downleft" }
        local direction = compass[index+1]
        if (math.abs(dx) <= 1 and math.abs(dy) <= 1.25) or card.highlighted then
            direction = "close"
        end
        --MINTY.say("Joker position: "..jokerpos.x..", "..jokerpos.y.."; Mouse position: "..mousepos.x..", "..mousepos.y.."; Direction: "..direction, "TRACE")

        if (card.ability.extra.state == "nap" or card.ability.extra.state == "yawn" or card.ability.extra.state == "wait") and direction ~= "close" then
            card.ability.extra.state = "alert"
            card.ability.extra.motion = {
                dir = "none",
                duration = 0
            }
        end

        -- update joker state based on this info 
        local joker_slot = nil
        for i = 1, #area.cards do
            if area.cards[i] == card then
                joker_slot = i
                break
            end
        end
        local leftmost = (joker_slot == 1)
        local rightmost = (joker_slot == #area.cards)
        -- TBA

        -- update soul sprite based on state
        jokerref.soul_pos.x = states[card.ability.extra.state]

        if direction == "close" then
            if (card.ability.extra.state ~= "wait"
            and card.ability.extra.state ~= "yawn"
            and card.ability.extra.state ~= "wash"
            and card.ability.extra.state ~= "nap")
            then
                card.ability.extra.state = "wait"
            end
        elseif "chase"..direction ~= card.ability.extra.state then
            card.ability.extra.state = "chase"..direction
        end

        if (card.ability.extra.state ~= "wait"
        and card.ability.extra.state ~= "yawn"
        and card.ability.extra.state ~= "alert")
        then
            jokerref.soul_pos.y = math.fmod(jokerref.soul_pos.y+1, 2)
        end
        --MINTY.say(tostring(jokerref.soul_pos.y), "TRACE")

        -- move joker to left or right if it's been in one of the lateral chase states long enough
        local lastdir = card.ability.extra.motion.dir
        --get current direction and reset tracking if it's changed
        if string.find(card.ability.extra.state, "left") then
            if lastdir ~= "left" then card.ability.extra.motion = {
                dir = "left",
                duration = 0
            }
            end
            if leftmost then
                card.ability.extra.state = "scratchl"
                lastdir = "none"
            end
        elseif string.find(card.ability.extra.state, "right") then
            if lastdir ~= "right" then card.ability.extra.motion = {
                dir = "right",
                duration = 0
            }
            end
            if rightmost then
                card.ability.extra.state = "scratchr"
                lastdir = "none"
            end
        else
            if lastdir ~= "none" then
                card.ability.extra.motion = {
                    dir = "none",
                    duration = 0
                }
            end
            if direction == "up" then
                card.ability.extra.state = "scratchu"
                lastdir = "none"
            elseif direction == "down" then
                card.ability.extra.state = "scratchd"
                lastdir = "none"
            end
        end

        if card.ability.extra.lastsprite ~= {card.ability.extra.state, jokerref.soul_pos.y} then
            card.ability.extra.lastsprite = {card.ability.extra.state, jokerref.soul_pos.y}
            card:set_sprites(jokerref)
        end

        if not joker_slot then
            MINTY.say("neko's update is being called when it's not in an area, send your mod list so i can figure out why", "WARN ")
            return
        end

        if card.ability.extra.motion.duration >= 5 and lastdir ~= "none" then --it's been running long enough
            card.ability.extra.motion.duration = 0
            if not leftmost and lastdir == "left" then
                area.cards[joker_slot-1], area.cards[joker_slot] = area.cards[joker_slot], area.cards[joker_slot-1]
            elseif not rightmost and lastdir == "right" then
                area.cards[joker_slot], area.cards[joker_slot+1] = area.cards[joker_slot+1], area.cards[joker_slot]
            end
        elseif card.ability.extra.motion.duration >= 10 and lastdir == "none" then
            if card.ability.extra.state == "wait" then
                card.ability.extra.state = "yawn"
                card.ability.extra.motion.duration = 6
            elseif card.ability.extra.state == "yawn" then
                card.ability.extra.state = "nap"
                card.ability.extra.motion.duration = 0
            end
        end
    end
}