//onLoad = "[_this, 'onLoad'] ExecVM 'GUI\GUI_Vote.sqf'";
if (_this select 1 == 'onLoad') then
{
	_isAdmin = serverCommandAvailable "#kick";
	ctrlEnable [1605, _isAdmin];
	ctrlEnable [1606, _isAdmin];
	if (player getVariable ["voted",false]) then
	{
		hintSilent "You have voted recently";
		ctrlEnable [1600, false];
	};
	_playerOfficers = missionnamespace getvariable ["playerOfficers",[]];
	_playerCOs = missionnamespace getvariable ["playerCOs",[]];
	_isCO = (player in _playerCOs);
	_isOfficer = (player in _playerCOs + _playerOfficers);
	ctrlEnable [1601, (_isCO && !SINGLE_CO_MODE)];
	ctrlEnable [1604, _isOfficer];
	if (side player == resistance) then {ctrlEnable [1601, false]};

	// Show CO, Players and Officers
	_coText = "";
	_y = 0;
	{
		if (playerSide == side _x) then
		{
			if (_y == 0) then {_coText = name _x; _y = _y+1;} else {_coText = ", "+ name _x };
		};
	} foreach _playerCOs;
	ctrlSetText [1002, _coText];
	{
		if (playerSide == side _x ) then
		{
			_zeus = _x getVariable ["zeus",objNull];
			if (_x in _playerOfficers && !isNull _zeus) then
			{
				//lbSetData [1501, _index, netId _x]; //set data
				_name = name _x;
				_text = format["%1: %2",name _x,_x getVariable ["role", ""]];
				_index = lbAdd [1501, _text]; //create item
			} else {
				_index = lbAdd [1500, name _x]; //create item
				//lbSetData [1500, _index, netId _x]; //set data
				_name = name _x;
				missionNamespace setVariable [_name, _x];
				lbSetData [1500, _index, _name]; //set data
			};
		};
	} foreach playableUnits;
};

if (_this select 1 == 'vote') then
{
	//_objNetID = lbData [1500, lbCurSel 1500]; //string
	//_obj = objectFromNetId _objNetID;
	_objString = lbData [1500, lbCurSel 1500]; //string
    _obj = missionNamespace getVariable [_objString, objNull];
	player setVariable ["voted", true];
	_votes = _obj getVariable ["votes",0];
	_votes = _votes + 1;
	_obj setVariable ["votes", _votes, true];
	//hint format["%1: %2",name _obj,_votes];
	hint format["Your vote for %1 has been cast",name _obj];
	closeDialog 1;
};

if (_this select 1 == 'appointXO' && !SINGLE_CO_MODE) then
{
	//_objNetID = lbData [1500, lbCurSel 1500]; //string
	//_obj = objectFromNetId _objNetID;
	// TODO - Add role selection in future builds
	_objString = lbData [1500, lbCurSel 1500]; //string
    _obj = missionNamespace getVariable [_objString, objNull];
	if(!isNull _obj) then {
		[[1,_obj], "xoAppoint", true, false] spawn BIS_fnc_MP;
		hint format["You have appointed %1 as an Officer",name _obj];
		closeDialog 1;
	};
};

if (_this select 1 == 'resign') then
{
	[[player], "coresign", true, false] spawn BIS_fnc_MP;
	if (DEF_PLAYER_SIDE == resistance) then {player setdamage 1; sleep 1; player removeAllMPEventHandlers "mpkilled";};
	closeDialog 1;
};