// shaz_inc_love
/*
	functions to assist the many "love" scripts
	
*/
// Shazbotian: 060708

int CanISpeakIntelligently()
{
	if(GetIsPlayableRacialType(OBJECT_SELF) || (GetRacialType(OBJECT_SELF) == RACIAL_TYPE_FEY) || 
	(GetRacialType(OBJECT_SELF) == RACIAL_TYPE_DRAGON) || (GetRacialType(OBJECT_SELF) == RACIAL_TYPE_OUTSIDER)) {
		return TRUE;
	} else {
		return FALSE;
	}
}

int CanISpeakAtAll()
{
	int iCanSpeak = CanISpeakIntelligently();
	
	if(iCanSpeak == FALSE) {
		switch(GetRacialType(OBJECT_SELF)) {
			case RACIAL_TYPE_GIANT:
			case RACIAL_TYPE_HUMANOID_GOBLINOID:
			case RACIAL_TYPE_HUMANOID_MONSTROUS:
			case RACIAL_TYPE_HUMANOID_ORC:
			case RACIAL_TYPE_HUMANOID_REPTILIAN:
				iCanSpeak = TRUE;
				break;
			default:
				iCanSpeak = FALSE;
				break;
		}
	}
	
	return iCanSpeak;
}