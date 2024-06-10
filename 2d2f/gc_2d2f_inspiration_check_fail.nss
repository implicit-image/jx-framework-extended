//::///////////////////////////////////////////////
//:: Gives failed message if used inspiration check failes
//::///////////////////////////////////////////////
//:: 2d2f: 04-29-08 Finished

#include "2d2f_includes"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int nWmLvl = GetLevelByClass(CLASS_WILDMAGE,oPC) + 2;
	int nCheck;
	
	if(nWmLvl == 5 || nWmLvl == 6)
	{
		nCheck = GetLocalInt(oPC,"nUsedInspiration_2");
	}
	else if(nWmLvl == 7 || nWmLvl == 8)
	{
		nCheck = GetLocalInt(oPC,"nUsedInspiration_3");
	}
	else if(nWmLvl == 9 || nWmLvl == 10)
	{
		nCheck = GetLocalInt(oPC,"nUsedInspiration_4");
	}
	else if(nWmLvl == 11 || nWmLvl == 12)
	{
		nCheck = GetLocalInt(oPC,"nUsedInspiration_5");
	}
	else if(nWmLvl == 13 || nWmLvl == 14)
	{
		nCheck = GetLocalInt(oPC,"nUsedInspiration_6");
	}
	else if(nWmLvl == 15 || nWmLvl == 16)
	{
		nCheck = GetLocalInt(oPC,"nUsedInspiration_7");
	}
	else if(nWmLvl >= 17)
	{
		nCheck = GetLocalInt(oPC,"nUsedInspiration_8");
	}
	
	if(nCheck == 1 && nWmLvl % 2 == 1)
	{
	 	return TRUE;
	}
	else if(nCheck == 2 && nWmLvl % 2 == 0)
	{
	 	return TRUE;
	}
	else
	{
		return FALSE;
	}
}