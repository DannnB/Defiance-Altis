// Pregenerated frequencies by [STELS]Zealot
// Use from init.sqf:
// [] execVM "zlt_gen_freqs.sqf";
// or ['a3ru'] execVM "zlt_gen_freqs.sqf"; for arma3.ru frequencies

#define SCRIPT_VERSION "1M"

#define STR_LR_STRING "LR %1 MHz (%2)"
#define STR_MAP_HDR "Frequencies:"


//private ["_radio_t"];

zlt_genfreq_radio_t = [_this, 0, "TF"] call bis_fnc_param;
zlt_genfreq_radio_t = toUpper (zlt_genfreq_radio_t);

_radio = [-2,2,32,64,100,400];


if ( zlt_genfreq_radio_t == "A3RU" ) then {
	_radio = [-2,2,5,18,100,400];
};

if ( zlt_genfreq_radio_t == "TF" ) then {
	if (not isClass (configFile >> "CfgPatches" >> "task_force_radio_items")) exitwith { zlt_genfreq_radio_t = ""; };

	tf_same_sw_frequencies_for_side = false;
	tf_same_lr_frequencies_for_side = true;
	if ([west, resistance] call BIS_fnc_areFriendly) then {
		tf_guer_radio_code = "_bluefor";
	};
	if ([east, resistance] call BIS_fnc_areFriendly) then {
		tf_guer_radio_code = "_opfor";
	};

	if (isNil "generateSwSetting") then {
		call compile preprocessFileLineNumbers "\task_force_radio\common.sqf";
	};
};

zlt_prc_freq_updmarkers = {

	_zlt_genfreq_xmap = 0;
	_zlt_genfreq_ymap = 8000;
	_zlt_genfreq_deltamap = 250;

	if (worldName == "Altis") then {
		_zlt_genfreq_xmap = 1000;
		_zlt_genfreq_ymap = 30000;
		_zlt_genfreq_deltamap = 500;
	};

	_zlt_spawnSetLrChannel = {
		if (leader group player == player) then {
			_this spawn {
					waituntil {sleep 0.5; not (isNil "haveLRRadio") and {player call haveLRRadio}};
					if (not isNil {setLrFrequency}) then {
						sleep 0.5;
						_val = str (_this);
						[(call activeLrRadio) select 0, (call activeLrRadio) select 1, _val] call setLrFrequency;
						if (dialog) then {
							call updateLRDialogToChannel;
						};
					};
			};
		};
	};

	_zlt_fnc_printfrq = {

		_str = _this;
		_txt = "";
		_mcolor = "";

		switch ( typename (_str select 0)) do {
			case ( typename east) : { _txt = format[STR_LR_STRING,_str select 1, _str select 2]; _mcolor = ([ (_str select 0) , true] call bis_fnc_sidecolor); };
			case ( typename grpnull) : { _txt = format["%1: %2 MHz", groupid(_str select 0)+"("+ name leader (_str select 0) +")", _str select 1]; _mcolor = [ side (_str select 0) , true] call bis_fnc_sidecolor; };
			default { _txt = STR_MAP_HDR; _mcolor = [ playerside , true] call bis_fnc_sidecolor; };
		};

		_mname = format ["mrk_freq_%1", _zlt_genfreq_ymap];
		createMarkerLocal[_mname, [_zlt_genfreq_xmap, _zlt_genfreq_ymap]];
		_mname setMarkerTypeLocal "mil_dot";
		_mname setMarkerTextLocal _txt;
		_mname setMarkerColorLocal _mcolor;
		_mname setmarkerposlocal [_zlt_genfreq_xmap, _zlt_genfreq_ymap];

		_zlt_genfreq_ymap = _zlt_genfreq_ymap - _zlt_genfreq_deltamap;
	};


	_friends = ([side player] call BIS_fnc_friendlySides) - [civilian];
	_friendsids = [];
	_playersideid = [playerside] call BIS_fnc_sideID;
	[""] call _zlt_fnc_printfrq;

	(zlt_pub_gen_frequencies select _playersideid) call _zlt_fnc_printfrq;

	{
		if ( typename (_x select 0) == typename grpNull and {side (_x select 0) in _friends} and { leader (_x select 0) in playableunits} ) then {
			_x call _zlt_fnc_printfrq;
		};
	} foreach zlt_pub_gen_frequencies;

	if (zlt_genfreq_radio_t == "TF" ) then {
		((zlt_pub_gen_frequencies select _playersideid) select 1) call _zlt_spawnSetLrChannel;
	};

};


if (not isDedicated) then {
	[] spawn {
		waitUntil {!isNil "zlt_pub_gen_frequencies"};
		waitUntil {player == player};


		if (playerside == civilian) exitwith {};

		[] call zlt_prc_freq_updmarkers;
	};
};


_fnc_genfreq = {
	private ["_state","_num","_isinbl","_l1","_l2"];
	_state = _this select 0;
	if (isNil {zlt_freqblacklist}) then {
		zlt_freqblacklist = [];
	};

	_num = 0;
	_l1 = _radio select 0;
	_l2 = _radio select 1;
	_isinbl = true;
	if (_state == 0) then {
		_l1 = _radio select 2; _l2 = _radio select 3;
	};
	if (_state == 1) then {
		_l1 = _radio select 4; _l2 = _radio select 5;
	};

	while {_isinbl} do {
		_num = round (([_l1,_l2] call bis_fnc_randomnum) * 10) / 10 ;
		if not (_num in zlt_freqblacklist) then {
			zlt_freqblacklist = zlt_freqblacklist set [count zlt_freqblacklist, _num ];
			_isinbl = false;
		};
	};
	_num;
};

if (not isServer) exitWith {};
zlt_pub_gen_frequencies = [];

{
	_num = 0;
	_sdv = 0;
	switch true do {
		case (_x == resistance and ([west, resistance] call BIS_fnc_areFriendly) ) : {
			_num = (zlt_pub_gen_frequencies select 1) select 1;
			_sdv = (zlt_pub_gen_frequencies select 1) select 2;
		};
		case (_x == resistance and ([east, resistance] call BIS_fnc_areFriendly) ) : {
			_num = (zlt_pub_gen_frequencies select 0) select 1;
			_sdv = (zlt_pub_gen_frequencies select 0) select 2;
		};
		default {
			_num = [0] call _fnc_genfreq ;
			_sdv = [2] call _fnc_genfreq ;
		};
	};
	_data = [_x, _num, _sdv];

	zlt_pub_gen_frequencies set [count zlt_pub_gen_frequencies,  _data];
} foreach [east, west, resistance];


{
	_num = [1] call _fnc_genfreq ;
	zlt_pub_gen_frequencies set [count zlt_pub_gen_frequencies, [_x, _num] ];

	if (zlt_genfreq_radio_t == "TF") then {
		_vl3 = [] call generateSwSetting;
		_vl3 set [2, str (_num)];
		_x setVariable["tf_sw_frequency", _vl3, true];
	};

} foreach allgroups;


publicVariable "zlt_pub_gen_frequencies";