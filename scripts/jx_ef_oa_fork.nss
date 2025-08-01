#include "jx_inc_script_call"
#include "jx_effect_interface"


void main(object oCaster, object oTarget, int iEffectType)
{
    JXScriptSetResponseInt(
        JXImplOnApplySpellEffectCode(
            oCaster,
            oTarget,
            iEffectType));
}
