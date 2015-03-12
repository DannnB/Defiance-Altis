/*
	File: fn_groupsDisplay.sqf
	Author: Nashable (@m_nash)

	Description:
	Dialog for player to manage/join Groups
*/
disableSerialization;
//load display
_display = (uiNamespace getVariable "ROLLCALL_XP_GROUPS");

// Load Group & Leader
_group = group player;
_leader = leader (group player);
_aiLeader = !(isPlayer _leader);
_isleader = _leader == player;
_groupLock = _group getVariable ["rollcall_grplock",false];
_groupName = str(_group);

//_ctBUT_createGroup = _display displayCtrl 1600;
//Become Leader Button
_ctBUT_leader = _display displayCtrl 1605;
_ctBUT_leader ctrlEnable (_aiLeader || _isleader);
if (_isleader) then
{
	_ctBUT_leader ctrlSetText "Step Down As Leader";
} else
{
	_ctBUT_leader ctrlSetText "Become Leader";
};

//(Un)Lock Button
_ctBUT_lock = _display displayCtrl 1606;
if (_groupLock) then {_ctBUT_lock ctrlSetText "Unlock Group";_ctBUT_lock ctrlSetTextColor [1,0,0,1]} else {_ctBUT_lock ctrlSetText "Lock Group";_ctBUT_lock ctrlSetTextColor [0,1,0,1]};

//Other Leader only controls
(_display displayCtrl 1603) ctrlEnable _isleader;
(_display displayCtrl 1604) ctrlEnable _isleader;

//Filter AI button
_filterAI = uiNamespace getVariable ["rollcall_filterAI",false];
_ctBUT_filterAI = _display displayCtrl 1607;
if (_filterAI) then
{
	_ctBUT_filterAI ctrlSetText "Show AI Units";
} else
{
	_ctBUT_filterAI ctrlSetText "Hide AI Units";
};

//Current Group
_ctTXT_currentGroup = _display displayCtrl 1001;
_ctTXT_currentGroup ctrlSetText (format ["Current Group: %1", _groupName]);

_ctLB_currentGroup = _display displayCtrl 1500;
lbClear _ctLB_currentGroup;
{
	_id = _ctLB_currentGroup lbAdd (name _x);
	_ctLB_currentGroup lbSetData [_id,netId _x];
	//_ctLB_currentGroup lbSetValue [_foreachindex,_foreachindex];
	if (!isplayer _x) then {_ctLB_currentGroup lbSetColor [_id,[1,1,1,0.8]]};
	if (vehicle _x == vehicle player) then {_ctLB_currentGroup lbSetColor [_id,[1,1,0,1]]};
	if (_x == _leader) then {_ctLB_currentGroup lbSetColor [_id,[0,1,0,1]]};
} forEach (units _group);

// All Groups
_ctTXT_allGroups = _display displayCtrl 1002;
_factionText = "";
{
	_factionText = format ["%1%2, ",_factionText,[_x] call bis_fnc_sideName];
} forEach RC_SIDES;
_factionText = [_factionText,0,-2] call BIS_fnc_trimString;
_ctTXT_allGroups ctrlSetText (format ["All Groups %1:",_factionText]);

_ctLB_allGroups = _display displayCtrl 1501;
_ctLB_allGroups ctrlSetEventHandler ["LBSelChanged","[] call RC_fnc_groupShowPlayers;"];
lbClear _ctLB_allGroups;
_id = _ctLB_allGroups lbAdd _groupName;
_ctLB_allGroups lbSetData [_id,netId _group];
_ctLB_allGroups lbSetColor [_id,[0,1,0,1]];
{
	if (side _x == playerSide && _x != _group) then
	{
		_id = _ctLB_allGroups lbAdd str(_x);
		_ctLB_allGroups lbSetData [_id,netid _x];
		if ((player getVariable ["rollcall_pref",-1]) in (_x getVariable ["rollcall_prefs",[]])) then {_ctLB_allGroups lbSetColor [_id,[0,0.5,0.8,1]]};
		if (_x getVariable ["rollcall_grplock",false] && (isPlayer (leader _x))) then {_ctLB_allGroups lbSetColor [_id,[1,0,0,1]]};
	};
} forEach allGroups;

//Request Role Combo
(_display displayCtrl 1608) ctrlEnable false;
(_display displayCtrl 1609) ctrlEnable false;
(_display displayCtrl 2100) ctrlEnable false;

//clear selected groups and pref roles
lbclear (_display displayCtrl 1502);
lbclear (_display displayCtrl 1503);