/*#########################################################
Treat functions in this file as lists of spells with certain properties.
As the implementation of those functions depends on the content independent
of the framework (spells, classes, feats etc), it is the responsibility of
custom content creators to implement following functions in order for their content
to work with framework features


The implementation should be in "jx_spell_info_interface_impl.nss". It is recommended
to base your implementation on example implementation in imp/pr_ov directory
*///#######################################################

#include "jx_inc_magic_const"

// include the implementation of the interface
#include "jx_spell_info_interface_impl"

// Indicate if a spell is using a ranged touch attack
// - iSpellId Identifier of the spell
// * Returns TRUE if the spell uses a ranged touch attack
int JXImplGetIsSpellUsingRangedTouchAttack(int iSpellId);

// Indicate if a spell is a spell or a spell-like ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a spell or a spell-like ability
int JXImplGetIsSpellMagical(int iSpellId);

// Indicate if a spell is a supernatural ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a supernatural ability
int JXImplGetIsSpellSupernatural(int iSpellId);

// Indicate if a spell is an extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is an extraordinary ability
int JXImplGetIsSpellExtraordinary(int iSpellId);

// Indicate if a spell isn't a spell, spell-like, supernatural or extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell isn't a spell, spell-like, supernatural or extraordinary ability
int JXImplGetIsSpellMiscellaneous(int iSpellId);

// Indicate if a spell has the specified descriptor
// - iSpellId SPELL_* constant
// - iDescriptor JX_SPELLDESCRIPTOR_* constant
// * Returns TRUE if the spell has the specified spell descriptor
int JXImplGetHasSpellDescriptor(int iSpellId, int iDescriptor = JX_SPELLDESCRIPTOR_ANY);

// Get the spell subschool of a spell
// - iSpellId SPELL_* constant
// * Returns a JX_SPELLSUBSCHOOL_* constant
int JXImplGetSpellSubSchool(int iSpellId);


// Get the creature's class that is associated with the specified spell
// - iSpellId SPELL_* constant
// - oCreature Creature on which the class search is performed
// * Returns a CLASS_TYPE_* constant, or -1 if it is not found
int JXImplGetClassForSpell(int iSpellId, object oCreature = OBJECT_SELF);

// Get the level of a spell, innate or depending on a caster class
// - iClass Class that is able to cast the spell (CLASS_TYPE_INVALID for innate)
// * Returns the spell level, or -1 if the spell is not accessible to the class
int JXImplGetBaseSpellLevel(int iSpellId, int iClass = CLASS_TYPE_INVALID)

// Private function - Get the save DC bonus for the specified spell
//int JXPrivateGetSpellDCBonusFromSpell(int iSpellId, object oCreature)
int JXImplGetSpellDCBonusFromSpell(int iSpellId, object oCreature)
