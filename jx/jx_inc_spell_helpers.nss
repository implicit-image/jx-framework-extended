//######################################################
//:: jx_inc_spell_helpers
//######################################################
// 02/06/2024 - implicit-image
//     * file added

#include "jx_inc_magic"
#include "nw_o0_itemmaker"
#include "x2_i0_spells"

void ClearLocalStringArray(object oTarget, string sArrayName, int iCount);

void ClearLocalIntArray(object oTarget, string sArrayName, int iCount);

void JXApplyEffectAtInterval(object oCaster, object oTarget, int iSpellId, effect eEffect, float fInterval=6.0f, int iDurationType=DURATION_TYPE_INSTANT, float fEffectDuration=0.0f);

string JXIntMapSet(string sMap, int iKey, int iValue);

int JXIntMapGetValue(string sMap, int iKey);



//============================= Implemetation ======================================
// JXInjectEventHandler()
// {
//     string sHandler = GetEventHandler(oObject, iEventId);
//     SetLocalString()
// }


void ClearLocalStringArray(object oTarget, string sArrayName, int iCount)
{
    int iIndex = 0;
    while(iIndex < iCount)
    {
        SetLocalArrayString(oTarget, sArrayName, iIndex, "");
        iIndex++;
    }
}

void ClearLocalIntArray(object oTarget, string sArrayName, int iCount)
{
    int iIndex = 0;
    while(iIndex < iCount)
    {
        SetLocalArrayString(oTarget, sArrayName, iIndex, "");
        iIndex++;
    }
}


// Apply the effect at interval
void JXApplyEffectAtInterval(object oCaster, object oTarget, int iSpellId, effect eEffect, float fInterval=6.0f, int iDurationType=DURATION_TYPE_INSTANT, float fDuration=0.0f)
{
    if (GZGetDelayedSpellEffectsExpired(iSpellId, oTarget, oCaster))
    {
        return;
    }
    JXApplyEffectToObject(iDurationType, eEffect, oTarget, fDuration);
    DelayCommand(fInterval, JXApplyEffectAtInterval(oCaster, oTarget, iSpellId, eEffect, fInterval, iDurationType, fDuration));
}

/* void JXRunRandomDamageOverTime(object oTarget, ) */


//##########################################
// MAP IMPLEMENTATION
// ##########################################

// FIXME: implement this after the foundations are working
// string JXIntMapSet(string sMap, int iKey, int iValue)
// {
//     struct sStringTokenizer strTok = GetStringTokenizer(sMap, JX_GEN_SEP);

//     string sCurrMapping;
//     string sResult;
//     string sCurrKey;
//     string sCurrValue;
//     while (HasMoreTokens(strTok))
//     {
//         strTok = AdvanceToNextToken(strTok);
//         // typefrom : type to
//         sCurrMapping = GetNextToken(strTok);
//         sCurrKey = GetTokenByPosition(sCurrMapping, JX_MAP_SEP, 0);
//         sCurrValue = GetTokenByPosition(sCurrMapping, JX_MAP_SEP, 1);
//         if (IntToString(iKey) == sCurrKey)
//                 sCurrValue = sValue;
//         sResult = sCurrKey + JX_MAP_SEP + sCurrValue + JX_GEN_SEP;
//     }
//     return sResult;
// }


// int JXIntMapGetValue(string sMap, int iKey)
// {
//     struct sStringTokenizer strTok = GetStringTokenizer(sMap, JX_GEN_SEP);

//     string sCurrMapping;

//     while (HasMoreTokens(strTok))
//     {
//         strTok = AdvanceToNextToken(strTok);
//         // typefrom : type to
//         sCurrMapping = GetNextToken(strTok);
//         sCurrKey = GetTokenByPosition(sCurrMapping, JX_MAP_SEP, 0);
//         sCurrValue = GetTokenByPosition(sCurrMapping, JX_MAP_SEP, 1);
//         if (IntToString(iKey) == sCurrKey)
//                 return StringToInt(sCurrValue);
//     }
//     return -1;
// }
