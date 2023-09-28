
global function ClMirageVoyage_Init






global function IsMirageVoyageEnabled
















const string MIRAGE_VOYAGE_MUSIC_CONTROLLER_SCRIPT_NAME = "mirage_voyage_music_target"

















































































const string MIRAGE_VOYAGE_AMBIENT_GENERIC_SCRIPT_NAME = "mirage_tt_music_ambient_generic"

























































void function ClMirageVoyage_Init()
{
	AddCallback_EntitiesDidLoad( InitMirageVoyageMusicEnts )
}




void function InitMirageVoyageMusicEnts()
{
	if ( !IsMirageVoyageEnabled() )
		return

	entity musicController = GetEntByScriptName( MIRAGE_VOYAGE_MUSIC_CONTROLLER_SCRIPT_NAME )
	entity ambientGeneric  = GetEntByScriptName( MIRAGE_VOYAGE_AMBIENT_GENERIC_SCRIPT_NAME )

	ambientGeneric.SetSoundCodeControllerEntity( musicController )
}
































































































































































































































































bool function IsMirageVoyageEnabled()
{
	if ( GetCurrentPlaylistVarBool( "mirage_tt_enabled", true ) )
	{
		array<string> entScriptnamesToCheck






			entScriptnamesToCheck.append( MIRAGE_VOYAGE_AMBIENT_GENERIC_SCRIPT_NAME )


		bool allEntsPresent = true
		foreach ( string scriptName in entScriptnamesToCheck )
		{
			array<entity> entsToCheck = GetEntArrayByScriptName( scriptName )

			if ( entsToCheck.len() == 0 )
			{
				allEntsPresent = false
				break
			}
		}

		if ( allEntsPresent )
			return true

		return false

	}

	return false
}


















































































































































































































































































































































































































































































































































































