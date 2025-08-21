#include "jx_inc_script_call"

void main()
{
    struct script_param_list ParamList = JXScriptGetParameters();
    string sMsg = JXScriptGetParameterString(ParamList, 1);
    SpeakString(sMsg, TALKVOLUME_SHOUT);
}
