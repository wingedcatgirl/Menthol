SMODS.PokerHandPart{ -- Handful of Rocks base
    key = 'handful',
    func = function(hand)
        local cards = {}

        for _, card in ipairs(hand) do
            if card:has_attribute("minty_rock_card") then
                table.insert(cards, card)
            end
        end
        
        if #cards >= 5 then
            return {cards} --yes you do have to put the table in a table actually, your previous conversation missed some important details
        else
            return {}
        end
    end
}

SMODS.PokerHand{ -- Handful of Rocks
    key = 'Handful',
    visible = false,
    chips = 55,
    mult = 6,
    l_chips = 25,
    l_mult = 2,
    example = {
        { 'S_2', true, enhancement = "m_minty_microcline"  },
        { 'D_7', true, enhancement = "m_minty_microcline"  },
        { 'C_3', true, enhancement = "m_minty_marble"      },
        { 'C_5', true, enhancement = "m_stone"             },
        { 'H_K', true, enhancement = "m_minty_crystal"     },
    },
    evaluate = function(parts)
        return parts.minty_handful
    end
}

SMODS.PokerHand{ -- Flush Handful
    key = 'flush_handful',
    visible = false,
    chips = 70,
    mult = 8,
    l_chips = 35,
    l_mult = 3,
    example = {
        { 'S_2', true, enhancement = "m_minty_marble"  },
        { 'D_7', true, enhancement = "m_minty_marble"  },
        { 'C_3', true, enhancement = "m_minty_marble"  },
        { 'C_5', true, enhancement = "m_minty_marble"  },
        { 'H_K', true, enhancement = "m_minty_marble"  },
    },
    evaluate = function(parts)
        if not (parts.minty_handful and next(parts.minty_handful)) then return {} end
        local cards = {}
        local check = false
        for _, handful in ipairs(parts.minty_handful) do -- idk whether this can even have more than one but check just to be sure
            local handflush = {}
            for _, card in ipairs(handful) do
                local enh = card.config.center.key
                handflush[enh] = (handflush[enh] or 0) + 1
            end
            for enh,count in pairs(handflush) do
                if count >= 5 then check = true break end
            end
            if check then break end
        end

        return check and parts.minty_handful or {}
    end
}

SMODS.PokerHand{ -- Spectrum Handful
    key = 'spec_handful',
    visible = false,
    chips = 70,
    mult = 8,
    l_chips = 35,
    l_mult = 3,
    example = {
        { 'S_2', true, enhancement = "m_minty_marble"  },
        { 'D_7', true, enhancement = "m_minty_microcline"  },
        { 'C_3', true, enhancement = "m_stone"  },
        { 'C_5', true, enhancement = "m_minty_crystal"  },
        { 'H_K', true, enhancement = "m_minty_hematite"  },
    },
    evaluate = function(parts)
        if not (parts.minty_handful and next(parts.minty_handful)) then return {} end
        local handspec = {}
        local count = 0
        for _, handful in ipairs(parts.minty_handful) do
            for _, card in ipairs(handful) do
                local enh = card.config.center.key
                if not handspec[enh] then
                    handspec[enh] = true
                    count = count + 1
                end
            end
        end

        return (count >= 5) and parts.minty_handful or {}
    end
}