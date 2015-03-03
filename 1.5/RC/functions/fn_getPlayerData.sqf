/*
	File: fn_getPlayerData.sqf
	Author: Nashable (@m_nash)

	Description:
	Gets all the Roll Call data for a specific player
	returns array
*/
_unit = _this select 0;
_array = objNull;
if (!isNil "_unit") then {
	if ((_unit getVariable ["rollcall_version",-1]) == RC_DATA_VERSION) then
	{
		_pname = name _unit;
		_xp = _unit getVariable "rollcall_xp";
		_pref = _unit getVariable "rollcall_pref";
		_mic = _unit getVariable "rollcall_hasMic";
		_rank = _unit getVariable "rollcall_rank";
		_array = [_pname,_xp,_pref,_mic,_rank];
	};
};
_array