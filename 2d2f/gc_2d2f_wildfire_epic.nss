//::///////////////////////////////////////////////
//:: Conditions for the Epic Spell tree of the
//:: Wildfire spell select conversation.
//::///////////////////////////////////////////////
//:: 2d2f: 03-09-08 - Finished

#include "jx_inc_magic"
#include "jx_inc_magic_info"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int nLvl = GetTotalLevels(oPC,FALSE);
	if (nLvl >= 21)
	{
	return TRUE;
	}
	else
	{
	return FALSE;
	}
}