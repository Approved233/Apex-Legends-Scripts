global function Perk_CarePackageInsight_Init

const string HIDDEN_CARE_PACKAGE_ENT_NAME = "care_package_hidden"
const string REVEALED_CARE_PACKAGE_ENT_NAME = "care_package_revealed"

const float CAREPACKAGE_WAYPOINT_UP_OFFSET = 90
const float CAREPACKAGE_HINT_NOTIFICATION_DIST = 20000
const float FORWARD_CAST_RAY_LENGTH = 40000
const float LOOKAT_HINT_COOLDOWN = 120

#if DEV
const bool CARE_PACKAGE_INSIGHT_PERF_TESTING = false
#endif






































global function S16_PathfinderSkirmisherPassiveActive

struct
{

















} file

void function Perk_CarePackageInsight_Init()
{
	if ( GetCurrentPlaylistVarBool( "disable_perk_care_package_insight", false ) )
		return

	PerkInfo carePackageInsight
	carePackageInsight.perkId          = ePerkIndex.CARE_PACKAGE_INSIGHT



















	Perks_RegisterClassPerk( carePackageInsight )
































}









































float function Perk_CarePackageInsight_LookatRevealTime()
{
	return GetCurrentPlaylistVarFloat( "care_package_insight_reveal_time", 1.0 )
}

float function Perk_CarePackageInsight_LookAtWideRevealDegrees()
{
	return GetCurrentPlaylistVarFloat( "care_package_insight_wide_reveal_degrees", 30.0 )
}

float function Perk_CarePackageInsight_LookAtDirectRevealDegrees()
{
	return GetCurrentPlaylistVarFloat( "care_package_insight_direct_reveal_degrees", 3.0 )
}

float function Perk_CarePackageInsight_IgnoreLosRevealDistance()
{
	return GetCurrentPlaylistVarFloat( "care_package_insight_ignore_los_distance", 6000.0 )
}

bool function S16_PathfinderSkirmisherPassiveActive()
{
	return GetCurrentPlaylistVarBool( "s16_pathfinder_skirmisher_passive_active", true )
}

































































































































































































































































































































































































































































































































































































































































































































































































































































































































































