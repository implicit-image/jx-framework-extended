#include "jx_inc_magic_effects_info"


struct jx_effect JXEffectHeal(int iDmgToHeal);

struct jx_effect JXEffectDamage(int iDmg, int iDmgType=DAMAGE_TYPE_MAGICAL, int iDamagePower=DAMAGE_POWER_NORMAL, int bIgnoreRes=FALSE);

struct jx_effect JXEffectDamageOverTime(int iDmg, float fInterval, int iDmgType=DAMAGE_TYPE_MAGICAL, int iIgnoreResistances=FALSE);

struct jx_effect JXEffectAbilityIncrease(int iAbility, int iModifyBy);

struct jx_effect JXEffectDamageResistance(int iDamageType, int iAmount, int iLimit=0);

struct jx_effect JXEffectResurrection();

struct jx_effect JXEffectSummonCreature(string sCreatureResref, int iVisualEffectId=VFX_NONE, float fDelay=0.0f, int iUseAppearAnimation=0);

struct jx_effect JXMagicalEffect(effect eEffect);

struct jx_effect JXSupernaturalEffect(effect eEffect);

struct jx_effect JXExtraordinaryEffect(effect eEffect);

struct jx_effect JXEffectACIncrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL, int iVsSpiritsOnly=FALSE);

struct jx_effect JXEffectSavingThrowIncrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL, int iVsSpiritsOnly=FALSE);

struct jx_effect JXEffectAttackIncrease(int iBonus, int iModifierType=ATTACK_BONUS_MISC);

struct jx_effect JXEffectDamageReduction(int iAmount, int iDRSubType=DAMAGE_POWER_NORMAL, int iLimit=0, int iDRType=DR_TYPE_MAGICBONUS);

struct jx_effect JXEffectDamageIncrease(int iBonus, int iDamageType=DAMAGE_TYPE_MAGICAL, int iVersusRace=-1);

struct jx_effect JXEffectEntangle();

struct jx_effect JXEffectDeath(int iSpectacularDeath=FALSE, int iDisplayFeedback=TRUE, int iIgnoreDeathImmunity=FALSE, int iPurgeEffects=TRUE);

struct jx_effect JXEffectKnockdown();

struct jx_effect JXEffectCurse(int iStrMod=1, int iDexMod=1, int iConMod=1, int iIntMod=1, int iWisMod=1, int iChaMod=1);

struct jx_effect JXEffectParalyze(int iSaveDC=-1, int iSave=SAVING_THROW_WILL, int iSaveEveryRound = TRUE);

struct jx_effect JXEffectSpellImmunity(int iImmunityToSpell=SPELL_ALL_SPELLS);

struct jx_effect JXEffectDeaf();

struct jx_effect JXEffectSleep();

struct jx_effect JXEffectCharmed();

struct jx_effect JXEffectConfused();

struct jx_effect JXEffectFrightened();

struct jx_effect JXEffectDominated();

struct jx_effect JXEffectDazed();

struct jx_effect JXEffectStunned();

struct jx_effect JXEffectRegenerate(int iAmount, float fIntervalSeconds);

struct jx_effect JXEffectMovementSpeedIncrease(int iPercentChange);

struct jx_effect JXEffectSpellResistanceIncrease(int iValue, int iUses = -1);

struct jx_effect JXEffectPoison(int iPoisonType);

struct jx_effect JXEffectDisease(int iDiseaseType);

struct jx_effect JXEffectSilence();

struct jx_effect JXEffectHaste();

struct jx_effect JXEffectSlow();

struct jx_effect JXEffectImmunity(int iImmunityType);

struct jx_effect JXEffectDamageImmunityIncrease(int iDamageType, int iPercentImmunity);

struct jx_effect JXEffectTemporaryHitpoints(int iHitPoints);

struct jx_effect JXEffectSkillIncrease(int iSkill, int iValue);

struct jx_effect JXVersusAlignmentEffect(effect eEffect, int iLawChaos=ALIGNMENT_ALL, int iGoodEvil=ALIGNMENT_ALL);

struct jx_effect JXVersusRacialTypeEffect(effect eEffect, int iRacialType);

struct jx_effect JXVersusTrapEffect(effect eEffect);

struct jx_effect JXEffectTurned();

struct jx_effect JXEffectHitPointChangeWhenDying(float fHitPointChangePerRound);

struct jx_effect JXEffectAbilityDecrease(int iAbility, int iModifyBy);

struct jx_effect JXEffectAttackDecrease(int iPenalty, int iModifierType=ATTACK_BONUS_MISC);

struct jx_effect JXEffectDamageDecrease(int iPenalty, int iDamageType=DAMAGE_TYPE_MAGICAL);

struct jx_effect JXEffectDamageImmunityDecrease(int iDamageType, int iPercentImmunity);

struct jx_effect JXEffectACDecrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL);

struct jx_effect JXEffectMovementSpeedDecrease(int iPercentChange);

struct jx_effect JXEffectSavingThrowDecrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL);

struct jx_effect JXEffectSkillDecrease(int iSkill, int iValue);

struct jx_effect JXEffectSpellResistanceDecrease(int iValue);

struct jx_effect JXEffectInvisibility(int iInvisibilityType);

struct jx_effect JXEffectConcealment(int iPercentage, int iMissType=MISS_CHANCE_TYPE_NORMAL);

struct jx_effect JXEffectDarkness();

struct jx_effect JXEffectUltravision();

struct jx_effect JXEffectNegativeLevel(int iNumLevels, int bHPBonus=FALSE);

struct jx_effect JXEffectPolymorph(int iPolymorphSelection, int bLocked=FALSE, int bWildshape=FALSE);

struct jx_effect JXEffectSanctuary(int iDifficultyClass);

struct jx_effect JXEffectTrueSeeing();

struct jx_effect JXEffectSeeInvisible();

struct jx_effect JXEffectTimeStop();

struct jx_effect JXEffectBlindness();

struct jx_effect JXEffectSpellLevelAbsorption(int iMaxSpellLevelAbsorbed, int iTotalSpellLevelsAbsorbed=0, int iSpellSchool=SPELL_SCHOOL_GENERAL);

struct jx_effect JXEffectMissChance(int iPercentage, int iMissChanceType=MISS_CHANCE_TYPE_NORMAL);

struct jx_effect JXEffectModifyAttacks(int iAttacks);

struct jx_effect JXEffectDamageShield(int iDamageAmount, int iRandomAmount, int iDamageType);

struct jx_effect JXEffectSwarm(int bLooping, string sCreatureTemplate1, string sCreatureTemplate2="", string sCreatureTemplate3="", string sCreatureTemplate4="");

struct jx_effect JXEffectTurnResistanceDecrease(int iHitDice);

struct jx_effect JXEffectTurnResistanceIncrease(int iHitDice);

struct jx_effect JXEffectPetrify();

struct jx_effect JXEffectSpellFailure(int iPercent=100, int iSpellSchool=SPELL_SCHOOL_GENERAL);

struct jx_effect JXEffectEthereal();

struct jx_effect JXEffectDetectUndead();

struct jx_effect JXEffectLowLightVision();

struct jx_effect JXEffectSetScale(float fScaleX, float fScaleY=-1.0, float fScaleZ=-1.0);

struct jx_effect JXEffectShareDamage(object oHelper, int iAmountShared=50, int iAmountCasterShared=50);

struct jx_effect JXEffectAssayResistance(object oTarget);

struct jx_effect JXEffectSeeTrueHPs();

struct jx_effect JXEffectAbsorbDamage(int iACTest);

struct jx_effect JXEffectHideousBlow(int iMetamagic);

struct jx_effect JXEffectMesmerize(int iBreakFlags, float fBreakDist = 0.0f);

struct jx_effect JXEffectDarkVision();

struct jx_effect JXEffectArmorCheckPenaltyIncrease(object oTarget, int nPenalty);

struct jx_effect JXEffectDisintegrate(object oTarget);

struct jx_effect JXEffectHealOnZeroHP(object oTarget, int iDmgToHeal);

struct jx_effect JXEffectBreakEnchantment(int nLevel);

struct jx_effect JXEffectBonusHitpoints(int iHitpoints);

struct jx_effect JXEffectBardSongSinging(int iSpellId);

struct jx_effect JXEffectJarring();

struct jx_effect JXEffectBABMinimum(int nBABMin);

struct jx_effect JXEffectMaxDamage();

struct jx_effect JXEffectArcaneSpellFailure(int iPercent);

struct jx_effect JXEffectWildshape();

struct jx_effect JXEffectEffectIcon(int iEffectIconId);

struct jx_effect JXEffectRescue(int iSpellId);

struct jx_effect JXEffectDetectSpirits();

struct jx_effect JXEffectDamageReductionNegated();

struct jx_effect JXEffectConcealmentNegated();

struct jx_effect JXEffectInsane();

struct jx_effect JXEffectSummonCopy(object oSource, int iVisualEffectId=VFX_NONE, float fDelaySeconds=0.0f, string sNewTag="", int iNewHP=0, string sScript="");

//==============================================================
// Cutscene Effects
//==============================================================

struct jx_effect JXEffectCutsceneParalyze();

struct jx_effect JXEffectCutsceneDominated();

struct jx_effect JXEffectCutsceneImmobilize();

struct jx_effect JXEffectCutsceneGhost();

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


struct jx_effect JXEffectAreaOfEffect(int iAreaEffectId, string sOnEnterScript="", string sHeartbeatScript="", string sOnExitScript="", string sEffectTag="");

struct jx_effect JXEffectVisualEffect(int iVisualEffectId, int bMissEffect=FALSE);

struct jx_effect JXEffectBeam(int iBeamVisualEffect, object oEffector, int iBodyPart, int bMissEffect=FALSE);







//========================================== Implementation ====================================






struct jx_effect JXEffectHeal(int iDmgToHeal)
{
    JXStartEffectMod(JX_EFFECT_HEAL);

    effect eMain;
    struct jx_effect eRes;
    // if effect is disabled return empty effect
    if (JXIsEffectDisabled())
    {
        JXEndEffectMod();
        return eMain;
    }

    // apply param1 modifiers

    iDmgToHeal = JXApplyEffectParamModifiers_Int(iDmgToHeal, 1);

    eMain = EffectHeal(iDmgToHeal);

    eRes = JXMakeEffect(eMain, JX_EFFECT_HEAL);

    JXEndEffectMod();
    return eRes;
}


struct jx_effect JXEffectDamage(int iDmg, int iDmgType=DAMAGE_TYPE_MAGICAL, int iDamagePower=DAMAGE_POWER_NORMAL, int bIgnoreRes=FALSE)
{
    JXStartEffectMod(JX_EFFECT_DAMAGE);

    effect eMain;
    struct jx_effect eRes;

    if (JXIsEffectDisabled())
    {
        JXEndEffectMod();
        return eRes;
    }
    iDmg = JXApplyEffectParamModifiers_Int(iDmg, 1);
    iDmgType = JXApplyEffectParamModifiers_Int(iDmgType, 2);
    iDmgPower = JXApplyEffectParamModifiers_Int(iDmgPower, 3);
    bIgnoreRes = JXApplyEffectParamModifiers_Int(bIgnoreRes, 4);

    eMain = EffectDamage(iDmg, iDmgType, iDmgPower, bIgnoreRes);

    eRes = JXMakeEffect(eMain, JX_EFFECT_DAMAGE);

    JXEndEffectMod();
    return eMain;
}

struct jx_effect JXEffectDamageOverTime(int iDmg, float fInterval, int iDmgType=DAMAGE_TYPE_MAGICAL, int iIgnoreResistances=FALSE)
{
    JXStartEffectMod(JX_EFFECT_DAMAGE_OVER_TIME);

    effect eMain;
    struct jx_effect eRes;

    if (JXIsEffectDisabled())
    {
        JXEndEffectMod();
        return eRes;
    }
    iDmg = JXApplyEffectParamModifiers_Int(iDmg, 1);
    fInterval = JXApplyEffectParamModifiers_Float(fInterval, 2);
    iDmgType = JXApplyEffectParamModifiers_Int(iDmgType, 3);
    bIgnoreResistances = JXApplyEffectParamModifiers_Int(bIgnoreResistances, 4);

    eMain = EffectDamageOverTime(iDmg, fInterval, iDmgType, bIgnoreResistances);

    eRes = JXMakeEffect(eMain, JX_EFFECT_DAMAGE_OVER_TIME);

    JXEndEffectMod();
    return eRes;;
}

struct jx_effect JXEffectAbilityIncrease(int iAbility, int iModifyBy);

struct jx_effect JXEffectDamageResistance(int iDamageType, int iAmount, int iLimit=0);

struct jx_effect JXEffectResurrection();

struct jx_effect JXEffectSummonCreature(string sCreatureResref, int iVisualEffectId=VFX_NONE, float fDelay=0.0f, int iUseAppearAnimation=0);

struct jx_effect JXMagicalEffect(effect eEffect);

struct jx_effect JXSupernaturalEffect(effect eEffect);

struct jx_effect JXExtraordinaryEffect(effect eEffect);

struct jx_effect JXEffectACIncrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL, int iVsSpiritsOnly=FALSE);

struct jx_effect JXEffectSavingThrowIncrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL, int iVsSpiritsOnly=FALSE);

struct jx_effect JXEffectAttackIncrease(int iBonus, int iModifierType=ATTACK_BONUS_MISC);

struct jx_effect JXEffectDamageReduction(int iAmount, int iDRSubType=DAMAGE_POWER_NORMAL, int iLimit=0, int iDRType=DR_TYPE_MAGICBONUS);

struct jx_effect JXEffectDamageIncrease(int iBonus, int iDamageType=DAMAGE_TYPE_MAGICAL, int iVersusRace=-1);

struct jx_effect JXEffectEntangle();

struct jx_effect JXEffectDeath(int iSpectacularDeath=FALSE, int iDisplayFeedback=TRUE, int iIgnoreDeathImmunity=FALSE, int iPurgeEffects=TRUE);

struct jx_effect JXEffectKnockdown();
