/*
	File: fn_filterAI.sqf
	Author: Nashable (@m_nash)

	Description:
	Toggles the filter setting for AI
*/
disableSerialization;
//load display
_display = (uiNamespace getVariable "ROLLCALL_XP_GROUPS");

_ctLB_allGroups = _display displayCtrl 1501;
//if no value or data the first row of LB will return a [] selection
_index = lbCurSel _ctLB_allGroups;
if (isNil "_index") then {_index = 0;};

_filterAI = uiNamespace getVariable ["rollcall_filterAI",false];
uiNamespace setVariable ["rollcall_filterAI",!_filterAI];
call RC_fnc_groupsDisplay;
_ctLB_allGroups lbSetCurSel _index;
call RC_fnc_groupShowPlayers;