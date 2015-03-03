/*
	File: fn_updateProfileLists.sqf
	Author: Nashable (@m_nash)

	Description:
	Sorts and refreshes skill lists in the Update Profile UI
*/
disableSerialization;
//load display
_display = (uiNamespace getVariable "ROLCALL_XP_PROFILE");
{
	if (!isNil "_x") then
	{
		_control = _display displayCtrl (1500+_foreachindex);
		lbClear _control;
		{
			private ["_x"];
			_id = _control lbAdd (ROLLCALL_XP_LABELS select _x);
			_control lbSetValue [_id,_x];
		} forEach _x;
	};
} forEach _this;

/*Refresh XP Tables
_0star = _this select 0;
_1star = _this select 1;
_2star = _this select 2;
_3star = _this select 3;
_4star = _this select 4;


[_0star,_1star,_2star,_3star,_4star];

if (!isNil "_0star") then {
	_ctrl0star = _display displayCtrl 1500;
	lbClear _ctlPref;
	{
		_ctlPref lbAdd [_foreachindex,ROLLCALL_XP_LABELS select _x];
		_ctlPref lbSetValue [_foreachindex,_x];
	} forEach _ctrl0star;
};
if (!isNil "_1star") then {
	_ctrl1star = _display displayCtrl 1501;
	lbClear _ctlPref;
	{
		_ctlPref lbAdd [_foreachindex,ROLLCALL_XP_LABELS select _x];
		_ctlPref lbSetValue [_foreachindex,_x];
	} forEach _ctrl0star;
};
_ctrl1star = _display displayCtrl 1501;
_ctrl2star = _display displayCtrl 1502;
_ctrl3star = _display displayCtrl 1503;
_ctrl4star = _display displayCtrl 1504;
*/