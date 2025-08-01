//::///////////////////////////////////////////////
//:: Conditions for the Gift of Inspiration Conversation
//::///////////////////////////////////////////////
//:: 2d2f: 04-29-08 Finished

#include "2d2f_includes"

int StartingConditional(int nLvl)
{
    object oPC = GetPCSpeaker();
    if(nLvl == 1 || nLvl == 2)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_1,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_2,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_3,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_4,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_5,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_6,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_7,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    else if(nLvl == 3)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_2,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_3,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_4,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_5,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_6,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_7,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }

    }
    else if(nLvl == 4)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_3,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_4,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_5,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_6,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_7,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }

    }
    else if(nLvl == 5)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_4,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_5,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_6,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_7,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }

    }
    else if(nLvl == 6)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_5,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_6,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_7,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }

    }
    else if(nLvl == 7)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_6,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_7,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }

    }
    else if(nLvl == 8)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_7,oPC) == TRUE ||
        GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }

    }
    else if(nLvl == 9)
    {
        if(GetHasFeat(FEAT_GIFT_OF_INSPIRATION_8,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }

    }

    else
    {
        return FALSE;
    }

    return FALSE;

}
