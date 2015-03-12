/*
	File: fn_removeUnitFromGroup.sqf
	Author: Nashable (@m_nash)

	Description:
	Removes the selected unit from Group
*/
_group = (group player);
_leader = leader _group;

if (_leader == player) then
{
	disableSerialization;
	//load display
	_display = (uiNamespace getVariable "ROLLCALL_XP_GROUPS");
	//Current Group
	_ctLB_currentGroup = _display displayCtrl 1500;
	_index = lbCurSel _ctLB_currentGroup;
	if (!isNil "_index") then
	{
		_unit = objectFromNetId (_ctLB_currentGroup lbData _index);
		[_unit] join grpNull;
	};
};
call RC_fnc_groupsDisplay;
