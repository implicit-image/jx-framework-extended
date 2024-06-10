#include "jx_inc_magic_item"

// Remove a permanent item property or a group of item properties from an item.
// The removed properties can be restored by using JXEnableItemProperty().
// If the item property doesn't exist on the item, nothing happens.
// N.B. : Due to NWN2 limitations, "Mind Blank", "On Monster Hit" and
//        "Damage Reduction" properties aren't affected.
// - oItem Item of which item properties must be removed
// - sStoreVariable Name of a variable used to store saved properties
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXImplDisableItemProperty(object oItem, string sStoreVariable, int iItemPropId = JX_ITEM_PROPERTY_ALL)
{
	// Item property type
	int iIPType;

	// Get the item properties curretly saved
	string sItemProperties = GetLocalString(oItem, sStoreVariable);
	string sItemProperty;

	// Loop to remove the item properties
	itemproperty ipLoop = GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(ipLoop))
	{
		// Get the identifier of the current item property
		iIPType = GetItemPropertyType(ipLoop);

		// Temporary properties aren't removed
		if (GetItemPropertyDurationType(ipLoop) == DURATION_TYPE_TEMPORARY)
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

		// Get the item property in a string form
		sItemProperty = JXItemPropertyToString(ipLoop);

		// Special case : As a weapon looses its enhancement bonus, it becomes masterwork
		if ((iItemPropId == JX_ITEM_PROPERTY_MAGIC) && (GetWeaponType(oItem) != WEAPON_TYPE_NONE) && (iIPType == ITEM_PROPERTY_ENHANCEMENT_BONUS))
			AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(1), oItem);

		// Item properties that can't be re-created
		if ((iIPType != ITEM_PROPERTY_MIND_BLANK)		// No ItemPropertyXXX() to create this property
		 && (iIPType != ITEM_PROPERTY_ON_MONSTER_HIT))	// ItemPropertyOnMonsterHitProperties() is bugged
		{
			if (sItemProperties == "")
				sItemProperties = sItemProperty;
			else
				sItemProperties += ";" + sItemProperty;
			RemoveItemProperty(oItem, ipLoop);
		}

		ipLoop = GetNextItemProperty(oItem);
	}

	// Save the item properties that have been removed
	SetLocalString(oItem, sStoreVariable, sItemProperties);
}

// Restore a permanent item property or a group of item properties from an item.
// The restored properties must have been removed by JXDisableItemProperty().
// If the item property hasn't been removed with JXDisableItemProperty(), nothing happens.
// N.B. : Due to NWN2 limitations, "Mind Blank", "On Monster Hit" and
//        "Damage Reduction" properties aren't affected.
// - oItem Item of which item properties must be restored
// - sStoreVariable Name of a variable used to restore saved properties
// - iItemPropId ITEM_PROPERTY_* or JX_ITEM_PROPERTY_* constant
void JXImplEnableItemProperty(object oItem, string sStoreVariable, int iItemPropId = JX_ITEM_PROPERTY_ALL)
{
	string sItemProperties = GetLocalString(oItem, sStoreVariable);
	string sItemProperty;
	string sItemPropertiesResult;

	// Loop on all item properties
	int iPosSemicolon = FindSubString(sItemProperties, ";");
	if (sItemProperties != "")
		while (1)
		{
			// Get the current item property
			if (iPosSemicolon == -1)
				sItemProperty = sItemProperties;
			else
			{
				sItemProperty = GetStringLeft(sItemProperties, iPosSemicolon);
				sItemProperties = GetSubString(sItemProperties, iPosSemicolon + 1, GetStringLength(sItemProperties) - iPosSemicolon + 1);
			}

			// Get the item property previously saved
			itemproperty ipRestored = JXStringToItemProperty(sItemProperty);

			// Determine if the item property has to be restored
			if (iItemPropId != JX_ITEM_PROPERTY_ALL)
				if ((iItemPropId != JX_ITEM_PROPERTY_MAGIC)
				 || (iItemPropId == JX_ITEM_PROPERTY_MAGIC) && (!JXGetIsItemPropertyMagical(oItem, ipRestored)))
					if ((iItemPropId != JX_ITEM_PROPERTY_NOMAGIC)
					 || (iItemPropId == JX_ITEM_PROPERTY_NOMAGIC) && (JXGetIsItemPropertyMagical(oItem, ipRestored)))
					 	if (iItemPropId != GetItemPropertyType(ipRestored))
						{
							if (sItemPropertiesResult == "")
								sItemPropertiesResult = sItemProperty;
							else
								sItemPropertiesResult += ";" + sItemProperty;
							if (iPosSemicolon == -1) break;
							iPosSemicolon = FindSubString(sItemProperties, ";");
							continue;
						}

			// Special case : As a weapon restores its enhancement bonus, it looses its masterwork property
			if ((GetWeaponType(oItem) != WEAPON_TYPE_NONE) && (GetItemPropertyType(ipRestored) == ITEM_PROPERTY_ENHANCEMENT_BONUS))
				IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_ATTACK_BONUS, DURATION_TYPE_PERMANENT);

			// Create the item property found on the item
			AddItemProperty(DURATION_TYPE_PERMANENT, ipRestored, oItem);

			// End loop if there are no other item properties
			if (iPosSemicolon == -1) break;
			iPosSemicolon = FindSubString(sItemProperties, ";");
		}

	// Save the item properties that haven't been restored
	SetLocalString(oItem, sStoreVariable, sItemPropertiesResult);
}

// Get the caster level of a magical item. By default, it gets the best caster level from
// its properties. But it can be overriden with the JX_ITEM_CASTER_LEVEL constant.
// - oItem The magical item from which the caster level is get
// - sAdditionalProperties Other properties available in a string form
// * Returns the caster level of the item
int JXImplGetItemCasterLevel(object oItem, string sAdditionalProperties = "")
{
    if (!GetIsObjectValid(oItem)) return 0;

    // Get the override item caster level
    int iItemCasterLevel = GetLocalInt(oItem, JX_ITEM_CASTER_LEVEL);
    if (iItemCasterLevel > 0) return iItemCasterLevel;

    // Item caster level equals its best item property caster level
    int iIPCasterLevel;
    itemproperty ipLoop = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ipLoop))
    {
        if (JXGetIsItemPropertyMagical(oItem, ipLoop))
        {
            iIPCasterLevel = JXGetItemPropertyCasterLevel(oItem, ipLoop);
            if (iIPCasterLevel > iItemCasterLevel)
                iItemCasterLevel = iIPCasterLevel;
        }
        ipLoop = GetNextItemProperty(oItem);
    }

	// Also look for additional properties under string form (ex: 35;51,2;7,3,3)
	if (sAdditionalProperties != "")
	{
		string sItemProperties = sAdditionalProperties;
		string sItemProperty;

		// Loop all additional item properties
		int iPosSemicolon = FindSubString(sItemProperties, ";");
		if (sItemProperties != "")
			while (1)
			{
				// Get the current item property
				if (iPosSemicolon == -1)
					sItemProperty = sItemProperties;
				else
				{
					sItemProperty = GetStringLeft(sItemProperties, iPosSemicolon);
					sItemProperties = GetSubString(sItemProperties, iPosSemicolon + 1, GetStringLength(sItemProperties) - iPosSemicolon + 1);
				}
	
				// Translate the string into the corresponding item property
				ipLoop = JXStringToItemProperty(sItemProperty);

				// Get the item property's caster level
		        if (JXGetIsItemPropertyMagical(oItem, ipLoop))
		        {
		            iIPCasterLevel = JXGetItemPropertyCasterLevel(oItem, ipLoop);
		            if (iIPCasterLevel > iItemCasterLevel)
		                iItemCasterLevel = iIPCasterLevel;
		        }

				// Find the next item property
				if (iPosSemicolon == -1) break;
				iPosSemicolon = FindSubString(sItemProperties, ";");
			}
	}

    return iItemCasterLevel;
}

// Get the spell school associated with a magical item
// - oItem The magical item from which the spell school is get
// - sAdditionalProperties Other properties available in a string form
// * Returns a SPELL_SCHOOL_* constant
int JXImplGetItemSpellSchool(object oItem, string sAdditionalProperties = "")
{
    if (!GetIsObjectValid(oItem)) return 0;

    // Get the override item spell school
    int iItemSpellSchool = GetLocalInt(oItem, JX_ITEM_SPELL_SCHOOL);
    if (iItemSpellSchool > 0) return iItemSpellSchool;

    // Item spell school is taken from its best item property (best caster level)
    int iItemCasterLevel = 0;
    int iIPCasterLevel;
    itemproperty ipBest;
    itemproperty ipLoop = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ipLoop))
    {
        if (JXGetIsItemPropertyMagical(oItem, ipLoop))
        {
            iIPCasterLevel = JXGetItemPropertyCasterLevel(oItem, ipLoop);
            if (iIPCasterLevel > iItemCasterLevel)
            {
                iItemCasterLevel = iIPCasterLevel;
                ipBest = ipLoop;
            }
        }
        ipLoop = GetNextItemProperty(oItem);
    }

	// Also look for additional properties under string form (ex: 35;51,2;7,3,3)
	if (sAdditionalProperties != "")
	{
		string sItemProperties = sAdditionalProperties;
		string sItemProperty;

		// Loop all additional item properties
		int iPosSemicolon = FindSubString(sItemProperties, ";");
		if (sItemProperties != "")
			while (1)
			{
				// Get the current item property
				if (iPosSemicolon == -1)
					sItemProperty = sItemProperties;
				else
				{
					sItemProperty = GetStringLeft(sItemProperties, iPosSemicolon);
					sItemProperties = GetSubString(sItemProperties, iPosSemicolon + 1, GetStringLength(sItemProperties) - iPosSemicolon + 1);
				}
	
				// Translate the string into the corresponding item property
				ipLoop = JXStringToItemProperty(sItemProperty);

				// Get the item property's spell school
		        if (JXGetIsItemPropertyMagical(oItem, ipLoop))
		        {
		            iIPCasterLevel = JXGetItemPropertyCasterLevel(oItem, ipLoop);
		            if (iIPCasterLevel > iItemCasterLevel)
					{
		                iItemCasterLevel = iIPCasterLevel;
                		ipBest = ipLoop;
					}
		        }

				// Find the next item property
				if (iPosSemicolon == -1) break;
				iPosSemicolon = FindSubString(sItemProperties, ";");
			}
	}

    return JXGetItemPropertySpellSchool(oItem, ipBest);
}

// Indicate if an item is a magical one.
// - oItem Item to test
// - sAdditionalProperties Other properties available in a string form
// * Returns TRUE if the item is magical
int JXImplGetIsItemMagical(object oItem, string sAdditionalProperties = "")
{
    // Item caster level equals its best item property caster level
    int iIPCasterLevel;
    itemproperty ipLoop = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ipLoop))
    {
        if (JXGetIsItemPropertyMagical(oItem, ipLoop))
			return TRUE;
        ipLoop = GetNextItemProperty(oItem);
    }

	// Also look for additional properties under string form (ex: 35;51,2;7,3,3)
	if (sAdditionalProperties != "")
	{
		string sItemProperties = sAdditionalProperties;
		string sItemProperty;

		// Loop all additional item properties
		int iPosSemicolon = FindSubString(sItemProperties, ";");
		if (sItemProperties != "")
			while (1)
			{
				// Get the current item property
				if (iPosSemicolon == -1)
					sItemProperty = sItemProperties;
				else
				{
					sItemProperty = GetStringLeft(sItemProperties, iPosSemicolon);
					sItemProperties = GetSubString(sItemProperties, iPosSemicolon + 1, GetStringLength(sItemProperties) - iPosSemicolon + 1);
				}
	
				// Translate the string into the corresponding item property
				ipLoop = JXStringToItemProperty(sItemProperty);

				// Get the item property's caster level
		        if (JXGetIsItemPropertyMagical(oItem, ipLoop))
					return TRUE;

				// Find the next item property
				if (iPosSemicolon == -1) break;
				iPosSemicolon = FindSubString(sItemProperties, ";");
			}
	}

	return FALSE;
}