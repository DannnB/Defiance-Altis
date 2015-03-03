remoteZeusUnitDelete = {
	_zeus = _this select 0;
	_unit = _this select 1;
	//_cost = ([typeOf _unit,false,0] call BIS_fnc_registerCuratorObject) select 0;
	_cost = 0;
	if (_unit isKindOf "Man") then {deleteVehicle _unit}
	else {
		{
		 	deleteVehicle _x;
		} forEach crew _unit;
	};
	[_zeus,format ["Maximum Unit Limit Of %1 Reached",MAX_UNITS]] call BIS_fnc_showCuratorFeedbackMessage;
	_zeus addCuratorPoints _cost;
};

updateHQCount = {
	if (isNil "aafHQSpawnPos") then {aafHQSpawnPos = getMarkerPos "respawn_west"};
	//CURRENT_NUM_AAF_HQ = count (aafHQSpawnPos nearEntities [INDFOR_HQ_UNIT, RAD_AAF_HQ+1000]);
	CURRENT_NUM_AAF_HQ = count (allMissionObjects INDFOR_HQ_UNIT);
	publicvariable "CURRENT_NUM_AAF_HQ";
	if (ALLOW_SAVING) then {saveGame};
};

updateTicketCount = {
	_side = _this select 0;
	_value = _this select 1;
	_tickets = [_side,_value] call BIS_fnc_respawnTickets;
};

hideinHouse = {
	private ["_obj","_radius","_minBuildingPos","_randomPos","_houseArray","_houseNumber","_x","_house","_y"];

	_obj = _this select 0;
	_radius = _this select 1;
	_minBuildingPos = _this select 2;
	_intelIndex = _this select 3;
	_randomPos = [(getpos _obj select 0) + _radius*0.5 - (random _radius), (getpos _obj select 1) + _radius*0.5 - (random _radius), 0];
	_houseArray = nearestObjects [_randomPos, ["House"], _radius];

	//sleep 1;

	_houseNumber = count _houseArray;

	_x = 0;

	while {_x <= _houseNumber} do
	{
		_house = _houseArray select _x;
		waitUntil {! isNil "_house"};
		if (format ["%1", _house buildingPos _minBuildingPos] != "[0,0,0]") exitWith {_y = 0; while { format ["%1", _house buildingPos _y] != "[0,0,0]" } do {_y = _y + 1}; _y = _y - 1; _obj setPos (_house buildingpos (ceil random _y));};
		_x = _x +1;
		//sleep 0.1;
	};
	if (_intelIndex > -1) then {[_obj,_intelIndex] call setUpIntel;};
};


voteForCOServer = {
	private ["_voteSide","_voteTime","_oldCommander","_newCommander","_allCandidates","_winningVotes"];
	_voteSide = _this select 0;
	_voteTime = _this select 1;
	_oldCommander = _this select 2;
	_newCommander = objNull;
	_allCandidates = [];
	_winningVotes = 0;

	//Clean Voting from previous vote
	{
		if (_voteSide == side _x) then
		{
			_x setVariable ["votes", 0, true]; // wipe their votes
			_x setVariable ["voted", false, true]; // Allow them to vote again
		};
	} foreach playableUnits;

	[[_voteSide,_voteTime], "voteForCOClient", _voteSide, false] spawn BIS_fnc_MP;

	sleep _voteTime;
	{
		if (_voteSide == side _x) then
		{
			_votes = _x getVariable ["votes",0];
			//hint format["%1: %2",name _x,_votes];
			if (_votes > _winningVotes) then {_newCommander = _x; _winningVotes = _votes };
			_allCandidates = _allCandidates + [_x]; // Just in case we need to select someone at random
			//sleep 2;
		};
	} foreach playableUnits;

	//deal with nobody got a vote edge case
	if  (isNull _newCommander) then {_newCommander = _allCandidates select floor (random(count _allCandidates)) };
	//Do we have a legit new commander selected
	if (!isnil "_newCommander") then {
		 if(!isNull _newCommander) then {
			_WinnersName = name _newCommander;
			//Announce Winner
			[[_voteSide,_WinnersName,_winningVotes], "coVoteResult", _voteSide, false] spawn BIS_fnc_MP;

			//[_voteSide,"hq"] sidechat format ["%1 has been promoted to Commander with %2 votes",_WinnersName,_winningVotes];

			//Change Zeus
			["update",_newCommander,0] spawn updateZeus;
		};
	};
	voteinprogress = false;
};

sv_findPlayer = {
   private ["_player"];
   _player = objNull;
   {
     if (getPlayerUID _x == _this) exitWith {
          _player = _x;
     };
   } forEach playableUnits;
   _player; // return _player
};

sv_onConnected =
{
	_uid = _this select 1;
	_name = _this select 2;
	//Check to make sure player isn't black listed for TKing
	//systemChat (format ["Checking %2 (%1)", _uid, _name]);
	//Add TK Checker
	//systemChat str(TK_PLAYERUIDS);
	//TK check
	_side = civilian;
	_player = objNull;
	if (_uid in TK_PLAYERUIDS) then
	{
		_timeout = time + 300;
		while {!(_side in [west,resistance]) && (time < _timeout)} do
		{
		    if (isNull _player) then {_player = _uid call sv_findPlayer};
		    if (!isNull _player) then {_side = side _player};
		    sleep 1;
		};
		_timeout = time + 300;
		waitUntil {sleep 1;alive (_uid call sv_findPlayer) || time > _timeout};
		[[_uid,_name,3], "cmn_TeamKiller", true, false] spawn BIS_fnc_MP;

	} else
	{

		// Check Side
		_timeout = time + 60;
		while {!(_side in [west,resistance]) && (time < _timeout)} do
		{
		    if (isNull _player) then {_player = _uid call sv_findPlayer};
		    if (!isNull _player) then {_side = side _player};
		    sleep 1;
		};
		//systemChat str(_side);
		switch (_side) do
		{
		    case west:
		    {
		    	//systemChat str(INDFOR_PLAYERUIDS);
		    	if !(_uid in INDFOR_PLAYERUIDS) then
		    	{
		    		if !(_uid in BLUFOR_PLAYERUIDS) then {BLUFOR_PLAYERUIDS set [count BLUFOR_PLAYERUIDS,_uid]};
		    	} else
		    	{
		    		_timeout = time + 300;
		     		waitUntil {sleep 1;alive (_uid call sv_findPlayer) || time > _timeout};
		     		//systemChat (format ["%2 (%1) Kick due to being Locked", _uid, _name]);
		    		[[_uid,_name,resistance], "cmn_TeamLocked", true, false] spawn BIS_fnc_MP;
		    	};
		    	//systemChat (format ["Set as BLUFOR %2 (%1)", _uid, _name]);
		    };

			case resistance:
		    {
		    	//systemChat str(BLUFOR_PLAYERUIDS);
		    	if (!(_uid in BLUFOR_PLAYERUIDS) || playersNumber resistance <= 1) then
		    	{
			    	if (INDFOR_TEAM_STACK_RATIO > 0) then
					{
						if ((playersNumber west)/INDFOR_TEAM_STACK_RATIO >= playersNumber resistance || playersNumber resistance <= 1) then {
							// The ratio is correct and we can lock in the INDFOR Player
							if !(_uid in INDFOR_PLAYERUIDS) then
							{
								INDFOR_PLAYERUIDS set [count INDFOR_PLAYERUIDS,_uid];
								BLUFOR_PLAYERUIDS = BLUFOR_PLAYERUIDS - [_uid];
							};
						};
					} else { // no ratio so lock them in right away
			    		if !(_uid in INDFOR_PLAYERUIDS) then { INDFOR_PLAYERUIDS set [count INDFOR_PLAYERUIDS,_uid]};
					};
					//systemChat (format ["Set as INDFOR %2 (%1)", _uid, _name]);
				} else {
					_timeout = time + 300;
		     		waitUntil {sleep 1;alive (_uid call sv_findPlayer) || time > _timeout};
		     		//systemChat (format ["%2 (%1) Kick due to being Locked", _uid, _name]);
					[[_uid,_name,west], "cmn_TeamLocked", true, false] spawn BIS_fnc_MP;
				};
			};

		    default
		    {
		     	// Kick the player as we can't pull their role.
		     	_timeout = time + 60;
		     	waitUntil {sleep 1;alive (_uid call sv_findPlayer) || time > _timeout};
		     	[[_uid], "cmn_cannotConnect", true, false] spawn BIS_fnc_MP;
		     	//systemChat (format ["%2 (%1) Ended up as Default", _uid, _name]);
		    };
		}; // End Switch
	}; // end TK Check
};

sv_handleTKer = {
	private ["_TKuid"];
	_TKuid = _this select 0;
	_TKname = _this select 1;
	if !(isNil "_TKuid") then
	{
		private ["_TKIndex","_lastTime","_warnLevel","_victims"];
		_TKIndex = TK_TRACKING find _TKuid;
		if (_TKIndex >= 0) then
		{
			_lastTime = (TK_TRACKING select (_TKIndex + 1)) select 0;
			_warnLevel = (TK_TRACKING select (_TKIndex + 1)) select 1;
			_victims = (TK_TRACKING select (_TKIndex + 1)) select 2;
		}
		else // new entry
		{
			_lastTime = 0;
			_warnLevel = 0;
			_victims = 0;
		};
		//_lastTime = _teamKiller getVariable ["TK_LastTime",0];
		//_warnLevel = _teamKiller getVariable ["TK_WarnLevel",0];

		_victims = _victims +1;
		if (_lastTime+1 < time) then //First Report
		{
			_warnLevel = _warnLevel+1;
			if (_warnLevel > 2) then
			{
				TK_PLAYERUIDS set [count TK_PLAYERUIDS,_TKuid];
				if (_TKuid in BLUFOR_PLAYERUIDS) then
				{
					if (_TKIndex >=0) then {
						[_TKname,_TKIndex] spawn {
							_TKname = _this select 0;
							_TKIndex = _this select 1;
							sleep 1.5; // wait to see if anyone else reports this TK
							_victims = (TK_TRACKING select (_TKIndex + 1)) select 2; // Update the Victim count
							_tickets = [west,_victims] call BIS_fnc_respawnTickets;
							[[_TKname,_victims], "cmn_RefundTKTickets", west, false] spawn BIS_fnc_MP;
						};
					} else {
						_tickets = [west,_warnLevel] call BIS_fnc_respawnTickets;
					};
				};
			};
			if (_TKIndex >=0) then {
		 		TK_TRACKING set [_TKIndex+1,[time,_warnLevel,_victims]];
	     	}
	     	else
	     	{
	     		_count = count TK_TRACKING;
	     		TK_TRACKING set [_count,_TKuid];
	     		TK_TRACKING set [_count+1,[time,1,1]];
	     	};
			[[_TKuid,_TKname,_warnLevel], "cmn_TeamKiller", true, false] spawn BIS_fnc_MP;
		} else {
			//Multiple Reports
			if (_TKIndex >=0) then
			{
		 		TK_TRACKING set [_TKIndex+1,[time,_warnLevel,_victims]];
	     	};
		};
	};
};

//review for performance
sv_updateActiveHQs = {
	//_allHqs = (getMarkerPos "respawn_west") nearEntities [INDFOR_HQ_UNIT, RAD_AAF_HQ+1000];
	_allHqs = allMissionObjects INDFOR_HQ_UNIT;
	_hqCount = count _allHqs;
	if (_hqCount <= ACTIVE_AO_NUM) then
	{
		//activate them all
		{
			_x setVariable ["active",true,true];
		} forEach _allHqs;
	} else {
		_inactiveHqs = [];
		_activeHQNum = 0;
		{
			if(!(_x getVariable ["active",false])) then {
				_inactiveHqs = _inactiveHqs + [_x];
			}
			else
			{
				_activeHQNum = _activeHQNum + 1;
				_x setVariable ["active",true,true];
			};
		} forEach _allHqs;
		_i = ACTIVE_AO_NUM - _activeHQNum;
		while {_i > 0} do {
			_updatedHQ = _inactiveHqs select (floor (random (count _inactiveHqs)));
			_updatedHQ setVariable ["active",true,true];
			_inactiveHqs = _inactiveHqs - [_updatedHQ];
			_i = _i - 1;
		};
	};
	[nil, "cl_updateActiveHQs", resistance, false] spawn BIS_fnc_MP;
};

sv_kickPlayer = {
	_name = _this select 0;
	serverCommand format["#kick %1",_name];
};

updateZeus = {
	_action = (_this select 0);
	_zeusUnit = (_this select 1);
	_role = (_this select 2);
	if (!isnil "_zeusUnit") then
	{
		if (isServer && !isNull _zeusUnit) then
		{
			voteinprogress = true; // disable voting while we finish updating this zeus
			private ["_zeus","_roleText","_oldZeusUnit"];

			if (_action == "update") then //swap player for another CO
			{
				//[[str(_zeusUnit)], 'def_fnc_debug', true, false] spawn BIS_fnc_MP;
				_zeus = objNull;
				_timeOut = time + 60; // give them 60 seconds to spawn
				waitUntil {(alive _zeusUnit && (side _zeusUnit == west || side _zeusUnit == resistance)) || time > _timeOut};
				//[[str(side _zeusUnit)], 'def_fnc_debug', true, false] spawn BIS_fnc_MP;
				switch (side _zeusUnit) do {
					case resistance:
					{
						_zeus = INDFOR_ZEUS_LOGIC select _role;
						_roleText = INDFOR_ZEUS_ROLETEXT select _role;
					};
					case west:
					{
						_zeus = BLUFOR_ZEUS_LOGIC select _role;
						_roleText = BLUFOR_ZEUS_ROLETEXT select _role;
					};
				};
				//[[str(_zeus)], 'def_fnc_debug', true, false] spawn BIS_fnc_MP;
				if (!isNull _zeusUnit && !isNull _zeus) then
				{
					_oldZeusUnit = getAssignedCuratorUnit _zeus;
					//[[str(_oldZeusUnit)], 'def_fnc_debug', true, false] spawn BIS_fnc_MP;

					if(_role <= ZEUS_CO_MAX_INDEX) then
					{
						//mission specific change
						if (side _zeusUnit == resistance && _oldZeusUnit != _zeusUnit) then {

							_oldZeusUnit removeAllMPEventHandlers "mpkilled";
							// Add the INDFOR Zeus Event Handler
							_zeusUnit addMPEventHandler ["mpkilled","
								[true,_this select 1,zeusBounty] call zeusBountyClaimed;
								zeusBounty = 0;
								"];
						};

						_playerCOs = missionnamespace getvariable ["playerCOs",[]];
						_playerCOs = _playerCOs - [_oldZeusUnit];
						_playerCOs = _playerCOs + [_zeusUnit];
						missionnamespace setvariable ["playerCOs",_playerCOs];
					};
					_playerOfficers = missionnamespace getvariable ["playerOfficers",[]];
					_playerOfficers = _playerOfficers - [_oldZeusUnit];
					_playerOfficers = _playerOfficers + [_zeusUnit];
					missionnamespace setvariable ["playerOfficers",_playerOfficers];

					_zeusUnit setVariable ["role", _roleText,true];
					[_zeusUnit,_role,_zeusUnit] call assignZeusUnitVar;
					if (_oldZeusUnit != _zeusUnit) then {
					 	_oldZeusUnit setVariable ["role", nil,true];
					 	unassignCurator _zeus;
					 };

					_zeusUnit assignCurator _zeus;
				};

			}
			else //remove player without replacement
			{
				_playerOfficers = missionnamespace getvariable ["playerOfficers",[]];
				_playerCOs = missionnamespace getvariable ["playerCOs",[]];

				missionnamespace setvariable ["playerCOs",_playerCOs - [_zeusUnit]];
				missionnamespace setvariable ["playerOfficers",_playerOfficers - [_zeusUnit]];

				_zeusUnit setVariable ["role", "",true];
				[_zeusUnit,_role,objNull] call assignZeusUnitVar;
				_zeus = getAssignedCuratorLogic _zeusUnit;
				unassignCurator _zeus;

			};
			publicVariable "playerOfficers";
			publicVariable "playerCOs";
			voteinprogress = false; // enable voting again
		};
	};
};

assignZeusUnitVar = {
	_zeusUnit = _this select 0;
	_role = _this select 1;
	_newZeusUnit = _this select 2;
	_zeusLogics = [];

	if(_zeusUnit != _newZeusUnit) then { _zeusUnit setVariable ["zeus",objNull,true];};
	switch (side _zeusUnit) do
	{
	    case west:
	    {
	    	_zeusLogics = BLUFOR_ZEUS_LOGIC;
	    };

	    case resistance:
	    {
	     	_zeusLogics = INDFOR_ZEUS_LOGIC;
	    };
	};

	if (!isNull _newZeusUnit) then { _newZeusUnit setVariable ["zeus",_zeusLogics select _role,true]; };
};

setUpIntel = {
	private ["_case"];

	_case = _this select 0;
	_x = _this select 1; //Index used to set up the intel
	_case allowDamage false;

	_trg = createTrigger['EmptyDetector', getPos _case];
	missionNamespace setVariable ["i_edit" + str(_x), _trg];
	_case setVariable ["trigger",_trg,true];
	missionNamespace getVariable ("i_edit" + str(_x)) setTriggerArea[INDFOR_HQ_PLACEMENT_RADIUS,INDFOR_HQ_PLACEMENT_RADIUS,0,false];
	missionNamespace getVariable ("i_edit" + str(_x)) setTriggerActivation["WEST","PRESENT",true];
	//_trg setTriggerArea[INDFOR_HQ_PLACEMENT_RADIUS,INDFOR_HQ_PLACEMENT_RADIUS,0,false];
	//_trg setTriggerActivation['WEST','PRESENT',true];
	call compile format ["i_edit%1 setTriggerStatements['this', 'i_zeus removeCuratorEditingArea %1', 'i_zeus addCuratorEditingArea [%1,getPos i_edit%1,%2]']",_x,INDFOR_HQ_PLACEMENT_RADIUS];

	//Create local INDFOR Player Spawn and trigger
	_marker = createMarker [format["respawn_guerrila%1",_x], getpos _case];
	_case setVariable ["respawn",_marker,true];

	_trg2 = createTrigger['EmptyDetector', getPos _case];
	_trg2 setVariable ["marker", _marker];
	missionNamespace setVariable ["i_spawn" + str(_x), _trg2];
	_case setVariable ["trigger2",_trg2,true];

	missionNamespace getVariable ("i_spawn" + str(_x)) setTriggerArea[INDFOR_HQ_PLACEMENT_RADIUS*0.1,INDFOR_HQ_PLACEMENT_RADIUS*0.1,0,false];
	missionNamespace getVariable ("i_spawn" + str(_x)) setTriggerActivation["WEST","PRESENT",true];
	call compile format ['i_spawn%1 setTriggerStatements["this && {((getPosATL _x) select 2) < 5} count thislist > 0", "deleteMarker ""respawn_guerrila%1""", "_marker = createMarker [""respawn_guerrila%1"",getpos i_spawn%1];"]',_x];


	// Create officer editing area for INDFOR
	i_zeus addCuratorEditingArea [_x,position _case,INDFOR_HQ_PLACEMENT_RADIUS];

	//Add Vars to HQ
	_case setVariable ["hq",_x,true];

	//player setPosAsl getPosAsl _case;
};


zeusTracking = {

	if (isServer) then
	{
		_i_zeusUnit = getAssignedCuratorUnit (INDFOR_ZEUS_LOGIC select 0);
		_marker = createMarker ["hades" + str(time), getPos _i_zeusUnit];
		_marker setMarkerType "n_hq";
		_marker setMarkerColor "ColorRed";
		_marker setMarkerText "Hades";

		_markerbg = createMarker ["hades_bg" + str(time), getPos _i_zeusUnit];
		_markerbg setMarkerShape "ELLIPSE";
		_markerbg setMarkerColor "ColorRed";
		_markerbg setMarkerBrush "FDiagonal";
		_markerbg setMarkerSize [HADES_TRACK_RADIUS, HADES_TRACK_RADIUS];

		//_timerEnd = time + HADES_TRACK_TIME;
		if (zeusTrackingTime < (time-10)) then
		{
			zeusTrackingTime = time + HADES_TRACK_TIME;
		};

		while {zeusTrackingTime > time && (alive _i_zeusUnit)} do
		{
			_posX = (getPos _i_zeusUnit select 0) + (random HADES_TRACK_RADIUS) - (random HADES_TRACK_RADIUS);
			_posY = (getPos _i_zeusUnit select 1) + (random HADES_TRACK_RADIUS) - (random HADES_TRACK_RADIUS);
			_marker setMarkerPos [_posX,_posY];
			_markerbg setMarkerPos [_posX,_posY];
			sleep 5;
		};
		if (alive _i_zeusUnit) then
		{
			_hour = (floor daytime);
			_mins = floor((daytime mod _hour)*60);
			if (_hour < 10) then { _hour = "0" + str(_hour);};
			if (_mins < 10) then { _mins = "0" + str(_mins);};
			_marker setMarkerType "hd_objective";
			_marker setMarkerText format["%1:%2 - Hades Last Spotted",_hour,_mins];
			deleteMarker _markerbg;
		}
		else
		{
			deleteMarker _marker;
			deleteMarker _markerbg;
		};
	};
};

//SPECTATING
serverSpectatorLoop = {
	if(isServer) then {
		//[s_zeus] call BIS_fnc_drawLocations ;
		_unitsWatched = [];
		while {!isNull s_zeusUnit} do
		{
		    _newUnits = allUnits - _unitsWatched;
		    s_zeus addCuratorEditableObjects [_newUnits,true];
		    _unitsWatched = _unitsWatched + _newUnits;
		    sleep 5;
		};
	};
};

send_all_data = {
	private ["_vars","_client"];
	_client = _this select 0;
	_vars = ["b_mhq","playerOfficers","playerCOs","tpw_civ_allcas","civIntelMarkers","CURRENT_NUM_AAF_HQ","b_zeusUpkeep","i_zeusUpkeep","zeusBounty"];
	[nil, "cl_updateActiveHQs", resistance, false] spawn BIS_fnc_MP;
	{
		(owner _client) publicVariableClient _x;
		sleep 0.5;
	} forEach _vars;

};

sv_register_unit_zeus = {
	_unit = _this select 0;
	if (!isNil "_unit") then
	{
		if (side _unit == west) then { b_zeus addCuratorEditableObjects [[_unit],false]; b_atc addCuratorEditableObjects [[_unit],false]; };
		if (side _unit == resistance) then { i_zeus addCuratorEditableObjects [[_unit],false]; };
		s_zeus addCuratorEditableObjects [[_unit],false];
	};
};

//Headless Client Server Side Functions ************
give_group_to_hc = {
	_HC    = _this select 0;
	_list  = _this select 1;

	{
		_x setOwner (owner _HC);
	} forEach _list;
};

//CURATOR FUNCTIONS ********************************

def_fnc_curatorAutomatic =
{
	/*
	Author: Karel Moricky modifed by Mark Nash (Nashable)

	Description:
	Spawn units based on curator settings.
	Used when curator role is not taken.

	Parameter(s):
		0: OBJECT - curator (costs and coefficients will be read from it)
		1: ARRAY of SIDEs - sides of placed units
		2: NUMBER - cheat coefficient (1 means default costs, 0.5 means 50% values; allows spawning of more units)
		3: NUMBER - infantry probability (probabilities are compared together, the ones with higher number have better chance of spawning)
		4: NUMBER - ground vehicles probability
		5: NUMBER - aircrafts probability
		6: NUMBER - marine probability

	Returns:
	ARRAY of GROUPs
	*/

	_curator = [_this,0,objnull,[objnull]] call bis_fnc_param;
	_sides = [_this,1,[],[[]]] call bis_fnc_param;
	_cheatCoef = [_this,2,1,[0]] call bis_fnc_param;

	if (count _sides == 0) exitwith {["No sides defined"] call bis_fcn_error;};

	_ratioInfantry = [_this,3,1,[1]] call bis_fnc_param;
	_ratioGround = [_this,4,1,[1]] call bis_fnc_param;
	_ratioAir = [_this,5,1,[1]] call bis_fnc_param;
	_ratioWater = [_this,6,1,[1]] call bis_fnc_param;
	_weights = [_ratioInfantry,_ratioGround,_ratioAir,_ratioWater];

	//////////////////////////////////////////////////////////////////////////////////

	//--- Spawn AI enemies
	_addons = curatoraddons _curator;
	_areas = curatoreditingarea _curator;
	_coef = _curator curatorCoef "place";

	if (count _areas < 1)  exitwith {};

	//--- Calculate area weights

	_areaWeightValues = [];
	_areaWeightSum = 0;
	{
		//_xId = format ["%1_%2",_curator,_x select 0];
		/*_xPos = _x select 0;
		_xSize = _x select 1;*/
		_xid = _x select 0;
		_xPos = _x select 1;
		_xSize = _x select 2;

		_positions = [_xId,_xPos,_xSize] call bis_fnc_curatorAutomaticPositions;
		_xWeight = (
			(count (_positions select 0) max 0 min 1) * (_weights select 0) +
			(count (_positions select 1) max 0 min 1) * (_weights select 1) +
			(count (_positions select 2) max 0 min 1) * (_weights select 2) +
			(count (_positions select 3) max 0 min 1) * (_weights select 3)
		);

		_areaWeightValues set [_foreachindex,_xWeight];
		_areaWeightSum = _areaWeightSum + _xWeight;
	} foreach _areas;

	_units = [];
	{
		_xUnits = getarray (configfile >> "cfgpatches" >> _x >> "units");
		{
			_unit = tolower _x;
			if !(_unit in _units) then {_units set [count _units,_unit];};
		} foreach _xUnits;
	} foreach _addons;

	if (count _units == 0) exitwith {};

	//--- Find placeable groups
	_sideIDs = [];
	{
		_sideIDs set [count _sideIDs,_x call bis_fnc_sideID];
	} foreach _sides;


	//////////////////////////////////////////////////////////////////////////////////
	//--- Calculate unit cost
	_costs = [_curator,_units] call bis_fnc_curatorObjectRegistered;
	_enabledUnits = [];
	_enabledUnitCosts = [];

	_vehiclesGround = [];
	_vehiclesAir = [];
	_vehiclesWater = [];
	{
		_result = _costs select _foreachindex;
		_enabled = [_result,0,false,[false]] call bis_fnc_paramin;

		if (_enabled) then {
			_cost = [_result,1,0,[0]] call bis_fnc_paramin;
			_cost = _cost * _cheatCoef;
			_enabledUnits set [count _enabledUnits,tolower _x];
			_enabledUnitCosts set [count _enabledUnitCosts,_cost];

			//--- Register vehicles separately
			_simulation = tolower gettext (configfile >> "cfgvehicles" >> _x >> "simulation");
			_side = getnumber (configfile >> "cfgvehicles" >> _x >> "side");
			if (
				_simulation in ["airplanex","carx","helicopterx","airplanex","shipx","submarinex","tankx"]
				&&
				!(_x iskindof "StaticWeapon")
				&&
				_side in _sideIDs
			) then {

				scopename "bis_fnc_systemcurator_vehicle";

				_armed = false;
				{
					{
						_weaponSimulation = gettext (configfile >> "cfgweapons" >> _x >> "simulation");
						_weaponMagazines = getarray (configfile >> "cfgweapons" >> _x >> "magazines");
						if (_weaponSimulation == "weapon" && count _weaponMagazines > 0) then {
							_armed = true;
							breakto "bis_fnc_systemcurator_vehicle";
						};
					} foreach (getarray (_x >> "weapons"));
				} foreach (_x call bis_fnc_getturrets);

				if (_armed) then {
					_cost = [_result,2,_cost,[0]] call bis_fnc_paramin;
					_side = getnumber (configfile >> "cfgvehicles" >> _x >> "side") call bis_fnc_sidetype;
					_vehicleArray = [tolower _x,_cost * _cheatCoef,_side];
					switch _simulation do {
						case "airplanex";
						case "helicopterx": {
							_vehiclesAir set [count _vehiclesAir,_vehicleArray];
						};
						case "carx";
						case "tankx": {
							_vehiclesGround set [count _vehiclesGround,_vehicleArray];
						};
						case "shipx";
						case "submarinex": {
							_vehiclesWater set [count _vehiclesWater,_vehicleArray];
						};
					};
				};
			};
		};
	} foreach _units;

	//////////////////////////////////////////////////////////////////////////////////
	//--- Calculate groups

	_groupsInfantry = [];
	_groupsGround = [];
	_groupsAir = [];
	_groupsWater = [];

	//--- ToDo: Load in MP type init and save into mission logic. Calculcate only cost here.

	_groupClasses = missionnamespace getvariable "BIS_fnc_curatorAutomatic_groupClasses";
	if (isnil {_groupClasses}) then {
		_groupClasses = [configfile >> "cfgGroups",3,false] call bis_fnc_returnChildren;
		missionnamespace setvariable ["BIS_fnc_curatorAutomatic_groupClasses",_groupClasses];
	};

	{
		_side = [_x,"side",-1] call bis_fnc_returnconfigentry;
		if (_side in _sideIDs) then {

			//--- Units
			_cost = 0;
			_enabled = true;
			_simulations = [];
			{
				_vehicle = tolower gettext (_x >> "vehicle");
				_vehicleID = _enabledUnits find _vehicle;
				if (_vehicleID < 0) exitwith {_enabled = false;};

				_cost = _cost + (_enabledUnitCosts select _vehicleID);
				_simulation = tolower gettext (configfile >> "cfgvehicles" >> _vehicle >> "simulation");
				if !(_simulation in _simulations) then {_simulations set [count _simulations,_simulation];};
			} foreach (_x call bis_fnc_returnChildren);

			if (_enabled) then {
				_groups = switch true do {
					case ("airplanex" in _simulations);
					case ("helicopterx" in _simulations): {_groupsAir};

					case ("carx" in _simulations);
					case ("tankx" in _simulations): {_groupsGround};

					case ("shipx" in _simulations);
					case ("submarinex" in _simulations): {_groupsWater};

					default {_groupsInfantry};
				};
				_groups set [count _groups,[_x,_cost,_side call bis_fnc_sidetype]];
			};
		};
	} foreach _groupClasses;

	_removeExpensive = {
		{
			_xCost = _x select 1;
			if ((_points + _xCost * _coef) < ((_areaPoints - _areaPointsLimit) max 0)) then {
				_this set [_foreachindex,objnull];
			};
		} foreach _this;
		_this = _this - [objnull];
		_this
	};
	_spawnGroup = {
		_spawnGroupWeights = [];
		{_spawnGroupWeights set [_foreachindex,_x select 1];} foreach (_this select 1);
		_pos = (_this select 0) call bis_fnc_selectrandom;
		_groupArray = [_this select 1,_spawnGroupWeights] call bis_fnc_selectrandomweighted;
		_type = _groupArray select 0;
		_cost = _groupArray select 1;
		_side = _groupArray select 2;
		if (typename _pos == typename objnull) then {_pos = position _pos;};
		["Group %1 created",configname _type] call bis_fnc_logFormat;
		[_pos,_side,_type] call bis_fnc_spawnGroup;
	};
	_spawnVehicle = {
		_spawnVehicleWeights = [];
		{_spawnVehicleWeights set [_foreachindex,_x select 1];} foreach (_this select 1);
		_pos = (_this select 0) call bis_fnc_selectrandom;
		_vehicleArray = [_this select 1,_spawnVehicleWeights] call bis_fnc_selectrandomweighted;
		_type = _vehicleArray select 0;
		_cost = _vehicleArray select 1;
		_side = _vehicleArray select 2;
		_dir = 0;
		if (typename _pos == typename objnull) then {
			//--- Road position
			_dir = direction _pos;
			_pos = position _pos;
		} else {
			if (typename (_pos select 0) == (typename [])) then {_pos = _pos select 0;}; //--- Converts from selectBestPlaces format
		};
		["Vehicle %1 created",_type] call bis_fnc_logFormat;
		_vehicle = createvehicle [_type,_pos,[],0,"none"];
		_vehicle setdir _dir;
		_group = creategroup _side;
		[_vehicle,_group] call bis_fnc_spawnCrew;
		_group
	};

	_pointsStart = curatorpoints _curator;
	_areaPointsLimit = _pointsStart; // (count _areas);
	private ["_spawnedGroups"];
	_spawnedGroups = [];
	_allTotal = 0;
	_areaCount = count _areas;
	for "_y" from 0 to _areaCount do
	{
		_index = (floor random (_areaCount));
		_area = _areas select _index;
		/*_areaPos = _area select 0;
		_areaSize = _area select 1;*/
		_areaId = _area select 0;

		_areaPos = _area select 1;
		_areaSize = _area select 2;
		//Check HQ is active.
		//private ["_hq"];
		_hq = (_areaPos nearEntities [INDFOR_HQ_UNIT, _areaSize+100]) select 0;
		if (isnil "_hq") exitwith {};
		if (ACTIVE_AO_NUM < 1 || _hq getVariable ["active",true] || (_areaCount < CURRENT_NUM_AAF_HQ)) then
		{
			_areaWeight = (_areaWeightValues select _index) / _areaWeightSum;
			_areaPoints = curatorpoints _curator;
			//_areaPointsLimit = _pointsStart * _areaWeight;
			_areaWeights = +_weights;
			//_xId = format ["%1_%2",_curator,_areaId];
			_xid = _index;
			_positions = [_xId, _areaPos,_areaSize] call bis_fnc_curatorAutomaticPositions;
			_positionsInfantry = _positions select 0;
			_positionsGround = _positions select 1;
			_positionsAir = _positions select 2;
			_positionsWater = _positions select 3;

			_groupsInfantryLocal = +_groupsInfantry;
			_groupsGroundLocal = +_groupsGround;
			_groupsAirLocal = +_groupsAir;
			_groupsWaterLocal = +_groupsWater;
			_vehiclesGroundLocal = +_vehiclesGround;
			_vehiclesAirLocal = +_vehiclesAir;
			_vehiclesWaterLocal = +_vehiclesWater;

			_points = curatorpoints _curator;

			//--- Remove expensive items
			_groupsInfantryLocal = _groupsInfantryLocal call _removeExpensive;
			_groupsGroundLocal = _groupsGroundLocal call _removeExpensive;
			_groupsAirLocal = _groupsAirLocal call _removeExpensive;
			_groupsWaterLocal = _groupsWaterLocal call _removeExpensive;
			_vehiclesGroundLocal = _vehiclesGroundLocal call _removeExpensive;
			_vehiclesAirLocal = _vehiclesAirLocal call _removeExpensive;
			_vehiclesWaterLocal = _vehiclesWaterLocal call _removeExpensive;

			_allGroups = _groupsInfantryLocal + _groupsGroundLocal + _groupsAirLocal + _groupsWaterLocal;
			_allVehicles = _vehiclesGroundLocal + _vehiclesAirLocal + _vehiclesWaterLocal;

			_allCount = count (_allGroups + _allVehicles);

			if (_allCount > 0) then
			{

				_cost = 0;

				//--- Eliminate unsuitable types (e.g., no water vehicles when the area is landlocked)
				_coefs = [
					((count _positionsInfantry) * (count _groupsInfantryLocal)) min 1,
					((count _positionsGround) * ((count _groupsGroundLocal) + (count _vehiclesGroundLocal))) min 1,
					((count _positionsAir) * ((count _groupsAirLocal) + (count _vehiclesAirLocal))) min 1,
					((count _positionsWater) * ((count _groupsWaterLocal) + (count _vehiclesWaterLocal))) min 1
				];
				{
					_areaWeights set [_foreachindex,_x * (_coefs select _foreachindex)];
				} foreach _areaWeights;
				if (_areaWeights call bis_fnc_magnitudesqr == 0) exitwith {_allCount = 0;};

				_type = [[0,1,2,3],_areaWeights] call bis_fnc_selectrandomweighted;
				_group = switch (_type) do {
					//--- Infantry
					case 0: {
						[_positionsInfantry,_groupsInfantryLocal] call _spawnGroup
					};
					//--- Ground
					case 1: {
						if (random 1 > 0.5 && count _vehiclesGroundLocal > 0 || count _groupsGroundLocal == 0) then {
							[_positionsGround,_vehiclesGroundLocal] call _spawnVehicle
						} else {
							[_positionsGround,_groupsGroundLocal] call _spawnGroup
						};
					};
					//--- Air
					case 2: {
						if (random 1 > 0.5 && count _vehiclesAirLocal > 0 || count _groupsAirLocal == 0) then {
							[_positionsAir,_vehiclesAirLocal] call _spawnVehicle
						} else {
							[_positionsAir,_groupsAirLocal] call _spawnGroup
						};
					};
					//--- Water
					case 3: {
						if (random 1 > 0.5 && count _vehiclesWater > 0 || count _groupsWaterLocal == 0) then {
							[_positionsWater,_vehiclesWaterLocal] call _spawnVehicle
						} else {
							[_positionsWater,_groupsWaterLocal] call _spawnGroup
						};
					};
					//--- Nothing
					default {
						"NULL" call bis_fnc_log;
						grpnull
					};
				};
				_spawnedGroups set [count _spawnedGroups,_group];

				//--- Mark as automatic
				_group setvariable ["BIS_fnc_curatorAutomatic",true,true];
				_group setvariable ["BIS_fnc_curatorAutomatic_area",_area];

				//IF HC is present, switch these units over to HC.
				if (HCPresent) then
				{
					{
						_X setowner (owner HCUnit);
					} forEach units _group;
				};

				if ((random 100 < HADES_AI_ATTACK_CHANCE || _areaCount < CURRENT_NUM_AAF_HQ) && !(vehicle (units _group select 0) isKindOf "Man") ) then
				{
					if (!isNull b_mhq) then
					{
						if (alive b_mhq) then
						{
							_wp = _group addWaypoint [position b_mhq, 0];
							_wp	waypointAttachVehicle b_mhq;
							_wp setWaypointType "DESTROY";
							_wp setWaypointBehaviour "COMBAT";
						};
					};
					_wp = _group addWaypoint [getMarkerPos "respawn_west", 0];
					_wp setWaypointBehaviour "AWARE";
					_wp setWaypointType "MOVE";

					_wp = _group addWaypoint [getMarkerPos "respawn_west", 0];
					_wp setWaypointBehaviour "COMBAT";
					_wp setWaypointType "SAD";

					//delete
					_wp = _group addWaypoint [getPos leader _group, 0];
					_wp setWaypointBehaviour "SAFE";
					_wp setWaypointType "MOVE";
					_wp setWaypointStatements ["true", "{deleteVehicle _x} foreach thislist;deleteGroup (group this)"];
				};

				//--- Execute scripted event handler on every group member
				[_curator,"curatorGroupPlaced",[_curator,_group]] call bis_fnc_callScriptedEventHandler;
				{
					[_curator,"curatorObjectPlaced",[_curator,_x]] call bis_fnc_callScriptedEventHandler;
				} foreach units _group;

				_curator addcuratoreditableobjects [units _group,true];
				_curator addcuratorpoints (_cost * _coef);
			};
			_allTotal = _allTotal + _allCount;
		};
	} foreach _areas;

	if (_allTotal == 0) then {
		_curator addcuratorpoints -1;
	};
_spawnedGroups
};
