//:://////////////////////////////////////////////////////////////
//
//
//     Reeron created on 8-2-07
//     Adds immunities for all effects in NWscript.nss
//     Especially useful for Bombardment spell
//
//
//:://////////////////////////////////////////////////////////////

int SPELLIMMUNE(object oTarget, float Duration)// Immunity to non-damaging spell effects
{ 
    int i1;
    int nImmune;
    /*effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    effect eDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
    effect eStun = EffectImmunity(IMMUNITY_TYPE_STUN);
    effect ePoison = EffectImmunity(IMMUNITY_TYPE_POISON);
    effect eMind = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eBlind = EffectImmunity(IMMUNITY_TYPE_BLINDNESS);
    effect eDeaf = EffectImmunity(IMMUNITY_TYPE_DEAFNESS);
    effect eDisease = EffectImmunity(IMMUNITY_TYPE_DISEASE);
    effect eSilence = EffectImmunity(IMMUNITY_TYPE_SILENCE);
    effect eCurse = EffectImmunity(IMMUNITY_TYPE_CURSED);
    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
    effect eKnock = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);// Stops Gust of Wind cheesiness. */
    for(i1=1; i1<=32; i1++)
        {
        effect eLink = EffectImmunity(i1);
        eLink = SupernaturalEffect(eLink);
        DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, Duration));
        }
    return nImmune; // really don't care what value it returns, just need the return statement
}

int DAMAGERESISTANCE(object oTarget, float Duration)// Immunity to non-physical damage
{

    int nImmune;
    effect eDamage = EffectDamageResistance(DAMAGE_TYPE_FIRE , 999, 0);
    effect eDamage2 = EffectDamageResistance(DAMAGE_TYPE_COLD , 999, 0);
    effect eDamage3 = EffectDamageResistance(DAMAGE_TYPE_ACID , 999, 0);
    effect eDamage4 = EffectDamageResistance(DAMAGE_TYPE_SONIC , 999, 0);
    effect eDamage5 = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL , 999, 0);
    effect eDamage6 = EffectDamageResistance(DAMAGE_TYPE_MAGICAL , 999, 0);
    effect eDamage7 = EffectDamageResistance(DAMAGE_TYPE_DIVINE , 999, 0);
    effect eDamage8 = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE , 999, 0);
    effect eDamage9 = EffectDamageResistance(DAMAGE_TYPE_POSITIVE , 999, 0);
    effect eLink = EffectLinkEffects(eDamage, eDamage2);
    eLink = EffectLinkEffects(eLink, eDamage3);
    eLink = EffectLinkEffects(eLink, eDamage4);
    eLink = EffectLinkEffects(eLink, eDamage5);
    eLink = EffectLinkEffects(eLink, eDamage6);
    eLink = EffectLinkEffects(eLink, eDamage7);
    eLink = EffectLinkEffects(eLink, eDamage8);
    eLink = EffectLinkEffects(eLink, eDamage9);
    eLink = SupernaturalEffect(eLink);
    DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, Duration));
    
    return nImmune; // really don't care what value it returns, just need the return statement
}

int REALETHEREALNESS(object oTarget, float Duration)// Etherealness should provide the following effects
{

    int nImmune;
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);// Can't be targeted by single-target spells.
    effect eDR = EffectDamageReduction(999, 0, 0, DR_TYPE_NONE);// Can't be harmed by physical damage.
    effect eMiss = EffectMissChance(100, MISS_CHANCE_TYPE_NORMAL); // Can't hit anything.
    effect eConceal = EffectConcealment(100, MISS_CHANCE_TYPE_NORMAL); // Can't be physically hit.
    effect eSpellAbsorb = EffectSpellLevelAbsorption(9, 999, SPELL_SCHOOL_GENERAL); // Absorbs all spells with spell resistance.
    effect eLink = EffectLinkEffects(eInvis, eDR);
    eLink = EffectLinkEffects(eLink, eMiss);
    eLink = EffectLinkEffects(eLink, eConceal);
    eLink = EffectLinkEffects(eLink, eSpellAbsorb);
    eLink = SupernaturalEffect(eLink);
    DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, Duration));
    
    return nImmune; // really don't care what value it returns, just need the return statement
}