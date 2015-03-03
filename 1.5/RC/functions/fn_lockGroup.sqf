/*
	File: fn_createGroup.sqf
	Author: Nashable (@m_nash)

	Description:
	Toggles the lock settings for a group
*/
_group = (group player);
if (leader _group == player) then
{
	_lock = _group getVariable ["rollcall_grplock",false];
	_group setVariable ["rollcall_grplock",!_lock,true];
	call RC_fnc_groupsDisplay;
};