#include "jx_inc_magic"
// i need RollDice function
#include "ginc_wp"
// i need string tokenizer
#include "x0_i0_stringlib"

/*
This file contains implementation details and helper functions for
override effects
*/


//##################################################
// Effect String Representation Data
//#################################################

struct jx_effect
{
    int iNumOfEffects;
    int iDefaultDurationType;
    string sEffectInfo;
};


//###################################################
// General Effect Info
//#################################################

// Get All effect integers of the effect
string JXGetAllEffectInts(effect eEffect)
{
    int iIndex = 0;
    string sEffectInts;
    int iEffectInt = GetEffectInteger(eEffect, iIndex);
    while(iEffectInt != 0)
    {
        sEffectInfo += IntToString(iEffectInt) + JX_GEN_SEP;
        SendMessageToPC(OBJECT_SELF, "effect info is " + sEffectInfo);
        iIndex++;
        iEffectInt = GetEffectInteger(eEffect, iIndex);
    }
    return sEffectInts;
}

int JXGetOverrideEffectDefaultDurationType(int iOverrideEffectId)
{
    switch (iOverrideEffectId)
    {
        case JX_SAVED_EFFECT_HEAL:
        case JX_SAVED_EFFECT_DAMAGE:
                return DURATION_TYPE_INSTANT;
        default:
                return DURATION_TYPE_TEMPORARY;
    }
}


//#################################################################
// Load effect from local array
//#################################################################

// @param JXEffectId - JX_EFFECT_* of the effect to link with
// @result effect    - effect link
effect JXLoadBonusEffectLink(int iJXEffectId, int iLinkCount)
{
    string sBonusLinkArray = JXArrayForEffect(iJXEffectId, JX_EFFECT_BONUS_LINK_ARRAY);

    int iIndex = 1;

    effect eLink;
    int iJXEffectId = GetLocalArrayInt(OBJECT_SELF, sBonusLinkArray, iIndex);
    while (iJXEffectId != 0)
    {
        effect eEffect = JXLoadEffectFromArray(iIndex, iJXEffectId, sBonusLinkArray);
        eLink = EffectLinkEffects(eEffect, eLink);

        // move to the next effect index
        iIndex += iIndex + JX_EFFECT_MAX_LINK_SIZE;
        // read next effect id
        iJXEffectId = GetLocalArrayInt(OBJECT_SELF, sBonusLinkArray, iIndex);
    }
    return eLink;
}

int JXEffectGetParamInt(string sArrayName, int iPos, object oOwner=OBJECT_SELF)
{
    string sEffectArr
    int sPAram = GetLocalArrayInt(oOwner, )
    return
}


effect JXLoadEffectFromArray(int iStartIndex, int iJXEffectId, string sArray, object oOwner=OBJECT_SELF)
{
    string sParam1 = GetVarNameFromArrayPos(sArray, iStartIndex + 1, oOwner);
    string sParam2 = GetVarNameFromArrayPos(sArray, iStartIndex + 2, oOwner);
    string sParam3 = GetVarNameFromArrayPos(sArray, iStartIndex + 3, oOwner);
    string sParam4 = GetVarNameFromArrayPos(sArray, iStartIndex + 4, oOwner);
    string sParam5 = GetVarNameFromArrayPos(sArray, iStartIndex + 5, oOwner);
    string sParam6 = GetVarNameFromArrayPos(sArray, iStartIndex + 6, oOwner);
    string sParam7 = GetVarNameFromArrayPos(sArray, iStartIndex + 7, oOwner);
    string sParam8 = GetVarNameFromArrayPos(sArray, iStartIndex + 8, oOwner);
    string sParam9 = GetVarNameFromArrayPos(sArray, iStartIndex + 9, oOwner);

    switch(iJXEffectId)
    {
        case JX_EFFECT_HEAL:
            {
                int iDmgToHeal = GetLocalInt(oOwner, sParam1);
                return EffectHeal(iDmgToHeal);
            }
        case JX_EFFECT_DAMAGE:
            {
                int iDmgAmount = GetLocalInt(oOwner, sParam1);
                int iDmgType = GetLocalInt(oOwner, sParam2);
                int iDmgPower = GetLocalInt(oOwner, sParam3);
                return EffectDamage(iDmgAmount, iDmgType, iDmgPower);
            }
        case JX_EFFECT_DAMAGE_OVER_TIME:
            {
                int iDmg = GetLocalInt(oOwner, sParam1);
                float fInterval = GetLocalInt(oOwner, sParam2);
                int iDmgType = GetLocalFloat(oOwner, sParam3);
                int iIgnoreResistances = GetLocalInt(oOwner, sParam4);
                return EffectDamageOverTime(iDmg, fInterval, iDmgType, iIgnoreResistances);
            }
        case JX_EFFECT_ABILITY_INCREASE:
            {
                int iAbility = GetLocalInt(oOwner, sParam1);
                int iModifyBy = GetLocalInt(oOwner, sParam2);
                return EffectAbilityIncrease(iAbility, iModifyBy);
            }
        case JX_EFFECT_DAMAGE_RESISTANCE:
            {
                int iDmgType = GetLocalInt(oOwner, sParam1);
                int iAmount = GetLocalInt(oOwner, sParam2);
                int iLimit = GetLocalInt(oOwner, sParam3);
                return EffectDamageResistance(iDmgType, iAmount, iLimit);
            }
        case JX_EFFECT_RESURRECTION:
            {
                return EffectResurrection();
            }
        case JX_EFFECT_SUMMON_CREATURE:
            {
                string sCreatureRef = GetLocalString(oOwner, sParam1);
                int iVisEffect = GetLocalInt(oOwner, sParam2);
                float fDelay = GetLocalFloat(oOwner, sParam3);
                int iUseAppearAnimation = GetLocalInt(oOwner, sParam4);
                return EffectSummonCreature(sCreatureRef, iVisEffects, fDelay, iUseAppearAnimation);
            }
        case JX_EFFECT_AC_INCREASE:
            {
                int iValue = GetLocalInt(oOwner, sParam1);
                int iModifyType = GetLocalInt(oOwner, sParam2);
                int iDamageType = GetLocalInt(oOwner, sParam3);
                int iVsSpiritsOnly = GetLocalInt(oOwner, sParam4);
                return EffectACIncrease(iValue, iModifyType, iDmaageType, iVsSpiritsOnly);
            }
        case JX_EFFECT_SAVING_THROW_INCREASE:
            {
                int iSave = GetLocalInt(oOwner, sParam1);
                int iValue = GetLocalInt(oOwner, sParam2);
                int iSaveType = GetLocalInt(oOwner, sParam3);
                int iVsSpiritsOnly = GetLocalInt(oOwner, sPAram4);
                return EffectSavingThrowDecrease(iSave, iValue, iSaveType, iVsSpiritsOnly);
            }
        case JX_EFFECT_ATTACK_INCREASE:
            {
                int iBonus = GetLocalInt(oOwner, sParam1);
                int iModifierType = GetLocalInt(oOwner, sParam2);
                return EffectAttackIncrease(iBonus, iModifierType);
            }
        case JX_EFFECT_DAMAGE_REDUCTION:
            {
                int iAmount = GetLocalInt(oOwner, sParam1);
                int iDamagePower = GetLocalInt(oOwner, sParam2);
                int iLimit = GetLocalInt(oOwner, sParam3);
                int iDRType = GetLocalInt(oowner, sParam4);
                return EffectDamageReduction(iAmount, iDamagePower, iLimit);
            }
        case JX_EFFECT_DAMAGE_INCREASE:
            {
                int iBonus = GetLocalInt(oOwner, sParam1);
                int iDamageType = GetLocalInt(oOwner, sParam2);
                int iVsRace = GetLocalInt(oOwner, sParam3);
                return EffectDamageIncrease(iBonus, iDamageType, iVsRace);
            }
        case JX_EFFECT_ENTANGLE:
            {
                return EffectEntangle();
            }
        case JX_EFFECT_DEATH:
            {
                int iSpectacularDeath = GetLocalInt(oOwner, sParam1);
                int iDisplayFeedback
                return EffectDeath(int iSpectacularDeath, iDisplayFeedback, iIgnoreImmunity, iPurgeEffects);
            }

        default:
            return;
    }
}

string JXArrayForEffect(int iJXEffectId, string sArrayRoot)
{
    return sArrayRoot + "_" + IntToString(iJXEffectId) + ":";
}

string JXModifierArrayForEffectProperty(int iJXEffectId, int iEffectProp, )

string JXVarForEffect(int iJXEffectId, string sVarRoot)
{
    return sVarRoot + "_" + IntToString(iJXEffectId) + ":";
}





//#########################################################
// Create effect from string representation
//#######################################################


effect JXEffectFromString(string sEffectRepr)
{

    SendMessageToPC(OBJECT_SELF, "Converting effect string repr to efffect.")
    effect e;
    // early out
    if (sEffectRepr == "")
    {
        SendMessageToPC(OBJECT_SELF, "Effect repr is empty string!!!");
        return e;
    }

    int iNumOfEffects = StringToInt(GetTokenByPosition(sEffectRepr, JX_FIELD_EP, 0));
    SendMessageToPC(OBJECT_SELF, "Number of linked effects is: " + IntoToString(iNumOfEffect));

    int iEffectSubtype = StringToInt(GetTokenByPosition(sEffectRepr, JX_FIELD_SEP, 1));
    SendMessageToPC(OBJECT_SELF, "Effect subtype id is: " + IntToString(iEffectSubtype));

    string sEffectInfos = GetTokenByPosition(sEffectRepr, JX_FIELD_SEP, 2);
    SendMessageToPC(OBJECT_SELF, "List of Effect Infos is: " + sEffectInfos);


    struct sStringTokenizer strTok= GetStringTokenizer(sEffectInfos, JX_EFFECT_SEP);

    while (HasMoreTokens(strTok))
    {
        strTok = AdvanceToNextToken(strTok);
        sEffectInfo = GetNextToken(strTok);

        SendMessageToPC(OBJECT_SELF, "Current effect info is: " + sEffectInfo);
        eNewEffect = JXSingleEffectFromString(sEffectInfo);
        e = EffectLinkEffects(e, eNewEffect);
        int isEffectOk = GetIsEffectValid(eNewEffect);
        int isLinkOk = GetIsEffectValid(e);
        if (isEffectOk && isLinkOk)
        {
            SendMessageToPC(OBJECT_SELF, "Created effect of type: " + IntToString(GetEffectType(eNewEffect)));
            SendMEssageToPC(OBJECT_SELF, "Creating effect out of effect info:")
        }

    }
    e = JXSetEffectSubtype(e, iEffectSubtype);
    return e;

}

effect JXEffectFromOverrideEffect(struct jx_effect OverrideEffect)
{
    effect e;
    struct sStringTokenizer strTok= GetStringTokenizer(OverrideEffect.sEffectInfos, JX_EFFECT_SEP);

    while (HasMoreTokens(strTok))
    {
        strTok = AdvanceToNextToken(strTok);
        sEffectInfo = GetNextToken(strTok);
        e = EffectLinkEffects(e, JXSingleEffectFromString(sEffectInfo));
    }
    return e;
}


effect JXSingleEffectFromString(string sEffectInfo)
{
    int iOverrideEffectType = StringToInt(GetTokenByPosition(OverrideEffect.sEffectInfo, JX_PROP_SEP, 0));
    int iEffectType = StringToInt(GetTokenByPosition(OverrideEffect.sEffectInfo, JX_PROP_SEP, 1));
    string sArgList = GetTokenByPosition(OverrideEffect.sEffectInfo, JX_PROP_SEP, 2);

    return JXCreateEffect(iOverrideEffectType, sArgsList, iEffectType);
}

effect JXCreateEffect(int iOverrideEffectType, string sArgList, int iEffectType)
{
    effect e;
    // each arg is <str_repr> of an arg
    string sArg0 = GetTokenByPosition(sArgList, JX_ARG_SEP, 0);
    string sArg1 = GetTokenByPosition(sArgList, JX_ARG_SEP, 1);
    string sArg2 = GetTokenByPosition(sArgList, JX_ARG_SEP, 2);
    string sArg3 = GetTokenByPosition(sArgList, JX_ARG_SEP, 3);
    string sArg4 = GetTokenByPosition(sArgList, JX_ARG_SEP, 4);
    string sArg5 = GetTokenByPosition(sArgList, JX_ARG_SEP, 5);
    string sArg6 = GetTokenByPosition(sArgList, JX_ARG_SEP, 6);
    string sArg7 = GetTokenByPosition(sArgList, JX_ARG_SEP, 7);

    switch (iOverrideEffectType)
    {
        case JX_EFFECT_HEAL:
                int iDmgToHeal = StringToInt(Arg0);
                e = EffectHeal(iDmgToHeal);
                break;
        case JX_EFFECT_DAMAGE:
                int iDmg = StringToInt(sArg0);
                int iDmgType = StringToInt(sArg1);
                int iDmgPower = StringToInt(sArg2);
                int iIgnoreResistances = StringToInt(sArg3);
                e = EffectDamage(iDmg, iDmgType, iDmgPower, iIgnoreResistaces);
                break;
        // case JX_EFFECT_:
        //     break;
        // case JX_EFFECT_:
        //     break;
        // case JX_EFFECT_:
        //     break;
        // case JX_EFFECT_:
        //     break;
        // case JX_EFFECT_:
        //     break;
        // case JX_EFFECT_:
        //     break;
    }
    return e;
}

//#######################################################
// Saving effect data
//#######################################################

string JXOverrideEffectToString(struct jx_effect OverrideEffect)
{
    string sOverrideEffectRepr;
    sOverrideEffectRepr += IntToString(OverrideEffect.iNumOfEffects) + JX_FIELD_SEP;
    sOverrideEffectRepr += IntToString(OverrideEffect.iEffectSubtype) + JX_FIELD_SEP;
    sOverrideEffectRepr += OverrideEffect.sEffectInfo;
    SendMessageToPC(OBJECT_SELF, "effect repr is: ");
    SendMessageToPC(OBJECT_SELF, "**********************");
    SendMessageToPC(OBJECT_SELF, sOverrideEffectRepr);
    SendMessageToPC(OBJECT_SELF, "**********************");
    return sOverrideEffectRepr;
}


struct jx_effect JXMakeOverrideEffect(int iOverrideEffectId, effect eEffect, string sEffectArgs)
{
    struct jx_effect OverrideEffect;
    string sEffectInfo;

    int iDefaultEffectDurationType = JXGetDefaultEffectDurationType(iOverrideEffectId);

    OverrideEffect.iDefaultDurationType = iDefaultEffectDurationType;
    OverrideEffect.iNumEffects = 1;

    sEffectInfo = IntToString(iSaveEffectId) + JX_INFO_SEP;
    sEffectInfo += IntToString(GetEffectType(eEffect)) + JX_INFO_SEP;
    sEffectInfo += IntToString(GetEffectSubtype(eEffect)) + JX_INFO_SEP;
    sEffectInfo += sEffectArgs + JX_EFFECT_SEP;

    OverrideEffect.sEffectInfo = sEffectInfo ;

    return OverrideEffect;
}


string JXOverrideEffectArgsPushInteger(string sArgList, int iArg)
{
    sArgList += IntToString(iArgs) + JX_ARG_SEP;
    return sArgList;
}

string JXOverrideEffectArgsPushFloat(string sArgList, float fArg)
{
    sArgList += FloatToString(fArg) + JX_ARG_SEP;
    return sArgList;
}

string JXOverrideEffectArgsPushString(string sArgList, string sArg)
{
    sArgList += sArg + JX_ARG_SEP;
    return sArgList;
}


string JXOverrideEffectArgsPushObject(string sArgList, object oArg)
{
    sArgList += ObjectToString(oArg) + JX_ARG_SEP;
    return sArgList;
}


effect JXSetEffectSubtype(effect eEffect, int iEffectSubtype)
{
    switch (iEffectSubtype)
    {
        case SUBTYPE_MAGICAL: return MagicalEffect(eEffect);
        case SUBTYPE_SUPERNATURAL: return SupernaturalEffect(eEffect);
        case SUBTYPE_EXTRAORDINARY: return ExtraordinaryEffect(eEffect);
        default: return eEffect
    }
}

int JXRollRandBonus(string sRollInfo)
{
    int iNumOfDice = GetTokenByPosition(sRollInfo, JX_GEN_SEP, 0);
    int iNumOfSides = GetTokenByPosition(sRollInfo, JX_GEN_SEP, 1);
    return Roll(iNumOfDice, iNumOfSides);
}
