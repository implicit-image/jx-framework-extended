//::///////////////////////////////////////////////
//:: Check to see if the PC has used the gift of inspiration I
//::///////////////////////////////////////////////
//:: 2d2f: 04-29-08 Finished

#include "2d2f_includes"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int nLvl = GetLevelByClass(CLASS_WILDMAGE,oPC);
	int nCheck = GetLocalInt(oPC,"nUsedInspiration_1");
	
	if(nCheck == 1 && nLvl == 1)
	{
		return FALSE;
	}
	else if (nCheck == 2 && nLvl == 2)
	{
		return FALSE;
	}
	else
	{
		return TRUE;
	}

}