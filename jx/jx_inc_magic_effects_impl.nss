#include "jx_inc_magic"
// i need RollDice function
#include "ginc_wp"
// i need string tokenizer
#include "x0_i0_stringlib"
#include "utils"

/*
This file contains implementation details and helper functions for
override effects
*/
// array helpers

int JXEffectModOpParamInt(int iValue);

int JXEffectModOpParamFloat(float fValue);

int JXEffectModOpParamString(string sValue);

int JXEffectModOpParamObject(object oValue);

// curremt mod param getters;

int JXGetCurrModOpParamInt(int iOpParamPos=1);

float JXGetCurrModOpParamFloat(int iOpParamPos=1);

string JXGetCurrModOpParamString(int iOpParamPos=1);

object JXGetCurrModOpParamObject(int iOpParamPos=1);

int JXGetCurrModOpParamType(int iParamPos);

int JXIsCurrModOpParamSet(int iParamPos);

void JXClearCurrModOpParams();

void JXTypeError(int iPassedType, int iExpectedType1=0, int iExpectedType2=0, int iExpectedType3=0, int iExpectedType4=0, int iExpectedType5=0);

// JXAddEffectModifier(JX_EFFECT_TYPE_HEAL, JX_EFFECT_MOD_TYPE_PARAM_1, JX_EFFECT_MOD_PARAM_INCREASE_BY, JXEffectModArgInt(40));;

void JXAddEffectModifier(int iEffectType, int iModType, int iModOp=0, int iModParam1=0, int iModParam2=0, int iModParam3=0, int iModParam4=0, int iModParam5=0, int iModParam6=0, int iModParam7=0);

void JXSetModOpParamValueInt(int iEffectType, int iModType, int iModOp, int iParamPos, int iValue);

void JXSetModOpParamValueFloat(int iEffectType, int iModType, int iModOp, int iParamPos, float fValue);

void JXSetModOpParamValueString(int iEffectType, int iModType, int iModOp, int iParamPos, string sValue);

void JXSetModOpParamValueObject(int iEffectType, int iModType, int iModOp, int iParamPos, object oValue);

int JXGetModOpParamValueInt(int iEffectType, int iModType, int iModOp, int iParamPos);

float JXGetModOpParamValueFloat(int iEffectType, int iModType, int iModOp, int iParamPos);

string JXGetModOpParamValueString(int iEffectType, int iModType, int iModOp, int iParamPos);

object JXGetModOpParamValueObject(int iEffectType, int iModType, int iModOp, int iParamPos);

void JXDisableEffect(int iEffectType);

int JXIsEffectDisabled();


//==================================================================== effect creation functions =====================================================;

void JXStartEffectMod(int iEffectType);

void JXEndEffectMod();

int JXGetModifiedEffectType();

int JXIsEffectModOpParamSet(int iModType, int iModOp, int iOpParamPosition=1);

int JXGetEffectModParamInt(int iModType, int iModOp, int iOpParamPosition=1);

float JXGetEffectModParamFloat(int iModType, int iModOp, int iOpParamPosition=1);

string JXGetEffectModParamString(int iOvrtype, int iModOp, int iOpParamPosition=1);

object JXGetEffectModParamObject(int iModType, int iModOp, int iOpParamPosition=1);

// applying modifiers;

effect JXApplyEffectPropertyModifiers(effect eEffect);

int JXApplyEffectParamModifiers_Int(int iValue, int iEffectParamPosition=1);

float JXApplyEffectParamModifiers_Float(float fValue, int iEffectParamPosition=1);

string JXApplyEffectParamModifiers_String(string sValue, int iEffectParamPosition=1);

object JXApplyEffectParamModifiers_Object(object oValue, int iEffectParamPosition=1);

effect JXApplyEffectBonusEffectLinks(effect eEffect);

effect JXSetEffectSubtype(effect eEffect, int iSubtype);

// call it in postcast script;
void JXClearEffectModifiers();



//========================================= Implementation ================================


//=============================================== effect modifier setup =============================================================


// passing modifier parameters

int JXEffectModOpParamInt(int iValue)
{
    // find first unset param index
    int i = 1;
    while (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i)))
    {
        i++;
    }
    // mark that ith param is set
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i), TRUE);
    // Set first param type
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_TYPES, i), JX_TYPE_INT);
    // set the param value
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, i), iValue);
    return 1;
}

int JXEffectModOpParamFloat(float fValue)
{
    // find first unset param index
    int i = 1;
    while (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i)))
    {
        i++;
    }
    // mark that ith param is set
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i), TRUE);
    // set param type
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_TYPES, i), JX_TYPE_FLOAT);
    // set the param value
    SetLocalFloat(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, i), fValue);
    return 1;
}

int JXEffectModOpParamString(string sValue)
{
    int i = 1;
    while (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i)))
    {
        i++;
    }
    // mark that ith param is set
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i), TRUE);
    // set param type
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_TYPES, i), JX_TYPE_STRING);
    // set the param value
    SetLocalString(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, i), sValue);
    return 1;
}

int JXEffectModOpParamObject(object oValue)
{
    int i = 1;
    while (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i)))
    {
        i++;
    }
    // mark that ith param is set
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i), TRUE);
    // set param type
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_TYPES, i), JX_TYPE_OBJECT);
    // set the param value
    SetLocalObject(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, i), oValue);
    return 1;
}



// curremt mod param getters

int JXGetCurrModOpParamInt(int iOpParamPos=1)
{
    JXPrintFunctionCall("JXGetCurrModOpParamInt(int iOpParamPos=1)", "Getting currently processes modifier operator paramater.", IntToString(iOpParamPos));
    // catch useless invocation
    if (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos)) == FALSE)
    {
        Log("JXGetCurrModOpParamInt called with no params set.");
        return 0;
    }
    // get the param value
    int iRes = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, iOpParamPos));
    // reset param state
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos), FALSE);
    return iRes;
}

float JXGetCurrModOpParamFloat(int iOpParamPos=1)
{
    JXPrintFunctionCall("JXGetCurrModOpParamFloat(int iOpParamPos=1)", "Getting currently processes modifier operator paramater.", IntToString(iOpParamPos));
    // catch useless invocation
    if (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos)) == FALSE)
    {

        Log("JXGetCurrModOpParamFloat called with no params set.");
        return 0.0f;
    }
    // get the param value
    float fRes = GetLocalFloat(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, iOpParamPos));
    // reset param state
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos), FALSE);
    return fRes;
}

string JXGetCurrModOpParamString(int iOpParamPos=1)
{

    JXPrintFunctionCall("JXGetCurrModOpParamString(int iOpParamPos=1)", "Getting currently processes modifier operator paramater.", IntToString(iOpParamPos));
    if (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos)) == FALSE)
    {

        Log("JXGetCurrModOpParamString called with no params set.");
        return "";
    }
    // get the param value
    string sRes = GetLocalString(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, iOpParamPos));
    // reset param state
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos), FALSE);
    return sRes;
}

object JXGetCurrModOpParamObject(int iOpParamPos=1)
{

    JXPrintFunctionCall("JXGetCurrModOpParamObject(int iOpParamPos=1)", "Getting currently processes modifier operator paramater.", IntToString(iOpParamPos));
    if (GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos)) == FALSE)
    {

        Log("JXGetCurrModOpParamObject called with no params set.");
        return OBJECT_INVALID;
    }
    // get the param value
    object oRes = GetLocalObject(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAMS, iOpParamPos));
    // reset param state
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iOpParamPos), FALSE);
    return oRes;
}


int JXGetCurrModOpParamType(int iParamPos)
{
    int iRes = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_TYPES, iParamPos));
    JXPrintFunctionCall("JXGetCurrModOpParamType(int iParamPos)", "", IntToString(iParamPos));
    return iRes;
}

int JXIsCurrModOpParamSet(int iParamPos)
{
    int iRes = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, iParamPos));
    JXPrintFunctionCall("JXIsCurrModOpParamSet(int iParamPos)", "", IntToString(iParamPos));
    return iRes;
}

void JXClearCurrModOpParams()
{
    int i;
    for (i = 0; i<=8 ;i++)
    {
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_CURR_MOD_OP_PARAM_STATES, i), FALSE);
    }
}


void JXTypeError(int iPassedType, int iExpectedType1=0, int iExpectedType2=0, int iExpectedType3=0, int iExpectedType4=0, int iExpectedType5=0)
{
    string sErrMsg = "Type Error: passed argument of type " + JXTypeName(iPassedType);
    string sExMsg = "Expected ";
    if (iExpectedType1 != 0) sExMsg = sExMsg + "or " + JXTypeName(iExpectedType1) + " ";
    if (iExpectedType2 != 0) sExMsg = sExMsg + "or " + JXTypeName(iExpectedType2) + " ";
    if (iExpectedType3 != 0) sExMsg = sExMsg + "or " + JXTypeName(iExpectedType3) + " ";
    if (iExpectedType4 != 0) sExMsg = sExMsg + "or " + JXTypeName(iExpectedType4) + " ";
    if (iExpectedType5 != 0) sExMsg = sExMsg + "or " + JXTypeName(iExpectedType5) + " ";

    Log(sErrMsg, "red");
    Log(sExMsg, "red");
}


// JXAddEffectModifier(JX_EFFECT_TYPE_HEAL, JX_EFFECT_MOD_TYPE_PARAM_1, JX_EFFECT_MOD_PARAM_INCREASE_BY, JXEffectModArgInt(40));

void JXAddEffectModifier(int iEffectType, int iModType, int iModOp=0, int iModParam1=0, int iModParam2=0, int iModParam3=0, int iModParam4=0, int iModParam5=0, int iModParam6=0, int iModParam7=0)
{
    JXPrintFunctionCall("JXAddEffectModifier(int iEffectType, int iModtype, int iModOp, ...)", "Adding effect modifier to locally saved modifiers", JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp));

    Log("Modifying effect " + JXEffectName(iEffectType));
    Log("Modifier type: " + JXModName(iModType));
    Log("Modifier operator type: " + JXModOpName(iModOp));


    //##################################################################
    // disabling effects
    //###################################################################
    if (iModType == JX_EFFECT_MOD_TYPE_DISABLE_EFFECT)
    {
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_ENABLED, iEffectType), FALSE);
    }

    //################################################################
    // effect parameter modifications
    //################################################################
    if (iModType >= JX_EFFECT_MOD_TYPE_PARAM_1 && iModType <= JX_EFFECT_MOD_TYPE_PARAM_9)
    {
        Log("Adding effect parameter modification");
        switch (iModOp)
        {
            // increases can be accumulate dby adding modifier values
            case JX_EFFECT_MOD_OP_PARAM_INCREASE_BY:
            case JX_EFFECT_MOD_OP_PARAM_DECREASE_BY:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_INT:
                    {
                        int iModOpParam1Value = JXGetCurrModOpParamInt(1);

                        int iOldModOpParam1Value;
                        if (JXIsCurrModOpParamSet(1))
                        {
                            iOldModOpParam1Value = JXGetModOpParamValueInt(iEffectType, iModType, iModOp, 1);
                        } else
                        {
                            iOldModOpParam1Value = JX_INT_ADD_ID;
                        }
                        JXSetModOpParamValueInt(iEffectType, iModType, iModOp, 1, iModOpParam1Value + iOldModOpParam1Value);
                        break;
                    }
                    case JX_TYPE_FLOAT:
                    {
                        float fModOpParam1Value = JXGetCurrModOpParamFloat(1);
                        float fOldModOpParam1Value;
                        if (JXIsCurrModOpParamSet(1))
                        {
                            fOldModOpParam1Value = JXGetModOpParamValueFloat(iEffectType, iModType, iModOp, 1);
                        } else
                        {
                            fOldModOpParam1Value = JX_FLOAT_ADD_ID;
                        }
                        JXSetModOpParamValueFloat(iEffectType, iModType, iModOp, 1, fModOpParam1Value + fOldModOpParam1Value);
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_INT, JX_TYPE_FLOAT);
                    }
                }
                break;
            }
            // multipliers and dividers are accumulated by multiplying modifier values
            case JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY:
            case JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_INT:
                    {
                        int iModOpParam1Value = JXGetCurrModOpParamInt(1);

                        int iOldModOpParam1Value;
                        if (JXIsCurrModOpParamSet(1))
                        {
                            iOldModOpParam1Value = JXGetModOpParamValueInt(iEffectType, iModType, iModOp, 1);
                        } else
                        {
                            iOldModOpParam1Value = JX_INT_MULTIPLY_ID;
                        }
                        JXSetModOpParamValueInt(iEffectType, iModType, iModOp, 1, iModOpParam1Value * iOldModOpParam1Value);
                        break;
                    }
                    case JX_TYPE_FLOAT:
                    {
                        float fModOpParam1Value = JXGetCurrModOpParamFloat(1);

                        float fOldModOpParam1Value;
                        if (JXIsCurrModOpParamSet(1))
                        {
                            fOldModOpParam1Value = JXGetModOpParamValueFloat(iEffectType, iModType, iModOp, 1);
                        } else
                        {
                            fOldModOpParam1Value = JX_FLOAT_MULTIPLY_ID;
                        }
                        JXSetModOpParamValueFloat(iEffectType, iModType, iModOp, 1, fModOpParam1Value * fOldModOpParam1Value);
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_INT, JX_TYPE_FLOAT);
                    }
                }
                break;
            }
            // random increases are accumulated by saving all dice roll info and rolling at effect creation
            case JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND:
            case JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_STRING:
                    {
                        // param stored as 4d6;2d8 etc
                        string sModOpParam1Value = JXGetCurrModOpParamString(1);

                        string sOldModOpParam1Value;
                        if (JXIsCurrModOpParamSet(1))
                        {
                            sOldModOpParam1Value = JXGetModOpParamValueString(iEffectType, iModType, iModOp, 1);
                            sOldModOpParam1Value = ";" + sOldModOpParam1Value;
                        } else
                        {
                            sOldModOpParam1Value = JX_STRING_CONCAT_ID;
                        }
                        JXSetModOpParamValueString(iEffectType, iModType, iModOp, 1, sOldModOpParam1Value + sModOpParam1Value);
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_STRING);
                    }

                }
                break;
            }
            // random multipliers are accumulated by saving all dice roll info and rolling at effect creation
            case JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND:
            case JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_STRING:
                    {
                        string sModOpParam1Value = JXGetCurrModOpParamString(1);

                        string sOldModOpParam1Value = JXGetModOpParamValueString(iEffectType, iModType, iModOp, 1);
                        JXSetModOpParamValueString(iEffectType, iModType, iModOp, 1, sOldModOpParam1Value + ";" + sModOpParam1Value);
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_STRING);
                    }

                }
                break;
            }
            // param maximum is accumulated by overriding the old maximum if it is larger
            case JX_EFFECT_MOD_OP_PARAM_MAX:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_INT:
                    {
                        int iModOpParam1Value = JXGetCurrModOpParamInt(1);

                        int iOldModOpParam1Value = JXGetModOpParamValueInt(iEffectType, iModType, iModOp, 1);
                        if (iOldModOpParam1Value > iModOpParam1Value)
                        {
                            iModOpParam1Value = iOldModOpParam1Value;
                        }
                        JXSetModOpParamValueInt(iEffectType, iModType, iModOp, 1, iModOpParam1Value);
                        break;
                    }
                    case JX_TYPE_FLOAT:
                    {
                        float fModOpParam1Value = JXGetCurrModOpParamFloat(1);

                        float fOldModParam1Value = JXGetModOpParamValueFloat(iEffectType, iModType, iModOp, 1);
                        if (fOldModParam1Value > fModOpParam1Value)
                        {
                            float fModOpParam1Value = fOldModParam1Value;
                        }
                        JXSetModOpParamValueFloat(iEffectType, iModType, iModOp, 1, fModOpParam1Value);
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_INT, JX_TYPE_FLOAT);
                    }
                }
                break;
            }
            // param minimum is accumulated by overriding the old minimum if is is smaller
            case JX_EFFECT_MOD_OP_PARAM_MIN:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_INT:
                    {
                        int iModOpParam1Value = JXGetCurrModOpParamInt(1);

                        int iOldModOpParam1Value = JXGetModOpParamValueInt(iEffectType, iModType, iModOp, 1);
                        if (iOldModOpParam1Value < iModOpParam1Value)
                        {
                            iModOpParam1Value = iOldModOpParam1Value;
                        }
                        JXSetModOpParamValueInt(iEffectType, iModType, iModOp, 1, iModOpParam1Value);
                        break;
                    }
                    case JX_TYPE_FLOAT:
                    {
                        float fModOpParam1Value = JXGetCurrModOpParamFloat(1);

                        float fOldModOpParam1Value = JXGetModOpParamValueFloat(iEffectType, iModType, iModOp, 1);
                        if (fOldModOpParam1Value < fModOpParam1Value)
                        {
                            float fModOpParam1Value = fOldModOpParam1Value;
                        }
                        JXSetModOpParamValueFloat(iEffectType, iModType, iModOp, 1, fModOpParam1Value);
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_INT, JX_TYPE_FLOAT);
                    }
                }
                break;
            }
            // param override mod is not accumulated, it always replaces the last one
            case JX_EFFECT_MOD_OP_PARAM_OVERRIDE:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_INT:
                    {
                        JXSetModOpParamValueInt(iEffectType, iModType, iModOp, 1, JXGetCurrModOpParamInt(1));
                        break;
                    }
                    case JX_TYPE_FLOAT:
                    {
                        JXSetModOpParamValueFloat(iEffectType, iModType, iModOp, 1, JXGetCurrModOpParamFloat(1));
                        break;
                    }
                    case JX_TYPE_STRING:
                    {

                        JXSetModOpParamValueString(iEffectType, iModType, iModOp, 1, JXGetCurrModOpParamString(1));
                        break;
                    }
                    case JX_TYPE_OBJECT:
                    {
                        JXSetModOpParamValueObject(iEffectType, iModType, iModOp, 1, JXGetCurrModOpParamObject(1));
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_INT, JX_TYPE_FLOAT, JX_TYPE_STRING, JX_TYPE_OBJECT);
                    }
                }

            }
            case JX_EFFECT_MOD_OP_PARAM_MAP:
            {
                int iModOpParam1Type = JXGetCurrModOpParamType(1);
                // we assume that second map param has the same type
                switch (iModOpParam1Type)
                {
                    case JX_TYPE_INT:
                    {
                        int iModOpParam1Value = JXGetCurrModOpParamInt(1);
                        int iModOpParam2Value = JXGetCurrModOpParamInt(2);
                        string sRepr = IntToString(iModOpParam1Value) + ":" + IntToString(iModOpParam2Value);
                        string sOld = JXGetModOpParamValueString(iEffectType, iModType, iModOp, 1);
                        sRepr = sRepr + ";" + sOld;
                        JXSetModOpParamValueString(iEffectType, iModType, iModOp, 1, sRepr);
                        break;
                    }
                    case JX_TYPE_FLOAT:
                    {
                        float fModOpParam1Value = JXGetCurrModOpParamFloat(1);
                        float fModOpParam2Value = JXGetCurrModOpParamFloat(2);
                        string sRepr = FloatToString(fModOpParam1Value) + ":" + FloatToString(fModOpParam2Value);
                        string sOld = JXGetModOpParamValueString(iEffectType, iModType, iModOp, 1);
                        sRepr = sRepr + ";" + sOld;
                        JXSetModOpParamValueString(iEffectType, iModType, iModOp, 1, sRepr);
                        break;
                    }
                    case JX_TYPE_STRING:
                    {
                        string sModOpParam1Value = JXGetCurrModOpParamString(1);
                        string sModOpParam2Value = JXGetCurrModOpParamString(2);
                        string sRepr = sModOpParam1Value + ":" + sModOpParam2Value;
                        string sOld = JXGetModOpParamValueString(iEffectType, iModType, iModOp, 1);
                        sRepr = sRepr + ";" + sOld;
                        JXSetModOpParamValueString(iEffectType, iModType, iModOp, 1, sRepr);
                        break;
                    }
                    case JX_TYPE_OBJECT:
                    {
                        object oModOpParam1Value = JXGetCurrModOpParamObject(1);
                        object oModOpParam2Value = JXGetCurrModOpParamObject(2);
                        string sRepr = ObjectToString(oModOpParam1Value) + ":" + ObjectToString(oModOpParam2Value);
                        string sOld = JXGetModOpParamValueString(iEffectType, iModType, iModOp, 1);
                        sRepr = sRepr + ";" + sOld;
                        JXSetModOpParamValueString(iEffectType, iModType, iModOp, 1, sRepr);
                        break;
                    }
                    default:
                    {
                        JXTypeError(iModOpParam1Type, JX_TYPE_INT, JX_TYPE_FLOAT, JX_TYPE_STRING, JX_TYPE_OBJECT);
                    }
                }
            }
        }
        return;
    }

    // TODO: effect link + substitution modification

    if (iModType >= JX_EFFECT_MOD_TYPE_SUBSTITUTE_EFFECT && iModType <= JX_EFFECT_MOD_TYPE_LINK_EFFECT)
    {
        Log("Adding effect link + substitution modification not implemented yet...");
    }

    JXClearCurrModOpParams();
    return;
}




void JXSetModOpParamValueInt(int iEffectType, int iModType, int iModOp, int iParamPos, int iValue)
{
    JXPrintFunctionCall("JXSetModOpParamValueInt(int iEffectType, int iModType, int iModOp, int iParamPos, int iValue)", "Saving modifier parameters" , JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos), IntToString(iValue));
    // check status
    int iModStatus = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    if (!iModStatus)
    {
        // if status is 0, set to 1 and initiialize value
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos), 1);
        // set type
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_TYPES, iEffectType, iModType, iModOp, iParamPos), JX_TYPE_INT);
    }
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iParamPos), iValue);
}

void JXSetModOpParamValueFloat(int iEffectType, int iModType, int iModOp, int iParamPos, float fValue)
{
    JXPrintFunctionCall("JXSetModOpParamValueFloat(int iEffectType, int iModType, int iModOp, int iParamPos, float fValue)", "Saving modifier parameters" , JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos), FloatToString(fValue));
    int iModStatus = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    if (!iModStatus)
    {
        // if status is 0, set to 1 and initiialize value
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos), 1);
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_TYPES, iEffectType, iModType, iModOp, iParamPos), JX_TYPE_FLOAT);
    }
    SetLocalFloat(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iParamPos), fValue);
}

void JXSetModOpParamValueString(int iEffectType, int iModType, int iModOp, int iParamPos, string sValue)
{
    JXPrintFunctionCall("JXSetModOpParamValueString(int iEffectType, int iModType, int iModOp, int iParamPos, string sValue)", "Saving modifier parameters" , JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos), sValue);
    int iModStatus = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    if (!iModStatus)
    {
        // if status is 0, set to 1 and initiialize value
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos), 1);
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_TYPES, iEffectType, iModType, iModOp, iParamPos), JX_TYPE_STRING);
    }
    SetLocalString(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iParamPos), sValue);
}

void JXSetModOpParamValueObject(int iEffectType, int iModType, int iModOp, int iParamPos, object oValue)
{
    JXPrintFunctionCall("JXSetModOpParamValueObject(int iEffectType, int iModType, int iModOp, int iParamPos, object oValue)", "Saving modifier parameters" , JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos), ObjectToString(oValue));
    int iModStatus = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    if (!iModStatus)
    {
        // if status is 0, set to 1 and initiialize value
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos), 1);
        SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_TYPES, iEffectType, iModType, iModOp, iParamPos), JX_TYPE_OBJECT);
    }
    SetLocalObject(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iParamPos), oValue);
}

int JXGetModOpParamValueInt(int iEffectType, int iModType, int iModOp, int iParamPos)
{
    int iRes = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    JXPrintFunctionCall("JXGetModOpParamValueInt(int iEffectType, int iModType, int iModOp, int iParamPos)", "Returning integer " + IntToString(iRes), JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos));
    return iRes;
}

float JXGetModOpParamValueFloat(int iEffectType, int iModType, int iModOp, int iParamPos)
{
    float fRes = GetLocalFloat(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    JXPrintFunctionCall("JXGetModOpParamValueFloat(int iEffectType, int iModType, int iModOp, int iParamPos)", "Returning float " + FloatToString(fRes), JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos));
    return fRes;
}

string JXGetModOpParamValueString(int iEffectType, int iModType, int iModOp, int iParamPos)
{
    string sRes = GetLocalString(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    JXPrintFunctionCall("JXGetModOpParamValueString(int iEffectType, int iModType, int iModOp, int iParamPos)", "Returning string " + sRes, JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos));
    return sRes;
}

object JXGetModOpParamValueObject(int iEffectType, int iModType, int iModOp, int iParamPos)
{
    object oRes = GetLocalObject(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iParamPos));
    JXPrintFunctionCall("JXGetModOpParamValueObject(int iEffectType, int iModType, int iModOp, int iParamPos)", "Returning object " + ObjectToString(oRes), JXEffectName(iEffectType), JXModName(iModType), JXModOpName(iModOp), IntToString(iParamPos));
    return oRes;
}

void JXDisableEffect(int iEffectType)
{
    JXPrintFunctionCall("JXDisableEffect(int iEffectType)", "", JXEffectName(iEffectType));
    SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_ENABLED, iEffectType), TRUE);
}

int JXIsEffectDisabled()
{
    int iEffectType = JXGetModifiedEffectType();
    return GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_ENABLED, iEffectType)) == TRUE;
}


//==================================================================== effect creation functions =====================================================


void JXStartEffectMod(int iEffectType)
{
    SetLocalInt(OBJECT_SELF, JX_EFFECT_CURRENT, iEffectType);
}

void JXEndEffectMod()
{
    SetLocalInt(OBJECT_SELF, JX_EFFECT_CURRENT, 0);
}

int JXGetModifiedEffectType()
{
    return GetLocalInt(OBJECT_SELF, JX_EFFECT_CURRENT);
}


//


int JXIsEffectModOpParamSet(int iModType, int iModOp, int iOpParamPosition=1)
{
    int iEffectType = JXGetModifiedEffectType();
    JXPrintFunctionCall("JXIsEffectModOpParamSet(int iModType, int iModOp, int iOpParamPosition=1)", "Checking if Modifier op param is set", JXModName(iModType), JXModOpName(iModOp), IntToString(iOpParamPosition));
    return GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffectType, iModType, iModOp, iOpParamPosition));
}

int JXGetEffectModParamInt(int iModType, int iModOp, int iOpParamPosition=1)
{
    int iEffectType = JXGetModifiedEffectType();
    int iValue = GetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iOpParamPosition));
    JXPrintFunctionCall("JXGetEffectModParamInt(int iModType, int iModOp, int iOpParamPosition=1)", "Getting integer mod parameter", JXModName(iModType), JXModOpName(iModOp), IntToString(iOpParamPosition));
    return iValue;
}

float JXGetEffectModParamFloat(int iModType, int iModOp, int iOpParamPosition=1)
{
    int iEffectType = JXGetModifiedEffectType();
    float fValue = GetLocalFloat(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iOpParamPosition));
    JXPrintFunctionCall("JXGetEffectModParamFloat(int iModType, int iModOp, int iOpParamPosition=1)", "Getting float mod parameter", JXModName(iModType), JXModOpName(iModOp), IntToString(iOpParamPosition));
    return fValue;
}

string JXGetEffectModParamString(int iModType, int iModOp, int iOpParamPosition=1)
{
    int iEffectType = JXGetModifiedEffectType();
    string sValue = GetLocalString(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iOpParamPosition));
    JXPrintFunctionCall("JXGetEffectModParamString(int iModType, int iModOp, int iOpParamPosition=1)", "Getting string mod parameter", JXModName(iModType), JXModOpName(iModOp), IntToString(iOpParamPosition));
    return sValue;
}

object JXGetEffectModParamObject(int iModType, int iModOp, int iOpParamPosition=1)
{
    int iEffectType = JXGetModifiedEffectType();
    object oValue = GetLocalObject(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAMS, iEffectType, iModType, iModOp, iOpParamPosition));
    JXPrintFunctionCall("JXGetEffectModParamObject(int iModType, int iModOp, int iOpParamPosition=1)", "Getting object mod parameter", JXModName(iModType), JXModOpName(iModOp), IntToString(iOpParamPosition));
    return oValue;

}


// applying modifiers

effect JXApplyEffectPropertyModifiers(effect eEffect)
{
    // TODO: decide when to apply effect property modifiers
    // int iSubtype;
    // int iEffectType = JXGetModifiedEffectType();

    // int iRacialType = JXGetEffectModParamInt(JX_EFFECT_MOD_TYPE_EFFECT_PROP, JX_EFFECT_MOD_PROP_VS_RACIAL);
    // if (iRacialType != 0) eEffect = VersusRacialTypeEffect(eEffect, iRacialType);

    // int iLawChaos = JXGetEffectModParamInt(JX_EFFECT_MOD_TYPE_EFFECT_PROP, JX_EFFECT_MOD_PROP_VS_ALIGN);
    // int iGoodEvil = JXGetEffectModParamInt(JX_EFFECT_MOD_TYPE_EFFECT_PROP, JX_EFFECT_MOD_PROP_VS_ALIGN, 2);
    // if (iGoodEvil == 0 || iLawChaos == 0) eEffect = VersusAlignmentEffect(eEffect, iLawChaos, iGoodEvil);

    // int iSubtype = JXGetEffectModParamInt(JX_EFFECT_MOD_TYPE_EFFECT_PROP, JX_EFFECT_MOD_PROP_SUBTYPE);
    // if (iSubtype !=  0) eEffect = JXSetEffectSubtype(eEffect, iSubType);

    return eEffect;
}



int JXApplyEffectParamModifiers_Int(int iValue, int iEffectParamPosition=1)
{

    JXPrintFunctionCall("JXApplyEffectParamModifiers_Int(int iValue, int iEffectParamPosition=1)", "applying int parameter modifiers", IntToString(iValue), IntToString(iEffectParamPosition));
    int iEffectType = JXGetModifiedEffectType();

    // FLAT INCREASE
    int iFlatIncrease = JX_INT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY))
    {
        iFlatIncrease = JXGetEffectModParamInt(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY);
    }

    // FLAT DECREASE
    int iFlatDecrease = JX_INT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY))
    {
        iFlatDecrease = JXGetEffectModParamInt(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY);
    }

    // MULTIPLIER
    float fMultiplier = JX_FLOAT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY))
    {
        fMultiplier = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY);
    }

    // DIVIDER
    float fDivider = JX_FLOAT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY))
    {
        fDivider = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY);
    }

    // FIXME: actually implement this
    // int iOr = JXGetEffectModParamInt(JX_EFFECT_MOD_PARAM_LOGIC_OR);
    // int iAnd = JXGetEffectModParamInt(JX_EFFECT_MOD_PARAM_LOGIC_AND);

    int iOr = JX_INT_OR_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_LOGIC_OR))
    {
        iOr = JXGetEffectModParamInt(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_LOGIC_OR);
    }

    int iAnd = iValue;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_LOGIC_AND))
    {
        iAnd = JXGetEffectModParamInt(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_LOGIC_AND);
    }

    int iRandIncrease = JX_INT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            iRandIncrease = iRandIncrease + RollDice(iDiceNum, iDice);
        }
    }

    int iRandDecrease = JX_INT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            iRandDecrease = iRandDecrease + RollDice(iDiceNum, iDice);
        }
    }


    int iRandMultiply = JX_INT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            iRandMultiply = iRandMultiply * RollDice(iDiceNum, iDice);
        }
    }

    int iRandDivide = JX_INT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            iRandDivide = iRandDivide * RollDice(iDiceNum, iDice);
        }
    }

    // value map applied first
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP);
        int iFrom, iTo;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sCell = GetNextToken(sTok);
            iFrom = StringToInt(GetTokenByPosition(sCell, ":", 0));
            iTo = StringToInt(GetTokenByPosition(sCell, ":", 1));
            if (iValue == iFrom)
            {
                iValue = iTo;
                break;
            }
        }
    }

    // apply multiplication
    iValue = FloatToInt(fMultiplier * (1 / fDivider) * IntToFloat(iRandMultiply) * (1 / IntToFloat(iRandDivide)) * IntToFloat(iValue));

    // apply flat changes
    iValue = iValue + iFlatIncrease - iFlatDecrease + iRandIncrease - iRandDecrease;


    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAX))
    {
        int iMax = JXGetEffectModParamInt(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAX);
        if (iMax != 0 && iValue > iMax) iValue = iMax;
    }

    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MIN))
    {
        int iMin = JXGetEffectModParamInt(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MIN);
        if (iMin != 0 && iValue < iMin) iValue = iMin;
    }

    // apply logical modifiers
    iValue = iValue | iOr;
    iValue = iValue & iAnd;

    return iValue;
}

float JXApplyEffectParamModifiers_Float(float fValue, int iEffectParamPosition=1)
{
    JXPrintFunctionCall("JXApplyEffectParamModifiers_Float(float fValue, int iEffectParamPosition=1)", "applying int parameter modifiers", FloatToString(fValue), IntToString(iEffectParamPosition));
    int iEffectType = JXGetModifiedEffectType();

    float fFlatIncrease = JX_FLOAT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY))
    {
        fFlatIncrease = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY);
    }

    float fFlatDecrease = JX_FLOAT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY))
    {
        fFlatDecrease = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY);
    }

    float fMultiplier = JX_FLOAT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY))
    {
        fMultiplier = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY);
    }

    float fDivider = JX_FLOAT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY))
    {
        fDivider = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY);
    }


    float fRandIncrease = JX_FLOAT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            fRandIncrease = fRandIncrease + IntToFloat(RollDice(iDiceNum, iDice));
        }
    }

    float fRandDecrease = JX_FLOAT_ADD_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            fRandDecrease = fRandDecrease + IntToFloat(RollDice(iDiceNum, iDice));
        }
    }


    float fRandMultiply = JX_FLOAT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            fRandMultiply = fRandMultiply * IntToFloat(RollDice(iDiceNum, iDice));
        }
    }

    float fRandDivide = JX_FLOAT_MULTIPLY_ID;
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND);

        int iDice, iDiceNum;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sDiceInfo = GetNextToken(sTok);
            iDiceNum = StringToInt(GetTokenByPosition(sDiceInfo, "d", 0));
            iDice = StringToInt(GetTokenByPosition(sDiceInfo, "d", 1));
            fRandDivide = fRandDivide * IntToFloat(RollDice(iDiceNum, iDice));
        }
    }

    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP);
        string sFrom;
        float fFrom, fTo;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sCell = GetNextToken(sTok);
            sFrom = GetTokenByPosition(sCell, ":", 0);
            fTo = StringToFloat(GetTokenByPosition(sCell, ":", 1));
            // compare string representation as the conversion from string is lossy
            if (FloatToString(fValue) == sFrom)
            {
                fValue = fTo;
                break;
            }
        }
    }

    // apply multiplication
    fValue = fMultiplier * fRandMultiply *  (1 / fDivider) * (1 / fRandDivide) * fValue;

    // apply flat changes
    fValue = fValue + fFlatIncrease + fRandIncrease - fFlatDecrease - fRandDecrease;


    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAX))
    {
        float fMax = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAX);
        if (fMax != -1.0f && fValue > fMax) fValue = fMax;
    }

    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MIN))
    {
        float fMin = JXGetEffectModParamFloat(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MIN);
        if (fMin != -1.0f && fValue < fMin) fValue = fMin;
    }

    return fValue;
}

string JXApplyEffectParamModifiers_String(string sValue, int iEffectParamPosition=1)
{
    JXPrintFunctionCall("JXApplyEffectParamModifiers_String(string sValue, int iEffectParamPosition=1)", "applying string parameter modifiers", sValue, IntToString(iEffectParamPosition));
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP);
        string sFrom, sTo;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sCell = GetNextToken(sTok);
            sFrom = GetTokenByPosition(sCell, ":", 0);
            sTo = GetTokenByPosition(sCell, ":", 1);
            if (sValue == sFrom)
            {
                sValue = sTo;
                break;
            }
        }
    }

    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_OVERRIDE))
    {
        // override takes precedence
        string sOverrideValue = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_OVERRIDE);
        if (sOverrideValue != "") sValue = sOverrideValue;
    }

    return sValue;
}

object JXApplyEffectParamModifiers_Object(object oValue, int iEffectParamPosition=1)
{
    JXPrintFunctionCall("JXApplyEffectParamModifiers_Object(object oValue, int iEffectParamPosition=1)", "applying string parameter modifiers", ObjectToString(oValue), IntToString(iEffectParamPosition));
    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP))
    {
        string sRepr = JXGetEffectModParamString(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_MAP);
        object oFrom, oTo;
        struct sStringTokenizer sTok = GetStringTokenizer(sRepr, ";");
        while(HasMoreTokens(sTok))
        {
            sTok = AdvanceToNextToken(sTok);
            string sCell = GetNextToken(sTok);
            oFrom = StringToObject(GetTokenByPosition(sCell, ":", 0));
            oTo = StringToObject(GetTokenByPosition(sCell, ":", 1));
            if (oValue == oFrom)
            {
                oValue = oTo;
                break;
            }
        }
    }

    if (JXIsEffectModOpParamSet(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_OVERRIDE))
    {
        // override takes precedence
        object oOverrideValue = JXGetEffectModParamObject(iEffectParamPosition, JX_EFFECT_MOD_OP_PARAM_OVERRIDE);
        if (oOverrideValue != OBJECT_INVALID) oValue = oOverrideValue;
    }

    return oValue;
}


effect JXApplyEffectBonusEffectLinks(effect eEffect)
{
    int iEffectType = JXGetModifiedEffectType();
    return eEffect;
}

effect JXSetEffectSubtype(effect eEffect, int iSubtype)
{
    switch(iSubtype)
    {
        case SUBTYPE_MAGICAL: return MagicalEffect(eEffect);
        case SUBTYPE_SUPERNATURAL: return SupernaturalEffect(eEffect);
        case SUBTYPE_EXTRAORDINARY: return ExtraordinaryEffect(eEffect);
    }
    return eEffect;
}

// called in postcast script
void JXClearEffectModifiers()
{
    int iEffect = 1;
    int iMod = 1;
    int iModOp = 1;
    while (iEffect < JX_EFFECT_MAX_ID)
    {
        while (iMod < JX_EFFECT_MOD_TYPE_MAX_ID)
        {
            while (iModOp < JX_EFFECT_MOD_OP_MAX_ID)
            {
                SetLocalInt(OBJECT_SELF, ArrayAt(JX_EFFECT_MOD_OP_PARAM_STATES, iEffect, iMod, iModOp), FALSE);
                iModOp++;
            }
            iMod++;
        }
        iEffect++;
    }
}
