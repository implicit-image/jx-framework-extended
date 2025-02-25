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



// effect info arrays
const string JX_EFFECT_ARRAY = "JX_EFFECT_ARRAY";
// const string JX_EFFECT_PROP_ARRAY
// const string JX_EFFECT_MOD_ARRAY



// effect parameter modifiers
const int JX_EFFECT_MOD_PARAM_INCREASE_BY = 1;
const int JX_EFFECT_MOD_PARAM_DECREASE_BY = 2;
const int JX_EFFECT_MOD_PARAM_MULTIPLY_BY = 4;
const int JX_EFFECT_MOD_PARAM_DIVIDE_BY = 8;
const int JX_EFFECT_MOD_PARAM_LOGIC_OR = 16;
const int JX_EFFECT_MOD_PARAM_LOGIC_AND = 32;
const int JX_EFFECT_MOD_PARAM_INCREASE_BY_RAND = 64;
const int JX_EFFECT_MOD_PARAM_DECREASE_BY_RAND = 128;
const int JX_EFFECT_MOD_PARAM_MULTIPLY_BY_RAND = 256;
const int JX_EFFECT_MOD_PARAM_DIVIDE_BY_RAND = 512;
const int JX_EFFECT_MOD_PARAM_MAX_CAP = 8192;
const int JX_EFFECT_MOD_PARAM_MIN_CAP = 16384;
const int JX_EFFECT_MOD_PARAM_OVERRIDE = 32768;
const int JX_EFFECT_MOD_PARAM_PREFIX = 65536;
const int JX_EFFECT_MOD_PARAM_POSTFIX = 131072;

// other effect modifiers
const int JX_EFFECT_MOD_SUBTYPE = 262144;
const int JX_EFFECT_MOD_VS_RACIAL = 524288;
const int JX_EFFECT_MOD_VS_ALIGN = 1048576;
const int JX_EFFECT_MOD_ENABLED = 2097152;

// EffectHeal
const int JX_EFFECT_HEAL = 1;
// Effect Damage
const int JX_EFFECT_DAMAGE = 2;
// Effect Damage Over Time
const int JX_EFFECT_DAMAGE_OVER_TIME = 3;
// Effect Ability Increase
const int JX_EFFECT_ABILITY_INCREASE = 4;

const int JX_EFFECT_MAX_ID = 40;
