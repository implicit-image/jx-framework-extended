#include "jx_inc_magic_info"
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



//========================================== Caster Class Search ==========================================//

// Get the main caster class, depending on the spell type
// - oCreature Creature from which to get the main caster class
// - iSpellType JX_SPELLTYPE_* constant
// * Returns a CLASS_TYPE_* constant, or -1 if not found
int JXGetMainCasterClass(object oCreature = OBJECT_SELF, int iSpellType = JX_SPELLTYPE_BOTH)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterObject(paramList, oCreature);
    paramList = JXScriptAddParameterInt(paramList, iSpellType);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_MAINCASTERCLASS, paramList);

    return JXScriptGetResponseInt();
}


int JXGetClassForSpell(int iSpellId, object oCreature = OBJECT_SELF)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterInt(paramList, iSpellId);
    paramList = JXScriptAddParameterObject(paramList, oCreature);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CLASS_FOR_SPELL, paramList);

    return JXScriptGetResponseInt();
}


//========================================== Class-related Caster Level ==========================================//

// Get the arcane caster level for a creature based on one of her class
// - oCreature Creature from which to get the arcane caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main arcane class)
// * Returns the creature's arcane caster level
int JXGetCreatureArcaneCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterObject(paramList, oCreature);
    paramList = JXScriptAddParameterInt(paramList, iClass);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATUREARCANECASTERLEVEL, paramList);

    return JXScriptGetResponseInt();
}

// Get the divine caster level for a creature based on one of her class
// - oCreature Creature from which to get the divine caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main divine class)
// * Returns the creature's divine caster level
int JXGetCreatureDivineCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterObject(paramList, oCreature);
    paramList = JXScriptAddParameterInt(paramList, iClass);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATUREDIVINECASTERLEVEL, paramList);

    return JXScriptGetResponseInt();
}

// Get the caster level for a creature based on one of her class
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevel(object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterObject(paramList, oCreature);
    paramList = JXScriptAddParameterInt(paramList, iClass);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATURECASTERLEVEL, paramList);

    return JXScriptGetResponseInt();
}

// Get the caster level for a creature depending on a spell
// - oCreature Creature from which to get the caster level
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the main caster class)
// * Returns the creature's caster level
int JXGetCreatureCasterLevelForSpell(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterInt(paramList, iSpellId);
    paramList = JXScriptAddParameterObject(paramList, oCreature);
    paramList = JXScriptAddParameterInt(paramList, iClass);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATURECASTERLEVELSPELL, paramList);

    return JXScriptGetResponseInt();
}


//========================================== Class-related Spell Save DC ==========================================//

// Get the save DC for the specified spell cast by a creature
// - iSpellId SPELL_* constant
// - oCreature Creature from which to get the spell save DC
// - iClass CLASS_TYPE_* constant (CLASS_TYPE_INVALID to use the best caster class able to cast the spell)
// * Returns the creature's spell save DC
int JXGetCreatureSpellSaveDC(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)
{
    struct script_param_list paramList;
    paramList = JXScriptAddParameterInt(paramList, iSpellId);
    paramList = JXScriptAddParameterObject(paramList, oCreature);
    paramList = JXScriptAddParameterInt(paramList, iClass);

    JXScriptCallFork(JX_SPFMWK_FORKSCRIPT, JX_FORK_CREATURESPELLSAVEDC, paramList);

    return JXScriptGetResponseInt();
}
