// status system for custom effects


#include "jx_inc_script_call"

int JXEffectApplyStatus(int iStatus, object oTarget, object oCaster=OBJECT_SELF);



//============================================= implementation ===============================

int JXEffectApplyStatus(int iStatus, object oTarget, object oCaster=OBJECT_SELF)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterInt(paramList, iStatus);
    paramList = JXScriptAddParameterObject(paramList, oTarget);
    paramList = JXScriptAddParameterObject(paramList, oCaster);

    JXScriptCallFork(JX_EFFECT_FORKSCRIPT, JX_FORK_EFFECT_APPLY_STATUS, paramList);

    return JXScriptGetResponseInt();
}
