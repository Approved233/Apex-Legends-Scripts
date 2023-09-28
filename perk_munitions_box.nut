const string MUNITIONS_BOX_SCRIPT_NAME = "assault_perk_loot_bin"
global const string MUNITIONS_BOX_LOOT_BIN_SKIN_NAME = "MunitionsBox"

const int HOP_UP_DROP_CHANCE = 20
const int MAG_DROP_CHANCE = 65
const int PURPLE_DROP_CHANCE = 20
const int BLUE_DROP_CHANCE = 100

const int HOP_UP_TIER = 6
const int PURPLE_TIER = 3
const int BLUE_TIER = 2
const int WHITE_TIER = 1

global function Perk_MunitionsBox_Init
global function Perk_SwapMunitionsBoxAndSkirmisherPerks





































void function Perk_MunitionsBox_Init()
{
	if ( GetCurrentPlaylistVarBool( "disable_perk_munitions_box", false ) )
		return

	PerkInfo munitionsBox
	munitionsBox.perkId          = ePerkIndex.MUNITIONS_BOX













	Perks_RegisterClassPerk( munitionsBox )
























}
















































bool function Perk_SwapMunitionsBoxAndSkirmisherPerks()
{
	return GetCurrentPlaylistVarBool( "swap_munitions_box_and_skirmisher_perks", false )
}

bool function MunitionsBoxSpawnsSmartLoot()
{
	return GetCurrentPlaylistVarBool( "munitions_box_spawns_smart_loot", true )
}

bool function AllPlayersCanOpenMunitionsBin()
{
	return GetCurrentPlaylistVarBool( "munitions_box_all_players_can_open", true )
}

bool function MunitionsBoxSpawnsSmartOptic()
{
	return GetCurrentPlaylistVarBool( "munitions_box_spawns_smart_optic", true )
}

bool function MunitionsBoxDropsWeaponIfOpeningPlayerIsUnarmed()
{
	return GetCurrentPlaylistVarBool( "munitions_box_drops_weapon_if_opening_player_is_unarmed", true )
}

bool function MunitionsBoxLimitsMagsAndHopUps()
{
	return GetCurrentPlaylistVarBool( "munitions_box_limits_mags_and_hopups", true )
}

bool function MunitionsBoxLimitGoldDrops()
{
	return GetCurrentPlaylistVarBool( "munitions_box_limits_gold_drops", true )
}

bool function MunitionsBox_UseNewLootLogic()
{
	return GetCurrentPlaylistVarBool( "munitions_box_use_new_loot_logic", true )
}

bool function MunitionsBox_BoostOpenerLoot()
{
	return GetCurrentPlaylistVarBool( "munitions_box_boost_opener_loot", false )
}














































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































