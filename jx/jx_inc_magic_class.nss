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

int JXImplGetCreatureCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

int JXImplGetCreatureCasterLevelForSpell(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

int JXImplGetCreatureArcaneCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

int JXImplGetCreatureDivineCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID);

//========================================== Caster Class Search ==========================================//

// Get the main caster class, depending on the spell type
// - oCreature Creature from which to get the main caster class
// - iSpellType JX_SPELLTYPE_* constant
// * Returns a CLASS_TYPE_* constant, or -1 if not found
int JXGetMainCasterClass(object oCreature = OBJECT_SELF, int iSpellType = JX_SPELLTYPE_BOTH)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iSpellType);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_MAINCASTERCLASS, paramList);
    //
    // return JXScriptGetResponseInt();

    return JXImplGetMainCasterClass(oCreature, iSpellType);
}


int JXGetClassForSpell(int iSpellId, object oCreature = OBJECT_SELF)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iSpellId);
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CLASS_FOR_SPELL, paramList);
    //
    // return JXScriptGetResponseInt();
    return JXImplGetClassForSpell(iSpellId, oCreature);
}


//========================================== Class-related Caster Level ==========================================//

// Get the arcane caster level for a creature based on one of her class
// - oCreature Creature from which to get the arcane caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main arcane class)
// * Returns the creature's arcane caster level
int JXGetCreatureArcaneCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATUREARCANECASTERLEVEL, paramList);

    // return JXScriptGetResponseInt();
    return JXImplGetCreatureArcaneCasterLevel(oCreature, iClass);
}

// Get the divine caster level for a creature based on one of her class
// - oCreature Creature from which to get the divine caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main divine class)
// * Returns the creature's divine caster level
int JXGetCreatureDivineCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATUREDIVINECASTERLEVEL, paramList);
    //
    // return JXScriptGetResponseInt();
    return JXImplGetCreatureDivineCasterLevel(oCreature, iClass);
}

// Get the caster level for a creature based on one of her class
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATURECASTERLEVEL, paramList);
    //
    // return JXScriptGetResponseInt();

    return JXImplGetCreatureCasterLevel(oCreature, iClass);
}

// Get the caster level for a creature depending on a spell
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevelForSpell(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iSpellId);
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATURECASTERLEVELSPELL, paramList);
    //
    // return JXScriptGetResponseInt();

    return JXImplGetCreatureCasterLevelForSpell(oCreature, iClass);
}


//========================================== Class-related Spell Save DC ==========================================//

// Get the save DC for the specified spell cast by a creature
// - iSpellId SPELL_* constant
// - oCreature Creature from which to get the spell save DC
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the best caster class able to cast the spell)
// * Returns the creature's spell save DC
int JXGetCreatureSpellSaveDC(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iSpellId);
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATURESPELLSAVEDC, paramList);
    //
    // return JXScriptGetResponseInt();
    return JXImplGetCreatureSpellSaveDC(iSpellId, oCreature);
}
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
         && (JXGetIsMainArcaneClass(iClass)))
        {
            iCasterLevel = JXGetComputedCLFromClass(iClass, iClassLevel);
            if ((iCasterLevel > iBestCasterLevel) || (iBestCasterLevel == CLASS_TYPE_INVALID))
            {
                iBestClass = iClass;
                iBestCasterLevel = iCasterLevel;
            }
        }

        // Case Divine class
        if (((iSpellType == JX_SPELLTYPE_DIVINE) || (iSpellType == JX_SPELLTYPE_BOTH))
         && (JXGetIsMainDivineClass(iClass)))
        {
            iCasterLevel = JXGetComputedCLFromClass(iClass, iClassLevel);
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
    if (!JXGetIsMainArcaneClass(iClass))
        return 0;

    // Compute the arcane caster level for the main caster class
    int iCasterLevel = JXGetComputedCLFromClass(iClass, GetLevelByClass(iClass, oCreature));
    // Add the arcane caster level from other classes
    if (iClass == iMainClass)
        iCasterLevel += JXGetImprovedArcaneCLFromClasses(oCreature, iClass);
    // Add the caster level due to the Practised Spellcaster feature
    iCasterLevel += JXGetCLBonusFromPractisedSpellcaster(oCreature, iClass, iCasterLevel);

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
    if (!JXGetIsMainDivineClass(iClass))
        return 0;

    // Compute the divine caster level for the main caster class
    int iCasterLevel = JXGetComputedCLFromClass(iClass, GetLevelByClass(iClass, oCreature));
    // Add the divine caster level from other classes
    if (iClass == iMainClass)
        iCasterLevel += JXGetImprovedDivineCLFromClasses(oCreature, iClass);
    // Add the caster level due to the Practised Spellcaster feature
    iCasterLevel += JXGetCLBonusFromPractisedSpellcaster(oCreature, iClass, iCasterLevel);

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
        if (!JXGetIsMainArcaneClass(iClass)
         && !JXGetIsMainDivineClass(iClass))
            return 0;
    }

    // Compute the arcane caster level for an arcane class
    if (JXGetIsMainArcaneClass(iClass))
        return JXGetCreatureArcaneCasterLevel(oCreature, iClass);

    // Compute the divine caster level for a divine class
    if (JXGetIsMainDivineClass(iClass))
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
        iClass = JXGetClassForSpell(iSpellId, oCreature);

    // Still no caster class found ? Then no caster level...
    if (iClass == CLASS_TYPE_INVALID) return 0;

    // Find the creature's caster level for the class
    int iCasterLevel = JXGetCreatureCasterLevel(oCreature, iClass);

    return iCasterLevel;
}

int JXGetIsMainArcaneClass(int iClass)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_IS_MAIN_ARCANE_CLASS, paramList);
    //
    // return JXScriptGetResponseInt();
    return JXImplGetIsMainArcaneClass(iClass);
}

int JXGetIsMainDivineClass(int iClass)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_IS_MAIN_DIVINE_CLASS, paramList);
    //
    // return JXScriptGetResponseInt();
    return JXImplGetIsMainDivineClass(iClass);
}

int JXGetComputedCLFromClass(int iClass, int iClassLevel)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    // paramList = JXScriptAddParameterInt(paramList, iClassLevel);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_COMPUTED_CL_FROM_CLASS, paramList);
    //
    // return JXScriptGetResponseInt();

    return JXImplGetComputedCLFromClass(iClass, iClassLevel);
}

int JXGetImprovedArcaneCLFromClasses(object oCreature, int iClass)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_IMPROVED_ARCANE_CL_FROM_CLASSES, paramList);

    // return JXScriptGetResponseInt();

    return JXImplGetImprovedArcaneCLFromClasses(oCreature, iClass);
}

int JXGetImprovedDivineCLFromClasses(object oCreature, int iClass)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterObject(paramList, oCreature);
    // paramList = JXScriptAddParameterInt(paramList, iClass);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_IMPROVED_DIVINE_CL_FROM_CLASSES, paramList);
    //
    // return JXScriptGetResponseInt();

    return JXImplGetImprovedDivineCLFromClasses(oCreature, iClass);
}

int JXGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterObject(paramList, oCaster);
    // paramList = JXScriptAddParameterInt(paramList, iCastingClass);
    // paramList = JXScriptAddParameterInt(paramList, iCastingLevels);
    //
    // JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_PRACTISED_SPELLCASTER_BONUS, paramList);
    //
    // return JXScriptGetResponseInt();
    return JXImplGetCLBonusFromPractisedSpellcaster(oCaster, iCastingClass, iCastingLevels);
}
