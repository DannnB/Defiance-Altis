/*
	File: fn_getXPLabels.sqf
	Author: Nashable (@m_nash)

	Description:
	Converts an array into a labeled array for XP Headers (Roles)
	returns array
*/
_xp = _this select 0;
_array = [];
{
	if (_x >= 0) then
	{
		_array set [_foreachindex,(ROLLCALL_XP_LABELS select _x)];
	} else {
		_array set [_foreachindex,"None"];
	};
} forEach _xp;
_array