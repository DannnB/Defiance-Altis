if (!isDedicated) then {
	//Default values
	//ROLLCALL_XP_LABELS = ["Side Commander","Squad Lead","Fire Team Lead","Medic","Marksman","AT/AA","Automatic Weapon","Grendier","JTAC","Attack Air Pilot","Air Air Gunner","Transport Pilot","Transport Gunner","Armored Commander","Armored Driver","Armored Gunner"];
	ROLLCALL_XP_LABELS = ["Misson CO","Squad Lead","Team Lead","Medic","Sniper","AT/AA","Auto Rifle","Grendier","JTAC/Recon","Fixed Wing","Helicopter","Driver","Gunner"];
	ROLLCALL_XP_VALUE_LABELS = ["None","Limited","Competent","Experienced","Elite"];
	ROLLCALL_XP_VALUE_IMG = ["RC\img\0star.paa","RC\img\1star.paa","RC\img\2star.paa","RC\img\3star.paa","RC\img\4star.paa"];
	ROLLCALL_XP_DEFAULT_VALUES = [];
	{
		ROLLCALL_XP_DEFAULT_VALUES set [_foreachindex,0];
	} forEach ROLLCALL_XP_LABELS;
	RC_DATA_VERSION = 1;
	RC_DEBUG = _this select 0;
	if (isNil "RC_DEBUG") then {RC_DEBUG = false};
	RC_SIDES = _this select 1;
	if (isNil "RC_SIDES") then {RC_SIDES = [playerSide]};

	//Wait until mission starts
	waitUntil {player == player};
	//Load Profile
	systemChat format ["ROLL CALL: Initialization Starting (Data Version: %1)", RC_DATA_VERSION];
	systemChat "ROLL CALL: Created by Nashable";
	call RC_fnc_loadProfile;

	//Add Action
	_id = player addAction ["<t color='#EB7FAF'>Roll Call (Group Management)</t>", "_handle = CreateDialog 'ROLCALL_XP_MENU'", nil, -200, false, true, "", ""];
	player addEventHandler ["Respawn", {
        _id = player addAction ["<t color='#EB7FAF'>Roll Call (Group Management)</t>", "_handle = CreateDialog 'ROLCALL_XP_MENU'", nil, -200, false, true, "", ""];
    }];

	//Debug
	ROLLCALL_XP_DEBUG_VALUES = [];
	for [{_i=0}, {_i<50}, {_i=_i+1}] do
	{
		_array = [];
	    {
			_array set [_foreachindex,floor (random 5)];
		} forEach ROLLCALL_XP_LABELS;
		ROLLCALL_XP_DEBUG_VALUES set [_i,_array];
	};
	[] spawn RC_fnc_rankTimer;
	systemChat "ROLL CALL: Initialization Complete!", RC_DATA_VERSION;

};