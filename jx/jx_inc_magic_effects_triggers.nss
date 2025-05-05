// jx_inc_effect_triggers
// trigger system for custom effects


#include "jx_inc_script_call"

int JXEffectActivateTrigger(int iTrigger);



//============================================= implementation ===============================

int JXEffectActivateTrigger(int iTrigger)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterInt(paramList, iTrigger);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EFFECT_TRIGGER, paramList);

    return JXScriptGetResponseInt();
}
