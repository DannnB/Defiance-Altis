
private ["_scriptHandle","_localUnit","_pictureID","_buttonID","_listID","_group","_groupO","_groupI","_dialogHandle"];
disableSerialization;
_localUnit = _this select 0;
_pictureID = _this select 1;
_buttonID = _this select 2;
_listID = _this select 3;
_group = _this select 4;
_groupO = _this select 5;
_groupI = _this select 6;
_dialogHandle = uiNamespace getVariable "KroK_group_dialog_handle";

// Disable this button for duration of script, to counter button spamming:
(_dialogHandle displayCtrl _buttonID) ctrlEnable false;

switch (side _localUnit) do {
    case west: {
	
        // check if a person is selected in the list, and that the person is not the player, and that the player is leader of this group:
        if ((lbText [_listID, (lbCurSel _listID)] != "") && (lbText [_listID, (lbCurSel _listID)] != (name _localUnit)) && (_localUnit == leader _group)) then{	
            // remove this player from the group:
            {
                if((lbText [_listID, (lbCurSel _listID)] == name _x)) then {
                    [_x] joinSilent grpNull;
                    hint format ["You kicked %1.", name _x];
                };
            }forEach units _group;
        };
    };
    case east: {
		
        // check if a person is selected in the list, and that the person is not the player, and that the player is leader of this group:
        if ((lbText [_listID, (lbCurSel _listID)] != "") && (lbText [_listID, (lbCurSel _listID)] != (name _localUnit)) && (_localUnit == leader _groupO)) then{
            // remove this player from the group:
            {
                if((lbText [_listID, (lbCurSel _listID)] == name _x)) then {
                    [_x] joinSilent grpNull;
                    hint format ["You kicked %1.", name _x];
                };
            }forEach units _groupO;
        };
    };
    case resistance: {
		
        // check if a person is selected in the list, and that the person is not the player, and that the player is leader of this group:
        if ((lbText [_listID, (lbCurSel _listID)] != "") && (lbText [_listID, (lbCurSel _listID)] != (name _localUnit)) && (_localUnit == leader _groupI)) then{
            // remove this player from the group:
            {
                if((lbText [_listID, (lbCurSel _listID)] == name _x)) then {
                    [_x] joinSilent grpNull;
                    hint format ["You kicked %1.", name _x];
                };
            }forEach units _groupI;
        };
    };
};

// set focus on leader (so that kick button is hidden again):
(_dialogHandle displayCtrl _listID) lbSetCurSel 0;

// Refresh lists after pressing this button:
[_localunit] call krk_fnc_refreshLists;	

// After kicking group leader, have to make sure the group is re-initialised as it has been left empty (and thus is now a null group)
// This is done through BIS_fnc_MP function so that only the server is responsible for groups being created.
switch (side _localUnit) do 
{
    case west: {
        _scriptHandle = [[[1],"eutw_gui\groupManager\defineGroups.sqf"],"BIS_fnc_execVM",false, false] spawn BIS_fnc_MP;
        waitUntil {scriptDone _scriptHandle};
    };
    case east: {
        _scriptHandle = [[[2],"eutw_gui\groupManager\defineGroups.sqf"],"BIS_fnc_execVM",false, false] spawn BIS_fnc_MP;
        waitUntil {scriptDone _scriptHandle};
    };
    case resistance: {
        _scriptHandle = [[[3],"eutw_gui\groupManager\defineGroups.sqf"],"BIS_fnc_execVM",false, false] spawn BIS_fnc_MP;
        waitUntil {scriptDone _scriptHandle};
    };
};

// Enable the button again:
(_dialogHandle displayCtrl _buttonID) ctrlEnable true;