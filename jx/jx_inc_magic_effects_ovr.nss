#include "jx_inc_spell_helpers"

//###############################################
// Setters and Getters  for override effect data
//###############################################

// ability type
int JXGetOverrideAbilityType(int iEffectType, int iAbilityType)
{
    int iAbility = GetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_ABILITY_TYPE_MAP, iEffectType);
    if (iAbility == 0)
        return -1;
    return iAbility;
}

void JXSetOverrideAbilityType(int iEffectType, int iAbilityFrom, int iAbilityTo)
{
    SetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_ABILITY_TYPE_MAP)
}




// bonus effect link
effect JXGetOverrideBonusEffectLink(int iEffectType)
{
    string sEffectRepr = GetLocalArrayString(OBJECT_SELF, JX_OVERRIDE_STR_ARR_BONUS_LINK, iEffectType);
    return JXEffectFromString(sEffectRepr);
}

void JXSetOverrideBonusEffectLink(int iEffectType, struct override_effect EffectLink)
{
    string sEffectRepr = JXOverrideEffectToString(EffectLink);
    SetLocalArrayString(OBJECT_SELF, JX_OVERRIDE_STR_ARR_BONUS_LINK, iEffectType, sEffectRepr);
}

// ignore default effect

int JXGetOverrideIgnoreDefaultEffect(int iEffectType)
{
    int bIgnoreDefault = GetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_IGNORE_DEFAULT, iEffectType);
    if (bIgnoreDefault == 0)
        return -1;
    return ~bIgnoreDefault;
}

void JXSetOverrideIgnoreDefaultEffect(int iEffectType, int bIgnore=TRUE)
{
    SetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_IGNORE_DEFAULT, iEffectType, ~bIgnore);
}

// flat bonus
//
//
int JXGetOverrideFlatBonus(int iEffectType)
{
    int iFlatBonus = GetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_FLAT_BONUS, iEffectType);
    return iFlatBonus;
}

void JXSetOverrideFlatBonus(int iEffectType, int iFlatbonus)
{
    SetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_FLAT_BONUS, iEffectType, iFlatBonus);
}

// random bonus

int JXGetOverrideRandBonus(int iEffectType)
{
    string sRandBousInfo = GetLocalArrayString(OBJECT_SELF, JX_OVERRIDE_STR_ARRAY_RAND_BONUS, iEffectType);
    return JXRollRandBonus(sRandBonusInfo);

}

void JXSetOverrideRandBonus(int iEffectType, int iNumDice, int iNumSides)
{
    SetLocalArrayString(OBJECT_SELF, JX_OVERRIDE_STR_ARR_RAND_BONUS, iEffectType, IntoToString(iNumDice) + JX_SEP_GEN + IntoToString(iNumSides));
}

// damage type chage

// returns what damage type iDamageType should be overriden by
int JXGetOverrideDamageType(int iEffectType, int iDamageType)
{
    string sMap = GetLocalArrayString(OBJECT_SELF, JX_OVERRRIDE_STR_ARR_DAMAGE_TYPE, iEffectType);
    int iDamageTypeOverride = JXIntMapGetValue(sMap, IntToString(iDamageType));
    if (sMap = "" || iDamageTypeOverride == -1)
            // not overriden
            return iDamageType;
    return iDamageTypeOverride;
}

void JXSetOverrideDamageType(int iEffectType, int iDamageTypeFrom, int iDamageTypeTo)
{
    string sCurrMap = GetLocalArrayString(OBJECT_SELF, JX_OVERRIDE_STR_ARR_DAMAGE_TYPE_MAP, iEffectDamage);
    // sCurrMap is DAMAGE_TYPE_FIRE : DAMAGE_TYPE_DIVINE ; DAMAGE_TYPE_COLD : DAMAGE_TYPE_MAGICAL
    sCurrMap = JXIntMapSet(sCurrMap, iDamageTypeFrom, iDamageTypeTo);
    SetLocalArrayString(OBJECT_SELF, JX_OVERRIDE_STR_ARR_DAMAGE_TYPE_MAP, iEffectType, sCurrMap);
}

// Damage interval

float JXGetOverrideInterval(int iEffectType)
{
    int iMiliseconds = GetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_INTERVAL, iEffectType);
    if (iMiliseconds == 0) return -1
    return IntToFloat(iMiliseconds) / 1000;
}

void JXSetOverrideInterval(int iEffectType,  float fInterval)
{
    int iMiliseconds = FloatToInt(fInterval * 1000.0);
    SetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_INTERVAL, iEffectType, iMiliseconds);
}

// Ignore Damage Resistences

int JXGetOverrideIgnoreResistances(int iEffectType)
{
    int bIgnoreRes = GetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_IGNORE_DMG_RES, iEffectType);
    if (bIgnoreRes == 0) return -1;
    return ~bIgnoreRes;
}

void JXSetOverrideIgnoreResistances(int iEffectType, int bIgnore)
{
    SetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_IGNORE_DMG_RES, iEffectType, ~bIgnore);
}

// damage power

int JXGetOverrideDamagePower(int iEffectType)
{
    int iDamagePower = GetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_DMG_POWER, iEffectType);
    if (iDamagePower == 0) return -1;
    return ~iDamagePower;
}

void JXSetOverrideDamagePower(iEffectType, int iDamagePower)
{
    SetLocalArrayInt(OBJECT_SELF, JX_OVERRIDE_INT_ARR_DMG_POWER, iEffectType, ~iDamagePower);
}

//helper functions for clearing override tables

void JXClearOverrideStringArray(string sOverrideArrayName, object oTarget=OBJECT_SELF)
{
    ClearLocalStringArray(oTarget, sOverrideArrayName, JX_MAX_EFFECT_ID);
}

void JXClearOverrideIntArray(string sOverrideArrayName, object oTarget=OBJECT_SELF)
{
    ClearLocalIntArray(oTarget, sOverrideArrayName, JX_MAX_EFFECT_ID);
}
