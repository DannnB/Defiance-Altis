private ["_localUnit","_pictureID","_buttonSwitchID","_listID","_group","_groupO","_groupI","_dialogHandle"];
disableSerialization;
_localUnit = _this select 0;
_pictureID = _this select 1;
_buttonSwitchID = _this select 2;
_listID = _this select 3;
_group = _this select 4;
_groupO = _this select 5;
_groupI = _this select 6;
_dialogHandle = uiNamespace getVariable "KroK_group_dialog_handle";

// switch focus from leader button to join/leave button (to prevent chevrons from being covered by background button):
ctrlSetFocus (_dialogHandle displayCtrl _buttonSwitchID);

// This switch statement is checking to see if the player who pressed the leader button is able to transfer leadership, then transfers it (or not):
switch (side _localUnit) do {
    case west: {
        // check if a person is selected in the list, and that the person is not the player, and that the player is leader of this group:
        if ((lbText [_listID, (lbCurSel _listID)] != "") && (lbText [_listID, (lbCurSel _listID)] != (name _localUnit)) && (_localUnit == leader _group)) then{

            // change chevron button to greyed out:
            (_dialogHandle displayCtrl _pictureID) ctrlSetTextColor [1, 1, 1, 0.25];
			
            // change leadership from player to the unit selected in the list:
            {
                if((lbText [_listID, (lbCurSel _listID)] == name _x)) then {
                    _group selectLeader _x;
                    hint format ["You gave leadership to %1.", name _x];
                };
            }forEach units _group;
        };
    };
    case east: {
        // check if a person is selected in the list, and that the person is not the player, and that the player is leader of this group:
        if ((lbText [_listID, (lbCurSel _listID)] != "") && (lbText [_listID, (lbCurSel _listID)] != (name _localUnit)) && (_localUnit == leader _groupO)) then{

            // change chevron button to greyed out:
            (_dialogHandle displayCtrl _pictureID) ctrlSetTextColor [1, 1, 1, 0.25];
			
            // change leadership from player to the unit selected in the list:
            {
                if((lbText [_listID, (lbCurSel _listID)] == name _x)) then {
                    _groupO selectLeader _x;
                    hint format ["You gave leadership to %1.", name _x];
                };
            }forEach units _groupO;
        };
    };
    case resistance: {
        // check if a person is selected in the list, and that the person is not the player, and that the player is leader of this group:
        if ((lbText [_listID, (lbCurSel _listID)] != "") && (lbText [_listID, (lbCurSel _listID)] != (name _localUnit)) && (_localUnit == leader _groupI)) then{

            // change chevron button to greyed out:
            (_dialogHandle displayCtrl _pictureID) ctrlSetTextColor [1, 1, 1, 0.25];
			
            // change leadership from player to the unit selected in the list:
            {
                if((lbText [_listID, (lbCurSel _listID)] == name _x)) then {
                    _groupI selectLeader _x;
                    hint format ["You gave leadership to %1.", name _x];
                };
            }forEach units _groupI;
        };
    };
};

// Refresh lists after pressing this button:
[_localunit] call krk_fnc_refreshLists;