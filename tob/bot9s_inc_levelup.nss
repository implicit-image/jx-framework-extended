//////////////////////////////////////////////
//	Author: Drammel							//
//	Date: 5/31/2009							//
//	Title: bot9s_inc_levelup				//
//	Description: Levelup functions for the	//
//	Book of the Nine Swords classes.		//
//////////////////////////////////////////////

#include "bot9s_inc_constants"
#include "bot9s_inc_levelup2"

// Prototypes

// Returns the maximum Maneuver level the PC can learn.
// -nLevelCap: The maximum martial adept level that we're allowed to check for.
int GetInitiatorLevelup(object oPC, int nClass, int nLevelCap = 0);

// Creates a list of the PC's Known Maneuvers.
void GenerateKnownManeuvers(object oPC = OBJECT_SELF);

// Runs data needed by the Levelup screen before it opens.
// -nClass: Class constant of the class that is leveling.
// -nLearn: Number of maneuvers available to learn this level.
// -nRetrain: Number of maneuvers available to be retrained this level, typically
// at 4th and every even numbered level thereafter.
// -nStance: Number of stances available to learn this level.
// -nLevelcap: Level of the class that is being leveled.  Implemented to avoid
// abuse of the levelup system when a character is autoleveled or similar.
void LoadLevelup(object oPC, int nClass, int nLearn, int nRetrain, int nStance, int nLevelCap);

// Checks to see if the PC already knows this maneuver.
// -nManeuver: 2da reference number of the maneuver we're checking.
// This data is stored on the placeholder item.
// Returns TRUE if the PC knows the maneuver.
int CheckIsManeuverKnown(int nManeuver);

// Adds a Listbox to the maneuver selection screen.
// -n: Current number of listboxes added to the maneuver selection screen.
// -n2da: Location of the variable on oToB that stores the 2da data.
void AddManeuver(int n, string s2da);

// Displays the maneuvers the PC can learn for the class they are leveling in.
// All stances are under level 0.
// -nLevel: Initiator level of the maneuvers to display.
// -nClass: Determines which maneuvers are availible to this class.
// -nLevelCap: Maximum initiator level allowed to generate maneuvers for.
void DisplayManeuversByClass(int nLevel, int nClass, int nLevelCap = 0);

// Functions

// Returns the maximum Maneuver level the PC can learn.
// -nLevelCap: The maximum martial adept level that we're allowed to check for.
int GetInitiatorLevelup(object oPC, int nClass, int nLevelCap = 0)
{
	int nMartialAdept;
	int nNonMartial;
	int nCrusader = GetLevelByClass(CLASS_TYPE_CRUSADER, oPC);
	int nSaint = GetLevelByClass(CLASS_TYPE_SAINT, oPC);
	int nSwordsage = GetLevelByClass(CLASS_TYPE_SWORDSAGE, oPC);
	int nWarblade = GetLevelByClass(CLASS_TYPE_WARBLADE, oPC);

	if (nClass == CLASS_TYPE_CRUSADER)
	{
		nMartialAdept = nCrusader;
	}
	else if (nClass == CLASS_TYPE_SAINT)
	{
		nMartialAdept = nSaint;
	}
	else if (nClass == CLASS_TYPE_SWORDSAGE)
	{
		nMartialAdept = nSwordsage;
	}
	else if (nClass == CLASS_TYPE_WARBLADE)
	{
		nMartialAdept = nWarblade;
	}
	else // For Martial Study/Stance.
	{
		if (nCrusader > nSaint || nCrusader > nSwordsage || nCrusader > nWarblade)
		{
			nMartialAdept = nCrusader;
		}
		else if (nSaint > nCrusader || nSaint > nSwordsage || nSaint > nWarblade)
		{
			nMartialAdept = nSaint;
		}
		else if (nSwordsage > nCrusader || nSwordsage > nSaint || nSwordsage > nWarblade)
		{
			nMartialAdept = nSwordsage;
		}
		else if (nWarblade > nCrusader || nWarblade > nSaint || nWarblade > nSwordsage)
		{
			nMartialAdept = nWarblade;
		}
		else if (nCrusader > 0 || nSaint > 0 || nSwordsage > 0 || nWarblade > 0)
		{
			if (nCrusader == nSaint || nCrusader == nSwordsage || nCrusader == nWarblade)
			{
				nMartialAdept = nCrusader; // Fyi, purely an alphabetical preferance.
			}
			else if (nSaint == nSwordsage || nSaint == nWarblade)
			{
				nMartialAdept = nSaint;
			}
			else if (nSwordsage == nWarblade)
			{
				nMartialAdept = nSwordsage;
			}
			else nMartialAdept = 0;
		}
		else nMartialAdept = 0;
	}

	nNonMartial = ((GetHitDice(oPC) - nMartialAdept) / 2);

	if (nLevelCap > 0)
	{
		if (nMartialAdept > nLevelCap)
		{
			nMartialAdept = nLevelCap;
		}

		if (GetHitDice(oPC) > nLevelCap)
		{
			nNonMartial = ((nLevelCap - nMartialAdept) / 2);
		}
	}

	int nInitiator = nMartialAdept + nNonMartial;
	int nReturn;

	switch (nInitiator)
	{
		case 0: nReturn = 0;	break;
		case 1:	nReturn = 1;	break;
		case 2:	nReturn = 1;	break;
		case 3:	nReturn = 2;	break;
		case 4:	nReturn = 2;	break;
		case 5:	nReturn = 3;	break;
		case 6:	nReturn = 3;	break;
		case 7:	nReturn = 4;	break;
		case 8:	nReturn = 4;	break;
		case 9:	nReturn = 5;	break;
		case 10:nReturn = 5;	break;
		case 11:nReturn = 6;	break;
		case 12:nReturn = 6;	break;
		case 13:nReturn = 7;	break;
		case 14:nReturn = 7;	break;
		case 15:nReturn = 8;	break;
		case 16:nReturn = 8;	break;
		default:nReturn = 9;	break;
	}

	if (nReturn == 0)
	{
		nReturn = 1; // Minimum Initiator level.
	}

	return nReturn;
}

// Creates a list of the PC's Known Maneuvers.
void GenerateKnownManeuvers(object oPC = OBJECT_SELF)
{
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	string sScreen = "SCREEN_LEVELUP_MANEUVERS";
	string sList = "RETRAIN_MANEUVER_LIST";
	string sPane = "MANEUVERPANE_PROTO";
	string sText, sTextures, sVari;
	object oManeuver;
	int nManeuver, nClass;
	int i;

	oManeuver = GetFirstItemInInventory(oToB);
	i = 1;

	while (GetIsObjectValid(oManeuver))
	{
		nManeuver = GetLocalInt(oManeuver, "2da");
		nClass = GetLocalInt(oManeuver, "Class");

		if (nManeuver != (GetLocalInt(oToB, "RetrainManeuver")))
		{
			SetLocalInt(oToB, "KnownManeuver" + IntToString(i), nManeuver);
		}

		if ((GetLocalInt(oToB, "LevelupRetrain") > 0) && (GetIsStance(nManeuver) == FALSE) && (nClass != 255) && (nManeuver < 210) && (nManeuver != 0))
		{
			sTextures = "MANEUVER_IMAGE=" + GetLocalString(oToB, "maneuvers_ICON" + IntToString(nManeuver)) + ".tga";
			sText = "MANEUVER_TEXT=" + GetStringByStrRef(GetLocalInt(oToB, "maneuvers_StrRef" + IntToString(nManeuver)));
			sVari = "7=" + IntToString(nManeuver);

			AddListBoxRow(oPC, sScreen, sList, sPane + IntToString(nManeuver), sText, sTextures, sVari, "");
		}

		oManeuver = GetNextItemInInventory(oToB);
		i++;
	}

	SetLocalInt(oToB, "KnownManeuverTotal", i);
	SetLocalInt(oToB, "GUIOpeningSafe", 1);
	DelayCommand(6.0f, DeleteLocalInt(oToB, "GUIOpeningSafe"));
}

// Runs data needed by the Levelup screen before it opens.
// -nClass: Class constant of the class that is leveling.
// -nLearn: Number of maneuvers available to learn this level.
// -nRetrain: Number of maneuvers available to be retrained this level, typically
// at 4th and every even numbered level thereafter.
// -nStance: Number of stances available to learn this level.
// -nLevelcap: Level of the class that is being leveled.  Implemented to avoid
// abuse of the levelup system when a character is autoleveled or similar.
void LoadLevelup(object oPC, int nClass, int nLearn, int nRetrain, int nStance, int nLevelCap)
{
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	SetPause(FALSE);

	if (GetIsObjectValid(oToB))
	{
		SetLocalInt(oToB, "LevelupClass", nClass);
		SetLocalInt(oToB, "LevelupLearn", nLearn);
		SetLocalInt(oToB, "LevelupRetrain", nRetrain);
		SetLocalInt(oToB, "LevelupStance", nStance);
		SetLocalInt(oToB, "LevelupCap", nLevelCap);
		AssignCommand(oPC, GenerateKnownManeuvers(oPC));
		AssignCommand(oPC, EnforceDataOpening());

		if (GetLocalInt(oToB, "CurrentLevelupLevel") == 0)
		{
			DelayCommand(0.1f, SetGUIObjectText(oPC, "SCREEN_LEVELUP_MANEUVERS", "POINT_POOL_TEXT", -1, IntToString(nStance)));
		}
		else DelayCommand(0.1f, SetGUIObjectText(oPC, "SCREEN_LEVELUP_MANEUVERS", "POINT_POOL_TEXT", -1, IntToString(nLearn)));

		DelayCommand(0.1f, SetGUIObjectText(oPC, "SCREEN_LEVELUP_MANEUVERS", "RETRAIN_POOL_TEXT", -1, IntToString(nRetrain)));
	}
}

// Checks to see if the PC already knows this maneuver.
// -nManeuver: 2da reference number of the maneuver we're checking.
// This data is stored on the placeholder item.
// Returns TRUE if the PC knows the maneuver.
int CheckIsManeuverKnown(int nManeuver)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	if (GetLocalInt(oToB, "KnownManeuver1") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver2") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver3") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver4") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver5") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver6") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver7") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver8") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver9") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver10") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver11") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver12") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver13") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver14") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver15") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver16") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver17") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver18") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver19") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver20") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver21") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver22") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver23") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver24") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver25") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver26") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver27") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver28") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver29") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver30") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver31") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver32") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver33") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver34") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver35") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver36") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver37") == nManeuver)
	{
		return TRUE;
	}
	else if (GetLocalInt(oToB, "KnownManeuver38") == nManeuver)
	{
		return TRUE;
	}
	else return FALSE;
}

// Adds a Listbox to the maneuver selection screen.
// -n: Current number of listboxes added to the maneuver selection screen.
// -n2da: Location of the variable on oToB that stores the 2da data.
void AddManeuver(int n, string s2da)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	string sScreen = "SCREEN_LEVELUP_MANEUVERS";
	string sList = "AVAILABLE_MANEUVER_LIST";
	string sPane = "MANEUVERPANE_PROTO";
	string sText, sTextures, sVari;
	int nManeuver = GetLocalInt(oToB, s2da);

	if (nManeuver == 0)
	{
		return; //Sanity Check.
	}

	sTextures = "MANEUVER_IMAGE=" + GetLocalString(oToB, "maneuvers_ICON" + IntToString(nManeuver)) + ".tga";
	sText = "MANEUVER_TEXT=" + GetStringByStrRef(GetLocalInt(oToB, "maneuvers_StrRef" + IntToString(nManeuver)));
	sVari = "7=" + IntToString(nManeuver);

	AddListBoxRow(oPC, sScreen, sList, sPane + IntToString(n), sText, sTextures, sVari, "");
}

// Displays the maneuvers the PC can learn for the class they are leveling in.
// All stances are under level 0.
// -nLevel: Initiator level of the maneuvers to display.
// -nClass: Determines which maneuvers are availible to this class.
// -nLevelCap: Maximum initiator level allowed to generate maneuvers for.
void DisplayManeuversByClass(int nLevel, int nClass, int nLevelCap = 0)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	int nInitLevel = GetInitiatorLevelup(oPC, nClass, nLevelCap);
	int nDW = GetLocalInt(oToB, "DWTotal");
	int nDS = GetLocalInt(oToB, "DSTotal");
	int nDM = GetLocalInt(oToB, "DMTotal");
	int nIH = GetLocalInt(oToB, "IHTotal");
	int nSS = GetLocalInt(oToB, "SSTotal");
	int nSH = GetLocalInt(oToB, "SHTotal");
	int nSD = GetLocalInt(oToB, "SDTotal");
	int nTC = GetLocalInt(oToB, "TCTotal");
	int nWR = GetLocalInt(oToB, "WRTotal");

	/* Drammel's Note: The else statements here are absolutely necessary
	to properly add and remove maneuvers which have other maneuvers as
	prerequisits.*/

	if (nLevel == 0)
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L01", STANCE_AURA_OF_CHAOS);
			}
			else SetLocalInt(oToB, "L01", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L02", STANCE_AURA_OF_PERFECT_ORDER);
			}
			else SetLocalInt(oToB, "L02", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L03", STANCE_AURA_OF_TRIUMPH);
			}
			else SetLocalInt(oToB, "L03", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L04", STANCE_AURA_OF_TYRANNY);
			}
			else SetLocalInt(oToB, "L04", 0);
			
			SetLocalInt(oToB, "L05", STANCE_BOLSTERING_VOICE);

			if ((nInitLevel >= 3) && (nSD >= 1))
			{
				SetLocalInt(oToB, "L06", STANCE_CRUSHING_WEIGHT_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L06", 0);

			if ((nInitLevel >= 8) && (nDS >= 3))
			{
				SetLocalInt(oToB, "L07", STANCE_IMMORTAL_FORTITUDE);
			}
			else SetLocalInt(oToB, "L07", 0);

			SetLocalInt(oToB, "L08", STANCE_IRON_GUARDS_GLARE);
			SetLocalInt(oToB, "L09", STANCE_LEADING_THE_CHARGE);
			SetLocalInt(oToB, "L010", STANCE_MARTIAL_SPIRIT);

			if ((nInitLevel >= 5) && (nWR >= 2))
			{
				SetLocalInt(oToB, "L011", STANCE_PRESS_THE_ADVANTAGE);
			}
			else SetLocalInt(oToB, "L011", 0);

			if (nInitLevel >= 3)
			{
				SetLocalInt(oToB, "L012", STANCE_ROOTS_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L012", 0);

			SetLocalInt(oToB, "L013", STANCE_STONEFOOT_STANCE);

			if ((nInitLevel >= 8) && (nSD >= 3))
			{
				SetLocalInt(oToB, "L014", STANCE_STRENGTH_OF_STONE);
			}
			else SetLocalInt(oToB, "L014", 0);

			if ((nInitLevel >= 8) && (nWR >= 1))
			{
				SetLocalInt(oToB, "L015", STANCE_SWARM_TACTICS);
			}
			else SetLocalInt(oToB, "L015", 0);

			if ((nInitLevel >= 3) && (nWR >= 1))
			{
				SetLocalInt(oToB, "L016", STANCE_TACTICS_OF_THE_WOLF);
			}
			else SetLocalInt(oToB, "L016", 0);

			if ((nInitLevel >= 3) && (nDS >= 1))
			{
				SetLocalInt(oToB, "L017", STANCE_THICKET_OF_BLADES);
			}
			else SetLocalInt(oToB, "L017", 0);

			if ((nInitLevel >= 5) && (nSD >= 2))
			{
				SetLocalInt(oToB, "L018", STANCE_GIANTS_STANCE);
			}
			else SetLocalInt(oToB, "L018", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if ((nInitLevel >= 3) && (nSH >= 1))
			{
				SetLocalInt(oToB, "L01", STANCE_ASSNS_STANCE);
			}
			else SetLocalInt(oToB, "L01", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L02", STANCE_AURA_OF_CHAOS);
			}
			else SetLocalInt(oToB, "L02", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L03", STANCE_AURA_OF_PERFECT_ORDER);
			}
			else SetLocalInt(oToB, "L03", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L04", STANCE_AURA_OF_TRIUMPH);
			}
			else SetLocalInt(oToB, "L04", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L05", STANCE_AURA_OF_TYRANNY);
			}
			else SetLocalInt(oToB, "L05", 0);

			if ((nInitLevel >= 8) && (nSH >= 2))
			{
				SetLocalInt(oToB, "L06", STANCE_BALANCE_SKY);
			}
			else SetLocalInt(oToB, "L06", 0);

			SetLocalInt(oToB, "L07", STANCE_CHILD_SHADOW);

			if (nInitLevel >= 3)
			{
				SetLocalInt(oToB, "L08", STANCE_DANCE_SPIDER);
			}
			else SetLocalInt(oToB, "L08", 0);

			if ((nInitLevel >= 5) && (nSH >= 1))
			{
				SetLocalInt(oToB, "L09", STANCE_DANCING_MOTH);
			}
			else SetLocalInt(oToB, "L09", 0);

			if ((nInitLevel >= 8) && (nDS >= 3))
			{
				SetLocalInt(oToB, "L010", STANCE_IMMORTAL_FORTITUDE);
			}
			else SetLocalInt(oToB, "L010", 0);

			SetLocalInt(oToB, "L011", STANCE_IRON_GUARDS_GLARE);
			SetLocalInt(oToB, "L012", STANCE_ISLAND_OF_BLADES);
			SetLocalInt(oToB, "L013", STANCE_MARTIAL_SPIRIT);

			if ((nInitLevel >= 3) && (nDS >= 1))
			{
				SetLocalInt(oToB, "L014", STANCE_THICKET_OF_BLADES);
			}
			else SetLocalInt(oToB, "L014", 0);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			if ((nInitLevel >= 3) && (nSH >= 1))
			{
				SetLocalInt(oToB, "L01", STANCE_ASSNS_STANCE);
			}
			else SetLocalInt(oToB, "L01", 0);

			if ((nInitLevel >= 8) && (nSH > 2))
			{
				SetLocalInt(oToB, "L02", STANCE_BALANCE_SKY);
			}
			else SetLocalInt(oToB, "L02", 0);

			SetLocalInt(oToB, "L03", STANCE_BLOOD_IN_THE_WATER);
			SetLocalInt(oToB, "L04", STANCE_CHILD_SHADOW);

			if ((nInitLevel >= 3) && ((nSD >= 1)))
			{
				SetLocalInt(oToB, "L05", STANCE_CRUSHING_WEIGHT_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L05", 0);

			if (nInitLevel >= 3)
			{
				SetLocalInt(oToB, "L06", STANCE_DANCE_SPIDER);
			}
			else SetLocalInt(oToB, "L06", 0);

			if ((nInitLevel >= 5) && (nSH >= 1))
			{
				SetLocalInt(oToB, "L07", STANCE_DANCING_MOTH);
			}
			else SetLocalInt(oToB, "L07", 0);

			SetLocalInt(oToB, "L08", STANCE_FLMSBLSS);

			if ((nInitLevel >= 6) && (nDW >= 2))
			{
				SetLocalInt(oToB, "L09", STANCE_FRYASLT);
			}
			else SetLocalInt(oToB, "L09", 0);

			if ((nInitLevel >= 8) && (nSS >= 3))
			{
				SetLocalInt(oToB, "L010", STANCE_GHOSTLY_DEFENSE);
			}
			else SetLocalInt(oToB, "L010", 0);

			if ((nInitLevel >= 3) && (nSS >= 1))
			{
				SetLocalInt(oToB, "L011", STANCE_GIANT_KILLING_STYLE);
			}
			else SetLocalInt(oToB, "L011", 0);

			if ((nInitLevel >= 5) && (nSD >= 2))
			{
				SetLocalInt(oToB, "L012", STANCE_GIANTS_STANCE);
			}
			else SetLocalInt(oToB, "L012", 0);

			if ((nInitLevel >= 5) && (nDM >= 2) && (!GetHasFeat(FEAT_KEEN_SENSE, oPC)))
			{
				SetLocalInt(oToB, "L013", STANCE_HEARING_THE_AIR);
			}
			else SetLocalInt(oToB, "L013", 0);

			if ((nInitLevel >= 3) && (nDW >= 1))
			{
				SetLocalInt(oToB, "L014", STANCE_HOLOSTCLK);
			}
			else SetLocalInt(oToB, "L014", 0);

			if (!GetHasFeat(FEAT_SCENT, oPC))
			{
				SetLocalInt(oToB, "L015", STANCE_HUNTERS_SENSE);
			}
			else SetLocalInt(oToB, "L015", 0);

			SetLocalInt(oToB, "L016", STANCE_ISLAND_OF_BLADES);

			if ((nInitLevel >= 3) && (nTC >= 1))
			{
				SetLocalInt(oToB, "L017", STANCE_LEAPING_DRAGON_STANCE);
			}
			else SetLocalInt(oToB, "L017", 0);

			if ((nInitLevel >= 8) && (nDM >= 3))
			{
				SetLocalInt(oToB, "L018", STANCE_OF_ALACRITY);
			}
			else SetLocalInt(oToB, "L018", 0);

			SetLocalInt(oToB, "L019", STANCE_OF_CLARITY);

			if ((nInitLevel >= 3) && (nDM >= 1))
			{
				SetLocalInt(oToB, "L020", STANCE_PEARL_OF_BLACK_DOUBT);
			}
			else SetLocalInt(oToB, "L020", 0);

			if ((nInitLevel >= 7) && (nTC >= 2))
			{
				SetLocalInt(oToB, "L021", STANCE_PREY_ON_THE_WEAK);
			}
			else SetLocalInt(oToB, "L021", 0);

			if (nInitLevel >= 3)
			{
				SetLocalInt(oToB, "L022", STANCE_ROOTS_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L022", 0);

			if ((nInitLevel >= 8) && (nDW >= 3))
			{
				SetLocalInt(oToB, "L023", STANCE_RSNPHEONIX);
			}
			else SetLocalInt(oToB, "L023", 0);

			if ((nInitLevel >= 5) && (nSS >= 2))
			{
				SetLocalInt(oToB, "L024", STANCE_SHIFTING_DEFENSE);
			}
			else SetLocalInt(oToB, "L025", 0);

			SetLocalInt(oToB, "L026", STANCE_STEP_OF_THE_WIND);
			SetLocalInt(oToB, "L027", STANCE_STONEFOOT_STANCE);

			if ((nInitLevel >= 8) && (nSD >= 3))
			{
				SetLocalInt(oToB, "L028", STANCE_STRENGTH_OF_STONE);
			}
			else SetLocalInt(oToB, "L028", 0);

			if ((nInitLevel >= 8) && (nTC >= 2))
			{
				SetLocalInt(oToB, "L029", STANCE_WOLF_PACK_TACTICS);
			}
			else SetLocalInt(oToB, "L029", 0);

			if ((nInitLevel >= 3) && (nTC >= 1))
			{
				SetLocalInt(oToB, "L030", STANCE_WOLVERINE_STANCE);
			}
			else SetLocalInt(oToB, "L030", 0);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			if ((nInitLevel >= 3) && (nIH >= 1))
			{
				SetLocalInt(oToB, "L01", STANCE_ABSOLUTE_STEEL);
			}
			else SetLocalInt(oToB, "L01", 0);

			SetLocalInt(oToB, "L02", STANCE_BLOOD_IN_THE_WATER);
			SetLocalInt(oToB, "L04", STANCE_BOLSTERING_VOICE);

			if ((nInitLevel >= 3) && (nSD >= 1))
			{
				SetLocalInt(oToB, "L05", STANCE_CRUSHING_WEIGHT_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L05", 0);

			if ((nInitLevel >= 5) && (nIH >= 2))
			{
				SetLocalInt(oToB, "L06", STANCE_DANCING_BLADE_FORM);
			}
			else SetLocalInt(oToB, "L06", 0);

			if ((nInitLevel >= 5) && (nSD >= 2))
			{
				SetLocalInt(oToB, "L07", STANCE_GIANTS_STANCE);
			}
			else SetLocalInt(oToB, "L07", 0);

			if ((nInitLevel >= 5) && (nDM >= 2) && (!GetHasFeat(FEAT_KEEN_SENSE, oPC)))
			{
				SetLocalInt(oToB, "L08", STANCE_HEARING_THE_AIR);
			}
			else SetLocalInt(oToB, "L08", 0);

			if (!GetHasFeat(FEAT_SCENT, oPC))
			{
				SetLocalInt(oToB, "L09", STANCE_HUNTERS_SENSE);
			}
			else SetLocalInt(oToB, "L09", 0);

			SetLocalInt(oToB, "L010", STANCE_LEADING_THE_CHARGE);

			if ((nInitLevel >= 3) && (nTC >= 1))
			{
				SetLocalInt(oToB, "L011", STANCE_LEAPING_DRAGON_STANCE);
			}
			else SetLocalInt(oToB, "L011", 0);

			if ((nInitLevel >= 8) && (nDM >= 3))
			{
				SetLocalInt(oToB, "L012", STANCE_OF_ALACRITY);
			}
			else SetLocalInt(oToB, "L012", 0);

			SetLocalInt(oToB, "L013", STANCE_OF_CLARITY);

			if ((nInitLevel >= 3) && (nDM >= 1))
			{
				SetLocalInt(oToB, "L014", STANCE_PEARL_OF_BLACK_DOUBT);
			}
			else SetLocalInt(oToB, "L014", 0);

			if ((nInitLevel >= 5) && (nWR >= 2))
			{
				SetLocalInt(oToB, "L015", STANCE_PRESS_THE_ADVANTAGE);
			}
			else SetLocalInt(oToB, "L015", 0);

			if ((nInitLevel >= 7) && (nTC >= 2))
			{
				SetLocalInt(oToB, "L016", STANCE_PREY_ON_THE_WEAK);
			}
			else SetLocalInt(oToB, "L016", 0);

			SetLocalInt(oToB, "L017", STANCE_PUNISHING_STANCE);

			if (nInitLevel >= 3)
			{
				SetLocalInt(oToB, "L018", STANCE_ROOTS_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L018", 0);

			SetLocalInt(oToB, "L019", STANCE_STONEFOOT_STANCE);

			if ((nInitLevel >= 8) && (nSD >= 3))
			{
				SetLocalInt(oToB, "L020", STANCE_STRENGTH_OF_STONE);
			}
			else SetLocalInt(oToB, "L020", 0);

			if ((nInitLevel >= 8) && (nIH >= 3))
			{
				SetLocalInt(oToB, "L021", STANCE_SUPREME_BLADE_PARRY);
			}
			else SetLocalInt(oToB, "L021", 0);

			if ((nInitLevel >= 8) && (nWR >= 1))
			{
				SetLocalInt(oToB, "L022", STANCE_SWARM_TACTICS);
			}
			else SetLocalInt(oToB, "L022", 0);

			if ((nInitLevel >= 3) && (nWR >= 1))
			{
				SetLocalInt(oToB, "L023", STANCE_TACTICS_OF_THE_WOLF);
			}
			else SetLocalInt(oToB, "L023", 0);

			if ((nInitLevel >= 8) && (nTC >= 2))
			{
				SetLocalInt(oToB, "L024", STANCE_WOLF_PACK_TACTICS);
			}
			else SetLocalInt(oToB, "L024", 0);

			if ((nInitLevel >= 3) && (nTC >= 1))
			{
				SetLocalInt(oToB, "L025", STANCE_WOLVERINE_STANCE);
			}
			else SetLocalInt(oToB, "L025", 0);
		}
		else //Martial Stance.  Requires a minimum of one maneuver in the stance's discipline in order to learn.
		{
			if ((nInitLevel >= 3) && (nIH >= 1))
			{
				SetLocalInt(oToB, "L01", STANCE_ABSOLUTE_STEEL);
			}
			else SetLocalInt(oToB, "L01", 0);

			if ((nInitLevel >= 3) && (nSH >= 1))
			{
				SetLocalInt(oToB, "L02", STANCE_ASSNS_STANCE);
			}
			else SetLocalInt(oToB, "L02", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L03", STANCE_AURA_OF_CHAOS);
			}
			else SetLocalInt(oToB, "L03", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L04", STANCE_AURA_OF_PERFECT_ORDER);
			}
			else SetLocalInt(oToB, "L04", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L05", STANCE_AURA_OF_TRIUMPH);
			}
			else SetLocalInt(oToB, "L05", 0);

			if ((nInitLevel >= 6) && (nDS >= 2))
			{
				SetLocalInt(oToB, "L06", STANCE_AURA_OF_TYRANNY);
			}
			else SetLocalInt(oToB, "L06", 0);

			if ((nInitLevel >= 8) && (nSH >= 2))
			{
				SetLocalInt(oToB, "L07", STANCE_BALANCE_SKY);
			}
			else SetLocalInt(oToB, "L07", 0);

			if (nTC >= 1)
			{
				SetLocalInt(oToB, "L08", STANCE_BLOOD_IN_THE_WATER);
			}
			else SetLocalInt(oToB, "L08", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L09", STANCE_BOLSTERING_VOICE);
			}
			else SetLocalInt(oToB, "L09", 0);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L010", STANCE_CHILD_SHADOW);
			}
			else SetLocalInt(oToB, "L010", 0);

			if ((nSD >= 1) && (nInitLevel >= 3))
			{
				SetLocalInt(oToB, "L011", STANCE_CRUSHING_WEIGHT_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L011", 0);

			if ((nSH >= 1) && (nInitLevel >= 3))
			{
				SetLocalInt(oToB, "L012", STANCE_DANCE_SPIDER);
			}
			else SetLocalInt(oToB, "L012", 0);

			if ((nInitLevel >= 5) && (nIH >= 2))
			{
				SetLocalInt(oToB, "L013", STANCE_DANCING_BLADE_FORM);
			}
			else SetLocalInt(oToB, "L013", 0);

			if ((nInitLevel >= 5) && (nSH >= 1))
			{
				SetLocalInt(oToB, "L014", STANCE_DANCING_MOTH);
			}
			else SetLocalInt(oToB, "L014", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L015", STANCE_FLMSBLSS);
			}
			else SetLocalInt(oToB, "L015", 0);

			if ((nInitLevel >= 6) && (nDW >= 2))
			{
				SetLocalInt(oToB, "L016", STANCE_FRYASLT);
			}
			else SetLocalInt(oToB, "L016", 0);

			if ((nInitLevel >= 8) && (nSS >= 3))
			{
				SetLocalInt(oToB, "L017", STANCE_GHOSTLY_DEFENSE);
			}
			else SetLocalInt(oToB, "L017", 0);

			if ((nInitLevel >= 3) && (nSS >= 1))
			{
				SetLocalInt(oToB, "L018", STANCE_GIANT_KILLING_STYLE);
			}
			else SetLocalInt(oToB, "L018", 0);

			if ((nInitLevel >= 5) && (nSD >= 2))
			{
				SetLocalInt(oToB, "L019", STANCE_GIANTS_STANCE);
			}
			else SetLocalInt(oToB, "L019", 0);

			if ((nInitLevel >= 5) && (nDM >= 2) && (!GetHasFeat(FEAT_KEEN_SENSE, oPC)))
			{
				SetLocalInt(oToB, "L020", STANCE_HEARING_THE_AIR);
			}
			else SetLocalInt(oToB, "L020", 0);

			if ((nInitLevel >= 3) && (nDW >= 1))
			{
				SetLocalInt(oToB, "L021", STANCE_HOLOSTCLK);
			}
			else SetLocalInt(oToB, "L021", 0);

			if ((nTC >= 1) && (!GetHasFeat(FEAT_SCENT, oPC)))
			{
				SetLocalInt(oToB, "L022", STANCE_HUNTERS_SENSE);
			}
			else SetLocalInt(oToB, "L022", 0);

			if ((nInitLevel >= 8) && (nDS >= 3))
			{
				SetLocalInt(oToB, "L023", STANCE_IMMORTAL_FORTITUDE);
			}
			else SetLocalInt(oToB, "L023", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L024", STANCE_IRON_GUARDS_GLARE);
			}
			else SetLocalInt(oToB, "L024", 0);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L025", STANCE_ISLAND_OF_BLADES);
			}
			else SetLocalInt(oToB, "L025", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L026", STANCE_LEADING_THE_CHARGE);
			}
			else SetLocalInt(oToB, "L026", 0);

			if ((nInitLevel >= 3) && (nTC >= 1))
			{
				SetLocalInt(oToB, "L027", STANCE_LEAPING_DRAGON_STANCE);
			}
			else SetLocalInt(oToB, "L027", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L028", STANCE_MARTIAL_SPIRIT);
			}
			else SetLocalInt(oToB, "L028", 0);

			if ((nInitLevel >= 8) && (nDM >= 3))
			{
				SetLocalInt(oToB, "L029", STANCE_OF_ALACRITY);
			}
			else SetLocalInt(oToB, "L029", 0);

			if (nDM >= 1)
			{
				SetLocalInt(oToB, "L030", STANCE_OF_CLARITY);
			}
			else SetLocalInt(oToB, "L030", 0);

			if ((nInitLevel >= 3) && (nDM >= 1))
			{
				SetLocalInt(oToB, "L031", STANCE_PEARL_OF_BLACK_DOUBT);
			}
			else SetLocalInt(oToB, "L031", 0);

			if ((nInitLevel >= 5) && (nWR >= 2))
			{
				SetLocalInt(oToB, "L032", STANCE_PRESS_THE_ADVANTAGE);
			}
			else SetLocalInt(oToB, "L032", 0);

			if ((nInitLevel >= 7) && (nTC >= 2))
			{
				SetLocalInt(oToB, "L033", STANCE_PREY_ON_THE_WEAK);
			}
			else SetLocalInt(oToB, "L033", 0);

			if (nIH >= 1)
			{
				SetLocalInt(oToB, "L034", STANCE_PUNISHING_STANCE);
			}
			else SetLocalInt(oToB, "L034", 0);

			if ((nSD >= 1) && (nInitLevel >= 3))
			{
				SetLocalInt(oToB, "L035", STANCE_ROOTS_OF_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L035", 0);

			if ((nInitLevel >= 8) && (nDW >= 3))
			{
				SetLocalInt(oToB, "L036", STANCE_RSNPHEONIX);
			}
			else SetLocalInt(oToB, "L036", 0);

			if ((nInitLevel >= 5) && (nSS >= 2))
			{
				SetLocalInt(oToB, "L037", STANCE_SHIFTING_DEFENSE);
			}
			else SetLocalInt(oToB, "L037", 0);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L038", STANCE_STEP_OF_THE_WIND);
			}
			else SetLocalInt(oToB, "L038", 0);

			if (nSD >= 1)
			{
				SetLocalInt(oToB, "L039", STANCE_STONEFOOT_STANCE);
			}
			else SetLocalInt(oToB, "L039", 0);

			if ((nInitLevel >= 8) && (nSD >= 3))
			{
				SetLocalInt(oToB, "L040", STANCE_STRENGTH_OF_STONE);
			}
			else SetLocalInt(oToB, "L040", 0);

			if ((nInitLevel >= 8) && (nIH >= 3))
			{
				SetLocalInt(oToB, "L041", STANCE_SUPREME_BLADE_PARRY);
			}
			else SetLocalInt(oToB, "L041", 0);

			if ((nInitLevel >= 8) && (nWR >= 1))
			{
				SetLocalInt(oToB, "L042", STANCE_SWARM_TACTICS);
			}
			else SetLocalInt(oToB, "L042", 0);

			if ((nInitLevel >= 3) && (nWR >= 1))
			{
				SetLocalInt(oToB, "L043", STANCE_TACTICS_OF_THE_WOLF);
			}
			else SetLocalInt(oToB, "L043", 0);

			if ((nInitLevel >= 3) && (GetHasFeat(nDS >= 1)))
			{
				SetLocalInt(oToB, "L044", STANCE_THICKET_OF_BLADES);
			}
			else SetLocalInt(oToB, "L044", 0);

			if ((nInitLevel >= 8) && (nTC >= 2))
			{
				SetLocalInt(oToB, "L045", STANCE_WOLF_PACK_TACTICS);
			}
			else SetLocalInt(oToB, "L045", 0);

			if ((nInitLevel >= 3) && (nTC >= 1))
			{
				SetLocalInt(oToB, "L046", STANCE_WOLVERINE_STANCE);
			}
			else SetLocalInt(oToB, "L046", 0);
		}
		int i;
		int nCheck;

		while (i < 47) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L0" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L0" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L01") > 0)
		{
			AddManeuver(n, "L01");
			n++;
		}

		if (GetLocalInt(oToB, "L02") > 0)
		{
			AddManeuver(n, "L02");
			n++;
		}

		if (GetLocalInt(oToB, "L03") > 0)
		{
			AddManeuver(n, "L03");
			n++;
		}

		if (GetLocalInt(oToB, "L04") > 0)
		{
			AddManeuver(n, "L04");
			n++;
		}

		if (GetLocalInt(oToB, "L05") > 0)
		{
			AddManeuver(n, "L05");
			n++;
		}

		if (GetLocalInt(oToB, "L06") > 0)
		{
			AddManeuver(n, "L06");
			n++;
		}

		if (GetLocalInt(oToB, "L07") > 0)
		{
			AddManeuver(n, "L07");
			n++;
		}

		if (GetLocalInt(oToB, "L08") > 0)
		{
			AddManeuver(n, "L08");
			n++;
		}

		if (GetLocalInt(oToB, "L09") > 0)
		{
			AddManeuver(n, "L09");
			n++;
		}

		if (GetLocalInt(oToB, "L010") > 0)
		{
			AddManeuver(n, "L010");
			n++;
		}

		if (GetLocalInt(oToB, "L011") > 0)
		{
			AddManeuver(n, "L011");
			n++;
		}

		if (GetLocalInt(oToB, "L012") > 0)
		{
			AddManeuver(n, "L012");
			n++;
		}

		if (GetLocalInt(oToB, "L013") > 0)
		{
			AddManeuver(n, "L013");
			n++;
		}

		if (GetLocalInt(oToB, "L014") > 0)
		{
			AddManeuver(n, "L014");
			n++;
		}

		if (GetLocalInt(oToB, "L015") > 0)
		{
			AddManeuver(n, "L015");
			n++;
		}

		if (GetLocalInt(oToB, "L016") > 0)
		{
			AddManeuver(n, "L016");
			n++;
		}

		if (GetLocalInt(oToB, "L017") > 0)
		{
			AddManeuver(n, "L017");
			n++;
		}

		if (GetLocalInt(oToB, "L018") > 0)
		{
			AddManeuver(n, "L018");
			n++;
		}

		if (GetLocalInt(oToB, "L019") > 0)
		{
			AddManeuver(n, "L019");
			n++;
		}

		if (GetLocalInt(oToB, "L020") > 0)
		{
			AddManeuver(n, "L020");
			n++;
		}

		if (GetLocalInt(oToB, "L021") > 0)
		{
			AddManeuver(n, "L021");
			n++;
		}

		if (GetLocalInt(oToB, "L022") > 0)
		{
			AddManeuver(n, "L022");
			n++;
		}

		if (GetLocalInt(oToB, "L023") > 0)
		{
			AddManeuver(n, "L023");
			n++;
		}

		if (GetLocalInt(oToB, "L024") > 0)
		{
			AddManeuver(n, "L024");
			n++;
		}

		if (GetLocalInt(oToB, "L025") > 0)
		{
			AddManeuver(n, "L025");
			n++;
		}

		if (GetLocalInt(oToB, "L026") > 0)
		{
			AddManeuver(n, "L026");
			n++;
		}

		if (GetLocalInt(oToB, "L027") > 0)
		{
			AddManeuver(n, "L027");
			n++;
		}

		if (GetLocalInt(oToB, "L028") > 0)
		{
			AddManeuver(n, "L028");
			n++;
		}

		if (GetLocalInt(oToB, "L029") > 0)
		{
			AddManeuver(n, "L029");
			n++;
		}

		if (GetLocalInt(oToB, "L030") > 0)
		{
			AddManeuver(n, "L030");
			n++;
		}

		if (GetLocalInt(oToB, "L031") > 0)
		{
			AddManeuver(n, "L031");
			n++;
		}

		if (GetLocalInt(oToB, "L032") > 0)
		{
			AddManeuver(n, "L032");
			n++;
		}

		if (GetLocalInt(oToB, "L033") > 0)
		{
			AddManeuver(n, "L033");
			n++;
		}

		if (GetLocalInt(oToB, "L034") > 0)
		{
			AddManeuver(n, "L034");
			n++;
		}

		if (GetLocalInt(oToB, "L035") > 0)
		{
			AddManeuver(n, "L035");
			n++;
		}

		if (GetLocalInt(oToB, "L036") > 0)
		{
			AddManeuver(n, "L036");
			n++;
		}

		if (GetLocalInt(oToB, "L037") > 0)
		{
			AddManeuver(n, "L037");
			n++;
		}

		if (GetLocalInt(oToB, "L038") > 0)
		{
			AddManeuver(n, "L038");
			n++;
		}

		if (GetLocalInt(oToB, "L039") > 0)
		{
			AddManeuver(n, "L039");
			n++;
		}

		if (GetLocalInt(oToB, "L040") > 0)
		{
			AddManeuver(n, "L040");
			n++;
		}

		if (GetLocalInt(oToB, "L041") > 0)
		{
			AddManeuver(n, "L041");
			n++;
		}

		if (GetLocalInt(oToB, "L042") > 0)
		{
			AddManeuver(n, "L042");
			n++;
		}

		if (GetLocalInt(oToB, "L043") > 0)
		{
			AddManeuver(n, "L043");
			n++;
		}

		if (GetLocalInt(oToB, "L044") > 0)
		{
			AddManeuver(n, "L044");
			n++;
		}

		if (GetLocalInt(oToB, "L045") > 0)
		{
			AddManeuver(n, "L045");
			n++;
		}

		if (GetLocalInt(oToB, "L046") > 0)
		{
			AddManeuver(n, "L046");
			n++;
		}
	}
	else if ((nLevel == 1) && (nInitLevel >= 1))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			SetLocalInt(oToB, "L11", STRIKE_CHARGING_MINOTAUR);
			SetLocalInt(oToB, "L12", STRIKE_CRUSADERS_STRIKE);
			SetLocalInt(oToB, "L13", STRIKE_DOUSE_THE_FLAMES);
			SetLocalInt(oToB, "L14", STRIKE_LEADING_THE_ATTACK);
			SetLocalInt(oToB, "L15", STRIKE_STONE_BONES);
			SetLocalInt(oToB, "L16", STRIKE_VANGUARD_STRIKE);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			SetLocalInt(oToB, "L11", STRIKE_CLINGING_SHADOW_STRIKE);
			SetLocalInt(oToB, "L12", STRIKE_CRUSADERS_STRIKE);
			SetLocalInt(oToB, "L13", STRIKE_SHADOW_BLADE_TECHNIQUE);
			SetLocalInt(oToB, "L14", STRIKE_VANGUARD_STRIKE);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			SetLocalInt(oToB, "L11", STRIKE_BLFLOURISH);
			SetLocalInt(oToB, "L12", BOOST_BRNBLADE);
			SetLocalInt(oToB, "L13", STRIKE_CHARGING_MINOTAUR);
			SetLocalInt(oToB, "L14", STRIKE_CLINGING_SHADOW_STRIKE);
			SetLocalInt(oToB, "L15", COUNTER_CHARGE);
			SetLocalInt(oToB, "L16", BOOST_DSTREMBER);
			SetLocalInt(oToB, "L17", STRIKE_MIGHTY_THROW);
			SetLocalInt(oToB, "L18", COUNTER_MOMENT_OF_PERFECT_MIND);
			SetLocalInt(oToB, "L19", STRIKE_SNBLADE);
			SetLocalInt(oToB, "L110", STRIKE_SHADOW_BLADE_TECHNIQUE);
			SetLocalInt(oToB, "L111", STRIKE_STONE_BONES);
			SetLocalInt(oToB, "L112", BOOST_SUDDEN_LEAP);
			SetLocalInt(oToB, "L113", BOOST_WINDSTRIDE);
			SetLocalInt(oToB, "L114", STRIKE_WOLF_FANG_STRIKE);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			SetLocalInt(oToB, "L11", STRIKE_CHARGING_MINOTAUR);
			SetLocalInt(oToB, "L12", STRIKE_DOUSE_THE_FLAMES);
			SetLocalInt(oToB, "L13", STRIKE_LEADING_THE_ATTACK);
			SetLocalInt(oToB, "L14", COUNTER_MOMENT_OF_PERFECT_MIND);
			SetLocalInt(oToB, "L15", STRIKE_SNBLADE);
			SetLocalInt(oToB, "L16", STRIKE_STEEL_WIND);
			SetLocalInt(oToB, "L17", STRIKE_STEELY_STRIKE);
			SetLocalInt(oToB, "L18", STRIKE_STONE_BONES);
			SetLocalInt(oToB, "L19", BOOST_SUDDEN_LEAP);
			SetLocalInt(oToB, "L110", STRIKE_WOLF_FANG_STRIKE);
		}
		else // Martial Study
		{
			SetLocalInt(oToB, "L11", STRIKE_BLFLOURISH);
			SetLocalInt(oToB, "L12", BOOST_BRNBLADE);
			SetLocalInt(oToB, "L13", STRIKE_CHARGING_MINOTAUR);
			SetLocalInt(oToB, "L14", STRIKE_CLINGING_SHADOW_STRIKE);
			SetLocalInt(oToB, "L15", STRIKE_CRUSADERS_STRIKE);
			SetLocalInt(oToB, "L16", COUNTER_CHARGE);
			SetLocalInt(oToB, "L17", BOOST_DSTREMBER);
			SetLocalInt(oToB, "L18", STRIKE_DOUSE_THE_FLAMES);
			SetLocalInt(oToB, "L19", STRIKE_LEADING_THE_ATTACK);
			SetLocalInt(oToB, "L110", STRIKE_MIGHTY_THROW);
			SetLocalInt(oToB, "L111", COUNTER_MOMENT_OF_PERFECT_MIND);
			SetLocalInt(oToB, "L112", STRIKE_SNBLADE);
			SetLocalInt(oToB, "L113", STRIKE_SHADOW_BLADE_TECHNIQUE);
			SetLocalInt(oToB, "L114", STRIKE_STEEL_WIND);
			SetLocalInt(oToB, "L115", STRIKE_STEELY_STRIKE);
			SetLocalInt(oToB, "L116", STRIKE_STONE_BONES);
			SetLocalInt(oToB, "L117", BOOST_SUDDEN_LEAP);
			SetLocalInt(oToB, "L118", STRIKE_VANGUARD_STRIKE);
			SetLocalInt(oToB, "L119", BOOST_WINDSTRIDE);
			SetLocalInt(oToB, "L120", STRIKE_WOLF_FANG_STRIKE);
		}

		int i;
		int nCheck;

		while (i < 21) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L1" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L1" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L11") > 0)
		{
			AddManeuver(n, "L11");
			n++;
		}

		if (GetLocalInt(oToB, "L12") > 0)
		{
			AddManeuver(n, "L12");
			n++;
		}

		if (GetLocalInt(oToB, "L13") > 0)
		{
			AddManeuver(n, "L13");
			n++;
		}

		if (GetLocalInt(oToB, "L14") > 0)
		{
			AddManeuver(n, "L14");
			n++;
		}

		if (GetLocalInt(oToB, "L15") > 0)
		{
			AddManeuver(n, "L15");
			n++;
		}

		if (GetLocalInt(oToB, "L16") > 0)
		{
			AddManeuver(n, "L16");
			n++;
		}

		if (GetLocalInt(oToB, "L17") > 0)
		{
			AddManeuver(n, "L17");
			n++;
		}

		if (GetLocalInt(oToB, "L18") > 0)
		{
			AddManeuver(n, "L18");
			n++;
		}

		if (GetLocalInt(oToB, "L19") > 0)
		{
			AddManeuver(n, "L19");
			n++;
		}

		if (GetLocalInt(oToB, "L110") > 0)
		{
			AddManeuver(n, "L110");
			n++;
		}

		if (GetLocalInt(oToB, "L111") > 0)
		{
			AddManeuver(n, "L111");
			n++;
		}

		if (GetLocalInt(oToB, "L112") > 0)
		{
			AddManeuver(n, "L112");
			n++;
		}

		if (GetLocalInt(oToB, "L113") > 0)
		{
			AddManeuver(n, "L113");
			n++;
		}

		if (GetLocalInt(oToB, "L114") > 0)
		{
			AddManeuver(n, "L114");
			n++;
		}

		if (GetLocalInt(oToB, "L115") > 0)
		{
			AddManeuver(n, "L115");
			n++;
		}

		if (GetLocalInt(oToB, "L116") > 0)
		{
			AddManeuver(n, "L116");
			n++;
		}

		if (GetLocalInt(oToB, "L117") > 0)
		{
			AddManeuver(n, "L117");
			n++;
		}

		if (GetLocalInt(oToB, "L118") > 0)
		{
			AddManeuver(n, "L118");
			n++;
		}

		if (GetLocalInt(oToB, "L119") > 0)
		{
			AddManeuver(n, "L119");
			n++;
		}

		if (GetLocalInt(oToB, "L120") > 0)
		{
			AddManeuver(n, "L120");
			n++;
		}
	}
	else if ((nLevel == 2) && (nInitLevel >= 2))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L21", STRIKE_BATTLE_LEADERS_CHARGE);
			}
			else SetLocalInt(oToB, "L21", 0);

			SetLocalInt(oToB, "L22", STRIKE_FOEHAMMER);
			SetLocalInt(oToB, "L23", STRIKE_MOUNTAIN_HAMMER);
			SetLocalInt(oToB, "L24", COUNTER_SHIELD_BLOCK);
			SetLocalInt(oToB, "L25", STRIKE_STONE_VISE);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L26", STRIKE_TACTICAL_STRIKE);
			}
			else SetLocalInt(oToB, "L26", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			SetLocalInt(oToB, "L21", BOOST_CLOAK_OF_DECEPTION);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L22", STRIKE_DRAIN_VITALITY);
			}
			else SetLocalInt(oToB, "L22", 0);

			SetLocalInt(oToB, "L23", STRIKE_FOEHAMMER);
			SetLocalInt(oToB, "L24", STRIKE_SHADOW_JAUNT);
			SetLocalInt(oToB, "L25", COUNTER_SHIELD_BLOCK);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			SetLocalInt(oToB, "L21", COUNTER_ACTION_BEFORE_THOUGHT);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L22", COUNTER_BAFFLING_DEFENSE);
			}
			else SetLocalInt(oToB, "L22", 0);

			SetLocalInt(oToB, "L23", BOOST_BRNBRAND);
			SetLocalInt(oToB, "L24", STRIKE_CLAW_AT_THE_MOON);
			SetLocalInt(oToB, "L25", STRIKE_CLEVER_POSITIONING);
			SetLocalInt(oToB, "L26", BOOST_CLOAK_OF_DECEPTION);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L27", STRIKE_DRAIN_VITALITY);
			}
			else SetLocalInt(oToB, "L27", 0);

			if (nDM >= 1)
			{
				SetLocalInt(oToB, "L28", STRIKE_EMERALD_RAZOR);
			}
			else SetLocalInt(oToB, "L28", 0);

			SetLocalInt(oToB, "L29", COUNTER_FIRERPST);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L210", STRIKE_FLSHSUN);
			}
			else SetLocalInt(oToB, "L210", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L211", STRIKE_HTCHLFLM);
			}
			else SetLocalInt(oToB, "L211", 0);

			SetLocalInt(oToB, "L212", STRIKE_MOUNTAIN_HAMMER);
			SetLocalInt(oToB, "L213", STRIKE_RABID_WOLF_STRIKE);
			SetLocalInt(oToB, "L214", STRIKE_SHADOW_JAUNT);
			SetLocalInt(oToB, "L215", STRIKE_STONE_VISE);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			SetLocalInt(oToB, "L21", COUNTER_ACTION_BEFORE_THOUGHT);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L22", STRIKE_BATTLE_LEADERS_CHARGE);
			}
			else SetLocalInt(oToB, "L22", 0);

			SetLocalInt(oToB, "L23", STRIKE_CLAW_AT_THE_MOON);
			SetLocalInt(oToB, "L24", STRIKE_DISARMING_STRIKE);

			if (nDM >= 1)
			{
				SetLocalInt(oToB, "L25", STRIKE_EMERALD_RAZOR);
			}
			else SetLocalInt(oToB, "L25", 0);

			SetLocalInt(oToB, "L26", STRIKE_MOUNTAIN_HAMMER);
			SetLocalInt(oToB, "L27", STRIKE_RABID_WOLF_STRIKE);
			SetLocalInt(oToB, "L28", STRIKE_STONE_VISE);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L29", STRIKE_TACTICAL_STRIKE);
			}
			else SetLocalInt(oToB, "L29", 0);

			SetLocalInt(oToB, "L210", COUNTER_WALL_OF_BLADES);
		}
		else // Martial Study
		{
			SetLocalInt(oToB, "L21", COUNTER_ACTION_BEFORE_THOUGHT);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L22", COUNTER_BAFFLING_DEFENSE);
			}
			else SetLocalInt(oToB, "L22", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L23", STRIKE_BATTLE_LEADERS_CHARGE);
			}
			else SetLocalInt(oToB, "L23", 0);

			SetLocalInt(oToB, "L24", BOOST_BRNBRAND);
			SetLocalInt(oToB, "L25", STRIKE_CLAW_AT_THE_MOON);
			SetLocalInt(oToB, "L26", STRIKE_CLEVER_POSITIONING);
			SetLocalInt(oToB, "L27", BOOST_CLOAK_OF_DECEPTION);
			SetLocalInt(oToB, "L28", STRIKE_DISARMING_STRIKE);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L29", STRIKE_DRAIN_VITALITY);
			}
			else SetLocalInt(oToB, "L29", 0);

			if (nDM >= 1)
			{
				SetLocalInt(oToB, "L210", STRIKE_EMERALD_RAZOR);
			}
			else SetLocalInt(oToB, "L210", 0);

			SetLocalInt(oToB, "L211", COUNTER_FIRERPST);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L212", STRIKE_FLSHSUN);
			}
			else SetLocalInt(oToB, "L212", 0);

			SetLocalInt(oToB, "L213", STRIKE_FOEHAMMER);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L214", STRIKE_HTCHLFLM);
			}
			else SetLocalInt(oToB, "L214", 0);

			SetLocalInt(oToB, "L215", STRIKE_MOUNTAIN_HAMMER);
			SetLocalInt(oToB, "L216", STRIKE_RABID_WOLF_STRIKE);
			SetLocalInt(oToB, "L217", STRIKE_SHADOW_JAUNT);
			SetLocalInt(oToB, "L218", COUNTER_SHIELD_BLOCK);
			SetLocalInt(oToB, "L219", STRIKE_STONE_VISE);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L220", STRIKE_TACTICAL_STRIKE);
			}
			else SetLocalInt(oToB, "L220", 0);

			SetLocalInt(oToB, "L221", COUNTER_WALL_OF_BLADES);
		}

		int i;
		int nCheck;

		while (i < 22) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L2" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L2" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L21") > 0)
		{
			AddManeuver(n, "L21");
			n++;
		}

		if (GetLocalInt(oToB, "L22") > 0)
		{
			AddManeuver(n, "L22");
			n++;
		}

		if (GetLocalInt(oToB, "L23") > 0)
		{
			AddManeuver(n, "L23");
			n++;
		}

		if (GetLocalInt(oToB, "L24") > 0)
		{
			AddManeuver(n, "L24");
			n++;
		}

		if (GetLocalInt(oToB, "L25") > 0)
		{
			AddManeuver(n, "L25");
			n++;
		}

		if (GetLocalInt(oToB, "L26") > 0)
		{
			AddManeuver(n, "L26");
			n++;
		}

		if (GetLocalInt(oToB, "L27") > 0)
		{
			AddManeuver(n, "L27");
			n++;
		}

		if (GetLocalInt(oToB, "L28") > 0)
		{
			AddManeuver(n, "L28");
			n++;
		}

		if (GetLocalInt(oToB, "L29") > 0)
		{
			AddManeuver(n, "L29");
			n++;
		}

		if (GetLocalInt(oToB, "L210") > 0)
		{
			AddManeuver(n, "L210");
			n++;
		}

		if (GetLocalInt(oToB, "L211") > 0)
		{
			AddManeuver(n, "L211");
			n++;
		}

		if (GetLocalInt(oToB, "L212") > 0)
		{
			AddManeuver(n, "L212");
			n++;
		}

		if (GetLocalInt(oToB, "L213") > 0)
		{
			AddManeuver(n, "L213");
			n++;
		}

		if (GetLocalInt(oToB, "L214") > 0)
		{
			AddManeuver(n, "L214");
			n++;
		}

		if (GetLocalInt(oToB, "L215") > 0)
		{
			AddManeuver(n, "L215");
			n++;
		}

		if (GetLocalInt(oToB, "L216") > 0)
		{
			AddManeuver(n, "L216");
			n++;
		}

		if (GetLocalInt(oToB, "L217") > 0)
		{
			AddManeuver(n, "L217");
			n++;
		}

		if (GetLocalInt(oToB, "L218") > 0)
		{
			AddManeuver(n, "L218");
			n++;
		}

		if (GetLocalInt(oToB, "L219") > 0)
		{
			AddManeuver(n, "L219");
			n++;
		}

		if (GetLocalInt(oToB, "L220") > 0)
		{
			AddManeuver(n, "L220");
			n++;
		}

		if (GetLocalInt(oToB, "L221") > 0)
		{
			AddManeuver(n, "L221");
			n++;
		}
	}
	else if ((nLevel == 3) && (nInitLevel >= 3))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			SetLocalInt(oToB, "L31", STRIKE_BONECRUSHER);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L32", BOOST_DEFENSIVE_REBUKE);
			}
			else SetLocalInt(oToB, "L32", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L33", BOOST_LIONS_ROAR);
			}
			else SetLocalInt(oToB, "L33", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L34", STRIKE_REVITALIZING_STRIKE);
			}
			else SetLocalInt(oToB, "L34", 0);

			if (nSD >= 1)
			{
				SetLocalInt(oToB, "L35", STRIKE_STONE_DRAGONS_FURY);
			}
			else SetLocalInt(oToB, "L35", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L36", BOOST_WHITE_RAVEN_TACTICS);
			}
			else SetLocalInt(oToB, "L36", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L31", BOOST_DEFENSIVE_REBUKE);
			}
			else SetLocalInt(oToB, "L31", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L32", STRIKE_REVITALIZING_STRIKE);
			}
			else SetLocalInt(oToB, "L32", 0);

			SetLocalInt(oToB, "L33", STRIKE_SHADOW_GARROTE);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L34", STRIKE_STRENGTH_DRAINING_STRIKE);
			}
			else SetLocalInt(oToB, "L34", 0);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			SetLocalInt(oToB, "L31", STRIKE_BONECRUSHER);
			SetLocalInt(oToB, "L32", STRIKE_DTHMARK);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L33", STRIKE_DEVASTATING_THROW);
			}
			else SetLocalInt(oToB, "L33", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L34", STRIKE_FANTHEFLM);
			}
			else SetLocalInt(oToB, "L34", 0);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L35", COUNTER_FEIGNED_OPENING);
			}
			else SetLocalInt(oToB, "L35", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L36", STRIKE_FLESH_RIPPER);
			}
			else SetLocalInt(oToB, "L36", 0);

			SetLocalInt(oToB, "L37", STRIKE_INSIGHTFUL_STRIKE);
			SetLocalInt(oToB, "L38", COUNTER_MIND_OVER_BODY);
			SetLocalInt(oToB, "L39", STRIKE_SHADOW_GARROTE);

			if (nSD >= 1)
			{
				SetLocalInt(oToB, "L310", STRIKE_STONE_DRAGONS_FURY);
			}
			else SetLocalInt(oToB, "L310", 0);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L312", STRIKE_STRENGTH_DRAINING_STRIKE);
			}
			else SetLocalInt(oToB, "L312", 0);

			if (nTC >= 1)
			{
				SetLocalInt(oToB, "L313", STRIKE_SOARING_RAPTOR_STRIKE);
			}
			else SetLocalInt(oToB, "L313", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L314", COUNTER_ZPHYRDNC);
			}
			else SetLocalInt(oToB, "L314", 0);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			SetLocalInt(oToB, "L31", STRIKE_BONECRUSHER);

			if (nIH >= 1)
			{
				SetLocalInt(oToB, "L32", STRIKE_EXORCISM_OF_STEEL);
			}
			else SetLocalInt(oToB, "L32", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L33", STRIKE_FLESH_RIPPER);
			}
			else SetLocalInt(oToB, "L33", 0);

			SetLocalInt(oToB, "L34", STRIKE_INSIGHTFUL_STRIKE);

			if (nIH >= 1)
			{
				SetLocalInt(oToB, "L35", STRIKE_IRON_HEART_SURGE);
			}
			else SetLocalInt(oToB, "L35", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L36", BOOST_LIONS_ROAR);
			}
			else SetLocalInt(oToB, "L36", 0);

			SetLocalInt(oToB, "L37", COUNTER_MIND_OVER_BODY);

			if (nSD >= 1)
			{
				SetLocalInt(oToB, "L38", STRIKE_STONE_DRAGONS_FURY);
			}
			else SetLocalInt(oToB, "L38", 0);

			if (nTC >= 1)
			{
				SetLocalInt(oToB, "L39", STRIKE_SOARING_RAPTOR_STRIKE);
			}
			else SetLocalInt(oToB, "L39", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L310", BOOST_WHITE_RAVEN_TACTICS);
			}
			else SetLocalInt(oToB, "L310", 0);
		}
		else // Martial Study
		{
			SetLocalInt(oToB, "L31", STRIKE_BONECRUSHER);
			SetLocalInt(oToB, "L32", STRIKE_DTHMARK);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L33", BOOST_DEFENSIVE_REBUKE);
			}
			else SetLocalInt(oToB, "L33", 0);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L34", STRIKE_DEVASTATING_THROW);
			}
			else SetLocalInt(oToB, "L34", 0);

			if (nIH >= 1)
			{
				SetLocalInt(oToB, "L35", STRIKE_EXORCISM_OF_STEEL);
			}
			else SetLocalInt(oToB, "L35", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L36", STRIKE_FANTHEFLM);
			}
			else SetLocalInt(oToB, "L36", 0);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L37", COUNTER_FEIGNED_OPENING);
			}
			else SetLocalInt(oToB, "L37", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L38", STRIKE_FLESH_RIPPER);
			}
			else SetLocalInt(oToB, "L38", 0);

			SetLocalInt(oToB, "L39", STRIKE_INSIGHTFUL_STRIKE);

			if (nIH >= 1)
			{
				SetLocalInt(oToB, "L310", STRIKE_IRON_HEART_SURGE);
			}
			else SetLocalInt(oToB, "L310", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L311", BOOST_LIONS_ROAR);
			}
			else SetLocalInt(oToB, "L311", 0);

			SetLocalInt(oToB, "L312", COUNTER_MIND_OVER_BODY);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L313", STRIKE_REVITALIZING_STRIKE);
			}
			else SetLocalInt(oToB, "L313", 0);

			SetLocalInt(oToB, "L314", STRIKE_SHADOW_GARROTE);

			if (nSD >= 1)
			{
				SetLocalInt(oToB, "L315", STRIKE_STONE_DRAGONS_FURY);
			}
			else SetLocalInt(oToB, "L315", 0);

			if (nSH >= 1)
			{
				SetLocalInt(oToB, "L316", STRIKE_STRENGTH_DRAINING_STRIKE);
			}
			else SetLocalInt(oToB, "L316", 0);

			if (nTC >= 1)
			{
				SetLocalInt(oToB, "L317", STRIKE_SOARING_RAPTOR_STRIKE);
			}
			else SetLocalInt(oToB, "L317", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L318", BOOST_WHITE_RAVEN_TACTICS);
			}
			else SetLocalInt(oToB, "L318", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L319", COUNTER_ZPHYRDNC);
			}
			else SetLocalInt(oToB, "L319", 0);
		}

		int i;
		int nCheck;

		while (i < 20) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L3" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L3" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L31") > 0)
		{
			AddManeuver(n, "L31");
			n++;
		}

		if (GetLocalInt(oToB, "L32") > 0)
		{
			AddManeuver(n, "L32");
			n++;
		}

		if (GetLocalInt(oToB, "L33") > 0)
		{
			AddManeuver(n, "L33");
			n++;
		}

		if (GetLocalInt(oToB, "L34") > 0)
		{
			AddManeuver(n, "L34");
			n++;
		}

		if (GetLocalInt(oToB, "L35") > 0)
		{
			AddManeuver(n, "L35");
			n++;
		}

		if (GetLocalInt(oToB, "L36") > 0)
		{
			AddManeuver(n, "L36");
			n++;
		}

		if (GetLocalInt(oToB, "L37") > 0)
		{
			AddManeuver(n, "L37");
			n++;
		}

		if (GetLocalInt(oToB, "L38") > 0)
		{
			AddManeuver(n, "L38");
			n++;
		}

		if (GetLocalInt(oToB, "L39") > 0)
		{
			AddManeuver(n, "L39");
			n++;
		}

		if (GetLocalInt(oToB, "L310") > 0)
		{
			AddManeuver(n, "L310");
			n++;
		}

		if (GetLocalInt(oToB, "L311") > 0)
		{
			AddManeuver(n, "L311");
			n++;
		}

		if (GetLocalInt(oToB, "L312") > 0)
		{
			AddManeuver(n, "L312");
			n++;
		}

		if (GetLocalInt(oToB, "L313") > 0)
		{
			AddManeuver(n, "L313");
			n++;
		}

		if (GetLocalInt(oToB, "L314") > 0)
		{
			AddManeuver(n, "L314");
			n++;
		}

		if (GetLocalInt(oToB, "L315") > 0)
		{
			AddManeuver(n, "L315");
			n++;
		}

		if (GetLocalInt(oToB, "L316") > 0)
		{
			AddManeuver(n, "L316");
			n++;
		}

		if (GetLocalInt(oToB, "L317") > 0)
		{
			AddManeuver(n, "L317");
			n++;
		}

		if (GetLocalInt(oToB, "L318") > 0)
		{
			AddManeuver(n, "L318");
			n++;
		}

		if (GetLocalInt(oToB, "L319") > 0)
		{
			AddManeuver(n, "L319");
			n++;
		}
	}
	else if ((nLevel == 4) && (nInitLevel >= 4))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L41", STRIKE_BONESPLITTING_STRIKE);
			}
			else SetLocalInt(oToB, "L41", 0);

			SetLocalInt(oToB, "L42", BOOST_BOULDER_ROLL);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L43", BOOST_COVERING_STRIKE);
			}
			else SetLocalInt(oToB, "L43", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L44", STRIKE_DIVINE_SURGE);
				SetLocalInt(oToB, "L45", STRIKE_ENTANGLING_BLADE);
			}
			else
			{
				SetLocalInt(oToB, "L44", 0);
				SetLocalInt(oToB, "L45", 0);
			}

			SetLocalInt(oToB, "L46", STRIKE_OVERWHELMING_MOUNTAIN_STRIKE);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L47", STRIKE_WHITE_RAVEN_STRIKE);
			}
			else SetLocalInt(oToB, "L47", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L41", STRIKE_DIVINE_SURGE);
				SetLocalInt(oToB, "L42", STRIKE_ENTANGLING_BLADE);
			}
			else
			{
				SetLocalInt(oToB, "L41", 0);
				SetLocalInt(oToB, "L42", 0);
			}

			SetLocalInt(oToB, "L43", STRIKE_HAND_OF_DEATH);

			if (nSH >= 2)
			{
				SetLocalInt(oToB, "L44", STRIKE_OBSCURING_SHADOW_VEIL);
			}
			else SetLocalInt(oToB, "L44", 0);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L41", STRIKE_BONESPLITTING_STRIKE);
			}
			else SetLocalInt(oToB, "L41", 0);

			SetLocalInt(oToB, "L42", BOOST_BOULDER_ROLL);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L43", STRIKE_BOUNDING_ASSAULT);
			}
			else SetLocalInt(oToB, "L43", 0);

			if (nSS >= 1)
			{
				SetLocalInt(oToB, "L44", STRIKE_COMET_THROW);
			}
			else SetLocalInt(oToB, "L44", 0);

			if (nTC >= 1)
			{
				SetLocalInt(oToB, "L45", STRIKE_DEATH_FROM_ABOVE);
			}
			else SetLocalInt(oToB, "L45", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L46", STRIKE_FIRESNAKE);
			}
			else SetLocalInt(oToB, "L46", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L47", BOOST_FOUNTAIN_OF_BLOOD);
			}
			else SetLocalInt(oToB, "L47", 0);

			SetLocalInt(oToB, "L48", STRIKE_HAND_OF_DEATH);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L49", STRIKE_MIND_STRIKE);
			}
			else SetLocalInt(oToB, "L49", 0);

			if (nSH >= 2)
			{
				SetLocalInt(oToB, "L410", STRIKE_OBSCURING_SHADOW_VEIL);
			}
			else SetLocalInt(oToB, "L410", 0);

			SetLocalInt(oToB, "L412", STRIKE_OVERWHELMING_MOUNTAIN_STRIKE);

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L416", STRIKE_OF_THE_BROKEN_SHIELD);
			}
			else SetLocalInt(oToB, "L416", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L413", STRIKE_RNBLADE);
			}
			else SetLocalInt(oToB, "L413", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L414", BOOST_SRNGBLD);
			}
			else SetLocalInt(oToB, "L414", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L415", STRIKE_SRNGCHRG);
			}
			else SetLocalInt(oToB, "L415", 0);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L41", STRIKE_BONESPLITTING_STRIKE);
			}
			else SetLocalInt(oToB, "L41", 0);

			SetLocalInt(oToB, "L42", BOOST_BOULDER_ROLL);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L43", STRIKE_BOUNDING_ASSAULT);
			}
			else SetLocalInt(oToB, "L43", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L44", BOOST_COVERING_STRIKE);
			}
			else SetLocalInt(oToB, "L44", 0);

			if (nTC >= 1)
			{
				SetLocalInt(oToB, "L45", STRIKE_DEATH_FROM_ABOVE);
			}
			else SetLocalInt(oToB, "L45", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L46", BOOST_FOUNTAIN_OF_BLOOD);
			}
			else SetLocalInt(oToB, "L46", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L47", COUNTER_LIGHTNING_RECOVERY);
			}
			else SetLocalInt(oToB, "L47", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L48", STRIKE_MIND_STRIKE);
			}
			else SetLocalInt(oToB, "L48", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L49", STRIKE_MITHRAL_TORNADO);
			}
			else SetLocalInt(oToB, "L49", 0);

			SetLocalInt(oToB, "L410", STRIKE_OVERWHELMING_MOUNTAIN_STRIKE);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L411", STRIKE_RNBLADE);
			}
			else SetLocalInt(oToB, "L411", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L412", STRIKE_WHITE_RAVEN_STRIKE);
			}
			else SetLocalInt(oToB, "L412", 0);
		}
		else // Martial Study
		{
			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L41", STRIKE_BONESPLITTING_STRIKE);
			}
			else SetLocalInt(oToB, "L41", 0);

			SetLocalInt(oToB, "L42", BOOST_BOULDER_ROLL);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L43", STRIKE_BOUNDING_ASSAULT);
			}
			else SetLocalInt(oToB, "L43", 0);

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L44", STRIKE_COMET_THROW);
			}
			else SetLocalInt(oToB, "L44", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L45", BOOST_COVERING_STRIKE);
			}
			else SetLocalInt(oToB, "L45", 0);

			if (nTC >= 1)
			{
				SetLocalInt(oToB, "L46", STRIKE_DEATH_FROM_ABOVE);
			}
			else SetLocalInt(oToB, "L46", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L47", STRIKE_DIVINE_SURGE);
				SetLocalInt(oToB, "L48", STRIKE_ENTANGLING_BLADE);
			}
			else
			{
				SetLocalInt(oToB, "L47", 0);
				SetLocalInt(oToB, "L48", 0);
			}

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L49", STRIKE_FIRESNAKE);
			}
			else SetLocalInt(oToB, "L49", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L410", BOOST_FOUNTAIN_OF_BLOOD);
			}
			else SetLocalInt(oToB, "L410", 0);

			SetLocalInt(oToB, "L411", STRIKE_HAND_OF_DEATH);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L412", COUNTER_LIGHTNING_RECOVERY);
			}
			else SetLocalInt(oToB, "L412", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L413", STRIKE_MIND_STRIKE);
			}
			else SetLocalInt(oToB, "L413", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L414", STRIKE_MITHRAL_TORNADO);
			}
			else SetLocalInt(oToB, "L414", 0);

			if (nSH >= 2)
			{
				SetLocalInt(oToB, "L415", STRIKE_OBSCURING_SHADOW_VEIL);
			}
			else SetLocalInt(oToB, "L415", 0);

			SetLocalInt(oToB, "L417", STRIKE_OVERWHELMING_MOUNTAIN_STRIKE);
			
			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L416", STRIKE_OF_THE_BROKEN_SHIELD);
			}
			else SetLocalInt(oToB, "L416", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L418", STRIKE_RNBLADE);
			}
			else SetLocalInt(oToB, "L418", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L419", BOOST_SRNGBLD);
			}
			else SetLocalInt(oToB, "L419", 0);

			if (nDW >= 1)
			{
				SetLocalInt(oToB, "L420", STRIKE_SRNGCHRG);
			}
			else SetLocalInt(oToB, "L420", 0);

			if (nWR >= 1)
			{
				SetLocalInt(oToB, "L421", STRIKE_WHITE_RAVEN_STRIKE);
			}
			else SetLocalInt(oToB, "L421", 0);
		}

		int i;
		int nCheck;

		while (i < 22) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L4" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L4" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L41") > 0)
		{
			AddManeuver(n, "L41");
			n++;
		}

		if (GetLocalInt(oToB, "L42") > 0)
		{
			AddManeuver(n, "L42");
			n++;
		}

		if (GetLocalInt(oToB, "L43") > 0)
		{
			AddManeuver(n, "L43");
			n++;
		}

		if (GetLocalInt(oToB, "L44") > 0)
		{
			AddManeuver(n, "L44");
			n++;
		}

		if (GetLocalInt(oToB, "L45") > 0)
		{
			AddManeuver(n, "L45");
			n++;
		}

		if (GetLocalInt(oToB, "L46") > 0)
		{
			AddManeuver(n, "L46");
			n++;
		}

		if (GetLocalInt(oToB, "L47") > 0)
		{
			AddManeuver(n, "L47");
			n++;
		}

		if (GetLocalInt(oToB, "L48") > 0)
		{
			AddManeuver(n, "L48");
			n++;
		}

		if (GetLocalInt(oToB, "L49") > 0)
		{
			AddManeuver(n, "L49");
			n++;
		}

		if (GetLocalInt(oToB, "L410") > 0)
		{
			AddManeuver(n, "L410");
			n++;
		}

		if (GetLocalInt(oToB, "L411") > 0)
		{
			AddManeuver(n, "L411");
			n++;
		}

		if (GetLocalInt(oToB, "L412") > 0)
		{
			AddManeuver(n, "L412");
			n++;
		}

		if (GetLocalInt(oToB, "L413") > 0)
		{
			AddManeuver(n, "L413");
			n++;
		}

		if (GetLocalInt(oToB, "L414") > 0)
		{
			AddManeuver(n, "L414");
			n++;
		}

		if (GetLocalInt(oToB, "L415") > 0)
		{
			AddManeuver(n, "L415");
			n++;
		}

		if (GetLocalInt(oToB, "L416") > 0)
		{
			AddManeuver(n, "L416");
			n++;
		}

		if (GetLocalInt(oToB, "L417") > 0)
		{
			AddManeuver(n, "L417");
			n++;
		}

		if (GetLocalInt(oToB, "L418") > 0)
		{
			AddManeuver(n, "L418");
			n++;
		}

		if (GetLocalInt(oToB, "L419") > 0)
		{
			AddManeuver(n, "L419");
			n++;
		}

		if (GetLocalInt(oToB, "L420") > 0)
		{
			AddManeuver(n, "L420");
			n++;
		}

		if (GetLocalInt(oToB, "L421") > 0)
		{
			AddManeuver(n, "L421");
			n++;
		}
	}
	else if ((nLevel == 5) && (nInitLevel >= 5))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L51", STRIKE_DAUNTING_STRIKE);
			}
			else SetLocalInt(oToB, "L51", 0);

			if ((nDS >= 1) && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL))
			{
				SetLocalInt(oToB, "L52", STRIKE_DOOM_CHARGE);
			}
			else SetLocalInt(oToB, "L52", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L53", STRIKE_ELDER_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L53", 0);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L54", STRIKE_FLANKING_MANEUVER);
			}
			else SetLocalInt(oToB, "L54", 0);

			if ((nDS >= 1) && (GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL))
			{
				SetLocalInt(oToB, "L55", STRIKE_LAW_BEARER);
			}
			else SetLocalInt(oToB, "L55", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L56", BOOST_MOUNTAIN_AVALANCHE);
			}
			else SetLocalInt(oToB, "L56", 0);

			if ((nDS >= 1) && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD))
			{
				SetLocalInt(oToB, "L57", STRIKE_RADIANT_CHARGE);
			}
			else SetLocalInt(oToB, "L57", 0);

			if ((nDS >= 1) && (GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC))
			{
				SetLocalInt(oToB, "L58", STRIKE_TIDE_OF_CHAOS);
			}
			else SetLocalInt(oToB, "L58", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if (nSH >= 2)
			{
				SetLocalInt(oToB, "L51", STRIKE_BLOODLETTING_STRIKE);
			}
			else SetLocalInt(oToB, "L51", 0);

			if (nDS >= 1)
			{
				SetLocalInt(oToB, "L52", STRIKE_DAUNTING_STRIKE);
			}
			else SetLocalInt(oToB, "L52", 0);

			if ((nDS >= 1) && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL))
			{
				SetLocalInt(oToB, "L53", STRIKE_DOOM_CHARGE);
			}
			else SetLocalInt(oToB, "L53", 0);

			if ((nDS >= 1) && (GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL))
			{
				SetLocalInt(oToB, "L54", STRIKE_LAW_BEARER);
			}
			else SetLocalInt(oToB, "L54", 0);

			if ((nDS >= 1) && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD))
			{
				SetLocalInt(oToB, "L55", STRIKE_RADIANT_CHARGE);
			}
			else SetLocalInt(oToB, "L55", 0);

			SetLocalInt(oToB, "L56", BOOST_SHADOW_STRIDE);

			if ((nDS >= 1) && (GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC))
			{
				SetLocalInt(oToB, "L57", STRIKE_TIDE_OF_CHAOS);
			}
			else SetLocalInt(oToB, "L57", 0);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			if (nSH >= 2)
			{
				SetLocalInt(oToB, "L51", STRIKE_BLOODLETTING_STRIKE);
			}
			else SetLocalInt(oToB, "L51", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L52", BOOST_DANCING_MONGOOSE);
			}
			else SetLocalInt(oToB, "L52", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L53", STRIKE_DISRUPTING_BLOW);
			}
			else SetLocalInt(oToB, "L53", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L54", STRIKE_DRGFLAME);
			}
			else SetLocalInt(oToB, "L54", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L55", STRIKE_ELDER_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L55", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L56", COUNTER_LPNFLAME);
				SetLocalInt(oToB, "L57", STRIKE_LNGNINFRNO);
			}
			else
			{
				SetLocalInt(oToB, "L56", 0);
				SetLocalInt(oToB, "L57", 0);
			}

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L58", COUNTER_MIRRORED_PURSUIT);
			}
			else SetLocalInt(oToB, "L58", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L59", BOOST_MOUNTAIN_AVALANCHE);
			}
			else SetLocalInt(oToB, "L59", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L510", STRIKE_POUNCING_CHARGE);
			}
			else SetLocalInt(oToB, "L510", 0);

			SetLocalInt(oToB, "L511", COUNTER_RAPID_COUNTER);
			SetLocalInt(oToB, "L512", BOOST_SHADOW_STRIDE);

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L513", STRIKE_SOARING_THROW);
				SetLocalInt(oToB, "L514", COUNTER_STALKING_SHADOW);
			}
			else
			{
				SetLocalInt(oToB, "L513", 0);
				SetLocalInt(oToB, "L514", 0);
			}
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L51", BOOST_DANCING_MONGOOSE);
			}
			else SetLocalInt(oToB, "L51", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L52", STRIKE_DAZING_STRIKE);
			}
			else SetLocalInt(oToB, "L52", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L53", STRIKE_DISRUPTING_BLOW);
			}
			else SetLocalInt(oToB, "L53", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L54", STRIKE_ELDER_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L54", 0);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L55", STRIKE_FLANKING_MANEUVER);
			}
			else SetLocalInt(oToB, "L55", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L56", COUNTER_IRON_HEART_FOCUS);
			}
			else SetLocalInt(oToB, "L56", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L57", BOOST_MOUNTAIN_AVALANCHE);
			}
			else SetLocalInt(oToB, "L57", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L58", STRIKE_POUNCING_CHARGE);
			}
			else SetLocalInt(oToB, "L58", 0);

			SetLocalInt(oToB, "L59", COUNTER_RAPID_COUNTER);
		}
		else // Martial Study
		{
			if (nSH >= 2)
			{
				SetLocalInt(oToB, "L51", STRIKE_BLOODLETTING_STRIKE);
			}
			else SetLocalInt(oToB, "L51", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L52", BOOST_DANCING_MONGOOSE);
			}
			else SetLocalInt(oToB, "L52", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L53", STRIKE_DAZING_STRIKE);
			}
			else SetLocalInt(oToB, "L53", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L54", STRIKE_DAUNTING_STRIKE);
			}
			else SetLocalInt(oToB, "L54", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L55", STRIKE_DISRUPTING_BLOW);
			}
			else SetLocalInt(oToB, "L55", 0);

			if ((nDS >= 1) && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL))
			{
				SetLocalInt(oToB, "L56", STRIKE_DOOM_CHARGE);
			}
			else SetLocalInt(oToB, "L56", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L57", STRIKE_DRGFLAME);
			}
			else SetLocalInt(oToB, "L57", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L58", STRIKE_ELDER_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L58", 0);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L59", STRIKE_FLANKING_MANEUVER);
			}
			else SetLocalInt(oToB, "L59", 0);

			if ((nDS >= 1) && (GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL))
			{
				SetLocalInt(oToB, "L510", STRIKE_LAW_BEARER);
			}
			else SetLocalInt(oToB, "L510", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L511", COUNTER_LPNFLAME);
				SetLocalInt(oToB, "L512", STRIKE_LNGNINFRNO);
			}
			else
			{
				SetLocalInt(oToB, "L511", 0);
				SetLocalInt(oToB, "L512", 0);
			}

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L513", COUNTER_IRON_HEART_FOCUS);
			}
			else SetLocalInt(oToB, "L513", 0);

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L514", COUNTER_MIRRORED_PURSUIT);
			}
			else SetLocalInt(oToB, "L514", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L515", BOOST_MOUNTAIN_AVALANCHE);
			}
			else SetLocalInt(oToB, "L515", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L516", STRIKE_POUNCING_CHARGE);
			}
			else SetLocalInt(oToB, "L516", 0);

			if ((nDS >= 1) && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD))
			{
				SetLocalInt(oToB, "L517", STRIKE_RADIANT_CHARGE);
			}
			else SetLocalInt(oToB, "L517", 0);

			SetLocalInt(oToB, "L518", COUNTER_RAPID_COUNTER);
			SetLocalInt(oToB, "L519", BOOST_SHADOW_STRIDE);

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L520", STRIKE_SOARING_THROW);
				SetLocalInt(oToB, "L521", COUNTER_STALKING_SHADOW);
			}
			else
			{
				SetLocalInt(oToB, "L520", 0);
				SetLocalInt(oToB, "L521", 0);
			}

			if ((nDS >= 1) && (GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC))
			{
				SetLocalInt(oToB, "L522", STRIKE_TIDE_OF_CHAOS);
			}
			else SetLocalInt(oToB, "L522", 0);
		}

		int i;
		int nCheck;

		while (i < 23) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L5" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L5" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L51") > 0)
		{
			AddManeuver(n, "L51");
			n++;
		}

		if (GetLocalInt(oToB, "L52") > 0)
		{
			AddManeuver(n, "L52");
			n++;
		}

		if (GetLocalInt(oToB, "L53") > 0)
		{
			AddManeuver(n, "L53");
			n++;
		}

		if (GetLocalInt(oToB, "L54") > 0)
		{
			AddManeuver(n, "L54");
			n++;
		}

		if (GetLocalInt(oToB, "L55") > 0)
		{
			AddManeuver(n, "L55");
			n++;
		}

		if (GetLocalInt(oToB, "L56") > 0)
		{
			AddManeuver(n, "L56");
			n++;
		}

		if (GetLocalInt(oToB, "L57") > 0)
		{
			AddManeuver(n, "L57");
			n++;
		}

		if (GetLocalInt(oToB, "L58") > 0)
		{
			AddManeuver(n, "L58");
			n++;
		}

		if (GetLocalInt(oToB, "L59") > 0)
		{
			AddManeuver(n, "L59");
			n++;
		}

		if (GetLocalInt(oToB, "L510") > 0)
		{
			AddManeuver(n, "L510");
			n++;
		}

		if (GetLocalInt(oToB, "L511") > 0)
		{
			AddManeuver(n, "L511");
			n++;
		}

		if (GetLocalInt(oToB, "L512") > 0)
		{
			AddManeuver(n, "L512");
			n++;
		}

		if (GetLocalInt(oToB, "L513") > 0)
		{
			AddManeuver(n, "L513");
			n++;
		}

		if (GetLocalInt(oToB, "L514") > 0)
		{
			AddManeuver(n, "L514");
			n++;
		}

		if (GetLocalInt(oToB, "L515") > 0)
		{
			AddManeuver(n, "L515");
			n++;
		}

		if (GetLocalInt(oToB, "L516") > 0)
		{
			AddManeuver(n, "L516");
			n++;
		}

		if (GetLocalInt(oToB, "L517") > 0)
		{
			AddManeuver(n, "L517");
			n++;
		}

		if (GetLocalInt(oToB, "L518") > 0)
		{
			AddManeuver(n, "L518");
			n++;
		}

		if (GetLocalInt(oToB, "L519") > 0)
		{
			AddManeuver(n, "L519");
			n++;
		}

		if (GetLocalInt(oToB, "L520") > 0)
		{
			AddManeuver(n, "L520");
			n++;
		}

		if (GetLocalInt(oToB, "L521") > 0)
		{
			AddManeuver(n, "L521");
			n++;
		}

		if (GetLocalInt(oToB, "L522") > 0)
		{
			AddManeuver(n, "L522");
			n++;
		}
	}
	else if ((nLevel == 6) && (nInitLevel >= 6))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			SetLocalInt(oToB, "L61", STRIKE_CRUSHING_VISE);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L62", STRIKE_IRON_BONES);
			}
			else SetLocalInt(oToB, "L62", 0);

			SetLocalInt(oToB, "L63", STRIKE_IRRESISTIBLE_MOUNTAIN_STRIKE);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L64", BOOST_ORDER_FORGED_FROM_CHAOS);
			}
			else SetLocalInt(oToB, "L64", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L65", STRIKE_RALLYING_STRIKE);
			}
			else SetLocalInt(oToB, "L65", 0);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L66", STRIKE_WAR_LEADERS_CHARGE);
			}
			else SetLocalInt(oToB, "L66", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L61", STRIKE_GHOST_BLADE);
			}
			else SetLocalInt(oToB, "L61", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L62", STRIKE_RALLYING_STRIKE);
			}
			else SetLocalInt(oToB, "L62", 0);

			SetLocalInt(oToB, "L63", STRIKE_SHADOW_NOOSE);
			SetLocalInt(oToB, "L64", STRIKE_STALKER_IN_THE_NIGHT);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L61", STRIKE_BALLISTA_THROW);
			}
			else SetLocalInt(oToB, "L61", 0);

			SetLocalInt(oToB, "L62", STRIKE_CRUSHING_VISE);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L63", STRIKE_DSRTTEMP);
			}
			else SetLocalInt(oToB, "L63", 0);

			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L64", STRIKE_GHOST_BLADE);
			}
			else SetLocalInt(oToB, "L64", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L65", STRIKE_INSIGHTFUL_STRIKE_GREATER);
			}
			else SetLocalInt(oToB, "L65", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L66", STRIKE_IRON_BONES);
			}
			else SetLocalInt(oToB, "L66", 0);

			SetLocalInt(oToB, "L67", STRIKE_IRRESISTIBLE_MOUNTAIN_STRIKE);
			
			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L68", BOOST_MOMENT_OF_ALACRITY);
			}
			else SetLocalInt(oToB, "L68", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L69", STRIKE_RABID_BEAR_STRIKE);
			}
			else SetLocalInt(oToB, "L69", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L610", STRIKE_RNGOFFIRE);
			}
			else SetLocalInt(oToB, "L610", 0);

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L611", COUNTER_SCORPION_PARRY);
			}
			else SetLocalInt(oToB, "L611", 0);

			SetLocalInt(oToB, "L612", STRIKE_SHADOW_NOOSE);
			SetLocalInt(oToB, "L613", STRIKE_STALKER_IN_THE_NIGHT);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L614", STRIKE_WOLF_CLIMBS_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L614", 0);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			SetLocalInt(oToB, "L61", STRIKE_CRUSHING_VISE);
			
			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L62", STRIKE_INSIGHTFUL_STRIKE_GREATER);
			}
			else SetLocalInt(oToB, "L62", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L63", STRIKE_IRON_BONES);
			}
			else SetLocalInt(oToB, "L63", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L64", BOOST_IRON_HEART_ENDURANCE);
			}
			else SetLocalInt(oToB, "L64", 0);

			SetLocalInt(oToB, "L65", STRIKE_IRRESISTIBLE_MOUNTAIN_STRIKE);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L66", COUNTER_MANTICORE_PARRY);
			}
			else SetLocalInt(oToB, "L66", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L67", BOOST_MOMENT_OF_ALACRITY);
			}
			else SetLocalInt(oToB, "L67", 0);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L68", BOOST_ORDER_FORGED_FROM_CHAOS);
			}
			else SetLocalInt(oToB, "L68", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L69", STRIKE_RABID_BEAR_STRIKE);
				SetLocalInt(oToB, "L610", STRIKE_WOLF_CLIMBS_THE_MOUNTAIN);
			}
			else
			{
				SetLocalInt(oToB, "L69", 0);
				SetLocalInt(oToB, "L610", 0);
			}

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L611", STRIKE_WAR_LEADERS_CHARGE);
			}
			else SetLocalInt(oToB, "L611", 0);
		}
		else // Martial Study
		{
			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L61", STRIKE_BALLISTA_THROW);
			}
			else SetLocalInt(oToB, "L61", 0);

			SetLocalInt(oToB, "L62", STRIKE_CRUSHING_VISE);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L63", STRIKE_DSRTTEMP);
			}
			else SetLocalInt(oToB, "L63", 0);

			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L64", STRIKE_GHOST_BLADE);
			}
			else SetLocalInt(oToB, "L64", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L65", STRIKE_INSIGHTFUL_STRIKE_GREATER);
			}
			else SetLocalInt(oToB, "L65", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L66", STRIKE_IRON_BONES);
			}
			else SetLocalInt(oToB, "L66", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L67", BOOST_IRON_HEART_ENDURANCE);
			}
			else SetLocalInt(oToB, "L67", 0);

			SetLocalInt(oToB, "L68", STRIKE_IRRESISTIBLE_MOUNTAIN_STRIKE);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L69", COUNTER_MANTICORE_PARRY);
			}
			else SetLocalInt(oToB, "L69", 0);

			if (nDM >= 2)
			{
				SetLocalInt(oToB, "L610", BOOST_MOMENT_OF_ALACRITY);
			}
			else SetLocalInt(oToB, "L610", 0);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L611", BOOST_ORDER_FORGED_FROM_CHAOS);
			}
			else SetLocalInt(oToB, "L611", 0);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L612", STRIKE_RABID_BEAR_STRIKE);
			}
			else SetLocalInt(oToB, "L612", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L613", STRIKE_RALLYING_STRIKE);
			}
			else SetLocalInt(oToB, "L613", 0);

			if (nDW >= 2)
			{
				SetLocalInt(oToB, "L614", STRIKE_RNGOFFIRE);
			}
			else SetLocalInt(oToB, "L614", 0);

			if (nSS >= 2)
			{
				SetLocalInt(oToB, "L615", COUNTER_SCORPION_PARRY);
			}
			else SetLocalInt(oToB, "L615", 0);

			SetLocalInt(oToB, "L616", STRIKE_SHADOW_NOOSE);
			SetLocalInt(oToB, "L617", STRIKE_STALKER_IN_THE_NIGHT);

			if (nTC >= 2)
			{
				SetLocalInt(oToB, "L618", STRIKE_WOLF_CLIMBS_THE_MOUNTAIN);
			}
			else SetLocalInt(oToB, "L618", 0);

			if (nWR >= 2)
			{
				SetLocalInt(oToB, "L619", STRIKE_WAR_LEADERS_CHARGE);
			}
			else SetLocalInt(oToB, "L619", 0);
		}

		int i;
		int nCheck;

		while (i < 20) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L6" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L6" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L61") > 0)
		{
			AddManeuver(n, "L61");
			n++;
		}

		if (GetLocalInt(oToB, "L62") > 0)
		{
			AddManeuver(n, "L62");
			n++;
		}

		if (GetLocalInt(oToB, "L63") > 0)
		{
			AddManeuver(n, "L63");
			n++;
		}

		if (GetLocalInt(oToB, "L64") > 0)
		{
			AddManeuver(n, "L64");
			n++;
		}

		if (GetLocalInt(oToB, "L65") > 0)
		{
			AddManeuver(n, "L65");
			n++;
		}

		if (GetLocalInt(oToB, "L66") > 0)
		{
			AddManeuver(n, "L66");
			n++;
		}

		if (GetLocalInt(oToB, "L67") > 0)
		{
			AddManeuver(n, "L67");
			n++;
		}

		if (GetLocalInt(oToB, "L68") > 0)
		{
			AddManeuver(n, "L68");
			n++;
		}

		if (GetLocalInt(oToB, "L69") > 0)
		{
			AddManeuver(n, "L69");
			n++;
		}

		if (GetLocalInt(oToB, "L610") > 0)
		{
			AddManeuver(n, "L610");
			n++;
		}

		if (GetLocalInt(oToB, "L611") > 0)
		{
			AddManeuver(n, "L611");
			n++;
		}

		if (GetLocalInt(oToB, "L612") > 0)
		{
			AddManeuver(n, "L612");
			n++;
		}

		if (GetLocalInt(oToB, "L613") > 0)
		{
			AddManeuver(n, "L613");
			n++;
		}

		if (GetLocalInt(oToB, "L614") > 0)
		{
			AddManeuver(n, "L614");
			n++;
		}

		if (GetLocalInt(oToB, "L615") > 0)
		{
			AddManeuver(n, "L615");
			n++;
		}

		if (GetLocalInt(oToB, "L616") > 0)
		{
			AddManeuver(n, "L616");
			n++;
		}

		if (GetLocalInt(oToB, "L617") > 0)
		{
			AddManeuver(n, "L617");
			n++;
		}

		if (GetLocalInt(oToB, "L618") > 0)
		{
			AddManeuver(n, "L618");
			n++;
		}

		if (GetLocalInt(oToB, "L619") > 0)
		{
			AddManeuver(n, "L619");
			n++;
		}
	}
	else if ((nLevel == 7) && (nInitLevel >= 7))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L71", STRIKE_ANCIENT_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L71", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L72", STRIKE_CASTIGATING_STRIKE);
			}
			else SetLocalInt(oToB, "L72", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L73", BOOST_CLARION_CALL);
			}
			else SetLocalInt(oToB, "L73", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L74", STRIKE_COLOSSUS_STRIKE);
			}
			else SetLocalInt(oToB, "L74", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L75", COUNTER_SHIELD_COUNTER);
			}
			else SetLocalInt(oToB, "L75", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L76", STRIKE_SWARMING_ASSAULT);
			}
			else SetLocalInt(oToB, "L76", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L71", STRIKE_CASTIGATING_STRIKE);
			}
			else SetLocalInt(oToB, "L71", 0);

			SetLocalInt(oToB, "L72", STRIKE_DEATH_IN_THE_DARK);
			SetLocalInt(oToB, "L73", BOOST_SHADOW_BLINK);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L74", COUNTER_SHIELD_COUNTER);
			}
			else SetLocalInt(oToB, "L74", 0);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L71", STRIKE_ANCIENT_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L71", 0);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L72", STRIKE_AVALANCHE_OF_BLADES);
			}
			else SetLocalInt(oToB, "L72", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L73", STRIKE_COLOSSUS_STRIKE);
			}
			else SetLocalInt(oToB, "L73", 0);

			SetLocalInt(oToB, "L74", STRIKE_DEATH_IN_THE_DARK);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L75", STRIKE_HAMSTRING_ATTACK);
			}
			else SetLocalInt(oToB, "L75", 0);

			if (nSS >= 3)
			{
				SetLocalInt(oToB, "L76", STRIKE_HYDRA_SLAYING_STRIKE);
			}
			else SetLocalInt(oToB, "L76", 0);

			SetLocalInt(oToB, "L77", BOOST_INFERNOBLD);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L78", BOOST_QUICKSILVER_MOTION);
			}
			else SetLocalInt(oToB, "L78", 0);

			if (nDW >= 3)
			{
				SetLocalInt(oToB, "L79", STRIKE_SLMDRCHRG);
			}
			else SetLocalInt(oToB, "L79", 0);

			SetLocalInt(oToB, "L710", BOOST_SHADOW_BLINK);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L711", STRIKE_SWOOPING_DRAGON_STRIKE);
			}
			else SetLocalInt(oToB, "L711", 0);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L71", STRIKE_ANCIENT_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L71", 0);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L72", STRIKE_AVALANCHE_OF_BLADES);
			}
			else SetLocalInt(oToB, "L72", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L73", BOOST_CLARION_CALL);
			}
			else SetLocalInt(oToB, "L73", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L74", STRIKE_COLOSSUS_STRIKE);
			}
			else SetLocalInt(oToB, "L74", 0);

			if (nIH >= 3)
			{
				SetLocalInt(oToB, "L75", STRIKE_FINISHING_MOVE);
			}
			else SetLocalInt(oToB, "L75", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L76", STRIKE_HAMSTRING_ATTACK);
			}
			else SetLocalInt(oToB, "L76", 0);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L77", BOOST_QUICKSILVER_MOTION);
			}
			else SetLocalInt(oToB, "L77", 0);

			if (nIH >= 3)
			{
				SetLocalInt(oToB, "L78", BOOST_SCYTHING_BLADE);
			}
			else SetLocalInt(oToB, "L78", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L79", STRIKE_SWARMING_ASSAULT);
			}
			else SetLocalInt(oToB, "L79", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L710", STRIKE_SWOOPING_DRAGON_STRIKE);
			}
			else SetLocalInt(oToB, "L710", 0);
		}
		else // Martial Study
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L71", STRIKE_ANCIENT_MOUNTAIN_HAMMER);
			}
			else SetLocalInt(oToB, "L71", 0);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L72", STRIKE_AVALANCHE_OF_BLADES);
			}
			else SetLocalInt(oToB, "L72", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L73", STRIKE_CASTIGATING_STRIKE);
			}
			else SetLocalInt(oToB, "L73", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L74", BOOST_CLARION_CALL);
			}
			else SetLocalInt(oToB, "L74", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L75", STRIKE_COLOSSUS_STRIKE);
			}
			else SetLocalInt(oToB, "L75", 0);

			SetLocalInt(oToB, "L76", STRIKE_DEATH_IN_THE_DARK);

			if (nIH >= 3)
			{
				SetLocalInt(oToB, "L77", STRIKE_FINISHING_MOVE);
			}
			else SetLocalInt(oToB, "L77", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L78", STRIKE_HAMSTRING_ATTACK);
			}
			else SetLocalInt(oToB, "L78", 0);

			if (nSS >= 3)
			{
				SetLocalInt(oToB, "L79", STRIKE_HYDRA_SLAYING_STRIKE);
			}
			else SetLocalInt(oToB, "L79", 0);

			SetLocalInt(oToB, "L710", BOOST_INFERNOBLD);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L711", BOOST_QUICKSILVER_MOTION);
			}
			else SetLocalInt(oToB, "L711", 0);

			if (nDW >= 3)
			{
				SetLocalInt(oToB, "L712", STRIKE_SLMDRCHRG);
			}
			else SetLocalInt(oToB, "L712", 0);

			if (nIH >= 3)
			{
				SetLocalInt(oToB, "L713", BOOST_SCYTHING_BLADE);
			}
			else SetLocalInt(oToB, "L713", 0);

			SetLocalInt(oToB, "L714", BOOST_SHADOW_BLINK);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L715", COUNTER_SHIELD_COUNTER);
			}
			else SetLocalInt(oToB, "L715", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L716", STRIKE_SWARMING_ASSAULT);
			}
			else SetLocalInt(oToB, "L716", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L717", STRIKE_SWOOPING_DRAGON_STRIKE);
			}
			else SetLocalInt(oToB, "L717", 0);
		}

		int i;
		int nCheck;

		while (i < 18) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L7" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L7" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L71") > 0)
		{
			AddManeuver(n, "L71");
			n++;
		}

		if (GetLocalInt(oToB, "L72") > 0)
		{
			AddManeuver(n, "L72");
			n++;
		}

		if (GetLocalInt(oToB, "L73") > 0)
		{
			AddManeuver(n, "L73");
			n++;
		}

		if (GetLocalInt(oToB, "L74") > 0)
		{
			AddManeuver(n, "L74");
			n++;
		}

		if (GetLocalInt(oToB, "L75") > 0)
		{
			AddManeuver(n, "L75");
			n++;
		}

		if (GetLocalInt(oToB, "L76") > 0)
		{
			AddManeuver(n, "L76");
			n++;
		}

		if (GetLocalInt(oToB, "L77") > 0)
		{
			AddManeuver(n, "L77");
			n++;
		}

		if (GetLocalInt(oToB, "L78") > 0)
		{
			AddManeuver(n, "L78");
			n++;
		}

		if (GetLocalInt(oToB, "L79") > 0)
		{
			AddManeuver(n, "L79");
			n++;
		}

		if (GetLocalInt(oToB, "L710") > 0)
		{
			AddManeuver(n, "L710");
			n++;
		}

		if (GetLocalInt(oToB, "L711") > 0)
		{
			AddManeuver(n, "L711");
			n++;
		}

		if (GetLocalInt(oToB, "L712") > 0)
		{
			AddManeuver(n, "L712");
			n++;
		}

		if (GetLocalInt(oToB, "L713") > 0)
		{
			AddManeuver(n, "L713");
			n++;
		}

		if (GetLocalInt(oToB, "L714") > 0)
		{
			AddManeuver(n, "L714");
			n++;
		}

		if (GetLocalInt(oToB, "L715") > 0)
		{
			AddManeuver(n, "L715");
			n++;
		}

		if (GetLocalInt(oToB, "L716") > 0)
		{
			AddManeuver(n, "L716");
			n++;
		}

		if (GetLocalInt(oToB, "L717") > 0)
		{
			AddManeuver(n, "L717");
			n++;
		}
	}
	else if ((nLevel == 8) && (nInitLevel >= 8))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L81", STRIKE_ADAMANTINE_BONES);
			}
			else SetLocalInt(oToB, "L81", 0);

			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L82", STRIKE_EARTHSTRIKE_QUAKE);
			}
			else SetLocalInt(oToB, "L82", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L83", STRIKE_DIVINE_SURGE_GREATER);
			}
			else SetLocalInt(oToB, "L83", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L84", STRIKE_WHITE_RAVEN_HAMMER);
			}
			else SetLocalInt(oToB, "L84", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L81", STRIKE_ENERVATING_SHADOW_STRIKE);
			}
			else SetLocalInt(oToB, "L81", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L82", STRIKE_DIVINE_SURGE_GREATER);
			}
			else SetLocalInt(oToB, "L82", 0);

			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L83", COUNTER_ONE_WITH_SHADOW);
			}
			else SetLocalInt(oToB, "L83", 0);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L81", STRIKE_ADAMANTINE_BONES);
			}
			else SetLocalInt(oToB, "L81", 0);

			SetLocalInt(oToB, "L82", COUNTER_DIAMOND_DEFENSE);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L83", STRIKE_DNBLADE);
			}
			else SetLocalInt(oToB, "L83", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L84", STRIKE_EARTHSTRIKE_QUAKE);
			}
			else SetLocalInt(oToB, "L84", 0);

			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L85", STRIKE_ENERVATING_SHADOW_STRIKE);
			}
			else SetLocalInt(oToB, "L85", 0);

			if (nSS >= 3)
			{
				SetLocalInt(oToB, "L86", COUNTER_FOOLS_STRIKE);
			}
			else SetLocalInt(oToB, "L86", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L87", BOOST_GIRALLON_WINDMILL_FLESH_RIP);
			}
			else SetLocalInt(oToB, "L87", 0);

			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L88", COUNTER_ONE_WITH_SHADOW);
			}
			else SetLocalInt(oToB, "L88", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L89", BOOST_RAGING_MONGOOSE);
			}
			else SetLocalInt(oToB, "L89", 0);

			if (nDW >= 3)
			{
				SetLocalInt(oToB, "L810", STRIKE_WYRMSFLAME);
			}
			else SetLocalInt(oToB, "L810", 0);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L81", STRIKE_ADAMANTINE_BONES);
			}
			else SetLocalInt(oToB, "L81", 0);

			if (nIH >= 3)
			{
				SetLocalInt(oToB, "L82", STRIKE_ADAMANTINE_HURRICANE);
			}
			else SetLocalInt(oToB, "L82", 0);

			SetLocalInt(oToB, "L83", COUNTER_DIAMOND_DEFENSE);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L84", STRIKE_DNBLADE);
			}
			else SetLocalInt(oToB, "L84", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L85", STRIKE_EARTHSTRIKE_QUAKE);
			}
			else SetLocalInt(oToB, "L85", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L86", BOOST_GIRALLON_WINDMILL_FLESH_RIP);
			}
			else SetLocalInt(oToB, "L86", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L87", STRIKE_LIGHTNING_THROW);
			}
			else SetLocalInt(oToB, "L87", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L88", BOOST_RAGING_MONGOOSE);
			}
			else SetLocalInt(oToB, "L88", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L89", STRIKE_WHITE_RAVEN_HAMMER);
			}
			else SetLocalInt(oToB, "L89", 0);
		}
		else // Martial Study
		{
			if (nSD >= 3)
			{
				SetLocalInt(oToB, "L81", STRIKE_ADAMANTINE_BONES);
			}
			else SetLocalInt(oToB, "L81", 0);

			if (nIH >= 3)
			{
				SetLocalInt(oToB, "L82", STRIKE_ADAMANTINE_HURRICANE);
			}
			else SetLocalInt(oToB, "L82", 0);

			SetLocalInt(oToB, "L83", COUNTER_DIAMOND_DEFENSE);

			if (nDM >= 3)
			{
				SetLocalInt(oToB, "L84", STRIKE_DNBLADE);
			}
			else SetLocalInt(oToB, "L84", 0);

			if (nDS >= 2)
			{
				SetLocalInt(oToB, "L85", STRIKE_DIVINE_SURGE_GREATER);
			}
			else SetLocalInt(oToB, "L85", 0);

			if (nSD >= 2)
			{
				SetLocalInt(oToB, "L86", STRIKE_EARTHSTRIKE_QUAKE);
			}
			else SetLocalInt(oToB, "L86", 0);

			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L87", STRIKE_ENERVATING_SHADOW_STRIKE);
			}
			else SetLocalInt(oToB, "L87", 0);

			if (nSS >= 3)
			{
				SetLocalInt(oToB, "L88", COUNTER_FOOLS_STRIKE);
			}
			else SetLocalInt(oToB, "L88", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L89", BOOST_GIRALLON_WINDMILL_FLESH_RIP);
			}
			else SetLocalInt(oToB, "L89", 0);

			if (nIH >= 2)
			{
				SetLocalInt(oToB, "L810", STRIKE_LIGHTNING_THROW);
			}
			else SetLocalInt(oToB, "L810", 0);

			if (nSH >= 3)
			{
				SetLocalInt(oToB, "L811", COUNTER_ONE_WITH_SHADOW);
			}
			else SetLocalInt(oToB, "L811", 0);

			if (nTC >= 3)
			{
				SetLocalInt(oToB, "L812", BOOST_RAGING_MONGOOSE);
			}
			else SetLocalInt(oToB, "L812", 0);

			if (nDW >= 3)
			{
				SetLocalInt(oToB, "L813", STRIKE_WYRMSFLAME);
			}
			else SetLocalInt(oToB, "L813", 0);

			if (nWR >= 3)
			{
				SetLocalInt(oToB, "L814", STRIKE_WHITE_RAVEN_HAMMER);
			}
			else SetLocalInt(oToB, "L814", 0);
		}

		int i;
		int nCheck;

		while (i < 18) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L8" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L8" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L81") > 0)
		{
			AddManeuver(n, "L81");
			n++;
		}

		if (GetLocalInt(oToB, "L82") > 0)
		{
			AddManeuver(n, "L82");
			n++;
		}

		if (GetLocalInt(oToB, "L83") > 0)
		{
			AddManeuver(n, "L83");
			n++;
		}

		if (GetLocalInt(oToB, "L84") > 0)
		{
			AddManeuver(n, "L84");
			n++;
		}

		if (GetLocalInt(oToB, "L85") > 0)
		{
			AddManeuver(n, "L85");
			n++;
		}

		if (GetLocalInt(oToB, "L86") > 0)
		{
			AddManeuver(n, "L86");
			n++;
		}

		if (GetLocalInt(oToB, "L87") > 0)
		{
			AddManeuver(n, "L87");
			n++;
		}

		if (GetLocalInt(oToB, "L88") > 0)
		{
			AddManeuver(n, "L88");
			n++;
		}

		if (GetLocalInt(oToB, "L89") > 0)
		{
			AddManeuver(n, "L89");
			n++;
		}

		if (GetLocalInt(oToB, "L810") > 0)
		{
			AddManeuver(n, "L810");
			n++;
		}

		if (GetLocalInt(oToB, "L811") > 0)
		{
			AddManeuver(n, "L811");
			n++;
		}

		if (GetLocalInt(oToB, "L812") > 0)
		{
			AddManeuver(n, "L812");
			n++;
		}

		if (GetLocalInt(oToB, "L813") > 0)
		{
			AddManeuver(n, "L813");
			n++;
		}

		if (GetLocalInt(oToB, "L814") > 0)
		{
			AddManeuver(n, "L814");
			n++;
		}
	}
	else if ((nLevel == 9) && (nInitLevel >= 9))
	{
		if (nClass == CLASS_TYPE_CRUSADER)
		{
			SetLocalInt(oToB, "L91", STRIKE_MOUNTAIN_TOMBSTONE_STRIKE);

			if (nDS >= 3)
			{
				SetLocalInt(oToB, "L92", STRIKE_OF_RIGHTEOUS_VITALITY);
			}
			else SetLocalInt(oToB, "L92", 0);

			if (nWR >= 4)
			{
				SetLocalInt(oToB, "L93", STRIKE_WAR_MASTERS_CHARGE);
			}
			else SetLocalInt(oToB, "L93", 0);
		}
		else if (nClass == CLASS_TYPE_SAINT)
		{
			if (nSH >= 5)
			{
				SetLocalInt(oToB, "L91", STRIKE_FSCIE_STRIKE);
			}
			else SetLocalInt(oToB, "L91", 0);

			if (nDS >= 3)
			{
				SetLocalInt(oToB, "L92", STRIKE_OF_RIGHTEOUS_VITALITY);
			}
			else SetLocalInt(oToB, "L92", 0);
		}
		else if (nClass == CLASS_TYPE_SWORDSAGE)
		{
			if (nTC >= 4)
			{
				SetLocalInt(oToB, "L91", STRIKE_FERAL_DEATH_BLOW);
			}
			else SetLocalInt(oToB, "L91", 0);

			if (nSH >= 5)
			{
				SetLocalInt(oToB, "L92", STRIKE_FSCIE_STRIKE);
			}
			else SetLocalInt(oToB, "L92", 0);

			if (nDW >= 5)
			{
				SetLocalInt(oToB, "L93", STRIKE_INFERNOBLST);
			}
			else SetLocalInt(oToB, "L93", 0);

			SetLocalInt(oToB, "L94", STRIKE_MOUNTAIN_TOMBSTONE_STRIKE);

			if (nDM >= 4)
			{
				SetLocalInt(oToB, "L95", STRIKE_TIME_STANDS_STILL);
			}
			else SetLocalInt(oToB, "L95", 0);

			if (nSS >= 5)
			{
				SetLocalInt(oToB, "L96", STRIKE_TORNADO_THROW);
			}
			else SetLocalInt(oToB, "L96", 0);
		}
		else if (nClass == CLASS_TYPE_WARBLADE)
		{
			if (nTC >= 4)
			{
				SetLocalInt(oToB, "L91", STRIKE_FERAL_DEATH_BLOW);
			}
			else SetLocalInt(oToB, "L91", 0);

			SetLocalInt(oToB, "L92", STRIKE_MOUNTAIN_TOMBSTONE_STRIKE);

			if (nIH >= 4)
			{
				SetLocalInt(oToB, "L93", STRIKE_OF_PERFECT_CLARITY);
			}
			else SetLocalInt(oToB, "L93", 0);

			if (nDM >= 4)
			{
				SetLocalInt(oToB, "L94", STRIKE_TIME_STANDS_STILL);
			}
			else SetLocalInt(oToB, "L94", 0);

			if (nWR >= 4)
			{
				SetLocalInt(oToB, "L95", STRIKE_WAR_MASTERS_CHARGE);
			}
			else SetLocalInt(oToB, "L95", 0);
		}
		else // Martial Study
		{
			if (nTC >= 4)
			{
				SetLocalInt(oToB, "L91", STRIKE_FERAL_DEATH_BLOW);
			}
			else SetLocalInt(oToB, "L91", 0);

			if (nSH >= 5)
			{
				SetLocalInt(oToB, "L92", STRIKE_FSCIE_STRIKE);
			}
			else SetLocalInt(oToB, "L92", 0);

			if (nDW >= 5)
			{
				SetLocalInt(oToB, "L93", STRIKE_INFERNOBLST);
			}
			else SetLocalInt(oToB, "L93", 0);

			SetLocalInt(oToB, "L94", STRIKE_MOUNTAIN_TOMBSTONE_STRIKE);

			if (nIH >= 4)
			{
				SetLocalInt(oToB, "L95", STRIKE_OF_PERFECT_CLARITY);
			}
			else SetLocalInt(oToB, "L95", 0);

			if (nDS >= 3)
			{
				SetLocalInt(oToB, "L96", STRIKE_OF_RIGHTEOUS_VITALITY);
			}
			else SetLocalInt(oToB, "L96", 0);

			if (nDM >= 4)
			{
				SetLocalInt(oToB, "L97", STRIKE_TIME_STANDS_STILL);
			}
			else SetLocalInt(oToB, "L97", 0);

			if (nSS >= 5)
			{
				SetLocalInt(oToB, "L98", STRIKE_TORNADO_THROW);
			}
			else SetLocalInt(oToB, "L98", 0);

			if (nWR >= 4)
			{
				SetLocalInt(oToB, "L99", STRIKE_WAR_MASTERS_CHARGE);
			}
			else SetLocalInt(oToB, "L99", 0);
		}

		int i;
		int nCheck;

		while (i < 10) //Reomve any maneuvers the PC knows from the list.
		{
			nCheck = GetLocalInt(oToB, "L9" + IntToString(i));

			if (CheckIsManeuverKnown(nCheck) == TRUE)
			{
				SetLocalInt(oToB, "L9" + IntToString(i), 0);
			}

			i++;
		}

		int n;

		n = 1;

		if (GetLocalInt(oToB, "L91") > 0)
		{
			AddManeuver(n, "L91");
			n++;
		}

		if (GetLocalInt(oToB, "L92") > 0)
		{
			AddManeuver(n, "L92");
			n++;
		}

		if (GetLocalInt(oToB, "L93") > 0)
		{
			AddManeuver(n, "L93");
			n++;
		}

		if (GetLocalInt(oToB, "L94") > 0)
		{
			AddManeuver(n, "L94");
			n++;
		}

		if (GetLocalInt(oToB, "L95") > 0)
		{
			AddManeuver(n, "L95");
			n++;
		}

		if (GetLocalInt(oToB, "L96") > 0)
		{
			AddManeuver(n, "L96");
			n++;
		}

		if (GetLocalInt(oToB, "L97") > 0)
		{
			AddManeuver(n, "L97");
			n++;
		}

		if (GetLocalInt(oToB, "L98") > 0)
		{
			AddManeuver(n, "L98");
			n++;
		}

		if (GetLocalInt(oToB, "L99") > 0)
		{
			AddManeuver(n, "L99");
			n++;
		}
	}
}