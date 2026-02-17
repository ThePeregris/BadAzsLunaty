-- [[ [|cff355E3BB|r]adAzs |cff32CD32Lunaty|r ]]
-- Author:  ThePeregris
-- Version: 2.0 (Integrated)
-- Target:  Turtle WoW (1.12 / LUA 5.0)
-- Requires: BadAzs Core v2.0+

-- =====================================
-- LUNATY - PALADIN MODULE
-- =====================================

function BadAzs_PallySeal()
    -- Inicia ataque (Core function)
    BadAzs_Cast("Attack")
    
    -- Utilidades do Core
    if BadAzs_UseRacial then BadAzs_UseRacial() end
    if BadAzs_EquipSet then BadAzs_EquipSet("SEAL") end

    -- Verifica Seal usando função global do Core
    -- "Ability_ThunderBolt" é a textura do Seal of Righteousness
    if not BadAzs_HasBuff("Ability_ThunderBolt") then
        BadAzs_Cast("Seal of Righteousness")
    end
end

function BadAzs_PallyHeal()
    if BadAzs_UseRacial then BadAzs_UseRacial() end
    if BadAzs_EquipSet then BadAzs_EquipSet("HOLY") end

    -- SHIFT = SELF
    if IsShiftKeyDown() then
        TargetUnit("player")
        BadAzs_Cast("Holy Light(Rank 1)")
        return
    end

    -- CTRL = FOCUS
    if IsControlKeyDown() and BadAzs_FocusName then
        TargetByName(BadAzs_FocusName, true)
        BadAzs_Cast("Holy Light(Rank 1)")
        return
    end

    -- TARGET EXISTE
    if UnitExists("target") then
        BadAzs_Cast("Holy Light(Rank 1)")
        return
    end

    -- FALLBACK
    TargetUnit("player")
    BadAzs_Cast("Holy Light(Rank 1)")
end

-- =====================================
-- LUNATY - HUNTER MODULE
-- =====================================

function BadAzs_HunterCombat()
    if not UnitExists("target") or not UnitCanAttack("player","target") then return end

    if CheckInteractDistance("target", 3) == 1 then
        SpellStopCasting() 
        BadAzs_Cast("Attack")
        
        -- Raptor Strike protegido pelo Core
        if BadAzs_Ready("Raptor Strike") then
            BadAzs_Cast("Raptor Strike")
        end
    else
        BadAzs_Cast("Attack")
        CastSpellByName("Auto Shot")
    end
end

-- =====================================
-- COMMANDS REGISTRATION (BL Prefix)
-- =====================================

-- PALADIN (BLPa...)
SLASH_BLPASEAL1 = "/blpaseal"
SlashCmdList["BLPASEAL"] = BadAzs_PallySeal

SLASH_BLPAHEAL1 = "/blpaheal"
SlashCmdList["BLPAHEAL"] = BadAzs_PallyHeal

-- HUNTER (BLHu...)
SLASH_BLHUNTER1 = "/blhunter"
SlashCmdList["BLHUNTER"] = BadAzs_HunterCombat
