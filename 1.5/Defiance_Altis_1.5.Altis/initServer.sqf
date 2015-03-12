#include "Common\var_defiance.sqf";
#include "Common\fnc_defiance.sqf";
#include "server\fnc_defiance_server.sqf";
//register addons & templates
#include "Common\cfg_addonTemplates.sqf";

//Player Cheating/TKing
BLUFOR_PLAYERUIDS = [];
INDFOR_PLAYERUIDS = [];
TK_PLAYERUIDS = [];
TK_TRACKING = [];

["playerConnect", "onPlayerConnected", {
	[_id,_uid,_name] spawn sv_onConnected;
}] call BIS_fnc_addStackedEventHandler;

//GAME SETUP START
// BLUFOR Respawn Tickets
_tickets = [west,STARTING_BLUFOR_TICKETS] call BIS_fnc_respawnTickets;

//Setup Date
 _DateStamp=Date;
 if (START_TIME < 0) then {START_TIME = random 24};
 _startingDate = [_DateStamp select 0, _DateStamp select 1, _DateStamp select 2, START_TIME, 0];

if (DYN_WEATHER) then { [_startingDate,START_WEATHER,WEATHER_CHANGE_SPEED] execVM "scripts\real_weather.sqf"; }
else {setDate _startingDate};

private ["_lt","_wander","_grp","_towns","_town","_wp"];

//Set up the game
_wander = INDFOR_HQ_PLACEMENT_RADIUS;
hqBuildArea = 500;

// Set up BLUFOR HQ
_pos = getMarkerPos "respawn_west";
//INDFOR Attacking Base
b_edit_hq = createTrigger['EmptyDetector', _pos];
b_edit_hq setTriggerArea[hqBuildArea,hqBuildArea,0,false];
b_edit_hq setTriggerActivation["GUER","PRESENT",true];
b_edit_hq setTriggerStatements['this', 'b_zeus removeCuratorEditingArea 0; hint "BLUFOR Base is under attack"', 'b_zeus addCuratorEditingArea [0,getPos b_edit_hq,hqBuildArea]'];
b_zeus addCuratorEditingArea [0,_pos,hqBuildArea];

//Add Ammo box if using VAS
if (VIRTUAL_AMMO_BOX) then
{
	_ammoBoxCount = (ceil ((playersNumber west) /5)) max 1;
	_boxradius = 3+(_ammoBoxCount*2);
	for "_i" from 1 to _ammoBoxCount do
	{
		_box = createVehicle [BLUFOR_AMMO_BOX,getMarkerPos "respawn_west",[],_boxradius,"NONE"];
		_box allowDamage false;
		//Old VAB Code
		_box setVariable ["VAB",west,true];

	};
};

/*kill/remove CIVs in BLUFOR Base
b_convert_hq = createTrigger['EmptyDetector', _pos];
b_convert_hq setTriggerArea[hqBuildArea,hqBuildArea,0,false];
b_convert_hq setTriggerActivation["CIV","PRESENT",true];
b_convert_hq setTriggerStatements['this', '{ if (_x in curatorEditableObjects i_zeus) then {vehicle _x setDamage 1; _x setDamage 1;}; } foreach thislist', ''];
*/
//Set up reserve build area
b_zeus addCuratorEditingArea [1,_pos,hqBuildArea*0.1];

//Spawn BLUFOR MHQ
execVM "scripts\nash_zeus_mhq.sqf";

// Set up BLUFOR ATC
//[b_atc,[atc1,atc2,atc3,atc4],objnull,true,false] call bis_fnc_addCuratorAreaFromTrigger;
_airCOTriggers = [atc1,atc2,atc3,atc4];
{
	_areasize = (triggerArea _x) select 0;
	_areapos = getPos _x;
	if (!SINGLE_CO_MODE) then {
		b_atc addCuratorEditingArea [_foreachindex,_areapos,_areasize];
	} else {
		b_zeus addCuratorEditingArea [_foreachindex+10,_areapos,_areasize];
	};
} forEach _airCOTriggers;

//TODO create triggers to restrict ATC spawns

/*
//set up Zeus Cameras - Obsolete
{
	_x addCuratorCameraArea [0,getMarkerPos "respawn_west",25000];
} forEach BLUFOR_ZEUS_LOGIC+INDFOR_ZEUS_LOGIC;
*/

//Set up HQs
_aafHqCenter = AAF_HQ_CENTER;
if (_aafHqCenter == -1) then {_aafHqCenter = floor (random (count AAF_HQ_MARKERS))};
aafHQSpawnPos = getMarkerPos (AAF_HQ_MARKERS select _aafHqCenter);
_towns = nearestLocations [aafHQSpawnPos, ["NameVillage","NameCity","NameCityCapital"], RAD_AAF_HQ];
_townnum = count _towns;

for [{_i=0}, {_i<NUM_AAF_HQ && count _towns > 0}, {_i=_i+1}] do
{
	private ["_case","_town"];
	_basePos = getMarkerPos "respawn_west";
	_town = _basePos;
	while {_town distance _basePos < 1000} do
	{
		_town = (_towns select (floor (random (count _towns))));
		_towns = _towns - [_town]; //remove the town so we don't use it again
	};

	if (!isNil "_town") then
	{
		_RandomTownPosition = position _town;

		//create INDFOR HQ
		_case = INDFOR_HQ_UNIT createVehicle _RandomTownPosition;
		_case setVariable ["active",(ACTIVE_AO_NUM > _i),true];
		_case setVariable ["town",text _town,true];
		[_case,INDFOR_HQ_PLACEMENT_RADIUS,0,_i] call hideinHouse;
//		missionNamespace setVariable [format["INDFOR_HQ%1",_i],_case];
		if (playersNumber resistance > 0) then {
			_veh = createVehicle ["I_G_Offroad_01_armed_F", position _case, [], 100, "NONE"] ;
			i_zeus addCuratorEditableObjects [[_veh],false];
		};

		//Add Ammo box if using VAS
		if (VIRTUAL_AMMO_BOX) then
		{
			_box = createVehicle [INDFOR_AMMO_BOX,getPos _case,[],100,"NONE"];
			_box allowDamage false;
			//[[_box,"<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf", nil, 1.5, True, True, "", "",nil,nil,nil,nil], "addGlobalAction", resistance, true] spawn BIS_fnc_MP;
			//Hide it in a nearby House
			[_box,100,0,-1] spawn hideinHouse;
			_box setVariable ["VAB",resistance,true];
			//[[getPos _box,"hd_dot","Virtual Ammo Box","ColorGUER",resistance], "createLocalPersistentMarker", true, true] spawn BIS_fnc_MP;
		};

		INDFOR_HQs =  INDFOR_HQs + [_case];
		#ifdef DEBUG
			i_zeus addCuratorEditableObjects [[_case],false];
			b_zeus addCuratorEditableObjects [[_case],false];
		#endif
	};
};
publicvariable "INDFOR_HQs";
i_zeus addCuratorEditingArea [(count curatorEditingArea i_zeus),[0,0,0],1];
//GAME SETUP END

//Final Common Init
#include "Common\final_init.sqf";

//LIVE GAME MONITORING AND CONTROL
[
	60, // seconds to delete dead bodies (0 means don't delete)
	5*60, // seconds to delete dead vehicles (0 means don't delete)
	3*60, // seconds to delete immobile vehicles (0 means don't delete)
	2*60, // seconds to delete dropped weapons (0 means don't delete)
	30*60, // seconds to deleted planted explosives (0 means don't delete)
	0 // seconds to delete dropped smokes/chemlights (0 means don't delete)
] execVM 'scripts\repetitive_cleanup.sqf';

[] spawn {
	sleep 30;
	while {true} do
	{
		if (playersNumber resistance > 0 || PAUSE_BOUNTY == 0) then
		{
			zeusBounty = zeusBounty + (floor (random 5)) + 1;
			publicvariable "zeusBounty";
		};
		sleep 900;
	};
};

//BLUFOR Zeus Upkeep
[] spawn {
	_radioTowers = 0;
	b_zeus addCuratorPoints 0.5;
	b_atc addCuratorPoints 0.5;
	while {true} do
	{
		_towerCount = 0;
		_newUpKeep = BLUFOR_ZEUS_UPKEEP_BASE;
		{
			if (_x isKindOf "Land_TTowerBig_2_F") then {_towerCount = _towerCount +1};
		} forEach curatorEditableObjects b_zeus;

		if (_radioTowers != _towerCount) then
		{
			if (_towerCount > 0) then
			{
				for "_x" from 1 to _towerCount do
				{
					_newUpKeep = _newUpKeep - (_newUpKeep * 0.1); // 10% recursive tax per Radio Tower
				};
				_radioTowers = _towerCount;
			} else {
				_newUpKeep = BLUFOR_ZEUS_UPKEEP_BASE;
				_radioTowers = 0;
			};
			//update vars
			b_zeusUpkeep = _newUpKeep;
			b_atcUpkeep = _newUpKeep/2;
			publicvariable "b_zeusUpkeep";
			[[_side,UPKEEP_MSG_TEMPLATES select 0,b_zeusUpKeep,BLUFOR_ZEUS_UPKEEP_BASE,bluforTick], "upKeepAnnounce", west, false] spawn BIS_fnc_MP;
		};
		b_zeus addCuratorPoints b_zeusUpkeep*ZEUS_RESOURCE_RATE;
		b_atc addCuratorPoints b_atcUpkeep*ZEUS_RESOURCE_RATE;
		sleep bluforTick;
	};
};

//INDFOR Zeus Upkeep & Automated Zeus
[] spawn {
	_zeus = INDFOR_ZEUS_LOGIC select 0;
	_zeus addCuratorPoints 1;
	while {true} do
	{
		//Update Zeus Points
		_zeus addCuratorPoints i_zeusUpkeep*ZEUS_RESOURCE_RATE;
		//Automated Zeus
		if (AI_HADES_SPAWN_COEF > 0) then
		{
			//Operate as long as there are no players on INDFOR
			if (playersNumber resistance == 0 && time > 55) then
			{
				_spawnUnits = false;
				_zPoints = curatorPoints _zeus;
				_troopCount = 0;
				_enemyCount = 0;
				{
					switch (side _x) do
					{
					    case west:
					    {
					    	_enemyCount = _enemyCount +1;
					    };

					    case resistance:
					    {
					     	_troopCount = _troopCount +1;
					    };
					};
				} forEach allUnits;
				// Are we at max points?
				if (_zPoints == 1) Then {	_spawnUnits = true	};
				// Do we have less Units than BLUFOR Players?
				if (_troopCount < playersNumber west) then  {_spawnUnits = true	};
				// Do we only have one location left or less troops than blufor but more than 10% points
				if (_troopCount < _enemyCount  && _zPoints > 0.1) Then { _spawnUnits = true };
				// Do we have less than 50 troops and over 50% points
				if (_troopCount < 50 && _zPoints > 0.5) then  {_spawnUnits = true	};
				if (_troopCount >= MAX_UNITS && MAX_UNITS != -1) then {_spawnUnits = false	}; //disable spawns if we hit the cap.

				if (_spawnUnits) then {
					[_zeus,[resistance],AI_HADES_SPAWN_COEF,0.4,0.6,0,0.1] call def_fnc_curatorAutomatic;
				};
			};
		};
		//now sleep
		sleep indforTick;
	};
};

//BLUFOR & INDFOR CO VOTE
[] spawn {
	sleep 30;
	_votewaitingINDFOR = false;
	_votewaitingBLUFOR = false;
	voteinprogress = false;
	if (playersNumber west > 0 && playersNumber resistance > 0) then
	{
		voteinprogress = true;
		[resistance,DEFAULT_ZEUS_VOTE_TIME,objNull] spawn voteForCOServer;
		[west,DEFAULT_ZEUS_VOTE_TIME,objNull] spawn voteForCOServer;
		sleep DEFAULT_ZEUS_VOTE_TIME+5;
	};
	while {true} do
	{
		private ["_westVote","_guerVote"];
		_westVote = true;
		_guerVote = true;

		//check we have players
		if (playersNumber resistance == 0) then {_guerVote = false};
		if (playersNumber west == 0) then {_westVote = false};

		//check resistance
		if (_guerVote) then
		{
			{
				private ["_zeusUnit"];
				_zeusUnit = getAssignedCuratorUnit _x;
				//[[format["%1: %2",_x,_zeusUnit]], 'def_fnc_debug', true, false] spawn BIS_fnc_MP;
				if (!isNil "_zeusUnit") then
				{
					if (!isnull _zeusUnit && isPlayer _zeusUnit) then {
						//make sure variables are correctly updated
						if (isNull (_zeusUnit getVariable ["zeus",objNull])) then
						{
							["update",_zeusUnit,_foreachindex] spawn updateZeus;
						};
						if (_foreachindex <= ZEUS_CO_MAX_INDEX) then { _guerVote = false };
					};
				};
			} forEach INDFOR_ZEUS_LOGIC;
		};
		//check west
		if (_westVote) then
		{
			{
				private ["_zeusUnit"];
				_zeusUnit = getAssignedCuratorUnit _x;
				if (!isNil "_zeusUnit") then
				{
					//[[format["%1: %2",_x,_zeusUnit]], 'def_fnc_debug', true, false] spawn BIS_fnc_MP;
					if (!isnull _zeusUnit && isPlayer _zeusUnit) then {
						//make sure variables are correctly updated
						if (isNull (_zeusUnit getVariable ["zeus",objNull])) then
						{
							["update",_zeusUnit,_foreachindex] spawn updateZeus;
						};
						if (_foreachindex <= ZEUS_CO_MAX_INDEX) then { _westVote = false };
					};
				};
			} forEach BLUFOR_ZEUS_LOGIC;
		};

		//Call votes if we need them
		if (_guerVote && ((!voteinprogress) || _votewaitingINDFOR)) then
		{
			voteinprogress = true;
			_votewaitingINDFOR = false;
			[resistance,DEFAULT_ZEUS_VOTE_TIME,objNull] spawn voteForCOServer;
			//sleep DEFAULT_ZEUS_VOTE_TIME;
		} else {
			_votewaitingINDFOR = _guerVote;
		};
		if (_westVote && (!voteinprogress || _votewaitingBLUFOR)) then
		{
			voteinprogress = true;
			_votewaitingBLUFOR = false;
			[west,DEFAULT_ZEUS_VOTE_TIME,objNull] spawn voteForCOServer;
			//sleep DEFAULT_ZEUS_VOTE_TIME;
		} else {
			_votewaitingBLUFOR = _westVote;
		};
		sleep DEFAULT_ZEUS_VOTE_TIME+5;
	};
};

//Headless Client
if (HCPresent) then
{
	[] spawn {
		while {true} do
		{
			{
				if(!isPlayer _x && (owner _X == 0)) then
				{
					_X setowner (owner HCUnit);
				};
			} forEach allUnits;
			sleep 60;
		};
	};
};

//Victory Check
[] spawn {
	[] call updateHQCount;
	while {true} do
	{
	    //We'll check to see if all the HQs are dead insted.
		// BLUFOR WIN?
		if (CURRENT_NUM_AAF_HQ < 1 && time > 30) then { bluforWin = true; publicvariable "bluForWin"; sleep 30; endMission "END1"};

		// INDFOR WIN?
		_tickets = [west] call BIS_fnc_respawnTickets;
		if (_tickets <= 0 && time > 30) then { indforWin = true; publicvariable "indforWin"; sleep 30; endMission "END2"};
		sleep 60;
	};
};

// Set up Active HQs
if (ACTIVE_AO_NUM > 0) then
{
	[] call sv_updateActiveHQs;
};

//start breadcrumb
if (START_INTEL_BREADCRUMB) then
{
	sleep 30;
	[[false], "cl_intelBreadcrumb", west, false] spawn BIS_fnc_MP;
};