local toga = next(SMODS.find_mod("TOGAPack"))

SMODS.Joker {
    key = "neko",
    name = "neko.exe",
    pronouns = "it_its",
    atlas = 'neko_alt',
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
    set_ability = function (self, card, initial, delay_sprites)
        card.children.center:set_state("base")
    end,
    load = function (self, card, card_table, other_card)
        MINTY.event(function ()
            if not (card.children and card.children.center and card.children.center.set_state) then return false end

            card.children.center:set_state("base")
            return true
        end, {blocking = false, blockable = false})
    end,
    update = function (self, card, dt)
        local succ,vis = pcall(function ()return card.states.visible end)
        if not (succ and vis) then
            MINTY.say("neko's update is being called when it is not visible, probably bad?", "WARN ")
            return
        end
        local area = card.area
        if not area then return end
        if area.config.collection then
            return --Neko can theoretically chase in collection but its timer doesn't update there, TODO fix this probably
        end
        card.ability.extra.timer = (card.ability.extra.timer or 0) + dt
        --print(card.ability.extra.timer)
        if card.ability.extra.timer > (G.SETTINGS.GAMESPEED * 0.25) then
            card.ability.extra.timer = 0
            card.ability.extra.motion.duration = card.ability.extra.motion.duration + 1
        end
        if card.children.floating_sprite.state.key == "alert" and card.ability.extra.motion.duration <= 4 then
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

        if (card.children.floating_sprite.state.key == "nap" or card.children.floating_sprite.state.key == "yawn" or card.children.floating_sprite.state.key == "wait") and direction ~= "close" then
            card.children.floating_sprite:set_state("alert")
            card.ability.extra.motion = {
                dir = "none",
                duration = 0
            }
            return
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

        do
            local key = card.children.floating_sprite.state.key
            local dirmap = {
                up = "u",
                down = "d",
                left = "l",
                upleft = "l",
                downleft = "l",
                right = "r",
                upright = "r",
                downright = "r",
            }
            if direction == "close" then
                if (key ~= "wait"
                and key ~= "yawn"
                and key ~= "wash"
                and key ~= "nap")
                then
                    card.children.floating_sprite:set_state("wait")
                end
            elseif key ~= "chase"..direction and key ~= "scratch"..dirmap[direction] then
                card.children.floating_sprite:set_state("chase"..direction)
            end
        end
        --MINTY.say(tostring(jokerref.soul_pos.y), "TRACE")

        -- move joker to left or right if it's been in one of the lateral chase states long enough
        local lastdir = card.ability.extra.motion.dir
        --get current direction and reset tracking if it's changed
        if string.find(card.children.floating_sprite.state.key, "left") then
            if lastdir ~= "left" then card.ability.extra.motion = {
                dir = "left",
                duration = 0
            }
            end
            if leftmost and card.children.floating_sprite.state.key ~= "scratchl" then
                card.children.floating_sprite:set_state("scratchl")
                lastdir = "none"
            end
        elseif string.find(card.children.floating_sprite.state.key, "right") then
            if lastdir ~= "right" then card.ability.extra.motion = {
                dir = "right",
                duration = 0
            }
            end
            if rightmost and card.children.floating_sprite.state.key ~= "scratchr" then
                card.children.floating_sprite:set_state("scratchr")
                lastdir = "none"
            end
        else
            if lastdir ~= "none" then
                card.ability.extra.motion = {
                    dir = "none",
                    duration = 0
                }
            end
            if direction == "up" and card.children.floating_sprite.state.key ~= "scratchu" then
                card.children.floating_sprite:set_state("scratchu")
                lastdir = "none"
            elseif direction == "down" and card.children.floating_sprite.state.key ~= "scratchd" then
                card.children.floating_sprite:set_state("scratchd")
                lastdir = "none"
            end
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
            if card.children.floating_sprite.state.key == "wait" then
                card.children.floating_sprite:set_state("yawn")
                card.ability.extra.motion.duration = 6
            elseif card.children.floating_sprite.state.key == "yawn" then
                card.children.floating_sprite:set_state("nap")
                card.ability.extra.motion.duration = 0
            end
        end
    end
}