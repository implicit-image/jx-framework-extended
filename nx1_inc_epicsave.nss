/*
  Epic Spell DC workaround

  GetSpellSaveDC() is problematic when used with feats, like epic spells.
  If epic spell is taken with prestige class, it will use primary ability
  of prestige class (defined in classes.2da) when calculating spell DC
  and not spellcasting ability of base class that prestige classes uses.

  For example, Pale Master Sorcerer who takes Vampiric Feast with Palemaster
  level will use Int bonus for epic spell save DC, even if his Int is very low.

  Current workaround will extrapolate correct base class, whose primary ability
  should be used.

  Note: This should be upadeted whenever new class is added to the game.

*/
// RPGplayer1 11/17/08 - completely reworked workaround
// RPGplayer1 11/30/08 - updated to take into account Doomguide PrC
// RPGplayer1 01/19/09 - fixed several bugs related to sorcerers and warlocks, added failsafe
// RPGplayer1 02/12/09 - tweaked failsafe (GetSpellSaveDC already takes into account Spellcasting Prodigy)
// RPGplayer1 02/14/09 - added support for Safiya influence feats
#include "jx_inc_magic"
#include "cmi_includes"

int isEpicWizard();
int isEpicSorcerer();
int isEpicBard();
int isEpicCleric();
int isEpicDruid();
int isEpicFavoredSoul();
int isEpicSpiritShaman();
int isEpicWarlock();

int GetEpicSpellSaveDC2()
{
    int nBonus = (JXGetCasterLevel(OBJECT_SELF)-20)/3; //+1DC every 3 levels after 20
    if (nBonus < 0)
    {
        nBonus = 0;
    }

    int nDC = 20 + GetHasFeat(FEAT_SPELLCASTING_PRODIGY);

    if (isEpicWizard())
    {
        nDC += GetAbilityModifier(ABILITY_INTELLIGENCE);
    }
    else if (isEpicSorcerer() || isEpicSpiritShaman() || isEpicWarlock()  || isEpicBard())
    {
        nDC += GetAbilityModifier(ABILITY_CHARISMA);
    }
    else if (isEpicCleric() || isEpicDruid() || isEpicFavoredSoul())
    {
        nDC += GetAbilityModifier(ABILITY_WISDOM);
    }
    else nDC = JXGetSpellSaveDC(); //failsafe, if no class is found

    nDC += 2*GetHasFeat(2056) + 4*GetHasFeat(2057); //Safiya influence: +2DC if loyal, +4DC if devoted

    nDC += nBonus;
    return nDC;
}

int isEpicWizard()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_WIZARD);

    if (GetHasFeat(1514)) //acrane trickster
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ARCANETRICKSTER);
    }
    if (GetHasFeat(1579)) //harper
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_HARPER) - 1;
    }
    if (GetHasFeat(1804)) //pale master
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_PALEMASTER) - 1;
    }
    if (GetHasFeat(1822)) //eldritch knight
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ELDRITCH_KNIGHT) - 1;
    }
    if (GetHasFeat(1886)) //red wizard
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_RED_WIZARD);
    }
    if (GetHasFeat(1889)) //arcane scholar
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ARCANE_SCHOLAR);
    }
    if (GetHasFeat(5517)) //wildmage
    {
        nCasterLevel += GetLevelByClass(253);
    }
    if (GetHasFeat(3719)) //daggerspell mage
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_MAGE) - 1;
    }
    if (GetHasFeat(3114)) //bladsinger
    {
        nCasterLevel += (GetLevelByClass(CLASS_BLADESINGER) - 1) / 2;
    }
    if (GetHasFeat(3283)) //Frost Mage
    {
        nCasterLevel += GetLevelByClass(CLASS_FROST_MAGE);
    }
    if (GetHasFeat(3270)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3328)) //canaith lyrist
    {
        nCasterLevel += GetLevelByClass(CLASS_CANAITH_LYRIST);
    }
    if (GetHasFeat(3128)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3371)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3584)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3162)) //swiftblade
    {
        int nSwiftbladeLevel = GetLevelByClass(CLASS_SWIFTBLADE);
		
			if (nSwiftbladeLevel > 9)
				nCasterLevel += (nSwiftbladeLevel - 4);
			else if (nSwiftbladeLevel > 6)
				nCasterLevel += (nSwiftbladeLevel - 3);
			else if (nSwiftbladeLevel > 3)
				nCasterLevel += (nSwiftbladeLevel - 2);
			else
				nCasterLevel += (nSwiftbladeLevel - 1);
    }
    if (GetHasFeat(5095)) //magelord
    {
        nCasterLevel += GetLevelByClass(91);
    }
    if (GetHasFeat(5098)) //incantarix
    {
        nCasterLevel += GetLevelByClass(89);
    }
    if (GetHasFeat(1544)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(5034)) //arcane devotee
    {
        nCasterLevel += GetLevelByClass(88);
    }
    if (GetHasFeat(5015)) //archmage
    {
        nCasterLevel += GetLevelByClass(81);
    }
    if (GetHasFeat(5013)) //Loremaster
    {
        nCasterLevel += GetLevelByClass(80);
    }

    if (nCasterLevel >= 17)
    {
        return TRUE;
    }
    return FALSE;
}

int isEpicSorcerer()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_SORCERER);

    if (GetHasFeat(1513)) //acrane trickster
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ARCANETRICKSTER);
    }
    if (GetHasFeat(1578)) //harper
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_HARPER) - 1;
    }
    if (GetHasFeat(1802)) //pale master
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_PALEMASTER) - 1;
    }
    if (GetHasFeat(1821)) //eldritch knight
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ELDRITCH_KNIGHT) - 1;
    }
    if (GetHasFeat(1888)) //arcane scholar
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ARCANE_SCHOLAR);
    }
    if (GetHasFeat(3717)) //daggerspell mage
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_MAGE) - 1;
    }
    if (GetHasFeat(3113)) //bladsinger
    {
        nCasterLevel += (GetLevelByClass(CLASS_BLADESINGER) - 1) / 2;
    }
    if (GetHasFeat(3281)) //Frost Mage
    {
        nCasterLevel += GetLevelByClass(CLASS_FROST_MAGE);
    }
    if (GetHasFeat(3268)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3326)) //canaith lyrist
    {
        nCasterLevel += GetLevelByClass(CLASS_CANAITH_LYRIST);
    }
    if (GetHasFeat(3127)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3369)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3582)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3161)) //swiftblade
    {
        int nSwiftbladeLevel = GetLevelByClass(CLASS_SWIFTBLADE);
		
			if (nSwiftbladeLevel > 9)
				nCasterLevel += (nSwiftbladeLevel - 4);
			else if (nSwiftbladeLevel > 6)
				nCasterLevel += (nSwiftbladeLevel - 3);
			else if (nSwiftbladeLevel > 3)
				nCasterLevel += (nSwiftbladeLevel - 2);
			else
				nCasterLevel += (nSwiftbladeLevel - 1);
    }
    if (GetHasFeat(5094)) //magelord
    {
        nCasterLevel += GetLevelByClass(91);
    }
    if (GetHasFeat(5097)) //incantarix
    {
        nCasterLevel += GetLevelByClass(89);
    }
    if (GetHasFeat(1543)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(5033)) //arcane devotee
    {
        nCasterLevel += GetLevelByClass(88);
    }
    if (GetHasFeat(5014)) //archmage
    {
        nCasterLevel += GetLevelByClass(81);
    }
    if (GetHasFeat(5012)) //Loremaster
    {
        nCasterLevel += GetLevelByClass(80);
    }

    if (nCasterLevel >= 18)
    {
        return TRUE;
    }
    return FALSE;
}

int isEpicBard()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_BARD);
	
    if (GetHasFeat(3568)) //dis chord
    {
        nCasterLevel += GetLevelByClass(CLASS_DISSONANT_CHORD);
    }
    if (GetHasFeat(3329)) //lyric thaumaturge
    {
        nCasterLevel += GetLevelByClass(CLASS_LYRIC_THAUMATURGE);
    }
    if (GetHasFeat(3320)) //canaith lyrist
    {
        nCasterLevel += GetLevelByClass(CLASS_CANAITH_LYRIST);
    }
    if (GetHasFeat(3126)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3275)) //Frost Mage
    {
        nCasterLevel += GetLevelByClass(CLASS_FROST_MAGE);
    }
    if (GetHasFeat(3262)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3363)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3112)) //bladsinger
    {
        nCasterLevel += (GetLevelByClass(CLASS_BLADESINGER) - 1) / 2;
    }
    if (GetHasFeat(3716)) //daggerspell mage
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_MAGE) - 1;
    }
    if (GetHasFeat(3332)) //knight of tierdrial
    {
        nCasterLevel += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL);
    }
    if (GetHasFeat(3576)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3160)) //swiftblade
    {
        int nSwiftbladeLevel = GetLevelByClass(CLASS_SWIFTBLADE);
		
			if (nSwiftbladeLevel > 9)
				nCasterLevel += (nSwiftbladeLevel - 4);
			else if (nSwiftbladeLevel > 6)
				nCasterLevel += (nSwiftbladeLevel - 3);
			else if (nSwiftbladeLevel > 3)
				nCasterLevel += (nSwiftbladeLevel - 2);
			else
				nCasterLevel += (nSwiftbladeLevel - 1);
    }
    if (GetHasFeat(1542)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(5093)) //magelord
    {
        nCasterLevel += GetLevelByClass(91);
    }
    if (GetHasFeat(5096)) //incantarix
    {
        nCasterLevel += GetLevelByClass(89);
    }
    if (GetHasFeat(5011)) //Loremaster
    {
        nCasterLevel += GetLevelByClass(80);
    }
	
    if (nCasterLevel >= 16)
    {
        return TRUE;
    }
    return FALSE;
}

int isEpicCleric()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_CLERIC);

    if (GetHasFeat(1549)) //sacred fist
    {
        nCasterLevel += (GetLevelByClass(CLASS_TYPE_SACREDFIST) + 1) * 3/4;
    }
    if (GetHasFeat(1576)) //harper
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_HARPER) - 1;
    }
    if (GetHasFeat(1808)) //warpriest
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_WARPRIEST) / 2;
    }
    if (GetHasFeat(2033)) //stormlord
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_STORMLORD);
    }
    if (GetHasFeat(2249)) //doomguide
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_DOOMGUIDE);
    }
    if (GetHasFeat(1545)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(3006)) //black flame zealot
    {
        nCasterLevel += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT) / 2;
    }
    if (GetHasFeat(3000)) //shining blade
    {
        nCasterLevel += GetLevelByClass(CLASS_SHINING_BLADE) / 2;
    }
    if (GetHasFeat(3148)) //lion of talisid
    {
        nCasterLevel += GetLevelByClass(CLASS_LION_TALISID);
    }
    if (GetHasFeat(3121)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3276)) //Frost Mage
    {
        nCasterLevel += GetLevelByClass(CLASS_FROST_MAGE);
    }
    if (GetHasFeat(3321)) //canaith lyrist
    {
        nCasterLevel += GetLevelByClass(CLASS_CANAITH_LYRIST);
    }
    if (GetHasFeat(3263)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3333)) //knight of tierdrial
    {
        nCasterLevel += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL);
    }
    if (GetHasFeat(3179)) //master of radiance
    {
        nCasterLevel += GetLevelByClass(CLASS_MASTER_RADIANCE) - 1;
    }
    if (GetHasFeat(3345)) //shadowbane stalker
    {
        int nShadowbaneLevel = GetLevelByClass(CLASS_SHADOWBANE_STALKER);
		
			if (nShadowbaneLevel > 8)
				nCasterLevel += (nShadowbaneLevel - 2);
			else if (nShadowbaneLevel > 3)
				nCasterLevel += (nShadowbaneLevel - 1);
			else
				nCasterLevel += nShadowbaneLevel;
    }
    if (GetHasFeat(3210)) //forest master
    {
        int nForestLevel = GetLevelByClass(CLASS_FOREST_MASTER);
		
			if (nForestLevel > 7)
				nCasterLevel += (nForestLevel - 2);
			else if (nForestLevel > 3)
				nCasterLevel += (nForestLevel - 1);
			else
				nCasterLevel += nForestLevel;
    }
    if (GetHasFeat(3364)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3720)) //daggerspell shaper
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER) - 1;
    }
    if (GetHasFeat(3577)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3380)) //eldrich disciple
    {
        nCasterLevel += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE);
    }

    if (nCasterLevel >= 17)
    {
        return TRUE;
    }
    return FALSE;
}

int isEpicDruid()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_DRUID);

    if (GetHasFeat(1550)) //sacred fist
    {
        nCasterLevel += (GetLevelByClass(CLASS_TYPE_SACREDFIST) + 1) * 3/4;
    }
    if (GetHasFeat(1577)) //harper
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_HARPER) - 1;
    }
    if (GetHasFeat(1809)) //warpriest
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_WARPRIEST) / 2;
    }
    if (GetHasFeat(2034)) //stormlord
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_STORMLORD);
    }
    if (GetHasFeat(2251)) //doomguide
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_DOOMGUIDE);
    }
    if (GetHasFeat(3252)) //nature warrior
    {
        nCasterLevel += GetLevelByClass(CLASS_NATURES_WARRIOR) / 2;
    }
    if (GetHasFeat(1546)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(3007)) //black flame zealot
    {
        nCasterLevel += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT) / 2;
    }
    if (GetHasFeat(3001)) //shining blade
    {
        nCasterLevel += GetLevelByClass(CLASS_SHINING_BLADE) / 2;
    }
    if (GetHasFeat(3149)) //lion of talisid
    {
        nCasterLevel += GetLevelByClass(CLASS_LION_TALISID);
    }
    if (GetHasFeat(3122)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3277)) //Frost Mage
    {
        nCasterLevel += GetLevelByClass(CLASS_FROST_MAGE);
    }
    if (GetHasFeat(3322)) //canaith lyrist
    {
        nCasterLevel += GetLevelByClass(CLASS_CANAITH_LYRIST);
    }
    if (GetHasFeat(3264)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3334)) //knight of tierdrial
    {
        nCasterLevel += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL);
    }
    if (GetHasFeat(3180)) //master of radiance
    {
        nCasterLevel += GetLevelByClass(CLASS_MASTER_RADIANCE) - 1;
    }
    if (GetHasFeat(3211)) //forest master
    {
        int nForestLevel = GetLevelByClass(CLASS_FOREST_MASTER);
		
			if (nForestLevel > 7)
				nCasterLevel += (nForestLevel - 2);
			else if (nForestLevel > 3)
				nCasterLevel += (nForestLevel - 1);
			else
				nCasterLevel += nForestLevel;
    }
    if (GetHasFeat(3346)) //shadowbane stalker
    {
        int nShadowbaneLevel = GetLevelByClass(CLASS_SHADOWBANE_STALKER);
		
			if (nShadowbaneLevel > 8)
				nCasterLevel += (nShadowbaneLevel - 2);
			else if (nShadowbaneLevel > 3)
				nCasterLevel += (nShadowbaneLevel - 1);
			else
				nCasterLevel += nShadowbaneLevel;
    }
    if (GetHasFeat(3365)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3721)) //daggerspell shaper
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER) - 1;
    }
    if (GetHasFeat(3578)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3381)) //eldrich disciple
    {
        nCasterLevel += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE);
    }

    if (nCasterLevel >= 17)
    {
        return TRUE;
    }
    return FALSE;
}

int isEpicFavoredSoul()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_FAVORED_SOUL);

    if (GetHasFeat(2078)) //harper
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_HARPER) - 1;
    }
    if (GetHasFeat(2079)) //warpriest
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_WARPRIEST) / 2;
    }
    if (GetHasFeat(2080)) //stormlord
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_STORMLORD);
    }
    if (GetHasFeat(2102)) //sacred fist
    {
        nCasterLevel += (GetLevelByClass(CLASS_TYPE_SACREDFIST) + 1) * 3/4;
    }
    if (GetHasFeat(2253)) //doomguide
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_DOOMGUIDE);
    }
    if (GetHasFeat(3402)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(3010)) //black flame zealot
    {
        nCasterLevel += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT) / 2;
    }
    if (GetHasFeat(3004)) //shining blade
    {
        nCasterLevel += GetLevelByClass(CLASS_SHINING_BLADE) / 2;
    }
    if (GetHasFeat(3152)) //lion of talisid
    {
        nCasterLevel += GetLevelByClass(CLASS_LION_TALISID);
    }
    if (GetHasFeat(3125)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3278)) //Frost Mage
    {
        nCasterLevel += GetLevelByClass(CLASS_FROST_MAGE);
    }
    if (GetHasFeat(3323)) //canaith lyrist
    {
        nCasterLevel += GetLevelByClass(CLASS_CANAITH_LYRIST);
    }
    if (GetHasFeat(3265)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3335)) //knight of tierdrial
    {
        nCasterLevel += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL);
    }
    if (GetHasFeat(3183)) //master of radiance
    {
        nCasterLevel += GetLevelByClass(CLASS_MASTER_RADIANCE) - 1;
    }
    if (GetHasFeat(3347)) //shadowbane stalker
    {
        int nShadowbaneLevel = GetLevelByClass(CLASS_SHADOWBANE_STALKER);
		
			if (nShadowbaneLevel > 8)
				nCasterLevel += (nShadowbaneLevel - 2);
			else if (nShadowbaneLevel > 3)
				nCasterLevel += (nShadowbaneLevel - 1);
			else
				nCasterLevel += nShadowbaneLevel;
    }
    if (GetHasFeat(3212)) //forest master
    {
        int nForestLevel = GetLevelByClass(CLASS_FOREST_MASTER);
		
			if (nForestLevel > 7)
				nCasterLevel += (nForestLevel - 2);
			else if (nForestLevel > 3)
				nCasterLevel += (nForestLevel - 1);
			else
				nCasterLevel += nForestLevel;
    }
    if (GetHasFeat(3366)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3722)) //daggerspell shaper
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER) - 1;
    }
    if (GetHasFeat(3579)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3382)) //eldrich disciple
    {
        nCasterLevel += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE);
    }

    if (nCasterLevel >= 18)
    {
        return TRUE;
    }
    return FALSE;
}

int isEpicSpiritShaman()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN);

    if (GetHasFeat(2013)) //harper
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_HARPER) - 1;
    }
    if (GetHasFeat(2014)) //warpriest
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_WARPRIEST) / 2;
    }
    if (GetHasFeat(2037)) //stormlord
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_STORMLORD);
    }
    if (GetHasFeat(2101)) //sacred fist
    {
        nCasterLevel += (GetLevelByClass(CLASS_TYPE_SACREDFIST) + 1) * 3/4;
    }
    if (GetHasFeat(2252)) //doomguide
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_DOOMGUIDE);
    }
    if (GetHasFeat(4301)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(3005)) //black flame zealot
    {
        nCasterLevel += GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT) / 2;
    }
    if (GetHasFeat(2999)) //shining blade
    {
        nCasterLevel += GetLevelByClass(CLASS_SHINING_BLADE) / 2;
    }
    if (GetHasFeat(3147)) //lion of talisid
    {
        nCasterLevel += GetLevelByClass(CLASS_LION_TALISID);
    }
    if (GetHasFeat(3120)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3282)) //Frost Mage
    {
        nCasterLevel += GetLevelByClass(CLASS_FROST_MAGE);
    }
    if (GetHasFeat(3327)) //canaith lyrist
    {
        nCasterLevel += GetLevelByClass(CLASS_CANAITH_LYRIST);
    }
    if (GetHasFeat(3269)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3339)) //knight of tierdrial
    {
        nCasterLevel += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL);
    }
    if (GetHasFeat(3178)) //master of radiance
    {
        nCasterLevel += GetLevelByClass(CLASS_MASTER_RADIANCE) - 1;
    }
    if (GetHasFeat(3350)) //shadowbane stalker
    {
        int nShadowbaneLevel = GetLevelByClass(CLASS_SHADOWBANE_STALKER);
		
			if (nShadowbaneLevel > 8)
				nCasterLevel += (nShadowbaneLevel - 2);
			else if (nShadowbaneLevel > 3)
				nCasterLevel += (nShadowbaneLevel - 1);
			else
				nCasterLevel += nShadowbaneLevel;
    }
    if (GetHasFeat(3215)) //forest master
    {
        int nForestLevel = GetLevelByClass(CLASS_FOREST_MASTER);
		
			if (nForestLevel > 7)
				nCasterLevel += (nForestLevel - 2);
			else if (nForestLevel > 3)
				nCasterLevel += (nForestLevel - 1);
			else
				nCasterLevel += nForestLevel;
    }
    if (GetHasFeat(3370)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3725)) //daggerspell shaper
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_SHAPER) - 1;
    }
    if (GetHasFeat(3583)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3385)) //eldrich disciple
    {
        nCasterLevel += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE);
    }

    if (nCasterLevel >= 18)
    {
        return TRUE;
    }
    return FALSE;
}

int isEpicWarlock()
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_WARLOCK);
	
    if (GetHasFeat(2164)) //Hellfire Warlock
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_HELLFIRE_WARLOCK);
    }
    if (GetHasFeat(1678)) //mystic theurge
    {
        nCasterLevel += GetLevelByClass(44);
    }
    if (GetHasFeat(3718)) //daggerspell mage
    {
        nCasterLevel += GetLevelByClass(CLASS_DAGGERSPELL_MAGE) - 1;
    }
    if (GetHasFeat(3585)) //child of night
    {
        nCasterLevel += GetLevelByClass(CLASS_CHILD_NIGHT) - 1;
    }
    if (GetHasFeat(3545)) //Stormsinger
    {
        nCasterLevel += GetLevelByClass(CLASS_STORMSINGER);
    }
    if (GetHasFeat(3372)) //dragonslayer
    {
        nCasterLevel += 1 + ((GetLevelByClass(CLASS_DRAGONSLAYER) - 1) / 2);
    }
    if (GetHasFeat(3341)) //knight of tierdrial
    {
        nCasterLevel += GetLevelByClass(CLASS_KNIGHT_TIERDRIAL);
    }
    if (GetHasFeat(3271)) //heartwarder
    {
        nCasterLevel += GetLevelByClass(CLASS_HEARTWARDER);
    }
    if (GetHasFeat(3386)) //eldrich disciple
    {
        nCasterLevel += GetLevelByClass(CLASS_ELDRITCH_DISCIPLE);
    }
	
    if (nCasterLevel >= 16)
    {
        return TRUE;
    }
    return FALSE;
}