#include "jx_inc_spell_helpers"
// #include "utils"



//================================================ Declarations ===================

//=======================================
// Effect bonus link
//=======================================

void JXSetEffectBonusLink(int iJXEffectType, struct jx_effect LinkedEffect);

//===================================
// Effect tags
//==================================

void JXSetEffectTag(int iJXEffectType, int JXEffectTag);

//===================================
// Effect modifiers
//===================================

int JXSetEffectModifierInt(int iModifierArrayType, int iEffectType, int iValue);

int JXSetEffectModifierString(int iModifierArrayType, int iEffectType, string sValue);

int JXSetEffectModifierFloat(int iModifierArrayType, int iEffectType, float fValue);


//========================
// Reset function
//========================

int JXResetEffectModifiers(int JXEffectType);




//====================================================== Implementation ========================



// void JXSaveEffect(int iJXEffectType, effect eEffect)
// {

// }


// void JXSetEffectBonusLink(int iJXEffectType, struct jx_effect LinkedEffect)
// {
//     string sStrEffectRepr = JXOverrideEffectToString(LinkedEffect);
//     SetLocalArrayString(OBJECT_SELF, JX_OVERRIDE_EFFECT_BONUS_LINK, iJXEffectType, sStrEffectRepr);
// }

// void JXSetEffectModifierInt(int iEffectType,
//                            string iEffectPropertyArrayToModify=JX_EFFECT_PROP_PARAM_1,
//                            int iEffectModificationType=JX_EFFECT_MOD_PARAM_OVERRIDE,
//                            int iValue,
//                            int iModificationValue=-1,
//                            int iModifyOnlyIfEqual=FALSE,
//                            int iOldValue=-1
//                            )
// {
//     int iBaseIndex = (iEffectType)
//     // save modification type
//     SetLocalArrayInt(OBJECT_SELF, iEffectPropertyArrayToModify, iIndex, iEffectModificationType);

//     // save modification value
//     SetLocalArrayInt(OBJECT_SELF, )


// }


// void JXGetEffectModifierInt(int iEffectType,
//                            string iEffectPropertyArrayToModify=JX_EFFECT_PROP_PARAM_1,
//                            int iEffectModificationType=JX_EFFECT_MOD_PARAM_OVERRIDE,
//                            int iModificationValue=-1,
//                            int iModifyOnlyIfEqual=FALSE,
//                            int iOldValue=-1
//                            )
// {

// }




// void JXResetEffectModifiers(int JXEffectType)
// {

// }
