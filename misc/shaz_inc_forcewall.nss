// shaz_inc_forcewall
/*
    Wall of Force functions written by Shazbotian
*/

//:: 05-14-08:Shaz: Modified the "Wall intercepts spell" function to set the spell to always be able to target the intersection point

//#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "shaz_inc_math"
#include "jx_inc_magic"
#include "nw_i0_spells"

void ShazForceWallDoArrowImmunity()
{
	object oCreature;
	object oTarget;
	object oWeapon;
	
	int iNumCreatures=0, iCurCreatureIndex, iResetIndex;
	
	//object oPC = GetFirstPC();
	//SendMessageToPC(oPC, "ForceWall checking arrow immunity");
	
	location lCreature, lTarget;
	vector vCreature, vTarget, vWallLeft, vWallRight, vIntersection;
	
	vIntersection.z = -1.0f;
	
	object oWall = GetNearestObjectByTag("ShazForceWall");
	vWallLeft = GetPositionFromLocation(GetLocalLocation(oWall, "LeftEnd"));
	vWallRight = GetPositionFromLocation(GetLocalLocation(oWall, "RightEnd"));
	
	// first count up the number of nearby creatures
	oCreature = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(oWall));
    //Declare the spell shape, size and the location.
    while(GetIsObjectValid(oCreature))
    {
		iNumCreatures++;
		oCreature = GetNextObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(oWall));
	}
	
	
	//oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	oCreature = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(oWall));
    //Declare the spell shape, size and the location.
	iCurCreatureIndex=0;
    while(iCurCreatureIndex < iNumCreatures)
    {
		// SHaz: the following method was completely unsuccessful. Apparently GetAttackTarget() returns invalid objects for everyone, always
		//SendMessageToPC(oPC, "Testing creature " + GetName(oCreature));
//		AssignCommand(oCreature, SpeakString("I'm testing against forcewalls!"));
//		oTarget = GetAttackTarget(oCreature);
//		AssignCommand(oCreature, SpeakString("I WAS targeting " + GetName(GetAttemptedAttackTarget())));
//		if(GetIsObjectValid(oTarget)) {
//			AssignCommand(oCreature, SpeakString("I'm targeting " + GetName(oTarget)));
//			// check if this creature is targeting someone on the other side of the wall
//			vCreature = GetPosition(oCreature);
//			vTarget = GetPosition(oTarget);
//			vIntersection = SegmentIntersectsSegment(vCreature, vTarget, vWallLeft, vWallRight);
//			if(vIntersection.z != -1.0f) {
//				// "creature" is aiming at "target" thru the wall, give target arrow immunity
//				effect eProt = EffectDamageReduction(100, DAMAGE_POWER_NORMAL, 0, DR_TYPE_NON_RANGED);
//				JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eProt, oTarget, 6.0f);
//				SendMessageToPC(oTarget, "The invisible wall protects you from " + GetName(oCreature) + "'s arrows!");
//			}
//		}

		//SendMessageToPC(oPC, "Checking if " + GetName(oCreature) + " has a ranged weapon...");

		// Shaz: so, my second attempt will be to give arrow immunity to anyone who has an enemy with a bow on the other side of the wall
		// first check if the creature has a bow
		// should we check the creature weapon slots? I have no idea...
		oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCreature);
        if (!GetIsObjectValid(oWeapon))
        {
            oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oCreature);
        }
		//SendMessageToPC(oPC, GetName(oCreature) + " has a " + GetName(oWeapon));
		if(GetWeaponRanged(oWeapon)) {
			
			//SendMessageToPC(oPC, GetName(oCreature) + " has a ranged weapon!");
			oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(oWall));
			while(GetIsObjectValid(oTarget)) {
				if(oTarget != oCreature) {
					if(GetIsEnemy(oTarget, oCreature) == TRUE) {
						//SendMessageToPC(oPC, "Testing Creature " + GetName(oCreature) + " against target " + GetName(oTarget));
						vCreature = GetPosition(oCreature);
						vTarget = GetPosition(oTarget);
						vIntersection = SegmentIntersectsSegment(vCreature, vTarget, vWallLeft, vWallRight);
						if(vIntersection.z != -1.0f) {
							effect eProt = EffectDamageReduction(100, DAMAGE_POWER_NORMAL, 0, DR_TYPE_NON_RANGED);
							JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, eProt, oTarget, 6.0f);
							SendMessageToPC(oTarget, "An invisible wall protects you from " + GetName(oCreature) + "'s arrows!");
						}
					}
				}
				
				oTarget = GetNextObjectInShape(SHAPE_SPHERE,40.0, GetLocation(oWall));
			}
		} // endif has a ranged weapon
			
		iCurCreatureIndex++;	// incriment so we check the next creature
		
		// get the next creature, this is tricky because the inner "target" loop has set us back to the beginning
		oCreature = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(oWall));
		iResetIndex = 0;
		while(iResetIndex < iCurCreatureIndex) {
			oCreature = GetNextObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(oWall));
			iResetIndex++;
		}
	}
}

// assuming a spell was just cast, this function checks if it crosses a force wall
// and if it does will change its target to the wall itself
// if the spell is disintigrate or mordekein's disjunction, it destroys the wall as well
void ShazForceWallSpellDeflect()
{
	// get caster loc and the target loc
	location	lCaster = GetLocation(OBJECT_SELF);
	location	lTarget = JXGetSpellTargetLocation(OBJECT_SELF);
	location	lWallLeft;
	location	lWallRight;
	location	lIntersection;
	object		oWall;
	vector		vIntersection;
	vector		vWallLeft;
	vector		vWallRight;
	int			iNumWalls;
	
	// now their could be several walls... how to handle that?
	// we handle it by going thru all objects with the tag "shazforcewall" and checking against each of them, bailing if we find an intersection with one
	oWall = GetObjectByTag("ShazForceWall",0);
	iNumWalls = 0;
	while(GetIsObjectValid(oWall)) {
		// check for an existing nearby AOE effect object (this should be our "wall effect"). if its gone, our wall is gone and we shouldn't interrupt spells with it
		if(GetIsObjectValid(GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(oWall), FALSE, OBJECT_TYPE_AREA_OF_EFFECT))) {
			//SendMessageToPC(OBJECT_SELF, "Testing ForceWall " + IntToString(iNumWalls));
			lWallLeft = GetLocalLocation(oWall, "LeftEnd");
			vWallLeft = GetPositionFromLocation(lWallLeft);
			lWallRight = GetLocalLocation(oWall, "RightEnd");
			vWallRight = GetPositionFromLocation(lWallRight);
			vIntersection = SegmentIntersectsSegment(GetPosition(OBJECT_SELF), GetPositionFromLocation(lTarget), vWallLeft, vWallRight);
			if(vIntersection.z != -1.0f) {
				// DEBUG!!!
				object oPC = GetFirstPC();
				//SendMessageToPC(oPC, "Spell ID " + IntToString(JXGetSpellId()) + " testing against a wall");
				// END DEBUG!!!
				SendMessageToPC(OBJECT_SELF, "Your spell was stopped by an invisible wall!");
				// there was an interesection: create an object at the wall for the spell to hit and set it as spell target
				// move the intersection up a little to make it look like the spell hit something in the air, not on the ground
				vIntersection.z = 1.5f;
				lIntersection = Location(GetArea(OBJECT_SELF), vIntersection, 0.0f);
				object oNewTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lIntersection, FALSE, "ShazFWNewTarget");
				JXSetSpellTargetObject(oNewTarget);
				JXSetSpellTargetLocation(lIntersection);
				// Shaz: added the next line because creatures casting spells at the PC would not treat the wall as a valid target - I have no idea why
				IgnoreTargetRulesEnqueueTarget(OBJECT_SELF, oNewTarget);
				DestroyObject(oNewTarget, 3.0f);
				
				if(FALSE){//JXGetSpellId() == SPELL_LIGHTNING_BOLT) {	// Shaz: I modified the lightnign bolt script to stop at the wall
					// lightning bolt has this obnoxious setup where it goes 30 units past whatever it hits
					// I can't stop that kind of insanity without re-writing Lightning bolt, so I'll just stop lightning bolt from doing anything
					SetModuleOverrideSpellScriptFinished();
					// Shaz: I wonder... what if we made a target for the lighting on the same side as the caster... hehe... "rebound!"
				} else if((JXGetSpellId() == SPELL_DISINTEGRATE) || (JXGetSpellId() == SPELL_MORDENKAINENS_DISJUNCTION)) {
					SendMessageToPC(OBJECT_SELF, "Your spell destroyed the wall!");
					DestroyObject(oWall);
					oWall = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lIntersection, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
					DestroyObject(oWall);
					SetGlobalInt("ShazForceWall", 0);
				}
				
				// to end the loop
				iNumWalls++;	// so the thing below doesn't think no walls exist
				oWall = OBJECT_INVALID;
			} else {
				// to continue looping over all the walls out there
				iNumWalls++;
				oWall = GetObjectByTag("ShazForceWall", iNumWalls);
			}
		} else {
			// there isn't an AOE object near the wall - somehow our effect got deleted (dispel magic?)
			// destroy our wall object so we don't erroneously interrupt spells
			DestroyObject(oWall);
			// continue looping over all the walls out there
			iNumWalls++;
			oWall = GetObjectByTag("ShazForceWall", iNumWalls);
		}
	}
	
	if(iNumWalls == 0) {
		// no walls exist, disable looking for them.
		SetGlobalInt("ShazForceWall", 0);
	}
}