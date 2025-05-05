//::///////////////////////////////////////////////
//:: JX Spellcasting Item Include
//:: jx_inc_magic_item
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: Mar 23, 2007
//:: Updated On: Apr 22, 2007
//:://////////////////////////////////////////////
//
// This include file provides functions to manage magical items
// that aren't available in the standard game.
//
//:://////////////////////////////////////////////
// 04/22/2007 : Added JXGetItemPropertyCasterLevel(), JXGetItemCasterLevel(),
//              JXGetItemPropertySpellSchool() and JXGetItemSpellSchool()
// 07/16/2007 : Added JXGetEffectFromItemProperty()
//              Modified JXGetItemCasterLevel() and JXGetItemSpellSchool()
//              to take a new optional parameter
// 08/19/2007 : * Added JXSetHiddenItemProperties() & JXGetHiddenItemProperties()
//              * Added JXSetItemCasterLevel(), JXSetItemSpellSchool()
//              * Added JXGetItemSaveXXX() & JXSetItemSaveXXX()
//              * Added JXMyItemSavingThrow()
//              * Renamed JXGet/SetXXXOnItem() in JXGet/SetItemSpellXXX()
// 09/09/2007 : Moved JXItemPropertyToString() & JXStringToItemProperty() to "jx_inc_data_func.nss"
//:://////////////////////////////////////////////

#include "jx_inc_magic_info"


//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//


//========================================== Spell Alteration ==========================================//

// Get the metamagic value (METAMAGIC_*) for the specified spell set as a "Cast Spell" property on an item.
// The returned value may contain many metamagic values : use the AND operator (&) instead
// of the Equal (==) operator to compare the result of this function with a metamagic value.
// Ex: if (JXGetMetaMagicFeat() & METAMAGIC_EXTEND) ...
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// * Return a METAMAGIC_* constant (or a value representing a group of constants)
int JXGetItemSpellMetaMagicFeat(int iSpellId, object oItem);

// Set the metamagic value (METAMAGIC_*) for the specified spell set as a "Cast Spell" property on an item.
// Many values can be set at the same time and a replacement mode determines what must be set.
// Ex: JXSetMetaMagicFeat(METAMAGIC_EMPOWER | METAMAGIC_EXTEND) sets both metamagic values.
// Three kinds of metamagic values exist (from the least to the most powerful):
//     * Strength : METAMAGIC_EMPOWER -> METAMAGIC_MAXIMIZE
//     * Duration : METAMAGIC_EXTEND -> METAMAGIC_PERSISTENT -> METAMAGIC_PERMANENT
//     * Invocation : METAMAGIC_INVOC_* (no order)
// Only one metamagic value of each kind is set at the same time.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// - iMetamagic Combination of METAMAGIC_* constants to set
// - iReplaceMode JX_METAMAGIC_REPLACE_YES to replace a value previously set or to set a new one
//                JX_METAMAGIC_REPLACE_NO to keep using a value previously set if it exists
//                JX_METAMAGIC_REPLACE_BEST to keep the best value between the old and the new one
void JXSetItemSpellMetaMagicFeat(int iSpellId, object oItem, int iMetamagic, int iReplaceMode = JX_METAMAGIC_REPLACE_BEST);

// Remove the metamagic value (METAMAGIC_*) for the specified spell set as a "Cast Spell" property on an item.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// - iMetamagic Combination of METAMAGIC_* constants to remove (default: everything)
void JXClearItemSpellMetaMagicFeat(int iSpellId, object oItem, int iMetamagic = METAMAGIC_ANY);

// Get the DC to save against for a spell (10 + spell level + relevant ability
// bonus) that is associated with a "Cast Spell" property on an item.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// * Return the DC for the spell
int JXGetItemSpellSpellSaveDC(int iSpellId, object oItem);

// Set a custom DC to save against for the spell associated with a 
// "Cast Spell" property on an item.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// - iDC Save DC to set for the spell
void JXSetItemSpellSpellSaveDC(int iSpellId, object oItem, int iDC);

// Get the level at which the item casts the specified spell associated
// with its "Cast Spell" property.
// If a custom caster level was set with JXSetCasterLevel(), this one is returned.
// - oCaster Caster of the spell
// - oItem Item that possesses a "Cast Spell" property
// * Return value on error, or if oCreature has not yet cast a spell: 0;
int JXGetItemSpellCasterLevel(int iSpellId, object oItem);

// Set a custom caster level for the specified spell associated
// with a "Cast Spell" property on an item.
// - iCasterLevel Caster level to use for the current spell
// - oItem Item that possesses a "Cast Spell" property
// - oCaster Caster of the spell
void JXSetItemSpellCasterLevel(int iSpellId, object oItem, int iCasterLevel);

//========================================== Item Property Operations ==========================================//

// Remove a permanent item property or a group of item properties from an item.
// The removed properties can be restored by using JXEnableItemProperty().
// If the item property doesn't exist on the item, nothing happens.
// N.B. : Due to NWN2 limitations, "Mind Blank", "On Monster Hit" and
//        "Damage Reduction" properties aren't affected.
// - oItem Item of which item properties must be removed
// - sStoreVariable Name of a variable used to store saved properties
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXDisableItemProperty(object oItem, string sStoreVariable, int iItemPropId = JX_ITEM_PROPERTY_ALL);

// Restore a permanent item property or a group of item properties from an item.
// The restored properties must have been removed by JXDisableItemProperty().
// If the item property hasn't been removed with JXDisableItemProperty(), nothing happens.
// N.B. : Due to NWN2 limitations, "Mind Blank", "On Monster Hit" and
//        "Damage Reduction" properties aren't affected.
// - oItem Item of which item properties must be restored
// - sStoreVariable Name of a variable used to restore saved properties
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXEnableItemProperty(object oItem, string sStoreVariable, int iItemPropId = JX_ITEM_PROPERTY_ALL);

// Remove a temporary item property or a group of item properties from an item.
// If the item property doesn't exist on the item, nothing happens.
// - oItem Item of which item properties must be removed
// - iDurationType DURATION_TYPE_* constant (DURATION_TYPE_INSTANT or 0 means any duration)
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXRemoveItemProperty(object oItem, int iDurationType = 0, int iItemPropId = JX_ITEM_PROPERTY_ALL);

// Get an effect that provides the same effects as the specified item property
// - oItem Item associated with an item property
// - ipProperty Item property to get the effect from
// * Returns an effect corresponding to the item property
// N.B. : Only 22 item properties have a corresponding effect.
//        Check with GetIsEffectValid() to know if an effect was created
effect JXGetEffectFromItemProperty(object oItem, itemproperty ipProperty);

//========================================== Item Informations ==========================================//

// Get the caster level associated with an item property
// - oItem The magical item that possesses the property
// - ipTest Item property to test
// * Returns the caster level of the item property
int JXGetItemPropertyCasterLevel(object oItem, itemproperty ipTest);

// Get the caster level of a magical item. By default, it gets the best caster level from
// its properties. But it can be overriden with the JX_ITEM_CASTER_LEVEL constant.
// - oItem The magical item from which the caster level is get
// - sAdditionalProperties Other properties available in a string form
// * Returns the caster level of the item
int JXGetItemCasterLevel(object oItem, string sAdditionalProperties = "");

// Set the caster level of a magical item.
// - oItem The magical item to set the caster level
// - iCasterLevel The caster level to set
// * Returns the caster level of the item
void JXSetItemCasterLevel(object oItem, int iCasterLevel);

// Get the spell school associated with an item property
// - oItem Object that possesses the item property
// - ipTest Item property to test
// * Returns a SPELL_SCHOOL_* constant
int JXGetItemPropertySpellSchool(object oItem, itemproperty ipTest);

// Get the spell school associated with a magical item
// - oItem The magical item from which the spell school is get
// - sAdditionalProperties Other properties available in a string form
// * Returns a SPELL_SCHOOL_* constant
int JXGetItemSpellSchool(object oItem, string sAdditionalProperties = "");

// Set the spell school associated with a magical item
// - oItem The magical item from which the spell school is get
// - iSpellSchool SPELL_SCHOOL_* constant
void JXSetItemSpellSchool(object oItem, int iSpellSchool);

// Indicate if an item property is a magical one.
// If it's a "Cast Spell" property, it's considered magical if the spell
// cast is a spell, spell-like, or supernatural ability.
// - oItem Item of which the property has to be tested
// - ipTest Item property to test
// * Returns TRUE if the item property is magical
int JXGetIsItemPropertyMagical(object oItem, itemproperty ipTest);

// Indicate if an item is a magical one.
// - oItem Item to test
// - sAdditionalProperties Other properties available in a string form
// * Returns TRUE if the item is magical
int JXGetIsItemMagical(object oItem, string sAdditionalProperties = "");

// Get hidden item properties
// - oItem Item to test
// * Returns the hidden item properties in a string form
string JXGetHiddenItemProperties(object oItem);

// Set hidden item properties
// - oItem Item to test
// - sHiddenProps Hidden item properties
// * Returns the hidden item properties in a string form
void JXSetHiddenItemProperties(object oItem, string sHiddenProps);

// Get the fortitude saving throw of an item.
// It equals to 2 + (item's caster level / 2) unless overriden.
// - oItem Concerned item
// - sAdditionalProperties Item properties available in a string form
// * Returns the item's fortitude saving throw
int JXGetItemFortitudeSave(object oItem, string sAdditionalProperties = "");

// Set the fortitude saving throw of an item
// - oItem Item affected
// - iFortitude The value of the saving throw
void JXSetItemFortitudeSave(object oItem, int iFortitude);

// Get the reflex saving throw of an item.
// It equals to 2 + (item's caster level / 2) unless overriden.
// - oItem Concerned item
// - sAdditionalProperties Item properties available in a string form
// * Returns the item's reflex saving throw
int JXGetItemReflexSave(object oItem, string sAdditionalProperties = "");

// Set the reflex saving throw of an item
// - oItem Item affected
// - iReflex The value of the saving throw
void JXSetItemReflexSave(object oItem, int iReflex);

// Get the will saving throw of an item.
// It equals to 2 + (item's caster level / 2) unless overriden.
// - oItem Concerned item
// - sAdditionalProperties Item properties available in a string form
// * Returns the item's will saving throw
int JXGetItemWillSave(object oItem, string sAdditionalProperties = "");

// Set the fortitude saving throw of an item
// - oItem Item affected
// - iFortitude The value of the saving throw
void JXSetItemWillSave(object oItem, int iWill);

// A magical item makes a saving throw check.
// - iSavingThrow SAVING_THROW_* constant
// - oItem Item that makes the saving throw
// - iDC Difficulty class of the check
// - iSaveType SAVING_THROW_TYPE_* constant
// - oSaveVersus Creature that gets the result message
// * Returns TRUE if the item succeeds the saving throw
int JXMyItemSavingThrow(int iSavingThrow,
						object oItem,
						int iDC,
						int iSaveType = SAVING_THROW_TYPE_NONE,
						object oSaveVersus = OBJECT_SELF);

// The magical item caster makes a caster level check against the specified DC.
// - oItem Magical item that makes the caster level check
// - iDC Difficulty Class of the check
// * Returns TRUE if the item succeeds the check
int JXItemCasterLevelCheck(object oItem, int iDC);




















//**************************************//
//                                      //
//            Implementation            //
//                                      //
//**************************************//


//========================================== Spell Alteration ==========================================//

// Get the metamagic value (METAMAGIC_*) for the specified spell set as a "Cast Spell" property on an item.
// The returned value may contain many metamagic values : use the AND operator (&) instead
// of the Equal (==) operator to compare the result of this function with a metamagic value.
// Ex: if (JXGetMetaMagicFeat() & METAMAGIC_EXTEND) ...
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// * Return a METAMAGIC_* constant (or a value representing a group of constants)
int JXGetItemSpellMetaMagicFeat(int iSpellId, object oItem)
{
	return GetLocalInt(oItem, JX_ITEM_SPELL_MM_PREFIX + IntToString(iSpellId));
}

// Set the metamagic value (METAMAGIC_*) for the specified spell set as a "Cast Spell" property on an item.
// Many values can be set at the same time and a replacement mode determines what must be set.
// Ex: JXSetMetaMagicFeat(METAMAGIC_EMPOWER | METAMAGIC_EXTEND) sets both metamagic values.
// Three kinds of metamagic values exist (from the least to the most powerful):
//     * Strength : METAMAGIC_EMPOWER -> METAMAGIC_MAXIMIZE
//     * Duration : METAMAGIC_EXTEND -> METAMAGIC_PERSISTENT -> METAMAGIC_PERMANENT
//     * Invocation : METAMAGIC_INVOC_* (no order)
// Only one metamagic value of each kind is set at the same time.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// - iMetamagic Combination of METAMAGIC_* constants to set
// - iReplaceMode JX_METAMAGIC_REPLACE_YES to replace a value previously set or to set a new one
//                JX_METAMAGIC_REPLACE_NO to keep using a value previously set if it exists
//                JX_METAMAGIC_REPLACE_BEST to keep the best value between the old and the new one
void JXSetItemSpellMetaMagicFeat(int iSpellId, object oItem, int iMetamagic, int iReplaceMode = JX_METAMAGIC_REPLACE_BEST)
{
	// Set the new metamagic feature(s)
	int iJXMetamagic = GetLocalInt(oItem, JX_ITEM_SPELL_MM_PREFIX + IntToString(iSpellId));

	// Empower has to be set
	if (iMetamagic & METAMAGIC_EMPOWER)
	{
		if (iJXMetamagic & METAMAGIC_MAXIMIZE)
		{
			// Empower replaces Maximize
			if (iReplaceMode == JX_METAMAGIC_REPLACE_YES)
			{
				iJXMetamagic = iJXMetamagic | METAMAGIC_EMPOWER;
				iJXMetamagic = iJXMetamagic ^ METAMAGIC_MAXIMIZE;
			}
		}
		else
			iJXMetamagic = iJXMetamagic | METAMAGIC_EMPOWER;
	}

	// Maximize has to be set
	if (iMetamagic & METAMAGIC_MAXIMIZE)
	{
		if (iJXMetamagic & METAMAGIC_EMPOWER)
		{
			// Maximize replaces Empower
			if ((iReplaceMode == JX_METAMAGIC_REPLACE_YES)
			 || (iReplaceMode == JX_METAMAGIC_REPLACE_BEST))
			{
				iJXMetamagic = iJXMetamagic | METAMAGIC_MAXIMIZE;
				iJXMetamagic = iJXMetamagic ^ METAMAGIC_EMPOWER;
			}
		}
		else
			iJXMetamagic = iJXMetamagic | METAMAGIC_MAXIMIZE;
	}

	// Extend has to be set
	if (iMetamagic & METAMAGIC_EXTEND)
	{
		if ((iJXMetamagic & METAMAGIC_PERSISTENT)
		 || (iJXMetamagic & METAMAGIC_PERMANENT))
		{
			// Extend replaces Persistent or Permanent
			if (iReplaceMode == JX_METAMAGIC_REPLACE_YES)
			{
				iJXMetamagic = iJXMetamagic | METAMAGIC_EXTEND;
				iJXMetamagic = iJXMetamagic ^ METAMAGIC_PERSISTENT ^ METAMAGIC_PERMANENT;
			}
		}
		else
			iJXMetamagic = iJXMetamagic | METAMAGIC_EXTEND;
	}

	// Persistent has to be set
	if (iMetamagic & METAMAGIC_PERSISTENT)
	{
		if (iJXMetamagic & METAMAGIC_EXTEND)
		{
			// Persistent replaces Extend
			if ((iReplaceMode == JX_METAMAGIC_REPLACE_YES)
			 || (iReplaceMode == JX_METAMAGIC_REPLACE_BEST))
			{
				iJXMetamagic = iJXMetamagic | METAMAGIC_PERSISTENT;
				iJXMetamagic = iJXMetamagic ^ METAMAGIC_EXTEND;
			}
		}
		else if (iJXMetamagic & METAMAGIC_PERMANENT)
		{
			// Persistent replaces Permanent
			if (iReplaceMode == JX_METAMAGIC_REPLACE_YES)
			{
				iJXMetamagic = iJXMetamagic | METAMAGIC_PERSISTENT;
				iJXMetamagic = iJXMetamagic ^ METAMAGIC_PERMANENT;
			}
		}
		else
			iJXMetamagic = iJXMetamagic | METAMAGIC_PERSISTENT;
	}

	// Permanent has to be set
	if (iMetamagic & METAMAGIC_PERMANENT)
	{
		if ((iJXMetamagic & METAMAGIC_EXTEND)
		 || (iJXMetamagic & METAMAGIC_PERSISTENT))
		{
			// Permanent replaces Extend or Persistent
			if ((iReplaceMode == JX_METAMAGIC_REPLACE_YES)
			 || (iReplaceMode == JX_METAMAGIC_REPLACE_BEST))
			{
				iJXMetamagic = iJXMetamagic | METAMAGIC_PERMANENT;
				iJXMetamagic = iJXMetamagic ^ METAMAGIC_EXTEND ^ METAMAGIC_PERSISTENT;
			}
		}
		else
			iJXMetamagic = iJXMetamagic | METAMAGIC_PERMANENT;
	}

	// Warlock invocations
	if (iMetamagic & METAMAGIC_INVOC_DRAINING_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_DRAINING_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_SPEAR)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_SPEAR;
	if (iMetamagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_FRIGHTFUL_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_HIDEOUS_BLOW)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_HIDEOUS_BLOW;
	if (iMetamagic & METAMAGIC_INVOC_BESHADOWED_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_BESHADOWED_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_BRIMSTONE_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_BRIMSTONE_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_CHAIN)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_CHAIN;
	if (iMetamagic & METAMAGIC_INVOC_HELLRIME_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_HELLRIME_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_BEWITCHING_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_BEWITCHING_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_CONE)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_CONE;
	if (iMetamagic & METAMAGIC_INVOC_NOXIOUS_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_NOXIOUS_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_VITRIOLIC_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_VITRIOLIC_BLAST;
	if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_DOOM)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_DOOM;
	if (iMetamagic & METAMAGIC_INVOC_UTTERDARK_BLAST)
		iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_UTTERDARK_BLAST;

	SetLocalInt(oItem, JX_ITEM_SPELL_MM_PREFIX + IntToString(iSpellId), iJXMetamagic);
}

// Remove the metamagic value (METAMAGIC_*) for the specified spell set as a "Cast Spell" property on an item.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// - iMetamagic Combination of METAMAGIC_* constants to remove (default: everything)
void JXClearItemSpellMetaMagicFeat(int iSpellId, object oItem, int iMetamagic = METAMAGIC_ANY)
{
	// Set the new metamagic feature
	int iJXMetamagic = GetLocalInt(oItem, JX_ITEM_SPELL_MM_PREFIX + IntToString(iSpellId));
	int iMetamagicDelete = iJXMetamagic & iMetamagic;
	int iJXMetamagicNew = iJXMetamagic ^ iMetamagicDelete;
	if (iJXMetamagic != iJXMetamagicNew)
		SetLocalInt(oItem, JX_ITEM_SPELL_MM_PREFIX + IntToString(iSpellId), iJXMetamagicNew);
}

// Get the DC to save against for a spell (10 + spell level + relevant ability
// bonus) that is associated with a "Cast Spell" property on an item.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// * Return the DC for the spell
int JXGetItemSpellSpellSaveDC(int iSpellId, object oItem)
{
	return GetLocalInt(oItem, JX_ITEM_SPELL_DC_PREFIX + IntToString(iSpellId));
}

// Set a custom DC to save against for the spell associated with a 
// "Cast Spell" property on an item.
// - iSpellId SPELL_* constant associated with the "Cast Spell" property
// - oItem Item that possesses a "Cast Spell" property
// - iDC Save DC to set for the spell
void JXSetItemSpellSpellSaveDC(int iSpellId, object oItem, int iDC)
{
	SetLocalInt(oItem, JX_ITEM_SPELL_DC_PREFIX + IntToString(iSpellId), iDC);
}

// Get the level at which the item casts the specified spell associated
// with its "Cast Spell" property.
// If a custom caster level was set with JXSetCasterLevel(), this one is returned.
// - oCaster Caster of the spell
// * Return value on error, or if oCreature has not yet cast a spell: 0;
int JXGetItemSpellCasterLevel(int iSpellId, object oItem)
{
	return GetLocalInt(oItem, JX_ITEM_SPELL_CL_PREFIX + IntToString(iSpellId));
}

// Set a custom caster level for the specified spell associated
// with a "Cast Spell" property on an item.
// - iCasterLevel Caster level to use for the current spell
// - oCaster Caster of the spell
void JXSetItemSpellCasterLevel(int iSpellId, object oItem, int iCasterLevel)
{
	SetLocalInt(oItem, JX_ITEM_SPELL_CL_PREFIX + IntToString(iSpellId), iCasterLevel);
}



//========================================== Item Property Operations ==========================================//

// Remove a permanent item property or a group of item properties from an item.
// The removed properties can be restored by using JXEnableItemProperty().
// If the item property doesn't exist on the item, nothing happens.
// N.B. : Due to NWN2 limitations, "Mind Blank", "On Monster Hit" and
//        "Damage Reduction" properties aren't affected.
// - oItem Item of which item properties must be removed
// - sStoreVariable Name of a variable used to store saved properties
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXDisableItemProperty(object oItem, string sStoreVariable, int iItemPropId = JX_ITEM_PROPERTY_ALL)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oItem);
	paramList = JXScriptAddParameterString(paramList, sStoreVariable);
	paramList = JXScriptAddParameterInt(paramList, iItemPropId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_DISABLEITEMPROP, paramList);
}

// Restore a permanent item property or a group of item properties from an item.
// The restored properties must have been removed by JXDisableItemProperty().
// If the item property hasn't been removed with JXDisableItemProperty(), nothing happens.
// N.B. : Due to NWN2 limitations, "Mind Blank", "On Monster Hit" and
//        "Damage Reduction" properties aren't affected.
// - oItem Item of which item properties must be restored
// - sStoreVariable Name of a variable used to restore saved properties
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXEnableItemProperty(object oItem, string sStoreVariable, int iItemPropId = JX_ITEM_PROPERTY_ALL)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oItem);
	paramList = JXScriptAddParameterString(paramList, sStoreVariable);
	paramList = JXScriptAddParameterInt(paramList, iItemPropId);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_ENABLEITEMPROP, paramList);
}

// Remove a temporary item property or a group of item properties from an item.
// If the item property doesn't exist on the item, nothing happens.
// - oItem Item of which item properties must be removed
// - iDurationType DURATION_TYPE_* constant (DURATION_TYPE_INSTANT or 0 means any duration)
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXRemoveItemProperty(object oItem, int iDurationType = 0, int iItemPropId = JX_ITEM_PROPERTY_ALL)
{
	// Item property type
	int iIPType;

	// Loop to remove the item properties
	itemproperty ipLoop = GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(ipLoop))
	{
		// Get the identifier of the current item property
		iIPType = GetItemPropertyType(ipLoop);

		// Duration type doesn't match
		if ((iDurationType == DURATION_TYPE_TEMPORARY) && (GetItemPropertyDurationType(ipLoop) == DURATION_TYPE_PERMANENT)
		 || (iDurationType == DURATION_TYPE_PERMANENT) && (GetItemPropertyDurationType(ipLoop) == DURATION_TYPE_TEMPORARY))
		{
			ipLoop = GetNextItemProperty(oItem);
			continue;
		}
		// Determine if the item property has to be removed
		if (iItemPropId != JX_ITEM_PROPERTY_ALL)
			if ((iItemPropId != JX_ITEM_PROPERTY_MAGIC)
			 || (iItemPropId == JX_ITEM_PROPERTY_MAGIC) && (!JXGetIsItemPropertyMagical(oItem, ipLoop)))
				if ((iItemPropId != JX_ITEM_PROPERTY_NOMAGIC)
				 || (iItemPropId == JX_ITEM_PROPERTY_NOMAGIC) && (JXGetIsItemPropertyMagical(oItem, ipLoop)))
				 	if (iItemPropId != iIPType)
					{
						ipLoop = GetNextItemProperty(oItem);
						continue;
					}

		// Definitely remove the item property
		RemoveItemProperty(oItem, ipLoop);

		// Remove Cast Spell custom powers
		if (iItemPropId == ITEM_PROPERTY_CAST_SPELL)
		{
			string sSpellId = Get2DAString("iprp_spells", "SpellIndex", GetItemPropertySubType(ipLoop));
			DeleteLocalInt(oItem, JX_ITEM_SPELL_MM_PREFIX + sSpellId);
			DeleteLocalInt(oItem, JX_ITEM_SPELL_CL_PREFIX + sSpellId);
			DeleteLocalInt(oItem, JX_ITEM_SPELL_DC_PREFIX + sSpellId);
		}

		ipLoop = GetNextItemProperty(oItem);
	}
}

// Get an effect that provides the same effects as the specified item property
// - oItem Item associated with an item property
// - ipProperty Item property to get the effect from
// * Returns an effect corresponding to the item property
// N.B. : Only 22 item properties have a corresponding effect.
//        Check with GetIsEffectValid() to know if an effect was created
effect JXGetEffectFromItemProperty(object oItem, itemproperty ipProperty)
{
	// Effect to return
	effect eResult;

	// Get other item property parameters
	int iIPSubType = GetItemPropertySubType(ipProperty);
	int iIPParam1Value = GetItemPropertyParam1Value(ipProperty);
	int iIPCostTableValue = GetItemPropertyCostTableValue(ipProperty);

	// Parameters for the effect to create
	int iParam1;
	int iParam2;
	int iParam3;

	// Ability Bonus
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ABILITY_BONUS)
	{
		switch (iIPSubType)
		{
			case IP_CONST_ABILITY_STR: iParam1 = ABILITY_STRENGTH;
			case IP_CONST_ABILITY_DEX: iParam1 = ABILITY_DEXTERITY;
			case IP_CONST_ABILITY_CON: iParam1 = ABILITY_CONSTITUTION;
			case IP_CONST_ABILITY_INT: iParam1 = ABILITY_INTELLIGENCE;
			case IP_CONST_ABILITY_WIS: iParam1 = ABILITY_WISDOM;
			case IP_CONST_ABILITY_CHA: iParam1 = ABILITY_CHARISMA;
		}
		iParam2 = iIPCostTableValue;
		eResult = EffectAbilityIncrease(iParam1, iParam2);
	}

	// Ability Decreased
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DECREASED_ABILITY_SCORE)
	{
		switch (iIPSubType)
		{
			case IP_CONST_ABILITY_STR: iParam1 = ABILITY_STRENGTH; break;
			case IP_CONST_ABILITY_DEX: iParam1 = ABILITY_DEXTERITY; break;
			case IP_CONST_ABILITY_CON: iParam1 = ABILITY_CONSTITUTION; break;
			case IP_CONST_ABILITY_INT: iParam1 = ABILITY_INTELLIGENCE; break;
			case IP_CONST_ABILITY_WIS: iParam1 = ABILITY_WISDOM; break;
			case IP_CONST_ABILITY_CHA: iParam1 = ABILITY_CHARISMA;
		}
		iParam2 = iIPCostTableValue;
		eResult = EffectAbilityDecrease(iParam1, iParam2);
	}

	// AC Bonus
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_AC_BONUS)
	{
		iParam1 = iIPCostTableValue;
		switch (GetBaseItemType(oItem))
		{
			case BASE_ITEM_BOOTS: iParam2 = AC_DODGE_BONUS; break;
			case BASE_ITEM_AMULET: iParam2 = AC_NATURAL_BONUS; break;
			case BASE_ITEM_ARMOR:
			case BASE_ITEM_BRACER: iParam2 = AC_ARMOUR_ENCHANTMENT_BONUS; break;
			case BASE_ITEM_SMALLSHIELD:
			case BASE_ITEM_LARGESHIELD:
			case BASE_ITEM_TOWERSHIELD: iParam2 = AC_SHIELD_ENCHANTMENT_BONUS; break;
			default: iParam2 = AC_DEFLECTION_BONUS;
		}
		eResult = EffectACIncrease(iParam1, iParam2);
	}

	// AC Decreased
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DECREASED_AC)
	{
		iParam1 = iIPCostTableValue;
		switch (iIPSubType)
		{
			case IP_CONST_ACMODIFIERTYPE_DODGE: iParam2 = AC_DODGE_BONUS; break;
			case IP_CONST_ACMODIFIERTYPE_NATURAL: iParam2 = AC_NATURAL_BONUS; break;
			case IP_CONST_ACMODIFIERTYPE_ARMOR: iParam2 = AC_ARMOUR_ENCHANTMENT_BONUS; break;
			case IP_CONST_ACMODIFIERTYPE_SHIELD: iParam2 = AC_SHIELD_ENCHANTMENT_BONUS; break;
			case IP_CONST_ACMODIFIERTYPE_DEFLECTION: iParam2 = AC_DEFLECTION_BONUS; break;
		}
		eResult = EffectACDecrease(iParam1, iParam2);
	}

	// Damage Immunity
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)
	{
		switch (iIPSubType)
		{
			case IP_CONST_DAMAGETYPE_BLUDGEONING: iParam1 = DAMAGE_TYPE_BLUDGEONING; break;
			case IP_CONST_DAMAGETYPE_PIERCING: iParam1 = DAMAGE_TYPE_PIERCING; break;
			case IP_CONST_DAMAGETYPE_SLASHING: iParam1 = DAMAGE_TYPE_SLASHING; break;
			//case IP_CONST_DAMAGETYPE_SUBDUAL: iParam1 = ?; break;
			//case IP_CONST_DAMAGETYPE_PHYSICAL: iParam1 = ?; break;
			case IP_CONST_DAMAGETYPE_MAGICAL: iParam1 = DAMAGE_TYPE_MAGICAL; break;
			case IP_CONST_DAMAGETYPE_ACID: iParam1 = DAMAGE_TYPE_ACID; break;
			case IP_CONST_DAMAGETYPE_COLD: iParam1 = DAMAGE_TYPE_COLD; break;
			case IP_CONST_DAMAGETYPE_DIVINE: iParam1 = DAMAGE_TYPE_DIVINE; break;
			case IP_CONST_DAMAGETYPE_ELECTRICAL: iParam1 = DAMAGE_TYPE_ELECTRICAL; break;
			case IP_CONST_DAMAGETYPE_FIRE: iParam1 = DAMAGE_TYPE_FIRE; break;
			case IP_CONST_DAMAGETYPE_NEGATIVE: iParam1 = DAMAGE_TYPE_NEGATIVE; break;
			case IP_CONST_DAMAGETYPE_POSITIVE: iParam1 = DAMAGE_TYPE_POSITIVE; break;
			case IP_CONST_DAMAGETYPE_SONIC: iParam1 = DAMAGE_TYPE_SONIC;
		}
		switch (iIPCostTableValue)
		{
			case IP_CONST_DAMAGEIMMUNITY_5_PERCENT: iParam2 = 5; break;
			case IP_CONST_DAMAGEIMMUNITY_10_PERCENT: iParam2 = 10; break;
			case IP_CONST_DAMAGEIMMUNITY_25_PERCENT: iParam2 = 25; break;
			case IP_CONST_DAMAGEIMMUNITY_50_PERCENT: iParam2 = 50; break;
			case IP_CONST_DAMAGEIMMUNITY_75_PERCENT: iParam2 = 75; break;
			case IP_CONST_DAMAGEIMMUNITY_90_PERCENT: iParam2 = 90; break;
			case IP_CONST_DAMAGEIMMUNITY_100_PERCENT: iParam2 = 100;
		}
		eResult = EffectDamageImmunityIncrease(iParam1, iParam2);
	}

	// Damage Resistance
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DAMAGE_RESISTANCE)
	{
		switch (iIPSubType)
		{
			case IP_CONST_DAMAGETYPE_BLUDGEONING: iParam1 = DAMAGE_TYPE_BLUDGEONING; break;
			case IP_CONST_DAMAGETYPE_PIERCING: iParam1 = DAMAGE_TYPE_PIERCING; break;
			case IP_CONST_DAMAGETYPE_SLASHING: iParam1 = DAMAGE_TYPE_SLASHING; break;
			//case IP_CONST_DAMAGETYPE_SUBDUAL: iParam1 = ?; break;
			//case IP_CONST_DAMAGETYPE_PHYSICAL: iParam1 = ?; break;
			case IP_CONST_DAMAGETYPE_MAGICAL: iParam1 = DAMAGE_TYPE_MAGICAL; break;
			case IP_CONST_DAMAGETYPE_ACID: iParam1 = DAMAGE_TYPE_ACID; break;
			case IP_CONST_DAMAGETYPE_COLD: iParam1 = DAMAGE_TYPE_COLD; break;
			case IP_CONST_DAMAGETYPE_DIVINE: iParam1 = DAMAGE_TYPE_DIVINE; break;
			case IP_CONST_DAMAGETYPE_ELECTRICAL: iParam1 = DAMAGE_TYPE_ELECTRICAL; break;
			case IP_CONST_DAMAGETYPE_FIRE: iParam1 = DAMAGE_TYPE_FIRE; break;
			case IP_CONST_DAMAGETYPE_NEGATIVE: iParam1 = DAMAGE_TYPE_NEGATIVE; break;
			case IP_CONST_DAMAGETYPE_POSITIVE: iParam1 = DAMAGE_TYPE_POSITIVE; break;
			case IP_CONST_DAMAGETYPE_SONIC: iParam1 = DAMAGE_TYPE_SONIC;
		}
		switch (iIPCostTableValue)
		{
			case IP_CONST_DAMAGERESIST_5: iParam2 = 5; break;
			case IP_CONST_DAMAGERESIST_10: iParam2 = 10; break;
			case IP_CONST_DAMAGERESIST_15: iParam2 = 15; break;
			case IP_CONST_DAMAGERESIST_20: iParam2 = 20; break;
			case IP_CONST_DAMAGERESIST_25: iParam2 = 25; break;
			case IP_CONST_DAMAGERESIST_30: iParam2 = 30; break;
			case IP_CONST_DAMAGERESIST_35: iParam2 = 35; break;
			case IP_CONST_DAMAGERESIST_40: iParam2 = 40; break;
			case IP_CONST_DAMAGERESIST_45: iParam2 = 45; break;
			case IP_CONST_DAMAGERESIST_50: iParam2 = 50;
		}
		eResult = EffectDamageResistance(iParam1, iParam2);
	}

	// Damage Vulnerability
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DAMAGE_VULNERABILITY)
	{
		switch (iIPSubType)
		{
			case IP_CONST_DAMAGETYPE_BLUDGEONING:	iParam1 = DAMAGE_TYPE_BLUDGEONING; break;
			case IP_CONST_DAMAGETYPE_PIERCING:		iParam1 = DAMAGE_TYPE_PIERCING; break;
			case IP_CONST_DAMAGETYPE_SLASHING:		iParam1 = DAMAGE_TYPE_SLASHING; break;
			//case IP_CONST_DAMAGETYPE_SUBDUAL:		iParam1 = ?; break;
			//case IP_CONST_DAMAGETYPE_PHYSICAL:	iParam1 = ?; break;
			case IP_CONST_DAMAGETYPE_MAGICAL:		iParam1 = DAMAGE_TYPE_MAGICAL; break;
			case IP_CONST_DAMAGETYPE_ACID:			iParam1 = DAMAGE_TYPE_ACID; break;
			case IP_CONST_DAMAGETYPE_COLD:			iParam1 = DAMAGE_TYPE_COLD; break;
			case IP_CONST_DAMAGETYPE_DIVINE:		iParam1 = DAMAGE_TYPE_DIVINE; break;
			case IP_CONST_DAMAGETYPE_ELECTRICAL:	iParam1 = DAMAGE_TYPE_ELECTRICAL; break;
			case IP_CONST_DAMAGETYPE_FIRE:			iParam1 = DAMAGE_TYPE_FIRE; break;
			case IP_CONST_DAMAGETYPE_NEGATIVE:		iParam1 = DAMAGE_TYPE_NEGATIVE; break;
			case IP_CONST_DAMAGETYPE_POSITIVE:		iParam1 = DAMAGE_TYPE_POSITIVE; break;
			case IP_CONST_DAMAGETYPE_SONIC:			iParam1 = DAMAGE_TYPE_SONIC;
		}
		switch (iIPCostTableValue)
		{
			case IP_CONST_DAMAGEVULNERABILITY_5_PERCENT:	iParam2 = 5; break;
			case IP_CONST_DAMAGEVULNERABILITY_10_PERCENT:	iParam2 = 10; break;
			case IP_CONST_DAMAGEVULNERABILITY_25_PERCENT:	iParam2 = 25; break;
			case IP_CONST_DAMAGEVULNERABILITY_50_PERCENT:	iParam2 = 50; break;
			case IP_CONST_DAMAGEVULNERABILITY_75_PERCENT:	iParam2 = 75; break;
			case IP_CONST_DAMAGEVULNERABILITY_90_PERCENT:	iParam2 = 90; break;
			case IP_CONST_DAMAGEVULNERABILITY_100_PERCENT:	iParam2 = 100;
		}
		eResult = EffectDamageImmunityDecrease(iParam1, iParam2);
	}

	// Saving Throws Bonus
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_SAVING_THROW_BONUS)
	{
		iParam1 = SAVING_THROW_ALL;
		iParam2 = iIPCostTableValue;
		switch (iIPSubType)
		{
			case IP_CONST_SAVEVS_UNIVERSAL:		iParam3 = SAVING_THROW_TYPE_ALL; break;
			case IP_CONST_SAVEVS_ACID:			iParam3 = SAVING_THROW_TYPE_ACID; break;
			case IP_CONST_SAVEVS_COLD:			iParam3 = SAVING_THROW_TYPE_COLD; break;
			case IP_CONST_SAVEVS_DEATH:			iParam3 = SAVING_THROW_TYPE_DEATH; break;
			case IP_CONST_SAVEVS_DISEASE:		iParam3 = SAVING_THROW_TYPE_DISEASE; break;
			case IP_CONST_SAVEVS_DIVINE:		iParam3 = SAVING_THROW_TYPE_DIVINE; break;
			case IP_CONST_SAVEVS_ELECTRICAL:	iParam3 = SAVING_THROW_TYPE_ELECTRICITY; break;
			case IP_CONST_SAVEVS_FEAR:			iParam3 = SAVING_THROW_TYPE_FEAR; break;
			case IP_CONST_SAVEVS_FIRE:			iParam3 = SAVING_THROW_TYPE_FIRE; break;
			case IP_CONST_SAVEVS_MINDAFFECTING:	iParam3 = SAVING_THROW_TYPE_MIND_SPELLS; break;
			case IP_CONST_SAVEVS_NEGATIVE:		iParam3 = SAVING_THROW_TYPE_NEGATIVE; break;
			case IP_CONST_SAVEVS_POISON:		iParam3 = SAVING_THROW_TYPE_POISON; break;
			case IP_CONST_SAVEVS_POSITIVE:		iParam3 = SAVING_THROW_TYPE_POSITIVE; break;
			case IP_CONST_SAVEVS_SONIC:			iParam3 = SAVING_THROW_TYPE_SONIC; break;
		}
		eResult = EffectSavingThrowIncrease(iParam1, iParam2, iParam3);
	}

	// Saving Throws Decreased
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DECREASED_SAVING_THROWS)
	{
		iParam1 = SAVING_THROW_ALL;
		iParam2 = iIPCostTableValue;
		switch (iIPSubType)
		{
			case IP_CONST_SAVEVS_UNIVERSAL:		iParam3 = SAVING_THROW_TYPE_ALL; break;
			case IP_CONST_SAVEVS_ACID:			iParam3 = SAVING_THROW_TYPE_ACID; break;
			case IP_CONST_SAVEVS_COLD:			iParam3 = SAVING_THROW_TYPE_COLD; break;
			case IP_CONST_SAVEVS_DEATH:			iParam3 = SAVING_THROW_TYPE_DEATH; break;
			case IP_CONST_SAVEVS_DISEASE:		iParam3 = SAVING_THROW_TYPE_DISEASE; break;
			case IP_CONST_SAVEVS_DIVINE:		iParam3 = SAVING_THROW_TYPE_DIVINE; break;
			case IP_CONST_SAVEVS_ELECTRICAL:	iParam3 = SAVING_THROW_TYPE_ELECTRICITY; break;
			case IP_CONST_SAVEVS_FEAR:			iParam3 = SAVING_THROW_TYPE_FEAR; break;
			case IP_CONST_SAVEVS_FIRE:			iParam3 = SAVING_THROW_TYPE_FIRE; break;
			case IP_CONST_SAVEVS_MINDAFFECTING:	iParam3 = SAVING_THROW_TYPE_MIND_SPELLS; break;
			case IP_CONST_SAVEVS_NEGATIVE:		iParam3 = SAVING_THROW_TYPE_NEGATIVE; break;
			case IP_CONST_SAVEVS_POISON:		iParam3 = SAVING_THROW_TYPE_POISON; break;
			case IP_CONST_SAVEVS_POSITIVE:		iParam3 = SAVING_THROW_TYPE_POSITIVE; break;
			case IP_CONST_SAVEVS_SONIC:			iParam3 = SAVING_THROW_TYPE_SONIC;
		}
		eResult = EffectSavingThrowDecrease(iParam1, iParam2, iParam3);
	}

	// Saving Throws Bonus Specific
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
	{
		switch (iIPSubType)
		{
			case IP_CONST_SAVEBASETYPE_FORTITUDE: iParam1 = SAVING_THROW_FORT; break;
			case IP_CONST_SAVEBASETYPE_WILL: iParam1 = SAVING_THROW_WILL; break;
			case IP_CONST_SAVEBASETYPE_REFLEX: iParam1 = SAVING_THROW_REFLEX;
		}
		iParam2 = iIPCostTableValue;
		eResult = EffectSavingThrowIncrease(iParam1, iParam2);
	}

	// Saving Throws Decreased Specific
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC)
	{
		switch (iIPSubType)
		{
			case IP_CONST_SAVEBASETYPE_FORTITUDE: iParam1 = SAVING_THROW_FORT; break;
			case IP_CONST_SAVEBASETYPE_WILL: iParam1 = SAVING_THROW_WILL; break;
			case IP_CONST_SAVEBASETYPE_REFLEX: iParam1 = SAVING_THROW_REFLEX;
		}
		iParam2 = iIPCostTableValue;
		eResult = EffectSavingThrowDecrease(iParam1, iParam2);
	}

	// Skill Bonus
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_SKILL_BONUS)
	{
		iParam1 = iIPSubType;
		iParam2 = iIPCostTableValue;
		eResult = EffectSkillIncrease(iParam1, iParam2);
	}

	// Skill Decreased
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
	{
		iParam1 = iIPSubType;
		iParam2 = iIPCostTableValue;
		eResult = EffectSkillDecrease(iParam1, iParam2);
	}

	// Darkvision
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_DARKVISION)
		eResult = EffectDarkVision();

	// Haste
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_HASTE)
		eResult = EffectHaste();

	// Regeneration
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_REGENERATION)
	{
		iParam1 = iIPCostTableValue;
		eResult = EffectRegenerate(iParam1, 6.0f);
	}

	// Bonus Hit Points
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_BONUS_HITPOINTS)
	{
		iParam1 = iIPCostTableValue;
		eResult = EffectBonusHitpoints(iParam1);
	}

	// Immunity Miscellaneous
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
	{
		switch (iIPSubType)
		{
			case IP_CONST_IMMUNITYMISC_BACKSTAB:			iParam1 = IMMUNITY_TYPE_SNEAK_ATTACK; break;
			case IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN:	iParam1 = IMMUNITY_TYPE_NEGATIVE_LEVEL; break;
			case IP_CONST_IMMUNITYMISC_MINDSPELLS:			iParam1 = IMMUNITY_TYPE_MIND_SPELLS; break;
			case IP_CONST_IMMUNITYMISC_POISON:				iParam1 = IMMUNITY_TYPE_POISON; break;
			case IP_CONST_IMMUNITYMISC_DISEASE:				iParam1 = IMMUNITY_TYPE_DISEASE; break;
			case IP_CONST_IMMUNITYMISC_FEAR:				iParam1 = IMMUNITY_TYPE_FEAR; break;
			case IP_CONST_IMMUNITYMISC_KNOCKDOWN:			iParam1 = IMMUNITY_TYPE_KNOCKDOWN; break;
			case IP_CONST_IMMUNITYMISC_PARALYSIS:			iParam1 = IMMUNITY_TYPE_PARALYSIS; break;
			case IP_CONST_IMMUNITYMISC_CRITICAL_HITS:		iParam1 = IMMUNITY_TYPE_CRITICAL_HIT; break;
			case IP_CONST_IMMUNITYMISC_DEATH_MAGIC:			iParam1 = IMMUNITY_TYPE_DEATH;
		}
		eResult = EffectImmunity(iParam1);
	}

	// Spell Resistance
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_SPELL_RESISTANCE)
	{
		switch (iIPCostTableValue)
		{
			case IP_CONST_SPELLRESISTANCEBONUS_10:	iParam1 = 10; break;
			case IP_CONST_SPELLRESISTANCEBONUS_12:	iParam1 = 12; break;
			case IP_CONST_SPELLRESISTANCEBONUS_14:	iParam1 = 14; break;
			case IP_CONST_SPELLRESISTANCEBONUS_16:	iParam1 = 16; break;
			case IP_CONST_SPELLRESISTANCEBONUS_18:	iParam1 = 18; break;
			case IP_CONST_SPELLRESISTANCEBONUS_20:	iParam1 = 20; break;
			case IP_CONST_SPELLRESISTANCEBONUS_22:	iParam1 = 22; break;
			case IP_CONST_SPELLRESISTANCEBONUS_24:	iParam1 = 24; break;
			case IP_CONST_SPELLRESISTANCEBONUS_26:	iParam1 = 26; break;
			case IP_CONST_SPELLRESISTANCEBONUS_28:	iParam1 = 28; break;
			case IP_CONST_SPELLRESISTANCEBONUS_30:	iParam1 = 30; break;
			case IP_CONST_SPELLRESISTANCEBONUS_32:	iParam1 = 32;
		}
		eResult = EffectSpellResistanceIncrease(iParam1);
	}

	// Immunity to Specific Spell
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
	{
		string sSpellIndex = Get2DAString("iprp_spellcost", "SpellIndex", iIPCostTableValue);
		int iParam1 = StringToInt(sSpellIndex);
		eResult = EffectSpellImmunity(iParam1);
	}

	// Immunity to Spell School
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
	{
		switch (iIPSubType)
		{
			case IP_CONST_SPELLSCHOOL_ABJURATION:		iParam1 = SPELL_SCHOOL_ABJURATION; break;
			case IP_CONST_SPELLSCHOOL_CONJURATION:		iParam1 = SPELL_SCHOOL_CONJURATION; break;
			case IP_CONST_SPELLSCHOOL_DIVINATION:		iParam1 = SPELL_SCHOOL_DIVINATION; break;
			case IP_CONST_SPELLSCHOOL_ENCHANTMENT:		iParam1 = SPELL_SCHOOL_ENCHANTMENT; break;
			case IP_CONST_SPELLSCHOOL_EVOCATION:		iParam1 = SPELL_SCHOOL_EVOCATION; break;
			case IP_CONST_SPELLSCHOOL_ILLUSION:			iParam1 = SPELL_SCHOOL_ILLUSION; break;
			case IP_CONST_SPELLSCHOOL_NECROMANCY:		iParam1 = SPELL_SCHOOL_NECROMANCY; break;
			case IP_CONST_SPELLSCHOOL_TRANSMUTATION:	iParam1 = SPELL_SCHOOL_TRANSMUTATION;
		}
		eResult = EffectSpellLevelAbsorption(-1, 0, iParam1);
	}

	// Immunity to Spell by Level
	if (GetItemPropertyType(ipProperty) == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)
	{
		iParam1 = iIPCostTableValue + 1;
		eResult = EffectSpellLevelAbsorption(iParam1);
	}

	return eResult;
}



//========================================== Item Informations ==========================================//

// Get the caster level associated with an item property
// - oItem The magical item that possesses the property
// - ipTest Item property to test
// * Returns the caster level of the item property
int JXGetItemPropertyCasterLevel(object oItem, itemproperty ipTest)
{
	// Get the identifier of the current item property
	int iIPType = GetItemPropertyType(ipTest);

	// Get other item property parameters
	int iIPSubType = GetItemPropertySubType(ipTest);
	int iIPCostTableValue = GetItemPropertyCostTableValue(ipTest);
	int iSpellId;
    int iSpellCL;

	string sItemProperty = IntToString(iIPType);

//------------------//
// Armor properties //
//------------------//

	// AC armor bonus (DMG p.217)
	if (iIPType == ITEM_PROPERTY_AC_BONUS) return iIPCostTableValue * 3;
	// AC armor bonus with focus
	if ((iIPType == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)		// Nacreous (+2, Stormwrack p.129)
	 || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
	 || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT))
	 	return iIPCostTableValue + 1;

	// Damage resistance
	if (iIPType == ITEM_PROPERTY_DAMAGE_RESISTANCE)
	{
		switch (iIPSubType)
		{
			// Elemental damage resistance (DMG p.217-218-219)
			case IP_CONST_DAMAGETYPE_ACID:			// Acid resistance (DMG p.217)
			case IP_CONST_DAMAGETYPE_COLD:			// Cold resistance (DMG p.218)
			case IP_CONST_DAMAGETYPE_ELECTRICAL:	// Electrical resistance (DMG p.218)
			case IP_CONST_DAMAGETYPE_FIRE:			// Fire resistance (DMG p.218)
			case IP_CONST_DAMAGETYPE_SONIC:			// Sonic resistance (DMG p.219)
				switch (iIPCostTableValue)
				{
					case IP_CONST_DAMAGERESIST_5: return 1;		// No D&D ref found
					case IP_CONST_DAMAGERESIST_10: return 3;	// Normal
					case IP_CONST_DAMAGERESIST_15: return 5;	// No D&D ref found
					case IP_CONST_DAMAGERESIST_20: return 7;	// Improved
					case IP_CONST_DAMAGERESIST_25: return 9;	// No D&D ref found
					case IP_CONST_DAMAGERESIST_30: return 11;	// Greater
					case IP_CONST_DAMAGERESIST_35: return 13;	// No D&D ref found
					case IP_CONST_DAMAGERESIST_40: return 15;	// No D&D ref found
					case IP_CONST_DAMAGERESIST_45: return 18;	// No D&D ref found
					case IP_CONST_DAMAGERESIST_50: return 21;	// Warding (ELH p.126-128)
				}
			case IP_CONST_DAMAGETYPE_PHYSICAL:                  // No D&D ref found
			case IP_CONST_DAMAGETYPE_BLUDGEONING: return 7;     // Hammerblock (MIC p.12)
			case IP_CONST_DAMAGETYPE_PIERCING: return 7;        // Spearblock (MIC p.14)
			case IP_CONST_DAMAGETYPE_SLASHING: return 7;        // Axeblock (MIC p.7)
			case IP_CONST_DAMAGETYPE_DIVINE:                    // No D&D ref found
			case IP_CONST_DAMAGETYPE_MAGICAL:
			case IP_CONST_DAMAGETYPE_NEGATIVE:
			case IP_CONST_DAMAGETYPE_POSITIVE:
			case IP_CONST_DAMAGETYPE_SUBDUAL: return 8;
		}
	}
    // Damage immunity (Elemental immunity, ELH p.135)
    if (iIPType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE) return 20;   // 

	// Spell Resistance (DMG p.219, D&D values are different : 13, 15, 17, 19, 21, 23, 25, 27)
	if (iIPType == ITEM_PROPERTY_SPELL_RESISTANCE)
	{
		switch (iIPCostTableValue)
		{
			case IP_CONST_SPELLRESISTANCEBONUS_10:				//    not D&D
			case IP_CONST_SPELLRESISTANCEBONUS_12:				// Spell Resistance (adapted DMG p.219)
			case IP_CONST_SPELLRESISTANCEBONUS_14:
			case IP_CONST_SPELLRESISTANCEBONUS_16:
			case IP_CONST_SPELLRESISTANCEBONUS_18: return 15;
			case IP_CONST_SPELLRESISTANCEBONUS_20: return 21;	// Great spell Resistance (adapated ELH p.127)
			case IP_CONST_SPELLRESISTANCEBONUS_22: return 22;	// Great spell Resistance (adapated ELH p.127)
			case IP_CONST_SPELLRESISTANCEBONUS_24: return 23;	// Great spell Resistance (adapated ELH p.127)
			case IP_CONST_SPELLRESISTANCEBONUS_26: return 24;	// Great spell Resistance (adapated ELH p.127)
			case IP_CONST_SPELLRESISTANCEBONUS_28: return 25;	//    not D&D
			case IP_CONST_SPELLRESISTANCEBONUS_30: return 26;	//    not D&D
			case IP_CONST_SPELLRESISTANCEBONUS_32: return 27;	//    not D&D
		}
	}

	// Miscellaneous immunities
	if (iIPType == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
	{
		switch (iIPSubType)
		{
			case IP_CONST_IMMUNITYMISC_BACKSTAB: return 13;         // Fortification, Heavy (DMG p.219)
			case IP_CONST_IMMUNITYMISC_CRITICAL_HITS: return 13;	// Fortification, Heavy (DMG p.219)
			case IP_CONST_IMMUNITYMISC_DEATH_MAGIC: return 7;		// Soulfire (BoED p.112)
			case IP_CONST_IMMUNITYMISC_DISEASE: return 5;           // Periapt of Health (DMG p.263)
			case IP_CONST_IMMUNITYMISC_FEAR: return 11;             // No D&D ref found
			case IP_CONST_IMMUNITYMISC_KNOCKDOWN: return 8;         // No D&D ref found
			case IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN: return 7;	// Soulfire (BoED p.112)
			case IP_CONST_IMMUNITYMISC_MINDSPELLS: return 13;       // No D&D ref found
			case IP_CONST_IMMUNITYMISC_PARALYSIS: return 13;        // No D&D ref found
			case IP_CONST_IMMUNITYMISC_POISON: return 5;            // Periapt of Proof against Poison (DMG p.263)
		}
	}
    // Mind blank
    if (iIPType == ITEM_PROPERTY_MIND_BLANK) return 13;             // No D&D ref found

	// Saving throws specific
	if (iIPType == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
	{
		switch (iIPSubType)
		{
			case IP_CONST_SAVEVS_ACID: return 7;                // No D&D ref found
			case IP_CONST_SAVEVS_COLD: return 6;                // No D&D ref found
			case IP_CONST_SAVEVS_DEATH: return 7;               // Phylactery of Virtue (+2, MIC p.215)
			case IP_CONST_SAVEVS_DISEASE: return 7;             // No D&D ref found
			case IP_CONST_SAVEVS_DIVINE: return 8;              // No D&D ref found
			case IP_CONST_SAVEVS_ELECTRICAL: return 6;          // No D&D ref found
			case IP_CONST_SAVEVS_FEAR: return 7;                // No D&D ref found
			case IP_CONST_SAVEVS_FIRE: return 6;                // No D&D ref found
			case IP_CONST_SAVEVS_MINDAFFECTING: return 9;		// Mask of mental armor (+3, MIC p.115)
			case IP_CONST_SAVEVS_NEGATIVE: return 7;            // Phylactery of Virtue (+2, MIC p.215)
			case IP_CONST_SAVEVS_POISON: return 7;              // Snakeblood Tooth (+5, MIC p.136)
			case IP_CONST_SAVEVS_POSITIVE: return 7;            // No D&D ref found
			case IP_CONST_SAVEVS_SONIC: return 7;               // adapted Rod of Silence (+4, CL9 with other abilites, MIC p.175)
			case IP_CONST_SAVEVS_UNIVERSAL:                     // Cloak of resistance (DMG p.253)
        		if (iIPCostTableValue == 1)
        			return 5;
        		else
        			return iIPCostTableValue * 3;
		}
	}
	// Saving throws (Agility & Stamania, MIC p.6,15)
	if (iIPType == ITEM_PROPERTY_SAVING_THROW_BONUS)
	{
		if (iIPCostTableValue == 1)
			return 5;
		else
			return iIPCostTableValue * 3;
	}

	// Weight reduction (Buoyant, Stormwrack p.128)
	if (iIPType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION) return 7;	// For weight -50%
	// Freedom of Movement (Freedom, MIC p.11)
	if (iIPType == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT) return 7;
    // Arcane spell failure (Twilight, MIC p.15)
	if (iIPType == ITEM_PROPERTY_ARCANE_SPELL_FAILURE) return 5;        // Should be -10%

//-------------------//
// Weapon properties //
//-------------------//

	// Enhancement bonus (DMG p.221)
	if (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS) return iIPCostTableValue * 3;
	// Enhancement bonus vs Racial group (Bane, DMG p.223)
	if (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP) return 8;		// Should be +2 (and associated with a 2D6 damage bonus)
	// Enhancement bonus with focus (not D&D)
	if ((iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT))
	 	 return iIPCostTableValue + 1;

	// Damage bonus
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS)
	{
		switch (iIPSubType)
		{
			case IP_CONST_DAMAGETYPE_ACID: return 10;		// Corrosive (damage 1d6, MIC p.31)
			case IP_CONST_DAMAGETYPE_COLD: return 8;		// Frost (damage 1D6, DMG p.224)
			case IP_CONST_DAMAGETYPE_ELECTRICAL: return 8;	// Shock (damage 1D6, DMG p.225)
			case IP_CONST_DAMAGETYPE_FIRE: return 10;		// Flaming (damage 1D6, DMG p.224)
			case IP_CONST_DAMAGETYPE_SONIC: return 7;		// Screaming (damage 1D4, MIC p.42)
			case IP_CONST_DAMAGETYPE_BLUDGEONING: return 6; // Collision (damage 5, MIC p.31)
			case IP_CONST_DAMAGETYPE_DIVINE: return 12;     // adapted Holy/Unholy Surge (MIC p.36,45)
			case IP_CONST_DAMAGETYPE_MAGICAL: return 12;    // No D&D ref found
			case IP_CONST_DAMAGETYPE_NEGATIVE: return 12;	// adapted Profane (CL7 but only strike living, MIC p.40)
			case IP_CONST_DAMAGETYPE_PHYSICAL: return 6;    // Collision (damage 5, MIC p.31)
			case IP_CONST_DAMAGETYPE_PIERCING: return 6;    // Collision (damage 5, MIC p.31)
			case IP_CONST_DAMAGETYPE_POSITIVE: return 12;	// adapted Sacred (CL7 but only strike undead, MIC p.42)
			case IP_CONST_DAMAGETYPE_SLASHING: return 6;    // Collision (damage 5, MIC p.31)
			case IP_CONST_DAMAGETYPE_SUBDUAL: return 5;		// Merciful (damage 1D6, DMG p.225)
		}
	}
	// Damage bonus vs Alignement (Anarchic, Axiomatic, Holy & Unholy, DMG p.223)
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP) return 7;	// Damage should be 2D6
	// Damage bonus vs Racial group (Bane, DMG p.223)
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP) return 8;	// Damage should be 2D6 (and associated with a +2 enhancement bonus)
	// Damage bonus vs Specific alignement (Anarchic & Axiomatic, adapted DMG p.223)
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT) return 5;	//     not D&D
	// Massive criticals (Maiming, MIC p.38)
	if (iIPType == ITEM_PROPERTY_MASSIVE_CRITICALS) return 5;               // Should deal 1D6/2D6/3D6

  	// On Hit properties
	if ((iIPType == ITEM_PROPERTY_ON_HIT_PROPERTIES)
     || (iIPType == ITEM_PROPERTY_ON_MONSTER_HIT))
	{
		switch (iIPSubType)
		{
			case IP_CONST_ONHIT_CONFUSION: return 16;           // No D&D ref found (attack the allies)
			case IP_CONST_ONHIT_DAZE: return 10;                // No D&D ref found (move slowly and can't attack)
			case IP_CONST_ONHIT_DEAFNESS: return 4;             // No D&D ref found (deaf)
			case IP_CONST_ONHIT_DISEASE: return 7;				// Diseased (UE p.54)
			case IP_CONST_ONHIT_DISPELMAGIC: return 10;			// adapted Dispelling (MIC p.33)
			case IP_CONST_ONHIT_DOOM: return 9;                 // Domineering (MIC p.33)
			case IP_CONST_ONHIT_FEAR: return 11;				// No D&D ref found (flee)
			case IP_CONST_ONHIT_GREATERDISPEL: return 15;		// Dispelling, Greater (MIC p.33)
			case IP_CONST_ONHIT_HOLD: return 14;                // adapted Paralyzing (CL10 for 1 use/day, MIC p.39)
			case IP_CONST_ONHIT_ITEMPOISON: return 9;           // Venomous (MIC p.45)
			case IP_CONST_ONHIT_KNOCK: return 11;               // adapted Knockback (MIC p.38)
			case IP_CONST_ONHIT_LESSERDISPEL: return 5;         // Dispelling (MIC p.33)
			case IP_CONST_ONHIT_LEVELDRAIN: return 11;          // Enervating (MIC p.34)
			case IP_CONST_ONHIT_MORDSDISJUNCTION: return 18;    // No D&D ref found (dispel magic)
			case IP_CONST_ONHIT_SILENCE: return 5;              // No D&D ref found (silence)
			case IP_CONST_ONHIT_SLAYALIGNMENT: return 16;       // No D&D ref found (instantly kill specific alignment)
			case IP_CONST_ONHIT_SLAYALIGNMENTGROUP: return 20;  // No D&D ref found (instantly kill alignment group)
			case IP_CONST_ONHIT_SLAYRACE: return 14;			// Disruption (DMG p.224)
			case IP_CONST_ONHIT_SLEEP: return 5;                // Sleep Arrow (DMG p.228)
			case IP_CONST_ONHIT_SLOW: return 5;                 // Slow Burst (MIC p.43)
			case IP_CONST_ONHIT_STUN: return 9;					// Stunning (MIC p.44)
			case IP_CONST_ONHIT_VORPAL: return 18;				// Vorpal (DMG p.226)
			case IP_CONST_ONHIT_WOUNDING: return 9;             // adapted Implacable (MIC p.37)
		}
	}

	// Skill bonus (Shadow, Silent Moves & Slick, DMG p.219)
	if (iIPType == ITEM_PROPERTY_SKILL_BONUS) return iIPCostTableValue;
	// Light (DMG p.221)
	if (iIPType == ITEM_PROPERTY_LIGHT) return 0;
	// Keen (DMG p.225) & Impact (MIC p.37)
	if (iIPType == ITEM_PROPERTY_KEEN) return 10;
	// Haste (Speed, adapted DMG p.225)
	if (iIPType == ITEM_PROPERTY_HASTE) return 14;           // Should be CL7 with the official Speed ability
	// Holy Avenger (DMG p.226)
	if (iIPType == ITEM_PROPERTY_HOLY_AVENGER) return 18;
	// Mighty (nonmagical, PHB p.119)
	if (iIPType == ITEM_PROPERTY_MIGHTY) return 0;
	// Spellblade (PGtF p.120)
	if (iIPType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL) return 13;
	// Vampiric (MIC p.45)
	if (iIPType == ITEM_PROPERTY_REGENERATION_VAMPIRIC) return 9;
    // Extra damage type (no D&D ref found)
    if ((iIPType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)
	 || (iIPType == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)) return 5;
    // Unlimited ammunition (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_UNLIMITED_AMMUNITION) return 5;

//-----------------//
// Ring properties //
//-----------------//

	// Regeneration (DMG p.232)
	if (iIPType == ITEM_PROPERTY_REGENERATION) return 15;		// Should be 1hp/hour
	// Evasion (DMG p.232)
	if (iIPType == ITEM_PROPERTY_IMPROVED_EVASION) return 7;
	// Wizardy (adapted DMG p.233)
	if (iIPType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N) return iIPCostTableValue;

//--------------------------//
// Wondrous Item properties //
//--------------------------//

	// Ability bonus (Amulet of Health, DMG p.246)
	if (iIPType == ITEM_PROPERTY_ABILITY_BONUS) return 8;		// Should be +2/+4/+6
	// Container reduced weight (Bag of Holding, DMG p.248)
	if (iIPType == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT) return 9;
    // Attack bonus (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_ATTACK_BONUS) return iIPCostTableValue * 2;
    if ((iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)
	 || (iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT))
        return iIPCostTableValue;
    // Darkvision (Goggles of Night, DMG p.258)
    if (iIPType == ITEM_PROPERTY_DARKVISION) return 3;
    // True Seeing (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_TRUE_SEEING) return 12;
    // Immunity to spell school (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL) return 22;
    // Immunity to spells per level (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL) return (iIPCostTableValue + 1) * 3;
    // Bonus hit Point (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_BONUS_HITPOINTS) return 6;
    // Turn resistance (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_TURN_RESISTANCE) return 5;
    // Weight increased (Stone of Weight, DMG.276)
	if (iIPType == ITEM_PROPERTY_WEIGHT_INCREASE) return 5;

//------------------//
// Other properties //
//------------------//

	// Cast spell (many official items)
	if (iIPType == ITEM_PROPERTY_CAST_SPELL)
	{
		iSpellId = StringToInt(Get2DAString("iprp_spells", "SpellIndex", iIPSubType));
        iSpellCL = JXGetItemSpellCasterLevel(iSpellId, oItem);
        if (iSpellCL > 0) return iSpellCL;
		return StringToInt(Get2DAString("iprp_spells", "CasterLvl", iIPSubType));
	}
	// On Hit Cast spell
	if (iIPType == ITEM_PROPERTY_ONHITCASTSPELL)
	{
		iSpellId = StringToInt(Get2DAString("iprp_onhitspell", "SpellIndex", iIPSubType));
        iSpellCL = JXGetItemSpellCasterLevel(iSpellId, oItem);
        if (iSpellCL > 0) return iSpellCL + 10;
		return StringToInt(Get2DAString("iprp_spells", "CasterLvl", iIPSubType)) + 10;
	}

	// Bonus feature
	if (iIPType == ITEM_PROPERTY_BONUS_FEAT)
	{
		switch (iIPSubType)
		{
            case 37: // Disarm (whip)
            case 38: return 0; // Weapon proficiency (creature)
            case IP_CONST_FEAT_ALERTNESS:
            case IP_CONST_FEAT_SPELLFOCUSABJ:
            case IP_CONST_FEAT_SPELLFOCUSCON:
            case IP_CONST_FEAT_SPELLFOCUSDIV:
            case IP_CONST_FEAT_SPELLFOCUSENC:
            case IP_CONST_FEAT_SPELLFOCUSEVO:
            case IP_CONST_FEAT_SPELLFOCUSILL:
            case IP_CONST_FEAT_SPELLFOCUSNEC:
            case IP_CONST_FEAT_SPELLPENETRATION: return 3;
            case IP_CONST_FEAT_CLEAVE:
            case IP_CONST_FEAT_DODGE:
            case IP_CONST_FEAT_POWERATTACK:
            case IP_CONST_FEAT_WEAPSPEUNARM:
            case IP_CONST_FEAT_IMPCRITUNARM:
            case IP_CONST_FEAT_DEFLECT_ARROWS:                  // Arrow Deflection (DMG p.218)
            case 28: return 5; // Disarm
            case IP_CONST_FEAT_WEAPFINESSE: return 6;
            case IP_CONST_FEAT_AMBIDEXTROUS:
            case IP_CONST_FEAT_COMBAT_CASTING:
            case IP_CONST_FEAT_KNOCKDOWN:
            case IP_CONST_FEAT_POINTBLANK:
            case IP_CONST_FEAT_TWO_WEAPON_FIGHTING: return 7;
            case 33: return 10; // Sneak Attack 2
            case 34: return 11; // Sneak Attack 3
            case 39: return 12; // Sneak Attack 4
            default: return 9; // All other features have cost = 5
		}
	}

	// Powerless properties
	if ((iIPType == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_USE_LIMITATION_CLASS)
	 || (iIPType == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE)
	 || (iIPType == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT)
	 || (iIPType == ITEM_PROPERTY_SPECIAL_WALK)
	 || (iIPType == ITEM_PROPERTY_VISUALEFFECT)
	 || (iIPType == ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER)
	 || (iIPType == ITEM_PROPERTY_DECREASED_DAMAGE)
	 || (iIPType == ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER)
	 || (iIPType == ITEM_PROPERTY_DAMAGE_VULNERABILITY)
	 || (iIPType == ITEM_PROPERTY_DECREASED_ABILITY_SCORE)
	 || (iIPType == ITEM_PROPERTY_DECREASED_AC)
	 || (iIPType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
	 || (iIPType == ITEM_PROPERTY_DECREASED_SAVING_THROWS)
	 || (iIPType == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC)
     || (iIPType == ITEM_PROPERTY_NO_DAMAGE))
	 	return 0;
	// Nonmagical properties
	if ((iIPType == ITEM_PROPERTY_HEALERS_KIT)
	 || (iIPType == ITEM_PROPERTY_THIEVES_TOOLS)
	 || (iIPType == ITEM_PROPERTY_MONSTER_DAMAGE)
	 || (iIPType == ITEM_PROPERTY_TRAP))
	 	return 0;

	return 0;
}

// Get the caster level of a magical item. By default, it gets the best caster level from
// its properties. But it can be overriden with the JX_ITEM_CASTER_LEVEL constant.
// - oItem The magical item from which the caster level is get
// - sAdditionalProperties Other properties available in a string form
// * Returns the caster level of the item
int JXGetItemCasterLevel(object oItem, string sAdditionalProperties = "")
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oItem);
	paramList = JXScriptAddParameterString(paramList, sAdditionalProperties);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_ITEMCASTERLEVEL, paramList);

	return JXScriptGetResponseInt();
}

// Set the caster level of a magical item.
// - oItem The magical item to set the caster level
// - iCasterLevel The caster level to set
// * Returns the caster level of the item
void JXSetItemCasterLevel(object oItem, int iCasterLevel)
{
	SetLocalInt(oItem, JX_ITEM_CASTER_LEVEL, iCasterLevel);
}

// Get the spell school associated with an item property
// - oItem Object that possesses the item property
// - ipTest Item property to test
// * Returns a SPELL_SCHOOL_* constant
int JXGetItemPropertySpellSchool(object oItem, itemproperty ipTest)
{
	// Get the identifier of the current item property
	int iIPType = GetItemPropertyType(ipTest);

	// Get other item property parameters
	int iIPSubType = GetItemPropertySubType(ipTest);
	int iIPCostTableValue = GetItemPropertyCostTableValue(ipTest);
    int iIPParam1Value = GetItemPropertyParam1Value(ipTest);
	int iSpellId;

	string sItemProperty = IntToString(iIPType);

//------------------//
// Armor properties //
//------------------//

	// AC armor bonus (DMG p.213)
	if ((iIPType == ITEM_PROPERTY_AC_BONUS)
	 || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)
	 || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
	 || (iIPType == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT))
	 	return SPELL_SCHOOL_ABJURATION;

	// Damage resistance (Elemental, DMG p.217-219 - Block, MIC p.7,12,14)
	if (iIPType == ITEM_PROPERTY_DAMAGE_RESISTANCE) return SPELL_SCHOOL_ABJURATION;
    // Damage immunity (Elemental immunity, ELH p.135)
    if (iIPType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE) return SPELL_SCHOOL_ABJURATION;

	// Spell Resistance (DMG p.219)
	if (iIPType == ITEM_PROPERTY_SPELL_RESISTANCE) return SPELL_SCHOOL_ABJURATION;;

	// Miscellaneous immunities
	if (iIPType == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
	{
		switch (iIPSubType)
		{
			case IP_CONST_IMMUNITYMISC_BACKSTAB:                                    // Fortification, Heavy (DMG p.219)
			case IP_CONST_IMMUNITYMISC_CRITICAL_HITS:	                            // Fortification, Heavy (DMG p.219)
			case IP_CONST_IMMUNITYMISC_DEATH_MAGIC:		                            // Soulfire (BoED p.112)
			case IP_CONST_IMMUNITYMISC_FEAR:                                        // No D&D ref found
			case IP_CONST_IMMUNITYMISC_KNOCKDOWN:                                   // No D&D ref found
			case IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN:	                        // Soulfire (BoED p.112)
			case IP_CONST_IMMUNITYMISC_MINDSPELLS:                                  // No D&D ref found
			case IP_CONST_IMMUNITYMISC_PARALYSIS: return SPELL_SCHOOL_ABJURATION;   // No D&D ref found
			case IP_CONST_IMMUNITYMISC_DISEASE:                                     // Periapt of Health (DMG p.263)
			case IP_CONST_IMMUNITYMISC_POISON: return SPELL_SCHOOL_CONJURATION;     // Periapt of Proof against Poison (DMG p.263)
		}
	}
    // Mind blank
    if (iIPType == ITEM_PROPERTY_MIND_BLANK) return SPELL_SCHOOL_ABJURATION;        // No D&D ref found

	// Saving throws specific
	if (iIPType == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
	{
		switch (iIPSubType)
		{
			case IP_CONST_SAVEVS_DEATH:                                         // Phylactery of Virtue (+2, MIC p.215)
			case IP_CONST_SAVEVS_NEGATIVE: return SPELL_SCHOOL_NECROMANCY;      // Phylactery of Virtue (+2, MIC p.215)
			case IP_CONST_SAVEVS_ACID:                                          // No D&D ref found
			case IP_CONST_SAVEVS_COLD:                                          // No D&D ref found
			case IP_CONST_SAVEVS_DIVINE:                                        // No D&D ref found
			case IP_CONST_SAVEVS_ELECTRICAL:                                    // No D&D ref found
			case IP_CONST_SAVEVS_FIRE:                                          // No D&D ref found
			case IP_CONST_SAVEVS_SONIC: return SPELL_SCHOOL_TRANSMUTATION;      // adapted Rod of Silence (MIC p.175)
			case IP_CONST_SAVEVS_DISEASE:                                       // No D&D ref found
			case IP_CONST_SAVEVS_POISON:                                        // Snakeblood Tooth (MIC p.136)
			case IP_CONST_SAVEVS_POSITIVE: return SPELL_SCHOOL_CONJURATION;     // No D&D ref found
			case IP_CONST_SAVEVS_FEAR:                                          // No D&D ref found
			case IP_CONST_SAVEVS_MINDAFFECTING:                         		// Mask of mental armor (MIC p.115)
			case IP_CONST_SAVEVS_UNIVERSAL: return SPELL_SCHOOL_ABJURATION;     // Cloak of resistance (DMG p.253)
		}
	}
	// Saving throws (Agility & Stamania, MIC p.6,15)
	if (iIPType == ITEM_PROPERTY_SAVING_THROW_BONUS) return SPELL_SCHOOL_TRANSMUTATION;

	// Weight reduction (Buoyant, Stormwrack p.128)
	if (iIPType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION) return SPELL_SCHOOL_TRANSMUTATION;
	// Freedom of Movement (Freedom, MIC p.11)
	if (iIPType == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT) return SPELL_SCHOOL_ABJURATION;
    // Arcane spell failure (Twilight, MIC p.15)
	if (iIPType == ITEM_PROPERTY_ARCANE_SPELL_FAILURE) return SPELL_SCHOOL_TRANSMUTATION;

//-------------------//
// Weapon properties //
//-------------------//

	// Enhancement bonus (DMG p.213)
	if (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS) return SPELL_SCHOOL_EVOCATION;
	// Enhancement bonus vs Racial group (Bane, DMG p.223)
	if (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP) return SPELL_SCHOOL_CONJURATION;
	// Enhancement bonus with focus (No D&D ref found)
	if ((iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT))
	 	 return SPELL_SCHOOL_EVOCATION;

	// Damage bonus
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS)
	{
		switch (iIPSubType)
		{
			case IP_CONST_DAMAGETYPE_ACID: 		                                    // Corrosive (MIC p.31)
			case IP_CONST_DAMAGETYPE_POSITIVE:                                      // adapted Sacred (MIC p.42)
			case IP_CONST_DAMAGETYPE_SUBDUAL: return SPELL_SCHOOL_CONJURATION;		// Merciful (DMG p.225)
			case IP_CONST_DAMAGETYPE_COLD: 		                                    // Frost (DMG p.224)
			case IP_CONST_DAMAGETYPE_ELECTRICAL:	                                // Shock (DMG p.225)
			case IP_CONST_DAMAGETYPE_FIRE:		                                    // Flaming (DMG p.224)
			case IP_CONST_DAMAGETYPE_SONIC: 		                                // Screaming (MIC p.42)
			case IP_CONST_DAMAGETYPE_DIVINE:                                        // adapted Holy/Unholy Surge (MIC p.36,45)
			case IP_CONST_DAMAGETYPE_MAGICAL: return SPELL_SCHOOL_EVOCATION;        // No D&D ref found
			case IP_CONST_DAMAGETYPE_NEGATIVE: return SPELL_SCHOOL_NECROMANCY;      // adapted Profane (MIC p.40)
			case IP_CONST_DAMAGETYPE_BLUDGEONING:                                   // Collision (MIC p.31)
			case IP_CONST_DAMAGETYPE_PHYSICAL:                                      // Collision (MIC p.31)
			case IP_CONST_DAMAGETYPE_PIERCING:                                      // Collision (MIC p.31)
			case IP_CONST_DAMAGETYPE_SLASHING: return SPELL_SCHOOL_TRANSMUTATION;   // Collision (MIC p.31)
		}
	}
	// Damage bonus vs Alignement (Anarchic, Axiomatic, Holy & Unholy, DMG p.223)
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP) return SPELL_SCHOOL_EVOCATION;
	// Damage bonus vs Racial group (Bane, DMG p.223)
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP) return SPELL_SCHOOL_CONJURATION;
	// Damage bonus vs Specific alignement (Anarchic & Axiomatic, adapted DMG p.223)
	if (iIPType == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT) return SPELL_SCHOOL_EVOCATION;
	// Massive criticals (Maiming, MIC p.38)
	if (iIPType == ITEM_PROPERTY_MASSIVE_CRITICALS) return SPELL_SCHOOL_TRANSMUTATION;

  	// On Hit properties
	if ((iIPType == ITEM_PROPERTY_ON_HIT_PROPERTIES)
     || (iIPType == ITEM_PROPERTY_ON_MONSTER_HIT))
	{
		switch (iIPSubType)
		{
			case IP_CONST_ONHIT_CONFUSION:                                          // No D&D ref found (attack the allies)
			case IP_CONST_ONHIT_DAZE:                                               // No D&D ref found (move slowly and can't attack)
			case IP_CONST_ONHIT_HOLD:                                               // adapted Paralyzing (MIC p.39)
			case IP_CONST_ONHIT_SLEEP:                                              // Sleep Arrow (DMG p.228)
			case IP_CONST_ONHIT_STUN: return SPELL_SCHOOL_ENCHANTMENT;				// Stunning (MIC p.44)
			case IP_CONST_ONHIT_DEAFNESS:                                           // No D&D ref found (deaf)
			case IP_CONST_ONHIT_DISEASE: 				                            // Diseased (UE p.54)
			case IP_CONST_ONHIT_DOOM:                                               // Domineering (MIC p.33)
			case IP_CONST_ONHIT_FEAR:				                                // No D&D ref found (flee)
			case IP_CONST_ONHIT_ITEMPOISON:                                         // Venomous (MIC p.45)
			case IP_CONST_ONHIT_LEVELDRAIN:                                         // Enervating (MIC p.34)
			case IP_CONST_ONHIT_SLAYALIGNMENT:                                      // No D&D ref found (instantly kill specific alignment)
			case IP_CONST_ONHIT_SLAYALIGNMENTGROUP:                                 // No D&D ref found (instantly kill alignment group)
			case IP_CONST_ONHIT_WOUNDING: return SPELL_SCHOOL_NECROMANCY;           // adapted Implacable (MIC p.37)
			case IP_CONST_ONHIT_DISPELMAGIC:			                            // adapted Dispelling (MIC p.33)
			case IP_CONST_ONHIT_GREATERDISPEL: 		                                // Dispelling, Greater (MIC p.33)
			case IP_CONST_ONHIT_LESSERDISPEL:                                       // Dispelling (MIC p.33)
			case IP_CONST_ONHIT_MORDSDISJUNCTION: return SPELL_SCHOOL_ABJURATION;   // No D&D ref found (dispel magic)
			case IP_CONST_ONHIT_KNOCK: return SPELL_SCHOOL_EVOCATION;               // adapted Knockback (MIC p.38)
			case IP_CONST_ONHIT_SILENCE: return SPELL_SCHOOL_ILLUSION;              // No D&D ref found (silence)
			case IP_CONST_ONHIT_SLOW:                                               // Slow Burst (MIC p.43)
			case IP_CONST_ONHIT_VORPAL: return SPELL_SCHOOL_TRANSMUTATION;			// Vorpal (DMG p.226)
			case IP_CONST_ONHIT_SLAYRACE:
                if (iIPParam1Value == IP_CONST_RACIALTYPE_UNDEAD)
                    return SPELL_SCHOOL_CONJURATION;                                // Disruption (DMG p.224)
                else
                    return SPELL_SCHOOL_NECROMANCY;                                 // Slaying Arrow (DMG p.228)
		}
	}

	// Skill bonus (Shadow, Silent Moves & Slick, DMG p.219)
	if (iIPType == ITEM_PROPERTY_SKILL_BONUS) return SPELL_SCHOOL_CONJURATION;
	// Light (DMG p.221)
	if (iIPType == ITEM_PROPERTY_LIGHT) return SPELL_SCHOOL_EVOCATION;
	// Keen (DMG p.225) & Impact (MIC p.37)
	if (iIPType == ITEM_PROPERTY_KEEN) return SPELL_SCHOOL_TRANSMUTATION;
	// Haste (Speed, adapted DMG p.225)
	if (iIPType == ITEM_PROPERTY_HASTE) return SPELL_SCHOOL_TRANSMUTATION;
	// Holy Avenger (DMG p.226)
	if (iIPType == ITEM_PROPERTY_HOLY_AVENGER) return SPELL_SCHOOL_ABJURATION;
	// Mighty (nonmagical, PHB p.119)
	if (iIPType == ITEM_PROPERTY_MIGHTY) return SPELL_SCHOOL_CONJURATION;
	// Spellblade (PGtF p.120)
	if (iIPType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL) return SPELL_SCHOOL_ABJURATION;
	// Vampiric (MIC p.45)
	if (iIPType == ITEM_PROPERTY_REGENERATION_VAMPIRIC) return SPELL_SCHOOL_NECROMANCY;
    // Extra damage type (no D&D ref found)
    if ((iIPType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)
	 || (iIPType == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)) return SPELL_SCHOOL_EVOCATION;
    // Unlimited ammunition (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_UNLIMITED_AMMUNITION) return SPELL_SCHOOL_TRANSMUTATION;

//-----------------//
// Ring properties //
//-----------------//

	// Regeneration (DMG p.232)
	if (iIPType == ITEM_PROPERTY_REGENERATION) return SPELL_SCHOOL_CONJURATION;
	// Evasion (DMG p.232)
	if (iIPType == ITEM_PROPERTY_IMPROVED_EVASION) return SPELL_SCHOOL_TRANSMUTATION;
	// Wizardy (adapted DMG p.233)
	if (iIPType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N) return SPELL_SCHOOL_GENERAL;

//--------------------------//
// Wondrous Item properties //
//--------------------------//

	// Ability bonus (Amulet of Health, DMG p.246)
	if (iIPType == ITEM_PROPERTY_ABILITY_BONUS) return SPELL_SCHOOL_TRANSMUTATION;
	// Container reduced weight (Bag of Holding, DMG p.248)
	if (iIPType == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT) return SPELL_SCHOOL_CONJURATION;
    // Attack bonus (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_ATTACK_BONUS) return SPELL_SCHOOL_EVOCATION;
    if ((iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)
	 || (iIPType == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT))
        return SPELL_SCHOOL_EVOCATION;
    // Darkvision (Goggles of Night, DMG p.258)
    if (iIPType == ITEM_PROPERTY_DARKVISION) return SPELL_SCHOOL_TRANSMUTATION;
    // True Seeing (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_TRUE_SEEING) return SPELL_SCHOOL_DIVINATION;
    // Immunity to spell school (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL) return SPELL_SCHOOL_ABJURATION;
    // Immunity to spells per level (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL) return SPELL_SCHOOL_ABJURATION;
    // Bonus hit Point (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_BONUS_HITPOINTS) return SPELL_SCHOOL_TRANSMUTATION;
    // Turn resistance (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_TURN_RESISTANCE) return SPELL_SCHOOL_NECROMANCY;

//------------------//
// Other properties //
//------------------//

	// Cast spell (many official items)
	if (iIPType == ITEM_PROPERTY_CAST_SPELL)
	{
		iSpellId = StringToInt(Get2DAString("iprp_spells", "SpellIndex", iIPSubType));
		return JXGetSpellSchool(iSpellId);
	}
	// On Hit Cast spell
	if (iIPType == ITEM_PROPERTY_ONHITCASTSPELL)
	{
		iSpellId = StringToInt(Get2DAString("iprp_onhitspell", "SpellIndex", iIPSubType));
		return JXGetSpellSchool(iSpellId);
	}

	// Bonus feature
	if (iIPType == ITEM_PROPERTY_BONUS_FEAT) return SPELL_SCHOOL_TRANSMUTATION;

	// Use limitation (No D&D ref found)
	if ((iIPType == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)
	 || (iIPType == ITEM_PROPERTY_USE_LIMITATION_CLASS)
	 || (iIPType == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE)
	 || (iIPType == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT)) return SPELL_SCHOOL_GENERAL;
    // Decreased skill modifier (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER) return SPELL_SCHOOL_CONJURATION;
    // No damage (No D&D ref found)
    if (iIPType == ITEM_PROPERTY_NO_DAMAGE) return SPELL_SCHOOL_EVOCATION;
    // Damage vulnerability (No D&D ref found)
	if (iIPType == ITEM_PROPERTY_DAMAGE_VULNERABILITY) return SPELL_SCHOOL_ABJURATION;
    // Decreased enhancement, attack bonus & damage (-2 Cursed Sword, DMG p.276)
    if ((iIPType == ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER)
	 || (iIPType == ITEM_PROPERTY_DECREASED_DAMAGE)
	 || (iIPType == ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER)) return SPELL_SCHOOL_EVOCATION;
    // Decreased ability score (Robe of Powerlessness, DMG p.276)
	if (iIPType == ITEM_PROPERTY_DECREASED_ABILITY_SCORE) return SPELL_SCHOOL_TRANSMUTATION;
    // Decreased AC (Bracers of Defenselessness, DMG p.274)
	if (iIPType == ITEM_PROPERTY_DECREASED_AC) return SPELL_SCHOOL_CONJURATION;
    // Decreased saving throws (Amulet of Inescapable, DMG p.274)
	if ((iIPType == ITEM_PROPERTY_DECREASED_SAVING_THROWS)
	 || (iIPType == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC)) return SPELL_SCHOOL_ABJURATION;
    // Weight increased (Stone of Weight, DMG.276)
	if (iIPType == ITEM_PROPERTY_WEIGHT_INCREASE) return SPELL_SCHOOL_TRANSMUTATION;

    // Nonmagical properties
	if ((iIPType == ITEM_PROPERTY_HEALERS_KIT)
	 || (iIPType == ITEM_PROPERTY_THIEVES_TOOLS)
	 || (iIPType == ITEM_PROPERTY_MONSTER_DAMAGE)
	 || (iIPType == ITEM_PROPERTY_TRAP)
	 || (iIPType == ITEM_PROPERTY_SPECIAL_WALK)
	 || (iIPType == ITEM_PROPERTY_VISUALEFFECT))
	 	return SPELL_SCHOOL_GENERAL;

	return 0;
}

// Get the spell school associated with a magical item
// - oItem The magical item from which the spell school is get
// - sAdditionalProperties Other properties available in a string form
// * Returns a SPELL_SCHOOL_* constant
int JXGetItemSpellSchool(object oItem, string sAdditionalProperties = "")
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oItem);
	paramList = JXScriptAddParameterString(paramList, sAdditionalProperties);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_ITEMSPELLSCHOOL, paramList);

	return JXScriptGetResponseInt();
}

// Set the spell school associated with a magical item
// - oItem The magical item from which the spell school is get
// - iSpellSchool SPELL_SCHOOL_* constant
void JXSetItemSpellSchool(object oItem, int iSpellSchool)
{
	SetLocalInt(oItem, JX_ITEM_SPELL_SCHOOL, iSpellSchool);
}

// Indicate if an item property is a magical one.
// If it's a "Cast Spell" property, it's considered magical if the spell
// cast is a spell, spell-like, or supernatural ability
// - oItem Item of which the property has to be tested
// - ipTest Item property to test
// * Returns TRUE if the item property is magical
int JXGetIsItemPropertyMagical(object oItem, itemproperty ipTest)
{
	int iItemPropId = GetItemPropertyType(ipTest);
	int iIPSubType;
	int iSpellId;

	// Armor & shield's arcane spell failure property
	if (iItemPropId == ITEM_PROPERTY_ARCANE_SPELL_FAILURE)
		return FALSE;
	// Masterwork weapons (+1 attack bonus)
	if ((iItemPropId == ITEM_PROPERTY_ATTACK_BONUS) && GetItemPropertyCostTableValue(ipTest) == 1)
		return FALSE;
	// Disarm is non magical whip's property
	if ((iItemPropId == ITEM_PROPERTY_BONUS_FEAT) && GetBaseItemType(oItem) == BASE_ITEM_WHIP && GetItemPropertySubType(ipTest) == FEAT_DISARM)
		return FALSE;
	// Healer's kit property
	if (iItemPropId == ITEM_PROPERTY_HEALERS_KIT)
		return FALSE;
	// Mighty is a non-magical bow property
	if (iItemPropId == ITEM_PROPERTY_MIGHTY)
		return FALSE;
	// Monster properties
	if ((iItemPropId == ITEM_PROPERTY_MONSTER_DAMAGE) || (iItemPropId == ITEM_PROPERTY_ON_MONSTER_HIT))
		return FALSE;
	// Zombie special walk property
	if (iItemPropId == ITEM_PROPERTY_SPECIAL_WALK)
		return FALSE;
	// Thieve's tools property
	if (iItemPropId == ITEM_PROPERTY_THIEVES_TOOLS)
		return FALSE;
	// Trap non-magical properties
	if ((iItemPropId == ITEM_PROPERTY_TRAP) && (GetItemPropertyCostTableValue(ipTest) != IP_CONST_TRAPTYPE_HOLY) && (GetItemPropertyCostTableValue(ipTest) != IP_CONST_TRAPTYPE_NEGATIVE))
		return FALSE;
	// Use limitation properties
	if ((iItemPropId == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)
	 || (iItemPropId == ITEM_PROPERTY_USE_LIMITATION_CLASS)
	 || (iItemPropId == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE)
	 || (iItemPropId == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT))
		return FALSE;
	// On Hit non-magical property
	if (iItemPropId == ITEM_PROPERTY_ON_HIT_PROPERTIES)
	{
		// Only Disease and Poison are considered non-magical
		iIPSubType = GetItemPropertySubType(ipTest);
		if ((iIPSubType == IP_CONST_ONHIT_DISEASE)
		 || (iIPSubType == IP_CONST_ONHIT_ITEMPOISON))
		{
			// Creature weapon (bites, claws, etc...)
			int iBaseItem = GetBaseItemType(oItem);
			if ((iBaseItem == BASE_ITEM_CBLUDGWEAPON)
			 || (iBaseItem == BASE_ITEM_CPIERCWEAPON)
			 || (iBaseItem == BASE_ITEM_CSLASHWEAPON)
			 || (iBaseItem == BASE_ITEM_CSLSHPRCWEAP))
	   			return FALSE;

			// Temporary effects (that aren't creature weapons)
			if (GetItemPropertyDurationType(ipTest) == DURATION_TYPE_TEMPORARY)
				return FALSE;
		}
	}
	// On Hit Cast Spell non-magical properties
	if (iItemPropId == ITEM_PROPERTY_ONHITCASTSPELL)
	{
		iIPSubType = GetItemPropertySubType(ipTest);
		iSpellId = StringToInt(Get2DAString("iprp_onhitspell", "SpellIndex", iIPSubType));
		if (JXGetIsSpellExtraordinary(iSpellId)
		 || JXGetIsSpellMiscellaneous(iSpellId))
			return FALSE;
	}
	// Cast Spell non-magical properties
	if (iItemPropId == ITEM_PROPERTY_CAST_SPELL)
	{
		iIPSubType = GetItemPropertySubType(ipTest);
		iSpellId = StringToInt(Get2DAString("iprp_spells", "SpellIndex", iIPSubType));
		if (JXGetIsSpellExtraordinary(iSpellId)
		 || JXGetIsSpellMiscellaneous(iSpellId))
			return FALSE;
	}

 	return TRUE;
}

// Indicate if an item is a magical one.
// - oItem Item to test
// - sAdditionalProperties Other properties available in a string form
// * Returns TRUE if the item is magical
int JXGetIsItemMagical(object oItem, string sAdditionalProperties = "")
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oItem);
	paramList = JXScriptAddParameterString(paramList, sAdditionalProperties);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_ITEMMAGICAL, paramList);

	return JXScriptGetResponseInt();
}

// Get hidden item properties
// - oItem Item to test
// * Returns the hidden item properties in a string form
string JXGetHiddenItemProperties(object oItem)
{
	return GetLocalString(oItem, JX_ITEM_MAGICAL_PROPERTIES);
}

// Set hidden item properties
// - oItem Item to test
// - sHiddenProps Hidden item properties
// * Returns the hidden item properties in a string form
void JXSetHiddenItemProperties(object oItem, string sHiddenProps)
{
	SetLocalString(oItem, JX_ITEM_MAGICAL_PROPERTIES, sHiddenProps);
}

// Get the fortitude saving throw of an item.
// It equals to 2 + (item's caster level / 2) unless overriden.
// - oItem Concerned item
// - sAdditionalProperties Other properties available in a string form
// * Returns the item's fortitude saving throw
int JXGetItemFortitudeSave(object oItem, string sAdditionalProperties = "")
{
	int iSave = GetLocalInt(oItem, JX_ITEM_SAVE_FORTITUDE);
	if (iSave == 0)
		return 2 + (JXGetItemCasterLevel(oItem, sAdditionalProperties) / 2);
	else
		return iSave;
}

// Set the fortitude saving throw of an item
// - oItem Item affected
// - iFortitude The value of the saving throw
void JXSetItemFortitudeSave(object oItem, int iFortitude)
{
	SetLocalInt(oItem, JX_ITEM_SAVE_FORTITUDE, iFortitude);
}

// Get the reflex saving throw of an item.
// It equals to 2 + (item's caster level / 2) unless overriden.
// - oItem Concerned item
// - sAdditionalProperties Item properties available in a string form
// * Returns the item's reflex saving throw
int JXGetItemReflexSave(object oItem, string sAdditionalProperties = "")
{
	int iSave = GetLocalInt(oItem, JX_ITEM_SAVE_REFLEX);
	if (iSave == 0)
		return 2 + (JXGetItemCasterLevel(oItem, sAdditionalProperties) / 2);
	else
		return iSave;
}

// Set the reflex saving throw of an item
// - oItem Item affected
// - iReflex The value of the saving throw
void JXSetItemReflexSave(object oItem, int iReflex)
{
	SetLocalInt(oItem, JX_ITEM_SAVE_REFLEX, iReflex);
}

// Get the will saving throw of an item.
// It equals to 2 + (item's caster level / 2) unless overriden.
// - oItem Concerned item
// - sAdditionalProperties Item properties available in a string form
// * Returns the item's will saving throw
int JXGetItemWillSave(object oItem, string sAdditionalProperties = "")
{
	int iSave = GetLocalInt(oItem, JX_ITEM_SAVE_WILL);
	if (iSave == 0)
		return 2 + (JXGetItemCasterLevel(oItem, sAdditionalProperties) / 2);
	else
		return iSave;
}

// Set the fortitude saving throw of an item
// - oItem Item affected
// - iFortitude The value of the saving throw
void JXSetItemWillSave(object oItem, int iWill)
{
	SetLocalInt(oItem, JX_ITEM_SAVE_REFLEX, iWill);
}

string JXGetBaseItemName(object oItem)
{
	int iBaseItemStrRef = StringToInt(Get2DAString("baseitems", "Name", GetBaseItemType(oItem)));
	return GetStringByStrRef(iBaseItemStrRef);
}

// A magical item makes a saving throw check.
// - iSavingThrow SAVING_THROW_* constant
// - oItem Item that makes the saving throw
// - iDC Difficulty class of the check
// - iSaveType SAVING_THROW_TYPE_* constant
// - oSaveVersus Creature that gets the result message
// * Returns TRUE if the item succeeds the saving throw
int JXMyItemSavingThrow(int iSavingThrow,
						object oItem,
						int iDC,
						int iSaveType = SAVING_THROW_TYPE_NONE,
						object oSaveVersus = OBJECT_SELF)
{
	object oHolder = GetItemPossessor(oItem);

    // Sanity checks to prevent wrapping around
	if (iDC < 1) iDC = 1;
	else if (iDC > 255) iDC = 255;

	// Get the best saving throws from the item and the creature
	int iBestSave;
	int iItemSave;
	// Get the item's saving throw
	switch (iSavingThrow)
	{
		case SAVING_THROW_FORT : iItemSave = JXGetItemFortitudeSave(oItem);
		case SAVING_THROW_REFLEX : iItemSave = JXGetItemReflexSave(oItem);
		case SAVING_THROW_WILL : iItemSave = JXGetItemWillSave(oItem);
	}
	// Get the creature's saving throw
	if (GetIsObjectValid(oHolder))
	{
		int iCreatureSave = JXGetSavingThrow(oHolder, iSavingThrow, iSaveType);
		if (iCreatureSave > iItemSave)
			iBestSave = iCreatureSave;
		else
			iBestSave = iItemSave;
	}
	else
		iBestSave = iItemSave;

	// Make the saving throw check
	int bValid = FALSE;
	int iRoll = d20();
	if ((iRoll + iBestSave) >= iDC)
		bValid = TRUE;

    // -------------------------------------------------------------------------
    // Print the result of the save check to the PC
    // -------------------------------------------------------------------------

	// Base item name
	string sMsgItemName = JXGetBaseItemName(oItem);

	// Saving throw label
	string sMsgSave;
	if (iSavingThrow == SAVING_THROW_FORT)			sMsgSave = GetStringByStrRef(520);
	else if (iSavingThrow == SAVING_THROW_REFLEX)	sMsgSave = GetStringByStrRef(519);
	else if (iSavingThrow == SAVING_THROW_WILL)		sMsgSave = GetStringByStrRef(745);

	// Saving throw vs. type label
	string sMsgSaveVsType = "";
	switch (iSaveType)
	{
		case SAVING_THROW_TYPE_MIND_SPELLS :	sMsgSaveVsType = GetStringByStrRef(8107); break;
		case SAVING_THROW_TYPE_POISON :			sMsgSaveVsType = GetStringByStrRef(1005); break;
		case SAVING_THROW_TYPE_DISEASE :		sMsgSaveVsType = GetStringByStrRef(1006); break;
		case SAVING_THROW_TYPE_FEAR :			sMsgSaveVsType = GetStringByStrRef(993); break;
		case SAVING_THROW_TYPE_SONIC :			sMsgSaveVsType = GetStringByStrRef(2202); break;
		case SAVING_THROW_TYPE_ACID :			sMsgSaveVsType = GetStringByStrRef(1027); break;
		case SAVING_THROW_TYPE_FIRE :			sMsgSaveVsType = GetStringByStrRef(1028); break;
		case SAVING_THROW_TYPE_ELECTRICITY :	sMsgSaveVsType = GetStringByStrRef(1030); break;
		case SAVING_THROW_TYPE_POSITIVE :		sMsgSaveVsType = GetStringByStrRef(5159); break;
		case SAVING_THROW_TYPE_NEGATIVE :		sMsgSaveVsType = GetStringByStrRef(5158); break;
		case SAVING_THROW_TYPE_DEATH :			sMsgSaveVsType = GetStringByStrRef(5154); break;
		case SAVING_THROW_TYPE_COLD :			sMsgSaveVsType = GetStringByStrRef(1029); break;
		case SAVING_THROW_TYPE_DIVINE :			sMsgSaveVsType = GetStringByStrRef(5155); break;
		case SAVING_THROW_TYPE_TRAP :			sMsgSaveVsType = GetStringByStrRef(5563); break;
		case SAVING_THROW_TYPE_SPELL :			sMsgSaveVsType = GetStringByStrRef(2295); break;
		case SAVING_THROW_TYPE_GOOD :			sMsgSaveVsType = GetStringByStrRef(265); break;
		case SAVING_THROW_TYPE_EVIL :			sMsgSaveVsType = GetStringByStrRef(266); break;
		case SAVING_THROW_TYPE_LAW :			sMsgSaveVsType = GetStringByStrRef(4943); break;
		case SAVING_THROW_TYPE_CHAOS :			sMsgSaveVsType = GetStringByStrRef(4944); break;
	}
	if (sMsgSaveVsType != "") sMsgSaveVsType = " " + GetStringByStrRef(7603) + " " + sMsgSaveVsType;

	// Check result (success/failure)
	string sMsgCheckResult;
	if (bValid)
		sMsgCheckResult = GetStringByStrRef(5352);
	else
		sMsgCheckResult = GetStringByStrRef(5353);

	// Build the saving throw message
	string sMessage = GetStringByStrRef(10473);
	sMessage = JXStringReplaceToken(sMessage, 0, "<color=plum>" + sMsgItemName);
	sMessage = JXStringReplaceToken(sMessage, 1, "</color>");
	sMessage = JXStringReplaceToken(sMessage, 2, "<color=skyblue>" + sMsgSave);
	sMessage = JXStringReplaceToken(sMessage, 3, sMsgSaveVsType);
	sMessage = JXStringReplaceToken(sMessage, 4, sMsgCheckResult);
	sMessage = JXStringReplaceToken(sMessage, 5, IntToString(iRoll));
	if (iBestSave >= 0)
	{
		sMessage = JXStringReplaceToken(sMessage, 6, "+");
		sMessage = JXStringReplaceToken(sMessage, 7, IntToString(iBestSave));
	}
	else
	{
		sMessage = JXStringReplaceToken(sMessage, 6, "-");
		sMessage = JXStringReplaceToken(sMessage, 7, IntToString(-iBestSave));
	}
	sMessage = JXStringReplaceToken(sMessage, 8, IntToString(iRoll + iBestSave));
	sMessage = JXStringReplaceToken(sMessage, 9, IntToString(iDC));
	sMessage += "</color>";

	// Display the save check to the PC
	SendMessageToPC(oSaveVersus, sMessage);

    return bValid;
}

// The magical item caster makes a caster level check against the specified DC.
// - oItem Magical item that makes the caster level check
// - iDC Difficulty Class of the check
// * Returns TRUE if the item succeeds the check
int JXItemCasterLevelCheck(object oItem, int iDC)
{
    // Sanity checks to prevent wrapping around
	if (iDC < 1) iDC = 1;
	else if (iDC > 255) iDC = 255;

	// Get the caster level of the creature
	int iCasterLevel = JXGetItemCasterLevel(oItem);

	// Make the saving throw check
	int bValid = FALSE;
	int iRoll = d20();
	if ((iRoll + iCasterLevel) >= iDC)
		bValid = TRUE;

    // -------------------------------------------------------------------------
    // Print the result of the caster level check to the PC
    // -------------------------------------------------------------------------

	// Caster level label
	string sMsgCasterLevel = GetStringByStrRef(17079397);

	// Check result (success/failure)
	string sMsgCheckResult;
	if (bValid)
		sMsgCheckResult = GetStringByStrRef(5352);
	else
		sMsgCheckResult = GetStringByStrRef(5353);

	// Build the saving throw message
	string sMessage = GetStringByStrRef(10473);
	sMessage = JXStringReplaceToken(sMessage, 0, "<color=plum>" + GetName(oItem));
	sMessage = JXStringReplaceToken(sMessage, 1, "</color>");
	sMessage = JXStringReplaceToken(sMessage, 2, "<color=skyblue>" + sMsgCasterLevel);
	sMessage = JXStringReplaceToken(sMessage, 3, "");
	sMessage = JXStringReplaceToken(sMessage, 4, sMsgCheckResult);
	sMessage = JXStringReplaceToken(sMessage, 5, IntToString(iRoll));
	sMessage = JXStringReplaceToken(sMessage, 6, "+");
	sMessage = JXStringReplaceToken(sMessage, 7, IntToString(iCasterLevel));
	sMessage = JXStringReplaceToken(sMessage, 8, IntToString(iRoll + iCasterLevel));
	sMessage = JXStringReplaceToken(sMessage, 9, IntToString(iDC));
	sMessage += "</color>";

	// Display the caster level check to the PC
	SendMessageToPC(GetItemPossessor(oItem), sMessage);

    return bValid;
}