#include "jx_class_info_interface"

//========================================== Caster Class Search ==========================================//

// Get the main caster class, depending on the spell type
// - oCreature Creature from which to get the main caster class
// - iSpellType JX_SPELLTYPE_* constant
// * Returns a CLASS_TYPE_* constant, or -1 if not found
int JXGetMainCasterClass(object oCreature = OBJECT_SELF, int iSpellType = JX_SPELLTYPE_BOTH);

// Get the creature's class that is associated with the specified spell
// - iSpellId SPELL_* constant
// - oCreature Creature on which the class search is performed
// * Returns a CLASS_TYPE_* constant, or -1 if it is not found
int JXGetClassForSpell(int iSpellId, object oCreature = OBJECT_SELF);

//========================================== Class-related Caster Level ==========================================//

// Get the arcane caster level for a creature based on one of her class
// - oCreature Creature from which to get the arcane caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main arcane class)
// * Returns the creature's arcane caster level
int JXGetCreatureArcaneCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

// Get the divine caster level for a creature based on one of her class
// - oCreature Creature from which to get the divine caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main divine class)
// * Returns the creature's divine caster level
int JXGetCreatureDivineCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

// Get the caster level for a creature based on one of her class
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

// Get the caster level for a creature depending on a spell
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevelForSpell(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

// Get the save DC for the specified spell cast by a creature
// - iSpellId SPELL_* constant
// - oCreature Creature from which to get the spell save DC
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the best caster class able to cast the spell)
// * Returns the creature's spell save DC
int JXGetCreatureSpellSaveDC(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

int JXGetIsMainArcaneClass(int iClass);

int JXGetIsMainDivineClass(int iClass);

int JXGetComputedCLFromClass(int iClass, int iClassLevel);

int JXGetImprovedArcaneCLFromClasses(object oCreature, int iClass);

int JXGetImprovedDivineCLFromClasses(object oCreature, int iClass);

int JXGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels);


//========================================== Caster Class Search ==========================================//

// Get the main caster class, depending on the spell type
// - oCreature Creature from which to get the main caster class
// - iSpellType JX_SPELLTYPE_* constant
// * Returns a CLASS_TYPE_* constant, or -1 if not found
int JXGetMainCasterClass(object oCreature = OBJECT_SELF, int iSpellType = JX_SPELLTYPE_BOTH)
{
    return JXImplGetMainCasterClass(oCreature, iSpellType);
}


int JXGetClassForSpell(int iSpellId, object oCreature = OBJECT_SELF)
{
    return JXImplGetClassForSpell(iSpellId, oCreature);
}


//========================================== Class-related Caster Level ==========================================//

// Get the arcane caster level for a creature based on one of her class
// - oCreature Creature from which to get the arcane caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main arcane class)
// * Returns the creature's arcane caster level
int JXGetCreatureArcaneCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    return JXImplGetCreatureArcaneCasterLevel(oCreature, iClass);
}

// Get the divine caster level for a creature based on one of her class
// - oCreature Creature from which to get the divine caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main divine class)
// * Returns the creature's divine caster level
int JXGetCreatureDivineCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    return JXImplGetCreatureDivineCasterLevel(oCreature, iClass);
}

// Get the caster level for a creature based on one of her class
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    return JXImplGetCreatureCasterLevel(oCreature, iClass);
}

// Get the caster level for a creature depending on a spell
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevelForSpell(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    return JXImplGetCreatureCasterLevelForSpell(iSpellId, oCreature, iClass);
}


//========================================== Class-related Spell Save DC ==========================================//

// Get the save DC for the specified spell cast by a creature
// - iSpellId SPELL_* constant
// - oCreature Creature from which to get the spell save DC
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the best caster class able to cast the spell)
// * Returns the creature's spell save DC
int JXGetCreatureSpellSaveDC(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    return JXImplGetCreatureSpellSaveDC(iSpellId, oCreature, iClass);
}


int JXGetIsMainArcaneClass(int iClass)
{
    return JXImplGetIsMainArcaneClass(iClass);
}

int JXGetIsMainDivineClass(int iClass)
{
    return JXImplGetIsMainDivineClass(iClass);
}

int JXGetComputedCLFromClass(int iClass, int iClassLevel)
{
    return JXImplGetComputedCLFromClass(iClass, iClassLevel);
}

int JXGetImprovedArcaneCLFromClasses(object oCreature, int iClass)
{
    return JXImplGetImprovedArcaneCLFromClasses(oCreature, iClass);
}

int JXGetImprovedDivineCLFromClasses(object oCreature, int iClass)
{
    return JXImplGetImprovedDivineCLFromClasses(oCreature, iClass);
}

int JXGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels)
{
    return JXImplGetCLBonusFromPractisedSpellcaster(oCaster, iCastingClass, iCastingLevels);
}
