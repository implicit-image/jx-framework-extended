//::///////////////////////////////////////////////
//:: Wild Magic Functions
//::///////////////////////////////////////////////
/*
This scrip contains all the functions related to wild magic
*/
//::///////////////////////////////////////////////
//:: Created By: 2DruNk2Frag & Shazbotian
//:: Created On: 02-06-2008
//:: Last Update: 02-22-2008
//:: 02/26/08:Shazbotian: changed surge reports to speakstrings so you could see enemy surges, added invis and monster summon surges
//:: 02/26/08:Shazbotian: added functions to generate enlarge and reduce effects
//:: 02-26-08:2d2f - Added function to handle spells part of banefull deflector.  
//::			   	- Modified GetRandomCreatureInArea to include caster and initial target if argument is set.
//::				- Moved wild mage level variation to the end because I'm tired of scrolling past it.
//:: 03/10/08:Shazbotian: added new helper functions for gemspray, hiccuping, and itching surges
//:: 03/13/08:Shazbotian: added helper function for dizzy surge
//:: 03-14-08:2d2f - Changed wildMageLevelVariation to use caster level instead of spell level as per TOM.  I guess I misunderstood the TOM all along. opps!
//:: 				- Made some changes to flyinggem surge function; changed vfx to custom one, changes vfx duration to 1 round for pizzaz, fixed cone shape problem
//:: 03-16-08:2d2f - Changed code to handle baneful deflector
//:: 03-19-08:2d2f - Modified GetRandomCreatureInArea again be able to select if you want to target the caster and initial target as seperate arguments
//:: 03-20-08:Shazbotian: added helper function for gate surge, modified monster summons, and added a helper function to make both follow the caster around
//:: 03-26-08:2d2f - Made some basic changes to doSurgeNoSpell
//:: 03-27-08:Shaz: added helper functions for RandomPolymorphing and destroying cloth
//:: 03-28-08:2d2f - Added helper functions, MusicFillsAir, ChangeSkinColor, and SmokeyEars
//:: 03-29-08:2d2f - Modified MusicFills air function to not play a clip if music is already playing
//:: 04-04-08:Shaz: added function to encircle the target with fire walls, and another to open all doors in an area
//:: 04-04-08:2d2f - Fixed the area of the banefulD function and made sure getrandomcreature function doesn't select dead creatures
//:: 04-10-08:2d2f - Added the following functions 	- GetRandomInventoryWeaponOrArmor
//::													- GetItemHasProperties
//::													- DrainItem
//::													- EnhanceItem
//::													- EnhanceAllNearWeapons
//::													- PrivateChooseRandomItemGlow
//::													- AllWeaponsGlow
//::													- AllMagicItemsGlow
//:: 04-14-08:2d2f - Found out that a temporary permanent effect will be removed by resting.
//::					- Created a function RemoveSupernaturalEffectWithSpellId that will handle this issue by
//::					- setting a bunk spell id to the effect so it can be removed after a delay.
//::					- Changed the changeskincolor funtion to use this.
//:: 04-16-08:2d2f - Added the function AboutFace and shrieker
//:: 04-18-08:2d2f - Added the function RandomLimb
//:: 04-20-08:2d2f - Added the following functions PrivateTinyLightning, SmallRainCloud, AOEKnockdown, and ExchangePlaces.
//:: 04-22-08:2d2f - Added the ARainbowAndALeprichaun function.
//:: 04-24-08:2d2f - added the function ChangeWeather
//:: 04-28-08:Shaz: Added ShazGetFirstEquippedMagicItem, ShazGetReversedSpellID, ShazDoSneezing, and ShazDoMagicAllergy functions, to support associated surges
//:: 04-31-08:2d2f - removed exchange places function and GetRandomInventoryWeaponOrArmor. added these functions - GetIsEquipable, GetCountOfEquipableItems, and GetRandomEquipableItem
//:: 04-31-08:2d2f - modified the AllMagicItemsGlow, EnhanceItem, AOEKnockdown, and DrainItem functions
//:: 05-01-08:2d2f - Added the function Streamers
//:: 05-06-08:2d2f - Added the function YouHaveStoppedBreathing
//:: 05-09-08:2d2f - Removed the streamers function, added the fireworks function
//:: 05-10-08:2d2f - Put in a fix for a rare but potentially nasty bug in the skinncolor, randomlimb, and zombified surge functions. Changed a line in the shrieker function.
//:: 05-14-08:Shaz: Modified doSurgeNoSpell slightly to restore the selected dweomer spell
//:: 05-18-08:2d2f - Added the helper functions forceEquip, forceUnequip, and forcePutDownItem. also modified the zombified surge
//:: 05-22-08:2d2f - Added the function CloneTarget. code stolen from Elysius (be sure to credit him on release)
//:: 05-30-08:2d2f - Modified the Skincolor, random limb, and zombie surges for increased supernatural effect removal reliability (again).
//:: 05-31-08:Shaz: Added levitation and "annoying" following functions, some fixes to equipping surges (undead, clothing)
//:: 06-02-08:2d2f - Added SummonDM function.
//:: 06-05-08:2d2f - Added summon rustmonster function, added drunkbomb function.
//:: 06-10-08:2d2f - Added the sexChange function
//:: 06-11-08:2d2f - Added the RaceChange, AddRacialAbilitires, RemoveRacialAbilities, and twoDimensions functions
//:: 06-15-08:2d2f - Added the GetSurgeName, RemoveSurgeSelector, and HandleSurgeSelector functions. Also, modified the dosurgenospell function for a  better bug fix(sorry))
//::///////////////////////////////////////////////

//for VFX_FNF_WILD_SURGE
//#include "2d2f_includes"
#include "cmi_ginc_spells"
#include "x0_i0_position"
// for MySavingThrow for DoGemspray()
#include "x0_i0_spells"	
#include "jx_inc_magic_info"
#include "ginc_event_handlers"
#include "ginc_henchman"
#include "nw_i0_spells"
#include "nw_i0_generic"
//#include "x0_i0_behavior"

#include "x2_inc_itemprop"


//::///////////////////////////////////////////////
//:: Constants
//::///////////////////////////////////////////////

const int SPELL_SHIMMER_LIGHTS = 17300;

//::///////////////////////////////////////////////
//:: Functions Definitions
//::///////////////////////////////////////////////

//:: Determins the wild mages level variation and if a wild surg results
//:: Called every time a Wild Mage casts a Spell
//:: 777 is the lucky number
int wildMageLevelVariation(int nCasterLvl);

//:: Private function - used by JXCastAtRandomTarget
int GetNumberOfCreaturesInArea(location oCenter, float fRadius);

//:: Private function - used by JXCastAtRandomTarget
//:: 2d2f: added option to target caster and initial target, both, or neither... err ya
object GetRandomCreatureInArea(object oCaster, object oInitialTarget, float fRadius, int nCasterValidTarget = FALSE, int nInitialValidTarget = FALSE);

//:: Applies the wild surge visual effect to the caster
void doWildSurgeEffect(object oCaster);

//:: Handles the spell Hornung's Baneful Deflector
void handleBanefulDeflector(object oCaster, object oTarget, int nSpellId);

//:: Used in cases where a surge needs to happen but no spell was cast
//:: Currently used in the Spell Vortex and Glyph of Wild MAgic
void doSurgeNoSpell(object oCaster, float fRadius);

//:: Used to set a supernatural effct to permanent, but still be able to remove it .
void RemoveSupernaturalEffectWithSpellId(object oTarget,int nSpellId);

//:: checks if the base item type is equipable
int GetIsEquipable(object oItem);

//:: Counts the number of equipable items on creature
//:: also can exclude non-magical items from the count
//:: used to set the maximum number of loops when selecting a random item
//:: in GetEquipableItem
int GetCountOfEquipableItems(object oCaster, int nMagicalOnly = TRUE);

//:: returns a random equipable item from creatures inventory
//:: can exclude non-magical items
object GetRandomEquipableItem(object oCaster, int nMagicalOnly = TRUE);

//:: forces the equiping of an item even in combat
void forceEquip(object oTarget, object oItem, int nSlot);

//:: forces the unequiping of an item
void forceUnequip(object oTarget, object oItem, int nSlot);

//:: forces the target t oput down an item
void forcePutDownItem(object oTarget, object oItem, int nSlot);

//:: Returns the surge name
string GetSurgeName(int nRand);

//:: checks to see if it is time to end Hornung's surge selector
void RemoveSurgeSelector(object oCaster);

//:: Executes hornung's surge selector
void HandleSurgeSelector(   object oCaster,
                            object oTarget,
                            location lLoc, 
                            int nSpellId,
                            int nMeta,
                            int nRangeType,
                            int nCasterLvl,
                            int nSpellSaveDC,
                            int iSurgeModifier);              

//....................//
//Wild Surge Functions//
//....................//


//:: 01a
//:: Make a spell change its original target for a random one
//:: oCaster Caster of the spell
//:: oTarget Target creature/placeable of the spell
//:: iSpellId SPELL_* constant
void JXWZCastAtRandomTarget(object oCaster, object oTarget, int iSpellId);

//:: 01b
//:: Make a spell change its original target location for a random one
//:: oCaster Caster of the spell
//:: iSpellId SPELL_* constant
void JXWZCastAtRandomLocation(object oCaster, int iSpellId);

//:: 03
//:: Summons a menagerie.
//:: cancels spells
void WmMenagerieLocation(location lLoc);

//:: 31
//:: Make a spell turn back at the caster
//:: oCaster Caster of the spell
//:: lTo Target location of the spell
//:: iSpellId SPELL_* constant
void JXWZTurnSpell(object oCaster, location lTo, int iSpellId);

//:: 44
//:: Make shimmering lights appear around the caster when he casts a spell
//:: oCaster Caster of the spell
void JXWZCastShimmeringLights(object oCaster);


//:: 100
//:: Spell functions but at doubles the casters level
//:: also adding 2 to its save DC
void JXWZIncreaseSpellStrength(object oCaster);

//:: 34
//:: randomly selects a 20-40 second tune
void MusicFillsAir(object oCaster);

//:: 98
//:: Target's skin becomes a diffrent color untell dispell magic is cast
void ChangeSkinColor(object oTarget);

//:: 43 
//:: Smoke trickles from the ears of nearby creatures
void SmokeyEars(object oCaster, int iShieldSuccess);


//::Returns TRUE if the passed item has any properties (and is therefore magical)
int GetItemHasProperties(object oItem);

//::40
//:: Item has all its properties removed
object DrainItem(object oCaster);

//::41
//:: Item gain 1-3 points of enhancement, attack bonus, or AC
object EnhanceItem(object oCaster);

//::42
//::all equiped melee weapons gain +2 enhancement / ranged +2 attack
//::within 30'
void EnhanceAllNearWeapons(object oCaster,int iShieldSuccess);

//::private function used in surges 59 and 61
itemproperty PrivateChooseRandomItemGlow();

//:: 59
//:: all weapons within 60' glow 1d4 rounds
void AllWeaponsGlow(object oCaster);

//::62
//:: all magic items within 60' glow for 2d8 days
void AllMagicItemsGlow(object oCaster);

//::9
//:: all creatures withing a really really huge area turn around
void AboutFace(object oCaster,int iShieldSuccess);

//::55
//:: spell functions but shreaks alerting all monsters in a super large area
void Shrieker(location lTarget, object oCaster, int iShieldSuccess);

//::97
// adds a useless new body part
void RandomLimb(object oTarget);

//:: private function used in the rain cloud surge
void PrivateTinyLightning(object oTarget);

//::86
//:: a small rain cloud forms over the caster.lasts 1 hour.
void SmallRainCloud(object oTarget);

//::1
//:: All within a large area are knocked down
void AOEKnockdown(object oCaster);

//::7
//:: a rainbow forms and a leprichaun apears.  hes not really that happy about it
void ARainbowAndALeprichaun(object oCaster);

//::51
//:: a change in weather?
void ChangeWeather();

//::39
//:: caster dies! not exactly
void YouHaveStoppedBreathing(object oCaster);

//::30
//:: fireworks
void Fireworks(object oCaster);

//:: 70
// creates 1-4 copies of the target
void CloneTarget(object oTarget, object oCaster);

//::25
//:: caster becomes phobic to a random creature for 1-4 days or 3-6 encounters
string Phobia(object oCaster, int nSpellId);

//::63
//:: The Dungeon Master appears and offers a prize if a card is drawn
void SummonDM(object oTarget);

//::82
//:: A rust monster appears
void SummonRustMonster(object oTarget);

//::80
//:: Everyone within 60' of target gets drunk!
void DrunkBomb(object oTarget,object oCaster, int iShieldSuccess);

//::85
//:: Target Changes Sex permanently
int SexChange(object oTarget, int nKeepGender = FALSE);

//:: private function for RaceChange
void RemoveRacialAbilities(object oTarget, int nSubRace);

//:: private function for RaceChange
void AddRacialAbilities(object oTarget, int nSubRace);

//::92
//:: Target Changes race
int RaceChange(object oTarget);

//::24
//:: target becomes 2-dimensional
void TwoDimensions(object oCaster);

/////////////////////////////////////////////////////
//:: Shazbotian Functions

//:: Selects a completely random spell from any in the game (cleric, druid, ect), and casts it at an appropriate target
//:: Note: the spell is treated as having come from OBJECT_SELF for the purposes of spell resistance, absorbtion, ect.
//:: This function returns the SpellID of the spell it cast
int ShazCastRandomSpellAtRandomTarget();

//:: as JXWZCastShimmeringLights, but for any spell
void ShazCastSpellOnObject(object oCaster, int iSpellID);

//:: this uses "oCaster's" stats but sends the spell from oTarget
void ShazCastSpellOnCasterFromTarget(object oCaster, object oTarget, int iSpellID);

void ShazCreateObjectVoid(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="");

// this function will destroy all clothing, padded armor, cloaks, and gloves (not gauntlets) on the target
// If it destroys what they were wearing, it puts "Barest of rags" onto them, to make them appear more appropriately "unclothed"
void ShazDestroyAllClothOnTarget(object oTarget);

// Does a bang effect like surge #52 in the ToM suggests, but also deafen's targets for awhile
// Also, returns a 1 if it ignored a creature, else 0
int ShazDoDeafeningBang(location lLocation, object oIgnoreCreature=OBJECT_INVALID);

//:: Causes an explosion size large (slightly smaller than a fireball)
//:: of the desired iDamageType (some types not supported, and will be treated as straight magic)
//:: doing damage of d4(iStrength). it is resistable, and can be evaded (like fireball)
void ShazDoExplosion(location lLocation, int iDamageType, int iStrength=1);

// copied from x0_s3_gemspray, modified to have more gems, 
// drop them on the ground around the targets, 
// and create some even if there aren't any targets hit
void ShazDoFlyingGems(object oCaster, location lTarget);

//:: A function called periodically on the victim, applies a debuf unless the victim has no armor on
void ShazDoItchyClothing(object oVictim);

//:: A function called periodically on the victim, applies a debuf and interups their action queue if they fail concentration roll
void ShazDoHiccups();

//:: Called periodically on the person levitating, makes adjacent enemies without ranged weapons highly innacurate
//::  also does the same to the person levitating
void ShazDoLevitation();

//:: called periodically on the living spell elemental
//:: causes the objectself (living spell) to attack the nearest target, friend or foe
//:: if it is a hostile creature, the elemental switches itself to defender faction
//:: if it is a non-hostile creature, it switches itself to hostile faction
//:: also, it has a 50% chance to ignore any targets it's hit (they get the "spellelemhit" tag)
void ShazDoLivingSpellAI();

//:: A function called periodically on a vicitm, makes them incapable of any movement as long as they have any magic items equipped
void ShazDoMagicAllergy();

void ShazDominateCreature(object oCreature);

//:: A function called perodically on a victim, makes the victim sneeze
void ShazDoSneezing();

//:: Function called periodically on the victim, makes friendlies not in combat say something and try to get away
void ShazDoStinkReactions();

//:: creates an effect that gives -4 to hit & ac , slows movement, and prevents spellcasting
effect ShazEffectDizzy();

//:: creates an enlarging effect (a package of linked effects similar to the "enlarge person" spell)
effect ShazEffectEnlarge();

//:: create a random polymorph effect; this includes almost every single polymorph with a valid appearce in the 2da
effect ShazEffectRandomPolymorph(object oTarget);

//:: creates an effect opposite that of the "enlarge person" spell
effect ShazEffectReduce();

//:: casts four fire walls around the target
void ShazEncloseTargetInFire(object oCaster, location lTarget);

//:: searches the target for buffs, dispelling magic ones (hopefully)
//:: and for each dispelled, causing a small explosion of a random element
//:: the strength of the explosion should depend on the innate spell level of the effect
void ShazExplodeMagicOnTarget(object oTarget);

//:: Makes the lover person irrationally follow the love target around, defend it,
//:: and pretty much ignore everything else. Oh, and they also declare their love for oLoveTarget periodically.
void ShazFallInLove(object oLover, object oLoveTarget);

//:: when executed by an object, makes the object walk to the target if it isn't already within 20' and not in combat
//:: this function will re-execute itself on the calling object periodically
void ShazFollowObject(object oTarget);

//:: when executed by an object, makes the object walk to the target if its greater than fDistance
//:: or twice fDistance when in combat. In addition, if not in combat, the executing object will occasionally say "hello"
//:: this function will re-execute itself on the calling object periodically
void ShazFollowObjectAnnoying(object oTarget, float fDistance);

//:: summons in a random outsider. Has a 50% chance to just make a gate
//:: also i've rigged this thing to make the outsider change faction after a random period of time... be careful! ;-)
void ShazGateRandomOutsider(int iLevel, location lLocation);

//:: gets a completely random spell id; could be cleric, mage, whatever, but it should be valid
int ShazGetAnyRandomValidSpellID();

//:: gets the first magic item oCreature has equipped
object ShazGetFirstEquippedMagicItem(object oCreature);

//:: given a spell, gets a "reversed" spell, if one exists, otherwise -1 (eg, "darkness" gets "light")
int ShazGetReversedSpellID(int iSpellID);

//:: A replacement for "incease spell strength" that gets closer to actually doubling (not quite there)
void ShazIncreaseSpellStrength(object oCaster);

//:: deterimines if a partiular spell id could be cast by anyone (does it have a class-type spell level)
int ShazIsSpellCastable(int iSpellID);

//:: returns 1 if the spellID is a summoning spell (gate, summon monster, create undead)
int ShazIsSummoningSpell(int iSpellID);

//:: Meant to be played on the player's "owned" character, it prevents them
//:: from controlling that character by forcing them to control another character
//:: as long as they have any companions. if they don't have any...
//:: please NOTE: use SetIsCompanionPossessionBlocked on non-player-owned characters, this is just for the player's own char
void ShazLovePreventPlayerControl();

//:: Unlocks and opens all nearby doors (should get secret and magical ones automatically?)
void ShazOpenAllNearbyDoors(location lTarget, float fDistance);

//:: A replacement for the "summon monster 2" surge cause that one is lame in NWN2 (a badger!? wtf?!)
void ShazSummonRandomCreaturesAtLocation(location lLocation);

//:: Creates a water elemental, applies some effects to it, gives it a creature weapon that casts a spell, and lets it roam free..
void ShazSummonSpellElemental(location lLocation, int iSpellID);

// removes the cutscene paralyze from a creature prematurely and
// lets them move around for six seconds, then re-freezes them (if there is time left)
void ShazTimeStopTurn(object oTarget, float fTimeLeftAfterTurn);

//:: Freezes all creatures in a large area with unresistable paralyze for
//:: 1 turn (1 minute) with a new creature getting freed up to move each round
void ShazTimeStopWithTurns(location lLocation, object oIgnoreCreature = OBJECT_INVALID);

//::///////////////////////////////////////////////
//:: Function Implementation
//::///////////////////////////////////////////////

int GetNumberOfCreaturesInArea(location oCenter, float fRadius)
{
	int iNumberOfCreatures = 0;
	// Iterate through all creatures
	object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, oCenter, TRUE, OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oCreature))
	{
		if((GetIsDead(oCreature) != TRUE) && (GetScriptHidden(oCreature) != TRUE)) {
			iNumberOfCreatures++;
		} else {
			//object oPC = GetFirstPC();
			//SendMessageToPC(oPC, "Avoid counting creature " + GetName(oCreature));
		}

		oCreature = GetNextObjectInShape(SHAPE_SPHERE, fRadius, oCenter, TRUE, OBJECT_TYPE_CREATURE);
	}

	return iNumberOfCreatures;
}

//::///////////////////////////////////////////////

object GetRandomCreatureInArea(object oCaster, object oInitialTarget, float fRadius, int nCasterValidTarget = FALSE, int nInitialValidTarget = FALSE)
{
	object oPC = GetFirstPC();	// for debuggind purposes only
	int iNumberOfTargets;
	 // Find the possible number of targets 
	if(nCasterValidTarget == FALSE && nInitialValidTarget == FALSE) // (Caster and initial target are not a valid target)
	{
		iNumberOfTargets = GetNumberOfCreaturesInArea(GetLocation(oCaster), fRadius) - 2;
	}
	else if(nCasterValidTarget == FALSE && nInitialValidTarget == TRUE) // (Caster is not a valid target)
	{
		iNumberOfTargets = GetNumberOfCreaturesInArea(GetLocation(oCaster), fRadius) - 1;
	}
	else if(nCasterValidTarget == TRUE && nInitialValidTarget == FALSE) // (Initial target is not a valid target)
	{
		iNumberOfTargets = GetNumberOfCreaturesInArea(GetLocation(oCaster), fRadius) - 1;
	}
	else // (Caster and initial target ARE valid target)
	{
		iNumberOfTargets = GetNumberOfCreaturesInArea(GetLocation(oCaster), fRadius);
	}
	
	//SendMessageToPC(oPC, IntToString(iNumberOfTargets) + " valid targets found by GetRandomCreature");
	
	// Shaz: It seems to me, if the caster was alone and this was called with 
	//  caster & target invalid, you'd get -1
	//if (iNumberOfTargets == 0)
	if(iNumberOfTargets <= 0) {
		return OBJECT_INVALID;
	}

	// Randomly choose a target
	int iRandomTarget = Random(iNumberOfTargets)+ 1;
	int iTargetsLoop = 0;
	// Iterate through all creatures
	object oRandomTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oRandomTarget))
	{
		if((GetIsDead(oRandomTarget) != TRUE) && (GetScriptHidden(oRandomTarget) != TRUE))
		{
			if(nCasterValidTarget == FALSE && nInitialValidTarget == FALSE) // Caster and initial target are not a valid target valid target
			{			
				if ((oRandomTarget != oCaster)
				&& (oRandomTarget != oInitialTarget))
				{
					iTargetsLoop++;
					if (iTargetsLoop == iRandomTarget)	// Random target found
					return oRandomTarget;
				}
			}
			else if(nCasterValidTarget == FALSE && nInitialValidTarget == TRUE) // (Caster is not a valid target)
			{			
				if ((oRandomTarget != oCaster)
				)
				{
					iTargetsLoop++;
					if (iTargetsLoop == iRandomTarget)	// Random target found
					return oRandomTarget;
				}
			}
			else if(nCasterValidTarget == TRUE && nInitialValidTarget == FALSE) // (Initial target is not a valid target)
			{			
				if ((oRandomTarget != oInitialTarget)
				)
				{
					iTargetsLoop++;
					if (iTargetsLoop == iRandomTarget)	// Random target found
					return oRandomTarget;
				}
			}
			else // caster and initial target are valid 
			{
				iTargetsLoop++;
				if (iTargetsLoop == iRandomTarget)	// Random target found
				return oRandomTarget;
			}
		}
	oRandomTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
	}
		

	// Should not be called
	//SendMessageToPC(oPC, "Reached bottom of GetRandomCreatureInArea");
	return OBJECT_INVALID;
}

//::///////////////////////////////////////////////

void doWildSurgeEffect(object oCaster)
{
	effect eVis = EffectVisualEffect(VFX_FNF_WILD_SURGE);
	float fDuration = RoundsToSeconds(1);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oCaster, fDuration);
}

//:://///////////////////////////////////////////

void handleBanefulDeflector(object oCaster, object oTarget, int nSpellId)
{
	if(nSpellId == SPELL_MAGIC_MISSILE ||
		nSpellId == SPELL_MELFS_ACID_ARROW ||
		nSpellId == SPELL_FLAME_ARROW ||
		nSpellId == SPELL_QUILLFIRE ||
		nSpellId == SPELL_TRAP_ARROW || // thought I'de give this a try don't know if it will work
		nSpellId == SPELL_TRAP_BOLT ||
		nSpellId == SPELL_TRAP_DART ||
		nSpellId == SPELL_TRAP_SHURIKEN)
		{
			int nSpellLvl = JXGetBaseSpellLevel(nSpellId);
			int nSpellSchool = JXGetSpellSchool(nSpellId); 
			effect eAbsorb = EffectSpellLevelAbsorption(9,0,nSpellSchool); //2d2f: absorb the spell
			JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAbsorb,oTarget,3.0);
		
		
			float fRange = JXGetSpellRange(nSpellId);
			object oRandomTarget = GetRandomCreatureInArea(oTarget, oCaster, RADIUS_SIZE_LARGE, TRUE);
			
			if (GetIsObjectValid(oRandomTarget))
			{
			
				location lRandom;
				lRandom = GetLocation(oTarget);
				// seting a delay so the spell effect finishes before firing the return gift
				DelayCommand(3.0,JXCastSpellFromLocationAtObject(lRandom, oRandomTarget, nSpellId, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE));
			}
			
			
		}
		else
		{
			return;
		}
}
//::///////////////////////////////////////////////

void doSurgeNoSpell(object oCaster, float fRadius)
{
	object oPC = GetFirstPC(TRUE);
	int nRand = Random(6);
	int nSpellId;
	
	SetLocalInt(oCaster,"nDoSurgeNoSpell", 1);
	
	DelayCommand(1.0,SetLocalInt(oCaster,"nDoSurgeNoSpell", 0));
	
	object oTarget = GetRandomCreatureInArea(oCaster, 
											oCaster, 
											fRadius, 
											TRUE,
											TRUE);
	// hostile										
	if(spellsIsTarget(oTarget,SPELL_TARGET_ALLALLIES,oCaster) == FALSE)
		{
		nSpellId = SPELL_RANDOM_SPELL_UTILITY_HOSTILE;
	}
	else // friendly
	{
		nSpellId = SPELL_RANDOM_SPELL_UTILITY_FRIENDLY;
	}
	
	//:debug
	//SendMessageToPC(oPC,"doSurge nospell spell id = " + IntToString(nSpellId));
	//SendMessageToPC(oPC,"doSurge nospell caster is = " + GetName(oCaster));
	//SendMessageToPC(oPC,"doSurge nospell target is = " + GetName(oTarget));
	
	// Shazbotian: added this here to fix a bug where glyph of wild magic would modifiy your dweomer selection without your knowledge
	//int iOriginalSpellId = GetLocalInt(oCaster,"nSpellId");

	SetLocalInt(oCaster,"nDoSurgeNoSpellSpellId",nSpellId);
	
	// Shazbotian: the idea here is to restore the original selected dweomer spell after the surge insanity is over
	//DelayCommand(2.0f, SetLocalInt(oCaster,"nSpellId",iOriginalSpellId));
		
	//:2d2f this code is to fix bug, apparently objects can't cast when walking... go fig
	// ... it took me 3 days to figure that out... ouch!
	effect eImmob = EffectCutsceneImmobilize();
	JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmob,oCaster,0.5);
	AssignCommand(oCaster, ClearAllActions());
			
	JXCastSpellFromObjectAtObject(oCaster,
								oTarget,
								nSpellId,
								METAMAGIC_NONE,
								JXGetCasterLevel(oCaster),
								JXGetSpellSaveDC(oCaster),
								TRUE);
}

//::///////////////////////////////////////////////

void RemoveSupernaturalEffectWithSpellId(object oTarget,int nSpellId)
{
	effect eLoop=GetFirstEffect(oTarget);
	
	while (GetIsEffectValid(eLoop))
	{		
		if (GetEffectSpellId(eLoop) == nSpellId)
		{
			RemoveEffect(oTarget,eLoop);
		}
	eLoop=GetNextEffect(oTarget);
	}
}

//::///////////////////////////////////////////////
int GetIsEquipable(object oItem)
{
	if(oItem != OBJECT_INVALID)
	{  
		if(IPGetIsMeleeWeapon(oItem) == TRUE ||
		GetWeaponRanged(oItem) == TRUE ||
		GetBaseItemType(oItem) == BASE_ITEM_AMULET ||
		GetBaseItemType(oItem) == BASE_ITEM_ARMOR ||
		GetBaseItemType(oItem) == BASE_ITEM_BELT ||
		GetBaseItemType(oItem) == BASE_ITEM_BOOTS ||
		GetBaseItemType(oItem) == BASE_ITEM_BRACER ||
		GetBaseItemType(oItem) == BASE_ITEM_CLOAK ||
		GetBaseItemType(oItem) == BASE_ITEM_HELMET ||
		GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD ||
		GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD ||
		GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD ||
		GetBaseItemType(oItem) == BASE_ITEM_RING)
		{
			return TRUE;
		}
		else
		{
			return FALSE;
		}
	}
	else
	{
		return FALSE;
	}
}

//::///////////////////////////////////////////////


int GetCountOfEquipableItems(object oCaster, int nMagicalOnly = TRUE)
{
	object	oItem ;
	int 	i=0;
	int nCount = 0;
	
	while(i<=10) 
	{
		oItem = GetItemInSlot(i, oCaster);
		if(oItem != OBJECT_INVALID && GetIsEquipable(oItem) == TRUE) 
		{
			if(nMagicalOnly == TRUE && GetItemHasProperties(oItem) == TRUE)
			{
				nCount++;
			}
			else
			{
				nCount++;	
			}
		}
		i++;
	}
	
	oItem = GetFirstItemInInventory(oCaster);
	while(GetIsObjectValid(oItem))
	{
		if(oItem != OBJECT_INVALID && GetIsEquipable(oItem) == TRUE) 
		{
			if(nMagicalOnly == TRUE && GetItemHasProperties(oItem) == TRUE)
			{
				nCount++;
			}
			else
			{
				nCount++;	
			}
		}	
	oItem = GetNextItemInInventory(oCaster);	
	}	
	
	return nCount;
}

//::///////////////////////////////////////////////
object GetRandomEquipableItem(object oCaster,int nMagicalOnly = TRUE)
{
	object	oItem ;
	int 	i=0;
	int nNumItemsInInv = GetCountOfEquipableItems(oCaster,nMagicalOnly);
	int nCount;
	int nRandomItemIndex = Random(nNumItemsInInv);	
	
	while(i<=10) 
	{
		oItem = GetItemInSlot(i, oCaster);
		if(oItem != OBJECT_INVALID && GetIsEquipable(oItem) == TRUE) 
		{
			if(nMagicalOnly == TRUE && GetItemHasProperties(oItem) == TRUE)
			{
				nCount++;
				if(nCount == nRandomItemIndex)
				{
					return oItem;
				}
			}
			else
			{
				nCount++;
				if(nCount == nRandomItemIndex)
				{
					return oItem;
				}	
			}
		}
		i++;
	}
	
	oItem = GetFirstItemInInventory(oCaster);
	while(GetIsObjectValid(oItem))
	{
		if(oItem != OBJECT_INVALID && GetIsEquipable(oItem) == TRUE) 
		{
			if(nMagicalOnly == TRUE && GetItemHasProperties(oItem) == TRUE)
			{
				nCount++;
				if(nCount == nRandomItemIndex)
				{
					return oItem;
				}
			}
			else
			{
				nCount++;
				if(nCount == nRandomItemIndex)
				{
					return oItem;
				}	
			}
		}	
	oItem = GetNextItemInInventory(oCaster);	
	}	
	
	return OBJECT_INVALID; // should not be called
}

//::///////////////////////////////////////////////


void forceEquip(object oTarget, object oItem, int nSlot)
{
	if(GetItemInSlot(nSlot,oTarget) != oItem)
	{
		AssignCommand(oTarget,ClearAllActions(TRUE));
		AssignCommand(oTarget,ActionEquipItem(oItem,nSlot));
		DelayCommand(0.5f, forceEquip(oTarget, oItem, nSlot));
	}

/*
	AssignCommand(oTarget,ClearAllActions(TRUE));
	AssignCommand(oTarget,ActionEquipItem(oItem,nSlot));
	while(GetItemInSlot(nSlot,oTarget) != oItem)
	{
		AssignCommand(oTarget,ClearAllActions(TRUE));
		AssignCommand(oTarget,ActionEquipItem(oItem,nSlot));
	}
	*/
}

//::///////////////////////////////////////////////


void forceUnequip(object oTarget, object oItem, int nSlot)
{
	if(GetItemInSlot(nSlot,oTarget) != OBJECT_INVALID)
	{
		AssignCommand(oTarget,ClearAllActions(TRUE));
		AssignCommand(oTarget,ActionDoCommand(ActionUnequipItem(oItem)));
	}
	/*
	AssignCommand(oTarget,ClearAllActions(TRUE));
	AssignCommand(oTarget,ActionDoCommand(ActionUnequipItem(oItem)));
	while(GetItemInSlot(nSlot,oTarget) != OBJECT_INVALID)
	{
		AssignCommand(oTarget,ClearAllActions(TRUE));
		AssignCommand(oTarget,ActionDoCommand(ActionUnequipItem(oItem)));
	}
	*/
}
//::///////////////////////////////////////////////
void forcePutDownItem(object oTarget, object oItem, int nSlot)
{	
	if(GetItemInSlot(nSlot,oTarget) != OBJECT_INVALID)
	{
		AssignCommand(oTarget,ClearAllActions(TRUE));
		AssignCommand(oTarget,ActionDoCommand(ActionUnequipItem(oItem)));
	}
}

//::///////////////////////////////////////////////

string GetSurgeName(int nRand)
{
    string sSurgeName;
    
    if(nRand <= 0)
    {
        sSurgeName = 	"	Spell Automatically Fails	" ;
    }
    else if (nRand > 100)
    {
        sSurgeName = 	"	Spell is cast successfully	" ;
    }
    else
    {    
        switch(nRand)
        {        
            case	1	: sSurgeName = 	"	Wall of Force Appears in front of caster	" ;	break;
            case	2	: sSurgeName = 	"	Caster smells like a skunk for (caster level) rounds	" ;	break;
            case	3	: sSurgeName = 	"	Summons various animals	" ;	break;
            case	4	: sSurgeName = 	"	Caster's clothes itch for 4d6 rounds	" ;	break;
            case	5	: sSurgeName = 	"	Light on caster	" ;	break;
            case	6	: sSurgeName = 	"	Spell affects everyone in 60'	" ;	break;
            case	7	: sSurgeName = 	"	A rainbow appears	" ;	break;
            case	8	: sSurgeName = 	"	A random creature in the area dies	" ;	break;
            case	9	: sSurgeName = 	"	Everyone turns around	" ;	break;
            case	10	: sSurgeName = 	"	Spell explodes in caster's face	" ;	break;
            case	11	: sSurgeName = 	"	Caster becomes allergic to magic items	" ;	break;
            case	12	: sSurgeName = 	"	Gold on caster is destroyed	" ;	break;
            case	13	: sSurgeName = 	"	Caster �reduced�	" ;	break;
            case	14	: sSurgeName = 	"	Caster falls madly in love with target until dispel magic or remove curse is cast	" ;	break;
            case	15	: sSurgeName = 	"	Everyone around you is knocked down	" ;	break;
            case	16	: sSurgeName = 	"	Caster polymorphed into a random form	" ;	break;
            case	17	: sSurgeName = 	"	Colorful bubbles come out of caster's mouth for one turn	" ;	break;
            case	18	: sSurgeName = 	"	A herd of cats appear	" ;	break;
            case	19	: sSurgeName = 	"	Caster surrounded by flames	" ;	break;
            case	20	: sSurgeName = 	"	Caster's feet enlarge	" ;	break;
            case	21	: sSurgeName = 	"	Spell targets caster and target	" ;	break;
            case	22	: sSurgeName = 	"	Caster levitates for 3d6 rounds	" ;	break;
            case	23	: sSurgeName = 	"	Fear on Caster	" ;	break;
            case	24	: sSurgeName = 	"	Caster becomes two-dimensional for 3-10 rounds	" ;	break;
            case	25	: sSurgeName = 	"	Caster gains a phobia of random creature type for 1d4 days	" ;	break;
            case	26	: sSurgeName = 	"	Spells in effect around caster explode violently	" ;	break;
            case	27	: sSurgeName = 	"	Silence 15' on caster	" ;	break;
            case	28	: sSurgeName = 	"	Time Stop, with turns	" ;	break;
            case	29	: sSurgeName = 	"	Magic is dampened. All creatures int he area recieve spell mantles.	" ;	break;
            case	30	: sSurgeName = 	"	Fireworks erupt over caster's head	" ;	break;
            case	31	: sSurgeName = 	"	Spell turns on caster	" ;	break;
            case	32	: sSurgeName = 	"	Caster becomes invisible	" ;	break;
            case	33	: sSurgeName = 	"	Color Spray	" ;	break;
            case	34	: sSurgeName = 	"	Butterflies pour from caster's mouth	" ;	break;
            case	35	: sSurgeName = 	"	Gold is created on the target	" ;	break;
            case	36	: sSurgeName = 	"	Gems shoot from caster's fingertips	" ;	break;
            case	37	: sSurgeName = 	"	Music fills the air	" ;	break;
            case	38	: sSurgeName = 	"	Create Food and Water	" ;	break;
            case	39	: sSurgeName = 	"	Caster becomes undead	" ;	break;
            case	40	: sSurgeName = 	"	One magic item on caster is completely drained	" ;	break;
            case	41	: sSurgeName = 	"	One normal item on caster becomes magical	" ;	break;
            case	42	: sSurgeName = 	"	All nearby weapons temporarily enchanted	" ;	break;
            case	43	: sSurgeName = 	"	Smoke pours from the ears of nearby creatures	" ;	break;
            case	44	: sSurgeName = 	"	Shimmering Lights	" ;	break;
            case	45	: sSurgeName = 	"	Everyone within 30' of caster begins to hiccup	" ;	break;
            case	46	: sSurgeName = 	"	All normal, secret, and magic doors open	" ;	break;
            case	47	: sSurgeName = 	"	Caster and target exchange places	" ;	break;
            case	48	: sSurgeName = 	"	Spell chooses random target	" ;	break;
            case	49	: sSurgeName = 	"	Spell fails but caster is refreshed	" ;	break;
            case	50	: sSurgeName = 	"	Random allies are summoned	" ;	break;
            case	51	: sSurgeName = 	"	Weather changes abruptly	" ;	break;
            case	52	: sSurgeName = 	"	Deafening bang affects all within 60'	" ;	break;
            case	53	: sSurgeName = 	"	Random spell is cast at random target	" ;	break;
            case	54	: sSurgeName = 	"	Gate opens and a creature emerges	" ;	break;
            case	55	: sSurgeName = 	"	Spell functions but shrieks horribly	" ;	break;
            case	56	: sSurgeName = 	"	Spell effectiveness decreases	" ;	break;
            case	57	: sSurgeName = 	"	Spell is reversed	" ;	break;
            case	58	: sSurgeName = 	"	Spell takes on free-willed physical form, casts itself on anything it hits	" ;	break;
            case	59	: sSurgeName = 	"	All nearby weapons glow for 1d4 rounds	" ;	break;
            case	60	: sSurgeName = 	"	Spell becomes irresistible	" ;	break;
            case	61	: sSurgeName = 	"	Spell appears to fail, occurs later	" ;	break;
            case	62	: sSurgeName = 	"	All nearby magic items begin to glow	" ;	break;
            case	63	: sSurgeName = 	"	A mysterious, yet strangely familiar, being of unlimited power appears	" ;	break;
            case	64	: sSurgeName = 	"	Target slowed	" ;	break;
            case	65	: sSurgeName = 	"	All spells in effect around target explode violently	" ;	break;
            case	66	: sSurgeName = 	"	Lightning Bolt cast at target	" ;	break;
            case	67	: sSurgeName = 	"	Target Enlarged	" ;	break;
            case	68	: sSurgeName = 	"	Darkness on target	" ;	break;
            case	69	: sSurgeName = 	"	Plant Growth on target	" ;	break;
            case	70	: sSurgeName = 	"	1d4 clones of target are created for one turn	" ;	break;
            case	71	: sSurgeName = 	"	Fireball on target	" ;	break;
            case	72	: sSurgeName = 	"	Target turned to stone	" ;	break;
            case	73	: sSurgeName = 	"	Spell casts successfully, caster is refreshed	" ;	break;
            case	74	: sSurgeName = 	"	Everyone within 10' of caster Healed	" ;	break;
            case	75	: sSurgeName = 	"	Target becomes dizzy for 2d4 rounds	" ;	break;
            case	76	: sSurgeName = 	"	Target surrounded by flames	" ;	break;
            case	77	: sSurgeName = 	"	Target levitates for 3d6 rounds	" ;	break;
            case	78	: sSurgeName = 	"	Target struck blind for one round per caster level	" ;	break;
            case	79	: sSurgeName = 	"	Charm Monster on target	" ;	break;
            case	80	: sSurgeName = 	"	Every creature within 60' of target becomes drunk for 4-10 rounds	" ;	break;
            case	81	: sSurgeName = 	"	Target's feet enlarge	" ;	break;
            case	82	: sSurgeName = 	"	Rust Monster appears	" ;	break;
            case	83	: sSurgeName = 	"	Target polymorphs into a random form	" ;	break;
            case	84	: sSurgeName = 	"	Target falls madly in love with caster until dispel magic or remove curse is cast	" ;	break;
            case	85	: sSurgeName = 	"	Target changes sex	" ;	break;
            case	86	: sSurgeName = 	"	Small black raincloud forms over target	" ;	break;
            case	87	: sSurgeName = 	"	Stinking Cloud on target	" ;	break;
            case	88	: sSurgeName = 	"	Heavy object falls on target	" ;	break;
            case	89	: sSurgeName = 	"	Target begins sneezing	" ;	break;
            case	90	: sSurgeName = 	"	Spell is cast against every creature within 60' of target	" ;	break;
            case	91	: sSurgeName = 	"	Target's clothes itch for 4d6 rounds	" ;	break;
            case	92	: sSurgeName = 	"	Target's race randomly changes	" ;	break;
            case	93	: sSurgeName = 	"	Target becomes Ethereal	" ;	break;
            case	94	: sSurgeName = 	"	Target Hasted	" ;	break;
            case	95	: sSurgeName = 	"	All cloth on target crumbles to dust	" ;	break;
            case	96	: sSurgeName = 	"	Target sprouts leaves	" ;	break;
            case	97	: sSurgeName = 	"	Target grows a new but useless appendage	" ;	break;
            case	98	: sSurgeName = 	"	Target's skin changes color	" ;	break;
            case	99	: sSurgeName = 	"	Spell is cast over and over for five rounds	" ;	break;
            case	100	: sSurgeName = 	"	Spell's power greatly increased	" ;	break;
            default : sSurgeName = "Invalid Surge" ; break;
        }
    }
    return sSurgeName;
    
}

void RemoveSurgeSelector(object oCaster)
{
    int nCasterLvl = GetLocalInt(oCaster,"nSurgeSelectorCasterLvl");
    int nSurgeSelectorCount = GetLocalInt(oCaster,"nSurgeSelectorCount");
    
    if(nSurgeSelectorCount > (nCasterLvl/5))
    {
        RemoveEffectsFromSpell(oCaster,SPELL_SURGE_SELECTOR);
        DeleteLocalInt(oCaster,"nSurgeSelectorCount");
        DeleteLocalObject(oCaster,"oSurgeSelectorTarget");
        DeleteLocalInt(oCaster,"nSurgeSelectorMeta");
        DeleteLocalInt(oCaster,"nSurgeSelectorMeta");
        DeleteLocalInt(oCaster,"nSurgeSelectorCasterLvl");
        DeleteLocalLocation(oCaster,"nSurgeSelectorLocation");
        DeleteLocalInt(oCaster,"SelectedSurgeOkButton");
        DeleteLocalInt(oCaster,"SelectedSurgeOkButton");
        DeleteLocalInt(oCaster,"nSurgeSelectorRangeType");
        DeleteLocalInt(oCaster,"nSurgeSelectorSpellSaveDC");
        DeleteLocalInt(oCaster,"nHornungsSurgeSelectionMade");
        return;
    }    
    
}

//::///////////////////////////////////////////////

void HandleSurgeSelector(   object oCaster,
                            object oTarget,
                            location lLoc, 
                            int nSpellId,
                            int nMeta,
                            int nRangeType,
                            int nCasterLvl,
                            int nSpellSaveDC,
                            int iSurgeModifier)
{
    //SendMessageToPC(GetFirstPC(),"Handle Surge Selector function entered");
    
    SetLocalObject(oCaster,"oSurgeSelectorTarget",oTarget);
    SetLocalInt(oCaster,"nSurgeSelectorSpellId",nSpellId);
    SetLocalInt(oCaster,"nSurgeSelectorMeta",nMeta);
    SetLocalInt(oCaster,"nSurgeSelectorCasterLvl",nCasterLvl);
    SetLocalLocation(oCaster,"nSurgeSelectorLocation",lLoc);
    SetLocalInt(oCaster,"nSurgeSelectorRangeType",nRangeType);
    SetLocalInt(oCaster,"nSurgeSelectorSpellSaveDC",nSpellSaveDC);
        
        
    int nRand1 = d100(1) + iSurgeModifier;
    int nRand2 = d100(1) + iSurgeModifier;
    
    string sSurgeName1 = GetSurgeName(nRand1);
    string sSurgeName2 = GetSurgeName(nRand2);
    
    SetLocalInt(oCaster,"SelectedSurgeOkButton",nRand1);
    SetLocalInt(oCaster,"SelectedSurgeCancelButton",nRand2);
    
    SetLocalInt(oCaster,"nHornungsSurgeSelectionMade",1);
        
    DisplayMessageBox(  oCaster, // oPC   	- The player object of the player to show this message box to
                    	0,// nMessageStrRef- The STRREF for the Message Box message.
                    	"<color=gold><b>Hornung's Surge Selector</b></color>\n\n"
                        + "Choose a Wild Surge.\n\n"
                        + "1. - " + sSurgeName1 + "\n\n"
                        + "2. - " + sSurgeName2,// sMessage      - The text to display in the message box. Overrides anything indicated by the nMessageStrRef
                    	"gui_2d2f_surge_selector_ok",// sOkCB         - The callback script to call if the user clicks OK, defaults to none. The script name MUST start with 'gui'
                    	"gui_2d2f_surge_selector_cancel",// sCancelCB     - The callback script to call if the user clicks Cancel, defaultsto none. The script name MUST start with 'gui'
                    	TRUE,// bShowCancel   - If TRUE, Cancel Button will appear on the message box.
                    	"SCREEN_MESSAGEBOX_DEFAULT",// sScreenName   - The GUI SCREEN NAME to use in place of the default message box. The default is SCREEN_STRINGINPUT_MESSAGEBOX
                    	0,// nOkStrRef     - The STRREF to display in the OK button, defaults to OK
                    	"1",// sOkString     - The string to show in the OK button. Overrides anything that nOkStrRef indicates if it is not an empty string
                    	0,// nCancelStrRef - The STRREF to dispaly in the Cancel button, defaults to Cancel.
                    	"2"// sCancelString - The string to display in the Cancel button. Overrides anything that nCancelStrRef indicates if it is anything besides empty string
                   	    );
    
    
}

//::///////////////////////////////////////////////

//:: 01a
void JXWZCastAtRandomTarget(object oCaster, object oTarget, int iSpellId)
{
	object oPC = GetFirstPC();
	// The spell doesn't change if its range is personal or touch
	int iRangeType = JXGetSpellRangeType(iSpellId);
//	if ((iRangeType == JX_SPELLRANGE_PERSONAL)
//	 || (iRangeType == JX_SPELLRANGE_TOUCH)
//	 || (iRangeType == JX_SPELLRANGE_INVALID))
//	{
//		//SendMessageToPCByStrRef(oCaster, 17079479);
//		return;
//	}
	if(iRangeType == JX_SPELLRANGE_INVALID) {
		return;
	}
	
	//SendMessageToPC(oPC, "JXZRandomTarget ORIGINAL target name: " + GetName(oTarget) + " tag: " + GetTag(oTarget));

	object oRandomTarget;
	float fRange = JXGetSpellRange(iSpellId);
	if(fRange < 2.0f) {
		// this one is for the touch and personal spells
		oRandomTarget = GetRandomCreatureInArea(oCaster, oTarget, 20.0f);
	} else {
		oRandomTarget = GetRandomCreatureInArea(oCaster, oTarget, fRange * 2);
	}
	
	// New target found in the spell range
	if (GetIsObjectValid(oRandomTarget))
	{
		
		//SendMessageToPC(oPC, "JXZRandomTarget name: " + GetName(oRandomTarget) + " tag: " + GetTag(oRandomTarget));
		// Relocate the spell origin if the caster is too far from the target
		float fDistance = GetDistanceBetween(oCaster, oRandomTarget);
		location lRandom;
		if (fDistance > fRange)
		{
			vector vCaster = GetPosition(oCaster);
			vector vRandomTarget = GetPosition(oRandomTarget);
			vector vNewSource = Vector(vCaster.x + (vRandomTarget.x - vCaster.x) / 2,
									   vCaster.y + (vRandomTarget.y - vCaster.y) / 2);
			lRandom = Location(GetArea(oCaster), vNewSource, 0.0f);
		}
		// Spell origin is caster location if target is in spell range
		else
			lRandom = GetLocation(oCaster);

		// Cast the spell at the random target
		//SendMessageToPCByStrRef(oCaster, 17079481);
		JXCastSpellFromLocationAtObject(lRandom, oRandomTarget, iSpellId, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE);
	} else {
		SendMessageToPC(oCaster, "No valid target found");
	}
}


//::///////////////////////////////////////////////

//:: 01b
void JXWZCastAtRandomLocation(object oCaster, int iSpellId)
{
	// The spell doesn't change if its range is personal or touch
	int iRangeType = JXGetSpellRangeType(iSpellId);
	if ((iRangeType == JX_SPELLRANGE_PERSONAL)
	 || (iRangeType == JX_SPELLRANGE_TOUCH)
	 || (iRangeType == JX_SPELLRANGE_INVALID))
	{
		//FloatingTextStringOnCreature("You get a strange feeling for a moment but it passes", oCaster);
		return;
	}

	// Get a random location in the spell range
	float fRange = JXGetSpellRange(iSpellId);
	location lTo = GetRandomLocation(GetArea(oCaster), oCaster, fRange);

	// Cast the spell at the random location
	JXCastSpellFromLocationAtLocation(GetLocation(oCaster), lTo, iSpellId, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE);
}
//::///////////////////////////////////////////////

//:: 03
void WmMenagerieLocation(location lLoc)
{	
	object oChick = CreateObject(OBJECT_TYPE_CREATURE, "c_chicken", lLoc, TRUE);
	AssignCommand(oChick, ActionRandomWalk());
	object oCat = CreateObject(OBJECT_TYPE_CREATURE, "c_cat", lLoc, TRUE);
	AssignCommand(oCat, ActionRandomWalk());
	object oRab = CreateObject(OBJECT_TYPE_CREATURE, "c_rabbit", lLoc, TRUE);
	AssignCommand(oRab, ActionRandomWalk());
	object oWeas = CreateObject(OBJECT_TYPE_CREATURE, "c_weasel", lLoc, TRUE);
	AssignCommand(oWeas, ActionRandomWalk());
	object oDeer =  CreateObject(OBJECT_TYPE_CREATURE, "c_deerfemale", lLoc, TRUE);
	AssignCommand(oDeer, ActionRandomWalk());
	object oCow = CreateObject(OBJECT_TYPE_CREATURE, "c_cow", lLoc, TRUE);
	AssignCommand(oCow, ActionRandomWalk());
	object oPig = CreateObject(OBJECT_TYPE_CREATURE, "c_pig", lLoc, TRUE);
	AssignCommand(oPig, ActionRandomWalk());
	
	effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
	JXApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc);
	
}

//::///////////////////////////////////////////////

//::31
void JXWZTurnSpell(object oCaster, location lTo, int iSpellId)
{
	// The spell doesn't turn back if its range is personal
	int iRangeType = JXGetSpellRangeType(iSpellId);
	if ((iRangeType == JX_SPELLRANGE_PERSONAL)
	 || (iRangeType == JX_SPELLRANGE_INVALID))
	{
		//SendMessageToPCByStrRef(oCaster, 17079479);
		return;
	}

	// Cast the spell back to the original caster

	JXCastSpellFromLocationAtObject(lTo, oCaster, iSpellId, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE, oCaster);
}

// Used to turn a spell from a caster back on themselves, by making a copy of themselves to shoot it at them
void ShazTurnSpell(object oCaster, location lTo, int iSpellId)
{
	// The spell doesn't turn back if its range is personal
	int iRangeType = JXGetSpellRangeType(iSpellId);
	if ((iRangeType == JX_SPELLRANGE_PERSONAL)
	 || (iRangeType == JX_SPELLRANGE_INVALID))
	{
		//SendMessageToPCByStrRef(oCaster, 17079479);
		return;
	}
	
	object oCasterCopy = CopyObject(oCaster, lTo);
	SetCommandable(FALSE, oCasterCopy);
	ClearEventHandlers(oCasterCopy);

	// Cast the spell back to the original caster
	JXCastSpellFromObjectAtObject(oCasterCopy, oCaster, iSpellId, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE);
	AssignCommand(oCasterCopy, SetCommandable(FALSE));
	SetIsDestroyable(TRUE,FALSE,FALSE);
	DestroyObject(oCasterCopy, 5.0f);
}

//::///////////////////////////////////////////////

//::44
void JXWZCastShimmeringLights(object oCaster)
{
	location lCaster = GetLocation(oCaster);
	int iCasterLevel = JXGetCasterLevel(oCaster);
	int iSpellSaveDC = 10 + iCasterLevel;

	SendMessageToPCByStrRef(oCaster, 17079483);
	JXCastSpellFromLocationAtLocation(lCaster,
									  lCaster,
									  SPELL_SHIMMER_LIGHTS,
									  METAMAGIC_NONE,
									  iCasterLevel,
									  iSpellSaveDC,
									  TRUE);
}

//::///////////////////////////////////////////////

//::100
void JXWZIncreaseSpellStrength(object oCaster)
{
	int nCasterLvl = JXGetCasterLevel(oCaster);
	int nTimesTwo = nCasterLvl * 2;
	JXSetCasterLevel(nTimesTwo);
	JXSetSpellSaveDC(JXGetSpellSaveDC(oCaster) + 2, oCaster);
}

void MusicFillsAir(object oCaster)
{
	int nRand = Random(8);
	float fMusicTime = GetLocalFloat(oCaster,"fMusicTime");
	
	// if music is already playing return
	if(fMusicTime > 0.0)
	{
		return;
	}
		
	if(nRand == 0)
	{
		SetLocalFloat(oCaster,"fMusicTime", 49.0);
		DelayCommand(49.0,DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("Moonlight"));
	}
	else if (nRand == 1)
	{
		SetLocalFloat(oCaster,"fMusicTime", 55.0);
		DelayCommand(55.0, DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("fortuna"));
	}
	else if (nRand == 2)
	{
		SetLocalFloat(oCaster,"fMusicTime", 40.0);
		DelayCommand(40.0, DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("symphony5"));
	}
	else if (nRand == 3)
	{
		SetLocalFloat(oCaster,"fMusicTime", 32.0);
		DelayCommand(32.0, DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("badinerie"));
	}
	else if (nRand == 4)
	{
		SetLocalFloat(oCaster,"fMusicTime", 50.0);
		DelayCommand(50.0, DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("bolero"));
	}
	else if (nRand == 5)
	{
		SetLocalFloat(oCaster,"fMusicTime", 28.0);
		DelayCommand(28.0, DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("messiah"));
	}
	else if (nRand == 6)
	{
		SetLocalFloat(oCaster,"fMusicTime", 50.0);
		DelayCommand(50.0, DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("symphony9"));
	}
	else if (nRand == 7)
	{
		SetLocalFloat(oCaster,"fMusicTime", 76.0);
		DelayCommand(76.0, DeleteLocalFloat(oCaster,"fMusicTime"));
		
		AssignCommand(oCaster,PlaySound("tocatta"));
	}	
}

void ChangeSkinColor(object oTarget)
{
	int nRand = Random(7);
	int nColor;
	
	switch(nRand)
	{
		case 0 : nColor = VFX_DUR_SKIN_BLACK; break;
		case 1 : nColor = VFX_DUR_SKIN_BLUE; break;
		case 2 : nColor = VFX_DUR_SKIN_GREEN; break;
		case 3 : nColor = VFX_DUR_SKIN_ORANGE; break;
		case 4 : nColor = VFX_DUR_SKIN_PURPLE; break;
		case 5 : nColor = VFX_DUR_SKIN_RED; break;
		case 6 : nColor = VFX_DUR_SKIN_YELLOW; break;
	
		default : break;
	}
	
	//duration 1 to 4 days
	float fDur = HoursToSeconds(Random(36) + 24);
	//float fDur = RoundsToSeconds(10);
	
	
	int	nTempSpellId = SURGE_TEMP_SPELLID_SKIN_COLOR;
	
	
		
	effect eVis = EffectVisualEffect(nColor);
	eVis = SupernaturalEffect(eVis);
	//eVis = SetEffectSpellId(eVis, nSpellId);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,SetEffectSpellId(eVis, nTempSpellId),oTarget);
	SetLocalInt(oTarget,"nColorChangeId",nTempSpellId);
	//DelayCommand(fDur,RemoveSupernaturalEffectWithSpellId(oTarget,nSpellId));


}
//////////////////////////////////////////////////
void SmokeyEars(object oCaster, int iShieldSuccess)
{
	location lTarget = GetLocation(oCaster);
	float fDur = TurnsToSeconds(1);
	effect eVis = EffectVisualEffect(VFX_DUR_SMOKEY_EARS);
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,FeetToMeters(60.0),lTarget,FALSE,OBJECT_TYPE_CREATURE);
	
	//:2d2f skip the caster if protected from surge
	if(iShieldSuccess != 0 && oTarget == oCaster)
	{
	oTarget = GetNextObjectInShape(SHAPE_SPHERE,FeetToMeters(60.0),lTarget,FALSE,OBJECT_TYPE_CREATURE);
	}
	
	while(GetIsObjectValid(oTarget))
	{	
		JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,fDur);
		
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,FeetToMeters(60.0),lTarget,FALSE,OBJECT_TYPE_CREATURE);
	
		if(iShieldSuccess != 0 && oTarget == oCaster)
		{
			oTarget = GetNextObjectInShape(SHAPE_SPHERE,FeetToMeters(60.0),lTarget,FALSE,OBJECT_TYPE_CREATURE);
		}
	}

}

//////////////////////////////////////////////////

int GetItemHasProperties(object oItem)
{
	if(GetIsItemPropertyValid(GetFirstItemProperty(oItem)))
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

//////////////////////////////////////////////////

object DrainItem(object oCaster)
{
	//object oItem = GetRandomInventoryWeaponOrArmor(oCaster, TRUE);
	object oItem = GetRandomEquipableItem(oCaster,TRUE);
	// check if it is a plot item.
	// it would be very very bad to drain the silver sword of Gith
	if(GetPlotFlag(oItem) != TRUE && GetIsObjectValid(oItem) == TRUE)
	{
		IPRemoveAllItemProperties(oItem,DURATION_TYPE_PERMANENT);
		return oItem;
	}
	else
	{
		return OBJECT_INVALID;
	}
}

//////////////////////////////////////////////////

object EnhanceItem(object oCaster)
{
	//object oItem = GetRandomInventoryWeaponOrArmor(oCaster, FALSE);
	object oItem = GetRandomEquipableItem(oCaster,FALSE);
	// check if it is a plot item.
	if(GetPlotFlag(oItem) != TRUE && GetIsObjectValid(oItem) == TRUE)
	{
		int nBonus = d3(1);
		int nExistingBonus;
		
		if(GetWeaponRanged(oItem) == TRUE)
		{
		
			itemproperty ip = GetFirstItemProperty(oItem);

			if(GetItemPropertyType(ip) != ITEM_PROPERTY_ATTACK_BONUS && 
					GetIsItemPropertyValid(ip) == TRUE)
			{
				while(GetItemPropertyType(ip) != ITEM_PROPERTY_ATTACK_BONUS && 
					GetIsItemPropertyValid(ip) == TRUE)
				{
					ip = GetNextItemProperty(oItem);
				}
			}		
		
			if (GetItemPropertyType(ip) == ITEM_PROPERTY_ATTACK_BONUS && 
					GetIsItemPropertyValid(ip) == TRUE)
        	{
            	nExistingBonus = GetItemPropertyCostTableValue(ip);
				nBonus = nBonus + nExistingBonus;
       		}
		
			IPSafeAddItemProperty(oItem,
								ItemPropertyAttackBonus(nBonus),
								0.0,
								X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);								
		
		}
		else if(IPGetIsMeleeWeapon(oItem) == TRUE)
		{
			nExistingBonus = IPGetWeaponEnhancementBonus(oItem);
			if(nExistingBonus > 0)
			{
				nBonus = nBonus + nExistingBonus;
				IPUpgradeWeaponEnhancementBonus(oItem,nBonus);
			}
			else
			{
				IPSafeAddItemProperty(oItem,
								ItemPropertyEnhancementBonus(nBonus),
								0.0,
								X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);				
			}
		
		}
		else
		{
			itemproperty ip = GetFirstItemProperty(oItem);

			if(GetItemPropertyType(ip) != ITEM_PROPERTY_AC_BONUS && 
					GetIsItemPropertyValid(ip) == TRUE)
			{
				while(GetItemPropertyType(ip) != ITEM_PROPERTY_AC_BONUS && 
					GetIsItemPropertyValid(ip) == TRUE)
				{
					ip = GetNextItemProperty(oItem);
				}
			}		
		
			if (GetItemPropertyType(ip) == ITEM_PROPERTY_AC_BONUS && 
					GetIsItemPropertyValid(ip) == TRUE)
        	{
            	nExistingBonus = GetItemPropertyCostTableValue(ip);
				nBonus = nBonus + nExistingBonus;
       		}
		
			IPSafeAddItemProperty(oItem,
								ItemPropertyACBonus(nBonus),
								0.0,
								X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);		
		
		}
		
		return oItem;
	}
	else
	{
		return OBJECT_INVALID;
	}

}

//////////////////////////////////////////////////

void EnhanceAllNearWeapons(object oCaster,int iShieldSuccess)
{
	location lTarget = GetLocation(oCaster);
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_MAGIC_WEAPON );
	
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_COLOSSAL,lTarget,FALSE,OBJECT_TYPE_CREATURE);
	
	//:2d2f skip the caster if protected from surge
	if(iShieldSuccess != 0 && oTarget == oCaster)
	{
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_COLOSSAL,lTarget,FALSE,OBJECT_TYPE_CREATURE);
	}
	
	while(GetIsObjectValid(oTarget))
	{
		//SendMessageToPC(GetFirstPC(), "Target = " + GetName(oTarget));
		object oItem1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND ,oTarget);
		object oItem2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND ,oTarget);
		
		if(GetIsObjectValid(oItem1) == TRUE)
		{
			if(GetWeaponRanged(oItem1) == TRUE)
			{
				IPSafeAddItemProperty(oItem1,
								ItemPropertyAttackBonus(2),
								TurnsToSeconds(1),
								X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			}
			else
			{
				IPSafeAddItemProperty(oItem1,
								ItemPropertyEnhancementBonus(2),
								TurnsToSeconds(1),
								X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			
			}
			
			JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, TurnsToSeconds(1));
        }
		if(GetIsObjectValid(oItem2) == TRUE)
		{
			IPSafeAddItemProperty(oItem1,
								ItemPropertyEnhancementBonus(2),
								TurnsToSeconds(1),
								X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		}
		if(GetIsObjectValid(oItem1) == TRUE || GetIsObjectValid(oItem2) == TRUE)
		{
			JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, TurnsToSeconds(1));
        
		}
	
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_COLOSSAL,lTarget,FALSE,OBJECT_TYPE_CREATURE);
		
		//:2d2f skip the caster if protected from surge
		if(iShieldSuccess != 0 && oTarget == oCaster)
		{
			oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_COLOSSAL,lTarget,FALSE,OBJECT_TYPE_CREATURE);
		}
		
		//SendMessageToPC(GetFirstPC(), "This is a loop!");
		
	}

}

//////////////////////////////////////////////////

itemproperty PrivateChooseRandomItemGlow()
{
	int nBright;
	int nColor;
		
	int nRandBright = Random(4);
	int nRandColor = Random(7);
	
	switch(nRandBright)
	{
		case 0 : nBright = IP_CONST_LIGHTBRIGHTNESS_BRIGHT; break;
		case 1 : nBright = IP_CONST_LIGHTBRIGHTNESS_DIM; break;
		case 2 : nBright = IP_CONST_LIGHTBRIGHTNESS_LOW; break;
		case 3 : nBright = IP_CONST_LIGHTBRIGHTNESS_NORMAL; break;
		default : break;
	}
	switch(nRandColor)
	{
		case 0 : nColor = IP_CONST_LIGHTCOLOR_BLUE; break;
		case 1 : nColor = IP_CONST_LIGHTCOLOR_GREEN; break;
		case 2 : nColor = IP_CONST_LIGHTCOLOR_ORANGE; break;
		case 3 : nColor = IP_CONST_LIGHTCOLOR_PURPLE; break;
		case 4 : nColor = IP_CONST_LIGHTCOLOR_RED; break;
		case 5 : nColor = IP_CONST_LIGHTCOLOR_WHITE; break;
		case 6 : nColor = IP_CONST_LIGHTCOLOR_YELLOW; break;
		default : break;
	}
	
	
	return ItemPropertyLight(nBright,nColor);
}

//////////////////////////////////////////////////

void AllWeaponsGlow(object oCaster)
{
	location lTarget = GetLocation(oCaster);
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_VAST,lTarget,FALSE,OBJECT_TYPE_CREATURE | OBJECT_TYPE_ITEM);
	
	while(GetIsObjectValid(oTarget))
	{
		object oItem1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND ,oTarget);
		object oItem2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND ,oTarget);
		object oItem3 = GetFirstItemInInventory(oTarget);
		
		if(GetIsObjectValid(oItem1) == TRUE)
		{
			IPSafeAddItemProperty(oItem1,
								PrivateChooseRandomItemGlow(),
								RoundsToSeconds(d4(1)),
								X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		
		}
		if(GetIsObjectValid(oItem2) == TRUE)
		{
			IPSafeAddItemProperty(oItem2,
								PrivateChooseRandomItemGlow(),
								RoundsToSeconds(d4(1)),
								X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		
		}	
		
		while(GetIsObjectValid(oItem3) == TRUE)
		{
			if(IPGetIsMeleeWeapon(oItem3) == TRUE || GetWeaponRanged(oItem3))
			{
				IPSafeAddItemProperty(oItem3,
								PrivateChooseRandomItemGlow(),
								RoundsToSeconds(d4(1)),
								X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			
			}
		
		oItem3 = GetNextItemInInventory(oTarget);
		//SendMessageToPC(GetFirstPC(), "This is a sub-loop loop!");
		}		
		
	oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_VAST,lTarget,FALSE,OBJECT_TYPE_CREATURE | OBJECT_TYPE_ITEM);
	//SendMessageToPC(GetFirstPC(), "This is a loop!");
	}	
}

//////////////////////////////////////////////////

void AllMagicItemsGlow(object oCaster)
{
	location lTarget = GetLocation(oCaster);
	object oItem;
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_VAST,lTarget,FALSE,OBJECT_TYPE_CREATURE | OBJECT_TYPE_ITEM);
		
	while(GetIsObjectValid(oTarget))
	{
		int i = 0;
		while(i<=10) 
		{
			oItem = GetItemInSlot(i, oTarget);
			if(oItem != OBJECT_INVALID) 
			{
				if(GetItemHasProperties(oItem) == TRUE)
				{
					IPSafeAddItemProperty(oItem,
								PrivateChooseRandomItemGlow(),
								HoursToSeconds(48 + Random(336)),
								X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
				}
			}
			i++;
		}
		
		oItem = GetFirstItemInInventory(oTarget);
		while(GetIsObjectValid(oItem))
		{
			if(GetItemHasProperties(oItem) == TRUE)
			{
				IPSafeAddItemProperty(oItem,
									PrivateChooseRandomItemGlow(),
									HoursToSeconds(48 + Random(336)),
									X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			}		
		oItem = GetNextItemInInventory(oTarget);
		//SendMessageToPC(GetFirstPC(), "This is a sub-loop loop!");
		}
	
	oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_VAST,lTarget,FALSE,OBJECT_TYPE_CREATURE | OBJECT_TYPE_ITEM);
	//SendMessageToPC(GetFirstPC(), "This is a loop!");
	}
}

//////////////////////////////////////////////////

void AboutFace(object oCaster,int iShieldSuccess)
{
	float fRadius = 100.0; //this is a really big area
	object oTarget = GetFirstObjectInShape(SHAPE_CUBE,fRadius,GetLocation(oCaster),FALSE,OBJECT_TYPE_CREATURE);
		
	if(iShieldSuccess != 0 && oTarget == oCaster)
	{		
		oTarget = GetNextObjectInShape(SHAPE_CUBE,fRadius,GetLocation(oCaster),FALSE,OBJECT_TYPE_CREATURE);
	}
			
	while(GetIsObjectValid(oTarget))
	{
		float fFacing = GetFacing(oTarget);
		float fNewFacing;
		
		if(fFacing > 180.0)
		{
			fNewFacing = fFacing - 180.0;
		}
		else
		{
			fNewFacing = fFacing + 180.0;
		}
		
		AssignCommand(oTarget, ClearAllActions());
		AssignCommand(oTarget, SetFacing(fNewFacing));
				
		oTarget = GetNextObjectInShape(SHAPE_CUBE,fRadius,GetLocation(oCaster),FALSE,OBJECT_TYPE_CREATURE);
			
		if(iShieldSuccess != 0 && oTarget == oCaster)
		{
			oTarget = GetNextObjectInShape(SHAPE_CUBE,fRadius,GetLocation(oCaster),FALSE,OBJECT_TYPE_CREATURE);
		}
	}
}

//////////////////////////////////////////////////

void Shrieker(location lOriginalTarget, object oCaster, int iShieldSuccess)
{
	//location lTarget = GetLocation(oTarget);
	//object oOriginalTarget = oTarget;
	//float fRadius = 100.0; //this is a really big area
	float fRadius = 75.0; // shaz: now that they actually respond, i turned it down a bit
	
	object oPC = GetFirstPC();
	//SendMessageToPC("Shrieker! 
	
	effect eVis = EffectVisualEffect(VFX_FNF_SHRIEKER);
	//effect eVis = EffectVisualEffect(VFX_FNF_FIREBALL);
	//JXApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis,lOriginalTarget,RoundsToSeconds(1));
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lOriginalTarget);
	//DelayCommand(3.0,AssignCommand(oTarget,PlaySound("2d2f_shreak")));
	
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lOriginalTarget,FALSE,OBJECT_TYPE_CREATURE);
	
	if(iShieldSuccess != 0 && oTarget == oCaster)
	{
		GetNextObjectInShape(SHAPE_SPHERE,fRadius,lOriginalTarget,FALSE,OBJECT_TYPE_CREATURE);
	}	
		
	while(GetIsObjectValid(oTarget))
	{
		//this should alert the target that something happened , and they may come looking
		//SignalEvent(oTarget,EventSpellCastAt(oTarget,SPELL_MAGIC_MISSILE, TRUE));
		if(GetIsEnemy(oTarget, oCaster) && !GetIsInCombat(oTarget)) {
			//AssignCommand(oTarget, DetermineCombatRound(oCaster));
			// Shaz: should we have them sprint to the sound or walk there? Walking seems to make more sense, and looks a little cooler. ;-)
			AssignCommand(oTarget, ActionMoveToLocation(lOriginalTarget, FALSE));
		}
	
		float fDist = GetDistanceBetweenLocations(lOriginalTarget,GetLocation(oTarget));
		if(fDist < 10.0)
		{
		float fDur = RoundsToSeconds(d3(1));
		effect eDeaf = EffectDeaf();
		JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,fDur);
		}
				
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lOriginalTarget,FALSE,OBJECT_TYPE_CREATURE);
		if(iShieldSuccess != 0 && oTarget == oCaster)
		{
		GetNextObjectInShape(SHAPE_SPHERE,fRadius,lOriginalTarget,FALSE,OBJECT_TYPE_CREATURE);
		}
		
	}
}

//////////////////////////////////////////////////

void RandomLimb(object oTarget)
{
	
	int nTempSpellId = SURGE_TEMP_SPELLID_RANDOM_LIMB;
	
	int nBody;	
	int nRand = Random(8);
	
	switch(nRand)
	{
		case 0 : nBody = VFX_DUR_BEAR_MUZ; break;
		case 1 : nBody = VFX_DUR_CHICKEN_LEG; break;
		case 2 : nBody = VFX_DUR_F_HAND; break;
		case 3 : nBody = VFX_DUR_MIND_F_MOUTH; break;
		case 4 : nBody = VFX_DUR_SPIDER_LEG; break;
		case 5 : nBody = VFX_DUR_TENTICLE; break;
		case 6 : nBody = VFX_DUR_WING; break;
		case 7 : nBody = VFX_DUR_UMBER_ARM; break;
		default : break;
	}
	
	effect eVis = EffectVisualEffect(nBody);
	effect eChr = EffectAbilityDecrease(ABILITY_CHARISMA,1);
	effect eLink = EffectLinkEffects(eVis,eChr);
	eLink = SupernaturalEffect(eLink);
	//eLink = SetEffectSpellId(eLink,nSpellId);
		
	JXApplyEffectToObject(DURATION_TYPE_PERMANENT,SetEffectSpellId(eLink,nTempSpellId),oTarget);
	SetLocalInt(oTarget,"nRandomLimbId",nTempSpellId);
	//DelayCommand(fDur,RemoveSupernaturalEffectWithSpellId(oTarget,nSpellId));
}

//////////////////////////////////////////////////

void PrivateTinyLightning(object oTarget)
{
	location lTarget = GetLocation(oTarget);
	float fRadius = FeetToMeters(3.0);
	float fDelay1 = 5.0; // lightning hit delay
	effect eVis = EffectVisualEffect(VFX_DUR_TINY_LIGHTNING);
	effect eVis2 = EffectVisualEffect(VFX_DUR_LIGHTNING_THUND_SOUND);
	effect eVis3 = EffectVisualEffect(VFX_DUR_LIGHTNING_HIT_SOUND);
	JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oTarget,RoundsToSeconds(3));
	DelayCommand(fDelay1,JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,RoundsToSeconds(2)));
	DelayCommand(fDelay1,JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis3,oTarget,RoundsToSeconds(2)));
	
	object oTarget1 = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);

	while(GetIsObjectValid(oTarget1))
	{
		location lTarget2 = GetLocation(oTarget1);
		float fDist = GetDistanceBetweenLocations(lTarget,lTarget2);
		int nDamMult = 4 - FloatToInt(fDist*3.04);
		int nDam = d4(nDamMult);
		effect eDam = EffectDamage(nDam,DAMAGE_TYPE_ELECTRICAL);
		DelayCommand(fDelay1,JXApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oTarget1));
	oTarget1 = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
	}
}

//////////////////////////////////////////////////

void SmallRainCloud(object oTarget)
{
	location lTarget = GetLocation(oTarget);
	object oVisPlace = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lTarget, FALSE, "jx_ipoint_caster");
	DestroyObject(oVisPlace,TurnsToSeconds(6));
	float fDelay1 = 18.0; // first lightning strike
	float fDelay2 = 6.0; // thunder sound onset
	float fDelay3 = 9.0; // rain sound onset
	effect eVis = EffectVisualEffect(VFX_DUR_SMALL_RAINCLOUD);
	eVis = SupernaturalEffect(eVis);
	effect eVis2 = EffectVisualEffect(VFX_DUR_CLOUD_THUND_SOUND);
	effect eVis3 = EffectVisualEffect(VFX_DUR_CLOUD_RAIN_SOUND);
	eVis2 =  SupernaturalEffect(eVis2);
	JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oVisPlace,TurnsToSeconds(6));
	DelayCommand(fDelay2,JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oVisPlace,RoundsToSeconds(2)));
	DelayCommand(fDelay3,JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis3,oVisPlace,TurnsToSeconds(6) - fDelay1));
		
	DelayCommand(fDelay1,PrivateTinyLightning(oVisPlace));
	
	int i;
	for(i = 0; i < 6; i++)
	{
		int nRand = Random(6);
		float fRandDelay = TurnsToSeconds(i) + RoundsToSeconds(nRand) + fDelay1;
		DelayCommand(fRandDelay,PrivateTinyLightning(oVisPlace));
	}
}


//////////////////////////////////////////////////

void AOEKnockdown(object oCaster)
{
	float fRadius = 22.5; // 68 feet
	location lTarget = GetLocation(oCaster);
	effect eVis = EffectVisualEffect(VFX_DUR_AOE_KNOCKDOWN);
	JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oCaster,RoundsToSeconds(1));

	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
	if(oTarget == oCaster)
	{
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
	}
	
	while(GetIsObjectValid(oTarget))
	{
		effect eKnock = EffectKnockdown();
		
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnock,oTarget,6.0);
		
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
		if(oTarget == oCaster)
		{
			oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
		}
	}
}


//////////////////////////////////////////////////

void ARainbowAndALeprichaun(object oCaster)
{
	float fDur = TurnsToSeconds(3);
	location lTarget = GetLocation(oCaster);
	object oVisPlace = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lTarget, FALSE, "jx_ipoint_caster");
	DestroyObject(oVisPlace,fDur);
	location lLoc = GetRandomLocation(GetArea(oCaster),oCaster,3.0);
	object oLep = CreateObject(OBJECT_TYPE_CREATURE, "c_leprichaun", lLoc, TRUE);
	DestroyObject(oLep,fDur);
	effect eVis = EffectVisualEffect(VFX_DUR_SA_RAINBOW_MED);
	JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oVisPlace,fDur);
	
	AssignCommand(oLep,ClearAllActions());
	ChangeToStandardFaction(oLep,STANDARD_FACTION_DEFENDER);
	AssignCommand(oLep,SetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE,TRUE));
	AssignCommand(oLep,SpeakString("You ain't gettin' me GOLD!!!",TALKVOLUME_SHOUT));
	effect eInv = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	JXApplyEffectToObject(DURATION_TYPE_PERMANENT,eInv,oLep);
	AssignCommand(oLep,ActionMoveAwayFromObject(oCaster,TRUE,45.0));
	
	int i;
	for(i = 0; i < 12; i++)
	{
		float fDelay = RoundsToSeconds(i) / 2.0;
		//ActionUseTalentOnObject(tTalent,oLep);
		DelayCommand(fDelay,AssignCommand(oLep,ActionMoveAwayFromObject(oCaster,TRUE,45.0)));
	}
	ChangeToStandardFaction(oLep,STANDARD_FACTION_HOSTILE);
	DelayCommand(RoundsToSeconds(7),
				AssignCommand(oLep,SetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE,TRUE)));
}

//////////////////////////////////////////////////

void ChangeWeather()
{
	object oArea = GetArea(GetFirstPC());
	location lTarget = GetCenterPointOfArea(oArea);
	float fDur = HoursToSeconds(1);
	object oVisPlace = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lTarget, FALSE, "jx_ipoint_caster");
	DestroyObject(oVisPlace,fDur);
	
	effect eVis = EffectVisualEffect(VFX_DUR_CLOUD_COVER);
	eVis = SupernaturalEffect(eVis);
	JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oVisPlace,fDur);
	
	int nRand = d2(1);
	if(nRand == 1)
	{
		SetWeather(oArea,WEATHER_TYPE_RAIN,WEATHER_POWER_STORMY);
	}
	else if(nRand == 2)
	{
		SetWeather(oArea,WEATHER_TYPE_INVALID,WEATHER_POWER_OFF);
		effect eVis2 = EffectVisualEffect(VFX_DUR_SNOWFALL);
		JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oVisPlace,fDur);
		SetWeather(oArea,WEATHER_TYPE_SNOW,WEATHER_POWER_STORMY);
	}
	
	
	DelayCommand(fDur,SetWeather(oArea,WEATHER_TYPE_INVALID,WEATHER_POWER_OFF));
}


//////////////////////////////////////////////////

void YouHaveStoppedBreathing(object oCaster)
{
	
	int	nTempSpellId = SURGE_TEMP_SPELLID_ZOMBIFIED;
	
	
	effect eVis = EffectVisualEffect(VFX_DUR_ZOMBIFIED);
	eVis = SupernaturalEffect(eVis);
	//eVis = SetEffectSpellId(eVis,nSpellId);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,SetEffectSpellId(eVis,nTempSpellId),oCaster);
	
	object oUndeadProps = CreateItemOnObject("nw_it_creitemunh",oCaster);
	//object oUndeadProps = CreateItemOnObject("nw_it_creitemunf",oCaster);
	//object oUndeadProps = CreateItemOnObject("n2_it_creitem008",oCaster);
		
	AssignCommand(oCaster,ClearAllActions(TRUE));
	AssignCommand(oCaster,ActionEquipItem(oUndeadProps,INVENTORY_SLOT_CARMOUR));
	DelayCommand(1.0,forceEquip(oCaster, oUndeadProps, INVENTORY_SLOT_CARMOUR));
	DelayCommand(2.0,forceEquip(oCaster, oUndeadProps, INVENTORY_SLOT_CARMOUR));
	DelayCommand(3.0,forceEquip(oCaster, oUndeadProps, INVENTORY_SLOT_CARMOUR));
	
	SetLocalInt(oCaster,"nZombified", nTempSpellId);


}

void Fireworks(object oCaster)
{
	effect eVis1 = EffectVisualEffect(VFX_DUR_FIREWORKS);
	effect eVis2 = EffectVisualEffect(VFX_STREAMER_SPARKLER);
	effect eSound1 = EffectVisualEffect(VFX_DUR_FIREWORKS_BOOM_1);
	effect eSound2 = EffectVisualEffect(VFX_DUR_FIREWORKS_BOOM_2);
	effect eSound3 = EffectVisualEffect(VFX_DUR_FIREWORKS_BOOM_3);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis1,oCaster,8.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oCaster,8.0);
	
	DelayCommand(2.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound1,oCaster,6.0));
	DelayCommand(2.5f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound2,oCaster,6.0));
	DelayCommand(3.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound3,oCaster,6.0));
	
	DelayCommand(3.2f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound1,oCaster,6.0));
	DelayCommand(3.8f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound2,oCaster,6.0));
	DelayCommand(3.5f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound3,oCaster,6.0));
	
	DelayCommand(4.3f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound1,oCaster,6.0));
	DelayCommand(4.8f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound2,oCaster,6.0));
	DelayCommand(4.6f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound3,oCaster,6.0));
	
	DelayCommand(5.7f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound1,oCaster,6.0));
	DelayCommand(5.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound2,oCaster,6.0));
	DelayCommand(5.4f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound3,oCaster,6.0));
	
	DelayCommand(6.3f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound1,oCaster,6.0));
	DelayCommand(6.9f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound2,oCaster,6.0));
	DelayCommand(6.2f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound3,oCaster,6.0));
	
	DelayCommand(7.3f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound1,oCaster,6.0));
	DelayCommand(7.6f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound2,oCaster,6.0));
	DelayCommand(7.1f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSound3,oCaster,6.0));
	
}

//////////////////////////////////////////////////

void CloneTarget(object oTarget, object oCaster)
{
	int nRand = d4(1);
	int i;
	for(i = 0; i < nRand; i++)
	{
		object oClone = CopyObject(oTarget, GetLocation(oTarget), OBJECT_INVALID, "PCClone");
	    
		if(spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE,oCaster) == FALSE)
		{
			ChangeToStandardFaction(oClone,STANDARD_FACTION_DEFENDER);
		}
		
	    object oItem = GetFirstItemInInventory(oClone);
	    if (GetIsObjectValid(oItem))
	    {
	        do
	        {
	            SetDroppableFlag(oItem, FALSE);
	            oItem = GetNextItemInInventory(oClone);
	        } while (GetIsObjectValid(oItem));
	    }
	    // Do not allow any of the clone's equipped items to be dropped when the clone dies.
	    int nSlot = 0;
	    do
	    {
	        oItem = GetItemInSlot(nSlot, oClone);
	        if (GetIsObjectValid(oItem))
	            SetDroppableFlag(oItem, FALSE);
	        nSlot++;
	    } while (nSlot < NUM_INVENTORY_SLOTS);
	    // Take away all of the clone's coins.
	    TakeGoldFromCreature(GetGold(oClone), oClone, TRUE, FALSE);
		AssignCommand(oClone,ShazFollowObject(oTarget));
		DestroyObject(oClone,TurnsToSeconds(1));
	}

}
//////////////////////////////////////////////////
string Phobia(object oCaster, int nSpellId)
{
	string sPhobicName;
		
	int nRand  = Random(48);
	int nPhobiaSubRace = nRand;
	switch(nRand)
	{
	
		case	0	:	sPhobicName =	"Gold Dwarfs"	; break; //	Gold_Dwarf
		case	1	:	sPhobicName =	"Druegar"	; break; //	Gray_Dwarf_Duergar
		case	2	:	sPhobicName =	"Shield Dwarfs"	; break; //	Shield_Dwarf
		case	3	:	sPhobicName =	"Drow"	; break; //	Drow
		case	4	:	sPhobicName =	"Moon Elfs"	; break; //	Moon_Elf
		case	5	:	sPhobicName =	"Sun Elfs"	; break; //	Sun_Elf
		case	6	:	sPhobicName =	"Wild Elfs"	; break; //	Wild_Elf
		case	7	:	sPhobicName =	"Wood Elfs"	; break; //	Wood_Elf
		case	8	:	sPhobicName =	"Svirfneblin"	; break; //	Deep_Gnome_Svirfneblin
		case	9	:	sPhobicName =	"Rock Gnomes"	; break; //	Rock_Gnome
		case	10	:	sPhobicName =	"Ghostwise Halflings"	; break; //	Ghostwise_Halfling
		case	11	:	sPhobicName =	"Lightfoot Halflings"	; break; //	Lightfoot_Halfling
		case	12	:	sPhobicName =	"Strongheart Halflings"	; break; //	Strongheart_Halfling
		case	13	:	sPhobicName =	"Aasimar"	; break; //	Aasimar
		case	14	:	sPhobicName =	"Tieflings"	; break; //	Tiefling
		case	15	:	sPhobicName =	"Half-Elfs"	; break; //	HalfElf
		case	16	:	sPhobicName =	"Half-Orcs"	; break; //	HalfOrc
		case	17	:	sPhobicName =	"Humans"	; break; //	Human
		case	18	:	sPhobicName =	"Air Genasi"	; break; //	Air_Genasi
		case	19	:	sPhobicName =	"Earth Genasi"	; break; //	Earth_Genasi
		case	20	:	sPhobicName =	"Fire Genasi"	; break; //	Fire_Genasi
		case	21	:	sPhobicName =	"Water Genasi"	; break; //	Water_Genasi
		case	22	:	sPhobicName =	"Aberrations"	; break; //	Aberration
		case	23	:	sPhobicName =	"Animals"	; break; //	Animal
		case	24	:	sPhobicName =	"Beasts"	; break; //	Beast
		case	25	:	sPhobicName =	"Constructs"	; break; //	Construct
		case	26	:	sPhobicName =	"Goblinoids"	; break; //	Humanoid_Goblinoid
		case	27	:	sPhobicName =	"Monsterous Humanoids"	; break; //	Humanoid_Monstrous
		case	28	:	sPhobicName =	"Orcs"	; break; //	Humanoid_Orc
		case	29	:	sPhobicName =	"Reptilians"	; break; //	Humanoid_Reptilian
		case	30	:	sPhobicName =	"Elementals"	; break; //	Elemental
		case	31	:	sPhobicName =	"Fey"	; break; //	Fey
		case	32	:	sPhobicName =	"Giants"	; break; //	Giant
		case	33	:	sPhobicName =	"Outsiders"	; break; //	Outsider
		case	34	:	sPhobicName =	"Shapechangers"	; break; //	Shapechanger
		case	35	:	sPhobicName =	"Undead"	; break; //	Undead
		case	36	:	sPhobicName =	"Vermin"	; break; //	Vermin
		case	37	:	sPhobicName =	"Oozes"	; break; //	Ooze
		case	38	:	sPhobicName =	"Dragons"	; break; //	Dragon
		case	39	:	sPhobicName =	"Magical Beasts"	; break; //	Magical_Beast
		case	40	:	sPhobicName =	"Incorporeal Creatures"	; break; //	Incorporeal
		case	41	:	sPhobicName =	"Githyanki"	; break; //	Githyanki
		case	42	:	sPhobicName =	"Githzerai"	; break; //	Githzerai
		case	43	:	sPhobicName =	"Half-Drow"	; break; //	HalfDrow
		case	44	:	sPhobicName =	"Animate Plants"	; break; //	Plant
		case	45	:	sPhobicName =	"Hagspawn"	; break; //	Hagspawn
		case	46	:	sPhobicName =	"Half-Celestials"	; break; //	HalfCelestial

	}
	
	int nPhobiaEncountersMax = d4(1) + 2;
	int nPhobiaEncountersTotal = 0;
	
	SetLocalString(oCaster,"sPhobicName",sPhobicName); // used for messages
	SetLocalInt(oCaster,"nPhobiaSubRace",nPhobiaSubRace); // used in enterscript
	SetLocalInt(oCaster,"nPhobiaEncountersMax",nPhobiaEncountersMax);
	SetLocalInt(oCaster,"nPhobiaEncountersTotal",nPhobiaEncountersTotal);
	
	float fDur = HoursToSeconds(24) + HoursToSeconds(Random(72));
	
	// just a fix for a potential nasty bug
	//if(nSpellId == 0)
	//{
		nSpellId = SURGE_TEMP_SPELLID_PHOBIA;
	//}
	
	SetLocalInt(oCaster,"nPhobiaSpellId",nSpellId);
	
	effect eAOE = EffectAreaOfEffect(AOE_PER_PHOBIA,"2d2f_surge_phobia_enter","","2d2f_surge_phobia_exit");
	eAOE = SupernaturalEffect(eAOE);
	//eAOE = SetEffectSpellId(eAOE,nSpellId);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,SetEffectSpellId(eAOE,nSpellId),oCaster);
	
	DelayCommand(fDur,RemoveSupernaturalEffectWithSpellId(oCaster,nSpellId) );
	DelayCommand(fDur,DeleteLocalString(oCaster,"sPhobicName"));
	DelayCommand(fDur,DeleteLocalInt(oCaster,"nPhobiaSubRace"));
	DelayCommand(fDur,DeleteLocalInt(oCaster,"nPhobiaEncountersMax" ));
	DelayCommand(fDur,DeleteLocalInt(oCaster,"nPhobiaEncountersTotal" ));
	DelayCommand(fDur,DeleteLocalInt(oCaster,"nPhobiaSpellId"));
	DelayCommand(fDur,FloatingTextStringOnCreature("You are no longer afraid of " + sPhobicName + ".",oCaster));
				
	
	return sPhobicName;
}

//////////////////////////////////////////////////

void SummonDM(object oTarget)
{
    object oDM = CreateObject(OBJECT_TYPE_CREATURE, "2d2f_dm", GetLocation(oTarget), TRUE, "The Dungeon Master");
    SetAllEventHandlers(oDM,"");
	SetLocalObject(GetFirstPC(),"oDM",oDM);
	AssignCommand(oDM, ActionRandomWalk());	    
}

//////////////////////////////////////////////////

void SummonRustMonster(object oTarget)
{
    object oRust = CreateObject(OBJECT_TYPE_CREATURE,
                "RustMonster",
                GetLocation(oTarget),
                TRUE);
    ChangeToStandardFaction(oRust,STANDARD_FACTION_HOSTILE);
	DelayCommand(6.0f, BuffSummons(OBJECT_SELF, 0, 0));
}

//////////////////////////////////////////////////

void DrunkBomb(object oTarget, object oCaster, int iShieldSuccess)
{
    float fRadius = RADIUS_SIZE_VAST;
	location lTarget = GetLocation(oTarget);
	//effect eVis = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND);
	//JXApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,RoundsToSeconds(1));

	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
	if(oTarget == oCaster && iShieldSuccess != 0)
	{
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
	}
	
	while(GetIsObjectValid(oTarget))
	{
		float fRandDelay = GetRandomDelay(0.1,1.1);
        AssignCommand(oTarget,ClearAllActions());
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));
        int nPoints = d3(1);
        effect eDumb = EffectAbilityDecrease(ABILITY_INTELLIGENCE, nPoints);
        DelayCommand(fRandDelay,JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDumb, oTarget, 60.0));
		
		
		int i;
		for(i = 0; i<5; i++)
		{
		    float fIDelay = IntToFloat(i*2) * 6.0;
		    float fDelay = fRandDelay + fIDelay;
		    int nRand1 = d2(1);
		    if(nRand1 == 1)
		    {
                int nRand2 = Random(5);
                if(nRand2 == 0)
                {
                    DelayCommand(fDelay,AssignCommand(oTarget,ClearAllActions()));
                    DelayCommand(fDelay,AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK)));
                }
                else if(nRand2 == 1)
                {
                    DelayCommand(fDelay,AssignCommand(oTarget,ClearAllActions()));
                    DelayCommand(fDelay,AssignCommand(oTarget, ActionRandomWalk()));                        
                }
                else if(nRand2 == 2)
                {
                    effect eKnock = EffectKnockdown();
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnock,oTarget,6.0));                    
                }
                else if(nRand2 == 3)
                {
                    DelayCommand(fDelay,AssignCommand(oTarget, ClearAllActions()));
			        DelayCommand(fDelay,AssignCommand(oTarget, PlayVoiceChat(VOICE_CHAT_LAUGH)));
			        DelayCommand(fDelay,AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING)));
                           
                }
                else if(nRand2 == 4)
                {
                    effect eConf = EffectConfused();
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eConf,oTarget,6.0));                    
                }
                
            }
		}
		
		oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
		if(oTarget == oCaster && iShieldSuccess != 0)
		{
			oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lTarget,TRUE,OBJECT_TYPE_CREATURE);
		}
	}

}
//////////////////////////////////////////////////
int SexChange(object oTarget, int nKeepGender = FALSE)
{   
    int nSexChanged = GetLocalInt(oTarget,"nSexChanged");
    int nRaceChanged = GetLocalInt(oTarget,"nRaceChanged");
    int nSubRace = GetSubRace(oTarget);
    
    // 0 = male 1 = female
    int nGender = GetGender(oTarget);
    
    if(nSexChanged != 0 && nRaceChanged != 1) // if this is the second time, they are restored
    {
        int nOriginalAppearance = GetLocalInt(oTarget,"nOriginalAppearance");
        SetCreatureAppearanceType(oTarget,nOriginalAppearance);
        DeleteLocalInt(oTarget,"nSexChanged");
        DeleteLocalInt(oTarget,"nFakeGender");
        return 1; 
    }
    else
    {      
        // if they have a fake appearance and already had a sex change
        // we need to know what their fake gender is  
        if(nSexChanged != 0)
        {
            nGender = GetLocalInt(oTarget,"nFakeGender");
        }
      
        
        // check to see if the creature currently has a different racial appearance
        // if not store their original appearance
        if(nRaceChanged != 1)
        {
            SetLocalInt(oTarget,"nOriginalAppearance",GetAppearanceType(oTarget));
        }
        else if (nRaceChanged == 1 && nKeepGender == TRUE)
        {
        // this part is if this function is used when removing a false race.
        // here we want this function to keep the current fake gender so
        // we reverse the nGender variable
        
        // Also, we want to keep the race valse fed into the function
            if(nGender == 0)
            {
                nGender = 1;
            }
            else
            {
                nGender = 0;
            }
        }
        else // their race has already changed. set nSubRace Accordingly
        {
            nSubRace = GetLocalInt(oTarget,"nFakeRace");            
        }   
        
        switch(nSubRace)
        {
            case	0	:		//	Gold_Dwarf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Dwarf_Gold_female);
                    SetLocalInt(oTarget,"nFakeGender",1);                    
                }else{
                    SetCreatureAppearanceType(oTarget,App_Dwarf_Gold_male);
                    SetLocalInt(oTarget,"nFakeGender",0);
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	1	:		//	Gray_Dwarf_Duergar
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Dwarf_Duergar_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Dwarf_Duergar_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;        
            case	2	:		//	Shield_Dwarf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Dwarf_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Dwarf_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	3	:		//	Drow
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Elf_Drow_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Elf_Drow_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	4	:		//	Moon_Elf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Elf_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Elf_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	5	:		//	Sun_Elf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Elf_Sun_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Elf_Sun_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	6	:		//	Wild_Elf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Elf_Wild_NX1_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Elf_Wild_NX1_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	7	:		//	Wood_Elf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Elf_Wood_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Elf_Wood_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	8	:		//	Deep_Gnome_Svirfneblin
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Gnome_Svirfneblin_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Gnome_Svirfneblin_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	9	:		//	Rock_Gnome
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Gnome_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Gnome_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	11	:		//	Lightfoot_Halfling
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Halfling_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Halfling_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	12	:		//	Strongheart_Halfling
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Halfling_Strongheart_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Halfling_Strongheart_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	13	:		//	Aasimar
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Assimar_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Assimar_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	14	:		//	Tiefling
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Tiefling_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Tiefling_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	15	:		//	HalfElf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Half_Elf_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Half_Elf_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	16	:		//	HalfOrc
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Half_Orc_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Half_Orc_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	17	:		//	Human
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Human_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Human_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	18	:		//	Air_Genasi
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Air_Genasi_NX1_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Air_Genasi_NX1_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	19	:		//	Earth_Genasi
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Earth_Genasi_NX1_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Earth_Genasi_NX1_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	20	:		//	Fire_Genasi
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Fire_Genasi_NX1_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Fire_Genasi_NX1_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	21	:		//	Water_Genasi
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Water_Genasi_NX1_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Water_Genasi_NX1_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
            case	41	:		//	Githyanki
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Githyanki_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Githyanki_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
           case	43	:		//	HalfDrow
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Half_Drow_NX1_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Half_Drow_NX1_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
           case	46	:		//	HalfCelestial
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Assimar_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Assimar_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
           case	47	:		//	YuantiPureblood
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_YuantiPureblood_NX2_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_YuantiPureblood_NX2_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
           case	48	:		//	GrayOrc
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_GreyOrc_NX2_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_GreyOrc_NX2_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
           case	67	:		//	StarElf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Elf_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Elf_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;
           case	68	:		//	PaintedElf
                if(nGender == 0){
                    SetCreatureAppearanceType(oTarget,App_Elf_Wood_female);
                    SetLocalInt(oTarget,"nFakeGender",1);   
                }else{
                    SetCreatureAppearanceType(oTarget,App_Elf_Wood_male);
                    SetLocalInt(oTarget,"nFakeGender",0);   
                }
                SetLocalInt(oTarget,"nSexChanged",1);
                return 1;

            default : return 0;
        }
    }
    
    return 0;
}
//////////////////////////////////////////////////

void RemoveRacialAbilities(object oTarget, int nSubRace)
{
    // remove any bonus stats gained from a previous transformation
    RemoveSupernaturalEffectWithSpellId(oTarget,SURGE_TEMP_SPELLID_RACIAL_STATS);
    
    effect eStat1;
    effect eStat2;
    effect eStat3;
    effect eStat4;
	effect eStat5;
	effect eStat6;
    effect eLink;    
    
        switch(nSubRace)
        {
            case	0	:		//	Gold_Dwarf
                eStat1 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatRemove(	oTarget,	228	);
                FeatRemove(	oTarget,	227 );
                FeatRemove(	oTarget,	229 );
                FeatRemove(	oTarget,	230 );
                FeatRemove(	oTarget,	1072 );
                FeatRemove(	oTarget,	233 );
                FeatRemove(	oTarget,	234 );
                FeatRemove(	oTarget,	1770 );
                break;
            case	1	:		//	Gray_Dwarf_Duergar
                eStat1 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,4);
                eLink = EffectLinkEffects(eStat1,eStat2);            
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	227 );
                FeatRemove(	oTarget,	230 );
                FeatRemove(	oTarget,	231 );
                FeatRemove(	oTarget,	232 );
                FeatRemove(	oTarget,	233 );
                FeatRemove(	oTarget,	234 );
                FeatRemove(	oTarget,	1753 );
                FeatRemove(	oTarget,	1748 );
                FeatRemove(	oTarget,	1751 );
                FeatRemove(	oTarget,	244 );
                FeatRemove(	oTarget,	246 );
                FeatRemove(	oTarget,	1073 );
                FeatRemove(	oTarget,	1074 );
                FeatRemove(	oTarget,	1752 );
                FeatRemove(	oTarget,	1768 );
                FeatRemove(	oTarget,	1770 ); 
                break;      
            case	2	:		//	Shield_Dwarf
                eStat1 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	227 );
                FeatRemove(	oTarget,	229 );
                FeatRemove(	oTarget,	230 );
                FeatRemove(	oTarget,	231 );
                FeatRemove(	oTarget,	232 );
                FeatRemove(	oTarget,	233 );
                FeatRemove(	oTarget,	234 );
                FeatRemove(	oTarget,	1770 );
                break;
            case	3	:		//	Drow
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat3 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat4 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatRemove(	oTarget,		235 );
                FeatRemove(	oTarget,		236 );
                FeatRemove(	oTarget,		256 );
                FeatRemove(	oTarget,		237 );
                FeatRemove(	oTarget,		238 );
                FeatRemove(	oTarget,		239 );
                FeatRemove(	oTarget,		240 );
                FeatRemove(	oTarget,		228 );
                FeatRemove(	oTarget,		1075 );
				FeatRemove(	oTarget,		1076 );
                FeatRemove(	oTarget,		1749 );
                FeatRemove(	oTarget,		3202 );
                FeatRemove(	oTarget,		1767 );
                 break;
            case	4	:		//	Moon_Elf
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	256 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	238 );
                FeatRemove(	oTarget,	239 );
                FeatRemove(	oTarget,	240 );
                FeatRemove(	oTarget,	354 );
                break;
            case	5	:		//	Sun_Elf
                eStat1 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	256 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	238 );
                FeatRemove(	oTarget,	239 );
                FeatRemove(	oTarget,	240 );
                FeatRemove(	oTarget,	354 );                
                break;
            case	6	:		//	Wild_Elf
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	256 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	238 );
                FeatRemove(	oTarget,	239 );
                FeatRemove(	oTarget,	240 );
                FeatRemove(	oTarget,	354 );                
                break;
            case	7	:		//	Wood_Elf
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat3 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	256 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	238 );
                FeatRemove(	oTarget,	239 );
                FeatRemove(	oTarget,	240 );
                FeatRemove(	oTarget,	354 );                
                break;
            case	8	:		//	Deep_Gnome_Svirfneblin
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_WISDOM,2);
                eStat3 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,4);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatRemove(	oTarget,	1795 );
                FeatRemove(	oTarget,	243 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	242 );
                FeatRemove(	oTarget,	232 );
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	375 );
                FeatRemove(	oTarget,	227 );
                FeatRemove(	oTarget,	1078 );
                FeatRemove(	oTarget,	1079 );
                FeatRemove(	oTarget,	1082 );
                FeatRemove(	oTarget,	1083 );
                FeatRemove(	oTarget,	1756 );
                FeatRemove(	oTarget,	1757 );
                FeatRemove(	oTarget,	1754 );
                FeatRemove(	oTarget,	1087 );
                FeatRemove(	oTarget,	1755 );
                break;
            case	9	:		//	Rock_Gnome
                eStat1 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatRemove(	oTarget,	1795 );
                FeatRemove(	oTarget,	243 );
                FeatRemove(	oTarget,	242 );
                FeatRemove(	oTarget,	241 );
                FeatRemove(	oTarget,	232 );
                FeatRemove(	oTarget,	233 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	354 );
                FeatRemove(	oTarget,	375 );
                 break;
            case	11	:		//	Lightfoot_Halfling
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatRemove(	oTarget,	247 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	248 );
                FeatRemove(	oTarget,	249 );
                FeatRemove(	oTarget,	250 );
                FeatRemove(	oTarget,	375 );
                break;
            case	12	:		//	Strongheart_Halfling
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatRemove(	oTarget,	247 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	249 );
                FeatRemove(	oTarget,	250 );
                FeatRemove(	oTarget,	375 );
                FeatRemove(	oTarget,	258 );
                break;
            case	13	:		//	Aasimar
                eStat1 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eStat2 = EffectAbilityDecrease(ABILITY_WISDOM,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	239 );
                FeatRemove(	oTarget,	1085 );
                FeatRemove(	oTarget,	1086 );
                FeatRemove(	oTarget,	427 );
                FeatRemove(	oTarget,	430 );
                FeatRemove(	oTarget,	428 );
                break;
            case	14	:		//	Tiefling
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat3 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                eLink = EffectLinkEffects(eLink,eStat3); 
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	1087 );
                FeatRemove(	oTarget,	1088 );
                FeatRemove(	oTarget,	1089 );
                FeatRemove(	oTarget,	1097 );
                FeatRemove(	oTarget,	429 );
                FeatRemove(	oTarget,	427 );
                FeatRemove(	oTarget,	430 );
                break;                
            case	15	:		//	HalfElf
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	244 );
                FeatRemove(	oTarget,	245 );
                FeatRemove(	oTarget,	246 );
                FeatRemove(	oTarget,	354 );
                FeatRemove(	oTarget,	1096 );
                FeatRemove(	oTarget,	1097 );
                break;
            case	16	:		//	HalfOrc
                eStat1 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat3 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                eLink = EffectLinkEffects(eLink,eStat3);
                FeatRemove(	oTarget,	228 );
            case	17	:		//	Human
                FeatRemove(	oTarget,	258 );
                FeatRemove(	oTarget,	1773 );
            case	18	:		//	Air_Genasi
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat3 = EffectAbilityIncrease(ABILITY_WISDOM,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	1868 );
                FeatRemove(	oTarget,	1872 );
                break;
            case	19	:		//	Earth_Genasi
                eStat1 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat3 = EffectAbilityIncrease(ABILITY_WISDOM,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	1869 );
                FeatRemove(	oTarget,	1873 );
                break;
            case	20	:		//	Fire_Genasi
                eStat1 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	1870 );
                FeatRemove(	oTarget,	1874 );
                break;
            case	21	:		//	Water_Genasi
                eStat1 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatRemove(	oTarget,	228 );
                FeatRemove(	oTarget,	1871 );
                FeatRemove(	oTarget,	1875 );
                break; 
            case	43	:		//	HalfDrow
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	244 );
                FeatRemove(	oTarget,	245 );
                FeatRemove(	oTarget,	246 );
                FeatRemove(	oTarget,	354 );
                FeatRemove(	oTarget,	1096 );
                FeatRemove(	oTarget,	1097 );
                break;
            case	46	:		//	HalfCelestial
                eStat1 = EffectAbilityDecrease(ABILITY_STRENGTH,4);
                eStat2 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat3 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat4 = EffectAbilityDecrease(ABILITY_CHARISMA,4);
                eStat5 = EffectAbilityDecrease(ABILITY_WISDOM,4);
                eStat6 = EffectAbilityDecrease(ABILITY_CONSTITUTION,4);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
				eLink = EffectLinkEffects(eLink,eStat5);
				eLink = EffectLinkEffects(eLink,eStat6);
                FeatRemove(	oTarget,	228	);
                FeatRemove(	oTarget,	301 );
                FeatRemove(	oTarget,	2112 );
                FeatRemove(	oTarget,	2113 );
                FeatRemove(	oTarget,	2114 );
                FeatRemove(	oTarget,	2115 );
                FeatRemove(	oTarget,	2116 );
                FeatRemove(	oTarget,	2117 );
				FeatRemove(	oTarget,	2118 );
				FeatRemove(	oTarget,	2119 );
				FeatRemove(	oTarget,	2120 );
				FeatRemove(	oTarget,	2121 );
				FeatRemove(	oTarget,	2122 );
				FeatRemove(	oTarget,	2123 );
				FeatRemove(	oTarget,	2124 );
                break;
            case	47	:		//	YuantiPureblood
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eStat3 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                FeatRemove(	oTarget,	228	);
                FeatRemove(	oTarget,	2112 );
                FeatRemove(	oTarget,	2171 );
                FeatRemove(	oTarget,	2172 );
                FeatRemove(	oTarget,	2173 );
                FeatRemove(	oTarget,	2174 );
                FeatRemove(	oTarget,	2175 );
                FeatRemove(	oTarget,	2176 );
                FeatRemove(	oTarget,	0 );
                FeatRemove(	oTarget,	408 );
                break;
            case	48	:		//	GrayOrc
                eStat1 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityDecrease(ABILITY_WISDOM,2);
                eStat3 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat4 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatRemove(	oTarget,	228	);
                FeatRemove(	oTarget,	1767 );
                FeatRemove(	oTarget,	2177 );
                FeatRemove(	oTarget,	2178 );
                FeatRemove(	oTarget,	1116 );
                FeatRemove(	oTarget,	2248 );
                break;
            case	67	:		//	Star_Elf
                eStat1 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	256 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	238 );
                FeatRemove(	oTarget,	239 );
                FeatRemove(	oTarget,	240 );
                FeatRemove(	oTarget,	354 );
                break;
            case	68	:		//	Painted_Elf
                eStat1 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatRemove(	oTarget,	235 );
                FeatRemove(	oTarget,	236 );
                FeatRemove(	oTarget,	256 );
                FeatRemove(	oTarget,	237 );
                FeatRemove(	oTarget,	238 );
                FeatRemove(	oTarget,	239 );
                FeatRemove(	oTarget,	240 );
                FeatRemove(	oTarget,	354 );
                break;
            default : return;
        }
    
    int nOriginalRaceStatReduction = GetLocalInt(oTarget,"nOriginalRaceStatReduction");
    
    // here we reverse the players original racial bonuses the first time this 
    // function is called only.
    // everytime after, the bonuses gained will be removed at the very beginning
    //of this function, but will leave the original change alone.
    //When the racial change is removed this reversal is cancled.
    if(nOriginalRaceStatReduction == 0)
    {
        eLink = SupernaturalEffect(eLink);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SetEffectSpellId(eLink,SURGE_TEMP_SPELLID_ORIGINAL_RACIAL_STATS),oTarget);
        SetLocalInt(oTarget,"nOriginalRaceStatReduction",1);
   }    
}
//////////////////////////////////////////////////

void AddRacialAbilities(object oTarget, int nSubRace)
{
    effect eStat1;
    effect eStat2;
    effect eStat3;
    effect eStat4;
	effect eStat5;
	effect eStat6;
    effect eLink;    
    
        switch(nSubRace)
        {
            case	0	:		//	Gold_Dwarf
                eStat1 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	227	,	FALSE);
                FeatAdd(	oTarget,	229	,	FALSE);
                FeatAdd(	oTarget,	230	,	FALSE);
                FeatAdd(	oTarget,	1072	,	FALSE);
                FeatAdd(	oTarget,	233	,	FALSE);
                FeatAdd(	oTarget,	234	,	FALSE);
                FeatAdd(	oTarget,	1770	,	FALSE);
                break;
            case	1	:		//	Gray_Dwarf_Duergar
                eStat1 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,4);
                eLink = EffectLinkEffects(eStat1,eStat2);            
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	227	,	FALSE);
                FeatAdd(	oTarget,	230	,	FALSE);
                FeatAdd(	oTarget,	231	,	FALSE);
                FeatAdd(	oTarget,	232	,	FALSE);
                FeatAdd(	oTarget,	233	,	FALSE);
                FeatAdd(	oTarget,	234	,	FALSE);
                FeatAdd(	oTarget,	1753	,	FALSE);
                FeatAdd(	oTarget,	1748	,	FALSE);
                FeatAdd(	oTarget,	1751	,	FALSE);
                FeatAdd(	oTarget,	244	,	FALSE);
                FeatAdd(	oTarget,	246	,	FALSE);
                FeatAdd(	oTarget,	1073	,	FALSE);
                FeatAdd(	oTarget,	1074	,	FALSE);
                FeatAdd(	oTarget,	1752	,	FALSE);
                FeatAdd(	oTarget,	1768	,	FALSE);
                FeatAdd(	oTarget,	1770	,	FALSE); 
                break;      
            case	2	:		//	Shield_Dwarf
                eStat1 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	227	,	FALSE);
                FeatAdd(	oTarget,	229	,	FALSE);
                FeatAdd(	oTarget,	230	,	FALSE);
                FeatAdd(	oTarget,	231	,	FALSE);
                FeatAdd(	oTarget,	232	,	FALSE);
                FeatAdd(	oTarget,	233	,	FALSE);
                FeatAdd(	oTarget,	234	,	FALSE);
                FeatAdd(	oTarget,	1770	,	FALSE);
                break;
            case	3	:		//	Drow
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat3 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat4 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatAdd(	oTarget,		235	,	FALSE);
                FeatAdd(	oTarget,		236	,	FALSE);
                FeatAdd(	oTarget,		256	,	FALSE);
                FeatAdd(	oTarget,		237	,	FALSE);
                FeatAdd(	oTarget,		238	,	FALSE);
                FeatAdd(	oTarget,		239	,	FALSE);
                FeatAdd(	oTarget,		240	,	FALSE);
                FeatAdd(	oTarget,		228	,	FALSE);
                FeatAdd(	oTarget,		1075	,	FALSE);
                FeatAdd(	oTarget,		1076	,	FALSE);
                FeatAdd(	oTarget,		1749	,	FALSE);
                FeatAdd(	oTarget,		3502	,	FALSE);
                FeatAdd(	oTarget,		1767	,	FALSE);
                 break;
            case	4	:		//	Moon_Elf
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	256	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	238	,	FALSE);
                FeatAdd(	oTarget,	239	,	FALSE);
                FeatAdd(	oTarget,	240	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);
                break;
            case	5	:		//	Sun_Elf
                eStat1 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	256	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	238	,	FALSE);
                FeatAdd(	oTarget,	239	,	FALSE);
                FeatAdd(	oTarget,	240	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);                
                break;
            case	6	:		//	Wild_Elf
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	256	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	238	,	FALSE);
                FeatAdd(	oTarget,	239	,	FALSE);
                FeatAdd(	oTarget,	240	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);                
                break;
            case	7	:		//	Wood_Elf
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eStat3 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	256	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	238	,	FALSE);
                FeatAdd(	oTarget,	239	,	FALSE);
                FeatAdd(	oTarget,	240	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);                
                break;
            case	8	:		//	Deep_Gnome_Svirfneblin
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_WISDOM,2);
                eStat3 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,4);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatAdd(	oTarget,	1795	,	FALSE);
                FeatAdd(	oTarget,	243	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	242	,	FALSE);
                FeatAdd(	oTarget,	232	,	FALSE);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	375	,	FALSE);
                FeatAdd(	oTarget,	227	,	FALSE);
                FeatAdd(	oTarget,	1078	,	FALSE);
                FeatAdd(	oTarget,	1079	,	FALSE);
                FeatAdd(	oTarget,	1082	,	FALSE);
                FeatAdd(	oTarget,	1083	,	FALSE);
                FeatAdd(	oTarget,	1756	,	FALSE);
                FeatAdd(	oTarget,	1757	,	FALSE);
                FeatAdd(	oTarget,	1754	,	FALSE);
                FeatAdd(	oTarget,	1087	,	FALSE);
                FeatAdd(	oTarget,	1755	,	FALSE);
                break;
            case	9	:		//	Rock_Gnome
                eStat1 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatAdd(	oTarget,	1795	,	FALSE);
                FeatAdd(	oTarget,	243	,	FALSE);
                FeatAdd(	oTarget,	242	,	FALSE);
                FeatAdd(	oTarget,	241	,	FALSE);
                FeatAdd(	oTarget,	232	,	FALSE);
                FeatAdd(	oTarget,	233	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);
                FeatAdd(	oTarget,	375	,	FALSE);
                 break;
            case	11	:		//	Lightfoot_Halfling
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatAdd(	oTarget,	247	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	248	,	FALSE);
                FeatAdd(	oTarget,	249	,	FALSE);
                FeatAdd(	oTarget,	250	,	FALSE);
                FeatAdd(	oTarget,	375	,	FALSE);
                break;
            case	12	:		//	Strongheart_Halfling
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_STRENGTH,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatAdd(	oTarget,	247	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	249	,	FALSE);
                FeatAdd(	oTarget,	250	,	FALSE);
                FeatAdd(	oTarget,	375	,	FALSE);
                FeatAdd(	oTarget,	258	,	FALSE);
                break;
            case	13	:		//	Aasimar
                eStat1 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eStat2 = EffectAbilityIncrease(ABILITY_WISDOM,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	239	,	FALSE);
                FeatAdd(	oTarget,	1085	,	FALSE);
                FeatAdd(	oTarget,	1086	,	FALSE);
                FeatAdd(	oTarget,	427	,	FALSE);
                FeatAdd(	oTarget,	430	,	FALSE);
                FeatAdd(	oTarget,	428	,	FALSE);
                break;
            case	14	:		//	Tiefling
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat3 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                eLink = EffectLinkEffects(eLink,eStat3); 
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	1087	,	FALSE);
                FeatAdd(	oTarget,	1088	,	FALSE);
                FeatAdd(	oTarget,	1089	,	FALSE);
                FeatAdd(	oTarget,	1097	,	FALSE);
                FeatAdd(	oTarget,	429	,	FALSE);
                FeatAdd(	oTarget,	427	,	FALSE);
                FeatAdd(	oTarget,	430	,	FALSE);
                break;                
            case	15	:		//	HalfElf
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	244	,	FALSE);
                FeatAdd(	oTarget,	245	,	FALSE);
                FeatAdd(	oTarget,	246	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);
                FeatAdd(	oTarget,	1096	,	FALSE);
                FeatAdd(	oTarget,	1097	,	FALSE);
                break;
            case	16	:		//	HalfOrc
                eStat1 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat3 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                eLink = EffectLinkEffects(eLink,eStat3);
                FeatAdd(	oTarget,	228	,	FALSE);
            case	17	:		//	Human
                FeatAdd(	oTarget,	258	,	FALSE);
                FeatAdd(	oTarget,	1773	,	FALSE);
            case	18	:		//	Air_Genasi
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat3 = EffectAbilityDecrease(ABILITY_WISDOM,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	1868	,	FALSE);
                FeatAdd(	oTarget,	1872	,	FALSE);
                break;
            case	19	:		//	Earth_Genasi
                eStat1 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat3 = EffectAbilityDecrease(ABILITY_WISDOM,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	1869	,	FALSE);
                FeatAdd(	oTarget,	1873	,	FALSE);
                break;
            case	20	:		//	Fire_Genasi
                eStat1 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2); 
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	1870	,	FALSE);
                FeatAdd(	oTarget,	1874	,	FALSE);
                break;
            case	21	:		//	Water_Genasi
                eStat1 = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	1871	,	FALSE);
                FeatAdd(	oTarget,	1875	,	FALSE);
                break; 
            case	43	:		//	HalfDrow
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	244	,	FALSE);
                FeatAdd(	oTarget,	245	,	FALSE);
                FeatAdd(	oTarget,	246	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);
                FeatAdd(	oTarget,	1096	,	FALSE);
                FeatAdd(	oTarget,	1097	,	FALSE);
                break;
            case	46	:		//	HalfCelestial
                eStat1 = EffectAbilityIncrease(ABILITY_STRENGTH,4);
                eStat2 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat3 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eStat4 = EffectAbilityIncrease(ABILITY_CHARISMA,4);
                eStat5 = EffectAbilityIncrease(ABILITY_WISDOM,4);
                eStat6 = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
				eLink = EffectLinkEffects(eLink,eStat5);
				eLink = EffectLinkEffects(eLink,eStat6);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	301	,	FALSE);
                FeatAdd(	oTarget,	2112	,	FALSE);
                FeatAdd(	oTarget,	2113	,	FALSE);
                FeatAdd(	oTarget,	2114	,	FALSE);
                FeatAdd(	oTarget,	2115	,	FALSE);
                FeatAdd(	oTarget,	2116	,	FALSE);
                FeatAdd(	oTarget,	2117	,	FALSE);
				FeatAdd(	oTarget,	2118	,	FALSE);
				FeatAdd(	oTarget,	2119	,	FALSE);
				FeatAdd(	oTarget,	2120	,	FALSE);
				FeatAdd(	oTarget,	2121	,	FALSE);
				FeatAdd(	oTarget,	2122	,	FALSE);
				FeatAdd(	oTarget,	2123	,	FALSE);
				FeatAdd(	oTarget,	2124	,	FALSE);
                break;
            case	47	:		//	YuantiPureblood
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eStat3 = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	2112	,	FALSE);
                FeatAdd(	oTarget,	2171	,	FALSE);
                FeatAdd(	oTarget,	2172	,	FALSE);
                FeatAdd(	oTarget,	2173	,	FALSE);
                FeatAdd(	oTarget,	2174	,	FALSE);
                FeatAdd(	oTarget,	2175	,	FALSE);
                FeatAdd(	oTarget,	2176	,	FALSE);
                FeatAdd(	oTarget,	0	,	FALSE);
                FeatAdd(	oTarget,	408	,	FALSE);
                break;
            case	48	:		//	GrayOrc
                eStat1 = EffectAbilityIncrease(ABILITY_STRENGTH,2);
                eStat2 = EffectAbilityIncrease(ABILITY_WISDOM,2);
                eStat3 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eStat4 = EffectAbilityDecrease(ABILITY_CHARISMA,2);
                eLink = EffectLinkEffects(eStat1,eStat2);  
                eLink = EffectLinkEffects(eLink,eStat3);
                eLink = EffectLinkEffects(eLink,eStat4);
                FeatAdd(	oTarget,	228	,	FALSE);
                FeatAdd(	oTarget,	1767	,	FALSE);
                FeatAdd(	oTarget,	2177	,	FALSE);
                FeatAdd(	oTarget,	2178	,	FALSE);
                FeatAdd(	oTarget,	1116	,	FALSE);
                FeatAdd(	oTarget,	2248	,	FALSE);
                break;
            case	67	:		//	Star_Elf
                eStat1 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
                eStat2 = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	256	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	238	,	FALSE);
                FeatAdd(	oTarget,	239	,	FALSE);
                FeatAdd(	oTarget,	240	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);
                break;
            case	68	:		//	Painted_Elf
                eStat1 = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
                eStat2 = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
                eLink = EffectLinkEffects(eStat1,eStat2);
                FeatAdd(	oTarget,	235	,	FALSE);
                FeatAdd(	oTarget,	236	,	FALSE);
                FeatAdd(	oTarget,	256	,	FALSE);
                FeatAdd(	oTarget,	237	,	FALSE);
                FeatAdd(	oTarget,	238	,	FALSE);
                FeatAdd(	oTarget,	239	,	FALSE);
                FeatAdd(	oTarget,	240	,	FALSE);
                FeatAdd(	oTarget,	354	,	FALSE);
                break;
            default : return;
        }
    
    eLink = SupernaturalEffect(eLink);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SetEffectSpellId(eLink,SURGE_TEMP_SPELLID_RACIAL_STATS),oTarget);
        
}
//////////////////////////////////////////////////

int RaceChange(object oTarget)
{
    int nSexChanged = GetLocalInt(oTarget,"nSexChanged");
    int nRaceChanged = GetLocalInt(oTarget,"nRaceChanged");
    int nCurrentSubRace;// = GetSubRace(oTarget);
    
    // 0 = male 1 = female
    int nGender = GetGender(oTarget);
    
    // store original appearance if not already stored from a sex change
    if(nRaceChanged == 0 && nSexChanged == 0)
    {
        SetLocalInt(oTarget,"nOriginalAppearance",GetAppearanceType(oTarget));
    }
    
    // if sex changed use the fake gender
    if(nSexChanged == 1)
    {
        nGender = GetLocalInt(oTarget,"nFakeGender");
    }

    // so we know what  abilities to remove    
    if(nRaceChanged == 0)
    {
        nCurrentSubRace = GetSubRace(oTarget);
    }
    else
    {
        nCurrentSubRace = GetLocalInt(oTarget,"nFakeRace");
    }

   if(nCurrentSubRace == 0 || nCurrentSubRace == 1 || nCurrentSubRace == 2 ||
        nCurrentSubRace == 3 || nCurrentSubRace == 4 || nCurrentSubRace == 5 ||
        nCurrentSubRace == 6 || nCurrentSubRace == 7 || nCurrentSubRace == 8 ||
        nCurrentSubRace == 9 || nCurrentSubRace == 11 || nCurrentSubRace == 12 ||
        nCurrentSubRace == 13 || nCurrentSubRace == 14 || nCurrentSubRace == 15 ||
        nCurrentSubRace == 16 || nCurrentSubRace == 17 || nCurrentSubRace == 18 ||
        nCurrentSubRace == 19 || nCurrentSubRace == 20 || nCurrentSubRace == 21 ||
        nCurrentSubRace == 43 || nCurrentSubRace == 46 || nCurrentSubRace == 47 ||
		nCurrentSubRace == 48 || nCurrentSubRace == 67 || nCurrentSubRace == 68)
        {        
        
        int nRand = Random(27);
    
        switch(nRand)
            {
                case	0	:		//	Gold_Dwarf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Dwarf_Gold_male);
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Dwarf_Gold_female);
                    }
                    SetLocalInt(oTarget,"nFakeRace",0);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,0);
                    return 1;
                case	1	:		//	Gray_Dwarf_Duergar
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Dwarf_Duergar_male);            
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Dwarf_Duergar_female);
                    }
                    SetLocalInt(oTarget,"nFakeRace",1);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,1);
                    return 1;
                case	2	:		//	Shield_Dwarf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Dwarf_male);              
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Dwarf_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",2);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,2);
                    return 1;
                case	3	:		//	Drow
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Elf_Drow_male);                 
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Elf_Drow_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",3);       
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,3);
                    return 1;
                case	4	:		//	Moon_Elf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Elf_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Elf_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",4);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,4);
                    return 1;
                case	5	:		//	Sun_Elf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Elf_Sun_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Elf_Sun_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",5);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,5);
                    return 1;
                case	6	:		//	Wild_Elf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Elf_Wild_NX1_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Elf_Wild_NX1_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",6);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,6);
                    return 1;
                case	7	:		//	Wood_Elf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Elf_Wood_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Elf_Wood_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",7);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,7);
                    return 1;
                case	8	:		//	Deep_Gnome_Svirfneblin
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Gnome_Svirfneblin_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Gnome_Svirfneblin_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",8);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,8);
                    return 1;
                case	9	:		//	Rock_Gnome
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Gnome_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Gnome_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",9);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,9);
                    return 1;
                case	10	:		//	Lightfoot_Halfling
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Halfling_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Halfling_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",11);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,11);
                    return 1;
                case	11	:		//	Strongheart_Halfling
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Halfling_Strongheart_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Halfling_Strongheart_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",12);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,12);
                    return 1;
                case	12	:		//	Aasimar
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Assimar_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Assimar_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",13);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,13);
                    return 1;
                case	13	:		//	Tiefling
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Tiefling_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Tiefling_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",14);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,14);
                    return 1;
                case	14	:		//	HalfElf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Half_Elf_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Half_Elf_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",15);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,15);
                    return 1;
                case	15	:		//	HalfOrc
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Half_Orc_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Half_Orc_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",16);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,16);
                    return 1;
                case	16	:		//	Human
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Human_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Human_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",17);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,17);
                    return 1;
                case	17	:		//	Air_Genasi
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Air_Genasi_NX1_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Air_Genasi_NX1_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",18);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,18);
                    return 1;
                case	18	:		//	Earth_Genasi
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Earth_Genasi_NX1_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Earth_Genasi_NX1_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",19);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,19);
                    return 1;
                case	19	:		//	Fire_Genasi
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Fire_Genasi_NX1_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Fire_Genasi_NX1_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",20);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,20);
                    return 1;
                case	20	:		//	Water_Genasi
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Water_Genasi_NX1_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Water_Genasi_NX1_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",21);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,21);
                    return 1;
                case	21	:		//	HalfDrow
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Half_Drow_NX1_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Half_Drow_NX1_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",43);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,43);
                    return 1;
                case	22	:		//	HalfCelestial
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Assimar_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Assimar_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",46);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,46);
                    return 1;
                case	23	:		//	YuantiPureblood
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_YuantiPureblood_NX2_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_YuantiPureblood_NX2_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",47);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,47);
                    return 1;
                case	24	:		//	GrayOrc
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_GreyOrc_NX2_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_GreyOrc_NX2_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",48);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,48);
                    return 1;
                case	25	:		//	StarElf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Elf_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Elf_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",67);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,67);
                    return 1;
                case	26	:		//	PaintedElf
                    if(nGender == 0){
                        SetCreatureAppearanceType(oTarget,App_Elf_Wood_male);     
                    }else{
                        SetCreatureAppearanceType(oTarget,App_Elf_Wood_female);
                   }
                    SetLocalInt(oTarget,"nFakeRace",68);
                    SetLocalInt(oTarget,"nRaceChanged",1);
                    RemoveRacialAbilities(oTarget,nCurrentSubRace);
                    AddRacialAbilities(oTarget,68);
                    return 1;
                default : return 0;
            }
        }
        else
        {
            return 0;
            
        }

    return 0;
}

void TwoDimensions(object oCaster)
{
    effect eConc = EffectConcealment(85);
    effect eImmob = EffectCutsceneParalyze();
    effect eImmun1 = EffectImmunity(IMMUNITY_TYPE_POISON);
    effect eImmun2 = EffectImmunity(IMMUNITY_TYPE_DISEASE);
    effect eImmun3 = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
    effect eImmun4 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,100);
    effect eImmun5 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC,100);
    effect eImmun6 = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
    effect eSkill1 = EffectSkillDecrease(SKILL_SPOT,4);
    effect eSkill2 = EffectSkillDecrease(SKILL_LISTEN,4);
    effect eLink = EffectLinkEffects(eConc,eImmob);
    eLink = EffectLinkEffects(eLink,eImmun1);
    eLink = EffectLinkEffects(eLink,eImmun2);
    eLink = EffectLinkEffects(eLink,eImmun3);
    eLink = EffectLinkEffects(eLink,eImmun4);
    eLink = EffectLinkEffects(eLink,eImmun5);
    eLink = EffectLinkEffects(eLink,eImmun6);
    eLink = EffectLinkEffects(eLink,eSkill1);
    eLink = EffectLinkEffects(eLink,eSkill2);
    
    
    effect ePolyFX = EffectVisualEffect(VFX_IMP_POLYMORPH);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,ePolyFX,oCaster);
    
    float fDur = RoundsToSeconds(2+d8(1));
    
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCaster, fDur);
    
    float fScaleX = GetScale(oCaster,SCALE_X);
    float fScaleY = GetScale(oCaster,SCALE_Y);
    float fScaleZ = GetScale(oCaster,SCALE_Z);
        
    int nRand = d2(1);
    
    if(nRand == 1)
    {
        SetScale(oCaster,0.02,fScaleY,fScaleZ);
    }
    else
    {
        SetScale(oCaster,fScaleX,0.02,fScaleZ);
    }

    DelayCommand(fDur,SetScale(oCaster,fScaleX,fScaleY,fScaleZ));
}

//////////////////////////////////////////////////
//:: Shaz functions

//:: Selects a completely random spell from any in the game (cleric, druid, ect), and casts it at an appropriate target
//:: Note: the spell is treated as having come from OBJECT_SELF for the purposes of spell resistance, absorbtion, ect.
//:: This function returns the SpellID of the spell it cast
int ShazCastRandomSpellAtRandomTarget()
{
	object oPC = GetFirstPC();
	int iSpellID;
	location lCast;
	vector vCast;
	
	// the spell should appear to come from nowhere and smack into them
	lCast = GetRandomLocation(GetArea(OBJECT_SELF), OBJECT_SELF, 10.0f);
	vCast = GetPositionFromLocation(lCast);
	vCast.z += 3.0f;
	lCast = Location(GetArea(OBJECT_SELF), vCast, IntToFloat(Random(360)));
	
	//SendMessageToPC(oPC, "Object self is: " + GetName(OBJECT_SELF) + " tag: " + GetTag(OBJECT_SELF));
	
	iSpellID = ShazGetAnyRandomValidSpellID();
	
	//SendMessageToPC(oPC, "Random Spell Surge selects: " + JXGetSpellName(iSpellID));
	
	// Shaz: shooting spells out into empty areas can get pretty boring, so I'll give a 50/50 it targets an object
	if((JXGetHasSpellTargetTypeArea(iSpellID) == TRUE) && (Random(100) < 50) && !ShazIsSummoningSpell(iSpellID)) {
		// select a random location to shoot it at
		// Get a random location in the spell range
		float fRange = JXGetSpellRange(iSpellID);
		location lTo = GetRandomLocation(GetArea(OBJECT_SELF), OBJECT_SELF, fRange);
	
		// Cast the spell at the random location
		JXCastSpellFromLocationAtLocation(GetLocation(OBJECT_SELF), lTo, iSpellID, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE, OBJECT_SELF);
		
		//SendMessageToPC(oPC, "Random spell surge targets an area!");
	} else {
		object oRandomTarget = GetRandomCreatureInArea(OBJECT_SELF, OBJECT_SELF, 50.0f, TRUE, TRUE);
		
		if(GetIsObjectValid(oRandomTarget)) {
			
			if(ShazIsSummoningSpell(iSpellID)) {
				// these appear to need to be cast from the target at the target, we'll try that here
				AssignCommand(oRandomTarget, ClearAllActions());
				JXCastSpellFromObjectAtObject(oRandomTarget, oRandomTarget, iSpellID, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE);
				
				//SendMessageToPC(oPC, "Random spell surge casts SELF spell on: " + GetName(oRandomTarget) + " tag: " + GetTag(oRandomTarget));
			} else {
				
				JXCastSpellFromLocationAtObject(lCast, oRandomTarget, iSpellID, JXGetMetaMagicFeat(), JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE, OBJECT_SELF);
				
				//SendMessageToPC(oPC, "Random spell surge targets: " + GetName(oRandomTarget) + " tag: " + GetTag(oRandomTarget));
			}
		} else {
			SendMessageToPC(oPC, "Random spell surge target INVALID!!!");
		}
	}
	
	return iSpellID;
}

void ShazCastSpellOnObject(object oCaster, int iSpellID)
{
	location lCaster = GetLocation(oCaster);
	int iCasterLevel = JXGetCasterLevel(oCaster);
	int iSpellSaveDC = 10 + iCasterLevel;

	JXCastSpellFromLocationAtObject(lCaster, oCaster, iSpellID, METAMAGIC_NONE, iCasterLevel, iSpellSaveDC, TRUE, oCaster);
}

void ShazCastSpellOnCasterFromTarget(object oCaster, object oTarget, int iSpellID)
{
	int iCasterLevel = JXGetCasterLevel(oCaster);
	int iSpellSaveDC = 10 + iCasterLevel;

	JXCastSpellFromObjectAtObject(oTarget, oCaster, iSpellID, METAMAGIC_NONE, iCasterLevel, iSpellSaveDC, TRUE);
}

// this is used to create an object in a DelayCommand
void ShazCreateObjectVoid(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="")
{
	object oWhatever = CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag);
}

// this function will destroy all clothing, padded armor, cloaks, and gloves (not gauntlets) on the target
// If it destroys what they were wearing, it puts "Barest of rags" onto them, to make them appear more appropriately "unclothed"
void ShazDestroyAllClothOnTarget(object oTarget)
{
	object oItem = GetFirstItemInInventory(oTarget);
	
	string sItemName;
	string sItemTag;
	int iItemDestroyed = 0;
	
	// first, scan their inventory (their "backpack")
	while (GetIsObjectValid(oItem))
	{
		sItemTag = GetTag(oItem);
		sItemName = GetName(oItem);
		// these checks should get all the armor
		if ((FindSubString(sItemTag, "CLOTH") >=0) || (FindSubString(sItemTag, "cloth") >=0) || (FindSubString(sItemTag, "pca_dragon") >= 0) || (FindSubString(sItemTag, "pca_duelist") >= 0)  || (FindSubString(sItemTag, "pca_sacredfist") >= 0))	{
			DestroyObject(oItem);
			iItemDestroyed= 1;
		} else if((FindSubString(sItemName, "Padded") >=0) || (FindSubString(sItemName, "Gloves") >=0)) {
			DestroyObject(oItem);
			iItemDestroyed = 1;
		} else if(GetBaseItemType(oItem) == BASE_ITEM_CLOAK) {
			// I'm assuming all cloaks are cloth. Sounds fair to me
			DestroyObject(oItem);
			iItemDestroyed = 1;
		}
		if(iItemDestroyed) {
			SendMessageToPC(oTarget, "Your " + sItemName + " crumbles to dust!");
		}
		
		// Now move on to the next item
		oItem = GetNextItemInInventory(oTarget);
		iItemDestroyed = 0;
	} // End while loop

	// check their equiped armor as well
	oItem  = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
	iItemDestroyed = 0;
	sItemTag = GetTag(oItem);
	sItemName = GetName(oItem);
	// Check the tag on the current item
	if ((FindSubString(sItemTag, "CLOTH") >=0) || (FindSubString(sItemTag, "cloth") >=0) || (FindSubString(sItemTag, "pca_dragon") >= 0) || (FindSubString(sItemTag, "pca_duelist") >= 0))	{
		DestroyObject(oItem);
		iItemDestroyed = 1;
	} else if((FindSubString(sItemName, "Padded") >=0)) {
		DestroyObject(oItem);
		iItemDestroyed = 1;
	} else if(GetBaseItemType(oItem) == BASE_ITEM_CLOAK) {
		// I'm assuming all cloaks are cloth. Sounds fair to me
		DestroyObject(oItem);
		iItemDestroyed = 1;
	}
	
	if(iItemDestroyed) {
		SendMessageToPC(oTarget, "Your " + sItemName + " crumbles to dust!");
		// if you destory what they were wearing, give them urchin rags in their place...
		// well it will look better with Always Summer mod ;-)
		// I mean, they're supposed to be naked, you just destroyed all their clothing... how can we get it to look like that...?
		// SHAZ: ok i've used Ransom's "non-replacing" stuff to make it so anyone and everyone hit by this will be popped into a miniscule amount of clothing
		object oNewRags = CreateItemOnObject("cloth110", oTarget, 1,"",0);
		if(GetIsObjectValid(oItem)) {
			AssignCommand(oTarget, forceEquip(oTarget, oNewRags, INVENTORY_SLOT_CHEST));
//			AssignCommand(oTarget, ClearAllActions());
//			AssignCommand(oTarget, ActionEquipItem(oNewRags, INVENTORY_SLOT_CHEST));
//			DelayCommand(0.5f, oTarget, forceEquip(oTarget, oNewRags, INVENTORY_SLOT_CHEST));
//			DelayCommand(1.0f, oTarget, forceEquip(oTarget, oNewRags, INVENTORY_SLOT_CHEST));
//			DelayCommand(1.5f, oTarget, forceEquip(oTarget, oNewRags, INVENTORY_SLOT_CHEST));
		}
	}
	
	
	oItem  = GetItemInSlot(INVENTORY_SLOT_CLOAK,oTarget);
	iItemDestroyed = 0;
	sItemName = GetName(oItem);
	if(GetIsObjectValid(oItem)) {
		DestroyObject(oItem);
		iItemDestroyed = 1;
		SendMessageToPC(oTarget, "Your " + sItemName + " crumbles to dust!");
	}
	
	oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
	iItemDestroyed = 0;
	sItemName = GetName(oItem);
	if(GetIsObjectValid(oItem) && (FindSubString(sItemName,"Gloves") >= 0)) {
		DestroyObject(oItem);
		iItemDestroyed = 1;
		SendMessageToPC(oTarget, "Your " + sItemName + " crumbles to dust!");
	}
}

// Does a bang effect like surge #52 in the ToM suggests, but also deafen's targets for awhile
// also, returns 1 if it ignored a creature, else 0
int ShazDoDeafeningBang(location lLocation, object oIgnoreCreature=OBJECT_INVALID)
{
	int iIgnoredCreature=0;
	
	// create a visual at the location
	effect eAOE = EffectVisualEffect(VFX_DUR_SHOCK_WAVE);//VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE);//VFX_FNF_SOUND_BURST);
	JXApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAOE, lLocation);
	//JXApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oIgnoreCreature, 15.0f);
	
	effect eStun = EffectStunned();
	effect eVis = EffectVisualEffect( VFX_HIT_SPELL_SONIC );
	effect eMind = EffectVisualEffect(VFX_DUR_STUN);
	effect eLink = EffectLinkEffects(eStun, eMind);
	effect eDeafen = EffectDeaf();
	
	// search thru all creatures in the aoe
	object oCurrent = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_VAST, lLocation);
	while (GetIsObjectValid(oCurrent)) {
		if(oCurrent != oIgnoreCreature) {
			// if they aren't deaf already, stun them & deafen them
			if(!MySavingThrow(SAVING_THROW_FORT, oCurrent, JXGetSpellSaveDC(), SAVING_THROW_TYPE_SONIC))
	        {
				JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCurrent, RoundsToSeconds(d3()));
			}
			JXApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oCurrent);
			JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeafen, oCurrent, RoundsToSeconds(d3(2)));
		} else {
			iIgnoredCreature=1;
		}
		oCurrent = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_VAST, lLocation);
	}
	
	return iIgnoredCreature;
}

//:: Causes an explosion size large (slightly smaller than a fireball)
//:: of the desired iDamageType (some types not supported, and will be treated as straight magic)
//:: doing damage of d4(iStrength). it is resistable, and can be evaded (like fireball)
void ShazDoExplosion(location lLocation, int iDamageType, int iStrength=1)
{
	effect eAOEVis;
	effect eImpactVis;
	effect eDam;
	effect eLink;
	int iSaveType;
	int iDamage;
	
	object oPC = GetFirstPC(); // for debug purposes only
	
	// first set up visual effects
	switch(iDamageType) {
		case DAMAGE_TYPE_ACID:
			eAOEVis = EffectVisualEffect(VFX_HIT_AOE_ACID);
			eImpactVis = EffectVisualEffect(VFX_COM_HIT_ACID);
			iSaveType = SAVING_THROW_TYPE_ACID;
			break;
		case DAMAGE_TYPE_COLD:
			eAOEVis = EffectVisualEffect(VFX_HIT_AOE_ICE);
			eImpactVis = EffectVisualEffect(VFX_COM_HIT_FROST);
			iSaveType = SAVING_THROW_TYPE_COLD;
			break;
		case DAMAGE_TYPE_ELECTRICAL:
			eAOEVis = EffectVisualEffect(VFX_HIT_AOE_LIGHTNING);
			eImpactVis = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
			iSaveType = SAVING_THROW_TYPE_ELECTRICITY;
			break;
		case DAMAGE_TYPE_FIRE:
			eAOEVis = EffectVisualEffect(VFX_HIT_AOE_FIRE);
			eImpactVis = EffectVisualEffect(VFX_COM_HIT_FIRE);
			iSaveType = SAVING_THROW_TYPE_FIRE;
			break;
		case DAMAGE_TYPE_SONIC:
			eAOEVis = EffectVisualEffect(VFX_HIT_AOE_SONIC);
			eImpactVis = EffectVisualEffect(VFX_COM_HIT_SONIC);
			iSaveType = SAVING_THROW_TYPE_SONIC;
			break;
		case DAMAGE_TYPE_NEGATIVE:
			eAOEVis = EffectVisualEffect(VFX_HIT_AOE_NECROMANCY);
			eImpactVis = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);
			iSaveType = SAVING_THROW_TYPE_NEGATIVE;
			break;
		default:
			eAOEVis = EffectVisualEffect(VFX_HIT_AOE_MAGIC);
			eImpactVis = EffectVisualEffect(VFX_HIT_SPELL_MAGIC);
			iSaveType = SAVING_THROW_TYPE_SPELL;
			break;
	}
	// now apply the AOE visual
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAOEVis, lLocation);
	
	// Following copied from nw_s0_fireball
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
		// everyone and everything is a target for this effect. Sucks for them!
        //if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    	//{
			//Fire cast spell at event for the specified target
			// SHAZ: won't do this, since their friends are exploding for unknown reasons; no one would know how to react anyway
			//SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIREBALL));
			//Get the distance between the explosion and the target to calculate delay
			//fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
			
			// Shaz: this has deep implications - since OBJECT_SELF is usually the wildmage,
			//  it will use their caster level to overcome resistances; this is wierd, but, whatever
			// also, who knows what spell variables will get used in here - i don't...
			if (!MyResistSpell(OBJECT_SELF, oTarget)) {
				//Roll damage for each target
                iDamage = d4(iStrength);
				
				int nSpellLvl = GetSpellLevel(JXGetSpellId());
				if (GetHasSpellEffect(FEAT_LYRIC_THAUM_SONIC_MIGHT, OBJECT_SELF))					
				{	iDamage += d6(nSpellLvl); }
					
				if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD, OBJECT_SELF))
				{
					if (iDamageType == DAMAGE_TYPE_COLD)
					{	iDamageType = DAMAGE_TYPE_MAGICAL;	}
					if (iSaveType == SAVING_THROW_TYPE_COLD)
					{	iSaveType = SAVING_THROW_TYPE_SPELL;	}
				}
				
				//Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
				iDamage = Bot9sReflexAdjustedDamage(iDamage, oTarget, 20, iSaveType);
				
				//Set the damage effect
				eDam = EffectDamage(iDamage, iDamageType);
				if(iDamage > 0) {
					// Apply effects to the currently selected target.
					JXApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
					//This visual effect is applied to the target object not the location as above.  This visual effect
					//represents the flame that erupts on the target not on the ground.
					JXApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget);
				}
			}
        //}
		//Select the next target within the spell shape.
		oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	}
}

// copied from x0_s3_gemspray, modified to have more gems, 
// drop them on the ground around the targets, 
// and create some even if there aren't any targets hit
void ShazDoFlyingGems(object oCaster, location lTarget)
{
	location lRandom;
    vector vOrigin = GetPosition(oCaster);
	// NOTE!!! SHAPE_CONE IS BROKEN!!!!! its not a cone at all. it doesn't work. It grabes dudes at random. it sucks. REPLACE!
    object oTarget = GetFirstObjectInShape(SHAPE_CONE,
                                           10.0,
                                           lTarget,
                                           TRUE,
                                           OBJECT_TYPE_CREATURE,
										   vOrigin); //::2d2f I think you forgot to add this
    int nGems, nDamage, nRand, i, iTargetsHit;
	float fRandom;
	float fRandomDelay; //:2d2f - added this so that gems do not all apear at once
	iTargetsHit = 0;
    while (GetIsObjectValid(oTarget)) {

        nGems = Random(5) + 1;
        nDamage = 0;
        for (i=0; i < nGems; i++) {
            // Create the gems on the target
            string sResRef = "nw_it_gem0";
            nRand = Random(20);
            if (nRand < 3) {	// 0-2
                sResRef += "10"; // topaz, a nice windfall
            } else if (nRand < 7) {	//4-6
                sResRef += "06";	// ruby
			} else if (nRand < 12) {	// 8-11
				sResRef += "11";	// garnet
            } else if (nRand < 14) { //12-13
                sResRef += "05";	// diamond
			} else if (nRand < 18) {	// 14-17
				sResRef += "03";	// Amethyst
            } else {	// 18-20
                sResRef += "08";	// sapphire
            }
            //object oGem = CreateItemOnObject(sResRef,oTarget);
			fRandom = Random(20) / 10.0f;
			fRandomDelay = IntToFloat(Random(6));
			lRandom = GetRandomLocation(GetArea(oTarget), oTarget, fRandom); 
			//DelayCommand(0.2f, ShazCreateObjectVoid(OBJECT_TYPE_ITEM, sResRef, lRandom));
			DelayCommand(fRandomDelay, ShazCreateObjectVoid(OBJECT_TYPE_ITEM, sResRef, lRandom));
			
            nDamage += d4();
        }
		
		//Let the target know they had a spell shot at them
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_MISSILE));

        // Make Reflex save to halve
        if ( MySavingThrow(SAVING_THROW_REFLEX, oTarget, 14)) {
            nDamage = nDamage/2;
        }

        DelayCommand(0.01, JXApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING),
                            oTarget));

        oTarget = GetNextObjectInShape(SHAPE_CONE, 
                                           10.0, 
										   lTarget,
                                           TRUE,
                                           OBJECT_TYPE_CREATURE,
										   vOrigin); //2d2f:: I think you forgot to add this

		iTargetsHit++;
    }
	
	//SendMessageToPC(oCaster, "Number Creatures in Gem cone: " + IntToString(iTargetsHit));
	
	if(iTargetsHit < 2) {
		// then, we should pepper a few in the area
		// we really should figure out a good spot for them if the target is out of range
		// but, thats complex and not real important so for now ill just fire them at the target location
		object oCenterTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lTarget, FALSE, "shaz_gmspry_cntr");
		DestroyObject(oCenterTarget, 3.0f);
	    nGems = Random(5) + 1;
	    for (i=0; i < nGems; i++) {
	    	// Create the gems on the target
	    	string sResRef = "nw_it_gem0";
	    	nRand = Random(20);
			if (nRand < 3) {	// 0-2
			    sResRef += "10"; // topaz, a nice windfall
			} else if (nRand < 7) {	//4-6
			    sResRef += "06";	// ruby
			} else if (nRand < 12) {	// 8-11
				sResRef += "11";	// garnet
			} else if (nRand < 14) { //12-13
			    sResRef += "05";	// diamond
			} else if (nRand < 18) {	// 14-17
				sResRef += "03";	// Amethyst
			} else {	// 18-20
			    sResRef += "08";	// sapphire
			}
			fRandom = Random(20) / 4.0f;
			fRandomDelay = IntToFloat(Random(6));
			lRandom = GetRandomLocation(GetAreaFromLocation(lTarget), oCenterTarget, fRandom);
			DelayCommand(fRandomDelay,ShazCreateObjectVoid(OBJECT_TYPE_ITEM, sResRef, lRandom));
			
			//object oGem = CreateObject(OBJECT_TYPE_ITEM, sResRef, lRandom);
		}
	}
	
	// visual effect
	effect eVis = EffectVisualEffect(VFX_DUR_GEMSPRAY); //:2d2f - changed to custom vfx
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oCaster, RoundsToSeconds(1)); //:2d2f changed duration to 1 round
}

//:: A function called periodically on the victim, applies a debuf unless the victim has no armor on
void ShazDoItchyClothing(object oVictim)
{
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oVictim);
	
	if(GetIsObjectValid(oArmor)) {
		effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);
		effect eIcon = EffectEffectIcon(44);
		effect eIconFail = EffectEffectIcon(110);
		effect eSpellFail = EffectArcaneSpellFailure(20);
		effect eLink;
		eLink = EffectLinkEffects(eLink, eSkill);
		eLink = EffectLinkEffects(eLink, eIcon);
		eLink = EffectLinkEffects(eLink, eIconFail);
		eLink = EffectLinkEffects(eLink, eSpellFail);
		
		
		SendMessageToPC(oVictim, "Your clothes & armor itch, distracting you!");
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oVictim, RoundsToSeconds(2));
		
	} else {
		SendMessageToPC(oVictim, "Your lack of clothing gives you temporary relief from the itching.");
	}
	int iItchRoundsLeft = GetLocalInt(oVictim, "ItchRoundsLeft");
	iItchRoundsLeft -= 2;
	SetLocalInt(oVictim, "ItchRoundsLeft", iItchRoundsLeft);
	if(iItchRoundsLeft > 0) {
		DelayCommand(RoundsToSeconds(2)+1.0, ShazDoItchyClothing(oVictim));
	}
}

//:: A function called periodically on the victim, applies a debuf and interups their action queue if they fail concentration roll
void ShazDoHiccups()
{
	if(GetIsDead(OBJECT_SELF) == 0) {
		SpeakString("Hiccup!");
		
		// do a concentration check
		if(GetIsSkillSuccessful(OBJECT_SELF, SKILL_CONCENTRATION, 25) == 0) {
			// apply debuff
			effect eToHit = EffectAttackDecrease(2);
			effect eSpellFail = EffectSpellFailure(30);
			effect eLink = EffectLinkEffects(eLink, eToHit);
			eLink = EffectLinkEffects(eLink, eSpellFail);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(1));
			
			// interrupt thier action queue
			ClearAllActions(TRUE);
		}
	
		int iHiccupRoundsLeft = GetLocalInt(OBJECT_SELF, "HiccupRoundsLeft");
		iHiccupRoundsLeft -= 1;
		SetLocalInt(OBJECT_SELF, "HiccupRoundsLeft", iHiccupRoundsLeft);
		if(iHiccupRoundsLeft > 0) {
			DelayCommand(RoundsToSeconds(1)+1.0, ShazDoHiccups());
		}
	} else {
		SetLocalInt(OBJECT_SELF, "HiccupRoundsLeft", 0);
	}
}

//:: Called periodically on the person levitating, makes adjacent enemies without ranged weapons highly innacurate
//::  also does the same to the person levitating
void ShazDoLevitation()
{
	// OBJECT_SELF is expected to be the person levitating
	object oCreature;
	object oWeapon;
	float fMeleeRange = 3.0f;
	int iNumAffectedCreatures = 0;
	
	if(GetIsDead(OBJECT_SELF) == 0) {
		//SendMessageToPC(OBJECT_SELF, "Testing levitation effects");
		// go through all enemies in a very small area
		oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fMeleeRange, GetLocation(OBJECT_SELF));
	    while(GetIsObjectValid(oCreature))
	    {
			//SendMessageToPC(OBJECT_SELF, "  testing a creature");
			if(oCreature != OBJECT_SELF) {
				// assume large creatures are adjacent - but medium creatures, they might not be
				if((GetCreatureSize(oCreature) >= CREATURE_SIZE_LARGE) || (GetCreatureSize(OBJECT_SELF) >= CREATURE_SIZE_LARGE) || (GetDistanceBetween(OBJECT_SELF, oCreature) <= 2.0f)) {
					// check if the creature has a bow
					// should we check the creature weapon slots? I have no idea...
					oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCreature);
			        if (!GetIsObjectValid(oWeapon))
			        {
			            oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oCreature);
			        }
					if((GetWeaponRanged(oWeapon) == FALSE) && (GetIsEnemy(OBJECT_SELF, oCreature) == TRUE)) {
						//SendMessageToPC(OBJECT_SELF, "  Creature is enemy and has no ranged");
						if(spellsIsFlying(oCreature)) {
							// if they are a flying creature, they would probaby actually have an easier time hitting you
							effect eAttack = EffectAttackIncrease(2);
							JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oCreature, 7.0f);
							SendMessageToPC(oCreature, "The creature hovering in the air is easier for you to attack");
							SendMessageToPC(OBJECT_SELF, "Your levitation makes it easier for the flying enemy to attack you!!");
						} else {
							// enemy nearby without a ranged weapon - assume they are attacking us and give a horrendus penalty to hit
							//int iAttackMod = 0;
							int iMissChance = 0;
							switch(GetCreatureSize(oCreature)) {
								case CREATURE_SIZE_TINY:
								case CREATURE_SIZE_SMALL:
									// would be impossible to hit from there
									//iAttackMod = 40;
									iMissChance = 98;
									SendMessageToPC(oCreature, "You cannot reach your hovering enemy at all!");
									break;
								case CREATURE_SIZE_MEDIUM:
									// still very hard to hit
									//iAttackMod = 15;
									iMissChance = 80;
									SendMessageToPC(oCreature, "You cannot reach your hovering enemy!");
									break;
								case CREATURE_SIZE_LARGE:
									// they can start to reach you here
									//iAttackMod = 5;
									iMissChance = 40;
									SendMessageToPC(oCreature, "The hovering enemy is barely within reach, and therefore harder to hit");
									break;
								case CREATURE_SIZE_HUGE:
									//iAttackMod = 0; // no penalty, they can reach you fine
									iMissChance = 0;
									break;
								default:
									//iAttackMod = 5;
									iMissChance = 40;
									SendMessageToPC(oCreature, "The hovering enemy is barely within reach, and therefore harder to hit");
									break;
							}
							//effect eAttack = EffectAttackDecrease(iAttackMod);
							effect eMiss = EffectMissChance(iMissChance, MISS_CHANCE_TYPE_VS_MELEE);
							JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMiss, oCreature, 7.0f);
							iNumAffectedCreatures++;
						}	// end else not flying
						
					} // else not enemy or has ranged weapon
				} // else is a medium (or smaller) creature too far away
			} // else is objectself
			
			oCreature = GetNextObjectInShape(SHAPE_SPHERE, fMeleeRange, GetLocation(OBJECT_SELF));
		} // end while object valid
		
		if(iNumAffectedCreatures > 0) {
			SendMessageToPC(OBJECT_SELF, "The enemy cannot reach you and suffers a penalty to attack!");
		}
		
		// if we dont' have a ranged weapon equipped, penalize our attack
		oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
        if (!GetIsObjectValid(oWeapon))
        {
            oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
        }
		if(GetWeaponRanged(oWeapon) == FALSE) {
			// don't apply the melee penalties unless there was actually someone nearby to melee attack
			if(iNumAffectedCreatures > 0) {
				if(GetIsObjectValid(oWeapon) == TRUE) {
					SendMessageToPC(OBJECT_SELF, "You can't reach the enemy with your " + GetName(oWeapon) + "!");
				} else {
					SendMessageToPC(OBJECT_SELF, "You can't reach the enemy!");
				}
				//effect eAttackDown = EffectAttackDecrease(15);
				//JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackDown, OBJECT_SELF, 7.0f);
				effect eMissChance = EffectMissChance(70, MISS_CHANCE_TYPE_VS_MELEE);
				JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMissChance, OBJECT_SELF, 7.0f);
			}
		} else {
			// even if we do have a ranged weapon, we still need to be penalized a bit
			SendMessageToPC(OBJECT_SELF, "You can't steady yourself and suffer a penalty to attack");
			effect eAttackDown = EffectAttackDecrease(3);
			JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackDown, OBJECT_SELF, 7.0f);
		}
		
		// re-queue the levitation effects
		int iLevitationRoundsLeft = GetLocalInt(OBJECT_SELF, "LevitationRoundsLeft");
		iLevitationRoundsLeft -= 1;
		SetLocalInt(OBJECT_SELF, "LevitationRoundsLeft", iLevitationRoundsLeft);
		if(iLevitationRoundsLeft > 0) {
			DelayCommand(RoundsToSeconds(1)+0.5, ShazDoLevitation());
		}
	} else { // object self is dead
		SetLocalInt(OBJECT_SELF, "LevitationRoundsLeft", 0);
	}
}

//:: called periodically on the living spell elemental
//:: causes the objectself (living spell) to attack the nearest target, friend or foe
//:: if it is a hostile creature, the elemental switches itself to defender faction
//:: if it is a non-hostile creature, it switches itself to hostile faction
//:: also, it has a 50% chance to ignore any targets it's hit (they get the "SpellElemHit" tag)
void ShazDoLivingSpellAI()
{
	object oTarget;
	int iNth = 1;
	int iFoundTarget = FALSE;
	if(GetIsDead(OBJECT_SELF) == 0) {
	
		oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE , OBJECT_SELF, iNth,CREATURE_TYPE_PERCEPTION , PERCEPTION_SEEN);
		while(GetIsObjectValid(oTarget) && (iFoundTarget == FALSE)) {
			if((GetLocalInt(oTarget, "SpellElemHit") < 0) || (d100(1) <= 50)) {
				iFoundTarget = TRUE;
				if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oTarget) > 0) {
					ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_DEFENDER);
				} else {
					ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
				}
				DetermineCombatRound(oTarget);
			}
			iNth++;
			oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE , OBJECT_SELF, iNth,CREATURE_TYPE_PERCEPTION , PERCEPTION_SEEN);
		}
		
		DelayCommand(3.0f, ShazDoLivingSpellAI());
	}
}

//:: A function called periodically on a vicitm, makes them incapable of any movement as long as they have any magic items equipped
void ShazDoMagicAllergy()
{
	if(GetIsDead(OBJECT_SELF) == 0) {
		
		// go thru their equipped items, check each for magical properties
		object oItem = ShazGetFirstEquippedMagicItem(OBJECT_SELF);
		
		// note: SendMessageToPC() about which item they were allergic to
		if(oItem != OBJECT_INVALID) {
			SpeakString("Ah-CHO!!!");
			SendMessageToPC(OBJECT_SELF, "You are allergic to your " + GetName(oItem) + "!");
			SendMessageToPC(OBJECT_SELF, "Your sneezing fit prevents you from taking any action!");
			effect eDaze = EffectDazed();
			
			JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, OBJECT_SELF, RoundsToSeconds(1));
		}
		
		// re-queue the sneezing
		int iAllergyRoundsLeft = GetLocalInt(OBJECT_SELF, "AllergyRoundsLeft");
		iAllergyRoundsLeft -= 1;
		SetLocalInt(OBJECT_SELF, "AllergyRoundsLeft", iAllergyRoundsLeft);
		if(iAllergyRoundsLeft > 0) {
			DelayCommand(RoundsToSeconds(1)+1.0, ShazDoMagicAllergy());
		} else {
			SendMessageToPC(OBJECT_SELF, "You feel your magic allergy has subsided...");
		}
	} else {
		SetLocalInt(OBJECT_SELF, "AllergyRoundsLeft", 0);
	}
}

void ShazDominateCreature(object oCreature)
{
	effect eDominate = EffectCutsceneDominated();
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDominate, oCreature);
}

//:: Function called periodically on a victim, makes them sneeze
void ShazDoSneezing()
{
	if(GetIsDead(OBJECT_SELF) == 0) {
		SpeakString("Ahh... Ahh... Ah-CHO!!!");
		
		// interrupt thier action queue
		ClearAllActions(TRUE);
		
		// re-queue the sneezing
		int iSneezeRoundsLeft = GetLocalInt(OBJECT_SELF, "SneezeRoundsLeft");
		iSneezeRoundsLeft -= 1;
		SetLocalInt(OBJECT_SELF, "SneezeRoundsLeft", iSneezeRoundsLeft);
		if(iSneezeRoundsLeft > 0) {
			DelayCommand(RoundsToSeconds(1)+1.0, ShazDoSneezing());
		}
	} else {
		SetLocalInt(OBJECT_SELF, "SneezeRoundsLeft", 0);
	}
}

//:: Function called periodically on the victim, makes friendlies not in combat say something and try to get away
void ShazDoStinkReactions()
{
	//SendMessageToPC(OBJECT_SELF, "StinkPulse!");
	int i;
	// search thru all creatures in the aoe
	object oCurrent = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
	while (GetIsObjectValid(oCurrent)) {
		// creature must not be in combat, be a humanoid, and be alive
		if((oCurrent != OBJECT_SELF) && (GetIsInCombat(oCurrent) == FALSE) && (AmIAHumanoid(oCurrent) == TRUE) && (GetIsDead(oCurrent) == FALSE)) {
			// creatures only have a 50% chance to respond at all
			if(d100() <= 50) {
				// check if they are friend, foe, or ally
				if(GetIsRosterMember(oCurrent) == 1 || (GetIsHenchman(OBJECT_SELF, oCurrent) == 1)) {
					// they are player's henchman
					string sVictimName = GetFirstName(OBJECT_SELF);
					int iRand = Random(3);
					if(iRand == 0) {
						AssignCommand(oCurrent, SpeakString("You need a bath, " + sVictimName + "!!"));
					} else if(iRand == 1) {
						AssignCommand(oCurrent, SpeakString("Ug... did you loose a fight with a skunk, " + sVictimName + "?"));
					} else if(iRand == 2) {
						AssignCommand(oCurrent, SpeakString(sVictimName + "... you smell worse than a troglodyte!"));
					}
				} else if(GetIsEnemy(OBJECT_SELF, oCurrent)) {
					// if they are enemy, you must have snuck up on them somehow. I'm not sure how to tell them to detect you...
					int iRand = Random(2);
					if(iRand == 0) {
						AssignCommand(oCurrent, SpeakString("What is that horrible smell?!"));
					} else if(iRand == 1) {
						AssignCommand(oCurrent, SpeakString("I smell something... awful!"));
					}
					location lNewLoc = GetRandomLocation(GetArea(OBJECT_SELF), oCurrent, RADIUS_SIZE_HUGE);
					AssignCommand(oCurrent, ActionMoveToLocation(lNewLoc, TRUE));
					
				} else {
					// not hench, not enemy
					int iRand = Random(2);
					if(iRand == 0) {
						AssignCommand(oCurrent, SpeakString("Oh my God, what is that stench?!"));
					} else if(iRand == 1) {
						AssignCommand(oCurrent, SpeakString("Ugh, stay away from me, you smell like a pile of rotten fish!"));
					}
					// make them walk away
					float fAngle = GetAngleBetweenObjects(OBJECT_SELF, oCurrent);
					location lNewLoc = GenerateNewLocation(oCurrent, RADIUS_SIZE_HUGE + 5.0f, fAngle, fAngle);
					AssignCommand(oCurrent, ActionMoveToLocation(lNewLoc, TRUE));
				}
			}
		}
		i++;
		oCurrent = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
	}
	
	//SendMessageToPC(OBJECT_SELF, "Creatures Nearby: " + IntToString(i));
	
	int iStinkRoundsLeft = GetLocalInt(OBJECT_SELF, "StinkRoundsLeft");
	iStinkRoundsLeft -= 1;
	SetLocalInt(OBJECT_SELF, "StinkRoundsLeft", iStinkRoundsLeft);
	if(iStinkRoundsLeft > 0) {
		DelayCommand(RoundsToSeconds(1)+1.0, ShazDoStinkReactions());
	}
}

//:: creates an effect that gives -4 to hit & ac , slows movement, and prevents spellcasting
// Shaz: Almost a Daze, but with ability to attack, abliet at stiff penalties. I wonder if we should just apply ArcaneSpellFailure instead of a silence?
effect ShazEffectDizzy()
{
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_DAZE );
	effect eAC = EffectACDecrease(4, AC_DODGE_BONUS);
	effect eAttack = EffectAttackDecrease(4);
	effect eSlow = EffectMovementSpeedDecrease(50);
	effect eSilence = EffectSilence();
	effect eLink = EffectLinkEffects(eVis, eAC);
	
	eLink = EffectLinkEffects(eLink, eAttack);
	eLink = EffectLinkEffects(eLink, eSlow);
	eLink = EffectLinkEffects(eLink, eSilence);
	
	return eLink;
}

effect ShazEffectEnlarge()
{
	// shaz: copied this from nw_s0_enlrgeper.nss
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ENLARGE_PERSON);
	
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
    effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY, 2);
    effect eAtk = EffectAttackDecrease(1, ATTACK_BONUS_MISC);
    effect eAC = EffectACDecrease(1, AC_DODGE_BONUS);
    effect eDmg = EffectDamageIncrease(3, DAMAGE_TYPE_MAGICAL);	// Should be Melee-only!
    effect eScale = EffectSetScale(1.5);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eStr, eDex);
    eLink = EffectLinkEffects(eLink, eAtk);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDmg);
    eLink = EffectLinkEffects(eLink, eScale);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
	
	return eLink;
}


//:: create a random polymorph effect; this includes almost every single polymorph with a valid appearce in the 2da
// this Effect is slightly more likely to turn the target into an animal
effect ShazEffectRandomPolymorph(object oTarget)
{
	effect	ePoly;
	int 	iPolyRand = Random(39);
	int		iPolyIndex;
	
	switch(iPolyRand) {
		case 0:
			iPolyIndex = POLYMORPH_TYPE_WEREWOLF;
			break;
		case 1:
			iPolyIndex = POLYMORPH_TYPE_GIANT_SPIDER;
			break;
		case 2:
			iPolyIndex = POLYMORPH_TYPE_UMBER_HULK;
			break;
		case 3:
		case 4:
			iPolyIndex = POLYMORPH_TYPE_PIXIE;
			break;
		case 5:
			iPolyIndex = POLYMORPH_TYPE_ZOMBIE;
			break;
		case 6:
			iPolyIndex = POLYMORPH_TYPE_RED_DRAGON;
			break;
		case 7:
			iPolyIndex = POLYMORPH_TYPE_TROLL;
			break;
		case 8:
			iPolyIndex = POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL;
			break;
		case 9:
			iPolyIndex = POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL;
			break;
		case 10:
			iPolyIndex = POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL;
			break;
		case 11:
			iPolyIndex = POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL;
			break;
		case 12:
		case 13:
			iPolyIndex = POLYMORPH_TYPE_BOAR;
			break;
		case 14:
		case 15:
			iPolyIndex = POLYMORPH_TYPE_WOLF;
			break;
		case 16:
		case 17:
			iPolyIndex = POLYMORPH_TYPE_BADGER;
			break;
		case 18:
		case 19:
			iPolyIndex = POLYMORPH_TYPE_COW;
			break;
		case 20:
		case 21:
			iPolyIndex = POLYMORPH_TYPE_IMP;
			break;
		case 22:
			iPolyIndex = POLYMORPH_TYPE_SUCCUBUS;
			break;
		case 23:
			iPolyIndex = POLYMORPH_TYPE_DIRE_BOAR;
			break;
		case 24:
			iPolyIndex = 162; //Panther
			break;
		case 25:
		case 26:
			iPolyIndex = POLYMORPH_TYPE_CHICKEN;
			break;
		case 27:
			iPolyIndex = POLYMORPH_TYPE_WINTER_WOLF;
			break;
		case 28:
			iPolyIndex = POLYMORPH_TYPE_MINDFLAYER;
			break;
		case 29:
			iPolyIndex = 163; //DirePanther
			break;
		case 30:
			iPolyIndex = POLYMORPH_TYPE_DIRE_RAT;
			break;
		case 31:
			iPolyIndex = POLYMORPH_TYPE_SHAMBLING_MOUND;
			break;
		case 32:
			iPolyIndex = POLYMORPH_TYPE_BLUE_DRAGON;
			break;
		case 33:
			iPolyIndex = POLYMORPH_TYPE_BLACK_DRAGON;
			break;
		case 34:
			iPolyIndex = 164; //EmberGuard
			break;
		case 35:
			iPolyIndex = POLYMORPH_TYPE_PANTHER;
			break;
		case 36:
			iPolyIndex = POLYMORPH_TYPE_BALOR;
			break;
		case 37:
			iPolyIndex = POLYMORPH_TYPE_HORNED_DEVIL;
			break;
		case 38:
			iPolyIndex = POLYMORPH_TYPE_TREANT;
			break;
		default:
			iPolyIndex = POLYMORPH_TYPE_CHICKEN;
			break;
	}
	
	// Shaz: there are several things about the implementation of this effect I really don't like.
	//	#1: the natural armor is simply added to the creatures previous armor. Unacceptable! A red dragon changed into a boar would *increase* its AC!!!
	effect	eAC = EffectACDecrease(GetAC(oTarget) - 10);
	//	#2: the players handbook states that being changed into an unfamiliar form makes the victim suffer penalties in "stressful situations" we'll just make those permanent ;-)
	effect	eAttack = EffectAttackDecrease(2);
	effect	eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);
	effect	eSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_ALL);
	//effect	eDamage = EffectDamageDecrease(2);	// this one is my own doing; player's handbook doesn't say anything about it
	effect	eLink;
	effect	eLarge = EffectSetScale(1.5f);
	int nArcaneShapesCanCast = GetLocalInt(GetModule(), "ArcaneShapesCanCast");
	
	ePoly = EffectPolymorph(iPolyIndex, TRUE, nArcaneShapesCanCast);
	
	eLink = EffectLinkEffects(eLink, ePoly);
	eLink = EffectLinkEffects(eLink, eAC);
	eLink = EffectLinkEffects(eLink, eAttack);
	eLink = EffectLinkEffects(eLink, eSkill);
	eLink = EffectLinkEffects(eLink, eSaves);
	
	// The dragons look much too small so we'll scale em up a bit to make them look more... "realistic"
	if(iPolyIndex == POLYMORPH_TYPE_BLACK_DRAGON || iPolyIndex == POLYMORPH_TYPE_BLACK_DRAGON || iPolyIndex == POLYMORPH_TYPE_RED_DRAGON) {
		eLink = EffectLinkEffects(eLink, eLarge);
	}
	
	return eLink;
}

effect ShazEffectReduce()
{
	// shaz: copied this from nw_s0_enlrgeper.nss
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ENLARGE_PERSON);
	
	effect eStr = EffectAbilityDecrease(ABILITY_STRENGTH, 2);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 2);
    effect eAtk = EffectAttackIncrease(1, ATTACK_BONUS_MISC);
    effect eAC = EffectACIncrease(1, AC_DODGE_BONUS);
    effect eDmg = EffectDamageDecrease(3, DAMAGE_TYPE_MAGICAL);	// Should be Melee-only!
    effect eScale = EffectSetScale(0.5);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eStr, eDex);
    eLink = EffectLinkEffects(eLink, eAtk);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDmg);
    eLink = EffectLinkEffects(eLink, eScale);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
	
	return eLink;
}

// cast four fire walls around the target
void ShazEncloseTargetInFire(object oCaster, location lTarget)
{
	location lWall1, lWall2, lWall3, lWall4;
	vector vTarget, vTemp, vDir;
	object oArea = GetAreaFromLocation(lTarget);
	float fAngle;
	
	vTarget = GetPositionFromLocation(lTarget);
	// we need four locations
	vTemp = vTarget;
	vTemp.x = vTarget.x + 1.5f;
	vDir = vTemp - vTarget;
	//SendMessageToPC(oCaster, "Angle1 = " + FloatToString(VectorToAngle(vDir)));
	lWall1 = Location(oArea, vTemp, VectorToAngle(vDir));
	vTemp.x = vTarget.x - 1.5f;
	vDir = vTemp - vTarget;
	//SendMessageToPC(oCaster, "Angle2 = " + FloatToString(VectorToAngle(vDir)));
	lWall2 = Location(oArea, vTemp, VectorToAngle(vDir));
	vTemp.x = vTarget.x;
	vTemp.y = vTarget.y + 1.5f;
	vDir = vTemp - vTarget;
	//SendMessageToPC(oCaster, "Angle3 = " + FloatToString(VectorToAngle(vDir)));
	lWall3 = Location(oArea, vTemp, VectorToAngle(vDir));
	vTemp.y = vTarget.y - 1.5f;
	vDir = vTemp - vTarget;
	//SendMessageToPC(oCaster, "Angle4 = " + FloatToString(VectorToAngle(vDir)));
	lWall4 = Location(oArea, vTemp, VectorToAngle(vDir));
	
	lTarget = Location(oArea, vTarget, GetFacingFromLocation(lWall1));
	JXCastSpellFromLocationAtLocation(lTarget, lWall1, SPELL_WALL_OF_FIRE,METAMAGIC_NONE, JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE, oCaster);
	lTarget = Location(oArea, vTarget, GetFacingFromLocation(lWall2));
	JXCastSpellFromLocationAtLocation(lTarget, lWall2, SPELL_WALL_OF_FIRE,METAMAGIC_NONE, JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE, oCaster);
	lTarget = Location(oArea, vTarget, GetFacingFromLocation(lWall3));
	JXCastSpellFromLocationAtLocation(lTarget, lWall3, SPELL_WALL_OF_FIRE,METAMAGIC_NONE, JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE, oCaster);
	lTarget = Location(oArea, vTarget, GetFacingFromLocation(lWall4));
	JXCastSpellFromLocationAtLocation(lTarget, lWall4, SPELL_WALL_OF_FIRE,METAMAGIC_NONE, JXGetCasterLevel(), JXGetSpellSaveDC(), TRUE, oCaster);
}

//:: searches the target for buffs, dispelling magic ones (hopefully)
//:: and for each dispelled, causing a small explosion of a random element
//:: the strength of the explosion should depend on the innate spell level of the effect
void ShazExplodeMagicOnTarget(object oTarget)
{
	effect eEffect;
	
	string sInnate;
	int iLevel;
	int iSpellID;
	int iEffectsRemoved=0;
	int iDamageType;
	int iRemovedEffect=0;
	
	object oPC = GetFirstPC(); // for debug only
	
	if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT) {
		//SendMessageToPC(oPC, "Object is AOE!!!");
		// destroy it, and cause an explosion
		// I figure this is legit, because the game's dispel spells
		//  destroy AOE's apparently without checking if they are magical or not...
		DestroyObject(oTarget);
		// determine a random element
		iDamageType = Random(7);
		iDamageType = 1<<(iDamageType+3);
		// we don't have a divine damage explosion; it doesn't make much sense for this to deal divine damage
		if(iDamageType == DAMAGE_TYPE_DIVINE) {
			iDamageType = DAMAGE_TYPE_SONIC;
		}
		ShazDoExplosion(GetLocation(oTarget), iDamageType, 5);
	} else if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) {
		//SendMessageToPC(oPC, "Object is Placeable!!!");
		// Jallaix does some insanity with placeables. Should we skip them? destroy them? I have no idea!!!
	}
	
	eEffect = GetFirstEffect(oTarget);
	while(GetIsEffectValid(eEffect)) {
		iRemovedEffect = FALSE;
		iSpellID = GetEffectSpellId(eEffect);
		if(iSpellID > 0) {
			//if(ShazIsSpellCastable(iSpellID)) {
			if (GetEffectSubType(eEffect) == SUBTYPE_MAGICAL) {
				// its a castable spell, remove it
				//DelayCommand(iEffectsRemoved * 0.2f, RemoveEffect(oTarget, eEffect));
				RemoveEffect(oTarget, eEffect);
				//if((GetEffectType(eEffect) != EFFECT_TYPE_VISUAL_EFFECT) && (GetEffectType(eEffect) != EFFECT_TYPE_EFFECT_ICON)) {
				// record the innate level of the spell (for determining the strength of the explosion)
				sInnate = Get2DAString("spells", "Innate", iSpellID);
				iLevel = StringToInt(sInnate);
				// determine a random element
				iDamageType = Random(7);
				iDamageType = 1<<(iDamageType+3);
				// we don't have a divine damage explosion; it doesn't make much sense for this to deal divine damage
				if(iDamageType == DAMAGE_TYPE_DIVINE) {
					iDamageType = DAMAGE_TYPE_SONIC;
				}
				
				//int iEffectType = GetEffectType(eEffect);
				//SendMessageToPC(oPC, "Effect type is " + IntToString(iEffectType));
				//SendMessageToPC(oPC, "Damage type is " + IntToString(iDamageType));
				//SendMessageToPC(oPC, "Spell is " + JXGetSpellName(iSpellID));
				//SendMessageToPC(oPC, "Innate Spell Level is " + sInnate);
				
				DelayCommand(0.3f * IntToFloat(iEffectsRemoved), SendMessageToPC(oTarget, "Your " + JXGetSpellName(iSpellID) + " explodes!"));
				DelayCommand(0.3f * IntToFloat(iEffectsRemoved), ShazDoExplosion(GetLocation(oTarget), iDamageType, iLevel));

				iRemovedEffect = TRUE;
				iEffectsRemoved++;
				
			}
		} else {
			// effect was probably applied from outside a spell script - should we blow these up??
		}
		if(iRemovedEffect) {
			// if we removed an effect, start over to be safe about linked effects
			eEffect = GetFirstEffect(oTarget);
		} else {
			eEffect = GetNextEffect(oTarget);
		}
	} // end while effect valid
}

//:: Makes the lover person irrationally follow the love target around, defend it,
//:: and pretty much ignore everything else. Oh, and they also declare their love for oLoveTarget periodically.
void ShazFallInLove(object oLover, object oLoveTarget)
{
	// first, store references to each other on the lover and the loved
	SetLocalObject(oLover, "ShazLoved", oLoveTarget);
	SetLocalObject(oLoveTarget, "ShazLover", oLover);
	// we must replace the love-target's "on attacked" and "on spell cast at" scripts so we can inform the lovesick the object of their affection has been attacked
//	string sLoveOnAttackOriginalScript = GetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_MELEE_ATTACKED);
//	SetLocalString(oLoveTarget, "ShazLoveOnAttackOriginalScript", sLoveOnAttackOriginalScript);
//	SetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_MELEE_ATTACKED, "shaz_onattacked_love");
	// replace "spell cast at"
//	string sLoveOnSpellAtOriginalScript = GetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_SPELLCASTAT);
//	SetLocalString(oLoveTarget, "ShazLoveOnSpellAtOriginalScript", sLoveOnAttackOriginalScript);
//	SetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_SPELLCASTAT, "shaz_onspellat_love");
	// replace "spell cast at", so that the target creature won't attack the lover unless he's the last one around
	string sLoveOnHeartOriginalScript = GetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_HEARTBEAT);
	SetLocalString(oLoveTarget, "ShazLoveOnHeartOriginalScript", sLoveOnHeartOriginalScript);
	SetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_HEARTBEAT, "shaz_onheart_love");
	//AssignCommand(oLoveTarget, ShazDominateCreature(oLover));
	if(GetIsOwnedByPlayer(oLover)) {
		AssignCommand(oLover, ShazLovePreventPlayerControl());
	}
	
	// what we will try to do here is replace the lover's scripts so we can control their AI
	SafeClearEventHandlers(oLover);
	// set some scripts
	SetAllEventHandlers(oLover, "");
	SetEventHandler(oLover, CREATURE_SCRIPT_ON_HEARTBEAT, "shaz_lover_onheart");
	SetEventHandler(oLover, CREATURE_SCRIPT_ON_DAMAGED, "shaz_lover_damaged");
	SetEventHandler(oLover, CREATURE_SCRIPT_ON_SPELLCASTAT, "shaz_lover_spellcastat");
	SetEventHandler(oLover, CREATURE_SCRIPT_ON_DEATH, "shaz_lover_ondeath");
	AssignCommand(oLover, ClearAllActions(TRUE));
	// technically the love never ends - until a remove curse(caster love) or a dispel magic(target love)
	//DelayCommand(60.0f, SendMessageToPC(oLoveTarget, "Restoring " + GetName(oLover) + " scripts"));
	//DelayCommand(60.0f, SafeRestoreEventHandlers(oLover));
//	DelayCommand(60.0f, SetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_MELEE_ATTACKED, sLoveOnAttackOriginalScript));
//	DelayCommand(60.0f, SetEventHandler(oLoveTarget, CREATURE_SCRIPT_ON_SPELLCASTAT, sLoveOnSpellAtOriginalScript));
	//SafeRestoreEventHandlers(
}

//:: when executed by an object, makes the object walk to the target if it isn't already within 20' and not in combat
//:: this function will re-execute itslef on the calling object periodically
void ShazFollowObject(object oTarget)
{
	if(GetIsInCombat() == 0) {
		//SendMessageToPC(oTarget, "DistanceBetween: " + FloatToString(GetDistanceBetween(OBJECT_SELF, oTarget)));
		if(GetDistanceBetween(OBJECT_SELF, oTarget) > 10.0f) { // ~18 feet
			AssignCommand(OBJECT_SELF, ActionMoveToObject(oTarget, FALSE, 5.0f));
		} else {
			// I had a couple times where a summoned dude would just stand there while something wailed on me. maybe this will get them to fight...
			AssignCommand(OBJECT_SELF, DetermineCombatRound());	// I realize this is going to be done instantly; oh well
		}
	}
	// either way, qeueu this up to get executed again in a few seconds
	DelayCommand(4.0f, ShazFollowObject(oTarget));
}

//:: when executed by an object, makes the object walk to the target if its greater than fDistance
//:: or twice fDistance when in combat. In addition, if not in combat, the executing object will occasionally say "hello"
//:: this function will re-execute itself on the calling object periodically
void ShazFollowObjectAnnoying(object oTarget, float fDistance)
{
	if(GetIsInCombat() == 1) {
		//SendMessageToPC(oTarget, "DistanceBetween: " + FloatToString(GetDistanceBetween(OBJECT_SELF, oTarget)));
		if(GetDistanceBetween(OBJECT_SELF, oTarget) > (fDistance*2.0f)) {
			ClearAllActions();
			AssignCommand(OBJECT_SELF, ActionMoveToObject(oTarget, TRUE, 4.0f));
		}
	} else {
		if(GetDistanceBetween(OBJECT_SELF, oTarget) > (fDistance)) {
			ClearAllActions();
			if(Random(100) >= 50) {
				AssignCommand(OBJECT_SELF, ActionMoveToObject(oTarget, FALSE, 4.0f));
			} else {
				AssignCommand(OBJECT_SELF, ActionMoveToObject(oTarget, TRUE, 4.0f));
			}
		} else {
			if(d10() <= 7) {
				PlayVoiceChat(VOICE_CHAT_SELECTED);
			}
			// I had a couple times where a summoned dude would just stand there while something wailed on me. maybe this will get them to fight...
			AssignCommand(OBJECT_SELF, DetermineCombatRound());	// I realize this is going to be done instantly; oh well
		}
	}
	// either way, qeueu this up to get executed again in a few seconds
	DelayCommand((1.5f + IntToFloat(Random(4))), ShazFollowObjectAnnoying(oTarget, fDistance));
}

//:: summons in a random outsider. Has a 50% chance to just make a gate
//:: also i've rigged this thing to make the outsider change faction after a random period of time... be careful! ;-)
void ShazGateRandomOutsider(int iLevel, location lLocation)
{
	// create & apply gate effect
	effect eGateVis = EffectVisualEffect( VFX_DUR_GATE );
	//JXApplyEffectAtLocation ( DURATION_TYPE_TEMPORARY, eGateVis, lLocation, 5.0);
	
	// SHAZ: put a delay here! So the appear vis happens after the gate vis
	
	if(TRUE){//d100() >= 25) {
		// a creature appears!
		effect eAppearVis;	// appropriate visual for the given plane summon
		string sCreatureName;
		// can't delay as we wouldn't have a pointer to the creature. could make a helper function, but im too lazy
		//float fGateDelay = IntToFloat(d4());	// delay a few seconds from the gate VFX
		// first we choose a randome plane, then we'll pick a monster from that plane based on the caster's level
		int iPlane = Random(8);
		int iCreatureLevel = iLevel + d10() - 5;
		int iDuration = 6 + Random(9);	// how long the creature sticks around: 6-14 rounds
		// number of rounds before the creature goes hostile on the player.
		//   anything over 14 is means the creature never turns, since they won't stick around that long
		int iSafeRounds = 15;
		int nElemental;
		switch(iPlane) {
			case 0:		// fire
				iSafeRounds = 6 + Random(5);	// safe for 6-10 rounds - they might not even attack you at all
				eAppearVis = EffectVisualEffect(VFX_HIT_AOE_FIRE);
				if(iCreatureLevel <= 5) { // 1-5
					// mephit
					sCreatureName = "c_impfire";
				} else if(iCreatureLevel <= 10) { // 6-10
					// elemental (normal)
					sCreatureName = "c_elmfire";
				} else if(iCreatureLevel <= 15) { // 11-15
					// huge elemental
					sCreatureName = "c_elmfirehuge";
				} else if(iCreatureLevel <= 24) {	// 16-24
					// greater elemental
					sCreatureName = "c_elmfiregreater";
				} else {							// 25-40
					// elder elemental
					sCreatureName = "c_elmfireelder";
				}
				nElemental = 1;
				break;
			case 1:		// water
				eAppearVis = EffectVisualEffect(VFX_HIT_AOE_MAGIC);
				iSafeRounds = 6 + Random(5);	// safe for 6-10 rounds - they might not even attack you at all
				if(iCreatureLevel <= 5) { // 1-5
					// elemental (normal)
					sCreatureName = "c_elmwater";
				} else if(iCreatureLevel <= 10) { // 6-10
					// large elemental
					sCreatureName = "c_elmwaterlarge";
				} else if(iCreatureLevel <= 15) { // 11-15
					// huge elemental
					sCreatureName = "c_elmwaterhuge";
				} else if(iCreatureLevel <= 24) {	// 16-24
					// greater elemental
					sCreatureName = "c_elmwatergreater";
				} else {							// 25-40
					// elder elemental
					sCreatureName = "c_elmwaterelder";
				}
				nElemental = 1;
				break;
			case 2:		// earth
				iSafeRounds = 6 + Random(5);	// safe for 6-10 rounds - they might not even attack you at all
				eAppearVis = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE);
				if(iCreatureLevel <= 10) { // 1-10
					// normal elemental
					sCreatureName = "c_elmearth";
				} else if(iCreatureLevel <= 15) { // 11-15
					// huge elemental
					sCreatureName = "c_elmearthhuge";
				} else if(iCreatureLevel <= 24) {	// 16-24
					// greater elemental
					sCreatureName = "c_elmearthgreater";
				} else {							// 25-40
					// elder elemental
					sCreatureName = "c_elmearthelder";
				}
				nElemental = 1;
				break;
			case 3:		// air
				iSafeRounds = 6 + Random(5);	// safe for 6-10 rounds - they might not even attack you at all
				eAppearVis = EffectVisualEffect(VFX_HIT_AOE_LIGHTNING);
				if(iCreatureLevel <= 5) { // 1-5
					// mephit
					sCreatureName = "c_impice";
				} else if(iCreatureLevel <= 10) { // 6-10
					// elemental (normal)
					sCreatureName = "c_elmair";
				} else if(iCreatureLevel <= 15) { // 11-15
					// huge elemental
					sCreatureName = "c_elmairhuge";
				} else if(iCreatureLevel <= 24) {	// 16-24
					// greater elemental
					sCreatureName = "c_elmairgreater";
				} else {							// 25-40
					// elder elemental
					sCreatureName = "c_elmairelder";
				}
				nElemental = 1;
				break;
			case 4:		// celestial
				eAppearVis = EffectVisualEffect(VFX_HIT_AOE_HOLY);
				if(iCreatureLevel <= 4) { // 1-4
					// wolf
					sCreatureName = "c_celestialwolf";
				} else if(iCreatureLevel <= 7) { // 5-7
					// bear
					sCreatureName = "c_celestialbear";
				} else if(iCreatureLevel <= 11) { // 8-11
					// dire bear
					sCreatureName = "c_celestialdbear";
				} else if(iCreatureLevel <= 20) {	// 12-20
					// planetaar
					sCreatureName = "c_planetar";
				} else {							// 21-40
					// solar
					sCreatureName = "c_solar";
				}
				break;
			case 5:		// abyss
				eAppearVis = EffectVisualEffect(VFX_INVOCATION_BRIMSTONE_DOOM);
				iSafeRounds = 2 + Random(7);	// safe for 2-8 rounds - they are very likely to attack you
				if(iCreatureLevel <= 4) { // 1-4
					// hellhound
					sCreatureName = "c_doghell";
				} else if(iCreatureLevel <= 12) { // 5-12
					// succubus
					sCreatureName = "c_succubus";
				} else if(iCreatureLevel <= 14) { // 13-14
					// night hag
					sCreatureName = "c_night_hag";
				} else if(iCreatureLevel <= 18) {	// 15-18
					// hezrou
					sCreatureName = "c_hezrou";
				} else {							// 19-40
					// balor
					sCreatureName = "c_balor";
				}
				break;
			case 6:		// hells
				eAppearVis = EffectVisualEffect(VFX_INVOCATION_UTTERDARK_DOOM);
				iSafeRounds = 2 + Random(7);	// safe for 2-8 rounds - they are very likely to attack you
				if(iCreatureLevel <= 3) { // 1-3
					// imp
					sCreatureName = "c_imp";
				} else if(iCreatureLevel <= 5) { // 4-5
					// fiend spider
					sCreatureName = "c_fiendish_spider";
				} else if(iCreatureLevel <= 12) { // 6-12
					// erynis
					sCreatureName = "c_erinyes";
				} else if(iCreatureLevel <= 17) {	// 13-17
					// horned dem
					sCreatureName = "c_devilhorn";
				} else {							// 18-40
					// pit demon
					sCreatureName = "c_fiend";
				}
				break;
			case 7:		// shadow
				eAppearVis = EffectVisualEffect(VFX_HIT_AOE_EVIL);
				iSafeRounds = 2 + Random(7);	// safe for 2-8 rounds - they are very likely to attack you
				if(iCreatureLevel <= 5) { // 1-5
					// shadow
					sCreatureName = "c_shadow";
				} else if(iCreatureLevel <= 9) { // 6-9
					// shadow mastiff
					sCreatureName = "c_dogshado";
				} else if(iCreatureLevel <= 17) { // 10-17
					// greater shadow
					sCreatureName = "c_greater_shadow";
				} else {							// 18-40
					// nightwalker
					sCreatureName = "c_night";
				}
				break;
		} // end switch on plane index
		
		// DEBUG!!!
		//object oPC = GetFirstPC(TRUE);
		//SendMessageToPC(oPC, "Gating! Lvl " + IntToString(iCreatureLevel) + " creature " + sCreatureName + " for " + IntToString(iDuration) + " rounds with hostility in " + IntToString(iSafeRounds) + " rounds");
		
		// create it!
		object oNewSpawn = CreateObject(OBJECT_TYPE_CREATURE, sCreatureName, lLocation);
		JXApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAppearVis, lLocation);
		//ChangeFaction(oNewSpawn, OBJECT_SELF);
		ChangeToStandardFaction(oNewSpawn, STANDARD_FACTION_DEFENDER);
		DestroyObject(oNewSpawn, RoundsToSeconds(iDuration));
		DelayCommand(RoundsToSeconds(iDuration)-0.5f, JXApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAppearVis, GetLocation(oNewSpawn)));
		// ok so i should have had the caster passed in. Ah, but this should hopefully work too...?
		if(GetIsObjectValid(OBJECT_SELF)) {
			object oCaster = OBJECT_SELF;
			AssignCommand(oNewSpawn, ShazFollowObject(oCaster));
			DelayCommand(6.0f, BuffSummons(oCaster, nElemental, 0));
		}
		// now, if it could become hostile, queue a command to make it so
		if(iSafeRounds < iDuration) {
			DelayCommand(RoundsToSeconds(iSafeRounds), ChangeToStandardFaction(oNewSpawn, STANDARD_FACTION_HOSTILE));
			DelayCommand(RoundsToSeconds(iSafeRounds)+1.0f, AssignCommand(oNewSpawn, DetermineCombatRound()));
		}
	}
}

//:: gets a completely random spell id; could be cleric, mage, whatever, but it should be valid
int ShazGetAnyRandomValidSpellID()
{
	object oPC = GetFirstPC();	// for debugging purposes
	int	iRandom;
	
	// by my calculations, there are 504 possible valid spells
	iRandom = Random(504);
	
	//SendMessageToPC(oPC, "Random SpellID before: " + IntToString(iRandom));
	
	// the spells exist in groups in the 2da. we'll have to write an if for each group
	// if the random is less than 195, leave it as is. Those are ok spell Id's
	if(iRandom > 194) {
		iRandom += 159;
	}
	if(iRandom > 377) {
		iRandom += 9;
	}
	if(iRandom > 396) {
		iRandom += 17;
	}
	if(iRandom > 427) {
		iRandom += 1;
	}
	if(iRandom > 463) {
		iRandom += 21;
	}
	if(iRandom > 486) {
		iRandom += 25;
	}
	if(iRandom > 549) {
		iRandom += 295;
	}
	if(iRandom > 900) {
		iRandom += 66;
	}
	if(iRandom > 967) {
		iRandom += 3;
	}
	if(iRandom > 980) {
		iRandom += 5;
	}
	if(iRandom > 987) {
		iRandom += 12;
	}
	if(iRandom > 1060) {
		iRandom += 2556;
	}
	if(iRandom > 3623) {
		iRandom += 1;
	}
	if(iRandom > 3625) {
		iRandom += 1;
	}
	if(iRandom > 3627) {
		iRandom += 1;
	}
	if(iRandom > 3650) {
		iRandom += 2;
	}
	if(iRandom > 3663) {
		iRandom += 1;
	}
	if(iRandom > 3678) {
		SendMessageToPC(oPC, "ERROR! Random Spell index too high!!!");
	}
	
//	SendMessageToPC(oPC, "Random Spell ID after skipping invalid groups: " + IntToString(iRandom));
	
	// ok now we have a spell id, but it might still not be okay...
	if((StringToInt(Get2DAString("spells", "REMOVED", iRandom)) == 1) ||
		(JXGetSpellName(iRandom) == "")) {
		// spell has been disabled by someone or another, we probably shouldn't use it
		// this could potentially infinite loop, but i doubt it will ever happen
		iRandom = ShazGetAnyRandomValidSpellID();
	}
	
	return iRandom;
}

//:: gets the first magic item oCreature has equipped
object ShazGetFirstEquippedMagicItem(object oCreature)
{
	object	oItem;
	int 	i=0;
	
	while(i<=10) {
		oItem = GetItemInSlot(i, oCreature);
		if(oItem != OBJECT_INVALID) {
			if(GetItemHasProperties(oItem) == TRUE) {
				return oItem;
			}
		}
		i++;
	}
	
	return OBJECT_INVALID;
}

//:: given a spell, gets a "reversed" spell, if one exists, otherwise -1 (eg, "darkness" gets "light")
//:: Shaz: please note, since this is intended to be used by mages only, i've only provided reverses for mage spells
int ShazGetReversedSpellID(int iSpellID)
{
	int iReturnID = -1;
	
	switch(iSpellID) {
		case SPELL_LIGHT:
			iReturnID = SPELL_DARKNESS;
			break;
		case SPELL_DARKNESS:
			iReturnID = SPELL_LIGHT;
			break;
		case SPELL_BURNING_HANDS:
			iReturnID = 2447; //frost fingers
			break;
		case 2206: //blast of flame
		case 2463: //red dragon
		case 2468: //gold dragon
			iReturnID = SPELL_CONE_OF_COLD;
			break;
		case SPELL_CHARM_PERSON:
		case SPELL_CHARM_MONSTER:
		case SPELL_CONFUSION:
		case SPELL_DOMINATE_PERSON:
		case 2204: //maddening scream
			iReturnID = SPELL_LESSER_MIND_BLANK;
			break;
		case SPELL_LESSER_MIND_BLANK:
			iReturnID = SPELL_CONFUSION;
			break;
		case SPELL_CAUSE_FEAR:
		case SPELL_FEAR:
			iReturnID = SPELL_REMOVE_FEAR;
		case SPELL_EXPEDITIOUS_RETREAT:
		case SPELL_HASTE:
		case SPELL_SNAKES_SWIFTNESS:
		case SPELL_SNAKES_SWIFTNESS_MASS:
			iReturnID = SPELL_SLOW;
			break;
		case SPELL_RAY_OF_ENFEEBLEMENT:
		case 1009: //pword weak
			iReturnID = SPELL_BULLS_STRENGTH;
			break;
		case SPELL_SLEEP:	// i just made this one up, it sounded good ;-)
		case SPELL_DEEP_SLUMBER:
		case SPELL_HISS_OF_SLEEP:
			iReturnID = SPELL_RAGE;
			break;
		case SPELL_BALAGARNSIRONHORN:
		case SPELL_SHOUT:
		case SPELL_CACOPHONIC_BURST:
		case SPELL_GREATER_SHOUT:
		case 1204: //less orb sound
		case 1862: //above
		case 1209: //orb sound
		case 1861: //above
		case 2321: //sonic blast
		case 2333: //h cough
		case 2334: //h boom
		case 2454: //shrieking blast
		case 2027: //sound blast
		case 2458: //thunderlance
			iReturnID = SPELL_SILENCE;
			break;
		case SPELL_COMBUST:
			iReturnID = SPELL_CREEPING_COLD;
			break;
		case SPELL_BEARS_ENDURANCE:
			iReturnID = SPELL_CONTAGION;
			break;
		case SPELL_BULLS_STRENGTH:
			iReturnID = SPELL_RAY_OF_ENFEEBLEMENT;
			break;
		case SPELL_EAGLES_SPLENDOR:
		case SPELL_FOXS_CUNNING:
			iReturnID = SPELL_FEEBLEMIND;
			break;
		case SPELL_GHOUL_TOUCH:
		case SPELL_HOLD_PERSON:
		case SPELL_HOLD_MONSTER:
		case 2345: //viscid glob
		case 2407: //icy prison
			iReturnID = SPELL_FREEDOM_OF_MOVEMENT;
			break;
		case SPELL_FIREBALL:
			iReturnID = 2476; //ice burst
			break;
		case SPELL_SLOW:
			iReturnID = SPELL_HASTE;
			break;
		case SPELL_RAGE:
			iReturnID = SPELL_DEEP_SLUMBER;
			break;
		case SPELL_ASSAY_RESISTANCE:
			iReturnID = SPELL_SPELL_RESISTANCE;
			break;
		case SPELL_SPELL_RESISTANCE:
			iReturnID = SPELL_ASSAY_RESISTANCE;
			break;
		case SPELL_BESTOW_CURSE:
			iReturnID = SPELL_REMOVE_CURSE;
			break;
		case SPELL_REMOVE_CURSE:
			iReturnID = SPELL_BESTOW_CURSE;
			break;
		case SPELL_CONTAGION:
			iReturnID = SPELL_REMOVE_DISEASE;
			break;
		case SPELL_ENERVATION:
			iReturnID = SPELL_RESTORATION;
			break;
		case SPELL_HEROISM:
		case SPELL_GREATER_HEROISM:
			iReturnID = SPELL_CRUSHING_DESPAIR;
			break;
		case SPELL_CRUSHING_DESPAIR:
			iReturnID = SPELL_HEROISM;
			break;
		case SPELL_CONE_OF_COLD:
		case 2028: //frostbreath
		case 2464: //white dragon
			iReturnID = 2206; //blast of flame
			break;	
		case SPELL_DISMISSAL:
			iReturnID = SPELL_SUMMON_CREATURE_V;
			break;
		case SPELL_SUMMON_CREATURE_I:
		case SPELL_SUMMON_CREATURE_II:
		case SPELL_SUMMON_CREATURE_III:
		case SPELL_SUMMON_CREATURE_IV:
		case SPELL_SUMMON_CREATURE_V:
		case 2419:
		case 2420:
		case 2421:
		case 2422:
		case 2423:
		case 2428:
		case 2429:
		case 2432:
		case 2435:
		case 2438:
		case 2469:
		case 2487:
			iReturnID = SPELL_DISMISSAL;
			break;
		case SPELL_VITRIOLIC_SPHERE:
			iReturnID = SPELL_SCINTILLATING_SPHERE;
			break;
		case SPELL_SCINTILLATING_SPHERE:
			iReturnID = SPELL_VITRIOLIC_SPHERE;
			break;
		case SPELL_FEEBLEMIND:
			iReturnID = SPELL_FOXS_CUNNING;
			break;
		case SPELL_FIREBRAND:
			iReturnID = 2339; //snowball swarm
			break;
		case SPELL_FIRE_STORM:
		case 2360: //hellfire storm
			iReturnID = SPELL_ICE_STORM;
			break;
		case SPELL_ICE_STORM:
			iReturnID = SPELL_FIRE_STORM;
			break;
		case SPELL_CIRCLE_OF_DEATH:
			iReturnID = SPELL_MASS_HEAL;
			break;
		case SPELL_ANIMATE_DEAD:
		case SPELL_CREATE_UNDEAD:
		case SPELL_CREATE_GREATER_UNDEAD:
			iReturnID = SPELL_UNDEATH_TO_DEATH;
			break;
		case SPELL_UNDEATH_TO_DEATH:
			iReturnID = SPELL_CREATE_UNDEAD;
			break;
		case SPELL_LEAST_SPELL_MANTLE:
		case SPELL_LESSER_SPELL_MANTLE:
			iReturnID = SPELL_LESSER_SPELL_BREACH;
			break;
		case SPELL_SPELL_MANTLE:
		case SPELL_GREATER_SPELL_MANTLE:
			iReturnID = SPELL_GREATER_SPELL_BREACH;
			break;
		case SPELL_LESSER_SPELL_BREACH:
			iReturnID = SPELL_LESSER_SPELL_MANTLE;
			break;
		case SPELL_GREATER_SPELL_BREACH:
			iReturnID = SPELL_GREATER_SPELL_MANTLE;
			break;
		case SPELL_FLESH_TO_STONE:
		case 1012: //pword stone
			iReturnID = SPELL_STONE_TO_FLESH;
			break;
		case SPELL_STONE_TO_FLESH:
			iReturnID = SPELL_FLESH_TO_STONE;
			break;
		case SPELL_BANISHMENT:
			iReturnID = SPELL_SUMMON_CREATURE_VIII;
			break;
		case SPELL_SUMMON_CREATURE_VI:
		case SPELL_SUMMON_CREATURE_VII:
		case SPELL_SUMMON_CREATURE_VIII:
		case SPELL_GATE:
		case 1078:
		case 1190:
		case 2361:
		case 2362:
		case 2424:
		case 2425:
		case 2426:
		case 2427:
		case 2430:
		case 2431:
		case 2433:
		case 2434:
		case 2436:
		case 2437:
		case 2439:
		case 2440:
			iReturnID = SPELL_BANISHMENT;
			break;
		case SPELL_FINGER_OF_DEATH:
			iReturnID = SPELL_HEAL;
			break;
		case SPELL_BLINDNESS_AND_DEAFNESS:
		case SPELL_POWORD_BLIND:
			iReturnID = SPELL_TRUE_SEEING;
			break;
		case SPELL_TRUE_SEEING:
			iReturnID = SPELL_POWORD_BLIND;
			break;
		case SPELL_MASS_CONTAGION:
			iReturnID = SPELL_MASS_BEAR_ENDURANCE;
			break;
		case SPELL_MASS_BEAR_ENDURANCE:
			iReturnID = SPELL_MASS_CONTAGION;
			break;
		case SPELL_HORRID_WILTING:
			iReturnID = SPELL_VIGOROUS_CYCLE;
			break;
		case SPELL_MIND_BLANK:
			iReturnID = SPELL_DOMINATE_MONSTER;
			break;
		case SPELL_MASS_CHARM:
		case SPELL_DOMINATE_MONSTER:
			iReturnID = SPELL_MIND_BLANK;
			break;
		case SPELL_ENERGY_DRAIN:
			iReturnID = SPELL_GREATER_RESTORATION;
			break;
		case SPELL_REDUCE_PERSON:
		case SPELL_REDUCE_PERSON_GREATER:
			iReturnID = SPELL_ENLARGE_PERSON;
			break;
		case SPELL_ENLARGE_PERSON:
			iReturnID = SPELL_REDUCE_PERSON;
			break;
		case 1197:	 //lesser cold orb
		case 1822:
			iReturnID = 1199;
			break;
		case 1199:	 //lesser fire orb
		case 1823:
			iReturnID = 1197;
			break;
		case 1198:	 //lesser elec orb
		case 1824:
			iReturnID = 1203;
			break;
		case 1203:	 //lesser acid orb
		case 1860:
			iReturnID = 1198;
			break;
		case 1206:	 //cold orb
		case 1825:
			iReturnID = 1208;
			break;
		case 1208:	 //fire orb
		case 1826:
			iReturnID = 1206;
			break;
		case 1207:	 //elec orb
		case 1827:
			iReturnID = 1205;
			break;
		case 1205:	 //acid orb
		case 1859:
			iReturnID = 1207;
			break;
		case 1010: //pword mala
			iReturnID = SPELL_CATS_GRACE;
			break;
		case SPELL_CATS_GRACE:
			iReturnID = 1010;
			break;
		case 2311: //acid storm
			iReturnID = 1015;
			break;
		case 1015: //call lightning storm
			iReturnID = 2311;
			break;
		case 2314: //acidball
			iReturnID = 2397;
			break;
		case 2397: //ball lightning
			iReturnID = 2314;
			break;
		case 2316: //damning darkness
			iReturnID = 2457;
			break;
		case 2457: //blistering radiance
			iReturnID = 2316;
			break;
		case 2338: //corrosive grasp
			iReturnID = 2452;
			break;
		case 2452: //storm touch
			iReturnID = 2338;
			break;
		case 2339: //snowball storm
			iReturnID = SPELL_FIREBRAND;
			break;
		case 2340: //icelance
		case 2207: //above
			iReturnID = 2322;
			break;
		case 2322: //ag's scorcher
			iReturnID = 2340;
			break;
		case 2347: //burning blood
			iReturnID = 1773;
			break;
		case 1773: //martyr blood
			iReturnID = 2347;
			break;
		case 2369: //ice dagger
			iReturnID = SPELL_FLAME_ARROW;
			break;
		case SPELL_FLAME_ARROW:
			iReturnID = 2369;
			break;
		case 2368: //acid sheath
			iReturnID = 2371;
			break;
		case 2371: //caco shield
			iReturnID = 2368;
			break;
		case 2401: //flashburst
			iReturnID = 2402;
			break;
		case 2402: //shadow spray
			iReturnID = 2401;
			break;
		case 2413: //mass resist
			iReturnID = 2342;
			break;
		case 2342: //energy spheres
			iReturnID = 2413;
			break;
		case SPELL_MOON_BOLT:
			iReturnID = 2409;
			break;
		case 2409: //baleful bolt
			iReturnID = SPELL_MOON_BOLT;
			break;
		case 2446: //flaming sphere
			iReturnID = 2205;
			break;
		case 2205: //freezing sphere
			iReturnID = 2446;
			break;
		case 2459: //acid breath
		case 2462: //above
			iReturnID = 2460;
			break;
		case 2460: //lightning breath
		case 2461: //above
			iReturnID = 2459;
			break;
	}
	
	return iReturnID;
}

//::Shaz: Wrote this because doubling the caster level often doesn't do anything,
//::      because usually the level is capped at 10 or so, depending on the spell.
//::		so, here we just turn on empower, to at least make the spell stronger
//::		than normal if you happen to be over the cap. This still doesn't do the +200% required by the ToM
//::		in the future, we could try: cast the spell twice; modify all spells in the game to do double damage/ect
void ShazIncreaseSpellStrength(object oCaster)
{
	int nCasterLvl = JXGetCasterLevel(oCaster);
	nCasterLvl = nCasterLvl + (nCasterLvl / 2);	// to try and reach 200% effectiveness, we will inrease the level by this, in case you aren't at the cap
	JXSetCasterLevel(nCasterLvl);
	SendMessageToPC(oCaster, "Your caster level increases to " + IntToString(nCasterLvl));
	JXSetMetaMagicFeat(METAMAGIC_EMPOWER);
	JXSetSpellSaveDC(JXGetSpellSaveDC(oCaster) + 2, oCaster);
}

//:: deterimines if a partiular spell id could be cast by anyone (does it have a class-type spell level)
int ShazIsSpellCastable(int iSpellID)
{
	string sLevel;
	
	sLevel = Get2DAString("spells", "Bard", iSpellID);
	if(sLevel == "") {
		sLevel = Get2DAString("spells", "Cleric", iSpellID);
		if(sLevel =="") {
			sLevel = Get2DAString("spells", "Druid", iSpellID);	
			if(sLevel =="") {
				sLevel = Get2DAString("spells", "Wiz_Sorc", iSpellID);
				if(sLevel =="") {
					sLevel = Get2DAString("spells", "Warlock", iSpellID);	
					if(sLevel =="") {
						sLevel = Get2DAString("spells", "Paladin", iSpellID);	
						if(sLevel =="") {
							sLevel = Get2DAString("spells", "Ranger", iSpellID);
							if(sLevel =="") {
								return FALSE;
							}	
						} else {
							return TRUE;
						}
					} else {
						return TRUE;
					}
				} else {
					return TRUE;
				}
			} else {
				return TRUE;
			}
		} else {
			return TRUE;
		}
	} else {
		return TRUE;
	}
	
	// not possible to get here
	return FALSE;
}

//:: returns 1 if the spellID is a summoning spell (gate, summon monster, create undead)
int ShazIsSummoningSpell(int iSpellID)
{
	switch(iSpellID) {
		case 2:
		case 29:	// crt grt und
		case 30:	// crt und
		case 63:
		case 69:
		case 96:
		case 123:
		case 128:
		case 174:
		case 175:
		case 176:
		case 177:
		case 178:
		case 179:
		case 180:
		case 181:
		case 182:
		case 303:
		case 304:
		case 317:
		case 318:
		case 324:
		case 344:
		case 349:
		case 378:
		case 379:
		case 451:
		case 476:
		case 564:
		case 609:
		case 610:
		case 623:
		case 624:
		case 627:
		case 638:
		case 701:
		case 823:
		case 1082:
		case 1137:
		case 1190:
		case 1689:
		case 1690:
		case 1691:
		case 1692:
		case 1730:
		case 1928:
		case 1930:
		case 1931:
		case 2361:
		case 2362:
		case 2373:
		case 2419:
		case 2420:
		case 2421:
		case 2422:
		case 2423:
		case 2424:
		case 2425:
		case 2426:
		case 2427:
		case 2428:
		case 2429:
		case 2430:
		case 2431:
		case 2432:
		case 2433:
		case 2434:
		case 2435:
		case 2436:
		case 2437:
		case 2438:
		case 2439:
		case 2440:
		case 2469:
		case 2487:
			return TRUE;
		default:
			return FALSE;
	}
	
	return FALSE;
}

//:: Meant to be played on the player's "owned" character, it prevents them
//:: from controlling that character by forcing them to control another character
//:: as long as they have any companions. if they don't have any...
//:: please NOTE: use SetIsCompanionPossessionBlocked on non-player-owned characters, this is just for the player's own char
void ShazLovePreventPlayerControl()
{
	object oLove = GetLocalObject(OBJECT_SELF, "ShazLoved");
	if(GetIsDead(oLove) || !GetIsObjectValid(oLove)) {
		return;
	}
	if (!GetIsOwnedByPlayer(OBJECT_SELF)) {
		// we could put SetIsCompPosBlock here....
		return;
	}
	if(GetIsDead(OBJECT_SELF)) {
		return;
	}
	if(GetIsPC(OBJECT_SELF)) {
		SendMessageToPC(OBJECT_SELF, "You are in love, and are unable to control your own actions");
		if(GetIsObjectValid(GetObjectFromRosterName(GetFirstRosterMember()))) {
			// its possible we could be blocked from possesing this creature for some reason
			
			SetOwnersControlledCompanion(OBJECT_SELF, GetObjectFromRosterName(GetFirstRosterMember()));
		} else {
			// player is alone... stun them for a bit
			effect eStun = EffectStunned();
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, OBJECT_SELF, 30.0f);
			return;
		}
	}
	
	SetAllEventHandlers(OBJECT_SELF, "");
	SetEventHandler(OBJECT_SELF, CREATURE_SCRIPT_ON_HEARTBEAT, "shaz_lover_onheart");
	SetEventHandler(OBJECT_SELF, CREATURE_SCRIPT_ON_DAMAGED, "shaz_lover_damaged");
	SetEventHandler(OBJECT_SELF, CREATURE_SCRIPT_ON_SPELLCASTAT, "shaz_lover_spellcastat");
	SetEventHandler(OBJECT_SELF, CREATURE_SCRIPT_ON_DEATH, "shaz_lover_ondeath");
	
	DelayCommand(2.0f, ShazLovePreventPlayerControl());
}

void ShazOpenAllNearbyDoors(location lTarget, float fDistance)
{
	object oTarget;
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);
    float fDelay;
    int nResist;
	
	oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fDistance, lTarget, FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);

    while(GetIsObjectValid(oTarget))
    {
        SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,SPELL_KNOCK));
        //fDelay = GetRandomDelay(0.5, 2.5);
        if(!GetPlotFlag(oTarget))
        {
			if( GetLocked(oTarget)) {
	            nResist =  GetDoorFlag(oTarget,DOOR_FLAG_RESIST_KNOCK);
	            if (nResist == 0)
	            {
	                
	                AssignCommand(oTarget, ActionUnlockObject(oTarget));
	            }
	            else if  (nResist == 1)
	            {
	                FloatingTextStrRefOnCreature(83887,OBJECT_SELF);   //
	            }
			}
			JXApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
			AssignCommand(oTarget, ActionOpenDoor(oTarget));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fDistance, lTarget, FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

void ShazSummonRandomCreaturesAtLocation(location lLocation)
{
	int iCasterLvl = JXGetCasterLevel(OBJECT_SELF);
	int iDuration =  iCasterLvl + 3;
	int iRand;
	effect eSummon;
	effect eTotalSummon;	// all summons linked together
	int bFirstSummon = TRUE;
	string sSummonName="";
	
	// generate a random number of HD (levels) to summon
	int iHDRemaining = d20() + iCasterLvl;
	//SendMessageToPC(OBJECT_SELF, "Summoning " + IntToString(iHDRemaining) + " HD of creatures!!!");
	
	// loop until we summon a monster worth more than the remaining HD
	while(iHDRemaining > 0) {
		iRand = d20();
		if(iHDRemaining <= 7) {
			// shaz: this is to prevent us from spawning a large monster when you have far less HD left than the monster is worth
			iRand = iRand / 2;
		}
		switch(iRand) {
			case 0:
			case 1:
				sSummonName = "c_rabbit";
				eSummon = EffectSummonCreature("c_rabbit", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 1;
				break;
			case 2:	// wolf
				sSummonName = "c_dogwolf";
				eSummon = EffectSummonCreature("c_dogwolf", VFX_HIT_SPELL_SUMMON_CREATURE);
				
				iHDRemaining -= 2;
				break;
			case 3:
				sSummonName = "c_snowleopard";
				eSummon = EffectSummonCreature("c_snowleopard", VFX_HIT_SPELL_SUMMON_CREATURE);
				
				iHDRemaining -= 3;
				break;
			case 4:
				sSummonName = "c_panther";
				eSummon = EffectSummonCreature("c_panther", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 3;
				break;
			case 5:
				sSummonName = "c_impice";
				eSummon = EffectSummonCreature("c_impice", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 4;	// should be 3, but their stronger than that (spell effects)
				break;
			case 6:
				sSummonName = "c_rat";
				eSummon = EffectSummonCreature("c_rat", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 1;
				break;
			case 7:
				sSummonName = "c_chicken";
				eSummon = EffectSummonCreature("c_chicken", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 1;
				break;
			case 8:
				sSummonName = "c_impfire";
				eSummon = EffectSummonCreature("c_impfire", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 4; // should be 3, but they're stronger than that (spell effects)
				break;
			case 9:
				sSummonName = "c_ratdire";
				eSummon = EffectSummonCreature("c_ratdire", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 2;
				break;
			case 10:
				sSummonName = "c_bugbear";
				eSummon = EffectSummonCreature("c_bugbear", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 3;
				
				break;
			case 11:
				sSummonName = "c_celestialwolf";
				eSummon = EffectSummonCreature("c_celestialwolf", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 5;
				break;
			case 12:
				sSummonName = "c_spidsword";
				eSummon = EffectSummonCreature("c_spidsword", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 5;
				break;
			case 13:
				sSummonName = "c_bear";
				eSummon = EffectSummonCreature("c_bear", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 6;
				break;
			case 14:
				sSummonName = "c_spidglow";
				eSummon = EffectSummonCreature("c_spidglow", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 6;
				break;
			case 15:
				sSummonName = "c_spidphase";
				eSummon = EffectSummonCreature("c_spidphase", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 5;
				break;
			case 16:
				sSummonName = "c_dogwolfwin";
				eSummon = EffectSummonCreature("c_dogwolfwin", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 6;
				break;
			case 17:
				sSummonName = "c_dogwolfdire";
				eSummon = EffectSummonCreature("c_dogwolfdire", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 6;
				break;
			case 18:
				sSummonName = "c_umber";
				eSummon = EffectSummonCreature("c_umber", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 9;
				break;
			case 19:
				sSummonName = "c_wyvern";
				eSummon = EffectSummonCreature("c_wyvern", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 11;	// should be 7, but wyverns are really quite strong
				break;
			case 20:
				sSummonName = "c_beardire";
				eSummon = EffectSummonCreature("c_beardire", VFX_HIT_SPELL_SUMMON_CREATURE);
				iHDRemaining -= 12;
				break;
				
			default:
				// shouldn't get here
				iHDRemaining = 0;
				break;
		}
/*
		if(bFirstSummon == TRUE) {
			//eTotalSummon = eSummon;
			bFirstSummon = FALSE;
			// New method: If its the first summon, summon normally.
			eSummon = SetEffectSpellId(eSummon, SPELL_SUMMON_CREATURE_II);
			ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lLocation, RoundsToSeconds(iDuration));
		} else {
			// if you do one summon at a time, you can only have one creature. Here we will try to have several...
			//eTotalSummon = EffectLinkEffects(eSummon, eTotalSummon);
			//SendMessageToPC(OBJECT_SELF, "Linking summon effects!!!");
			// all other summons must be done.. "specially"
			object oNewSpawn = CreateObject(OBJECT_TYPE_CREATURE, sSummonName, lLocation);
			//AddHenchman(OBJECT_SELF, oNewSpawn);
			HenchmanAdd(OBJECT_SELF, oNewSpawn, 1, 1);
			SendMessageToPC(OBJECT_SELF, "Setting event handler!!!");
			ExecuteScript("shaz_allowuserheart", oNewSpawn);
			SetEventHandler(oNewSpawn, 0, "shaz_sumheart");
		}
*/
		effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
		// third method
		object oNewSpawn = CreateObject(OBJECT_TYPE_CREATURE, sSummonName, lLocation);
		DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oNewSpawn));
		DelayCommand(6.0f, BuffSummons(OBJECT_SELF, 0, 1));
		// ok so i should have had the caster passed in. Ah, but this should hopefully work too...?
		if(GetIsObjectValid(OBJECT_SELF)) {
			object oCaster = OBJECT_SELF;
			//SendMessageToPC(oCaster, "ordering creature to follow you!");
			AssignCommand(oNewSpawn, ShazFollowObject(oCaster));
		}
		
		if (GetHasFeat(FEAT_ASHBOUND, OBJECT_SELF))
		{	iDuration *= 2;	}
		
		//ChangeFaction(oNewSpawn, OBJECT_SELF);
		ChangeToStandardFaction(oNewSpawn, STANDARD_FACTION_DEFENDER);
		DestroyObject(oNewSpawn, RoundsToSeconds(iDuration));
		DelayCommand(RoundsToSeconds(iDuration), JXApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oNewSpawn)));
	}
	if(bFirstSummon == FALSE) {
		//JXApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eTotalSummon, lLocation, RoundsToSeconds(iDuration));
		//ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eTotalSummon, lLocation, RoundsToSeconds(iDuration));
	} // don't apply the effect if we never generated one
}

//:: Creates a water elemental, applies some effects to it, gives it a creature weapon that casts a spell, and lets it roam free..
void ShazSummonSpellElemental(location lLocation, int iSpellID)
{
	object oPC = GetFirstPC(); // just for debug
	int iDuration = d4(2) + 3;
	effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
	
	object oNewSpawn = CreateObject(OBJECT_TYPE_CREATURE, "c_elmspell", lLocation);
	DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oNewSpawn));
	
	// give that darn elemental some spell-on-hit stuffz
	itemproperty ip = ItemPropertyOnHitCastSpell(IP_SPELL_ELEMENTAL_ONHIT, JXGetCasterLevel());
	//itemproperty ip = ItemPropertyOnHitCastSpell(IP_BANEFULL_D_ONHIT,1);
	if(GetIsItemPropertyValid(ip)) {
		object oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oNewSpawn);
		if(! GetIsObjectValid(oWeapon)) {
			oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oNewSpawn);
		}
		if(! GetIsObjectValid(oWeapon)) {
			oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oNewSpawn);
		}
		if(GetIsObjectValid(oWeapon)) {
			//SendMessageToPC(oPC, "Spell elemental spell applied to elemental weapon, spellid: " + IntToString(iSpellID));
			IPSafeAddItemProperty(oWeapon, ip, RoundsToSeconds(iDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		} else {
			//SendMessageToPC(oPC, "Could not get the elemental's weapon to apply the spell to");
		}
	} else {
		//SendMessageToPC(oPC, "Onhit-spell itemproperty INVALID!");
	}
	
	DelayCommand(6.0f, BuffSummons(OBJECT_SELF, 1, 0));
	// make it an enemy of even the badguys
//	ChangeToStandardFaction(oNewSpawn, STANDARD_FACTION_MERCHANT);
	//SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oNewSpawn);
	//SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 0, oNewSpawn);
	//SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 0, oNewSpawn);
	//AdjustReputation(oNewSpawn, oPC, -100);
	//AssignCommand(oNewSpawn, DetermineCombatRound(GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oNewSpawn)));
	AssignCommand(oNewSpawn, ShazDoLivingSpellAI());
	
	// that isn't enough on its own, store the spell id on the elemental
	SetLocalInt(oNewSpawn, "ShazElementalSpellID", iSpellID);
	// and these are attempts to get it to use the right casting vars
	SetLocalInt(oNewSpawn, "ShazElementalCastLevel", JXGetCasterLevel());
	SetLocalInt(oNewSpawn, "ShazElementalSpellDC", JXGetSpellSaveDC());
	
	// this just for visual spiffiness
	effect eVis1 = EffectVisualEffect(VFX_DUR_PHASE_AFFLICTION_ARMS);
	JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis1, oNewSpawn, RoundsToSeconds(iDuration));
	
	DestroyObject(oNewSpawn, RoundsToSeconds(iDuration));
	DelayCommand(RoundsToSeconds(iDuration), JXApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oNewSpawn)));
}

// removes the cutscene paralyze from a creature prematurely and
// lets them move around for six seconds, then re-freezes them (if there is time left)
void ShazTimeStopTurn(object oTarget, float fTimeLeftAfterTurn)
{
	//AssignCommand(oTarget, SpeakString("Your turn!"));
	SendMessageToPC(oTarget, "Your turn!");
	// first, remove the cutscene paralyze from this creature
	effect eCurEffect = GetFirstEffect(oTarget);
	while(GetIsEffectValid(eCurEffect)) {
		if(GetEffectType(eCurEffect) == EFFECT_TYPE_CUTSCENE_PARALYZE) {
			RemoveEffect(oTarget, eCurEffect);
		}
		eCurEffect = GetNextEffect(oTarget);
	}
	// then, delay command the application of a new paralyze lasting fTimeLeft (unless timeleft is 0)
	if(fTimeLeftAfterTurn > 0.0f) {
		effect eParalyze = EffectCutsceneParalyze();
		effect eIcon = EffectEffectIcon(16);	// paralyze icon -im not sure if these are #define'd anywhere...?
		effect eAnim = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
		effect eLink = EffectLinkEffects(eParalyze, eIcon);
		eLink =EffectLinkEffects(eLink, eAnim);
		DelayCommand(6.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fTimeLeftAfterTurn));
		DelayCommand(6.0f, SendMessageToPC(oTarget, "Times up!"));
	}
}

//:: Freezes all creatures in a large area with unresistable paralyze for
//:: 1 turn (1 minute) with a new creature getting freed up to move each round
void ShazTimeStopWithTurns(location lLocation, object oIgnoreCreature = OBJECT_INVALID)
{
	object oCreature0;	//wweeeee make-shift arrays ftw!
	object oCreature1;
	object oCreature2;
	object oCreature3;
	object oCreature4;
	object oCreature5;
	object oCreature6;
	object oCreature7;
	object oCreature8;
	object oCreature9;
	object oCreature10;
	object oCreature11;
	object oCreature12;
	object oCreature13;
	object oCreature14;
	int iNumCreatures=0; // we'll cap this at ten, because only ten get turns
	effect eParalyze = EffectCutsceneParalyze();
	effect eIcon = EffectEffectIcon(16);	// paralyze icon -im not sure if these are #define'd anywhere...?
	effect eAnim = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
	effect eLink = EffectLinkEffects(eParalyze, eIcon);
	eLink =EffectLinkEffects(eLink, eAnim);
	
	// first, go through all creatures in a VERY large area around the lLoc,
	// and cutscene immobilize them for 60 seconds
	object oCurrent = GetFirstObjectInShape(SHAPE_SPHERE, 36.0f,lLocation, FALSE);
	while(GetIsObjectValid(oCurrent)) {
		if(oCurrent != oIgnoreCreature) {
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCurrent, 60.0f);
			// we'll also record the first 15 creatures we find, as we will use this "array"
			// to determine a random order to give turns to. This means that if you have 20 creatures in the AOE,
			// only the first (nearest?) 10 will get to move - well, aren't you glad you were standing next to that wild mage? ;-)
			if(iNumCreatures < 15) {
				// weeee! Make-shift array assignment!
				switch(iNumCreatures) {
					case 0:
						oCreature0 = oCurrent;
						break;
					case 1:
						oCreature1 = oCurrent;
						break;
					case 2:
						oCreature2 = oCurrent;
						break;
					case 3:
						oCreature3 = oCurrent;
						break;
					case 4:
						oCreature4 = oCurrent;
						break;
					case 5:
						oCreature5 = oCurrent;
						break;
					case 6:
						oCreature6 = oCurrent;
						break;
					case 7:
						oCreature7 = oCurrent;
						break;
					case 8:
						oCreature8 = oCurrent;
						break;
					case 9:
						oCreature9 = oCurrent;
						break;
					case 10:
						oCreature10 = oCurrent;
						break;
					case 11:
						oCreature11 = oCurrent;
						break;
					case 12:
						oCreature12 = oCurrent;
						break;
					case 13:
						oCreature13 = oCurrent;
						break;
					case 14:
						oCreature14 = oCurrent;
						break;
					
				}
				iNumCreatures++;
			} // else numcreaturs > 15
		} // else current == ignore creature
		oCurrent = GetNextObjectInShape(SHAPE_SPHERE, 36.0f, lLocation, FALSE);
	}
	
	// now for the tricky stuff. Go through all our recorded creatures, issuing delayed turns to the first 10
	// if we run out of creatures, reset the "numCreaturessToPickFrom" and keep going
	// oh, and if you pick one, swap it with the last one, so it doesn't get picked again
	int iNumPickable = iNumCreatures;
	int iNumPicked = 0;
	int iRandom;
	object oSwapper;
	
	while(iNumPicked < 10) {
		iRandom = Random(iNumPickable);
		switch(iRandom) {
			case 0:
				oCurrent = oCreature0;
				break;
			case 1:
				oCurrent = oCreature1;
				break;
			case 2:
				oCurrent = oCreature2;
				break;
			case 3:
				oCurrent = oCreature3;
				break;
			case 4:
				oCurrent = oCreature4;
				break;
			case 5:
				oCurrent = oCreature5;
				break;
			case 6:
				oCurrent = oCreature6;
				break;
			case 7:
				oCurrent = oCreature7;
				break;
			case 8:
				oCurrent = oCreature8;
				break;
			case 9:
				oCurrent = oCreature9;
				break;
			case 10:
				oCurrent = oCreature10;
				break;
			case 11:
				oCurrent = oCreature11;
				break;
			case 12:
				oCurrent = oCreature12;
				break;
			case 13:
				oCurrent = oCreature13;
				break;
			case 14:
				oCurrent = oCreature14;
				break;
		}
		// ok we picked one, now we have to cycle it out and the last one in
		switch(iNumPickable-1) {
			case 0:
				oSwapper = oCreature0;
				oCreature0 = oCurrent;
				break;
			case 1:
				oSwapper = oCreature1;
				oCreature1 = oCurrent;
				break;
			case 2:
				oSwapper = oCreature2;
				oCreature2 = oCurrent;
				break;
			case 3:
				oSwapper = oCreature3;
				oCreature3 = oCurrent;
				break;
			case 4:
				oSwapper = oCreature4;
				oCreature4 = oCurrent;
				break;
			case 5:
				oSwapper = oCreature5;
				oCreature5 = oCurrent;
				break;
			case 6:
				oSwapper = oCreature6;
				oCreature6 = oCurrent;
				break;
			case 7:
				oSwapper = oCreature7;
				oCreature7 = oCurrent;
				break;
			case 8:
				oSwapper = oCreature8;
				oCreature8 = oCurrent;
				break;
			case 9:
				oSwapper = oCreature9;
				oCreature9 = oCurrent;
				break;
			case 10:
				oSwapper = oCreature10;
				oCreature10 = oCurrent;
				break;
			case 11:
				oSwapper = oCreature11;
				oCreature11 = oCurrent;
				break;
			case 12:
				oSwapper = oCreature12;
				oCreature12 = oCurrent;
				break;
			case 13:
				oSwapper = oCreature13;
				oCreature13 = oCurrent;
				break;
			case 14:
				oSwapper = oCreature14;
				oCreature14 = oCurrent;
				break;
		}
		// finish the swapping by putting the non-picked one into the picked slot
		switch(iRandom) {
			case 0:
				oCreature0 = oSwapper;
				break;
			case 1:
				oCreature1 = oSwapper;
				break;
			case 2:
				oCreature2 = oSwapper;
				break;
			case 3:
				oCreature3 = oSwapper;
				break;
			case 4:
				oCreature4 = oSwapper;
				break;
			case 5:
				oCreature5 = oSwapper;
				break;
			case 6:
				oCreature6 = oSwapper;
				break;
			case 7:
				oCreature7 = oSwapper;
				break;
			case 8:
				oCreature8 = oSwapper;
				break;
			case 9:
				oCreature9 = oSwapper;
				break;
			case 10:
				oCreature10 = oSwapper;
				break;
			case 11:
				oCreature11 = oSwapper;
				break;
			case 12:
				oCreature12 = oSwapper;
				break;
			case 13:
				oCreature13 = oSwapper;
				break;
			case 14:
				oCreature14 = oSwapper;
				break;
		}
		iNumPickable--;
		if(iNumPickable == 0) {
			// we picked all the creatures we had available, reset and continue
			iNumPickable = iNumCreatures;
		}
		// OKAY! now we can do the actual "give em a turn"
		DelayCommand(IntToFloat(iNumPicked)*6.0f + 0.1f, ShazTimeStopTurn(oCurrent, ((9.0f-IntToFloat(iNumPicked))* 6.0f)));
		
		iNumPicked++;
	} // end while numpicked < 10
}

//::///////////////////////////////////////////////

int wildMageLevelVariation(int nCasterLvl)
{
	
	//int nSpellLvl = JXGetBaseSpellLevel(nSpellId);
	
	if(nCasterLvl == 0)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return 777;
		case 2 : return -1;
		case 3 : return -1;
		case 4 : return -1;
		case 5 : return 0;
		case 6 : return 0;
		case 7 : return 0;
		case 8 : return 0;
		case 9 : return 0;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 0;
		case 13 : return 0;
		case 14 : return 0;
		case 15 : return 0;
		case 16 : return 0;
		case 17 : return 1;
		case 18 : return 1;
		case 19 : return 1;
		case 20 : return 1;
		default : return 0;
		}
	}
	else if(nCasterLvl == 1)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -1;
		case 2 : return -1;
		case 3 : return -1;
		case 4 : return -1;
		case 5 : return -1;
		case 6 : return 0;
		case 7 : return 0;
		case 8 : return 0;
		case 9 : return 0;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 0;
		case 13 : return 0;
		case 14 : return 0;
		case 15 : return 0;
		case 16 : return 1;
		case 17 : return 1;
		case 18 : return 1;
		case 19 : return 1;
		case 20 : return 777;
		default : return 0;
		}
	}
	else if(nCasterLvl == 2)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -1;
		case 2 : return -1;
		case 3 : return -1;
		case 4 : return -1;
		case 5 : return -1;
		case 6 : return -1;
		case 7 : return 777;
		case 8 : return 0;
		case 9 : return 0;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 0;
		case 13 : return 0;
		case 14 : return 0;
		case 15 : return 1;
		case 16 : return 1;
		case 17 : return 1;
		case 18 : return 1;
		case 19 : return 1;
		case 20 : return 1;
		default : return 0;
		}
	}
	else if(nCasterLvl == 3)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -2;
		case 2 : return -1;
		case 3 : return -1;
		case 4 : return -1;
		case 5 : return -1;
		case 6 : return -1;
		case 7 : return -1;
		case 8 : return 0;
		case 9 : return 0;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 777;
		case 13 : return 0;
		case 14 : return 1;
		case 15 : return 1;
		case 16 : return 1;
		case 17 : return 1;
		case 18 : return 1;
		case 19 : return 1;
		case 20 : return 2;
		default : return 0;
		}
	}
	else if(nCasterLvl == 4)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -2;
		case 2 : return -2;
		case 3 : return 777;
		case 4 : return -1;
		case 5 : return -1;
		case 6 : return -1;
		case 7 : return -1;
		case 8 : return -1;
		case 9 : return 0;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 0;
		case 13 : return 1;
		case 14 : return 1;
		case 15 : return 1;
		case 16 : return 1;
		case 17 : return 1;
		case 18 : return 1;
		case 19 : return 2;
		case 20 : return 2;
		default : return 0;
		}
	}
	else if(nCasterLvl == 5)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -3;
		case 2 : return -2;
		case 3 : return -2;
		case 4 : return -1;
		case 5 : return -1;
		case 6 : return -1;
		case 7 : return -1;
		case 8 : return -1;
		case 9 : return -1;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 1;
		case 13 : return 1;
		case 14 : return 1;
		case 15 : return 1;
		case 16 : return 777;
		case 17 : return 1;
		case 18 : return 2;
		case 19 : return 2;
		case 20 : return 3;
		default : return 0;
		}
	}
	else if(nCasterLvl == 6)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -3;
		case 2 : return -3;
		case 3 : return -2;
		case 4 : return -2;
		case 5 : return -1;
		case 6 : return -1;
		case 7 : return -1;
		case 8 : return -1;
		case 9 : return -1;
		case 10 : return 777;
		case 11 : return 0;
		case 12 : return 1;
		case 13 : return 1;
		case 14 : return 1;
		case 15 : return 1;
		case 16 : return 1;
		case 17 : return 2;
		case 18 : return 2;
		case 19 : return 3;
		case 20 : return 3;
		default : return 0;
		}
	}
	else if(nCasterLvl == 7)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -4;
		case 2 : return -3;
		case 3 : return -3;
		case 4 : return -2;
		case 5 : return -2;
		case 6 : return -1;
		case 7 : return -1;
		case 8 : return -1;
		case 9 : return -1;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 1;
		case 13 : return 1;
		case 14 : return 1;
		case 15 : return 1;
		case 16 : return 2;
		case 17 : return 777;
		case 18 : return 3;
		case 19 : return 3;
		case 20 : return 4;
		default : return 0;
		}
	}
	else if(nCasterLvl == 8)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -4;
		case 2 : return -4;
		case 3 : return -3;
		case 4 : return -3;
		case 5 : return 777;
		case 6 : return -2;
		case 7 : return -1;
		case 8 : return -1;
		case 9 : return -1;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 1;
		case 13 : return 1;
		case 14 : return 1;
		case 15 : return 2;
		case 16 : return 2;
		case 17 : return 3;
		case 18 : return 3;
		case 19 : return 4;
		case 20 : return 4;
		default : return 0;
		}
	}
	else if(nCasterLvl >= 9)
	{
		int nRand = d20(1);	
	
		switch(nRand)
		{
		case 1 : return -5;
		case 2 : return -4;
		case 3 : return -4;
		case 4 : return -3;
		case 5 : return -3;
		case 6 : return -2;
		case 7 : return 777;
		case 8 : return -1;
		case 9 : return -1;
		case 10 : return 0;
		case 11 : return 0;
		case 12 : return 1;
		case 13 : return 1;
		case 14 : return 2;
		case 15 : return 2;
		case 16 : return 3;
		case 17 : return 3;
		case 18 : return 4;
		case 19 : return 4;
		case 20 : return 5;
		default : return 0;
		}
	}
	else
	{
	return 0;
	}
	
	return 0;
}