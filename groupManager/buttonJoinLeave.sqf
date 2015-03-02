
private ["_scriptHandle","_localUnit","_buttonID","_group","_groupO","_groupI","_grpLocked","_grpOLocked","_grpILocked","_dialogHandle"];
disableSerialization;
_localUnit = _this select 0;
_buttonID = _this select 1;
_group = _this select 2;
_groupO = _this select 3;
_groupI = _this select 4;
_grpLocked = _this select 5;
_grpOLocked = _this select 6;
_grpILocked = _this select 7;
_dialogHandle = uiNamespace getVariable "KroK_group_dialog_handle";

// Disable this button for duration of script, to counter button spamming:
(_dialogHandle displayCtrl _buttonID) ctrlEnable false;

// This switch statement is checking to see if you join or leave a group (limited by group size or locked status):
switch (side _localUnit) do {
    case west: {
        // IF you clicked on other group's button (to join that group):
        if((group _localUnit) != _group) then {
            // Is the group locked?:
            if(!_grpLocked) then{
                //Check to see if group is full:
                if(count units _group < Krok_maximum_group_size)then{
                    [_localUnit] joinSilent _group;
                }else{hint "This group is full."};
            }else{hint "This group is locked."};
		}
        else{
            // ELSE you clicked on your group button (which is leave group):
            [_localUnit] joinSilent grpNull;
        };
    };
    case east: {
        // IF you clicked on other group's button (to join that group):
        if((group _localUnit) != _groupO) then 
        {
            // Is the group locked?:
            if(!_grpOLocked) then{
                //Check to see if group is full:
                if(count units _groupO < Krok_maximum_group_size)then{
                    [_localUnit] joinSilent _groupO;
                }else{hint "This group is full."};
            }else{hint "This group is locked."};
		}
        else{
            // ELSE you clicked on your group button (which is leave group):
            [_localUnit] joinSilent grpNull;
        };
    };
    case resistance: {
        // IF you clicked on other group's button (to join that group):
        if((group _localUnit) != _groupI) then {
            // Is the group locked?:
            if(!_grpILocked) then{
                //Check to see if group is full:
                if(count units _groupI < Krok_maximum_group_size)then{
                    [_localUnit] joinSilent _groupI;
                }else{hint "This group is full."};
            }else{hint "This group is locked."};
		}
        else{
            // ELSE you clicked on your group button (which is leave group):
            [_localUnit] joinSilent grpNull;
        };
    };
};

// Refresh lists after joining/leaving:
[_localunit] call krk_fnc_refreshLists;

// After leaving a group, have to make sure the group is re-initialised if it had been left empty (and thus is now a null group)
// This is done through BIS_fnc_MP function so that only the server is responsible for groups being created.
// This has to be done after the join group part, so that the group is initialised for the buttonJoinLeave parameters.
switch (side _localUnit) do {
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

// Enable the button again, and put focus on it:
(_dialogHandle displayCtrl _buttonID) ctrlEnable true;
ctrlSetFocus (_dialogHandle displayCtrl _buttonID);