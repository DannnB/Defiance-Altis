/*
	File: fn_removeRoleGroup.sqf
	Author: Nashable (@m_nash)

	Description:
	Removes all the request roles from a group
*/
_group = (group player);
if (leader _group == player) then
{
	disableSerialization;
	//load display
	_display = (uiNamespace getVariable "ROLLCALL_XP_GROUPS");
	_group setVariable ["rollcall_prefs",nil,true];
	call RC_fnc_groupsDisplay;
	_ctLB_allGroups = _display displayCtrl 1501;
	_ctLB_allGroups lbSetCurSel 0;
	call RC_fnc_groupShowPlayers;
};