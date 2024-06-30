#include "jx_class_info_interface_impl"


// Private function - Get the caster level associated with one of the main classes
//int JXPrivateGetComputedCLFromClass(int iClass, int iClassLevel)
int JXImplGetComputedCLFromClass(int iClass, int iClassLevel);

// Private function - Get the improved arcane casting levels due to prestige classes
//int JXPrivateGetImprovedArcaneCLFromClasses(object oCreature, int iMainClass)
int JXImplGetImprovedArcaneCLFromClasses(object oCreature, int iMainClass);

// Private function - Get the improved divine casting levels du to prestige classes
//int JXPrivateGetImprovedDivineCLFromClasses(object oCreature, int iMainClass)
int JXImplGetImprovedDivineCLFromClasses(object oCreature, int iMainClass);

// Private function - Indicate if a class is a main arcane class
//int JXPrivateGetIsMainArcaneClass(int iClass)
int JXImplGetIsMainArcaneClass(int iClass);

// Private function - Indicate if a class is a main divine class
//int JXPrivateGetIsMainDivineClass(int iClass)
int JXImplGetIsMainDivineClass(int iClass);

// Private function - Get the caster level bonus due to the Practised Spellcaster feature
//int JXPrivateGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels)
int JXImplGetCLBonusFromPractisedSpellcaster(object oCaster, int iCastingClass, int iCastingLevels)

// Private function - Get the save DC bonus for the specified spell
//int JXPrivateGetSpellDCBonusFromSpell(int iSpellId, object oCreature)
int JXImplGetSpellDCBonusFromSpell(int iSpellId, object oCreature);
