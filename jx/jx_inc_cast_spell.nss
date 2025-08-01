
#include "jx_inc_action"
#include "jx_inc_magic_events"


//========================================== Cast Spell ==========================================//

// Cast a spell from an object at another location
// - oCaster Caster of the spell
// - lTo Target location of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
void JXCastSpellFromObjectAtLocation(object oCaster,
                                     location lTo,
                                     int iSpellId,
                                     int iMetamagic = 0,
                                     int iCasterLevel = 0,
                                     int iDC = 0,
                                     int bIgnoreDeadZone = FALSE);

// Cast a spell from an object at another object
// - oCaster Caster of the spell
// - oTarget Target creature/placeable of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
void JXCastSpellFromObjectAtObject(object oCaster,
                                   object oTarget,
                                   int iSpellId,
                                   int iMetamagic = 0,
                                   int iCasterLevel = 0,
                                   int iDC = 0,
                                   int bIgnoreDeadZone = FALSE);

// Cast a spell from a location at another location
// - lFrom Origin location of the spell
// - lTo Target location of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
// - oSpellCreator To specify a creature as the spell creator
void JXCastSpellFromLocationAtLocation(location lFrom,
                                       location lTo,
                                       int iSpellId,
                                       int iMetamagic = 0,
                                       int iCasterLevel = 0,
                                       int iDC = 0,
                                       int bIgnoreDeadZone = FALSE,
                                       object oSpellCreator = OBJECT_INVALID);

// Cast a spell from a location at an object
// - lFrom Origin location of the spell
// - oTarget Target creature/placeable of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
// - oSpellCreator To specify a creature as the spell creator
void JXCastSpellFromLocationAtObject(location lFrom,
                                     object oTarget,
                                     int iSpellId,
                                     int iMetamagic = 0,
                                     int iCasterLevel = 0,
                                     int iDC = 0,
                                     int bIgnoreDeadZone = FALSE,
                                     object oSpellCreator = OBJECT_INVALID);

// Make a creature cast a spell at a location by performing an action
// - lTarget Target location of the spell
// - iSpellId SPELL_* constant
// - iMetaMagicFeat METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iSpellSaveDC Difficulty check for the spell
// - iClass Class used to cast the spell
void JXActionCastSpellAtLocation(location lTarget,
                                 int iSpellId,
                                 int iMetaMagicFeat = 0,
                                 int iCasterLevel = 0,
                                 int iSpellSaveDC = 0,
                                 int iClass = CLASS_TYPE_INVALID);

// Make a creature cast a spell at an object by performing an action
// - oTarget Target creature/placeable of the spell
// - iSpellId SPELL_* constant
// - iMetaMagicFeat METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iSpellSaveDC Difficulty check for the spell
// - iClass Class used to cast the spell
void JXActionCastSpellAtObject(object oTarget,
                               int iSpellId,
                               int iMetaMagicFeat = 0,
                               int iCasterLevel = 0,
                               int iSpellSaveDC = 0,
                               int iClass = CLASS_TYPE_INVALID);


//===================================== implementation =================

// Cast a spell from a location at another location
// - lFrom Origin location of the spell
// - lTo Target location of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
// - oSpellCreator To specify a creature as the spell creator
void JXCastSpellFromLocationAtLocation(location lFrom,
                                       location lTo,
                                       int iSpellId,
                                       int iMetamagic = 0,
                                       int iCasterLevel = 0,
                                       int iDC = 0,
                                       int bIgnoreDeadZone = FALSE,
                                       object oSpellCreator = OBJECT_INVALID)
{
    // Create an invisible placeable and set its name
    object oCaster = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lFrom, FALSE, "jx_ipoint_caster");
    if (GetIsObjectValid(oSpellCreator))
    {
        SetFirstName(oCaster, GetName(oSpellCreator));
        // Save the real creator on the placeable
        SetLocalObject(oCaster, JX_REAL_CREATOR, oSpellCreator);
    }
    else
        SetFirstName(oCaster, GetStringByStrRef(50963));


    // Cast the spell
    JXCastSpellFromObjectAtLocation(oCaster, lTo, iSpellId, iMetamagic, iCasterLevel, iDC, bIgnoreDeadZone);

    // Delete the object in 24 hours
    DestroyObject(oCaster, HoursToSeconds(24));
}

// Cast a spell from a location at an object
// - lFrom Origin location of the spell
// - oTarget Target creature/placeable of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
// - oSpellCreator To specify a creature as the spell creator
void JXCastSpellFromLocationAtObject(location lFrom,
                                     object oTarget,
                                     int iSpellId,
                                     int iMetamagic = 0,
                                     int iCasterLevel = 0,
                                     int iDC = 0,
                                     int bIgnoreDeadZone = FALSE,
                                     object oSpellCreator = OBJECT_INVALID)
{
    // Create an invisible placeable and set its name
    object oCaster = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_ipoint ", lFrom, FALSE, "jx_ipoint_caster");
    if (GetIsObjectValid(oSpellCreator))
    {
        SetFirstName(oCaster, GetName(oSpellCreator));
        // Save the real creator on the placeable
        SetLocalObject(oCaster, JX_REAL_CREATOR, oSpellCreator);
    }
    else
        SetFirstName(oCaster, GetStringByStrRef(50963));

    // Cast the spell
    JXCastSpellFromObjectAtObject(oCaster, oTarget, iSpellId, iMetamagic, iCasterLevel, iDC, bIgnoreDeadZone);

    // Delete the object in 24 hours
    DestroyObject(oCaster, HoursToSeconds(24));
}

// Cast a spell from an object at another location
// - oCaster Caster of the spell
// - lTo Target location of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
void JXCastSpellFromObjectAtLocation(object oCaster,
                                     location lTo,
                                     int iSpellId,
                                     int iMetamagic = 0,
                                     int iCasterLevel = 0,
                                     int iDC = 0,
                                     int bIgnoreDeadZone = FALSE)
{
    if (bIgnoreDeadZone)
        JXSetIgnoreDeadZone(oCaster);

    if (iCasterLevel > 0)
        JXSetCasterLevel(iCasterLevel, oCaster);
    if (iMetamagic > 0)
        JXSetMetaMagicFeat(iMetamagic, oCaster);
    if (iDC > 0)
        JXSetSpellSaveDC(iDC, oCaster);

    AssignCommand(oCaster,
        ActionCastSpellAtLocation(iSpellId,
                                  lTo,
                                  iMetamagic,
                                  TRUE,
                                  PROJECTILE_PATH_TYPE_DEFAULT,
                                  TRUE));
}

// Cast a spell from an object at another object
// - oCaster Caster of the spell
// - oTarget Target creature/placeable of the spell
// - iSpellId SPELL_* constant
// - iMetamagic METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iDC Difficulty check for the spell
// - bIgnoreDeadZone Ignore dead/wild magic effects
void JXCastSpellFromObjectAtObject(object oCaster,
                                   object oTarget,
                                   int iSpellId,
                                   int iMetamagic = 0,
                                   int iCasterLevel = 0,
                                   int iDC = 0,
                                   int bIgnoreDeadZone = FALSE)
{
    if (bIgnoreDeadZone)
        JXSetIgnoreDeadZone(oCaster);

    if (iCasterLevel > 0)
        JXSetCasterLevel(iCasterLevel, oCaster);
    if (iMetamagic > 0)
        JXSetMetaMagicFeat(iMetamagic, oCaster);
    if (iDC > 0)
        JXSetSpellSaveDC(iDC, oCaster);

    AssignCommand(oCaster,
        ActionCastSpellAtObject(iSpellId,
                                oTarget,
                                iMetamagic,
                                TRUE,
                                0,
                                PROJECTILE_PATH_TYPE_DEFAULT,
                                TRUE));
}

// Private function - used by JXPrivateStartActionCastSpell() - Check Armor Spell Failure
void JXPrivateFireActionCastSpellConjured(object oCaster, struct jx_action_castspell actionCastSpell)
{
    // Fire the conjuration animation started event
    if (!JXEventActionCastSpellConjured(oCaster,
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
        ClearAllActions();
        JXClearActionQueue();
    }
}

// Private function - used by JXActionCastSpellAtObject() and JXActionCastSpellAtLocation()
void JXPrivateStartActionCastSpell(int iActionId, int bIsMoving = FALSE, int bActionStarted = FALSE)
{
    object oCaster = OBJECT_SELF;

    // Get the current action
    int iCurrentAction = GetCurrentAction();
    // The current action may be invalid because all actions have just been cleared
    if (iCurrentAction == ACTION_INVALID)
    {
        JXClearActionQueue();
        return;
    }
    // The action queue may be cleared if a PC is performing a move action
    if ((GetIsPC(oCaster)) && (iCurrentAction == ACTION_MOVETOPOINT))
    {
        // The creature was moving before the spell cast action was added to the queue
        if (bIsMoving)
        {
            DelayCommand(0.1, JXPrivateStartActionCastSpell(iActionId, TRUE));
            return;
        }
        // The creature has moved since the spell cast action was added to the queue
        else
        {
            JXClearActionQueue();
            return;
        }
    }

    // Wait until the previous action is done
    struct jx_action_castspell actionCastSpell = JXGetActionCastSpellFromQueue(1);
    int iCurrentActionId = actionCastSpell.iActionId;
    if ((iCurrentAction != ACTION_CASTSPELL) || (iCurrentActionId != iActionId))
    {
        DelayCommand(0.1, JXPrivateStartActionCastSpell(iActionId));
        return;
    }

    if (!bActionStarted)
        // Fire the spellcasting action started event
        if (!JXEventActionCastSpellStarted(oCaster,
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
            ClearAllActions();
            JXClearActionQueue();
            return;
        }

    // Wait if the caster near his target is moving to cast the spell
    location lLastCasterLocation = GetLocalLocation(oCaster, "JX_CASTER_LAST_LOCATION");
    location lCurrentCasterLocation = GetLocation(oCaster);
    if (lCurrentCasterLocation != lLastCasterLocation)
    {
        SetLocalLocation(oCaster, "JX_CASTER_LAST_LOCATION", lCurrentCasterLocation);
        DelayCommand(0.1, JXPrivateStartActionCastSpell(iActionId, FALSE, TRUE));
        return;
    }
    DeleteLocalLocation(oCaster, "JX_CASTER_LAST_LOCATION");

    // Fire the conjuration animation started event
    if (!JXEventActionCastSpellConjuring(oCaster,
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
        ClearAllActions();
        JXClearActionQueue();
        return;
    }

    // Call the post conjuration event
    int iConjurationTime = StringToInt(Get2DAString("spells", "ConjTime", actionCastSpell.iSpellId));
    DelayCommand(IntToFloat(iConjurationTime - 250) / 1000.0, JXPrivateFireActionCastSpellConjured(oCaster, actionCastSpell));

    // Remove the spell cast action at the end of the round
    struct jx_action_castspell actionCastSpell2 = JXGetActionCastSpellFromQueue(2);
    if (!(actionCastSpell2.iMetaMagicFeat & METAMAGIC_QUICKEN))
        DelayCommand(5.5, JXRemoveFirstActionCastSpellFromQueue(TRUE, iActionId));
}

// Make a creature cast a spell at a location by performing an action
// - lTarget Target location of the spell
// - iSpellId SPELL_* constant
// - iMetaMagicFeat METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iSpellSaveDC Difficulty check for the spell
// - iClass Class used to cast the spell
void JXActionCastSpellAtLocation(location lTarget,
                                 int iSpellId,
                                 int iMetaMagicFeat,
                                 int iCasterLevel,
                                 int iSpellSaveDC,
                                 int iClass)
{
    int bPreRoundAction = FALSE;

    struct jx_action_castspell actionCastSpell;
    actionCastSpell.iActionId = JXFindNewActionCastSpellIdentifier();
    actionCastSpell.iSpellId = iSpellId;
    actionCastSpell.oTarget = OBJECT_INVALID;
    actionCastSpell.lTarget = lTarget;
    actionCastSpell.iCasterLevel = iCasterLevel;
    actionCastSpell.iMetaMagicFeat = iMetaMagicFeat;
    actionCastSpell.iSpellSaveDC = iSpellSaveDC;
    actionCastSpell.iClass = iClass;

    if (iMetaMagicFeat & METAMAGIC_QUICKEN)
    {
        int iCurrentAction = GetCurrentAction();
        bPreRoundAction = (iCurrentAction == ACTION_INVALID) || (Get2DAString("actions", "TIMER", iCurrentAction) == "0");
        actionCastSpell.bPreRoundAction = bPreRoundAction;
        if (JXAddActionCastSpellToQueue(actionCastSpell))
            ActionCastSpellAtLocation(iSpellId, lTarget, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
        else if (JXAddActionCastSpellToQueue(actionCastSpell))
    {
        int bIsMoving = (GetCurrentAction() == ACTION_MOVETOPOINT) ? TRUE : FALSE;
        ActionCastSpellAtLocation(iSpellId, lTarget, METAMAGIC_ANY, TRUE);
        JXPrivateStartActionCastSpell(actionCastSpell.iActionId, bIsMoving);
    }
}

// Make a creature cast a spell at an object by performing an action
// - oTarget Target creature/placeable of the spell
// - iSpellId SPELL_* constant
// - iMetaMagicFeat METAMAGIC_* constant
// - iCasterLevel Spell caster level
// - iSpellSaveDC Difficulty check for the spell
// - iClass Class used to cast the spell
void JXActionCastSpellAtObject(object oTarget,
                               int iSpellId,
                               int iMetaMagicFeat,
                               int iCasterLevel,
                               int iSpellSaveDC,
                               int iClass)
{
    int bPreRoundAction = FALSE;

    struct jx_action_castspell actionCastSpell;
    actionCastSpell.iActionId = JXFindNewActionCastSpellIdentifier();
    actionCastSpell.iSpellId = iSpellId;
    actionCastSpell.oTarget = oTarget;
    actionCastSpell.lTarget = GetLocation(oTarget);
    actionCastSpell.iCasterLevel = iCasterLevel;
    actionCastSpell.iMetaMagicFeat = iMetaMagicFeat;
    actionCastSpell.iSpellSaveDC = iSpellSaveDC;
    actionCastSpell.iClass = iClass;

    if (iMetaMagicFeat & METAMAGIC_QUICKEN)
    {
        int iCurrentAction = GetCurrentAction();
        bPreRoundAction = (iCurrentAction == ACTION_INVALID) || (Get2DAString("actions", "TIMER", iCurrentAction) == "0");
        actionCastSpell.bPreRoundAction = bPreRoundAction;
        if (JXAddActionCastSpellToQueue(actionCastSpell))
            ActionCastSpellAtObject(iSpellId, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (JXAddActionCastSpellToQueue(actionCastSpell))
    {
        int bIsMoving = (GetCurrentAction() == ACTION_MOVETOPOINT) ? TRUE : FALSE;
        ActionCastSpellAtObject(iSpellId, oTarget, METAMAGIC_ANY, TRUE);
        JXPrivateStartActionCastSpell(actionCastSpell.iActionId, bIsMoving);
    }
}
