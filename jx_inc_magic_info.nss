//::///////////////////////////////////////////////
//:: JX Spellcasting Library Include
//:: jx_inc_magic_info
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: Mar 7, 2007
//:: Updated On: Mar 13, 2007
//:: Updated On: Mar 23, 2007
//:: Updated On: Apr 22, 2007
//:://////////////////////////////////////////////
//
// This include file provides functions to get many information
// about spells that aren't available in the standard game.
//
//:://////////////////////////////////////////////
// 03/13/2007 : Added JXGetIsSpellASpell() and JXGetIsSpellNotASpell()
// 03/23/2007 : * Splitted JXGetIsSpellASpell() and JXGetIsSpellNotASpell() into JXGetIsSpellMagical(),
//                JXGetIsSpellSupernatural(), JXGetIsSpellExtraordinary() & JXGetIsSpellMiscellaneous()
//              * Added JXGetHasSpellDescriptor() & JXGetIsItemPropertyMagical() functions
// 04/22/2007 : Added JXGetSpellSchool() and JXGetSpellSchoolName()
// 08/19/2007 : Added JXGetSpellName() & JXGetSavingThrow()
// 09/09/2007 : Added JXGetSpellType(), JXGetBaseSpellLevel() & JXGetCasterAbility()
// 10/12/2007 : Added JXGetSpellSubSchool()
// 10/24/2007 : * Added JXClassGetMemorizesSpells(), JXClassGetHasInfiniteSpells(), JXClassGetHasInfiniteSpells(),
//              JXClassGetKnowsAllSpells() & JXClassGetHasDomains() functions
//              * Renamed JXGetCasterAbility() into JXClassGetCasterAbility()
//:://////////////////////////////////////////////

#include "jx_inc_magic_const"
#include "jx_inc_script_call"
















//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//



// Get the name of a spell
// - iSpellId Identifier of the spell
// * Returns the name of the specified spell
string JXGetSpellName(int iSpellId);

// Get the range type of a spell
// - iSpellId Identifier of the spell
// * Return a SPELLRANGE_* constant
int JXGetSpellRangeType(int iSpellId);

// Get the range of a spell
// - iSpellId Identifier of the spell
// * Return the spell range
float JXGetSpellRange(int iSpellId);

// Indicate if the spell can target an area
// - iSpellId Identifier of the spell
// * Return TRUE if the spell can target an area
int JXGetHasSpellTargetTypeArea(int iSpellId);

// Indicate if a spell is using a ranged touch attack
// - iSpellId Identifier of the spell
// * Returns TRUE if the spell uses a ranged touch attack
int JXGetIsSpellUsingRangedTouchAttack(int iSpellId);

// Indicate if a spell is a spell or a spell-like ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a spell or a spell-like ability
int JXGetIsSpellMagical(int iSpellId);

// Indicate if a spell is a supernatural ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a supernatural ability
int JXGetIsSpellSupernatural(int iSpellId);

// Indicate if a spell is an extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is an extraordinary ability
int JXGetIsSpellExtraordinary(int iSpellId);

// Indicate if a spell isn't a spell, spell-like, supernatural or extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell isn't a spell, spell-like, supernatural or extraordinary ability
int JXGetIsSpellMiscellaneous(int iSpellId);

// Indicate if a spell has the specified descriptor
// - iSpellId SPELL_* constant
// - iDescriptor JX_SPELLDESCRIPTOR_* constant
// * Returns TRUE if the spell has the specified spell descriptor
int JXGetHasSpellDescriptor(int iSpellId, int iDescriptor = JX_SPELLDESCRIPTOR_ANY);

// Get the spell school of a spell
// - iSpellId SPELL_* constant
// * Returns a SPELL_SCHOOL_* constant
int JXGetSpellSchool(int iSpellId);

// Get the spell subschool of a spell
// - iSpellId SPELL_* constant
// * Returns a JX_SPELLSUBSCHOOL_* constant
int JXGetSpellSubSchool(int iSpellId);

// Get the spell school name from a spell school identifier
// - iSpellSchool SPELL_SCHOOL_* constant
// * Returns the name of a spell school
string JXGetSpellSchoolName(int iSpellSchool);

// Get the saving throw (fortitude, reflex or will) of a creature, door, or placeable.
// Contrary to GetFortitudeSavingThrow() functions and the like, this function
// take into account active effects and item properties' increased and decreased
// saving throws versus specific effects.
// - iSave SAVING_THROW_FORT, SAVING_THROW_REFLEX or SAVING_THROW_WILL
// - iSaveVsType SAVING_THROW_TYPE_* constant
// * Returns the specified saving throw
int JXGetSavingThrow(object oCreature, int iSave, int iSaveVsType = SAVING_THROW_ALL);

// Get the spell type : none, arcane, divine, or both
// - iSpellId SPELL_* constant
// * Returns a JX_SPELLTYPE_* constant
int JXGetSpellType(int iSpellId);

// Get the level of a spell, innate or depending on a caster class
// - iClass Class that is able to cast the spell (-1 for innate)
// * Returns the spell level, or -1 if the spell is not accessible to the class
int JXGetBaseSpellLevel(int iSpellId, int iClass = -1);

// Get the main ability for a spellcasting class
// - iClass The class from which to get the main spellcasting ability
// * Returns an ABILITY_* constant, or -1 if the class doesn't have any spellcasting ability
int JXClassGetCasterAbility(int iClass);

// Determine if a class must memorize spells
// - iClass Class to test
// * Returns TRUE if the class must memorize spells
int JXClassGetMemorizesSpells(int iClass);

// Determine if a class can cast its spells infinitely
// - iClass Class to test
// * Returns TRUE if the class has infinite spells
int JXClassGetHasInfiniteSpells(int iClass);

// Determine if a class knows all the spells associated with it
// - iClass Class to test
// * Returns TRUE if all spells are known for the the class
int JXClassGetKnowsAllSpells(int iClass);

// Determine if a class has domain spells
// - iClass Class to test
// * Returns TRUE if all spells are known for the the class
int JXClassGetHasDomains(int iClass);






















//**************************************//
//                                      //
//            Implementation            //
//                                      //
//**************************************//


// Get the name of a spell
// - iSpellId Identifier of the spell
// * Returns the name of the specified spell
string JXGetSpellName(int iSpellId)
{
	string sSpellNameStrRef = Get2DAString("spells", "Name", iSpellId);
	if (sSpellNameStrRef == "") return "";

	return GetStringByStrRef(StringToInt(sSpellNameStrRef));
}

// Get the range type of a spell
// - iSpellId Identifier of the spell
// * Return a SPELLRANGE_* constant
int JXGetSpellRangeType(int iSpellId)
{
	string sRange = Get2DAString("spells", "Range", iSpellId);
	if (sRange == "S") return JX_SPELLRANGE_SHORT;
	if (sRange == "M") return JX_SPELLRANGE_MEDIUM;
	if (sRange == "L") return JX_SPELLRANGE_LONG;
	if (sRange == "P") return JX_SPELLRANGE_PERSONAL;
	if (sRange == "T") return JX_SPELLRANGE_TOUCH;
	return JX_SPELLRANGE_INVALID;
}

// Get the range of a spell
// - iSpellId Identifier of the spell
// * Return the spell range
float JXGetSpellRange(int iSpellId)
{
	int iRangeType = JXGetSpellRangeType(iSpellId);
	switch (iRangeType)
	{
		case JX_SPELLRANGE_SHORT : return 8.0;
		case JX_SPELLRANGE_MEDIUM : return 20.0;
		case JX_SPELLRANGE_LONG : return 40.0;
	}
	return 0.0;
}

// Private function - used in JXGetIsTargetTypeArea()
int JXPrivateHexStringToInt(string hex)
{
	int dec = 0;

	// We don't care about the "0x" prefix
	hex = GetSubString(hex, 2, GetStringLength(hex) - 2);
	int len = GetStringLength(hex);

	int i;
	string digit;
	int multiplier;
	for (i = 0; i < len; i++)
	{
		digit = GetSubString(hex, i, 1);
		if (GetStringUpperCase(digit) == "A")
			multiplier = 10;
		else if (GetStringUpperCase(digit) == "B")
			multiplier = 11;
		else if (GetStringUpperCase(digit) == "C")
			multiplier = 12;
		else if (GetStringUpperCase(digit) == "D")
			multiplier = 13;
		else if (GetStringUpperCase(digit) == "E")
			multiplier = 14;
		else if (GetStringUpperCase(digit) == "F")
			multiplier = 15;
		else
			multiplier = StringToInt(digit);

		int j;
		int digitLoc = 1;
		for (j = 1; j < len -i; j++)
			digitLoc *= 16;
		dec += multiplier * digitLoc;
	}

	return dec;
}

// Indicate if the spell can target an area
// - iSpellId Identifier of the spell
// * Return TRUE if the spell can target an area
int JXGetHasSpellTargetTypeArea(int iSpellId)
{
	string sTargetType = Get2DAString("spells", "TargetType", iSpellId);
	int iTargetType = JXPrivateHexStringToInt(sTargetType);
	int iTargetTypeArea = 4;

	if ((iTargetType & iTargetTypeArea) == iTargetTypeArea)
		return TRUE;
	else
		return FALSE;
}

// Indicate if a spell is using a ranged touch attack
// - iSpellId Identifier of the spell
// * Returns TRUE if the spell uses a ranged touch attack
int JXGetIsSpellUsingRangedTouchAttack(int iSpellId)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLRANGEDTOUCHATTACK, paramList);

	return JXScriptGetResponseInt();
}

// Indicate if a spell is a spell or a spell-like ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a spell or a spell-like ability
int JXGetIsSpellMagical(int iSpellId)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLMAGICAL, paramList);

	return JXScriptGetResponseInt();
}

// Indicate if a spell is a supernatural ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a supernatural ability
int JXGetIsSpellSupernatural(int iSpellId)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLSUPERNATURAL, paramList);

	return JXScriptGetResponseInt();
}

// Indicate if a spell is an extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is an extraordinary ability
int JXGetIsSpellExtraordinary(int iSpellId)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLEXTRAORDINARY, paramList);

	return JXScriptGetResponseInt();
}

// Indicate if a spell isn't a spell, spell-like, supernatural or extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell isn't a spell, spell-like, supernatural or extraordinary ability
int JXGetIsSpellMiscellaneous(int iSpellId)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLMISCELLANEOUS, paramList);

	return JXScriptGetResponseInt();
}

// Indicate if a spell has the specified descriptor
// - iSpellId SPELL_* constant
// - iDescriptor JX_SPELLDESCRIPTOR_* constant
// * Returns TRUE if the spell has the specified spell descriptor
int JXGetHasSpellDescriptor(int iSpellId, int iDescriptor = JX_SPELLDESCRIPTOR_ANY)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterInt(paramList, iDescriptor);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLDESCRIPTOR, paramList);

	return JXScriptGetResponseInt();
}

// Get the spell school of a spell
// - iSpellId SPELL_* constant
// * Returns a SPELL_SCHOOL_* constant
int JXGetSpellSchool(int iSpellId)
{
    string sSchool = Get2DAString("spells", "School", iSpellId);
    if (sSchool == "A") return SPELL_SCHOOL_ABJURATION;
    if (sSchool == "C") return SPELL_SCHOOL_CONJURATION;
    if (sSchool == "D") return SPELL_SCHOOL_DIVINATION;
    if (sSchool == "E") return SPELL_SCHOOL_ENCHANTMENT;
    if (sSchool == "V") return SPELL_SCHOOL_EVOCATION;
    if (sSchool == "I") return SPELL_SCHOOL_ILLUSION;
    if (sSchool == "N") return SPELL_SCHOOL_NECROMANCY;
    if (sSchool == "T") return SPELL_SCHOOL_TRANSMUTATION;

    return SPELL_SCHOOL_GENERAL;
}

// Get the spell subschool of a spell
// - iSpellId SPELL_* constant
// * Returns a JX_SPELLSUBSCHOOL_* constant
int JXGetSpellSubSchool(int iSpellId)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLSUBSCHOOL, paramList);

	return JXScriptGetResponseInt();
}

// Get the spell school name from a spell school identifier
// - iSpellSchool SPELL_SCHOOL_* constant
// * Returns the name of a spell school
string JXGetSpellSchoolName(int iSpellSchool)
{
    switch (iSpellSchool)
    {
        case SPELL_SCHOOL_ABJURATION: return GetStringByStrRef(969);
        case SPELL_SCHOOL_CONJURATION: return GetStringByStrRef(970);
        case SPELL_SCHOOL_DIVINATION: return GetStringByStrRef(971);
        case SPELL_SCHOOL_ENCHANTMENT: return GetStringByStrRef(972);
        case SPELL_SCHOOL_EVOCATION: return GetStringByStrRef(973);
        case SPELL_SCHOOL_ILLUSION: return GetStringByStrRef(974);
        case SPELL_SCHOOL_NECROMANCY: return GetStringByStrRef(975);
        case SPELL_SCHOOL_TRANSMUTATION: return GetStringByStrRef(976);
    }
    return "";
}

// Get the saving throw (fortitude, reflex or will) of a creature, door, or placeable.
// Contrary to GetFortitudeSavingThrow() function and the like, this function
// take into account active effects and item properties' increased and decreased
// saving throws versus specific effects.
// - oTarget Creature, door, or placeable from which the saving throw is get
// - iSave SAVING_THROW_FORT, SAVING_THROW_REFLEX or SAVING_THROW_WILL
// - iSaveVsType SAVING_THROW_TYPE_* constant
// * Returns the specified saving throw
int JXGetSavingThrow(object oTarget, int iSave, int iSaveVsType = SAVING_THROW_ALL)
{
	// Test if the target is a valid creature
	if (!GetIsObjectValid(oTarget))
		return 0;

	// Get the base saving throw
	int iBaseSave;
	switch (iSave)
	{
		case SAVING_THROW_FORT :
			iBaseSave = GetFortitudeSavingThrow(oTarget);
			break;
		case SAVING_THROW_REFLEX :
			iBaseSave = GetReflexSavingThrow(oTarget);
			break;
		case SAVING_THROW_WILL :
			iBaseSave = GetWillSavingThrow(oTarget);
			break;
	}

	if ((GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
	 || (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE))
	 	return iBaseSave;

	// Get the effect modifier
	int iEffectModifier = 0;
	int iSaveTemp;
	int iSaveVsTypeTemp;
	effect eLoop = GetFirstEffect(oTarget);
	while (GetIsEffectValid(eLoop))
	{
		if (GetEffectType(eLoop) == EFFECT_TYPE_SAVING_THROW_INCREASE)
		{
			// Get the saving throw type (SAVING_THROW_* constant)
			iSaveTemp = GetEffectInteger(eLoop, 1);
			// Get the type of decreased saving throw (SAVING_THROW_TYPE_* constant)
			iSaveVsTypeTemp = GetEffectInteger(eLoop, 2);
			
			if (((iSaveTemp == iSave) || (iSaveTemp == SAVING_THROW_ALL))
			 && (iSaveVsTypeTemp == iSaveVsType))
			{
				iEffectModifier += GetEffectInteger(eLoop, 0);
			}
		}
		else if (GetEffectType(eLoop) == EFFECT_TYPE_SAVING_THROW_DECREASE)
		{
			// Get the saving throw type (SAVING_THROW_* constant)
			iSaveTemp = GetEffectInteger(eLoop, 1);
			// Get the type of decreased saving throw (SAVING_THROW_TYPE_* constant)
			iSaveVsTypeTemp = GetEffectInteger(eLoop, 2);
			
			if (((iSaveTemp == iSave) || (iSaveTemp == SAVING_THROW_ALL))
			 && (iSaveVsTypeTemp == iSaveVsType))
			{
				// Get the saving throw decreased value
				iEffectModifier -= GetEffectInteger(eLoop, 0);
			}
		}
		eLoop = GetNextEffect(oTarget);
	}

	// Get the item properties' saving throws vs type
	int iIPSaveVsType = -1;
	switch (iSaveVsType)
	{
		case SAVING_THROW_TYPE_ALL :			iIPSaveVsType = IP_CONST_SAVEVS_UNIVERSAL; break;
		case SAVING_THROW_TYPE_ACID :			iIPSaveVsType = IP_CONST_SAVEVS_ACID; break;
		case SAVING_THROW_TYPE_COLD :			iIPSaveVsType = IP_CONST_SAVEVS_COLD; break;
		case SAVING_THROW_TYPE_DEATH :			iIPSaveVsType = IP_CONST_SAVEVS_DEATH; break;
		case SAVING_THROW_TYPE_DISEASE :		iIPSaveVsType = IP_CONST_SAVEVS_DISEASE; break;
		case SAVING_THROW_TYPE_DIVINE :			iIPSaveVsType = IP_CONST_SAVEVS_DIVINE; break;
		case SAVING_THROW_TYPE_ELECTRICITY :	iIPSaveVsType = IP_CONST_SAVEVS_ELECTRICAL; break;
		case SAVING_THROW_TYPE_FEAR	:			iIPSaveVsType = IP_CONST_SAVEVS_FEAR; break;
		case SAVING_THROW_TYPE_FIRE :			iIPSaveVsType = IP_CONST_SAVEVS_FIRE; break;
		case SAVING_THROW_TYPE_MIND_SPELLS :	iIPSaveVsType = IP_CONST_SAVEVS_MINDAFFECTING; break;
		case SAVING_THROW_TYPE_NEGATIVE :		iIPSaveVsType = IP_CONST_SAVEVS_NEGATIVE; break;
		case SAVING_THROW_TYPE_POISON :			iIPSaveVsType = IP_CONST_SAVEVS_POISON; break;
		case SAVING_THROW_TYPE_POSITIVE :		iIPSaveVsType = IP_CONST_SAVEVS_POSITIVE; break;
		case SAVING_THROW_TYPE_SONIC :			iIPSaveVsType = IP_CONST_SAVEVS_SONIC; break;
	}

	// Get the item property modifier
	int iItemPropModifier = 0;
	if (iIPSaveVsType != -1)
	{
		// Loop all all items held by the creature
		itemproperty ipLoop;
		object oItemHeld; int iLoop;
		for (iLoop = 0; iLoop < 17; iLoop++)
		{
			oItemHeld = GetItemInSlot(iLoop, oTarget);
			if (GetIsObjectValid(oItemHeld)
			 && (GetItemHasItemProperty(oItemHeld, ITEM_PROPERTY_SAVING_THROW_BONUS)
			  || GetItemHasItemProperty(oItemHeld, ITEM_PROPERTY_DECREASED_SAVING_THROWS)))
			{
				// Loop all item propeties of an item
				ipLoop = GetFirstItemProperty(oItemHeld);
				while (GetIsItemPropertyValid(ipLoop))
				{
					// Item property that increases saving throws vs type found
					if ((GetItemPropertyType(ipLoop) == ITEM_PROPERTY_SAVING_THROW_BONUS)
					 && ((GetItemPropertySubType(ipLoop) == iIPSaveVsType)
					  || (GetItemPropertySubType(ipLoop) == IP_CONST_SAVEVS_UNIVERSAL)))
						iItemPropModifier += GetItemPropertyCostTableValue(ipLoop);
					// Item property that decreases saving throws vs type found
					else if ((GetItemPropertyType(ipLoop) == ITEM_PROPERTY_DECREASED_SAVING_THROWS)
					 && ((GetItemPropertySubType(ipLoop) == iIPSaveVsType)
					  || (GetItemPropertySubType(ipLoop) == IP_CONST_SAVEVS_UNIVERSAL)))
						iItemPropModifier -= GetItemPropertyCostTableValue(ipLoop);
					ipLoop = GetNextItemProperty(oItemHeld);
				}
			}
		}
	}

	return iBaseSave + iEffectModifier + iItemPropModifier;
}

// Get the spell type : none, arcane, divine, or both
// - iSpellId SPELL_* constant
// * Returns a JX_SPELLTYPE_* constant
int JXGetSpellType(int iSpellId)
{
	int iArcane = 0;
	int iDivine = 0;

	// Check if the spell type is arcane
	if (Get2DAString("spells", "Wiz_Sorc", iSpellId) != "") iArcane = 1;
	if ((iArcane == 0) && (Get2DAString("spells", "Warlock", iSpellId) != "")) iArcane = 1;
	if ((iArcane == 0) && (Get2DAString("spells", "Bard", iSpellId) != "")) iArcane = 1;

	// Check if the spell type is divine
	if (Get2DAString("spells", "Cleric", iSpellId) != "") iDivine = 1;
	if ((iDivine == 0) && (Get2DAString("spells", "Druid", iSpellId) != "")) iDivine = 1;
	if ((iDivine == 0) && (Get2DAString("spells", "Ranger", iSpellId) != "")) iDivine = 1;
	if ((iDivine == 0) && (Get2DAString("spells", "Paladin", iSpellId) != "")) iDivine = 1;

	return iArcane + iDivine;
}

// Get the level of a spell, innate or depending on a caster class
// - iClass Class that is able to cast the spell (CLASS_TYPE_INVALID for innate)
// * Returns the spell level, or -1 if the spell is not accessible to the class
int JXGetBaseSpellLevel(int iSpellId, int iClass = CLASS_TYPE_INVALID)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterInt(paramList, iClass);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_SPELLLEVEL, paramList);

	return JXScriptGetResponseInt();
}

// Get the main ability for a spellcasting class
// - iClass The class from which to get the main spellcasting ability
// * Returns an ABILITY_* constant, or -1 if the class doesn't have any spellcasting ability
int JXClassGetCasterAbility(int iClass)
{
	string sAbility = Get2DAString("classes", "SpellAbil", iClass);

	if (sAbility == "STR")
		return ABILITY_STRENGTH;
	if (sAbility == "DEX")
		return ABILITY_DEXTERITY;
	if (sAbility == "CON")
		return ABILITY_CONSTITUTION;
	if (sAbility == "INT")
		return ABILITY_INTELLIGENCE;
	if (sAbility == "WIS")
		return ABILITY_WISDOM;
	if (sAbility == "CHA")
		return ABILITY_CHARISMA;

	return -1;
}

// Determine if a class must memorize spells
// - iClass Class to test
// * Returns TRUE if the class must memorize spells
int JXClassGetMemorizesSpells(int iClass)
{
	return StringToInt(Get2DAString("classes", "MemorizesSpells", iClass));
}

// Determine if a class can cast its spells infinitely
// - iClass Class to test
// * Returns TRUE if the class has infinite spells
int JXClassGetHasInfiniteSpells(int iClass)
{
	return StringToInt(Get2DAString("classes", "HasInfiniteSpells", iClass));
}

// Determine if a class knows all the spells associated with it
// - iClass Class to test
// * Returns TRUE if all spells are known for the the class
int JXClassGetKnowsAllSpells(int iClass)
{
	return StringToInt(Get2DAString("classes", "AllSpellsKnown", iClass));
}

// Determine if a class has domain spells
// - iClass Class to test
// * Returns TRUE if all spells are known for the the class
int JXClassGetHasDomains(int iClass)
{
	return StringToInt(Get2DAString("classes", "HasDomains", iClass));
}