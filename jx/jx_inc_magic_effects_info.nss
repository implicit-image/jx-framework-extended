#include "x0_i0_stringlib"


//====================================================== Declarations ====================================================

struct jx_effect JXMakeEffect(effect eBaseEffect, int iEffectType=-1);

struct jx_effect JXEffectLinkEffects(struct jx_effect Child, struct jx_effect Parent);

struct jx_effect JXEffectLinkNormalEffect(struct jx_effect Effect, effect eEffect, int iEffectType=-1);

int JXGetEffectHasCompatibleDurationType(int iEffectType, int iDurationType);

int JXEffectLinkHasType(struct jx_effect e, int iEffectType);

string JXEffectTypeString(int iEffectType);

struct jx_effect JXCreateCustomEffect(int iEffectType, string sArg1="", string sArg2="", string sArg3="", string sArg4="", string sArg5="", string sArg6="");

int JXGetEffectParamInt(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1);

float JXGetEffectParamFloat(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1);

string JXGetEffectParamString(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1);

object JXGetEffectParamObject(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1);

// ====================================================== Implementation ====================================================

struct jx_effect
{
    // linked effects
    effect eLink
    // string listing types of linked effects
    string types;
    // the subtypee of the link
    int subtype;
    // how many effects are linked
    int count;
    // list of linked effect types
    string effects;
    // effect constructor arguments
    string params;
    // which triggers this effect activate; see jx_inc_magic_effects_triggers
    string triggers;
    // what statuses this effect link applies; see jx_inc_magic_effects_status
    string status;
    // TRUE if the effect has custom effects linked , ie not created using vanilla Effect* constructors
    int has_custom;
    int _dur_instant;
    int _dur_temporary;
    int _dur_permanent;
    int _is_valid;
};

// pass EFFECT_TYPE_* to iEffectType if passed eBaseEffect cant be
// examined using GetEffectType()
// eBaseEffect cannot be a link
struct jx_effect JXMakeEffect(effect eBaseEffect, struct script_param_list params, int iEffectType=EFFECT_TYPE_INVALIDEFFECT)
{
    if (iEffectType == EFFECT_TYPE_INVALIDEFFECT)
    {
        iEffectType = GetEffectType(eBaseEffect);
    }
    struct jx_effect Effect;
    Effect.eLink = eBaseEffect;
    Effect.types = "|" + JXEffectTypeString(iEffectType);
    Effect.count = 1;
    Effect.effects = "";
    Effect.params = ":" + params.sParamList + ":";
    Effect.subtype = SUBTYPE_MAGICAL;
    Effect.triggers = "";
    Effect.status = "";
    Effect._dur_instant = JXGetEffectHasCompatibleDurationType(iEffectType, DURATION_TYPE_INSTANT);
    Effect._dur_temporary = JXGetEffectHasCompatibleDurationType(iEffectType, DURATION_TYPE_TEMPORARY);
    Effect._dur_permanent = JXGetEffectHasCompatibleDurationType(iEffectType, DURATION_TYPE_PERMANENT);
    Effect._is_valid = iEffectType != EFFECT_TYPE_INVALIDEFFECT;
    return Effect;
}

struct jx_effect JXEffectLinkEffects(struct jx_effect Child, struct jx_effect Parent)
{
    if (Parentheses)
    Parent.eLink = EffectLinkEffects(Child.eLink, Parent.Elink);
    Parent.types = Child.types + Parent.types;
    Parent.count = Parent.count + Child.count;
    return Parent;
}

struct jx_effect JXEffectLinkNormalEffect(struct jx_effect Effect, effect eEffect, int iEffectType=-1)
{
    if (iEffectType == -1)
    {
        iEffectType = GetEffectType(eEffect);
    }


    string sEffectType = JXEffectTypeString(iEffectType);
    Effect.eLink = EffectLinkEffects(eEffect, Effect.eLink);
    if (!FindSubString(Effect.types, sEffectType) && iEffectType != 0)
    {
        Effect.types = Effect.types + sEffectType;
    }
    Effect.count += 1;
    return Effect;
}

string JXEffectTypeString(int iEffectType)
{
    return "|" + IntToString(iEffectType) + "|";
}

int JXEffectLinkHasType(struct jx_effect e, int iEffectType)
{
    return FindSubString(e.types, JXEffectTypeString(iEffectType)) != -1;
}


int JXGetEffectHasCompatibleDurationType(int iEffectType, int iDurationType)
{
    switch(iDurationType)
    {
        case DURATION_TYPE_INSTANT:
        {
            switch (iEffectType)
            {
                case JX_EFFECT_HEAL:
                case JX_EFFECT_DAMAGE:
                case JX_EFFECT_RESURRECTION:
                case JX_EFFECT_DEATH:
                case JX_EFFECT_TURNED:
                case JX_EFFECT_HIDEOUS_BLOW:
                case JX_EFFECT_DESINTEGRATE:
                case JX_EFFECT_BREAK_ENCHANTMENT:
                {
                    return TRUE;
                }
                default: return FALSE;
            }
        }
        case DURATION_TYPE_TEMPORARY:
        {
            switch(iEffectType)
            {
                case JX_EFFECT_HEAL:
                case JX_EFFECT_DAMAGE:
                case JX_EFFECT_RESURRECTION:
                case JX_EFFECT_DEATH:
                case JX_EFFECT_TURNED:
                case JX_EFFECT_HIDEOUS_BLOW:
                case JX_EFFECT_DESINTEGRATE:
                case JX_EFFECT_BREAK_ENCHANTMENT:
                case JX_EFFECT_CURSE:
                {
                    return FALSE;
                }
                default: return TRUE;
            }
        }
        case DURATION_TYPE_PERMANENT:
        {
            switch(iEffectType)
            {
                case JX_EFFECT_HEAL:
                case JX_EFFECT_DAMAGE:
                case JX_EFFECT_RESURRECTION:
                case JX_EFFECT_DEATH:
                case JX_EFFECT_TURNED:
                case JX_EFFECT_HIDEOUS_BLOW:
                case JX_EFFECT_DESINTEGRATE:
                case JX_EFFECT_BREAK_ENCHANTMENT:
                {
                    return FALSE;
                }
                default: return TRUE;
            }
        }
        default: return FALSE;
    }
    return FALSE;
}



struct jx_effect JXCreateCustomEffect(int iEffectType, string sArg1="", string sArg2="", string sArg3="", string sArg4="", string sArg5="", string sArg6="")
{
    struct jx_effect eRes;
    return eRes;
}

int JXGetEffectParamInt(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1)
{
    string sEffectParams = GetTokenByPosition(Effect.params, "||", iEffectIndex);
    string sParam = GetTokenByPosition(sEffectParams, "|", iParamPos);

    if (sParam == "")
    {
        return -1;
    }
    return StringToInt(sParam);
}

float JXGetEffectParamFloat(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1)
{
    string sEffectParams = GetTokenByPosition(Effect.params, "||", iEffectIndex);
    string sParam = GetTokenByPosition(sEffectParams, "|", iParamPos);

    if (sParam == "")
    {
        return -1;
    }
    return StringToFloat(sParam);
}

string JXGetEffectParamString(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1)
{
    string sEffectParams = GetTokenByPosition(Effect.params, "||", iEffectIndex);
    string sParam = GetTokenByPosition(sEffectParams, "|", iParamPos);

    if (sParam == "")
    {
        return -1;
    }
    return sParam;
}

object JXGetEffectParamObject(struct jx_effect Effect, int iParamPos=1, int iEffectIndex=1)
{
    string sEffectParams = GetTokenByPosition(Effect.params, "||", iEffectIndex);
    string sParam = GetTokenByPosition(sEffectParams, "|", iParamPos);

    if (sParam == "")
    {
        return -1;
    }
    return StringToObject(sParam);
}
