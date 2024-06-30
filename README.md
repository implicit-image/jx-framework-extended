# JX Spellcasting Framework - extended

This is my extension of jallaix's spellcasting framework.

### Compatibility

Since nwscript doesnt have lists or similar features, spell and feat categories are determined using functions in *_interface_impl.nss files. This requires implementing following functions for your particular spell/class/feat setup

The impl directory contains the implementation for my Progression Overhaul Mod (in pr_ov directory) and for zMerger (in zMerger directory). I will probably move it to a seperate repo later. If you are using different content pack you have to modify impl/ files to make your spells, classes and feats work with the framework features.


#### file: jx_spell_info_interface_impl.nss



``` c++

// Indicate if a spell is using a ranged touch attack
// - iSpellId Identifier of the spell
// * Returns TRUE if the spell uses a ranged touch attack
int JXImplGetIsSpellUsingRangedTouchAttack(int iSpellId);


// Indicate if a spell is a spell or a spell-like ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a spell or a spell-like ability
int JXImplGetIsSpellMagical(int iSpellId)


// Indicate if a spell is a supernatural ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a supernatural ability
int JXImplGetIsSpellSupernatural(int iSpellId)


// Indicate if a spell is an extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is an extraordinary ability
int JXImplGetIsSpellExtraordinary(int iSpellId)


// Indicate if a spell isn't a spell, spell-like, supernatural or extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell isn't a spell, spell-like, supernatural or extraordinary ability
int JXImplGetIsSpellMiscellaneous(int iSpellId)


// Indicate if a spell has the specified descriptor
// - iSpellId SPELL_* constant
// - iDescriptor JX_SPELLDESCRIPTOR_* constant
// * Returns TRUE if the spell has the specified spell descriptor
int JXImplGetHasSpellDescriptor(int iSpellId, int iDescriptor = JX_SPELLDESCRIPTOR_ANY)


// Get the spell subschool of a spell
// - iSpellId SPELL_* constant
// * Returns a JX_SPELLSUBSCHOOL_* constant
int JXImplGetSpellSubSchool(int iSpellId)


// Get the creature's class that is associated with the specified spell
// - iSpellId SPELL_* constant
// - oCreature Creature on which the class search is performed
// * Returns a CLASS_TYPE_* constant, or -1 if it is not found
int JXImplGetClassForSpell(int iSpellId, object oCreature = OBJECT_SELF)


// Get the level of a spell, innate or depending on a caster class
// - iClass Class that is able to cast the spell (CLASS_TYPE_INVALID for innate)
// * Returns the spell level, or -1 if the spell is not accessible to the class
int JXImplGetBaseSpellLevel(int iSpellId, int iClass = CLASS_TYPE_INVALID)
```



#### file: jx_epic_spell_interface_impl.nss

These functions should correctly add caster levels gained from prestige classes for calculating epic spell save DC.

``` c++
int isEpicWizard();
int isEpicSorcerer();
int isEpicBard();
int isEpicCleric();
int isEpicDruid();
int isEpicFavoredSoul();
int isEpicSpiritShaman();
int isEpicWarlock();
```



#### file: jx_invocations_interface_impl.nss

``` c++

// Returns the highest level of Eldritch Blast available
int JXImplGetEldritchBlastLevelBonus(object oCaster)
```



#### file: jx_class_info_interface_impl.nss

``` c++

// Get the caster level associated with one of the main classes
int JXImplGetComputedCLFromClass(int iClass, int iClassLevel)


// Get the improved arcane casting levels due to prestige classes
int JXImplGetImprovedArcaneCLFromClasses(object oCreature, int iMainClass)


// Get the improved divine casting levels du to prestige classes
int JXImplGetImprovedDivineCLFromClasses(object oCreature, int iMainClass)


// Indicate if a class is a main arcane class
int JXImplGetIsMainArcaneClass(int iClass)


// Indicate if a class is a main divine class
int JXImplGetIsMainDivineClass(int iClass)


// Get the caster level bonus due to the Practised Spellcaster feature
int JXImplGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels)


// Get the save DC bonus for the specified spell
int JXImplGetSpellDCBonusFromSpell(int iSpellId, object oCreature)


int JXImplGetCreatureSpellSaveDC(int iSpellId, object oCreature = OBJECT_SELF, int iClass = CLASS_TYPE_INVALID)


int JXImplGetClassForSpell(int iSpellId, object oCreature = OBJECT_SELF)
```



#### file: jx_inc_magic
