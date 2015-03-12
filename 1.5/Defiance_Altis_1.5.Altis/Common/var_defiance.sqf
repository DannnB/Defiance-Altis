//Params
	STARTING_BLUFOR_TICKETS = ["NATO_TICKETS",50] call BIS_fnc_getParamValue; //  paramsArray select 0; //num of tickets blufor
	MHQ_TICKETS = ["MHQ_TICKETS",10] call BIS_fnc_getParamValue; //  paramsArray select 0; //num of tickets blufor
	NUM_AAF_HQ = ["AAF_HQ_NUM",8] call BIS_fnc_getParamValue; //paramsArray select 1; // number of HQ obj
	AAF_HQ_CENTER = ["AAF_HQ_CENTER",0] call BIS_fnc_getParamValue;
	RAD_AAF_HQ = ["AAF_HQ_RADIUS",25000] call BIS_fnc_getParamValue; //paramsArray select 2; // Radius from Blufor Base
	AI_HADES_SPAWN_COEF = ["AI_HADES_SPAWN_COEF",1] call BIS_fnc_getParamValue; //paramsArray select 3; //Cost impact for Automated INDFOR
	PLAYER_MAP_MARKERS = ["MAP_MARKERS",1] call BIS_fnc_getParamValue; //paramsArray select 4; //Show Map Markers for Players.
	MAX_CIV_DEATH = ["MAX_CIV_DEATH",50] call BIS_fnc_getParamValue; //paramsArray select 5; //How many Civ Deaths before Penalty kicks in
	CIV_DEATH_PEN = 1;
	if (MAX_CIV_DEATH < 0) then {CIV_DEATH_PEN = 0;MAX_CIV_DEATH = 1e10};
	START_TIME = ["START_TIME",-1] call BIS_fnc_getParamValue; //paramsArray select 6;
	DYN_WEATHER = 0 == ["ENABLE_DYN_WEATHER",1] call BIS_fnc_getParamValue; //paramsArray select 7;
	START_WEATHER = ["START_WEATHER","Clear"] call BIS_fnc_getParamValue; //paramsArray select 8;
	WEATHER_CHANGE_SPEED = ["WEATHER_CHANGE_SPEED",0] call BIS_fnc_getParamValue; //paramsArray select 9;
	MAX_UNITS = ["MAX_UNITS",50] call BIS_fnc_getParamValue; //paramsArray select 10;
	ZEUS_RESOURCE_RATE = ["ZEUS_RESOURCE_RATE",1] call BIS_fnc_getParamValue;
	SHOW_CIV_INTEL_RADIUS = ["SHOW_CIV_INTEL_RADIUS",1] call BIS_fnc_getParamValue; //paramsArray select 11;
	SHOW_INTEL_BREADCRUMB = ["SHOW_INTEL_BREADCRUMB",0] call BIS_fnc_getParamValue; //paramsArray select 12;
	START_INTEL_BREADCRUMB = 1 == ["START_INTEL_BREADCRUMB",0] call BIS_fnc_getParamValue; //paramsArray select 12;
	INDFOR_TEAM_STACK_RATIO = ["INDFOR_TEAM_STACK_RATIO",0] call BIS_fnc_getParamValue;
	VIRTUAL_AMMO_BOX = ["VIRTUAL_AMMO_BOX",0] call BIS_fnc_getParamValue > 0;
	NO_TWS = ["VIRTUAL_AMMO_BOX",0] call BIS_fnc_getParamValue >= 2;
	TVT_AMMO_BOX = ["VIRTUAL_AMMO_BOX",0] call BIS_fnc_getParamValue == 3;
	VIRTUAL_AMMO_BOX_MHQ = ["VIRTUAL_AMMO_BOX_MHQ",0] call BIS_fnc_getParamValue == 1;
	HCPRESENT = 1 == ["HeadlessClient",0] call BIS_fnc_getParamValue;
	REVIVE_MODE = ["FAR_REVIVE_MODE",-1] call BIS_fnc_getParamValue;
	REVIVE_TIME = ["FAR_REVIVE_TIME",60] call BIS_fnc_getParamValue;
	ACTIVE_AO_NUM = ["ACTIVE_AO_NUM",0] call BIS_fnc_getParamValue;
	ALLOW_FLEEING = 1 == ["ALLOW_FLEEING",1] call BIS_fnc_getParamValue;
	CIV_POP = ["CIV_POP",1] call BIS_fnc_getParamValue;
	FAKE_INTEL = 1 == ["FAKE_INTEL",0] call BIS_fnc_getParamValue;
	HELO_LIFT = ["HELO_LIFT",0] call BIS_fnc_getParamValue;
	PAUSE_BOUNTY = ["PAUSE_BOUNTY",1] call BIS_fnc_getParamValue;
	SINGLE_CO_MODE = ["SINGLE_CO_MODE",0] call BIS_fnc_getParamValue == 1;
	ALLOW_SAVING = ["ALLOW_SAVING",0] call BIS_fnc_getParamValue == 1;

//Constants / Config
	// UPKeep Vars
	BLUFOR_ZEUS_UPKEEP_BASE = 0.16;
	b_zeusUpKeep = BLUFOR_ZEUS_UPKEEP_BASE;
	b_atcUpKeep = BLUFOR_ZEUS_UPKEEP_BASE/2;

	INDFOR_ZEUS_UPKEEP_BASE = 0.02;
	i_zeusUpKeep = INDFOR_ZEUS_UPKEEP_BASE;
	bluforTick = 60;
	indforTick = 10;

	CIV_DEATH_PEN_TIME = 300; // Timer for how long a penalty
	CIV_DEATH_PEN_AMOUNT = 0.5; // Coef for Civ Death penalty

	//Upkeep message Templates
	UPKEEP_MSG_TEMPLATES = [
		"NATO Upkeep due to Radiotowers has updated to a %1%3 of resources every %2 seconds.",
		"Due to excessive civilian casualties your team's resource penalty has been updated to %1%3 every %2 seconds.",
		"Your resource penalty has been restored to %1%3 every %2 seconds. Be careful of civilian casualties in the future."
		];

	//HQ Setup Vars
	AAF_HQ_MARKERS = ["respawn_west","north","east","south","west","center"];
	INDFOR_HQ_PLACEMENT_RADIUS = 500;
	INDFOR_HQ_UNIT = "Land_SatellitePhone_F";
	INDFOR_HQs = [];
	HADES_TRACK_RADIUS = 250;
	HADES_TRACK_TIME = 600;

	//INTEL
	CIV_INTEL_HQ_RADIUS = 500; // How far out does the Civ Intel start from the HQ
	CIV_INTEL_HQ_INCREMENTS = 50; // With each Intel Gather, how much closer does it get to the target.
	CIV_INTEL_RANGE = 5000; // How far from an Enemy HQ can a Civ identify/give intel on them
	CIV_INTEL_CHANCE = 75; // % chance to get Intel if Enemy HQ are operating in the area.
	CIV_FALSE_INTEL_CHANCE = 25; //Chance that if no real intel is given, the players will recieve false info.
	civIntelMarkers = [];
	activeHQMarkers = [];

	//Zeus FOW
	ZEUS_PLAYER_LOS = 1000;
	ZEUS_MINION_LOS = 250;

	//Zeus Voting
	DEFAULT_ZEUS_VOTE_TIME = 60;
	BLUFOR_ZEUS_LOGIC = [b_zeus,b_atc];
	BLUFOR_ZEUS_UNITS = ["b_zeusUnit","b_atcUnit"];
	BLUFOR_ZEUS_ROLETEXT = ["NATO Land Commander (CO)","NATO Air Commander (XO)"];
	INDFOR_ZEUS_LOGIC = [i_zeus];
	INDFOR_ZEUS_UNITS = ["i_zeusUnit"];
	INDFOR_ZEUS_ROLETEXT = ["Hades (CO)"];
	ZEUS_CO_MAX_INDEX = 0;
	ZEUS_CO_LOGICS = [b_zeus,i_zeus];

	//ZEUS AI
	HADES_AI_ATTACK_CHANCE = 50;

	//VAS Integration
	BLUFOR_AMMO_BOX = "B_supplyCrate_F";
	//BLUFOR_AMMO_BOX = "Land_Pallet_MilBoxes_F";
	INDFOR_AMMO_BOX = "Land_Box_AmmoOld_F";

	//View Script Integration
	tawvd_disablenone = !TVT_AMMO_BOX;

	//MHQ TYPE
	if (MHQ_TICKETS >= 0 || HELO_LIFT == 4) then {
		BLUFOR_MHQ_TYPE = "B_APC_Tracked_01_CRV_F";
	} else {
		BLUFOR_MHQ_TYPE = "B_Truck_01_box_F";
	};
	//BIS_fnc_codePerformance

	IF (HCPRESENT) then
	{
		if (!hasInterface && !isServer) then
		{

			HCUnit = player;
			publicVariable "HCUnit";
		};
	} else {
		if(isServer) then
		{
			HCUnit = "";
			publicVariable "HCUnit";
		};
	};
//Zeus Playing Units init
	{
		missionNamespace setVariable [_x,objNull];
	} forEach BLUFOR_ZEUS_UNITS+INDFOR_ZEUS_UNITS;