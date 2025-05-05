// status system for custom effects


#include "jx_inc_script_call"

int JXEffectApplyStatus(int iStatus);



//============================================= implementation ===============================

int JXEffectApplyStatus(int iStatus)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterInt(paramList, iStatus);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EFFECT_APPLY_STATUS, paramList);

    return JXScriptGetResponseInt();
}

