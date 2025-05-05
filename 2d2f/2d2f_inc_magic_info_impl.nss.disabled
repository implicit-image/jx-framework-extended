#include "jx_inc_magic_const"


// Indicate if a spell is using a ranged touch attack
// - iSpellId Identifier of the spell
// * Returns TRUE if the spell uses a ranged touch attack
int JXImplGetIsSpellUsingRangedTouchAttack(int iSpellId)
{
	switch (iSpellId)
	{
		case SPELL_ACID_SPLASH:
		case SPELL_ARROW_FIRE_NOFOG:
		case SPELL_ARROW_NOFOG:
		case SPELL_ENERVATION:
		case SPELL_GRENADE_CHICKEN:
		case SPELL_MELFS_ACID_ARROW:
		case SPELL_METEOR_SWARM_TARGET_CREATURE:
		case SPELL_POLAR_RAY:
		case SPELL_RAY_OF_ENFEEBLEMENT:
		case SPELL_RAY_OF_FROST:
		case SPELL_SEARING_LIGHT:
		case SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW:
		case SPELL_DISINTEGRATE:
		case SPELL_TRAP_ARROW:
		case SPELL_TRAP_BOLT:
		case SPELL_TRAP_DART:
		case SPELL_TRAP_SHURIKEN:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_CHARISMA:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_CONSTITUTION:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_DEXTERITY:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_INTELLIGENCE:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_STRENGTH:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_WISDOM:
		case SPELLABILITY_BOLT_ACID:
		case SPELLABILITY_BOLT_CHARM:
		case SPELLABILITY_BOLT_COLD:
		case SPELLABILITY_BOLT_CONFUSE:
		case SPELLABILITY_BOLT_DAZE:
		case SPELLABILITY_BOLT_DEATH:
		case SPELLABILITY_BOLT_DISEASE:
		case SPELLABILITY_BOLT_DOMINATE:
		case SPELLABILITY_BOLT_FIRE:
		case SPELLABILITY_BOLT_KNOCKDOWN:
		case SPELLABILITY_BOLT_LEVEL_DRAIN:
		case SPELLABILITY_BOLT_LIGHTNING:
		case SPELLABILITY_BOLT_PARALYZE:
		case SPELLABILITY_BOLT_POISON:
		case SPELLABILITY_BOLT_SHARDS:
		case SPELLABILITY_BOLT_SLOW:
		case SPELLABILITY_BOLT_STUN:
		case SPELLABILITY_BOLT_WEB:
		case SPELLABILITY_MEPHIT_SALT_BREATH:
		case SPELLABILITY_MEPHIT_STEAM_BREATH:
		case SPELLABILITY_MANTICORE_SPIKES:
		case SPELLABILITY_AA_ARROW_OF_DEATH:
		case SPELLABILITY_AA_HAIL_OF_ARROWS:
		case SPELLABILITY_AA_IMBUE_ARROW:
		case SPELL_GRENADE_ACID:
		case SPELL_GRENADE_FIRE:
		case SPELL_GRENADE_HOLY:
		case 51: //Energy Drain
		case 302: //smoke claw
		case 744:	// Grenade Fire Bomb
		case 745:	// Grenade Acid Bomb
		case 692:	// Greater Wild Shape Spikes
		case 710:	// Eyeball ray
		case 711:	// Eyeball ray
		case 712:	// Eyeball ray
		case 770:	// Slaad Chaos Spittle
		case 801:	// Azer Fire Blast
		case SPELL_AVASCULATE:
		case 1056:	// Scorching Ray (many)
		case 1057:	// Scorching Ray (single)
		case SPELLABILITY_I_ELDRITCH_BLAST:
		case 949:	// see above
		case 950:	// see above
		case 951:	// see above
		case 952:	// see above
		case 953:	// see above
		case 954:	// see above
		case 955:	// see above
		case 956:	// see above
		case 1061:	// see above
		case 1062:	// see above
		case 1063:	// see above
		case 1064:	// see above
		case 1065:	// see above
		case SPELL_I_ELDRITCH_CHAIN:
		case SPELL_I_DRAINING_BLAST:
		case SPELL_I_FRIGHTFUL_BLAST:
		case SPELL_I_BESHADOWED_BLAST:
		case SPELL_I_BRIMSTONE_BLAST:
		case SPELL_I_HELLRIME_BLAST:
		case SPELL_I_BEWITCHING_BLAST:
		case SPELL_I_NOXIOUS_BLAST:
		case SPELL_I_VITRIOLIC_BLAST:
		case SPELL_I_UTTERDARK_BLAST:
		case SPELL_I_ELDRITCH_SPEAR:
		case 1130:	// Hindering Blast
		case 1131:	// Binding Blast
		case 1197: //Orb of cold lesser
		case 1822: //see above
		case 1198: //Orb of elec lesser
		case 1824: //see above
		case 1199: //Orb of fire lesser
		case 1823: //see above
		case 1203: //Orb of acid lesser
		case 1860: //see above
		case 1204: //Orb of sound lesser
		case 1862: //see above
		case 1205: //Orb of acid
		case 1859: //see above
		case 1206: //Orb of cold
		case 1825: //see above
		case 1207: //Orb of elec
		case 1827: //see above
		case 1208: //Orb of fire
		case 1826: //see above
		case 1209: //Orb of sound
		case 1861: //see above
		case 1863: //orb of force
		case 2346: //see above
		case 1864: //acid splatter reserve
		case 1868: //invis needle reserve
		case 1895: //SS thunderstrike
		case 1943: //MoR Searing Light
		case 2207: //icelance
		case 2340: //see above
		case 2315: //darkbolt
		case 2335: //launch stone
		case 2336: //launch bolt
		case 2339: //snowball storm
		case 2358: //DoM Hellfire Blast
		case 2448: //rainbow beam
		case 2477: //arch arcanefire
		case 2490: //see above
		case 2491: //see above
		case 2492: //see above
		case 2493: //see above
		case 2494: //see above
		case 2495: //see above
		case 2496: //see above
		case 2497: //see above
			return TRUE;
	}

	return FALSE;
}

// Indicate if a spell is a spell or a spell-like ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a spell or a spell-like ability
int JXImplGetIsSpellMagical(int iSpellId)
{
	switch (iSpellId)
	{
//-----------------//
// Assassin Spells //
//-----------------//

		// Level 1
		case 1762:
		case 1698:
		case 1699:
		case 1700:
		// Level 2
		case SPELLABILITY_AS_GHOSTLY_VISAGE:		// Illusion
		case SPELLABILITY_AS_DARKNESS:				// Evocation [Darkness]
		case SPELLABILITY_AS_INVISIBILITY:			// Illusion (Glamer)
		case 1701:
		case 1702:
		case 1703:
		case 1704:
		// Level 3
		case 1705:
		case 1706:
		case 1707:
		case 1708:
		case 1709:
		// Level 4
		case SPELLABILITY_AS_GREATER_INVISIBLITY:	// Illusion (Glamer)
		case 1710:
		case 1711:
		case 1712:
		case 1713:
		case 1714:


//-------------//
// Bard Spells //
//-------------//

		// Level 1
		case SPELL_AMPLIFY:							// Transmutation [Sonic], ref. Magic of Faerûn
		case SPELL_JOYFUL_NOISE:					// Abjuration, ref. Complete Adventurer
		case 1819: //insp boost

		// Level 2
		case SPELL_BLADEWEAVE:						// Illusion (Pattern), ref. Complete Adventurer
		case 1831: //sonic weapon

		// Level 3
		case SPELL_WOUNDING_WHISPERS:				// Abjuration [Sonic], ref. Magic of Faerûn
		case 2376: //above
		case 1813: //sonic shield
		case 2453: //above

		// Level 4
		case SPELL_WAR_CRY:							// Enchantment (Compulsion) [Sonic, Mind-Affecting], ref. Magic of Faerûn
		case SPELL_SHOUT:							// Evocation [Sonic]
		case 1829: //reson bolt
		case 1830: //sirine's grace

		// Level 5
		case SPELL_SONG_OF_DISCORD:					// Enchantment (Compulsion) [Mind-Affecting, Sonic]
		case SPELL_CACOPHONIC_BURST:				// Evocation [Sonic], ref. Spell Compendium
		case 2027: //sound blast

		// Level 6
		case SPELL_DIRGE:							// Evocation [Sonic], ref. Magic of Faerûn
		case SPELL_GREATER_SHOUT:					// Evocation [Sonic]
		case 1833: //nixie grace
		case 2371: //caco shield


//-------------------//
// Blackguard Spells //
//-------------------//

		// Level 1
		case 1715:
		case 1716:
		case 1717:
		case 1718:
		case 1719:
		// Level 2
		case SPELLABILITY_BG_BULLS_STRENGTH:
		case 1720:
		case 1721:
		case 1722:
		case 1723:
		case 1724:
		case 1725:
		// Level 3
		case SPELLABILITY_BG_CONTAGION:
		case SPELLABILITY_BG_INFLICT_SERIOUS_WOUNDS:
		case 1726:
		case 1727:
		case 1728:
		case 1729:
		case 1730:
		// Level 4
		case SPELLABILITY_BG_INFLICT_CRITICAL_WOUNDS:
		case 701: // Summon Fiendish Ally
		case 1731:
		case 1732:
		case 1733:
		case 1734:
		case 1735:


//---------------//
// Cleric Spells //
//---------------//

		// Level 0
		case SPELL_CURE_MINOR_WOUNDS:				// Conjuration (Healing)
		case SPELL_VIRTUE:							// Transmutation
		case SPELL_INFLICT_MINOR_WOUNDS:			// Necromancy

		// Level 1
		case SPELL_BLESS:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_CURE_LIGHT_WOUNDS:				// Conjuration (Healing)
		case SPELL_DOOM:							// Necromancy [Fear, Mind-Affecting]
		case SPELL_PROTECTION_FROM_CHAOS:			// Abjuration [Lawful]
		case SPELL_PROTECTION_FROM_EVIL:			// Abjuration [Good]
		case SPELL_PROTECTION_FROM_GOOD:			// Abjuration [Evil]
		case SPELL_PROTECTION_FROM_LAW:				// Abjuration [Chaotic]
		case SPELL_REMOVE_FEAR:						// Abjuration
		case SPELL_SANCTUARY:						// Abjuration
		case SPELL_CAUSE_FEAR:						// Necromancy [Fear, Mind-Affecting]
//      case SPELL_PROTECTION_FROM_ALIGNMENT:
		case SPELL_DIVINE_FAVOR:					// Evocation
		case SPELL_ENTROPIC_SHIELD:					// Abjuration
		case SPELL_INFLICT_LIGHT_WOUNDS:			// Necromancy
		case SPELL_BANE:							// Enchantment (Compulsion) [Fear, Mind-Affecting]
		case SPELL_SHIELD_OF_FAITH:					// Abjuration
		case SPELL_DETECT_UNDEAD:					// Divination
		case SPELL_DEATHWATCH:						// Necromancy [Evil]
		case SPELL_LESSER_VIGOR:					// Conjuration (Healing), ref. Complete Divine
		case SPELL_NIGHTSHIELD:						// Abjuration, ref. Spell Compendium
		case SPELL_CONVICTION:						// Abjuration, ref. Miniatures Handbook
		case 1740: //blessed aim

		// Level 2
		case SPELL_AID:								// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_CURE_MODERATE_WOUNDS:			// Conjuration (Healing)
//      case SPELL_CALM_EMOTIONS:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_LESSER_RESTORATION:				// Conjuration (Healing)
		case SPELL_REMOVE_PARALYSIS:				// Conjuration (Healing)
		case SPELL_SILENCE:							// Illusion (Glamer)
		case SPELL_SOUND_BURST:						// Evocation [Sonic]
		case SPELL_EAGLES_SPLENDOR:					// Transmutation
		case SPELL_FIND_TRAPS:						// Divination
		case SPELL_INFLICT_MODERATE_WOUNDS:			// Necromancy
		case SPELL_STONE_BONES:						// Transmutation, ref. Magic of Faerûn
		case SPELL_DEATH_KNELL:						// Necromancy [Death, Evil]
		case SPELL_SHIELD_OTHER:					// Abjuration
		case SPELL_LIVING_UNDEATH:					// Necromancy, ref. Miniatures Handbook
		case 1202: //stabilize
		case 1760: //hand of divinity
		case 1821: //living undeath
		case 2370: //darkfire
		case 1747: //lesser energy shield
		case 1748: //above
		case 1749: //above
		case 1750: //above
		case 1751: //above
		case 1752: //above
		case 2315: //darkbolt

		// Level 3
		case SPELL_ANIMATE_DEAD:					// Necromancy [Evil]
		case SPELL_BESTOW_CURSE:					// Transmutation
		case SPELL_CONTAGION:						// Necromancy [Evil]
		case SPELL_CURE_SERIOUS_WOUNDS:				// Conjuration (Healing)
		case SPELL_INVISIBILITY_PURGE:				// Invisibility Purge
		case SPELL_MAGIC_CIRCLE_AGAINST_CHAOS:		// Abjuration [Lawful]
		case SPELL_MAGIC_CIRCLE_AGAINST_EVIL:		// Abjuration [Good]
		case SPELL_MAGIC_CIRCLE_AGAINST_GOOD:		// Abjuration [Evil]
		case SPELL_MAGIC_CIRCLE_AGAINST_LAW:		// Abjuration [Chaotic]
		case SPELL_MAGIC_VESTMENT:					// Transmutation
		case SPELL_PRAYER:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_REMOVE_BLINDNESS_AND_DEAFNESS:	// Conjuration (Healing)
		case SPELL_REMOVE_CURSE:					// Abjuration
		case SPELL_REMOVE_DISEASE:					// Conjuration (Healing)
		case SPELL_SEARING_LIGHT:					// Evocation
//      case SPELL_MAGIC_CIRCLE_AGAINST_ALIGNMENT:
		case SPELL_INFLICT_SERIOUS_WOUNDS:			// Necromancy
		case SPELL_NEGATIVE_ENERGY_PROTECTION:		// Abjuration, ref. Libris Mortis
		case SPELL_DARKFIRE:						// Evocation [Fire], ref. Magic of Faerûn
		case SPELL_GLYPH_OF_WARDING:				// Abjuration, ref. Magic of Faerûn
		case 764: // Glyph of Warding triggered		// see above
		case SPELL_BLINDSIGHT:						// Transmutation, ref. Magic of Faerûn & PGtF
		case SPELL_CLARITY:							// Abjuration (not D&D, NWN1 removed spell)
		case SPELL_VIGOR:							// Conjuration (Healing), ref. Complete Divine
		case SPELL_MASS_LESSER_VIGOR:				// Conjuration (Healing), ref. Complete Divine
		case SPELL_VISAGE_OF_THE_DEITY:				// Transmutation [Evil, Good], ref. Complete Divine
		case 1052:	// Mass Aid						// Enchantment (Compulsion) [Mind-Affecting]
		case 1739: //awaken sin
		case 1744: //cloak of bravery
		case 1753: //energy shield
		case 1754: //above
		case 1755: //above
		case 1756: //above
		case 1757: //above
		case 1758: //above
		case 1759: //flame of faith
		case 1766: //shield ward
		case 1771: //weapon of the diety
		case 2317: //shriveling

		// Level 4
		case SPELL_CURE_CRITICAL_WOUNDS:			// Conjuration (Healing)
		case SPELL_DEATH_WARD:						// Necromancy
		case SPELL_DISMISSAL:						// Abjuration
		case SPELL_DIVINE_POWER:					// Evocation
		case SPELL_RESTORATION:						// Conjuration (Healing)
		case SPELL_INFLICT_CRITICAL_WOUNDS:			// Necromancy
		case SPELL_SPELL_IMMUNITY:					// Abjuration
		case SPELL_HAMMER_OF_THE_GODS:				// Evocation, not D&D
		case SPELL_GREATER_RESISTANCE:				// Abjuration, ref. Spell Compendium
		case 1054:	// Recitation					// Conjuration (Creation), ref. Complete Divine
		case SPELL_CASTIGATION:						// Evocation [Sonic], ref. Complete Divine
		case 1742: //blessed righteousness
		case 1743: //castigate
		case 1770: //undead bane weapon
		case 1773: //blood of the martyr
		case 2316: //damning darkness

		// Level 5
		case SPELL_MASS_INFLICT_LIGHT_WOUNDS:		// Necromancy
//      case SPELL_CIRCLE_OF_DOOM:					// NWN1 version of Mass Inflict Light Wounds
		case SPELL_MASS_CURE_LIGHT_WOUNDS:			// Conjuration (Healing)
//      case SPELL_HEALING_CIRCLE:					// NWN1 version of Mass Cure Light Wounds
		case SPELL_RAISE_DEAD:						// Conjuration (Healing)
		case SPELL_SPELL_RESISTANCE:				// Abjuration
		case SPELL_SLAY_LIVING:						// Necromancy [Death]
		case SPELL_TRUE_SEEING:						// Divination
		case SPELL_BATTLETIDE:						// Transmutation, ref. Magic of Faerûn & PgtF
		case SPELL_MONSTROUS_REGENERATION:			// Conjuration (Healing), ref. Magic of Faerûn
		case SPELL_RIGHTEOUS_MIGHT:					// Transmutation
		case SPELL_MASS_CONTAGION:					// Necromancy [Evil], ref. Races of Faerûn
		case SPELL_SYMBOL_OF_PAIN:					// Necromancy [Evil]
		case SPELL_SYMBOL_OF_SLEEP:					// Enchantment (Compulsion) [Mind-Affecting]

		// Level 6
		case SPELL_BLADE_BARRIER:					// Evocation [Force]
		case SPELL_BLADE_BARRIER_WALL:				// Evocation [Force]
		case SPELL_BLADE_BARRIER_SELF:				// Evocation [Force]
		case SPELL_CREATE_UNDEAD:					// Necromancy [Evil]
		case SPELL_HARM:							// Necromancy
		case SPELL_HEAL:							// Conjuration (Healing)
		case SPELL_BANISHMENT:						// Abjuration
		case SPELL_PLANAR_ALLY:						// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SPELL_MANTLE:					// Abjuration (Mystra), ref. Magic of Faerûn
		case SPELL_UNDEATH_TO_DEATH:				// Necromancy, ref. Magic of Faerûn
		case SPELL_MASS_CURE_MODERATE_WOUNDS:		// Conjuration (Healing)
		case SPELL_MASS_INFLICT_MODERATE_WOUNDS:	// Necromancy
		case SPELL_SUPERIOR_RESISTANCE:				// Abjuration, ref. Spell Compendium
		case SPELL_VIGOROUS_CYCLE:					// Conjuration (Healing), ref. Complete Divine
		case SPELL_SYMBOL_OF_FEAR:					// Necromancy [Fear, Mind-Affecting]
		case SPELL_SYMBOL_OF_PERSUASION:			// Enchantment (Charm) [Mind-Affecting]
		case 1795: //visage of the diety
		case 1812: //chasing perfection

		// Level 7
		case SPELL_GREATER_RESTORATION:				// Conjuration (Healing)
		case SPELL_RESURRECTION:					// Conjuration (Healing)
		case SPELL_DESTRUCTION:						// Necromancy [Death]
		case SPELL_REGENERATE:						// Conjuration (Healing)
		case SPELL_FORTUNATE_FATE:					// Conjuration (Healing), ref. Magic of Faerûn
		case SPELL_MASS_CURE_SERIOUS_WOUNDS:		// Conjuration (Healing)
		case SPELL_MASS_INFLICT_SERIOUS_WOUNDS:		// Necromancy 
		case SPELL_WORD_OF_FAITH:					// Evocation, not D&D
		case SPELL_BLOOD_TO_WATER:					// Necromancy [Water], ref. Spell Compendium
		case SPELL_SYMBOL_OF_STUNNING:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_SYMBOL_OF_WEAKNESS:				// Necromancy

		// Level 8
		case SPELL_CLOAK_OF_CHAOS:					// Abjuration [Chaotic]
		case SPELL_CREATE_GREATER_UNDEAD:			// Necromancy [Evil]
		case SPELL_HOLY_AURA:						// Abjuration [Good]
		case SPELL_SHIELD_OF_LAW:					// Abjuration [Lawful]
		case SPELL_UNHOLY_AURA:						// Abjuration [Evil]
		case SPELL_GREATER_SPELL_IMMUNITY:			// Abjuration
		case SPELL_MASS_CURE_CRITICAL_WOUNDS:		// Conjuration (Healing)
		case SPELL_MASS_INFLICT_CRITICAL_WOUNDS:	// Necromancy
//      case SPELL_AURA_VERSUS_ALIGNMENT:			// Abjuration, not D&D
		case SPELL_MASS_DEATH_WARD:					// Necromancy, ref. Libris Mortis
		case SPELL_BODAKS_GLARE:					// Necromancy [Death, Evil], ref. Planar Handbook
		case SPELL_SYMBOL_OF_DEATH:					// Necromancy [Death]
		case 1820: //lion roar

		// Level 9
		case SPELL_IMPLOSION:						// Evocation
		case SPELL_MASS_HEAL:						// Conjuration (Healing)
		case SPELL_UNDEATHS_ETERNAL_FOE:			// Abjuration [Good], ref. Magic of Faerûn & PGtF
		case SPELL_MIRACLE:							// Evocation
		case SPELL_GREATER_VISAGE_OF_THE_DEITY:		// Transmutation [Evil, Good], ref. Complete Divine


//--------------//
// Druid Spells //
//--------------//

		// Level 1
		case SPELL_CHARM_PERSON_OR_ANIMAL:			// Enchantment (Charm) [Mind-Affecting]
		case SPELL_ENTANGLE:						// Transmutation
		case SPELL_MAGIC_FANG:						// Transmutation
		case SPELL_CAMOFLAGE:						// Transmutation, ref. Magic of Faerûn
		case SPELL_FOUNDATION_OF_STONE:				// Transmutation [Earth], ref. Spell Compendium
		case 1201: //snake swift
		case 1857: //faerie fire

		// Level 2
		case SPELL_BARKSKIN:						// Transmutation
		case SPELL_BULLS_STRENGTH:					// Transmutation
		case SPELL_CATS_GRACE:						// Transmutation
		case SPELL_BEARS_ENDURANCE:					// Transmutation
		case SPELL_GUST_OF_WIND:					// Evocation [Air]
		case SPELL_HOLD_ANIMAL:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_OWLS_WISDOM:						// Transmutation
		case SPELL_ONE_WITH_THE_LAND:				// Transmutation, ref. Magic of Faerûn
		case SPELL_BLOOD_FRENZY:					// Transmutation, ref. Magic of Faerûn
		case SPELL_MASS_CAMOFLAGE:					// Transmutation, ref. Magic of Faerûn
		case SPELL_BODY_OF_THE_SUN:					// Transmutation [Fire], ref. Complete Divine
		case SPELL_FLAME_LASH:						// Evocation (not D&D, NWN1 removed spell)
		case SPELL_CREEPING_COLD:					// Transmutation [Cold], ref. Complete Divine
		case SPELL_ANIMALISTIC_POWER:				// Transmutation, ref. Player's Handbook II
		case SPELL_HEALING_STING:					// Necromancy, ref. Magic of Faerun
		case 1191: //animal trance
		case 1210: //reduce animal
		case 1213: //mass snake swift
		case 1828: //nature's favor
		case 1832: //wild instinct
		case 1858: //heartfire
		case 2028: //frostbreath
		case 2446: //flaming sphere
		case 2447: //frostfingers

		// Level 3
		case SPELL_CALL_LIGHTNING:					// Evocation [Electricity]
		case SPELL_DOMINATE_ANIMAL:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_NEUTRALIZE_POISON:				// Conjuration (Healing)
		case SPELL_POISON:							// Necromancy
		case SPELL_GREATER_MAGIC_FANG:				// Transmutation
		case SPELL_SPIKE_GROWTH:					// Transmutation
		case SPELL_QUILLFIRE:						// Transmutation, ref. Magic of Faerûn
		case SPELL_INFESTATION_OF_MAGGOTS:			// Necromancy, ref. Magic of Faerûn
		case SPELL_JAGGED_TOOTH:					// Transmutation, ref. Savage Species
		case SPELL_HYPOTHERMIA:						// Evocation [Cold], ref. Spell Compendium
		case SPELL_DEHYDRATE:						// Necromancy, ref. Spell Compendium
		case 1951: //thornskin
		case 2207: //icelance
		case 2340: //above
		case 2399: //greenfire

		// Level 4
		case SPELL_FLAME_STRIKE:					// Evocation [Fire]
		case SPELL_FREEDOM_OF_MOVEMENT:				// Abjuration
		case SPELL_ICE_STORM:						// Evocation [Cold]
		case SPELL_NATURES_BALANCE:					// Transmutation, ref. Magic of Faerûn
		case SPELL_MOON_BOLT:						// Evocation, ref. Spell Compendium
		case SPELL_GREATER_CREEPING_COLD:			// Transmutation [Cold], ref. Complete Divine
		case SPELL_ARC_OF_LIGHTNING:				// Conjuration (Creation) [Electricity], ref. Complete Arcane
		case 2428: //summon spider

		// Level 5
		case SPELL_STONESKIN:						// Abjuration
		case SPELL_AWAKEN:							// Transmutation
		case SPELL_INFERNO:							// Transmutation [Fire], ref. Magic of Faerûn & PGtF
		case SPELL_VINE_MINE:						// Conjuration (Creation), ref. Magic of Faerûn
		case SPELL_VINE_MINE_ENTANGLE:				// Sub-spell (see above)
		case SPELL_VINE_MINE_HAMPER_MOVEMENT:		// Sub-spell (see above)
		case SPELL_VINE_MINE_CAMOUFLAGE:			// Sub-spell (see above)
		case SPELL_REJUVENATION_COCOON:				// Conjuration (Healing), ref. Complete Divine
		case 438: // Owl's Insight					// Transmutation, ref. Magic of Faerûn
		case SPELL_CALL_LIGHTNING_STORM:			// Evocation [Electricity]
		case 1950: //plant body
		case 2026: //flaywind blast
		case 2469: //summon wyvern

		// Level 6
		case SPELL_CRUMBLE:							// Transmutation, ref. Magic of Faerûn
		case SPELL_DROWN:							// Conjuration (Creation) [Water], ref. Magic of Faerûn
		case SPELL_STONEHOLD:						// Conjuration (Creation) [Earth]
		case SPELL_ENERGY_IMMUNITY:					// Abjuration, ref. Complete Arcane
		case SPELL_ENERGY_IMMUNITY_ACID:			// Abjuration, ref. Complete Arcane
		case SPELL_ENERGY_IMMUNITY_COLD:			// Abjuration, ref. Complete Arcane
		case SPELL_ENERGY_IMMUNITY_ELECTRICAL:		// Abjuration, ref. Complete Arcane
		case SPELL_ENERGY_IMMUNITY_FIRE:			// Abjuration, ref. Complete Arcane
		case SPELL_ENERGY_IMMUNITY_SONIC:			// Abjuration, ref. Complete Arcane
		case SPELL_GREATER_STONESKIN:				// Abjuration, not D&D
		case SPELL_TORTOISE_SHELL:					// Transmutation, ref. Complete Divine (other version at level 3)
		case SPELL_MASS_BEAR_ENDURANCE:				// Transmutation
		case SPELL_MASS_BULL_STRENGTH:				// Transmutation
		case SPELL_MASS_OWL_WISDOM:					// Transmutation
		case SPELL_MASS_CAT_GRACE:					// Transmutation
		case SPELL_MASS_EAGLE_SPLENDOR:				// Transmutation
		case 1058:	// Extract Water Elemental		// Transmutation [Water], ref. Spell Compendium
		case 1928: //liveoak

		// Level 7
		case SPELL_FIRE_STORM:						// Evocation [Fire]
		case SPELL_SUNBEAM:							// Evocation [Light]
		case SPELL_CREEPING_DOOM:					// Conjuration (Summoning)
		case SPELL_AURA_OF_VITALITY:				// Transmutation, ref. Magic of Faerûn
		case SPELL_GREAT_THUNDERCLAP:				// Evocation [Sonic], ref. Magic of Faerûn
		case SPELL_SWAMP_LUNG:						// Conjuration (Creation), ref. Spell Compendium

		// Level 8
		case SPELL_EARTHQUAKE:						// Evocation [Earth]
		case SPELL_SUNBURST:						// Evocation [Light]
		case SPELL_BOMBARDMENT:						// Conjuration (Creation), ref. Magic of Faerûn & PGtF
		case SPELL_STORM_AVATAR:					// Transmutation, not D&D
		case 1914: //leonal roar
		case 1931: //phantom wolf
		case 2025: //deadly lahar

		// Level 9
		case SPELL_ELEMENTAL_SWARM:					// Conjuration (Summoning) [Air/Earth/Fire/Water]
		case SPELL_SHAPECHANGE:						// Transmutation
		case 392: // Shape change in Frost Giant	// See above
		case 393: // Shape change in Fire Giant		// See above
		case 394: // Shape change in Horned Devil	// See above
		case 395: // Shape change in Nightwalker	// See above
		case 396: // Shape change in Iron Golem		// See above
		case SPELL_STORM_OF_VENGEANCE:				// Conjuration (Summoning)
		case SPELL_NATURE_AVATAR:					// Evocation, ref. Masters of the Wild
		case SPELL_MASS_DROWN:						// Conjuration (Creation), ref. Underdark
		case SPELL_GLACIAL_WRATH:					// Evocation/Transmutation, ref. Dragon Magic (to verify as I don't have the book !)
		case 1930: //phantom bear


//--------------//
// Harper Scout //
//--------------//

		// Level 1
		case 480: // Sleep							// Enchantment (Compulsion) [Mind-Affecting]
		// Lebel 2
		case 481: // Cat's Grace					// Transmutation
		case 482: // Eagle's Splendor				// Transmutation
		case 483: // Invisibility					// Illusion (Glamer)


//----------------//
// Paladin Spells //
//----------------//

		// Level 1
		case SPELL_BLESS_WEAPON:					// Transmutation
//		case SPELL_DEAFENING_CLANG:					// Transmutation [Sonic], ref. Magic of Faerûn (same const as Fox's Cunning)
		case 1053:	// Lionheart					// Abjuration[Mind-Affecting], ref. Miniatures Handbook
		case 1745: //deaf clang
		case 1765: //second wind
		case 1767: //silver beard
		case 1768: //strat charge
		
		// Level 2
		case SPELL_AURAOFGLORY:						// Transmutation, ref. Magic of Faerûn
		case 1738: //angelskin
		case 1769: //strength of stone
		case 1772: //zeal
		
		//Level 3
		case 1741: //Blessing of bahumut
		case 1764: //righteous fury

		// Level 4
		case SPELL_HOLY_SWORD:						// Evocation [Good]
		case 1746: //drac might
		case 1761: //lawful sword
		case 1774: //righteous glory


//---------------//
// Ranger Spells //
//---------------//

		// Level 3
		case SPELL_BLADE_THIRST:					// Transmutation, ref. Magic of Faerûn
		case SPELL_HEAL_ANIMAL_COMPANION:			// Conjuration (Healing), ref. Spell Compendium


//---------------------//
// Warlock Invocations //
//---------------------//

		case SPELL_I_BEGUILING_INFLUENCE:
		case SPELL_I_BREATH_OF_NIGHT:
		case SPELL_I_DARK_ONES_OWN_LUCK:
		case SPELL_I_DARKNESS:
		case SPELL_I_DEVILS_SIGHT:
		case SPELL_I_DRAINING_BLAST:
		case SPELL_I_ELDRITCH_SPEAR:
		case SPELL_I_ENTROPIC_WARDING:
		case SPELL_I_FRIGHTFUL_BLAST:
		case SPELL_I_HIDEOUS_BLOW:
		case 931: // Hideous Blow Impact
		case SPELL_I_LEAPS_AND_BOUNDS:
		case SPELL_I_SEE_THE_UNSEEN:
		case SPELL_I_BESHADOWED_BLAST:
		case SPELL_I_BRIMSTONE_BLAST:
		case SPELL_I_CHARM:
		case SPELL_I_CURSE_OF_DESPAIR:
		case SPELL_I_THE_DEAD_WALK:
		case SPELL_I_ELDRITCH_CHAIN:
		case SPELL_I_FLEE_THE_SCENE:
		case SPELL_I_HELLRIME_BLAST:
		case SPELL_I_VOIDSENSE:
		case SPELL_I_VORACIOUS_DISPELLING:
		case SPELL_I_WALK_UNSEEN:
		case SPELL_I_BEWITCHING_BLAST:
		case SPELL_I_CHILLING_TENTACLES:
		case SPELL_I_DEVOUR_MAGIC:
		case SPELL_I_ELDRITCH_CONE:
		case SPELL_I_NOXIOUS_BLAST:
		case SPELL_I_TENACIOUS_PLAGUE:
		case SPELL_I_VITRIOLIC_BLAST:
		case SPELL_I_WALL_OF_PERILOUS_FLAME:
		case SPELL_I_DARK_FORESIGHT:
		case SPELL_I_ELDRITCH_DOOM:
		case SPELL_I_PATH_OF_SHADOW:
		case SPELL_I_RETRIBUTIVE_INVISIBILITY:
		case SPELL_I_UTTERDARK_BLAST:
		case SPELL_I_WORD_OF_CHANGING:
		case 1059:	// Otherwordly Whispers
		case 1060:	// Dread Seizure
		case 1130:	// Hindering Blast
		case 1131:	// Binding Blast
		case 1844:	// eld glaive


//---------------//
// Wizard Spells //
//---------------//

		// Level 0
		case SPELL_DAZE:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_LIGHT:							// Evocation [Light]
		case SPELL_RAY_OF_FROST:					// Evocation [Cold]
		case SPELL_RESISTANCE:						// Abjuration
		case SPELL_FLARE:							// Evocation [Light]
		case SPELL_ACID_SPLASH:						// Conjuration (Creation) [Acid]
		case SPELL_ELECTRIC_JOLT:					// Evocation [Electricity], ref. Magic of Faerûn
		case JX_SPELL_DETECTMAGIC:					// Divination
		case SPELL_TOUCH_OF_FATIGUE:				// Necromancy
		case 1864: //reserve
		case 1865: //reserve
		case 1866: //reserve
		case 1867: //reserve
		case 1868: //reserve
		case 1870: //reserve
		case 1871: //reserve
		case 1872: //reserve
		case 1873: //reserve
		case 1874: //reserve
		case 1875: //reserve
		case 1876: //reserve
		case 1877: //reserve
		case 1919: //reserve
		case 1920: //reserve
		case 1921: //reserve
		case 1922: //reserve
		case 2333: //cough
		case 2335: //stone
		case 2375: //jolt
		case 2415: //read magic
		case 2487: //ran sum 0

		// Level 1
		case SPELL_BURNING_HANDS:					// Evocation [Fire]
		case SPELL_CHARM_PERSON:					// Enchantment (Charm) [Mind-Affecting]
		case SPELL_COLOR_SPRAY:						// Illusion (Pattern) [Mind-Affecting]
		case SPELL_ENDURE_ELEMENTS:					// Abjuration
//      case SPELL_ENDURE_ELEMENTS_COLD:
//      case SPELL_ENDURE_ELEMENTS_FIRE:
//      case SPELL_ENDURE_ELEMENTS_ACID:
//      case SPELL_ENDURE_ELEMENTS_SONIC:
//      case SPELL_ENDURE_ELEMENTS_ELECTRICITY:
		case SPELL_GREASE:							// Conjuration (Creation)
		case SPELL_IDENTIFY:						// Divination
		case SPELL_MAGE_ARMOR:						// Conjuration (Creation) [Force]
		case SPELL_MAGIC_MISSILE:					// Evocation [Force]
		case SPELL_MAGIC_WEAPON:					// Transmutation
		case SPELL_RAY_OF_ENFEEBLEMENT:				// Necromancy
		case SPELL_SLEEP:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_SUMMON_CREATURE_I:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_TRUE_STRIKE:						// Divination
		case SPELL_SHIELD:							// Abjuration [Force]
		case SPELL_EXPEDITIOUS_RETREAT:				// Transmutation
		case SPELL_NEGATIVE_ENERGY_RAY:				// Necromancy, ref. Tome and Blood
		case 2200: //above
		case 2367: //above
		case SPELL_HORIZIKAULS_BOOM:				// Evocation [Sonic], ref. Magic of Faerûn
		case SPELL_IRONGUTS:						// Abjuration, ref. Magic of Faerûn
		case SPELL_SHELGARNS_PERSISTENT_BLADE:		// Evocation [Force], ref. Magic of Faerûn
		case SPELL_ICE_DAGGER:						// Evocation [Cold], ref. Magic of Faerûn
		case SPELL_ENLARGE_PERSON:					// Transmutation
		case SPELL_SHOCKING_GRASP:					// Evocation [Electricity]
		case SPELL_LOW_LIGHT_VISION:				// Transmutation, ref. Magic of Faerûn
		case SPELL_BLADES_OF_FIRE:					// Conjuration (Creation) [Fire], ref. Complete Arcane
		case 1200: //reduce person
		case 1197: //lesser cold orb
		case 1822: //above
		case 1198: //lesser elec orb
		case 1824: //above
		case 1199: //lesser fire orb
		case 1823: //above
		case 1203: //lesser acid orb
		case 1860: //above
		case 1204: //lesser sound orb
		case 1862: //above
		case 2219: //arcane bolts
		case 2324: //quickblast
		case 2334: //h's boom
		case 2336: //bolt
		case 2338: //corrosive grasp
		case 2344: //snowball
		case 2369: //ice dagger
		case 2377: //ironguts
		case 2403: //forcewave
		case 2412: //nightshield
		case 2419: //ran sum I
		case 2445: //help hand
//		case 2470: //scit nerves
		
		// Level 2
		case SPELL_BLINDNESS_AND_DEAFNESS:			// Necromancy
		case SPELL_DARKNESS:						// Evocation [Darkness]
		case SPELL_GHOUL_TOUCH:						// Necromancy
		case SPELL_INVISIBILITY:					// Illusion (Glamer)
		case SPELL_KNOCK:							// Transmutation
		case SPELL_MELFS_ACID_ARROW:				// Conjuration (Creation) [Acid]
		case SPELL_RESIST_ENERGY:					// Abjuration
//		case SPELL_RESIST_ELEMENTS_COLD:
//		case SPELL_RESIST_ELEMENTS_FIRE:
//		case SPELL_RESIST_ELEMENTS_ACID:
//		case SPELL_RESIST_ELEMENTS_SONIC:
//		case SPELL_RESIST_ELEMENTS_ELECTRICITY:
		case SPELL_SEE_INVISIBILITY:				// Divination
		case SPELL_SUMMON_CREATURE_II:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_WEB:								// Conjuration (Creation)
		case SPELL_FOXS_CUNNING:					// Transmutation
		case SPELL_DARKVISION:						// Transmutation
		case SPELL_CONTINUAL_FLAME:					// Evocation [Light]
		case SPELL_TASHAS_HIDEOUS_LAUGHTER:			// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_BALAGARNSIRONHORN:				// Transmutation [Sonic], ref. Magic of Faerûn
		case SPELL_COMBUST:							// Evocation [Fire], ref. Magic of Faerûn
		case SPELL_DEATH_ARMOR:						// Necromancy, ref. Magic of Faerûn
		case SPELL_GEDLEES_ELECTRIC_LOOP:			// Evocation [Electricity], ref. Magic of Faerûn & PGtF
		case SPELL_CLOUD_OF_BEWILDERMENT:			// Evocation, ref. Magic of Faerûn & PGtF
		case SPELL_FLAME_WEAPON:					// Evocation [Fire], ref. Magic of Faerûn (Flame Dagger)
		case SPELLABILITY_ONHITFLAMEDAMAGE:			// Flaming Weapon spell : On Hit Cast Spell property (should work in wild magic zones, not in dead magic zones)
		case SPELL_FALSE_LIFE:						// Necromancy
		case SPELL_FIREBURST:						// Evocation [Fire]
		case SPELL_MIRROR_IMAGE:					// Illusion (Figment)
		case SPELL_PROTECTION_FROM_ARROWS:			// Abjuration
		case SPELL_SCARE:							// Necromancy [Fear, Mind-Affecting]
		case SPELL_LESSER_DISPEL:					// Abjuration, not D&D
		case SPELL_GHOSTLY_VISAGE:					// Illusion, not D&D
		case SPELL_CURSE_OF_BLADES:					// Necromancy, ref. Miniatures Handbook
		case 1051:	// Touch of Idiocy				// Enchantment (Compulsion) [Mind-Affecting]
		case 1055:	// Scorching Ray				// Evocation [Fire]
		case 1056:	// Scorching Ray (many)			// See above
		case 1057:	// Scorching Ray (single)		// See above
		case 1845: //lesser dispel
		case 1846: //above
		case 1847: //above
		case 2339: //snowball storm
		case 2378: //stonebones
		case 2402: //shadowspray
		case 2404: //battering ram
		case 2420: //ran sum II
		case 2448: //rainbow beam
//		case 2480: //force scourge
//		case 2481: //crackling sphere
//		case 2482: //force blast

		// Level 3
		case SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE:	// Divination (Scrying)
		case SPELL_DISPEL_MAGIC:					// Abjuration
		case SPELL_FIREBALL:						// Evocation [Fire]
		case SPELL_FLAME_ARROW:						// Transmutation [Fire]
		case SPELL_GREATER_MAGIC_WEAPON:			// Transmutation
		case SPELL_HASTE:							// Transmutation
		case SPELL_HOLD_PERSON:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_INVISIBILITY_SPHERE:				// Illusion (Glamer)
		case SPELL_LIGHTNING_BOLT:					// Evocation [Electricity]
		case SPELL_PROTECTION_FROM_ENERGY:			// Abjuration
//      case SPELL_PROTECTION_FROM_ELEMENTS_COLD:
//      case SPELL_PROTECTION_FROM_ELEMENTS_FIRE:
//      case SPELL_PROTECTION_FROM_ELEMENTS_ACID:
//      case SPELL_PROTECTION_FROM_ELEMENTS_SONIC:
//      case SPELL_PROTECTION_FROM_ELEMENTS_ELECTRICITY:
		case SPELL_SLOW:							// Transmutation
		case SPELL_STINKING_CLOUD:					// Conjuration (Creation)
		case SPELL_SUMMON_CREATURE_III:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_VAMPIRIC_TOUCH:					// Necromancy
		case SPELL_DISPLACEMENT:					// Illusion (Glamer)
		case SPELL_NEGATIVE_ENERGY_BURST:			// Necromancy, ref. Tome and Blood
		case 2201: //above
		case 2366: //above
		case SPELL_MESTILS_ACID_BREATH:				// Conjuration (Creation) [Acid], ref. Magic of Faerûn
		case SPELL_SCINTILLATING_SPHERE:			// Evocation [Electricity], ref. Magic of Faerûn
		case SPELL_KEEN_EDGE:						// Transmutation
		case SPELL_DEEP_SLUMBER:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_ENHANCE_FAMILIAR:				// Universal, ref. Complete Arcane
		case SPELL_HEROISM:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_IMPROVED_MAGE_ARMOR:				// Conjuration (Creation) [Force], ref. Complete Arcane (Greater Mage Armor)
		case SPELL_RAGE:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_SPIDERSKIN:						// Transmutation, ref. Underdark
		case SPELL_WEAPON_OF_IMPACT:				// Transmutation, ref. Magic of Faerûn
		case SPELL_POWORD_WEAKEN:					// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
		case SPELL_POWORD_MALADROIT:				// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
		case SPELL_GREATER_CURSE_OF_BLADES:			// Necromancy, ref. Spell Compendium
		case 1814: //energy weapon
		case 1815: //above
		case 1816: //above
		case 1817: //above
		case 1818: //above
		case 1848: //dispel
		case 1849: //above
		case 1850: //above
		case 2314: //acidball
		case 2401: //flashburst
		case 2421: //ran sum III
		case 2449: //rainbow blast
		case 2458: //sound lance
//		case 2471: //heal touch
//		case 2475: //abolish shadows
		case 2476: //ice burst
		case 2478: //hailstones
//		case 2479: //disrupting hand
//		case 2488: //mindspin

		// Level 4
		case SPELL_CHARM_MONSTER:					// Enchantment (Charm) [Mind-Affecting]
		case SPELL_CONFUSION:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_ENERVATION:						// Necromancy
		case SPELL_FEAR:							// Necromancy [Fear, Mind-Affecting]
		case SPELL_GREATER_INVISIBILITY:			// Illusion (Glamer)
		case SPELL_LESSER_GLOBE_OF_INVULNERABILITY:	// Abjuration
		case SPELL_PHANTASMAL_KILLER:				// Illusion (Phantasm) [Fear, Mind-Affecting]
		case SPELL_POLYMORPH_SELF:					// Transmutation
		case 387: // Polymorph in Sword Spider		// See above
		case 388: // Polymorph in Troll				// See above
		case 389: // Polymorph in Humber Hulk		// See above
		case 390: // Polymorph in Gargoyle			// See above
		case 391: // Polymorph in Mindflayer		// See above
		case SPELL_SUMMON_CREATURE_IV:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_WALL_OF_FIRE:					// Evocation [Fire]
		case SPELL_EVARDS_BLACK_TENTACLES:			// Conjuration (Creation)
		case SPELL_ASSAY_RESISTANCE:				// Divination, ref. Complete Arcane
		case SPELL_CRUSHING_DESPAIR:				// Enchantment (Compulsion) [Mind-Affecting]
		case 159: //SPELL_SHADOW_CONJURATION:		// Illusion (Shadow)
		case SPELL_SHADOW_CONJURATION_SUMMON_SHADOW:// See above
		case SPELL_SHADOW_CONJURATION_DARKNESS:		// See above
		case SPELL_SHADOW_CONJURATION_INIVSIBILITY:	// See above
		case SPELL_SHADOW_CONJURATION_MAGE_ARMOR:	// See above
		case SPELL_SHADOW_CONJURATION_MAGIC_MISSILE:// See above
		case SPELL_ELEMENTAL_SHIELD:				// Evocation [Cold, Fire], D&D name : Fire Shield
		case SPELL_LESSER_SPELL_BREACH:				// Abjuration, not D&D
		case SPELL_ISAACS_LESSER_MISSILE_STORM:		// Evocation, not D&D
		case SPELL_LEAST_SPELL_MANTLE:				// Abjuration, not D&D
		case 1206: //cold orb
		case 1825: //above
		case 1207: //elec orb
		case 1827: //above
		case 1208: //fire orb
		case 1826: //above
		case 1205: //acid orb
		case 1859: //above
		case 1209: //sound orb
		case 1861: //above
		case 1212: //mass reduce person
		case 1863: //force orb
		case 2346: //above
		case 2206: //blast of flame
		case 2341: //thunderlance
		case 2342: //energy spheres
		case 2345: //viscid glob
		case 2364: //cold shield
		case 2379: //ironbones
		case 2400: //i's mantle
		case 2409: //baleful bolt
		case 2410: //locate creature
		case 2413: //mass resist energy
		case 2414: //dispel breath
		case 2422: //ran sum IV
		case 2442: //light lance
		case 2456: //rad shield
		case 2457: //blist rad
		case 2459: //drag breath
		case 2460: //drag breath
		case 2461: //drag breath
		case 2462: //drag breath
		case 2463: //drag breath
		case 2464: //drag breath
		case 2465: //drag breath
		case 2466: //drag breath
		case 2467: //drag breath
		case 2468: //drag breath

		// Level 5
		case SPELL_CLOUDKILL:						// Conjuration (Creation)
		case SPELL_CONE_OF_COLD:					// Evocation [Cold]
		case SPELL_DOMINATE_PERSON:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_FEEBLEMIND:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_HOLD_MONSTER:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_LESSER_PLANAR_BINDING:			// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_MIND_FOG:						// Enchantment (Compulsion) [Mind-Affecting],
		case SPELL_SUMMON_CREATURE_V:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_BIGBYS_INTERPOSING_HAND:			// Evocation [Force]
		case SPELL_ENERGY_BUFFER:					// Abjuration, ref. Tome and Blood
		case SPELL_FIREBRAND:						// Evocation [Fire], ref. Magic of Faerûn
		case SPELL_BALL_LIGHTNING:					// Evocation [Electricity], ref. Magic of Faerûn & PGtF
		case SPELL_MESTILS_ACID_SHEATH:				// Conjuration (Creation) [Acid], ref. Magic of Faerûn
		case SPELL_GREATER_FIREBURST:				// Evocation [Fire], ref. Complete Arcane
		case SPELL_PERMANENCY:						// Universal
		case SPELL_SHROUD_OF_FLAME:					// Evocation [Fire], ref. PGtF
		case SPELL_TELEPORT:						// Conjuration (Teleportation)
		case SPELL_VITRIOLIC_SPHERE:				// Conjuration (Creation) [Acid], ref. Complete Arcane
		case SPELL_LESSER_SPELL_MANTLE:				// Abjuration, not D&D
		case SPELL_LESSER_MIND_BLANK:				// Abjuration, not D&D
		case SPELL_SPHERE_OF_CHAOS:					// Alteration, AD&D 2.0 (Chaos Magic)
		case SPELL_WALL_DISPEL_MAGIC:				// Abjuration, ref. Underdark
		case SPELL_POWER_WORD_DISABLE:				// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
		case 1133:	// Glass Doppelganger			// Illusion (Shadow)
		case 1211: //greater reduce person
		case 2347: //burning blood
		case 2368: //acid sheath
		case 2372: //flensing
		case 2374: //stone sphere
		case 2397: //ball lightning
		case 2398: //major missile
		case 2408: //h's vibration
		case 2423: //ran sum V
		case 2441: //acid rain
		case 2443: //moonbow
		case 2452: //storm touch
		case 2454: //shrieking blast
//		case 2483: //cyclone blast

		// Level 6
		case SPELL_ACID_FOG:						// Conjuration (Creation) [Acid]
		case SPELL_CHAIN_LIGHTNING:					// Evocation [Electricity]
		case SPELL_CIRCLE_OF_DEATH:					// Necromancy [Death]
		case SPELL_GLOBE_OF_INVULNERABILITY:		// Abjuration
		case SPELL_GREATER_DISPELLING:				// Abjuration
		case SPELL_PLANAR_BINDING:					// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_VI:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_TENSERS_TRANSFORMATION:			// Transmutation
		case SPELL_LEGEND_LORE:						// Divination
		case SPELL_BIGBYS_FORCEFUL_HAND:			// Evocation [Force]
		case SPELL_FLESH_TO_STONE:					// Transmutation
		case SPELL_STONE_TO_FLESH:					// Transmutation
		case SPELL_CONTINGENCY:						// Evocation
		case SPELL_DISINTEGRATE:					// Transmutation
		case SPELL_GREATER_HEROISM:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_REPULSION:						// Abjuration
		case SPELL_STONE_BODY:						// Transmutation, ref. PGtF
		case SPELL_GREATER_SPELL_BREACH:			// Abjuration, not D&D
		case SPELL_MASS_HASTE:						// Enchantment, not D&D
		case SPELL_ETHEREAL_VISAGE:					// Illusion, not D&D
		case SPELL_ISAACS_GREATER_MISSILE_STORM:	// Evocation, not D&D
		case SPELL_MASS_FOX_CUNNING:				// Transmutation
		case JX_SPELL_ANALYZEDWEOMER:				// Divination
		case 1851: //greater dispel
		case 1852: //above
		case 1853: //above
		case 2205: //freezing sphere
		case 2311: //acid storm
		case 2327: //glass strike
		case 2424: //ran sum VI
		case 2429: //sum huge elem
		case 2432: //sum huge elem
		case 2435: //sum huge elem
		case 2438: //sum huge elem
		case 2444: //r's fire ring
		case 2451: //crush sphere
//		case 2485: //great minspin

		// Level 7
		case SPELL_CONTROL_UNDEAD:					// Necromancy
		case SPELL_DELAYED_BLAST_FIREBALL:			// Evocation [Fire]
		case SPELL_FINGER_OF_DEATH:					// Necromancy [Death]
		case SPELL_MORDENKAINENS_SWORD:				// Evocation [Force]
		case SPELL_PRISMATIC_SPRAY:					// Evocation
		case SPELL_SUMMON_CREATURE_VII:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_BIGBYS_GRASPING_HAND:			// Evocation [Force]
		case SPELL_LIMITED_WISH:					// Universal
		case SPELL_MASS_HOLD_PERSON:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_MASS_INVISIBILITY:				// Illusion (Glamer)
		case SPELL_SPELL_TURNING:					// Abjuration
		case SPELL_GREATER_TELEPORT:				// Conjuration (Teleportation)
		case 71: //SPELL_GREATER_SHADOW_CONJURATION:		// Illusion (Shadow)
		case SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW:// See above
		case SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW:	// See above
		case SPELL_GREATER_SHADOW_CONJURATION_MIRROR_IMAGE:	// See above
		case SPELL_GREATER_SHADOW_CONJURATION_WEB:			// See above
		case SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE:	// See above
		case SPELL_SHADOW_SHIELD:							// Illusion
		case 724: // Ethereal Jaunt					// Transmutation
		case SPELL_POWORD_BLIND:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_AVASCULATE:						// Necromancy [Death, Evil], ref. Libris Mortis
		case SPELL_HISS_OF_SLEEP:					// Enchantment (Compulsion) [Mind-Affecting], ref. Spell Compendium
		case 1129:	// Solipsism					// Illusion (Phantasm) [Mind-Affecting], ref. Spell Compendium
		case 2332: //great thunderclap
		case 2407: //z's prison
		case 2425: //ran sum VII
		case 2430: //sum great elem
		case 2433: //sum great elem
		case 2436: //sum great elem
		case 2439: //sum great elem
//		case 2486: //time reaver

		// Level 8
		case SPELL_GREATER_PLANAR_BINDING:			// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_INCENDIARY_CLOUD:				// Conjuration (Creation) [Fire]
		case SPELL_MASS_CHARM:						// Enchantment (Charm) [Mind-Affecting]
		case SPELL_MIND_BLANK:						// Abjuration
		case SPELL_POWER_WORD_STUN:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_PROTECTION_FROM_SPELLS:			// Abjuration
		case SPELL_SUMMON_CREATURE_VIII:			// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_HORRID_WILTING:					// Necromancy
		case SPELL_BIGBYS_CLENCHED_FIST:			// Evocation [Force]
		case SPELL_BLACKSTAFF:						// Transmutation, ref. Magic of Faerûn
		case SPELL_IRON_BODY:						// Transmutation
		case SPELL_POLAR_RAY:						// Evocation [Cold]
		case SPELL_STALKING_SPELL:					// Illusion (Glamer), ref. Savage Species
		case SPELL_MASS_BLINDNESS_AND_DEAFNESS:		// Illusion, not D&D
		case SPELL_PREMONITION:						// Divination, not D&D
		case SPELL_POWORD_PETRIFY:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_GREATER_WALL_DISPEL_MAGIC:		// Abjuration, ref. Underdark
		case 2204: //maddening scream
		case 2363: //ny's castigate
		case 2405: //z's razors
		case 2426: //ran sum VIII
		case 2431: //sum eld elem
		case 2434: //sum eld elem
		case 2437: //sum eld elem
		case 2440: //sum eld elem
//		case 2473: //skele guard
//		case 2474: //devastate undead

		// Level 9
		case SPELL_DOMINATE_MONSTER:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_ENERGY_DRAIN:					// Necromancy
		case SPELL_GATE:							// Conjuration (Creation or Calling)
		case SPELL_METEOR_SWARM:					// Evocation [Fire]
		case SPELL_METEOR_SWARM_TARGET_SELF:		// Evocation [Fire]
		case SPELL_METEOR_SWARM_TARGET_LOCATION:	// Evocation [Fire]
		case SPELL_METEOR_SWARM_TARGET_CREATURE:	// Evocation [Fire]
		case SPELL_MORDENKAINENS_DISJUNCTION:		// Abjuration
		case SPELL_POWER_WORD_KILL:					// Enchantment (Compulsion) [Death, Mind-Affecting]
		case SPELL_SUMMON_CREATURE_IX:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_TIME_STOP:						// Transmutation
		case 2365: //above
		case SPELL_WAIL_OF_THE_BANSHEE:				// Necromancy [Death, Sonic]
		case SPELL_WEIRD:							// Illusion (Phantasm) [Fear, Mind-Affecting]
		case SPELL_ETHEREALNESS:					// Transmutation
		case SPELL_BIGBYS_CRUSHING_HAND:			// Evocation [Force]
		case SPELL_BLACK_BLADE_OF_DISASTER:			// Conjuration (Creation), ref. Magic of Faerûn
		case SPELL_MASS_HOLD_MONSTER:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_WISH:							// Universal
		case 158: //SPELL_SHADES:					// Illusion (Shadow)
		case SPELL_SHADES_TARGET_CASTER:			// See above
		case SPELL_SHADES_TARGET_CREATURE:			// See above
		case SPELL_SHADES_TARGET_GROUND:			// See above
		case SPELL_SHADES_SUMMON_SHADOW:			// See above
		case SPELL_SHADES_CONE_OF_COLD:				// See above
		case SPELL_SHADES_FIREBALL:					// See above
		case SPELL_SHADES_STONESKIN:				// See above
		case SPELL_SHADES_WALL_OF_FIRE:				// See above
		case SPELL_GREATER_SPELL_MANTLE:			// Abjuration, not D&D
		case 1132:	// Shadow Simulacrum			// Illusion (Shadow), ref. Polyhedron #144
		case 1854: //mord's disjunc
		case 1855: //above
		case 1856: //above
		case 2348: //eleminster's ep
		case 2349: //ult sphere
		case 2373: //blackblade
		case 2406: //z's avalanche
		case 2411: //foresight
		case 2427: //ran sum IX
		case 2450: //pris deluge


//-------------//
// Epic Spells //
//-------------//

		// Epic spells
		case SPELL_EPIC_HELLBALL:
		case SPELL_EPIC_MUMMY_DUST:
		case SPELL_EPIC_DRAGON_KNIGHT:
		case SPELL_EPIC_MAGE_ARMOR:
		case SPELL_EPIC_RUIN:
		case 695:	// Warding
		case 1076:	// Damnation
		case SPELL_ENTROPIC_HUSK:
		case 1078:	// Epic Gate
		case 1079:	// Mass Fowl
		case 1080:	// Vampiric Feast


//---------------//
// Magical Items //
//---------------//

		// Miscellaneous
		case SPELL_ROD_OF_WONDER:					// Randomly fire spells
		case SPELL_ELEMENTAL_SUMMONING_ITEM:		// Summon elemental creature
		case SPELL_DECK_OF_MANY_THINGS:				// Random effects
		case SPELL_DECK_AVATAR:
		case SPELL_DECK_GEMSPRAY:
		case SPELL_DECK_BUTTERFLYSPRAY:
		case SPELL_POWERSTONE:						// Many abilities
		case SPELL_SPELLSTAFF:						// Fire 3 spells
		case 509: //SPELL_CHARGER:					// Recharge an item
		case SPELL_DECHARGER:						// Decharge an item
		case 1159:									// Disruption

		// Ioun Stones
		case SPELL_IOUN_STONE_DUSTY_ROSE:
		case SPELL_IOUN_STONE_PALE_BLUE:
		case SPELL_IOUN_STONE_SCARLET_BLUE:
		case SPELL_IOUN_STONE_BLUE:
		case SPELL_IOUN_STONE_DEEP_RED:
		case SPELL_IOUN_STONE_PINK:
		case SPELL_IOUN_STONE_PINK_GREEN:
		case SPELLABILITY_IOUN_STONE_STR:
		case SPELLABILITY_IOUN_STONE_DEX:
		case SPELLABILITY_IOUN_STONE_CON:
		case SPELLABILITY_IOUN_STONE_INT:
		case SPELLABILITY_IOUN_STONE_WIS:
		case SPELLABILITY_IOUN_STONE_CHA:

		// Spell Sequencer
		case 717:									// Activate 1
		case 718:									// Activate 2
		case 719:									// Activate 3
		case 720:									// Clear

		// Item Unique Power
		case SPELLABILITY_ACTIVATE_ITEM:			// (Unique Power)
		case 413: // Activate Item Self				// (Unique Power Self Only)
		case SPELL_ACTIVATE_ITEM_PORTAL:			// (Manipulate Portal Stone)
		case 700: // Activate Item OnHit			// (On Hit Cast Spell)


//---------------//
// Miscellaneous //
//---------------//

		case SPELL_GREATER_EAGLE_SPLENDOR:
		case SPELL_GREATER_OWLS_WISDOM:
		case SPELL_GREATER_FOXS_CUNNING:
		case SPELL_GREATER_BULLS_STRENGTH:
		case SPELL_GREATER_CATS_GRACE:
		case SPELL_GREATER_BEARS_ENDURANCE:
		case SPELL_CATAPULT:
		case SPELL_INFINITE_RANGE_FIREBALL:
		case 562: // Aura of Glory
		case 563: // Haste - Slow
		case 564: // Summon Shadow
		case 565: // Tide of Battle
		case 566: // Evil Blight
		case 567: // Cure Critical Wounds, Other
		case 568: // Restoration, Other
		case 615: // Twin Fists
		case 616: // Lich Lyrics
		case 617: // Ice Berry
		case 618: // Flame Berry
		case 619: // Prayer Box
		case 668: // OnHit : Teleport
		case 669: // OnHit : Chaos Shield
		case 696: // OnHit : Fire Damage (flaming weapon)
		case 702: // OnHit : Planar Rift
		case 703: // OnHit : Darkfire (flaming weapon)
		case 721: // OnHit : Flaming Skin
		case 761: // Aura of Hellfire
		case 762: // Hell Inferno
		case 772: // Accelerating Fireball
		case 790: // OnHit : Deafening Clang
		case 791: // OnHit : Knockdown
		case 792: // OnHit : Freeze
		case 1793: //blasphemy
		case 1794: //holy word
		case 1796: //scourge
		case 1797: //inspire hatred
		case 1798: //mystic prot
		case 1799: //pain touch
		case 1800: //death touch
		case 1980: //above
		case 1801: //control undead
		case 1929: //justice mark
		case 1981: //wild touch


//--------------------//
// Creature Abilities //
//--------------------//

		case SPELLABILITY_SUMMON_SLAAD:				// Spell-like (Slaad, ref. Monster Manual)
		case SPELLABILITY_SUMMON_TANARRI:			// Spell-like (Demon, ref. Monster Manual)
		case SPELLABILITY_SUMMON_MEPHIT:			// Spell-like (?)
		case SPELLABILITY_SUMMON_CELESTIAL:			// Spell-like (?)
		case SPELLABILITY_MINDBLAST:				// Spell-like or Psionic (Mind Flayer, ref. Monster Manual)
		case SPELLABILITY_CHARMMONSTER:				// Spell-like or Psionic (Mind Flayer, ref. Monster Manual)
		case 713: // Greater Mind Blast				// Spell-like or Psionic (Mind Flayer, ref. ?)
		case 789: // Mind Blast						// Spell-like or Psionic (Mind Flayer, ref. Monster Manual)
		case 741: // Inertial Barrier				// Psionic (Mindflayer, ref. Expanded Psionics Handbook)
		case 759: // Undead Self Harm				// Spell-like (not D&D)
		case 763: // Mass Concussion				// Psionic AD&D2 (Mindflayer, ref. Psionics Handbook)


//-----------------//
// Class Abilities //
//-----------------//

		// Arcane Archer
		case SPELLABILITY_AA_IMBUE_ARROW:			// Spell-like
		case SPELLABILITY_AA_SEEKER_ARROW_1:		// Spell-like
		case SPELLABILITY_AA_SEEKER_ARROW_2:		// Spell-like
		case SPELLABILITY_AA_HAIL_OF_ARROWS:		// Spell-like
		case SPELLABILITY_AA_ARROW_OF_DEATH:		// Spell-like

		// Arcane Trickster
		case SPELLABILITY_PILFER_MAGIC:				// Spell-like (not D&D, replaces Ranged Legerdemain)

		// Bard
		case SPELLABILITY_SONG_COUNTERSONG:			// Supernatural
		case SPELLABILITY_SONG_FASCINATE:			// Spell-like
		case SPELLABILITY_SONG_HAVEN_SONG:			// Spell-like (not D&D)
		case SPELLABILITY_SONG_CLOUD_MIND:			// Spell-like (not D&D)
		case SPELLABILITY_SONG_IRONSKIN_CHANT:		// Spell-like (not D&D)
		case SPELLABILITY_SONG_OF_FREEDOM:			// Spell-like
		case SPELLABILITY_SONG_LEAVETAKINGS:		// Spell-like (not D&D)
		case SPELLABILITY_SONG_THE_SPIRIT_OF_THE_WOOD:		// Spell-like (not D&D)
		case SPELLABILITY_SONG_THE_FALL_OF_ZEEAIRE:	// Spell-like (not D&D)
		case SPELLABILITY_SONG_THE_BATTLE_OF_HIGHCLIFF:		// Spell-like (not D&D)
		case SPELLABILITY_SONG_THE_SIEGE_OF_CROSSROAD_KEEP:	// Spell-like (not D&D)
		case SPELLABILITY_SONG_A_TALE_OF_HEROES:	// Spell-like (not D&D)
		case SPELLABILITY_SONG_THE_TINKERS_SONG:	// Spell-like (not D&D)
		case SPELLABILITY_SONG_DIRGE_OF_ANCIENT_ILLEFARN:	// Spell-like (not D&D)
		case SPELLABILITY_SONG_OF_AGES:				// Spell-like (not D&D)
		case SPELLABILITY_EPIC_CURSE_SONG:			// Spell-like (not D&D)
		case 411: // Bard song						// Spell-like (not D&D)
		case 2011:
		case 2017:
		
		// Paladin
		case SPELLABILITY_DETECT_EVIL:				// Spell-like
		case SPELLABILITY_REMOVE_DISEASE:			// Spell-like

		// Pale Master
		case SPELLABILITY_PM_ANIMATE_DEAD:			// Spell-like (ref. Tome and Blood)

		// Psionic
		case SPELLABILITY_LESSER_BODY_ADJUSTMENT:	// Psionic Manifestation (ref. Expanded Psionic Handbook)
//      case SPELL_MASS_DOMINATION:					// Psionic Manifestion (Psionics Handbook)

		// Shadowdancer
		case SPELL_SHADOW_DAZE:						// Spell-like (not D&D)

		// Shaman Spirit
		case 1095:	// Detect Spirits				// Spell-like (ref. Complete Divine)
		case 1096:	// Blessing of the Spirits		// Spell-like (ref. Complete Divine)
		case 1101:	// Warding of the Spirits		// Spell-like (ref. Complete Divine)
		case 1103:	// Spirit Journey				// Spell-like (ref. Complete Divine)
		case 1104:	// Favored of the Spirits		// Spell-like (ref. Complete Divine)
		case 1157:	// Recall Spirit				// Spell-like (ref. Complete Divine)

		// Shape Shifter
		case 688: // Darkness						// Spell-like (Drider, ref. Monster Manual)
		case 693: // Mind Blast						// Spell-like (Mindflayer, ref. Monster Manual)

		// Warlock
		case SPELLABILITY_I_ELDRITCH_BLAST:			// Spell-like (ref. Complete arcane)
		case 949:									// See above
		case 950:									// See above
		case 951:									// See above
		case 952:									// See above
		case 953:									// See above
		case 954:									// See above
		case 955:									// See above
		case 956:									// See above
		case 1061:									// See above
		case 1062:									// See above
		case 1063:									// See above
		case 1064:									// See above
		case 1065:									// See above
		case 1081:	// Imbue Item					// Spell-like

		// Warpriest
		case 961: // Mass Cure Light Wounds			// Spell-like (ref. Defender of the Faith)
		case 963: // Battletide						// Spell-like (not D&D)
		case 964: // Haste							// Spell-like (D&D modified, ref. Defender of the Faith)
		case 965: // Mass Healing					// Spell-like (ref. Defender of the Faith)
		case SPELLABILITY_IMPLACABLE_FOE:			// Spell-like (ref. Defender of the Faith)
//		case SPELL_REMOVE_FEAR:						// Spell-like (should be Extraordinary in Defender of the Faith (Rally) but same spell is used by wizard...)

		//Bladesinger
		case 1889:
		case 1890:

		// Doomguide
		case 1184:
		
		//Elemental Archer
		case 1954:
		case 1955:

		//Stormsinger
		case 1894:
		case 1895:
		case 1896:
		case 1897:
		case 1898:
		case 1899:
		
		//Lion of Tal
		case 1911:
		
		//Swiftblade
		case 1913:
		
		//Master of Radiance
		case 1943:
		case 1944:
		
		//Dragon Slayer
		case 1987:
		
		//Discordant Note
		case 2041:
		
		//Vanguard
		case 2067:
		
		//Disciple of Meph
		case 2357:
		case 2359:
		case 2360:
		case 2488:
		case 2489:
		
		//Archamge
		case 2477:
		case 2490:
		case 2491:
		case 2492:
		case 2493:
		case 2494:
		case 2495:
		case 2496:
		case 2497:


//----------------//
// Race Abilities //
//----------------//

		// Aasimar
		case SPELLABILITY_LIGHT:					// Spell-like (ref. FRCS)

		// Drow
		case SPELLABILITY_DARKNESS:					// Spell-like (ref. FRCS)
		case 805: // Faerie Fire					// Spell-like (ref. FRCS)
		case 1941: //above

		// Duergar
		case 803: // Enlarge Person					// Spell-like (ref. Monster Manual)
		case 804: // Invisibility					// Spell-like (ref. Monster Manual)

		// Genasi
		case SPELLABILITY_SUMMON_GALE:				// Spell-like (not D&D, replaces Mingle with Wind (ref. Monsters of Faerûn))
		case SPELLABILITY_MERGE_WITH_STONE:			// Spell-like (ref. Monsters of Faerûn)
		case SPELLABILITY_REACH_TO_THE_BLAZE:		// Spell-like (ref. Monsters of Faerûn)
		case SPELLABILITY_SHROUDING_FOG:			// Spell-like (not D&D, replaces Call to the Wave (ref. Monsters of Faerûn))

		// Svirfneblin
//		case SPELL_POLYMORPH_SELF:					// Spell-like (ref. Underdark (Disguise Self), same as wizard)
		case 806: // Blur							// Spell-like (ref. Underdark)
		case 946: // Blindness/Deafness				// Spell-like (ref. Underdark)

		// Miscellaneous
		case SPELLABILITY_WORD_OF_FAITH:			// Spell-like (not D&D)
		case SPELLABILITY_MASS_CHARM_MONSTER:		// Spell-like (not D&D)
		case SPELLABILITY_SUMMON_PLANETAR:			// Spell-like (not D&D)
		
		// Yuanti
		case 1196: //darkness


//-----------------------------//
// Official Campaign Abilities //
//-----------------------------//

		// PC Powers
		case SPELLABILITY_CLEANSING_NOVA:			// Spell-like (not D&D)
		case SPELLABILITY_SHINING_SHIELD:			// Spell-like (not D&D)
		case SPELLABILITY_SOOTHING_LIGHT:			// Spell-like (not D&D)
		case SPELLABILITY_AURORA_CHAIN:				// Spell-like (not D&D)
		case SPELLABILITY_WEB_OF_PURITY:			// Spell-like (not D&D)

		// Spells
		case SPELL_TRUE_NAME:
		case SPELL_TRUE_NAME_TWO:
		case SPELL_TRUE_NAME_THREE:

			return TRUE;
	}
	return FALSE;
}

// Indicate if a spell is a supernatural ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is a supernatural ability
int JXImplGetIsSpellSupernatural(int iSpellId)
{
	switch (iSpellId)
	{
//-----------------------//
// Miscellaneous Effects //
//-----------------------//

		// Auras
		case SPELLABILITY_AURA_BLINDING:
		case SPELLABILITY_AURA_COLD:
		case SPELLABILITY_AURA_ELECTRICITY:
		case SPELLABILITY_AURA_FEAR:
		case SPELLABILITY_AURA_FIRE:
		case SPELLABILITY_AURA_MENACE:
		case SPELLABILITY_AURA_PROTECTION:
		case SPELLABILITY_AURA_STUN:
		case SPELLABILITY_AURA_UNEARTHLY_VISAGE:
		case SPELLABILITY_AURA_UNNATURAL:

		// Bolts
		case SPELLABILITY_BOLT_ABILITY_DRAIN_CHARISMA:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_CONSTITUTION:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_DEXTERITY:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_INTELLIGENCE:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_STRENGTH:
		case SPELLABILITY_BOLT_ABILITY_DRAIN_WISDOM:
		case SPELLABILITY_BOLT_ACID:
		case SPELLABILITY_BOLT_CHARM:
		case SPELLABILITY_BOLT_COLD:
		case SPELLABILITY_BOLT_CONFUSE:
		case SPELLABILITY_BOLT_DAZE:
		case SPELLABILITY_BOLT_DEATH:
		case SPELLABILITY_BOLT_DISEASE:
		case SPELLABILITY_BOLT_DOMINATE:
		case SPELLABILITY_BOLT_FIRE:
		case SPELLABILITY_BOLT_KNOCKDOWN:
		case SPELLABILITY_BOLT_LEVEL_DRAIN:
		case SPELLABILITY_BOLT_LIGHTNING:
		case SPELLABILITY_BOLT_PARALYZE:
		case SPELLABILITY_BOLT_POISON:
		case SPELLABILITY_BOLT_SHARDS:
		case SPELLABILITY_BOLT_SLOW:
		case SPELLABILITY_BOLT_STUN:
		case SPELLABILITY_BOLT_WEB:

		// Cones
		case SPELLABILITY_CONE_ACID:
		case SPELLABILITY_CONE_COLD:
		case SPELLABILITY_CONE_DISEASE:
		case SPELLABILITY_CONE_FIRE:
		case SPELLABILITY_CONE_LIGHTNING:
		case SPELLABILITY_CONE_POISON:
		case SPELLABILITY_CONE_SONIC:
		
		// Feats
		case 1915:
		case 1916:
		case 1917:
		case 1918:
		case 2016:

		// Gazes
		case SPELLABILITY_GAZE_CHARM:
		case SPELLABILITY_GAZE_CONFUSION:
		case SPELLABILITY_GAZE_DAZE:
		case SPELLABILITY_GAZE_DEATH:
		case SPELLABILITY_GAZE_DESTROY_CHAOS:
		case SPELLABILITY_GAZE_DESTROY_EVIL:
		case SPELLABILITY_GAZE_DESTROY_GOOD:
		case SPELLABILITY_GAZE_DESTROY_LAW:
		case SPELLABILITY_GAZE_DOMINATE:
		case SPELLABILITY_GAZE_DOOM:
		case SPELLABILITY_GAZE_FEAR:
		case SPELLABILITY_GAZE_PARALYSIS:
		case SPELLABILITY_GAZE_STUNNED:

		// Howls
		case SPELLABILITY_HOWL_CONFUSE:
		case SPELLABILITY_HOWL_DAZE:
		case SPELLABILITY_HOWL_DEATH:
		case SPELLABILITY_HOWL_DOOM:
		case SPELLABILITY_HOWL_FEAR:
		case SPELLABILITY_HOWL_PARALYSIS:
		case SPELLABILITY_HOWL_SONIC:
		case SPELLABILITY_HOWL_STUN:

		// Pulses
		case SPELLABILITY_PULSE_DROWN:
		case SPELLABILITY_PULSE_SPORES:
		case SPELLABILITY_PULSE_WHIRLWIND:
		case SPELLABILITY_PULSE_FIRE:
		case SPELLABILITY_PULSE_LIGHTNING:
		case SPELLABILITY_PULSE_COLD:
		case SPELLABILITY_PULSE_NEGATIVE:
		case SPELLABILITY_PULSE_HOLY:
		case SPELLABILITY_PULSE_DEATH:
		case SPELLABILITY_PULSE_LEVEL_DRAIN:
		case SPELLABILITY_PULSE_ABILITY_DRAIN_INTELLIGENCE:
		case SPELLABILITY_PULSE_ABILITY_DRAIN_CHARISMA:
		case SPELLABILITY_PULSE_ABILITY_DRAIN_CONSTITUTION:
		case SPELLABILITY_PULSE_ABILITY_DRAIN_DEXTERITY:
		case SPELLABILITY_PULSE_ABILITY_DRAIN_STRENGTH:
		case SPELLABILITY_PULSE_ABILITY_DRAIN_WISDOM:
		case SPELLABILITY_PULSE_POISON:
		case SPELLABILITY_PULSE_DISEASE:
		

//--------------------//
// Creature Abilities //
//--------------------//

		// Dragon Abilities
		case SPELLABILITY_DRAGON_BREATH_ACID:		// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_COLD:		// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_FEAR:		// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_FIRE:		// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_GAS:		// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_LIGHTNING:	// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_PARALYZE:	// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_SLEEP:		// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_SLOW:		// Supernatural, ref. Monster Manual (Breath Weapon)
		case SPELLABILITY_DRAGON_BREATH_WEAKEN:		// Supernatural, ref. Monster Manual (Breath Weapon)
//		case SPELLABILITY_DRAGON_BREATH_NEGATIVE:	// = 658 (wrong value, should be 698)
		case 698: // Breath Negative				// Supernatural, ref. Monster Manual (Breath Weapon)
		case 771: // Breath Prismatic				// Supernatural, ref. Epic Level Handbook (Breath Weapon)
		case 757: // Shadow Blend					// Supernatural, ref. Monsters of Faerûn (Shadow Dragon)
		case 760: // Paralyzing Touch				// Supernatural, ref. FRCS (Dracolich)
		case 774: // Deflecting Force				// Supernatural, ref. Epic Level Handbook (Prismatic Dragon)

		// Other Monsters Abilities
		case SPELLABILITY_GOLEM_BREATH_GAS:			// Supernatural (Golem, ref. Monster Manual)
		case SPELLABILITY_HELL_HOUND_FIREBREATH:	// Supernatural (Hell Hound, ref. Monster Manual)
		case SPELLABILITY_KRENSHAR_SCARE:			// Supernatural (Krenchar, ref. Monster Manual)
		case SPELLABILITY_MEPHIT_SALT_BREATH:		// Supernatural (Mephit, ref. Monster Manual)
		case SPELLABILITY_MEPHIT_STEAM_BREATH:		// Supernatural (Mephit, ref. Monster Manual)
		case SPELLABILITY_MUMMY_BOLSTER_UNDEAD:		// Supernatural (Mummy, ref. ?)
		case SPELLABILITY_TRUMPET_BLAST:			// Supernatural (Trumpet Archon, ref. Monster Manual)
		case SPELLABILITY_TYRANT_FOG_MIST:			// Supernatural (Zombie Tyrantfog, ref. Monsters of Faerûn)
		case SPELLABILITY_BREATH_PETRIFY:			// Supernatural (?)
		case SPELLABILITY_TOUCH_PETRIFY:			// Supernatural (?)
		case SPELLABILITY_GAZE_PETRIFY:				// Supernatural (Basilik & Medusa, ref. Monster Manual)
		case 686: // Captiving Song					// Supernatural (Harpy, ref. Monster Manual)
		case 710: // Eye Rays						// Supernatural (Eyeball, ref. Monsters of Faerûn)
		case 711:									// See above
		case 712:									// See above
		case 727: // Antimagic Cone					// Supernatural (Beholder, ref. Monster Manual)
		case 776: // Eye Ray (Finger of Death)		// Supernatural (Beholder, ref. Monster Manual)
		case 777: // Eye Ray (Telekinesis)			// See above
		case 778: // Eye Ray (Flesh to Stone)		// See above
		case 779: // Eye Ray (Charm Monster)		// See above
		case 780: // Eye Ray (Slow)					// See above
		case 783: // Eye Ray (Inflict Moderate Wounds)	// See above
		case 784: // Eye Ray (Fear)					// See above
		case 785: // Eye Ray (not implemented)		// See above
		case 786: // Eye Ray (not implemented)		// See above
		case 787: // Eye Ray (not implemented)		// See above
		case 769: // Strength Attack				// Supernatural (Shadow, ref. Monster Manual)
		case 991: // Air Elemental Appearance
		case 1134:	// Abyssal Blast				// Supernatural (Death Knight, ref. Monster Manual II)
		case 1155:	// Constitution Drain			// Supernatural (Dread Wraith)
		case 1156:	// Paralyzing Touch				// Supernatural (Demilich, ref. Epic Level Handbook)


//-----------------//
// Class Abilities //
//-----------------//

		//Annointed Knight
		case 1900:
		case 1901:
		case 1902:
		case 1903:
		case 1904:
		case 1905:
		case 1906:

		// Bard
		case SPELLABILITY_SONG_INSPIRE_COURAGE:		// Supernatural
		case SPELLABILITY_SONG_INSPIRE_COMPETENCE:	// Supernatural
		case SPELLABILITY_SONG_INSPIRE_DEFENSE:		// Supernatural (not D&D)
		case SPELLABILITY_SONG_INSPIRE_REGENERATION:// Supernatural (not D&D)
		case SPELLABILITY_SONG_INSPIRE_TOUGHNESS:	// Supernatural (not D&D)
		case SPELLABILITY_SONG_INSPIRE_SLOWING:		// Supernatural (not D&D)
		case SPELLABILITY_SONG_INSPIRE_JARRING:		// Supernatural (not D&D)
		case SPELLABILITY_SONG_INSPIRE_HEROICS:		// Supernatural
		case SPELLABILITY_SONG_INSPIRE_LEGION:		// Supernatural (not D&D)
		case 1158:	// Chorus of Heroism			// Supernatural (not D&D)

		//Black Flame Zealot
		case 1790:
		case 1791:
		
		// Blackguard
		case SPELLABILITY_BG_CREATEDEAD:			// Supernatural (Command Undead)
		case SPELLABILITY_BG_FIENDISH_SERVANT:		// Supernatural
		case SPELLABLILITY_AURA_OF_DESPAIR:			// Supernatural

		//Champ of the Silver Flame
		case 2024:
		
		//Child of Night
		case 2030:
		case 2031:
		case 2032:
		
		//Chosen of Mystra
		case 2396:
		
		// Cleric
		case SPELLABILITY_TURN_UNDEAD:				// Supernatural
		case SPELLABILITY_BATTLE_MASTERY:			// Supernatural (War Domain power, not D&D)
		case SPELLABILITY_DIVINE_STRENGTH:			// Supernatural (Strenght Domain power, not D&D)
		case SPELLABILITY_DIVINE_PROTECTION:		// Supernatural (Protection Domain power, not D&D)
		case SPELLABILITY_NEGATIVE_PLANE_AVATAR:	// Supernatural (Death Domain power, not D&D)
		case SPELLABILITY_DIVINE_TRICKERY:			// Supernatural (Trickery Domain power, modified D&D)
		case SPELL_DIVINE_MIGHT:					// Divine (Supernatural)
		case SPELL_DIVINE_SHIELD:					// Divine (Supernatural)
		
		//Daggerspell mage
		case 2068:
		
		//Disciple of Meph
		case 2353:
		case 2358:
		case 2361:
		case 2362:

		// Divine Champion
		case SPELLABILITY_DC_DIVINE_WRATH:			// Supernatural (ref. FRCS)
		case 643 : // Smite Infidel					// Supernatural (ref. FRCS)
		
		//Divine Seeker
		case 1834:
		case 1835:
		case 1836:
		
		// Doomguide
		case 1183:
		
		//Dragon Warrior
		case 2039:

		// Druid
		case SPELLABILITY_ELEMENTAL_SHAPE:			// Supernatural
		case 397: // Elemental shape Fire			// See above
		case 398: // Elemental shape Water			// See above
		case 399: // Elemental shape Earth			// See above
		case 400: // Elemental shape Air			// See above
		case SPELLABILITY_WILD_SHAPE:				// Supernatural
		case SPELLABILITY_WILD_SHAPE_BROWN_BEAR:	// see above
		case SPELLABILITY_WILD_SHAPE_PANTHER:		// see above
		case SPELLABILITY_WILD_SHAPE_WOLF:			// see above
		case SPELLABILITY_WILD_SHAPE_BOAR:			// see above
		case SPELLABILITY_WILD_SHAPE_BADGER:		// see above
		case SPELLABILITY_PLANT_WILD_SHAPE:			// see above
		case SPELLABILITY_PLANT_WILD_SHAPE_SHAMBLING_MOUND:	// see above
		case SPELLABILITY_PLANT_WILD_SHAPE_TREANT:	// see above
		case 725: // Dragon Shape					// Supernatural (ref. Epic Level Handbook)
		case 707: // Dragon Shape Red				// see above
		case 708: // Dragon Shape Blue				// see above
		case 709: // Dragon Shape Black				// see above
		case 1932:
		case 1933:
		case 1934:
		case 1935:
		case 1936:
		case 1937:
		case 1938:
		case 2010:
		
		//Eldrich Disciple
		case 2033:
		case 2034:
		case 2035:
		case 2036:
		
		//Elemental Warrior
		case 2004:
		case 2006:
		case 2007:
		
		//Forest Master
		case 1958:
		case 1959:
		case 1960:

		// Frenzied Berserker
		case SPELLABILITY_INSPIRE_FRENZY:			// Supernatural (ref. Masters of the Wild)

		// Harper Scout
		case SPELL_TYMORAS_SMILE:					// Supernatural (ref. FRCS)
		case 947: // Dominate Animal				// Supernatural (not D&D)
		
		//Heartwarder
		case 1968:
		case 1969:

		// Hellfire Warlock
		case 1187:
		case 1188:
		case 1190:
		
		//Lion of Tal
		case 1910:
		
		//Master of Radiance
		case 1945:
		
		// Monk
		case SPELLABILITY_WHOLENESS_OF_BODY:		// Supernatural
		case SPELLABILITY_QUIVERING_PALM:			// Supernatural
		case SPELLABILITY_EMPTY_BODY:				// Supernatural
		case 1948:
		case 1949:

		// Neverwinter Nine
		case 929: // Guarding the Lord				// Supernatural (Not D&D)
		case SPELLABILITY_PROTECTIVE_AURA:			// Supernatural (Not D&D)

		// Paladin
		case SPELLABILITY_LAY_ON_HANDS:				// Supernatural
		case SPELLABILITY_AURA_OF_COURAGE:			// Supernatural
		case SPELLABILITY_SMITE_EVIL:				// Supernatural
		case 1802:
		case 1841:
		case 1842:
		case 2042:
		case 2043:
		case 2044:

		// Pale Master
		case SPELLABILITY_PM_SUMMON_UNDEAD:			// Supernatural (ref. Tome and Blood)
		case SPELLABILITY_PM_UNDEAD_GRAFT_1:		// Supernatural (ref. Tome and Blood)
		case SPELLABILITY_PM_UNDEAD_GRAFT_2:		// Supernatural (ref. Tome and Blood)
		case SPELLABILITY_PM_SUMMON_GREATER_UNDEAD:	// Supernatural (ref. Tome and Blood)
		case SPELLABILITY_PM_DEATHLESS_MASTER_TOUCH:// Supernatural (ref. Tome and Blood)
		case 1801:

		// Red Dragon Disciple
		case 690: // Breath Weapon					// Supernatural
		case 1803:
		case 1808:
		case 1809:
		case 1810:
		case 1811:

		// Sacred Fist
		case 1123:	// Sacred Flames				// Supernatural, ref. Complete Divine
		
		//Shadow Stalker
		case 1984:
		case 1985:

		// Shadowdancer
		case SPELL_SUMMON_SHADOW:					// Supernatural
		case SPELL_SHADOW_EVADE:					// Supernatural (not D&D)

		// Shape Shifter
		case SPELLABILITY_EPIC_SHAPE_DRAGONKIN:		
		case SPELLABILITY_EPIC_SHAPE_DRAGON:		
		case 663: // Wyrmling Breath Cold			// Supernatural, ref. Monster Manual (Breath Weapon)
		case 664: // Wyrmling Breath Acid			// Supernatural, ref. Monster Manual (Breath Weapon)
		case 665: // Wyrmling Breath Fire			// Supernatural, ref. Monster Manual (Breath Weapon)
		case 666: // Wyrmling Breath Gas			// Supernatural, ref. Monster Manual (Breath Weapon)
		case 667: // Wyrmling Breath Lightning		// Supernatural, ref. Monster Manual (Breath Weapon)
		case 687: // Petrifying Gaze				// Supernatural, ref. Monster Manual (Basilik & Medusa)
		case 796: // Epic Dragon Breath Lightning	// Supernatural, ref. Epic Level Handbook (Breath Weapon)
		case 797: // Epic Dragon Breath Fire		// Supernatural, ref. Epic Level Handbook (Breath Weapon)
		case 798: // Epic Dragon Breath Gas			// Supernatural, ref. Epic Level Handbook (Breath Weapon)
		case 799: // Invisibility (Gazeous Form modified	// Supernatural, ref. Monster Manual (Vampire)
		case 800: // Dominate						// Supernatural, ref. Monster Manual (Vampire)
		case 802: // Energy Drain					// Supernatural, ref. Monster Manual (Spectre)

		// Shining Blade
		case 1789:
		case 1792:
		
		// Spirit Shaman
		case 1094:	// Chastise Spirits				// Supernatural, ref. Complete Divine
		case 1102:	// Spirit Form					// Supernatural, ref. Complete Divine
		case 1105:	// Weaken Spirits				// Supernatural, ref. Complete Divine
		
		//Swiftblade
		case 1912:

		// Stormlord
		case 1107:	// Storm Avatar					// Supernatural (not D&D)
		case 1108:	// Shock Weapon					// Supernatural, ref. Faiths and Pantheons
		case 1109:	// Thundering Weapon			// Supernatural, ref. Faiths and Pantheons
		case 1110:	// Shocking Burst Weapon		// Supernatural, ref. Faiths and Pantheons
		
		//Vanguard
		case 2066:

		//Warrior of Darkness
		case 1880:
		case 1881:
		case 1882:
		case 1883:
		case 1884:
		case 1885:
		
		// Warlock
		case SPELLABILITY_FIENDISH_RESILIENCE:		// Supernatural (ref. Complete Arcane)

		// Warpriest
		case SPELLABILITY_WAR_GLORY:				// Supernatural (Glory Cleric Domain, ref. Defender of the Faith)
		case SPELLABILITY_WARPRIEST_FEAR_AURA:		// Supernatural (ref. Defender of the Faith)

		// Wizard
		case SPELLABILITY_SUMMON_FAMILIAR:			// Supernatural


//----------------//
// Race Abilities //
//----------------//

		// Svirfneblin
		case 944: // Invisibility					// Supernatural (ref. Underdark (modified Non Detection))
		case 945: // Entropic Shield				// Supernatural (ref. Underdark (modified Non Detection))


//-----------------------------//
// Official Campaign Abilities //
//-----------------------------//

		// King of Shadows
		case SPELLABILITY_KOS_DOT:					// Supernatural (not D&D)
		case SPELLABILITY_KOS_PROTECTION:			// Supernatural (not D&D)
		case SPELLABILITY_KOS_NUKE:					// Supernatural (not D&D)

		// Pre-order NWN2 Ability
		case SPELL_BLESSED_OF_WAUKEEN:				// Supernatural


//------------------------//
// MotB Campaign Features //
//------------------------//

		// Epic features
		case SPELLABILITY_BLAZING_AURA:				// Supernatural (not D&D)
		case SPELLABILITY_LAST_STAND:				// Supernatural (not D&D)
		case 1074:	// Song of Requiem				// Supernatural (not D&D)
		case 1075:	// rescue						// Supernatural (not D&D)

		// Spirit Eater features
		case SPELLABILITY_DEVOUR_SPIRIT:			// Supernatural (not D&D)
		case SPELLABILITY_SPIRIT_GORGE:				// Supernatural (not D&D)
		case SPELLABILITY_RAVENOUS_INCARNATION:		// Supernatural (not D&D)
		case SPELLABILITY_BESTOW_LIFE_FORCE:		// Supernatural (not D&D)
		case SPELLABILITY_SUPPRESS:					// Supernatural (not D&D)
		case SPELLABILITY_SATIATE:					// Supernatural (not D&D)
		case SPELLABILITY_DEVOUR_SOUL:				// Supernatural (not D&D)
		case SPELLABILITY_ETERNAL_REST:				// Supernatural (not D&D)
		case 1097:	// Shapers Alembic				// Supernatural (not D&D)
		case 1098:	// Shapers Alembic				// Supernatural (not D&D)
		case 1099:	// Shapers Alembic				// Supernatural (not D&D)
		case 1100:	// Shapers Alembic				// Supernatural (not D&D)
		case SPELLABILITY_MOLD_SPIRIT:				// Supernatural (not D&D)
		case SPELLABILITY_MALLEATE_SPIRIT:			// Supernatural (not D&D)
		case SPELLABILITY_SPIRITUAL_EVISCERATION:	// Supernatural (not D&D)
		case SPELLABILITY_PROVOKE_SPIRITS:			// Supernatural (not D&D)
		case SPELLABILITY_AKACHI_DEVOUR:			// Supernatural (not D&D)
		case 1140:	// Scythe Devour Spirit			// Supernatural (not D&D)
		
		
//------------------------//
// SoZ Campaign Features //
//------------------------//

		// Misc
		case 1185: //arcane nexus activation
		case 1186: //boss heal
		case 1189: //shaman something or other
		case 1215: //sacred purification

			return TRUE;
	}
	return FALSE;
}

// Indicate if a spell is an extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell is an extraordinary ability
int JXImplGetIsSpellExtraordinary(int iSpellId)
{
	switch (iSpellId)
	{
//--------------------//
// Creature Abilities //
//--------------------//

		// Ferocity (Extraordinary)
		case SPELLABILITY_FEROCITY_1:
		case SPELLABILITY_FEROCITY_2:
		case SPELLABILITY_FEROCITY_3:

		// Intensity (Extraordinary)
		case SPELLABILITY_INTENSITY_1:
		case SPELLABILITY_INTENSITY_2:
		case SPELLABILITY_INTENSITY_3:

		// Dragon Abilities
		case SPELLABILITY_DRAGON_WING_BUFFET:		// Special Attack, ref. Monster Manual (Wing)
		case SPELLABILITY_DRAGON_FEAR:				// Extraordinary, ref. Monster Manual (Frightful Presence)
		case SPELLABILITY_DRAGON_TAIL_SLAP:			// Extraordinary, ref. Monster Manual (Tail Sweep)

		// Other Monsters Abilities
		case SPELLABILITY_SMOKE_CLAW:				// Extraordinary (Belker, ref. Monster Manual)
		case SPELLABILITY_MANTICORE_SPIKES:			// Extraordinary (Manticore, ref. Monster Manual)
		case SPELLABILITY_HEZROU_STENCH:			// Extraordinary (Hezrou, ref. Monster Manual)
		case SPELLABILITY_GHAST_STENCH:				// Extraordinary (Ghast, ref. Monster Manual)
		case 715: // Ranged Slam					// Special Attack (Golem, ref. ?)
		case 716: // Extract						// Extraordinary (Mindflayer, ref. Monster Manual)
		case 731: // Web							// Extraordinary (Bebilith, ref. Monster Manual)
		case 736: // Attack logic (eye rays)		// Special Attack (Beholder)
		case 756: // Rend Armor						// Extraordinary (Bebilith, ref. Monster Manual)
		case 758: // Paralyzing Touch				// Extraordinary (Lich, ref. Monster Manual)
		case 770: // Chaos Spittle					// Extraordinary (Slaad, ref. Epic Level Handbook)
		case 775: // Rock Throwing					// Extraordinary (Giant, ref. Monster Manual)
		case 788: // Paralysis						// Extraordinary (Gelatinous Cube, ref. Monster Manual)
		case 991: // Air Elemental Appearance


//-----------------//
// Class Abilities //
//-----------------//

		// Barbarian
		case SPELLABILITY_BARBARIAN_RAGE:			// Extraordinary
		case SPELLABILITY_RAGE_3:					// Extraordinary
		case SPELLABILITY_RAGE_4:					// Extraordinary
		case SPELLABILITY_RAGE_5:					// Extraordinary
		case SPELLABILITY_EPIC_MIGHTY_RAGE:			// Extraordinary
		
		//Bard
		case 2029:
		
		//Bladsinger
		case 1888:
		
		//Champ of the Wild
		case 1972:
		case 1973:
		case 1974:
		
		//Dervish
		case 2008:
		case 2009:
		case 2046:
		case 2047:
		
		// Dread Commando
		case 1879:
		
		// dread pirate
		case 2061:
		case 2062:
		
		// Druid
		case SPELLABILITY_SUMMON_ANIMAL_COMPANION:	// Extraordinary

		// Duelist
		case SPELLABILITY_IMPROVED_REACTION:		// Extraordinary (modified D&D)

		// Dwarven Defender spells
		case SPELLABILITY_DW_DEFENSIVE_STANCE:		// Extraordinary

		// Favored Soul
		case 1122:	// Haste						// Extraordinary (not D&D), ref. Complete Divine (Wings)
		
		// Fighter
		case SPELLABILITY_WHIRLWIND:				// Special Attack
		case SPELLABILITY_EPIC_IMPROVED_WHIRLWIND:	// Special Attack

		//Fist of the Forest
		case 2022:
		case 2023:
		
		// Frenzied Berserker
		case SPELLABILITY_FRENZY:					// Extraordinary (ref. Masters of the Wild)

		//Ghost-faced Killer
		case 2053:
		case 2054:
		
		// Neverwinter Nine
		case SPELLABILITY_FURIOUS_ASSAULT:			// Extraordinary (Not D&D)
		
		//Nightsong
		case 1837:
		case 1838:
		case 1839:
		case 1840:
		case 1843:
		case 1878:
		
		//Ninja
		case 2048:
		case 2049:
		case 2050:
		case 2051:
		case 2052:

		// Red Dragon Disciple
		case 943: // Blindsense						// Extraordinary

		// Sacred Fist
		case 1124:	// Inner Armor					// Extraordinary, ref. Complete Divine
		
		// Scout
		case 2064:
		case 2065:
		
		// Shape Shifter
		case 692: // Spikes							// Extraordinary, ref. Monster Manual (Manticore)

		// Stormlord
		case 1106:	// Immunity to Electricity		// Extraordinary (not D&D), ref. Faiths and Pantheons (Electricity Resistance)

		//Tempest
		case 1736:
		case 1737:
		
		// Warpriest
		case SPELLABILITY_INFLAME:					// Extraordinary (ref. Defender of the Faith)
		

//-------------------------//
// MotB Campaign Abilities //
//-------------------------//

		// Influence system
		case 1113:	// Okku abilities				// Extraordinary (not D&D)
		case 1114:	// Okku abilities				// Extraordinary (not D&D)
		case 1115:	// Okku abilities				// Extraordinary (not D&D)
		case 1116:	// Dove abilities				// Extraordinary (not D&D)
		case 1117:	// Dove abilities				// Extraordinary (not D&D)
		case 1118:	// Gann abilities				// Extraordinary (not D&D)
		case 1119:	// Gann abilities				// Extraordinary (not D&D)
		case 1120:	// One of Many abilities		// Extraordinary (not D&D)
		case 1121:	// One of Many abilities		// Extraordinary (not D&D)

			return TRUE;
	}
	return FALSE;
}

// Indicate if a spell isn't a spell, spell-like, supernatural or extraordinary ability
// - iSpellId SPELL_* constant
// * Returns TRUE if the spell isn't a spell, spell-like, supernatural or extraordinary ability
int JXImplGetIsSpellMiscellaneous(int iSpellId)
{
	switch (iSpellId)
	{
//----------//
// Features //
//----------//

		// Miscellaneous
		case 491:	// Blinding Speed				// ref. Epic Level Handbook

		// Harper Scout
		case SPELL_CRAFT_HARPER_ITEM:				// ref. FRCS (deprectated for Harper Agent)


//----------//
// Crafting //
//----------//

		case SPELL_CRAFT_DYE_CLOTHCOLOR_1:
		case SPELL_CRAFT_DYE_CLOTHCOLOR_2:
		case SPELL_CRAFT_DYE_LEATHERCOLOR_1:
		case SPELL_CRAFT_DYE_LEATHERCOLOR_2:
		case SPELL_CRAFT_DYE_METALCOLOR_1:
		case SPELL_CRAFT_DYE_METALCOLOR_2:
		case SPELL_CRAFT_ADD_ITEM_PROPERTY:
		case SPELL_CRAFT_POISON_WEAPON_OR_AMMO:
		case SPELL_CRAFT_CRAFT_WEAPON_SKILL:
		case SPELL_CRAFT_CRAFT_ARMOR_SKILL:
		case 742: // Craft weapon component
		case 743: // Craft armor component
		case 699: // Apply poison


//-------------------//
// Non Magical Items //
//-------------------//

		// Healing kit (Natural)
		case SPELL_HEALINGKIT:

		// Potion (Alchemical)
		case SPELLABILITY_ROGUES_CUNNING:
		case SPELLPOTION_LORE:

		// Grenadelike Weapons (Alchemical)
		case SPELL_GRENADE_FIRE:
		case SPELL_GRENADE_TANGLE:
		case SPELL_GRENADE_HOLY:
		case SPELL_GRENADE_CHOKING:
		case SPELL_GRENADE_THUNDERSTONE:
		case SPELL_GRENADE_ACID:
		case SPELL_GRENADE_CHICKEN:
		case SPELL_GRENADE_CALTROPS:
		case SPELL_FLYING_DEBRIS:
		case 744: // Grenade Fire Bomb
		case 745: // Grenade Acid Bomb
		case 1192:
		case 1193:
		case 1194:
		case 1195:

		// Traps (Mechanical)
		case SPELL_TRAP_ARROW:
		case SPELL_TRAP_BOLT:
		case SPELL_TRAP_DART:
		case SPELL_TRAP_SHURIKEN:
		case SPELL_ARROW_NOFOG:						// Works like SPELL_TRAP_ARROW
		case SPELL_ARROW_FIRE_NOFOG:				// Works like SPELL_TRAP_ARROW

		// Alcohol
		case 406:
		case 407:
		case 408:

		// Herb
		case 409:
		case 410:

		// Miscellaneous Items
		case SPELL_SILVER_SWORD_ATTACK:
		case SPELL_SILVER_SWORD_STOP_ABILITY:
		case SPELL_SILVER_SWORD_RECHARGE:
		case SPELL_SHARD_SHIELD:
		case SPELL_SHARD_ATTACK:
		case SPELL_KOBOLD_JUMP:
		case 553: // Goblin ballista fireball
		case 767: // Intelligent Weapon Talk
		case 768: // Intelligent Weapon OnHit
		case 773: // Tossed Boulders
		case 794: // Ballista Bolt

		// Item Activation
		case SPELL_ACTIVATE_ITEM_SELF2:		// (Activate Item)
		case 697: // Activate Item Long		// (Activate Item Long Range)
		case 795: // Activate Item Touch	// (Activate Item Touch)

			return TRUE;
	}
	return FALSE;
}

// Indicate if a spell has the specified descriptor
// - iSpellId SPELL_* constant
// - iDescriptor JX_SPELLDESCRIPTOR_* constant
// * Returns TRUE if the spell has the specified spell descriptor
int JXImplGetHasSpellDescriptor(int iSpellId, int iDescriptor = JX_SPELLDESCRIPTOR_ANY)
{
	// Acid
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_ACID))
		switch (iSpellId)
		{
			case SPELL_ACID_FOG:						// Conjuration (Creation) [Acid]
			case SPELL_ACID_SPLASH:						// Conjuration (Creation) [Acid]
			case SPELL_MELFS_ACID_ARROW:				// Conjuration (Creation) [Acid]
			case SPELL_MESTILS_ACID_BREATH:				// Conjuration (Creation) [Acid], ref. Magic of Faerûn
			case SPELL_MESTILS_ACID_SHEATH:				// Conjuration (Creation) [Acid], ref. Magic of Faerûn
			case SPELL_VITRIOLIC_SPHERE:				// Conjuration (Creation) [Acid], ref. Complete Arcane
			case 2311:
			case 2314:
			case 2388:
			case 2368:
			case 2399:
			case 2441:
			case 2459:
			case 2462:
			case 1859:
			case 1860:
			case 1203:
			case 1205:
			case 1864:
				return TRUE;
		}

	// Air
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_AIR))
		switch (iSpellId)
		{
			case SPELL_GUST_OF_WIND:					// Evocation [Air]
			case 2483:
			case 2438:
			case 2439:
			case 2440:
			case 2026:
			case 1765:
			case 1867:
				return TRUE;
		}

	// Chaotic
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_CHAOTIC))
		switch (iSpellId)
		{
			case SPELL_CLOAK_OF_CHAOS:					// Abjuration [Chaotic]
			case SPELL_MAGIC_CIRCLE_AGAINST_LAW:		// Abjuration [Chaotic]
			case SPELL_PROTECTION_FROM_LAW:				// Abjuration [Chaotic]
			case SPELL_SPHERE_OF_CHAOS:					// Alteration, AD&D 2.0 (Chaos Magic)
				return TRUE;
		}

	// Cold
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_COLD))
		switch (iSpellId)
		{
			case SPELL_CONE_OF_COLD:					// Evocation [Cold]
			case SPELL_ELEMENTAL_SHIELD:				// Evocation [Cold, Fire], D&D name : Fire Shield
			case SPELL_ICE_DAGGER:						// Evocation [Cold], ref. Magic of Faerûn
			case SPELL_ICE_STORM:						// Evocation [Cold]
			case SPELL_POLAR_RAY:						// Evocation [Cold]
			case SPELL_RAY_OF_FROST:					// Evocation [Cold]
			case SPELL_HYPOTHERMIA:						// Evocation [Cold], ref. Spell Compendium
			case SPELL_CREEPING_COLD:					// Transmutation [Cold], ref. Complete Divine
			case SPELL_GREATER_CREEPING_COLD:			// Transmutation [Cold], ref. Complete Divine
			case 2478:
			case 2476:
			case 2464:
			case 2447:
			case 2407:
			case 2406:
			case 2405:
			case 2369:
			case 2364:
			case 2344:
			case 2340:
			case 2339:
			case 2205:
			case 2207:
			case 2028:
			case 1822:
			case 1825:
			case 1206:
			case 1197:
			case 1873:
				return TRUE;
		}

	// Darkness
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_DARKNESS))
		switch (iSpellId)
		{
			case SPELLABILITY_AS_DARKNESS:				// Evocation [Darkness]
			case SPELL_DARKNESS:						// Evocation [Darkness]
			case 2316:
			case 2402:
			case 1704:
			case 1722:
			case 1877:
				return TRUE;
		}

	// Death
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_DEATH))
		switch (iSpellId)
		{
			case SPELL_CIRCLE_OF_DEATH:					// Necromancy [Death]
			case SPELL_DEATH_KNELL:						// Necromancy [Death, Evil]
			case SPELL_DESTRUCTION:						// Necromancy [Death]
			case SPELL_FINGER_OF_DEATH:					// Necromancy [Death]
			case SPELL_POWER_WORD_KILL:					// Enchantment (Compulsion) [Death, Mind-Affecting]
			case SPELL_SLAY_LIVING:						// Necromancy [Death]
			case SPELL_WAIL_OF_THE_BANSHEE:				// Necromancy [Death, Sonic]
			case SPELL_AVASCULATE:						// Necromancy [Death, Evil], ref. Libris Mortis
			case SPELL_BODAKS_GLARE:					// Necromancy [Death, Evil], ref. Planar Handbook
			case SPELL_SYMBOL_OF_DEATH:					// Necromancy [Death]
				return TRUE;
		}

	// Earth
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_EARTH))
		switch (iSpellId)
		{
			case SPELL_EARTHQUAKE:						// Evocation [Earth]
			case SPELL_FOUNDATION_OF_STONE:				// Transmutation [Earth], ref. Spell Compendium
			case SPELL_STONEHOLD:						// Conjuration (Creation) [Earth]
			case 2327:
			case 2374:
			case 2378:
			case 2335:
			case 2435:
			case 2436:
			case 2437:
			case 1769:
				return TRUE;
		}

	// Electricity
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_ELECTRICITY))
		switch (iSpellId)
		{
			case SPELL_BALL_LIGHTNING:					// Evocation [Electricity], ref. Magic of Faerûn & PGtF
			case SPELL_CALL_LIGHTNING:					// Evocation [Electricity]
			case SPELL_CHAIN_LIGHTNING:					// Evocation [Electricity]
			case SPELL_ELECTRIC_JOLT:					// Evocation [Electricity], ref. Magic of Faerûn
			case SPELL_GEDLEES_ELECTRIC_LOOP:			// Evocation [Electricity], ref. Magic of Faerûn & PGtF
			case SPELL_LIGHTNING_BOLT:					// Evocation [Electricity]
			case SPELL_SCINTILLATING_SPHERE:			// Evocation [Electricity], ref. Magic of Faerûn
			case SPELL_SHOCKING_GRASP:					// Evocation [Electricity]
			case SPELL_CALL_LIGHTNING_STORM:			// Evocation [Electricity]
			case SPELL_ARC_OF_LIGHTNING:				// Conjuration (Creation) [Electricity], ref. Complete Arcane
			case 2481:
			case 2472:
			case 2456:
			case 2452:
			case 2442:
			case 2397:
			case 2375:
			case 2443:
			case 1827:
			case 1824:
			case 1198:
			case 1207:
			case 1870:
				return TRUE;
		}

	// Evil
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_EVIL))
		switch (iSpellId)
		{
			case SPELL_ANIMATE_DEAD:					// Necromancy [Evil]
			case SPELL_CONTAGION:						// Necromancy [Evil]
			case SPELL_CREATE_UNDEAD:					// Necromancy [Evil]
			case SPELL_CREATE_GREATER_UNDEAD:			// Necromancy [Evil]
			case SPELL_DEATHWATCH:						// Necromancy [Evil]
			case SPELL_DEATH_KNELL:						// Necromancy [Death, Evil]
			case SPELL_MAGIC_CIRCLE_AGAINST_GOOD:		// Abjuration [Evil]
			case SPELL_PROTECTION_FROM_GOOD:			// Abjuration [Evil]
			case SPELL_UNHOLY_AURA:						// Abjuration [Evil]
			case SPELL_MASS_CONTAGION:					// Necromancy [Evil], ref. Races of Faerûn
			case SPELL_AVASCULATE:						// Necromancy [Death, Evil], ref. Libris Mortis
			case SPELL_BODAKS_GLARE:					// Necromancy [Death, Evil], ref. Planar Handbook
			case SPELL_SYMBOL_OF_PAIN:					// Necromancy [Evil]
			case 2315:
			case 2317:
			case 2343:
			case 2347:
			case 2366:
			case 2367:
			case 2372:
			case 2409:
			case 2473:
			case 2200:
			case 2201:
			case 2202:
			case 2203:
			case 1709:
			case 1871:
				return TRUE;
		}

	// Fear
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_FEAR))
		switch (iSpellId)
		{
			case SPELL_BANE:							// Enchantment (Compulsion) [Fear, Mind-Affecting]
			case SPELL_CAUSE_FEAR:						// Necromancy [Fear, Mind-Affecting]
			case SPELL_DOOM:							// Necromancy [Fear, Mind-Affecting]
			case SPELL_FEAR:							// Necromancy [Fear, Mind-Affecting]
			case SPELL_PHANTASMAL_KILLER:				// Illusion (Phantasm) [Fear, Mind-Affecting]
			case SPELL_SCARE:							// Necromancy [Fear, Mind-Affecting]
			case SPELL_WEIRD:							// Illusion (Phantasm) [Fear, Mind-Affecting]
			case SPELL_SYMBOL_OF_FEAR:					// Necromancy [Fear, Mind-Affecting]
			case 2470:
			case 1718:
				return TRUE;
		}
		
	// Fire
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_FIRE))
		switch (iSpellId)
		{
			case SPELL_BODY_OF_THE_SUN:					// Transmutation [Fire], ref. Complete Divine
			case SPELL_BURNING_HANDS:					// Evocation [Fire]
			case SPELL_COMBUST:							// Evocation [Fire], ref. Magic of Faerûn
			case SPELL_DARKFIRE:						// Evocation [Fire], ref. Magic of Faerûn
			case SPELL_ELEMENTAL_SHIELD:				// Evocation [Cold, Fire], D&D name : Fire Shield
			case SPELL_FIREBALL:						// Evocation [Fire]
			case SPELL_DELAYED_BLAST_FIREBALL:			// Evocation [Fire]
			case SPELL_FIREBRAND:						// Evocation [Fire], ref. Magic of Faerûn
			case SPELL_FIREBURST:						// Evocation [Fire]
			case SPELL_GREATER_FIREBURST:				// Evocation [Fire], ref. Complete Arcane
			case SPELL_FIRE_STORM:						// Evocation [Fire]
			case SPELL_FLAME_ARROW:						// Transmutation [Fire]
			case SPELL_FLAME_STRIKE:					// Evocation [Fire]
			case SPELL_FLAME_WEAPON:					// Evocation [Fire], ref. Magic of Faerûn (Flame Dagger)
			case SPELL_INCENDIARY_CLOUD:				// Conjuration (Creation) [Fire]
			case SPELL_INFERNO:							// Transmutation [Fire], ref. Magic of Faerûn & PGtF
			case SPELL_METEOR_SWARM:					// Evocation [Fire]
			case SPELL_METEOR_SWARM_TARGET_SELF:		// Evocation [Fire]
			case SPELL_METEOR_SWARM_TARGET_LOCATION:	// Evocation [Fire]
			case SPELL_METEOR_SWARM_TARGET_CREATURE:	// Evocation [Fire]
			case SPELL_SHROUD_OF_FLAME:					// Evocation [Fire], ref. PGtF
			case SPELL_WALL_OF_FIRE:					// Evocation [Fire]
			case 1055:	// Scorching Ray				// Evocation [Fire]
			case 1056:	// Scorching Ray (many)			// See above
			case 1057:	// Scorching Ray (single)		// See above
			case SPELL_BLADES_OF_FIRE:					// Conjuration (Creation) [Fire], ref. Complete Arcane
			case 2468:
			case 2463:
			case 2446:
			case 2444:
			case 2432:
			case 2433:
			case 2434:
			case 2322:
			case 2206:
			case 2025:
			case 1826:
			case 1823:
			case 1759:
			case 1199:
			case 1208:
			case 1866:
				return TRUE;
		}

	// Force
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_FORCE))
		switch (iSpellId)
		{
			case SPELL_BIGBYS_INTERPOSING_HAND:			// Evocation [Force]
			case SPELL_BIGBYS_FORCEFUL_HAND:			// Evocation [Force]
			case SPELL_BIGBYS_GRASPING_HAND:			// Evocation [Force]
			case SPELL_BIGBYS_CLENCHED_FIST:			// Evocation [Force]
			case SPELL_BIGBYS_CRUSHING_HAND:			// Evocation [Force]
			case SPELL_BLADE_BARRIER:					// Evocation [Force]
			case SPELL_BLADE_BARRIER_WALL:				// Evocation [Force]
			case SPELL_BLADE_BARRIER_SELF:				// Evocation [Force]
			case SPELL_MAGE_ARMOR:						// Conjuration (Creation) [Force]
			case SPELL_IMPROVED_MAGE_ARMOR:				// Conjuration (Creation) [Force], ref. Complete Arcane (Greater Mage Armor)
			case SPELL_MAGIC_MISSILE:					// Evocation [Force]
			case SPELL_MORDENKAINENS_SWORD:				// Evocation [Force]
			case SPELL_SHELGARNS_PERSISTENT_BLADE:		// Evocation [Force], ref. Magic of Faerûn
			case SPELL_SHIELD:							// Abjuration [Force]
			case 2320:
			case 2319:
			case 2346:
			case 2348:
			case 2349:
			case 2398:
			case 2400:
			case 2403:
			case 2404:
			case 2445:
			case 2451:
			case 2479:
			case 2482:
			case 2480:
			case 1863:
			case 1868:
				return TRUE;
		}

	// Good
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_GOOD))
		switch (iSpellId)
		{
			case SPELL_HOLY_AURA:						// Abjuration [Good]
			case SPELL_HOLY_SWORD:						// Evocation [Good]
			case SPELL_PROTECTION_FROM_EVIL:			// Abjuration [Good]
			case SPELL_MAGIC_CIRCLE_AGAINST_EVIL:		// Abjuration [Good]
			case SPELL_UNDEATHS_ETERNAL_FOE:			// Abjuration [Good], ref. Magic of Faerûn & PGtF
			case 2471:
			case 2474:
			case 2475:
			case 1914:
			case 1738:
			case 1741:
			case 1742:
			case 1764:
			case 1770:
			case 1773:
			case 1774:
				return TRUE;
		}

	// Language-dependant
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_LANGUAGEDEPENDANT))
		switch (iSpellId)
		{
		}

	// Lawful
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_LAWFUL))
		switch (iSpellId)
		{
			case SPELL_PROTECTION_FROM_CHAOS:			// Abjuration [Lawful]
			case SPELL_MAGIC_CIRCLE_AGAINST_CHAOS:		// Abjuration [Lawful]
			case SPELL_SHIELD_OF_LAW:					// Abjuration [Lawful]
			case 1761:
				return TRUE;
		}

	// Light
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_LIGHT))
		switch (iSpellId)
		{
			case SPELL_CONTINUAL_FLAME:					// Evocation [Light]
			case SPELL_FLARE:							// Evocation [Light]
			case SPELL_LIGHT:							// Evocation [Light]
			case SPELL_SUNBEAM:							// Evocation [Light]
			case SPELL_SUNBURST:						// Evocation [Light]
			case 2457:
			case 2401:
			case 1857:
				return TRUE;
		}

	// Mind-affecting
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_MINDAFFECTING))
		switch (iSpellId)
		{
			case SPELL_AID:								// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_BANE:							// Enchantment (Compulsion) [Fear, Mind-Affecting]
			case SPELL_BLESS:							// Enchantment (Compulsion) [Mind-Affecting]
			//case SPELL_CALM_EMOTIONS:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_CAUSE_FEAR:						// Necromancy [Fear, Mind-Affecting]
			case SPELL_CHARM_PERSON:					// Enchantment (Charm) [Mind-Affecting]
			case SPELL_CHARM_PERSON_OR_ANIMAL:			// Enchantment (Charm) [Mind-Affecting]
			case SPELL_CHARM_MONSTER:					// Enchantment (Charm) [Mind-Affecting]
			case SPELL_CONFUSION:						// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_MASS_CHARM:						// Enchantment (Charm) [Mind-Affecting]
			case SPELL_COLOR_SPRAY:						// Illusion (Pattern) [Mind-Affecting]
			case SPELL_CRUSHING_DESPAIR:				// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_DAZE:							// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_DEEP_SLUMBER:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_DOMINATE_ANIMAL:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_DOMINATE_MONSTER:				// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_DOMINATE_PERSON:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_DOOM:							// Necromancy [Fear, Mind-Affecting]
			case SPELL_FEAR:							// Necromancy [Fear, Mind-Affecting]
			case SPELL_FEEBLEMIND:						// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_HEROISM:							// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_GREATER_HEROISM:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_HOLD_ANIMAL:						// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_HOLD_MONSTER:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_HOLD_PERSON:						// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_MASS_HOLD_MONSTER:				// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_MASS_HOLD_PERSON:				// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_MIND_FOG:						// Enchantment (Compulsion) [Mind-Affecting],
			case SPELL_PRAYER:							// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_SCARE:							// Necromancy [Fear, Mind-Affecting]
			case SPELL_SLEEP:							// Enchantment (Compulsion) [Mind-Affecting]
			case 480: // Sleep							// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_SONG_OF_DISCORD:					// Enchantment (Compulsion) [Mind-Affecting, Sonic]
			case SPELL_RAGE:							// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_TASHAS_HIDEOUS_LAUGHTER:			// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_PHANTASMAL_KILLER:				// Illusion (Phantasm) [Fear, Mind-Affecting]
			case SPELL_POWER_WORD_KILL:					// Enchantment (Compulsion) [Death, Mind-Affecting]
			case SPELL_POWER_WORD_STUN:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_WAR_CRY:							// Enchantment (Compulsion) [Sonic, Mind-Affecting], ref. Magic of Faerûn
			case SPELL_WEIRD:							// Illusion (Phantasm) [Fear, Mind-Affecting]
			case SPELL_POWORD_WEAKEN:					// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
			case SPELL_POWORD_MALADROIT:				// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
			case SPELL_POWORD_BLIND:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_POWORD_PETRIFY:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_HISS_OF_SLEEP:					// Enchantment (Compulsion) [Mind-Affecting], ref. Spell Compendium
			case SPELL_POWER_WORD_DISABLE:				// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
			case 1051:	// Touch of Idiocy				// Enchantment (Compulsion) [Mind-Affecting]
			case 1052:	// Mass Aid						// Enchantment (Compulsion) [Mind-Affecting]
			case 1053:	// Lionheart					// Abjuration[Mind-Affecting], ref. Miniatures Handbook
			case 1129:	// Solipsism					// Illusion (Phantasm) [Mind-Affecting], ref. Spell Compendium
			case SPELL_SYMBOL_OF_FEAR:					// Necromancy [Fear, Mind-Affecting]
			case SPELL_SYMBOL_OF_PERSUASION:			// Enchantment (Charm) [Mind-Affecting]
			case SPELL_SYMBOL_OF_SLEEP:					// Enchantment (Compulsion) [Mind-Affecting]
			case SPELL_SYMBOL_OF_STUNNING:				// Enchantment (Compulsion) [Mind-Affecting]
			case 2337:
			case 2363:
			case 2484:
			case 2485:
				return TRUE;
		}

	// Sonic
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_SONIC))
		switch (iSpellId)
		{
			case SPELL_AMPLIFY:							// Transmutation [Sonic], ref. Magic of Faerûn
			case SPELL_WOUNDING_WHISPERS:				// Abjuration [Sonic], ref. Magic of Faerûn
			case SPELL_WAR_CRY:							// Enchantment (Compulsion) [Sonic, Mind-Affecting], ref. Magic of Faerûn
			case SPELL_SONG_OF_DISCORD:					// Enchantment (Compulsion) [Mind-Affecting, Sonic]
			case SPELL_DIRGE:							// Evocation [Sonic], ref. Magic of Faerûn
			case SPELL_SOUND_BURST:						// Evocation [Sonic]
			case SPELL_GREAT_THUNDERCLAP:				// Evocation [Sonic], ref. Magic of Faerûn
			//case SPELL_DEAFENING_CLANG:				// Transmutation [Sonic], ref. Magic of Faerûn (same const as Fox's Cunning)
			case SPELL_HORIZIKAULS_BOOM:				// Evocation [Sonic], ref. Magic of Faerûn
			case SPELL_BALAGARNSIRONHORN:				// Transmutation [Sonic], ref. Magic of Faerûn
			case SPELL_WAIL_OF_THE_BANSHEE:				// Necromancy [Death, Sonic]
			case SPELL_CACOPHONIC_BURST:				// Evocation [Sonic], ref. Spell Compendium
			case SPELL_SHOUT:							// Evocation [Sonic]
			case SPELL_GREATER_SHOUT:					// Evocation [Sonic]
			case SPELL_CASTIGATION:						// Evocation [Sonic], ref. Complete Divine
			case 2454:
			case 2453:
			case 2408:
			case 2376:
			case 2371:
			case 2341:
			case 2334:
			case 2333:
			case 2332:
			case 2321:
			case 2027:
			case 1862:
			case 1861:
			case 1831:
			case 1829:
			case 1820:
			case 1813:
			case 1745:
			case 1743:
			case 1209:
			case 1204:
			case 1865:
				return TRUE;
		}

	// Water
	if ((iDescriptor == JX_SPELLDESCRIPTOR_ANY) || (iDescriptor == JX_SPELLDESCRIPTOR_WATER))
		switch (iSpellId)
		{
			case SPELL_DROWN:							// Conjuration (Creation) [Water], ref. Magic of Faerûn
			case 1058:	// Extract Water Elemental		// Transmutation [Water], ref. Spell Compendium
			case SPELL_BLOOD_TO_WATER:					// Necromancy [Water], ref. Spell Compendium
			case 2429:
			case 2430:
			case 2431:
				return TRUE;
		}

	/*case SPELL_ELEMENTAL_SWARM:				// Conjuration (Summoning) [Air/Earth/Fire/Water]
	case SPELL_SUMMON_CREATURE_I:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_II:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_III:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_IV:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_V:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_VI:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_VII:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_VIII:			// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_SUMMON_CREATURE_IX:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_PLANAR_ALLY:						// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_LESSER_PLANAR_BINDING:			// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_PLANAR_BINDING:					// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_GREATER_PLANAR_BINDING:			// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
	case SPELL_VISAGE_OF_THE_DEITY:				// Transmutation [Evil, Good], ref. Complete Divine
	case SPELL_GREATER_VISAGE_OF_THE_DEITY:		// Transmutation [Evil, Good], ref. Complete Divine*/

	return FALSE;
}

// Get the spell subschool of a spell
// - iSpellId SPELL_* constant
// * Returns a JX_SPELLSUBSCHOOL_* constant
int JXImplGetSpellSubSchool(int iSpellId)
{
	switch (iSpellId)
	{
		// Conjuration : Calling
		case SPELL_PLANAR_ALLY:						// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_LESSER_PLANAR_BINDING:			// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_PLANAR_BINDING:					// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_GREATER_PLANAR_BINDING:			// Conjuration (Calling) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_GATE:							// Conjuration (Creation or Calling)
			return JX_SPELLSUBSCHOOL_CONJURATION_CALLING;

		// Conjuration : Creation
		case 1054:	// Recitation					// Conjuration (Creation), ref. Complete Divine
		case SPELL_VINE_MINE:						// Conjuration (Creation), ref. Magic of Faerûn
		case SPELL_VINE_MINE_ENTANGLE:				// Sub-spell (see above)
		case SPELL_VINE_MINE_HAMPER_MOVEMENT:		// Sub-spell (see above)
		case SPELL_VINE_MINE_CAMOUFLAGE:			// Sub-spell (see above)
		case SPELL_DROWN:							// Conjuration (Creation) [Water], ref. Magic of Faerûn
		case SPELL_STONEHOLD:						// Conjuration (Creation) [Earth]
		case SPELL_SWAMP_LUNG:						// Conjuration (Creation), ref. Spell Compendium
		case SPELL_BOMBARDMENT:						// Conjuration (Creation), ref. Magic of Faerûn & PGtF
		case SPELL_MASS_DROWN:						// Conjuration (Creation), ref. Underdark
		case SPELL_ACID_SPLASH:						// Conjuration (Creation) [Acid]
		case SPELL_GREASE:							// Conjuration (Creation)
		case SPELL_MAGE_ARMOR:						// Conjuration (Creation) [Force]
		case SPELL_MELFS_ACID_ARROW:				// Conjuration (Creation) [Acid]
		case SPELL_WEB:								// Conjuration (Creation)
		case SPELL_STINKING_CLOUD:					// Conjuration (Creation)
		case SPELL_MESTILS_ACID_BREATH:				// Conjuration (Creation) [Acid], ref. Magic of Faerûn
		case SPELL_IMPROVED_MAGE_ARMOR:				// Conjuration (Creation) [Force], ref. Complete Arcane (Greater Mage Armor)
		case SPELL_EVARDS_BLACK_TENTACLES:			// Conjuration (Creation)
		case SPELL_CLOUDKILL:						// Conjuration (Creation)
		case SPELL_MESTILS_ACID_SHEATH:				// Conjuration (Creation) [Acid], ref. Magic of Faerûn
		case SPELL_VITRIOLIC_SPHERE:				// Conjuration (Creation) [Acid], ref. Complete Arcane
		case SPELL_ACID_FOG:						// Conjuration (Creation) [Acid]
		case SPELL_INCENDIARY_CLOUD:				// Conjuration (Creation) [Fire]
		case SPELL_BLACK_BLADE_OF_DISASTER:			// Conjuration (Creation), ref. Magic of Faerûn
		case SPELL_ARC_OF_LIGHTNING:				// Conjuration (Creation) [Electricity], ref. Complete Arcane
		case SPELL_BLADES_OF_FIRE:					// Conjuration (Creation) [Fire], ref. Complete Arcane
		case 2368:
		case 2406:
		case 2441:
		case 2207:
		case 2206:
		case 1197:
		case 1198:
		case 1199:
		case 1203:
		case 1204:
		case 1205:
		case 1206:
		case 1207:
		case 1208:
		case 1209:
		case 1822:
		case 1823:
		case 1824:
		case 1825:
		case 1826:
		case 1827:
		case 1859:
		case 1860:
		case 1861:
		case 1862:
		case 1863:
		case 2025:
			return JX_SPELLSUBSCHOOL_CONJURATION_CREATION;

		// Conjuration : Healing
		case SPELL_CURE_MINOR_WOUNDS:				// Conjuration (Healing)
		case SPELL_CURE_LIGHT_WOUNDS:				// Conjuration (Healing)
		case SPELL_LESSER_VIGOR:					// Conjuration (Healing), ref. Complete Divine
		case SPELL_CURE_MODERATE_WOUNDS:			// Conjuration (Healing)
		case SPELL_LESSER_RESTORATION:				// Conjuration (Healing)
		case SPELL_REMOVE_PARALYSIS:				// Conjuration (Healing)
		case SPELL_CURE_SERIOUS_WOUNDS:				// Conjuration (Healing)
		case SPELL_REMOVE_BLINDNESS_AND_DEAFNESS:	// Conjuration (Healing)
		case SPELL_REMOVE_DISEASE:					// Conjuration (Healing)
		case SPELL_VIGOR:							// Conjuration (Healing), ref. Complete Divine
		case SPELL_MASS_LESSER_VIGOR:				// Conjuration (Healing), ref. Complete Divine
		case SPELL_CURE_CRITICAL_WOUNDS:			// Conjuration (Healing)
		case SPELL_RESTORATION:						// Conjuration (Healing)
		case SPELL_MASS_CURE_LIGHT_WOUNDS:			// Conjuration (Healing)
		case SPELL_RAISE_DEAD:						// Conjuration (Healing)
		case SPELL_MONSTROUS_REGENERATION:			// Conjuration (Healing), ref. Magic of Faerûn
		case SPELL_HEAL:							// Conjuration (Healing)
		case SPELL_MASS_CURE_MODERATE_WOUNDS:		// Conjuration (Healing)
		case SPELL_VIGOROUS_CYCLE:					// Conjuration (Healing), ref. Complete Divine
		case SPELL_GREATER_RESTORATION:				// Conjuration (Healing)
		case SPELL_RESURRECTION:					// Conjuration (Healing)
		case SPELL_REGENERATE:						// Conjuration (Healing)
		case SPELL_FORTUNATE_FATE:					// Conjuration (Healing), ref. Magic of Faerûn
		case SPELL_MASS_CURE_SERIOUS_WOUNDS:		// Conjuration (Healing)
		case SPELL_MASS_CURE_CRITICAL_WOUNDS:		// Conjuration (Healing)
		case SPELL_MASS_HEAL:						// Conjuration (Healing)
		case SPELL_NEUTRALIZE_POISON:				// Conjuration (Healing)
		case SPELL_REJUVENATION_COCOON:				// Conjuration (Healing), ref. Complete Divine
		case SPELL_HEAL_ANIMAL_COMPANION:			// Conjuration (Healing), ref. Spell Compendium
		case 2471:
		case 1202:
		case 1876:
			return JX_SPELLSUBSCHOOL_CONJURATION_HEALING;

		// Conjuration : Summoning
		case SPELL_CREEPING_DOOM:					// Conjuration (Summoning)
		case SPELL_ELEMENTAL_SWARM:					// Conjuration (Summoning) [Air/Earth/Fire/Water]
		case SPELL_STORM_OF_VENGEANCE:				// Conjuration (Summoning)
		case SPELL_SUMMON_CREATURE_I:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_II:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_III:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_IV:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_V:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_VI:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_VII:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_VIII:			// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case SPELL_SUMMON_CREATURE_IX:				// Conjuration (Summoning) [Air/Chaos/Earth/Evil/Fire/Good/Law/Water]
		case 2419:
		case 2420:
		case 2421:
		case 2422:
		case 2423:
		case 2424:
		case 2425:
		case 2426:
		case 2427:
		case 2428:
		case 2429:
		case 2430:
		case 2431:
		case 2432:
		case 2433:
		case 2434:
		case 2435:
		case 2436:
		case 2437:
		case 2438:
		case 2439:
		case 2440:
		case 2469:
		case 2487:
		case 1730:
		case 1928:
			return JX_SPELLSUBSCHOOL_CONJURATION_SUMMONING;

		// Conjuration : Teleportation		
		case SPELL_TELEPORT:						// Conjuration (Teleportation)
		case SPELL_GREATER_TELEPORT:				// Conjuration (Teleportation)
			return JX_SPELLSUBSCHOOL_CONJURATION_TELEPORTATION;

		// Divination : Scrying
		case SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE:	// Divination (Scrying)
		case 1714:
			return JX_SPELLSUBSCHOOL_DIVINATION_SCRYING;

		// Enchantment : Charm
		case SPELL_CHARM_PERSON_OR_ANIMAL:			// Enchantment (Charm) [Mind-Affecting]
		case SPELL_CHARM_PERSON:					// Enchantment (Charm) [Mind-Affecting]
		case SPELL_CHARM_MONSTER:					// Enchantment (Charm) [Mind-Affecting]
		case SPELL_MASS_CHARM:						// Enchantment (Charm) [Mind-Affecting]
		case SPELL_SYMBOL_OF_PERSUASION:			// Enchantment (Charm) [Mind-Affecting]
			return JX_SPELLSUBSCHOOL_ENCHANTMENT_CHARM;

		// Enchantment : Compulsion
		case SPELL_WAR_CRY:							// Enchantment (Compulsion) [Sonic, Mind-Affecting], ref. Magic of Faerûn
		case SPELL_SONG_OF_DISCORD:					// Enchantment (Compulsion) [Mind-Affecting, Sonic]
		case SPELL_BLESS:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_BANE:							// Enchantment (Compulsion) [Fear, Mind-Affecting]
		case SPELL_AID:								// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_PRAYER:							// Enchantment (Compulsion) [Mind-Affecting]
		case 1052:	// Mass Aid						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_HOLD_ANIMAL:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_DOMINATE_ANIMAL:					// Enchantment (Compulsion) [Mind-Affecting]
		case 480: // Sleep							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_DAZE:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_SLEEP:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_TASHAS_HIDEOUS_LAUGHTER:			// Enchantment (Compulsion) [Mind-Affecting]
		case 1051:	// Touch of Idiocy				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_HOLD_PERSON:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_DEEP_SLUMBER:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_HEROISM:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_RAGE:							// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_POWORD_WEAKEN:					// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
		case SPELL_POWORD_MALADROIT:				// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
		case SPELL_CONFUSION:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_CRUSHING_DESPAIR:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_DOMINATE_PERSON:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_FEEBLEMIND:						// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_HOLD_MONSTER:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_MIND_FOG:						// Enchantment (Compulsion) [Mind-Affecting],
		case SPELL_POWER_WORD_DISABLE:				// Enchantment (Compulsion) [Mind-Affecting], ref. Races of the Dragon
		case SPELL_GREATER_HEROISM:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_MASS_HOLD_PERSON:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_POWORD_BLIND:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_HISS_OF_SLEEP:					// Enchantment (Compulsion) [Mind-Affecting], ref. Spell Compendium
		case SPELL_POWER_WORD_STUN:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_POWORD_PETRIFY:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_DOMINATE_MONSTER:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_POWER_WORD_KILL:					// Enchantment (Compulsion) [Death, Mind-Affecting]
		case SPELL_MASS_HOLD_MONSTER:				// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_SYMBOL_OF_SLEEP:					// Enchantment (Compulsion) [Mind-Affecting]
		case SPELL_SYMBOL_OF_STUNNING:				// Enchantment (Compulsion) [Mind-Affecting]
		case 2484:
		case 2485:
		case 2363:
		case 2337:
		case 2204:
		case 1191:
		case 1699:
		case 1739:
			return JX_SPELLSUBSCHOOL_ENCHANTMENT_COMPULSION;

		// Illusion : Figment
		case SPELL_MIRROR_IMAGE:					// Illusion (Figment)
			return JX_SPELLSUBSCHOOL_ILLUSION_FIGMENT;

		// Illusion : Glamer
		case SPELLABILITY_AS_INVISIBILITY:			// Illusion (Glamer)
		case SPELLABILITY_AS_GREATER_INVISIBLITY:	// Illusion (Glamer)
		case SPELL_SILENCE:							// Illusion (Glamer)
		case 483: // Invisibility					// Illusion (Glamer)
		case SPELL_INVISIBILITY:					// Illusion (Glamer)
		case SPELL_INVISIBILITY_SPHERE:				// Illusion (Glamer)
		case SPELL_DISPLACEMENT:					// Illusion (Glamer)
		case SPELL_GREATER_INVISIBILITY:			// Illusion (Glamer)
		case SPELL_MASS_INVISIBILITY:				// Illusion (Glamer)
		case SPELL_STALKING_SPELL:					// Illusion (Glamer), ref. Savage Species
		case 1706:
		case 1711:
			return JX_SPELLSUBSCHOOL_ILLUSION_GLAMER;

		// Illusion : Pattern
		case SPELL_COLOR_SPRAY:						// Illusion (Pattern) [Mind-Affecting]
		case SPELL_BLADEWEAVE:						// Illusion (Pattern), ref. Complete Adventurer
			return JX_SPELLSUBSCHOOL_ILLUSION_PATTERN;

		// Illusion : Phantasm
		case SPELL_PHANTASMAL_KILLER:				// Illusion (Phantasm) [Fear, Mind-Affecting]
		case 1129:	// Solipsism					// Illusion (Phantasm) [Mind-Affecting], ref. Spell Compendium
		case SPELL_WEIRD:							// Illusion (Phantasm) [Fear, Mind-Affecting]
		case 1930:
		case 1931:
			return JX_SPELLSUBSCHOOL_ILLUSION_PHANTASM;

		// Illusion : Shadow
		case 159: //SPELL_SHADOW_CONJURATION:		// Illusion (Shadow)
		case SPELL_SHADOW_CONJURATION_SUMMON_SHADOW:// See above
		case SPELL_SHADOW_CONJURATION_DARKNESS:		// See above
		case SPELL_SHADOW_CONJURATION_INIVSIBILITY:	// See above
		case SPELL_SHADOW_CONJURATION_MAGE_ARMOR:	// See above
		case SPELL_SHADOW_CONJURATION_MAGIC_MISSILE:// See above
		case 1133:	// Glass Doppelganger			// Illusion (Shadow)
		case 71: //SPELL_GREATER_SHADOW_CONJURATION:		// Illusion (Shadow)
		case SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW:// See above
		case SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW:	// See above
		case SPELL_GREATER_SHADOW_CONJURATION_MIRROR_IMAGE:	// See above
		case SPELL_GREATER_SHADOW_CONJURATION_WEB:			// See above
		case SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE:	// See above
		case 158: //SPELL_SHADES:					// Illusion (Shadow)
		case SPELL_SHADES_TARGET_CASTER:			// See above
		case SPELL_SHADES_TARGET_CREATURE:			// See above
		case SPELL_SHADES_TARGET_GROUND:			// See above
		case SPELL_SHADES_SUMMON_SHADOW:			// See above
		case SPELL_SHADES_CONE_OF_COLD:				// See above
		case SPELL_SHADES_FIREBALL:					// See above
		case SPELL_SHADES_STONESKIN:				// See above
		case SPELL_SHADES_WALL_OF_FIRE:				// See above
		case 1132:	// Shadow Simulacrum			// Illusion (Shadow), ref. Polyhedron #144
		case 2402:
			return JX_SPELLSUBSCHOOL_ILLUSION_SHADOW;
	}

	return JX_SPELLSUBSCHOOL_NONE;
}

// Get the level of a spell, innate or depending on a caster class
// - iClass Class that is able to cast the spell (CLASS_TYPE_INVALID for innate)
// * Returns the spell level, or -1 if the spell is not accessible to the class
int JXImplGetBaseSpellLevel(int iSpellId, int iClass = CLASS_TYPE_INVALID)
{
	string sSpellLevel = "";

	switch (iClass)
	{
	  case CLASS_TYPE_BARD:
	  	sSpellLevel = Get2DAString("spells", "Bard", iSpellId); break;
	  case CLASS_TYPE_CLERIC:
	  case CLASS_TYPE_FAVORED_SOUL:
	  	sSpellLevel = Get2DAString("spells", "Cleric", iSpellId); break;
	  case CLASS_TYPE_DRUID:
	  case CLASS_TYPE_SPIRIT_SHAMAN:
	  	sSpellLevel = Get2DAString("spells", "Druid", iSpellId); break;
	  case CLASS_TYPE_RANGER:
	  	sSpellLevel = Get2DAString("spells", "Ranger", iSpellId); break;
	  case CLASS_TYPE_PALADIN:
	  	sSpellLevel = Get2DAString("spells", "Paladin", iSpellId); break;
	  case CLASS_TYPE_WIZARD:
	  case CLASS_TYPE_SORCERER:
	  	sSpellLevel = Get2DAString("spells", "Wiz_Sorc", iSpellId); break;
	  default:
	  	sSpellLevel = Get2DAString("spells", "Innate", iSpellId); break;
	}

	if (sSpellLevel == "")
		return -1;
	else
		return StringToInt(sSpellLevel);
}