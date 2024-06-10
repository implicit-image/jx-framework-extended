/*
Lore check in the dm_conversation
*/


int StartingConditional()
{
	object oPC = GetPCSpeaker();
	
	int nLore = GetIsSkillSuccessful(oPC,SKILL_LORE,14);
	
	if(nLore == TRUE)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}

}