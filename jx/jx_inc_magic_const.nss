// Spell constants
const int JX_SPELL_DETECTMAGIC      = 930;
const int JX_SPELL_ANALYZEDWEOMER   = 17301;

// Item property constants
const int JX_IP_CONST_CASTSPELL_SPELLTURNING    = 1300;
const int JX_IP_CONST_CASTSPELL_DETECTMAGIC         = 1301;
const int JX_IP_CONST_CASTSPELL_ANALYZEDWEOMER  = 1302;

// Area of effect constants
const int AOE_PER_CUSTOM01_AOE = 300;   // 1 meter
const int AOE_PER_CUSTOM02_AOE = 301;   // 2 meters
const int AOE_PER_CUSTOM03_AOE = 302;   // 3 meters
const int AOE_PER_CUSTOM04_AOE = 303;   // 4 meters
const int AOE_PER_CUSTOM05_AOE = 304;   // 5 meters
const int AOE_PER_CUSTOM06_AOE = 305;   // 6 meters
const int AOE_PER_CUSTOM07_AOE = 306;   // 7 meters
const int AOE_PER_CUSTOM08_AOE = 307;   // 8 meters
const int AOE_PER_CUSTOM09_AOE = 308;   // 9 meters
const int AOE_PER_CUSTOM10_AOE = 309;   // 10 meters
const int AOE_PER_CUSTOM11_AOE = 310;   // 11 meters
const int AOE_PER_CUSTOM12_AOE = 311;   // 12 meters
const int AOE_PER_CUSTOM13_AOE = 312;   // 13 meters
const int AOE_PER_CUSTOM14_AOE = 313;   // 14 meters
const int AOE_PER_CUSTOM15_AOE = 314;   // 15 meters
const int AOE_PER_CUSTOM16_AOE = 315;   // 16 meters
const int AOE_PER_CUSTOM17_AOE = 316;   // 17 meters
const int AOE_PER_CUSTOM18_AOE = 317;   // 18 meters
const int AOE_PER_CUSTOM19_AOE = 318;   // 19 meters
const int AOE_PER_CUSTOM20_AOE = 319;   // 20 meters

// Replacement mode constants for JXSetMetaMagicFeat()
const int JX_METAMAGIC_REPLACE_NO = 0;
const int JX_METAMAGIC_REPLACE_YES = 1;
const int JX_METAMAGIC_REPLACE_BEST = 2;

// Spell range type constants
const int JX_SPELLRANGE_INVALID  = 0;
const int JX_SPELLRANGE_SHORT    = 1;
const int JX_SPELLRANGE_MEDIUM   = 2;
const int JX_SPELLRANGE_LONG     = 3;
const int JX_SPELLRANGE_PERSONAL = 4;
const int JX_SPELLRANGE_TOUCH    = 5;

// Spell descriptor constants
const int JX_SPELLDESCRIPTOR_ANY               = 0;
const int JX_SPELLDESCRIPTOR_ACID              = 1;
const int JX_SPELLDESCRIPTOR_AIR               = 2;
const int JX_SPELLDESCRIPTOR_CHAOTIC           = 3;
const int JX_SPELLDESCRIPTOR_COLD              = 4;
const int JX_SPELLDESCRIPTOR_DARKNESS          = 5;
const int JX_SPELLDESCRIPTOR_DEATH             = 6;
const int JX_SPELLDESCRIPTOR_EARTH             = 7;
const int JX_SPELLDESCRIPTOR_ELECTRICITY       = 8;
const int JX_SPELLDESCRIPTOR_EVIL              = 9;
const int JX_SPELLDESCRIPTOR_FEAR              = 10;
const int JX_SPELLDESCRIPTOR_FIRE              = 11;
const int JX_SPELLDESCRIPTOR_FORCE             = 12;
const int JX_SPELLDESCRIPTOR_GOOD              = 13;
const int JX_SPELLDESCRIPTOR_LANGUAGEDEPENDANT = 14;
const int JX_SPELLDESCRIPTOR_LAWFUL            = 15;
const int JX_SPELLDESCRIPTOR_LIGHT             = 16;
const int JX_SPELLDESCRIPTOR_MINDAFFECTING     = 17;
const int JX_SPELLDESCRIPTOR_SONIC             = 18;
const int JX_SPELLDESCRIPTOR_WATER             = 19;

// Spell subschool constants
const int JX_SPELLSUBSCHOOL_NONE                        = 0;
const int JX_SPELLSUBSCHOOL_CONJURATION_CALLING             = 1;
const int JX_SPELLSUBSCHOOL_CONJURATION_CREATION        = 2;
const int JX_SPELLSUBSCHOOL_CONJURATION_HEALING             = 3;
const int JX_SPELLSUBSCHOOL_CONJURATION_SUMMONING       = 4;
const int JX_SPELLSUBSCHOOL_CONJURATION_TELEPORTATION   = 5;
const int JX_SPELLSUBSCHOOL_DIVINATION_SCRYING          = 6;
const int JX_SPELLSUBSCHOOL_ENCHANTMENT_CHARM           = 7;
const int JX_SPELLSUBSCHOOL_ENCHANTMENT_COMPULSION      = 8;
const int JX_SPELLSUBSCHOOL_ILLUSION_FIGMENT            = 9;
const int JX_SPELLSUBSCHOOL_ILLUSION_GLAMER                 = 10;
const int JX_SPELLSUBSCHOOL_ILLUSION_PATTERN            = 11;
const int JX_SPELLSUBSCHOOL_ILLUSION_PHANTASM           = 12;
const int JX_SPELLSUBSCHOOL_ILLUSION_SHADOW                 = 13;

// Constants used by items to modify the spells they cast
const string JX_ITEM_SPELL_MM_PREFIX = "JX_ITEM_SPELL_MM_";
const string JX_ITEM_SPELL_CL_PREFIX = "JX_ITEM_SPELL_CL_";
const string JX_ITEM_SPELL_DC_PREFIX = "JX_ITEM_SPELL_DC_";

// Constants to override the item properties
const string JX_ITEM_CASTER_LEVEL       = "JX_ITEM_CASTER_LEVEL";
const string JX_ITEM_SPELL_SCHOOL       = "JX_ITEM_SPELL_SCHOOL";
const string JX_ITEM_MAGICAL_PROPERTIES     = "JX_ITEM_MAGICAL_PROPS";
const string JX_ITEM_SAVE_FORTITUDE         = "JX_ITEM_SAVE_FORTITUDE";
const string JX_ITEM_SAVE_REFLEX        = "JX_ITEM_SAVE_REFLEX";
const string JX_ITEM_SAVE_WILL          = "JX_ITEM_SAVE_WILL";
const string JX_ITEM_IDENTIFIED             = "JX_ITEM_IDENTIFIED";
const string JX_ITEM_MAGICSTAFF             = "JX_ITEM_MAGICSTAFF";

// Store/remove item property constants
const int JX_ITEM_PROPERTY_ALL = -1;
const int JX_ITEM_PROPERTY_MAGIC = -2;
const int JX_ITEM_PROPERTY_NOMAGIC = -3;

// Magical aura strength constants
const int JX_AURASTRENGTH_NONE          = 0;
const int JX_AURASTRENGTH_FAINT             = 1;
const int JX_AURASTRENGTH_MODERATE      = 2;
const int JX_AURASTRENGTH_STRONG        = 3;
const int JX_AURASTRENGTH_OVERWHELMING  = 4;

// Spell type constants
const int JX_SPELLTYPE_NONE         = 0;
const int JX_SPELLTYPE_ARCANE   = 1;
const int JX_SPELLTYPE_DIVINE   = 2;
const int JX_SPELLTYPE_BOTH         = 3;

// Script fork constants
const string JX_SPFMWK_FORKSCRIPT = "jx_spfmwk_fork";
//        jx_inc_magic_info
const int JX_FORK_SPELLRANGEDTOUCHATTACK =      1;
const int JX_FORK_SPELLMAGICAL =                2;
const int JX_FORK_SPELLSUPERNATURAL =           3;
const int JX_FORK_SPELLEXTRAORDINARY =          4;
const int JX_FORK_SPELLMISCELLANEOUS =          5;
const int JX_FORK_SPELLDESCRIPTOR =                 6;
const int JX_FORK_SPELLSUBSCHOOL =              19;
const int JX_FORK_SPELLLEVEL =                  20;
//        jx_inc_magic_item
const int JX_FORK_DISABLEITEMPROP =                 7;
const int JX_FORK_ENABLEITEMPROP =              8;
const int JX_FORK_ITEMCASTERLEVEL =                 9;
const int JX_FORK_ITEMSPELLSCHOOL =                 10;
const int JX_FORK_ITEMMAGICAL =                     11;
//        jx_inc_magic_class
const int JX_FORK_MAINCASTERCLASS =                 12;
const int JX_FORK_CREATUREARCANECASTERLEVEL =   13;
const int JX_FORK_CREATUREDIVINECASTERLEVEL =   14;
const int JX_FORK_CREATURECASTERLEVEL =             15;
const int JX_FORK_CREATURECASTERLEVELSPELL =    16;
const int JX_FORK_CREATURESPELLSAVEDC =             17;
//        jx_inc_magicstaff
const int JX_FORK_MAGIC_STAFF =                     18;
//        jx_inc_magic_events
const int JX_FORK_EVENTSPELLENQUEUED =          21;
const int JX_FORK_EVENTSPELLSTARTED =           22;
const int JX_FORK_EVENTSPELLCONJURING =             23;
const int JX_FORK_EVENTSPELLCONJURED =          24;
const int JX_FORK_EVENTSPELLCAST =              25;
const int JX_FORK_EVENTSPELLFINISHED =          26;

const string MODULE_VAR_JX_USER_POSTCAST = "JX_POST_SPELLSCRIPT";

const string MODULE_VAR_JX_USER_ON_APPLY_SPELL_EFFECT = "JX_ON_APPLY_SPELL_EFFECT";

//Event handler backup arrays




const string VAR_JX_ON_APPLY_SPELL_EFFECT_RESULT = "JX_ON_APPLY_SPELL_EFFECT_RESULT";


// separators for saving effects
const string JX_GEN_SEP = ";";
const string JX_EFFECT_SEP = "|";
const string JX_ARG_SEP = ":";
const string JX_FIELD_SEP = "&";
const string JX_INFO_SEP = "_";
const string JX_MAP_SEP = ";";

//=============================== EFFECT OVERRIDES ======================================

// TYPE IDENTITIES

const int JX_INT_ADD_ID = 0;
const int JX_INT_MULTIPLY_ID = 1;
const int JX_INT_OR_ID = 0;

const float JX_FLOAT_ADD_ID = 0.0f;
const float JX_FLOAT_MULTIPLY_ID = 1.0f;

const string JX_STRING_CONCAT_ID = "";

// TYPES
const int JX_TYPE_NONE = -1;
const int JX_TYPE_INT = 1;
const int JX_TYPE_FLOAT = 2;
const int JX_TYPE_STRING = 3;
const int JX_TYPE_OBJECT = 4;
const int JX_TYPE_LOCATION = 5;
const int JX_TYPE_VECTOR = 6;

const string JX_TYPE_NAME_INT = "INT";
const string JX_TYPE_NAME_FLOAT = "FLOAT";
const string JX_TYPE_NAME_STRING ="STRING";
const string JX_TYPE_NAME_OBJECT = "OBJECT";
const string JX_TYPE_NAME_LOCATION = "LOCATION";
const string JX_TYPE_NAME_VECTOR = "VECTOR";


// JXSetEffectModifierInt(EFFECT_TYPE,
//                        PROPERTY_TO_MODIFY,
//                        TYPE_OF_MODIFICATION,
//                        VALUE,
//                        REQUIRED_PREVIOUS_VALUE)
//
// idk how to implement these atm; they require functions as args
// - const int JX_EFFECT_DISPEL_ALL = 200;
// - const int JX_EFFECT_DISPEL_BEST = 201;
// - const int JX_EFFECT_ON_DISPEL = 202;

// const string JX_OVERRIDE_EFFECT_BONUS_LINK = "JX_OVR_BONUS_LINK_ARR";
const string JX_EFFECT_BONUS_LINK_ARRAY = "JX_OVR_BONUS_LINK_ARR";
const string JX_EFFECT_MOD_INFO_ARRAY = "JX_EFFECT_MOD_INFO";

// helper local vars
const string JX_EFFECT_NUM_OF_LINKS = "JX_EFFECT_LINK_NUMBER";
const int JX_EFFECT_MAX_LINK_COUNT = 10;
const int JX_EFFECT_MAX_LINK_SIZE = 10;




// effect override types
// param override types take as their parameters values of types corresponding to effect
// constructor arguments
// eg. for EffectDamage()
//  int, int int int
const int JX_EFFECT_MOD_TYPE_PARAM_1 = 1;
const int JX_EFFECT_MOD_TYPE_PARAM_2 = 2;
const int JX_EFFECT_MOD_TYPE_PARAM_3 = 3;
const int JX_EFFECT_MOD_TYPE_PARAM_4 = 4;
const int JX_EFFECT_MOD_TYPE_PARAM_5 = 5;
const int JX_EFFECT_MOD_TYPE_PARAM_6 = 6;
const int JX_EFFECT_MOD_TYPE_PARAM_7 = 7;
const int JX_EFFECT_MOD_TYPE_PARAM_8 = 8;
const int JX_EFFECT_MOD_TYPE_PARAM_9 = 9;


const int JX_EFFECT_MOD_TYPE_EFFECT_PROP = 10;

const int JX_EFFECT_MOD_TYPE_DISABLE_EFFECT = 11;
const int JX_EFFECT_MOD_TYPE_SUBSTITUTE_EFFECT = 12;
const int JX_EFFECT_MOD_TYPE_LINK_EFFECT = 13;

const int JX_EFFECT_MOD_TYPE_MAX_ID = 14;
// effect override modifier types
const int JX_EFFECT_MOD_OP_PARAM_INCREASE_BY = 1;
const int JX_EFFECT_MOD_OP_PARAM_DECREASE_BY = 2;
const int JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY = 3;
const int JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY = 4;
const int JX_EFFECT_MOD_OP_PARAM_LOGIC_OR = 5;
const int JX_EFFECT_MOD_OP_PARAM_LOGIC_AND = 6;
const int JX_EFFECT_MOD_OP_PARAM_INCREASE_BY_RAND = 7;
const int JX_EFFECT_MOD_OP_PARAM_DECREASE_BY_RAND = 8;
const int JX_EFFECT_MOD_OP_PARAM_MULTIPLY_BY_RAND = 9;
const int JX_EFFECT_MOD_OP_PARAM_DIVIDE_BY_RAND = 10;
const int JX_EFFECT_MOD_OP_PARAM_MAX = 11;
const int JX_EFFECT_MOD_OP_PARAM_MIN = 12;
const int JX_EFFECT_MOD_OP_PARAM_OVERRIDE = 13;
const int JX_EFFECT_MOD_OP_PARAM_MAP = 14;

const int JX_EFFECT_MOD_OP_PROP_SUBTYPE = 15;
const int JX_EFFECT_MOD_OP_PROP_VS_RACIAL = 16;
const int JX_EFFECT_MOD_OP_PROP_VS_ALIGN = 17;

const int JX_EFFECT_MOD_OP_MAX_ID = 18;

const string JX_EFFECT_MOD_IGNORE = "JX_EM_IGNORE";
//###########################################
// params at effect creation
//############################################
const string JX_EFFECT_MOD_OP_PARAMS = "JX_EM_PARAM";
const string JX_EFFECT_MOD_OP_PARAM_STATES = "JX_EF_MPS";
const string JX_EFFECT_MOD_OP_PARAM_TYPES = "JX_EMP_T";

//###################################
// currently processed mod params
//######################################
const string JX_EFFECT_CURR_MOD_OP_PARAMS = "JX_EF_CMP";
const string JX_EFFECT_CURR_MOD_OP_PARAM_STATES = "JX_EF_CMPS";
const string JX_EFFECT_CURR_MOD_OP_PARAM_TYPES = "JX_CEMP_T";
// stores the id of currently processed effect in JXEffect* wrappers
const string JX_EFFECT_CURRENT = "JX_EF_CURR";

// JX_P_MODS_1_1 = 33242452, JX_P_MODS_1_1_32;
// JX_P_MODS_1_2 = 33242452, JX_P_MODS_1_2_32
// JX_P_MODS_1_3 = 33242452, JX_P_MODS_1_3_32
// JX_P_MODS_1_4 = 33242452, JX_P_MODS_1_4_32
// JX_P_MODS_1_5 = 33242452, JX_P_MODS_1_5_32
// JX_P_MODS_1_6 = 33242452, JX_P_MODS_1_6_32
const int JX_EFFECT_MAX_MOD_PARAMS = 8;

const int JX_EFFECT_HEAL = 1;
const int JX_EFFECT_DAMAGE = 2;
const int JX_EFFECT_DAMAGE_OVER_TIME = 3;
const int JX_EFFECT_ABILITY_INCREASE = 4;
const int JX_EFFECT_DAMAGE_RESISTANCE = 5;
const int JX_EFFECT_RESURRECTION = 6;
const int JX_EFFECT_SUMMON_CREATURE = 7;
const int JX_EFFECT_AC_INCREASE = 8;
const int JX_EFFECT_SAVING_THROW_INCREASE = 9;
const int JX_EFFECT_ATTACK_INCREASE = 10;
const int JX_EFFECT_DMAAGE_REDUCTION = 11;
const int JX_EFFECT_DAMAGE_INCREASE = 12;
const int JX_EFFECT_ENTANGLE = 13;
const int JX_EFFECT_DEATH = 14;
const int JX_EFFECT_KNOCKDOWN = 15;
const int JX_EFFECT_CURSE = 16;
const int JX_EFFECT_PARALYZE = 17;
const int JX_EFFECT_SPELL_IMMUNITY = 18;
const int JX_EFFECT_DEAF = 19;
const int JX_EFFECT_SLEEP = 20;
const int JX_EFFECT_CHARMED = 21;
const int JX_EFFECT_CONFUSED = 22;
const int JX_EFFECT_FRIGHTENED = 23;
const int JX_EFFECT_DOMINATED = 24;
const int JX_EFFECT_DAZED = 25;
const int JX_EFFECT_STUNNED = 26;
const int JX_EFFECT_REGENERATE = 27;
const int JX_EFFECT_MOVEMENT_SPEED_INCREASE = 28;
const int JX_EFFECT_SPELL_RESISTANCE_INCREASE = 29;
const int JX_EFFECT_POISON = 30;
const int JX_EFFECT_DISEASE = 31;
const int JX_EFFECT_SILENCE = 32;
const int JX_EFFECT_HASTE = 33;
const int JX_EFFECT_SLOW = 34;
const int JX_EFFECT_IMMUNITY = 35;
const int JX_EFFECT_DAMAGE_IMMUNITY_INCREASE = 36;
const int JX_EFFECT_TEMPORARY_HITPOINTS = 37;
const int JX_EFFECT_SKILL_INCREASE = 38;
const int JX_EFFECT_TURNED = 39;
const int JX_EFFECT_HITPOINT_CHANGE_WHEN_DYING = 40;
const int JX_EFFECT_ABILITY_DECREASE = 41;
const int JX_EFFECT_ATTACK_DECREASE = 42;
const int JX_EFFECT_DAMAGE_DECREASE = 43;
const int JX_EFFECT_DAMAGE_IMMUNITY_DECREASE = 44;
const int JX_EFFECT_AC_DECREASE = 45;
const int JX_EFFECT_MOVEMENT_SPEED_DECREASE = 46;
const int JX_EFFECT_SAVING_THROW_DECREASE = 47;
const int JX_EFFECT_SKILL_DECREASE = 48;
const int JX_EFFECT_SPELL_RESISTANCE_DECCREASE = 49;
const int JX_EFFECT_INVISIBILITY = 50;
const int JX_EFFECT_CONCEALMENT = 51;
const int JX_EFFECT_DARKNESS = 52;
const int JX_EFFECT_ULTRAVISION = 53;
const int JX_EFFECT_NEGATIVE_LEVEL = 54;
const int JX_EFFECT_POLYMORPH = 55;
const int JX_EFFECT_SANCTUARY = 56;
const int JX_EFFECT_TRUE_SEEING = 57;
const int JX_EFFECT_SEE_INVISIBLE = 58;
const int JX_EFFECT_TIME_STOP = 59;
const int JX_EFFECT_BLINDESS = 60;
const int JX_EFFECT_SPELL_LEVEL_ABSORPTION = 61;
const int JX_EFFECT_MISS_CHANCE = 62;
const int JX_EFFECT_MODIFY_ATTACKS = 63;
const int JX_EFFECT_DAMAGE_SHIELD = 64;
const int JX_EFFECT_SWARM = 65;
const int JX_EFFECT_TURN_RESISTANCE_DECREASE = 66;
const int JX_EFFECT_TURN_RESISTANCE_INCREASE = 67;
const int JX_EFFECT_PETRIFY = 68;
const int JX_EFFECT_SPELL_FAILURE = 69;
const int JX_EFFECT_ETHEREAL = 70;
const int JX_EFFECT_DETECT_UNDEAD = 71;
const int JX_EFFECT_LOW_LIGHT_VISION = 72;
const int JX_EFFECT_SET_SCALE = 73;
const int JX_EFFECT_SHARE_DAMAGE = 74;
const int JX_EFFECT_ASSAY_RESISTANCE = 75;
const int JX_EFFECT_SEE_TRUE_HPS = 76;
const int JX_EFFECT_ABSORB_DAMAGE = 77;
const int JX_EFFECT_HIDEOUS_BLOW = 78;
const int JX_EFFECT_MESMERIZE = 79;
const int JX_EFFECT_DARK_VISION = 80;
const int JX_EFFECT_ARMOR_CHECK_PENALTY_INCREASE = 81;
const int JX_EFFECT_DESINTEGRATE = 82;
const int JX_EFFECT_HEAL_ON_ZERO_HP = 83;
const int JX_EFFECT_BREAK_ENCHANTMENT = 84;
const int JX_EFFECT_BONUS_HITPOINTS = 85;
const int JX_EFFECT_BARD_SONG_SINGING = 86;
const int JX_EFFECT_JARRING = 87;
const int JX_EFFECT_BAB_MINIMUM = 88;
const int JX_EFFECT_MAX_DAMAGE = 89;
const int JX_EFFECT_ARCANE_SPELL_FAILURE = 90;
const int JX_EFFECT_WILD_SHAPE = 91;
const int JX_EFFECT_RESCUE = 92;
const int JX_EFFECT_DETECT_SPIRITS = 93;
const int JX_EFFECT_DAMAGE_REDUCTION_NEGATED = 94;
const int JX_EFFECT_CONCEALMENT_NEGATED = 95;
const int JX_EFFECT_INSANE = 96;
const int JX_EFFECT_SUMMON_COPY = 97;
// simulated effects
const int JX_EFFECT_SHAKEN = 98;


const int JX_EFFECT_MAX_ID = 99;
