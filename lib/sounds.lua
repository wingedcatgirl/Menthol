SMODS.Sound { --Source: https://www.youtube.com/watch?v=gXE9UgrOdls
    key = 'batnoise',
    path = 'batnoise.ogg'
}

SMODS.Sound { --Sound by Artninja and scale75: https://freesound.org/people/Artninja/sounds/749731/
    key = 'swordnoise',
    path = 'artninja slice 4.ogg'
}

SMODS.Sound { --Sound by jjcunning https://freesound.org/people/jjcunning/sounds/578189/
    key = 'gunshot',
    path = 'jjcunning gun noise.ogg'
}

SMODS.Sound { --Deltarune reference, original source is this thing: https://soundeffects.fandom.com/wiki/Sound_Ideas,_EXPLOSION_-_LARGE_EXPLOSION_03_(H-B)
    key = 'explosion',
    path = 'lofi explosion.wav'
}

SMODS.Sound { --Sonic 2 time limit warning noise
    key = 'warning',
    path = 'S2 siren.wav'
}

SMODS.Sound { --https://sounds.spriters-resource.com/gamecube/supermariosunshine/asset/394927/; (sloppy) recreation from w2ndLoad_0.aw_000001bb.wav and w2ndLoad_0.aw_000001d0.wav
    key = 'squirt',
    path = 'approximately yoshi juice noise probably.ogg'
}

SMODS.Sound { --balala
    key = 'unbalance',
    path = 'unbalanced.ogg'
}

SMODS.Sound{
    key = "DRIVING",
    path = "DRIVING IN MY CAR.ogg"
}

SMODS.Sound{ --https://freesound.org/people/skymary/sounds/412017/
    key = "meow1",
    path = "meow 1.ogg"
}

SMODS.Sound{ --https://freesound.org/people/FreqWincy/sounds/703921/
    key = "meow2",
    path = "meow 2.ogg"
}

SMODS.Sound{ --https://freesound.org/people/FreqWincy/sounds/703921/ x2 combob
    key = "meow3",
    path = "meow 3.ogg"
}

do --Buttload of meme sounds grabbed from https://thirtydollar.website/ and also video games
    local path = SMODS.current_mod.path.."assets/sounds/thirty dollar memes"
    local info = NFS.getDirectoryItemsInfo(path)
    MINTY.memecount = #info
    for i,v in ipairs(info) do
        local filename = v.name
        sendTraceMessage("Registering meme sound number "..i..": "..filename)
        assert(string.find(filename, ".wav") or string.find(filename, ".ogg"), "Menthol: "..filename.." isn't a valid sound file! (Must be .wav or .ogg)")
        SMODS.Sound{
            key = "memenoise"..i,
            path = "thirty dollar memes/"..filename
        }
    end
end