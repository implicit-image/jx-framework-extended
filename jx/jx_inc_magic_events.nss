//::///////////////////////////////////////////////
//:: JX Spellcasting Events Include
//:: jx_inc_magic_events
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: dec 02, 2007
//:://////////////////////////////////////////////
//
// This file contains functions to manage spellcasting events :
// - Spell casting action enqueued in the action queue
// - Spell casting action started
// - Spell conjuring animation started (not fired with quicken spells)
// - Spell conjuring animation finished (happens just before a spell is cast, not fired with quicken spells)
// - Spell cast
// - Spell casting action finished
//
// N.B. : These events are only fired if the functions
//        JXActionCastSpellAtLocation/Object() are called,
//        except the "spell cast" event
//
//:://////////////////////////////////////////////

#include "jx_inc_script_call"
















//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//


// This event is fired when a spellcasting action is enqueued in the action queue.
// N.B. : The action that will be enqueued can be overriden by using the
//        JXOverrideAddedActionCastSpell() function defined in "jx_inc_action"
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to enqueue the spellcasting action, or FALSE to prevent it to be enqueued
int JXEventActionCastSpellEnqueued(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass);

// This event is fired when a spellcasting action becomes the current action of the caster
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXEventActionCastSpellStarted(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass);

// This event is fired when the conjuration animation of a spellcasting action starts
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXEventActionCastSpellConjuring(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass);

// This event is fired when the conjuration animation of a spellcasting action stops
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXEventActionCastSpellConjured(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass);

// This event is fired when the spell is cast
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spell effects apply, or FALSE to prevent them
int JXEventActionCastSpellCast(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass);

// This event is fired when a spellcasting action is finished
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// - bResult FALSE if the spellcasting action hasn't been performed successfully
void JXEventActionCastSpellFinished(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass, int bResult);
















//**************************************//
//                                      //
//            Implementation            //
//                                      //
//**************************************//


// This event is fired when a spell casting action is enqueued in the action queue
// N.B. : The action that will be enqueued can be overriden by using the
//        JXOverrideAddedActionCastSpell() function defined in "jx_inc_action"
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to enqueue the spellcasting action, or FALSE to prevent it to be enqueued
int JXEventActionCastSpellEnqueued(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oCaster);
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterObject(paramList, oTarget);
	paramList = JXScriptAddParameterLocation(paramList, lTarget);
	paramList = JXScriptAddParameterInt(paramList, iCasterLevel);
	paramList = JXScriptAddParameterInt(paramList, iMetaMagicFeat);
	paramList = JXScriptAddParameterInt(paramList, iSpellSaveDC);
	paramList = JXScriptAddParameterInt(paramList, iClass);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EVENTSPELLENQUEUED, paramList);

	return JXScriptGetResponseInt();
}

// This event is fired when a spellcasting action becomes the current action of the caster
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXEventActionCastSpellStarted(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oCaster);
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterObject(paramList, oTarget);
	paramList = JXScriptAddParameterLocation(paramList, lTarget);
	paramList = JXScriptAddParameterInt(paramList, iCasterLevel);
	paramList = JXScriptAddParameterInt(paramList, iMetaMagicFeat);
	paramList = JXScriptAddParameterInt(paramList, iSpellSaveDC);
	paramList = JXScriptAddParameterInt(paramList, iClass);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EVENTSPELLSTARTED, paramList);

	return JXScriptGetResponseInt();
}

// This event is fired when the conjuration animation of a spellcasting action starts
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXEventActionCastSpellConjuring(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oCaster);
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterObject(paramList, oTarget);
	paramList = JXScriptAddParameterLocation(paramList, lTarget);
	paramList = JXScriptAddParameterInt(paramList, iCasterLevel);
	paramList = JXScriptAddParameterInt(paramList, iMetaMagicFeat);
	paramList = JXScriptAddParameterInt(paramList, iSpellSaveDC);
	paramList = JXScriptAddParameterInt(paramList, iClass);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EVENTSPELLCONJURING, paramList);

	return JXScriptGetResponseInt();
}

// This event is fired when the conjuration animation of a spellcasting action stops
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXEventActionCastSpellConjured(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oCaster);
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterObject(paramList, oTarget);
	paramList = JXScriptAddParameterLocation(paramList, lTarget);
	paramList = JXScriptAddParameterInt(paramList, iCasterLevel);
	paramList = JXScriptAddParameterInt(paramList, iMetaMagicFeat);
	paramList = JXScriptAddParameterInt(paramList, iSpellSaveDC);
	paramList = JXScriptAddParameterInt(paramList, iClass);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EVENTSPELLCONJURED, paramList);

	return JXScriptGetResponseInt();
}

// This event is fired when the spell is cast
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spell effects apply, or FALSE to prevent them
int JXEventActionCastSpellCast(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oCaster);
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterObject(paramList, oTarget);
	paramList = JXScriptAddParameterLocation(paramList, lTarget);
	paramList = JXScriptAddParameterInt(paramList, iCasterLevel);
	paramList = JXScriptAddParameterInt(paramList, iMetaMagicFeat);
	paramList = JXScriptAddParameterInt(paramList, iSpellSaveDC);
	paramList = JXScriptAddParameterInt(paramList, iClass);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EVENTSPELLCAST, paramList);

	return JXScriptGetResponseInt();
}

// This event is fired when a spellcasting action is finished
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// - bResult FALSE if the spellcasting action hasn't been performed successfully
void JXEventActionCastSpellFinished(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass, int bResult)
{
	struct script_param_list paramList;
	paramList = JXScriptAddParameterObject(paramList, oCaster);
	paramList = JXScriptAddParameterInt(paramList, iSpellId);
	paramList = JXScriptAddParameterObject(paramList, oTarget);
	paramList = JXScriptAddParameterLocation(paramList, lTarget);
	paramList = JXScriptAddParameterInt(paramList, iCasterLevel);
	paramList = JXScriptAddParameterInt(paramList, iMetaMagicFeat);
	paramList = JXScriptAddParameterInt(paramList, iSpellSaveDC);
	paramList = JXScriptAddParameterInt(paramList, iClass);
	paramList = JXScriptAddParameterInt(paramList, bResult);

	JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_EVENTSPELLFINISHED, paramList);
}