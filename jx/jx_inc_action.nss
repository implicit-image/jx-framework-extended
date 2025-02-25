//::///////////////////////////////////////////////
//:: JX Spellcasting Action Include
//:: jx_inc_action
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: nov 26, 2007
//:://////////////////////////////////////////////
//
// This file contains functions to manage actions.
//
//:://////////////////////////////////////////////

#include "jx_inc_magic_events"
















//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//


// Structure that holds informations about a spellcasting action
struct jx_action_castspell
{
    int iActionId;
    int iSpellId;
    object oTarget;
    location lTarget;
    int iCasterLevel;
    int iMetaMagicFeat;
    int iSpellSaveDC;
    int iClass;
    int bPreRoundAction;
};

// Transform a spellcasting action structure into a string
// - actionCastSpell Spellcasting action in strucure form
// * Returns the spellcasting action in string form
string JXActionCastSpellToString(struct jx_action_castspell actionCastSpell);

// Transform a spellcasting action string into a structure
// - actionCastSpell Spellcasting action in string form
// * Returns the spellcasting action in strucure form
struct jx_action_castspell JXStringToActionCastSpell(string sActionCastSpell);

// Create a new action identifier for a creature
// - oCreature Creature for whom the action identifier is generated
// * Returns the generated action identifier
int JXFindNewActionCastSpellIdentifier(object oCreature = OBJECT_SELF);

// Override the spellcasting action that is about to be added to the queue
// - actionCastSpell Informations about the action to enqueue
// - oCreature Creature for whom the action must be added to the queue
void JXOverrideAddedActionCastSpell(struct jx_action_castspell actionCastSpell, object oCreature = OBJECT_SELF);

// Enqueue a new spellcasting action in the action queue
// - actionCastSpell Informations about the action to enqueue
// - oCreature Creature for whom the action must be added to the queue
// * Returns TRUE if the action has been successfully added to the queue
int JXAddActionCastSpellToQueue(struct jx_action_castspell actionCastSpell, object oCreature = OBJECT_SELF);

// Remove the first (current) spellcasting action from the queue
// - iActionId Only remove the action from the queue if it has the specified action identifier
// - bResult Indicate if the action was performed successfully or not
// - oCreature Creature for whom the action must be removed from the queue
void JXRemoveFirstActionCastSpellFromQueue(int bResult = TRUE, int iActionId = 0, object oCreature = OBJECT_SELF);

// Get informations about a spellcasting action currently in the queue
// - iPos Position of the action in the queue (starts at 1)
// - oCreature Creature for whom the action must be get
// * Returns informations about the specified action
struct jx_action_castspell JXGetActionCastSpellFromQueue(int iPos, object oCreature = OBJECT_SELF);

// Remove all spellcasting actions from the queue
// - oCreature Creature for whom the actions must be removed from the queue
void JXClearActionQueue(object oCreature = OBJECT_SELF);

// Count the number of spellcasting actions currently in the queue
// - oCreature Creature with an action queue
// * Returns the number of actions in the queue
int JXCountActionsInQueue(object oCreature = OBJECT_SELF);















//**************************************//
//                                      //
//            Implementation            //
//                                      //
//**************************************//


// Transform a spellcasting action structure into a string
// - actionCastSpell Spellcasting action in strucure form
// * Returns the spellcasting action in string form
string JXActionCastSpellToString(struct jx_action_castspell actionCastSpell)
{
    string sAction = IntToString(actionCastSpell.iActionId);
    sAction += ";" + IntToString(actionCastSpell.iSpellId);
    sAction += ";" + IntToString(ObjectToInt(actionCastSpell.oTarget));
    sAction += ";" + JXLocationToString(actionCastSpell.lTarget);
    sAction += ";" + IntToString(actionCastSpell.iCasterLevel);
    sAction += ";" + IntToString(actionCastSpell.iMetaMagicFeat);
    sAction += ";" + IntToString(actionCastSpell.iSpellSaveDC);
    sAction += ";" + IntToString(actionCastSpell.iClass);
    sAction += ";" + IntToString(actionCastSpell.bPreRoundAction);

    return sAction;
}

// Transform a spellcasting action string into a structure
// - actionCastSpell Spellcasting action in string form
// * Returns the spellcasting action in strucure form
struct jx_action_castspell JXStringToActionCastSpell(string sActionCastSpell)
{
    struct jx_action_castspell actionCastSpell;
    actionCastSpell.iActionId = StringToInt(JXStringSplit(sActionCastSpell, ";", 0));
    actionCastSpell.iSpellId = StringToInt(JXStringSplit(sActionCastSpell, ";", 1));
    actionCastSpell.oTarget = IntToObject(StringToInt(JXStringSplit(sActionCastSpell, ";", 2)));
    actionCastSpell.lTarget = JXStringToLocation(JXStringSplit(sActionCastSpell, ";", 3));
    actionCastSpell.iCasterLevel = StringToInt(JXStringSplit(sActionCastSpell, ";", 4));
    actionCastSpell.iMetaMagicFeat = StringToInt(JXStringSplit(sActionCastSpell, ";", 5));
    actionCastSpell.iSpellSaveDC = StringToInt(JXStringSplit(sActionCastSpell, ";", 6));
    actionCastSpell.iClass = StringToInt(JXStringSplit(sActionCastSpell, ";", 7));
    actionCastSpell.bPreRoundAction = StringToInt(JXStringSplit(sActionCastSpell, ";", 8));

    return actionCastSpell;
}

// Create a new action identifier for a creature
// - oCreature Creature for whom the action identifier is generated
// * Returns the generated action identifier
int JXFindNewActionCastSpellIdentifier(object oCreature)
{
    int iActionId = GetLocalInt(oCreature, "JX_LAST_ACTION_CASTSPELL_ID") + 1;
    if (iActionId == 101)
        iActionId = 1;
    SetLocalInt(oCreature, "JX_LAST_ACTION_CASTSPELL_ID", iActionId);
    return iActionId;
}

// Override the spellcasting action that is about to be added to the queue
// - actionCastSpell Informations about the action to enqueue
// - oCreature Creature for whom the action must be added to the queue
void JXOverrideAddedActionCastSpell(struct jx_action_castspell actionCastSpell, object oCreature)
{
    string sAction = JXActionCastSpellToString(actionCastSpell);
    SetLocalString(oCreature, "JX_ACTION_CASTSPELL_OVERRIDE", sAction);
}

// Enqueue a new spellcasting action in the action queue
// - actionCastSpell Informations about the action to enqueue
// - oCreature Creature for whom the action must be added to the queue
// * Returns TRUE if the action has been successfully added to the queue
int JXAddActionCastSpellToQueue(struct jx_action_castspell actionCastSpell, object oCreature)
{
    // Fire the spellcasting action enqueued event
    if (JXEventActionCastSpellEnqueued(oCreature,
                                       actionCastSpell.iSpellId,
                                       actionCastSpell.oTarget,
                                       GetIsObjectValid(actionCastSpell.oTarget) ?
                                       GetLocation(actionCastSpell.oTarget) :
                                       actionCastSpell.lTarget,
                                       actionCastSpell.iCasterLevel,
                                       actionCastSpell.iMetaMagicFeat,
                                       actionCastSpell.iSpellSaveDC,
                                       actionCastSpell.iClass))
    {
        int iCountActions = GetLocalInt(oCreature, "JX_ACTION_CASTSPELL_COUNT") + 1;
        SetLocalInt(oCreature, "JX_ACTION_CASTSPELL_COUNT", iCountActions);

        // Save the overriden action if it exists
        string sAction = GetLocalString(oCreature, "JX_ACTION_CASTSPELL_OVERRIDE");
        if (sAction != "")
        {
            SetLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iCountActions), sAction);
            DeleteLocalString(oCreature, "JX_ACTION_CASTSPELL_OVERRIDE");
        }
        else
        {
            sAction = JXActionCastSpellToString(actionCastSpell);
            SetLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iCountActions), sAction);
        }

        return TRUE;
    }
    else
        return FALSE;
}

// Remove the first (current) spellcasting action from the queue
// - iActionId Only remove the action from the queue if it has the specified action identifier
// - bResult Indicate if the action was performed successfully or not
// - oCreature Creature for whom the action must be removed from the queue
void JXRemoveFirstActionCastSpellFromQueue(int bResult, int iActionId, object oCreature)
{
    string sAction = GetLocalString(oCreature, "JX_ACTION_CASTSPELL_1");
    struct jx_action_castspell actionCastSpell = JXStringToActionCastSpell(sAction);
    if ((iActionId == 0) || (actionCastSpell.iActionId == iActionId))
    {
        // Fire the spellcasting action finished event
        JXEventActionCastSpellFinished(oCreature,
                                       actionCastSpell.iSpellId,
                                       actionCastSpell.oTarget,
                                       GetIsObjectValid(actionCastSpell.oTarget) ?
                                       GetLocation(actionCastSpell.oTarget) :
                                       actionCastSpell.lTarget,
                                       actionCastSpell.iCasterLevel,
                                       actionCastSpell.iMetaMagicFeat,
                                       actionCastSpell.iSpellSaveDC,
                                       actionCastSpell.iClass,
                                       bResult);

        // Move the actions that are after the removed spell
        int iCountActions = GetLocalInt(oCreature, "JX_ACTION_CASTSPELL_COUNT");
        int iLoopPos;
        for (iLoopPos = 1; iLoopPos < iCountActions; iLoopPos++)
        {
            SetLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iLoopPos),
             GetLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iLoopPos + 1)));
        }
        DeleteLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iCountActions));

        // Update the action counter
        SetLocalInt(oCreature, "JX_ACTION_CASTSPELL_COUNT", iCountActions - 1);
    }
}

// Get informations about a spellcasting action currently in the queue
// - iPos Position of the action in the queue (starts at 1)
// - oCreature Creature for whom the action must be get
// * Returns informations about the specified action
struct jx_action_castspell JXGetActionCastSpellFromQueue(int iPos, object oCreature)
{
    string sAction = GetLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iPos));

    return JXStringToActionCastSpell(sAction);
}

// Remove all spellcasting actions from the queue
// - oCreature Creature for whom the actions must be removed from the queue
void JXClearActionQueue(object oCreature)
{
    // Remove all the spellcasting actions from the queue
    int iCountActions = GetLocalInt(oCreature, "JX_ACTION_CASTSPELL_COUNT");
    int iLoopPos;
    for (iLoopPos = 1; iLoopPos <= iCountActions; iLoopPos++)
    {
        // Fire the spellcasting action finished event
        string sAction = GetLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iLoopPos));
        struct jx_action_castspell actionCastSpell = JXStringToActionCastSpell(sAction);
        JXEventActionCastSpellFinished(oCreature,
                                       actionCastSpell.iSpellId,
                                       actionCastSpell.oTarget,
                                       GetIsObjectValid(actionCastSpell.oTarget) ?
                                       GetLocation(actionCastSpell.oTarget) :
                                       actionCastSpell.lTarget,
                                       actionCastSpell.iCasterLevel,
                                       actionCastSpell.iMetaMagicFeat,
                                       actionCastSpell.iSpellSaveDC,
                                       actionCastSpell.iClass,
                                       FALSE);

        DeleteLocalString(oCreature, "JX_ACTION_CASTSPELL_" + IntToString(iLoopPos));
    }
    DeleteLocalInt(oCreature, "JX_ACTION_CASTSPELL_COUNT");
}

// Count the number of spellcasting actions currently in the queue
// - oCreature Creature with an action queue
// * Returns the number of actions in the queue
int JXCountActionsInQueue(object oCreature)
{
    return GetLocalInt(oCreature, "JX_ACTION_CASTSPELL_COUNT");
}
