//////////////////////////////////////////////
//	Author: Drammel							//
//	Date: 5/31/2009							//
//	Title: bot9s_inc_levelup2				//
//	Description: Levelup functions for the	//
//	Book of the Nine Swords classes.		//
//////////////////////////////////////////////

#include "bot9s_inc_constants"
#include "bot9s_include"

// Prototypes

// Displays maneuvers that are chosen by the PC to gain on levelup.
void DisplayAddedManeuvers();

// Determines how many maneuvers a player should have without actually creating
// the items for them.  Used to determine which maneuvers a player can access.
// 1 = Initiate, 2 = Novice, 3 = Adept, 4 = Veteran, 5 or more = Master.
// -nDiscipline: Which discpline to add or subtract from.
// -bAddSubtract: Add or subtract from the total number of maneuvers of 
// nDiscipline.  Use TRUE to add and FALSE to subtract.
void PredictDisciplineStatus(int nDiscipline, int bAddSubtract);

// Sets the PC's level of mastery based upon how many maneuvers of a certain
// discipline they have learned.  Used for determining prerequisites.
// 1 = Initiate, 2 = Novice, 3 = Adept, 4 = Veteran, 5 or more = Master.
void DetermineDisciplineStatus();

// Checks if the maneuver is a stance or not.
// Returns TRUE if it is.
int GetIsStance(int nManeuver);

// Flags a Known Maneuver as unknown.
void UnlearnManeuver(int nManeuver);

// Used to only open the levelup xmls when all of the screen's data has been loaded.
void EnforceDataOpening();

// Functions

// Displays maneuvers that are chosen by the PC to gain on levelup.
void DisplayAddedManeuvers()
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	string sScreen = "SCREEN_LEVELUP_MANEUVERS";
	string sListBox = "ADDED_MANEUVER_LIST";
	string sTexture, sPane, sVari, sTitle, sData;
	int nTitle, i;

	i = 1;

	while (i < 210)
	{
		sData = GetLocalString(oToB, "AddedManeuver" + IntToString(i));

		if (sData != "")
		{
			nTitle = GetLocalInt(oToB, "maneuvers_StrRef" + sData);
			sTitle = "MANEUVER_TEXT=" + GetStringByStrRef(nTitle);
			sTexture = "MANEUVER_IMAGE=" + GetLocalString(oToB, "maneuvers_ICON" + sData);
			sPane = "MANEUVERPANE_PROTO" + sData;
			sVari = "7=" + sData;
		
			AddListBoxRow(oPC, sScreen, sListBox, sPane, sTitle, sTexture + ".tga", sVari, "");
		}
		i++;
	}
}

// Determines how many maneuvers a player should have without actually creating
// the items for them.  Used to determine which maneuvers a player can access.
// 1 = Initiate, 2 = Novice, 3 = Adept, 4 = Veteran, 5 or more = Master.
// -nDiscipline: Which discpline to add or subtract from.
// -bAddSubtract: Add or subtract from the total number of maneuvers of 
// nDiscipline.  Use TRUE to add and FALSE to subtract.
void PredictDisciplineStatus(int nDiscipline, int bAddSubtract)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	int nDW = GetLocalInt(oToB, "DWTotal");
	int nDS = GetLocalInt(oToB, "DSTotal");
	int nDM = GetLocalInt(oToB, "DMTotal");
	int nIH = GetLocalInt(oToB, "IHTotal");
	int nSS = GetLocalInt(oToB, "SSTotal");
	int nSH = GetLocalInt(oToB, "SHTotal");
	int nSD = GetLocalInt(oToB, "SDTotal");
	int nTC = GetLocalInt(oToB, "TCTotal");
	int nWR = GetLocalInt(oToB, "WRTotal");

	if (bAddSubtract == TRUE)
	{
		switch (nDiscipline)
		{
			case DESERT_WIND:	nDW += 1;	break;
			case DEVOTED_SPIRIT:nDS += 1;	break;
			case DIAMOND_MIND:	nDM += 1;	break;
			case IRON_HEART:	nIH += 1;	break;
			case SETTING_SUN:	nSS += 1;	break;
			case SHADOW_HAND:	nSH += 1;	break;
			case STONE_DRAGON:	nSD += 1;	break;
			case TIGER_CLAW:	nTC += 1;	break;
			case WHITE_RAVEN:	nWR += 1;	break;
		}
	}
	else if (bAddSubtract == FALSE)
	{
		switch (nDiscipline)
		{
			case DESERT_WIND:	nDW -= 1;	break;
			case DEVOTED_SPIRIT:nDS -= 1;	break;
			case DIAMOND_MIND:	nDM -= 1;	break;
			case IRON_HEART:	nIH -= 1;	break;
			case SETTING_SUN:	nSS -= 1;	break;
			case SHADOW_HAND:	nSH -= 1;	break;
			case STONE_DRAGON:	nSD -= 1;	break;
			case TIGER_CLAW:	nTC -= 1;	break;
			case WHITE_RAVEN:	nWR -= 1;	break;
		}
	}

	SetLocalInt(oToB, "DWTotal", nDW);
	SetLocalInt(oToB, "DSTotal", nDS);
	SetLocalInt(oToB, "DMTotal", nDM);
	SetLocalInt(oToB, "IHTotal", nIH);
	SetLocalInt(oToB, "SSTotal", nSS);
	SetLocalInt(oToB, "SHTotal", nSH);
	SetLocalInt(oToB, "SDTotal", nSD);
	SetLocalInt(oToB, "TCTotal", nTC);
	SetLocalInt(oToB, "WRTotal", nWR);
}

// Sets the PC's level of mastery based upon how many maneuvers of a certain
// discipline they have learned.  Used for determining prerequisites.
// 1 = Initiate, 2 = Novice, 3 = Adept, 4 = Veteran, 5 or more = Master.
void DetermineDisciplineStatus()
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	object oManeuver;
	int nManeuver;
	int nDW, nDS, nDM, nIH, nSS, nSH, nSD, nTC, nWR;

	oManeuver = GetFirstItemInInventory(oToB);

	while (GetIsObjectValid(oManeuver))
	{
		nManeuver = GetLocalInt(oManeuver, "2da");

		if ((nManeuver > 0) && (nManeuver < 28))
		{
			nDW += 1;
		}
		else if ((nManeuver > 27) && (nManeuver < 54))
		{
			nDS += 1;
		}
		else if ((nManeuver > 53) && (nManeuver < 76))
		{
			nDM += 1;
		}
		else if ((nManeuver > 75) && (nManeuver < 97))
		{
			nIH += 1;
		}
		else if (((nManeuver > 96) && (nManeuver < 116)) || nManeuver == 209)
		{
			nSS += 1;
		}
		else if ((nManeuver > 115) && (nManeuver < 141))
		{
			nSH += 1;
		}
		else if ((nManeuver > 140) && (nManeuver < 165))
		{
			nSD+= 1;
		}
		else if ((nManeuver > 164) && (nManeuver < 188))
		{
			nTC += 1;
		}
		else if ((nManeuver > 187) && (nManeuver < 208))
		{
			nWR += 1;
		}
		oManeuver = GetNextItemInInventory(oToB);
	}

	SetLocalInt(oToB, "DWTotal", nDW);
	SetLocalInt(oToB, "DSTotal", nDS);
	SetLocalInt(oToB, "DMTotal", nDM);
	SetLocalInt(oToB, "IHTotal", nIH);
	SetLocalInt(oToB, "SSTotal", nSS);
	SetLocalInt(oToB, "SHTotal", nSH);
	SetLocalInt(oToB, "SDTotal", nSD);
	SetLocalInt(oToB, "TCTotal", nTC);
	SetLocalInt(oToB, "WRTotal", nWR);

	// Add Maneuver Rank Feats
	if ((nDW > 0) && (!GetHasFeat(FEAT_DW_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DW_INITIATE, TRUE);
	}

	if ((nDW > 1) && (!GetHasFeat(FEAT_DW_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DW_NOVICE, TRUE);
	}

	if ((nDW > 2) && (!GetHasFeat(FEAT_DW_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DW_ADEPT, TRUE);
	}

	if ((nDW > 3) && (!GetHasFeat(FEAT_DW_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DW_VETERAN, TRUE);
	}

	if ((nDW > 4) && (!GetHasFeat(FEAT_DW_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DW_MASTER, TRUE);
	}
	
	if ((nDS > 0) && (!GetHasFeat(FEAT_DS_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DS_INITIATE, TRUE);
	}

	if ((nDS > 1) && (!GetHasFeat(FEAT_DS_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DS_NOVICE, TRUE);
	}

	if ((nDS > 2) && (!GetHasFeat(FEAT_DS_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DS_ADEPT, TRUE);
	}

	if ((nDS > 3) && (!GetHasFeat(FEAT_DS_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DS_VETERAN, TRUE);
	}

	if ((nDS > 4) && (!GetHasFeat(FEAT_DS_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DS_MASTER, TRUE);
	}
	
	if ((nDM > 0) && (!GetHasFeat(FEAT_DM_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DM_INITIATE, TRUE);
	}

	if ((nDM > 1) && (!GetHasFeat(FEAT_DM_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DM_NOVICE, TRUE);
	}

	if ((nDM > 2) && (!GetHasFeat(FEAT_DM_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DM_ADEPT, TRUE);
	}

	if ((nDM > 3) && (!GetHasFeat(FEAT_DM_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DM_VETERAN, TRUE);
	}

	if ((nDM> 4) && (!GetHasFeat(FEAT_DM_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_DM_MASTER, TRUE);
	}
	
	if ((nIH > 0) && (!GetHasFeat(FEAT_IH_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_IH_INITIATE, TRUE);
	}

	if ((nIH > 1) && (!GetHasFeat(FEAT_IH_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_IH_NOVICE, TRUE);
	}

	if ((nIH > 2) && (!GetHasFeat(FEAT_IH_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_IH_ADEPT, TRUE);
	}

	if ((nIH > 3) && (!GetHasFeat(FEAT_IH_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_IH_VETERAN, TRUE);
	}

	if ((nIH > 4) && (!GetHasFeat(FEAT_IH_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_IH_MASTER, TRUE);
	}
	
	if ((nSS > 0) && (!GetHasFeat(FEAT_SS_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SS_INITIATE, TRUE);
	}

	if ((nSS > 1) && (!GetHasFeat(FEAT_SS_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SS_NOVICE, TRUE);
	}

	if ((nSS > 2) && (!GetHasFeat(FEAT_SS_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SS_ADEPT, TRUE);
	}

	if ((nSS > 3) && (!GetHasFeat(FEAT_SS_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SS_VETERAN, TRUE);
	}

	if ((nSS > 4) && (!GetHasFeat(FEAT_SS_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SS_MASTER, TRUE);
	}
	
	if ((nSH > 0) && (!GetHasFeat(FEAT_SH_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SH_INITIATE, TRUE);
	}

	if ((nSH > 1) && (!GetHasFeat(FEAT_SH_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SH_NOVICE, TRUE);
	}

	if ((nSH > 2) && (!GetHasFeat(FEAT_SH_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SH_ADEPT, TRUE);
	}

	if ((nSH > 3) && (!GetHasFeat(FEAT_SH_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SH_VETERAN, TRUE);
	}

	if ((nSH > 4) && (!GetHasFeat(FEAT_SH_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SH_MASTER, TRUE);
	}
	
	if ((nSD > 0) && (!GetHasFeat(FEAT_SD_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SD_INITIATE, TRUE);
	}

	if ((nSD > 1) && (!GetHasFeat(FEAT_SD_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SD_NOVICE, TRUE);
	}

	if ((nSD > 2) && (!GetHasFeat(FEAT_SD_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SD_ADEPT, TRUE);
	}

	if ((nSD > 3) && (!GetHasFeat(FEAT_SD_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SD_VETERAN, TRUE);
	}

	if ((nSD > 4) && (!GetHasFeat(FEAT_SD_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_SD_MASTER, TRUE);
	}
	
	if ((nTC > 0) && (!GetHasFeat(FEAT_TC_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_TC_INITIATE, TRUE);
	}

	if ((nTC > 1) && (!GetHasFeat(FEAT_TC_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_TC_NOVICE, TRUE);
	}

	if ((nTC > 2) && (!GetHasFeat(FEAT_TC_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_TC_ADEPT, TRUE);
	}

	if ((nTC > 3) && (!GetHasFeat(FEAT_TC_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_TC_VETERAN, TRUE);
	}

	if ((nTC > 4) && (!GetHasFeat(FEAT_TC_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_TC_MASTER, TRUE);
	}
	
	if ((nWR > 0) && (!GetHasFeat(FEAT_WR_INITIATE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_WR_INITIATE, TRUE);
	}

	if ((nWR > 1) && (!GetHasFeat(FEAT_WR_NOVICE, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_WR_NOVICE, TRUE);
	}

	if ((nWR > 2) && (!GetHasFeat(FEAT_WR_ADEPT, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_WR_ADEPT, TRUE);
	}

	if ((nWR > 3) && (!GetHasFeat(FEAT_WR_VETERAN, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_WR_VETERAN, TRUE);
	}

	if ((nWR > 4) && (!GetHasFeat(FEAT_WR_MASTER, oPC)))
	{
		WrapperFeatAdd(oPC, FEAT_WR_MASTER, TRUE);
	}

	// Remove Maneuver Rank Feats
	if ((nDW < 5) && (GetHasFeat(FEAT_DW_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_DW_MASTER);
	}

	if ((nDW < 4) && (GetHasFeat(FEAT_DW_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_DW_VETERAN);
	}

	if ((nDW < 3) && (GetHasFeat(FEAT_DW_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_DW_ADEPT);
	}

	if ((nDW < 2) && (GetHasFeat(FEAT_DW_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_DW_NOVICE);
	}

	if ((nDW < 1) && (GetHasFeat(FEAT_DW_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_DW_INITIATE);
	}

	if ((nDS < 5) && (GetHasFeat(FEAT_DS_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_DS_MASTER);
	}

	if ((nDS < 4) && (GetHasFeat(FEAT_DS_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_DS_VETERAN);
	}
	
	if ((nDS < 3) && (GetHasFeat(FEAT_DS_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_DS_ADEPT);
	}
	
	if ((nDS < 2) && (GetHasFeat(FEAT_DS_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_DS_NOVICE);
	}
	
	if ((nDS < 1) && (GetHasFeat(FEAT_DS_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_DS_INITIATE);
	}

	if ((nDM < 5) && (GetHasFeat(FEAT_DM_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_DM_MASTER);
	}
	
	if ((nDM < 4) && (GetHasFeat(FEAT_DM_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_DM_VETERAN);
	}
	
	if ((nDM < 3) && (GetHasFeat(FEAT_DM_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_DM_ADEPT);
	}
	
	if ((nDM < 2) && (GetHasFeat(FEAT_DM_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_DM_NOVICE);
	}
	
	if ((nDM < 1) && (GetHasFeat(FEAT_DM_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_DM_INITIATE);
	}

	if ((nIH < 5) && (GetHasFeat(FEAT_IH_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_IH_MASTER);
	}

	if ((nIH < 4) && (GetHasFeat(FEAT_IH_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_IH_VETERAN);
	}

	if ((nIH < 3) && (GetHasFeat(FEAT_IH_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_IH_ADEPT);
	}

	if ((nIH < 2) && (GetHasFeat(FEAT_IH_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_IH_NOVICE);
	}

	if ((nIH < 1) && (GetHasFeat(FEAT_IH_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_IH_INITIATE);
	}

	if ((nSS < 5) && (GetHasFeat(FEAT_SS_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_SS_MASTER);
	}

	if ((nSS < 4) && (GetHasFeat(FEAT_SS_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_SS_VETERAN);
	}

	if ((nSS < 3) && (GetHasFeat(FEAT_SS_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_SS_ADEPT);
	}

	if ((nSS < 2) && (GetHasFeat(FEAT_SS_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_SS_NOVICE);
	}

	if ((nSS < 1) && (GetHasFeat(FEAT_SS_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_SS_INITIATE);
	}

	if ((nSH < 5) && (GetHasFeat(FEAT_SH_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_SH_MASTER);
	}

	if ((nSH < 4) && (GetHasFeat(FEAT_SH_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_SH_VETERAN);
	}

	if ((nSH < 3) && (GetHasFeat(FEAT_SH_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_SH_ADEPT);
	}

	if ((nSH < 2) && (GetHasFeat(FEAT_SH_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_SH_NOVICE);
	}

	if ((nSH < 1) && (GetHasFeat(FEAT_SH_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_SH_INITIATE);
	}

	if ((nSD < 5) && (GetHasFeat(FEAT_SD_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_SD_MASTER);
	}

	if ((nSD < 4) && (GetHasFeat(FEAT_SD_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_SD_VETERAN);
	}

	if ((nSD < 3) && (GetHasFeat(FEAT_SD_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_SD_ADEPT);
	}

	if ((nSD < 2) && (GetHasFeat(FEAT_SD_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_SD_NOVICE);
	}

	if ((nSD < 1) && (GetHasFeat(FEAT_SD_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_SD_INITIATE);
	}

	if ((nTC < 5) && (GetHasFeat(FEAT_TC_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_TC_MASTER);
	}

	if ((nTC < 4) && (GetHasFeat(FEAT_TC_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_TC_VETERAN);
	}

	if ((nTC < 3) && (GetHasFeat(FEAT_TC_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_TC_ADEPT);
	}

	if ((nTC < 2) && (GetHasFeat(FEAT_TC_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_TC_NOVICE);
	}

	if ((nTC < 1) && (GetHasFeat(FEAT_TC_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_TC_INITIATE);
	}

	if ((nWR < 5) && (GetHasFeat(FEAT_WR_MASTER, oPC)))
	{
		FeatRemove(oPC, FEAT_WR_MASTER);
	}

	if ((nWR < 4) && (GetHasFeat(FEAT_WR_VETERAN, oPC)))
	{
		FeatRemove(oPC, FEAT_WR_VETERAN);
	}

	if ((nWR < 3) && (GetHasFeat(FEAT_WR_ADEPT, oPC)))
	{
		FeatRemove(oPC, FEAT_WR_ADEPT);
	}

	if ((nWR < 2) && (GetHasFeat(FEAT_WR_NOVICE, oPC)))
	{
		FeatRemove(oPC, FEAT_WR_NOVICE);
	}

	if ((nWR < 1) && (GetHasFeat(FEAT_WR_INITIATE, oPC)))
	{
		FeatRemove(oPC, FEAT_WR_INITIATE);
	}
}

// Checks if the maneuver is a stance or not.
// Returns TRUE if it is.
int GetIsStance(int nManeuver)
{
	int nReturn;

	switch (nManeuver)
	{
		case STANCE_ABSOLUTE_STEEL:					nReturn = TRUE;	break;
		case STANCE_ASSNS_STANCE:					nReturn = TRUE;	break;
		case STANCE_AURA_OF_CHAOS:					nReturn = TRUE;	break;
		case STANCE_AURA_OF_PERFECT_ORDER:			nReturn = TRUE;	break;
		case STANCE_AURA_OF_TRIUMPH:				nReturn = TRUE;	break;
		case STANCE_AURA_OF_TYRANNY:				nReturn = TRUE;	break;
		case STANCE_BALANCE_SKY:					nReturn = TRUE;	break;
		case STANCE_BLOOD_IN_THE_WATER:				nReturn = TRUE;	break;
		case STANCE_BOLSTERING_VOICE:				nReturn = TRUE;	break;
		case STANCE_CHILD_SHADOW:					nReturn = TRUE;	break;
		case STANCE_CRUSHING_WEIGHT_OF_THE_MOUNTAIN:nReturn = TRUE;	break;
		case STANCE_DANCE_SPIDER:					nReturn = TRUE;	break;
		case STANCE_DANCING_BLADE_FORM:				nReturn = TRUE;	break;
		case STANCE_DANCING_MOTH:					nReturn = TRUE;	break;
		case STANCE_FLMSBLSS:						nReturn = TRUE;	break;
		case STANCE_FRYASLT:						nReturn = TRUE;	break;
		case STANCE_GHOSTLY_DEFENSE:				nReturn = TRUE;	break;
		case STANCE_GIANT_KILLING_STYLE:			nReturn = TRUE;	break;
		case STANCE_GIANTS_STANCE:					nReturn = TRUE;	break;
		case STANCE_HEARING_THE_AIR:				nReturn = TRUE;	break;
		case STANCE_HOLOSTCLK:						nReturn = TRUE;	break;
		case STANCE_HUNTERS_SENSE:					nReturn = TRUE;	break;
		case STANCE_IMMORTAL_FORTITUDE:				nReturn = TRUE;	break;
		case STANCE_IRON_GUARDS_GLARE:				nReturn = TRUE;	break;
		case STANCE_ISLAND_OF_BLADES:				nReturn = TRUE;	break;
		case STANCE_LEADING_THE_CHARGE:				nReturn = TRUE;	break;
		case STANCE_LEAPING_DRAGON_STANCE:			nReturn = TRUE;	break;
		case STANCE_MARTIAL_SPIRIT:					nReturn = TRUE;	break;
		case STANCE_OF_ALACRITY:					nReturn = TRUE;	break;
		case STANCE_OF_CLARITY:						nReturn = TRUE;	break;
		case STANCE_PEARL_OF_BLACK_DOUBT:			nReturn = TRUE;	break;
		case STANCE_PRESS_THE_ADVANTAGE:			nReturn = TRUE;	break;
		case STANCE_PREY_ON_THE_WEAK:				nReturn = TRUE;	break;
		case STANCE_PUNISHING_STANCE:				nReturn = TRUE;	break;
		case STANCE_ROOTS_OF_THE_MOUNTAIN:			nReturn = TRUE;	break;
		case STANCE_RSNPHEONIX:						nReturn = TRUE;	break;
		case STANCE_SHIFTING_DEFENSE:				nReturn = TRUE;	break;
		case STANCE_STEP_OF_THE_WIND:				nReturn = TRUE;	break;
		case STANCE_STONEFOOT_STANCE:				nReturn = TRUE;	break;
		case STANCE_STRENGTH_OF_STONE:				nReturn = TRUE;	break;
		case STANCE_SUPREME_BLADE_PARRY:			nReturn = TRUE;	break;
		case STANCE_SWARM_TACTICS:					nReturn = TRUE;	break;
		case STANCE_TACTICS_OF_THE_WOLF:			nReturn = TRUE;	break;
		case STANCE_THICKET_OF_BLADES:				nReturn = TRUE;	break;
		case STANCE_WOLF_PACK_TACTICS:				nReturn = TRUE;	break;
		case STANCE_WOLVERINE_STANCE:				nReturn = TRUE;	break;
		default:									nReturn = FALSE;break;
	}
	return nReturn;
}

// Flags a Known Maneuver as unknown.
void UnlearnManeuver(int nManeuver)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	if (GetLocalInt(oToB, "KnownManeuver1") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver1", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver2") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver2", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver3") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver3", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver4") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver4", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver5") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver5", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver6") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver6", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver7") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver7", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver8") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver8", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver9") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver9", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver10") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver10", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver11") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver11", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver12") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver12", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver13") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver13", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver14") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver14", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver15") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver15", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver16") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver16", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver17") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver17", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver18") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver18", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver19") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver19", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver20") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver20", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver21") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver21", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver22") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver22", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver23") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver23", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver24") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver24", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver25") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver25", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver26") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver26", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver27") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver27", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver28") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver28", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver29") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver29", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver30") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver30", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver31") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver31", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver32") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver32", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver33") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver33", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver34") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver34", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver35") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver35", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver36") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver36", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver37") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver37", 0);
	}
	else if (GetLocalInt(oToB, "KnownManeuver38") == nManeuver)
	{
		SetLocalInt(oToB, "KnownManeuver38", 0);
	}
}

// Used to only open the levelup xmls when all of the screen's data has been loaded.
void EnforceDataOpening()
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	if (GetLocalInt(oToB, "GUIOpeningSafe") == 1)
	{
		AssignCommand(oPC, DisplayGuiScreen(oPC, "SCREEN_LEVELUP_MANEUVERS", FALSE, "levelup_maneuvers.xml"));
	}
	else DelayCommand(0.5f, EnforceDataOpening());
}