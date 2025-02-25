// kinc_cohort
/*
	Helper functions for cohorts.
*/
// TDE 6/20/08

#include "ginc_henchman"
#include "ginc_companion"
#include "ginc_object"
#include "ginc_ipspeaker"

//-------------------------------------------------
// Constants
//-------------------------------------------------

// Cohort ResRefs
const string RR_BELUETH 	= "co_belueth";
const string RR_CHIR		= "co_chir";
const string RR_FINCH		= "co_finch";
const string RR_GRYKK		= "co_grykk";
const string RR_INSHULA 	= "co_inshula";
const string RR_LASTRI		= "co_lastri";
const string RR_QUARREL		= "co_quarrel";
const string RR_RIBSMASHER	= "co_ribsmasher";
const string RR_SEPTIMUND	= "co_septimund";
const string RR_SORAEVORA	= "co_soraevora";
const string RR_UMOJA		= "co_umoja";
const string RR_ZARL		= "co_zarl";

// Cohort String Refs
// SCRIPTER: Need to fill in the correct string ref values after a string rip has been done.
const int STR_REF_BELUETH 	= 0;
const int STR_REF_CHIR		= 0;
const int STR_REF_GRYKK		= 0;
const int STR_REF_INSHULA	= 0;
const int STR_REF_LASTRI 	= 0;
const int STR_REF_QUARREL 	= 0;
const int STR_REF_RIBSMASHER= 0;
const int STR_REF_SEPTIMUND	= 0;
const int STR_REF_SORAEVORA	= 0;
const int STR_REF_UMOJA 	= 0;
const int STR_REF_ZARL	 	= 0;

// we'll always use tag as the roster name
const string TAG_BELUETH 	= "co_belueth";
const string TAG_CHIR		= "co_chir";
const string TAG_FINCH		= "co_finch";
const string TAG_GRYKK		= "co_grykk";
const string TAG_INSHULA 	= "co_inshula";
const string TAG_LASTRI		= "co_lastri";
const string TAG_QUARREL	= "co_quarrel";
const string TAG_RIBSMASHER	= "co_ribsmasher";
const string TAG_SEPTIMUND	= "co_septimund";
const string TAG_SORAEVORA	= "co_soraevora";
const string TAG_UMOJA		= "co_umoja";
const string TAG_ZARL		= "co_zarl";

// Joined variables
const string BELUETH_JOINED 	= "00_cBeluethJoin";
const string CHIR_JOINED	 	= "00_cChirJoin";
const string FINCH_JOINED	 	= "00_cFinchJoin";
const string GRYKK_JOINED	 	= "00_cGrykkJoin";
const string INSHULA_JOINED	 	= "00_cInshulaJoin";
const string LASTRI_JOINED	 	= "00_cLastriJoin";
const string QUARREL_JOINED	 	= "00_cQuarrelJoin";
const string RIBSMASHER_JOINED	= "00_cRibsmasherJoin";
const string SEPTIMUND_JOINED	= "00_cSeptimundJoin";
const string SORAEVORA_JOINED	= "00_cSoraevoraJoin";
const string UMOJA_JOINED	 	= "00_cUmojaJoin";
const string ZARL_JOINED	 	= "00_cZarlJoin";

// set up a companion.
void InitializeCohort(string sRosterName, string sTag, string sResRef)
{
	AddCompanionToRoster(sRosterName, sTag, sResRef);
	SetHangOutSpot(sTag, COMPANION_SPAWN_WP_PREFIX + sTag);
	SetIsRosterMemberSelectable(sRosterName, 0);
}

// adds all companions to the roster
// members in roster must still be added to party	
void InitializeNX2Cohorts()
{
	InitializeCohort(TAG_BELUETH,	TAG_BELUETH, 	RR_BELUETH);
	InitializeCohort(TAG_CHIR, 		TAG_CHIR, 		RR_CHIR);
	InitializeCohort(TAG_FINCH, 	TAG_FINCH, 		RR_FINCH);
	InitializeCohort(TAG_GRYKK, 	TAG_GRYKK, 		RR_GRYKK);
	InitializeCohort(TAG_INSHULA,	TAG_INSHULA, 	RR_INSHULA);
	InitializeCohort(TAG_LASTRI, 	TAG_LASTRI, 	RR_LASTRI);
	InitializeCohort(TAG_QUARREL,	TAG_QUARREL, 	RR_QUARREL);
	InitializeCohort(TAG_RIBSMASHER,TAG_RIBSMASHER,	RR_RIBSMASHER);
	InitializeCohort(TAG_SEPTIMUND, TAG_SEPTIMUND,	RR_SEPTIMUND);
	InitializeCohort(TAG_SORAEVORA, TAG_SORAEVORA, 	RR_SORAEVORA);
	InitializeCohort(TAG_UMOJA, 	TAG_UMOJA, 		RR_UMOJA);
	InitializeCohort(TAG_ZARL, 		TAG_ZARL, 		RR_ZARL);
}

// spawn all NX2 cohorts at their hangout
void SpawnNX2CohortRosterMembersAtHangout()
{
	// tags also serve as the roster name.
	SpawnNonPartyRosterMemberAtHangout(TAG_BELUETH);
	SpawnNonPartyRosterMemberAtHangout(TAG_CHIR);
	SpawnNonPartyRosterMemberAtHangout(TAG_FINCH);
	SpawnNonPartyRosterMemberAtHangout(TAG_GRYKK);
	SpawnNonPartyRosterMemberAtHangout(TAG_INSHULA);
	SpawnNonPartyRosterMemberAtHangout(TAG_LASTRI);
	SpawnNonPartyRosterMemberAtHangout(TAG_QUARREL);
	SpawnNonPartyRosterMemberAtHangout(TAG_RIBSMASHER);
	SpawnNonPartyRosterMemberAtHangout(TAG_SEPTIMUND);
	SpawnNonPartyRosterMemberAtHangout(TAG_SORAEVORA);
	SpawnNonPartyRosterMemberAtHangout(TAG_UMOJA);
	SpawnNonPartyRosterMemberAtHangout(TAG_ZARL);
}

// Success should return 0, or remaining number of companions on failure
int RemoveAllCohorts( object oPC , int bDespawn = TRUE)
{
	RemoveRosterMemberFromParty( TAG_BELUETH, 	oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_CHIR, 		oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_FINCH, 	oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_GRYKK, 	oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_INSHULA, 	oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_LASTRI, 	oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_QUARREL, 	oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_RIBSMASHER,oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_SEPTIMUND, oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_SORAEVORA, oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_UMOJA, 	oPC, bDespawn );
	RemoveRosterMemberFromParty( TAG_ZARL, 		oPC, bDespawn );
	
	return (0);
}

void InitiateLeaveParty(object oTarget)
{
	//SCRIPTER: TEMP
	AssignCommand (oTarget, SpeakString ("That's the last straw!  I am so out of here!!!!"));
	
	string sTargetTag 	= GetTag(oTarget);
	string sLeavePartyDialogName = "gl_" + sTargetTag + "_leave";
	PrettyDebug("sLeavePartyDialogName = " + sLeavePartyDialogName);
	CreateIPSpeaker( sTargetTag, sLeavePartyDialogName, GetLocation( OBJECT_SELF ), 1.75f );
}

void SetPlayerInventoryAccess(object oTarget, int bCanAccessInventory)
{
	int bDisableEquip = !bCanAccessInventory;
	// TRUE = equipment disabled
	SetLocalInt(oTarget, "X2_JUST_A_DISABLEEQUIP", bDisableEquip);
}

void SetIsPossessable(object oTarget, int bPossessable)
{
	int bBlocked = !bPossessable;
	SetIsCompanionPossessionBlocked(oTarget, bBlocked);
}

void SetHangoutIfSelectable(string sRosterName, string sHangOutWPTag)
{
	if ( GetIsRosterMemberSelectable(sRosterName) )
	{
		SetHangOutSpot(sRosterName, sHangOutWPTag);	
	}
}

// Set a cohort's joined variable and make them selectable.  If sCohort is "" then set all cohorts.
void CohortJoin(string sCohort, int bJoined = 1)
{
	sCohort = GetStringLowerCase(sCohort);

	if ( sCohort == "all" || sCohort == "co_belueth" || sCohort == "belueth")
	{
		SetGlobalInt("00_cBeluethJoin", bJoined);
		SetIsRosterMemberSelectable("co_belueth", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_chir" || sCohort == "chir")
	{
		SetGlobalInt("00_cChirJoin", bJoined);
		SetIsRosterMemberSelectable("co_chir", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_finch" || sCohort == "finch")
	{
		SetGlobalInt("00_cFinchJoin", bJoined);
		SetIsRosterMemberSelectable("co_finch", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_grykk" || sCohort == "grykk")
	{
		SetGlobalInt("00_cGrykkJoin", bJoined);
		SetIsRosterMemberSelectable("co_grykk", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_inshula" || sCohort == "inshula")
	{
		SetGlobalInt("00_cInshulaJoin", bJoined);
		SetIsRosterMemberSelectable("co_inshula", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_lastri" || sCohort == "lastri")
	{
		SetGlobalInt("00_cLastriJoin", bJoined);
		SetIsRosterMemberSelectable("co_lastri", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_quarrel" || sCohort == "quarrel")
	{
		SetGlobalInt("00_cQuarrelJoin", bJoined);
		SetIsRosterMemberSelectable("co_quarrel", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_ribsmasher" || sCohort == "ribsmasher")
	{
		SetGlobalInt("00_cRibsmasherJoin", bJoined);
		SetIsRosterMemberSelectable("co_ribsmasher", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_septimund" || sCohort == "septimund")
	{
		SetGlobalInt("00_cSeptimundJoin", bJoined);
		SetIsRosterMemberSelectable("co_septimund", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_soraevora" || sCohort == "soraevora")
	{
		SetGlobalInt("00_cSoraevoraJoin", bJoined);
		SetIsRosterMemberSelectable("co_soraevora", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_umoja" || sCohort == "umoja")
	{
		SetGlobalInt("00_cUmojaJoin", bJoined);
		SetIsRosterMemberSelectable("co_umoja", bJoined);
	}
	if ( sCohort == "all" || sCohort == "co_zarl" || sCohort == "zarl")
	{
		SetGlobalInt("00_cZarlJoin", bJoined);
		SetIsRosterMemberSelectable("co_zarl", bJoined);
	}
}

int CohortsInParty()
{
	int nCohortsInParty = 0;
	
	if ( IsInParty("co_belueth") )
		nCohortsInParty++;
	if ( IsInParty("co_chir") )
		nCohortsInParty++;
	if ( IsInParty("co_finch") )
		nCohortsInParty++;
	if ( IsInParty("co_grykk") )
		nCohortsInParty++;
	if ( IsInParty("co_inshula") )
		nCohortsInParty++;
	if ( IsInParty("co_lastri") )
		nCohortsInParty++;
	if ( IsInParty("co_quarrel") )
		nCohortsInParty++;
	if ( IsInParty("co_ribsmasher") )
		nCohortsInParty++;
	if ( IsInParty("co_septimund") )
		nCohortsInParty++;
	if ( IsInParty("co_soraevora") )
		nCohortsInParty++;
	if ( IsInParty("co_umoja") )
		nCohortsInParty++;
	if ( IsInParty("co_zarl") )
		nCohortsInParty++;

	PrettyDebug("kinc_cohort: " + IntToString(nCohortsInParty) + " cohorts in the party.");

	return nCohortsInParty;
}