#include "jx_inc_script_call"
#include "jx_effect_interface"

void main(int iJXEffectType, object oValue, int iParamPos)
{
    JXScriptSetResponseObject(
        JXImplApplyEffectParamModifier_Object(
            iJXEffectType,
            oValue,
            iParamPos));
}
