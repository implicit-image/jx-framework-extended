#include "jx_inc_magic"
// i need RollDice function
#include "ginc_wp"
// i need string tokenizer
#include "x0_i0_stringlib"

//##################################################
// Effect String Representation Data
//#################################################

struct override_effect
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

effect JXEffectFromOverrideEffect(struct override_effect OverrideEffect)
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
                int iDmgype = StringToInt(sArg1);
                int iDmgPower = StringToInt(sArg2);
                int iIgnoreResistances = StringToInt(sArg3);
                e = EffectDamage(iDmg, iDmgType, iDmgPower, iIgnoreResistaces);
                break;
    }
    return e;
}

//#######################################################
// Saving effect data
//#######################################################

string JXOverrideEffectToString(struct override_effect OverrideEffect)
{
    string sOverrideEffectRepr;
    sOverrideEffectRepr += IntToString(OverrideEffect.iNumOfEffects) + JX_FIELD_SEP;
    sOverrideEffectRepr += IntToString(OverrideEffect.iEffectSubtype) + JX_FIELD_SEP;
    sOverrideEffectRepr += OverrideEffect.sEffectInfo;
    return sOverrideEffectRepr;
}


struct override_effect JXMakeOverrideEffect(int iOverrideEffectId, effect eEffect, string sEffectArgs)
{
    struct override_effect OverrideEffect;
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
