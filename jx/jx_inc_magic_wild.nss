
//========================================== Dead/Wild Magic ==========================================//

// Make the next/current spell ignore dead/wild magic effects
// - oCaster Caster that must ignore dead/wild magic effects
void JXSetIgnoreDeadZone(object oCaster);

// Get if a cast spell must ignore dead/wild magic effects
// - oCaster Caster that could ignore dead/wild magic effects
int JXGetIgnoreDeadZone(object oCaster);


//========================================== Dead/Wild Magic ==========================================//

const string JX_IGNORE_DEADMAGICZONE    = "JX_IGNORE_DEADMAGICZONE";

// Make the next/current spell ignore dead/wild magic effects
// - oCaster Caster that must ignore dead/wild magic effects
void JXSetIgnoreDeadZone(object oCaster)
{
    SetLocalInt(oCaster, JX_IGNORE_DEADMAGICZONE, 1);
}

// Get if a cast spell must ignore dead/wild magic effects
// - oCaster Caster that could ignore dead/wild magic effects
int JXGetIgnoreDeadZone(object oCaster)
{
    if (GetLocalInt(oCaster, JX_IGNORE_DEADMAGICZONE) == 1)
    return TRUE;
    else
    return FALSE;
}
