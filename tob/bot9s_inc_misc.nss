//////////////////////////////////
//	Author: Drammel				//
//	Date: 3/29/2009				//
//	Title: bot9s_inc_misc		//
//	Description: Misc functions.//
//////////////////////////////////

#include "bot9s_inc_constants"
#include "bot9s_inc_maneuvers"

//Prototype

// Targeting function for strike maneuvers.  This function takes the value of
// int nTarget from gui_execute_strike# and uses the value of "Strike" to
// assign the correct target variable of the strike listed in oToB.
// -nStrike: The current value of "Strike" in oToB, as set by the
// gui_execute_strike function.
// -nTarget: Data of the object targeted GUI-side by UIObject_Input_ActionTargetScript.
void IndexStrikeTarget(int nStrike, int nTarget);

// Placing a location value on an item tends to crash NWN2 so the location
// information here is stored in its raw state as three floats.
// -nManeuver: A maneuver of any type.
// -fx: The location's x position.
// -fy: The location's y position.
// -fz: The location's z position.
void IndexManeuverPosition(int nManeuver, float fx, float fy, float fz);

//  Marks nRow as the next strike to be activated by the script activate_strike.
//  This is similar to the action queue, but works outside of it.  Strikes are
//  only removed from the action queue after they've been passed through the
//  script activate_strike.
void SetStrike(int nRow);

// Switches the mask buttons for the Swordsage maneuver recovery method on and off.
void ToggleMasks(int bToggle, string sScreen);

// Recovers all maneuvers.  Intended use is for out of combat, the feat Adaptive
// Style and for use in the Warblade's recovery method.
// -sScreen: Xml screen for which we are recovering maneuvers.
void RecoverAllManeuvers(string sScreen);

// Checks for stances that bypass the uneven terrain rule for charging.
int CheckStanceChargeRules();

// Returns an itemproperty from an item based on a desired itemproperty constant.
// nSubType by default ignores subtypes until a constant is entered as its value.
itemproperty GetItemPropertyByConst(int nItemProp, object oItem, int nSubType = 0);

//Returns the integer value of nSubType if it matches the subtype of the test item.
int GetItemPropertySubTypeByConst(int nItemProp, object oItem, int nSubType = -1);

// Returns a constant from an item based on a desired itemproperty constant.
// nSubType by default ignores subtypes until a constant is entered as its value.
int GetItemPropertyConst(itemproperty ip, int nItemProp, object oItem, int nSubType = -1);

// Tracks movement for the Strike Desert Tempest.  If the player has stopped
// moving, this function sets the strike to an inactive status.
void DoDesertTempestLoc();

// Runs the attack rolls and damage for the maneuver Desert Tempest while the 
// PC is moving by his opponents.  This maneuver has a cap of ten opponents.
void DoDesertTempest(float fRange);

// Determines if a Crusader has readied all aviablable maneuvers.
// Returns TRUE if the crusader has.
int CheckRedCrusader(object oOrigin = OBJECT_SELF);

//Functions

// Targeting function for strike maneuvers.  This function takes the value of
// int nTarget from gui_execute_strike# and uses the value of "Strike" to
// assign the correct target variable of the strike listed in oToB.
// -nStrike: The current value of "Strike" in oToB, as set by the
// gui_execute_strike function.
// -nTarget: Data of the object targeted GUI-side by UIObject_Input_ActionTargetScript.
void IndexStrikeTarget(int nStrike, int nTarget)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	switch (nStrike)
	{
		case STRIKE_ADAMANTINE_BONES:				SetLocalInt(oToB, "AdamantineBones", nTarget);				break;
		case STRIKE_ADAMANTINE_HURRICANE:			SetLocalInt(oToB, "AdamantineHurricane", nTarget);			break;
		case STRIKE_ANCIENT_MOUNTAIN_HAMMER:		SetLocalInt(oToB, "AncientMountainHammer", nTarget);		break;
		case STRIKE_AVALANCHE_OF_BLADES:			SetLocalInt(oToB, "AvalancheofBlades", nTarget);			break;
		case STRIKE_BALLISTA_THROW:					SetLocalInt(oToB, "BallistaThrow", nTarget);				break;
		case STRIKE_BATTLE_LEADERS_CHARGE:			SetLocalInt(oToB, "BattleLeadersCharge", nTarget);			break;
		case STRIKE_BLFLOURISH:						SetLocalInt(oToB, "BlisteringFlourish", nTarget);			break;
		case STRIKE_BLOODLETTING_STRIKE:			SetLocalInt(oToB, "BloodlettingStrike", nTarget);			break;
		case STRIKE_BONECRUSHER:					SetLocalInt(oToB, "Bonecrusher", nTarget);					break;
		case STRIKE_BONESPLITTING_STRIKE:			SetLocalInt(oToB, "BonesplittingStrike", nTarget);			break;
		case STRIKE_BOUNDING_ASSAULT:				SetLocalInt(oToB, "BoundingAssault", nTarget);				break;
		case STRIKE_CASTIGATING_STRIKE:				SetLocalInt(oToB, "CastigatingStrike", nTarget);			break;
		case STRIKE_CHARGING_MINOTAUR:				SetLocalInt(oToB, "ChargingMinotaur", nTarget);				break;
		case STRIKE_CLAW_AT_THE_MOON:				SetLocalInt(oToB, "ClawattheMoon", nTarget);				break;
		case STRIKE_CLEVER_POSITIONING:				SetLocalInt(oToB, "CleverPositioning", nTarget);			break;
		case STRIKE_CLINGING_SHADOW_STRIKE:			SetLocalInt(oToB, "CSStrike", nTarget);						break;
		case STRIKE_COLOSSUS_STRIKE:				SetLocalInt(oToB, "ColossusStrike", nTarget);				break;
		case STRIKE_COMET_THROW:					SetLocalInt(oToB, "CometThrow", nTarget);					break;
		case STRIKE_CRUSADERS_STRIKE:				SetLocalInt(oToB, "CrusadersStrike", nTarget);				break;
		case STRIKE_CRUSHING_VISE:					SetLocalInt(oToB, "CrushingVise", nTarget);					break;
		case STRIKE_DAUNTING_STRIKE:				SetLocalInt(oToB, "DauntingStrike", nTarget);				break;
		case STRIKE_DAZING_STRIKE:					SetLocalInt(oToB, "DazingStrike", nTarget);					break;
		case STRIKE_DEATH_FROM_ABOVE:				SetLocalInt(oToB, "DeathFromAbove", nTarget);				break;
		case STRIKE_DEATH_IN_THE_DARK:				SetLocalInt(oToB, "DeathintheDark", nTarget);				break;
		case STRIKE_DEVASTATING_THROW:				SetLocalInt(oToB, "DevastatingThrow", nTarget);				break;
		case STRIKE_DISARMING_STRIKE:				SetLocalInt(oToB, "DisarmingStrike", nTarget);				break;
		case STRIKE_DISRUPTING_BLOW:				SetLocalInt(oToB, "DisruptingBlow", nTarget);				break;
		case STRIKE_DIVINE_SURGE:					SetLocalInt(oToB, "DivineSurge", nTarget);					break;
		case STRIKE_DIVINE_SURGE_GREATER:			SetLocalInt(oToB, "DivineSurgeGreater", nTarget);			break;
		case STRIKE_DNBLADE:						SetLocalInt(oToB, "DNBlade", nTarget);						break;
		case STRIKE_DOOM_CHARGE:					SetLocalInt(oToB, "DoomCharge", nTarget);					break;
		case STRIKE_DOUSE_THE_FLAMES:				SetLocalInt(oToB, "DousetheFlames", nTarget);				break;
		case STRIKE_DRAIN_VITALITY:					SetLocalInt(oToB, "DrainVitality", nTarget);				break;
		case STRIKE_DRGFLAME:						SetLocalInt(oToB, "DragonsFlame", nTarget);					break;
		case STRIKE_DSRTTEMP:						SetLocalInt(oToB, "DesertTempest", nTarget);				break;
		case STRIKE_DTHMARK:						SetLocalInt(oToB, "DeathMark", nTarget);					break;
		case STRIKE_EARTHSTRIKE_QUAKE:				SetLocalInt(oToB, "EarthstrikeQuake", nTarget);				break;
		case STRIKE_ELDER_MOUNTAIN_HAMMER:			SetLocalInt(oToB, "ElderMountainHammer", nTarget);			break;
		case STRIKE_EMERALD_RAZOR:					SetLocalInt(oToB, "EmeraldRazor", nTarget);					break;
		case STRIKE_ENERVATING_SHADOW_STRIKE:		SetLocalInt(oToB, "EnervatingShadowStrike", nTarget);		break;
		case STRIKE_ENTANGLING_BLADE:				SetLocalInt(oToB, "EntanglingBlade", nTarget);				break;
		case STRIKE_EXORCISM_OF_STEEL:				SetLocalInt(oToB, "ExorcismofSteel", nTarget);				break;
		case STRIKE_FANTHEFLM:						SetLocalInt(oToB, "FantheFlames", nTarget);					break;
		case STRIKE_FERAL_DEATH_BLOW:				SetLocalInt(oToB, "FeralDeathBlow", nTarget);				break;
		case STRIKE_FINISHING_MOVE:					SetLocalInt(oToB, "FinishingMove", nTarget);				break;
		case STRIKE_FIRESNAKE:						SetLocalInt(oToB, "Firesnake", nTarget);					break;
		case STRIKE_FLANKING_MANEUVER:				SetLocalInt(oToB, "FlankingManeuver", nTarget);				break;
		case STRIKE_FLESH_RIPPER:					SetLocalInt(oToB, "FleshRipper", nTarget);					break;
		case STRIKE_FLSHSUN:						SetLocalInt(oToB, "FlashingSun", nTarget);					break;
		case STRIKE_FOEHAMMER:						SetLocalInt(oToB, "Foehammer", nTarget);					break;
		case STRIKE_FSCIE_STRIKE:					SetLocalInt(oToB, "FSCIEStrike", nTarget);					break;
		case STRIKE_GHOST_BLADE:					SetLocalInt(oToB, "GhostBlade", nTarget);					break;
		case STRIKE_HAMSTRING_ATTACK:				SetLocalInt(oToB, "HamstringAttack", nTarget);				break;
		case STRIKE_HAND_OF_DEATH:					SetLocalInt(oToB, "HandofDeath", nTarget);					break;
		case STRIKE_HTCHLFLM:						SetLocalInt(oToB, "HatchlingsFlame", nTarget);				break;
		case STRIKE_HYDRA_SLAYING_STRIKE:			SetLocalInt(oToB, "HydraSlayingStrike", nTarget);			break;
		case STRIKE_INFERNOBLST:					SetLocalInt(oToB, "InfernoBlast", nTarget);					break;
		case STRIKE_INSIGHTFUL_STRIKE:				SetLocalInt(oToB, "InsightfulStrike", nTarget);				break;
		case STRIKE_INSIGHTFUL_STRIKE_GREATER:		SetLocalInt(oToB, "InsightfulStrikeGreater", nTarget);		break;
		case STRIKE_IRON_BONES:						SetLocalInt(oToB, "IronBones", nTarget);					break;
		case STRIKE_IRON_HEART_SURGE:				SetLocalInt(oToB, "IronHeartSurge", nTarget);				break; // Does not do damage.
		case STRIKE_IRRESISTIBLE_MOUNTAIN_STRIKE:	SetLocalInt(oToB, "IrresistibleMountainStrike", nTarget);	break;
		case STRIKE_LAW_BEARER:						SetLocalInt(oToB, "LawBearer", nTarget);					break;
		case STRIKE_LEADING_THE_ATTACK:				SetLocalInt(oToB, "LeadingtheAttack", nTarget);				break;
		case STRIKE_LIGHTNING_THROW:				SetLocalInt(oToB, "LightningThrow", nTarget);				break;
		case STRIKE_LNGNINFRNO:						SetLocalInt(oToB, "LingeringInferno", nTarget);				break;
		case STRIKE_MIGHTY_THROW:					SetLocalInt(oToB, "MightyThrow", nTarget);					break;
		case STRIKE_MIND_STRIKE:					SetLocalInt(oToB, "MindStrike", nTarget);					break;
		case STRIKE_MITHRAL_TORNADO:				SetLocalInt(oToB, "MithralTornado", nTarget);				break;
		case STRIKE_MOUNTAIN_HAMMER:				SetLocalInt(oToB, "MountainHammer", nTarget);				break;
		case STRIKE_MOUNTAIN_TOMBSTONE_STRIKE:		SetLocalInt(oToB, "MountainTombstoneStrike", nTarget);		break;
		case STRIKE_OBSCURING_SHADOW_VEIL:			SetLocalInt(oToB, "ObscuringShadowVeil", nTarget);			break;
		case STRIKE_OF_PERFECT_CLARITY:				SetLocalInt(oToB, "StrikeofPerfectClarity", nTarget);		break;
		case STRIKE_OF_RIGHTEOUS_VITALITY:			SetLocalInt(oToB, "StrikeofRighteousVitality", nTarget);	break;
		case STRIKE_OF_THE_BROKEN_SHIELD:			SetLocalInt(oToB, "StrikeotBrokenShield", nTarget);			break;
		case STRIKE_OVERWHELMING_MOUNTAIN_STRIKE:	SetLocalInt(oToB, "OverwhelmingMountainStrike", nTarget);	break;
		case STRIKE_POUNCING_CHARGE:				SetLocalInt(oToB, "PouncingCharge", nTarget);				break;
		case STRIKE_RABID_BEAR_STRIKE:				SetLocalInt(oToB, "RabidBearStrike", nTarget);				break;
		case STRIKE_RABID_WOLF_STRIKE:				SetLocalInt(oToB, "RabidWolfStrike", nTarget);				break;
		case STRIKE_RADIANT_CHARGE:					SetLocalInt(oToB, "RadiantCharge", nTarget);				break;
		case STRIKE_RALLYING_STRIKE:				SetLocalInt(oToB, "RallyingStrike", nTarget);				break;
		case STRIKE_REVITALIZING_STRIKE:			SetLocalInt(oToB, "RevitalizingStrike", nTarget);			break;
		case STRIKE_RNBLADE:						SetLocalInt(oToB, "RNBlade", nTarget);						break;
		case STRIKE_RNGOFFIRE:						SetLocalInt(oToB, "RingofFire", nTarget);					break;
		case STRIKE_SHADOW_BLADE_TECHNIQUE:			SetLocalInt(oToB, "ShadowBladeTechnique", nTarget);			break;
		case STRIKE_SHADOW_GARROTE:					SetLocalInt(oToB, "ShadowGarrote", nTarget);				break;
		case STRIKE_SHADOW_NOOSE:					SetLocalInt(oToB, "ShadowNoose", nTarget);					break;
		case STRIKE_SLMDRCHRG:						SetLocalInt(oToB, "SalamanderCharge", nTarget);				break;
		case STRIKE_SNBLADE:						SetLocalInt(oToB, "SNBlade", nTarget);						break;
		case STRIKE_SOARING_RAPTOR_STRIKE:			SetLocalInt(oToB, "SoaringRaptorStrike", nTarget);			break;
		case STRIKE_SOARING_THROW:					SetLocalInt(oToB, "SoaringThrow", nTarget);					break;
		case STRIKE_SRNGCHRG:						SetLocalInt(oToB, "SearingCharge", nTarget);				break;
		case STRIKE_STALKER_IN_THE_NIGHT:			SetLocalInt(oToB, "StalkerintheNight", nTarget);			break;
		case STRIKE_STEEL_WIND:						SetLocalInt(oToB, "SteelWind", nTarget);					break;
		case STRIKE_STEELY_STRIKE:					SetLocalInt(oToB, "SteelyStrike", nTarget);					break;
		case STRIKE_STONE_BONES:					SetLocalInt(oToB, "StoneBones", nTarget);					break;
		case STRIKE_STONE_DRAGONS_FURY:				SetLocalInt(oToB, "StoneDragonsFury", nTarget);				break;
		case STRIKE_STONE_VISE:						SetLocalInt(oToB, "StoneVise", nTarget);					break;
		case STRIKE_STRENGTH_DRAINING_STRIKE:		SetLocalInt(oToB, "StrengthDrainingStrike", nTarget);		break;
		case STRIKE_SWARMING_ASSAULT:				SetLocalInt(oToB, "SwarmingAssault", nTarget);				break;
		case STRIKE_SWOOPING_DRAGON_STRIKE:			SetLocalInt(oToB, "SwoopingDragonStrike", nTarget);			break;
		case STRIKE_TACTICAL_STRIKE:				SetLocalInt(oToB, "TacticalStrike", nTarget);				break;
		case STRIKE_TIDE_OF_CHAOS:					SetLocalInt(oToB, "TideofChaos", nTarget);					break;
		case STRIKE_TIME_STANDS_STILL:				SetLocalInt(oToB, "TimeStandsStill", nTarget);				break;
		case STRIKE_VANGUARD_STRIKE:				SetLocalInt(oToB, "VanguardStrike", nTarget);				break;
		case STRIKE_WAR_LEADERS_CHARGE:				SetLocalInt(oToB, "WarLeadersCharge", nTarget);				break;
		case STRIKE_WAR_MASTERS_CHARGE:				SetLocalInt(oToB, "WarMastersCharge", nTarget);				break;
		case STRIKE_WHITE_RAVEN_HAMMER:				SetLocalInt(oToB, "WhiteRavenHammer", nTarget);				break;
		case STRIKE_WHITE_RAVEN_STRIKE:				SetLocalInt(oToB, "WhiteRavenStr", nTarget);				break;
		case STRIKE_WOLF_CLIMBS_THE_MOUNTAIN:		SetLocalInt(oToB, "WolfClimbstheMountain", nTarget);		break;
		case STRIKE_WOLF_FANG_STRIKE:				SetLocalInt(oToB, "WolfFangStrike", nTarget);				break;
		case STRIKE_WYRMSFLAME:						SetLocalInt(oToB, "WyrmsFlame", nTarget);					break;
		default: return;
	}
}

// Placing a location value on an item tends to crash NWN2 so the location
// information here is stored in its raw state as three floats.
// -nManeuver: A maneuver of any type.
// -fx: The location's x position.
// -fy: The location's y position.
// -fz: The location's z position.
void IndexManeuverPosition(int nManeuver, float fx, float fy, float fz)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	switch (nManeuver)
	{
		case BOOST_BOULDER_ROLL:		SetLocalFloat(oToB, "BoulderRollX", fx);		SetLocalFloat(oToB, "BoulderRollY", fy);		SetLocalFloat(oToB, "BoulderRollZ", fz);		break;
		case BOOST_MOUNTAIN_AVALANCHE:	SetLocalFloat(oToB, "MountainAvalancheX", fx);	SetLocalFloat(oToB, "MountainAvalancheY", fy);	SetLocalFloat(oToB, "MountainAvalancheZ", fz);	break;
		case BOOST_SUDDEN_LEAP:			SetLocalFloat(oToB, "SuddenLeapX", fx);	   	 	SetLocalFloat(oToB, "SuddenLeapY", fy);			SetLocalFloat(oToB, "SuddenLeapZ", fz);			break;
		case BOOST_SHADOW_BLINK:		SetLocalFloat(oToB, "ShadowBlinkX", fx);		SetLocalFloat(oToB, "ShadowBlinkY", fy);		SetLocalFloat(oToB, "ShadowBlinkZ", fz);		break;
		case BOOST_SHADOW_STRIDE:		SetLocalFloat(oToB, "ShadowStrideX", fx);		SetLocalFloat(oToB, "ShadowStrideY", fy);		SetLocalFloat(oToB, "ShadowStrideZ", fz);		break;
		case STRIKE_SHADOW_JAUNT:		SetLocalFloat(oToB, "ShadowJauntX", fx); 		SetLocalFloat(oToB, "ShadowJauntY", fy);		SetLocalFloat(oToB, "ShadowJauntZ", fz);		break;
		case STRIKE_TORNADO_THROW:		SetLocalFloat(oToB, "TornadoThrowX", fx);		SetLocalFloat(oToB, "TornadoThrowY", fy);		SetLocalFloat(oToB, "TornadoThrowZ", fz);		break;
		default: return;
	}
}

//  Marks nRow as the next strike to be activated by the script activate_strike.
//  This is similar to the action queue, but works outside of it.  Strikes are
//  only removed from the action queue after they've been passed through the
//  script activate_strike.
void SetStrike(int nRow)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	int i;

	i = 0;

	SetLocalInt(oToB, "Strike0", 1);

	while (GetLocalInt(oToB, "Strike" + IntToString(i)) > 0)
	{
		i++;

		if (GetLocalInt(oToB, "Strike" + IntToString(i)) == 0)
		{
			SetLocalInt(oToB, "Strike" + IntToString(i), nRow);
			SetLocalInt(oToB, "HighStrike", i);
			break;
		}
	}
}

// Switches the mask buttons for the Swordsage maneuver recovery method on and off.
void ToggleMasks(int bToggle, string sScreen)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);

	SetGUIObjectHidden(oPC, sScreen, "STRIKE_ONE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_TWO_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_THREE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_FOUR_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_FIVE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_SIX_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_SEVEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_EIGHT_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_NINE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_TEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_ELEVEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_TWELVE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_THIRTEEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_FOURTEEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_FIFTEEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_SIXTEEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_SEVENTEEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_EIGHTEEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_NINETEEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "STRIKE_TWENTY_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_ONE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_TWO_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_THREE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_FOUR_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_FIVE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_SIX_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_SEVEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_EIGHT_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_NINE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "BOOST_TEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_ONE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_TWO_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_THREE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_FOUR_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_FIVE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_SIX_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_SEVEN_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_EIGHT_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_NINE_MASK", bToggle);
	SetGUIObjectHidden(oPC, sScreen, "COUNTER_TEN_MASK", bToggle);
}

// Recovers all maneuvers.  Intended use is for out of combat, the feat Adaptive
// Style and for use in the Warblade's recovery method.
// -sScreen: Xml screen for which we are recovering maneuvers.
void RecoverAllManeuvers(string sScreen)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	string sClass = GetStringRight(sScreen, 3);

	if (sClass == "_CR")
	{
		SetLocalInt(oToB, "EncounterR1", 0);
		return;
	}

	if (GetLocalInt(oToB, "BlueBoxSTR1" + sClass) > 0) // The extra checks improve preformance.
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_ONE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR2" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_TWO", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR3" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_THREE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR4" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_FOUR", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR5" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_FIVE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR6" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_SIX", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR7" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_SEVEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR8" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_EIGHT", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR9" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_NINE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR10" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_TEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR11" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_ELEVEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR12" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_TWELVE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR13" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_THIRTEEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR14" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_FOURTEEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR15" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_FIFTEEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR16" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_SIXTEEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR17" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_SEVENTEEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR18" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_EIGHTEEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR19" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_NINETEEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxSTR20" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "STRIKE_TWENTY", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB1" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_ONE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB2" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_TWO", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB3" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_THREE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB4" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_FOUR", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB5" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_FIVE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB6" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_SIX", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB7" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_SEVEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB8" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_EIGHT", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB9" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_NINE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxB10" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "BOOST_TEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC1" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_ONE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC2" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_TWO", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC3" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_THREE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC4" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_FOUR", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC5" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_FIVE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC6" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_SIX", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC7" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_SEVEN", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC8" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_EIGHT", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC9" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_NINE", FALSE);
	}

	if (GetLocalInt(oToB, "BlueBoxC10" + sClass) > 0)
	{
		SetGUIObjectDisabled(oPC, sScreen, "COUNTER_TEN", FALSE);
	}
}

// Checks for stances that bypass the uneven terrain rule for charging.
int CheckStanceChargeRules()
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	int nStance = GetLocalInt(oToB, "Stance");
	int nStance2 = GetLocalInt(oToB, "Stance2");
	int nReturn;
	
	switch (nStance)
	{
		case STANCE_STEP_OF_THE_WIND:	nReturn = TRUE;	break;
		default:						nReturn = FALSE;break;
	}

	switch (nStance2)
	{
		case STANCE_STEP_OF_THE_WIND:	nReturn = TRUE;	break;
		default:						nReturn = FALSE;break;
	}

	return nReturn;
}

// Returns an itemproperty from an item based on a desired itemproperty constant.
// nSubType by default ignores subtypes until a constant is entered as its value.
itemproperty GetItemPropertyByConst(int nItemProp, object oItem, int nSubType = -1)
{
	itemproperty iNull = ItemPropertyNoDamage();
    itemproperty ip = GetFirstItemProperty(oItem);
	int nSub = GetItemPropertySubType(ip);
	
    while (GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip) == nItemProp)
        {
			if (nSubType == -1 || nSub == nSubType)
			{
            	return ip;
			}
        }
        ip = GetNextItemProperty(oItem);
		nSub = GetItemPropertySubType(ip);
    }
    return iNull; //47, No combat damage property.
}

//Returns the integer value of nSubType if it matches the subtype of the test item.
int GetItemPropertySubTypeByConst(int nItemProp, object oItem, int nSubType = -1)
{
    itemproperty ip = GetFirstItemProperty(oItem);
	int nSub = GetItemPropertySubType(ip);
	
    while (GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip) == nItemProp)
        {
			if (nSubType == -1 || nSub == nSubType)
			{
            	return nSubType;
			}
        }
        ip = GetNextItemProperty(oItem);
		nSub = GetItemPropertySubType(ip);
    }
    return -1; // Nothing should have this subtype.
}

// Returns a constant from an item based on a desired itemproperty constant.
// nSubType by default ignores subtypes until a constant is entered as its value.
int GetItemPropertyConst(itemproperty ip, int nItemProp, object oItem, int nSubType = -1)
{
	int nSub = GetItemPropertySubType(ip);
	
	if (GetItemPropertyType(ip) == nItemProp)
	{
		if (nSubType == -1 || nSub == nSubType)
		{
           	return nItemProp;
		}
	}
    return -1;
}

// Tracks movement for the Strike Desert Tempest.  If the player has stopped
// moving, this function sets the strike to an inactive status.
void DoDesertTempestLoc()
{
	object oPC = OBJECT_SELF;
	location lPC = GetLocation(oPC);

	if (GetLocalLocation(oPC, "DesertTempestLoc") != lPC)
	{
		SetLocalLocation(oPC, "DesertTempestLoc", lPC);
		DelayCommand(0.1f, DoDesertTempestLoc());
	}
	else DeleteLocalInt(oPC, "DesertTempestActive");
}

// Runs the attack rolls and damage for the maneuver Desert Tempest while the 
// PC is moving by his opponents.  This maneuver has a cap of ten opponents.
void DoDesertTempest(float fRange)
{
	object oOrigin = OBJECT_SELF;
	object oPC = GetControlledCharacter(oOrigin);
	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);

	if (GetLocalInt(oPC, "DesertTempestActive") == 1)
	{
		location lPC = GetLocation(oPC);
		object oCreature;
		float fDist;
		int n;

		oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lPC);
		n = 1;

		while (GetIsObjectValid(oCreature))
		{
			fDist = GetDistanceBetween(oPC, oCreature);

			if ((oCreature != oPC) && (GetLocalInt(oCreature, "DesertTempestHit") == 0) && (GetIsReactionTypeHostile(oCreature, oPC)) && (fDist <= fRange))
			{
				SetLocalInt(oCreature, "DesertTempestHit", 1);
				AssignCommand(oCreature, DelayCommand(6.0f, DeleteLocalInt(oCreature, "DesertTempestHit")));
				SetLocalObject(oToB, "DesertTempestFoe" + IntToString(n), oCreature);
				n++;

				if (n > 10)
				{
					break;
				}
			}
			oCreature = GetNextObjectInShape(SHAPE_SPHERE, fRange, lPC);
		}

		object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
		object oFoe1 = GetLocalObject(oToB, "DesertTempestFoe1");

		if (GetIsObjectValid(oFoe1))
		{
			int nHit1 = StrikeAttackRoll(oWeapon, oFoe1);

			StrikeAttackSound(oWeapon, oFoe1, nHit1, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit1, oFoe1);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe1"));
		}

		object oFoe2 = GetLocalObject(oToB, "DesertTempestFoe2");

		if (GetIsObjectValid(oFoe2))
		{
			int nHit2 = StrikeAttackRoll(oWeapon, oFoe2);

			StrikeAttackSound(oWeapon, oFoe2, nHit2, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit2, oFoe2);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe2"));
		}

		object oFoe3 = GetLocalObject(oToB, "DesertTempestFoe3");

		if (GetIsObjectValid(oFoe3))
		{
			int nHit3 = StrikeAttackRoll(oWeapon, oFoe3);

			StrikeAttackSound(oWeapon, oFoe3, nHit3, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit3, oFoe3);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe3"));
		}

		object oFoe4 = GetLocalObject(oToB, "DesertTempestFoe4");

		if (GetIsObjectValid(oFoe4))
		{
			int nHit4 = StrikeAttackRoll(oWeapon, oFoe4);

			StrikeAttackSound(oWeapon, oFoe4, nHit4, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit4, oFoe4);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe4"));
		}

		object oFoe5 = GetLocalObject(oToB, "DesertTempestFoe5");

		if (GetIsObjectValid(oFoe5))
		{
			int nHit5 = StrikeAttackRoll(oWeapon, oFoe5);

			StrikeAttackSound(oWeapon, oFoe5, nHit5, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit5, oFoe5);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe5"));
		}

		object oFoe6 = GetLocalObject(oToB, "DesertTempestFoe6");

		if (GetIsObjectValid(oFoe6))
		{
			int nHit6 = StrikeAttackRoll(oWeapon, oFoe6);

			StrikeAttackSound(oWeapon, oFoe6, nHit6, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit6, oFoe6);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe6"));
		}

		object oFoe7 = GetLocalObject(oToB, "DesertTempestFoe7");

		if (GetIsObjectValid(oFoe7))
		{
			int nHit7 = StrikeAttackRoll(oWeapon, oFoe7);

			StrikeAttackSound(oWeapon, oFoe7, nHit7, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit7, oFoe7);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe7"));
		}

		object oFoe8 = GetLocalObject(oToB, "DesertTempestFoe8");

		if (GetIsObjectValid(oFoe8))
		{
			int nHit8 = StrikeAttackRoll(oWeapon, oFoe8);

			StrikeAttackSound(oWeapon, oFoe8, nHit8, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit8, oFoe8);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe8"));
		}

		object oFoe9 = GetLocalObject(oToB, "DesertTempestFoe9");

		if (GetIsObjectValid(oFoe9))
		{
			int nHit9 = StrikeAttackRoll(oWeapon, oFoe9);

			StrikeAttackSound(oWeapon, oFoe9, nHit9, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit9, oFoe9);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe9"));
		}

		object oFoe10 = GetLocalObject(oToB, "DesertTempestFoe10");

		if (GetIsObjectValid(oFoe10))
		{
			int nHit10 = StrikeAttackRoll(oWeapon, oFoe10);

			StrikeAttackSound(oWeapon, oFoe10, nHit10, 0.0f);
			StrikeWeaponDamage(oWeapon, nHit10, oFoe10);
			DelayCommand(0.1f, DeleteLocalObject(oToB, "DesertTempestFoe10"));
		}

		DelayCommand(1.0f, DoDesertTempest(fRange));
	}
	else
	{
		DeleteLocalObject(oToB, "DesertTempestFoe1");
		DeleteLocalObject(oToB, "DesertTempestFoe2");
		DeleteLocalObject(oToB, "DesertTempestFoe3");
		DeleteLocalObject(oToB, "DesertTempestFoe4");
		DeleteLocalObject(oToB, "DesertTempestFoe5");
		DeleteLocalObject(oToB, "DesertTempestFoe6");
		DeleteLocalObject(oToB, "DesertTempestFoe7");
		DeleteLocalObject(oToB, "DesertTempestFoe8");
		DeleteLocalObject(oToB, "DesertTempestFoe9");
		DeleteLocalObject(oToB, "DesertTempestFoe10");
	}
}

// Determines if a Crusader has readied all aviablable maneuvers.
// Returns TRUE if the crusader has.
int CheckRedCrusader(object oOrigin = OBJECT_SELF)
{
	object oPC;

	if (oOrigin != OBJECT_SELF)
	{
		oPC = oOrigin;
	}
	else oPC = GetControlledCharacter(oOrigin);

	string sToB = GetFirstName(oPC) + "tob";
	object oToB = GetObjectByTag(sToB);
	int nReadiedTotal = GetLocalInt(oToB, "ReadiedTotal_CR");
	int n, nRed, nReturn;
	string sRed;

	n = 1;
	nRed = 0;

	while (n < 18)
	{
		sRed = "RedBox" + IntToString(n) + "_CR";

		if (GetLocalInt(oToB, sRed) == 1)
		{
			nRed += 1;
		}

		if (nRed == nReadiedTotal)
		{
			nReturn = TRUE;
			break;
		}

		n++;
	}

	return nReturn;
}
	