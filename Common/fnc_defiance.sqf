//Functions
def_fnc_debug = {
	_message = _this select 0;
	systemchat str(_message);
	diag_log _message;
};

createLocalPersistentMarker = {
	_pos = _this select 0;
	_type = _this select 1;
	_text = _this select 2;
	_color = _this select 3;

	if(!isDedicated) then {
		_marker = createMarkerLocal ["local_"+str(time)+str(random 1000),_pos];
		if (!isNil "_text") then {_marker setMarkerTextLocal _text};
		if (!isNil "_type") then {_marker setMarkerTypeLocal _type};
		if (!isNil "_color") then {_marker setMarkerColorLocal _color};
	};
};

resetOfficers = {
	_isadmin = _this select 0;
	if (!_isadmin || isNil "_isAdmin") exitWith {};
	systemchat "An admin has reset all Zeus players and leaders. Votes will begin shortly.";
	if (isServer) then {
		{
			unassignCurator _x;
		} forEach (BLUFOR_ZEUS_LOGIC + INDFOR_ZEUS_LOGIC);
		playerCOs = [];
		playerOfficers = [];
		publicvariable "playerCos";
		publicvariable "playerOfficers";
		{
			[_x,nil,objNull] call assignZeusUnitVar ;
		} forEach playableUnits;
		voteinprogress = false;
	};
};

cmn_resetTeams = {
	_isadmin = _this select 0;
	if (!_isadmin || isNil "_isAdmin") exitWith {};
	systemchat "An admin has unlocked teams and forgiven the teamkills of all players. You will be locked to a team the next time you connect.";
	if (isServer) then {
		//Reset Player Cheating/TKing
		BLUFOR_PLAYERUIDS = [];
		INDFOR_PLAYERUIDS = [];
		TK_PLAYERUIDS = [];
		TK_TRACKING = [];
	};
};


civDeathPenalty = {
	_side = _this select 0;
	_zeusUpKeep = 1;
	_zeusUpKeepBase = 1;
	switch (_side) do
	{
	    case west:
	    {
	    	_zeusUpKeepBase = BLUFOR_ZEUS_UPKEEP_BASE;
	    	_zeusUpkeepModifier = b_zeusUpKeep*CIV_DEATH_PEN_AMOUNT;
	    	_zeusUpKeep = b_zeusUpKeep-_zeusUpkeepModifier;
	    	publicvariable "b_zeusUpkeep";
	    	[[_side,UPKEEP_MSG_TEMPLATES select 1,b_zeusUpKeep,BLUFOR_ZEUS_UPKEEP_BASE,bluforTick], "upKeepAnnounce", _side, false] spawn BIS_fnc_MP;
	    	[] spawn {
	    		sleep CIV_DEATH_PEN_TIME;
	    		b_zeusUpKeep = _zeusUpKeep+_zeusUpkeepModifier;
	    		publicvariable "b_zeusUpkeep";
	    		[[_side,UPKEEP_MSG_TEMPLATES select 2,b_zeusUpKeep,BLUFOR_ZEUS_UPKEEP_BASE,bluforTick], "upKeepAnnounce", _side, false] spawn BIS_fnc_MP;
	     	};
	    };

	    case resistance:
	    {
	     	_zeusUpKeepBase = INDFOR_ZEUS_UPKEEP_BASE;
	     	_zeusUpkeepModifier = i_zeusUpKeep*CIV_DEATH_PEN_AMOUNT;
	     	_zeusUpKeep = i_zeusUpKeep-_zeusUpkeepModifier;
	     	i_zeusUpKeep = _zeusUpKeep;
	     	publicvariable "i_zeusUpkeep";
	     	[[_side,UPKEEP_MSG_TEMPLATES select 1,i_zeusUpKeep,INDFOR_ZEUS_UPKEEP_BASE,indforTick], "upKeepAnnounce", _side, false] spawn BIS_fnc_MP;
	     	[] spawn {
				sleep CIV_DEATH_PEN_TIME;
		     	i_zeusUpKeep = _zeusUpKeep+_zeusUpkeepModifier;
		     	publicvariable "i_zeusUpkeep";
		     	[[_side,UPKEEP_MSG_TEMPLATES select 2,i_zeusUpKeep,INDFOR_ZEUS_UPKEEP_BASE,indforTick], "upKeepAnnounce", _side, false] spawn BIS_fnc_MP;
	     	};
	    };
	};
};

upKeepAnnounce = {
	_side = _this select 0;
	_template = _this select 1;
	_newUpKeep = _this select 2;
	_baseUpkeep = _this select 3;
	_tick = _this select 4;
	[_side, "hq"] sideChat format[_template,100-((_newUpKeep/_baseUpkeep)*100),_tick,"%"];
};

coVoteResult =
{
	_voteSide = _this select 0;
	_voteWinner = _this select 1;
	_voteResults = _this select 2;
	if (!isNil "_voteWinner") then
	{
		_announcement = format ["%1 has been promoted to Commander with %2",_voteWinner,_voteResults];
		if (_voteResults == 1) then {_announcement = _announcement + " vote"} else {_announcement = _announcement + " votes"};
		[_voteSide,"hq"] sidechat _announcement;
		_faction = [_voteSide] call bis_fnc_sideName;
		["NewCO"+_faction,[_faction,_announcement]] call bis_fnc_showNotification;
		if (!isDedicated) then {ZeusFOWLoop = false;sleep 2;[] spawn cl_zeusFoW};
	};
};

coResign = {
	_player = _this select 0;
	_role = 0;
	_zeusLogics = [];
	[side _player,"hq"] sidechat format ["%1 has resigned from the %2 position",name _player,_player getVariable ["role", "Officer"]];
	if (isServer) then {
	 	switch (side _player) do
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
		_zeus = getAssignedCuratorLogic _player;
		_role = _zeusLogics find _zeus;
	 	if(isServer) then {["remove",_player,objNull,_role] spawn updateZeus};
	 };
};

xoAppoint = {
	_role = _this select 0;
	_player = _this select 1;
	if (isServer) then { ["update",_player,_role] spawn updateZeus;};
	sleep 5;
	[side _player,"hq"] sidechat format ["%1 has been appointed to the position of %2",name _player,_player getVariable ["role", "Officer"]];
};


zeusBountyClaimed = {
	//TODO CLEAN UP
	if (_this select 0) then
	{
		_claimedzeusBounty = _this select 2;
		_zeusBountyHunter = _this select 1;
		if (_zeusBountyHunter isKindOf "Man") then { _zeusBountyHunter = format[" by %1,",name _zeusBountyHunter]; } else { _zeusBountyHunter = "."; };
		if (_claimedzeusBounty > 0) then
		{
			_message = format["Hades was killed%1 NATO has been awarded a bounty of %2 tickets",_zeusBountyHunter,_claimedzeusBounty];
			[west, "hq"] sideChat _message;
			[resistance, "hq"] sideChat _message;
			["HadesDead",[_claimedzeusBounty,_zeusBountyHunter]] call bis_fnc_showNotification;
			if (isServer) then {[west,_claimedzeusBounty] call BIS_fnc_respawnTickets;};
		};
	};
};

cmn_getOrdinal = {
 _value = _this select 0;
 _tenRemainder = _value mod 10;
 _ord = "th";
 switch (_tenRemainder) do
 {
 	case 1:
 	{
   		_ord = "st";
   	};
  	case 2:
  	{
   		_ord = "nd";
   	};
  	case 3:
  	{
   		_ord = "rd";
   	};
  	default
  	{
   		_ord = "th";
   	};
 };
_ord
};

cmn_cannotConnect = {
	_puid = _this select 0;
	_spectator = objNull;
	if (!isNil "s_zeusUnit") then {_spectator = s_zeusUnit};
	if (!isNil "_puid" && getPlayerUID player == _puid && player != _spectator)	 then
	{
		waitUntil { (!isNull player) && alive player };
		sleep 1;
		["COULD_NOT_CONNECT",false,false] call BIS_fnc_endMission;
	};
};

cmn_getPlayerNameFromUID = {
	private ["_puid"];
	_puid = _this select 0;
	{
		if (getPlayerUID _x == _puid) exitWith {name _x};
	} forEach playableUnits;
};

cmn_TeamLocked = {
	_puid = _this select 0;
	_pname = _this select 1;
	_sideLocked = _this select 2;
	systemchat format ["%1 has tried to team switch but is locked to %2 (%3 vs %4)", _pname, [_sideLocked] call bis_fnc_sideName,_puid,getPlayerUID player];
	if (getPlayerUID player == _puid) then
	{
		waitUntil { (!isNull player) && alive player };
		sleep 1;
		["TEAM_SWITCH",false,false] call BIS_fnc_endMission;
	};
};

cmn_TeamKiller = {
	_puid = _this select 0;
	_pname = _this select 1;
	_warnLevel = _this select 2;
	if (isDedicated) then
	{
		_action = "Warn";
		if (_warnLevel > 2) then {_action = "Blacklisted"};
		diag_log format ["%3: %1 (%2) has a TK Level of %4 (%5)", _pname, _puid, time, _warnLevel,_action];
	} else
	{
		private ["_message"];
		if (_warnLevel > 2) then
		{
			_message = format ["Due to excessive team killing %1 has been blacklisted from this round", _pname];
			if (getPlayerUID player == _puid) then
			{
				waitUntil {(!isNull player) && alive player };
				sleep 1;
				["TEAM_KILLER",false,false] call BIS_fnc_endMission;
			};
		} else {
			_message = format ["%1 has been detected as killing members of their own team. This is %1's %2%3 warning. Three warnings will result in Blacklisting.", _pname,_warnLevel, [_warnLevel] call cmn_getOrdinal];
			if (getPlayerUID player == _puid) then
			{
				hintC _message;
			};
		};
		systemchat _message;
	};
};

cmn_KindOfArray = {
	//Checks a unit KindOf against an array
	_unit = _this select 0;
	_array =  _this select 1;
	_return = false;
	_count = count _array;

	if (_count < 1) exitWith {_return = true};

	_y = 0;

	while {!_return && _y < _count} do
	{
	    _return = _unit isKindOf (_array select _y);
	    _y = _y + 1;
	};
	_return
};

cmn_rmv_inactive_Hqs_from_array = {
	_hqs = _this select 0;
	if (ACTIVE_AO_NUM > 0) then {
		_activeHqs = [];
		{
			if (_x getVariable ["active",false]) then
			{
				_activeHqs = _activeHqs + [_x];
			};
		} forEach _hqs;
		_hqs = _activeHqs;
	};
	_hqs
};