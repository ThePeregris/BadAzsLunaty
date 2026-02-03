-- =====================================
-- BADAZS LUNATY - PALADIN MODULE
-- Vanilla 1.12 / Lua 5.0
-- =====================================

function BadAzs_PallyHasSeal()
    local i = 1
    while true do
        local texture = UnitBuff("player", i)
        if not texture then break end

        -- Procura o ícone do Seal of Righteousness
        if string.find(texture, "Ability_ThunderBolt") then
            return true
        end
        i = i + 1
    end
    return false
end

function BadAzs_PallySeal()
    BadAzs_UseHumanRacial()     -- Chama do Core
    BadAzs_EquipSet("SEAL")     -- Chama do Core

    if not BadAzs_PallyHasSeal() then
        CastSpellByName("Seal of Righteousness")
        DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Seal cast")
    else
        DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Seal already active")
    end
end

function BadAzs_PallyHeal()
    BadAzs_UseHumanRacial()
    BadAzs_EquipSet("HOLY")

    -- SHIFT = SELF
    if IsShiftKeyDown() then
        TargetUnit("player")
        CastSpellByName("Holy Light(Rank 1)")
        DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Self heal (SHIFT)")
        return
    end

    -- CTRL = FOCUS
    if IsControlKeyDown() and BadAzs_FocusName then
        TargetByName(BadAzs_FocusName, true)
        CastSpellByName("Holy Light(Rank 1)")
        DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Focus heal (CTRL)")
        return
    end

    -- TARGET EXISTE
    if UnitExists("target") then
        CastSpellByName("Holy Light(Rank 1)")
        DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Target heal")
        return
    end

    -- INTEGRAÇÃO QUICKHEAL
    if QuickHeal then
        ClearTarget()
        CastSpellByName("Holy Light(Rank 1)")
        DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] QuickHeal used")
        return
    end

    -- FALLBACK
    TargetUnit("player")
    CastSpellByName("Holy Light(Rank 1)")
    DEFAULT_CHAT_FRAME:AddMessage("[BadAzs Lunaty] Fallback self heal")
end

-- Novos Comandos de Chat
SLASH_BADSEAL1 = "/badseal"
SlashCmdList["BADSEAL"] = BadAzs_PallySeal

SLASH_BADHEAL1 = "/badheal"
SlashCmdList["BADHEAL"] = BadAzs_PallyHeal