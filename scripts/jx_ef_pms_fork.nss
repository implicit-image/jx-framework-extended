#include "jx_inc_script_call"
#include "jx_effect_interface"

void main(int iJXEffectType, string sValue, int iParamPos)
{
    JXScriptSetResponseString(
        JXImplApplyEffectParamModifier_String(
            iJXEffectType,
            sValue,
            iParamPos));
}
