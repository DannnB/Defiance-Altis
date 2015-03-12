/*
	File: fn_getXPimg.sqf
	Author: Nashable (@m_nash)

	Description:
	Converts an XP Data array into a array of image paths
	returns array
*/
_xp = _this select 0;
_array = [];
{
	_array set [_foreachindex,ROLLCALL_XP_VALUE_IMG select _x];
} forEach _xp;
_array