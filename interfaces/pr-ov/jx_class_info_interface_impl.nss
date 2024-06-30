#include "jx_inc_magic_info"
#include "jx_inc_magic"
#include "jx_class_info_interface"


//=========================================== Helpers =====================================
// Private function - Return the level of an Assassin spell
//int JXPrivateGetAssassinSpellLevel(int iSpellId)
int JXGetAssassinSpellLevel(int iSpellId)
{
    sg
    switch (iSpellId)
    {
        case SPELLABILITY_AS_GHOSTLY_VISAGE: return 1;
        case SPELLABILITY_AS_DARKNESS: return 2;
        case SPELLABILITY_AS_INVISIBILITY: return 3;
        case SPELLABILITY_AS_GREATER_INVISIBLITY: return 4;
        case 1698: return 1; //ghost
        case 1699: return 1; //sleep
        case 1700: return 1; //true
        case 1701: return 2; //sb2
        case 1702: return 2; //cat
        case 1703: return 2; //fox
        case 1704: return 2; //dark
        case 1705: return 3; //sb3
        case 1706: return 3; //invis
        case 1707: return 3; //slum
        case 1708: return 2; //false
        case 1709: return 3; //mcirc
        case 1710: return 4; //sb4
        case 1711: return 4; //impinv
        case 1712: return 4; //free
        case 1713: return 3; //pois
        case 1714: return 3; //clair
        case 1762: return 1; //clair
        }
    return 0;
}

// Private function - Return the level of a Blackguard spell
//int JXPrivateGetBlackguardSpellLevel(int iSpellId)
int JXGetBlackguardSpellLevel(int iSpellId)
{
    switch (iSpellId)
    {
        case SPELLABILITY_BG_BULLS_STRENGTH: return 1;
        case SPELLABILITY_BG_CONTAGION: return 3;
        case SPELLABILITY_BG_INFLICT_SERIOUS_WOUNDS: return 3;
        case SPELLABILITY_BG_INFLICT_CRITICAL_WOUNDS: return 4;
        //case SPELLABILITY_BG_CREATEDEAD           // Not a spell : supernatural ability
        //case SPELLABILITY_BG_FIENDISH_SERVANT         // Not a spell : supernatural ability
        case 701: return 5; // Summon Fiendish Ally
        case 1715: return 1; //sb1
        case 1716: return 1; //bstrength
        case 1717: return 1; //mweapon
        case 1718: return 1; //doom
        case 1719: return 1; //clight
        case 1720: return 3; //sb2
        case 1721: return 3; //iserious
        case 1722: return 2; //darkness
        case 1723: return 2; //cmod
        case 1724: return 2; //eagle
        case 1725: return 2; //knell
        case 1726: return 3; //sb3
        case 1727: return 3; //contag
        case 1728: return 3; //cseri
        case 1729: return 3; //prot
        case 1730: return 3; //scIII
        case 1731: return 4; //sb4
        case 1732: return 4; //icrit
        case 1733: return 4; //cctit
        case 1734: return 4; //free
        case 1735: return 3; //pois
    }

    return 0;
}


//======================================== Implementation ==================================

// Private function - Get the caster level associated with one of the main classes
//int JXPrivateGetComputedCLFromClass(int iClass, int iClassLevel)
int JXImplGetComputedCLFromClass(int iClass, int iClassLevel)
{
    if ((iClass == CLASS_TYPE_BARD)
     || (iClass == CLASS_TYPE_SORCERER)
     || (iClass == CLASS_TYPE_WIZARD)
     || (iClass == CLASS_TYPE_WARLOCK)
     || (iClass == CLASS_TYPE_ASSASSIN)
     || (iClass == CLASS_AVENGER)
     || (iClass == CLASS_TYPE_CLERIC)
     || (iClass == CLASS_TYPE_DRUID)
     || (iClass == CLASS_TYPE_BLACKGUARD)
     || (iClass == CLASS_TYPE_SPIRIT_SHAMAN)
     || (iClass == CLASS_TYPE_FAVORED_SOUL))
        return iClassLevel;

    if (iClass == CLASS_TYPE_RANGER)
        return iClassLevel / 2;

    int nPaladinFullCaster = GetLocalInt(GetModule(), "PaladinFullCaster");
    if (iClass == CLASS_TYPE_PALADIN && nPaladinFullCaster == 1)
        return iClassLevel;
    else
        return iClassLevel / 2;

    return 0;
}
// Private function - Get the improved arcane casting levels due to prestige classes
//int JXPrivateGetImprovedArcaneCLFromClasses(object oCreature, int iMainClass)
int JXImplGetImprovedArcaneCLFromClasses(object oCreature, int iMainClass)
{
    int iCasterLevel;

    if (iMainClass == CLASS_TYPE_ASSASSIN)
    {
        int iClass, iClassLevel;
        int iLoop;
        for (iLoop = 1; iLoop <= 4; iLoop++)
        {
            iClass = GetClassByPosition(iLoop, oCreature);
            iClassLevel = GetLevelByPosition(iLoop, oCreature);

            if (iClass == CLASS_AVENGER)
                iCasterLevel += iClassLevel;

            if (iClass == CLASS_KNIGHT_TIERDRIAL && GetHasFeat(FEAT_KOT_SPELLCASTING_ASSASSIN, oCreature))
                iCasterLevel += iClassLevel;

            if (iClass == CLASS_DRAGONSLAYER && GetHasFeat(FEAT_DRSLR_SPELLCASTING_ASSASSIN, oCreature))
                iCasterLevel += 1 + ((iClassLevel - 1) / 2);

            if (iClass == CLASS_CHILD_NIGHT && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_ASSASSIN, oCreature))
                iCasterLevel += ( iClassLevel - 1 );
        }
        return iCasterLevel;
    }

    if (iMainClass == CLASS_AVENGER)
    {
        int iClass, iClassLevel;
        int iLoop;
        for (iLoop = 1; iLoop <= 4; iLoop++)
        {
            iClass = GetClassByPosition(iLoop, oCreature);
            iClassLevel = GetLevelByPosition(iLoop, oCreature);

            if (iClass == CLASS_TYPE_ASSASSIN)
                iCasterLevel += iClassLevel;

            if (iClass == CLASS_KNIGHT_TIERDRIAL && GetHasFeat(FEAT_KOT_SPELLCASTING_AVENGER, oCreature))
                iCasterLevel += iClassLevel;

            if (iClass == CLASS_DRAGONSLAYER && GetHasFeat(FEAT_DRSLR_SPELLCASTING_AVENGER, oCreature))
                iCasterLevel += 1 + ((iClassLevel - 1) / 2);

            if (iClass == CLASS_CHILD_NIGHT && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_AVENGER, oCreature))
                iCasterLevel += ( iClassLevel - 1 );
        }
        return iCasterLevel;
    }

    int iClass, iClassLevel;
    int iLoop;
    for (iLoop = 1; iLoop <= 4; iLoop++)
    {
        iClass = GetClassByPosition(iLoop, oCreature);
        iClassLevel = GetLevelByPosition(iLoop, oCreature);

        // Get the Arcane Scholar of Candlekeep caster level
        if (iClass == CLASS_TYPE_ARCANE_SCHOLAR)
            iCasterLevel += iClassLevel;

        // Get the Arcane Trickster caster level
        if (iClass == CLASS_TYPE_ARCANETRICKSTER)
            iCasterLevel += iClassLevel;

        // Get the Eldritch Knight caster level
        if (iClass == CLASS_TYPE_ELDRITCH_KNIGHT)
            iCasterLevel += ( iClassLevel - 1 );

        // Get the Harper Agent caster level
        if (iClass == CLASS_TYPE_HARPER)
            iCasterLevel += ( iClassLevel - 1 );

        // Get the Palemaster caster level
        if (iClass == CLASS_TYPE_PALEMASTER)
            iCasterLevel += ( iClassLevel - 1 );

        // Get the Red Wizard of Thay caster level
        if (iClass == CLASS_TYPE_RED_WIZARD)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_WILDMAGE)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_DAGGERSPELL_MAGE)
            iCasterLevel += ( iClassLevel - 1 );

        if (iClass == CLASS_BLADESINGER)
            iCasterLevel += 1 + ((iClassLevel - 1) / 2);

        if (iClass == CLASS_FROST_MAGE)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_DISSONANT_CHORD)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_KNIGHT_TIERDRIAL && GetHasFeat(FEAT_KOT_SPELLCASTING_BARD, oCreature))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_LYRIC_THAUMATURGE)
            iCasterLevel += iClassLevel;

        // Get the Magelord caster level
        if (iClass == 91)
            iCasterLevel += iClassLevel;

        // Get the Incanatrix caster level
        if (iClass == 89)
            iCasterLevel += iClassLevel;

        // Get the Mystic Theurge caster level
        if (iClass == 44)
            iCasterLevel += iClassLevel;

        // Get the Devotee caster level
        if (iClass == 88)
            iCasterLevel += iClassLevel;

        // Get the Archmage caster level
        if (iClass == 81)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_HEARTWARDER && (GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_BARD, oCreature) ||
            GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_SORCERER, oCreature) || GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_WIZARD, oCreature)))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_CANAITH_LYRIST && (GetHasFeat(FEAT_CANAITH_SPELLCASTING_BARD, oCreature) ||
            GetHasFeat(FEAT_CANAITH_SPELLCASTING_SORCERER, oCreature) || GetHasFeat(FEAT_CANAITH_SPELLCASTING_WIZARD, oCreature)))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_STORMSINGER && (GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_BARD, oCreature) ||
            GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_SORCERER, oCreature) || GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_WIZARD, oCreature)))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_DRAGONSLAYER && (GetHasFeat(FEAT_DRSLR_SPELLCASTING_BARD, oCreature) ||
            GetHasFeat(FEAT_DRSLR_SPELLCASTING_SORCERER, oCreature) || GetHasFeat(FEAT_DRSLR_SPELLCASTING_WIZARD, oCreature)))
            iCasterLevel += 1 + ((iClassLevel - 1) / 2);

        if (iClass == CLASS_CHILD_NIGHT && (GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_BARD, oCreature) ||
            GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_SORCERER, oCreature) || GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_WIZARD, oCreature)))
            iCasterLevel += (iClassLevel - 1);

        if (iClass == CLASS_SWIFTBLADE)
            if (iClassLevel > 9)
                iCasterLevel += (iClassLevel - 4);
            else if (iClassLevel > 6)
                iCasterLevel += (iClassLevel - 3);
            else if (iClassLevel > 3)
                iCasterLevel += (iClassLevel - 2);
            else
                iCasterLevel += (iClassLevel - 1);

        // Get the Loremaster caster level
        if (iClass == 80)
            iCasterLevel += iClassLevel;
    }

    return iCasterLevel;
}

// Private function - Get the improved divine casting levels du to prestige classes
//int JXPrivateGetImprovedDivineCLFromClasses(object oCreature, int iMainClass)
int JXImplGetImprovedDivineCLFromClasses(object oCreature, int iMainClass)
{
    int iCasterLevel = 0;

    if (iMainClass == CLASS_TYPE_BLACKGUARD)
    {
        int iClass, iClassLevel;
        int iLoop;
        for (iLoop = 1; iLoop <= 4; iLoop++)
        {
            iClass = GetClassByPosition(iLoop, oCreature);
            iClassLevel = GetLevelByPosition(iLoop, oCreature);

            if (iClass == CLASS_KNIGHT_TIERDRIAL && GetHasFeat(FEAT_KOT_SPELLCASTING_BLACKGUARD, oCreature))
                iCasterLevel += iClassLevel;

            if (iClass == CLASS_DRAGONSLAYER && GetHasFeat(FEAT_DRSLR_SPELLCASTING_BLACKGUARD, oCreature))
                iCasterLevel += 1 + ((iClassLevel - 1)/ 2);

            if (iClass == CLASS_CHILD_NIGHT && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_BLACKGUARD, oCreature))
                iCasterLevel += ( iClassLevel - 1 );
        }
        return iCasterLevel;
    }

    int iClass, iClassLevel;
    int iLoop;
    for (iLoop = 1; iLoop <= 4; iLoop++)
    {
        iClass = GetClassByPosition(iLoop, oCreature);
        iClassLevel = GetLevelByPosition(iLoop, oCreature);

        // Get the Harper Agent caster level
        if (iClass == CLASS_TYPE_HARPER)
            iCasterLevel += ( iClassLevel - 1 );

        // Get the Warpriest caster level
        if (iClass == CLASS_TYPE_WARPRIEST)
            iCasterLevel += (iClassLevel + 1) / 2;

        // Get the Stormlord caster level
        if (iClass == CLASS_TYPE_STORMLORD)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_LION_TALISID)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_CHAMP_SILVER_FLAME)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_ELDRITCH_DISCIPLE)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_DAGGERSPELL_SHAPER)
            iCasterLevel += ( iClassLevel - 1 );

        if (iClass == CLASS_MASTER_RADIANCE)
            iCasterLevel += (iClassLevel - 1);

        if (iClass == CLASS_BLACK_FLAME_ZEALOT)
            iCasterLevel += (iClassLevel / 2);

        if (iClass == CLASS_NATURES_WARRIOR)
            iCasterLevel += (iClassLevel / 2);

        if (iClass == CLASS_SHINING_BLADE)
            iCasterLevel += (iClassLevel / 2);

        if (iClass == CLASS_FOREST_MASTER)
            if (iClassLevel > 7)
                iCasterLevel += (iClassLevel - 2);
            else if (iClassLevel > 3)
                iCasterLevel += (iClassLevel - 1);
            else
                iCasterLevel += iClassLevel;

        if (iClass == CLASS_SHADOWBANE_STALKER)
            if (iClassLevel > 8)
                iCasterLevel += (iClassLevel - 2);
            else if (iClassLevel > 3)
                iCasterLevel += (iClassLevel - 1);
            else
                iCasterLevel += iClassLevel;

        // Get the Mystic Theurge caster level
        if (iClass == 44)
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_CHILD_NIGHT && (GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_CLERIC, oCreature) ||
            GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_DRUID, oCreature) || GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_PALADIN, oCreature) ||
            GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_RANGER, oCreature) || GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_FAVORED_SOUL, oCreature) ||
            GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_SPIRIT_SHAMAN, oCreature)))
            iCasterLevel += (iClassLevel - 1);

        if (iClass == CLASS_STORMSINGER && (GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_CLERIC, oCreature) ||
            GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_DRUID, oCreature) || GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_PALADIN, oCreature) ||
            GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_RANGER, oCreature) || GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_FAVORED_SOUL, oCreature) ||
            GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_SPIRIT_SHAMAN, oCreature)))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_KNIGHT_TIERDRIAL && (GetHasFeat(FEAT_KOT_SPELLCASTING_CLERIC, oCreature) ||
            GetHasFeat(FEAT_KOT_SPELLCASTING_DRUID, oCreature) || GetHasFeat(FEAT_KOT_SPELLCASTING_PALADIN, oCreature) ||
            GetHasFeat(FEAT_KOT_SPELLCASTING_RANGER, oCreature) || GetHasFeat(FEAT_KOT_SPELLCASTING_FAVORED_SOUL, oCreature) ||
            GetHasFeat(FEAT_KOT_SPELLCASTING_SPIRIT_SHAMAN, oCreature)))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_HEARTWARDER && (GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_CLERIC, oCreature) ||
            GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_DRUID, oCreature) || GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_PALADIN, oCreature) ||
            GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_RANGER, oCreature) || GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_FAVORED_SOUL, oCreature) ||
            GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_SPIRIT_SHAMAN, oCreature)))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_CANAITH_LYRIST && (GetHasFeat(FEAT_CANAITH_SPELLCASTING_CLERIC, oCreature) ||
            GetHasFeat(FEAT_CANAITH_SPELLCASTING_DRUID, oCreature) || GetHasFeat(FEAT_CANAITH_SPELLCASTING_PALADIN, oCreature) ||
            GetHasFeat(FEAT_CANAITH_SPELLCASTING_RANGER, oCreature) || GetHasFeat(FEAT_CANAITH_SPELLCASTING_FAVORED_SOUL, oCreature) ||
            GetHasFeat(FEAT_CANAITH_SPELLCASTING_SPIRIT_SHAMAN, oCreature)))
            iCasterLevel += iClassLevel;

        if (iClass == CLASS_DRAGONSLAYER && (GetHasFeat(FEAT_DRSLR_SPELLCASTING_CLERIC, oCreature) ||
            GetHasFeat(FEAT_DRSLR_SPELLCASTING_DRUID, oCreature) || GetHasFeat(FEAT_DRSLR_SPELLCASTING_PALADIN, oCreature) ||
            GetHasFeat(FEAT_DRSLR_SPELLCASTING_RANGER, oCreature) || GetHasFeat(FEAT_DRSLR_SPELLCASTING_FAVORED_SOUL, oCreature) ||
            GetHasFeat(FEAT_DRSLR_SPELLCASTING_SPIRIT_SHAMAN, oCreature)))
            iCasterLevel += 1 + ((iClassLevel - 1) / 2);
    }

    return iCasterLevel;
}

// Private function - Indicate if a class is a main arcane class
//int JXPrivateGetIsMainArcaneClass(int iClass)
int JXImplGetIsMainArcaneClass(int iClass)
{
    if ((iClass == CLASS_TYPE_BARD)
     || (iClass == CLASS_TYPE_SORCERER)
     || (iClass == CLASS_TYPE_WIZARD)
     || (iClass == CLASS_TYPE_WARLOCK)
     || (iClass == CLASS_AVENGER)
     || (iClass == CLASS_TYPE_ASSASSIN))
        return TRUE;

    return FALSE;
}

// Private function - Indicate if a class is a main divine class
//int JXPrivateGetIsMainDivineClass(int iClass)
int JXImplGetIsMainDivineClass(int iClass)
{
    if ((iClass == CLASS_TYPE_CLERIC)
     || (iClass == CLASS_TYPE_DRUID)
     || (iClass == CLASS_TYPE_PALADIN)
     || (iClass == CLASS_TYPE_RANGER)
     || (iClass == CLASS_TYPE_BLACKGUARD)
     || (iClass == CLASS_TYPE_SPIRIT_SHAMAN)
     || (iClass == CLASS_TYPE_FAVORED_SOUL))
        return TRUE;

    return FALSE;
}

// Private function - Get the caster level bonus due to the Practised Spellcaster feature
//int JXPrivateGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels)
int JXImplGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels)
{
    int iBonus = GetTotalLevels(oCaster, FALSE) - iCastingLevels;
    if (iBonus > 4) iBonus = 4;
    if (iBonus < 0) iBonus = 0;

    if (((iCastingClass == CLASS_TYPE_BARD) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_BARD, oCaster))
     || ((iCastingClass == CLASS_TYPE_SORCERER) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_SORCERER, oCaster))
     || ((iCastingClass == CLASS_TYPE_WIZARD) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_WIZARD, oCaster))
     || ((iCastingClass == CLASS_TYPE_CLERIC) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_CLERIC, oCaster))
     || ((iCastingClass == CLASS_TYPE_DRUID) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_DRUID, oCaster))
     || ((iCastingClass == CLASS_TYPE_PALADIN) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_PALADIN, oCaster))
     || ((iCastingClass == CLASS_TYPE_RANGER) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_RANGER, oCaster))
     || ((iCastingClass == CLASS_AVENGER) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_AVENGER, oCaster))
     || ((iCastingClass == CLASS_TYPE_ASSASSIN) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_ASSASSIN, oCaster))
     || ((iCastingClass == CLASS_TYPE_BLACKGUARD) && GetHasFeat(FEAT_PRACTICED_SPELLCASTER_BLACKGUARD, oCaster))
     || ((iCastingClass == CLASS_TYPE_SPIRIT_SHAMAN) && GetHasFeat(2003 /*FEAT_PRACTICED_SPELLCASTER_SPIRIT_SHAMAN*/, oCaster))
     || ((iCastingClass == CLASS_TYPE_FAVORED_SOUL) && GetHasFeat(2068 /*FEAT_PRACTICED_SPELLCASTER_FAVOURED_SOUL*/, oCaster))
     )
        return iBonus;

    return 0;
}



int JXImplGetCreatureSpellSaveDC(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    if (iSpellId < 0) return 0;

    // Get the class used to cast the current spell
    if (iClass == CLASS_TYPE_INVALID)
        iClass = GetLastSpellCastClass();

    // Get the best creature's class able to cast the spell
    if (iClass == CLASS_TYPE_INVALID)
        iClass = JXGetClassForSpell(iSpellId, oCreature);

    // Still no caster class found ? Then no caster level...
    if (iClass == CLASS_TYPE_INVALID) return 0;

    // Set the base spell save DC
    int iSpellSaveDC = 10;
    // Add the spell save DC bonus based on the spell level
    if (iClass == CLASS_TYPE_ASSASSIN)
        iSpellSaveDC += JXGetAssassinSpellLevel(iSpellId);
    else if (iClass == CLASS_TYPE_BLACKGUARD)
        iSpellSaveDC += JXGetBlackguardSpellLevel(iSpellId);
    else
        iSpellSaveDC += JXGetBaseSpellLevel(iSpellId, iClass);
    // Add the spell save DC bonus that depends on the spell
    iSpellSaveDC += JXImplGetSpellDCBonusFromSpell(iSpellId, oCreature);
    // Add the caster ability modifier
    int iAbility = -1;
    if (iClass == CLASS_TYPE_ASSASSIN)
        iAbility = ABILITY_INTELLIGENCE;
    else if (iClass == CLASS_TYPE_BLACKGUARD)
        iAbility = ABILITY_WISDOM;
    else
    {
        iAbility = JXClassGetCasterAbility(iClass);
    }
    iSpellSaveDC += GetAbilityModifier(iAbility, oCreature);

    return iSpellSaveDC;
}

