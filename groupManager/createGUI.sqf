
private ["_scriptHandle","_nameIndex","_localUnit","_handle","_dialogHandle"];
disableSerialization;

// If dialog is already open, close it and then exit script:
if(!isNull (uiNamespace getVariable "KroK_group_dialog_handle"))exitWith{closeDialog 0};

_localUnit = _this select 0;
_handle = CreateDialog "groupManagementDialog";
_dialogHandle = uiNamespace getVariable "KroK_group_dialog_handle";

[_localunit] execVM "eutw_gui\groupManager\refreshLists.sqf";

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

// If custom group names are enabled, rename all group text:
if(Krok_Custom_GrpNames) then
{
    _nameIndex = 0;
    switch(side _localUnit) do {
        case west: {_nameIndex = 0};
        case east: {_nameIndex = 1};
        case resistance: {_nameIndex = 2};
    };

    (_dialogHandle displayCtrl 1002) ctrlSetText (Krok_grpName_1 select _nameIndex);
    (_dialogHandle displayCtrl 1003) ctrlSetText (Krok_grpName_2 select _nameIndex);
    (_dialogHandle displayCtrl 1004) ctrlSetText (Krok_grpName_3 select _nameIndex);

    (_dialogHandle displayCtrl 1005) ctrlSetText (Krok_grpName_4 select _nameIndex);
    (_dialogHandle displayCtrl 1006) ctrlSetText (Krok_grpName_5 select _nameIndex);
    (_dialogHandle displayCtrl 1007) ctrlSetText (Krok_grpName_6 select _nameIndex);

    (_dialogHandle displayCtrl 1008) ctrlSetText (Krok_grpName_7 select _nameIndex);
    (_dialogHandle displayCtrl 1009) ctrlSetText (Krok_grpName_8 select _nameIndex);
    (_dialogHandle displayCtrl 1010) ctrlSetText (Krok_grpName_9 select _nameIndex);
};

// Refresh the dialog every Krok_refresh_time seconds:
while{!isNull _dialogHandle} do 
{
    [_localunit] call krk_fnc_refreshLists;
    uisleep Krok_refresh_time;
};