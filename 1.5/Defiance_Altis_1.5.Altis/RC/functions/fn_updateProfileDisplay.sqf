/*
	File: fn_updateProfileDisplay.sqf
	Author: Nashable (@m_nash)

	Description:
	Dialog for player to update their skills profile
*/
disableSerialization;
//load display
_display = (uiNamespace getVariable "ROLCALL_XP_PROFILE");

//load data
_playerData = [player] call RC_fnc_getPlayerData;
//systemChat format ["DEBUG (Playerdata): %1", _playerData];
_xp = _playerData select 1;
_pref = _playerData select 2;
_hasMic = _playerData select 3;
_rank = _playerData select 4;

//Setup Preferences
_ctlPref = _display displayCtrl 2100;
lbClear _ctlPref;
{
	_ctlPref lbAdd _x;
	_ctlPref lbSetValue [_foreachindex,_foreachindex];
} forEach ROLLCALL_XP_LABELS;
//Set selection to preference
if (_pref >= 0) then
{
	_ctlPref lbSetCurSel _pref;
};
//lbSetCurSel [2100,_pref+1];

//Setup Mic
_ctrlMic = _display displayCtrl 2101;
_ctrlMic lbAdd "No";
_ctrlMic lbSetValue [0,0];
_ctrlMic lbAdd "Yes";
_ctrlMic lbSetValue [1,1];
if(_hasMic) then {_ctrlMic lbSetCurSel 1} else {_ctrlMic lbSetCurSel 0};

//Setup XP Tables
_0star = [];
_1star = [];
_2star = [];
_3star = [];
_4star = [];
{
	switch (_x) do
	{
	    case 1:
	    {
	    	_1star set [count _1star,_foreachindex];
	    };
	    case 2:
	    {
	    	_2star set [count _2star,_foreachindex];
	    };
	    case 3:
	    {
	    	_3star set [count _3star,_foreachindex];
	    };
	    case 4:
	    {
	    	_4star set [count _4star,_foreachindex];
	    };
	    default
	    {
	     	_0star set [count _0star,_foreachindex];
	    };
	};
} forEach _xp;

[_0star,_1star,_2star,_3star,_4star] call RC_fnc_updateProfileLists;