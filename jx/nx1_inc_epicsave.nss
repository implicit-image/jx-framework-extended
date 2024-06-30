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
#include "jx_epic_spell_interface"


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

