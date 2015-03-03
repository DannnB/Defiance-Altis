/*
	File: fn_removeAI.sqf
	Author: Nashable (@m_nash)

	Description:
	Removes all the AI from a group
*/
_group = (group player);
_leader = leader _group;
_units = [];
if (_leader == player) then
{
	{
		if (!isPlayer _x) then
		{
			_units set [count _units,_x];
		};
	} forEach units _group;
	if (count _units > 0) then {_units join (createGroup (side _group))};
};
call RC_fnc_groupsDisplay;
