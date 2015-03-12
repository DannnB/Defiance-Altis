/*
	File: fn_addRoleGroup.sqf
	Author: Nashable (@m_nash)

	Description:
	Adds a role to a group
*/
_group = (group player);
if (leader _group == player) then
{
	disableSerialization;
	//load display
	_display = (uiNamespace getVariable "ROLLCALL_XP_GROUPS");

	_ctCMB_roles = _display displayCtrl 2100;
	_index = lbCurSel _ctCMB_roles;
	if (!isNil "_index") then
	{
		_requests = _group getVariable ["rollcall_prefs",[]];
		_requests set [count _requests,_index];
		_group setVariable ["rollcall_prefs",_requests,true];
		call RC_fnc_groupsDisplay;
		_ctLB_allGroups = _display displayCtrl 1501;
		_ctLB_allGroups lbSetCurSel 0;
		call RC_fnc_groupShowPlayers;
	};
};