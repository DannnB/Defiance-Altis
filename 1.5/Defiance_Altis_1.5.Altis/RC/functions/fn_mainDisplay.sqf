/*
	File: fn_mainDisplay.sqf
	Author: Nashable (@m_nash)

	Description:
	Main display for Roll Call Menu System
*/
//RC_MIC_PIC = "\A3\ui_f_data\a3\ui_f\data\IGUI\RscIngameUI\RscDisplayVoiceChat\microphone_ca.paa";
RC_MIC_PIC = "RC\img\mic.paa";
disableSerialization;
//_control = ((findDisplay 88100) displayCtrl 1500);
//systemChat str(((findDisplay 88100) displayCtrl 1500));

_display = (uiNamespace getVariable "ROLCALL_XP_MENU");

//Sort Combo
_ctCMB_Sort = (_display displayCtrl 2100);
lbClear _ctCMB_Sort;
_id = _ctCMB_Sort lbAdd "Rank";
_id = _ctCMB_Sort lbAdd "Side";
_id = _ctCMB_Sort lbAdd "Microphone";
_id = _ctCMB_Sort lbAdd "Pref Role";
{
	_id = _ctCMB_Sort lbAdd (ROLLCALL_XP_LABELS select _foreachindex);
	//_ctCMB_Sort lbSetValue [_id,_foreachindex];
} forEach ROLLCALL_XP_LABELS;
_ctCMB_Sort ctrlRemoveAllEventHandlers "LBSelChanged";
_ctCMB_Sort_Select = uiNamespace getVariable ["ROLCALL_XP_SORT",0];
_ctCMB_Sort lbSetCurSel _ctCMB_Sort_Select;
//_ctCMB_Sort ctrlSetEventHandler ["LBSelChanged",'[] call RC_fnc_mainDisplay;'];
_ctCMB_Sort ctrlSetEventHandler ["LBSelChanged",'uiNamespace setVariable ["ROLCALL_XP_SORT",lbCurSel ((uiNamespace getVariable "ROLCALL_XP_MENU") displayCtrl 2100)]; [] call RC_fnc_mainDisplay;'];

//Display SKills Profile
_controlHeader = _display displayCtrl 1499;
_control = _display displayCtrl 1500;
lnbClear _controlHeader;
lnbClear _control;
//Add Headers
_controlHeader lnbAddRow ["","Rank","Side","Name"] + ROLLCALL_XP_LABELS + ["Pref Role"];
_controlHeader ctrlEnable false;
//_controlHeader lnbSetPicture[[0,0],RC_MIC_PIC];

//Add Player Data

_playerData = [] call RC_fnc_getAllPlayerData;
if (count _playerData == 0) exitWith {systemChat "Error obtaining player data or no players in the game with a profile saved"};
{
	_pname = _x select 0;
	_xp = _x select 1;
	_pref = _x select 2;
	_hasMic = _x select 3;
	_rank = _x select 4;
	_side = _x select 5;

	//Add Microphone
	_row = ["","",[_side] call bis_fnc_sideName,_pname];
	_dummyRow = [];
	{
		_dummyRow set [_foreachindex,""];
	} forEach ROLLCALL_XP_LABELS;
	_values = [_xp] call RC_fnc_getXPImg;
	_prefRow = [[_pref]] call RC_fnc_getXPLabels;
	//systemChat format ["DEBUG _prefRow = %1 (%2)", _prefRow,_pref];
	_rid = _control lnbAddRow (_row+_dummyRow+_prefRow);
	{
		_control lnbSetPicture [[_rid,_foreachindex+4],_x];
	} forEach _values;

	if (_hasMic) then {
		_control lnbSetPicture[[_rid,0],RC_MIC_PIC];
	};
	_control lnbSetPicture[[_rid,1],[_rank,"texture"] call BIS_fnc_rankParams];
	_control lnbSetColor [[_rid,2],[_side] call bis_fnc_sideColor];
} forEach _playerData;

//Dummy Data for Demo
if (RC_DEBUG) then
{
	_dummySides = [west,east,resistance];
	{
		_pname = format ["Test-%1", _foreachindex];
		_values = [_x] call RC_fnc_getXPImg;
		_rank = floor (random 8);
		_side = _dummySides call bis_fnc_selectRandom;
		_row = ["","",[_side] call bis_fnc_sideName,_pname];
		_dummyRow = [];
		{
			_dummyRow set [_foreachindex,""];
		} forEach ROLLCALL_XP_LABELS;
		_pref = ROLLCALL_XP_LABELS select (floor (random (count ROLLCALL_XP_LABELS)));
		_row = _row + _dummyRow + [_pref];
		_rid = _control lnbAddRow _row;
		{
			_control lnbSetPicture [[_rid,_foreachindex+4],_x];
		} forEach _values;

		if (random 4 > 3) then {
			_control lnbSetPicture[[_rid,0],RC_MIC_PIC];
		};
		_control lnbSetPicture[[_rid,1],[_rank,"texture"] call BIS_fnc_rankParams];
		_color = [_side] call bis_fnc_sideColor;
		_control lnbSetColor [[_rid,2],_color];
	} forEach ROLLCALL_XP_DEBUG_VALUES;
};