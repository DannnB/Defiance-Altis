private ["_localUnit","_pictureID","_westgrp","_eastgrp","_indgrp","_lockNum","_dialogHandle"];

#define KRK_MIN_LOCK_SIZE hint format["You can't lock a group with less than %1 players in it.", Krok_minimum_lock_size]

disableSerialization;
_localUnit = _this select 0;
_dialogHandle = uiNamespace getVariable "KroK_group_dialog_handle";

// This is checking to see if the player is leader of the squad, then inverting the lock status of the squad:

[_this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5] call {
    _localUnit = _this select 0;
    _pictureID = _this select 1;
    _westgrp = _this select 2;
    _eastgrp = _this select 3;
    _indgrp = _this select 4;
    _lockNum = _this select 5;
    if (_localUnit == leader _westgrp && _lockNum == 1) exitWith {
        if(locked1) then {locked1 = false; publicVariable "locked1";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked1 = true; publicVariable "locked1";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 2) exitWith {
        if(locked2) then {locked2 = false; publicVariable "locked2";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked2 = true; publicVariable "locked2";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 3) exitWith {
        if(locked3) then {locked3 = false; publicVariable "locked3";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked3 = true; publicVariable "locked3";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 4) exitWith {
        if(locked4) then {locked4 = false; publicVariable "locked4";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked4 = true; publicVariable "locked4";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 5) exitWith {
        if(locked5) then {locked5 = false; publicVariable "locked5";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked5 = true; publicVariable "locked5";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 6) exitWith {
        if(locked6) then {locked6 = false; publicVariable "locked6";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked6 = true; publicVariable "locked6";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 7) exitWith {
        if(locked7) then {locked7 = false; publicVariable "locked7";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked7 = true; publicVariable "locked7";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 8) exitWith {
        if(locked8) then {locked8 = false; publicVariable "locked8";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked8 = true; publicVariable "locked8";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _westgrp && _lockNum == 9) exitWith {
        if(locked9) then {locked9 = false; publicVariable "locked9";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{locked9 = true; publicVariable "locked9";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    // EAST:
    if (_localUnit == leader _eastgrp && _lockNum == 1) exitWith {
        if(lockedO1) then {lockedO1 = false; publicVariable "lockedO1";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO1 = true; publicVariable "lockedO1";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 2) exitWith {
        if(lockedO2) then {lockedO2 = false; publicVariable "lockedO2";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO2 = true; publicVariable "lockedO2";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 3) exitWith {
        if(lockedO3) then {lockedO3 = false; publicVariable "lockedO3";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO3 = true; publicVariable "lockedO3";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 4) exitWith {
        if(lockedO4) then {lockedO4 = false; publicVariable "lockedO4";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO4 = true; publicVariable "lockedO4";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 5) exitWith {
        if(lockedO5) then {lockedO5 = false; publicVariable "lockedO5";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO5 = true; publicVariable "lockedO5";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 6) exitWith {
        if(lockedO6) then {lockedO6 = false; publicVariable "lockedO6";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO6 = true; publicVariable "lockedO6";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 7) exitWith {
        if(lockedO7) then {lockedO7 = false; publicVariable "lockedO7";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO7 = true; publicVariable "lockedO7";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 8) exitWith {
        if(lockedO8) then {lockedO8 = false; publicVariable "lockedO8";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO8 = true; publicVariable "lockedO8";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _eastgrp && _lockNum == 9) exitWith {
        if(lockedO9) then {lockedO9 = false; publicVariable "lockedO9";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedO9 = true; publicVariable "lockedO9";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    // RESISTANCE:
    if (_localUnit == leader _indgrp && _lockNum == 1) exitWith {
        if(lockedI1) then {lockedI1 = false; publicVariable "lockedI1";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI1 = true; publicVariable "lockedI1";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 2) exitWith {
        if(lockedI2) then {lockedI2 = false; publicVariable "lockedI2";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI2 = true; publicVariable "lockedI2";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 3) exitWith {
        if(lockedI3) then {lockedI3 = false; publicVariable "lockedI3";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI3 = true; publicVariable "lockedI3";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 4) exitWith {
        if(lockedI4) then {lockedI4 = false; publicVariable "lockedI4";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI4 = true; publicVariable "lockedI4";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 5) exitWith {
        if(lockedI5) then {lockedI5 = false; publicVariable "lockedI5";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI5 = true; publicVariable "lockedI5";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 6) exitWith {
        if(lockedI6) then {lockedI6 = false; publicVariable "lockedI6";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI6 = true; publicVariable "lockedI6";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 7) exitWith {
        if(lockedI7) then {lockedI7 = false; publicVariable "lockedI7";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI7 = true; publicVariable "lockedI7";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 8) exitWith {
        if(lockedI8) then {lockedI8 = false; publicVariable "lockedI8";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI8 = true; publicVariable "lockedI8";}else{KRK_MIN_LOCK_SIZE};
        };
    };
    if (_localUnit == leader _indgrp && _lockNum == 9) exitWith {
        if(lockedI9) then {lockedI9 = false; publicVariable "lockedI9";}else{
            if(count units group _localUnit >= Krok_minimum_lock_size) then{lockedI9 = true; publicVariable "lockedI9";}else{KRK_MIN_LOCK_SIZE};
        };
    };
};

// Refresh lists after pressing this button:
[_localunit] call krk_fnc_refreshLists;	  