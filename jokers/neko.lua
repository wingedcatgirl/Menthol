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
    set_sprites = function (self, card, front)
        local sprite = card.children.floating_sprite
        sprite.minty_neko = {
            x=0, y=0
        }

        local shade = sprite.draw_shader
        function sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
            local multiplier = sprite.minty_neko.multiplier or 0.05

            if _shader == "dissolve" then
                mx = (mx or 0) + (sprite.minty_neko.x * multiplier)
                my = (my or 0) + (sprite.minty_neko.y * multiplier)
            end

            shade(self, _shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
        end
    end,
    draw = function (self, card, layer)
        local sprite = card.children.floating_sprite
        local state = card.children.floating_sprite.state.key

        if string.find(state, "chase") then
            local dirs = {
                left = {x=-1, y=0},
                right = {x=1, y=0},
                up = {x=0, y=-1},
                down = {x=0, y=1}
            }
            for k,v in pairs(dirs) do
                if string.find(state,k) then
                    sprite.minty_neko.x = sprite.minty_neko.x + v.x
                    sprite.minty_neko.y = sprite.minty_neko.y + v.y
                end
            end
        end
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
        local sprite = card.children.floating_sprite
        local state = sprite.state.key

        card.ability.extra.timer = (card.ability.extra.timer or 0) + dt
        --print(card.ability.extra.timer)
        if card.ability.extra.timer > (G.SETTINGS.GAMESPEED * 0.25) then
            card.ability.extra.timer = 0
            card.ability.extra.motion.duration = card.ability.extra.motion.duration + 1
        end
        if state == "alert" and card.ability.extra.motion.duration <= 4 then
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


        -- get positions of mouse and joker
        local mousepos = {
            x = math.floor(G.CURSOR.T.x*4)/4,
            y = math.floor(G.CURSOR.T.y*4)/4
        }
        local nekopos = {
            x = math.floor((sprite.VT.x)*4)/4,
            y = math.floor((sprite.VT.y)*4)/4
        }
        nekopos.x, nekopos.y = nekopos.x + 1.25, nekopos.y + 2 --Todo, figure out why these offsets and get them directly
        local location_multiplier = sprite.minty_neko.location_multiplier or 0.05
        nekopos.x, nekopos.y = nekopos.x + (sprite.minty_neko.x * location_multiplier), nekopos.y + (sprite.minty_neko.y * location_multiplier)

        --math out the direction
        local dx = nekopos.x - mousepos.x
        local dy = nekopos.y - mousepos.y

        local angle_rad = math.atan2(dy, dx)
        local angle_deg = math.deg(angle_rad)
        angle_deg = (angle_deg + 360) % 360

        local index = math.floor((angle_deg + 22.5) / 45) % 8
        local compass = { "left", "upleft", "up", "upright", "right", "downright", "down", "downleft" }
        local direction = compass[index+1]
        if (math.abs(dx) <= 1 and math.abs(dy) <= 1.25) or card.highlighted then
            direction = "close"
        end

        local waiting_states = {
            nap = true,
            yawn = true,
            wait = true,
            wash = true,
        }
        if (waiting_states[state]) and direction ~= "close" then
            sprite:set_state("alert")
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

        do
            local key = state
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
                    sprite:set_state("wait")
                end
            elseif key ~= "chase"..direction and key ~= "scratch"..dirmap[direction] then
                sprite:set_state("chase"..direction)
            end
        end

        -- move joker to left or right if it's been in one of the lateral chase states long enough
        local lastdir = card.ability.extra.motion.dir
        --get current direction and reset tracking if it's changed
        if string.find(state, "left") then
            if lastdir ~= "left" then card.ability.extra.motion = {
                dir = "left",
                duration = 0
            }
            end
        elseif string.find(state, "right") then
            if lastdir ~= "right" then card.ability.extra.motion = {
                dir = "right",
                duration = 0
            }
            end
        else
            if lastdir ~= "none" then
                card.ability.extra.motion = {
                    dir = "none",
                    duration = 0
                }
            end
            --[[
            if direction == "up" and state ~= "scratchu" then
                sprite:set_state("scratchu")
                lastdir = "none"
            elseif direction == "down" and state ~= "scratchd" then
                sprite:set_state("scratchd")
                lastdir = "none"
            end
            --]]
        end

        if not joker_slot then
            MINTY.say("neko's update is being called when it's not in an area, send your mod list so i can figure out why", "WARN ")
            return
        end

        if card.ability.extra.motion.duration >= 5 and lastdir ~= "none" then --it's been running long enough
            do return end --disable joker swapping for testing the change thingy
        
            card.ability.extra.motion.duration = 0
            if not leftmost and lastdir == "left" then
                area.cards[joker_slot-1], area.cards[joker_slot] = area.cards[joker_slot], area.cards[joker_slot-1]
            elseif not rightmost and lastdir == "right" then
                area.cards[joker_slot], area.cards[joker_slot+1] = area.cards[joker_slot+1], area.cards[joker_slot]
            end
        elseif card.ability.extra.motion.duration >= 10 and lastdir == "none" then
            if state == "wait" then
                local newstate = ({"yawn", "wash"})[math.random(2)]

                sprite:set_state(newstate)
                card.ability.extra.motion.duration = newstate == "yawn" and 6 or 0
            elseif state == "wash" then
                local newstate = ({"yawn", "wait"})[math.random(2)]

                sprite:set_state(newstate)
                card.ability.extra.motion.duration = 6
            elseif state == "yawn" then
                sprite:set_state("nap")
                card.ability.extra.motion.duration = 0
            end
        end
    end
}