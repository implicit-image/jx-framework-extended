//::///////////////////////////////////////////////
//:: Misc Functions
//::///////////////////////////////////////////////
/*
This scrip contains everything from manditory class
functions to utility scripts.

I really should split this up; it has grown out of
controll.
*/
//::///////////////////////////////////////////////
//:: Created By: 2DruNk2Frag
//:: Created On: 01-10-2008
//:: Last Update: 01-26-2008
//::///////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_includes"
#include "x2_inc_itemprop"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

//::///////////////////////////////////////////////
//:: Constants
//::///////////////////////////////////////////////

//const int WEAPON_SIZE_TINY = 1;
//const int WEAPON_SIZE_SMALL = 2;
//const int WEAPON_SIZE_MEDIUM = 3;
//const int WEAPON_SIZE_LARGE = 4;

//::///////////////////////////////////////////////
//:: Functions Definitions
//::///////////////////////////////////////////////

//:: getMeleeWeaponSize - Determins weapon size.
//:: Isn't there a built in funxction for this?
int getMeleeWeaponSize(object oItem);

//:: getMeleeWeaponDamageType - returns damage type.
int getMeleeWeaponDamageType(object oItem);

//:: getMeleeWeaponDamage - returns weapon damage. Used for effectdamage
int getMeleeWeaponDamage(object oItem);

//:: isMoaWeaponValid - checks for dual wielding two-handed weapons
int isMoaWeaponValid(object oItem);

//:: numSplitUp - Rounds up.
int numSplitUp(int num);

//:: numSplitDown - Rounds down
int numSplitDown(int num);

//:: getMoaDamageBonus - Handles damage bonus if weapon tyoes differ
int getMoaDamageBonus();

//:: IsMoTAStateValid - Checks for dual wielding
int IsMoTAStateValid();

//:: EvaluateMoTA - The meat of The Man of Two Arms
void EvaluateMoTA();

//:: GetIPDamageBonus - Gets items damage bonus reference number
int GetIPDamageBonus(itemproperty ip, int nDamageBonus = ITEM_PROPERTY_DAMAGE_BONUS);

//:: GetDamageFromReferenceNumber - Gets Damage from Ip reference. used in effectdamage
int GetDamageFromReferenceNumber(int nNumber);

//:: convertIpDamTypeToEffectDamType - Used in effect damage
int convertIpDamTypeToEffectDamType(int number);

//:: evaluateDOTHF - Actually this activates Pummeling Strike
void evaluateDOTHF();

//:: DOTHFWithering - Main finction for Withering Strike
void DOTHFWithering();

//:: DOTHFIlluminating - Main Function for Illuminating Strike
void DOTHFIlluminating();

//:: DOTHFArcane - Main Function for Arcane Strike
void DOTHFArcane();

//:: isDOTHFUnarmed - Checks if unarmed... is this necessary?
int isDOTHFUnarmed();

//:: isDOTHFSwiftable - Checks Swiftness of Strikes requirements
int isDOTHFSwiftable();

//:: returnDOTHFUnarmedDamage - Wacky function for determining DotHF damage stacking with Monk
int returnDOTHFUnarmedDamage();

//:: unarmedDamageLevel - Used with returnDOTHFUnarmedDamage
int unarmedDamageLevel(int lvl);

//:: isMonkItem - checks if item is limited to monks. used in Stitching of Reclamation
int isMonkItem(object oItem);

//::///////////////////////////////////////////////
//:: Function Implementation
//::///////////////////////////////////////////////

int IsMoTAStateValid()
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oWeapon2    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);

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

    if  (GetIsObjectValid(oWeapon))
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
//::///////////////////////////////////////////////
void EvaluateMoTA()
{
        object oPC = OBJECT_SELF;

        int nSpellId = SPELL_SKILL_OF_ARMS;
        int nSpellId2 = SPELL_MIGHT_OF_ARMS;
        int bMoTAStateValid = IsMoTAStateValid();
        int bHasSOA = GetHasSpellEffect(nSpellId,oPC);
        int bHasMOA = GetHasSpellEffect(nSpellId2,oPC);
        if (bMoTAStateValid)
        {
            RemoveSpellEffects(nSpellId, oPC, oPC);
            RemoveSpellEffects(nSpellId2, oPC, oPC);

                    int nAB = 0;
                    int nLevel = GetLevelByClass(CLASS_MoTA,oPC);

                    int nDam;
                    int nDamType1;
                    int nDamType2;

                    if(nLevel <= 3)
                    {
                    nAB = 1;
                    }
                    else
                    {
                    nAB = ((nLevel-1)/3) + 1;
                    }

                    effect eAB = SupernaturalEffect(EffectAttackIncrease(nAB));

                    eAB = SetEffectSpellId(eAB,nSpellId);
                //  if (!bHasSOA)
                    SendMessageToPC(oPC,"Skill of Arms enabled.");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(48));


                    nDam = getMoaDamageBonus();
                    nDamType1 = getMeleeWeaponDamageType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF));
                    nDamType2 = getMeleeWeaponDamageType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF));

                    effect eDam1;
                    effect eDam2;
                    effect eLink;

                        if(nDamType1 == nDamType2)
                        {
                        eLink = SupernaturalEffect(EffectDamageIncrease(nDam, nDamType1));
                        }
                        else
                        {
                        eDam1 = EffectDamageIncrease(IPGetDamageBonusConstantFromNumber(numSplitUp(nDam)), nDamType1);
                        eDam2 = EffectDamageIncrease(IPGetDamageBonusConstantFromNumber(numSplitDown(nDam)), nDamType2);
                        eLink = EffectLinkEffects(eDam1, eDam2);
                        eLink = SupernaturalEffect(eLink);
                        }

                    eLink = SetEffectSpellId(eLink,nSpellId2);
                    //if (!bHasMOA)
                //  {
                    if(GetHasFeat(FEAT_MIGHT_OF_ARMS,oPC) == TRUE)
                    {
                    SendMessageToPC(oPC,"Might of Arms enabled.");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
                    }
        }
        else
        {
            RemoveSpellEffects(nSpellId, oPC, oPC);
            if (bHasSOA)
                SendMessageToPC(oPC,"Skill of Arms disabled, it is only valid when wielding two weapons.");

            RemoveSpellEffects(nSpellId2, oPC, oPC);
            if (bHasMOA)
                SendMessageToPC(oPC,"Might of Arms disabled, it is only valid when wielding two weapons.");
        }
}
//::///////////////////////////////////////////////
int getMeleeWeaponSize(object oItem)
{
int nBaseItem = GetBaseItemType(oItem);

    if(GetIsObjectValid(oItem) && IPGetIsMeleeWeapon(oItem))
    {

    int nWeaponSize =  ( StringToInt(Get2DAString("baseitems","WeaponSize",nBaseItem)));
        if(nWeaponSize == 1)
        {
        return WEAPON_SIZE_TINY;
        }
        else if(nWeaponSize == 2)
        {
        return WEAPON_SIZE_SMALL;
        }
        else if(nWeaponSize == 3)
        {
        return WEAPON_SIZE_MEDIUM;
        }
        else if(nWeaponSize == 4)
        {
        return WEAPON_SIZE_LARGE;
        }
        else
        {
        return FALSE;
        }
    }
    else
    {
    return FALSE;
    }
}
//::///////////////////////////////////////////////
int getMeleeWeaponDamageType(object oItem)
{
object oPC = OBJECT_SELF;
int nBaseItem = GetBaseItemType(oItem);

    if(GetIsObjectValid(oItem) && IPGetIsMeleeWeapon(oItem))
    {

    int nWeaponType =  ( StringToInt(Get2DAString("baseitems","WeaponType",nBaseItem)));
        if(nWeaponType == 3 || nWeaponType == 4)
        {
        return DAMAGE_TYPE_SLASHING;
        }
        else if(nWeaponType == 2)
        {
        return DAMAGE_TYPE_BLUDGEONING;
        }
        else if(nWeaponType == 1)
        {
        return DAMAGE_TYPE_PIERCING;
        }
        else
        {
        return FALSE;
        }
    }
    else
    {
    return FALSE;
    }
}
//::///////////////////////////////////////////////
int isMoaWeaponValid(object oItem)
{
object oPC = OBJECT_SELF;
int nMySize = GetCreatureSize(oPC);

    if(GetIsObjectValid(oItem) && IPGetIsMeleeWeapon(oItem))
    {
        if(nMySize == CREATURE_SIZE_SMALL)
        {
            if(getMeleeWeaponSize(oItem) == WEAPON_SIZE_MEDIUM)
            {
            return TRUE;
            }
            else
            {
            return FALSE;
            }
        }
        else if(nMySize == CREATURE_SIZE_MEDIUM)
        {
        if((getMeleeWeaponSize(oItem) == WEAPON_SIZE_LARGE) ||
            (GetBaseItemType(oItem) == BASE_ITEM_BASTARDSWORD) ||
            (GetBaseItemType(oItem) == BASE_ITEM_KATANA) ||
            (GetBaseItemType(oItem) == BASE_ITEM_DWARVENWARAXE))
            {
            return TRUE;
            }
            else
            {
            return FALSE;
            }
        }
        else
        {
        return FALSE;
        }
    }
    else
    {
    return FALSE;
    }
}
//::///////////////////////////////////////////////
int getMoaDamageBonus()
{
int isMainHandValid = isMoaWeaponValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF));
int isOffHandValid = isMoaWeaponValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF));
int nDam;
int nHalfStrMod = numSplitDown(GetAbilityModifier(ABILITY_STRENGTH));

    if(isMainHandValid == TRUE && isOffHandValid == TRUE)
    {
    nDam = IPGetDamageBonusConstantFromNumber(nHalfStrMod);
    return nDam;
    }
    else if(isMainHandValid == TRUE && isOffHandValid == FALSE)
    {
    nDam = IPGetDamageBonusConstantFromNumber(numSplitUp(nHalfStrMod));
    return nDam;
    }
    else if(isMainHandValid == FALSE && isOffHandValid == TRUE)
    {
    nDam = IPGetDamageBonusConstantFromNumber(numSplitUp(nHalfStrMod));
    return nDam;
    }
    else
    {
    return 0;
    }
}
//::///////////////////////////////////////////////
int numSplitUp(int num)
{
int nInt;
    if(num == 0)
    {
    nInt = 0;
    return nInt;
    }
    else if(num == 1)
    {
    nInt = 1;
    return nInt;
    }
    else if(num != 0 && num != 1 && num % 2 == 0)
    {
    nInt = num / 2;
    return nInt;
    }
    else if(num != 0 && num != 1 && num % 2 == 1)
    {
    nInt = (num / 2) + 1;
    return nInt;
    }

return FALSE;
}
//::///////////////////////////////////////////////
int numSplitDown(int num)
{
int nInt;
    if(num == 0)
    {
    nInt = 0;
    return nInt;
    }
    else if(num == 1)
    {
    nInt = 0;
    return nInt;
    }
    else if(num != 0 && num != 1)
    {
    nInt = num / 2;
    return nInt;
    }
return FALSE;
}
//::///////////////////////////////////////////////
int GetIPDamageBonus(itemproperty ip, int nDamageBonus = ITEM_PROPERTY_DAMAGE_BONUS)
{
int nFound = 0;
        if (GetItemPropertyType(ip) == nDamageBonus)
        {
            nFound = GetItemPropertyCostTableValue(ip);
        }
 return nFound;
}
//::///////////////////////////////////////////////
int convertIpDamTypeToEffectDamType(int nNumber)
{
    switch (nNumber)
    {
    case 6: //IP_CONST_DAMAGETYPE_ACID
        return DAMAGE_TYPE_ACID;
    case 0: //IP_CONST_DAMAGETYPE_BLUDGEONING
        return DAMAGE_TYPE_BLUDGEONING;
    case 7: //IP_CONST_DAMAGETYPE_COLD
        return DAMAGE_TYPE_COLD;
    case 8: //IP_CONST_DAMAGETYPE_DIVINE
        return DAMAGE_TYPE_DIVINE;
    case 9: //IP_CONST_DAMAGETYPE_ELECTRICAL
        return DAMAGE_TYPE_ELECTRICAL;
    case 10: //IP_CONST_DAMAGETYPE_FIRE
        return DAMAGE_TYPE_FIRE;
    case 5: //IP_CONST_DAMAGETYPE_MAGICAL
        return DAMAGE_TYPE_MAGICAL;
    case 11: //IP_CONST_DAMAGETYPE_NEGATIVE
        return DAMAGE_TYPE_NEGATIVE;
    case 4: //IP_CONST_DAMAGETYPE_PHYSICAL
        return DAMAGE_TYPE_MAGICAL;  // no Equivilent
    case 1: //IP_CONST_DAMAGETYPE_PIERCING
        return DAMAGE_TYPE_PIERCING;
    case 12: //IP_CONST_DAMAGETYPE_POSITIVE
        return DAMAGE_TYPE_POSITIVE;
    case 2: //IP_CONST_DAMAGETYPE_SLASHING
        return DAMAGE_TYPE_SLASHING;
    case 13: //IP_CONST_DAMAGETYPE_SONIC
        return DAMAGE_TYPE_SONIC;

    }
    return 0;
}
//::///////////////////////////////////////////////
int GetDamageFromReferenceNumber(int nNumber)
{
    switch (nNumber)
    {
        case 1:  return 1;//DAMAGE_BONUS_1;
        case 2:  return 2;//DAMAGE_BONUS_2;
        case 3:  return 3;//DAMAGE_BONUS_3;
        case 4:  return 4;//DAMAGE_BONUS_4;
        case 5:  return 5;//DAMAGE_BONUS_5;
        case 16:  return 6;//DAMAGE_BONUS_6;
        case 17:  return 7;//DAMAGE_BONUS_7;
        case 18:  return 8;//DAMAGE_BONUS_8;
        case 19:  return 9;//DAMAGE_BONUS_9;
        case 20: return 10;//DAMAGE_BONUS_10;
        case 21:  return 11;//DAMAGE_BONUS_11;
        case 22:  return 12;//DAMAGE_BONUS_12;
        case 23:  return 13;//DAMAGE_BONUS_13;
        case 24:  return 14;//DAMAGE_BONUS_14;
        case 25:  return 15;//DAMAGE_BONUS_15;
        case 26:  return 16;//DAMAGE_BONUS_16;
        case 27:  return 17;//DAMAGE_BONUS_17;
        case 28:  return 18;//DAMAGE_BONUS_18;
        case 29:  return 19;//DAMAGE_BONUS_19;
        case 30: return 20;//DAMAGE_BONUS_20;
        case 31: return 21;//DAMAGE_BONUS_21;
        case 32: return 22;//DAMAGE_BONUS_22;
        case 33: return 23;//DAMAGE_BONUS_23;
        case 34: return 24;//DAMAGE_BONUS_24;
        case 35: return 25;//DAMAGE_BONUS_25;
        case 36: return 26;//DAMAGE_BONUS_26;
        case 37: return 27;//DAMAGE_BONUS_27;
        case 38: return 28;//DAMAGE_BONUS_28;
        case 39: return 29;//DAMAGE_BONUS_29;
        case 40: return 30;//DAMAGE_BONUS_30;
        case 41: return 31;//DAMAGE_BONUS_31;
        case 42: return 32;//DAMAGE_BONUS_32;
        case 43: return 33;//DAMAGE_BONUS_33;
        case 44: return 34;//DAMAGE_BONUS_34;
        case 45: return 35;//DAMAGE_BONUS_35;
        case 46: return 36;//DAMAGE_BONUS_36;
        case 47: return 37;//DAMAGE_BONUS_37;
        case 48: return 38;//DAMAGE_BONUS_38;
        case 49: return 39;//DAMAGE_BONUS_39;
        case 50: return 40;//DAMAGE_BONUS_40;
        case 9: return d10(1);//DAMAGE_BONUS_1d10;
        case 14: return d12(1);//DAMAGE_BONUS_1d12;
        case 6: return d4(1);//DAMAGE_BONUS_1d4;
        case 7: return d6(1);//DAMAGE_BONUS_1d6;
        case 8: return d8(1);//DAMAGE_BONUS_1d8;
        case 13: return d10(2);//DAMAGE_BONUS_2d10;
        case 15: return d12(2);//DAMAGE_BONUS_2d12;
        case 12: return d4(2);//DAMAGE_BONUS_2d4;
        case 10: return d6(2);//DAMAGE_BONUS_2d6;
        case 11: return d8(2);//DAMAGE_BONUS_2d8;
        case 51: return d10(3);//IP_CONST_DAMAGEBONUS_3d10;
        case 52: return d12(3);//IP_CONST_DAMAGEBONUS_3d12;
        case 53: return d6(4);//IP_CONST_DAMAGEBONUS_4d6;
        case 54: return d8(4);//IP_CONST_DAMAGEBONUS_4d8;
        case 55: return d10(4);//IP_CONST_DAMAGEBONUS_4d10;
        case 56: return d12(4);//IP_CONST_DAMAGEBONUS_4d12;
        case 57: return d6(5);//IP_CONST_DAMAGEBONUS_5d6;
        case 58: return d12(5);//IP_CONST_DAMAGEBONUS_5d12;
        case 59: return d12(6);//IP_CONST_DAMAGEBONUS_6d12;
        case 60: return d6(3);//IP_CONST_DAMAGEBONUS_3d6;
        case 61: return d6(6);//IP_CONST_DAMAGEBONUS_6d6;


    }

    if (nNumber>61)
    {
        return 40;
    }
        else
    {
        return -1;
    }
}
//::///////////////////////////////////////////////
int getMeleeWeaponDamage(object oItem)
{
int nBaseItem = GetBaseItemType(oItem);

    if(GetIsObjectValid(oItem) && IPGetIsMeleeWeapon(oItem))
    {

    int nNumDice =  ( StringToInt(Get2DAString("baseitems","NumDice",nBaseItem)));
    int nDieToRoll =  ( StringToInt(Get2DAString("baseitems","DieToRoll",nBaseItem)));
        if(nNumDice == 1 && nDieToRoll == 3)
        {
        return d3(1);//DAMAGE_BONUS_1d4;
        }
        if(nNumDice == 1 && nDieToRoll == 4)
        {
        return d4(1);//DAMAGE_BONUS_1d4;
        }
        else if(nNumDice == 1 && nDieToRoll == 6)
        {
        return d6(1);//DAMAGE_BONUS_1d6;
        }
        else if(nNumDice == 1 && nDieToRoll == 8)
        {
        return d8(1);//DAMAGE_BONUS_1d8;
        }
        else if(nNumDice == 1 && nDieToRoll == 10)
        {
        return d10(1);//DAMAGE_BONUS_1d10;
        }
        else if(nNumDice == 1 && nDieToRoll == 12)
        {
        return d12(1);//DAMAGE_BONUS_1d12;
        }
        else if(nNumDice == 2 && nDieToRoll == 4)
        {
        return d4(2);//DAMAGE_BONUS_2d4;
        }
        else if(nNumDice == 2 && nDieToRoll == 6)
        {
        return d6(2);//DAMAGE_BONUS_2d6;
        }
        else
        {
        return 0;
        }
    }
    else
    {
    return 0;
    }
}
//::///////////////////////////////////////////////
void evaluateDOTHF()
{
    object oPC = OBJECT_SELF;
    int nSpellId = SPELL_PUMMELING_STRIKE;
    int nIsUnarmed = isDOTHFUnarmed();
    int dlvl = GetLevelByClass(CLASS_DOTHF, oPC);
    int mlvl = GetLevelByClass(CLASS_TYPE_MONK, oPC);
    int tlvl = dlvl + mlvl;
    //int nDam = unarmedDamageLevel(tlvl);
    int nTotalDam = unarmedDamageLevel(tlvl);
    int nMonkDam = unarmedDamageLevel(mlvl);
    int nDam = nTotalDam - nMonkDam;
    int nDOTHFDam = returnDOTHFUnarmedDamage();

    effect eDam;
    effect eDam2;
    effect eLink;

    //RemoveSpellEffects(SPELL_PUMMELING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_WITHERING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_ILLUMINATING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_ARCANE_STRIKE, oPC, oPC);


    if(nIsUnarmed == TRUE)
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);

        if(mlvl >= 1)
        {
            if(nDam == 10 || nDam ==14 || nDam == 18 || nDam == 24)
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_BLUDGEONING);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_BLUDGEONING);
            eLink = EffectLinkEffects(eDam2, eDam);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Pummeling Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_BLUDGEONING);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Pummeling Strike - Activated", oPC);
            }
        }
        else if(mlvl == 0)
        {
            if(nDam == 16 || nDam ==18 || nDam == 24 || nDam == 30)
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_BLUDGEONING);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_BLUDGEONING);
            eLink = EffectLinkEffects(eDam, eDam2);
            eLink = ExtraordinaryEffect(eLink);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Pummeling Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_BLUDGEONING);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Pummeling Strike - Activated", oPC);
            }
        }
    }
    else
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);
    FloatingTextStringOnCreature("Pummeling Strike - Deactivated", oPC);
    }
}
//::///////////////////////////////////////////////
void DOTHFWithering()
{
    object oPC = OBJECT_SELF;
    int nSpellId = SPELL_WITHERING_STRIKE;
    int nIsUnarmed = isDOTHFUnarmed();
    int dlvl = GetLevelByClass(CLASS_DOTHF, oPC);
    int mlvl = GetLevelByClass(CLASS_TYPE_MONK, oPC);
    int tlvl = dlvl + mlvl;
    //int nDam = unarmedDamageLevel(tlvl);
    int nTotalDam = unarmedDamageLevel(tlvl);
    int nMonkDam = unarmedDamageLevel(mlvl);
    int nDam = nTotalDam - nMonkDam;
    int nDOTHFDam = returnDOTHFUnarmedDamage();

    effect eDam;
    effect eDam2;
    effect eLink;

    RemoveSpellEffects(SPELL_PUMMELING_STRIKE, oPC, oPC);
    //RemoveSpellEffects(SPELL_WITHERING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_ILLUMINATING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_ARCANE_STRIKE, oPC, oPC);


    if(nIsUnarmed == TRUE)
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);

        if(mlvl > 0)
        {
        if(nDam == 10 || nDam ==14 || nDam == 18 || nDam == 24)
        {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_NEGATIVE);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_NEGATIVE);
            eLink = EffectLinkEffects(eDam, eDam2);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Withering Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_NEGATIVE);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Withering Strike - Activated", oPC);
            }
        }
        else
        {
            if(nDam == 16 || nDam ==18 || nDam == 24 || nDam == 30)
            {

            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_NEGATIVE);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_NEGATIVE);
            eLink = EffectLinkEffects(eDam, eDam2);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Withering Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_NEGATIVE);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Withering Strike - Activated", oPC);
            }
        }
    }
    else
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);
    FloatingTextStringOnCreature("Withering Strike - Deactivated", oPC);
    }
}
//::///////////////////////////////////////////////
void DOTHFIlluminating()
{
    object oPC = OBJECT_SELF;
    int nSpellId = SPELL_ILLUMINATING_STRIKE;
    int nIsUnarmed = isDOTHFUnarmed();
    int dlvl = GetLevelByClass(CLASS_DOTHF, oPC);
    int mlvl = GetLevelByClass(CLASS_TYPE_MONK, oPC);
    int tlvl = dlvl + mlvl;
    //int nDam = unarmedDamageLevel(tlvl);
    int nTotalDam = unarmedDamageLevel(tlvl);
    int nMonkDam = unarmedDamageLevel(mlvl);
    int nDam = nTotalDam - nMonkDam;
    int nDOTHFDam = returnDOTHFUnarmedDamage();

    effect eDam;
    effect eDam2;
    effect eLink;

    RemoveSpellEffects(SPELL_PUMMELING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_WITHERING_STRIKE, oPC, oPC);
    //RemoveSpellEffects(SPELL_ILLUMINATING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_ARCANE_STRIKE, oPC, oPC);


    if(nIsUnarmed == TRUE)
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);

    if(mlvl > 0)
    {
        if(nDam == 10 || nDam ==14 || nDam == 18 || nDam == 24)
        {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_POSITIVE);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_POSITIVE);
            eLink = EffectLinkEffects(eDam, eDam2);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Illuminating Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_POSITIVE);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Illuminating Strike - Activated", oPC);
            }
        }
        else
        {
            if(nDam == 16 || nDam ==18 || nDam == 24 || nDam == 30)
            {

            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_POSITIVE);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_POSITIVE);
            eLink = EffectLinkEffects(eDam, eDam2);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Illuminating Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_POSITIVE);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Illuminating Strike - Activated", oPC);
            }
        }
    }
    else
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);
    FloatingTextStringOnCreature("Illuminating Strike - Deactivated", oPC);
    }
}
//::///////////////////////////////////////////////
void DOTHFArcane()
{
    object oPC = OBJECT_SELF;
    int nSpellId = SPELL_ARCANE_STRIKE;
    int nIsUnarmed = isDOTHFUnarmed();
    int dlvl = GetLevelByClass(CLASS_DOTHF, oPC);
    int mlvl = GetLevelByClass(CLASS_TYPE_MONK, oPC);
    int tlvl = dlvl + mlvl;
    //int nDam = unarmedDamageLevel(tlvl);
    int nTotalDam = unarmedDamageLevel(tlvl);
    int nMonkDam = unarmedDamageLevel(mlvl);
    int nDam = nTotalDam - nMonkDam;
    int nDOTHFDam = returnDOTHFUnarmedDamage();

    effect eDam;
    effect eDam2;
    effect eLink;

    RemoveSpellEffects(SPELL_PUMMELING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_WITHERING_STRIKE, oPC, oPC);
    RemoveSpellEffects(SPELL_ILLUMINATING_STRIKE, oPC, oPC);
    //RemoveSpellEffects(SPELL_ARCANE_STRIKE, oPC, oPC);


    if(nIsUnarmed == TRUE)
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);

    if(mlvl > 0)
    {
        if(nDam == 10 || nDam ==14 || nDam == 18 || nDam == 24)
        {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_MAGICAL);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_MAGICAL);
            eLink = EffectLinkEffects(eDam, eDam2);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Arcane Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_MAGICAL);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Arcane Strike - Activated", oPC);
            }
        }
        else
        {
            if(nDam == 16 || nDam ==18 || nDam == 24 || nDam == 30)
            {

            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_MAGICAL);
            eDam2 = EffectDamageDecrease(DAMAGE_BONUS_2, DAMAGE_TYPE_MAGICAL);
            eLink = EffectLinkEffects(eDam, eDam2);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Arcane Strike - Activated", oPC);
            }
            else
            {
            eDam = EffectDamageIncrease(nDOTHFDam, DAMAGE_TYPE_MAGICAL);
            eDam = ExtraordinaryEffect(eDam);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, HoursToSeconds(48));
            FloatingTextStringOnCreature("Arcane Strike - Activated", oPC);
            }
        }
    }
    else
    {
    RemoveSpellEffects(nSpellId, oPC, oPC);
    FloatingTextStringOnCreature("Arcane Strike - Deactivated", oPC);
    }
}
//::///////////////////////////////////////////////
int isDOTHFUnarmed()
{
    object oPC = OBJECT_SELF;
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    if(GetIsObjectValid(oWeapon) == FALSE && GetIsObjectValid(oWeapon2) == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}
//::///////////////////////////////////////////////
int isDOTHFSwiftable()
{
    object oPC = OBJECT_SELF;
    int nUnarmed = isDOTHFUnarmed();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    int oItem = GetBaseItemType(oWeapon);
    int oItem2 = GetBaseItemType(oWeapon2);

    if(nUnarmed == TRUE ||
    oItem == BASE_ITEM_CLUB ||
    oItem == BASE_ITEM_DAGGER ||
    oItem == BASE_ITEM_HANDAXE ||
    oItem == BASE_ITEM_KAMA ||
    oItem == BASE_ITEM_QUARTERSTAFF)
    {
        if(nUnarmed == TRUE ||
        oItem2 == BASE_ITEM_CLUB ||
        oItem2 == BASE_ITEM_DAGGER ||
        oItem2 == BASE_ITEM_HANDAXE ||
        oItem2 == BASE_ITEM_KAMA ||
        oItem2 == BASE_ITEM_QUARTERSTAFF)
        {
        return TRUE;
        }
        else
        {
        return FALSE;
        }
    }
    else
    {
    return FALSE;
    }
}
//::///////////////////////////////////////////////
int returnDOTHFUnarmedDamage()
{
    object oPC = OBJECT_SELF;
    int dlvl = GetLevelByClass(CLASS_DOTHF, oPC);
    int mlvl = GetLevelByClass(CLASS_TYPE_MONK, oPC);
    int tlvl = dlvl + mlvl;
    int nTotalDam = unarmedDamageLevel(tlvl);
    //int nDam = nTotalDam;
    int nMonkDam = unarmedDamageLevel(mlvl);
    int nDam = nTotalDam - nMonkDam;

    if(mlvl > 0)
    {
        switch(nDam)
        {
        case 2: return DAMAGE_BONUS_2;
        case 4: return DAMAGE_BONUS_1d4;
        case 6: return DAMAGE_BONUS_1d6;
        case 8: return DAMAGE_BONUS_1d8;
        case 10: return DAMAGE_BONUS_1d10; // - 2
        case 12: return DAMAGE_BONUS_2d6;
        case 14: return DAMAGE_BONUS_2d8; //- 2
        case 16: return DAMAGE_BONUS_2d8;
        case 18: return DAMAGE_BONUS_2d10; // - 2
        case 20: return DAMAGE_BONUS_2d10;
        case 22: return DAMAGE_BONUS_2d12;// -2
        case 24: return DAMAGE_BONUS_2d12;
        //case 30: return DAMAGE_BONUS_3d10; // won't happen
        default: return 0;
        }
    }
    else
    {
        switch(nDam)
        {
        //case 2: return DAMAGE_BONUS_1;
        //case 4: return DAMAGE_BONUS_2;
        case 6: return DAMAGE_BONUS_1d4;
        case 8: return DAMAGE_BONUS_1d6;
        case 10: return DAMAGE_BONUS_1d8;
        case 12: return DAMAGE_BONUS_1d10;
        case 14: return DAMAGE_BONUS_2d6;
        case 16: return DAMAGE_BONUS_2d8;// -2
        case 18: return DAMAGE_BONUS_2d8;
        case 20: return DAMAGE_BONUS_2d10;// -2
        case 22: return DAMAGE_BONUS_2d10;
        case 24: return DAMAGE_BONUS_2d12; // -2
        case 30: return 51; // 3d10 // -2
        default: return 0;
        }
    }
    return 0;
}
//::///////////////////////////////////////////////
int unarmedDamageLevel(int lvl)
{
    if(lvl == 0){return 0;
    }
    else if(lvl >= 1 && lvl <= 3){return 6;
    }
    else if(lvl >= 4 && lvl <= 7){return 8;
    }
    else if(lvl >= 8 && lvl <= 11){return 10;
    }
    else if(lvl >= 12 && lvl <= 15){return 12;
    }
    else if(lvl >= 16 && lvl <= 19){return 16;
    }
    else if(lvl >= 20 && lvl <= 23){return 20;
    }
    else if(lvl >= 24 && lvl <= 27){return 24;
    }
    else{return 30;
    }
}
//::///////////////////////////////////////////////
int isMonkItem(object oItem)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    int nSubType;

    while (GetIsItemPropertyValid(ip))
    {
        if(GetItemPropertyType(ip) == ITEM_PROPERTY_USE_LIMITATION_CLASS)
        {
        nSubType = GetItemPropertySubType(ip);
            if(nSubType == CLASS_TYPE_MONK)
            {
            return TRUE;
            }
            else
            {
            return FALSE;
            }
        }
        ip = GetNextItemProperty(oItem);
    }
    return FALSE;
}
//::///////////////////////////////////////////////
