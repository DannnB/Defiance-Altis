private ["_scriptHandle"];

if (isServer) then {
    alphaGroup1 = createGroup west; publicVariable "alphaGroup1";
    alphaGroup2 = createGroup west; publicVariable "alphaGroup2";
    alphaGroup3 = createGroup west; publicVariable "alphaGroup3";
    bravoGroup1 = createGroup west; publicVariable "bravoGroup1";
    bravoGroup2 = createGroup west; publicVariable "bravoGroup2";
    bravoGroup3 = createGroup west; publicVariable "bravoGroup3";
    charlieGroup1 = createGroup west; publicVariable "charlieGroup1";
    charlieGroup2 = createGroup west; publicVariable "charlieGroup2";
    charlieGroup3 = createGroup west; publicVariable "charlieGroup3";

    alphaOGroup1 = createGroup east; publicVariable "alphaOGroup1";
    alphaOGroup2 = createGroup east; publicVariable "alphaOGroup2";
    alphaOGroup3 = createGroup east; publicVariable "alphaOGroup3";
    bravoOGroup1 = createGroup east; publicVariable "bravoOGroup1";
    bravoOGroup2 = createGroup east; publicVariable "bravoOGroup2";
    bravoOGroup3 = createGroup east; publicVariable "bravoOGroup3";
    charlieOGroup1 = createGroup east; publicVariable "charlieOGroup1";
    charlieOGroup2 = createGroup east; publicVariable "charlieOGroup2";
    charlieOGroup3 = createGroup east; publicVariable "charlieOGroup3";

    alphaIGroup1 = createGroup resistance; publicVariable "alphaIGroup1";
    alphaIGroup2 = createGroup resistance; publicVariable "alphaIGroup2";
    alphaIGroup3 = createGroup resistance; publicVariable "alphaIGroup3";
    bravoIGroup1 = createGroup resistance; publicVariable "bravoIGroup1";
    bravoIGroup2 = createGroup resistance; publicVariable "bravoIGroup2";
    bravoIGroup3 = createGroup resistance; publicVariable "bravoIGroup3";
    charlieIGroup1 = createGroup resistance; publicVariable "charlieIGroup1";
    charlieIGroup2 = createGroup resistance; publicVariable "charlieIGroup2";
    charlieIGroup3 = createGroup resistance; publicVariable "charlieIGroup3";

    locked1 = false; publicVariable "locked1";
    locked2 = false; publicVariable "locked2";
    locked3 = false; publicVariable "locked3";
    locked4 = false; publicVariable "locked4";
    locked5 = false; publicVariable "locked5";
    locked6 = false; publicVariable "locked6";
    locked7 = false; publicVariable "locked7";
    locked8 = false; publicVariable "locked8";
    locked9 = false; publicVariable "locked9";

    lockedO1 = false; publicVariable "lockedO1";
    lockedO2 = false; publicVariable "lockedO2";
    lockedO3 = false; publicVariable "lockedO3";
    lockedO4 = false; publicVariable "lockedO4";
    lockedO5 = false; publicVariable "lockedO5";
    lockedO6 = false; publicVariable "lockedO6";
    lockedO7 = false; publicVariable "lockedO7";
    lockedO8 = false; publicVariable "lockedO8";
    lockedO9 = false; publicVariable "lockedO9";

    lockedI1 = false; publicVariable "lockedI1";
    lockedI2 = false; publicVariable "lockedI2";
    lockedI3 = false; publicVariable "lockedI3";
    lockedI4 = false; publicVariable "lockedI4";
    lockedI5 = false; publicVariable "lockedI5";
    lockedI6 = false; publicVariable "lockedI6";
    lockedI7 = false; publicVariable "lockedI7";
    lockedI8 = false; publicVariable "lockedI8";
    lockedI9 = false; publicVariable "lockedI9";
};

_scriptHandle = [] execVM "eutw_gui\groupManager\variableDefinitions.sqf";
waitUntil {scriptDone _scriptHandle};

krk_fnc_refreshLists = compile PreProcessFile "eutw_gui\groupManager\refreshLists.sqf";
krk_fnc_createGUI = compile PreProcessFile "eutw_gui\groupManager\createGUI.sqf";
// KEY BINDINGS AREA:
if (!isDedicated) then {

   // player addAction ["<t color='#00FFFF'>Group Manager</t>", "eutw_gui\groupManager\createGUI.sqf", player, -10, false, true, "User10"];

    /*
	FOR SERVER SIDE KEY BINDS:
    keyPressed = {
        _key = _this select 1;
		_dialogHandle = uiNamespace getVariable "KroK_group_dialog_handle";

        //"T" key with ctrl held down  or  "H" key with ctrl held down
        if (((_key == 20 && _this select 3) or (_key == 35 && _this select 3))) then {
            _creationHandle = [player] execVM "eutw_gui\groupManager\createGUI.sqf";
        };
    };

    //This adds an eventhandler that executes keyPressed when you press a key on your keyboard:
    waituntil {!(IsNull (findDisplay 46))};
    _tempEHHandle = (findDisplay 46) displayAddEventHandler  ["KeyDown", "_this call keyPressed"];
	*/
};  


if(isServer) then{
    [] execVM "eutw_gui\groupManager\autoKickSolo.sqf";
};