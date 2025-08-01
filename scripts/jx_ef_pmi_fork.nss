#include "jx_inc_script_call"
#include "jx_effect_interface"

void main(int iJXEffectType, int iValue, int iParamPos)
{
    JXScriptSetResponseInt(
        JXImplApplyEffectParamModifier_Int(
            iJXEffectType,
            iValue,
            iParamPos));
}
