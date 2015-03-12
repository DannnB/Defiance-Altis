/*
	File: fn_groupShowPlayers.sqf
	Author: Nashable (@m_nash)

	Description:
	Update the list of Players for the selected group
*/
_filterAI = uiNamespace getVariable ["rollcall_filterAI",false];

disableSerialization;
//load display
_display = (uiNamespace getVariable "ROLLCALL_XP_GROUPS");

_ctLB_allGroups = _display displayCtrl 1501;
//Clean up Player Listing
_ctLB_playersInGroup = _display displayCtrl 1502;
lbClear _ctLB_playersInGroup;
//Clean up request roles
_ctLB_requestRoles = _display displayCtrl 1503;
_ctCMB_roles = (_display displayCtrl 2100);
lbClear _ctLB_requestRoles;
lbClear _ctCMB_roles;
//if no value or data the first row of LB will return a [] selection
_index = lbCurSel _ctLB_allGroups;
if (isNil "_index") exitWith { };
_group = groupFromNetId (_ctLB_allGroups lbData _index);
//if (!isNil "_index") then { _group = [_ctLB_allGroups lbText _index] call RC_fnc_findGroupByID};
_playerPref = player getVariable ["rollcall_pref",-1];
{
	_isPlayer = isplayer _x;
	if (!_filterAI || _isPlayer) then
	{
		_pref = -2;
		_rolePref = format [" (AI-%1)",getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
		if (_isPlayer) then {
			_pref = _x getVariable ["rollcall_pref",-1];
			_prefText = ([[_pref]] call RC_fnc_getXPLabels) select 0;
			_rolePref = format [" (%1)", _prefText];
		};
		_id = _ctLB_playersInGroup lbAdd (format ["%1%2", (name _x),_rolePref]);
		if (_pref == _playerPref) then {_ctLB_playersInGroup lbSetColor [_id,[0,0.5,0.8,1]]};
		if (!_isPlayer) then {_ctLB_playersInGroup lbSetColor [_id,[1,1,1,0.8]]};
		if (vehicle _x == player) then {_ctLB_playersInGroup lbSetColor [_id,[1,1,0,1]]};
		if (_x == leader _group) then {_ctLB_playersInGroup lbSetColor [_id,[0,1,0,1]]};
	};
} forEach (units _group);

//requested roles
_requests = _group getVariable ["rollcall_prefs",[]];
_requestLabels = [_requests] call RC_fnc_getXPLabels;
{
	_id = _ctLB_requestRoles lbAdd _x;
	if ((_requests select _foreachindex) == _playerPref) then {_ctLB_requestRoles lbSetColor [_id,[0,0.5,0.8,1]]};
} forEach _requestLabels;
/*Request Role Buttons
_ctBUT_addRole = _display displayCtrl 1608;
_ctBUT_delRole = _display displayCtrl 1609;
_ctCMB_roles = _display displayCtrl 2100;*/
_hasOwnGroupSel = leader _group == player;
(_display displayCtrl 1608) ctrlEnable _hasOwnGroupSel;
(_display displayCtrl 1609) ctrlEnable _hasOwnGroupSel;

 _ctCMB_roles ctrlEnable _hasOwnGroupSel;
 {
 	_id = _ctCMB_roles lbAdd _x;
 	lbSetValue [_id,_foreachindex];
 } forEach ROLLCALL_XP_LABELS;
//Disable Lock button when they start clicking on stuff to be sure.
(_display displayCtrl 1606) ctrlEnable _hasOwnGroupSel;