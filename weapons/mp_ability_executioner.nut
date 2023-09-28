
global function MpAbilityExectioner_Init
global function PassiveRevenantRework_OnPassiveChanged
global function PassiveExecutioner_EntityShouldBeHighlighted


global function ServerToClient_HighlightEnemy
global function ServerToClient_StopHighlightEnemy


const float EXECUTIONER_WATCH_RANGE = 30 * METERS_TO_INCHES
const int EXECUTIONER_HEALTH_THRESHOLD = 40

const vector EXECUTIONER_WAYPOINT_OFFSET = <0, 0, 96>
const float EXECUTIONER_WAYPOINT_DURATION = 2.75

const float EXECUTIONER_WAYPOINT_AFTER_DAMAGE_WINDOW = 30.0
const float EXECUTIONER_WAYPOINT_DAMAGE_DELAY = 0.3
const float EXECUTIONER_DELTA_DAMAGE_TIME = 30.0

const asset FX_EXECUTIONER_WAYPOINT_TARGET = $"P_rev2_ar_target"

const string EXECUTIONER_MARKED_SOUND = "Revenant_Passive_WaypointAppear"

const asset EXECUTIONER_ICON = $"rui/hud/character_abilities/revenant_rework_marked"
















struct
{






		array< entity > currentHighlightTargets


	
	float highlightRange
	int highlightHealthThreshold
	float markDuration
	float markDamageWindow
	float markDamageDelay
	float markDeltaDamageTime
}file

void function MpAbilityExectioner_Init()
{
	PrecacheParticleSystem( FX_EXECUTIONER_WAYPOINT_TARGET )

	RegisterSignal( "EndExecutionerPassive" )
	RegisterSignal( "StopWatchingExecutionerVictim" )
	AddCallback_OnPassiveChanged( ePassives.PAS_REVENANT_REWORK, PassiveRevenantRework_OnPassiveChanged )

	Remote_RegisterClientFunction( "ServerToClient_HighlightEnemy", "entity" )
	Remote_RegisterClientFunction( "ServerToClient_StopHighlightEnemy", "entity" )

	
	file.highlightRange = GetCurrentPlaylistVarFloat( "assassins_instinct_highlight_range", EXECUTIONER_WATCH_RANGE )
	file.highlightHealthThreshold = GetCurrentPlaylistVarInt( "assassins_instinct_highlight_health_threshold", EXECUTIONER_HEALTH_THRESHOLD )
	file.markDuration = GetCurrentPlaylistVarFloat( "assassins_instinct_mark_duration", EXECUTIONER_WAYPOINT_DURATION )
	file.markDamageWindow = GetCurrentPlaylistVarFloat( "assassins_instinct_mark_damage_window", EXECUTIONER_WAYPOINT_AFTER_DAMAGE_WINDOW )
	file.markDamageDelay = GetCurrentPlaylistVarFloat( "assassins_instinct_mark_damage_delay", EXECUTIONER_WAYPOINT_DAMAGE_DELAY )
	file.markDeltaDamageTime = GetCurrentPlaylistVarFloat( "assassins_instinct_mark_delta_damage_time", EXECUTIONER_DELTA_DAMAGE_TIME )







}

void function PassiveRevenantRework_OnPassiveChanged( entity player, int passive, bool didHave, bool nowHas )
{
	if ( !IsAlive( player ) )
		return

	if ( nowHas )
	{











	}

	else if ( didHave )
	{
		player.Signal( "EndExecutionerPassive" )






	}
}




















































































































































































































































































































































bool function DoesPlayerPassExecutionerChecks( entity player, entity target )
{
	if ( !IsAlive( target ) )
		return false

	if( target == player )
		return false

	if ( target.IsPhaseShifted() )
		return false

	if( Bleedout_IsBleedingOut( target ) )
		return false

	if ( DoesPlayerPassExecutionHealthCheck( target ) )
		return true

	return false
}

bool function DoesPlayerPassExecutionHealthCheck( entity player )
{
	int shieldValue = GetEntityShieldValue( player )
	int healthValue = GetEntityHealthValue( player )

	int totalHealth = shieldValue + healthValue

	if ( ( totalHealth > 0 ) && ( totalHealth <= file.highlightHealthThreshold ) )
		return true

	return false
}

int function GetEntityHealthValue( entity ent )
{
	if ( !IsValid( ent ) )
		return 0

	int victimHealth = 100

	if ( ent.IsPlayerDecoy() )
	{
		entity decoyOwner = ent.GetOwner()

		if ( IsValid( decoyOwner ) )
			victimHealth = decoyOwner.GetHealth()
	}
	else
		victimHealth = ent.GetHealth()

	return victimHealth
}

int function GetEntityShieldValue( entity ent )
{
	if ( !IsValid( ent ) )
		return 0

	int victimShields = 0

	if ( ent.IsPlayerDecoy() )
	{
		entity decoyOwner = ent.GetOwner()

		if ( IsValid( decoyOwner ) )
			victimShields = decoyOwner.GetShieldHealth()
	}
	else
		victimShields = ent.GetShieldHealth()

	return victimShields
}


void function ServerToClient_HighlightEnemy( entity target )
{
	entity player = GetLocalViewPlayer()

	if( !IsValid( player ) || !IsValid( target ) )
		return

	if( file.currentHighlightTargets.contains( target ) )
		return

	thread PassiveExecutioner_HighlightThink( player, target )

	file.currentHighlightTargets.append( target )
}

void function ServerToClient_StopHighlightEnemy( entity target )
{
	if( !IsValid( target ) )
		return

	target.Signal( "StopWatchingExecutionerVictim" )
}

void function PassiveExecutioner_HighlightThink( entity player, entity targetPlayer )
{
	if ( !IsValid( player ) || !IsValid( targetPlayer ) )
		return

	EndSignal( targetPlayer, "OnDeath", "OnDestroy", "StopWatchingExecutionerVictim" )
	player.EndSignal( "EndExecutionerPassive" )

	ManageHighlightEntity( targetPlayer )

	OnThreadEnd(
		function() : ( targetPlayer )
		{
			if ( IsValid( targetPlayer ) )
			{
				ManageHighlightEntity( targetPlayer )
				file.currentHighlightTargets.fastremovebyvalue( targetPlayer )
			}
		}
	)

	while( StatusEffect_HasSeverity( targetPlayer, eStatusEffect.assassins_instinct ) )
	{
		WaitFrame()
	}
}


bool function PassiveExecutioner_EntityShouldBeHighlighted( entity viewPlayer, entity target )
{

		if ( StatusEffect_HasSeverity( target, eStatusEffect.assassins_instinct ) )
		{
			float distanceSqr = DistanceSqr( viewPlayer.EyePosition(), target.GetWorldSpaceCenter() )
			if( distanceSqr > pow( file.highlightRange, 2 ) )
				return false

			return true
		}


	return false
}
                            