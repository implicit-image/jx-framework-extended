/*

//:: Created By: Kaedrin (Matt)
//:: cmi_includes

This is the include file for my content and will hopefully allow others
to remap my content for their own use more easily.

*/

/*
const int SPELL_TARGET_ALLALLIES = 1;
const int SPELL_TARGET_STANDARDHOSTILE = 2;
const int SPELL_TARGET_SELECTIVEHOSTILE = 3;
*/

void cmi_ApplyEffectToObject(int nSpellId, int nDurationType, effect eEffect, object oTarget, float fDuration=0.0f)
{
	if (GetHasSpellEffect(nSpellId,oTarget))
	{
		return;
	}	
	else
	{
		ApplyEffectToObject(nDurationType, eEffect, oTarget, fDuration);
	}
}

const int SR_FIX = -4000;
const int DMGRES_FIX = -4001;
const int FATIGUE = -4002;
const int EXHAUSTED = -4003;

const int CLASS_HOSPITALER = 106;
const int CLASS_WARRIOR_DARKNESS = 107;
const int CLASS_BLADESINGER = 108;
const int CLASS_STORMSINGER = 109;
const int CLASS_TEMPEST = 110;
const int CLASS_BLACK_FLAME_ZEALOT = 111;
const int CLASS_SHINING_BLADE = 112;
const int CLASS_SWIFTBLADE = 113;
const int CLASS_FOREST_MASTER = 114;
const int CLASS_NIGHTSONG_ENFORCER = 115;
const int CLASS_THUG = 116;
const int CLASS_ELDRITCH_DISCIPLE = 117;
const int CLASS_ELEM_ARCHER = 118;
const int CLASS_DIVINE_SEEKER = 119;
const int CLASS_ANOINTED_KNIGHT = 120;
const int CLASS_NATURES_WARRIOR = 121;
const int CLASS_FROST_MAGE = 122;
const int CLASS_LION_TALISID = 123;
const int CLASS_CANAITH_LYRIST = 124;
const int CLASS_LYRIC_THAUMATURGE = 125;
const int CLASS_CHAMPION_WILD = 126;
const int CLASS_SKULLCLAN_HUNTER = 127;
const int CLASS_DARK_LANTERN = 128;
const int CLASS_NIGHTSONG_INFILTRATOR = 129;
const int CLASS_MASTER_RADIANCE = 130;
const int CLASS_HEARTWARDER = 131;
const int CLASS_KNIGHT_TIERDRIAL = 132;
const int CLASS_SHADOWBANE_STALKER = 133;
const int CLASS_DRAGONSLAYER = 134;
const int CLASS_DRAGON_SHAMAN = 135;
const int CLASS_FIST_FOREST = 136;
const int CLASS_CHAMP_SILVER_FLAME = 137;
const int CLASS_SWORD_DANCER = 138;
const int CLASS_DRAGON_WARRIOR = 139;
const int CLASS_CHILD_NIGHT = 140;

const int CLASS_AVENGER = 142;
const int CLASS_DERVISH = 143;
const int CLASS_NINJA = 144;
const int CLASS_GHOST_FACED_KILLER = 145;
const int CLASS_DREAD_PIRATE = 146;
const int CLASS_DAGGERSPELL_MAGE = 147;
const int CLASS_DAGGERSPELL_SHAPER = 148;
const int CLASS_SCOUT = 149;
const int CLASS_WILD_STALKER = 150;
const int CLASS_VERDANT_GUARDIAN = 151;

const int CLASS_DREAD_COMMANDO = 166;

const int CLASS_ELEMENTAL_WARRIOR = 180;
const int CLASS_WHIRLING_DERVISH = 181;
const int CLASS_DEATH_BLADE = 182;
const int CLASS_OPTIMIST = 183;
const int CLASS_DISSONANT_CHORD = 184;
//


const int FEAT_LAYONHANDS_HOSTILE = 2989;
const int FEAT_MELEE_TOUCH_SPELL_SPECIALIZATION = 2991;
const int FEAT_RANGED_TOUCH_SPELL_SPECIALIZATION = 2992;
const int FEAT_HOSPITALER_SPELLCASTING_SPIRIT_SHAMAN = 2993;
const int FEAT_HOSPITALER_SPELLCASTING_CLERIC = 2994;
const int FEAT_HOSPITALER_SPELLCASTING_DRUID = 2995;
const int FEAT_HOSPITALER_SPELLCASTING_PALADIN = 2996;
const int FEAT_HOSPITALER_SPELLCASTING_RANGER = 2997;
const int FEAT_HOSPITALER_SPELLCASTING_FAVORED_SOUL = 2998;
const int FEAT_SHINING_BLADE_SPELLCASTING_SPIRIT_SHAMAN = 2999;
const int FEAT_SHINING_BLADE_SPELLCASTING_CLERIC = 3000;
const int FEAT_SHINING_BLADE_SPELLCASTING_DRUID = 3001;
const int FEAT_SHINING_BLADE_SPELLCASTING_PALADIN = 3002;
const int FEAT_SHINING_BLADE_SPELLCASTING_RANGER = 3003;
const int FEAT_SHINING_BLADE_SPELLCASTING_FAVORED_SOUL = 3004;
const int FEAT_BFZ_SPELLCASTING_SPIRIT_SHAMAN = 3005;
const int FEAT_BFZ_SPELLCASTING_CLERIC = 3006;
const int FEAT_BFZ_SPELLCASTING_DRUID = 3007;
const int FEAT_BFZ_SPELLCASTING_PALADIN = 3008;
const int FEAT_BFZ_SPELLCASTING_RANGER = 3009;
const int FEAT_BFZ_SPELLCASTING_FAVORED_SOUL = 3010;
const int FEAT_BG_BULLS_STRENGTH_1 = 3011;
const int FEAT_BG_BULLS_STRENGTH_2 = 3012;
const int FEAT_BG_BULLS_STRENGTH_3 = 3013;
const int FEAT_BG_BULLS_STRENGTH_4 = 3014;
const int FEAT_BG_BULLS_STRENGTH_5 = 3015;
const int FEAT_BG_INFLICT_SERIOUS_WOUNDS_1 = 3016;
const int FEAT_BG_INFLICT_SERIOUS_WOUNDS_2 = 3017;
const int FEAT_BG_INFLICT_SERIOUS_WOUNDS_3 = 3018;
const int FEAT_BG_INFLICT_SERIOUS_WOUNDS_4 = 3019;
const int FEAT_BG_INFLICT_SERIOUS_WOUNDS_5 = 3020;
const int FEAT_BG_CONTAGION_1 = 3021;
const int FEAT_BG_CONTAGION_2 = 3022;
const int FEAT_BG_CONTAGION_3 = 3023;
const int FEAT_BG_CONTAGION_4 = 3024;
const int FEAT_BG_INFLICT_CRITICAL_WOUNDS_1 = 3025;
const int FEAT_BG_INFLICT_CRITICAL_WOUNDS_2 = 3026;
const int FEAT_BG_INFLICT_CRITICAL_WOUNDS_3 = 3027;
const int FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE_1 = 3028;
const int FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE_2 = 3029;
const int FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE_3 = 3030;
const int FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE_4 = 3031;
const int FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE_5 = 3032;
const int FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE_6 = 3033;
const int FEAT_PRESTIGE_DARKNESS_1 = 3034;
const int FEAT_PRESTIGE_DARKNESS_2 = 3035;
const int FEAT_PRESTIGE_DARKNESS_3 = 3036;
const int FEAT_PRESTIGE_DARKNESS_4 = 3037;
const int FEAT_PRESTIGE_DARKNESS_5 = 3038;
const int FEAT_PRESTIGE_DARKNESS_6 = 3039;
const int FEAT_PRESTIGEx_INVISIBILITY_1 = 3040;
const int FEAT_PRESTIGEx_INVISIBILITY_2 = 3041;
const int FEAT_PRESTIGEx_INVISIBILITY_3 = 3042;
const int FEAT_PRESTIGEx_INVISIBILITY_4 = 3043;
const int FEAT_PRESTIGEx_INVISIBILITY_5 = 3044;
const int FEAT_PRESTIGEx_INVISIBILITY_6 = 3045;
const int FEAT_PRESTIGE_IMP_INVISIBILITY_1 = 3046;
const int FEAT_PRESTIGE_IMP_INVISIBILITY_2 = 3047;
const int FEAT_PRESTIGE_IMP_INVISIBILITY_3 = 3048;
const int FEAT_PRESTIGE_IMP_INVISIBILITY_4 = 3049;
const int FEAT_PRESTIGE_IMP_INVISIBILITY_5 = 3050;
const int FEAT_PRESTIGE_IMP_INVISIBILITY_6 = 3051;
const int FEAT_EPIC_WIDEN_AURA_DESPAIR = 3052;
const int FEAT_EPIC_IMPROVED_AURA_DESPAIR = 3053;
const int FEAT_TEMPEST_WHIRLWIND = 3054;
const int FEAT_TEMPEST_DEFENSE = 3055;
const int FEAT_BFZ_SACRED_FLAME = 3056;
const int FEAT_BFZ_ZEALOUS_HEART = 3057;
const int FEAT_EPITHET_CELERITY_DOMAIN = 3058;
const int FEAT_EPITHET_DWARF_DOMAIN = 3059;
const int FEAT_EPITHET_ELF_DOMAIN = 3060;
const int FEAT_EPITHET_FATE_DOMAIN = 3061;
const int FEAT_EPITHET_HATRED_DOMAIN = 3062;
const int FEAT_EPITHET_MYSTICISM_DOMAIN = 3063;
const int FEAT_EPITHET_PESTILENCE_DOMAIN = 3064;
const int FEAT_EPITHET_STORM_DOMAIN = 3065;
const int FEAT_EPITHET_SUFFERING_DOMAIN = 3066;
const int FEAT_EPITHET_TYRANNY_DOMAIN = 3067;
const int FEAT_EPITHET_REPOSE_DOMAIN = 3068;
const int FEAT_EPITHET_COURAGE_DOMAIN = 3069;
const int FEAT_EPITHET_GLORY_DOMAIN = 3070;
const int FEAT_EPITHET_PURIFICATION_DOMAIN = 3071;
const int FEAT_EPITHET_COMPETITION_DOMAIN = 3072;
const int FEAT_DOMAIN_INSPIRE_HATRED = 3073;
const int FEAT_DOMAIN_MYSTIC_PROT = 3074;
const int FEAT_DOMAIN_PAIN_TOUCH = 3075;
const int FEAT_DOMAIN_DEATH_TOUCH = 3076;
const int FEAT_SB_SHOCK_BLADE1 = 3077;
const int FEAT_SB_SHOCK_BLADE2 = 3078;
const int FEAT_SB_HOLY_BLADE1 = 3079;
const int FEAT_SB_HOLY_BLADE2 = 3080;
const int FEAT_SB_HOLY_BLADE3 = 3081;
const int FEAT_DIVSEEK_SACRED_STEALTH = 3082;
const int FEAT_DIVSEEK_SACRED_DEFENSE = 3083;
const int FEAT_DIVSEEK_DIVINE_PERSERVERANCE= 3084;
const int FEAT_NI_TEAMWORK = 3085;
const int FEAT_NI_ADRENALINE_BOOST1 = 3086;
const int FEAT_NI_ADRENALINE_BOOST2 = 3087;
const int FEAT_NI_ADRENALINE_BOOST3 = 3088;
const int FEAT_NE_TEAMWORK = 3089;
const int FEAT_NE_AGILITY_TRAINING = 3090;
const int FEAT_NI_TRACKLESS_STEP_ALLIES = 3091;
const int FEAT_RESERVE_ACIDIC_SPLATTER = 3092;
const int FEAT_RESERVE_CLAP_OF_THUNDER = 3093;
const int FEAT_RESERVE_FIERY_BURST = 3094;
const int FEAT_RESERVE_HURRICANE_BREATH = 3095;
const int FEAT_RESERVE_INVISIBLE_NEEDLE = 3096;
const int FEAT_RESERVE_MINOR_SHAPESHIFT = 3097;
const int FEAT_RESERVE_STORM_BOLT = 3098;
const int FEAT_RESERVE_SICKENING_GRASP = 3099;
const int FEAT_RESERVE_SUMMON_ELEMENTAL = 3100;
const int FEAT_RESERVE_WINTERS_BLAST = 3101;
const int FEAT_RESERVE_HOLY_WARRIOR = 3102;
//const int FEAT_RESERVE_PROTECTIVE_WARD = 3103;
const int FEAT_RESERVE_TOUCH_OF_HEALING = 3104;
const int FEAT_RESERVE_UMBRAL_SHROUD = 3105;
const int FEAT_DC_TEAM_INITIATIVE = 3106;
const int FEAT_DC_ARMORED_EASE = 3107;

const int FEAT_WOD_DARKLING_WEAPON = 3109;
const int FEAT_WOD_SCARRED_FLESH = 3110;
const int FEAT_WOD_REPELLANT_FLESH = 3111;
const int FEAT_BLADESINGER_SPELLCASTING_BARD = 3112;
const int FEAT_BLADESINGER_SPELLCASTING_SORCERER = 3113;
const int FEAT_BLADESINGER_SPELLCASTING_WIZARD = 3114;
const int FEAT_BLADESINGER_BLADESONG_STYLE = 3115;
const int FEAT_BLADESINGER_SONG_CELERITY_1 = 3116;
const int FEAT_BLADESINGER_SONG_CELERITY_2 = 3117;
const int FEAT_BLADESINGER_SONG_FURY = 3118;
const int FEAT_ARMORED_CASTER_BLADESINGER = 3119;

const int FEAT_CROSSBOW_SNIPER = 3129;
const int FEAT_SACRED_VOW = 3130;
const int FEAT_EXALTED_NATURAL_ATTACK = 3131;
const int FEAT_EXALTED_WILD_SHAPE = 3132;
const int FEAT_EXALTED_COMPANION = 3133;
const int FEAT_RANGED_WEAPON_MASTERY = 3134;

const int FEAT_LION_TALISID_SPELLCASTING_PALADIN = 3150;

const int FEAT_SB_SHOCK_BLADE3 = 3171;
const int FEAT_SB_SHOCK_BLADE4 = 3172;
const int FEAT_SB_SHOCK_BLADE5 = 3173;

const int FEAT_MASTER_RADIANCE_SPELLCASTING_PALADIN = 3181;

const int FEAT_BATTLE_CASTER_BLADESINGER = 3189;

const int FEAT_FAST_HEALING_II = 3193;
const int FEAT_GTR_2WPN_DEFENSE = 3194;
const int FEAT_BECKON_THE_FROZEN = 3195;

const int FEAT_ARMOR_SPECIALIZATION_MEDIUM = 3198;
const int FEAT_ARMOR_SPECIALIZATION_HEAVY = 3199;
const int FEAT_EPIC_INSPIRATION = 3200;
const int FEAT_SONG_OF_THE_HEART = 3201;

const int FEAT_DAYLIGHT_ENDURANCE = 3203;
const int FEAT_OVERSIZE_TWO_WEAPON_FIGHTING = 3204;

const int FEAT_BATTLE_DANCER = 3206;
const int FEAT_FIERY_FIST = 3207;

const int FEAT_UNARMED_COMBAT_MASTERY = 3209;

const int FEAT_FOREST_MASTER_SPELLCASTING_PALADIN = 3213;

const int FEAT_FOREST_MASTER_FOREST_HAMMER = 3218;

const int FEAT_ELEM_ARCHER_ELEM_STORM = 3230;
const int FEAT_ELEM_ARCHER_IMP_ELEM_SHIELD = 3231;
const int FEAT_ELEM_ARCHER_IMP_ELEM_STORM = 3232;
const int FEAT_ELEM_ARCHER_PATH_AIR = 3233;
const int FEAT_ELEM_ARCHER_PATH_EARTH = 3234;
const int FEAT_ELEM_ARCHER_PATH_FIRE = 3235;
const int FEAT_ELEM_ARCHER_PATH_WATER = 3236;
const int FEAT_DEADLY_DEFENSE = 3237;
const int FEAT_DRAGON_DIS_BLACK = 3238;
const int FEAT_DRAGON_DIS_BLUE = 3239;
const int FEAT_DRAGON_DIS_BRASS = 3240;
const int FEAT_DRAGON_DIS_BRONZE = 3241;
const int FEAT_DRAGON_DIS_COPPER = 3242;
const int FEAT_DRAGON_DIS_GOLD = 3243;
const int FEAT_DRAGON_DIS_GREEN = 3244;
const int FEAT_DRAGON_DIS_RED = 3245;
const int FEAT_DRAGON_DIS_SILVER = 3246;
const int FEAT_DRAGON_DIS_WHITE = 3247;
const int FEAT_DRAGON_DIS_GENERAL = 3248;
const int FEAT_DRAGON_DIS_IMMUNITY = 3249;

const int FEAT_BARB_WHIRLWIND_FRENZY = 3251;

const int FEAT_NATWARR_NATARM_CROC = 3255;
const int FEAT_NATWARR_NATARM_BLAZE = 3256;
const int FEAT_NATWARR_NATARM_GRIZZLY = 3257;
const int FEAT_NATWARR_NATARM_EARTH = 3258;
const int FEAT_NATWARR_NATARM_CLOUD = 3259;
const int FEAT_NATWARR_NATARM_GROWTH = 3260;

const int FEAT_HEARTWARDER_SPELLCASTING_BARD = 3262;
const int FEAT_HEARTWARDER_SPELLCASTING_CLERIC = 3263;
const int FEAT_HEARTWARDER_SPELLCASTING_DRUID = 3264;
const int FEAT_HEARTWARDER_SPELLCASTING_FAVORED_SOUL = 3265;
const int FEAT_HEARTWARDER_SPELLCASTING_PALADIN = 3266;

const int FEAT_HEARTWARDER_SPELLCASTING_RANGER = 3267;
const int FEAT_HEARTWARDER_SPELLCASTING_SORCERER = 3268;
const int FEAT_HEARTWARDER_SPELLCASTING_SPIRIT_SHAMAN = 3269;
const int FEAT_HEARTWARDER_SPELLCASTING_WIZARD = 3270;
const int FEAT_HEARTWARDER_SPELLCASTING_WARLOCK = 3271;

const int FEAT_FROSTMAGE_SPELLCASTING_PALADIN = 3279;

const int FEAT_FROSTMAGE_PIERCING_COLD = 3285;


const int FEAT_SACREDFIST_CODE_OF_CONDUCT = 3316;

const int FEAT_DARING_OUTLAW = 3319;
const int FEAT_CANAITH_SPELLCASTING_BARD = 3320;
const int FEAT_CANAITH_SPELLCASTING_CLERIC = 3321;
const int FEAT_CANAITH_SPELLCASTING_DRUID = 3322;
const int FEAT_CANAITH_SPELLCASTING_FAVORED_SOUL = 3323;
const int FEAT_CANAITH_SPELLCASTING_PALADIN = 3324;
const int FEAT_CANAITH_SPELLCASTING_RANGER = 3325;
const int FEAT_CANAITH_SPELLCASTING_SORCERER = 3326;
const int FEAT_CANAITH_SPELLCASTING_SPIRIT_SHAMAN = 3327;
const int FEAT_CANAITH_SPELLCASTING_WIZARD = 3328;


const int FEAT_MELODIC_CASTING = 3330;
const int FEAT_LYRIC_THAUM_SONIC_MIGHT = 3331;

const int FEAT_KOT_SPELLCASTING_BARD = 3332;
const int FEAT_KOT_SPELLCASTING_CLERIC = 3333;
const int FEAT_KOT_SPELLCASTING_DRUID = 3334;
const int FEAT_KOT_SPELLCASTING_FAVORED_SOUL = 3335;
const int FEAT_KOT_SPELLCASTING_PALADIN = 3336;

const int FEAT_KOT_SPELLCASTING_RANGER = 3337;
const int FEAT_KOT_SPELLCASTING_SORCERER = 3338;
const int FEAT_KOT_SPELLCASTING_SPIRIT_SHAMAN = 3339;
const int FEAT_KOT_SPELLCASTING_WIZARD = 3340;
const int FEAT_KOT_SPELLCASTING_WARLOCK = 3341;
const int FEAT_KOT_SPELLCASTING_ASSASSIN = 3342;
const int FEAT_KOT_SPELLCASTING_AVENGER = 3343;
const int FEAT_KOT_SPELLCASTING_BLACKGUARD = 3344;

const int FEAT_SHDWSTLKR_SPELLCASTING_PALADIN = 3348;

const int FEAT_PRACTICED_SPELLCASTER_ASSASSIN = 3353;
const int FEAT_PRACTICED_SPELLCASTER_BLACKGUARD = 3354;
const int FEAT_PRACTICED_SPELLCASTER_AVENGER = 3355;
const int FEAT_DIVCHA_SPELLCASTING = 3356;
const int FEAT_INTUITIVE_ATTACK = 3357;

const int FEAT_DRSLR_SPELLCASTING_BARD = 3363;
const int FEAT_DRSLR_SPELLCASTING_CLERIC = 3364;
const int FEAT_DRSLR_SPELLCASTING_DRUID = 3365;
const int FEAT_DRSLR_SPELLCASTING_FAVORED_SOUL = 3366;
const int FEAT_DRSLR_SPELLCASTING_PALADIN = 3367;

const int FEAT_DRSLR_SPELLCASTING_RANGER = 3368;
const int FEAT_DRSLR_SPELLCASTING_SORCERER = 3369;
const int FEAT_DRSLR_SPELLCASTING_SPIRIT_SHAMAN = 3370;
const int FEAT_DRSLR_SPELLCASTING_WIZARD = 3371;
const int FEAT_DRSLR_SPELLCASTING_WARLOCK = 3372;
const int FEAT_DRSLR_SPELLCASTING_ASSASSIN = 3373;
const int FEAT_DRSLR_SPELLCASTING_AVENGER = 3374;
const int FEAT_DRSLR_SPELLCASTING_BLACKGUARD = 3375;

const int FEAT_ELDDISC_SPELLCASTING_PALADIN = 3383;

const int FEAT_ELEMWAR_AFFINITY_AIR = 3500;
const int FEAT_ELEMWAR_AFFINITY_EARTH = 3501;
const int FEAT_ELEMWAR_AFFINITY_FIRE = 3502;
const int FEAT_ELEMWAR_AFFINITY_WATER = 3503;

const int FEAT_ELEMSHAPE_EMBERGUARD = 3518;
const int FEAT_AUGMENT_ELEMENTAL = 3519;
const int FEAT_ASHBOUND = 3520;
const int FEAT_SHARED_FURY = 3522;

const int FEAT_MELEE_WEAPON_MASTERY_B = 3524;
const int FEAT_MELEE_WEAPON_MASTERY_P = 3525;
const int FEAT_MELEE_WEAPON_MASTERY_S = 3526;
const int FEAT_SILVER_FANG = 3527;
const int FEAT_SILVER_FANG_COMP = 3528;
const int FEAT_DRAGONSONG = 3529;
const int FEAT_ABILITY_FOCUS_BARDSONG = 3530;
const int FEAT_ABILITY_FOCUS_ELDRITCH_BLAST = 3531;
const int FEAT_ABILITY_FOCUS_INVOCATIONS = 3532;
const int FEAT_SANCTIFY_STRIKES = 3533;
const int FEAT_HEAVY_ARMOR_OPTIMIZATION = 3534;
const int FEAT_GREATER_HEAVY_ARMOR_OPTIMIZATION = 3535;

const int FEAT_STORMSINGER_SPELLCASTING_BARD = 3126;
const int FEAT_STORMSINGER_SPELLCASTING_CLERIC = 3121;
const int FEAT_STORMSINGER_SPELLCASTING_DRUID = 33122;
const int FEAT_STORMSINGER_SPELLCASTING_FAVORED_SOUL = 3125;
const int FEAT_STORMSINGER_SPELLCASTING_PALADIN = 3123;
const int FEAT_STORMSINGER_SPELLCASTING_RANGER = 3124;
const int FEAT_STORMSINGER_SPELLCASTING_SORCERER = 3127;
const int FEAT_STORMSINGER_SPELLCASTING_SPIRIT_SHAMAN = 3120;
const int FEAT_STORMSINGER_SPELLCASTING_WIZARD = 3128;
const int FEAT_STORMSINGER_SPELLCASTING_WARLOCK = 3545;
const int FEAT_COTSF_SPELLCASTING_PALADIN = 3546;

const int FEAT_RESERVE_PROTECTIVE_WARD = 3553;

const int FEAT_SWRDNCR_SPELLCASTING_PALADIN = 3556;

const int FEAT_DISCHORD_IMPROVED_COUNTERSPELL = 3569;

const int FEAT_CHLDNIGHT_SPELLCASTING_BARD = 3576;
const int FEAT_CHLDNIGHT_SPELLCASTING_CLERIC = 3577;
const int FEAT_CHLDNIGHT_SPELLCASTING_DRUID = 3578;
const int FEAT_CHLDNIGHT_SPELLCASTING_FAVORED_SOUL = 3579;
const int FEAT_CHLDNIGHT_SPELLCASTING_PALADIN = 3580;
const int FEAT_CHLDNIGHT_SPELLCASTING_RANGER = 3581;
const int FEAT_CHLDNIGHT_SPELLCASTING_SORCERER = 3582;
const int FEAT_CHLDNIGHT_SPELLCASTING_SPIRIT_SHAMAN = 3583;
const int FEAT_CHLDNIGHT_SPELLCASTING_WIZARD = 3584;
const int FEAT_CHLDNIGHT_SPELLCASTING_WARLOCK = 3585;
const int FEAT_CHLDNIGHT_SPELLCASTING_ASSASSIN = 3586;
const int FEAT_CHLDNIGHT_SPELLCASTING_AVENGER = 3587;
const int FEAT_CHLDNIGHT_SPELLCASTING_BLACKGUARD = 3588;

const int FEAT_DERVISH_DEFENSIVE_PARRY = 3613;

const int FEAT_NINJA_KI_POWER_1 = 3617;

const int FEAT_DRPIRATE_RALLY_THE_CREW_1 = 3686;
const int FEAT_DRPIRATE_RALLY_THE_CREW_2 = 3687;

const int FEAT_EXPANDED_KI_POOL = 3692;

const int FEAT_ASCETIC_STALKER = 3695;
const int FEAT_MARTIAL_STALKER = 3696;
const int FEAT_DEVOTED_TRACKER = 3697;
const int FEAT_EXTRA_SPIRIT_FORM = 3698;
const int FEAT_EXTRA_SPIRIT_JOURNEY = 3698;

const int FEAT_TELTHOR_COMPANION = 3704;
const int FEAT_IMPROVED_NATURAL_BOND = 3705;

const int FEAT_SCOUT_SKIRMISHAC = 3709;
const int FEAT_SWIFT_AMBUSHER = 3710;
const int FEAT_SWIFT_HUNTER = 3711;

const int FEAT_DMAGE_SPELLCASTING_WARLOCK = 3718;

const int FEAT_VGUARD_PLANT_SHAPE1 = 3730;

const int FEAT_ENERGY_SUBSTITUTION = -1;


//

const int SPELL_ASN_GhostlyVisage = 1698;
const int SPELL_ASN_Sleep = 1699;
const int SPELL_ASN_True_Strike = 1700;
const int SPELL_ASN_Spellbook_2 = 1701;
const int SPELL_ASN_Cats_Grace = 1702;
const int SPELL_ASN_Foxs_Cunning = 1703;
const int SPELL_ASN_Darkness = 1704;
const int SPELL_ASN_Spellbook_3 = 1705;
const int SPELL_ASN_Invisibility = 1706;
const int SPELL_ASN_Deep_Slumber = 1707;
const int SPELL_ASN_False_Life = 1708;
const int SPELL_ASN_Magic_Circle_against_Good = 1709;
const int SPELL_ASN_Spellbook_4 = 1710;
const int SPELL_ASN_ImprovedInvisibility = 1711;
const int SPELL_ASN_Freedom_of_Movement = 1712;
const int SPELL_ASN_Poison = 1713;
const int SPELL_ASN_Clairaudience_and_Clairvoyance = 1714;
const int SPELL_BG_Spellbook_1 = 1715;
const int SPELL_BG_BullsStrength = 1716;
const int SPELL_BG_Magic_Weapon = 1717;
const int SPELL_BG_Doom = 1718;
const int SPELL_BG_Cure_Light_Wounds = 1719;
const int SPELL_BG_Spellbook_2 = 1720;
const int SPELL_BG_InflictSerious = 1721;
const int SPELL_BG_Darkness = 1722;
const int SPELL_BG_Cure_Moderate_Wounds = 1723;
const int SPELL_BG_Eagle_Splendor = 1724;
const int SPELL_BG_Death_Knell = 1725;
const int SPELL_BG_Spellbook_3 = 1726;
const int SPELL_BG_Contagion = 1727;
const int SPELL_BG_Cure_Serious_Wounds = 1728;
const int SPELL_BG_Protection_from_Energy = 1729;
const int SPELL_BG_Summon_Creature_III = 1730;
const int SPELL_BG_Spellbook_4 = 1731;
const int SPELL_BG_InflictCritical = 1732;
const int SPELL_BG_Cure_Critical_Wounds = 1733;
const int SPELL_BG_Freedom_of_Movement = 1734;
const int SPELL_BG_Poison = 1735;
const int SPELL_Tempest_Whirlwind = 1736;
const int SPELL_Tempest_Defense = 1737;
const int SPELL_Angelskin = 1738;
const int SPELL_Awaken_Sin = 1739;
const int SPELL_Blessed_Aim = 1740;
const int SPELL_Blessing_Bahumut = 1741;
const int SPELL_Blessing_Righteous = 1742;
const int SPELL_Castigate = 1743;
const int SPELL_Cloak_Bravery = 1744;
const int SPELL_Deafening_Clang = 1745;
const int SPELL_Draconic_Might = 1746;
const int SPELL_Lesser_Energized_Shield = 1747;
const int SPELL_Lesser_Energizedl_Shield_F = 1748;
const int SPELL_Lesser_Energized_Shield_C = 1749;
const int SPELL_Lesser_Energized_Shield_E = 1750;
const int SPELL_Lesser_Energized_Shield_A = 1751;
const int SPELL_Lesser_Energized_Shield_S = 1752;
const int SPELL_Energized_Shield = 1753;
const int SPELL_Energizedl_Shield_F = 1754;
const int SPELL_Energized_Shield_C = 1755;
const int SPELL_Energized_Shield_E = 1756;
const int SPELL_Energized_Shield_A = 1757;
const int SPELL_Energized_Shield_S = 1758;
const int SPELL_Flame_Faith = 1759;
const int SPELL_Hand_Divinity = 1760;
const int SPELL_Lawful_Sword = 1761;
const int SPELL_ASN_Spellbook_1 = 1762;

const int SPELL_Righteous_Fury = 1764;
const int SPELL_Second_Wind = 1765;
const int SPELL_Shield_Warding = 1766;
const int SPELL_Silverbeard = 1767;
const int SPELL_Strategic_Charge = 1768;
const int SPELL_Strength_Stone = 1769;
const int SPELL_Undead_Bane_Weapon = 1770;
const int SPELL_Weapon_of_the_Deity = 1771;
const int SPELL_Zeal = 1772;
const int SPELL_Blood_of_the_Martyr = 1773;
const int SPELL_Righteous_Glory = 1774;

const int SPELL_SB_Shocking_Blade = 1789;
const int SPELL_BFZ_Sacred_Flame = 1790;
const int SPELL_BFZ_Zealous_Heart = 1791;
const int SPELL_SB_Holy_Blade = 1792;
const int SPELL_Blasphemy = 1793;
const int SPELL_Holy_Word = 1794;
const int SPELL_Visage_Deity = 1795;
const int SPELL_Scourge = 1796;
const int SPELL_Domain_Inspire_Hatred = 1797;
const int SPELL_Domain_Mystic_Protection = 1798;
const int SPELL_Domain_Pain_Touch = 1799;
const int SPELL_Domain_Death_Touch = 1800;

const int SPELL_Lay_On_Hands_Hostilev1 = 1802;

const int SPELL_Chasing_Perfection = 1812;
const int SPELL_Sonic_Shield = 1813;
const int SPELL_Weapon_Energy = 1814;
const int SPELL_Weapon_Energy_F = 1815;
const int SPELL_Weapon_Energy_A = 1816;
const int SPELL_Weapon_Energy_C = 1817;
const int SPELL_Weapon_Energy_E = 1818;
const int SPELL_Inspirational_Boost = 1819;
const int SPELL_Lions_Roar = 1820;
const int SPELL_Living_Undeath = 1821;
const int SPELL_Lesser_Orb_Cold = 1822;
const int SPELL_Lesser_Orb_Fire = 1823;
const int SPELL_Lesser_Orb_Electricity = 1824;
const int SPELL_Orb_Cold = 1825;
const int SPELL_Orb_Fire = 1826;
const int SPELL_Orb_Electricity = 1827;
const int SPELL_Natures_Favor = 1828;
const int SPELL_Resonating_Bolt = 1829;
const int SPELL_Sirines_Grace = 1830;
const int SPELL_Sonic_Weapon = 1831;
const int SPELL_Wild_Instinct = 1832;
const int SPELL_Nixies_Grace = 1833;
const int SPELL_DIVSEEK_SACRED_DEFENSE = 1834;
const int SPELL_DIVSEEK_SACRED_STEALTH = 1835;
const int SPELL_DIVSEEK_DIVINE_PERSERVERANCE = 1836;
const int SPELL_NIGHTSONGI_ADRENALINE_BOOST = 1837;
const int SPELL_SPELLABILITY_AURA_NI_TEAMWORK = 1838;
const int SPELL_SPELLABILITY_AURA_NE_TEAMWORK = 1839;
const int SPELL_NIGHTSONGE_AGILITY_TRAINING = 1840;

const int SPELL_Lay_On_Hands_HOSTILEv2 = 1842;
const int SPELL_NIGHTSONGI_TRACKLESS_STEP_ALLIES = 1843;
const int SPELL_REMOVED_Eldritch_Glaive = 1844;
const int SPELL_Lesser_Dispel_AoE = 1845;
const int SPELL_Lesser_Dispel_Hostile = 1846;
const int SPELL_Lesser_Dispel_Friendly = 1847;
const int SPELL_Dispel_Magic_AoE = 1848;
const int SPELL_Dispel_Magic_Hostile = 1849;
const int SPELL_Dispel_Magic_Friendly = 1850;
const int SPELL_Greater_Dispel_Magic_AoE = 1851;
const int SPELL_Greater_Dispel_Magic_Hostile = 1852;
const int SPELL_Greater_Dispel_Magic_Friendly = 1853;
const int SPELL_Mordenkainens_Disjunction_AoE = 1854;
const int SPELL_Mordenkainens_Disjunction_Hostile = 1855;
const int SPELL_Mordenkainens_Disjunction_Friendly = 1856;
const int SPELL_Faerie_Fire = 1857;
const int SPELL_Heartfire = 1858;   
const int SPELL_Orb_Acid = 1859;               
const int SPELL_Lesser_Orb_Acid = 1860;
const int SPELL_Orb_Sound = 1861;
const int SPELL_Lesser_Orb_Sound = 1862;
const int SPELL_Orb_Force = 1863;
const int SPELL_SPELLABILITY_Acidic_Splatter = 1864;
const int SPELL_SPELLABILITY_Clap_Thunder = 1865;
const int SPELL_SPELLABILITY_Fiery_Burst = 1866;
const int SPELL_SPELLABILITY_Hurricane_Breath = 1867;
const int SPELL_SPELLABILITY_Invisible_Needle = 1868;

const int SPELL_SPELLABILITY_Storm_Bolt = 1870;
const int SPELL_SPELLABILITY_Sickening_Graspe = 1871;
const int SPELL_SPELLABILITY_Summon_Elemental = 1872;
const int SPELL_SPELLABILITY_Winters_Blast = 1873;
const int SPELL_SPELLABILITY_Holy_Warrior = 1874;
const int SPELL_SPELLABILITY_Protective_Ward = 1875;
const int SPELL_SPELLABILITY_Healing_Touch = 1876;
const int SPELL_SPELLABILITY_Umbral_Shroud = 1877;
const int SPELLABILITY_AURA_DC_TEAMINIT = 1878;
const int DREADCOM_ARMORED_EASE = 1879;
const int WOD_DARKLING_WEAPON = 1880;
const int WOD_DARKLING_WEAPON_FLAMING = 1881;
const int WOD_DARKLING_WEAPON_FROST = 1882;
const int WOD_DARKLING_WEAPON_VAMP = 1883;
const int WOD_DARKLING_WEAPON_SHOCK = 1884;
const int WOD_DARKLING_WEAPON_CRITS = 1885;
const int WOD_SCARRED_FLESH = 1886;
const int WOD_REPELLANT_FLESH = 1887;
const int BLADESINGER_BLADESONG_STYLE = 1888;
const int BLADESINGER_SONG_CELERITY = 1889;
const int BLADESINGER_SONG_FURY = 1890;
const int SPELLABILITY_Crossbow_Sniper = 1891;
const int SPELLABILITY_Sacred_Vow = 1892;
const int SPELLABILITY_Ranged_Weapon_Mastery = 1893;
const int STORMSINGER_GUST_OF_WIND = 1894;
const int STORMSINGER_THUNDERSTRIKE = 1895;
const int STORMSINGER_CALL_LIGHTNING = 1896;
const int STORMSINGER_WINTER_BALLAD = 1897;
const int STORMSINGER_GTR_THUNDERSTRIKE = 1898;
const int STORMSINGER_STORM_VENGEANCE = 1899;
const int STORMSINGER_RESIST_ELECTRICITY = 1900;
const int AKNIGHT_ANOINT_WEAPON = 1901;
const int AKNIGHT_ANOINT_WEAPON_FLAMING = 1902;
const int AKNIGHT_ANOINT_WEAPON_FROST = 1903;
const int AKNIGHT_ANOINT_WEAPON_VAMP = 1904;
const int AKNIGHT_ANOINT_WEAPON_SHOCK = 1905;
const int AKNIGHT_ANOINT_WEAPON_CRITS = 1906;
const int AKNIGHT_UNBROKEN_FLESH = 1907;
const int AKNIGHT_SACRED_FLESH = 1908;
const int LION_TALISID_LIONS_COURAGE = 1909;
const int LION_TALISID_LIONS_SWIFTNESS = 1910;
const int LION_TALISID_LEONALS_ROAR = 1911;
const int SWIFTBLADE_SWIFTSURGE = 1912;

const int SPELLABILITY_Divine_Armor = 1915;
const int SPELLABILITY_Divine_Fortune = 1916;
const int SPELLABILITY_Divine_Cleansing = 1917;
const int SPELLABILITY_Divine_Vigor = 1918;
const int SPELLABILITY_Minor_Shapeshift = 1919;
const int SPELLABILITY_Minor_Shapeshift_Might = 1920;
const int SPELLABILITY_Minor_Shapeshift_Speed = 1921;
const int SPELLABILITY_Minor_Shapeshift_Vigor = 1922;
const int SPELLABILITY_Armored_Caster = 1923;
const int SPELLABILITY_Battle_Caster = 1924;
const int SPELLABILITY_Fast_Healing_I = 1925;
const int SPELLABILITY_Fast_Healing_II = 1926;
const int SPELLABILITY_Gtr_2Wpn_Defense = 1927;

const int SPELLABILITY_TOXIC_GIFT = 1933;
const int SPELLABILITY_ELEMENTAL_ESSENCE = 1934;
const int SPELLABILITY_ELEMENTAL_ESSENCE_A = 1935;
const int SPELLABILITY_ELEMENTAL_ESSENCE_C = 1936;
const int SPELLABILITY_ELEMENTAL_ESSENCE_E = 1937;
const int SPELLABILITY_ELEMENTAL_ESSENCE_F = 1938;
const int SPELLABILITY_ARMOR_SPECIALIZATION_MEDIUM = 1939;
const int SPELLABILITY_ARMOR_SPECIALIZATION_HEAVY = 1940;
const int SPELLABILITY_RACIAL_FAERIE_FIRE = 1941;
const int SPELLABILITY_OVERSIZE_TWO_WEAPON_FIGHTING = 1942; 
const int SPELLABILITY_MASTER_RADIANCE_SEARING_LIGHT = 1943;
const int SPELLABILITY_MASTER_RADIANCE_BEAM_SUNLIGHT = 1944;
const int SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA = 1945;
const int SPELLABILITY_PENETRATING_SHOT = 1946;
const int SPELLABILITY_BATTLE_DANCER = 1947;
const int SPELLABILITY_FIERY_FIST = 1948;
const int SPELLABILITY_FIERY_KI_DEFENSE = 1949;
const int SPELL_Plant_Body = 1950;
const int SPELL_Thorn_Skin = 1951;
const int SPELLABILITY_UNARMED_COMBAT_MASTERY = 1952;
const int ELEM_ARCHER_ELEM_SHOT = 1953;
const int ELEM_ARCHER_ELEM_SHIELD = 1954;
const int ELEM_ARCHER_ELEM_STORM = 1955;

const int FOREST_MASTER_FOREST_HAMMER = 1958;
const int FOREST_MASTER_FOREST_HAMMER_FROST = 1959;
const int FOREST_MASTER_FOREST_HAMMER_SHOCK = 1960;
const int FOREST_MASTER_OAKEN_SKIN = 1961;
const int FOREST_MASTER_OAK_HEART = 1963;
const int FOREST_MASTER_DEEP_ROOTS = 1964;
const int FOREST_MASTER_FOREST_MIGHT = 1965;

const int SPELLABILITY_DARKLANT_CIT_TRAIN = 1967;
const int SPELLABILITY_HEARTWARD_HEART_PASSION = 1968;
const int SPELLABILITY_HEARTWARD_LIPS_RAPTURE = 1969;
const int SPELLABILITY_ARMOR_FROST = 1970;
const int SPELLABILITY_SKULLCLAN_HUNTERS_IMMUNITIES = 1971;
const int SPELLABILITY_CHAMPWILD_ELEGANT_STRIKE = 1972;
const int SPELLABILITY_CHAMPWILD_SUPERIOR_DEFENSE = 1973;
const int SPELLABILITY_CHAMPWILD_WRATH_WILD = 1974;
const int SPELLABILITY_INTUITIVE_ATTACK = 1975;

const int SACREDFIST_CODE_OF_CONDUCT = 1979;

const int SPELLABILITY_SHDWSTLKR_SACRED_STEALTH = 1984;
const int SPELLABILITY_SHDWSTLKR_DISCOVER_SUBTERFUGE = 1985;
const int SPELLABILITY_DRSLR_DMG_BONUS = 1986;

const int SPELLABILITY_ELEMWAR_AFFINITY = 2000;
const int SPELLABILITY_ELEMWAR_MANIFESTATION = 2004;
const int SPELLABILITY_ELEMWAR_WEAPON = 2005;
const int SPELLABILITY_ELEMWAR_SANCTUARY = 2006;
const int SPELLABILITY_ELEMWAR_STRIKE = 2007;
const int SPELLABILITY_WHDERV_CRITSENSE = 2008;

const int SPELLABILITY_WEAPON_SUPREMACY = 2012;
const int SPELLABILITY_MELEE_WEAPON_MASTERY_B = 2013;
const int SPELLABILITY_MELEE_WEAPON_MASTERY_P = 2014;
const int SPELLABILITY_MELEE_WEAPON_MASTERY_S = 2015;
const int SPELLABILITY_SANCTIFY_STRIKES = 2016;
const int SPELLABILITY_DRAGONSONG = 2017;
const int SPELLABILITY_HEAVY_ARMOR_OPTIMIZATION = 2018;
const int SPELLABILITY_GREATER_HEAVY_ARMOR_OPTIMIZATION = 2019;
const int SPELLABILITY_FOTF_AC_BONUS = 2020;
const int SPELLABILITY_FOTF_UNARMED_BONUS = 2021;
const int SPELLABILITY_FOTF_FERAL_STANCE = 2022;
const int SPELLABILITY_COTSF_BLESSING_CHAMP = 2024;

const int SONG_SNOWFLAKE_WARDANCE = 2029;
const int SPELLABILITY_CHLDNIGHT_CLOAK_SHADOWS = 2030;
const int SPELLABILITY_CHLDNIGHT_DANCE_SHADOWS = 2031;
const int SPELLABILITY_CHLDNIGHT_NIGHT_FORM = 2032;
const int SPELLABILITY_ELDDISC_DR = 2033;
const int SPELLABILITY_ELDDISC_FR = 2034;
const int SPELLABILITY_ELDDISC_HB = 2035;
const int SPELLABILITY_ELDDISC_WF = 2036;
const int SPELLABILITY_DRGWRR_RESIST_ENERGY = 2037;
const int SPELLABILITY_DRGWRR_ELEMENTAL_WEAPON = 2038;
const int SPELLABILITY_DRGWRR_DRG_BREATH = 2039;
const int SPELLABILITY_DISCHORD_BREAK_CONC = 2040;
const int SPELLABILITY_DISCHORD_DISJUNCT = 2041;
const int SPELLABILITY_PALADIN_SPIRIT_COMBAT = 2042;
const int SPELLABILITY_PALADIN_SPIRIT_HEROISM = 2043;
const int SPELLABILITY_PALADIN_SPIRIT_FALLEN = 2044;
const int SPELLABILITY_DERVISH_AC_BONUS = 2045;
const int SPELLABILITY_DERVISH_DANCE = 2046;
const int SPELLABILITY_THOUSAND_CUTS = 2047;
const int SPELLABILITY_NINJA_AC_BONUS = 2048;
const int SPELLABILITY_NINJA_GHOST_STEP = 2049;
const int SPELLABILITY_NINJA_KI_DODGE = 2050;
const int SPELLABILITY_NINJA_GHOST_STRIKE = 2051;
const int SPELLABILITY_NINJA_GHOST_WALK = 2052;
const int SPELLABILITY_GFK_GHOST_STEP = 2053;
const int SPELLABILITY_GFK_FRIGHTFUL_ATK = 2054;

const int SPELLABILITY_DRPIRATE_FEARSOME_REPUTATION = 2061;
const int SPELLABILITY_DRPIRATE_RALLY_THE_CREW = 2062;

const int SPELLABILITY_SCOUT_BATTLEFORT = 2064;
const int SPELLABILITY_SCOUT_SKIRMISHAC = 2065;
const int SPELLABILITY_VGUARD_PLANT_SHAPE = 2066;

const int SPELLABILITY_ENERGY_SUBSTITUTION_ACID = -100;
const int SPELLABILITY_ENERGY_SUBSTITUTION_COLD = -101;
const int SPELLABILITY_ENERGY_SUBSTITUTION_ELEC = -102;
const int SPELLABILITY_ENERGY_SUBSTITUTION_FIRE = -103;
const int SPELLABILITY_ENERGY_SUBSTITUTION_SONIC = -104;

const int SPELLABILITY_EXALTED_WILD_SHAPE = -3132;


//

const int VFX_PER_WIDEN_AURA_OF_DESPAIR = 81;
const int VFX_PER_PRC_DARKNESS = 82;
const int VFX_MOB_PRC_CIRCEVIL = 83;
const int VFX_PER_NI_TEAMWORK = 84;
const int VFX_PER_NE_TEAMWORK = 85;
const int VFX_PER_DC_TEAMINIT = 86;
const int VFX_PER_STORMSINGER_STORM = 87;
const int VFX_PER_RADIANT_AURA = 88;
const int VFX_PER_BREAK_CONC = 89;

const int IPRP_FEAT_UNCANNYDODGE1 = 800;
const int IPRP_FEAT_EPIC_PERFECT_TWO_WEAPON_FIGHTING = 801;
const int IPRP_FEAT_TRACKLESSSTEP = 802;
const int IPRP_FEAT_EPIC_SUPERIOR_INITIATIVE = 803;
const int IPRP_FEAT_IMPCRITCREATURE = 804;
const int IPRP_FEAT_WPNSPEC_CREATURE = 805;
const int IPRP_FEAT_EPICWPNFOC_CREATURE = 806;
const int IPRP_FEAT_EPICWPNSPEC_CREATURE = 807;
const int IPRP_FEAT_EPICOVERWHELMCRIT_CREATURE = 808;
const int IPRP_FEAT_GHOST_WARRIOR = 809;

const int DOMAIN_CELERITY = 32;
const int DOMAIN_DWARF = 33;
const int DOMAIN_ELF = 34;
const int DOMAIN_FATE = 35;
const int DOMAIN_HATRED = 36;
const int DOMAIN_MYSTICISM = 37;
const int DOMAIN_PESTILENCE = 38;
const int DOMAIN_STORM = 39;
const int DOMAIN_SUFFERING = 40;
const int DOMAIN_TYRANNY = 41;
const int DOMAIN_REPOSE = 42;
const int DOMAIN_COURAGE = 43;
const int DOMAIN_GLORY = 44;
const int DOMAIN_PURIFICATION = 45;
const int DOMAIN_COMPETITION = 46;

const int CMI_OPTIONS_PaladinFullCaster = 0;
const int CMI_OPTIONS_SneakAttackSpells = 1;
const int CMI_OPTIONS_TouchofHealingUse50PercentCap = 2;
const int CMI_OPTIONS_TouchofHealingUseAugmentHealing = 3;
const int CMI_OPTIONS_UseAlternateTurnUndeadRules = 4;
const int CMI_OPTIONS_PaladinOnlyAlternateTurnUndeadRule = 5;
const int CMI_OPTIONS_AmmoStacksToCreate = 6;
const int CMI_OPTIONS_TempestStackWithRanger = 7;
const int CMI_OPTIONS_ElaborateParry = 8;
const int CMI_OPTIONS_UseSacredFistFix = 9;
const int CMI_OPTIONS_UseTwoWpnDefense = 10;
const int CMI_OPTIONS_HolyWarriorCap = 11;
const int CMI_OPTIONS_Stormlord24HrBuffDuration = 12;
const int CMI_OPTIONS_ArcaneShapesCanCast = 13;
const int CMI_OPTIONS_UnarmedPolymorphFeatFix = 14;
const int CMI_OPTIONS_DaringOutlawCap = 15;
const int CMI_OPTIONS_DivChampSpellcastingProgression = 16;
const int CMI_OPTIONS_EldGlaiveAttackCap = 17;
const int CMI_OPTIONS_EldGlaiveAllowEldMastery = 18;
const int CMI_OPTIONS_EldGlaiveAllowEssence = 19;
const int CMI_OPTIONS_EldGlaiveAllowCrits = 20;
const int CMI_OPTIONS_EldGlaiveAllowHasteBoost = 21;
const int CMI_OPTIONS_HealingHymnCap = 22;
const int CMI_OPTIONS_CrossbowSniper50PercentDexCap = 23;
const int CMI_OPTIONS_WintersBlastUsesPiercingCold = 24;
const int CMI_OPTIONS_UseSRFix = 25;
const int CMI_OPTIONS_UseDmgResFix = 26;
const int CMI_OPTIONS_UseEnhancedBGPet = 27;
const int CMI_OPTIONS_UseWildshapeTiers = 28;
const int CMI_OPTIONS_LoadCMIOptions = 29;
const int CMI_OPTIONS_FreeEmberGuard = 30;
const int CMI_OPTIONS_PlanetouchedGetMartialWeaponProf = 31;
const int CMI_OPTIONS_FangLineExceeds20 = 32;
const int CMI_OPTIONS_SpellSpecAdds1PerDie = 33;
const int CMI_OPTIONS_SonicMightAffectsClapofThunder = 34;
const int CMI_OPTIONS_ArcaneShapesUseWildshapeFixes = 35;
const int CMI_OPTIONS_UnlimitedWildshapeUses = 36;
const int CMI_OPTIONS_FrostMageArmorStacks = 37;
const int CMI_OPTIONS_EnableReserveMeta = 38;
const int CMI_OPTIONS_GrantSerenasCoin = 39;

const int VFX_BEAM_RESONBOLT = 1200;

const float RADIUS_SIZE_INNERVATE_SPEED = 30.48f;

//Polymorph.2da
const int POLYMORPH_WILDSHAPE_TYPE_PANTHER = 162;
const int POLYMORPH_WILDSHAPE_TYPE_DIRE_PANTHER = 163;
const int POLYMORPH_TYPE_EMBER_GUARD = 164;

// Moved to cmi_animcom
/*

int GetAnimalCompanionLevel(object oPC)
{

	int nCompLevel = 0;
	if (GetHasFeat(1835 , oPC))
		nCompLevel += GetLevelByClass(CLASS_TYPE_CLERIC , oPC); //Animal Domain Cleric
	
	int nRanger = GetLevelByClass(CLASS_TYPE_RANGER , oPC); //Ranger
	if (nRanger > 3)
		nCompLevel += (nRanger - 3);

	nCompLevel += GetLevelByClass(CLASS_TYPE_DRUID , oPC); //Druid
	nCompLevel += GetLevelByClass(CLASS_LION_TALISID , oPC); //Lion of Talisid
	
	if (GetHasFeat(FEAT_DEVOTED_TRACKER, oPC))
	{
		int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN , oPC);
		nPaladin = nPaladin - 4;
		if (nPaladin > 0)
			nCompLevel += nPaladin;
	}
	
	if (GetHasFeat(FEAT_TELTHOR_COMPANION, oPC))
	{
		int nSS = GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN , oPC);
		nSS = nSS - 3;
		if (nSS > 0)
			nCompLevel += nSS;
	}	
	
	if (GetHasFeat(FEAT_IMPROVED_NATURAL_BOND, oPC))
	{
		int nHD = GetHitDice(oPC);
		if (nHD > nCompLevel)
		{
			nCompLevel += 6;
			if (nCompLevel > nHD)
				nCompLevel = nHD;
		}	
	}
	else
	if (GetHasFeat(2106, oPC)) //Natural Bond
	{
		int nHD = GetHitDice(oPC);
		if (nHD > nCompLevel)
		{
			nCompLevel += 3;
			if (nCompLevel > nHD)
				nCompLevel = nHD;
		}
	}
	
	if (GetHasFeat(1959 , oPC)) //Epic Animal Companion
		nCompLevel += 3;	
	
	//Testing
	//nCompLevel += 10;
		
	return nCompLevel;

}

int GetAnimCompRange(object oPC)
{
	int nCompLevel = GetAnimalCompanionLevel(oPC);
	int nRange;
	if (nCompLevel > 2)
		nRange = (nCompLevel / 3) + 1;
	else 
		nRange = 1;
	//SendMessageToPC(oPC, IntToString(nRange));
	//SendMessageToPC(oPC, IntToString(nCompLevel));	
	return nRange;
}

string GetElemCompRange(object oPC)
{
	int nCompLevel = GetAnimalCompanionLevel(oPC);

	int nRange = 1;
	if (nCompLevel > 27)
		nRange = 6;
	else
	if (nCompLevel > 21)
		nRange = 5;
	else
	if (nCompLevel > 15)
		nRange = 4;
	else		
	if (nCompLevel > 9)
		nRange = 3;
	else
	if (nCompLevel > 3)
		nRange = 2;				
	
	//SendMessageToPC(oPC, "Range: " + IntToString(nRange));
	//SendMessageToPC(oPC, "Level: " + IntToString(nCompLevel));	
	return IntToString(nRange);
}

void SummonCMIAnimComp(object oPC)
{
	int nTelthor = 0;
	string sBlueprint = GetLocalString(oPC, "cmi_animcomp");
	string sRange;
	int nRange = GetAnimCompRange(oPC);	    
	sRange = IntToString(nRange);	
	
	//SendMessageToPC(oPC, "sBlueprint: " + sBlueprint);
	//SendMessageToPC(oPC, "sRange: " + sRange);	
	
	if (GetHasFeat(FEAT_TELTHOR_COMPANION, oPC, TRUE))
	{
		sBlueprint = "cmi_ancom_telthor" + sRange;
		nTelthor = 1;
	}
	
	if (sBlueprint == "")
	{
		SummonAnimalCompanion();
		object oComp = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
		string sTag = GetTag(oComp);
		//SendMessageToPC(oPC, "Tag: " + sTag);
		//SendMessageToPC(oPC, "sRange: " + sRange);
		if (FindSubString(sTag, "blue") > -1)
		{
			sBlueprint = "c_ancom_blue" + sRange;	
		}
		else
		if (FindSubString(sTag, "bronze") > -1)
		{
			sBlueprint = "c_ancom_bronze" + sRange;	
		}
		else
		if (FindSubString(sTag, "dino") > -1)
		{
			sBlueprint = "c_ancom_dino" + sRange;	
		}
		else
		if (FindSubString(sTag, "elea") > -1)
		{
			sBlueprint = "cmi_ancom_elea" + GetElemCompRange(oPC);	
		}
		else
		if (FindSubString(sTag, "elee") > -1)
		{
			sBlueprint = "cmi_ancom_elee" + GetElemCompRange(oPC);	
		}
		else
		if (FindSubString(sTag, "elef") > -1)
		{
			sBlueprint = "cmi_ancom_elef" + GetElemCompRange(oPC);
		}
		else
		if (FindSubString(sTag, "elew") > -1)
		{
			sBlueprint = "cmi_ancom_elew" + GetElemCompRange(oPC);
		}
		else					
		if (FindSubString(sTag, "badger") > -1)
		{
			sBlueprint = "c_ancom_badger" + sRange;	
		}
		else
		if (FindSubString(sTag, "bear") > -1)
		{
			sBlueprint = "c_ancom_bear" + sRange;	
		}
		else
		if (FindSubString(sTag, "boar") > -1)
		{
			sBlueprint = "c_ancom_boar" + sRange;	
		}
		else
		if (FindSubString(sTag, "spider") > -1)
		{
			sBlueprint = "c_ancom_spider" + sRange;	
		}
		else
		if (FindSubString(sTag, "panther") > -1)
		{
			sBlueprint = "c_ancom_panther" + sRange;	
		}
		else
		if (FindSubString(sTag, "wolf") > -1)
		{
			sBlueprint = "c_ancom_wolf" + sRange;	
		}	
		//SendMessageToPC(oPC, "sBlueprint2: " + sBlueprint);
	}
	
	if (GetHasFeat(2002, oPC, TRUE))
	{
	    int nAlign = GetAlignmentGoodEvil(oPC);		
		if (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL)
			sBlueprint = "c_ancom_bronze" + sRange;
		else
			sBlueprint = "c_ancom_blue" + sRange;
	}
	else
	if (GetHasFeat(FEAT_DINOSAUR_COMPANION, oPC, TRUE))
		sBlueprint = "c_ancom_dino" + sRange;
	
	if (GetTag(OBJECT_SELF) == "co_umoja")
		sBlueprint = "c_ancom_dino" + sRange;
	
	
		
	//SendMessageToPC(oPC, "sBlueprint3: " + sBlueprint);	
		
	SetLocalString(oPC, "cmi_animcomp", sBlueprint);
	SummonAnimalCompanion(oPC, sBlueprint); 				
		
	if (nTelthor)
	{
		SetFirstName( GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC), "Spirit of");
		SetLastName( GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC), "the Land");
	}	
	//object oComp = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
	//string sTag = GetTag(oComp);
	//SendMessageToPC(oPC, "Tag: " + sTag);	
}

*/
void ApplySilverFangEffect(object oTarget)
{

  object oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget);
  if (GetIsObjectValid(oWeapon))
  {
	SetItemBaseMaterialType(oWeapon, GMATERIAL_METAL_ALCHEMICAL_SILVER); 
  } 

  oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
  if (GetIsObjectValid(oWeapon))
  {
	SetItemBaseMaterialType(oWeapon, GMATERIAL_METAL_ALCHEMICAL_SILVER);
  }

  oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
  if (GetIsObjectValid(oWeapon))
  {
	SetItemBaseMaterialType(oWeapon, GMATERIAL_METAL_ALCHEMICAL_SILVER);
  }
  
}