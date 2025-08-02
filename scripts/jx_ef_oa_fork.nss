#include "jx_inc_script_call"
#include "jx_effect_interface"
#include "utils"

void main(object oCaster, object oTarget, int iEffectType)
{
    Log("Running on apply code");

    JXScriptSetResponseInt(
        JXImplOnApplySpellEffectCode(
            oCaster,
            oTarget,
            iEffectType));

    return;
}
