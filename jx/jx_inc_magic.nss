//::///////////////////////////////////////////////
//:: JX Spellcasting Framework Include
//:: jx_inc_magic
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: Mar 1, 2007
//:: Updated On: Mar 7, 2007
//:: Updated On: Mar 13, 2007
//:://////////////////////////////////////////////
//
// Functions in this include file provide many improvements
// to the standard NWN2 spellcasting system.
//
// 1 - The JXActionCastSpellAtXXX() functions permit a creature to enqueue a spellcasting action. Metamagic
//     (even silent, still and quicken), caster level, save DC, and class can be specified as parameters for
//     these functions.
//   Ex : JXActionCastSpellAtObject(oTarget, SPELL_MELFS_ACID_ARROW, METAMAGIC_QUICKEN, 7, 18, CLASS_TYPE_WIZARD);
//        will enqueue a Melf's Acid Arrow casting action with the target "oTarget", the
//        "Quicken" metamagic feature, a caster level of 7, and a save DC of 18. The spell will be cast as a
//        wizard, so Arcane Spell Failure will apply.
//
// 2 - The JXCastSpellXXX() functions permit to cast any spell from a given object/location. Metamagic,
//     caster level and save DC can be specified as parameters for these functions.
//   Ex : JXCastSpellFromLocationAtObject(lSource, oTarget, SPELL_MELFS_ACID_ARROW, METAMAGIC_EXTEND, 10, 15);
//        will cast a Melf's Acid Arrow from the location "lSource" to the target "oTarget" with the
//        "Extended" metamagic feature, a caster level of 10, and a save DC of 15.
//
// 3 - The standard pre-cast spell hook can make use of the JXSetMetaMagicFeat(), JXSetSpellSaveDC() and
//     JXSetCasterLevel() functions to modify "on the fly" the power of a spell. They can be used outside
//     the hook and will affect the next cast spell. Multiple metamagic features are now supported.
//   Ex : if (GetLocalInt(GetArea(OBJECT_SELF), "AREA_MAXIMIZE") == 1)
//            JXSetMetaMagicFeat(METAMAGIC_MAXIMIZE);
//        will make all spells cast in the current area to be affected by the "Maximize" metamagic feature.
//
// 4 - A Post-cast spell hook is now available. Execute the script you want after a spell script execution
//     by adding a line in the "x2_mod_def_load.nss" file, like in the example below.
//   Ex : SetLocalString(GetModule(), "JX_POST_SPELLSCRIPT", "test_spellhook_post");
//        will make the "test_spellhook_post.nss" script to execute after each cast spell.
//
// 5 - For spell creators, use JXGetMetaMagicFeat(), JXGetSpellSaveDC() and JXGetCasterLevel() instead of
//     the standard NWN2 functions. Use JXApplyAreaEffectAtXXX() to create areas of effect and
//     JXResistSpell() instead of ResistSpell() (or better, simply use MyResistSpell()).
//
// 6 - To properly implement a dead/wild magic zone system, the JXCastSpellXXX() can ignore dead/wild
//     magic zones. Also use JXSetIgnoreDeadZone() and JXGetIgnoreDeadZone() in your pre-cast spell hook.
//
//:://////////////////////////////////////////////
// 03/07/2007 : * Corrected a bug in JXCastSpellFromLocationAtXXX() that
//                stopped some spells to work before they are finished
//              * Moved information content into "jx_inc_magic_info.nss"
//                (JXGetSpellRangeType() & JXGetSpellRange())
//              * Moved GetScaledEffect() from "nw_i0_spells.nss"
// 03/13/2007 : * Rewritten JXSetMetaMagicFeat() and JXGetMetaMagicFeat()
//                and added JXClearMetaMagicFeat()
//              * Corrected a bug in JXResistSpell()
// 03/23/2007 : * Moved constants in "jx_inc_magic_const.nss"
// 08/17/2007 : * Added JXApplyEffectAtLocation(), JXApplyEffectToObject(),
//                JXGetAOERealCreator() for effect informations
//              * JXGetActiveSpells(), JXGetSpellCasterLevel(),
//                JXGetSpellMetaMagicFeat(), JXGetSpellSpellSaveDC() &
//                JXGetSpellCreator() to get active spell infos
//              * Added  JXGetMagicalAura() & JXGetMagicalAuraStrengthName()
//                for magical auras management
// 11/26/2007 : * Added JXActionCastSpellAtXXX()
//              * Added JXGetCaster() & JXGetSpellId()
//              * Added JXSet/Get/RemoveSpellTargetLocation/Object()
//              * Moved IPGetTargetedOrEquippedMeleeWeapon() &
//                IPGetTargetedOrEquippedArmor() from "x2_inc_itemprop.nss"
//:://////////////////////////////////////////////

// SHAZBOTIAN 022008: modified JXResist and the AOE functions to get a creator stored in a placeable,
//                    if the placeable spellcaster is used; this allows targets of said spells to resist, absorb, or be immune to them
// 2DruNk2Frag 02-22-08 Commented out IPGetTargetedOrEquippedMeleeWeapon() &
//                IPGetTargetedOrEquippedArmor() due to compile error "duplicate function implementation"
// implicit-image  05-30-24:
//                           * Added check for selective magic to JXApplyEffectToObject()
//                           * Added hook for overriding and adding on hit effects
//#include "jx_inc_magic_info"
#include "jx_inc_magic_item"
#include "jx_inc_magic_class"
#include "jx_inc_action"
#include "jx_inc_magic_wild"

#include "utils"
// to silence errors
// #include "2d2f_includes"
//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//


// Structure to hold informations about a magical aura
struct jx_magic_aura
{
    int strength;
    int school;
};

// Get the metamagic value (METAMAGIC_*) of the current spell cast by the specified caster.
// It gets the metamagic value returned by the GetMetaMagicFeat(), or the value previously
// set by JXSetMetaMagicFeat().
// The returned value may contain many metamagic values : use the AND operator (&) instead
// of the Equal (==) operator to compare the result of this function with a metamagic value
// Ex: if (JXGetMetaMagicFeat() & METAMAGIC_EXTEND) ...
// - oCaster Caster of the spell (only useful when JXSetMetaMagicFeat() has been used)
// * Return value if the caster is not a valid object: -1, else a combination of
//   METAMAGIC_* constants
int JXGetMetaMagicFeat(object oCaster = OBJECT_SELF);

// Set the metamagic value (METAMAGIC_*) for the current spell cast by the specified caster.
// Many values can be set at the same time and a replacement mode determines what must be set.
// Ex: JXSetMetaMagicFeat(METAMAGIC_EMPOWER | METAMAGIC_EXTEND) sets both metamagic values.
// Three kinds of metamagic values exist (from the least to the most powerful):
//     * Strength : METAMAGIC_EMPOWER -> METAMAGIC_MAXIMIZE
//     * Duration : METAMAGIC_EXTEND -> METAMAGIC_PERSISTENT -> METAMAGIC_PERMANENT
//     * Invocation : METAMAGIC_INVOC_* (no order)
// Only one metamagic value of each kind is set at the same time.
// - iMetamagic Combination of METAMAGIC_* constants to set
// - oCaster Caster of the spell (only useful when JXSetMetaMagicFeat() has been used)
// - iReplaceMode JX_METAMAGIC_REPLACE_YES to replace a value previously set or to set a new one
//                JX_METAMAGIC_REPLACE_NO to keep using a value previously set if it exists
//                JX_METAMAGIC_REPLACE_BEST to keep the best value between the old and the new one
void JXSetMetaMagicFeat(int iMetamagic, object oCaster = OBJECT_SELF, int iReplaceMode = JX_METAMAGIC_REPLACE_BEST);

// Remove the metamagic value specified for the current spell cast by the specified caster.
// - iMetamagic Combination of METAMAGIC_* constants to remove (default: everything)
// - oCaster Caster of the spell (only usefull when JXSetMetaMagicFeat() has been used)
void JXClearMetaMagicFeat(int iMetamagic = METAMAGIC_ANY, object oCaster = OBJECT_SELF);

// Get the DC to save against for a spell (10 + spell level + relevant ability
// bonus). This can be called by a creature or by an Area of Effect object.
// If a custom DC was set with JXSetSpellSaveDC(), this one is returned.
// - oCaster Caster of the spell
// * Return the DC for the spell
int JXGetSpellSaveDC(object oCaster = OBJECT_SELF);

// Set a custom DC to save against for the spell
// - iDC Save DC to set for the next spell used
// - oCaster Caster of the spell
void JXSetSpellSaveDC(int iDC, object oCaster = OBJECT_SELF);

// Get the level at which this creature casts the current spell (or spell-like ability).
// If a custom caster level was set with JXSetCasterLevel(), this one is returned.
// - oCaster Caster of the spell
// * Return value on error, or if oCreature has not cast a spell yet: 0;
int JXGetCasterLevel(object oCaster = OBJECT_SELF);

// Set a custom caster level for the current spell.
// - iCasterLevel Caster level to use for the current spell
// - oCaster Caster of the spell
void JXSetCasterLevel(int iCasterLevel, object oCaster = OBJECT_SELF);

// Do a Spell Resistance check between oCaster and oTarget, returning TRUE if
// the spell was resisted.
// * Return SPELL_RESIST_FAIL if spell bypassed spell resistance
// * Return SPELL_RESIST_PASS if spell resisted
// * Return SPELL_RESIST_GLOBE if spell resisted via magic immunity
// * Return SPELL_RESIST_MANTLE if spell resisted via spell absorption
int JXResistSpell(object oCaster, object oTarget);

// The caster makes a caster level check against the specified DC.
// - oCaster Creature that makes the caster level check
// - iDC Difficulty Class of the check
// * Returns TRUE if the caster succeeds the check
int JXCasterLevelCheck(object oCaster, int iDC);

// Get the creature associated with the placeable used to cast the spell
// - oPlaceable Placeable that casts a spell
// * Returns the creature associated with the placeable if it exists
object JXGetCaster(object oPlaceable = OBJECT_SELF);

// Set the identifier of the spell being cast
// - iSpellId Spell identifier
// - oCaster Creature that is casting a spell
void JXSetSpellId(int iSpellId, object oCaster = OBJECT_SELF);

// Get the identifier of the spell being cast
// - oCaster Creature that is casting a spell
// * Returns the identifier of the spell
int JXGetSpellId(object oCaster = OBJECT_SELF);

// Set the target location of a spell being cast
// - lTarget Spell target location
// - oCaster Creature that is casting a spell
void JXSetSpellTargetLocation(location lTarget, object oCaster = OBJECT_SELF);

// Get the target location of a spell being cast
// - oCaster Creature that is casting a spell
// * Returns the spell target location
location JXGetSpellTargetLocation(object oCaster = OBJECT_SELF);

// Set the target object of a spell being cast
// - oTarget Spell target object
// - oCaster Creature that is casting a spell
void JXSetSpellTargetObject(object oTarget, object oCaster = OBJECT_SELF);

// Get the target object of a spell being cast
// - oCaster Creature that is casting a spell
// * Returns the spell target object
object JXGetSpellTargetObject(object oCaster = OBJECT_SELF);


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

//========================================== Spell Effects ==========================================//

// Apply an effect to the specified location and save spell informations
// - iDuration DURATION_TYPE_* constant
// - eEffect Effect to apply at the location
// - lLocation Location to apply the effect at
// - fDuration Duration of the spell if iDuration is DURATION_TYPE_TEMPORARY
void JXApplyEffectAtLocation(int iDuration, effect eEffect, location lLocation, float fDuration=0.0f);

// Apply an effect to the specified object and save spell informations
// - iDuration DURATION_TYPE_* constant
// - eEffect Effect to apply to the object
// - oTarget Object to apply the effect to
// - fDuration Duration of the spell if iDuration is DURATION_TYPE_TEMPORARY
void JXApplyEffectToObject(int iDuration, effect eEffect, object oTarget, float fDuration=0.0f, int iEffectType=-1);

// Create an area of effect for the current spell and apply it at the specified location.
// Areas of effect created by this way have the following properties :
//   * continue to work after the death of the caster
//   * Make use of overridden spell properties (caster level, DC, metamagic)
//   * Can be cast by a placeable
// - nAreaEffectId Area of effect identifier (AOE_*)
// - ltarget Target location of the spell
// - nDuration Duration of the spell, permanent if this value is 0
// - sOnEnterScript Overriden OnEnter script for the AoE
// - sOnHeartbeatScript Overriden OnHeartbeat script for the AoE
// - sOnExitScript Overriden OnExit script for the AoE
// - sEffectTag Tag for the AoE object
// - iEffectSubType SUBTYPE_* constant for the effect
void JXApplyAreaEffectAtLocation(int nAreaEffectId,
                                 location lTarget,
                                 float nDuration = 0.0f,
                                 string sOnEnterScript = "",
                                 string sOnHeartbeatScript = "",
                                 string sOnExitScript = "",
                                 string sEffectTag = "",
                                 int iEffectSubType = SUBTYPE_MAGICAL);

// Create an area of effect for the current spell and apply it to the specified object.
// Areas of effect created by this way have the following properties :
//   * continue to work after the death of the caster
//   * Make use of overridden spell properties (caster level, DC, metamagic)
//   * Can be cast by a placeable
// - nAreaEffectId Area of effect identifier (AOE_*)
// - otarget Target of the spell
// - nDuration Duration of the spell, permanent if this value is 0
// - sOnEnterScript Overriden OnEnter script for the AoE
// - sOnHeartbeatScript Overriden OnHeartbeat script for the AoE
// - sOnExitScript Overriden OnExit script for the AoE
// - sEffectTag Tag for the AoE object
// - iEffectSubType SUBTYPE_* constant for the effect
void JXApplyAreaEffectToObject(int nAreaEffectId,
                               object oTarget,
                               float nDuration = 0.0f,
                               string sOnEnterScript = "",
                               string sOnHeartbeatScript = "",
                               string sOnExitScript = "",
                               string sEffectTag = "",
                               int iEffectSubType = SUBTYPE_MAGICAL);

// Get the real creator of an area of effect.
// N.B. : A call to GetAreaOfEffectCreator() on an area of effect that has been
// created with JXApplyAreaEffectToXXX() would return an "Attach Spell Node" creature.
// - oAOE Area of effect
// * Returns the real creator of the spell, or
object JXGetAOERealCreator(object oAOE = OBJECT_SELF);

// * Get Scaled Effect
effect GetScaledEffect(effect eStandard, object oTarget);

// Create a charmed effect that uses the nearest creature as the caster
// if the current one is a placeable
// - otarget Target of the spell
// - nDuration Duration of the spell, permanent if this value is 0
void JXApplyCharmedEffectToObject(object oTarget, float fDuration);

// Create a dominated effect that uses the nearest creature as the caster
// if the current one is a placeable
// - otarget Target of the spell
// - nDuration Duration of the spell, permanent if this value is 0
void JXApplyDominatedEffectToObject(object oTarget, float fDuration);


//========================================== Active Spells ==========================================//

// Get the list of active spells currently active on a creature
// - oTarget Creature to get the active spells from
// * Returns a list of spell identifiers in a string form (ex: 104;3;862)
string JXGetActiveSpells(object oTarget);

// Get the caster level of a spell currently active on a creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: -1,
//   else the caster level of the spell specified
int JXGetSpellCasterLevel(object oTarget, int iSpellId);

// Get the metamagic feats of a spell currently active on a creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: -1,
//   else a combination of METAMAGIC_* constants
int JXGetSpellMetaMagicFeat(object oTarget, int iSpellId);

// Get the save DC of a spell currently active on a creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: -1,
//   else the save DC of the spell specified
int JXGetSpellSpellSaveDC(object oTarget, int iSpellId);

// Get the creature that created a spell currently active on another creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: OBJECT_INVALID,
//   else the creator of the spell specified
object JXGetSpellCreator(object oTarget, int iSpellId);


//========================================== Magical Aura ==========================================//

// Get the strength of a magical aura
// - oSource Source creature or item for a potential aura
// - bHiddenItemProps To also get hidden item magical properties
// * Returns a JX_AURASTRENGTH_* constant
struct jx_magic_aura JXGetMagicalAura(object oSource, int bHiddenItemProps = FALSE);

// Get the associated name of magical aura strength
// - iAuraStrength JX_AURASTRENGTH_* constant
// * Returns the name of the magical aura strength
string JXGetMagicalAuraStrengthName(int iAuraStrength);



//========================================== On Apply Spell Effect Hook ==========================================//

int JXOnApplySpellEffectCode(object oCaster, object oTarget, effect eEffect);

// Set the result of running user on_apply_spell_effect script on a target
// For use in the user script
void JXSetOnApplySpellEffectResult(int iValue, object oTarget=OBJECT_SELF);


//========================================== Post-cast spell hook ==========================================//

// Reinitialize all Spellcasting Framework variables and
// call the post spellscript defined by the user
void JXPostSpellCastCode();


//**************************************//
//                                      //
//            Implementation            //
//                                      //
//**************************************//



// Spell properties override constants
const string JX_METAMAGIC_BYPASS_STD    = "JX_METAMAGIC_BYPASS_STD";
const string JX_METAMAGIC               = "JX_METAMAGIC";
const string JX_SPELL_DC_OVERRIDE       = "JX_SPELL_DC_OVERRIDE";
const string JX_CASTER_LEVEL_OVERRIDE   = "JX_CASTER_LEVEL_OVERRIDE";
const string JX_SPELL_ID                = "JX_SPELL_ID";
const string JX_SPELL_TARGET_LOCATION   = "JX_SPELL_TARGET_LOCATION";
const string JX_SPELL_TARGET_OBJECT         = "JX_SPELL_TARGET_OBJECT";

// Area of effect constants
const string JX_AOE_CASTER_TMP_LOCATION = "jxwp_loc_temp";
const string JX_AOE_CASTER_TAG          = "c_attachspellnode";
const string JX_AOE_REAL_CREATOR        = "JX_AOE_REAL_CREATOR";

// Spell constants
const string JX_REAL_CREATOR = "JX_REAL_CREATOR";
const string JX_CAST_SPELLS_INFO = "JX_CAST_SPELLS_INFO";

// Spell Turning constants
const string JX_SPELLTURN_ACTIVE = "JX_SPELLTURN_ACTIVE";
const string JX_SP_SPELLTURN_LVLS = "JX_SP_SPELLTURN_LVLS";


// Constants that dictate ResistSpell results
const int SPELL_RESIST_FAIL = 0;
const int SPELL_RESIST_PASS = 1;
const int SPELL_RESIST_GLOBE = 2;
const int SPELL_RESIST_MANTLE = 3;
// Get the metamagic value (METAMAGIC_*) of the current spell cast by the specified caster.
// It gets the metamagic value returned by the GetMetaMagicFeat(), or the value previously
// set by JXSetMetaMagicFeat().
// The returned value may contain many metamagic values : use the AND operator (&) instead
// of the Equal (==) operator to compare the result of this function with a metamagic value
// Ex: if (JXGetMetaMagicFeat() & METAMAGIC_EXTEND) ...
// - oCaster Caster of the spell (only usefull when JXSetMetaMagicFeat() has been used)
// * Return value if the caster is not a valid object: -1, else a combination of
//   METAMAGIC_* constants
int JXGetMetaMagicFeat(object oCaster = OBJECT_SELF)
{
    // Get the "engine" metamagic feature
    int bBypassStdMetamagic = GetLocalInt(oCaster, JX_METAMAGIC_BYPASS_STD);
    int iStdMetamagic = 0;
    if (bBypassStdMetamagic == 0)
        iStdMetamagic = GetMetaMagicFeat();
    if (iStdMetamagic == -1 ) iStdMetamagic = 0;

    return GetLocalInt(oCaster, JX_METAMAGIC) | iStdMetamagic;
}

// Set the metamagic value (METAMAGIC_*) for the current spell cast by the specified caster.
// Many values can be set at the same time and a replacement mode determines what must be set.
// Ex: JXSetMetaMagicFeat(METAMAGIC_EMPOWER | METAMAGIC_EXTEND) sets both metamagic values.
// Three kinds of metamagic values exist (from the least to the most powerful):
//     * Strength : METAMAGIC_EMPOWER -> METAMAGIC_MAXIMIZE
//     * Duration : METAMAGIC_EXTEND -> METAMAGIC_PERSISTENT -> METAMAGIC_PERMANENT
//     * Invocation : METAMAGIC_INVOC_* (no order)
// Only one metamagic value of each kind is set at the same time.
// - iMetamagic Combination of METAMAGIC_* constants to set
// - oCaster Caster of the spell (only usefull when JXSetMetaMagicFeat() has been used)
// - iReplaceMode JX_METAMAGIC_REPLACE_YES to replace a value previously set or to set a new one
//                JX_METAMAGIC_REPLACE_NO to keep using a value previously set if it exists
//                JX_METAMAGIC_REPLACE_BEST to keep the best value between the old and the new one
void JXSetMetaMagicFeat(int iMetamagic, object oCaster = OBJECT_SELF, int iReplaceMode = JX_METAMAGIC_REPLACE_BEST)
{
    // Use JXClearMetaMagicFeat() to remove metamagic values
    if (iMetamagic == METAMAGIC_NONE) return;

    // Get the "engine" metamagic feature
    int bBypassStdMetamagic = GetLocalInt(oCaster, JX_METAMAGIC_BYPASS_STD);
    int iStdMetamagic = 0;
    if (bBypassStdMetamagic == 0)
    {
        iStdMetamagic = GetMetaMagicFeat();
        if (iStdMetamagic == -1) iStdMetamagic = 0;
        SetLocalInt(oCaster, JX_METAMAGIC_BYPASS_STD, 1);
    }

    // Set the new metamagic feature(s)
    int iJXMetamagic = GetLocalInt(oCaster, JX_METAMAGIC) | iStdMetamagic;

    // Empower has to be set
    if (iMetamagic & METAMAGIC_EMPOWER)
        iJXMetamagic = iJXMetamagic | METAMAGIC_EMPOWER;

    // Maximize has to be set
    if (iMetamagic & METAMAGIC_MAXIMIZE)
        iJXMetamagic = iJXMetamagic | METAMAGIC_MAXIMIZE;

    // Extend has to be set
    if (iMetamagic & METAMAGIC_EXTEND)
    {
        if ((iJXMetamagic & METAMAGIC_PERSISTENT)
         || (iJXMetamagic & METAMAGIC_PERMANENT))
        {
            // Extend replaces Persistent or Permanent
            if (iReplaceMode == JX_METAMAGIC_REPLACE_YES)
            {
                iJXMetamagic = iJXMetamagic | METAMAGIC_EXTEND;
                iJXMetamagic = iJXMetamagic ^ METAMAGIC_PERSISTENT ^ METAMAGIC_PERMANENT;
            }
        }
        else
            iJXMetamagic = iJXMetamagic | METAMAGIC_EXTEND;
    }

    // Persistent has to be set
    if (iMetamagic & METAMAGIC_PERSISTENT)
    {
        if (iJXMetamagic & METAMAGIC_EXTEND)
        {
            // Persistent replaces Extend
            if ((iReplaceMode == JX_METAMAGIC_REPLACE_YES)
             || (iReplaceMode == JX_METAMAGIC_REPLACE_BEST))
            {
                iJXMetamagic = iJXMetamagic | METAMAGIC_PERSISTENT;
                iJXMetamagic = iJXMetamagic ^ METAMAGIC_EXTEND;
            }
        }
        else if (iJXMetamagic & METAMAGIC_PERMANENT)
        {
            // Persistent replaces Permanent
            if (iReplaceMode == JX_METAMAGIC_REPLACE_YES)
            {
                iJXMetamagic = iJXMetamagic | METAMAGIC_PERSISTENT;
                iJXMetamagic = iJXMetamagic ^ METAMAGIC_PERMANENT;
            }
        }
        else
            iJXMetamagic = iJXMetamagic | METAMAGIC_PERSISTENT;
    }

    // Permanent has to be set
    if (iMetamagic & METAMAGIC_PERMANENT)
    {
        if ((iJXMetamagic & METAMAGIC_EXTEND)
         || (iJXMetamagic & METAMAGIC_PERSISTENT))
        {
            // Permanent replaces Extend or Persistent
            if ((iReplaceMode == JX_METAMAGIC_REPLACE_YES)
             || (iReplaceMode == JX_METAMAGIC_REPLACE_BEST))
            {
                iJXMetamagic = iJXMetamagic | METAMAGIC_PERMANENT;
                iJXMetamagic = iJXMetamagic ^ METAMAGIC_EXTEND ^ METAMAGIC_PERSISTENT;
            }
        }
        else
            iJXMetamagic = iJXMetamagic | METAMAGIC_PERMANENT;
    }

    // Warlock invocations
    if (iMetamagic & METAMAGIC_INVOC_DRAINING_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_DRAINING_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_SPEAR)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_SPEAR;
    if (iMetamagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_FRIGHTFUL_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_HIDEOUS_BLOW)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_HIDEOUS_BLOW;
    if (iMetamagic & METAMAGIC_INVOC_BESHADOWED_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_BESHADOWED_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_BRIMSTONE_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_BRIMSTONE_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_CHAIN)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_CHAIN;
    if (iMetamagic & METAMAGIC_INVOC_HELLRIME_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_HELLRIME_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_BEWITCHING_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_BEWITCHING_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_CONE)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_CONE;
    if (iMetamagic & METAMAGIC_INVOC_NOXIOUS_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_NOXIOUS_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_VITRIOLIC_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_VITRIOLIC_BLAST;
    if (iMetamagic & METAMAGIC_INVOC_ELDRITCH_DOOM)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_ELDRITCH_DOOM;
    if (iMetamagic & METAMAGIC_INVOC_UTTERDARK_BLAST)
        iJXMetamagic = iJXMetamagic | METAMAGIC_INVOC_UTTERDARK_BLAST;

    SetLocalInt(oCaster, JX_METAMAGIC, iJXMetamagic);
}

// Remove the metamagic value specified for the current spell cast by the specified caster.
// - iMetamagic Combination of METAMAGIC_* constants to remove (default: everything)
// - oCaster Caster of the spell (only usefull when JXSetMetaMagicFeat() has been used)
void JXClearMetaMagicFeat(int iMetamagic = METAMAGIC_ANY, object oCaster = OBJECT_SELF)
{
    // Get the "engine" metamagic feature
    int bBypassStdMetamagic = GetLocalInt(oCaster, JX_METAMAGIC_BYPASS_STD);
    int iStdMetamagic = 0;
    if (bBypassStdMetamagic == 0)
    {
        iStdMetamagic = GetMetaMagicFeat();
        if (iStdMetamagic == -1 ) iStdMetamagic = 0;
        SetLocalInt(oCaster, JX_METAMAGIC_BYPASS_STD, 1);
    }

    // Set the new metamagic feature
    int iJXMetamagic = GetLocalInt(oCaster, JX_METAMAGIC) | iStdMetamagic;
    int iMetamagicDelete = iJXMetamagic & iMetamagic;
    int iJXMetamagicNew = iJXMetamagic ^ iMetamagicDelete;
    if (iJXMetamagic != iJXMetamagicNew)
        SetLocalInt(oCaster, JX_METAMAGIC, iJXMetamagicNew);
}

// Get the DC to save against for a spell (10 + spell level + relevant ability
// bonus). This can be called by a creature or by an Area of Effect object.
// If a custom DC was set with JXSetSpellSaveDC(), this one is returned.
// - oCaster Caster of the spell
// * Return the DC for the current spell
int JXGetSpellSaveDC(object oCaster = OBJECT_SELF)
{
    if (GetObjectType(oCaster) == OBJECT_TYPE_AREA_OF_EFFECT)
        oCaster = GetAreaOfEffectCreator();

    // Get the value of the custom save DC to use
    // For AOE spells, this value is automatically set
    int iDC = GetLocalInt(oCaster, JX_SPELL_DC_OVERRIDE);

    // Return the custom DC value if it exists, else return the "engine" one
    if (iDC > 0)
        return iDC;
    else
        return GetSpellSaveDC();
}

// Set a custom DC to save against for the spell
// - iDC Save DC to set for the next spell used
// - oCaster Caster of the spell
void JXSetSpellSaveDC(int iDC, object oCaster = OBJECT_SELF)
{
    SetLocalInt(oCaster, JX_SPELL_DC_OVERRIDE, iDC);
}

// Get the level at which this creature casts the current spell (or spell-like ability).
// If a custom caster level was set with JXSetCasterLevel(), this one is returned.
// - oCaster Caster of the spell
// * Return value on error, or if oCreature has not cast a spell yet: 0;
int JXGetCasterLevel(object oCaster = OBJECT_SELF)
{
    if (GetObjectType(oCaster) == OBJECT_TYPE_AREA_OF_EFFECT)
        oCaster = GetAreaOfEffectCreator();

    // Get the value of the custom caster level to use
    // For AOE spells, this value is automatically set
    int iCasterLevel = GetLocalInt(oCaster, JX_CASTER_LEVEL_OVERRIDE);

    // Return the custom caster level value if it exists, else return the "engine" one
    if (iCasterLevel > 0)
        return iCasterLevel;
    else
        return GetCasterLevel(oCaster);
}

// Set a custom caster level for the current spell.
// - iCasterLevel Caster level to use for the current spell
// - oCaster Caster of the spell
void JXSetCasterLevel(int iCasterLevel, object oCaster = OBJECT_SELF)
{
    SetLocalInt(oCaster, JX_CASTER_LEVEL_OVERRIDE, iCasterLevel);
}

// Private - Used by JXResistSpell() for the Spell Turning effect
void SendMessageResistToPC(object oPC, int iSpellLevel, int iSpellLevelsLeft)
{
    // Message 1
    string message = GetStringByStrRef(52973);

    message = JXStringReplaceToken(message, 0, GetFirstName(oPC) + " " + GetLastName(oPC));
    message = JXStringReplaceToken(message, 1, IntToString(iSpellLevel));
    message = JXStringReplaceToken(message, 2, IntToString(iSpellLevelsLeft));
    message = "<color=mediumorchid>" + message + "</color>";
    SendMessageToPC(oPC, message);

    // Message 2
    message = GetStringByStrRef(8342);
    string sReplace0 = GetFirstName(oPC) + " " + GetLastName(oPC);
    string sReplace1 = GetStringByStrRef(8345);

    int iPosCustom0 = FindSubString(message, "<CUSTOM0>");
    int iPosCustom1 = FindSubString(message, "<CUSTOM1>");

    message = "<color=mediumorchid>" +
              GetSubString(message, 0, iPosCustom0) +
              "</color><color=skyblue>" +
              sReplace0 +
              "</color><color=mediumorchid>" +
              GetSubString(message, iPosCustom0 + 9, iPosCustom1 - iPosCustom0 - 9) +
              sReplace1 +
              GetSubString(message, iPosCustom1 + 9, GetStringLength(message) - iPosCustom1 - 9) +
              "</color>";
    SendMessageToPC(oPC, message);
}

// Do a Spell Resistance check between oCaster and oTarget, returning TRUE if
// the spell was resisted.
// * Return SPELL_RESIST_FAIL if spell bypassed spell resistance
// * Return SPELL_RESIST_PASS if spell resisted
// * Return SPELL_RESIST_GLOBE if spell resisted via magic immunity
// * Return SPELL_RESIST_MANTLE if spell resisted via spell absorption
int JXResistSpell(object oCaster, object oTarget)
{
    // Get the original caster if the current one is an area of effect
    object oOriginCaster = oCaster;
    if (GetTag(oCaster) == JX_AOE_CASTER_TAG)
        oOriginCaster = GetLocalObject(oCaster, JX_AOE_REAL_CREATOR);
    // Shaz: added this to solve the problem of a "placeable" spellcaster not being resistable
    if (GetTag(oCaster) == "jx_ipoint_caster")
        oOriginCaster = GetLocalObject(oCaster, JX_REAL_CREATOR);

    // Test spell protection
    int iProtection = ResistSpell(oOriginCaster, oTarget);
    if (iProtection == SPELL_RESIST_GLOBE) return SPELL_RESIST_GLOBE;
    if (iProtection == SPELL_RESIST_MANTLE) return SPELL_RESIST_MANTLE;

    // Turn back the spell to the caster if the target is
    // protected by a Spell Turning effect
    if ((GetHasSpellEffect(SPELL_SPELL_TURNING, oTarget))
        && (JXGetHasSpellTargetTypeArea(GetSpellId()) == FALSE)
        && (JXGetSpellRange(GetSpellId()) > 0.0)
        && (JXGetIsSpellUsingRangedTouchAttack(GetSpellId()) == FALSE))
    {
        // Cast the same spell from the target to the caster
        int iSpellLevelsLeft = GetLocalInt(oTarget, JX_SP_SPELLTURN_LVLS);
        // Decrease the number of spell absorption levels
        int iSpellLevel = GetSpellLevel(GetSpellId());
        if (iSpellLevelsLeft - iSpellLevel > 0)
        {
            if (GetIsPC(oTarget))
                SendMessageResistToPC(oTarget, iSpellLevel, iSpellLevelsLeft - iSpellLevel);

            SetLocalInt(oTarget, JX_SP_SPELLTURN_LVLS, iSpellLevelsLeft - iSpellLevel);
            return SPELL_RESIST_MANTLE;
        }
        // Remove the Spell Turning effect if no spell absorption levels are left
        if (iSpellLevelsLeft - iSpellLevel == 0)
        {
            if (GetIsPC(oTarget))
                SendMessageResistToPC(oTarget, iSpellLevel, 0);

            DeleteLocalInt(oTarget, JX_SP_SPELLTURN_LVLS);
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                if (GetEffectSpellId(eLoop) == SPELL_SPELL_TURNING)
                    RemoveEffect(oTarget, eLoop);
                effect eLoop = GetNextEffect(oTarget);
            }
            return SPELL_RESIST_MANTLE;
        }
        if (iSpellLevelsLeft - iSpellLevel >= 0)
            JXCastSpellFromLocationAtObject(GetLocation(oTarget),
                                            oCaster,
                                            GetSpellId(),
                                            JXGetMetaMagicFeat(oCaster),
                                            JXGetCasterLevel(oCaster),
                                            JXGetSpellSaveDC(oCaster),
                                            TRUE,
                                            oCaster);
    }

    // Get the caster level used for the spell
    int iCasterLevel = JXGetCasterLevel(oCaster);

    // Increase the caster level if the caster has a spell penetration feature
    if (GetHasFeat(FEAT_SPELL_PENETRATION, oOriginCaster))
    {
        iCasterLevel += 2;
        if (GetHasFeat(FEAT_EPIC_SPELL_PENETRATION, oOriginCaster))
            iCasterLevel += 4;
        else if (GetHasFeat(FEAT_GREATER_SPELL_PENETRATION, oOriginCaster))
            iCasterLevel += 2;
    }

    // Get the spell resistance of the target
    int iSpellResistance = GetSpellResistance(oTarget);

    // Test if the caster bypasses the target's spell resistance
    int iCLCheck = iCasterLevel + d20();
    SetLocalInt(oTarget, JX_SPELL_RESIST_ROLL, iCLCheck);
    SetLocalInt(oTarget, JX_SPELL_RESIST_DC, iSpellResistance);
    if (iCLCheck < iSpellResistance)
        return SPELL_RESIST_PASS;
    else
        return SPELL_RESIST_FAIL;
}

// The caster makes a caster level check against the specified DC.
// - oCaster Creature that makes the caster level check
// - iDC Difficulty class of the check
// * Returns TRUE if the caster succeeds the check
int JXCasterLevelCheck(object oCaster, int iDC)
{
    // Sanity checks to prevent wrapping around
    if (iDC < 1) iDC = 1;
    else if (iDC > 255) iDC = 255;

    // Get the caster level of the creature
    int iCasterLevel = JXGetCasterLevel(oCaster);

    // Make the saving throw check
    int bValid = FALSE;
    int iRoll = d20();
    if ((iRoll + iCasterLevel) >= iDC)
        bValid = TRUE;

    // -------------------------------------------------------------------------
    // Print the result of the caster level check to the PC
    // -------------------------------------------------------------------------

    // Caster level label : Tlk installed
    string sMsgCasterLevel = GetStringByStrRef(17079397);
    // Caster level label : No Tlk installed
    if (sMsgCasterLevel == "") sMsgCasterLevel = GetStringByStrRef(302181);

    // Check result (success/failure)
    string sMsgCheckResult;
    if (bValid)
        sMsgCheckResult = GetStringByStrRef(5352);
    else
        sMsgCheckResult = GetStringByStrRef(5353);

    // Build the saving throw message
    string sMessage = GetStringByStrRef(10473);
    sMessage = JXStringReplaceToken(sMessage, 0, "<color=plum>" + GetFirstName(oCaster));
    sMessage = JXStringReplaceToken(sMessage, 1, " " + GetLastName(oCaster) + "</color>");
    sMessage = JXStringReplaceToken(sMessage, 2, "<color=skyblue>" + sMsgCasterLevel);
    sMessage = JXStringReplaceToken(sMessage, 3, "");
    sMessage = JXStringReplaceToken(sMessage, 4, sMsgCheckResult);
    sMessage = JXStringReplaceToken(sMessage, 5, IntToString(iRoll));
    sMessage = JXStringReplaceToken(sMessage, 6, "+");
    sMessage = JXStringReplaceToken(sMessage, 7, IntToString(iCasterLevel));
    sMessage = JXStringReplaceToken(sMessage, 8, IntToString(iRoll + iCasterLevel));
    sMessage = JXStringReplaceToken(sMessage, 9, IntToString(iDC));
    sMessage += "</color>";

    // Display the caster level check to the PC
    SendMessageToPC(oCaster, sMessage);

    return bValid;
}

// Get the creature associated with the placeable used to cast the spell
// - oPlaceable Placeable that casts a spell
// * Returns the creature associated with the placeable if it exists
object JXGetCaster(object oPlaceable)
{
    object oCaster = oPlaceable;
    if (GetObjectType(oPlaceable) == OBJECT_TYPE_PLACEABLE)
    {
        // Shaz: NOTE! Because this is a "inner-ly" defined oCaster, it doesn't change
        //  the outer one which is returned. This means this function will never return
        //  anything but the "oPlaceable" that is passed in. I left this because if you
        //  make this function actually return the correct JX_REAL_CREATOR, you end up
        //  causing all spells to be treated as being cast from the JX_REAL_CREATOR.
        //  this is caused by the "AssignCommand(JXGetCaster(), mainSpell());" at the
        //  top of every single spell in the game.
        object oCaster = GetLocalObject(oPlaceable, JX_REAL_CREATOR);
        if (GetIsObjectValid(oCaster))
            // Set the spell target location (as it's lost if the context changes)
            SetLocalLocation(oCaster, "JX_SPELL_TARGET_LOCATION", GetSpellTargetLocation());
    }
    return oCaster;
}

// Set the identifier of the spell being cast
// - iSpellId Spell identifier
// - oCaster Creature that is casting a spell
void JXSetSpellId(int iSpellId, object oCaster)
{
    SetLocalString(oCaster, JX_SPELL_ID, IntToString(iSpellId));
}

// Get the identifier of the spell being cast
// - oCaster Creature that is casting a spell
// * Returns the identifier of the spell
int JXGetSpellId(object oCaster)
{
    int iSpellId = GetSpellId();
    string sSpellId = GetLocalString(oCaster, JX_SPELL_ID);
    if (sSpellId != "")
        iSpellId = StringToInt(sSpellId);
    return iSpellId;
}

// Set the target location of a spell being cast
// - lTarget Spell target location
// - oCaster Creature that is casting a spell
void JXSetSpellTargetLocation(location lTarget, object oCaster)
{
    SetLocalLocation(oCaster, JX_SPELL_TARGET_LOCATION, lTarget);
}

// Get the target location of a spell being cast
// - oCaster Creature that is casting a spell
// * Returns the spell target location
location JXGetSpellTargetLocation(object oCaster)
{
    object oTarget = JXGetSpellTargetObject(oCaster);
    if (GetIsObjectValid(oTarget))
        return GetLocation(oTarget);

    location lTarget = GetLocalLocation(oCaster, JX_SPELL_TARGET_LOCATION);
    vector vTarget = GetPositionFromLocation(lTarget);
    if ((vTarget.x == 0.0)
     || (vTarget.y == 0.0)
     || (vTarget.z == 0.0))
        lTarget = GetSpellTargetLocation();
    return lTarget;
}

// Set the target object of a spell being cast
// - oTarget Spell target object
// - oCaster Creature that is casting a spell
void JXSetSpellTargetObject(object oTarget, object oCaster)
{
    SetLocalObject(oCaster, JX_SPELL_TARGET_OBJECT, oTarget);
}

// Get the target object of a spell being cast
// - oCaster Creature that is casting a spell
// * Returns the spell target object
object JXGetSpellTargetObject(object oCaster)
{
    object oTarget = GetLocalObject(oCaster, JX_SPELL_TARGET_OBJECT);
    if (!GetIsObjectValid(oTarget))
        oTarget = GetSpellTargetObject();
    return oTarget;
}

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

//========================================== Spell Effects ==========================================//

// Private function - used by JXApplyEffectToObject()
void JXPrivateSaveSpellInfosOnCreature(object oCaster, object oTarget, int iSpellId)
{
    // Get information about the associated spell
    int iCasterLevel = JXGetCasterLevel();
    int iMetaMagic = JXGetMetaMagicFeat();
    int iSpellSaveDC = JXGetSpellSaveDC();
    string sNewSpell = IntToString(iSpellId) + "," +            // Spell id
                       IntToString(iCasterLevel) + "," +        // Caster level
                       IntToString(iMetaMagic) + "," +          // Metamagic
                       IntToString(iSpellSaveDC) + ",";             // Spell save DC
    if (GetIsObjectValid(oCaster))
        sNewSpell += IntToString(ObjectToInt(oCaster));             // Spell creator

    string sResult = "";
    int bAlreadyReplaced = FALSE;
    int iSpellIdTemp;

    // Get the spells' informations previously saved
    string sSavedSpells = GetLocalString(oTarget, JX_CAST_SPELLS_INFO);
    int iNbSpells = JXStringSplitCount(sSavedSpells, ";");
    string sSavedSpell;
    int iLoop;
    for (iLoop = 0; iLoop < iNbSpells; iLoop++)
    {
        // Get informations about one of the saved spells
        sSavedSpell = JXStringSplit(sSavedSpells, ";", iLoop);
        // Get the spell identifier that was saved
        iSpellIdTemp = StringToInt(JXStringSplit(sSavedSpell, ",", 0));

        // The saved informations about an old spell are still valid, or
        // have just been replaced by the informations of the current spell
        if (GetHasSpellEffect(iSpellIdTemp, oTarget))
        {
            // The new informations about the current spell replace the old ones
            if (iSpellId == iSpellIdTemp)
            {
                if (sResult != "") sResult += ";";
                sResult += sNewSpell;
                bAlreadyReplaced = TRUE;
            }
            // The old informations are still valid
            else
            {
                if (sResult != "") sResult += ";";
                sResult += sSavedSpell;
            }
        }
    }

    // Save the informations about the current spell
    if (!bAlreadyReplaced)
    {
        if (sResult != "") sResult += ";";
        sResult += sNewSpell;
    }

    // Update the spells' informations
    if (sResult != sSavedSpells)
        SetLocalString(oTarget, JX_CAST_SPELLS_INFO, sResult);
}

// Apply an effect to the specified location and save spell informations
// - iDuration DURATION_TYPE_* constant
// - eEffect Effect to apply at the location
// - lLocation Location to apply the effect at
// - fDuration Duration of the spell if iDuration is DURATION_TYPE_TEMPORARY
void JXApplyEffectAtLocation(int iDuration, effect eEffect, location lLocation, float fDuration=0.0f)
{
    // Shazbotian: this used to just set the effects SID to JXGetSpellId, but I discovered that for most AOE effects,
    //  GetSpellId would return -1, while the effects already had the proper SID in them, so this fixes the bug where their SID's were being wipped out
    int iSpellId = JXGetSpellId();
    if(iSpellId >= 0) {
        eEffect = SetEffectSpellId(eEffect, iSpellId);
    }
    ApplyEffectAtLocation(iDuration, eEffect, lLocation, fDuration);
}

// Apply an effect to the specified object and save spell informations
// - iDuration DURATION_TYPE_* constant
// - eEffect Effect to apply to the object
// - oTarget Object to apply the effect to
// - fDuration Duration of the spell if iDuration is DURATION_TYPE_TEMPORARY
// - iEffectType JX_EFFECT_TYPE_* of the passed effect
void JXApplyEffectToObject(int iDuration, effect eEffect, object oTarget, float fDuration=0.0f, int iEffectType=-1)
{
    object oCaster = JXGetCaster();
    int iSpellId = JXGetSpellId();

    // try to guess the effect type
    if (iEffectType == -1)
    {
        iEffectType = GetEffectType(eEffect);
    }

    // Information about instant effect spells aren't saved
    if (iDuration != DURATION_TYPE_INSTANT)
    {
        // Applying an effect from within an area of effect
        if (GetObjectType(oCaster) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            oCaster = GetLocalObject(GetAreaOfEffectCreator(), JX_AOE_REAL_CREATOR);
            iSpellId = GetEffectSpellId(eEffect);
        }
        // Get the real spellcaster if the current caster is a placeable
        if (GetObjectType(oCaster) == OBJECT_TYPE_PLACEABLE)
        {
            object oSpellCreator = GetLocalObject(oCaster, JX_REAL_CREATOR);
            if (GetIsObjectValid(oSpellCreator)) oCaster = oSpellCreator;
        }

        if (iSpellId != -1) JXPrivateSaveSpellInfosOnCreature(oCaster, oTarget, iSpellId);
    }

    // tag the effect
    eEffect = SetEffectSpellId(eEffect, iSpellId);

    int iContinue = TRUE;
    if (iContinue)
    {
        ApplyEffectToObject(iDuration, eEffect, oTarget, fDuration);
    }
}

// Private function - used by JXApplyAreaEffectAtLocation
void JXPrivateCreateCasterToApplyAOEAtLocation(int nAreaEffectId,
                                               location lTarget,
                                               float nDuration,
                                               int nSpellId,
                                               string sOnEnterScript,
                                               string sOnHeartbeatScript,
                                               string sOnExitScript,
                                               string sEffectTag,
                                               int iEffectSubType)
{
    effect eAOE = EffectAreaOfEffect(nAreaEffectId, sOnEnterScript, sOnHeartbeatScript, sOnExitScript, sEffectTag);
    if (iEffectSubType == SUBTYPE_EXTRAORDINARY)
        eAOE = ExtraordinaryEffect(eAOE);
    if (iEffectSubType == SUBTYPE_SUPERNATURAL)
        eAOE = SupernaturalEffect(eAOE);

    if (nDuration == 0.0f)
        JXApplyEffectAtLocation(DURATION_TYPE_PERMANENT, SetEffectSpellId(eAOE, nSpellId), lTarget);
    else
    {
        object oAOECaster = OBJECT_SELF;
        JXApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, SetEffectSpellId(eAOE, nSpellId), lTarget, nDuration);
        DestroyObject(oAOECaster, nDuration + 1.0f);
    }
}

// Create an area of effect for the current spell.
// Areas of effect created by this way have the following properties :
//   * continue to work after the death of the caster
//   * Make use of overridden spell properties (caster level, DC, metamagic)
//   * Can be cast by a placeable
// - nAreaEffectId Area of effect identifier (AOE_*)
// - ltarget Target of the spell
// - nDuration Duration of the spell, permanent if this value is 0
// - sOnEnterScript Overriden OnEnter script for the AoE
// - sOnHeartbeatScript Overriden OnHeartbeat script for the AoE
// - sOnExitScript Overriden OnExit script for the AoE
// - sEffectTag Tag for the AoE object
// - iEffectSubType SUBTYPE_* constant for the effect
void JXApplyAreaEffectAtLocation(int nAreaEffectId,
                                 location lTarget,
                                 float nDuration = 0.0f,
                                 string sOnEnterScript = "",
                                 string sOnHeartbeatScript = "",
                                 string sOnExitScript = "",
                                 string sEffectTag = "",
                                 int iEffectSubType = SUBTYPE_MAGICAL)
{
    object oCaster = OBJECT_SELF;

    // Find a location to place the AOE creator
    object oWPAOECreator = GetWaypointByTag(JX_AOE_CASTER_TMP_LOCATION);
    location lAOECreator;
    // Erf imported : the location is specified
    if (GetIsObjectValid(oWPAOECreator))
        lAOECreator = GetLocation(GetWaypointByTag(JX_AOE_CASTER_TMP_LOCATION));
    // No Erf imported : the location is the module's starting location
    else
        lAOECreator = GetStartingLocation();
    // Define the AOE creator
    object oAOECreator = CreateObject(OBJECT_TYPE_CREATURE,
                                      JX_AOE_CASTER_TAG,
                                      lAOECreator,
                                      FALSE,
                                      JX_AOE_CASTER_TAG);
    SetScriptHidden(oAOECreator, TRUE);

    // Shaz: added this to solve the problem of a "placeable" spellcaster not being resistable
    if (GetTag(oCaster) == "jx_ipoint_caster")
    {
        object oRealCaster = GetLocalObject(oCaster, JX_REAL_CREATOR);
        if(GetIsObjectValid(oRealCaster))
        {
            oCaster = oRealCaster;

        }
    }

    // Define the spell power
    SetLocalObject(oAOECreator, JX_AOE_REAL_CREATOR, oCaster);
    JXSetCasterLevel(JXGetCasterLevel(oCaster), oAOECreator);
    JXSetSpellSaveDC(JXGetSpellSaveDC(oCaster), oAOECreator);
    JXSetMetaMagicFeat(JXGetMetaMagicFeat(oCaster), oAOECreator);

    int iSpellId = GetSpellId();

    // Make the temporary creature create the AOE effect
    AssignCommand(oAOECreator,
        JXPrivateCreateCasterToApplyAOEAtLocation(nAreaEffectId,
                                                  lTarget,
                                                  nDuration,
                                                  iSpellId,
                                                  sOnEnterScript,
                                                  sOnHeartbeatScript,
                                                  sOnExitScript,
                                                  sEffectTag,
                                                  iEffectSubType)
    );
}

// Private function - used by JXApplyAreaEffectAtLocation
void JXPrivateCreateCasterToApplyAOEToObject(int nAreaEffectId,
                                             object oTarget,
                                             float nDuration,
                                             int nSpellId,
                                             string sOnEnterScript,
                                             string sOnHeartbeatScript,
                                             string sOnExitScript,
                                             string sEffectTag,
                                             int iEffectSubType,
                                             object oOriginalCaster)
{

    effect eAOE = EffectAreaOfEffect(nAreaEffectId, sOnEnterScript, sOnHeartbeatScript, sOnExitScript, sEffectTag);

    // Icon for Detect Magic and Analyze Dweomer
    if (nSpellId == JX_SPELL_DETECTMAGIC)
        eAOE = EffectLinkEffects(EffectEffectIcon(191), eAOE);
    if (nSpellId == JX_SPELL_ANALYZEDWEOMER)
        eAOE = EffectLinkEffects(EffectEffectIcon(192), eAOE);

    if (iEffectSubType == SUBTYPE_EXTRAORDINARY)
        eAOE = ExtraordinaryEffect(eAOE);
    if (iEffectSubType == SUBTYPE_SUPERNATURAL)
        eAOE = SupernaturalEffect(eAOE);

    // Save spell informations
    if (GetObjectType(oOriginalCaster) == OBJECT_TYPE_PLACEABLE)
    {
        object oSpellCreator = GetLocalObject(oOriginalCaster, JX_REAL_CREATOR);
        if (GetIsObjectValid(oSpellCreator))
            oOriginalCaster = oSpellCreator;
    }
    JXPrivateSaveSpellInfosOnCreature(oOriginalCaster, oTarget, nSpellId);

    // Apply area of effect
    if (nDuration == 0.0f)
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SetEffectSpellId(eAOE, nSpellId), oTarget);
    else
    {
        object oAOECaster = OBJECT_SELF;
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, SetEffectSpellId(eAOE, nSpellId), oTarget, nDuration);
        DestroyObject(oAOECaster, nDuration + 1.0f);
    }
}

// Create an area of effect for the current spell and apply it to the specified object.
// Areas of effect created by this way have the following properties :
//   * continue to work after the death of the caster
//   * Make use of overridden spell properties (caster level, DC, metamagic)
//   * Can be cast by a placeable
// - nAreaEffectId Area of effect identifier (AOE_*)
// - otarget Target of the spell
// - nDuration Duration of the spell, permanent if this value is 0
// - sOnEnterScript Overriden OnEnter script for the AoE
// - sOnHeartbeatScript Overriden OnHeartbeat script for the AoE
// - sOnExitScript Overriden OnExit script for the AoE
// - sEffectTag Tag for the AoE object
// - iEffectSubType SUBTYPE_* constant for the effect
void JXApplyAreaEffectToObject(int nAreaEffectId,
                               object oTarget,
                               float nDuration = 0.0f,
                               string sOnEnterScript = "",
                               string sOnHeartbeatScript = "",
                               string sOnExitScript = "",
                               string sEffectTag = "",
                               int iEffectSubType = SUBTYPE_MAGICAL)
{
    object oCaster = OBJECT_SELF;

    // Find a location to place the AOE creator
    object oWPAOECreator = GetWaypointByTag(JX_AOE_CASTER_TMP_LOCATION);
    location lAOECreator;
    // Erf imported : the location is specified
    if (GetIsObjectValid(oWPAOECreator))
        lAOECreator = GetLocation(GetWaypointByTag(JX_AOE_CASTER_TMP_LOCATION));
    // No Erf imported : the location is the module's starting location
    else
        lAOECreator = GetStartingLocation();
    // Define the AOE creator
    object oAOECreator = CreateObject(OBJECT_TYPE_CREATURE,
                                      JX_AOE_CASTER_TAG,
                                      lAOECreator,
                                      FALSE,
                                      JX_AOE_CASTER_TAG);
    SetScriptHidden(oAOECreator, TRUE);

    // Shaz: added this to solve the problem of a "placeable" spellcaster not being resistable
    if (GetTag(oCaster) == "jx_ipoint_caster")
    {
        object oRealCaster = GetLocalObject(oCaster, JX_REAL_CREATOR);
        if(GetIsObjectValid(oRealCaster))
        {
            oCaster = oRealCaster;

        }
    }

    // Define the spell power
    SetLocalObject(oAOECreator, JX_AOE_REAL_CREATOR, oCaster);
    JXSetCasterLevel(JXGetCasterLevel(oCaster), oAOECreator);
    JXSetSpellSaveDC(JXGetSpellSaveDC(oCaster), oAOECreator);
    JXSetMetaMagicFeat(JXGetMetaMagicFeat(oCaster), oAOECreator);

    int iSpellId = GetSpellId();

    // Make the temporary creature create the AOE effect
    AssignCommand(oAOECreator,
        JXPrivateCreateCasterToApplyAOEToObject(nAreaEffectId,
                                                oTarget,
                                                nDuration,
                                                iSpellId,
                                                sOnEnterScript,
                                                sOnHeartbeatScript,
                                                sOnExitScript,
                                                sEffectTag,
                                                iEffectSubType,
                                                oCaster)
    );
}

// Get the real creator of an area of effect.
// N.B. : A call to GetAreaOfEffectCreator() on an area of effect that has been
// created with JXApplyAreaEffectToXXX() would return an "Attach Spell Node" creature.
// - oAOE Area of effect
// * Returns the real creator of the spell, or an "Attach Spell Node" creature if
//   the real creator doesn't exist anymore
object JXGetAOERealCreator(object oAOE = OBJECT_SELF)
{
    object oSpellNode = GetAreaOfEffectCreator();
    object oAOECreator = GetLocalObject(oSpellNode, JX_AOE_REAL_CREATOR);

    if (GetIsObjectValid(oAOECreator))
        return oAOECreator;
    else
        return oSpellNode;
}

// Bioware/Obsidian function moved here for use with charmed and dominated effects
effect GetScaledEffect(effect eStandard, object oTarget)
{
    int nDiff = GetGameDifficulty();
    effect eNew = eStandard;
    object oMaster = GetMaster(oTarget);
    if(GetIsPC(oTarget) || (GetIsObjectValid(oMaster) && GetIsPC(oMaster)))
    {
        if(GetEffectType(eStandard) == EFFECT_TYPE_FRIGHTENED && nDiff == GAME_DIFFICULTY_VERY_EASY)
        {
            eNew = EffectAttackDecrease(-2);
            return eNew;
        }
        if(GetEffectType(eStandard) == EFFECT_TYPE_FRIGHTENED && nDiff == GAME_DIFFICULTY_EASY)
        {
            eNew = EffectAttackDecrease(-4);
            return eNew;
        }
        if(nDiff == GAME_DIFFICULTY_VERY_EASY &&
            (GetEffectType(eStandard) == EFFECT_TYPE_PARALYZE ||
             GetEffectType(eStandard) == EFFECT_TYPE_STUNNED ||
             GetEffectType(eStandard) == EFFECT_TYPE_CONFUSED))
        {
            eNew = EffectDazed();
            return eNew;
        }
        else if(GetEffectType(eStandard) == EFFECT_TYPE_CHARMED || GetEffectType(eStandard) == EFFECT_TYPE_DOMINATED)
        {
            eNew = EffectDazed();
            return eNew;
        }
    }
    return eNew;
}

// Private function - used by JXApplyCharmedEffectToObject
void JXPrivateApplyCharmedEffectSpellToObject(object oTarget, float nDuration, int nSpellId)
{
    effect eCharmed = EffectCharmed();
    eCharmed = GetScaledEffect(eCharmed, oTarget);
    if (nDuration == 0.0f)
        JXApplyEffectToObject(DURATION_TYPE_PERMANENT, SetEffectSpellId(eCharmed, nSpellId), oTarget);
    else
        JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, SetEffectSpellId(eCharmed, nSpellId), oTarget, nDuration);
}

// Private function - used by JXApplyDominatedEffectToObject
void JXPrivateApplyDominatedEffectSpellToObject(object oTarget, float nDuration, int nSpellId)
{
    effect eDominated = EffectDominated();
    eDominated = GetScaledEffect(eDominated, oTarget);
    if (nDuration == 0.0f)
        JXApplyEffectToObject(DURATION_TYPE_PERMANENT, SetEffectSpellId(eDominated, nSpellId), oTarget);
    else
        JXApplyEffectToObject(DURATION_TYPE_TEMPORARY, SetEffectSpellId(eDominated, nSpellId), oTarget, nDuration);
}

// Create a charmed effect that uses the nearest creature as the caster
// if the current one is a placeable
// - otarget Target of the spell
// - nDuration Duration of the spell, permanent if this value is 0
void JXApplyCharmedEffectToObject(object oTarget, float fDuration)
{
    int iSpellId = GetSpellId();

    object oSource = OBJECT_SELF;
    if (GetObjectType(oSource) == OBJECT_TYPE_PLACEABLE)
        oSource = GetNearestCreatureToLocation(CREATURE_TYPE_IS_ALIVE,
                                               CREATURE_ALIVE_BOTH,
                                               GetLocation(oSource));

    AssignCommand(oSource,
        JXPrivateApplyCharmedEffectSpellToObject(oTarget, fDuration, iSpellId)
    );
}

// Create a dominated effect that uses the nearest creature as the caster
// if the current one is a placeable
// - otarget Target of the spell
// - nDuration Duration of the spell, permanent if this value is 0
void JXApplyDominatedEffectToObject(object oTarget, float fDuration)
{
    int iSpellId = GetSpellId();

    object oSource = OBJECT_SELF;
    if (GetObjectType(oSource) == OBJECT_TYPE_PLACEABLE)
        oSource = GetNearestCreatureToLocation(CREATURE_TYPE_IS_ALIVE,
                                               CREATURE_ALIVE_BOTH,
                                               GetLocation(oSource));

    AssignCommand(oSource,
        JXPrivateApplyDominatedEffectSpellToObject(oTarget, fDuration, iSpellId)
    );
}



//========================================== Active Spells ==========================================//

// Get the list of active spells currently active on a creature
// - oTarget Creature to get the active spells from
// * Returns a list of spell identifiers in a string form (ex: 104;3;862)
string JXGetActiveSpells(object oTarget)
{
    string sActiveSpells = "";

    // Loop through all effects on the creature to detect active spells
    int iSpellId;
    effect eLoop = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eLoop))
    {
        iSpellId = GetEffectSpellId(eLoop);
        if ((iSpellId != -1)                                                // Spell active
         && (FindSubString(sActiveSpells, IntToString(iSpellId)) == -1))    // Not already detected
        {
            if (sActiveSpells != "") sActiveSpells += ";";
            sActiveSpells += IntToString(iSpellId);
        }
        eLoop = GetNextEffect(oTarget);
    }

    return sActiveSpells;
}

// Private function - used by JXGetSpellCasterLevel() and JXGetSpellCreator()
string JXPrivateGetSpellInfos(object oTarget, int iSpellId)
{
    int iSpellIdTemp;

    // Get the spells' informations previously saved
    string sSavedSpells = GetLocalString(oTarget, JX_CAST_SPELLS_INFO);
    int iNbSpells = JXStringSplitCount(sSavedSpells, ";");
    string sSpellInfos;
    int iLoop;
    for (iLoop = 0; iLoop < iNbSpells; iLoop++)
    {
        // Get informations about one of the saved spells
        sSpellInfos = JXStringSplit(sSavedSpells, ";", iLoop);
        // Get the spell identifier that was saved
        iSpellIdTemp = StringToInt(JXStringSplit(sSpellInfos, ",", 0));
        // Returns the spell informations when they are found
        if (iSpellIdTemp == iSpellId)
            return sSpellInfos;
    }

    return "";
}

// Get the caster level of a spell currently active on a creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: -1,
//   else the caster level of the spell specified
int JXGetSpellCasterLevel(object oTarget, int iSpellId)
{
    // Check that the target is valid
    if (!GetIsObjectValid(oTarget))
        return -1;

    string sSpellInfos = JXPrivateGetSpellInfos(oTarget, iSpellId);
    if (sSpellInfos == "")
        return 0;
    else
        return StringToInt(JXStringSplit(sSpellInfos, ",", 1));
}

// Get the metamagic feats of a spell currently active on a creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: -1,
//   else a combination of METAMAGIC_* constants
int JXGetSpellMetaMagicFeat(object oTarget, int iSpellId)
{
    // Check that the target is valid
    if (!GetIsObjectValid(oTarget))
        return -1;

    string sSpellInfos = JXPrivateGetSpellInfos(oTarget, iSpellId);
    if (sSpellInfos == "")
        return 0;
    else
        return StringToInt(JXStringSplit(sSpellInfos, ",", 2));
}

// Get the save DC of a spell currently active on a creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: -1,
//   else the save DC of the spell specified
int JXGetSpellSpellSaveDC(object oTarget, int iSpellId)
{
    // Check that the target is valid
    if (!GetIsObjectValid(oTarget))
        return -1;

    string sSpellInfos = JXPrivateGetSpellInfos(oTarget, iSpellId);
    if (sSpellInfos == "")
        return 0;
    else
        return StringToInt(JXStringSplit(sSpellInfos, ",", 3));
}

// Get the creature that created a spell currently active on another creature
// - oTarget Creature with an active spell
// - iSpellId SPELL_* constant
// * Return value if the target is not a valid object: OBJECT_INVALID,
//   else the creator of the spell specified
object JXGetSpellCreator(object oTarget, int iSpellId)
{
    // Check that the target is valid
    if (!GetIsObjectValid(oTarget))
        return OBJECT_INVALID;

    string sSpellInfos = JXPrivateGetSpellInfos(oTarget, iSpellId);
    if (sSpellInfos == "")
        return OBJECT_INVALID;
    else
    {
        string sSpellCreator = JXStringSplit(sSpellInfos, ",", 4);
        if (sSpellCreator == "")
            return OBJECT_INVALID;
        else
            return IntToObject(StringToInt(sSpellCreator));
    }
}



//========================================== Magical Aura ==========================================//

// Get the strength of a magical aura
// - oSource Source creature or item for a potential aura
// - bHiddenItemProps To also get hidden item magical properties
// * Returns a JX_AURASTRENGTH_* constant
struct jx_magic_aura JXGetMagicalAura(object oSource, int bHiddenItemProps = FALSE)
{
    struct jx_magic_aura aura;
    int iAuraStrength = JX_AURASTRENGTH_NONE;
    int iSpellSchool = SPELL_SCHOOL_GENERAL;

    int iObjectType = GetObjectType(oSource);

    // Get the magical aura from an item
    if (iObjectType == OBJECT_TYPE_ITEM)
    {
        // Get the item caster level
        string sItemProperties = "";
        if (bHiddenItemProps)
            sItemProperties = JXGetHiddenItemProperties(oSource);
        int iItemCasterLevel = JXGetItemCasterLevel(oSource, sItemProperties);

        // Get the item aura strength
        if (iItemCasterLevel == 0)  iAuraStrength = JX_AURASTRENGTH_NONE;
        else if (iItemCasterLevel < 6)  iAuraStrength = JX_AURASTRENGTH_FAINT;
        else if (iItemCasterLevel < 12)     iAuraStrength = JX_AURASTRENGTH_MODERATE;
        else if (iItemCasterLevel < 21)     iAuraStrength = JX_AURASTRENGTH_STRONG;
        else iAuraStrength = JX_AURASTRENGTH_OVERWHELMING;

        // Get the item spell school
        iSpellSchool = JXGetItemSpellSchool(oSource, sItemProperties);
    }

    // Get the magical aura from a creature
    if (iObjectType == OBJECT_TYPE_CREATURE)
    {
        int iBestSpellLevel = -1;

        // Look for the best spell effect on the creature
        int iSpellIdTemp;
        int iSpellLevelTemp;
        effect eSpellTemp = GetFirstEffect(oSource);
        while (GetIsEffectValid(eSpellTemp))
        {
            iSpellIdTemp = GetEffectSpellId(eSpellTemp);
            if (iSpellIdTemp > -1)
            {
                iSpellLevelTemp = GetSpellLevel(iSpellIdTemp);
                if (iSpellLevelTemp > iBestSpellLevel)
                    iBestSpellLevel = iSpellLevelTemp;
            }
            eSpellTemp = GetNextEffect(oSource);
        }
        if (iBestSpellLevel == -1)  iAuraStrength = JX_AURASTRENGTH_NONE;
        else if (iBestSpellLevel < 4)   iAuraStrength = JX_AURASTRENGTH_FAINT;
        else if (iBestSpellLevel < 7)   iAuraStrength = JX_AURASTRENGTH_MODERATE;
        else if (iBestSpellLevel < 10)  iAuraStrength = JX_AURASTRENGTH_STRONG;
        else iAuraStrength = JX_AURASTRENGTH_OVERWHELMING;
    }

    aura.strength = iAuraStrength;
    aura.school = iSpellSchool;

    return aura;
}

// Get the associated name of magical aura strength
// - iAuraStrength JX_AURASTRENGTH_* constant
// * Returns the name of the magical aura strength
string JXGetMagicalAuraStrengthName(int iAuraStrength)
{
    string sAuraStrengthName = "";

    // Tlk installed
    switch (iAuraStrength)
    {
        case JX_AURASTRENGTH_FAINT:             sAuraStrengthName = GetStringByStrRef(17079398);
        case JX_AURASTRENGTH_MODERATE:      sAuraStrengthName = GetStringByStrRef(17079399);
        case JX_AURASTRENGTH_STRONG:        sAuraStrengthName = GetStringByStrRef(17079400);
        case JX_AURASTRENGTH_OVERWHELMING:  sAuraStrengthName = GetStringByStrRef(17079401);
    }

    // No Tlk installed
    if (sAuraStrengthName == "")
    {
        switch (iAuraStrength)
        {
            case JX_AURASTRENGTH_FAINT:             sAuraStrengthName = GetStringByStrRef(302182);
            case JX_AURASTRENGTH_MODERATE:      sAuraStrengthName = GetStringByStrRef(302183);
            case JX_AURASTRENGTH_STRONG:        sAuraStrengthName = GetStringByStrRef(302184);
            case JX_AURASTRENGTH_OVERWHELMING:  sAuraStrengthName = GetStringByStrRef(302185);
        }
    }

    return sAuraStrengthName;
}



//========================================== Post-cast spell hook ==========================================//

// Private function - used by JXPostSpellCastCode
int JXPrivateRunUserDefinedPostSpellScript()
{
    string sScript = GetLocalString(GetModule(), MODULE_VAR_JX_USER_POSTCAST);
    if (sScript != "")
    {
        ExecuteScript(sScript,OBJECT_SELF);

        int nRet = GetLocalInt(OBJECT_SELF, "JX_BLOCK_LAST_SPELL_POST");
        DeleteLocalInt(OBJECT_SELF, "JX_BLOCK_LAST_SPELL_POST");
        if (nRet == TRUE)
        return FALSE;
    }
    return TRUE;
}

// Reinitialize all Spellcasting Framework variables and
// call the post spellscript defined by the user
void JXPostSpellCastCode()
{
    int nContinue = TRUE;

    //-----------------------------------------------------------------------
    // run any user defined post spellscript here
    //-----------------------------------------------------------------------
    nContinue = JXPrivateRunUserDefinedPostSpellScript();

    object oCaster = OBJECT_SELF;
    // Delete the ignore dead zone indicator
    DeleteLocalInt(oCaster, JX_IGNORE_DEADMAGICZONE);
    // Delete custom metamagic variables from the caster
    DeleteLocalInt(oCaster, JX_METAMAGIC_BYPASS_STD);
    DeleteLocalInt(oCaster, JX_METAMAGIC);
    // Delete the value of the custom save DC
    DeleteLocalInt(oCaster, JX_SPELL_DC_OVERRIDE);
    // Delete the value of the custom caster level
    DeleteLocalInt(oCaster, JX_CASTER_LEVEL_OVERRIDE);
    // Delete the value of the spell identifier
    DeleteLocalString(oCaster, JX_SPELL_ID);
    // Delete the values of the spell targets
    DeleteLocalObject(oCaster, JX_SPELL_TARGET_OBJECT);
    DeleteLocalLocation(oCaster, JX_SPELL_TARGET_LOCATION);
}


//========================================== On Apply Spell Effect Hook ==========================================//
// TODO: actually make this work
int JXOnApplySpellEffectCode(object oCaster, object oTarget, effect eEffect)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterObject(paramList, oCaster);
    paramList = JXScriptAddParameterObject(paramList, oTarget);
    paramList = JXScriptAddParameterInt(paramList, GetEffectType(eEffect));
    JXScriptCallFork(JX_EFFECT_FORKSCRIPT, JX_FORK_EFFECT_ON_APPLY_CODE, paramList);

   return JXScriptGetResponseInt();
}

// use this function to set the result of on_apply_spell_effect script
void JXSetOnApplySpellEffectResult(int iValue, object oTarget=OBJECT_SELF)
{
    SetLocalInt(oTarget, VAR_JX_ON_APPLY_SPELL_EFFECT_RESULT, iValue);
}
