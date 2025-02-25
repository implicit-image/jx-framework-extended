//////////////////////////////////////////////////////////////////////
//	Author: Drammel													//
//	Date: 6/9/2009													//
//	Title: bot9s_inc_retrain										//
//	Description: Script library for feat retraining functions.		//
//////////////////////////////////////////////////////////////////////

#include "bot9s_inc_constants"

// Prototypes

// Creates a list of feats that the PC knows.
// Must be broken into several parts to avoid a TMI error.
void AddKnownFeats(object oPC, int nStart, int nFinish);

// Runs the above function for the entire feat.2da listing.
void AddAllKnownFeats(object oPC);

// Displays the feats that the PC qualifies for and does not already know.
// Again, this is a setup for the big TMI prevention function.
void GetAvailableFeats(int nStart, int nFinish, object oPC = OBJECT_SELF);

// Runs the above function in segments to avoid TMI errors.
void GetAllAvailableFeats(object oPC = OBJECT_SELF);

// Displays discplines for the Insightful Strike: Weapon Focus menu.
void DisplaySSInsightfulStrike(object oPC = OBJECT_SELF);

// Adds Feats pending to be switched for the feats the PC is retraining to the 
// Added Feats window.
void DiplayAddedFeats(object oPC = OBJECT_SELF);

// Functions

// Creates a list of feats that the PC knows.
// Must be broken into several parts to avoid a TMI error.
void AddKnownFeats(object oPC, int nStart, int nFinish)
{
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	string sScreen = "SCREEN_LEVELUP_RETRAIN_FEATS";
	string sPane = "RETRAINPANE_PROTO";
	int i, nFSWpnFocus, nFSWeaponSpec, nForbidden, nForbidden1, nForbidden2, nForbidden3, nForbidden4, nForbidden5, nForbidden6;
	string sFeatType, sIcon, sName, sVari;

	// Favored Soul Weapon Proficeny is granted as a bonus feat and if it is
	// removed is granted again on each levelup it isn't present.  A check must
	// be used to prevent the class from granting free feats.
	if (GetLevelByClass(CLASS_TYPE_FAVORED_SOUL, oPC) > 0)
	{
		string sGod = GetDeity(oPC);
		string sCheck;
		int nSeraph;

		nSeraph = 1;
		sCheck = Get2DAString("nwn2_deities", "FirstName", nSeraph);

		while (sCheck != "")
		{
			if (sGod == sCheck)
			{
				nFSWpnFocus = StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponFocus", nSeraph));
				nFSWeaponSpec = StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponSpecialization", nSeraph));
				break;
			}

			nSeraph++;
			sCheck = Get2DAString("nwn2_deities", "FirstName", nSeraph);
		}
	}

	i = nStart;

	while (i < nFinish)
	{
		nForbidden = 0;
		nForbidden1 = GetLocalInt(oToB, "ForbiddenRetrain1");
		nForbidden2 = GetLocalInt(oToB, "ForbiddenRetrain2");
		nForbidden3 = GetLocalInt(oToB, "ForbiddenRetrain3");
		nForbidden4 = GetLocalInt(oToB, "ForbiddenRetrain4");
		nForbidden5 = GetLocalInt(oToB, "ForbiddenRetrain5");
		nForbidden6 = GetLocalInt(oToB, "ForbiddenRetrain6");

		if (i == nForbidden1)
		{
			nForbidden = 1;
		}

		if ((i == nForbidden2) && (nForbidden2 > 0)) // Because Alertness is something we'd never think of retraining! ;)
		{
			nForbidden = 1;
		}

		if ((i == nForbidden3) && (nForbidden3 > 0))
		{
			nForbidden = 1;
		}

		if ((i == nForbidden4) && (nForbidden4 > 0))
		{
			nForbidden = 1;
		}

		if ((i == nForbidden5) && (nForbidden5 > 0))
		{
			nForbidden = 1;
		}

		if ((i == nForbidden6) && (nForbidden6 > 0))
		{
			nForbidden = 1;
		}

		// Special cases, like Use Poison.
		if (i == 0 || i == 1799 || i == 1800 || i == 2129 || i == 2130 || i == 2131
		|| i == 1912 || i == 1913 || i == 1914 || i == 1915 || i == 1916 || i == 960
		|| i == 1113 || i == 1116 || i == 1917 ||  i == 2132 || i == 2133 || i == 6945)
		{
			nForbidden = 1;
		}

		// Bonus feats for classes.  Must be forbidden because feats granted by classes are automatically regranted to the player on levelup if they have been removed.
		if ((GetLevelByClass(CLASS_TYPE_CRUSADER, oPC) > 9) && (i == FEAT_DIEHARD_CRUSADER))
		{
			nForbidden = 1;
		}

		if ((GetLevelByClass(CLASS_TYPE_SWORDSAGE, oPC) > 4) && (i == FEAT_IMPROVED_INITIATIVE))
		{
			nForbidden = 1;
		}

		if ((GetLevelByClass(CLASS_TYPE_SWASHBUCKLER, oPC) > 0) && (i == FEAT_LUCK_OF_HEROES || i == FEAT_MOBILITY || i == FEAT_WEAPON_FINESSE))
		{
			nForbidden = 1;
		}

		if (i == nFSWpnFocus || i == nFSWeaponSpec) //Favored Soul Stuff
		{
			nForbidden = 1;
		}

		if (GetLevelByClass(CLASS_TYPE_ARCANE_SCHOLAR, oPC) > 0)
		{
			if (i == FEAT_MAXIMIZE_SPELL || i == FEAT_QUICKEN_SPELL || i == FEAT_IMPROVED_EMPOWER_SPELL
			|| i == FEAT_IMPROVED_MAXIMIZE_SPELL || i == FEAT_IMPROVED_QUICKEN_SPELL)
			{
				nForbidden = 1;
			}
		}

		if (GetLevelByClass(CLASS_TYPE_MONK, oPC) > 0)
		{
			if (i == 21 || i == 39 || i == 8 || i == 17 || i == 24)
			{
				nForbidden = 1;
			}
		}

		if ((GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0) && (i == FEAT_TOUGHNESS))
		{
			nForbidden = 1;
		}

		if ((GetLevelByClass(CLASS_TYPE_FRENZIEDBERSERKER, oPC) > 0) && (i == FEAT_TOUGHNESS))
		{
			nForbidden = 1;
		}

		// Racial abilites that shouldn't be retrained as well.
		if (GetSubRace(oPC) == RACIAL_SUBTYPE_AASIMAR)
		{
			if (i == 427 || i == 428 || i == 430)
			{
				nForbidden = 1;
			}
		}
		else if (GetSubRace(oPC) == RACIAL_SUBTYPE_TIEFLING)
		{
			if (i == 427 || i == 429 || i == 430)
			{
				nForbidden = 1;
			}
		}
		else if (GetSubRace(oPC) == RACIAL_SUBTYPE_GRAYORC)
		{
			if (i == 2178 || i == 1116 || i == 2248)
			{
				nForbidden = 1;
			}
		}
		else if (GetSubRace(oPC) == RACIAL_SUBTYPE_YUANTI)
		{
			if (i == 0 || i == 408 || i == 2171)
			{
				nForbidden = 1;
			}
		}

		if ((GetHasFeat(i, oPC)) && (GetLocalInt(oToB, "FeatRetrain1") != i) && (nForbidden == 0) && (i != 0))
		{
			sFeatType = Get2DAString("feat", "FeatCategory", i);

			if (sFeatType == "GENERAL_FT_CAT" || sFeatType == "SKILLNSAVE_FT_CAT" || sFeatType == "SPELLCASTING_FT_CAT" || sFeatType == "METAMAGIC_FT_CAT" || sFeatType == "DIVINE_FT_CAT" || sFeatType == "EPIC_FT_CAT")
			{
				sIcon = "RETRAIN_IMAGE=" + Get2DAString("feat", "ICON", i) + ".tga";
				sName = "RETRAIN_TEXT=" + GetStringByStrRef(StringToInt(Get2DAString("feat", "FEAT", i)));
				sVari = "7=" + IntToString(i);

				AddListBoxRow(oPC, sScreen, "RETRAIN_FEATS_LIST", sPane + IntToString(i), sName, sIcon, sVari, "");
			}
		}
		i++;
	}
}

// Runs the above function for the entire feat.2da listing.
void AddAllKnownFeats(object oPC = OBJECT_SELF)
{
	int nLimit = GetNum2DARows("feat");

	DelayCommand(0.01f, AddKnownFeats(oPC, 0, 250));
	DelayCommand(0.02f, AddKnownFeats(oPC, 250, 500));
	DelayCommand(0.03f, AddKnownFeats(oPC, 500, 750));
	DelayCommand(0.04f, AddKnownFeats(oPC, 750, 1000));
	DelayCommand(0.05f, AddKnownFeats(oPC, 1000, 1250));
	DelayCommand(0.06f, AddKnownFeats(oPC, 1250, 1500));
	DelayCommand(0.07f, AddKnownFeats(oPC, 1500, 1750));
	DelayCommand(0.08f, AddKnownFeats(oPC, 1750, 2000));
	DelayCommand(0.09f, AddKnownFeats(oPC, 2000, 2250));
	DelayCommand(0.10f, AddKnownFeats(oPC, 2250, 2500));
	DelayCommand(0.11f, AddKnownFeats(oPC, 2500, 2750));
	DelayCommand(0.12f, AddKnownFeats(oPC, 2750, 3000));
	DelayCommand(0.13f, AddKnownFeats(oPC, 3000, 3250));
	DelayCommand(0.14f, AddKnownFeats(oPC, 3250, 3500));
	DelayCommand(0.15f, AddKnownFeats(oPC, 3500, 3750));
	DelayCommand(0.16f, AddKnownFeats(oPC, 3750, 4000));
	DelayCommand(0.17f, AddKnownFeats(oPC, 4000, 4250));
	DelayCommand(0.18f, AddKnownFeats(oPC, 4250, 4500));
	DelayCommand(0.19f, AddKnownFeats(oPC, 4500, 4750));
	DelayCommand(0.20f, AddKnownFeats(oPC, 4750, 5000));
	DelayCommand(0.21f, AddKnownFeats(oPC, 5000, 5250));
	DelayCommand(0.22f, AddKnownFeats(oPC, 5250, 5500));
	DelayCommand(0.23f, AddKnownFeats(oPC, 5500, 5750));
	DelayCommand(0.24f, AddKnownFeats(oPC, 5750, 6000));
	DelayCommand(0.20f, AddKnownFeats(oPC, 4750, 5000));
	DelayCommand(0.21f, AddKnownFeats(oPC, 6000, 6250));
	DelayCommand(0.22f, AddKnownFeats(oPC, 6250, 6500));
	DelayCommand(0.23f, AddKnownFeats(oPC, 6500, 6750));
	DelayCommand(0.24f, AddKnownFeats(oPC, 6750, 7000));

	if (nLimit > 7000)
	{
		DelayCommand(0.25f, AddKnownFeats(oPC, 7000, 7250));
	}

	if (nLimit > 7250)
	{
		DelayCommand(0.26f, AddKnownFeats(oPC, 7250, 7500));
	}

	if (nLimit > 7500)
	{
		DelayCommand(0.27f, AddKnownFeats(oPC, 7500, 7750));
	}

	if (nLimit > 7750)
	{
		DelayCommand(0.28f, AddKnownFeats(oPC, 7750, 8000));
	}

	if (nLimit > 8000)
	{
		DelayCommand(0.29f, AddKnownFeats(oPC, 8000, nLimit));
	}
}

// Displays the feats that the PC qualifies for and does not already know.
// Again, this is a setup for the big TMI prevention function.
void GetAvailableFeats(int nStart, int nFinish, object oPC = OBJECT_SELF)
{
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	int nLevelCap = GetLocalInt(oToB, "LevelupCap");
	string sIcon, sName, sVari; // Listbox strings
	// Prerequisite strings (le sigh...)
	string sMinAB, sMinSTR, sMinDEX, sMinCON, sMinINT, sMinWIS, sMinCHA;
	string sMaxSTR, sMaxDEX, sMaxCON, sMaxINT, sMaxWIS, sMaxCHA, sFeatType;
	string sMinSpellLvl, sMinCasterLvl, sPrereq1, sPrereq2, sOrReq1, sOrReq2;
	string sOrReq3, sOrReq4, sOrReq5, sReqSkill, sReqSkillMinRank, sReqSkill2, sReqSkillMinRank2;
	string sReqSkillMaxRank, sReqSkillMaxRank2, sMinLevel, sMinLevelClass, sMaxLevel;
	string sMinFortSave, sEpic, sOrReq0, sAlignRestrict, sRemoved;

	int nRetrain1 = GetLocalInt(oToB, "FeatRetrain1");
	int nRetrain2 = GetLocalInt(oToB, "FeatRetrain2");
	int nDW = GetLocalInt(oToB, "DWTotal");
	int nDS = GetLocalInt(oToB, "DSTotal");
	int nDM = GetLocalInt(oToB, "DMTotal");
	int nIH = GetLocalInt(oToB, "IHTotal");
	int nSS = GetLocalInt(oToB, "SSTotal");
	int nSH = GetLocalInt(oToB, "SHTotal");
	int nSD = GetLocalInt(oToB, "SDTotal");
	int nTC = GetLocalInt(oToB, "TCTotal");
	int nWR = GetLocalInt(oToB, "WRTotal");
	int i, nClassLvl, nPrereq, nMyAB, nForbidden1, nPending1, nPending2;

	i = nStart;

	while (i < nFinish)
	{
		sFeatType = Get2DAString("feat", "FeatCategory", i);

		if (sFeatType == "GENERAL_FT_CAT" || sFeatType == "SKILLNSAVE_FT_CAT" || sFeatType == "DIVINE_FT_CAT")
		{
			if ((!GetHasFeat(i, oPC)) || (i == nRetrain1) || (i == nRetrain2))
			{
				int nOrReq0, nOrReq1, nOrReq2, nOrReq3, nOrReq4, nOrReq5;
				int nOrReq0State, nOrReq1State, nOrReq2State, nOrReq3State, nOrReq4State, nOrReq5State;

				sOrReq0 = Get2DAString("feat", "OrReqFeat0", i);
				sOrReq1 = Get2DAString("feat", "OrReqFeat1", i);
				sOrReq2 = Get2DAString("feat", "OrReqFeat2", i);
				sOrReq3 = Get2DAString("feat", "OrReqFeat3", i);
				sOrReq4 = Get2DAString("feat", "OrReqFeat4", i);
				sOrReq5 = Get2DAString("feat", "OrReqFeat5", i);

				nOrReq0 = StringToInt(sOrReq0);
				nOrReq1 = StringToInt(sOrReq1);
				nOrReq2 = StringToInt(sOrReq2);
				nOrReq3 = StringToInt(sOrReq3);
				nOrReq4 = StringToInt(sOrReq4);
				nOrReq5 = StringToInt(sOrReq5);

				nOrReq0State = 0;
				nOrReq1State = 0;
				nOrReq2State = 0;
				nOrReq3State = 0;
				nOrReq4State = 0;
				nOrReq5State = 0;

				if (sOrReq0 == "" || (GetHasFeat(nOrReq0, oPC)))
				{
					nOrReq0State = 1;
				}

				if (sOrReq1 == "" || (GetHasFeat(nOrReq0, oPC)))
				{
					nOrReq1State = 1;
				}

				if (sOrReq2 == "" || (GetHasFeat(nOrReq0, oPC)))
				{
					nOrReq2State = 1;
				}

				if (sOrReq3 == "" || (GetHasFeat(nOrReq0, oPC)))
				{
					nOrReq3State = 1;
				}

				if (sOrReq4 == "" || (GetHasFeat(nOrReq0, oPC)))
				{
					nOrReq4State = 1;
				}

				if (sOrReq5 == "" || (GetHasFeat(nOrReq0, oPC)))
				{
					nOrReq5State = 1;
				}

				if ((nOrReq0State == 1) && (nOrReq1State == 1) && (nOrReq2State == 1) && (nOrReq3State == 1) && (nOrReq4State == 1) && (nOrReq5State == 1))
				{
					nPrereq = 1; // When this changes to 0 the feat is not added to the list.
					sPrereq1 = Get2DAString("feat", "PREREQFEAT1", i);
					sPrereq2 = Get2DAString("feat", "PREREQFEAT2", i);
	
					if (sPrereq1 != "")
					{
						int nPrereq1 = StringToInt(sPrereq1);
	
						if (!GetHasFeat(nPrereq1, oPC))
						{
							nPrereq = 0;
						}
					}
	
					if (sPrereq2 != "")
					{
						int nPrereq2 = StringToInt(sPrereq2);
	
						if (!GetHasFeat(nPrereq2, oPC))
						{
							nPrereq = 0;
						}
					}
	
					sMinSTR = Get2DAString("feat", "MINSTR", i);
					sMinDEX = Get2DAString("feat", "MINDEX", i);
					sMinCON = Get2DAString("feat", "MINCON", i);
					sMinINT = Get2DAString("feat", "MININT", i);
					sMinWIS = Get2DAString("feat", "MINWIS", i);
					sMinCHA = Get2DAString("feat", "MINCHA", i);
	
					if (sMinSTR != "")
					{
						if (GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) < StringToInt(sMinSTR))
						{
							nPrereq = 0;
						}
					}
	
					if (sMinDEX != "")
					{
						if (GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) < StringToInt(sMinDEX))
						{
							nPrereq = 0;
						}
					}
	
					if (sMinCON != "")
					{
						if (GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) < StringToInt(sMinCON))
						{
							nPrereq = 0;
						}
					}
	
					if (sMinINT != "")
					{
						if (GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE) < StringToInt(sMinINT))
						{
							nPrereq = 0;
						}
					}
	
					if (sMinWIS != "")
					{
						if (GetAbilityScore(oPC, ABILITY_WISDOM, TRUE) < StringToInt(sMinWIS))
						{
							nPrereq = 0;
						}
					}
	
					if (sMinCHA != "")
					{
						if (GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE) < StringToInt(sMinCHA))
						{
							nPrereq = 0;
						}
					}
	
					sMaxSTR = Get2DAString("feat", "MAXSTR", i);
					sMaxDEX = Get2DAString("feat", "MAXDEX", i);
					sMaxCON = Get2DAString("feat", "MAXCON", i);
					sMaxINT = Get2DAString("feat", "MAXINT", i);
					sMaxWIS = Get2DAString("feat", "MAXWIS", i);
					sMaxCHA = Get2DAString("feat", "MAXCHA", i);
	
					if (sMaxSTR != "")
					{
						if (GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) > StringToInt(sMaxSTR))
						{
							nPrereq = 0;
						}
					}
	
					if (sMaxDEX != "")
					{
						if (GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) > StringToInt(sMaxDEX))
						{
							nPrereq = 0;
						}
					}
	
					if (sMaxCON != "")
					{
						if (GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) > StringToInt(sMaxCON))
						{
							nPrereq = 0;
						}
					}
	
					if (sMaxINT != "")
					{
						if (GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE) > StringToInt(sMaxINT))
						{
							nPrereq = 0;
						}
					}
	
					if (sMaxWIS != "")
					{
						if (GetAbilityScore(oPC, ABILITY_WISDOM, TRUE) > StringToInt(sMaxWIS))
						{
							nPrereq = 0;
						}
					}

					if (sMaxCHA != "")
					{
						if (GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE) > StringToInt(sMaxCHA))
						{
							nPrereq = 0;
						}
					}
	
					sReqSkill = Get2DAString("feat", "REQSKILL", i);
					sReqSkill2 = Get2DAString("feat", "REQSKILL2", i);
	
					if (sReqSkill != "")
					{
						int nMyRanks1 = GetSkillRank(StringToInt(sReqSkill), oPC, TRUE);
						sReqSkillMinRank = Get2DAString("feat", "ReqSkillMinRanks", i);
						sReqSkillMaxRank = Get2DAString("feat", "ReqSkillMaxRanks", i);

						if (sReqSkillMinRank != "")
						{
							if (nMyRanks1 < StringToInt(sReqSkillMinRank))
							{
								nPrereq = 0;
							}
						}
	
						if (sReqSkillMaxRank != "")
						{
							if (nMyRanks1 >= StringToInt(sReqSkillMaxRank))
							{
								nPrereq = 0;
							}
						}
					}
	
					if (sReqSkill2 != "")
					{
						int nMyRanks2 = GetSkillRank(StringToInt(sReqSkill2), oPC, TRUE);
						sReqSkillMinRank2 = Get2DAString("feat", "ReqSkillMinRanks2", i);
						sReqSkillMaxRank2 = Get2DAString("feat", "ReqSkillMaxRanks2", i);
	
						if (sReqSkillMinRank2 != "")
						{
							if (nMyRanks2 < StringToInt(sReqSkillMinRank2))
							{
								nPrereq = 0;
							}
						}
	
						if (sReqSkillMaxRank2 != "")
						{
							if (nMyRanks2 >= StringToInt(sReqSkillMaxRank2))
							{
								nPrereq = 0;
							}
						}
					}
	
					sMinFortSave = Get2DAString("feat", "MinFortSave", i);
	
					if (sMinFortSave != "")
					{
						if (GetFortitudeSavingThrow(oPC) < StringToInt(sMinFortSave))
						{
							nPrereq = 0;
						}
					}
	
					sMinLevelClass = Get2DAString("feat", "MinLevelClass", i);
					sMinLevel = Get2DAString("feat", "MinLevel", i);
					sMaxLevel = Get2DAString("feat", "MaxLevel", i);
	
					if ((sMinLevelClass == "") && (sMinLevel != ""))
					{
						int nHitDie = GetHitDice(oPC);
				
						if (nHitDie < StringToInt(sMinLevel))
						{
							nPrereq = 0;
						}
					}
					else if (sMinLevelClass != "")
					{
						nClassLvl = GetLevelByClass(StringToInt(sMinLevelClass), oPC);

						if (sMinLevel != "")
						{
							if (nClassLvl < StringToInt(sMinLevel))
							{
								nPrereq = 0;
							}
						}

						if (sMaxLevel != "")
						{
							if (nClassLvl > StringToInt(sMaxLevel))
							{
								nPrereq = 0;
							}
						}
					}
	
					sAlignRestrict = Get2DAString("feat", "AlignRestrict", i);

					if (sAlignRestrict != "")
					{
						int nAlignRestrict = StringToInt(sAlignRestrict);
	
						if (nAlignRestrict == 2)
						{
							int nLaw = GetAlignmentLawChaos(oPC);
	
							if (nLaw == ALIGNMENT_LAWFUL)
							{
								nPrereq = 0;
							}
						}
						else if (nAlignRestrict == 3)
						{
							int nChaos = GetAlignmentLawChaos(oPC);
	
							if (nChaos == ALIGNMENT_CHAOTIC)
							{
								nPrereq = 0;
							}
						}
						else if (nAlignRestrict == 4)
						{
							int nGood = GetAlignmentGoodEvil(oPC);
	
							if (nGood == ALIGNMENT_GOOD)
							{
								nPrereq = 0;
							}
						}
						else if (nAlignRestrict == 5)
						{
							int nEvil = GetAlignmentGoodEvil(oPC);
	
							if (nEvil == ALIGNMENT_EVIL)
							{
								nPrereq = 0;
							}
						}
					}

					nPending1 = GetLocalInt(oToB, "PendingFeat1");
					nPending2 = GetLocalInt(oToB, "PendingFeat2");

					if (i == nPending1)
					{
						if (i == nPending1)
						{
							nPrereq = 0;
						}
						else if (i == nPending2)
						{
							nPrereq = 0;
						}
					}

					/* Drammel's Notes on sMinSpellLvl, sMinCasterLvl:
					These checks are currently not supported due to the inability to reliably
					determine either via scripting.  Most of the feats that require these
					also check for other variables and as such are reliable for an accurate
					listing of available feats to retrain.  Hence, I will wait until Obsidian
					implements these checks, if ever.  The only feats that I am aware of that
					allow a 'cheat' on retraining are a handful of skill focus feats.  Considering
					the nature of the feats and the level 1 requirement on caster level, I'm not
					too concerned.*/

					sMinAB = Get2DAString("feat", "MINATTACKBONUS", i);

					if (sMinAB != "")
					{
						// There is no pure way to determine the BAB at previous levels, but the level cap does help moderate a bit.
						if (GetBaseAttackBonus(oPC) > GetLocalInt(oToB, "LevelupCap"))
						{
							nMyAB = GetLocalInt(oToB, "LevelupCap");
						}
						else nMyAB = GetBaseAttackBonus(oPC);
	
						if (nMyAB < StringToInt(sMinAB))
						{
							nPrereq = 0;
						}
					}

					// Special cases, like Use Poison.
					if (i == 0 || i == 1799 || i == 1800 || i == 2129 || i == 2130 || i == 2131 || i == 2132 || i == 2133
					|| i == 1912 || i == 1913 || i == 1914 || i == 1915 || i == 1916 || i == 960
					|| i == 1113 || i == 1116 || i == 1917 || i == 6945)
					{
						nPrereq = 0;
					}

					string sScent = GetName(oPC) + "sa_huntersns";
					object oScent = GetObjectByTag(sScent);

					if (GetIsObjectValid(oScent))
					{
						if (i == FEAT_SCENT) //Hunter's Sense actually grants the feat.  This prevents 'gaining a spare to trade'.
						{
							nPrereq = 0;
						}
					}

					nForbidden1 = GetLocalInt(oToB, "ForbiddenRetrain1");

					if (nForbidden1 > 0) // For the Swordsage's Insightful Strike: Weapon Focus, mostly.
					{
						int nForbidden2 = GetLocalInt(oToB, "ForbiddenRetrain2");
						int nForbidden3 = GetLocalInt(oToB, "ForbiddenRetrain3");
						int nForbidden4 = GetLocalInt(oToB, "ForbiddenRetrain4");
						int nForbidden5 = GetLocalInt(oToB, "ForbiddenRetrain5");
						int nForbidden6 = GetLocalInt(oToB, "ForbiddenRetrain6");

						if (i == nForbidden1)
						{
							nPrereq = 0;
						}

						if ((i == nForbidden2) && (nForbidden2 > 0)) // Because Alertness is something we'd never think of retraining! ;)
						{
							nPrereq = 0;
						}

						if ((i == nForbidden3) && (nForbidden3 > 0))
						{
							nPrereq = 0;
						}

						if ((i == nForbidden4) && (nForbidden4 > 0))
						{
							nPrereq = 0;
						}

						if ((i == nForbidden5) && (nForbidden5 > 0))
						{
							nPrereq = 0;
						}

						if ((i == nForbidden6) && (nForbidden6 > 0))
						{
							nPrereq = 0;
						}
					}

					// Special cases to enable, such as maneuver requirements.
					if (i == 6832 || i == 6833)
					{
						if (nDW >= 1)
						{
							nPrereq = 1;
						}
					}
					else if (i == 6834)
					{
						if (nDS >= 1)
						{
							nPrereq = 1;
						}
					}
					else if (i == 6835)
					{
						if ((nDS >= 1) && (GetHasFeat(FEAT_TURN_UNDEAD, oPC, TRUE)))
						{
							nPrereq = 1;
						}
					}
					else if (i == 6838)
					{
						if ((nSS >= 1) && (GetHasFeat(FEAT_STUNNING_FIST, oPC, TRUE)))
						{
							nPrereq = 1;
						}
					}
					else if (i == 6839)
					{
						if (nIH >= 1)
						{
							nPrereq = 1;
						}
					}
					else if (i == 6840)
					{
						if ((nDW >= 1) || (nDS >= 1) || (nDM >= 1) || (nIH >= 1) || (nSS >= 1) || (nSH >= 1) || (nSD >= 1) || (nTC >= 1) || (nWR >= 1))
						{
							nPrereq = 1;
						}
					}
					else if (i == 6843 || i == 6844)
					{
						if (nSH >= 1)
						{
							nPrereq = 1;
						}
					}
					else if (i == 6845)
					{
						if ((nWR >= 1) && (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPC)))
						{
							nPrereq = 1;
						}
					}
					else if (i == 6847)
					{
						int nMySTR = GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE);

						// There is no pure way to determine the BAB at previous levels, but the level cap does help moderate a bit.
						if (GetBaseAttackBonus(oPC) > GetLocalInt(oToB, "LevelupCap"))
						{
							nMyAB = GetLocalInt(oToB, "LevelupCap");
						}
						else nMyAB = GetBaseAttackBonus(oPC);

						if ((nSD >= 1) && (nMySTR >= 13) && (nMyAB >= 5))
						{
							nPrereq = 1;
						}
					}
					else if (i == 6848) //Not identical to what the actual checks are in the 2da, but equal.
					{
						if ((nDW >= 1) || (nDS >= 1) || (nDM >= 1) || (nIH >= 1) || (nSS >= 1) || (nSH >= 1) || (nSD >= 1) || (nTC >= 1) || (nWR >= 1))
						{
							nPrereq = 1;
						}
					}
					else if (i == 6850)
					{
						if (nTC >= 1)
						{
							if ((GetHasFeat(FEAT_BARBARIAN_RAGE, oPC, TRUE)) || (GetHasFeat(FEAT_WILD_SHAPE, oPC, TRUE)))
							{
								nPrereq = 1;
							}
						}
					}
					else if (i == 6851)
					{
						if (GetHasFeat(FEAT_MARTIAL_STANCE, oPC) || GetHasFeat(FEAT_MARTIAL_STUDY_2, oPC) || GetHasFeat(FEAT_SWORDSAGE, oPC) || GetHasFeat(FEAT_SAINT, oPC) || GetHasFeat(FEAT_WARBLADE, oPC) || GetHasFeat(FEAT_CRUSADER, oPC))
						{
							nPrereq = 1;
						}
					}
					else if (i == 6852)
					{
						if (nWR >= 1)
						{
							nPrereq = 1;
						}
					}
					else if ((i == 6836) && (GetLevelByClass(CLASS_TYPE_CRUSADER, oPC) > 0))
					{
						nPrereq = 1;
					}
					else if ((i == 6837) && (GetLevelByClass(CLASS_TYPE_SWORDSAGE, oPC) > 0))
					{
						nPrereq = 1;
					}

					if (i == nRetrain1)
					{
						nPrereq = 1;
					}

					if (i == nRetrain2)
					{
						nPrereq = 1;
					}

					sRemoved = Get2DAString("feat", "REMOVED", i);
	
					if (StringToInt(sRemoved) == 1)
					{
						nPrereq = 0;
					}

					if (nPrereq == 1)
					{
						sIcon = "RETRAIN_IMAGE=" + Get2DAString("feat", "ICON", i) + ".tga";
						sName = "RETRAIN_TEXT=" + GetStringByStrRef(StringToInt(Get2DAString("feat", "FEAT", i)));
						sVari = "7=" + IntToString(i);

						AddListBoxRow(oPC, "SCREEN_LEVELUP_RETRAIN_FEATS", "AVAILABLE_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(i), sName, sIcon, sVari, "");
					}
				}
			}
		}
		i++;
	}
}

// Runs the above function in segments to avoid TMI errors.
void GetAllAvailableFeats(object oPC = OBJECT_SELF)
{
	int nLimit = GetNum2DARows("feat");

	DelayCommand(0.01f, GetAvailableFeats(1, 250, oPC)); // Alertness causes all sorts of problems and needs to be excluded.
	DelayCommand(0.02f, GetAvailableFeats(250, 500, oPC));
	DelayCommand(0.03f, GetAvailableFeats(500, 750, oPC));
	DelayCommand(0.04f, GetAvailableFeats(750, 1000, oPC));
	DelayCommand(0.05f, GetAvailableFeats(1000, 1250, oPC));
	DelayCommand(0.06f, GetAvailableFeats(1250, 1500, oPC));
	DelayCommand(0.07f, GetAvailableFeats(1500, 1750, oPC));
	DelayCommand(0.08f, GetAvailableFeats(1750, 2000, oPC));
	DelayCommand(0.09f, GetAvailableFeats(2000, 2250, oPC));
	DelayCommand(0.10f, GetAvailableFeats(2250, 2500, oPC));
	DelayCommand(0.11f, GetAvailableFeats(2500, 2750, oPC));
	DelayCommand(0.12f, GetAvailableFeats(2750, 3000, oPC));
	DelayCommand(0.13f, GetAvailableFeats(3000, 3250, oPC));
	DelayCommand(0.14f, GetAvailableFeats(3250, 3500, oPC));
	DelayCommand(0.15f, GetAvailableFeats(3500, 3750, oPC));
	DelayCommand(0.16f, GetAvailableFeats(3750, 4000, oPC));
	DelayCommand(0.17f, GetAvailableFeats(4000, 4250, oPC));
	DelayCommand(0.18f, GetAvailableFeats(4250, 4500, oPC));
	DelayCommand(0.19f, GetAvailableFeats(4500, 4750, oPC));
	DelayCommand(0.20f, GetAvailableFeats(4750, 5000, oPC));
	DelayCommand(0.21f, GetAvailableFeats(5000, 5250, oPC));
	DelayCommand(0.22f, GetAvailableFeats(5250, 5500, oPC));
	DelayCommand(0.23f, GetAvailableFeats(5500, 5750, oPC));
	DelayCommand(0.24f, GetAvailableFeats(5750, 6000, oPC));
	DelayCommand(0.20f, GetAvailableFeats(4750, 5000, oPC));
	DelayCommand(0.21f, GetAvailableFeats(6000, 6250, oPC));
	DelayCommand(0.22f, GetAvailableFeats(6250, 6500, oPC));
	DelayCommand(0.23f, GetAvailableFeats(6500, 6750, oPC));
	DelayCommand(0.24f, GetAvailableFeats(6750, 7000, oPC));

	if (nLimit > 7000)
	{
		DelayCommand(0.25f, GetAvailableFeats(7000, 7250, oPC));
	}

	if (nLimit > 7250)
	{
		DelayCommand(0.26f, GetAvailableFeats(7250, 7500, oPC));
	}

	if (nLimit > 7500)
	{
		DelayCommand(0.27f, GetAvailableFeats(7500, 7750, oPC));
	}

	if (nLimit > 7750)
	{
		DelayCommand(0.28f, GetAvailableFeats(7750, 8000, oPC));
	}

	if (nLimit > 8000)
	{
		DelayCommand(0.29f, GetAvailableFeats(8000, nLimit, oPC));
	}
}

// Displays discplines for the Insightful Strike: Weapon Focus menu.
void DisplaySSInsightfulStrike(object oPC = OBJECT_SELF)
{
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	string sScreen = "SCREEN_LEVELUP_RETRAIN_FEATS";

	ClearListBox(oPC, "SCREEN_LEVELUP_RETRAIN_FEATS", "AVAILABLE_RETRAIN_LIST");

	if (GetLocalInt(oToB, "SSWeaponFocus") != 1)
	{
		string sDWIcon = "RETRAIN_IMAGE=desertwind.tga";
		string sDWName = "RETRAIN_TEXT=Desert Wind";
		string sDWVari = "7=" + IntToString(1);

		AddListBoxRow(oPC, sScreen, "AVAILABLE_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(1), sDWName, sDWIcon, sDWVari, "");
	}

	if (GetLocalInt(oToB, "SSWeaponFocus") != 3)
	{
		string sDMIcon = "RETRAIN_IMAGE=diamondmind.tga";
		string sDMName = "RETRAIN_TEXT=Diamond Mind";
		string sDMVari = "7=" + IntToString(3);

		AddListBoxRow(oPC, sScreen, "AVAILABLE_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(3), sDMName, sDMIcon, sDMVari, "");
	}

	if (GetLocalInt(oToB, "SSWeaponFocus") != 5)
	{
		string sSSIcon = "RETRAIN_IMAGE=settingsun.tga";
		string sSSName = "RETRAIN_TEXT=Setting Sun";
		string sSSVari = "7=" + IntToString(5);
	
		AddListBoxRow(oPC, sScreen, "AVAILABLE_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(5), sSSName, sSSIcon, sSSVari, "");
	}

	if (GetLocalInt(oToB, "SSWeaponFocus") != 6)
	{
		string sSHIcon = "RETRAIN_IMAGE=greenhand.tga";
		string sSHName = "RETRAIN_TEXT=Shadow Hand";
		string sSHVari = "7=" + IntToString(6);

		AddListBoxRow(oPC, sScreen, "AVAILABLE_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(6), sSHName, sSHIcon, sSHVari, "");
	}

	if (GetLocalInt(oToB, "SSWeaponFocus") != 7)
	{
		string sSDIcon = "RETRAIN_IMAGE=stonedragon.tga";
		string sSDName = "RETRAIN_TEXT=Stone Dragon";
		string sSDVari = "7=" + IntToString(7);

		AddListBoxRow(oPC, sScreen, "AVAILABLE_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(7), sSDName, sSDIcon, sSDVari, "");
	}

	if (GetLocalInt(oToB, "SSWeaponFocus") != 8)
	{
		string sTCIcon = "RETRAIN_IMAGE=tigerclaw.tga";
		string sTCName = "RETRAIN_TEXT=Tiger Claw";
		string sTCVari = "7=" + IntToString(8);

		AddListBoxRow(oPC, sScreen, "AVAILABLE_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(8), sTCName, sTCIcon, sTCVari, "");
	}
}

// Adds Feats pending to be switched for the feats the PC is retraining to the 
// Added Feats window.
void DiplayAddedFeats(object oPC = OBJECT_SELF)
{
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	int nPending1 = GetLocalInt(oToB, "PendingFeat1");
	int nPending2 = GetLocalInt(oToB, "PendingFeat2");

	ClearListBox(oPC, "SCREEN_LEVELUP_RETRAIN_FEATS", "ADDED_RETRAIN_LIST");

	if (nPending1 > 0)
	{
		string sIcon = "RETRAIN_IMAGE=" + Get2DAString("feat", "ICON", nPending1) + ".tga";
		string sName = "RETRAIN_TEXT=" + GetStringByStrRef(StringToInt(Get2DAString("feat", "FEAT", nPending1)));
		string sVari = "7=" + IntToString(nPending1);

		AddListBoxRow(oPC, "SCREEN_LEVELUP_RETRAIN_FEATS", "ADDED_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(nPending1), sName, sIcon, sVari, "");
	}

	if (nPending2 > 0)
	{
		string sIcon = "RETRAIN_IMAGE=" + Get2DAString("feat", "ICON", nPending2) + ".tga";
		string sName = "RETRAIN_TEXT=" + GetStringByStrRef(StringToInt(Get2DAString("feat", "FEAT", nPending2)));
		string sVari = "7=" + IntToString(nPending1);

		AddListBoxRow(oPC, "SCREEN_LEVELUP_RETRAIN_FEATS", "ADDED_RETRAIN_LIST", "RETRAINPANE_PROTO" + IntToString(nPending2), sName, sIcon, sVari, "");
	}
}