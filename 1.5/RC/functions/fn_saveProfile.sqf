/*
	File: fn_saveProfile.sqf
	Author: Nashable (@m_nash)

	Description:
	Saves Roll Call vars from Profile Update Display
*/
disableSerialization;
systemChat "ROLL CALL: Saving Profile";
//load display
_display = (uiNamespace getVariable "ROLCALL_XP_PROFILE");

//Read XP Tables
_xp = [];
for [{_y=0}, {_y<5}, {_y=_y+1}] do
{
	_control = _display displayCtrl (1500+_y);
	_size = lbSize _control;
	for [{_i=0}, {_i<_size}, {_i=_i+1}] do
	{
		_index = (_control lbvalue _i);
		_xp set [_index,_y];
	};
};
["rollcall_version",RC_DATA_VERSION] call RC_fnc_saveStat;
["rollcall_xp",_xp] call RC_fnc_saveStat;
["rollcall_pref",lbCurSel 2100] call RC_fnc_saveStat;
["rollcall_hasMic",((lbCurSel 2101) == 1)] call RC_fnc_saveStat;

systemChat "ROLL CALL: Profile Saved";
closeDialog 0;
call RC_fnc_mainDisplay;