#include "utils"


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
effect JXEffectShaken();

effect JXEffectSickened();

effect JXEffectFatigue();

effect JXEffectExhausted();



//=========================================================
// UTILITY FUNCTIONS
//=========================================================

effect JXEffectLinkEffects(effect e1, effect e2);

effect JXEffectLink3Effects(effect e1, effect e2, effect e3);

effect JXEffectLink4Effects(effect e1, effect e2, effect e3, effect e4);

effect JXEffectLink5Effects(effect e1, effect e2, effect e3, effect e4, effect e5);

effect JXEffectLink6Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6);

effect JXEffectLink7Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7);

effect JXEffectLink8Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7, effect e8);

effect JXEffectLink9Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7, effect e8, effect e9);

effect JXEffectLink10Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7, effect e8, effect e9, effect e10);

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
    iDmgToHeal = JXApplyEffectParamModifier_Int(JX_EFFECT_HEAL, iDmgToHeal, 1);
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
    iDmg = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, iDmg, 1);
    iDmgType = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, iDmgType, 2);
    iDmgPower = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, iDmgPower, 3);
    bIgnoreRes = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE, bIgnoreRes, 4);
    eMain = EffectDamage(iDmg, iDmgType, iDmgPower, bIgnoreRes);
    return eMain;
}


//=====================================================
// EffectDamageOverTime
//=======================================================


effect JXEffectDamageOverTime(int iDmg, float fInterval, int iDmgType=DAMAGE_TYPE_MAGICAL, int bIgnoreResistances=FALSE)
{
    effect eMain;
    iDmg = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_OVER_TIME, iDmg, 1);
    fInterval = JXApplyEffectParamModifier_Float(JX_EFFECT_DAMAGE_OVER_TIME, fInterval, 2);
    iDmgType = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_OVER_TIME, iDmgType, 3);
    bIgnoreResistances = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_OVER_TIME, bIgnoreResistances, 4);
    eMain = EffectDamageOverTime(iDmg, fInterval, iDmgType, bIgnoreResistances);
    return eMain;
}


//=============================================================
// EffectAbilityIncrease
//=============================================================

effect JXEffectAbilityIncrease(int iAbility, int iModifyBy)
{
    effect eMain;
    iAbility = JXApplyEffectParamModifier_Int(JX_EFFECT_ABILITY_INCREASE, iAbility, 1);
    iModifyBy = JXApplyEffectParamModifier_Int(JX_EFFECT_ABILITY_INCREASE, iModifyBy, 2);
    eMain = EffectAbilityIncrease(iAbility, iModifyBy);
    return eMain;
}

effect JXEffectDamageResistance(int iDamageType, int iAmount, int iLimit=0)
{
    effect eMain;
    iDamageType = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_RESISTANCE, iDamageType, 1);
    iAmount = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_RESISTANCE, iAmount, 2);
    iLimit = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_RESISTANCE, iLimit, 3);
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
    sCreatureResref = JXApplyEffectParamModifier_String(JX_EFFECT_SUMMON_CREATURE, sCreatureResref, 1);
    iVisualEffectId = JXApplyEffectParamModifier_Int(JX_EFFECT_SUMMON_CREATURE, iVisualEffectId, 2);
    fDelay = JXApplyEffectParamModifier_Float(JX_EFFECT_SUMMON_CREATURE, fDelay, 3);
    iUseAppearAnimation = JXApplyEffectParamModifier_Int(JX_EFFECT_SUMMON_CREATURE, iUseAppearAnimation, 4);
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
    iValue = JXApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iValue, 1);
    iModifyType = JXApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iModifyType, 2);
    iDamageType = JXApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iDamageType, 3);
    iVsSpiritsOnly = JXApplyEffectParamModifier_Int(JX_EFFECT_AC_INCREASE, iVsSpiritsOnly, 4);
    eMain = EffectACIncrease(iValue, iModifyType, iDamageType, iVsSpiritsOnly);
    return eMain;
}

effect JXEffectSavingThrowIncrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL, int iVsSpiritsOnly=FALSE)
{
    effect eMain;
    iSave = JXApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_INCREASE, iSave, 1);
    iValue = JXApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_INCREASE, iValue, 2);
    iVsSpiritsOnly = JXApplyEffectParamModifier_Int(JX_EFFECT_SAVING_THROW_INCREASE, iVsSpiritsOnly, 3);
    eMain = EffectSavingThrowIncrease(iSave, iValue, iSaveType, iVsSpiritsOnly);
    return eMain;
}

effect JXEffectAttackIncrease(int iBonus, int iModifierType=ATTACK_BONUS_MISC)
{
    effect eMain;
    iBonus = JXApplyEffectParamModifier_Int(JX_EFFECT_ATTACK_INCREASE, iBonus, 1);
    iModifierType = JXApplyEffectParamModifier_Int(JX_EFFECT_ATTACK_INCREASE, iModifierType, 2);
    eMain = EffectAttackIncrease (iBonus, iModifierType);
    return eMain;
}

effect JXEffectDamageReduction(int iAmount, int iDmgPower=DAMAGE_POWER_NORMAL, int iLimit=0, int iDRType=DR_TYPE_MAGICBONUS)
{
    effect eMain;
    iAmount = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iAmount, 1);
    iDmgPower = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iDmgPower, 2);
    iLimit = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iLimit, 3);
    iDRType = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_REDUCTION, iDRType, 4);
    eMain = EffectDamageReduction (iAmount, iDmgPower, iLimit, iDRType);
    return eMain;
}

effect JXEffectDamageIncrease(int iBonus, int iDamageType=DAMAGE_TYPE_MAGICAL, int iVersusRace=-1)
{
    effect eMain;
    iBonus = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_INCREASE, iBonus, 1);
    iDamageType = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_INCREASE, iDamageType, 2);
    iVersusRace = JXApplyEffectParamModifier_Int(JX_EFFECT_DAMAGE_INCREASE, iVersusRace, 3);
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
    iSpectacularDeath = JXApplyEffectParamModifier_Int(JX_EFFECT_DEATH, iSpectacularDeath, 1);
    iDisplayFeedback = JXApplyEffectParamModifier_Int(JX_EFFECT_DEATH, iDisplayFeedback, 2);
    iIgnoreDeathImmunity = JXApplyEffectParamModifier_Int(JX_EFFECT_DEATH, iIgnoreDeathImmunity, 3);
    eMain = EffectDeath (iSpectacularDeath, iDisplayFeedback, iIgnoreDeathImmunity, iPurgeEffects);
    return eMain;
}

effect JXEffectKnockdown()
{
    return EffectKnockdown();
}

effect JXEffectCurse(int iStrMod=1, int iDexMod=1, int iConMod=1, int iIntMod=1, int iWisMod=1, int iChaMod=1)
{
    return EffectCurse(iStrMod, iDexMod, iConMod, iIntMod, iWisMod, iChaMod);
}

effect JXEffectParalyze(int iSaveDC=-1, int iSave=SAVING_THROW_WILL, int iSaveEveryRound = TRUE)
{
    return EffectParalyze(iSaveDC, iSave, iSaveEveryRound);
}

effect JXEffectSpellImmunity(int iImmunityToSpell=SPELL_ALL_SPELLS)
{
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
    return EffectRegenerate(iAmount, fIntervalSeconds);
}

effect JXEffectMovementSpeedIncrease(int iPercentChange)
{
    return EffectMovementSpeedIncrease(iPercentChange);
}

effect JXEffectSpellResistanceIncrease(int iValue, int iUses=-1)
{
    return EffectSpellResistanceIncrease(iValue, iUses);
}

effect JXEffectPoison(int iPoisonType)
{
    return EffectPoison(iPoisonType);
}

effect JXEffectDisease(int iDiseaseType)
{
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
    return EffectImmunity(iImmunityType);
}

effect JXEffectDamageImmunityIncrease(int iDamageType, int iPercentImmunity)
{
    return EffectDamageImmunityIncrease(iDamageType, iPercentImmunity);
}

effect JXEffectTemporaryHitpoints(int iHitPoints)
{
    return EffectTemporaryHitpoints(iHitPoints);
}

effect JXEffectSkillIncrease(int iSkill, int iValue)
{
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
    return EffectHitPointChangeWhenDying(fHitPointChangePerRound);
}

effect JXEffectAbilityDecrease(int iAbility, int iModifyBy)
{
    return EffectAbilityDecrease(iAbility, iModifyBy);
}

effect JXEffectAttackDecrease(int iPenalty, int iModifierType=ATTACK_BONUS_MISC)
{
    return EffectAttackDecrease(iPenalty, iModifierType);
}

effect JXEffectDamageDecrease(int iPenalty, int iDamageType=DAMAGE_TYPE_MAGICAL)
{
    return EffectDamageDecrease(iPenalty, iDamageType);
}

effect JXEffectDamageImmunityDecrease(int iDamageType, int iPercentImmunity)
{
    return EffectDamageImmunityDecrease(iDamageType, iPercentImmunity);
}

effect JXEffectACDecrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL)
{
    return EffectACDecrease(iValue, iModifyType, iDamageType);
}

effect JXEffectMovementSpeedDecrease(int iPercentChange)
{
    return EffectMovementSpeedDecrease(iPercentChange);
}

effect JXEffectSavingThrowDecrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL)
{
    return EffectSavingThrowDecrease(iSave, iValue, iSaveType);
}

effect JXEffectSkillDecrease(int iSkill, int iValue)
{
    return EffectSkillDecrease(iSkill, iValue);
}

effect JXEffectSpellResistanceDecrease(int iValue)
{
    return EffectSpellResistanceDecrease(iValue);
}

effect JXEffectInvisibility(int iInvisibilityType)
{
    return EffectInvisibility(iInvisibilityType);
}

effect JXEffectConcealment(int iPercentage, int iMissType=MISS_CHANCE_TYPE_NORMAL)
{
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
    return EffectNegativeLevel(iNumLevels, bHPBonus);
}

effect JXEffectPolymorph(int iPolymorphSelection, int bLocked=FALSE, int bWildshape=FALSE)
{
    return EffectPolymorph(iPolymorphSelection, bLocked, bWildshape);
}

effect JXEffectSanctuary(int iDifficultyClass)
{
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
    return EffectSpellLevelAbsorption(iMaxSpellLevelAbsorbed, iTotalSpellLevelsAbsorbed, iSpellSchool);
}

effect JXEffectMissChance(int iPercentage, int iMissChanceType=MISS_CHANCE_TYPE_NORMAL)
{
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
    return EffectModifyAttacks(iAttacks);
}

effect JXEffectDamageShield(int iDamageAmount, int iRandomAmount, int iDamageType)
{
    return EffectDamageShield(iDamageAmount, iRandomAmount, iDamageType);
}

effect JXEffectSwarm(int bLooping, string sCreatureTemplate1, string sCreatureTemplate2="", string sCreatureTemplate3="", string sCreatureTemplate4="")
{
    return EffectSwarm(bLooping, sCreatureTemplate1, sCreatureTemplate2, sCreatureTemplate3, sCreatureTemplate4);
}

effect JXEffectTurnResistanceDecrease(int iHitDice)
{
    return EffectTurnResistanceDecrease(iHitDice);
}

effect JXEffectTurnResistanceIncrease(int iHitDice)
{
    return EffectTurnResistanceIncrease(iHitDice);
}

effect JXEffectPetrify()
{
    return EffectPetrify();
}

effect JXEffectSpellFailure(int iPercent=100, int iSpellSchool=SPELL_SCHOOL_GENERAL)
{
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
    return EffectSetScale(fScaleX, fScaleY, fScaleZ);
}

effect JXEffectShareDamage(object oHelper, int iAmountShared=50, int iAmountCasterShared=50)
{
    return EffectShareDamage(oHelper, iAmountShared, iAmountCasterShared);
}

effect JXEffectAssayResistance(object oTarget)
{
    return EffectAssayResistance(oTarget);
}

effect JXEffectSeeTrueHPs()
{
    return EffectSeeTrueHPs();
}

effect JXEffectAbsorbDamage(int iACTest)
{
    return EffectAbsorbDamage(iACTest);
}

effect JXEffectHideousBlow(int iMetamagic)
{
    return EffectHideousBlow(iMetamagic);
}

effect JXEffectMesmerize(int iBreakFlags, float fBreakDist = 0.0f)
{
    return EffectMesmerize(iBreakFlags, fBreakDist);
}

effect JXEffectDarkVision()
{
    return EffectDarkVision();
}

effect JXEffectArmorCheckPenaltyIncrease(object oTarget, int iPenalty)
{
    return EffectArmorCheckPenaltyIncrease(oTarget, iPenalty);
}

effect JXEffectDisintegrate(object oTarget)
{
    return EffectDisintegrate(oTarget);
}

effect JXEffectHealOnZeroHP(object oTarget, int iDmgToHeal)
{
    return EffectHealOnZeroHP(oTarget, iDmgToHeal);
}

effect JXEffectBreakEnchantment(int iLevel)
{
    return EffectBreakEnchantment(iLevel);
}

effect JXEffectBonusHitpoints(int iHitpoints)
{
    return EffectBonusHitpoints(iHitpoints);
}

effect JXEffectBardSongSinging(int iSpellId)
{
    return EffectBardSongSinging(iSpellId);
}

effect JXEffectJarring()
{
    return EffectJarring();
}

effect JXEffectBABMinimum(int iBABMin)
{
    return EffectBABMinimum(iBABMin);
}

effect JXEffectMaxDamage()
{
    return EffectMaxDamage();
}

effect JXEffectArcaneSpellFailure(int iPercent)
{
    return EffectArcaneSpellFailure(iPercent);
}

effect JXEffectWildshape()
{
    return EffectWildshape();
}

effect JXEffectEffectIcon(int iEffectIconId)
{
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
effect JXEffectShaken()
{
    effect eAttackPen = EffectAttackDecrease(2, ATTACK_BONUS_MISC);
    effect eSavePen = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_ALL);
    effect eSkillPen = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);
    effect eShakenLink = EffectLinkEffects(eAttackPen, eSavePen);
    eShakenLink = EffectLinkEffects(eShakenLink, eSkillPen);
    return eShakenLink;
}

effect JXEffectSickened()
{
    effect eAttackPenalty = EffectAttackDecrease(2);
    effect eDamagePenalty = EffectDamageDecrease(2);
    effect eSavePenalty = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2);
    effect eSkillPenalty = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);
    //effect eAbilityPenalty = EffectAbilityDecrease(, 2);

    effect eRet = EffectLinkEffects (eAttackPenalty, eDamagePenalty);
    eRet = EffectLinkEffects(eRet, eSavePenalty);
    eRet = EffectLinkEffects(eRet, eSkillPenalty);
    eRet = ExtraordinaryEffect(eRet);
    return (eRet);
}

effect JXEffectFatigue()
{
    // Create the fatigue penalty
    effect eStrPenalty = EffectAbilityDecrease(ABILITY_STRENGTH, 2);
    effect eDexPenalty = EffectAbilityDecrease(ABILITY_DEXTERITY, 2);
    effect eMovePenalty = EffectMovementSpeedDecrease(10);  // 10% decrease

    effect eRet = EffectLinkEffects (eStrPenalty, eDexPenalty);
    eRet = EffectLinkEffects(eRet, eMovePenalty);
    eRet = ExtraordinaryEffect(eRet);
    return (eRet);
}

effect JXEffectExhausted()
{
    effect eStrPenalty = EffectAbilityDecrease(ABILITY_STRENGTH, 6);
    effect eDexPenalty = EffectAbilityDecrease(ABILITY_DEXTERITY, 6);
    effect eMovePenalty = EffectMovementSpeedDecrease(50);  // 50% decrease

    effect eRet = EffectLinkEffects (eStrPenalty, eDexPenalty);
    eRet = EffectLinkEffects(eRet, eMovePenalty);
    eRet = ExtraordinaryEffect(eRet);
    return (eRet);
}

// for compatibility atp.
effect JXEffectLinkEffects(effect e1, effect e2)
{
    return EffectLinkEffects(e1, e2);
}

effect JXEffectLink3Effects(effect e1, effect e2, effect e3)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    return e1;
}

effect JXEffectLink4Effects(effect e1, effect e2, effect e3, effect e4)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    e1 = EffectLinkEffects(e1, e4);
    return e1;
}

effect JXEffectLink5Effects(effect e1, effect e2, effect e3, effect e4, effect e5)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    e1 = EffectLinkEffects(e1, e4);
    e1 = EffectLinkEffects(e1, e5);
    return e1;
}

effect JXEffectLink6Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    e1 = EffectLinkEffects(e1, e4);
    e1 = EffectLinkEffects(e1, e5);
    e1 = EffectLinkEffects(e1, e6);
    return e1;
}

effect JXEffectLink7Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    e1 = EffectLinkEffects(e1, e4);
    e1 = EffectLinkEffects(e1, e5);
    e1 = EffectLinkEffects(e1, e6);
    e1 = EffectLinkEffects(e1, e7);
    return e1;
}

effect JXEffectLink8Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7, effect e8)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    e1 = EffectLinkEffects(e1, e4);
    e1 = EffectLinkEffects(e1, e5);
    e1 = EffectLinkEffects(e1, e6);
    e1 = EffectLinkEffects(e1, e7);
    e1 = EffectLinkEffects(e1, e8);
    return e1;
}

effect JXEffectLink9Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7, effect e8, effect e9)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    e1 = EffectLinkEffects(e1, e4);
    e1 = EffectLinkEffects(e1, e5);
    e1 = EffectLinkEffects(e1, e6);
    e1 = EffectLinkEffects(e1, e7);
    e1 = EffectLinkEffects(e1, e8);
    e1 = EffectLinkEffects(e1, e9);
    return e1;
}

effect JXEffectLink10Effects(effect e1, effect e2, effect e3, effect e4, effect e5, effect e6, effect e7, effect e8, effect e9, effect e10)
{
    e1 = EffectLinkEffects(e1, e2);
    e1 = EffectLinkEffects(e1, e3);
    e1 = EffectLinkEffects(e1, e4);
    e1 = EffectLinkEffects(e1, e5);
    e1 = EffectLinkEffects(e1, e6);
    e1 = EffectLinkEffects(e1, e7);
    e1 = EffectLinkEffects(e1, e8);
    e1 = EffectLinkEffects(e1, e9);
    e1 = EffectLinkEffects(e1, e10);
    return e1;
}

int JXApplyEffectParamModifier_Int(int iJXEffectType, int iValue, int iParamPos=1)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iJXEffectType);
    // paramList = JXScriptAddParameterInt(paramList, iValue);
    // paramList = JXScriptAddParameterInt(paramList, iParamPos);
    //
    // JXScriptCallFork(JX_EFFECT_FORKSCRIPT, JX_FORK_EFFECT_PARAM_MOD_INT, paramList);

    AddScriptParameterInt(iJXEffectType);
    AddScriptParameterInt(iValue);
    AddScriptParameterInt(iParamPos);
    ExecuteScriptEnhanced(JX_EFFECT_PARAM_MOD_INT_FORKSCRIPT, OBJECT_SELF);

    return JXScriptGetResponseInt();
}

float JXApplyEffectParamModifier_Float(int iJXEffectType, float fValue, int iParamPos=1)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iJXEffectType);
    // paramList = JXScriptAddParameterFloat(paramList, fValue);
    // paramList = JXScriptAddParameterInt(paramList, iParamPos);
    //
    // JXScriptCallFork(JX_EFFECT_FORKSCRIPT, JX_FORK_EFFECT_PARAM_MOD_FLOAT, paramList);

    AddScriptParameterInt(iJXEffectType);
    AddScriptParameterFloat(fValue);
    AddScriptParameterInt(iParamPos);
    ExecuteScriptEnhanced(JX_EFFECT_PARAM_MOD_FLOAT_FORKSCRIPT, OBJECT_SELF);

    return JXScriptGetResponseFloat();
}

string JXApplyEffectParamModifier_String(int iJXEffectType, string sValue, int iParamPos=1)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iJXEffectType);
    // paramList = JXScriptAddParameterString(paramList, sValue);
    // paramList = JXScriptAddParameterInt(paramList, iParamPos);
    //
    // JXScriptCallFork(JX_EFFECT_FORKSCRIPT, JX_FORK_EFFECT_PARAM_MOD_STRING, paramList);

    AddScriptParameterInt(iJXEffectType);
    AddScriptParameterString(sValue);
    AddScriptParameterInt(iParamPos);
    ExecuteScriptEnhanced(JX_EFFECT_PARAM_MOD_STRING_FORKSCRIPT, OBJECT_SELF);

    return JXScriptGetResponseString();
}

object JXApplyEffectParamModifier_Object(int iJXEffectType, object oValue, int iParamPos=1)
{
    // struct script_param_list paramList;
    // paramList = JXScriptAddParameterInt(paramList, iJXEffectType);
    // paramList = JXScriptAddParameterObject(paramList, oValue);
    // paramList = JXScriptAddParameterInt(paramList, iParamPos);
    //
    // JXScriptCallFork(JX_EFFECT_FORKSCRIPT, JX_FORK_EFFECT_PARAM_MOD_STRING, paramList);

    AddScriptParameterInt(iJXEffectType);
    AddScriptParameterObject(oValue);
    AddScriptParameterInt(iParamPos);
    ExecuteScriptEnhanced(JX_EFFECT_PARAM_MOD_OBJECT_FORKSCRIPT, OBJECT_SELF);

    return JXScriptGetResponseObject();
}
