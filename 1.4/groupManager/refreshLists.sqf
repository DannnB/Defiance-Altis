// This script is compiled into a function, and handles the refresh of all lists and buttons in the group manager:

#define BTN_STR_TXT_LEAVE ctrlSetStructuredText parseText "<t align='center'>LEAVE</t>"
#define BTN_STR_TXT_JOIN ctrlSetStructuredText parseText "<t align='center'>JOIN</t>"
#define ICO_UNLOCKED "eutw_gui\groupManager\Images\unlocked.paa"
#define GR_LEADER_COLOR_BLUE  [0,0.8313,1,1] /*[0, 0.3333, 0.6666, 1]*/
#define GR_LEADER_COLOR_GREEN  [0,1,0.1647,1] /*[0, 0.5, 0, 1]*/
#define GR_LEADER_COLOR_RED  [1,0.1647,0,1] /*[0.6117, 0.08, 0.08, 1]*/

private ["_index1","_index2","_index3","_index4","_index5","_index6","_index7","_index8","_index9","_grp","_index10","_listNum","_index","_indexName","_thisUnit","_unitSide","_localUnit","_dialogHandle","_locksHandle"];
disableSerialization;
_localUnit = _this select 0;
_dialogHandle = uiNamespace getVariable "KroK_group_dialog_handle";

// clear and populate all lists:
for "_n" from 1500 to 1509 step 1 do {lbClear _n};

    { if ((side group _x) == (side group _localUnit) && (isPlayer _x)) then{
        [_x] call {
            _grp = group (_this select 0);
            if (_grp == alphaGroup1 or _grp == alphaOGroup1 or _grp == alphaIGroup1) exitWith {_index1 = lbAdd [1500, (name _x)]};
            if (_grp == alphaGroup2 or _grp == alphaOGroup2 or _grp == alphaIGroup2) exitWith {_index2 = lbAdd [1501, (name _x)]};
            if (_grp == alphaGroup3 or _grp == alphaOGroup3 or _grp == alphaIGroup3) exitWith {_index3 = lbAdd [1502, (name _x)]};
            if (_grp == bravoGroup1 or _grp == bravoOGroup1 or _grp == bravoIGroup1) exitWith {_index4 = lbAdd [1503, (name _x)]};
            if (_grp == bravoGroup2 or _grp == bravoOGroup2 or _grp == bravoIGroup2) exitWith {_index5 = lbAdd [1504, (name _x)]};
            if (_grp == bravoGroup3 or _grp == bravoOGroup3 or _grp == bravoIGroup3) exitWith {_index6 = lbAdd [1505, (name _x)]};
            if (_grp == charlieGroup1 or _grp == charlieOGroup1 or _grp == charlieIGroup1) exitWith {_index7 = lbAdd [1506, (name _x)]};
            if (_grp == charlieGroup2 or _grp == charlieOGroup2 or _grp == charlieIGroup2) exitWith {_index8 = lbAdd [1507, (name _x)]};
            if (_grp == charlieGroup3 or _grp == charlieOGroup3 or _grp == charlieIGroup3) exitWith {_index9 = lbAdd [1508, (name _x)]};
            _index10 = lbAdd [1509, (name _x)];
        };	  
    };
} forEach (allUnits + allDead);

//set player name to a colour (yellow):
for '_li' from 1500 to 1509 step 1 do {
    for '_n' from 0 to (lbSize _li) step 1 do {if(name _localUnit == (lbText [_li, _n]))then{lbSetColor [_li, _n, [1, 1, 0, 1]];};};
};

// Sorting the units in the list so that leader is at the top of the list, and colouring the leader name:
for '_li' from 1500 to 1508 step 1 do {
    for '_n' from 0 to (lbSize _li) step 1 do {
        lbSetValue [_li, _n, 1];
		 
        [_li, _n] call {
            _listNum = _this select 0;
            _index = _this select 1;
            _indexName = lbText [_this select 0, _this select 1];
		 
            if (_indexName == name (leader alphaGroup1) or _indexName == name (leader alphaGroup2) or _indexName == name (leader alphaGroup3) or
            _indexName == name (leader bravoGroup1) or _indexName == name (leader bravoGroup2) or _indexName == name (leader bravoGroup3) or
            _indexName == name (leader charlieGroup1) or _indexName == name (leader charlieGroup2) or _indexName == name (leader charlieGroup3)
            ) exitWith {lbSetColor [_listNum, _index, GR_LEADER_COLOR_BLUE]; lbSetValue [_listNum, _index, -1];};
		 
            if (_indexName == name (leader alphaOGroup1) or _indexName == name (leader alphaOGroup2) or _indexName == name (leader alphaOGroup3) or
            _indexName == name (leader bravoOGroup1) or _indexName == name (leader bravoOGroup2) or _indexName == name (leader bravoOGroup3) or
            _indexName == name (leader charlieOGroup1) or _indexName == name (leader charlieOGroup2) or _indexName == name (leader charlieOGroup3)
            ) exitWith {lbSetColor [_listNum, _index, GR_LEADER_COLOR_RED]; lbSetValue [_listNum, _index, -1];};
		 
            if (_indexName == name (leader alphaIGroup1) or _indexName == name (leader alphaIGroup2) or _indexName == name (leader alphaIGroup3) or
            _indexName == name (leader bravoIGroup1) or _indexName == name (leader bravoIGroup2) or _indexName == name (leader bravoIGroup3) or
            _indexName == name (leader charlieIGroup1) or _indexName == name (leader charlieIGroup2) or _indexName == name (leader charlieIGroup3)
            ) exitWith {lbSetColor [_listNum, _index, GR_LEADER_COLOR_GREEN]; lbSetValue [_listNum, _index, -1];};
        };		 
		 
    };
};
for '_li' from 1500 to 1508 step 1 do {lbSortByValue (_dialogHandle displayCtrl _li);};
 
// Set all button text to "Join":
for "_x" from 1600 to 1608 step 1 do {(_dialogHandle displayCtrl _x) BTN_STR_TXT_JOIN;};
// Set leadership buttons to faded:
for '_lb' from 1200 to 1208 step 1 do {(_dialogHandle displayCtrl _lb) ctrlSetTextColor [1, 1, 1, 0.25];};

// Set button text to "Leave" if player is in that squad, and also set leadership button to highlighted if they are a leader:
[_localUnit] call {
    _thisUnit = (_this select 0);
    _grp = group _thisUnit;
    if (_grp == alphaGroup1 or _grp == alphaOGroup1 or _grp == alphaIGroup1) exitWith {
        (_dialogHandle displayCtrl 1600) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader alphaGroup1 or _thisUnit == leader alphaOGroup1 or _thisUnit == leader alphaIGroup1)then{
            (_dialogHandle displayCtrl 1200) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == alphaGroup2 or _grp == alphaOGroup2 or _grp == alphaIGroup2) exitWith {
        (_dialogHandle displayCtrl 1601) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader alphaGroup2 or _thisUnit == leader alphaOGroup2 or _thisUnit == leader alphaIGroup2)then{
            (_dialogHandle displayCtrl 1201) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == alphaGroup3 or _grp == alphaOGroup3 or _grp == alphaIGroup3) exitWith {
        (_dialogHandle displayCtrl 1602) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader alphaGroup3 or _thisUnit == leader alphaOGroup3 or _thisUnit == leader alphaIGroup3)then{
            (_dialogHandle displayCtrl 1202) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == bravoGroup1 or _grp == bravoOGroup1 or _grp == bravoIGroup1) exitWith {
        (_dialogHandle displayCtrl 1603) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader bravoGroup1 or _thisUnit == leader bravoOGroup1 or _thisUnit == leader bravoIGroup1)then{
            (_dialogHandle displayCtrl 1203) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == bravoGroup2 or _grp == bravoOGroup2 or _grp == bravoIGroup2) exitWith {
        (_dialogHandle displayCtrl 1604) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader bravoGroup2 or _thisUnit == leader bravoOGroup2 or _thisUnit == leader bravoIGroup2)then{
            (_dialogHandle displayCtrl 1204) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == bravoGroup3 or _grp == bravoOGroup3 or _grp == bravoIGroup3) exitWith {
        (_dialogHandle displayCtrl 1605) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader bravoGroup3 or _thisUnit == leader bravoOGroup3 or _thisUnit == leader bravoIGroup3)then{
            (_dialogHandle displayCtrl 1205) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == charlieGroup1 or _grp == charlieOGroup1 or _grp == charlieIGroup1) exitWith {
        (_dialogHandle displayCtrl 1606) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader charlieGroup1 or _thisUnit == leader charlieOGroup1 or _thisUnit == leader charlieIGroup1)then{
            (_dialogHandle displayCtrl 1206) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == charlieGroup2 or _grp == charlieOGroup2 or _grp == charlieIGroup2) exitWith {
        (_dialogHandle displayCtrl 1607) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader charlieGroup2 or _thisUnit == leader charlieOGroup2 or _thisUnit == leader charlieIGroup2)then{
            (_dialogHandle displayCtrl 1207) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
    if (_grp == charlieGroup3 or _grp == charlieOGroup3 or _grp == charlieIGroup3) exitWith {
        (_dialogHandle displayCtrl 1608) BTN_STR_TXT_LEAVE;
        if(_thisUnit == leader charlieGroup3 or _thisUnit == leader charlieOGroup3 or _thisUnit == leader charlieIGroup3)then{
            (_dialogHandle displayCtrl 1208) ctrlSetTextColor [1, 1, 1, 1];
        };
    };
};	 

// Check each group to see if it should be locked or unlocked:
_locksHandle = [[[_localUnit],"eutw_gui\groupManager\setLocks.sqf"],"BIS_fnc_execVM",false,false] spawn BIS_fnc_MP;
waitUntil {scriptDone _locksHandle};

// set all lock buttons to unlocked:
for '_lkb' from 1250 to 1258 step 1 do {(_dialogHandle displayCtrl _lkb) ctrlSetText ICO_UNLOCKED;};

// Show if each group is locked:
[_localUnit] call {
    _unitSide = side (_this select 0);
    if ((_unitSide == west && locked1) or(_unitSide == east && lockedO1) or (_unitSide == resistance && lockedI1)) exitWith {(_dialogHandle displayCtrl 1250) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked2) or(_unitSide == east && lockedO2) or (_unitSide == resistance && lockedI2)) exitWith {(_dialogHandle displayCtrl 1251) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked3) or(_unitSide == east && lockedO3) or (_unitSide == resistance && lockedI3)) exitWith {(_dialogHandle displayCtrl 1252) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked4) or(_unitSide == east && lockedO4) or (_unitSide == resistance && lockedI4)) exitWith {(_dialogHandle displayCtrl 1253) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked5) or(_unitSide == east && lockedO5) or (_unitSide == resistance && lockedI5)) exitWith {(_dialogHandle displayCtrl 1254) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked6) or(_unitSide == east && lockedO6) or (_unitSide == resistance && lockedI6)) exitWith {(_dialogHandle displayCtrl 1255) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked7) or(_unitSide == east && lockedO7) or (_unitSide == resistance && lockedI7)) exitWith {(_dialogHandle displayCtrl 1256) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked8) or(_unitSide == east && lockedO8) or (_unitSide == resistance && lockedI8)) exitWith {(_dialogHandle displayCtrl 1257) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
    if ((_unitSide == west && locked9) or(_unitSide == east && lockedO9) or (_unitSide == resistance && lockedI9)) exitWith {(_dialogHandle displayCtrl 1258) ctrlSetText "eutw_gui\groupManager\Images\locked.paa";};
};	 		
		
// Set all kick buttons to faded:
for '_kb' from 1275 to 1283 step 1 do {(_dialogHandle displayCtrl _kb) ctrlSetTextColor [1, 1, 1, 0.25];};

//highlight kick button if (group leader && have selected a player in the list && not selected yourself):
[_localUnit] call {
    _thisUnit = _this select 0;
    if ((_thisUnit == leader alphaGroup1 or _thisUnit == leader alphaOGroup1 or _thisUnit == leader alphaIGroup1) && (lbText [1500, (lbCurSel 1500)] != "") && (lbText [1500, (lbCurSel 1500)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1275) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader alphaGroup2 or _thisUnit == leader alphaOGroup2 or _thisUnit == leader alphaIGroup2) && (lbText [1501, (lbCurSel 1501)] != "") && (lbText [1501, (lbCurSel 1501)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1276) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader alphaGroup3 or _thisUnit == leader alphaOGroup3 or _thisUnit == leader alphaIGroup3) && (lbText [1502, (lbCurSel 1502)] != "") && (lbText [1502, (lbCurSel 1502)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1277) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader bravoGroup1 or _thisUnit == leader bravoOGroup1 or _thisUnit == leader bravoIGroup1) && (lbText [1503, (lbCurSel 1503)] != "") && (lbText [1503, (lbCurSel 1503)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1278) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader bravoGroup2 or _thisUnit == leader bravoOGroup2 or _thisUnit == leader bravoIGroup2) && (lbText [1504, (lbCurSel 1504)] != "") && (lbText [1504, (lbCurSel 1504)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1279) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader bravoGroup3 or _thisUnit == leader bravoOGroup3 or _thisUnit == leader bravoIGroup3) && (lbText [1505, (lbCurSel 1505)] != "") && (lbText [1505, (lbCurSel 1505)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1280) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader charlieGroup1 or _thisUnit == leader charlieOGroup1 or _thisUnit == leader charlieIGroup1) && (lbText [1506, (lbCurSel 1506)] != "") && (lbText [1506, (lbCurSel 1506)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1281) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader charlieGroup2 or _thisUnit == leader charlieOGroup2 or _thisUnit == leader charlieIGroup2) && (lbText [1507, (lbCurSel 1507)] != "") && (lbText [1507, (lbCurSel 1507)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1282) ctrlSetTextColor [1, 1, 1, 1];
    };
    if ((_thisUnit == leader charlieGroup3 or _thisUnit == leader charlieOGroup3 or _thisUnit == leader charlieIGroup3) && (lbText [1508, (lbCurSel 1508)] != "") && (lbText [1508, (lbCurSel 1508)] != (name _thisUnit))) exitWith {
        (_dialogHandle displayCtrl 1283) ctrlSetTextColor [1, 1, 1, 1];
    };
};	
