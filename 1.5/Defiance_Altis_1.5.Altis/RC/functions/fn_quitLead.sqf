/*
	File: fn_quitLead.sqf
	Author: Nashable (@m_nash)

	Description:
	Resign as a leader of a group
*/
_group = (group player);
_leader = leader _group;
if (_leader == player) then
{
	_aiUnit = nil;
	{
		if (isPlayer _x) exitWith {_group selectLeader _x};
		if (_x != player && isNil "_aiUnit") then {_aiUnit = _x};
	} forEach (units _group);
	// Didn't find a player so lets pick a random AI
	if (!isNil "_aiUnit") then {_group selectLeader _aiUnit};
} else
{
	//Then lets see if they're trying to take over an AI squad
	if (!isPlayer (_leader)) then
	{
		_group selectLeader player;
	};
};
call RC_fnc_groupsDisplay;
