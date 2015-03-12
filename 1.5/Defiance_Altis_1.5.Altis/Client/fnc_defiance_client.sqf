addGlobalAction = {
	private ["_title", "_script", "_arguments", "_priority", "_showWindow", "_hideOnUse", "_shortcut", "_condition"];
	/*_unit = [_this, 0, objNull] call BIS_fnc_param;
	_title = [_this, 1, ""] call BIS_fnc_param;
	_script = [_this, 2, ""] call BIS_fnc_param;
	_arguments = [_this, 3, nil] call BIS_fnc_param;
	_priority = [_this, 4, 1.5] call BIS_fnc_param;
	_showWindow = [_this, 5, true] call BIS_fnc_param;
	_hideOnUse = [_this, 6, true] call BIS_fnc_param;
	_shortcut = [_this, 7, ""] call BIS_fnc_param;
	_condition = [_this, 8, true] call BIS_fnc_param;*/
	_unit = _this select 0;
	_title = _this select 1;
	_script = _this select 2;
	_arguments = _this select 3;
	_priority = _this select 4;
	_showWindow = _this	select 5;
	_hideOnUse = _this select 6;
	_shortcut = _this select 7;
	_condition = _this select 8;
	 _unit addAction [_title, _script, _arguments, _priority, _showWindow, _hideOnUse, _shortcut, _condition];
};

cl_HandleDLC =
{
	//Kart DLC
	if (288520 in (getDLCs 2)) then
	{
		//Credit to Mr Burns - DLC Should not split the Community
		/*player addaction ['<t color="#ff0000">Get in Kart (Without DLC)</t>',
				{ player moveindriver cursortarget }, this, 1, true, true,'',
				'(typeof cursortarget == "C_Kart_01_Blu_F" ||
				typeof cursortarget == "C_Kart_01_F" ||
		        typeof cursortarget == "C_Kart_01_F_Base" ||
				typeof cursortarget == "C_Kart_01_Fuel_F" ||
				typeof cursortarget == "C_Kart_01_Red_F" ||
				typeof cursortarget == "C_Kart_01_Vrana_F"
				) && (player distance cursortarget < 10) && (vehicle player == player) && ((cursortarget emptyPositions "driver") > 0) '];*/
		player addaction ['<t color="#ff0000">Get in Kart (Without DLC)</t>',
				{ player moveindriver cursortarget }, this, 1, true, true,'',
				'(cursortarget isKindOf "C_Kart_01_F_Base") && (player distance cursortarget < 10) && (vehicle player == player) && ((cursortarget emptyPositions "driver") > 0) '];
	};
};

createSearcedhMarker = {
	_housePos = _this select 0;
	_marker = createMarkerLocal [(format["cleared_%1",time]),_housePos];
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerTypeLocal "mil_box";
};

civHalt = {
	_civ = _this select 0;
	if (!isNull _civ && !isNil "_civ") then
	{
		_civ playMoveNow "AmovPercMstpSsurWnonDnon";
		if (local _civ) then
		{
			_civ disableAI "MOVE";
			_civ disableAI "ANIM";
		};
		sleep 10;
		_civ playMoveNow "AmovPsitMstpSnonWnonDnon_ground";
		if (local _civ) then
		{
			sleep 30;
			_civ enableAI "ANIM";
			_civ enableAI "MOVE";
		};
	};
};

createHouseIntelMarker = {

	if (SHOW_CIV_INTEL_RADIUS == -1) exitWith {};

	_obj = _this select 0; // The HQ Object
	_realIntel = _this select 1; // Is this marker being created as real intel
	_radius = CIV_INTEL_RANGE;
	_color = "ColorOrange";
	_intelNum = _obj getVariable ["intelNum",0];
	if (_realIntel) then
	{
		_radius = CIV_INTEL_HQ_RADIUS - (_intelNum*CIV_INTEL_HQ_INCREMENTS);
	} else {
		_radius = CIV_INTEL_HQ_RADIUS - ((floor (random 10))*CIV_INTEL_HQ_INCREMENTS);
	};
	if (_radius < CIV_INTEL_HQ_INCREMENTS) then {_radius = 10; _color = "ColorRed"};
	_randomPos = [(getpos _obj select 0) + _radius*0.5 - (random _radius), (getpos _obj select 1) + _radius*0.5 - (random _radius), 0];
	_houseArray = nearestObjects [_randomPos, ["House"], _radius];
	_pos = getPos (_houseArray select (floor (random (count _houseArray))));
	_marker = createMarker ["civ_intel_"+str(time), _pos];
	if (SHOW_CIV_INTEL_RADIUS >= 1) Then
	{
			_marker setMarkerText format ["%1m",_radius];
	};
	_marker setMarkerType "mil_box";
	_marker setMarkerColor _color;
	_markerArray = [_marker];
	private ["_markerbg"];
	if (SHOW_CIV_INTEL_RADIUS == 2) then
	{
		_markerbg = createMarker ["civ_intelbg_"+str(time), _pos];
		_markerbg setMarkerColor "ColorBlack";
		_markerbg setMarkerShape "ELLIPSE";
		_markerbg setMarkerBrush "Border";
		_markerbg setMarkerSize [_radius,_radius];
		_markerArray = _markerArray + [_markerbg];
	};
	civIntelMarkers = civIntelMarkers + _markerArray;
	publicvariable "civIntelMarkers";
	if (_realIntel) then
	{
		_obj setVariable [format["civ_intel_%1",_intelNum],_marker,true];
		if (SHOW_CIV_INTEL_RADIUS == 2) then { _obj setVariable [format["civ_intelbg_%1",_intelNum],_markerbg,true] };
	} else {
		[_markerArray] spawn {
			_faKeMarkers = _this select 0;
			sleep 900;
			{
				deleteMarker _x;
			} forEach _faKeMarkers;
		};
	};
	civIntelMarkers
};

pickupIntel = {

	_message = format ["%1 deactivated the enemy HQ.",name intelOwner];
	["HQClosed",[_message]] call bis_fnc_showNotification;
	[west,"hq"] sideChat _message;

	//determine the next clue for civ intel

	//Intel

	sleep 2;
	if (!isNull getAssignedCuratorUnit (INDFOR_ZEUS_LOGIC select 0)) then
	{
		[west,"hq"] sideChat format ["We can now track the enemy leader via his satellite phone for %1 minutes or until we neutralized him.",HADES_TRACK_TIME/60];
		sleep 2;
	};
	[true] call cl_intelBreadcrumb;
};


cl_intelBreadcrumb = {
	_foundHQ = _this select 0;
	if (SHOW_INTEL_BREADCRUMB >= 0) then
	{
		private ["_nextTown","_intelTowns","_towns","_hqs","_intelradius","_message"];
		if (_foundHQ) then { _hqs = intelOwner nearEntities [INDFOR_HQ_UNIT, 25000]; }
		//else { _hqs = (getMarkerPos "respawn_west") nearEntities [INDFOR_HQ_UNIT, 25000]; };
		else { _hqs = allMissionObjects INDFOR_HQ_UNIT; };
		_hqs = [_hqs] call cmn_rmv_inactive_Hqs_from_array;
		if (count _hqs == 0) exitWith {};
		_intelradius = (CIV_INTEL_RANGE*0.75);
		_towns = nearestLocations [getPos (_hqs select 0), ["NameVillage","NameCity","NameCityCapital"], _intelradius];
		_townCount = (count _towns)-1;
		if (_townCount >= 0) then {
			//_nextTown = _towns select floor (random count _towns);
			_nextTown = _towns select _townCount;
			_intelTowns = [];
			if (SHOW_INTEL_BREADCRUMB == 1) Then
			{
				_intelTowns = [_nextTown];
			} else {
				_intelTowns = nearestLocations [position _nextTown, ["NameVillage","NameCity","NameCityCapital"], _intelradius];
			};

			{
				_nextCivIntel = getPos _x;
				_marker = createMarkerLocal ["civintel" + str(time) + str(_foreachindex), [_nextCivIntel select 0,(_nextCivIntel select 1)-100]];
				_marker setMarkerTypeLocal "hd_flag";
				_marker setMarkerColorLocal "ColorOrange";
				_marker setMarkerTextLocal "Possible Enemy HQ in this area (Interview Civs to find it)";
			} forEach _intelTowns;
			if (_foundHQ) then {_message = "Records found at the HQ showed potential enemy HQ locations. Check map for flag markers."}
			else {_message = "Command has sent us some initial intel on enemy operating areas. Check map for flag markers."};
			[west,"hq"] sideChat _message;
		} else {
			[west,"hq"] sideChat format["No records of any AAF activity found within a %1m radius of the HQ.",_intelradius];
		};
	};
};

def_fnc_playerMarkers = {
	//PLAYER_MAP_MARKERS
	if (isnil "playerMarkersArray") then {playerMarkersArray = []};
	private ["_updatedMarkers","_deletedMarkers"];
	_spectator = getAssignedCuratorUnit s_zeus;
	_isSpectator = (player == _spectator);
    _updatedMarkers = [];
	{
		if (isPlayer _x) then
		{
			private ["_color","_type","_marker","_markerName","_label","_vcl","_side","_playerUID"];
			_side = side _x;
			if ((_side == playerSide || _isSpectator) && _x != _spectator) then {
				_playerUID = getPlayerUID _x;
				_markerName = format["pm_%1",_playerUID];
				if (getMarkerColor _markerName == "") then
				{
					_marker = createMarkerLocal [_markerName,[0,0]];
					playerMarkersArray set [count playerMarkersArray, _marker];
					_updatedMarkers set [count _updatedMarkers,_marker];
				} else {
					_marker = _markerName;
					_updatedMarkers set [count _updatedMarkers,_marker];
				}
			};
			_color = "ColorBlue";
			if (_isSpectator) then {
			    _color = [_side,true] call bis_fnc_sidecolor;
			} else {
				if (group _x == group player) Then {_color = "ColorGreen"};
				if (player == _X)Then {_color = "ColorYellow"};
				if (_x getVariable ["FAR_isUnconscious",0] == 1) Then {_color = "ColorRed"};
				if (!alive _x ) Then {_color = "ColorBlack"};
			};
			_type = "mil_dot";
			_label = name _x;
			_vcl = vehicle _x;
			if (_vcl != _x) then {
				_label = format ["%1:", getText (configFile >> "cfgVehicles" >> (typeOf _vcl) >> "displayName")];
				{
					if (isPlayer _x) then { _label = _label + format [" %1,", name _x]};
				} forEach crew _vcl;
				_label = [_label,0,-1] call BIS_fnc_trimString;
				_type = "mil_triangle";
			} else {

				if (PLAYER_MAP_MARKERS == 2) then
				{
					private ["_distance"];
					_distance = (player distance _x);
					if ((_side == playerSide && _distance <= 100)  || _isSpectator) then
					{
						private ["_texture","_playerPos","_textSize","_size"];
						switch (_side) do
						{
						    case west:
						    {
						    	_texture = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
						    };

						    case resistance:
						    {
								_texture = "\A3\ui_f\data\map\markers\nato\n_unknown.paa";
							};

						    default
						    {
						     	_texture = "\A3\ui_f\data\map\markers\nato\o_unknown.paa";
						    };
						};

						_playerPos = getPosATL _x;
						_size = 2-(_distance/50);
						_textSize = 0.05-(_distance/4000);
						drawIcon3D [
					        _texture,
					        [_side,false] call bis_fnc_sidecolor,
					        [_playerPos select 0,_playerPos select 1,1.8],
					        _size,
					        _size,
					        0,
					        name _x,
					        0,
					        _textSize,
					        "PuristaMedium"
	    				];
	    			};
				};
			};
			if (getMarkerColor _markerName != "") then {
				_marker setMarkerColorLocal _color;
				_marker setMarkerTypeLocal _type;
				_marker setMarkerTextLocal _label;
				_marker setMarkerPosLocal getPos _vcl;
				_marker setMarkerDirLocal getDir _vcl;
			};
		};
	} forEach playableUnits;

	_deletedMarkers = playerMarkersArray - _updatedMarkers;
    {
    	deleteMarkerLocal _x;
    } forEach _deletedMarkers;
    playerMarkersArray = playerMarkersArray - _deletedMarkers;
};

playerMarkers = {
	private ["_isSpectator","_playerMarkers","_spectator","_resetTimer"];
	_playerMarkers = [];
	sleep 1;
	_spectator = getAssignedCuratorUnit s_zeus;
	_isSpectator = (player == _spectator);
	_resetTimer = time + 60;
	while {true} do
	{
		private ["_updatedMarkers","_deletedMarkers"];
	    _updatedMarkers = [];
	    {
	    	if (isPlayer _x) then
	    	{
		    	private ["_color","_type","_marker","_markerName","_label","_vcl","_side","_playerUID"];
				_side = side _x;
				if ((_side == playerSide || _isSpectator) && _x != _spectator) then {
					_playerUID = getPlayerUID _x;
					_markerName = format["pm_%1",_playerUID];
					if (getMarkerColor _markerName == "") then
					{
						_marker = createMarkerLocal [_markerName,[0,0]];
						_playerMarkers = _playerMarkers + [_marker];
						_updatedMarkers = _updatedMarkers + [_marker];
					} else {
						_updatedMarkers = _updatedMarkers + [_markerName];
					}
				};
				_color = "ColorBlue";
				if (_isSpectator) then {
				    _color = [_side,true] call bis_fnc_sidecolor;
				} else {
					if (group _x == group player) Then {_color = "ColorGreen"};
					if (player == _X)Then {_color = "ColorYellow"};
					if (_x getVariable ["FAR_isUnconscious",0] == 1) Then {_color = "ColorRed"};
					if (!alive _x ) Then {_color = "ColorBlack"};
				};
				_type = "mil_dot";
				_label = name _x;
				_vcl = vehicle _x;
				if (_vcl != _x) then {
					_label = format ["%1:", getText (configFile >> "cfgVehicles" >> (typeOf _vcl) >> "displayName")];
					{
						if (isPlayer _x) then { _label = _label + format [" %1,", name _x]};
					} forEach crew _vcl;
					_label = [_label,0,-1] call BIS_fnc_trimString;
					_type = "mil_triangle";
				};
				if (getMarkerColor _markerName != "") then {
					_marker setMarkerColorLocal _color;
					_marker setMarkerTypeLocal _type;
					_marker setMarkerTextLocal _label;
					_marker setMarkerPosLocal getPos _vcl;
					_marker setMarkerDirLocal getDir _vcl;
				};
			};
		} forEach (playableUnits);
		/*
		if (_resetTimer < time) then
		{
			_deletedMarkers = _playerMarkers;
			_resetTimer = time + 60;
		} else {
			_deletedMarkers = _playerMarkers - _updatedMarkers;
		};
		*/
		_deletedMarkers = _playerMarkers - _updatedMarkers;
	    {
	    	deleteMarkerLocal _x;
	    } forEach _deletedMarkers;
	    _playerMarkers = _playerMarkers - _deletedMarkers;

	    sleep 1;
	};
};

searchHouse = {
	_houseArray = nearestObjects [player, ["House"], 5];
	if (count _houseArray > 0) then {
		_house = _houseArray select 0;
		_hqs = nearestObjects [_house,[INDFOR_HQ_UNIT], 10];
		if (count _hqs == 0) then {
			//Nothing nearby, lets create a marker.
			[[getpos _house], "createSearcedhMarker", west, false] spawn BIS_fnc_MP;
			systemChat "No sign of the an enemy HQ in this building. Marked as cleared on Map";
			hintSilent "";
		} else {
			hint "Enemy HQ is nearby";
		};
	} else {
		hint "Get near to the center of a building to clear it";
	};
};


voteForCOClient = {
	_voteSide = _this select 0;
	_voteTime = _this select 1;
	if (_voteTime > 0 && playerSide == _voteSide) then
	{
		// Add Vote Menu
		_id = player addAction ["<t color='#19c0f3'>Vote for CO</t>", "_handle = CreateDialog 'DEF_CO_VOTE'", nil, 99, True, True, "", ""];
		[_voteSide,"hq"] sidechat format[ "Vote for your new Commanding Officer! Voting ends in %1 seconds.",_voteTime];
		//_handle = CreateDialog 'DEF_CO_VOTE';
		sleep _voteTime;
		[_voteSide,"hq"] sidechat format ["Voting has closed. You recieved %1 votes.",player getVariable ["votes",0]];
		player removeAction _id;
	};
};

maxZeusUnitsCheck = {
	_zeus = _this select 0;
	_unit = _this select 1;
	if (_unit isKindOf "AllVehicles") then
	{
		_unitCount = {alive _x && side _x == playerSide} count allUnits;
		if (_unitCount >= MAX_UNITS && MAX_UNITS != -1) then
		{
			[_zeus,format ["Maximum Unit Limit Of %1 Reached",MAX_UNITS]] call BIS_fnc_showCuratorFeedbackMessage;
			[[_zeus,_unit], "remoteZeusUnitDelete", false, false] spawn BIS_fnc_MP;
		};
	};
};

cl_baseSafetyLoop = {
	Base_Safety = true;
	_safetyHandler = player addEventHandler ["Fired",{
		_projectile = _this select 6;
		if (side cursorTarget == playerSide) then
		{
			deleteVehicle _projectile;
			hintC "Do not fire on friendlies!";
		}
		else
		{
			if ((_projectile isKindOf "GrenadeHand" && !(_projectile isKindOf "SmokeShell")) || _projectile isKindOf "TimeBombCore") then
			{
				deleteVehicle _projectile;
				hintC "Do not place explosives or throw grenades on base!";
			} else
			{
				if (side cursorTarget != resistance) then
				{
					deleteVehicle _projectile;
					hintSilent "Firing is restricted on base, unless you're targetting an enemy";
				};
			};
		};
	}];

	/*
	while {Base_Safety} do {
		_objs = (getpos player nearObjects ["Sh_82mm_AMOS",300]);
		if (count _objs >  0) then
		{
			{
				deleteVehicle _x;
			} forEach _objs;
		};
		sleep 0.5;
	}; */
	waitUntil {sleep 1;Base_Safety == false};
	player removeEventHandler ["fired",_safetyHandler];
};

cl_BaseSafety_FiredEH = {
	_projectile = _this select 6;
	if (side cursorTarget == playerSide) then
	{
		deleteVehicle _projectile;
		hintC "Do not fire on friendlies!";
	}
	else
	{
		if ((_projectile isKindOf "GrenadeHand" && !(_projectile isKindOf "SmokeShell")) || _projectile isKindOf "TimeBombCore") then
		{
			deleteVehicle _projectile;
			hintC "Do not place explosives or throw grenades on base!";
		} else
		{
			if (side cursorTarget != resistance) then
			{
				deleteVehicle _projectile;
				hintSilent "Firing is restricted on base, unless you're targetting an enemy";
			};
		};
	};
};

cl_KilledEH = {
	private ["_victim","_killer","_playerTeamKiller"];
	_params = _this select 0;
	_victim = _params select 0;
	_killer = _params select 1;
	/*["Killed EH Function"] call def_fnc_debug;
	[format ["%1 was killed by %2", _victim, _killer]] call def_fnc_debug;
	systemChat str((isPlayer _killer));
	systemChat str((_victim != _killer));
	systemChat str((vehicle _victim != vehicle _killer));
	systemchat ([playerside] call bis_fnc_sideName);
	systemChat str((playerSide == side _killer));*/
	if (!(isnil "_victim" || isnil "_killer")) then
	{
		_veh = vehicle _killer;
		if ((isPlayer _killer) && (_victim != _killer) && (vehicle _victim != _veh) && ((playerside == side _killer) || (side _killer == sideEnemy))) then
		{
			_playerTeamKiller = objNull;
			//["Checking for TKer"] call def_fnc_debug;
			if(_killer isKindOf "Man") then {
				_playerTeamKiller = _killer;
				//["TKer is Man"] call def_fnc_debug;
			} else {
				if (damage _veh != 1) then
				{
					//["TKer is Vehicle"] call def_fnc_debug;
					_trts = configFile >> "CfgVehicles" >> typeof _veh >> "turrets";
					_paths = [[-1]];
					if (count _trts > 0) then {
						for "_i" from 0 to (count _trts - 1) do {
							_trt = _trts select _i;
							_trts2 = _trt >> "turrets";
							_paths = _paths + [[_i]];
							for "_j" from 0 to (count _trts2 - 1) do {
								_trt2 = _trts2 select _j;
								_paths = _paths + [[_i, _j]];
							};
						};
					};
					_ignore = ["SmokeLauncher", "FlareLauncher", "CMFlareLauncher", "CarHorn", "BikeHorn", "TruckHorn", "TruckHorn2", "SportCarHorn", "MiniCarHorn", "Laserdesignator_mounted"];
					_suspects = [];
					{
						_weps = (_veh weaponsTurret _x) - _ignore;
						if(count _weps > 0) then {
							_unt = objNull;
							if(_x select 0 == -1) then {_unt = driver _veh;}
							else {_unt = _veh turretUnit _x;};
							if(!isNull _unt) then {
								_suspects = _suspects + [_unt];
							};
						};
					} forEach _paths;

					if(count _suspects == 1) then {
						_playerTeamKiller = _suspects select 0;
					};
				};
			};
			if (!(isNull _playerTeamKiller) && isPlayer _playerTeamKiller) then
			{
				[[getPlayerUID _playerTeamKiller,name _playerTeamKiller], "sv_handleTKer", false, false] spawn BIS_fnc_MP;
			};
		};
	};
};

cl_zeusRespawnHandler = {
	[player,objnull] call BIS_fnc_curatorRespawn; // Make sure any Curator roles transfer over to the new unit
};

cl_lostHQ = {
	_townName = _this select 0;
	_message = format ["We have lost contact with our HQ near %1",_townName];
	["HQClosed",[_message]] call bis_fnc_showNotification;
	[resistance,"hq"] sidechat _message;
};

cl_updateActiveHQs = {
	//_allHqs = (getMarkerPos "respawn_west") nearEntities [INDFOR_HQ_UNIT, RAD_AAF_HQ+1000];
	_allHqs = allMissionObjects INDFOR_HQ_UNIT;
	if (count activeHQMarkers > 0) then
	{
		{
			deleteMarkerLocal _x;
		} forEach activeHQMarkers;
		activeHQMarkers = [];
	};
	//create new markers
	{
		if (_x getVariable ["active",false]) then
		{
			_pos = getPos _x;
			_marker = createMarkerLocal [(format["activeHQ_%1",_foreachindex]),_pos];
			_marker setMarkerColorLocal "ColorGuer";
			_marker setMarkerTypeLocal "n_hq";
			_marker setMarkerTextLocal "Defend HQ";

			_markerbg = createMarkerLocal [(format["activeHQ_bg%1",_foreachindex]), _pos];
			_markerbg setMarkerShapeLocal "ELLIPSE";
			_markerbg setMarkerColorLocal "ColorGuer";
			_markerbg setMarkerBrushLocal "Solid";
			_markerbg setMarkerAlphaLocal 0.33;
			_markerbg setMarkerSizeLocal [INDFOR_HQ_PLACEMENT_RADIUS,INDFOR_HQ_PLACEMENT_RADIUS];

			activeHQMarkers = activeHQMarkers + [_marker,_markerbg];
		};
	} forEach _allHqs;
};

cl_welcomeMessage = {
	//Newbie Player Notification
	//image "img\defiance.jpg"
	_hints = [composeText ["Read the Briefing (On the Map Menu) for full details."]];

	if (playerSide == west) then
	{
		_hints = _hints + [text ("Talk with civilians in towns to get Intel")];
		_hints = _hints + [text("Search Houses to find INDFOR HQs")];
		_hints = _hints + [text("Find HQs and walk over them to deactivate")];
		_hints = _hints + [composeText["Deactive all HQs before running out of tickets to win!"]];
	};
	if (playerSide == resistance) then
	{
		_hints = _hints + [Text ("Kill BLUFOR Players to reduce their tickets")];
		_hints = _hints + [text("Defend your HQs (Spawn Points) to stop BLUFOR deactivating them")];
		_hints = _hints + [text("Kill BLUFOR's MHQ to reduce their tickets also")];
		_hints = _hints + [composeText["Reduce BLUFOR Tickets to 0 before all your HQs are deactivated to win!"]];
	};
	"New to Defiance?" hintC _hints;
};

cl_bluforLoop = {
	//Set up Spawn Areas
	_spawnMarkers = ["respawn_west"];
	_airfieldActive = (getMarkerColor "respawn_west2" != "");
	//set up fast travel for HQ/MHQ and Airfield
	if (_airfieldActive) then {_spawnMarkers = _spawnMarkers + ["respawn_west2"]};
	{
		_pos = getMarkerPos _x;
		//Fast Travel
		_flag = "Flag_Blue_F" createVehicleLocal _pos;
		_actid = _flag addAction ["Travel to MHQ","player setPos ((getPos b_mhq) findEmptyPosition [5,100])"];
		if (_airfieldActive) then
		{
			_actid = _flag addAction ["Travel to HQ","player setPos ((getMarkerPos 'respawn_west') findEmptyPosition [5,100])"];
			_actid = _flag addAction ["Travel to Airfield","player setPos ((getMarkerPos 'respawn_west2')  findEmptyPosition [5,100])"];
		};

		//Create the Weapon Safety Triggers
		_trig_WeaponSafety = createTrigger['EmptyDetector', _pos];
		_trig_WeaponSafety setTriggerArea[125,125,0,false];
		_trig_WeaponSafety setTriggerActivation["WEST","PRESENT",true];
		//_trig_WeaponSafety setTriggerStatements['player in thislist', '_handler = [] spawn cl_baseSafetyLoop', 'Base_Safety = false'];
		_trig_WeaponSafety setTriggerStatements['player in thislist', 'Base_Safety = player addEventHandler["Fired",cl_BaseSafety_FiredEH]', 'player removeEventHandler ["fired",Base_Safety]'];
	} forEach _spawnMarkers;
	//CHECK FOR VAS
	_bluforVASArray = [BLUFOR_AMMO_BOX];
	if (VIRTUAL_AMMO_BOX_MHQ) then {_bluforVASArray = _bluforVASArray + [BLUFOR_MHQ_TYPE]};
	sleep 1;
	_vasBoxes = [];
	{
		_vasBoxes = _vasBoxes + allMissionObjects _x;
	} forEach _bluforVASArray;
	{
		_x addAction["<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf"];
		if !(_x isKindOf BLUFOR_MHQ_TYPE) then { [getPos _x,"mil_dot","Virtual Ammo Box","ColorWEST"] call createLocalPersistentMarker; };
	//} forEach ((getMarkerPos "respawn_west") nearEntities [_bluforVASArray, 25000]);
	} forEach _vasBoxes;

	while {true} do
	{
		call casePickup;
		if (!isNil "b_mhq" && alive b_mhq) then { "respawn_west1" setMarkerPosLocal (getPos b_mhq); }
			else { "respawn_west1" setMarkerPosLocal (getMarkerPos "b_mhq_spawn");};
		sleep 1;
	};
};

cl_indforLoop = {
//CHECK FOR VAS
	sleep 1;
	{
		_x addAction["<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf"];
		[getPos _x,"mil_dot","Virtual Ammo Box","ColorGUER"] call createLocalPersistentMarker;
	//} forEach ((getMarkerPos "respawn_west") nearEntities [INDFOR_AMMO_BOX, 25000]);
	} forEach allMissionObjects INDFOR_AMMO_BOX;

	"respawn_west" setMarkerAlphaLocal 0;
	"respawn_west2" setMarkerAlphaLocal 0;
	deleteMarkerLocal "respawn_west1";

	if (INDFOR_TEAM_STACK_RATIO > 0) then
	{

		// Side Stacking Check
		sleep 15;
		if ((playersNumber west)/INDFOR_TEAM_STACK_RATIO < playersNumber resistance && playersNumber resistance > 1) then {
			player groupChat "You are stacking the INDFOR side, you must join the BLUFOR side within 10 seconds or you will be forced back to the Lobby";
			hintc "You are stacking the INDFOR side, you must join the BLUFOR side within 10 seconds or you will be forced back to the Lobby";
			titleText["You are stacking the INDFOR side, you must join the BLUFOR side within 10 seconds or you will be forced back to the Lobby", "BLACK", 10];
			sleep 10;
			if ((playersNumber west)/INDFOR_TEAM_STACK_RATIO < playersNumber resistance && playersNumber resistance > 1) then { ["INDFOR_STACKING",false] call BIS_fnc_endMission; };
			//if ((playersNumber west)/INDFOR_TEAM_STACK_RATIO < playersNumber resistance && playersNumber resistance > 1) then { [[name player], "sv_kickPlayer", false, false] spawn BIS_fnc_MP };
		};
	};
};

cl_victoryLoop = {
	while {true} do
	{
		if (bluforWin && indforWin) then {hint "Somehow this ended up as a draw!?"; sleep 20; endMission "END1";};
		if (bluforWin) then
		{
			if (playerSide == resistance) then
			{
				["INDFOR_LOSS",false] call BIS_fnc_endMission;
			}
			else
			{
				["BLUFOR_WIN",true] call BIS_fnc_endMission;
			}
		};

		if (indforWin) then
		{
			if (playerSide == west) then
			{
				["BLUFOR_LOSS",false] call BIS_fnc_endMission;
			}
			else
			{
				["INDFOR_WIN",true] call BIS_fnc_endMission;
			};
		};
		sleep 15;
	};
};

cl_zeusKeyHandler = {
	private['_handled'];
	_handled = false;

	switch (_this select 1) do
	{
		//L key
		case 38:
		{
			private ["_handledVehicles"];
			_selectedUnits = curatorSelected select 0;
			_handledVehicles = [];
			{
				private ["_vehicle","_driver","_grp"];
				if (typename (_x) == "ARRAY") then { _vehicle = vehicle (_x select 0)}
				else {_vehicle = vehicle _x};
				if (_vehicle isKindOf "Helicopter" && !(_vehicle in _handledVehicles)) then
				{
					_handledVehicles = _handledVehicles + [_vehicle];
					_driver = (driver _vehicle);
					if !(_vehicle getVariable ["def_landing",false]) then
					{
						_vehicle setVariable ["def_landing",true];
						if (!isPlayer _driver) then
						{
							systemChat format ["%1 is now landing. It will hold position until you press L again.", _driver];
							_grp = group _driver;
							while {count waypoints _grp > 0} do {deletewaypoint (waypoints _grp select 0)};
							doStop _vehicle;
							[[_vehicle], "cl_remoteHeliLand", _vehicle, false] spawn BIS_fnc_MP;
						} else {
							systemChat "You cannot force a player to land.";
						};
					} else {
						_vehicle doMove (getPos _vehicle);
						_vehicle setVariable ["def_landing",false];
						systemChat format ["%1 is no longer holding position.", _driver];
					};
				};
			} forEach _selectedUnits;
			_handled = true;
		};
	};
	_handled;
};

cl_remoteHeliLand = {
	_heli = _this select 0;
	_heli land "Land";
};

cl_spawnsafetycheck =
{
	waitUntil {alive Player};
	sleep 2;
	_safeSpawn = false;
	if (playerside == west)	 then
	{
		private ["_spawnMarkers"];
		_spawnMarkers = ["respawn_west","respawn_west1"];
		if (getMarkerColor "respawn_west2" != "") then {_spawnMarkers = _spawnMarkers + ["respawn_west2"]};
		{
			if (!_safeSpawn) then {_safeSpawn = (player distance (getMarkerPos _x)) < 250};
		} forEach _spawnMarkers;
		if !(_safeSpawn) then {player setPos (getMarkerPos "respawn_west")};
	};
	if (playerSide == resistance) then
	{
		_nearbyHqs = count (player nearEntities [INDFOR_HQ_UNIT,250]);
		if (_nearbyHqs == 0) then
		{
			//_allHQs = player nearEntities [INDFOR_HQ_UNIT,25000];
			_allHQs = allMissionObjects INDFOR_HQ_UNIT;
			if (count _allHQs > 0) then {player setPos (getPos (_allHQs select 0))};
		} else
		{
			_safeSpawn = true;
		};
	};
	if !(_safeSpawn) then {systemchat "Spawn position check failed. You have been moved to a new location."};
};

cl_zeusFoW = {
 	//hint str((getAssignedCuratorLogic player));
 	if (!isNull (getAssignedCuratorLogic player)) then
 	{
	 	_enemy = civilian;
		_zeusLos = ZEUS_PLAYER_LOS;
		_unitLos = ZEUS_MINION_LOS;
		switch (playerSide) do {
			case resistance: {
				_enemy = west;
			};
			case west: {
				_enemy = resistance;
			};
		};
		ZeusFOWLoop = true;
		_keysHooked = false;
		_unitsFar = nil;
 		while {ZeusFOWLoop} do
 		{
	 		_throttle = 1;
	 		//check to see if Zeus display is open
	 		//hint str((!(isNull (findDisplay 312 ))));
	 		if (!(isNull (findDisplay 312 ))) then
	 		{
		 		//Hook Event Handler for Custom Zeus Actions
		 		if (!_keysHooked) then
		 		{
					(findDisplay 312) displayAddEventHandler ["KeyDown","_this call cl_zeusKeyHandler"];
					_keysHooked = true;
				};
		 		_unitsNearby = player nearEntities ["Land", _zeusLos];
				_unitsFar = [];

				//BLUFOR FOW
				if (playerSide == west) then
				{
					{
						if (_x isKindOf "Land_TTowerBig_2_F") then { _unitsNearby = _unitsNearby + _x nearEntities ["Land", _zeusLos*2.5];};
					} forEach curatorEditableObjects b_zeus ;
					//_unitsFar = _unitsFar + (player nearEntities [INDFOR_HQ_UNIT,25000]);
					_unitsFar = _unitsFar + (allMissionObjects INDFOR_HQ_UNIT);
				};

				/*INDFOR FOW
				if (playerSide == resistance) then
				{
					{
						if (side _x == civilian && alive _x) then { _unitsNearby = _unitsNearby + nearestObjects [_x, ["Land"], _unitLos];};
					} forEach curatorEditableObjects i_zeus ;
				};*/
				//build list of units to hide
				{
					if ((side _x) == playerSide) then
					{
						if (_x isKindOf "Air") then {_unitLos = ZEUS_PLAYER_LOS} else { _unitLos = ZEUS_MINION_LOS};
						_unitsNearby = _unitsNearby + (_x nearEntities ["Land", _unitLos]);
					};
					if (vehicle _x isKindOf "Land" && side _x == _enemy) then
					{
						_unitsFar = _unitsFar + [_x];
					}
				} forEach allUnits;

				 _unitsFar = _unitsFar - _unitsNearby;
				{
					vehicle _x hideObject true;
				} forEach _unitsFar;
				{
					vehicle _x hideObject false;
				} forEach _unitsNearby;
			} else
			{
				_keysHooked = false;
				if (!isnil "_unitsFar") then
				{
					{
						vehicle _x hideObject false;
					} forEach _unitsFar;
					_unitsFar = nil;
				};
			};
			sleep 1;
		};
 	};
};

casePickup = {
	_cases = nearestObjects[getPosATL player,[INDFOR_HQ_UNIT], 5];
	if (count _cases == 0) exitWith {};
	_case = _cases select 0;
	if isNull _case exitWith {};
	if (!(_case getVariable ["active",false]) && ACTIVE_AO_NUM > 0 && CURRENT_NUM_AAF_HQ > 1) exitWith {hintsilent "This HQ is not active, come back later"};
	intelfound = true;
	intelOwner = player;
	intelLocation = getPos _case;


	//Cleanup Intel Marks and get other
	_intelNum = _case getVariable ["intelNum",-1];
	if (_intelNum > 0) then {
		for "_x" from 0 to _intelNum do
		{
			_marker = _case getVariable [format["civ_intel_%1",_x],nil];
			if (!isNil "_marker") then {deleteMarker _marker};
			_markerbg = _case getVariable [format["civ_intelbg_%1",_x],nil];
			if (!isNil "_markerbg") then {deleteMarker _markerbg};
		};
	};

	//Get other Vars from Case
	_hq = _case getVariable "hq";
	_townName = _case getVariable ["town",nil];

	//Delete INDFOR Spawn
	deleteMarker (_case getVariable "respawn");
	//Delete Triggers
	deleteVehicle (_case getVariable "trigger");
	deleteVehicle (_case getVariable "trigger2");
	//Delete case
	deleteVehicle _case;

	//broadcast updates
	publicvariable "intelOwner";
	publicvariable "intelLocation";
	publicvariable "intelfound";
	if (ACTIVE_AO_NUM > 0) then {[nil, "sv_updateActiveHQs", false, false] spawn BIS_fnc_MP};
	if (!isNil "_townName") then {[[_townName], "cl_lostHQ", resistance, false] spawn BIS_fnc_MP};
	[nil, "pickupIntel", west, false] spawn BIS_fnc_MP;
	[nil, 'zeusTracking', false, false] spawn BIS_fnc_MP;
	[nil, "updateHQCount", false, false] spawn BIS_fnc_MP;
};