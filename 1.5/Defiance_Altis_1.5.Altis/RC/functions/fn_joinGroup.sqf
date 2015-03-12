/*
	File: fn_joinGroup.sqf
	Author: Nashable (@m_nash)

	Description:
	Join the selected group
*/
disableSerialization;
//load display
_display = (uiNamespace getVariable "ROLLCALL_XP_GROUPS");
//systemChat str(_display);
_ctLB_allGroups = _display displayCtrl 1501;
//systemChat str(_ctLB_allGroups);
//if no value or data the first row of LB will return a [] selection
_index = lbCurSel _ctLB_allGroups;
//systemChat str(_index);
// if (isNil "_index") exitWith {systemChat "ROLL CALL: Unable to determine new group. Please try again"};
 _group = groupFromNetId (_ctLB_allGroups lbData _index);
 if (isNil "_group") exitWith {systemChat "ROLL CALL: Unable to determine new group. Please try again"};
 _lock = _group getVariable ["rollcall_grplock",false];
if (!_lock || !(isPlayer (leader _group))) then
{
	[player] join _group;
	//Clear Group Specific Stuff
	lbClear (_display displayCtrl 1503);
	lbClear (_display displayCtrl 1502);
	call RC_fnc_groupsDisplay;
	_ctLB_allGroups lbSetCurSel 0;
	call RC_fnc_groupShowPlayers;

} else
{
	hint "This group has been locked. Ask the group leader to unlock it so you can join";
};