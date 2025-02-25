#include "jx_inc_magic"
// #include "jx_inc_magic_effects_impl"
// #include "jx_inc_magic_effects_overrides"


/*
In order to use effect overrides you need to set them in the precast script.
All effect overrides are local and are reset after the spell finishes casting.
Since effect type cannot be identified before the effect is applied, this code
works by creating wrapper functions for effect creation.

More about the precast script in x2_inc_spellhook.nss.

You can:
- override effect parameters
- modify passed parameters
- add bonus effect to be linked with og effect
- nullify effect (changes the effect to an invalid one)


Examples:


- increase slow effects by 20
JXSetEffectModiffierInt(JX_EFFECT_SLOW, JX_EFFECT_PARAM_1, JX_EFFECT_MOD_PARAM_INCREASE_BY, 20);

- override the damage type of damage effects
JXSetEffectModifierInt(JX_EFFECT_DAMAGE, JX_EFFECT_PARAM_2, JX_EFFECT_PARAM_OVERRIDE, DAMAGE_TYPE_MAGICAL);

- add bonus damage effect to all slow effects (may cause unexpected behaviour with dispelling)
JXOverrideEffectLinkEffectDamage(JX_EFFECT_SLOW, 20);

- make damage effects count as magical effects
JXSetEffectModifierInt(JX_EFFECT_DAMAGE, JX_EFFECT_SUBTYPE, JX_EFFECT_SUBTYPE_MAGICAL);

- override the damage type if it is DAMAGE_TYPE_FIRE
JXSetEffectModifierInt(JX_EFFECT_DAMAGE, JX_EFFECT_PARAM_1, JX_EFFECT_PARAM_OVERRIDE, DAMAGE_TYPE_MAGICAL, DAMAGE_TYPE_FIRE);

- nullify the effect (it is declared but not initialized, and therefore invalid)
JXSetEffectModifierInt(JX_EFFECT_DAMAGE, JX_EFFECT_NULLIFY);

*/


//=====================================================
// EFFECT WRAPPERS
//
// Each effect uses only some of existing overrides. See jx_inc_effect_ovr.nss
// for more more information.
//======================================================



//============================================Declarations===================================


//=====================================================
// EFFECT HEAL
//=====================================================
// used overrides:
//    * flat heal amount bonus
//    * random heal amount bonus
//    * bonus effect link
//    * ignore default effect


// creates resulting effect after taking under account existing override

effect JXEffectHeal(int iDmgToHeal);

//=========================================================
// EFFECT DAMAGE
//=========================================================

// Possible overrides:
// + damage type (as a mapping from old to new)
// + substitute
// + bonus flat dmg
// + bonus rand dmg
// + override damage power
// + override ignore resist
//
// EffectDamage wrapper
// Allows for overriding spell damage type in precast script

effect JXEffectDamage(int iDmg, int iDmgType=DAMAGE_TYPE_MAGICAL, int iDamagePower=DAMAGE_POWER_NORMAL, int bIgnoreRes=FALSE);

//=====================================================
// EffectDamageOverTime
//=====================================================


// EffectDamageOverTime wrapper
// Allows for overriding spell damage type in precast script
// Possible overrides:
// + damage type (as a mapping from old to new)
// + substitute
// + bonus flat dmg
// + bonus rand dmg
// + set interval
// + override ignore resist

effect JXEffectDamageOverTime(int iDmg, float fInterval, int iDmgType=DAMAGE_TYPE_MAGICAL, int iIgnoreResistances=FALSE);

//=============================================================
// EffectAbilityIncrease
//=============================================================
// Possible overrides
// + flat bonus
// + random bonus
// + override ability
// + bonus inked effects
// + ignore def effects

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


//================================================IMPLEMENTATION====================================





//=======================================================
// EFFECT HEAL
//=====================================================
// used overrides:
//    * flat heal amount bonus
//    * random heal amount bonus
//    * bonus effect link
//    * ignore default effect


// creates resulting effect after taking under account existing override
// variables
effect JXEffectHeal(int iDmgToHeal)
{
    // int iBonusLinkCount = GetLocalArrayInt(OBJECT_SELF, JX_EFFECT_NUM_OF_LINKS, JX_EFFECT_HEAL);
    // if (iBonusLinkCount > 0)
    // {
        //     effect eBonusLink = JXLoadBonusEffectLink(JX_EFFECT_HEAL, iBonusLinkCount);
        // }

        // string sModInfoArray = JXArrayForEffect(JX_EFFECT_HEAL, JX_EFFECT_MOD_INFO_ARRAY);

        // iDmgToHeal = JXApplyEffectModifiersInt(JX_EFFECT_PARAM_1, iDmgToHeal);


        // effect eMain;
        // effect eDefault = EffectHeal(iDmgToHeal);
        // if (!JXOverrideGetIgnoreDefaultEffect(JX_EFFECT_HEAL))
        // {
            //     int iFlatBonus = JXOverrideGetFlatBonus(JX_EFFECT_HEAL);
            //     int iRandBonus = JXOverrideGetRandBonus(JX_EFFECT_HEAL)
            //     iDamageToHeal = iDmgToHeal + FlatBonus + iRandBonus;
            //     eMain = EffectHeal(iDmgToHeal);
            // }
            // effect eBonusLink = JXOverrideGetBonusEffectLink(JX_EFFECT_HEAL);
            // if (GetIsEffectValid(eBonusLink))
            // {
                //     eMain = EffectLinkEffect(eMain, eBonusLink);
                // }
                // return eDefault;

    return EffectHeal(iDmgToHeal);
}

// void JXBonusLinkEffectHeal(int iJXEffectId, int iDmgToHeal)
// {
//     // get array name for the target effect
//     string sBonusLinkArray = JXArrayForEffect(iJXEffectId, JX_EFFECT_BONUS_LINK);

//     // check the bonus link limit
//     int iBonusLinkCount = GetLocalArrayInt(OBJECT_SELF, JX_EFFECT_NUM_OF_LINKS, iJXEffectType);
//     if (iBonusLinkCount >= JX_EFFECT_MAX_LINK_COUNT)
//     {
//         // cant add more effects to the link
//         return;
//     }
//     // calculate correct index for heal effect info
//     int iStartIndex = (iJXEffectId + (iBonusLinkCount * JX_EFFECT_MAX_LINK_SIZE) + 1);
//     // save effect information
//     SetLocalArrayInt(OBJECT_SELF, sBonusLinkArray, iStartIndex, JX_EFFECT_HEAL);
//     SetLocalArrayInt(OBJECT_SELF, sBonusLinkArray, iStartIndex + 1, iDmgToHeal);

//     // increment link count for the effect
//     SetLocalArrayInt(OBJECT_SELF, JX_EFFECT_NUM_OF_LINKS, iJXEffectId, iBonusLinkCount + 1);
// }


//=========================================================
// EFFECT DAMAGE
//==========================================================

// Possible overrides:
// + damage type (as a mapping from old to new)
// + substitute
// + bonus flat dmg
// + bonus rand dmg
// + override damage power
// + override ignore resist
//


// EffectDamage wrapper
// Allows for overriding spell damage type in precast script
effect JXEffectDamage(int iDmg, int iDmgType=DAMAGE_TYPE_MAGICAL, int iDmgPower=DAMAGE_POWER_NORMAL, int bIgnoreRes=FALSE)
{
    // effect eMain;

    // // dmg type override
    // iDmgType = JXGetOverrideDamageType(JX_EFFECT_DAMAGE, iDmgType);
    // // add dmg bonus handling

    // int bIgnoreDefault= JXGetOverrideIgnoreDefaultEffect(JX_EFFECT_DAMAGE);
    // if (!bIgnoreDefault)
    // {
        //     // flat bonus
        //     int iFlatBonus = JXGetOverrideFlatBonus(JX_EFFECT_DAMAGE);
        //     // roll random bonus
        //     int iRandBonus = JXGetOverrideRandBonus(JX_EFFECT_DAMAGE);
        //     // damage power override
        //     int iOvrDmgPower = JXGetOverrideDamagePower(JX_EFFECT_DAMAGE);
        //     if (iOvrDmgPower != -1) iDmgPower = iOvrDmgPower;
        //     // ignore resists override
        //     int bOvrIgnoreRes = JXGetOverrideIgnoreResistance(JX_EFFECT_DAMAGE);
        //     if (bOvrIgnoreRes != -1) bIgnoreRes = bOvrIgnoreRes

        //     // sum up the bonuses
        //     iDmg = iDmg + iFlatBonus + iRandBonus;
        //     // create altered effect
        //     eMain = EffectLinkEffects(eMain, EffectDamage(iDmg, iDmgType, iDmgPower, bIgnoreRes));
        // }

        // effect eBonusLink = JXGetOverrideBonusEffectLink(JX_EFFECT_DAMAGE);
        // if (GetIsEffectValid(eBonusLink))
        // {
            //     eMain = EffectLinkEffects(eMain, eBonusLink);
            // }

            // return eMain;
    return EffectDamage(iDmg, iDmgType, iDmgPower, bIgnoreRes);
}


// struct jx_effect JXOverrideEffectDamage(int iDmg, int iDmgType=DAMAGE_TYPE_MAGICAL, int iDamagePower=DAMAGE_POWER_NORMAL, int iIgnoreResistances=FALSE)
// {
//     string sEffectArgs;
//     effect eDmg = EffectDamage(iDmg, iDmgType, iDamagePower, iIgnoreResistances);

//     sEffectArgs = JXOverrideEffectArgsPushInteger("", iDmg);
//     sEffectArgs = JXOverrideEffectArgsPushInteger(sEffectArgs, iDmgType);
//     sEffectArgs = JXOverrideEffectArgsPushInteger(sEffectArgs, iDamagePower);
//     sEffectArgs = JXOverrideEffectArgsPushInteger(sEffectArgs, iIgnoreResistances);

//     struct jx_effect DamageEffect = JXMakeOverrideEffect(JX_EFFECT_DAMAGE, eDmg, sEffectArgs);
//     return DamageEffect;
// }



//=====================================================
// EffectDamageOverTime
//=======================================================


// EffectDamageOverTime wrapper
// Allows for overriding spell damage type in precast script
// Possible overrides:
// + damage type (as a mapping from old to new)
// + substitute
// + bonus flat dmg
// + bonus rand dmg
// + set interval
// + override ignore resist

effect JXEffectDamageOverTime(int iDmg, float fInterval, int iDmgType=DAMAGE_TYPE_MAGICAL, int bIgnoreResistances=FALSE)
{
    // effect eMain;

    // // dmg type override
    // iDmgType = JXGetOverrideDamageType(JX_EFFECT_DAMAGE_OVER_TIME, iDmgType);

    // int bIgnoreDefault= JXGetOverrideIgnoreDefaultEffect(JX_EFFECT_DAMAGE);
    // if (!bIgnoreDefault)
    // {
        //     // check flat bonus
        //     int iFlatBonus = JXGetOverrideFlatBonus(JX_EFFECT_DAMAGE_OVER_TIME);
        //     // check random bonus
        //     int iRandBonus = JXGetOverrideRandBonus(JX_EFFECT_DAMAGE_OVER_TIME);
        //     // check ignore resist overrid
        //     int iOvrIgnoreRes = JXGetOverrideIgnoreResistance(JX_EFFECT_DAMAGE_OVER_TIME);
        //     if (iOvrIgnoreRes != -1) iIgnoreRes = iOvrIgnoreRes;
        //     float fOvrInterval = JXGetOverrideInterval(JX_EFFECT_OVER_TIME);
        //     if (fOvrInterval != 0) fInterval = fOvrInterval;
        //     iDmg = iDmg + iFlatBonus + iRandBonus;
        //     eMain = EffectLinkEffects(eMain, EffectDamageOverTime(iDmg, fInterval, iDmgType, bIgnoreResistances));
        // }

        // effect eBonusLink = JXGetOverrideBonusEffectLink(JX_EFFECT_DAMAGE_OVER_TIME);
        // if (GetIsEffectValid(eBonusLink))
        // {
            //     // link the bonus effect link
            //     eMain = EffectLinkEffects(eMain, eBonusLink);
            // }

            // return eMain;
    return EffectDamageOverTime(iDmg, fInterval, iDmgType, bIgnoreResistances);
}


// struct jx_effect JXOverrideEffectDamageOverTime(int iAmount, float fIntervalSeconds, int iDamageType=DAMAGE_TYPE_MAGICAL, int bIgnoreRes=FALSE)
// {
//     string sEffectArgs;
//     effect eDmg = EffectDamageOverTime(iDmg, fInterval, iDmgType, iIgnoreRes);

//     sEffectArgs = JXOverrideEffectArgsPushInteger("", iDmg);
//     sEffectArgs = JXOverrideEffectArgsPushInteger(sEffectArgs, iDmgType);
//     sEffectArgs = JXOverrideEffectArgsPushFloat(sEffectArgs, fInterval);
//     sEffectArgs = JXOverrideEffectArgsPushInteger(sEffectArgs, iIgnoreResistances);

//     struct jx_effect DamageEffect = JXMakeOverrideEffect(JX_EFFECT_DAMAGE_OVER_TIME, eDmg,  sEffectArgs);
//     return DamageEffect;

// }


//=============================================================
// EffectAbilityIncrease
//=============================================================
// Possible overrides
// + flat bonus
// + random bonus
// + override ability
// + bonus inked effects
// + ignore def effects

effect JXEffectAbilityIncrease(int iAbility, int iModifyBy)
{
    // effect eMain;

    // // ability to increase
    // iAbility = JXGetOverrideAbilityIncrease(JX_EFFECT_ABILITY_INCREASE, iAbility);

    // int bIgnoreDefault= JXGetOverrideIgnoreDefaultEffect(JX_EFFECT_DAMAGE);
    // if (!bIgnoreDefault)
    // {
        //     // check flat bonus
        //     int iFlatBonus = JXGetOverrideFlatBonus(JX_EFFECT_DAMAGE_OVER_TIME);
        //     // check random bonus
        //     int iRandBonus = JXGetOverrideRandBonus(JX_EFFECT_DAMAGE_OVER_TIME);
        //     // check ignore resist overrid
        //     int iOvrIgnoreRes = JXGetOverrideIgnoreResistance(JX_EFFECT_DAMAGE_OVER_TIME);
        //     if (iOvrIgnoreRes != -1) iIgnoreRes = iOvrIgnoreRes;
        //     float fOvrInterval = JXGetOverrideInterval(JX_EFFECT_OVER_TIME);
        //     if (fOvrInterval != 0) fInterval = fOvrInterval;
        //     iDmg = iDmg + iFlatBonus + iRandBonus;
        //     eMain = EffectLinkEffects(eMain, EffectDamageOverTime(iDmg, fInterval, iDmgType, bIgnoreResistances));
        // }

        // effect eBonusLink = JXGetOverrideBonusEffectLink(JX_EFFECT_DAMAGE_OVER_TIME);
        // if (GetIsEffectValid(eBonusLink))
        // {
            //     // link the bonus effect link
            //     eMain = EffectLinkEffects(eMain, eBonusLink);
            // }

            // return eMain;
    return EffectAbilityIncrease(iAbility, iModifyBy);
}

effect JXEffectDamageResistance(int iDamageType, int iAmount, int iLimit=0)
{
    return EffectDamageResistance(iDamageType, iAmount, iLimit);
}

effect JXEffectResurrection()
{
    return EffectResurrection();
}

effect JXEffectSummonCreature(string sCreatureResref, int iVisualEffectId=VFX_NONE, float fDelay=0.0f, int iUseAppearAnimation=0)
{
    return EffectSummonCreature(sCreatureResref, iVisualEffectId, fDelay, iUseAppearAnimation);
}

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

effect JXEffectACIncrease(int iValue, int iModifyType=AC_DODGE_BONUS, int iDamageType=AC_VS_DAMAGE_TYPE_ALL, int iVsSpiritsOnly=FALSE)
{
    return EffectACIncrease(iValue, iModifyType, iDamageType, iVsSpiritsOnly);
}

effect JXEffectSavingThrowIncrease(int iSave, int iValue, int iSaveType=SAVING_THROW_TYPE_ALL, int iVsSpiritsOnly=FALSE)
{
    return EffectSavingThrowIncrease(iSave, iValue, iSaveType, iVsSpiritsOnly);
}

effect JXEffectAttackIncrease(int iBonus, int iModifierType=ATTACK_BONUS_MISC)
{
    return EffectAttackIncrease(iBonus, iModifierType);
}

effect JXEffectDamageReduction(int iAmount, int iDRSubType=DAMAGE_POWER_NORMAL, int iLimit=0, int iDRType=DR_TYPE_MAGICBONUS)
{
    return EffectDamageReduction(iAmount, iDRSubType, iLimit, iDRType);
}

effect JXEffectDamageIncrease(int iBonus, int iDamageType=DAMAGE_TYPE_MAGICAL, int iVersusRace=-1)
{
    return EffectDamageIncrease(iBonus, iDamageType, iVersusRace);
}

effect JXEffectEntangle()
{
    return EffectEntangle();
}

effect JXEffectDeath(int iSpectacularDeath=FALSE, int iDisplayFeedback=TRUE, int iIgnoreDeathImmunity=FALSE, int iPurgeEffects=TRUE)
{
    return EffectDeath(iSpectacularDeath, iDisplayFeedback, iIgnoreDeathImmunity, iPurgeEffects);
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






// creates a jx_effect which stores the information about a link of
// ParentEffect and ChildEffect.
// You can only link jx_effects with the same iDefaultDurationType
// Otherwise ParentOverrideEffect is returned
// struct jx_effect JXOverrideEffectLinkEffects(struct jx_effect ParentOverrideEffect, struct jx_effect ChildOverrideEffect)
// {
//     if (ParentOverrideEffect.iDefaultDurationType == ChildOverrideEffect.iDefaultDurationType)
//     {
//         ParentOverrideEffect.iNumOfEffects += ChildOverrideEffect.iNumOfEffects;
//         ParentOverrideEffect.sEffectInfo += JX_EFFECT_SEP + ChildOverrideEffect.sEffectInfo;
//         ParentOverrideEffect.iEffectSubtype ^= ChildOverrideEffect.iEffectSubtype;
//     }
//     return ParentOverrideEffect;
// }

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
