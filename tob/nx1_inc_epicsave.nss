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

int isEpicWizard();
int isEpicSorcerer();
int isEpicCleric();
int isEpicDruid();
int isEpicFavoredSoul();
int isEpicSpiritShaman();
int isEpicWarlock();

int GetEpicSpellSaveDC2()
{
    int nBonus = (GetCasterLevel(OBJECT_SELF)-20)/3; //+1DC every 3 levels after 20
    if (nBonus < 0)
    {
        nBonus = 0;
    }

    int nDC = 20 + GetHasFeat(FEAT_SPELLCASTING_PRODIGY);

    if (isEpicWizard())
    {
        nDC += GetAbilityModifier(ABILITY_INTELLIGENCE);
    }
    else if (isEpicSorcerer() || isEpicSpiritShaman() || isEpicWarlock())
    {
        nDC += GetAbilityModifier(ABILITY_CHARISMA);
    }
    else if (isEpicCleric() || isEpicDruid() || isEpicFavoredSoul())
    {
        nDC += GetAbilityModifier(ABILITY_WISDOM);
    }
    else nDC = GetSpellSaveDC(); //failsafe, if no class is found

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
        nCasterLevel += (GetLevelByClass(CLASS_TYPE_PALEMASTER) + 1)/ 2;
    }
    if (GetHasFeat(1822)) //eldritch knight
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ELDRITCH_KNIGHT) - 1;
    }
    if (GetHasFeat(1886)) //red wizard
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_RED_WIZARD);
    }
    if (GetHasFeat(1889)) //acrane scholar
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ARCANE_SCHOLAR);
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
        nCasterLevel += (GetLevelByClass(CLASS_TYPE_PALEMASTER) + 1)/ 2;
    }
    if (GetHasFeat(1821)) //eldritch knight
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ELDRITCH_KNIGHT) - 1;
    }
    if (GetHasFeat(1888)) //acrane scholar
    {
        nCasterLevel += GetLevelByClass(CLASS_TYPE_ARCANE_SCHOLAR);
    }

    if (nCasterLevel >= 18)
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
    if (GetHasFeat(2049)) //doomguide
    {
        nCasterLevel += GetLevelByClass(60);
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
    if (GetHasFeat(2051)) //doomguide
    {
        nCasterLevel += GetLevelByClass(60);
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
    if (GetHasFeat(2053)) //doomguide
    {
        nCasterLevel += GetLevelByClass(60);
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
    if (GetHasFeat(2052)) //doomguide
    {
        nCasterLevel += GetLevelByClass(60);
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

    if (nCasterLevel >= 16)
    {
        return TRUE;
    }
    return FALSE;
}