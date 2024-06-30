//::///////////////////////////////////////////////
//:: JX Magic Staff Include
//:: jx_inc_magicstaff_impl
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: sep 08, 2007
//:://////////////////////////////////////////////
//
// Use the magic staff system.
//
//:://////////////////////////////////////////////

#include "jx_inc_magic"

// Use the magic staff system. The staff wielder's caster level is used if it is
// better than the staff's caster level. The wielder's spell save DC is also
// used.
// - oItem Staff or any other item that uses the magic staff system
// - iSpellId Spell cast from the staff
void JXUseStaff(object oItem, int iSpellId) {
  // Determine if the item is a magic staff
  int bStaff = GetLocalInt(oItem, JX_ITEM_MAGICSTAFF);
  if (bStaff) {
    // Get the creature that holds the staff
    object oWielder = GetItemPossessor(oItem);

    // Get the item's caster level
    int iItemCasterLevel = JXGetItemCasterLevel(oItem);
    SendMessageToPC(GetFirstPC(),
                    "item caster level : " + IntToString(iItemCasterLevel));
    // Get the caster level of the staff's wielder (it may depend on the spell)
    int iWielderCasterLevel =
        JXGetCreatureCasterLevelForSpell(iSpellId, oWielder);
    // if (iWielderCasterLevel == 0)
    //   iWielderCasterLevel = JXGetCreatureCasterLevel(oWielder);
    SendMessageToPC(GetFirstPC(), "wielder caster level : " +
                                      IntToString(iWielderCasterLevel));
    // Use the best between the item's and the wielder's caster level
    if (iItemCasterLevel > iWielderCasterLevel)
      JXSetCasterLevel(iItemCasterLevel);
    else
      JXSetCasterLevel(iWielderCasterLevel);
    SendMessageToPC(GetFirstPC(),
                    "caster level set : " + IntToString(JXGetCasterLevel()));
    // Set the spell save DC as if the staff's wielder is casting the spell
    int iSaveDC = JXGetCreatureSpellSaveDC(iSpellId, oWielder);
    JXSetSpellSaveDC(iSaveDC);
    SendMessageToPC(GetFirstPC(),
                    "save DC set : " + IntToString(JXGetSpellSaveDC()));
  }
}
