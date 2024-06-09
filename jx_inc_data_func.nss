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















//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//

const int JX_DATATYPE_INTEGER		= 0;
const int JX_DATATYPE_FLOAT			= 1;
const int JX_DATATYPE_STRING		= 2;
const int JX_DATATYPE_OBJECT		= 3;
const int JX_DATATYPE_LOCATION		= 4;
const int JX_DATATYPE_ITEMPROPERTY	= 5;



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

	if ((iIPType == ITEM_PROPERTY_MIND_BLANK)		// No ItemPropertyXXX() to create this property
	 || (iIPType == ITEM_PROPERTY_ON_MONSTER_HIT))	// ItemPropertyOnMonsterHitProperties() is bugged
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