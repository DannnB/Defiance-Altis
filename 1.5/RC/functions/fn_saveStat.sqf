/*
	File: fn_saveStat.sqf
	Author: Nashable (@m_nash)

	Description:
	Save a named var to Profile
*/
_varName = _this select 0;
_value = _this select 1;
if (!isNil "_varName" && !isNil "_value") then
{
	//systemChat format ["ROLL CALL: Saving %1 (%2) to Profile", _varName,_value];
	profileNameSpace setVariable [(format ["%1%2", _varName,RC_DATA_VERSION]),_value];
	[_varName,_value] call RC_fnc_broadcastStat;
};