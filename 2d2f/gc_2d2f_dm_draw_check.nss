/*
Checks if the player has drawn a card from the deck before
*/

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int nDeckDraws = GetLocalInt(oPC,"nDeckDraws");
	
	if(nDeckDraws > 0)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}