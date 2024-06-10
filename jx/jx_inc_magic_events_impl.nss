#include "jx_inc_data_func"


// Private function - Check if a spell can't be cast because of a silence effect on the caster
int JXPrivateCheckSilenceEffect(object oCaster, int iSpellId, int iMetaMagicFeat)
{
	// Get the verbal and somatic components of the spell to cast
	string sVS = Get2DAString("spells", "JX_VS", iSpellId);
	int bHasVerbal = (FindSubString(sVS, "v") > -1) ? TRUE : FALSE;
	int bHasSomatic = (FindSubString(sVS, "s") > -1) ? TRUE : FALSE;

	// Check if the verbal component prevents the spell to be cast
	if (bHasVerbal)
	{
		int bSilenceEffect = FALSE;
		effect eSilence = GetFirstEffect(oCaster);
		while (GetIsEffectValid(eSilence))
		{
			if (GetEffectType(eSilence) == EFFECT_TYPE_SILENCE)
			{
				bSilenceEffect = TRUE;
				break;
			}
			eSilence = GetNextEffect(oCaster);
		}
		// The spell can't be cast because of a silence effect on the caster
		if ((bSilenceEffect) && !(iMetaMagicFeat & METAMAGIC_SILENT))
		{
			SendMessageToPCByStrRef(oCaster, 67640);
			return FALSE;
		}
	}

	return TRUE;
}

// Private function - Check if a spell can't be cast because of arcane spell failure
int JXPrivateCheckASF(object oCaster, int iSpellId, int iMetaMagicFeat, int iClass)
{
	// Divine spells don't have spell failure
	if (Get2DAString("classes", "HasDivine", iClass) == "1")
		return TRUE;

	string sVS = Get2DAString("spells", "JX_VS", iSpellId);
	int bHasSomatic = (FindSubString(sVS, "s") > -1) ? TRUE : FALSE;

	// Check if the somatic component prevents the spell to be cast
	if (bHasSomatic && !(iMetaMagicFeat & METAMAGIC_STILL))
	{
		int iASF = GetArcaneSpellFailure(oCaster);
		if (iASF > 0)
		{
			int iASFCheck = d100();
			// The spell can't be cast because of arcane spell failure
			if (iASFCheck <= iASF)
			{
				if (GetIsPC(oCaster))
				{
					string sMessageASF = GetStringByStrRef(176528);
					sMessageASF = JXStringReplaceToken(sMessageASF, 0, IntToString(iASF));
					sMessageASF = JXStringReplaceToken(sMessageASF, 1, IntToString(iASFCheck));
					SendMessageToPC(oCaster, sMessageASF);
				}
				return FALSE;
			}
		}
	}

	return TRUE;
}

// This event is fired when a spell casting action is enqueued in the action queue
// N.B. : The action that will be enqueued can be overriden by using the
//        JXOverrideAddedActionCastSpell() function defined in "jx_inc_action"
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to enqueue the spellcasting action, or FALSE to prevent it to be enqueued
int JXImplEventActionCastSpellEnqueued(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	return TRUE;
}

// This event is fired when a spellcasting action becomes the current action of the caster
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXImplEventActionCastSpellStarted(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	return TRUE;
}

// This event is fired when the conjuration animation of a spellcasting action starts
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXImplEventActionCastSpellConjuring(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	return JXPrivateCheckSilenceEffect(oCaster, iSpellId, iMetaMagicFeat);
}

// This event is fired when the conjuration animation of a spellcasting action stops
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spellcasting action continue, or FALSE to stop it
int JXImplEventActionCastSpellConjured(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	return JXPrivateCheckASF(oCaster, iSpellId, iMetaMagicFeat, iClass);
}

// This event is fired when the spell is cast
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// * Returns TRUE to let the spell effects apply, or FALSE to prevent them
int JXImplEventActionCastSpellCast(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass)
{
	// Kept for compatibility with current systems
	return TRUE;
}

// This event is fired when a spellcasting action is finished
// - oCaster Caster of the spell
// - iSpellId SPELL_* constant
// - oTarget Target object of the spell (may be OBJECT_INVALID)
// - lTarget Target location of the spell (location of oTarget if oTarget is valid)
// - iCasterLevel Caster level for the spell
// - iMetaMagicFeat MetaMagic feat for the spell
// - iSpellSaveDC Save DC for the spell
// - iClass Class used to cast the spell
// - iResult FALSE if the spellcasting action hasn't been performed successfully
void JXImplEventActionCastSpellFinished(object oCaster, int iSpellId, object oTarget, location lTarget, int iCasterLevel, int iMetaMagicFeat, int iSpellSaveDC, int iClass, int iResult)
{
}