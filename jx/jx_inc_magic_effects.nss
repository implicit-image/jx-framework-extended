#include "utils"
#include "jx_effect_param_interface"
#include "jx_inc_magic"
/*
In order to use effect overrides you need to set them in the precast script.
All effect overrides are local and are reset after the spell finishes casting.
Since effect type cannot be identified before the effect is applied, this code
works by creating wrapper functions for effect creation.

More about the precast script in x2_inc_spellhook.nss.

*/


//=====================================================
// EFFECT WRAPPERS
//
// Each effect uses only some of existing overrides. See jx_inc_effect_ovr.nss
// for more more information.
//======================================================


//============================================Declarations===================================

effect JXEffectHeal(int iDmgToHeal);

effect JXEffectDamage(int iDmg, int iDmgType=DAMAGE_TYPE_MAGICAL, int iDamagePower=DAMAGE_POWER_NORMAL, int bIgnoreRes=FALSE);

effect JXEffectDamageOverTime(int iDmg, float fInterval, int iDmgType=DAMAGE_TYPE_MAGICAL, int iIgnoreResistances=FALSE);

effect JXEffectAbilityIncrease(int iAbility, int iModifyBy);

effect JXEffectDamageResistance(int iDamageType, int iAmount, int iLimit=0);

effect JXEffectResurrection();

effect JXEffectSummonCreature(string sCreatureResref, int iVisualEffectId=VFX_NONE, float fDelay=0.0f, int iUseAppearAnimation=0);

effect JXMagicalEffect(effect eEffect);

effect JXSupernaturalEffect(effect eEffect);

effect JXExtraordinaryEffect(effect eEffect);

effect JXEffectACIncrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL, int iVsSpiritsOnly=FALSE);

effect JXEffectSavingThrowIncrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL, int iVsSpiritsOnly=FALSE);

effect JXEffectAttackIncrease(int iBonus, int iModifierType=ATTACK_BONUS_MISC);

effect JXEffectDamageReduction(int iAmount, int iDRSubType=DAMAGE_POWER_NORMAL, int iLimit=0, int iDRType=DR_TYPE_MAGICBONUS);

effect JXEffectDamageIncrease(int iBonus, int iDamageType=DAMAGE_TYPE_MAGICAL, int iVersusRace=-1);

effect JXEffectEntangle();

effect JXEffectDeath(int iSpectacularDeath=FALSE, int iDisplayFeedback=TRUE, int iIgnoreDeathImmunity=FALSE, int iPurgeEffects=TRUE);

effect JXEffectKnockdown();

effect JXEffectCurse(int iStrMod=1, int iDexMod=1, int iConMod=1, int iIntMod=1, int iWisMod=1, int iChaMod=1);

effect JXEffectParalyze(int iSaveDC=-1, int iSave=SAVING_THROW_WILL, int iSaveEveryRound = TRUE);

effect JXEffectSpellImmunity(int iImmunityToSpell=SPELL_ALL_SPELLS);

effect JXEffectDeaf();

effect JXEffectSleep();

effect JXEffectCharmed();

effect JXEffectConfused();

effect JXEffectFrightened();

effect JXEffectDominated();

effect JXEffectDazed();

effect JXEffectStunned();

effect JXEffectRegenerate(int iAmount, float fIntervalSeconds);

effect JXEffectMovementSpeedIncrease(int iPercentChange);

effect JXEffectSpellResistanceIncrease(int iValue, int iUses = -1);

effect JXEffectPoison(int iPoisonType);

effect JXEffectDisease(int iDiseaseType);

effect JXEffectSilence();

effect JXEffectHaste();

effect JXEffectSlow();

effect JXEffectImmunity(int iImmunityType);

effect JXEffectDamageImmunityIncrease(int iDamageType, int iPercentImmunity);

effect JXEffectTemporaryHitpoints(int iHitPoints);

effect JXEffectSkillIncrease(int iSkill, int iValue);

effect JXVersusAlignmentEffect(effect eEffect, int iLawChaos=ALIGNMENT_ALL, int iGoodEvil=ALIGNMENT_ALL);

effect JXVersusRacialTypeEffect(effect eEffect, int iRacialType);

effect JXVersusTrapEffect(effect eEffect);

effect JXEffectTurned();

effect JXEffectHitPointChangeWhenDying(float fHitPointChangePerRound);

effect JXEffectAbilityDecrease(int iAbility, int iModifyBy);

effect JXEffectAttackDecrease(int iPenalty, int iModifierType=ATTACK_BONUS_MISC);

effect JXEffectDamageDecrease(int iPenalty, int iDamageType=DAMAGE_TYPE_MAGICAL);

effect JXEffectDamageImmunityDecrease(int iDamageType, int iPercentImmunity);

effect JXEffectACDecrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL);

effect JXEffectMovementSpeedDecrease(int iPercentChange);

effect JXEffectSavingThrowDecrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL);

effect JXEffectSkillDecrease(int iSkill, int iValue);

effect JXEffectSpellResistanceDecrease(int iValue);

effect JXEffectInvisibility(int iInvisibilityType);

effect JXEffectConcealment(int iPercentage, int iMissType=MISS_CHANCE_TYPE_NORMAL);

effect JXEffectDarkness();

effect JXEffectUltravision();

effect JXEffectNegativeLevel(int iNumLevels, int bHPBonus=FALSE);

effect JXEffectPolymorph(int iPolymorphSelection, int bLocked=FALSE, int bWildshape=FALSE);

effect JXEffectSanctuary(int iDifficultyClass);

effect JXEffectTrueSeeing();

effect JXEffectSeeInvisible();

effect JXEffectTimeStop();

effect JXEffectBlindness();

effect JXEffectSpellLevelAbsorption(int iMaxSpellLevelAbsorbed, int iTotalSpellLevelsAbsorbed=0, int iSpellSchool=SPELL_SCHOOL_GENERAL);

effect JXEffectMissChance(int iPercentage, int iMissChanceType=MISS_CHANCE_TYPE_NORMAL);

effect JXEffectDisappearAppear(location lLocation, int iAnimation=1);

effect JXEffectDisappear(int iAnimation=1);

effect JXEffectAppear(int iAnimation=1);

effect JXEffectModifyAttacks(int iAttacks);

effect JXEffectDamageShield(int iDamageAmount, int iRandomAmount, int iDamageType);

effect JXEffectSwarm(int bLooping, string sCreatureTemplate1, string sCreatureTemplate2="", string sCreatureTemplate3="", string sCreatureTemplate4="");

effect JXEffectTurnResistanceDecrease(int iHitDice);

effect JXEffectTurnResistanceIncrease(int iHitDice);

effect JXEffectPetrify();

effect JXEffectSpellFailure(int iPercent=100, int iSpellSchool=SPELL_SCHOOL_GENERAL);

effect JXEffectEthereal();

effect JXEffectDetectUndead();

effect JXEffectLowLightVision();

effect JXEffectSetScale(float fScaleX, float fScaleY=-1.0, float fScaleZ=-1.0);

effect JXEffectShareDamage(object oHelper, int iAmountShared=50, int iAmountCasterShared=50);

effect JXEffectAssayResistance(object oTarget);

effect JXEffectSeeTrueHPs();

effect JXEffectAbsorbDamage(int iACTest);

effect JXEffectHideousBlow(int iMetamagic);

effect JXEffectMesmerize(int iBreakFlags, float fBreakDist = 0.0f);

effect JXEffectDarkVision();

effect JXEffectArmorCheckPenaltyIncrease(object oTarget, int nPenalty);

effect JXEffectDisintegrate(object oTarget);

effect JXEffectHealOnZeroHP(object oTarget, int iDmgToHeal);

effect JXEffectBreakEnchantment(int nLevel);

effect JXEffectBonusHitpoints(int iHitpoints);

effect JXEffectBardSongSinging(int iSpellId);

effect JXEffectJarring();

effect JXEffectBABMinimum(int nBABMin);

effect JXEffectMaxDamage();

effect JXEffectArcaneSpellFailure(int iPercent);

effect JXEffectWildshape();

effect JXEffectEffectIcon(int iEffectIconId);

effect JXEffectRescue(int iSpellId);

effect JXEffectDetectSpirits();

effect JXEffectDamageReductionNegated();

effect JXEffectConcealmentNegated();

effect JXEffectInsane();

effect JXEffectSummonCopy(object oSource, int iVisualEffectId=VFX_NONE, float fDelaySeconds=0.0f, string sNewTag="", int iNewHP=0, string sScript="");

//==============================================================
// Cutscene Effects
//==============================================================

effect JXEffectCutsceneParalyze();

effect JXEffectCutsceneDominated();

effect JXEffectCutsceneImmobilize();

effect JXEffectCutsceneGhost();

//====================================================================
// Effects using action parameters
//====================================================================

// impossible to implement as user defined functions
// cant use action type arguments

/* effect JXEffectDispelMagicAll(int iCasterLevel, action aOnDispelEffect ) */
/* effect JXEffectDispelMagicBest(int iCasterLevel, action aOnDispelEffect ); */
/* effect JXEffectOnDispel( float fDelay, action aOnDispelEffect ); */

//==============================================================
// SPECIAL EFFECT FUNCTIONS
//==============================================================


effect JXEffectAreaOfEffect(int iAreaEffectId, string sOnEnterScript="", string sHeartbeatScript="", string sOnExitScript="", string sEffectTag="");

effect JXEffectVisualEffect(int iVisualEffectId, int bMissEffect=FALSE);

effect JXEffectBeam(int iBeamVisualEffect, object oEffector, int iBodyPart, int bMissEffect=FALSE);

//======================================================
// SIMULATED EFFECTS
//======================================================

//simulates shaken effect
effect JXEffectShaken(int iAttackPenalty=2, int iSavePenalty=2, int iSkillPenalty=2);

effect JXEffectSickened(int iAttackPenalty=2,
                        int iDamagePenalty=2,
                        int iSavePenalty=2,
                        int iSkillPenalty=2);

effect JXEffectFatigued(int iStrPenalty=2, int iDexPenalty=2, int iMovePenalty=10);


effect JXEffectExhausted();



//=========================================================
// UTILITY FUNCTIONS
//=========================================================

effect JXEffectLinkEffects(effect e1, effect e2);

int JXApplyEffectParamModifier_Int(int iJXEffectType, int iValue, int iParamPos=1);

float JXApplyEffectParamModifier_Float(int iJXEffectType, float fValue, int iParamPos=1);

string JXApplyEffectParamModifier_String(int iJXEffectType, string sValue, int iParamPos=1);

object JXApplyEffectParamModifier_Object(int iJXEffectType, object oValue, int iParamPos=1);

//================================================IMPLEMENTATION====================================


//=======================================================
// EFFECT HEAL
//=====================================================
effect JXEffectHeal(int iDmgToHeal)
{
    effect eMain;
    iDmgToHeal = JXImplApplyEffectParamModifier_Int(JX_EFFECT_HEAL, iDmgToHeal, 1);
    eMain = EffectHeal(iDmgToHeal);
    return eMain;
}


//=========================================================
// EFFECT DAMAGE
//==========================================================


// EffectDamage wrapper
// Allows for overriding spell damage type in precast script
effect JXEffectDamage(int iDmg, int iDmgType=DAMAGE_TYPE_MAGICAL, int iDmgPower=DAMAGE_POWER_NORMAL, int bIgnoreRes=FALSE)
{
    effect eMain;
    iDmg = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, iDmg, 1);
    iDmgType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, iDmgType, 2);
    iDmgPower = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, iDmgPower, 3);
    bIgnoreRes = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, bIgnoreRes, 4);
    eMain = EffectDamage(iDmg, iDmgType, iDmgPower, bIgnoreRes);
    return eMain;
}


//=====================================================
// EffectDamageOverTime
//=======================================================


effect JXEffectDamageOverTime(int iDmg, float fInterval, int iDmgType=DAMAGE_TYPE_MAGICAL, int bIgnoreResistances=FALSE)
{
    effect eMain;
    iDmg = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_OVER_TIME, iDmg, 1);
    fInterval = JXImplApplyEffectParamModifier_Float(JX_EFFECT_DAMAGE_OVER_TIME, fInterval, 2);
    iDmgType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_OVER_TIME, iDmgType, 3);
    bIgnoreResistances = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_OVER_TIME, bIgnoreResistances, 4);
    eMain = EffectDamageOverTime(iDmg, fInterval, iDmgType, bIgnoreResistances);
    return eMain;
}


//=============================================================
// EffectAbilityIncrease
//=============================================================

effect JXEffectAbilityIncrease(int iAbility, int iModifyBy)
{
    effect eMain;
    iAbility = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ABILITY_INCREASE, iAbility, 1);
    iModifyBy = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ABILITY_INCREASE, iModifyBy, 2);
    eMain = EffectAbilityIncrease(iAbility, iModifyBy);
    return eMain;
}

effect JXEffectDamageResistance(int iDamageType, int iAmount, int iLimit=0)
{
    effect eMain;
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_RESISTANCE, iDamageType, 1);
    iAmount = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_RESISTANCE, iAmount, 2);
    iLimit = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_RESISTANCE, iLimit, 3);
    eMain = EffectDamageResistance(iDamageType, iAmount, iLimit);
    return eMain;
}

effect JXEffectResurrection()
{
    effect eMain;
    eMain = EffectResurrection();
    return eMain;
}

effect JXEffectSummonCreature(string sCreatureResref, int iVisualEffectId=VFX_NONE, float fDelay=0.0f, int iUseAppearAnimation=0)
{
    effect eMain;
    sCreatureResref = JXImplApplyEffectParamModifier_String(JX_EFFECT_SUMMON_CREATURE, sCreatureResref, 1);
    iVisualEffectId = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SUMMON_CREATURE, iVisualEffectId, 2);
    fDelay = JXImplApplyEffectParamModifier_Float(JX_EFFECT_SUMMON_CREATURE, fDelay, 3);
    iUseAppearAnimation = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SUMMON_CREATURE, iUseAppearAnimation, 4);
    eMain = EffectSummonCreature(sCreatureResref, iVisualEffectId, fDelay, iUseAppearAnimation);
    return eMain;
}


//#####################################################
// atm they are here just for compatibility
effect JXMagicalEffect(effect eEffect)
{
    return MagicalEffect(eEffect);
}

effect JXSupernaturalEffect(effect eEffect)
{
    return SupernaturalEffect(eEffect);
}

effect JXExtraordinaryEffect(effect eEffect)
{
    return ExtraordinaryEffect(eEffect);
}
//#####################################################

effect JXEffectACIncrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL, int iVsSpiritsOnly=FALSE)
{
    effect eMain;
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iValue, 1);
    iModifyType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iModifyType, 2);
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iDamageType, 3);
    iVsSpiritsOnly = JXImplApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iVsSpiritsOnly, 4);
    eMain = EffectACIncrease(iValue, iModifyType, iDamageType, iVsSpiritsOnly);
    return eMain;
}

effect JXEffectSavingThrowIncrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL, int iVsSpiritsOnly=FALSE)
{
    effect eMain;
    iSave = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_INCREASE, iSave, 1);
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_INCREASE, iValue, 2);
    iVsSpiritsOnly = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_INCREASE, iVsSpiritsOnly, 3);
    eMain = EffectSavingThrowIncrease(iSave, iValue, iSaveType, iVsSpiritsOnly);
    return eMain;
}

effect JXEffectAttackIncrease(int iBonus, int iModifierType=ATTACK_BONUS_MISC)
{
    effect eMain;
    iBonus = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ATTACK_INCREASE, iBonus, 1);
    iModifierType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ATTACK_INCREASE, iModifierType, 2);
    eMain = EffectAttackIncrease (iBonus, iModifierType);
    return eMain;
}

effect JXEffectDamageReduction(int iAmount, int iDmgPower=DAMAGE_POWER_NORMAL, int iLimit=0, int iDRType=DR_TYPE_MAGICBONUS)
{
    effect eMain;
    iAmount = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iAmount, 1);
    iDmgPower = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iDmgPower, 2);
    iLimit = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iLimit, 3);
    iDRType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iDRType, 4);
    eMain = EffectDamageReduction (iAmount, iDmgPower, iLimit, iDRType);
    return eMain;
}

effect JXEffectDamageIncrease(int iBonus, int iDamageType=DAMAGE_TYPE_MAGICAL, int iVersusRace=-1)
{
    effect eMain;
    iBonus = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_INCREASE, iBonus, 1);
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_INCREASE, iDamageType, 2);
    iVersusRace = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_INCREASE, iVersusRace, 3);
    eMain = EffectDamageIncrease (iBonus, iDamageType, iVersusRace);
    return eMain;
}

effect JXEffectEntangle()
{
    return EffectEntangle();
}

effect JXEffectDeath(int iSpectacularDeath=FALSE, int iDisplayFeedback=TRUE, int iIgnoreDeathImmunity=FALSE, int iPurgeEffects=TRUE)
{
    effect eMain;
    iSpectacularDeath = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DEATH, iSpectacularDeath, 1);
    iDisplayFeedback = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DEATH, iDisplayFeedback, 2);
    iIgnoreDeathImmunity = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DEATH, iIgnoreDeathImmunity, 3);
    eMain = EffectDeath (iSpectacularDeath, iDisplayFeedback, iIgnoreDeathImmunity, iPurgeEffects);
    return eMain;
}

effect JXEffectKnockdown()
{
    return EffectKnockdown();
}

effect JXEffectCurse(int iStrMod=1, int iDexMod=1, int iConMod=1, int iIntMod=1, int iWisMod=1, int iChaMod=1)
{
    iStrMod = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CURSE, iStrMod, 1);
    iDexMod = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CURSE, iDexMod, 2);
    iConMod = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CURSE, iConMod, 3);
    iIntMod = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CURSE, iIntMod, 4);
    iWisMod = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CURSE, iWisMod, 5);
    iChaMod = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CURSE, iChaMod, 6);
    return EffectCurse(iStrMod, iDexMod, iConMod, iIntMod, iWisMod, iChaMod);
}

effect JXEffectParalyze(int iSaveDC=-1, int iSave=SAVING_THROW_WILL, int iSaveEveryRound = TRUE)
{
    iSaveDC = JXImplApplyEffectParamModifier_Int(JX_EFFECT_PARALYZE, iSaveDC, 1);
    iSave = JXImplApplyEffectParamModifier_Int(JX_EFFECT_PARALYZE, iSave, 2);
    iSaveEveryRound = JXImplApplyEffectParamModifier_Int(JX_EFFECT_PARALYZE, iSaveEveryRound, 3);
    return EffectParalyze(iSaveDC, iSave, iSaveEveryRound);
}

effect JXEffectSpellImmunity(int iImmunityToSpell=SPELL_ALL_SPELLS)
{
    iImmunityToSpell = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_IMMUNITY, iImmunityToSpell, 1);
    return EffectSpellImmunity(iImmunityToSpell);
}

effect JXEffectDeaf()
{
    return EffectDeaf();
}

effect JXEffectSleep()
{
    return EffectSleep();
}

effect JXEffectCharmed()
{
    return EffectCharmed();
}

effect JXEffectConfused()
{
    return EffectConfused();
}

effect JXEffectFrightened()
{
    return EffectFrightened();
}

effect JXEffectDominated()
{
    return EffectDominated();
}

effect JXEffectDazed()
{
    return EffectDazed();
}

effect JXEffectStunned()
{
    return EffectStunned();
}

effect JXEffectRegenerate(int iAmount, float fIntervalSeconds)
{
    iAmount = JXImplApplyEffectParamModifier_Int(JX_EFFECT_REGENERATE, iAmount, 1);
    fIntervalSeconds = JXImplApplyEffectParamModifier_Float(JX_EFFECT_REGENERATE, fIntervalSeconds, 2);
    return EffectRegenerate(iAmount, fIntervalSeconds);
}

effect JXEffectMovementSpeedIncrease(int iPercentChange)
{
    iPercentChange = JXImplApplyEffectParamModifier_Int(JX_EFFECT_MOVEMENT_SPEED_INCREASE, iPercentChange, 1);
    return EffectMovementSpeedIncrease(iPercentChange);
}

effect JXEffectSpellResistanceIncrease(int iValue, int iUses=-1)
{
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_RESISTANCE_INCREASE, iValue, 1);
    iUses = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_RESISTANCE_INCREASE, iUses, 2);
    return EffectSpellResistanceIncrease(iValue, iUses);
}

effect JXEffectPoison(int iPoisonType)
{
    iPoisonType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_POISON, iPoisonType, 1);
    return EffectPoison(iPoisonType);
}

effect JXEffectDisease(int iDiseaseType)
{
    iDiseaseType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DISEASE, iDiseaseType, 1);
    return EffectDisease(iDiseaseType);
}

effect JXEffectSilence()
{
    return EffectSilence();
}

effect JXEffectHaste()
{
    return EffectHaste();
}

effect JXEffectSlow()
{
    return EffectSlow();
}

effect JXEffectImmunity(int iImmunityType)
{
    iImmunityType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_IMMUNITY, iImmunityType, 1);
    return EffectImmunity(iImmunityType);
}

effect JXEffectDamageImmunityIncrease(int iDamageType, int iPercentImmunity)
{
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_IMMUNITY_INCREASE, iDamageType, 1);
    iPercentImmunity = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_IMMUNITY_INCREASE, iPercentImmunity, 2);
    return EffectDamageImmunityIncrease(iDamageType, iPercentImmunity);
}

effect JXEffectTemporaryHitpoints(int iHitPoints)
{
    iHitPoints = JXImplApplyEffectParamModifier_Int(JX_EFFECT_TEMPORARY_HITPOINTS, iHitPoints, 1);
    return EffectTemporaryHitpoints(iHitPoints);
}

effect JXEffectSkillIncrease(int iSkill, int iValue)
{
    iSkill = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SKILL_INCREASE, iSkill, 1);
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SKILL_INCREASE, iSkill, 2);
    return EffectSkillIncrease(iSkill, iValue);
}

//####################################################
// ATM for compatibility only
effect JXVersusAlignmentEffect(effect eEffect, int iLawChaos=ALIGNMENT_ALL, int iGoodEvil=ALIGNMENT_ALL)
{
    return VersusAlignmentEffect(eEffect, iLawChaos, iGoodEvil);
}

effect JXVersusRacialTypeEffect(effect eEffect, int iRacialType)
{
    return VersusRacialTypeEffect(eEffect, iRacialType);
}

effect JXVersusTrapEffect(effect eEffect)
{
    return VersusTrapEffect(eEffect);
}

//##################################################

effect JXEffectTurned()
{
    return EffectTurned();
}

effect JXEffectHitPointChangeWhenDying(float fHitPointChangePerRound)
{
    fHitPointChangePerRound = JXImplApplyEffectParamModifier_Float(JX_EFFECT_HITPOINT_CHANGE_WHEN_DYING, fHitPointChangePerRound, 1);
    return EffectHitPointChangeWhenDying(fHitPointChangePerRound);
}

effect JXEffectAbilityDecrease(int iAbility, int iModifyBy)
{
    iAbility = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ABILITY_DECREASE, iAbility, 1);
    iModifyBy = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ABILITY_DECREASE, iModifyBy, 2);
    return EffectAbilityDecrease(iAbility, iModifyBy);
}

effect JXEffectAttackDecrease(int iPenalty, int iModifierType=ATTACK_BONUS_MISC)
{
    iPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ATTACK_DECREASE, iPenalty, 1);
    iModifierType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ATTACK_DECREASE, iModifierType, 2);
    return EffectAttackDecrease(iPenalty, iModifierType);
}

effect JXEffectDamageDecrease(int iPenalty, int iDamageType=DAMAGE_TYPE_MAGICAL)
{
    iPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_DECREASE, iPenalty, 1);
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_DECREASE, iDamageType, 2);
    return EffectDamageDecrease(iPenalty, iDamageType);
}

effect JXEffectDamageImmunityDecrease(int iDamageType, int iPercentImmunity)
{
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_IMMUNITY_DECREASE, iDamageType, 1);
    iPercentImmunity = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_IMMUNITY_DECREASE, iPercentImmunity, 2);
    return EffectDamageImmunityDecrease(iDamageType, iPercentImmunity);
}

effect JXEffectACDecrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL)
{
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_AC_DECREASE, iValue, 1);
    iModifyType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_AC_DECREASE, iModifyType, 2);
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_AC_DECREASE, iDamageType, 3);
    return EffectACDecrease(iValue, iModifyType, iDamageType);
}

effect JXEffectMovementSpeedDecrease(int iPercentChange)
{
    iPercentChange = JXImplApplyEffectParamModifier_Int(JX_EFFECT_MOVEMENT_SPEED_DECREASE, iPercentChange, 1);
    return EffectMovementSpeedDecrease(iPercentChange);
}

effect JXEffectSavingThrowDecrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL)
{
    iSave = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_DECREASE, iSave, 1);
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_DECREASE, iValue, 2);
    iSaveType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_DECREASE, iSaveType, 3);
    return EffectSavingThrowDecrease(iSave, iValue, iSaveType);
}

effect JXEffectSkillDecrease(int iSkill, int iValue)
{
    iSkill = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SKILL_DECREASE, iSkill, 1);
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SKILL_DECREASE, iValue, 2);
    return EffectSkillDecrease(iSkill, iValue);
}

effect JXEffectSpellResistanceDecrease(int iValue)
{
    iValue = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_RESISTANCE_DECREASE, iValue, 1);
    return EffectSpellResistanceDecrease(iValue);
}

effect JXEffectInvisibility(int iInvisibilityType)
{
    iInvisibilityType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_INVISIBILITY, iInvisibilityType, 1);
    return EffectInvisibility(iInvisibilityType);
}

effect JXEffectConcealment(int iPercentage, int iMissType=MISS_CHANCE_TYPE_NORMAL)
{
    iPercentage = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CONCEALMENT, iPercentage, 1);
    iMissType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_CONCEALMENT, iMissType, 2);
    return EffectConcealment(iPercentage, iMissType);
}

effect JXEffectDarkness()
{
    return EffectDarkness();
}

effect JXEffectUltravision()
{
    return EffectUltravision();
}

effect JXEffectNegativeLevel(int iNumLevels, int bHPBonus=FALSE)
{
    iNumLevels = JXImplApplyEffectParamModifier_Int(JX_EFFECT_NEGATIVE_LEVEL, iNumLevels, 1);
    bHPBonus = JXImplApplyEffectParamModifier_Int(JX_EFFECT_NEGATIVE_LEVEL, bHPBonus, 2);
    return EffectNegativeLevel(iNumLevels, bHPBonus);
}

effect JXEffectPolymorph(int iPolymorphSelection, int bLocked=FALSE, int bWildshape=FALSE)
{
    iPolymorphSelection = JXImplApplyEffectParamModifier_Int(JX_EFFECT_POLYMORPH, iPolymorphSelection, 1);
    bLocked = JXImplApplyEffectParamModifier_Int(JX_EFFECT_POLYMORPH, bLocked, 2);
    bWildshape = JXImplApplyEffectParamModifier_Int(JX_EFFECT_POLYMORPH, bWildshape, 3);
    return EffectPolymorph(iPolymorphSelection, bLocked, bWildshape);
}

effect JXEffectSanctuary(int iDifficultyClass)
{
    iDifficultyClass = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SANCTUARY, iDifficultyClass, 1);
    return EffectSanctuary(iDifficultyClass);
}

effect JXEffectTrueSeeing()
{
    return EffectTrueSeeing();
}

effect JXEffectSeeInvisible()
{
    return EffectSeeInvisible();
}

effect JXEffectTimeStop()
{
    return EffectTimeStop();
}

effect JXEffectBlindness()
{
    return EffectBlindness();
}

effect JXEffectSpellLevelAbsorption(int iMaxSpellLevelAbsorbed, int iTotalSpellLevelsAbsorbed=0, int iSpellSchool=SPELL_SCHOOL_GENERAL )
{
    iMaxSpellLevelAbsorbed = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_LEVEL_ABSORPTION, iMaxSpellLevelAbsorbed, 1);
    iTotalSpellLevelsAbsorbed = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_LEVEL_ABSORPTION, iTotalSpellLevelsAbsorbed, 2);
    iSpellSchool = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_LEVEL_ABSORPTION, iSpellSchool, 3);
    return EffectSpellLevelAbsorption(iMaxSpellLevelAbsorbed, iTotalSpellLevelsAbsorbed, iSpellSchool);
}

effect JXEffectMissChance(int iPercentage, int iMissChanceType=MISS_CHANCE_TYPE_NORMAL)
{
    iPercentage = JXImplApplyEffectParamModifier_Int(JX_EFFECT_MISS_CHANCE, iPercentage, 1);
    iMissChanceType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_MISS_CHANCE, iMissChanceType, 2);
    return EffectMissChance(iPercentage, iMissChanceType);
}

effect JXEffectDisappearAppear(location lLocation, int iAnimation=1)
{
    return EffectDisappearAppear(lLocation, iAnimation);
}

effect JXEffectDisappear(int iAnimation=1)
{
    return EffectDisappear(iAnimation);
}

effect JXEffectAppear(int iAnimation=1)
{
    return EffectAppear(iAnimation);
}

effect JXEffectModifyAttacks(int iAttacks)
{
    iAttacks = JXImplApplyEffectParamModifier_Int(JX_EFFECT_MODIFY_ATTACKS, iAttacks, 1);
    return EffectModifyAttacks(iAttacks);
}

effect JXEffectDamageShield(int iDamageAmount, int iRandomAmount, int iDamageType)
{
    iDamageAmount = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_SHIELD, iDamageAmount, 1);
    iRandomAmount = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_SHIELD, iRandomAmount, 2);
    iDamageType = JXImplApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_SHIELD, iDamageType, 3);
    return EffectDamageShield(iDamageAmount, iRandomAmount, iDamageType);
}

effect JXEffectSwarm(int bLooping, string sCreatureTemplate1, string sCreatureTemplate2="", string sCreatureTemplate3="", string sCreatureTemplate4="")
{
    bLooping = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SWARM, bLooping, 1);
    sCreatureTemplate1 = JXImplApplyEffectParamModifier_String(JX_EFFECT_SWARM, sCreatureTemplate1, 2);
    sCreatureTemplate2 = JXImplApplyEffectParamModifier_String(JX_EFFECT_SWARM, sCreatureTemplate2, 3);
    sCreatureTemplate3 = JXImplApplyEffectParamModifier_String(JX_EFFECT_SWARM, sCreatureTemplate3, 4);
    sCreatureTemplate4 = JXImplApplyEffectParamModifier_String(JX_EFFECT_SWARM, sCreatureTemplate4, 5);

    return EffectSwarm(bLooping, sCreatureTemplate1, sCreatureTemplate2, sCreatureTemplate3, sCreatureTemplate4);
}

effect JXEffectTurnResistanceDecrease(int iHitDice)
{
    iHitDice = JXImplApplyEffectParamModifier_Int(JX_EFFECT_TURN_RESISTANCE_DECREASE, iHitDice, 1);
    return EffectTurnResistanceDecrease(iHitDice);
}

effect JXEffectTurnResistanceIncrease(int iHitDice)
{
    iHitDice = JXImplApplyEffectParamModifier_Int(JX_EFFECT_TURN_RESISTANCE_INCREASE, iHitDice, 1);
    return EffectTurnResistanceIncrease(iHitDice);
}

effect JXEffectPetrify()
{
    return EffectPetrify();
}

effect JXEffectSpellFailure(int iPercent=100, int iSpellSchool=SPELL_SCHOOL_GENERAL)
{
    iPercent = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_FAILURE, iPercent, 1);
    iSpellSchool = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SPELL_FAILURE, iSpellSchool, 2);
    return EffectSpellFailure(iPercent, iSpellSchool);
}

effect JXEffectEthereal()
{
    return EffectEthereal();
}

effect JXEffectDetectUndead()
{
    return EffectDetectUndead();
}

effect JXEffectLowLightVision()
{
    return EffectLowLightVision();
}

effect JXEffectSetScale(float fScaleX, float fScaleY=-1.0, float fScaleZ=-1.0)
{
    fScaleX = JXImplApplyEffectParamModifier_Float(JX_EFFECT_SET_SCALE, fScaleX, 1);
    fScaleY = JXImplApplyEffectParamModifier_Float(JX_EFFECT_SET_SCALE, fScaleY, 2);
    fScaleZ = JXImplApplyEffectParamModifier_Float(JX_EFFECT_SET_SCALE, fScaleZ, 3);
    return EffectSetScale(fScaleX, fScaleY, fScaleZ);
}

effect JXEffectShareDamage(object oHelper, int iAmountShared=50, int iAmountCasterShared=50)
{
    oHelper = JXImplApplyEffectParamModifier_Object(JX_EFFECT_SHARE_DAMAGE, oHelper, 1);
    iAmountShared = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SHARE_DAMAGE, iAmountShared, 2);
    iAmountCasterShared = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SHARE_DAMAGE, iAmountCasterShared, 3);
    return EffectShareDamage(oHelper, iAmountShared, iAmountCasterShared);
}

effect JXEffectAssayResistance(object oTarget)
{
    oTarget = JXImplApplyEffectParamModifier_Object(JX_EFFECT_ASSAY_RESISTANCE, oTarget, 1);
    return EffectAssayResistance(oTarget);
}

effect JXEffectSeeTrueHPs()
{
    return EffectSeeTrueHPs();
}

effect JXEffectAbsorbDamage(int iACTest)
{
    iACTest = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ABSORB_DAMAGE, iACTest, 1);
    return EffectAbsorbDamage(iACTest);
}

effect JXEffectHideousBlow(int iMetamagic)
{
    iMetamagic = JXImplApplyEffectParamModifier_Int(JX_EFFECT_HIDEOUS_BLOW, iMetamagic, 1);
    return EffectHideousBlow(iMetamagic);
}

effect JXEffectMesmerize(int iBreakFlags, float fBreakDist = 0.0f)
{
    iBreakFlags = JXImplApplyEffectParamModifier_Int(JX_EFFECT_MESMERIZE, iBreakFlags, 1);
    fBreakDist = JXImplApplyEffectParamModifier_Float(JX_EFFECT_MESMERIZE, fBreakDist, 2);
    return EffectMesmerize(iBreakFlags, fBreakDist);
}

effect JXEffectDarkVision()
{
    return EffectDarkVision();
}

effect JXEffectArmorCheckPenaltyIncrease(object oTarget, int iPenalty)
{
    oTarget = JXImplApplyEffectParamModifier_Object(JX_EFFECT_ARMOR_CHECK_PENALTY_INCREASE, oTarget, 1);
    iPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ARMOR_CHECK_PENALTY_INCREASE, iPenalty, 2);
    return EffectArmorCheckPenaltyIncrease(oTarget, iPenalty);
}

effect JXEffectDisintegrate(object oTarget)
{
    oTarget = JXImplApplyEffectParamModifier_Object(JX_EFFECT_DESINTEGRATE, oTarget, 1);
    return EffectDisintegrate(oTarget);
}

effect JXEffectHealOnZeroHP(object oTarget, int iDmgToHeal)
{
    oTarget = JXImplApplyEffectParamModifier_Object(JX_EFFECT_HEAL_ON_ZERO_HP, oTarget, 1);
    iDmgToHeal = JXImplApplyEffectParamModifier_Int(JX_EFFECT_HEAL_ON_ZERO_HP, iDmgToHeal, 2);
    return EffectHealOnZeroHP(oTarget, iDmgToHeal);
}

effect JXEffectBreakEnchantment(int iLevel)
{
    iLevel = JXImplApplyEffectParamModifier_Int(JX_EFFECT_BREAK_ENCHANTMENT, iLevel, 1);
    return EffectBreakEnchantment(iLevel);
}

effect JXEffectBonusHitpoints(int iHitpoints)
{
    iHitpoints = JXImplApplyEffectParamModifier_Int(JX_EFFECT_BONUS_HITPOINTS, iHitpoints, 1);
    return EffectBonusHitpoints(iHitpoints);
}

effect JXEffectBardSongSinging(int iSpellId)
{
    // NOTE: probably not necessary
    iSpellId = JXImplApplyEffectParamModifier_Int(JX_EFFECT_BARD_SONG_SINGING, iSpellId, 1);
    return EffectBardSongSinging(iSpellId);
}

effect JXEffectJarring()
{
    return EffectJarring();
}

effect JXEffectBABMinimum(int iBABMin)
{
    iBABMin = JXImplApplyEffectParamModifier_Int(JX_EFFECT_BAB_MINIMUM, iBABMin, 1);
    return EffectBABMinimum(iBABMin);
}

effect JXEffectMaxDamage()
{
    return EffectMaxDamage();
}

effect JXEffectArcaneSpellFailure(int iPercent)
{
    iPercent = JXImplApplyEffectParamModifier_Int(JX_EFFECT_ARCANE_SPELL_FAILURE, iPercent, 1);
    return EffectArcaneSpellFailure(iPercent);
}

effect JXEffectWildshape()
{
    return EffectWildshape();
}

effect JXEffectEffectIcon(int iEffectIconId)
{
    iEffectIconId = JXImplApplyEffectParamModifier_Int(JX_EFFECT_EFFECT_ICON, iEffectIconId, 1);
    return EffectEffectIcon(iEffectIconId);
}

effect JXEffectRescue(int iSpellId)
{
    return EffectRescue(iSpellId);
}

effect JXEffectDetectSpirits()
{
    return EffectDetectSpirits();
}

effect JXEffectDamageReductionNegated()
{
    return EffectDamageReductionNegated();
}

effect JXEffectConcealmentNegated()
{
    return EffectConcealmentNegated();
}

effect JXEffectInsane()
{
    return EffectInsane();
}

effect JXEffectSummonCopy(object oSource, int iVisualEffectId=VFX_NONE, float fDelaySeconds=0.0f, string sNewTag="", int iNewHP=0, string sScript="")
{
    oSource = JXImplApplyEffectParamModifier_Object(JX_EFFECT_SUMMON_COPY, oSource, 1);
    iVisualEffectId = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SUMMON_COPY, iVisualEffectId, 2);
    fDelaySeconds = JXImplApplyEffectParamModifier_Float(JX_EFFECT_SUMMON_COPY, fDelaySeconds, 3);
    sNewTag = JXImplApplyEffectParamModifier_String(JX_EFFECT_SUMMON_COPY, sNewTag, 4);
    iNewHP = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SUMMON_COPY, iNewHP, 5);
    sScript = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SUMMON_COPY, sScript, 6);
    return EffectSummonCopy(oSource, iVisualEffectId, fDelaySeconds, sNewTag, iNewHP, sScript);
}

//=============================================================
// Cutscene Effects
//=============================================================

// for compatibility only
effect JXEffectCutsceneParalyze()
{
    return EffectCutsceneParalyze();
}

effect JXEffectCutsceneDominated()
{
    return EffectCutsceneDominated();
}

effect JXEffectCutsceneImmobilize()
{
    return EffectCutsceneImmobilize();
}

effect JXEffectCutsceneGhost()
{
    return EffectCutsceneGhost();
}

//===============================================================
// Effects using action parameters
//===============================================================

// impossible to implement as user defined functions
// cant use action type arguments
/* effect JXEffectDispelMagicAll(int iCasterLevel, action aOnDispelEffect ) */
/* effect JXEffectDispelMagicBest(int iCasterLevel, action aOnDispelEffect ); */
/* effect JXEffectOnDispel( float fDelay, action aOnDispelEffect ); */

//===========================================================
// SPECIAL EFFECT FUNCTIONS
//===========================================================


effect JXEffectAreaOfEffect(int iAreaEffectId, string sOnEnterScript="", string sHeartbeatScript="", string sOnExitScript="", string sEffectTag="" )
{
    return EffectAreaOfEffect(iAreaEffectId, sOnEnterScript, sHeartbeatScript, sOnExitScript, sEffectTag);
}


effect JXEffectVisualEffect(int iVisualEffectId, int bMissEffect=FALSE)
{
    return EffectVisualEffect(iVisualEffectId, bMissEffect);
}

effect JXEffectBeam(int iBeamVisualEffect, object oEffector, int iBodyPart, int bMissEffect=FALSE)
{
    return EffectBeam(iBeamVisualEffect, oEffector, iBodyPart, bMissEffect);
}


//=====================================================
// SIMULATED EFFECTS
//=====================================================

//simulates shaken effect
effect JXEffectShaken(int iAttackPenalty=2, int iSavePenalty=2, int iSkillPenalty=2)
{
    iAttackPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SHAKEN, iAttackPenalty, 1);
    iSavePenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SHAKEN, iSavePenalty, 2);
    iSkillPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SHAKEN, iSkillPenalty, 3);

    effect eAttackPen = EffectAttackDecrease(iAttackPenalty, ATTACK_BONUS_MISC);
    effect eSavePen = EffectSavingThrowDecrease(SAVING_THROW_TYPE_FEAR, iSavePenalty, SAVING_THROW_TYPE_ALL);
    effect eSkillPen = EffectSkillDecrease(SKILL_ALL_SKILLS, iSkillPenalty);

    effect eShakenLink = EffectLink3Effects(eAttackPen, eSavePen, eSkillPen);
    return eShakenLink;
}

effect JXEffectSickened(int iAttackPenalty=2,
                        int iDamagePenalty=2,
                        int iSavePenalty=2,
                        int iSkillPenalty=2)
{
    iAttackPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SICKENED, iAttackPenalty, 1);
    iDamagePenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SICKENED, iDamagePenalty, 2);
    iSavePenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SICKENED, iSavePenalty, 3);
    iSkillPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_SICKENED, iSkillPenalty, 4);


    effect eAttackPenalty = EffectAttackDecrease(iAttackPenalty);
    effect eDamagePenalty = EffectDamageDecrease(iDamagePenalty);
    effect eSavePenalty = EffectSavingThrowDecrease(SAVING_THROW_ALL, iSavePenalty);
    effect eSkillPenalty = EffectSkillDecrease(SKILL_ALL_SKILLS, iSkillPenalty);

    effect eRet = EffectLink4Effects(
        eAttackPenalty,
        eDamagePenalty,
        eSavePenalty,
        eSkillPenalty);
    return eRet;
}

effect JXEffectFatigued(int iStrPenalty=2, int iDexPenalty=2, int iMovePenalty=10)
{
    iStrPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_FATIGUED, iStrPenalty, 1);
    iDexPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_FATIGUED, iDexPenalty, 2);
    iMovePenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_FATIGUED, iMovePenalty, 3);

    effect eStrPenalty = EffectAbilityDecrease(ABILITY_STRENGTH, iStrPenalty);
    effect eDexPenalty = EffectAbilityDecrease(ABILITY_DEXTERITY, iDexPenalty);
    effect eMovePenalty = EffectMovementSpeedDecrease(iMovePenalty);

    effect eRet = EffectLink3Effects(
        eStrPenalty,
        eDexPenalty,
        eMovePenalty);
    return eRet;
}

effect JXEffectExhausted(int iStrPenalty=6, int iDexPenalty=6, int iMovePenalty=50)
{
    iStrPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_EXHAUSTED, iStrPenalty, 1);
    iDexPenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_EXHAUSTED, iDexPenalty, 2);
    iMovePenalty = JXImplApplyEffectParamModifier_Int(JX_EFFECT_EXHAUSTED, iMovePenalty, 3);

    effect eStrPenalty = EffectAbilityDecrease(ABILITY_STRENGTH, iStrPenalty);
    effect eDexPenalty = EffectAbilityDecrease(ABILITY_DEXTERITY, iDexPenalty);
    effect eMovePenalty = EffectMovementSpeedDecrease(iMovePenalty);

    effect eRet = EffectLink3Effects(
        eStrPenalty,
        eDexPenalty,
        eMovePenalty);
    return eRet;
}

// for compatibility atp.
effect JXEffectLinkEffects(effect e1, effect e2)
{
    return EffectLinkEffects(e1, e2);
}
