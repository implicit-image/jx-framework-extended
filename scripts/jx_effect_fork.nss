#include "jx_inc_magic_const"
#include "jx_inc_script_call"


#include "jx_effect_interface"
#include "utils"


void main()
{
    struct script_param_list paramList;
    paramList = JXScriptGetParameters();

    int iOperation = JXScriptGetForkOperation();

    Log("Running jx_effect_fork.")

    switch (iOperation)
    {
        case JX_FORK_EFFECT_TRIGGER:
            JXImplEffectActivateTrigger(
                JXScriptGetParameterInt(paramList, 1));
            break;
        case JX_FORK_EFFECT_APPLY_STATUS:
            JXImplEffectApplyStatus(
                JXScriptGetParameterInt(paramList, 1),
                JXScriptGetParameterObject(paramList, 2),
                JXScriptGetParameterObject(paramList, 3));
            break;
        // case JX_FORK_EFFECT_PARAM_MOD_INT:
        //     JXScriptSetResponseInt(
        //         JXImplApplyEffectParamModifier_Int(
        //             JXScriptGetParameterInt(paramList, 1),
        //             JXScriptGetParameterInt(paramList, 2),
        //             JXScriptGetParameterInt(paramList, 3)));
        //     break;
        // case JX_FORK_EFFECT_PARAM_MOD_FLOAT:
        //     JXScriptSetResponseFloat(
        //         JXImplApplyEffectParamModifier_Float(
        //             JXScriptGetParameterInt(paramList, 1),
        //             JXScriptGetParameterFloat(paramList, 2),
        //             JXScriptGetParameterInt(paramList, 3)));
        //     break;
        // case JX_FORK_EFFECT_PARAM_MOD_STRING:
        //     JXScriptSetResponseString(
        //         JXImplApplyEffectParamModifier_String(
        //             JXScriptGetParameterInt(paramList, 1),
        //             JXScriptGetParameterString(paramList, 2),
        //             JXScriptGetParameterInt(paramList, 3)));
        //     break;
        // case JX_FORK_EFFECT_PARAM_MOD_OBJECT:
        //     JXScriptSetResponseObject(
        //         JXImplApplyEffectParamModifier_Object(
        //             JXScriptGetParameterInt(paramList, 1),
        //             JXScriptGetParameterObject(paramList, 2),
        //             JXScriptGetParameterInt(paramList, 3)));
        //     break;
        // case JX_FORK_EFFECT_ON_APPLY_CODE:
        //     JXScriptSetResponseInt(
        //         JXImplOnApplySpellEffectCode(
        //             JXScriptGetParameterObject(paramList, 1),
        //             JXScriptGetParameterObject(paramList, 2),
        //             JXScriptGetParameterInt(paramList, 3)));
        //     break;
        default:
            return;
    }
}
