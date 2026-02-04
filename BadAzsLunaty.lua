-- [[ [|cff355E3BB|r]adAzs |cff32CD32Lunaty|r ]]
-- Author:  ThePeregris
-- Version: 1.4 (Uses Core Attack API)
-- Target:  Turtle WoW (1.12 / LUA 5.0)

-- =====================================
-- LUNATY - PALADIN MODULE
-- =====================================

function BadAzs_UseHumanRacial()
    local _, race = UnitRace("player")
    if race == "Human" then
        -- Verifica se o Core carregou a API de cooldown
        if BadAzs_Ready and BadAzs_Ready("Perception") then
            CastSpellByName("Perception")
        else
            -- Fallback
            CastSpellByName("Perception")
        end
    end
end

function BadAzs_PallyHasSeal()
    local i = 1
    while true do
        local texture = UnitBuff("player", i)
        if not texture then break end
        if string.find(texture, "Ability_ThunderBolt") then
            return true
        end
        i = i + 1
    end
    return false
end

function BadAzs_PallySeal()
    -- [[ INICIA ATAQUE VIA CORE API ]]
    if BadAzs_StartAttack then BadAzs_StartAttack() end

    BadAzs_UseHumanRacial()      -- Chama do Core
    BadAzs_EquipSet("SEAL")      -- Chama do Core

    if not BadAzs_PallyHasSeal() then
        CastSpellByName("Seal of Righteousness")
        -- DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Seal cast")
    else
        -- DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Seal already active")
    end
end

function BadAzs_PallyHeal()
    BadAzs_UseHumanRacial()
    BadAzs_EquipSet("HOLY")

    -- SHIFT = SELF
    if IsShiftKeyDown() then
        TargetUnit("player")
        CastSpellByName("Holy Light(Rank 1)")
        return
    end

    -- CTRL = FOCUS
    if IsControlKeyDown() and BadAzs_FocusName then
        TargetByName(BadAzs_FocusName, true)
        CastSpellByName("Holy Light(Rank 1)")
        return
    end

    -- TARGET EXISTE
    if UnitExists("target") then
        CastSpellByName("Holy Light(Rank 1)")
        return
    end

    -- INTEGRAÇÃO QUICKHEAL
    if QuickHeal then
        ClearTarget()
        CastSpellByName("Holy Light(Rank 1)")
        return
    end

    -- FALLBACK
    TargetUnit("player")
    CastSpellByName("Holy Light(Rank 1)")
end

-- Novos Comandos de Chat
SLASH_BADSEAL1 = "/badseal"
SlashCmdList["BADSEAL"] = BadAzs_PallySeal

SLASH_BADHEAL1 = "/badheal"
SlashCmdList["BADHEAL"] = BadAzs_PallyHeal