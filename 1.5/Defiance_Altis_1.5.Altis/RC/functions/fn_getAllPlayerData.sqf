/*
	File: fn_getAllPlayerData.sqf
	Author: Nashable (@m_nash)

	Description:
	Gets all the player data
	returns array
*/
if (isNil "RC_SIDES") then {RC_SIDES = [playerSide]};
_array = [];
_sort = uiNamespace getVariable ["ROLCALL_XP_SORT",0];
private ["_algorithm"];
switch (_sort) do
{
    case 0: //Rank
    {
    	_algorithm = {0-(_x select 4)};
    };
    case 1: //Side
    {
    	_algorithm = {(([_x select 5] call BIS_fnc_sideID)*100)-(_x select 4)};
    };
    case 2: //Mic
    {
    	_algorithm = {if (_x select 3) then {0-(_x select 4)} else {100-(_x select 4)};};
    };
    case 3: //Pref Role
    {
    	_algorithm = {((_x select 2)*100)-(_x select 4)};
    };

    default // a specific role was chosen, offset is 4
    {
     	if (_sort >= 4) then
     	{
     		_algorithm = {0-(((_x select 1) select (_input0-4))*100)-(_x select 4)};
     	} else
     	{
			_algorithm = {0-(_x select 4)};
			systemChat "ROLL CALL: There was an issue sorting player data. Defaulted to sort by Rank";
     	};
    };
};


{
	//_side = side _x;
	//if (_side in RC_SIDES && isPlayer _x) then
	if (isPlayer _x) then
	{
		if ((_x getVariable ["rollcall_version",-1]) == RC_DATA_VERSION) then
		{
			_pname = name _x;
			_xp = _x getVariable "rollcall_xp";
			_pref = _x getVariable "rollcall_pref";
			_mic = _x getVariable "rollcall_hasMic";
			_rank = _x getVariable "rollcall_rank";
			_side = side _x;
            if ((!(isNil "_pname" && isNil "_xp"  && isNil "_pref"  && isNil "_mic"  && isNil "_rank"  && isNil "_side")) && (_pname != "Game Logic")) then
            {
                _array set [_foreachindex,[_pname,_xp,_pref,_mic,_rank,_side]];
            };
		};
	};
} forEach playableUnits;
//_array = [_array,[],_algorithm,"ASCEND"] call BIS_fnc_sortBy;
//systemChat format ["%1 | %2 | %3", _sort, _algorithm,_array];
_array = [_array,[_sort],_algorithm,"ASCEND"] call BIS_fnc_sortBy;
//systemChat format ["DEBUG (fn_getPlayerData): %1", _array];
_array