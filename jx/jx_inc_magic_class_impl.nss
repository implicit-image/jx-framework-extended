#include "jx_inc_magic_class"
#include "jx_class_info_interface"


// Get the main caster class, depending on the spell type
// - oCreature Creature from which to get the main caster class
// - iSpellType JX_SPELLTYPE_* constant
// * Returns a CLASS_TYPE_* constant, or -1 if not found
int JXImplGetMainCasterClass(object oCreature = OBJECT_SELF, int iSpellType = JX_SPELLTYPE_BOTH)
{
    int iBestClass = CLASS_TYPE_INVALID;
    int iBestCasterLevel = -1;

    int iClass, iClassLevel;
    int iCasterLevel;
    int iLoop;
    for (iLoop = 1; iLoop <= 4; iLoop++)
    {
        // Get the current class and its level
        iClass = GetClassByPosition(iLoop, oCreature);
        iClassLevel = GetLevelByPosition(iLoop, oCreature);

        // Case Arcane class
        if (((iSpellType == JX_SPELLTYPE_ARCANE) || (iSpellType == JX_SPELLTYPE_BOTH))
         && (JXImplGetIsMainArcaneClass(iClass)))
        {
            iCasterLevel = JXImplGetComputedCLFromClass(iClass, iClassLevel);
            if ((iCasterLevel > iBestCasterLevel) || (iBestCasterLevel == CLASS_TYPE_INVALID))
            {
                iBestClass = iClass;
                iBestCasterLevel = iCasterLevel;
            }
        }

        // Case Divine class
        if (((iSpellType == JX_SPELLTYPE_DIVINE) || (iSpellType == JX_SPELLTYPE_BOTH))
         && (JXImplGetIsMainDivineClass(iClass)))
        {
            iCasterLevel = JXImplGetComputedCLFromClass(iClass, iClassLevel);
            if ((iCasterLevel > iBestCasterLevel) || (iBestCasterLevel == CLASS_TYPE_INVALID))
            {
                iBestClass = iClass;
                iBestCasterLevel = iCasterLevel;
            }
        }
    }

    return iBestClass;
}

// Get the arcane caster level for a creature based on one of her class
// - oCreature Creature from which to get the arcane caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main arcane class)
// * Returns the creature's arcane caster level
int JXImplGetCreatureArcaneCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // Get the main arcane caster class
    int iMainClass = JXGetMainCasterClass(oCreature, JX_SPELLTYPE_ARCANE);
    if (iMainClass == CLASS_TYPE_INVALID) return 0;
    if (iClass == CLASS_TYPE_INVALID)
        iClass = iMainClass;

    // Test if the specified class is an arcane class
    if (!JXImplGetIsMainArcaneClass(iClass))
        return 0;

    // Compute the arcane caster level for the main caster class
    int iCasterLevel = JXImplGetComputedCLFromClass(iClass, GetLevelByClass(iClass, oCreature));
    // Add the arcane caster level from other classes
    if (iClass == iMainClass)
        iCasterLevel += JXImplGetImprovedArcaneCLFromClasses(oCreature, iClass);
    // Add the caster level due to the Practised Spellcaster feature
    iCasterLevel += JXImplGetCLBonusFromPractisedSpellcaster(oCreature, iClass, iCasterLevel);

    return iCasterLevel;
}

// Get the divine caster level for a creature based on one of her class
// - oCreature Creature from which to get the divine caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main divine class)
// * Returns the creature's divine caster level
int JXImplGetCreatureDivineCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // Get the main divine caster class
    int iMainClass = JXGetMainCasterClass(oCreature, JX_SPELLTYPE_DIVINE);
    if (iMainClass == CLASS_TYPE_INVALID) return 0;
    if (iClass == CLASS_TYPE_INVALID)
        iClass = iMainClass;

    // Test if the specified class is a divine class
    if (!JXImplGetIsMainDivineClass(iClass))
        return 0;

    // Compute the divine caster level for the main caster class
    int iCasterLevel = JXImplGetComputedCLFromClass(iClass, GetLevelByClass(iClass, oCreature));
    // Add the divine caster level from other classes
    if (iClass == iMainClass)
        iCasterLevel += JXImplGetImprovedDivineCLFromClasses(oCreature, iClass);
    // Add the caster level due to the Practised Spellcaster feature
    iCasterLevel += JXImplGetCLBonusFromPractisedSpellcaster(oCreature, iClass, iCasterLevel);

    return iCasterLevel;
}

// Get the caster level for a creature based on one of her class
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXImplGetCreatureCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // Get the main caster class (arcane or divine) if no class is specified
    if (iClass == CLASS_TYPE_INVALID)
    {
        iClass = JXGetMainCasterClass(oCreature, JX_SPELLTYPE_BOTH);
        if (iClass == CLASS_TYPE_INVALID) return 0;
    }
    // Test if the specified class is an arcane or a divine class
    else
    {
        if (!JXImplGetIsMainArcaneClass(iClass)
         && !JXImplGetIsMainDivineClass(iClass))
            return 0;
    }

    // Compute the arcane caster level for an arcane class
    if (JXImplGetIsMainArcaneClass(iClass))
        return JXGetCreatureArcaneCasterLevel(oCreature, iClass);

    // Compute the divine caster level for a divine class
    if (JXImplGetIsMainDivineClass(iClass))
        return JXGetCreatureDivineCasterLevel(oCreature, iClass);

    return 0;
}

// Get the caster level for a creature depending on a spell
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXImplGetCreatureCasterLevelForSpell(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    if (iSpellId < 0) return 0;

    // Get the class used to cast the current spell
    if (iClass == CLASS_TYPE_INVALID)
        iClass = GetLastSpellCastClass();

    // Get the best creature's class able to cast the spell
    if (iClass == CLASS_TYPE_INVALID)
        iClass = JXImplGetClassForSpell(iSpellId, oCreature);

    // Still no caster class found ? Then no caster level...
    if (iClass == CLASS_TYPE_INVALID) return 0;

    // Find the creature's caster level for the class
    int iCasterLevel = JXGetCreatureCasterLevel(oCreature, iClass);

    return iCasterLevel;
}

