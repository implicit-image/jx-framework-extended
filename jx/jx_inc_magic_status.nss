


struct jx_status
{
    int status_id;
    int vfx_dur;
    int vfx_impact;
    string audio_dur;
    string audio_impact;
    string impact_script;
    string heartbeat_script;
    string finish_script;
}



struct jx_status JXMakeStatus(int iStatus, string sImpScript, string sHeartScript, string sFinishScript, int iVFXDur, int iVFXImp, string sAudioDur, string sAudioImp);

void JXApplyStatus(struct jx_status Status);

//========================================================== implementation ===========================


struct jx_status JXMakeStatus(int iStatus, string sImpScript, string sHeartScript, string sFinishScript, int iVFXDur, int iVFXImp, string sAudioDur, string sAudioImp)
{
    struct jx_status Status;
    Status.status_id = iStatus;
    Status.impact_script = sImpScript;
    Status.heartbeat_script = sHeartScript;
    Status.
    Status.vfx_dur = iVFXDur;
    Status.vfx_impact = iVFXImp;
    Status.audio_dur = sAudioDur;
    Status.audio_impact = sAudioImp;

    return Status;
}


void JXApplyStatus(struct jx_status Status)
{
    return;
}
