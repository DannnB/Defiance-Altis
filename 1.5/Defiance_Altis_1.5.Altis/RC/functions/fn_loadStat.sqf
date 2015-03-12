/*
	File: fn_loadStat.sqf
	Author: Nashable (@m_nash)

	Description:
	Load a named var from Profile
*/
_varName = _this select 0;
//systemChat format ["ROLL CALL: Loading %1 from Profile", _varName];
_value = profileNameSpace getVariable (format ["%1%2", _varName,RC_DATA_VERSION]);
if(isNil "_value") then
{
	[_varName] call RC_fnc_InitProfile;
} else
{
	[_varName,_value] call RC_fnc_broadcastStat;
};