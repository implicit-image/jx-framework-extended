#include "jx_inc_script_call"
#include "jx_effect_interface"

void main(int iJXEffectType, float fValue, int iParamPos)
{
    JXScriptSetResponseFloat(
        JXImplApplyEffectParamModifier_Float(
            iJXEffectType,
            fValue,
            iParamPos));
}
