//::///////////////////////////////////////////////
//:: General Include for Characters
//:: cmi_ginc_chars
//:: Utility script for Characters
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 19, 2007
//:://////////////////////////////////////////////

#include "cmi_includes"	
#include "x2_inc_itemprop"
#include "nwn2_inc_spells"

/*
const int    X2_IP_ADDPROP_POLICY_REPLACE_EXISTING = 0;
const int    X2_IP_ADDPROP_POLICY_KEEP_EXISTING = 1;
const int    X2_IP_ADDPROP_POLICY_IGNORE_EXISTING =2;
*/

void InfuseDivineSpirit(object oPC)
{
	int nFixCompleted = GetLocalInt(oPC, "PaladinDivinelyInfused");
	if (!nFixCompleted)
	{
		int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
		if (nPaladin > 29)
		{
			//3601 - E
			//3602 - 5
			//3603 - 10
			//3604 - 15
			//3605 - 20
			//3693 - 25
			//3694 - 30	
			FeatAdd(oPC, 3601, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3602, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3603, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3604, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3605, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3693, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3694, FALSE, FALSE, FALSE);						
		}
		else
		if (nPaladin > 24)
		{
			//3601 - E
			//3602 - 5
			//3603 - 10
			//3604 - 15
			//3605 - 20
			//3693 - 25		
			FeatAdd(oPC, 3601, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3602, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3603, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3604, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3605, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3693, FALSE, FALSE, FALSE);
		}
		else
		if (nPaladin > 19)
		{
			//3601 - E
			//3602 - 5
			//3603 - 10
			//3604 - 15
			//3605 - 20	
			FeatAdd(oPC, 3601, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3602, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3603, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3604, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3605, FALSE, FALSE, FALSE);
		}
		else
		if (nPaladin > 14)
		{
			//3601 - E
			//3602 - 5
			//3603 - 10
			//3604 - 15
			FeatAdd(oPC, 3601, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3602, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3603, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3604, FALSE, FALSE, FALSE);		
		}
		else
		if (nPaladin > 9)
		{
			//3601 - E
			//3602 - 5
			//3603 - 10		
			FeatAdd(oPC, 3601, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3602, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3603, FALSE, FALSE, FALSE);
		}
		else
		if (nPaladin > 4)
		{
			//3601 - E
			//3602 - 5	
			FeatAdd(oPC, 3601, FALSE, FALSE, FALSE);
			FeatAdd(oPC, 3602, FALSE, FALSE, FALSE);
		}				
	}
	
}

void StackSpiritShaman(object oPC)
{
	int nSS = GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN, oPC);
	int nCurrent = 0;
	
	//Spirit Form
	if (GetHasFeat(FEAT_EXTRA_SPIRIT_FORM, oPC))
	{
		int nSS = GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN, oPC);
		if (nSS > 14)
			nCurrent = nSS/5 - 1;
		else
			nCurrent = 1;
			
		if (nCurrent == 5)
		{
//3700 - 6
//3701 - 7	
			FeatAdd(oPC, 3700, FALSE, FALSE, FALSE);	
			FeatAdd(oPC, 3701, FALSE, FALSE, FALSE);			
		}
		else
		if (nCurrent == 4)
		{
//2026 - 5		
//3700 - 6	
			FeatAdd(oPC, 2026, FALSE, FALSE, FALSE);	
			FeatAdd(oPC, 3700, FALSE, FALSE, FALSE);	
		}	
		else
		if (nCurrent == 3)
		{
//2025 - 4
//2026 - 5	
			FeatAdd(oPC, 2025, FALSE, FALSE, FALSE);	
			FeatAdd(oPC, 2026, FALSE, FALSE, FALSE);	
		}			
		else
		if (nCurrent == 2)
		{
//2024 - 3
//2025 - 4	
			FeatAdd(oPC, 2024, FALSE, FALSE, FALSE);	
			FeatAdd(oPC, 2025, FALSE, FALSE, FALSE);	
		}		
		else
		{
//2023 - 2
//2024 - 3	
			FeatAdd(oPC, 2023, FALSE, FALSE, FALSE);	
			FeatAdd(oPC, 2024, FALSE, FALSE, FALSE);	
		}		
			
	}
	
	//Spirit Journey
	if (GetHasFeat(FEAT_EXTRA_SPIRIT_JOURNEY, oPC))
	{
			FeatAdd(oPC, 3702, FALSE, FALSE, FALSE);	
			FeatAdd(oPC, 3703, FALSE, FALSE, FALSE);	
	}
	

}

effect EffectCMIFatigue()
{
	// Create the fatigue penalty
	effect eStrPenalty = EffectAbilityDecrease(ABILITY_STRENGTH, 2);
	effect eDexPenalty = EffectAbilityDecrease(ABILITY_DEXTERITY, 2);
	effect eMovePenalty = EffectMovementSpeedDecrease(10);	// 10% decrease
	
	effect eRet = EffectLinkEffects (eStrPenalty, eDexPenalty);
	eRet = EffectLinkEffects(eRet, eMovePenalty);
	eRet = ExtraordinaryEffect(eRet);
	eRet = SetEffectSpellId(eRet, FATIGUE );
	return (eRet);
}

// Simulates an Exhausted effect.  Can't be dispelled.
effect EffectCMIExhausted()
{
	effect eStrPenalty = EffectAbilityDecrease(ABILITY_STRENGTH, 6);
	effect eDexPenalty = EffectAbilityDecrease(ABILITY_DEXTERITY, 6);
	effect eMovePenalty = EffectMovementSpeedDecrease(50);	// 50% decrease
	
	effect eRet = EffectLinkEffects (eStrPenalty, eDexPenalty);
	eRet = EffectLinkEffects(eRet, eMovePenalty);
	eRet = ExtraordinaryEffect(eRet);
	eRet = SetEffectSpellId(eRet, EXHAUSTED );	
	return (eRet);
}

void ClearFatigue(object oTarget)
{
	if (GetHasSpellEffect(FATIGUE,oTarget))
		RemoveSpellEffects(FATIGUE, oTarget, oTarget);	
}

void ClearExhausted(object oTarget)
{
	if (GetHasSpellEffect(EXHAUSTED,oTarget))
		RemoveSpellEffects(EXHAUSTED, oTarget, oTarget);	
}

///////////////////////////////////////////////////////////////////////////////
// ApplyFatigue
///////////////////////////////////////////////////////////////////////////////
// Created By:	Andrew Woo (AFW-OEI)
// Created On:	08/08/2006
// Description:	Applies a "fatigue" effect to the target (oTarget), which lasts
//	nFatigueDuration rounds.  You can delay the fatigue application by fDelay
//	seconds.
///////////////////////////////////////////////////////////////////////////////
void ApplyCMIFatigue(object oTarget, float fFatigueDuration, float fDelay = 0.0f)
{
	// Only apply fatigue if you're not resting.
	if( !GetIsResting() )
	{
		if (GetHasSpellEffect(FATIGUE,oTarget))
		{
			effect eExhausted = EffectCMIExhausted();
			DelayCommand(fDelay, ClearFatigue(oTarget));	
			DelayCommand(fDelay, ClearExhausted(oTarget));			
			DelayCommand(fDelay + 0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExhausted, oTarget, fFatigueDuration));
			DelayCommand(fDelay + 0.2f, SendMessageToPC(oTarget, "Your fatigue becomes exhaustion due to your exertions."));	
		}
		else
		{
			effect eFatigue = EffectCMIFatigue();
			DelayCommand(fDelay, ClearFatigue(oTarget));	
			DelayCommand(fDelay + 0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFatigue, oTarget, fFatigueDuration));		
			DelayCommand(fDelay + 0.2f, SendMessageToPC(oTarget, "Your become fatigued due to your exertions."));				
		}
	}
}

int IsMWM_BValid()
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);	
	if	(GetIsObjectValid(oWeapon) && IPGetIsMeleeWeapon(oWeapon) && (GetWeaponType(oWeapon) == WEAPON_TYPE_BLUDGEONING))
	{
		return TRUE;
	}
	else			
		return FALSE;
}

int IsMWM_PValid()
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);	
	if	(GetIsObjectValid(oWeapon) && IPGetIsMeleeWeapon(oWeapon) && (GetWeaponType(oWeapon) == WEAPON_TYPE_PIERCING || GetWeaponType(oWeapon) == WEAPON_TYPE_PIERCING_AND_SLASHING) )
	{
		return TRUE;
	}
	else			
		return FALSE;
}

int IsMWM_SValid()
{
	int bSlashing;
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);	
	if	(GetIsObjectValid(oWeapon) && IPGetIsMeleeWeapon(oWeapon) && (GetWeaponType(oWeapon) == WEAPON_TYPE_SLASHING || GetWeaponType(oWeapon) == WEAPON_TYPE_PIERCING_AND_SLASHING) )
	{
		bSlashing = TRUE;
	}
	else			
		bSlashing = FALSE;
		
	oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);	
	if	(GetIsObjectValid(oWeapon))
	{
		if (IPGetIsMeleeWeapon(oWeapon))
		{
			if (!(GetWeaponType(oWeapon) == WEAPON_TYPE_SLASHING || GetWeaponType(oWeapon) == WEAPON_TYPE_PIERCING_AND_SLASHING))
				bSlashing = FALSE;
		}			
	}
		
	return bSlashing;
}

int HandleReserveMeta(int nDice, int nDieType)
{

	int nReserveMeta = GetLocalInt(GetModule(), "EnableReserveMeta");
	// 0 = Disabled
	// 1 = Empower
	// 2 = Max
	// 3 = Emp + Max
			
	int nDamage = 0;
	
	if (nReserveMeta)
	{
		int nReserveEmpower;
		int nReserveMaximize;
		int nReserveEmpPlusMax;	
		
		if (nReserveMeta == 3)
		{
			nReserveEmpPlusMax = 1;
			nReserveEmpower = 1;
			nReserveMaximize = 1;
		}
		else
		if (nReserveMeta == 2)
		{
			nReserveMaximize = 1;
		}	
		else
		{
			nReserveEmpower = 1;
		}			
		
		if (nReserveEmpower && !GetHasFeat(FEAT_EMPOWER_SPELL))
			nReserveEmpower = 0;
		if (nReserveMaximize && !GetHasFeat(FEAT_MAXIMIZE_SPELL))
			nReserveMaximize = 0;
		if (nReserveEmpower == 0 || nReserveMaximize == 0)
			nReserveEmpPlusMax = 0;
		
		if (nReserveEmpPlusMax)
		{
			if (nDieType == 6)
			{
				nDamage = (6 * nDice * 3) / 2;
			}
			else
			if (nDieType == 4)
			{
				nDamage = (4 * nDice * 3) / 2;
			}				
		}
		else
		if (nReserveMaximize)
		{
			if (nDieType == 6)
			{
				nDamage = 6 * nDice;
			}
			else
			if (nDieType == 4)
			{
				nDamage = 4 * nDice;
			}		
		}
		else
		if (nReserveEmpower)
		{
			if (nDieType == 6)
			{
				nDamage = (d6(nDice) * 3)/2;
			}
			else
			if (nDieType == 4)
			{
				nDamage = (d4(nDice) * 3)/2;
			}				
		}
		else // No valid metamagics available
		{
			if (nDieType == 6)
			{
				nDamage = d6(nDice);
			}
			else
			if (nDieType == 4)
			{
				nDamage = d4(nDice);
			}		
		}				
		
	}
	else
	{
		if (nDieType == 6)
		{
			nDamage = d6(nDice);
		}
		else
		if (nDieType == 4)
		{
			nDamage = d4(nDice);
		}
	}
	
	return nDamage;
}

int isValidIntuitiveAttackWeapon(object oWpn)
{
	if	(GetIsObjectValid(oWpn))
	{
		int nBaseItemType = GetBaseItemType(oWpn);	
		
		int Valid = FALSE;
		
//club, dagger, mace, sickle, spear, morningstar, quarterstaff
//light and heavy crossbows, dart, and sling.
		if 
		(
			(nBaseItemType == BASE_ITEM_CLUB) ||		
			(nBaseItemType == BASE_ITEM_DAGGER) ||			
			(nBaseItemType == BASE_ITEM_DART) ||	
			(nBaseItemType == BASE_ITEM_LIGHTMACE) ||	
			(nBaseItemType == BASE_ITEM_SICKLE) ||	
			(nBaseItemType == BASE_ITEM_SPEAR) ||	
			(nBaseItemType == BASE_ITEM_MORNINGSTAR) ||		
			(nBaseItemType == BASE_ITEM_LIGHTCROSSBOW) ||	
			(nBaseItemType == BASE_ITEM_HEAVYCROSSBOW) ||	
			(nBaseItemType == BASE_ITEM_QUARTERSTAFF) ||	
			(nBaseItemType == BASE_ITEM_SLING) ||											
			(nBaseItemType == BASE_ITEM_ALLUSE_SWORD) 
		)
			Valid = TRUE;
		return Valid;		
	}	
	else
		return FALSE;
}

int IsIntuitiveAttackValid()
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oWeapon2    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
	
	int bWpn1Valid = FALSE;	
	int bWpn2Valid = FALSE;
	int bMain = FALSE;
	int bOffhand = FALSE;
	
	if	(GetIsObjectValid(oWeapon))
	{
		bWpn1Valid = TRUE;
		if (isValidIntuitiveAttackWeapon(oWeapon))
		{
			bMain = TRUE;
		}	
	}
	
	if	(GetIsObjectValid(oWeapon2))
	{
		bWpn2Valid = TRUE;
		if (isValidIntuitiveAttackWeapon(oWeapon2))
		{
			bOffhand = TRUE;
		}	
		if (!IPGetIsMeleeWeapon(oWeapon2)) //Not a weapon, so it's ok
			bWpn2Valid = FALSE;
	}
	
	//Return Codes
	//0 FALSE
	//1 Character Bonus
	//2 Mainhand Only
	//3 Offhand Only
	
	if (bWpn1Valid == TRUE)
	{
		if (bMain)
		{
			if (bWpn2Valid && bOffhand) //Good main, good off
				return 1;
			else
			if (bWpn2Valid && !bOffhand) //Good main, bad off
				return 2;
			else
				return 1; //Good main, no off
		}
		else
		{
			if (bWpn2Valid && bOffhand) //Bad main, good off
				return 3;
			else
				return FALSE; //Nothing valid equipped
		}
	}
	else
	{
			return 1; //Unarmed, which is valid
	}

				
}

void DelayedDmgResFixApplication(object oPC, effect eEffect)
{
	if (GetHasSpellEffect(DMGRES_FIX,oPC))
	{
		RemoveSpellEffects(DMGRES_FIX, oPC, oPC);
	}
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);
}

void ApplyDmgResFix(object oPC, int nEquip)
{	
    int nCostTableResRef;
	int nDR = 0;
	int nDRType = 0;
	object oItem;
    object oItemBelt = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
		
	if (nEquip)
		oItem = GetPCItemLastEquipped();
	else
		oItem = GetPCItemLastUnequipped();
		
	if(GetIsObjectValid(oItem) && oItem == oItemBelt)
	{
		if (GetHasSpellEffect(DMGRES_FIX,oPC))
		{
			RemoveSpellEffects(DMGRES_FIX, oPC, oPC);
		}	
		if (nEquip)
		{
			itemproperty iProp = GetFirstItemProperty(oItem);
			while (GetIsItemPropertyValid(iProp))
			{
				nCostTableResRef = GetItemPropertyCostTable(iProp);
				if (nCostTableResRef == 7) //IPRP_RESISTCOST
				{
					int nVal;
					nVal = GetItemPropertyCostTableValue(iProp); //Resist Amount, 5/- * nVal
					if (nVal > 0)
					{
						nDR = nVal * 5;
						nVal = GetItemPropertySubType(iProp); //Damage Type, IPRP_DamageType or Toolset Consts
						if (nVal == IP_CONST_DAMAGETYPE_BLUDGEONING)
						{
							nDRType = IP_CONST_DAMAGETYPE_BLUDGEONING;
							SendMessageToPC(GetFirstPC(), "IP_CONST_DAMAGETYPE_BLUDGEONING");
						}
						else
						if (nVal == IP_CONST_DAMAGETYPE_SLASHING)
						{
							nDRType = IP_CONST_DAMAGETYPE_SLASHING;
							SendMessageToPC(GetFirstPC(), "IP_CONST_DAMAGETYPE_SLASHING");
						}
						else
						if (nVal == IP_CONST_DAMAGETYPE_PIERCING)
						{
							nDRType = IP_CONST_DAMAGETYPE_PIERCING;
							SendMessageToPC(GetFirstPC(), "IP_CONST_DAMAGETYPE_PIERCING");
						}
						else
							nDR = 0;										
					}
				}
				/*
				if (nCostTableResRef == 11) //iprp_srcost
				{
					int nVal;
					nVal = GetItemPropertyCostTable(iProp);
					SendMessageToPC(GetFirstPC(), "GetItemPropertyCostTable " + IntToString(nVal));
					nVal = GetItemPropertyCostTableValue(iProp);
					SendMessageToPC(GetFirstPC(), "GetItemPropertyCostTableValue " + IntToString(nVal));
					nVal = GetItemPropertyParam1(iProp);
					SendMessageToPC(GetFirstPC(), "GetItemPropertyParam1 " + IntToString(nVal));
					nVal = GetItemPropertyParam1Value(iProp);
					SendMessageToPC(GetFirstPC(), "GetItemPropertyParam1Value " + IntToString(nVal));
					nVal = GetItemPropertySubType(iProp);
					SendMessageToPC(GetFirstPC(), "GetItemPropertySubType " + IntToString(nVal));
					nVal = GetItemPropertyType(iProp);
					SendMessageToPC(GetFirstPC(), "GetItemPropertyType " + IntToString(nVal));	
					SendMessageToPC(GetFirstPC(), "-----");		
				}
				*/			
				iProp = GetNextItemProperty(oItem);
			}
		    if (nDR > 0)
			{
		
				effect eDR;
				eDR = EffectDamageReduction(nDR/2, DAMAGE_POWER_NORMAL, 0, DR_TYPE_NONE);
				eDR = SetEffectSpellId(eDR, DMGRES_FIX);
				eDR = SupernaturalEffect(eDR);
				DelayCommand(0.3f, DelayedDmgResFixApplication(oPC, eDR));
			}			
		}		
	}	//end if valid object and belt item	     	
}

void DelayedSRFixApplication(object oPC, effect eEffect)
{
	if (GetHasSpellEffect(SR_FIX,oPC))
	{
		RemoveSpellEffects(SR_FIX, oPC, oPC);
	}
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);
}

int GetSRValueBy2DAValue(int nItemPropertyCostTableValueIndex)
{
	int nSR = 10;
	
	switch (nItemPropertyCostTableValueIndex)
	{
		case 0: nSR = 10;
			break;
		case 1: nSR = 12;
			break;
		case 2: nSR = 14;
			break;
		case 3: nSR = 16;
			break;
		case 4: nSR = 18;
			break;
		case 5: nSR = 20;
			break;
		case 6: nSR = 22;
			break;
		case 7: nSR = 24;
			break;
		case 8: nSR = 26;
			break;
		case 9: nSR = 28;
			break;
		case 10: nSR = 30;
			break;
		case 11: nSR = 32;
			break;
		case 12: nSR = 34;
			break;
		case 13: nSR = 36;
			break;
		case 14: nSR = 38;
			break;
		case 15: nSR = 40;
			break;
		case 16: nSR = 19;
			break;																																							
		default: nSR = 10;
			break;									
	}
	
	return nSR;
}

void ApplySRFix(object oPC)
{
	if (GetHasSpellEffect(SR_FIX,oPC))
	{
		RemoveSpellEffects(SR_FIX, oPC, oPC);
	}
	
    object oItem;
    int nSRMax=0;	
    int nSRCurrent=0;

    int nCostTableResRef;
    int nValue;

	int nSlotNum;
    for(nSlotNum = 0; nSlotNum < NUM_INVENTORY_SLOTS; nSlotNum++)
    {
        oItem = GetItemInSlot(nSlotNum, oPC);
        if(GetIsObjectValid(oItem))
        {
        	itemproperty iProp = GetFirstItemProperty(oItem);
        	while (GetIsItemPropertyValid(iProp))
            {
	            nCostTableResRef = GetItemPropertyCostTable(iProp);
	            if (nCostTableResRef == 11) //iprp_srcost
	            {
					nValue = GetItemPropertyCostTableValue(iProp);
	                //string nSRValue = Get2DAString("iprp_srcost", "Value", nValue);
	                //nSRCurrent = StringToInt(nSRValue);
					nSRCurrent = GetSRValueBy2DAValue(nValue);
		            if (nSRMax < nSRCurrent)
		            {
		                nSRMax = nSRCurrent;
		            }					
	            }
	            iProp = GetNextItemProperty(oItem);
            }
        }
    }
	
    if (nSRMax > 0)
	{
		effect eSR = EffectSpellResistanceIncrease(nSRMax);
		eSR = SetEffectSpellId(eSR, SR_FIX);
		eSR = SupernaturalEffect(eSR);
		DelayCommand(0.3f, DelayedSRFixApplication(oPC, eSR));
	}
	     	
}

void CleanAssassin(object oPC)
{
	if (GetHasFeat(468, oPC, TRUE))
		FeatRemove(oPC, 468);
	if (GetHasFeat(469, oPC, TRUE))
		FeatRemove(oPC, 469);
	if (GetHasFeat(470, oPC, TRUE))
		FeatRemove(oPC, 470);
	if (GetHasFeat(471, oPC, TRUE))
		FeatRemove(oPC, 471);						
	SetLocalInt(oPC, "AssassinCleaned", 1);
}

void CleanBlackGuard(object oPC)
{
	if (GetHasFeat(476, oPC, TRUE))
		FeatRemove(oPC, 476);
	if (GetHasFeat(477, oPC, TRUE))
		FeatRemove(oPC, 477);	
	if (GetHasFeat(478, oPC, TRUE))
		FeatRemove(oPC, 478);
	if (GetHasFeat(479, oPC, TRUE))
		FeatRemove(oPC, 479);				
	SetLocalInt(oPC, "BlackGuardCleaned", 1);
}

int isValidElegantStrikeWeapon(object oWpn)
{
	if	(GetIsObjectValid(oWpn))
	{
		int nBaseItemType = GetBaseItemType(oWpn);	
		
		int Valid = FALSE;
		if 
		(
			(nBaseItemType == BASE_ITEM_LONGSWORD) ||		
			(nBaseItemType == BASE_ITEM_RAPIER) ||			
			(nBaseItemType == BASE_ITEM_SCIMITAR) ||	
			//(nBaseItemType == BASE_ITEM_SHORTSWORD) ||				
			(nBaseItemType == BASE_ITEM_ALLUSE_SWORD) 
		)
			Valid = TRUE;
		return Valid;		
	}	
	else
		return FALSE;
}

void StackEldBlast (object oPC)
{
	int nWarlock = GetLevelByClass(CLASS_TYPE_WARLOCK, oPC);
	int nHeartwarder = GetLevelByClass(CLASS_HEARTWARDER, oPC);
	int nStormSinger = GetLevelByClass(CLASS_STORMSINGER, oPC);
	int nChildNight = GetLevelByClass(CLASS_CHILD_NIGHT, oPC);
	if (nChildNight > 0 && !GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_WARLOCK, oPC) )
		nChildNight = 0;	
	if (nHeartwarder > 0 && !GetHasFeat(FEAT_HEARTWARDER_SPELLCASTING_WARLOCK, oPC) )
		nHeartwarder = 0;
	if (nStormSinger > 0 && !GetHasFeat(FEAT_STORMSINGER_SPELLCASTING_WARLOCK, oPC) )
		nStormSinger = 0;		
	int nKoT = GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oPC);
	if (nKoT > 0 && !GetHasFeat(FEAT_KOT_SPELLCASTING_WARLOCK, oPC) )
		nKoT = 0;
	int nDrgSlyr = GetLevelByClass(CLASS_DRAGONSLAYER, oPC);
	if (nDrgSlyr > 0 && !GetHasFeat(FEAT_DRSLR_SPELLCASTING_WARLOCK, oPC) )
		nDrgSlyr = 0;
	else
		nDrgSlyr = (nDrgSlyr + 1) / 2;
	int nDaggMage = GetLevelByClass(CLASS_DAGGERSPELL_MAGE, oPC);
	if (nDaggMage > 0 && !GetHasFeat(FEAT_DMAGE_SPELLCASTING_WARLOCK, oPC) )
		nDaggMage = 0;
					
	int nTotal = nDaggMage + nWarlock + nHeartwarder + nKoT + nDrgSlyr + nStormSinger + nChildNight; //Total Warlock level for blasts
	int nDice;
	int nCount;	
	
	//if Hellfire Warlock is needed
	int nHfW = GetLevelByClass(CLASS_TYPE_HELLFIRE_WARLOCK, oPC);
	nTotal += nHfW; 

	//Eld Disciple always advances dice
	int nEldDisc = GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oPC);
	nTotal += nEldDisc;
	
	
	//1411-1419 1-9
	//1948-1952 10-14
		
	if (nTotal > 20) //10-14
	{
		nDice = (nTotal - 20) / 2;
		for (nCount = 0; nCount < nDice; nCount++)
		{
			FeatAdd(oPC, nCount + 1948, FALSE);
		}		
		FeatAdd(oPC, 1411, FALSE);
		FeatAdd(oPC, 1412, FALSE);	
		FeatAdd(oPC, 1413, FALSE);	
		FeatAdd(oPC, 1414, FALSE);	
		FeatAdd(oPC, 1415, FALSE);	
		FeatAdd(oPC, 1416, FALSE);	
		FeatAdd(oPC, 1417, FALSE);	
		FeatAdd(oPC, 1418, FALSE);	
		FeatAdd(oPC, 1419, FALSE);				
	}
	else
	if (nTotal > 11) //7-9
	{
		nDice = (nTotal - 11) / 3;
		for (nCount = 0; nCount < nDice; nCount++)
		{
			FeatAdd(oPC, nCount + 1417, FALSE);
		}	
		FeatAdd(oPC, 1411, FALSE);
		FeatAdd(oPC, 1412, FALSE);	
		FeatAdd(oPC, 1413, FALSE);	
		FeatAdd(oPC, 1414, FALSE);	
		FeatAdd(oPC, 1415, FALSE);	
		FeatAdd(oPC, 1416, FALSE);										
	}
	else //1-6
	{

		nDice = (nTotal + 1) / 2;
		for (nCount = 0; nCount < nDice; nCount++)
		{
			FeatAdd(oPC, nCount + 1411, FALSE);
		}
		
	}

}

void SetupDragonDis()
{
	
	if (GetHasFeat(FEAT_DRAGON_DIS_GOLD, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 1);
		return;
	}
	if (GetHasFeat(FEAT_DRAGON_DIS_RED, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 1);
		return;
	}
	if (GetHasFeat(FEAT_DRAGON_DIS_BRASS, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 1);
		return;
	}	
	if (GetHasFeat(FEAT_DRAGON_DIS_BLACK, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 2);
		return;
	}	
	if (GetHasFeat(FEAT_DRAGON_DIS_GREEN, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 2);
		return;
	}	
	if (GetHasFeat(FEAT_DRAGON_DIS_COPPER, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 2);
		return;
	}	
	
	if (GetHasFeat(FEAT_DRAGON_DIS_BLUE, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 3);
		return;
	}	
	if (GetHasFeat(FEAT_DRAGON_DIS_BRONZE, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 3);
		return;
	}	
	
	if (GetHasFeat(FEAT_DRAGON_DIS_SILVER, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 4);
		return;
	}	
	if (GetHasFeat(FEAT_DRAGON_DIS_WHITE, OBJECT_SELF))
	{
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 4);
		return;
	}							

}


//dagger, handaxe, kama, kukri, light hammer, mace, rapier, short sword, sickle, whip and unarmed strike
int isWeaponFinesseable(object oWeapon)
{

	int nBaseItemType = GetBaseItemType(oWeapon);
	
	if (nBaseItemType == 
		BASE_ITEM_DAGGER ||
		BASE_ITEM_HANDAXE ||
		BASE_ITEM_KAMA ||
		BASE_ITEM_KUKRI ||
		BASE_ITEM_LIGHTHAMMER ||
		BASE_ITEM_MACE ||
		BASE_ITEM_RAPIER ||
		BASE_ITEM_SHORTSWORD ||
		BASE_ITEM_SICKLE ||
		BASE_ITEM_CBLUDGWEAPON ||
		BASE_ITEM_CPIERCWEAPON ||
		BASE_ITEM_CSLASHWEAPON ||
		BASE_ITEM_CSLSHPRCWEAP	)
		{
			return TRUE;		
		}
		else
			return FALSE;
	
	return FALSE;

}

int isDeadlyDefenseValid(object oPartyMember)
{
	int nArmorRank = ARMOR_RANK_NONE;
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPartyMember);
 	if (GetIsObjectValid(oArmor))
		nArmorRank = GetArmorRank(oArmor);
	//SendMessageToPC(oPartyMember, "Rank: " + IntToString(nArmorRank));	
	object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPartyMember);
	object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPartyMember);
	
	int nWpnType1;
	int nWpnType2;
	
 	if (GetIsObjectValid(oWeapon1))	
	{
		if (!isWeaponFinesseable(oWeapon1))
			return FALSE;	
	}
	
 	if (GetIsObjectValid(oWeapon2))
	{
		if (!isWeaponFinesseable(oWeapon2))
			return FALSE;
	}
		
	if (nArmorRank == ARMOR_RANK_NONE || nArmorRank == ARMOR_RANK_LIGHT)
		return TRUE;
	else 
		return FALSE;

}

int IsTwoWeaponValid(object oPartyMember)
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPartyMember);
    //object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oWeapon2    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPartyMember);
	
    if (GetIsObjectValid(oWeapon2))
    {
		int nBaseItemType = GetBaseItemType(oWeapon2);
		
        if (nBaseItemType ==BASE_ITEM_LARGESHIELD ||
            nBaseItemType ==BASE_ITEM_SMALLSHIELD ||
            nBaseItemType ==BASE_ITEM_TOWERSHIELD)
        {
            oWeapon2 = OBJECT_INVALID;
        }
    }
	
	if	(GetIsObjectValid(oWeapon))
	{
		int nBaseItemType = GetBaseItemType(oWeapon);
		if (GetWeaponRanged(oWeapon))
			oWeapon = OBJECT_INVALID;
	}
	
	if ((oWeapon != OBJECT_INVALID) &&  (oWeapon2 != OBJECT_INVALID))
	{
		return TRUE;
	}
	else
		return FALSE;
}

int IsElemArcherStateValid()
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	
    if (GetIsObjectValid(oWeapon))
    {
		int nBaseItemType = GetBaseItemType(oWeapon);
		switch (nBaseItemType)
		{
			case BASE_ITEM_HEAVYCROSSBOW:
				return TRUE;
				break;
				
			case BASE_ITEM_LIGHTCROSSBOW:
				return TRUE;
				break;
				
			case BASE_ITEM_LONGBOW:
				return TRUE;
				break;
				
			case BASE_ITEM_SHORTBOW:
				return TRUE;
				break;
				
			case BASE_ITEM_SHURIKEN:
				return TRUE;
				break;
				
			case BASE_ITEM_THROWINGAXE:
				return TRUE;
				break;
				
			case BASE_ITEM_DART:
				return TRUE;
				break;
				
			case BASE_ITEM_SLING:
				return TRUE;
				break;	
				
			default:
				return FALSE;
				break;											
																		
		}
    }
	return FALSE;

}

int GetCurrentWildShapeFeat(object oPC)
{	
	if (GetHasFeat(1933, oPC)) //9
		return 1933;	
	if (GetHasFeat(1932, oPC)) //8
		return 1932;
	if (GetHasFeat(1931, oPC)) //7
		return 1931;
	if (GetHasFeat(339, oPC)) //6
		return 339;		
	if (GetHasFeat(338, oPC)) //5
		return 338;	
	if (GetHasFeat(337, oPC)) //4
		return 337;		
	if (GetHasFeat(336, oPC)) //3
		return 336;			
	if (GetHasFeat(335, oPC)) //2
		return 335;	
	if (GetHasFeat(305, oPC)) //1
		return 305;												
	return -1;
}

void EvaluateUCM()
{
		object oPC = OBJECT_SELF;
	
		int nSpellId = SPELLABILITY_UNARMED_COMBAT_MASTERY;		
		int bUCMStateValid = FALSE;
		
	    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	    object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
		
		if (GetIsObjectValid(oWeapon) || GetIsObjectValid(oWeapon2))	
			bUCMStateValid = FALSE;
		else
			bUCMStateValid = TRUE;	

		int bHasUCM = GetHasSpellEffect(nSpellId,oPC);
		RemoveSpellEffects(nSpellId, oPC, oPC);
		if (bUCMStateValid)
		{
				effect eAB = SupernaturalEffect(EffectAttackIncrease(2));
				effect eDmg = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_BLUDGEONING));
				effect eLink = SupernaturalEffect(EffectLinkEffects(eAB,eDmg));
				eLink = SetEffectSpellId(eLink,nSpellId);
					
				if (!bHasUCM)
					SendMessageToPC(oPC,"Unarmed Combat Mastery enabled.");			
				DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48)));				
		}
		else
		{
			if (bHasUCM)
				SendMessageToPC(oPC,"Unarmed Combat Mastery disabled, it is only valid when fighting unarmed or with creature weapons.");			
		}		
}

void EvaluateOver2WpnFight()
{
	if (GetHasSpellEffect(SPELLABILITY_OVERSIZE_TWO_WEAPON_FIGHTING,OBJECT_SELF))
		RemoveEffectsFromSpell(OBJECT_SELF, SPELLABILITY_OVERSIZE_TWO_WEAPON_FIGHTING);
	//SendMessageToPC(OBJECT_SELF, "EvaluateOver2WpnFight");
	
	int bValid = FALSE;
    object oWeapon2    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    if (GetIsObjectValid(oWeapon2))
    {
		int nBaseItemType = GetBaseItemType(oWeapon2);
		
        if (nBaseItemType ==BASE_ITEM_LARGESHIELD ||
            nBaseItemType ==BASE_ITEM_SMALLSHIELD ||
            nBaseItemType ==BASE_ITEM_TOWERSHIELD)
        {
        	bValid = FALSE;
        }
		else
			bValid = TRUE;
    }
	if (bValid)
	{
		int nBaseItemType = GetBaseItemType(oWeapon2);
		if ( 		
			nBaseItemType == BASE_ITEM_LONGSWORD
			|| nBaseItemType == BASE_ITEM_BATTLEAXE
			|| nBaseItemType == BASE_ITEM_BASTARDSWORD
			|| nBaseItemType == BASE_ITEM_LIGHTFLAIL
			|| nBaseItemType == BASE_ITEM_WARHAMMER
			|| nBaseItemType == BASE_ITEM_HALBERD
			|| nBaseItemType == BASE_ITEM_GREATSWORD
			|| nBaseItemType == BASE_ITEM_GREATAXE
			|| nBaseItemType == BASE_ITEM_CLUB
			|| nBaseItemType == BASE_ITEM_KATANA
			|| nBaseItemType == BASE_ITEM_MAGICSTAFF
			|| nBaseItemType == BASE_ITEM_MORNINGSTAR
			|| nBaseItemType == BASE_ITEM_QUARTERSTAFF
			|| nBaseItemType == BASE_ITEM_RAPIER
			|| nBaseItemType == BASE_ITEM_SCIMITAR
			|| nBaseItemType == BASE_ITEM_SCYTHE
			|| nBaseItemType == BASE_ITEM_FALCHION
			|| nBaseItemType == BASE_ITEM_DWARVENWARAXE
			|| nBaseItemType == BASE_ITEM_SPEAR
			|| nBaseItemType == BASE_ITEM_GREATCLUB
			|| nBaseItemType == BASE_ITEM_WARMACE
			|| nBaseItemType == BASE_ITEM_ALLUSE_SWORD
		   )
			bValid = TRUE; // Stays true;
		else
			bValid = FALSE;		
		
	}
	if (bValid)
	{
		effect eAB = EffectAttackIncrease(2);
		eAB = SetEffectSpellId(eAB, SPELLABILITY_OVERSIZE_TWO_WEAPON_FIGHTING);
		eAB = SupernaturalEffect(eAB);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(SPELLABILITY_OVERSIZE_TWO_WEAPON_FIGHTING, DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, HoursToSeconds(48)));		
	}	
}

void EvaluateArmorSpec()
{
	object oPC = OBJECT_SELF;
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST);
	int nArmorRank = GetArmorRank(oArmor);
	
	if (GetHasSpellEffect(SPELLABILITY_ARMOR_SPECIALIZATION_MEDIUM,oPC))
	{
		if (nArmorRank == ARMOR_RANK_MEDIUM && GetHasFeat(FEAT_ARMOR_SPECIALIZATION_MEDIUM))
			return;
		else		
			RemoveEffectsFromSpell(oPC, SPELLABILITY_ARMOR_SPECIALIZATION_MEDIUM);
	}
	if (GetHasSpellEffect(SPELLABILITY_ARMOR_SPECIALIZATION_HEAVY,oPC))
	{	
		if (nArmorRank == ARMOR_RANK_HEAVY && GetHasFeat(FEAT_ARMOR_SPECIALIZATION_HEAVY))
			return;
		else
			RemoveEffectsFromSpell(oPC, SPELLABILITY_ARMOR_SPECIALIZATION_HEAVY);
	}	
				
	if (nArmorRank == ARMOR_RANK_MEDIUM && GetHasFeat(FEAT_ARMOR_SPECIALIZATION_MEDIUM))
	{
		effect eDR = EffectDamageReduction(2, DR_TYPE_NONE, 0, DR_TYPE_NONE);
		eDR = SetEffectSpellId(eDR, SPELLABILITY_ARMOR_SPECIALIZATION_MEDIUM);
		eDR = SupernaturalEffect(eDR);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(SPELLABILITY_ARMOR_SPECIALIZATION_MEDIUM, DURATION_TYPE_PERMANENT, eDR, oPC));			
	}
	else
	if (nArmorRank == ARMOR_RANK_HEAVY && GetHasFeat(FEAT_ARMOR_SPECIALIZATION_HEAVY))
	{
		effect eDR = EffectDamageReduction(2, DR_TYPE_NONE, 0, DR_TYPE_NONE);
		eDR = SetEffectSpellId(eDR, SPELLABILITY_ARMOR_SPECIALIZATION_HEAVY);
		eDR = SupernaturalEffect(eDR);
		//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDR, oPC);	
		DelayCommand(0.1f, cmi_ApplyEffectToObject(SPELLABILITY_ARMOR_SPECIALIZATION_HEAVY, DURATION_TYPE_PERMANENT, eDR, oPC));
	}
	
}

/*
effect RangedDamage(object oUser = OBJECT_SELF)
{
	
	int nSlash=0; //4
	int nBlunt=0; //1
	int nPierce=0; //2
	int nFire=0; //256
	int nAcid=0; //16
	int nElec=0; //128
	int nCold=0; //32
	int nSonic=0; //2048
	int nDivine=0; //64
	int nNeg=0; //512
	int nMag=0; //8
	int nPos=0; //1024
	
	//Need int GetDamageByDmgBonusConstant(int nConstant)
	//Need int GetWeaponDamageByItem(object oItem)
	//Need int GetWeaponDamageTypeByItem(object oItem)
	
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
	int bSpec;
	int nDamage;
    if (GetIsObjectValid(oItem) == TRUE)
    {
		int nDamageType = GetWeaponType(oItem);        
		if (GetBaseItemType(oItem) == BASE_ITEM_LONGBOW )
        {
            nDamage = d8();
            if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONGBOW,oUser))
            {
              bSpec = TRUE;
            }
        }
        else
        if (GetBaseItemType(oItem) == BASE_ITEM_SHORTBOW)
        {
            nDamage = d6();
            if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORTBOW,oUser))
            {
              bSpec = TRUE;
            }
        }
        else
            return 0;
    }
    else
    {
            return 0;
    }

    int nStrength = GetAbilityModifier(ABILITY_STRENGTH,oUser);

    if (bSpec == TRUE)
    {
        nDamage +=2;
    }
	
	effect eEffect = GetFirstEffect(OBJECT_SELF);
	int nType;
	while(GetIsEffectValid(eEffect))
   	{
      nType = GetEffectType(eEffect);
      if(nType == EFFECT_TYPE_DAMAGE_INCREASE)
	  {
	  
		//GetEffectInteger(eEffect, 0)
		//0 is DAMAGE_BONUS
		//1 is DAMAGE_TYPE
      }
      eEffect = GetNextEffect(OBJECT_SELF);
   	}	
	
	effect eDamage;
    return eDamage;
}
*/

/*
int GetASFReducedPercent(object oPC)
{
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
 	if (GetIsObjectValid(oArmor))
	{
		int nArmorRank = GetArmorRank(oArmor);
		if (nArmorRank == ARMOR_RANK_LIGHT)
			return 15;
		else
		if (nArmorRank == ARMOR_RANK_MEDIUM)
			return 30;
		else
			return 0;
	}	
	else 
		return 0;
}
*/

int GetASFReduction(object oPC, int nBattleCaster = 0)
{
	int nASF = 0;
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
 	if (GetIsObjectValid(oArmor))
	{
		int nArmorRank = GetArmorRank(oArmor);
		if (nArmorRank == ARMOR_RANK_MEDIUM)
		{
		 	if (nBattleCaster == 0)
				return 0;
			else
			{
				int nArmorRules = GetArmorRulesType(oArmor);
				string sASF = Get2DAString("armorrulestats", "ARCANEFAILURE%", nArmorRules);
				nASF = StringToInt(sASF);
				return nASF;
			}
		}
		if (nArmorRank == ARMOR_RANK_LIGHT)
		{
				int nArmorRules = GetArmorRulesType(oArmor);
				string sASF = Get2DAString("armorrulestats", "ARCANEFAILURE%", nArmorRules);
				nASF = StringToInt(sASF);
				return nASF;		
		}
	}
	return 0;
}

void EvaluateArmoredCaster()
{

	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_Armored_Caster;
	int bArmoredCasterValid = GetASFReduction(oPC, FALSE);	
	int bHasArmoredCaster = GetHasSpellEffect(nSpellId,oPC);
	
	if (bHasArmoredCaster)
		RemoveSpellEffects(nSpellId, oPC, oPC);	
	
	if (bArmoredCasterValid)
	{
		if (!bHasArmoredCaster)
			SendMessageToPC(oPC,"Armored Caster enabled.");	
		int nValue = 0 - bArmoredCasterValid;
		effect eASF = SupernaturalEffect(EffectArcaneSpellFailure(nValue));	
		eASF = SetEffectSpellId(eASF,nSpellId);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_PERMANENT, eASF, oPC));							
	}
	else
	{
		if (bHasArmoredCaster)
			SendMessageToPC(oPC,"Armored Caster disabled. You must be wearing light armor with arcane spell failure for this ability to work.");			
	}
}

void EvaluateBattleCaster()
{

	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_Battle_Caster;
	int bBattleCasterValid = GetASFReduction(oPC, TRUE);	
	int bHasBattleCaster = GetHasSpellEffect(nSpellId,oPC);
	
	if (GetHasSpellEffect(SPELLABILITY_Armored_Caster,oPC))
		RemoveSpellEffects(SPELLABILITY_Armored_Caster, oPC, oPC);	
	if (bHasBattleCaster)
		RemoveSpellEffects(nSpellId, oPC, oPC);			
	
	if (bBattleCasterValid)
	{
		if (!bHasBattleCaster)
			SendMessageToPC(oPC,"Battle Caster enabled.");
		int nValue = 0 - bBattleCasterValid;			
		effect eASF = SupernaturalEffect(EffectArcaneSpellFailure(nValue));	
		eASF = SetEffectSpellId(eASF,nSpellId);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_PERMANENT, eASF, oPC));							
	}
	else
	{
		if (bHasBattleCaster)
			SendMessageToPC(oPC,"Battle Caster disabled. You must be wearing light or medium armor with arcane spell failure for this ability to work.");			
	}
}

//For simple uses/day
int GetBardicClassLevelForUses(object oPC)
{

	int nBardicMusic;
	
	nBardicMusic = GetLevelByClass(CLASS_TYPE_BARD, oPC);
	nBardicMusic += GetLevelByClass(CLASS_STORMSINGER, oPC);
	nBardicMusic += GetLevelByClass(CLASS_CANAITH_LYRIST, oPC);
	nBardicMusic += GetLevelByClass(CLASS_LYRIC_THAUMATURGE, oPC);
	nBardicMusic += GetLevelByClass(CLASS_DISSONANT_CHORD, oPC);		
	return nBardicMusic;	

}

//For classes that advance songs known
int GetBardicClassLevelForSongs(object oPC)
{

	int nBardicMusic;
	
	nBardicMusic = GetLevelByClass(CLASS_TYPE_BARD, oPC);
	nBardicMusic += GetLevelByClass(CLASS_CANAITH_LYRIST, oPC);
	return nBardicMusic;	

}


void StackSwashbucklerGrace(object oPC)
{
	int nRogue = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
	nRogue += GetLevelByClass(CLASS_NINJA, oPC);
	int nSwash = GetLevelByClass(CLASS_TYPE_SWASHBUCKLER,oPC);
	
	int nDaringOutlawCap = GetLocalInt(GetModule(), "DaringOutlawCap");	
	if (nDaringOutlawCap > 0)
	{
		if (nRogue > nDaringOutlawCap)
			nRogue = nDaringOutlawCap;
	}
	
	if (!GetHasFeat(FEAT_DARING_OUTLAW , oPC))
		nRogue = 0;
	
	int nTotal = nRogue + nSwash;
	
	//Grace
	if (nTotal > 28)
	{
		FeatAdd(oPC, 2140 , FALSE, FALSE, FALSE);
		FeatAdd(oPC, 2139 , FALSE, FALSE, FALSE);
		FeatAdd(oPC, 2138 , FALSE, FALSE, FALSE);						
	}
	else if (nTotal > 19)
	{
		FeatAdd(oPC, 2139 , FALSE, FALSE, FALSE);
		FeatAdd(oPC, 2138 , FALSE, FALSE, FALSE);		
	}
	else if (nTotal > 10)
	{
		FeatAdd(oPC, 2138 , FALSE, FALSE, FALSE);	
	}						
}

void StackSwashbucklerDodge(object oPC)
{

	int nTotal=0;
	int nDaringOutlawCap = GetLocalInt(GetModule(), "DaringOutlawCap");	
		
	int nWildStlk = GetLevelByClass(CLASS_WILD_STALKER,oPC);
	if (nWildStlk > 3)
		nTotal += nWildStlk/4;
	
	int nRogue = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
	int nNinja = GetLevelByClass(CLASS_NINJA, oPC);
	int nSwash = GetLevelByClass(CLASS_TYPE_SWASHBUCKLER,oPC);	
		
	int nScout = GetLevelByClass(CLASS_SCOUT,oPC);
	
	if (GetHasFeat(FEAT_SWIFT_AMBUSHER , oPC))
	{
		if (GetHasFeat(FEAT_DARING_OUTLAW , oPC))
		{	
			nScout += nRogue;
			nScout += nNinja;
			nScout += nSwash;
		}
		else
		{
			nScout += nRogue;
			nScout += nNinja;		
		}
	}
	else
	{
		if (GetHasFeat(FEAT_DARING_OUTLAW , oPC))
		{
			if (nDaringOutlawCap > 0)
			{
				if (nRogue + nNinja > nDaringOutlawCap)
					nSwash += nDaringOutlawCap;
			}
			else
			{
				nSwash += nRogue;
				nSwash += nNinja;			
			}		
		
		}	
	}
	if (GetHasFeat(FEAT_SWIFT_HUNTER , oPC))
	{
		int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oPC);	
		nScout += nRanger;
	}	
	
	nTotal += ((nScout + 1)/4);
	nTotal += nSwash/5; 	
	
	//Dodge
	if (nTotal > 6)
	{
		FeatAdd(oPC, FEAT_SCOUT_SKIRMISHAC , FALSE, FALSE, FALSE); //+7	
		FeatAdd(oPC, 2148 , FALSE, FALSE, FALSE); //+6
		FeatAdd(oPC, 2147 , FALSE, FALSE, FALSE); //+5
		FeatAdd(oPC, 2146 , FALSE, FALSE, FALSE); //+4
		FeatAdd(oPC, 2145 , FALSE, FALSE, FALSE); //+3
		FeatAdd(oPC, 2144 , FALSE, FALSE, FALSE); //+2
		FeatAdd(oPC, 2143 , FALSE, FALSE, FALSE); //+1		
	}
	if (nTotal == 6)
	{
		FeatAdd(oPC, 2148 , FALSE, FALSE, FALSE); //+6
		FeatAdd(oPC, 2147 , FALSE, FALSE, FALSE); //+5
		FeatAdd(oPC, 2146 , FALSE, FALSE, FALSE); //+4
		FeatAdd(oPC, 2145 , FALSE, FALSE, FALSE); //+3
		FeatAdd(oPC, 2144 , FALSE, FALSE, FALSE); //+2
		FeatAdd(oPC, 2143 , FALSE, FALSE, FALSE); //+1											
						
	}
	else if (nTotal == 5)
	{
		FeatAdd(oPC, 2147 , FALSE, FALSE, FALSE); //+5
		FeatAdd(oPC, 2146 , FALSE, FALSE, FALSE); //+4
		FeatAdd(oPC, 2145 , FALSE, FALSE, FALSE); //+3
		FeatAdd(oPC, 2144 , FALSE, FALSE, FALSE); //+2
		FeatAdd(oPC, 2143 , FALSE, FALSE, FALSE); //+1			
	}	
	else if (nTotal == 4)
	{
		FeatAdd(oPC, 2146 , FALSE, FALSE, FALSE); //+4
		FeatAdd(oPC, 2145 , FALSE, FALSE, FALSE); //+3
		FeatAdd(oPC, 2144 , FALSE, FALSE, FALSE); //+2
		FeatAdd(oPC, 2143 , FALSE, FALSE, FALSE); //+1		
	}	
	else if (nTotal == 3)
	{
		FeatAdd(oPC, 2145 , FALSE, FALSE, FALSE); //+3
		FeatAdd(oPC, 2144 , FALSE, FALSE, FALSE); //+2
		FeatAdd(oPC, 2143 , FALSE, FALSE, FALSE); //+1		
	}	
	else if (nTotal == 2)
	{
		FeatAdd(oPC, 2144 , FALSE, FALSE, FALSE); //+2
		FeatAdd(oPC, 2143 , FALSE, FALSE, FALSE); //+1			
	}	
	else if (nTotal == 1)
	{
		FeatAdd(oPC, 2143 , FALSE, FALSE, FALSE); //+1	
	}					
		
}

void StackBardicUses(object oPC)
{

	int nBardicUses =  GetBardicClassLevelForUses(oPC);
	
	if (nBardicUses > 20)
		nBardicUses = 20;
		
	//1 = 257 No need to add 1 use, no bardic prc can be taken without Bard levels
	//2-20 = 355 - 373
	int nMax = nBardicUses - 1 + 355;
	int iFeatCurrent;
	
	if (nMax == 0)
		return;
		
	for (iFeatCurrent = 355; iFeatCurrent< nMax; iFeatCurrent++)
	{
		FeatAdd(oPC, iFeatCurrent,FALSE);
	}		

}

void StackBardMusicUses(object oPC)
{

	int nBard = GetLevelByClass(CLASS_TYPE_BARD, oPC);
	int nBardLevel =  GetBardicClassLevelForSongs(oPC);
	
/*
2 - 1467
3 - 1475
5 - 1468
6 - 1476
7 - 1469
8 - 1470
9 - 1477
11 - 1471
12 - 1478
14 - 1472
15 - 1479
18 - 1480	
*/
	
	if (nBardLevel > nBard)
	{
		if (nBardLevel > 17)
		{
			if (!GetHasFeat(1480, oPC, TRUE))
				FeatAdd(oPC, 1480, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1479, oPC, TRUE))
				FeatAdd(oPC, 1479, FALSE, FALSE, FALSE);	
			if (!GetHasFeat(1472, oPC, TRUE))
				FeatAdd(oPC, 1472, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1478, oPC, TRUE))
				FeatAdd(oPC, 1478, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1471, oPC, TRUE))
				FeatAdd(oPC, 1471, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1477, oPC, TRUE))
				FeatAdd(oPC, 1477, FALSE, FALSE, FALSE);														
			if (!GetHasFeat(1470, oPC, TRUE))
				FeatAdd(oPC, 1470, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);																																	
				
		} else
		if (nBardLevel > 14)
		{
			if (!GetHasFeat(1479, oPC, TRUE))
				FeatAdd(oPC, 1479, FALSE, FALSE, FALSE);	
			if (!GetHasFeat(1472, oPC, TRUE))
				FeatAdd(oPC, 1472, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1478, oPC, TRUE))
				FeatAdd(oPC, 1478, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1471, oPC, TRUE))
				FeatAdd(oPC, 1471, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1477, oPC, TRUE))
				FeatAdd(oPC, 1477, FALSE, FALSE, FALSE);														
			if (!GetHasFeat(1470, oPC, TRUE))
				FeatAdd(oPC, 1470, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else
		if (nBardLevel > 13)
		{
			if (!GetHasFeat(1472, oPC, TRUE))
				FeatAdd(oPC, 1472, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1478, oPC, TRUE))
				FeatAdd(oPC, 1478, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1471, oPC, TRUE))
				FeatAdd(oPC, 1471, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1477, oPC, TRUE))
				FeatAdd(oPC, 1477, FALSE, FALSE, FALSE);														
			if (!GetHasFeat(1470, oPC, TRUE))
				FeatAdd(oPC, 1470, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else		
		if (nBardLevel > 11)
		{
			if (!GetHasFeat(1478, oPC, TRUE))
				FeatAdd(oPC, 1478, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1471, oPC, TRUE))
				FeatAdd(oPC, 1471, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1477, oPC, TRUE))
				FeatAdd(oPC, 1477, FALSE, FALSE, FALSE);														
			if (!GetHasFeat(1470, oPC, TRUE))
				FeatAdd(oPC, 1470, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else
		if (nBardLevel > 10)
		{
			if (!GetHasFeat(1471, oPC, TRUE))
				FeatAdd(oPC, 1471, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1477, oPC, TRUE))
				FeatAdd(oPC, 1477, FALSE, FALSE, FALSE);														
			if (!GetHasFeat(1470, oPC, TRUE))
				FeatAdd(oPC, 1470, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else
		if (nBardLevel > 8)
		{
			if (!GetHasFeat(1477, oPC, TRUE))
				FeatAdd(oPC, 1477, FALSE, FALSE, FALSE);														
			if (!GetHasFeat(1470, oPC, TRUE))
				FeatAdd(oPC, 1470, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);		
		} else
		if (nBardLevel > 7)
		{
			if (!GetHasFeat(1470, oPC, TRUE))
				FeatAdd(oPC, 1470, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else							
		if (nBardLevel > 6)
		{
			if (!GetHasFeat(1469, oPC, TRUE))
				FeatAdd(oPC, 1469, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else		
		if (nBardLevel > 5)
		{
			if (!GetHasFeat(1476, oPC, TRUE))
				FeatAdd(oPC, 1476, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else		
		if (nBardLevel > 4)
		{
			if (!GetHasFeat(1468, oPC, TRUE))
				FeatAdd(oPC, 1468, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else	
		if (nBardLevel > 2)
		{
			if (!GetHasFeat(1475, oPC, TRUE))
				FeatAdd(oPC, 1475, FALSE, FALSE, FALSE);
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		} else	
		if (nBardLevel > 2)
		{
			if (!GetHasFeat(1467, oPC, TRUE))
				FeatAdd(oPC, 1467, FALSE, FALSE, FALSE);	
		}						
	}		

}


int GetDruidWildShapeUses(int nDruid, object oPC)
{	
	int nCount=0;

	if (nDruid > 29)
		nCount = 9;
	else
	if (nDruid > 25)
		nCount = 8;
	else
	if (nDruid > 21)
		nCount = 7;
	else	
	if (nDruid > 17)
		nCount = 6;
	else
	if (nDruid > 13)
		nCount = 5;
	else
	if (nDruid > 9)
		nCount = 4;
	else
	if (nDruid > 6)
		nCount = 3;
	else
	if (nDruid == 6)
		nCount = 2;
	else
	if (nDruid== 5)
		nCount = 1;
		
	return nCount;
					
}

void StackWildshapeUses (object oPC)
{
	int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
	int nLionTalisid = GetLevelByClass(CLASS_LION_TALISID, oPC) - 2;
	int nNaturesWarrior = GetLevelByClass(CLASS_NATURES_WARRIOR, oPC);
	int nDaggerShaper = GetLevelByClass(CLASS_DAGGERSPELL_SHAPER, oPC);
	
	if (nLionTalisid < 0)
		nLionTalisid = 0;
			
	int nTotal = nDruid + nLionTalisid + nNaturesWarrior; //Total Druid level for shapes
	int nCount = GetDruidWildShapeUses(nTotal, oPC);
	nCount += ((nDaggerShaper + 2)/3);
		
	//Wild Shapes	
	if (nCount > 13)
		nCount = 13;
		
	if (nCount > 9)
	{
		int n;
		//Add 10-13
		for (n = 9; n < nCount; n++)
		{
			if (!GetHasFeat(3162+n, oPC, TRUE))
				FeatAdd(oPC,3162+n,FALSE);			
		}		
	
	}
	if (nCount > 6)
	{
		int n;
		//Add 7-9
		for (n = 6; n < nCount; n++)
		{
			if (!GetHasFeat(1925+n, oPC, TRUE))
				FeatAdd(oPC,1925+n,FALSE);			
		}		
	}
	if (nCount > 1)
	{
		int n;
		//Add 2-6
		for (n = 1; n < nCount; n++)
		{
			if (!GetHasFeat(334+n, oPC, TRUE))
				FeatAdd(oPC,334+n,FALSE);			
		}
		
	}
	if (nCount > 0)
	{
		//Add 1
		if (!GetHasFeat(305, oPC, TRUE))
			FeatAdd(oPC,305,FALSE);
	}
	
	//Elemental Shapes
	if (nTotal > 19)
	{
		if (!GetHasFeat(341, oPC, TRUE))
			FeatAdd(oPC,341,FALSE);							
	}
	if (nTotal > 17)
	{
		if (!GetHasFeat(340, oPC, TRUE))
			FeatAdd(oPC,340,FALSE);	
	}
	if (nTotal > 15)
	{
		if (!GetHasFeat(304, oPC, TRUE))
			FeatAdd(oPC,304,FALSE);	
	}
	
	//Plant Shape
	if (nTotal > 11)
	{
		if (!GetHasFeat(2111, oPC, TRUE))
			FeatAdd(oPC,2111,FALSE);	
	}
	
}

effect GetSwiftbladeSurgeEffect(object oPC)
{

	int nSwiftblade = GetLevelByClass(CLASS_SWIFTBLADE, oPC);
	int nBonus;
	int nDamageBonus=0;
		
	if (nSwiftblade == 10)
	{
		nBonus = 2;		
		nDamageBonus = DAMAGE_BONUS_2d6;

	}
	else	
	if (nSwiftblade > 6)
	{
		nBonus = 2;
		nDamageBonus = DAMAGE_BONUS_1d6;
	}
	else
		nBonus = 1;
	
	effect eAtk = EffectAttackIncrease(nBonus);
	effect eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nBonus, SAVING_THROW_TYPE_ALL);
	effect eAC = EffectACIncrease(nBonus, AC_DODGE_BONUS);
	
	effect eLink = EffectLinkEffects(eReflex, eAtk);
	eLink = EffectLinkEffects(eLink, eAC);

	if (nDamageBonus != 0)
	{
		effect eDmg = EffectDamageIncrease(nDamageBonus, DAMAGE_TYPE_PIERCING);
		eLink = EffectLinkEffects(eLink, eDmg);		
	}
	
	return eLink;

}

float GetSwiftbladeHasteDuration(int nSwiftblade, float fDuration)
{
	if (nSwiftblade > 8)
		fDuration *= 3;
	else
	if (nSwiftblade > 2)
		fDuration *= 2;
		
	return fDuration;
}

effect GetSwiftbladeHasteEffect (int nSwiftblade, effect eLink)
{
		switch (nSwiftblade)
		{
			case 2:
			{
				effect eConceal = EffectConcealment(20);
				eLink = EffectLinkEffects(eConceal, eLink);
			}
			break;	
										
			case 3:
			{
				effect eConceal = EffectConcealment(30);
				eLink = EffectLinkEffects(eConceal, eLink);
			}
			break;	
										
			case 4:
			{
				effect eConceal = EffectConcealment(40);
				eLink = EffectLinkEffects(eConceal, eLink);									
			}
			break;	
										
			case 5:
			{
				effect eConceal = EffectConcealment(50);
				eLink = EffectLinkEffects(eConceal, eLink);
				effect eSR = EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
				eLink = EffectLinkEffects(eSR, eLink);													
			}	
			break;							
				
			case 6:
			{
				effect eConceal = EffectConcealment(50);
				eLink = EffectLinkEffects(eConceal, eLink);
				effect eSR = EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
				eLink = EffectLinkEffects(eSR, eLink);						
				eLink = SupernaturalEffect(eLink);								
			}
			break;	
										
			case 7:
			{
				effect eConceal = EffectConcealment(50);
				eLink = EffectLinkEffects(eConceal, eLink);
				effect eSR = EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
				eLink = EffectLinkEffects(eSR, eLink);						
				eLink = SupernaturalEffect(eLink);													
			}
			break;	
										
			case 8:
			{
				effect eConceal = EffectConcealment(50);
				eLink = EffectLinkEffects(eConceal, eLink);
				effect eSR = EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
				eLink = EffectLinkEffects(eSR, eLink);
			    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
			    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
			    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
			    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
			    eLink = EffectLinkEffects(eLink, eParal);
			    eLink = EffectLinkEffects(eLink, eEntangle);		
			    eLink = EffectLinkEffects(eLink, eSlow);
			    eLink = EffectLinkEffects(eLink, eMove);								
				eLink = SupernaturalEffect(eLink);														
			}
			break;	
										
			case 9:
			{
				effect eConceal = EffectConcealment(50);
				eLink = EffectLinkEffects(eConceal, eLink);
				effect eSR = EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
				eLink = EffectLinkEffects(eSR, eLink);
			    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
			    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
			    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
			    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
			    eLink = EffectLinkEffects(eLink, eParal);
			    eLink = EffectLinkEffects(eLink, eEntangle);		
			    eLink = EffectLinkEffects(eLink, eSlow);
			    eLink = EffectLinkEffects(eLink, eMove);									
				eLink = SupernaturalEffect(eLink);													
			}	
			break;	
										
			case 10:
			{
				effect eConceal = EffectConcealment(50);
				eLink = EffectLinkEffects(eConceal, eLink);
				effect eSR = EffectSpellResistanceIncrease(10 + GetHitDice(OBJECT_SELF));
				eLink = EffectLinkEffects(eSR, eLink);	
			    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
			    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
			    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
			    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
			    eLink = EffectLinkEffects(eLink, eParal);
			    eLink = EffectLinkEffects(eLink, eEntangle);		
			    eLink = EffectLinkEffects(eLink, eSlow);
			    eLink = EffectLinkEffects(eLink, eMove);							
				eLink = SupernaturalEffect(eLink);													
			}																
			break;			

		}
		
		return eLink;
}

int isRangedWeaponEquipped(object oPC)
{

    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
	if	(GetIsObjectValid(oWeapon) && GetWeaponRanged(oWeapon))
		return TRUE;
	else
		return FALSE;
}

void EvaluateRWM()
{
		object oPC = OBJECT_SELF;
	
		int nSpellId = SPELLABILITY_Ranged_Weapon_Mastery;		
		int bRWMStateValid = isRangedWeaponEquipped(oPC);
		//SendMessageToPC(oPC,"TempStateValid: "+IntToString(bTempestStateValid));
		int bHasRWM = GetHasSpellEffect(nSpellId,oPC);
		RemoveSpellEffects(nSpellId, oPC, oPC);
		if (bRWMStateValid)
		{
					effect eAB = SupernaturalEffect(EffectAttackIncrease(2));
					effect eDmg = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_PIERCING));
					effect eLink = SupernaturalEffect(EffectLinkEffects(eAB,eDmg));
					eLink = SetEffectSpellId(eLink,nSpellId);
					
					if (!bHasRWM)
						SendMessageToPC(oPC,"Ranged Weapon Mastery enabled.");			
				    DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48)));			
		}
		else
		{
			if (bHasRWM)
				SendMessageToPC(oPC,"Ranged Weapon Mastery disabled, it is only valid when wielding a ranged weapon.");			
		}		
}

int GetDCBonusByLevel(object oPC)
{
	int nDCBonus = 0;
		
	int nLevel = GetHitDice(oPC);
	if (nLevel > 28) //29
		nDCBonus += 3;
	else
	if (nLevel > 25) //26
		nDCBonus += 2;
	else
	if (nLevel > 22) //23
		nDCBonus += 1;
		
	if (GetHasFeat(1114, oPC)) //Spellcasting Prodigy
		nDCBonus += 1;
		
	return nDCBonus;
}

int GetReserveSpellSaveDC(int nSpellLevel, object oCaster)
{

	int nDC = 10;
	
	nDC += GetDCBonusByLevel(oCaster);	
	nDC += nSpellLevel;	
	
	int nTemp = 0;
	int nInt = 0; //10,30
	nTemp += GetLevelByClass(10,oCaster);
	nTemp += GetLevelByClass(30,oCaster);
	nInt = nTemp;	

	nTemp = 0;			
	int nCha= 0; //1,9
	nTemp += GetLevelByClass(1,oCaster);
	nTemp += GetLevelByClass(9,oCaster);
	nCha = nTemp;

	nTemp = 0;					
	int nWis= 0; //2,3,6,7,31
	nTemp += GetLevelByClass(2,oCaster);
	nTemp += GetLevelByClass(3,oCaster);
	nTemp += GetLevelByClass(6,oCaster);
	nTemp += GetLevelByClass(7,oCaster);
	nTemp += GetLevelByClass(31,oCaster);
	nWis = nTemp;
	
	int nType = 0;	
	if (nInt > nCha)
	{	
		if (nInt > nWis)
		{
			nDC += GetAbilityModifier(ABILITY_INTELLIGENCE, oCaster);
		}
		else
		{
			nDC +=  GetAbilityModifier(ABILITY_WISDOM, oCaster);
		}
	}
	else
	{
		if (nCha > nWis)
		{
			nDC +=  GetAbilityModifier(ABILITY_CHARISMA, oCaster);	
		}
		else
		{
			nDC +=  GetAbilityModifier(ABILITY_WISDOM, oCaster);			
		}	
	}
	
	
	return nDC;
	
}

int GetStormSongCasterLevel(object oPC)
{
	int nCasterLevel = 0;
	if (GetLevelByClass(CLASS_STORMSINGER, oPC) > 1)
		nCasterLevel += 2;
	nCasterLevel += GetSkillRank(SKILL_PERFORM,oPC);
	return nCasterLevel;	
	
}

int IsModuleSupported(int LoadOptions)
{

	
	//int nCMI_Supported = GetLocalInt(GetModule(), "CMI_Supported");
	int nLoadCMIOptions = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_LoadCMIOptions));	
	
	if	(LoadOptions == 0 && nLoadCMIOptions == 0)
		return TRUE;
	else  
	{		
		int nPaladinFullCaster = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_PaladinFullCaster));	
		SetLocalInt(GetModule(), "PaladinFullCaster", nPaladinFullCaster);
		
		int nSneakAttackSpells = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells));	
		SetLocalInt(GetModule(), "SneakAttackSpells", nSneakAttackSpells);
		
		int nTouchofHealingUse50PercentCap = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_TouchofHealingUse50PercentCap));	
		SetLocalInt(GetModule(), "TouchofHealingUse50PercentCap", nTouchofHealingUse50PercentCap);

		int nTouchofHealingUseAugmentHealing = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_TouchofHealingUseAugmentHealing));	
		SetLocalInt(GetModule(), "TouchofHealingUseAugmentHealing", nTouchofHealingUseAugmentHealing);

		int nUseAlternateTurnUndeadRules = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UseAlternateTurnUndeadRules));	
		SetLocalInt(GetModule(), "UseAlternateTurnUndeadRules", nUseAlternateTurnUndeadRules);

		int nPaladinOnlyAlternateTurnUndeadRule = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_PaladinOnlyAlternateTurnUndeadRule));	
		SetLocalInt(GetModule(), "PaladinOnlyAlternateTurnUndeadRule", nPaladinOnlyAlternateTurnUndeadRule);
				
		int nAmmoStacksToCreate = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_AmmoStacksToCreate));	
		SetLocalInt(GetModule(), "AmmoStacksToCreate", nAmmoStacksToCreate);
					
		int nTempestStackWithRanger = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_TempestStackWithRanger));	
		SetLocalInt(GetModule(), "TempestStackWithRanger", nTempestStackWithRanger);	
	
		int nElaborateParry = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_ElaborateParry));	
		SetLocalInt(GetModule(), "ElaborateParry", nElaborateParry);
		
		int nUseSacredFistFix = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UseSacredFistFix));	
		SetLocalInt(GetModule(), "UseSacredFistFix", nUseSacredFistFix);
		
		int nUseTwoWpnDefense = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UseTwoWpnDefense));	
		SetLocalInt(GetModule(), "UseTwoWpnDefense", nUseTwoWpnDefense);
		
		int nHolyWarriorCap = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_HolyWarriorCap));	
		SetLocalInt(GetModule(), "HolyWarriorCap", nHolyWarriorCap);	
		
		int nStormlord24HrBuffDuration = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_Stormlord24HrBuffDuration));	
		SetLocalInt(GetModule(), "Stormlord24HrBuffDuration", nStormlord24HrBuffDuration);										

		int nArcaneShapesCanCast = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_ArcaneShapesCanCast));	
		SetLocalInt(GetModule(), "ArcaneShapesCanCast", nArcaneShapesCanCast);	
	
		int nUnarmedPolymorphFeatFix = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UnarmedPolymorphFeatFix));	
		SetLocalInt(GetModule(), "UnarmedPolymorphFeatFix", nUnarmedPolymorphFeatFix);	
		
		int nDaringOutlawCap = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_DaringOutlawCap));	
		SetLocalInt(GetModule(), "DaringOutlawCap", nDaringOutlawCap);			
		
		int nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_DivChampSpellcastingProgression));	
		SetLocalInt(GetModule(), "DivChampSpellcastingProgression", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_EldGlaiveAttackCap));	
		SetLocalInt(GetModule(), "EldGlaiveAttackCap", nValue);																			
		//nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_EldGlaiveAllowEldMastery));	
		//SetLocalInt(GetModule(), "EldGlaiveAllowEldMastery", nValue);
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_EldGlaiveAllowEssence));	
		SetLocalInt(GetModule(), "EldGlaiveAllowEssence", nValue);
		//nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_EldGlaiveAllowCrits));	
		//SetLocalInt(GetModule(), "EldGlaiveAllowCrits", nValue);
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_EldGlaiveAllowHasteBoost));	
		SetLocalInt(GetModule(), "EldGlaiveAllowHasteBoost", nValue);
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_HealingHymnCap));	
		SetLocalInt(GetModule(), "HealingHymnCap", nValue);
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_CrossbowSniper50PercentDexCap));	
		SetLocalInt(GetModule(), "CrossbowSniper50PercentDexCap", nValue);														
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_WintersBlastUsesPiercingCold));	
		SetLocalInt(GetModule(), "WintersBlastUsesPiercingCold", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UseSRFix));	
		SetLocalInt(GetModule(), "UseSRFix", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UseDmgResFix));	
		SetLocalInt(GetModule(), "UseDmgResFix", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UseEnhancedBGPet));	
		SetLocalInt(GetModule(), "UseEnhancedBGPet", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UseWildshapeTiers));	
		SetLocalInt(GetModule(), "UseWildshapeTiers", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_FangLineExceeds20));	
		SetLocalInt(GetModule(), "FangLineExceeds20", nValue);					
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SpellSpecAdds1PerDie));	
		SetLocalInt(GetModule(), "SpellSpecAdds1PerDie", nValue);			
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SonicMightAffectsClapofThunder));	
		SetLocalInt(GetModule(), "SonicMightAffectsClapofThunder", nValue);			
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_ArcaneShapesUseWildshapeFixes));	
		SetLocalInt(GetModule(), "ArcaneShapesUseWildshapeFixes", nValue);			
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_UnlimitedWildshapeUses));	
		SetLocalInt(GetModule(), "UnlimitedWildshapeUses", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_FrostMageArmorStacks));	
		SetLocalInt(GetModule(), "FrostMageArmorStacks", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_EnableReserveMeta));	
		SetLocalInt(GetModule(), "EnableReserveMeta", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_FreeEmberGuard));	
		SetLocalInt(GetModule(), "FreeEmberGuard", nValue);	
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_PlanetouchedGetMartialWeaponProf));	
		SetLocalInt(GetModule(), "PlanetouchedGetMartialWeaponProf", nValue);																											
		//SetLocalInt(GetModule(), "CMI_Supported", 5);
		nValue = StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_GrantSerenasCoin));	
		SetLocalInt(GetModule(), "GrantSerenasCoin", nValue);				
		return TRUE;
	}
		
}

int IsXbowSniperValid()
{
    object oWeapon    = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	if	(GetIsObjectValid(oWeapon))
	{
		if (IPGetIsRangedWeapon(oWeapon))
		{
			int nBaseItemType = GetBaseItemType(oWeapon);
			if (nBaseItemType == BASE_ITEM_LIGHTCROSSBOW)
			{
				if (GetHasFeat(93,OBJECT_SELF,TRUE))
					return TRUE;
				else
					return FALSE;
			}
			else
			if (nBaseItemType == BASE_ITEM_HEAVYCROSSBOW)
			{
				if (GetHasFeat(92,OBJECT_SELF,TRUE))
					return TRUE;
				else
					return FALSE;			
			}
			else 
				return FALSE;			
		}
		else
			return FALSE;

	}
	return FALSE;	
}

int IsBladesingerValid()
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oWeapon2    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
		
	if	(GetIsObjectValid(oWeapon))
	{
		int nBaseItemType = GetBaseItemType(oWeapon);	
		
		if (nBaseItemType != BASE_ITEM_RAPIER)
		{
			if (nBaseItemType != BASE_ITEM_LONGSWORD)
			{
				if (nBaseItemType != BASE_ITEM_ALLUSE_SWORD)
					return FALSE;
			}
		}	
		
	}
	else
		return FALSE;
	
	if	(GetIsObjectValid(oWeapon2))
	{
		if (IPGetIsMeleeWeapon(oWeapon2) || IPGetIsRangedWeapon(oWeapon2))
			return FALSE;
		int nBaseItemType = GetBaseItemType(oWeapon2);		
	    if (nBaseItemType == BASE_ITEM_LARGESHIELD ||
	    		nBaseItemType == BASE_ITEM_SMALLSHIELD ||
	    		nBaseItemType == BASE_ITEM_TOWERSHIELD)
			return FALSE;
	}	
	
	if ( GetIsObjectValid(oArmor))
	{
		if ((GetArmorRank(oArmor) == ARMOR_RANK_HEAVY)  || (GetArmorRank(oArmor) ==  ARMOR_RANK_MEDIUM))
		{
			return FALSE;
		}	
	}
					
	return TRUE;

}

void StackDeathAttack(object oPC)
{
	int nAssassin = GetLevelByClass(30,oPC);
	int nAvenger = GetLevelByClass(CLASS_AVENGER,oPC);
	int nBFZ = GetLevelByClass(CLASS_BLACK_FLAME_ZEALOT,oPC);

	int nDice = 0;

	//Assassin/Avenger is 1,3,5,7,9,11,13,15,17,19
	//BFZ is 3,6,9
							
	if (nAssassin > 0)
	{
		nDice += ((nAssassin+1)/2);
	}
	if (nAvenger > 0)
	{
		nDice += ((nAvenger+1)/2);	
	}	
	
	if (nBFZ > 2)
	{
		if (nBFZ > 8)
			nDice += 3;
		else if (nBFZ > 5)
			nDice += 2;
		else
			nDice += 1;	
	}
	
	if (nDice > 20)
		nDice = 20;
	
	if (nDice > 0)
	{
		int iFeatCurrent=0;
		
		if (nDice > 8) // 9+
		{
			for (iFeatCurrent = 455; iFeatCurrent< 460; iFeatCurrent++)
			{
				FeatAdd(oPC, iFeatCurrent,FALSE);
			}
			FeatAdd(oPC, 1004,FALSE); //6	
			FeatAdd(oPC, 1005,FALSE); //7			
			FeatAdd(oPC, 1006,FALSE); //8
			
			int iFeatLast = 1019 + (nDice - 8);
			for (iFeatCurrent = 1019; iFeatCurrent< iFeatLast; iFeatCurrent++)
			{
				FeatAdd(oPC, iFeatCurrent,FALSE);
			}								
		}
		else if (nDice > 5) // 6-8
		{
			for (iFeatCurrent = 455; iFeatCurrent< 460; iFeatCurrent++)
			{
				FeatAdd(oPC, iFeatCurrent,FALSE);
			}
			if (nDice == 6)
			{
				FeatAdd(oPC, 1004,FALSE); //6
			}
			else if (nDice == 7)
			{
				FeatAdd(oPC, 1004,FALSE); //6	
				FeatAdd(oPC, 1005,FALSE); //7
			}
			else //8
			{
				FeatAdd(oPC, 1004,FALSE); //6	
				FeatAdd(oPC, 1005,FALSE); //7			
				FeatAdd(oPC, 1006,FALSE); //8
			}					
		}
		else //1-5
		{
			int iFeatLast = 455 + (nDice);
			for (iFeatCurrent = 455; iFeatCurrent< iFeatLast; iFeatCurrent++)
			{
				FeatAdd(oPC, iFeatCurrent,FALSE);
			}										
		}
	
	
	}
		
}

void CleanBadDice(object oPC, int iFeatLast, int nDice)
{
		int iFeatCurrent=0;	
		//iFeatLast = 1032 + (nDice - 10); 1037+
		int iFeatBadLast= 1032 + (nDice);
		for (iFeatCurrent = iFeatLast; iFeatCurrent< iFeatBadLast; iFeatCurrent++) //11-20
		{
			if (GetHasFeat(iFeatCurrent, oPC, TRUE))
				FeatRemove(oPC, iFeatCurrent);
		}	
}

void StackSneakAttack(object oPC)
{

											
	//SendMessageToPC(oPC,"StackSneakAttack");
	int nNightsongEnforcer = GetLevelByClass(CLASS_NIGHTSONG_ENFORCER,oPC);
	int nNightsongInfiltrator = GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR,oPC);
	int nRogue = GetLevelByClass(8,oPC);
	int nDreadCommando = GetLevelByClass(CLASS_DREAD_COMMANDO,oPC);
	int nShadStalk = GetLevelByClass(CLASS_SHADOWBANE_STALKER,oPC);		
	int nWhirlDerv = GetLevelByClass(CLASS_WHIRLING_DERVISH, oPC);
	int nDarkLantern = GetLevelByClass(CLASS_DARK_LANTERN,oPC);
	int nSkullclanHunter = GetLevelByClass(CLASS_SKULLCLAN_HUNTER,oPC);
	int nThug = GetLevelByClass(CLASS_THUG,oPC);
	
	int nNinja = GetLevelByClass(CLASS_NINJA,oPC);
	int nGFK = GetLevelByClass(CLASS_GHOST_FACED_KILLER,oPC);
	int nDreadPirate = GetLevelByClass(CLASS_DREAD_PIRATE,oPC);
	int nDagMage = GetLevelByClass(CLASS_DAGGERSPELL_MAGE,oPC);
	int nDagShape = GetLevelByClass(CLASS_DAGGERSPELL_SHAPER,oPC);
	int nWildStlk = GetLevelByClass(CLASS_WILD_STALKER,oPC);
	int nScout = GetLevelByClass(CLASS_SCOUT,oPC);					
	
	if (GetHasFeat(FEAT_DARING_OUTLAW , oPC))
	{
		int nSwash = GetLevelByClass(CLASS_TYPE_SWASHBUCKLER,oPC);
		int nDaringOutlawCap = GetLocalInt(GetModule(), "DaringOutlawCap");	
		if (nDaringOutlawCap > 0)
		{
			if (nSwash > nDaringOutlawCap)
				nSwash = nDaringOutlawCap;
		}	
		nRogue += nSwash;
	}	

	int nDice = 0;
	
	//Rogue is 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29
	//NE is 1,4,7,10
	//NI is 4,8	
	//DL is 2,4,6,8,10
	//SH is 3,6,9
	
	int iFeatCurrent=0;	
	int iFeatLast=0;
	
	if (nNinja > 0)
	{
		nDice += ((nNinja+1)/2);
	}	
	if (nGFK > 1)
	{
		nDice += ((nGFK+1)/3);
	}		
	if (nDagMage > 2)
	{
		nDice += nDagMage/3;
	}	
	if (nDagShape > 2)
	{
		nDice += nDagShape/3;
	}	
	if (nWildStlk > 1)
	{
		nDice += ((nWildStlk+2)/4);
	}	
	if (nScout > 0)
	{
		if (GetHasFeat(FEAT_SWIFT_AMBUSHER , oPC))
			nDice += ((nScout+1)/2);
		else
		if (GetHasFeat(FEAT_SWIFT_HUNTER , oPC))
		{
			int nRanger = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
			nDice += ((nScout+nRanger+1)/2);
		}		
		else
			nDice += (1 + ((nScout - 1)/4));
	}									
	
	if (nShadStalk > 2)
	{
		nDice += nShadStalk/3;
	}		
	if (nWhirlDerv > 2)
	{
		nDice += nWhirlDerv/3;
	}	
	if (nDarkLantern > 1)
	{
		nDice += nDarkLantern/2;
	}	
	if (nSkullclanHunter > 2)
	{
		nDice += (nSkullclanHunter / 3 );
	}			
	if (nDreadCommando > 0)
	{
		nDice += ((nDreadCommando+1)/2);
	}	
	if (nThug > 0)
	{
		nDice += (nThug/2);
	}	
	if (nRogue > 0)
	{
		nDice += ((nRogue+1)/2);
	}
	if (nNightsongEnforcer > 0)
	{	
		nDice += ( (nNightsongEnforcer+2) /3 );
	}	
	if (nNightsongInfiltrator > 3)
	{
		if (nNightsongInfiltrator > 7)
			nDice += 2;
		else
			nDice += 1;
	}	
	//SendMessageToPC(oPC,IntToString(nDice));		
	//1 is 221
	//2-10 is 345-353
	//11-20 is 1032-1041
	
	if (nDice > 20)
		nDice = 20;
	
	if (nDice > 10) //11-20
	{

		iFeatLast = 1032 + (nDice - 10);
		
		CleanBadDice(oPC, iFeatLast, nDice);			
		
		FeatAdd(oPC, 221,FALSE); //1
		for (iFeatCurrent = 345; iFeatCurrent< 354; iFeatCurrent++) //2-10
		{
			FeatAdd(oPC, iFeatCurrent,FALSE);
		}						
		for (iFeatCurrent = 1032; iFeatCurrent< iFeatLast; iFeatCurrent++) //11-20
		{
			FeatAdd(oPC, iFeatCurrent,FALSE);
		}	
	}
	else if (nDice > 1) // 2-10
	{
		iFeatLast = 345 + (nDice - 1);
		
		FeatAdd(oPC, 221,FALSE); //1			
		for (iFeatCurrent = 345; iFeatCurrent< iFeatLast; iFeatCurrent++) //2-10
		{
			FeatAdd(oPC, iFeatCurrent,FALSE);
		}	

	}
	else if (nDice == 1) //1
	{
		FeatAdd(oPC, 221,FALSE); //1	
	}	
}

int GetAbilityScoreByAbility(object oPC, int Ability)
{
	string ColumnName = "";

	if (Ability == 0) //Str
		ColumnName = "StrAdjust";
	else				
	if (Ability == 1)  //Dex
		ColumnName = "DexAdjust";
	else
	if (Ability == 2) //Con
		ColumnName = "ConAdjust";
	else
	if (Ability == 3) //Int
		ColumnName = "IntAdjust";
	else
	if (Ability == 4) //Wis
		ColumnName = "WisAdjust";
	else
	if (Ability == 5) //Cha
		ColumnName = "ChaAdjust";
		
	int nSubRace = GetSubRace(oPC);			
	string sVal = Get2DAString("racialsubtypes",ColumnName,nSubRace);
									
	int nScore = GetAbilityScore(oPC,Ability,TRUE);
	nScore = nScore + StringToInt(sVal);
	
	if (GetHasFeat(FEAT_SPELLCASTING_PRODIGY,oPC))
		nScore += 2;
	
	return nScore;
}

int GetAbilitySpellBonusByLevel(object oPC, int Spell_Level, int AbilityScore)
{
	
	string ColumnName = ("L" + IntToString(Spell_Level));
	string sBonus = Get2DAString("cmi_spellbonus",ColumnName,AbilityScore);	

	return StringToInt(sBonus);
}

void AddBGFeats(object oPC)
{

			int nAbilityScore = GetAbilityScoreByAbility(oPC, ABILITY_WISDOM);
			int nBonus1 = GetAbilitySpellBonusByLevel(oPC,1,nAbilityScore);
			int nBonus2 = GetAbilitySpellBonusByLevel(oPC,2,nAbilityScore);
			int nBonus3 = GetAbilitySpellBonusByLevel(oPC,3,nAbilityScore);
			int nBonus4 = GetAbilitySpellBonusByLevel(oPC,4,nAbilityScore);
			
			int iCount1=0;
			int iCount2=0;
			int iCount3=0;
			int iCount4=0;			
			int iCurrent=0;
			int iFeat=0;
								
			int nLevel = GetLevelByClass(31,oPC);	
			
			int nKoT = GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oPC);
			int nDrSlr = GetLevelByClass(CLASS_DRAGONSLAYER, oPC);
			int nChildNight = GetLevelByClass(CLASS_CHILD_NIGHT, oPC);
			if (nKoT > 0 && GetHasFeat(FEAT_KOT_SPELLCASTING_BLACKGUARD, oPC))
				nLevel += nKoT;
			if (nChildNight > 0 && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_BLACKGUARD, oPC))
				nLevel += nChildNight;				
			if (nDrSlr > 0 && GetHasFeat(FEAT_DRSLR_SPELLCASTING_BLACKGUARD, oPC))
				nLevel += nDrSlr / 2;				
			if (nLevel > 10)
				nLevel = 10;
			
			switch (nLevel)
			{
					
			case 1:
				{

					iCount1 = 0 + nBonus1;
					iCount2 = -10 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
				
					
				case 2:
				{

					iCount1 = 1 + nBonus1;
					iCount2 = -10 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
				
				case 3:
				{

					iCount1 = 1 + nBonus1;
					iCount2 = 0 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
		
				case 4:
				{

					iCount1 = 1 + nBonus1;
					iCount2 = 1 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
				
				case 5:
				{

					iCount1 = 1 + nBonus1;
					iCount2 = 1 + nBonus2;
					iCount3 = 0 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
				
				case 6:
				{

					iCount1 = 1 + nBonus1;
					iCount2 = 1 + nBonus2;
					iCount3 = 1 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
				
				case 7:
				{

					iCount1 = 2 + nBonus1;
					iCount2 = 1 + nBonus2;
					iCount3 = 1 + nBonus3;
					iCount4 = 0 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;				
				
				case 8:
				{

					iCount1 = 2 + nBonus1;
					iCount2 = 1 + nBonus2;
					iCount3 = 1 + nBonus3;
					iCount4 = 1 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
								
				case 9:
				{

					iCount1 = 2 + nBonus1;
					iCount2 = 2 + nBonus2;
					iCount3 = 1 + nBonus3;
					iCount4 = 1 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;				
																	
				case 10:
				{

					iCount1 = 2 + nBonus1;
					iCount2 = 2 + nBonus2;
					iCount3 = 2 + nBonus3;
					iCount4 = 1 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3011;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3016;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3021;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3025;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;				
																	
				default:
				break;			
			
			
			}
			
												
													
}

void AddASNFeats(object oPC)
{

			int nAbilityScore = GetAbilityScoreByAbility(oPC, ABILITY_INTELLIGENCE);
			int nBonus1 = GetAbilitySpellBonusByLevel(oPC,1,nAbilityScore);
			int nBonus2 = GetAbilitySpellBonusByLevel(oPC,2,nAbilityScore);
			int nBonus3 = GetAbilitySpellBonusByLevel(oPC,3,nAbilityScore);
			int nBonus4 = GetAbilitySpellBonusByLevel(oPC,4,nAbilityScore);
			
			int iCount1=0;
			int iCount2=0;
			int iCount3=0;
			int iCount4=0;			
			int iCurrent=0;
			int iFeat=0;
								
			int nLevel = GetLevelByClass(30,oPC);
			int nLevel2 = GetLevelByClass(142,oPC);
			
			int nKoT = GetLevelByClass(CLASS_KNIGHT_TIERDRIAL, oPC);
			int nDrSlr = GetLevelByClass(CLASS_DRAGONSLAYER, oPC);
			int nChildNight = GetLevelByClass(CLASS_DRAGONSLAYER, oPC);
			
			if (nChildNight > 0 && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_ASSASSIN, oPC))
				nLevel += nChildNight;
			else
			if (nChildNight > 0 && GetHasFeat(FEAT_CHLDNIGHT_SPELLCASTING_AVENGER, oPC))
				nLevel2 += nChildNight;
							
			if (nKoT > 0 && GetHasFeat(FEAT_KOT_SPELLCASTING_ASSASSIN, oPC))
				nLevel += nKoT;
			else
			if (nKoT > 0 && GetHasFeat(FEAT_KOT_SPELLCASTING_AVENGER, oPC))
				nLevel2 += nKoT;
				
			if (nDrSlr > 0 && GetHasFeat(FEAT_DRSLR_SPELLCASTING_ASSASSIN, oPC))
				nLevel += nDrSlr / 2;
			else
			if (nDrSlr > 0 && GetHasFeat(FEAT_DRSLR_SPELLCASTING_AVENGER, oPC))
				nLevel2 += nDrSlr / 2;
								
								
			if (nLevel2 > nLevel)
				nLevel = nLevel2;
			//Only use the higher of the two, they shouldn't be on the same character
			
			if (nLevel > 10)
				nLevel = 10;
									
			switch (nLevel)
			{
			
						
			case 1:
				{

					iCount1 = 0 + nBonus1;
					iCount2 = -10 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3045;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
				
					
				case 2:
				{

					iCount1 = 1 + nBonus1;
					iCount2 = -10 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3045;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}															
					
				}
				break;
				
				case 3:
				{

					iCount1 = 2 + nBonus1;
					iCount2 = 0 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3045;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}						
					
				}
				break;
		
				case 4:
				{

					iCount1 = 3 + nBonus1;
					iCount2 = 1 + nBonus2;
					iCount3 = -10 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3045;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}					
				}
				break;
				
				case 5:
				{

					iCount1 = 3 + nBonus1;
					iCount2 = 2 + nBonus2;
					iCount3 = 0 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3045;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}					
				}
				break;
				
				case 6:
				{

					iCount1 = 3 + nBonus1;
					iCount2 = 3 + nBonus2;
					iCount3 = 1 + nBonus3;
					iCount4 = -10 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3045;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}					
				}
				break;
				
				case 7:
				{

					iCount1 = 3 + nBonus1;
					iCount2 = 3 + nBonus2;
					iCount3 = 2 + nBonus3;
					iCount4 = 0 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3045;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}					
				}
				break;				
				
				case 8:
				{

					iCount1 = 3 + nBonus1;
					iCount2 = 3 + nBonus2;
					iCount3 = 3 + nBonus3;
					iCount4 = 1 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3046;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}					
				}
				break;
								
				case 9:
				{

					iCount1 = 3 + nBonus1;
					iCount2 = 3 + nBonus2;
					iCount3 = 3 + nBonus3;
					iCount4 = 2 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3046;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}					
				}
				break;				
																	
				case 10:
				{

					iCount1 = 3 + nBonus1;
					iCount2 = 3 + nBonus2;
					iCount3 = 3 + nBonus3;
					iCount4 = 3 + nBonus4;
					
					if (iCount1 > 0)
					{
						iCurrent=0;
						iFeat = 3028;
						for (iCurrent = 0; iCurrent < iCount1; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}	
					}
					if (iCount2 > 0)
					{
						iCurrent=0;
						iFeat = 3034;
						for (iCurrent = 0; iCurrent < iCount2; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount3 > 0)
					{
						iCurrent=0;
						iFeat = 3040;
						for (iCurrent = 0; iCurrent < iCount3; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}
					if (iCount4 > 0)
					{
						iCurrent=0;
						iFeat = 3046;
						for (iCurrent = 0; iCurrent < iCount4; iCurrent++)
						{
							FeatAdd(oPC,iFeat+iCurrent,FALSE);
						}						
					}					
				}
				break;				
																	
				default:
				break;			
			
			
			}												
													
}

int IsSnowflakeValid(object oPC, int bAllowTwoHanded = FALSE)
{

	object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
		
	int bArmor = FALSE;
	int nArmorRank = ARMOR_RANK_NONE;
 	if (GetIsObjectValid(oItem))
		nArmorRank = GetArmorRank(oItem);
	if (nArmorRank == ARMOR_RANK_NONE || nArmorRank == ARMOR_RANK_LIGHT)
		bArmor = TRUE;
	else
		bArmor = FALSE;	
		
	int bShield = FALSE;		
	oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);	
 	if (GetIsObjectValid(oItem))
	{
		int nBaseItemType = GetBaseItemType(oItem);
		if (nBaseItemType == BASE_ITEM_SMALLSHIELD || 
		nBaseItemType == BASE_ITEM_TOWERSHIELD ||
		nBaseItemType == BASE_ITEM_LARGESHIELD)
			bShield = TRUE;
	}
	int bSlashing = IsMWM_SValid();	
	
	if (bSlashing && (bAllowTwoHanded == FALSE))
	{
    	object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
		int nBaseItemType = GetBaseItemType(oWeapon);
		if (nBaseItemType == BASE_ITEM_SCYTHE || nBaseItemType == BASE_ITEM_HALBERD || nBaseItemType == BASE_ITEM_GREATSWORD  || nBaseItemType == BASE_ITEM_GREATAXE || nBaseItemType == BASE_ITEM_FALCHION)
			bSlashing = FALSE;		
	}
	
	if (bSlashing && !bShield && bArmor)
		return TRUE;
	else
		return FALSE;
}

/*
void ClearTempestFeatsv1(object oPC)
{
	if (GetHasFeat(2883,oPC,TRUE))
	{
		FeatRemove(oPC,2883);
	}
	if (GetHasFeat(2884,oPC,TRUE))
	{
		FeatRemove(oPC,2884);	
	}	
}

void ClearBFZFeatsv1(object oPC)
{
	if (GetHasFeat(2891,oPC,TRUE))  //Sacred Flame
	{
		FeatRemove(oPC,2891);
	}
	if (GetHasFeat(2893,oPC,TRUE)) // Zealous Heart
	{
		FeatRemove(oPC,2893);	
	}	
}

void ClearBGFeats_v1(object oPC)
{
			int bHasWidenAura = 0;
			int bHasImpAura = 0;
			
			//Remove the old feats
			int iFeat;
			for (iFeat=2869; iFeat<2883; iFeat++)
			{
				if (GetHasFeat(iFeat,oPC,TRUE))
					FeatRemove(oPC,iFeat);
			}
			if (GetHasFeat(476,oPC,TRUE))
				FeatRemove(oPC,476);
			if (GetHasFeat(477,oPC,TRUE))
				FeatRemove(oPC,477);
			if (GetHasFeat(478,oPC,TRUE))
				FeatRemove(oPC,478);
			if (GetHasFeat(479,oPC,TRUE))
				FeatRemove(oPC,479);
			if (GetHasFeat(479,oPC,TRUE))
				FeatRemove(oPC,479);
			if (GetHasFeat(479,oPC,TRUE))
				FeatRemove(oPC,479);	
			if (GetHasFeat(2924,oPC,TRUE))
			{
				FeatRemove(oPC,2924);
				bHasWidenAura = 1;			
			}
			if (GetHasFeat(2925,oPC,TRUE))
			{
				FeatRemove(oPC,2925);
				bHasImpAura = 1;			
			}
			
			//Add the new feats
			if (bHasWidenAura)
				FeatAdd(oPC,3052,FALSE);
			if (bHasImpAura)
				FeatAdd(oPC,3053,FALSE);	
}


void ClearASNFeats_v1(object oPC)
{
			//Remove the old feats
			int iFeat;
			for (iFeat=2861; iFeat<2869; iFeat++)
			{
				if (GetHasFeat(iFeat,oPC,TRUE))
					FeatRemove(oPC,iFeat);
			}
			for (iFeat=3028; iFeat<3052; iFeat++)
			{
				if (GetHasFeat(iFeat,oPC,TRUE))
					FeatRemove(oPC,iFeat);
			}			
			if (GetHasFeat(476,oPC,TRUE))
				FeatRemove(oPC,476);
			if (GetHasFeat(477,oPC,TRUE))
				FeatRemove(oPC,477);
			if (GetHasFeat(478,oPC,TRUE))
				FeatRemove(oPC,478);
			if (GetHasFeat(479,oPC,TRUE))
				FeatRemove(oPC,479);
			if (GetHasFeat(479,oPC,TRUE))
				FeatRemove(oPC,479);
			if (GetHasFeat(479,oPC,TRUE))
				FeatRemove(oPC,479);	
}


int RemapClericFeatsv1(object oPC)
{
		if ((GetLevelByClass(34,oPC) > 0) || (GetLevelByClass(37,oPC) > 0))	
		{
		
			int Count = 0;
			
			if (GetHasFeat(306,oPC,TRUE)) //
				Count++;				
			if (GetHasFeat(307,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(308,oPC,TRUE)) //
				Count++;			
			if (GetHasFeat(310,oPC,TRUE)) //
				Count++;			
			if (GetHasFeat(315,oPC,TRUE)) //
				Count++;			
			if (GetHasFeat(318,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(322,oPC,TRUE)) //
				Count++;							
			if (GetHasFeat(1834,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1835,oPC,TRUE)) //
				Count++;	
			if (GetHasFeat(1837,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1838,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1840,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1841,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1843,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1844,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1845,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1849,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1850,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(1852,oPC,TRUE)) //
				Count++;	
			if (GetHasFeat(2092,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(2093,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(2094,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(2095,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(2096,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(2097,oPC,TRUE)) //
				Count++;																																				
			if (GetHasFeat(2098,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(2099,oPC,TRUE)) //
				Count++;
			if (GetHasFeat(2100,oPC,TRUE)) //
				Count++;	
				
			if (Count != 2)	
			{	
				SetLocalInt(oPC,"cmi_DomainCount",Count);																																																																
				BeginConversation("c_Cleric_Domains",OBJECT_SELF);
				DeleteLocalInt(oPC,"cmi_domainCount");	
				return TRUE;																				
			}
			else
				return FALSE;
				
		}
		else
		{
			int nFeatStart;
			for (nFeatStart=2894; nFeatStart<2913; nFeatStart++)
			{
				if (GetHasFeat(nFeatStart,oPC,TRUE))
				{
					FeatRemove(oPC,nFeatStart);
					FeatAdd(oPC,(nFeatStart+164),FALSE);		
				}
			}	
			return FALSE;			
		}


}

*/