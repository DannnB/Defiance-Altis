#include "Common\var_defiance.sqf";
#include "Common\fnc_defiance.sqf";
#include "client\fnc_defiance_client.sqf";
#include "briefing.sqf";

//Task Force Radio Check
if (isClass (configFile >> "CfgPatches" >> "task_force_radio_items")) then {
	[] execVM "scripts\zlt_gen_freqs.sqf";
};

//tpw ambient life
switch (CIV_POP) do
{
    case 0:
    {
    	[5,150,15,2,4,MAX_CIV_DEATH,CIV_DEATH_PEN,30,15,1] execvm "scripts\tpw_civs.sqf";
    };

    case 2:
    {
    	[5,150,15,2,4,MAX_CIV_DEATH,CIV_DEATH_PEN,30,15,1] execvm "scripts\tpw_civs.sqf";
		[5,1000,15,2,1] execvm "scripts\tpw_cars.sqf";
		[5,1000,15,2] execvm "scripts\tpw_boats.sqf";
		[10,300,150,20,10] execvm "scripts\tpw_park.sqf";
		[15] execvm "scripts\tpw_houselights.sqf";
    };

    default
    {
     	[5,150,15,2,4,MAX_CIV_DEATH,CIV_DEATH_PEN,30,15,1] execvm "scripts\tpw_civs.sqf";
		[5,1000,15,2,1] execvm "scripts\tpw_cars.sqf";
    };
};

//waitUntil { !(isNull player)};

//for JIP Players make sure MHQ position is up to date for spawn
//if (!isNil "b_mhq" && playerSide == west) then {
//	if (alive b_mhq) then { "respawn_west1" setMarkerPosLocal (getPos b_mhq); };
//};

waitUntil { !(isNull player) && alive player};

//Helo Lift Scripts
_liftGroundBlacklist = [];
_liftAirBlacklist = ["B_Heli_Attack_01_F","B_Heli_Light_01_armed_F","B_Heli_Light_01_F"];

switch (HELO_LIFT) do
{
    case 1: //MRAP/SEA
    {
    	_liftGroundBlacklist = ["Tank","Truck_F","b_mhq"];
    };
    case 2: //All no MHQ
    {
    	_liftGroundBlacklist = ["b_mhq"];
    };
    case 3: // ALL
    {
    	_liftGroundBlacklist = [];
    };
    case 4: // MHQ Only
    {
    	_liftGroundBlacklist = ["Car","Ship","B_APC_Tracked_01_AA_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_MBT_01_mlrs_F","B_APC_Tracked_01_rcws_F","B_APC_Wheeled_01_cannon_F","B_MBT_01_TUSK_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_APC_Wheeled_03_cannon_F"];
    };

    default
    {
     	_liftGroundBlacklist = nil;
    };
};

if (HELO_LIFT > 0) then {[_liftGroundBlacklist,_liftAirBlacklist] execVM "scripts\lift_init.sqf"};

//cache the player's side
DEF_PLAYER_SIDE = playerSide;

//GROUP MANAGEMENT
[player] execVM "scripts\groupsMenu\initGroups.sqf";

///Dynamic Weather Client
if (DYN_WEATHER) then {[date,START_WEATHER,WEATHER_CHANGE_SPEED] execVM "scripts\real_weather.sqf";};

indforWin = false;
bluforWin = false;

[] spawn {
	while {true} do
	{
	    sleep 5;
	    // DO NOT REMOVE OR EDIT THE LINE BELOW. IF WE SPOT A SERVER NOT SHOWING THIS MESSAGE WE'LL REVOKE ITS LICENSE TO HOST THE MISSION
		systemChat "DEFIANCE: This mission is still in development. Please visit our website to give feedback and suggestions - http://playdefiance.com";
		sleep 5;
		// YOU CAN CUSTOMIZE THE LINE BELOW TO INCLUDE YOUR OWN TS IF YOU HAVE ONE OR FEEL FREE TO USE OURS!
		systemChat "DEFIANCE: Join our Teamspeak - ts.playdefiance.com";
		sleep 1000;
	};
};

// PEH

//Local for Player

if (!isServer) then {
	"zeusBounty" addPublicVariableEventHandler
	{
		_zeusBounty = _this select 1;
		if (_zeusBounty > 0) then
		{
			[west, "hq"] sideChat format["Hades' bounty has increased to %1 tickets",_zeusBounty];
			[resistance, "hq"] sideChat format["The enemy have increased Hades' bounty to %1 tickets",_zeusBounty];
		};
	};
};

//TODO - Rewrite
//if (!isServer) then {
//	"b_zeusUpkeep" addPublicVariableEventHandler
//	{
//		_upkeep = _this select 1;
//		[west, "hq"] sideChat format["NATO Upkeep due to Radiotowers has updated to a %1%2 tax on resource income.",100-((b_zeusUpkeep/BLUFOR_ZEUS_UPKEEP_BASE)*100),"%"];
//	};
//};

if (side player == resistance) then {
	"civIntelMarkers" addPublicVariableEventHandler
	{
		{
			deleteMarkerLocal _x
		} forEach civIntelMarkers;
	};
};

{
	//Handle excessive number of units.
	_x addEventHandler ["CuratorObjectPlaced",{
		_zeus = _this select 0;
		_unit = _this select 1;
		//disable fleeing
		if (ALLOW_FLEEING && _unit isKindOf "Man") then {_unit allowFleeing 0};
		if (player != getAssignedCuratorUnit _zeus) exitWith {};
		[_zeus,_unit] call maxZeusUnitsCheck;
	}];

	_x addEventHandler ["CuratorGroupPlaced",{
		_zeus = _this select 0;
		_grp = _this select 1;

		//disable fleeing
		if (ALLOW_FLEEING) then {_grp allowFleeing 0};

		if (player != getAssignedCuratorUnit _zeus) exitWith {};
		{
			[_zeus,_x] call maxZeusUnitsCheck;
		} forEach units _grp;
	}];
} forEach BLUFOR_ZEUS_LOGIC + INDFOR_ZEUS_LOGIC;

//Init Actions
_id = player addAction ["<t color='#c42726'>Defiance - Command</t>", "_handle = CreateDialog 'DEF_CO_VOTE'", nil, 0, false, true, "", ""];
_id = player addAction ["<t color='#c42726'>Defiance - Sitrep</t>", "_handle = CreateDialog 'DEF_SITREP'", nil, 0, false, true, "", ""];
if (DEF_PLAYER_SIDE == west) then {
	_id = player addAction ["<t color='#009dde'>Search House for Enemy HQ</t>", "call searchHouse", nil, 6, false, true, "", "(count nearestObjects [player, ['House'], 5]) > 0"];
};
//Unflip Action
Flip_Action = player addAction ["Unflip Vehicle", "scripts\unflip.sqf", [], 0, false, true, "", "_this == vehicle _target && (cursorTarget isKindOf 'LandVehicle') && (_this distance cursorTarget <= 5)"];
[[player], "sv_register_unit_zeus", false, false] spawn BIS_fnc_MP;
call cl_welcomeMessage;

//Killed EH
player addEventHandler ["Killed",
{
	[_this] call cl_KilledEH;
}];

//Respawn EH
player addEventHandler ["Respawn", {
		_unit = _this select 0;
		_corpse = _this select 1;
		waitUntil { !(isNull player) && alive player};

        _id = player addAction ["<t color='#c42726'>Defiance - Command</t>", "_handle = CreateDialog 'DEF_CO_VOTE'", nil, 0, false, true, "", ""];
        _id = player addAction ["<t color='#c42726'>Defiance - Sitrep</t>", "_handle = CreateDialog 'DEF_SITREP'", nil, 0, false, true, "", ""];
		if (DEF_PLAYER_SIDE == west) then {
			_id = player addAction ["<t color='#009dde'>Search House for Enemy HQ</t>", "call searchHouse", nil, 6, false, true, "", "(count nearestObjects [player, ['House'], 5]) > 0"];
		};
		//Unflip Action
		Flip_Action = player addAction ["Unflip Vehicle", "scripts\unflip.sqf", [], 0, false, true, "", "_this == vehicle _target && (cursorTarget isKindOf 'LandVehicle') && (_this distance cursorTarget <= 5)"];

		if (isNil "playerFirstSpawn") then
		{
			call cl_welcomeMessage;
			playerFirstSpawn = true;
		};

		//Register Player Unit with Zeus
		[[player], "sv_register_unit_zeus", false, false] spawn BIS_fnc_MP;


        //check for Zeus Command - Keep in-game tracking logic consistent.
		_zeus = _corpse getVariable ["zeus",objNull];
		if (!isNull _zeus) then
		{
			_role = -1;
			switch (DEF_PLAYER_SIDE) do
			{
			    case west:
			    {
			    	_role = BLUFOR_ZEUS_LOGIC find _zeus;
			    };
			    case resistance:
			    {
			    	_role = INDFOR_ZEUS_LOGIC find _zeus;
			    };
			};

			[["update",_unit,_role], "updateZeus", false, false] spawn BIS_fnc_MP;
		};
		if (!isNil "_corpse") then {deleteVehicle _corpse};
		[] spawn cl_spawnsafetycheck;
}];

// Enable victory check loop
[] spawn cl_victoryLoop;

//Player markers
if (PLAYER_MAP_MARKERS == 1) Then {[] spawn playerMarkers};

//Grab data JIP
if (time > 30) then {[[player], "send_all_data", false, false] spawn BIS_fnc_MP; };

if (REVIVE_MODE >= 0 && DEF_PLAYER_SIDE != civilian) then {call compileFinal preprocessFileLineNumbers "FAR_revive\FAR_revive_init.sqf"};

//local player loops
if ( DEF_PLAYER_SIDE == west ) then
{
	[] spawn cl_bluforLoop;
};
if (DEF_PLAYER_SIDE == resistance) then
{
	[] spawn cl_indforLoop;
};

//Spectator mode
if (player == getAssignedCuratorUnit s_zeus) then {
	if (PLAYER_MAP_MARKERS == 0) Then {[] spawn playerMarkers}; // Spawn Map Markers anyway if Spectator
	//[[], "serverSpectatorLoop", false, false] spawn BIS_fnc_MP;
};

//Final Common Init
if (!isServer) then {
	#include "Common\final_init.sqf";
};