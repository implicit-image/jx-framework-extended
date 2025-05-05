//::///////////////////////////////////////////////
//:: Conditions for the Spell Shape Conversation
//::///////////////////////////////////////////////
//:: 2d2f: 03-01-08 - Finished

#include "jx_inc_magic"
#include "jx_inc_magic_info"

int StartingConditional(int nSpellId)
{
        object oPC = GetPCSpeaker();
        int nSpellShapeLvl = GetLocalInt(oPC, "nSpellShapeLevel");
        int nHasSpell = GetHasSpell(nSpellId, oPC);
        if (nHasSpell > 0 && nSpellShapeLvl >= JXGetBaseSpellLevel(nSpellId))
        {
        return TRUE;
        }
        else
        {
        return FALSE;
        }
}
