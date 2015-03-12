/*
	File: fn_findGroupByID.sqf
	Author: Nashable (@m_nash)

	Description:
	Based on the group ID return a Group Obj
*/
_groupID = _this select 0;
{
	if (_groupID == str(_x)) exitWith {_x};
} forEach allGroups;