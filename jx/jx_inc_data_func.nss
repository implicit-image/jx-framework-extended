//::///////////////////////////////////////////////
//:: JX Spellcasting Data functions Include
//:: jx_inc_data_func
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: aug 18, 2007
//:://////////////////////////////////////////////
//
// This file contains functions that perform miscellaneous
// operations on basic data.
//
//:://////////////////////////////////////////////
// 09/09/2007 : Moved JXItemPropertyToString() & JXStringToItemProperty() from "jx_inc_magic_item.nss"
//              Added JXLocationToString() & JXStringToLocation()
//:://////////////////////////////////////////////

#include "x2_inc_itemprop"
#include "utils"





//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//

const int JX_DATATYPE_INTEGER       = 0;
const int JX_DATATYPE_FLOAT             = 1;
const int JX_DATATYPE_STRING        = 2;
const int JX_DATATYPE_OBJECT        = 3;
const int JX_DATATYPE_LOCATION      = 4;
const int JX_DATATYPE_ITEMPROPERTY  = 5;



// Replace a specific sub-string by another in a source string, and returns the result.
// If the source string contains many occurences of the sub-string, all occurences are replaced.
// - sSource String that contains the substrings to replace
// - sOld Sub-string to replace
// - sNew New value for the sub-string
// * Returns the modified source string
string JXStringReplace(string sSource, string sOld, string sNew);

// Replace a token by the specified value in a source string, and returns the result.
// If the source string contains many occurences of the token, all occurences are replaced.
// - sSource String that contains the substrings to replace
// - iCustomTokenNumber Token number (from 0 to 9999)
// - sTokenValue Value for the token
// * Returns the modified source string
string JXStringReplaceToken(string sSource, int iCustomTokenNumber, string sTokenValue);

// Count the number of sub-strings in a string, split by the specified separator.
// - sSource String to split
// - sSeparator Characters used to split the string
// * Returns the number of sub-strings
int JXStringSplitCount(string sSource, string sSeparator);

// Split a string using the specified separator, and returns the sub-string at the specified position.
// Use in conjunction with JXStringSplitCount() to get the number of available sub-strings.
// - sSource String to split
// - sSeparator Characters used to split the string
// - iRank Rank of the sub-string to get (starting at 0)
// * Returns the desired sub-string
string JXStringSplit(string sSource, string sSeparator, int iRank);

// Get a string from a corresponding item property
// - ipProperty Item property from which the string is get
// * Returns a string corresponding to the item property
string JXItemPropertyToString(itemproperty ipProperty);

// Get a an item property from a corresponding string
// - sItemProperty String from which the item property is get
// * Returns an item property corresponding to the string
itemproperty JXStringToItemProperty(string sItemProperty);

// Get a string from a corresponding location
// - lLocation Location from which the string is get
// * Returns a string corresponding to the location
string JXLocationToString(location lLocation);

// Get a location from a corresponding string
// - sLocation String from which the location is get
// * Returns a loation corresponding to the string
location JXStringToLocation(string sLocation);

string JXEffectName(int iEffect);

string JXModName(int iMod);

string JXModOpName(int iModOp);


















//**************************************//
//                                      //
//            Implementation            //
//                                      //
//**************************************//


// Replace a specific sub-string by another in a source string, and returns the result.
// If the source string contains many occurences of the sub-string, all occurences are replaced.
// - sSource String that contains the substrings to replace
// - sOld Sub-string to replace
// - sNew New value for the sub-string
// * Returns the modified source string
string JXStringReplace(string sSource, string sOld, string sNew)
{
    string sResult = sSource;

    int iPos = FindSubString(sResult, sOld);
    while (iPos != -1)
    {
        sResult = GetStringLeft(sResult, iPos) +
                  sNew +
                  GetStringRight(sResult, GetStringLength(sResult) - iPos - GetStringLength(sOld));
        iPos = FindSubString(sResult, sOld);
    }

    return sResult;
}

// Replace a token by the specified value in a source string, and returns the result.
// If the source string contains many occurences of the token, all occurences are replaced.
// - sSource String that contains the substrings to replace
// - iCustomTokenNumber Token number (from 0 to 9999)
// - sTokenValue Value for the token
// * Returns the modified source string
string JXStringReplaceToken(string sSource, int iCustomTokenNumber, string sTokenValue)
{
    string sToken = "<CUSTOM" + IntToString(iCustomTokenNumber) + ">";

    return JXStringReplace(sSource, sToken, sTokenValue);
}

// Count the number of sub-strings in a string, split by the specified separator.
// - sSource String to split
// - sSeparator Characters used to split the string
// * Returns the number of sub-strings
int JXStringSplitCount(string sSource, string sSeparator)
{
    int iCount = 1;
    string sTemp = sSource;

    int iPos = FindSubString(sTemp, sSeparator);
    while (iPos != -1)
    {
        iCount++;
        sTemp = GetStringRight(sTemp, GetStringLength(sTemp) - iPos - GetStringLength(sSeparator));
        iPos = FindSubString(sTemp, sSeparator);
    }

    return iCount;
}

// Split a string using the specified separator, and returns the sub-string at the specified position.
// Use in conjunction with JXStringSplitCount() to get the number of available sub-strings.
// - sSource String to split
// - sSeparator Characters used to split the string
// - iRank Rank of the sub-string to get (starting at 0)
// * Returns the desired sub-string
string JXStringSplit(string sSource, string sSeparator, int iRank)
{
    int iCount = 0;
    string sTemp = sSource;

    int iPos = FindSubString(sTemp, sSeparator);
    while (iPos != -1)
    {
        if (iCount == iRank)
            return GetStringLeft(sTemp, iPos);

        iCount++;
        sTemp = GetStringRight(sTemp, GetStringLength(sTemp) - iPos - GetStringLength(sSeparator));
        iPos = FindSubString(sTemp, sSeparator);
    }

    return sTemp;
}

// Get a string from a corresponding item property
// - ipProperty Item property from which the string is get
// * Returns a string corresponding to the item property
string JXItemPropertyToString(itemproperty ipProperty)
{
    // Get the identifier of the current item property
    int iIPType = GetItemPropertyType(ipProperty);

    if ((iIPType == ITEM_PROPERTY_MIND_BLANK)       // No ItemPropertyXXX() to create this property
     || (iIPType == ITEM_PROPERTY_ON_MONSTER_HIT))  // ItemPropertyOnMonsterHitProperties() is bugged
        return "";

    // Get other item property parameters
    int iIPSubType = GetItemPropertySubType(ipProperty);
    int iIPParam1Value = GetItemPropertyParam1Value(ipProperty);
    int iIPCostTableValue = GetItemPropertyCostTableValue(ipProperty);

    string sItemProperty = IntToString(iIPType);

    // Sub-type
    if ((iIPType == ITEM_PROPERTY_BONUS_FEAT)
     || (iIPType == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
     || (iIPType == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
     || (iIPType == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)
     || (iIPType == ITEM_PROPERTY_USE_LIMITATION_CLASS)
     || (iIPType == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE)
     || (iIPType == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT)
     || (iIPType == ITEM_PROPERTY_SPECIAL_WALK)
     || (iIPType == ITEM_PROPERTY_VISUALEFFECT))
        sItemProperty += "," + IntToString(iIPSubType);
    else
    // Cost table value
    if ((iIPType == ITEM_PROPERTY_AC_BONUS)
     || (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS)
     || (iIPType == ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER)
     || (iIPType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)
     || (iIPType == ITEM_PROPERTY_DECREASED_DAMAGE)
     || (iIPType == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)
     || (iIPType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)
     || (iIPType == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)
     || (iIPType == ITEM_PROPERTY_SPELL_RESISTANCE)
     || (iIPType == ITEM_PROPERTY_REGENERATION)
     || (iIPType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
     || (iIPType == ITEM_PROPERTY_THIEVES_TOOLS)
     || (iIPType == ITEM_PROPERTY_ATTACK_BONUS)
     || (iIPType == ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER)
     || (iIPType == ITEM_PROPERTY_UNLIMITED_AMMUNITION)
     || (iIPType == ITEM_PROPERTY_REGENERATION_VAMPIRIC)
     || (iIPType == ITEM_PROPERTY_BONUS_HITPOINTS)
     || (iIPType == ITEM_PROPERTY_TURN_RESISTANCE)
     || (iIPType == ITEM_PROPERTY_MASSIVE_CRITICALS)
     || (iIPType == ITEM_PROPERTY_MONSTER_DAMAGE)
     || (iIPType == ITEM_PROPERTY_HEALERS_KIT)
     || (iIPType == ITEM_PROPERTY_ARCANE_SPELL_FAILURE)
     || (iIPType == ITEM_PROPERTY_MIGHTY))
        sItemProperty += "," + IntToString(iIPCostTableValue);
    else
    // Cost table value + 1
    if (iIPType == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)
        sItemProperty += "," + IntToString(iIPCostTableValue + 1);
    else
    // Param1 value
    if (iIPType == ITEM_PROPERTY_WEIGHT_INCREASE)
        sItemProperty += "," + IntToString(iIPParam1Value);
    else
    // Sub-type + Cost table value
    if ((iIPType == ITEM_PROPERTY_ABILITY_BONUS)
     || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)
     || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)
     || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
     || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)
     || (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)
     || (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)
     || (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)
     || (iIPType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
     || (iIPType == ITEM_PROPERTY_CAST_SPELL)
     || (iIPType == ITEM_PROPERTY_DAMAGE_BONUS)
     || (iIPType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)
     || (iIPType == ITEM_PROPERTY_DAMAGE_RESISTANCE)
     || (iIPType == ITEM_PROPERTY_DAMAGE_VULNERABILITY)
     || (iIPType == ITEM_PROPERTY_DECREASED_ABILITY_SCORE)
     || (iIPType == ITEM_PROPERTY_DECREASED_AC)
     || (iIPType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
     || (iIPType == ITEM_PROPERTY_SAVING_THROW_BONUS)
     || (iIPType == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
     || (iIPType == ITEM_PROPERTY_DECREASED_SAVING_THROWS)
     || (iIPType == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC)
     || (iIPType == ITEM_PROPERTY_SKILL_BONUS)
     || (iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)
     || (iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)
     || (iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)
     || (iIPType == ITEM_PROPERTY_TRAP))
        sItemProperty += "," + IntToString(iIPSubType) + "," + IntToString(iIPCostTableValue);
    else
    // Sub-type + Cost table value + 1
    if (iIPType == ITEM_PROPERTY_ONHITCASTSPELL)
        sItemProperty += "," + IntToString(iIPSubType) + "," + IntToString(iIPCostTableValue + 1);
    else
    // Cost table value + Param1 value
    if (iIPType == ITEM_PROPERTY_LIGHT)
        sItemProperty += "," + IntToString(iIPCostTableValue) + "," + IntToString(iIPParam1Value);
    else
    // Sub-type + Cost table value + Param1 value
    if (iIPType == ITEM_PROPERTY_ON_HIT_PROPERTIES)
        sItemProperty += "," + IntToString(iIPSubType) + "," + IntToString(iIPCostTableValue) + "," + IntToString(iIPParam1Value);
    else
    // Sub-type + Param1 value + Cost table value
    if ((iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)
     || (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)
     || (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT))
        sItemProperty += "," + IntToString(iIPSubType) + "," + IntToString(iIPParam1Value) + "," + IntToString(iIPCostTableValue);
    // No parameter required
    /*
    else
    if ((iIPType == ITEM_PROPERTY_DARKVISION)
     || (iIPType == ITEM_PROPERTY_HASTE)
     || (iIPType == ITEM_PROPERTY_HOLY_AVENGER)
     || (iIPType == ITEM_PROPERTY_IMPROVED_EVASION)
     || (iIPType == ITEM_PROPERTY_KEEN)
     || (iIPType == ITEM_PROPERTY_NO_DAMAGE)
     || (iIPType == ITEM_PROPERTY_TRUE_SEEING)
     || (iIPType == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)) {}
    */

    // Item properties that don't exist
    /*
      ITEM_PROPERTY_DAMAGE_REDUCTION_DEPRECATED : deprecated !
      25 (Dancing Weapon) : not implemented
      30 (Double Stack) : not implemented
      31 (Enhanced Container Bonus Slot) : not implemented
      42 (unknown value) : not implemented
      68 (Vorpal) : not implemented (now On Hit subtype)
      69 (Wounding) : not implemented
      ITEM_PROPERTY_POISON : not implemented (now a On Hit subtype)
      ITEM_PROPERTY_DAMAGE_REDUCTION : ItemPropertyDamageReduction() is bugged and the property is never returned by GetFirst/NextItemProperty
                                       Currently = 85 (Arrow Catching), should be 90)
      86 (Bashing) : not implemented
      87 (Animated) : not implemented
      88 (Wild) : not implemented
      89 (Etherealness) : not implemented
      90 (Damage Reduction) : not implemented
    */

    return sItemProperty;
}

// Get an item property from a corresponding string
// - sItemProperty String from which the item property is get
// * Returns an item property corresponding to the string
itemproperty JXStringToItemProperty(string sItemProperty)
{
    itemproperty ipProperty;

    // Initialize all item property's parameters
    int iPrm = 1;
    int iIPType = 0;
    int iParam1 = 0;
    int iParam2 = 0;
    int iParam3 = 0;
    int iParam4 = 0;
    int iItemPropertyParam;

    // Loop on all item property's parameters
    int iPosComma = FindSubString(sItemProperty, ",");
    while (1)
    {
        // Get the current item property's parameter
        if (iPosComma == -1)
            iItemPropertyParam = StringToInt(sItemProperty);
        else
        {
            iItemPropertyParam = StringToInt(GetStringLeft(sItemProperty, iPosComma));
            sItemProperty = GetSubString(sItemProperty, iPosComma + 1, GetStringLength(sItemProperty) - iPosComma + 1);
        }
        // Define the value of the current item property's parameter
        if (iPrm == 1) iIPType = iItemPropertyParam;
        else if (iPrm == 2) iParam1 = iItemPropertyParam;
        else if (iPrm == 3) iParam2 = iItemPropertyParam;
        else if (iPrm == 4) iParam3 = iItemPropertyParam;
        else if (iPrm == 5) iParam4 = iItemPropertyParam;

        // End loop if there are no other item property's parameters
        if (iPosComma == -1) break;

        iPosComma = FindSubString(sItemProperty, ",");
        iPrm++;
    }
    ipProperty = IPGetItemPropertyByID(iIPType, iParam1, iParam2, iParam3, iParam4);

    return ipProperty;
}

// Get a string from a corresponding location
// - lLocation Location from which the string is get
// * Returns a string corresponding to the location
string JXLocationToString(location lLocation)
{
    // Get the location informations : area, position, orientation
    object oArea = GetAreaFromLocation(lLocation);
    vector vPosition = GetPositionFromLocation(lLocation);
    float fOrientation = GetFacingFromLocation(lLocation);

    string sArea = IntToString(ObjectToInt(oArea));
    string sPosX = FloatToString(vPosition.x);
    string sPosY = FloatToString(vPosition.y);
    string sPosZ = FloatToString(vPosition.z);
    string sOrientation = FloatToString(fOrientation);

    return sArea + "!" + sPosX + "!" + sPosY + "!" + sPosZ + "!" + sOrientation;
}

// Get a location from a corresponding string
// - sLocation String from which the location is get
// * Returns a loation corresponding to the string
location JXStringToLocation(string sLocation)
{
    object oArea = IntToObject(StringToInt(JXStringSplit(sLocation, "!", 0)));
    vector vPosition;
    vPosition.x = StringToFloat(JXStringSplit(sLocation, "!", 1));
    vPosition.y = StringToFloat(JXStringSplit(sLocation, "!", 2));
    vPosition.z = StringToFloat(JXStringSplit(sLocation, "!", 3));
    float fOrientation = StringToFloat(JXStringSplit(sLocation, "!", 4));

    return Location(oArea, vPosition, fOrientation);
}

string JXEffectName(int iEffect)
{
    switch (iEffect)
    {
        case JX_EFFECT_HEAL:                       return "JX_EFFECT_HEAL";
        case JX_EFFECT_DAMAGE:                     return "JX_EFFECT_DAMAGE";
        case JX_EFFECT_DAMAGE_OVER_TIME:           return "JX_EFFECT_DAMAGE_OVER_TIME";
        case JX_EFFECT_ABILITY_INCREASE:           return "JX_EFFECT_ABILITY_INCREASE";
        case JX_EFFECT_DAMAGE_RESISTANCE:          return "JX_EFFECT_DAMAGE_RESISTANCE";
        case JX_EFFECT_RESURRECTION:               return "JX_EFFECT_RESURRECTION";
        case JX_EFFECT_SUMMON_CREATURE:            return "JX_EFFECT_SUMMON_CREATURE";
        case JX_EFFECT_AC_INCREASE:                return "JX_EFFECT_AC_INCREASE";
        case JX_EFFECT_SAVING_THROW_INCREASE:      return "JX_EFFECT_SAVING_THROW_INCREASE";
        case JX_EFFECT_ATTACK_INCREASE:            return "JX_EFFECT_ATTACK_INCREASE";
        case JX_EFFECT_DAMAGE_REDUCTION:           return "JX_EFFECT_DMAAGE_REDUCTION";
        case JX_EFFECT_DAMAGE_INCREASE:            return "JX_EFFECT_DAMAGE_INCREASE";
        case JX_EFFECT_ENTANGLE:                   return "JX_EFFECT_ENTANGLE";
        case JX_EFFECT_DEATH:                      return "JX_EFFECT_DEATH";
        case JX_EFFECT_KNOCKDOWN:                  return "JX_EFFECT_KNOCKDOWN";
        case JX_EFFECT_CURSE:                      return "JX_EFFECT_CURSE";
        case JX_EFFECT_PARALYZE:                   return "JX_EFFECT_PARALYZE";
        case JX_EFFECT_SPELL_IMMUNITY:             return "JX_EFFECT_SPELL_IMMUNITY";
        case JX_EFFECT_DEAF:                       return "JX_EFFECT_DEAF";
        case JX_EFFECT_SLEEP:                      return "JX_EFFECT_SLEEP";
        case JX_EFFECT_CHARMED:                    return "JX_EFFECT_CHARMED";
        case JX_EFFECT_CONFUSED:                   return "JX_EFFECT_CONFUSED";
        case JX_EFFECT_FRIGHTENED:                 return "JX_EFFECT_FRIGHTENED";
        case JX_EFFECT_DOMINATED:                  return "JX_EFFECT_DOMINATED";
        case JX_EFFECT_DAZED:                      return "JX_EFFECT_DAZED";
        case JX_EFFECT_STUNNED:                    return "JX_EFFECT_STUNNED";
        case JX_EFFECT_REGENERATE:                 return "JX_EFFECT_REGENERATE";
        case JX_EFFECT_MOVEMENT_SPEED_INCREASE:    return "JX_EFFECT_MOVEMENT_SPEED_INCREASE";
        case JX_EFFECT_SPELL_RESISTANCE_INCREASE:  return "JX_EFFECT_SPELL_RESISTANCE_INCREASE";
        case JX_EFFECT_POISON:                     return "JX_EFFECT_POISON";
        case JX_EFFECT_DISEASE:                    return "JX_EFFECT_DISEASE";
        case JX_EFFECT_SILENCE:                    return "JX_EFFECT_SILENCE";
        case JX_EFFECT_HASTE:                      return "JX_EFFECT_HASTE";
        case JX_EFFECT_SLOW:                       return "JX_EFFECT_SLOW";
        case JX_EFFECT_IMMUNITY:                   return "JX_EFFECT_IMMUNITY";
        case JX_EFFECT_DAMAGE_IMMUNITY_INCREASE:   return "JX_EFFECT_DAMAGE_IMMUNITY_INCREASE";
        case JX_EFFECT_TEMPORARY_HITPOINTS:        return "JX_EFFECT_TEMPORARY_HITPOINTS";
        case JX_EFFECT_SKILL_INCREASE:             return "JX_EFFECT_SKILL_INCREASE";
        case JX_EFFECT_TURNED:                     return "JX_EFFECT_TURNED";
        case JX_EFFECT_HITPOINT_CHANGE_WHEN_DYING: return "JX_EFFECT_HITPOINT_CHANGE_WHEN_DYING";
        case JX_EFFECT_ABILITY_DECREASE:           return "JX_EFFECT_ABILITY_DECREASE";
        case JX_EFFECT_ATTACK_DECREASE:            return "JX_EFFECT_ATTACK_DECREASE";
        case JX_EFFECT_DAMAGE_DECREASE:            return "JX_EFFECT_DAMAGE_DECREASE";
        case JX_EFFECT_DAMAGE_IMMUNITY_DECREASE:   return "JX_EFFECT_DAMAGE_IMMUNITY_DECREASE";
        case JX_EFFECT_AC_DECREASE:                return "JX_EFFECT_AC_DECREASE";
        case JX_EFFECT_MOVEMENT_SPEED_DECREASE:    return "JX_EFFECT_MOVEMENT_SPEED_DECREASE";
        case JX_EFFECT_SAVING_THROW_DECREASE:      return "JX_EFFECT_SAVING_THROW_DECREASE";
        case JX_EFFECT_SKILL_DECREASE:             return "JX_EFFECT_SKILL_DECREASE";
        case JX_EFFECT_SPELL_RESISTANCE_DECREASE:  return "JX_EFFECT_SPELL_RESISTANCE_DECREASE";
        case JX_EFFECT_INVISIBILITY:               return "JX_EFFECT_INVISIBILITY";
        case JX_EFFECT_CONCEALMENT:                return "JX_EFFECT_CONCEALMENT";
        case JX_EFFECT_DARKNESS:                   return "JX_EFFECT_DARKNESS";
        case JX_EFFECT_ULTRAVISION:                return "JX_EFFECT_ULTRAVISION";
        case JX_EFFECT_NEGATIVE_LEVEL:             return "JX_EFFECT_NEGATIVE_LEVEL";
        case JX_EFFECT_POLYMORPH:                  return "JX_EFFECT_POLYMORPH";
        case JX_EFFECT_SANCTUARY:                  return "JX_EFFECT_SANCTUARY";
        case JX_EFFECT_TRUE_SEEING:                return "JX_EFFECT_TRUE_SEEING";
        case JX_EFFECT_SEE_INVISIBLE:              return "JX_EFFECT_SEE_INVISIBLE";
        case JX_EFFECT_TIME_STOP:                  return "JX_EFFECT_TIME_STOP";
        case JX_EFFECT_BLINDESS:                   return "JX_EFFECT_BLINDESS";
        case JX_EFFECT_SPELL_LEVEL_ABSORPTION:     return "JX_EFFECT_SPELL_LEVEL_ABSORPTION";
        case JX_EFFECT_MISS_CHANCE:                return "JX_EFFECT_MISS_CHANCE";
        case JX_EFFECT_MODIFY_ATTACKS:             return "JX_EFFECT_MODIFY_ATTACKS";
        case JX_EFFECT_DAMAGE_SHIELD:              return "JX_EFFECT_DAMAGE_SHIELD";
        case JX_EFFECT_SWARM:                      return "JX_EFFECT_SWARM";
        case JX_EFFECT_TURN_RESISTANCE_DECREASE:   return "JX_EFFECT_TURN_RESISTANCE_DECREASE";
        case JX_EFFECT_TURN_RESISTANCE_INCREASE:   return "JX_EFFECT_TURN_RESISTANCE_INCREASE";
        case JX_EFFECT_PETRIFY:                    return "JX_EFFECT_PETRIFY";
        case JX_EFFECT_SPELL_FAILURE:              return "JX_EFFECT_SPELL_FAILURE";
        case JX_EFFECT_ETHEREAL:                   return "JX_EFFECT_ETHEREAL";
        case JX_EFFECT_DETECT_UNDEAD:              return "JX_EFFECT_DETECT_UNDEAD";
        case JX_EFFECT_LOW_LIGHT_VISION:           return "JX_EFFECT_LOW_LIGHT_VISION";
        case JX_EFFECT_SET_SCALE:                  return "JX_EFFECT_SET_SCALE";
        case JX_EFFECT_SHARE_DAMAGE:               return "JX_EFFECT_SHARE_DAMAGE";
        case JX_EFFECT_ASSAY_RESISTANCE:           return "JX_EFFECT_ASSAY_RESISTANCE";
        case JX_EFFECT_SEE_TRUE_HPS:               return "JX_EFFECT_SEE_TRUE_HPS";
        case JX_EFFECT_ABSORB_DAMAGE:              return "JX_EFFECT_ABSORB_DAMAGE";
        case JX_EFFECT_HIDEOUS_BLOW:               return "JX_EFFECT_HIDEOUS_BLOW";
        case JX_EFFECT_MESMERIZE:                  return "JX_EFFECT_MESMERIZE";
        case JX_EFFECT_DARK_VISION:                return "JX_EFFECT_DARK_VISION";
        case JX_EFFECT_ARMOR_CHECK_PENALTY_INCREASE: return "JX_EFFECT_ARMOR_CHECK_PENALTY_INCREASE";
        case JX_EFFECT_DESINTEGRATE:               return "JX_EFFECT_DESINTEGRATE";
        case JX_EFFECT_HEAL_ON_ZERO_HP:            return "JX_EFFECT_HEAL_ON_ZERO_HP";
        case JX_EFFECT_BREAK_ENCHANTMENT:          return "JX_EFFECT_BREAK_ENCHANTMENT";
        case JX_EFFECT_BONUS_HITPOINTS:            return "JX_EFFECT_BONUS_HITPOINTS";
        case JX_EFFECT_BARD_SONG_SINGING:          return "JX_EFFECT_BARD_SONG_SINGING";
        case JX_EFFECT_JARRING:                    return "JX_EFFECT_JARRING";
        case JX_EFFECT_BAB_MINIMUM:                return "JX_EFFECT_BAB_MINIMUM";
        case JX_EFFECT_MAX_DAMAGE:                 return "JX_EFFECT_MAX_DAMAGE";
        case JX_EFFECT_ARCANE_SPELL_FAILURE:       return "JX_EFFECT_ARCANE_SPELL_FAILURE";
        case JX_EFFECT_WILD_SHAPE:                 return "JX_EFFECT_WILD_SHAPE";
        case JX_EFFECT_RESCUE:                     return "JX_EFFECT_RESCUE";
        case JX_EFFECT_DETECT_SPIRITS:             return "JX_EFFECT_DETECT_SPIRITS";
        case JX_EFFECT_DAMAGE_REDUCTION_NEGATED:   return "JX_EFFECT_DAMAGE_REDUCTION_NEGATED";
        case JX_EFFECT_CONCEALMENT_NEGATED:        return "JX_EFFECT_CONCEALMENT_NEGATED";
        case JX_EFFECT_INSANE:                     return "JX_EFFECT_INSANE";
        case JX_EFFECT_SUMMON_COPY:                return "JX_EFFECT_SUMMON_COPY";
        case JX_EFFECT_SHAKEN:                     return "JX_EFFECT_SHAKEN";
    }

    return "<INVALID EFFECT ID (" + IntToString(iEffect) + ")>";
}

string JXModName(int iMod)
{
    switch(iMod)
    {
        case JX_EFFECT_MOD_TYPE_PARAM_1:           return "JX_EFFECT_MOD_TYPE_PARAM_1";
        case JX_EFFECT_MOD_TYPE_PARAM_2:           return "JX_EFFECT_MOD_TYPE_PARAM_2";
        case JX_EFFECT_MOD_TYPE_PARAM_3:           return "JX_EFFECT_MOD_TYPE_PARAM_3";
        case JX_EFFECT_MOD_TYPE_PARAM_4:           return "JX_EFFECT_MOD_TYPE_PARAM_4";
        case JX_EFFECT_MOD_TYPE_PARAM_5:           return "JX_EFFECT_MOD_TYPE_PARAM_5";
        case JX_EFFECT_MOD_TYPE_PARAM_6:           return "JX_EFFECT_MOD_TYPE_PARAM_6";
        case JX_EFFECT_MOD_TYPE_PARAM_7:           return "JX_EFFECT_MOD_TYPE_PARAM_7";
        case JX_EFFECT_MOD_TYPE_PARAM_8:           return "JX_EFFECT_MOD_TYPE_PARAM_8";
        case JX_EFFECT_MOD_TYPE_PARAM_9:           return "JX_EFFECT_MOD_TYPE_PARAM_9";
        case JX_EFFECT_MOD_TYPE_EFFECT_PROP:       return "JX_EFFECT_MOD_TYPE_EFFECT_PROP";
        case JX_EFFECT_MOD_TYPE_DISABLE_EFFECT:    return "JX_EFFECT_MOD_TYPE_DISABLE_EFFECT";
        case JX_EFFECT_MOD_TYPE_SUBSTITUTE_EFFECT: return "JX_EFFECT_MOD_TYPE_SUBSTITUTE_EFFECT";
        case JX_EFFECT_MOD_TYPE_LINK_EFFECT:       return "JX_EFFECT_MOD_TYPE_LINK_EFFECT";
    }
    return "<INVALID EFFECT MOD ID (" + IntToString(iMod) + ")>";
}

string JXModOpName(int iModOp)
{
    switch(iModOp)
    {
        case JX_EFFECT_MOD_OP_PARAM_INCREASE_BY : return "JX_EFFECT_MOD_OP_PARAM_INCREASE_BY";
        case JX_EFFECT_MOD_OP_PARAM_DECREASE_BY : return "JX_EFFECT_MOD_OP_PARAM_DECREASE_BY";
        case JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY : return "JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY";
        case JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY : return "JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY";
        case JX_EFFECT_MOD_OP_PARAM_LOGIC_OR : return "JX_EFFECT_MOD_OP_PARAM_LOGIC_OR";
        case JX_EFFECT_MOD_OP_PARAM_LOGIC_AND : return "JX_EFFECT_MOD_OP_PARAM_LOGIC_AND";
        case JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND : return "JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND";
        case JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND : return "JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND";
        case JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND : return "JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND";
        case JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND : return "JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND";
        case JX_EFFECT_MOD_OP_PARAM_MAX : return "JX_EFFECT_MOD_OP_PARAM_MAX";
        case JX_EFFECT_MOD_OP_PARAM_MIN : return "JX_EFFECT_MOD_OP_PARAM_MIN";
        case JX_EFFECT_MOD_OP_PARAM_OVERRIDE : return "JX_EFFECT_MOD_OP_PARAM_OVERRIDE";
        case JX_EFFECT_MOD_OP_PARAM_MAP : return "JX_EFFECT_MOD_OP_PARAM_MAP";
        default: return "<INVALID EFFECT MOD OP ID(" + IntToString(iModOp) + ")>";
    }
    return "<INVALID EFFECT MOD OP ID(" + IntToString(iModOp) + ")>";
}
