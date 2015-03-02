/*
TPW HOUSELIGHTS ALTIS/STRATIS

Author: tpw
Date: 20140126
Version: 1.06

House status:
0 = unassigned 
1 = lightable
2 = lit

To use: 
1 - Save this script into your mission directory as eg tpw_houselights_a3.sqf
2 - Call it with 0 = [10] execvm "\scripts\tpw_houselights_a3.sqf"; where 10 = delay until houselighting starts

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS
*/

if (isDedicated) exitWith {};
if !(isnil "tpw_houselights_active") exitWith {hint "TPW HOUSELIGHTS already running."};
//if (count _this < 1) exitWith {hint "TPW HOUSELIGHTS incorrect/no config, exiting."};
WaitUntil {!isNull FindDisplay 46};

// VARIABLES
tpw_houselights_sleep = _this select 0; // Delay until houselights functions start
tpw_houselights_housearray = []; // Array of lightable houses near player
tpw_houselights_radius = 50; // Radius around player to check for houses to spawn lights into
tpw_houselights_debug = false; // Debugging
tpw_houselights_active = true; // Global enable/disable
tpw_houselights_version = "1.06"; // Version string

tpw_houselights_lightable = [ // Habitable houses with white walls, red roofs, intact doors and windows
"Land_i_House_Small_01_V1_F",
"Land_i_House_Small_01_V2_F",
"Land_i_House_Small_01_V3_F",
"Land_i_House_Small_02_V1_F",
"Land_i_House_Small_02_V2_F",
"Land_i_House_Small_02_V3_F",
"Land_i_House_Small_03_V1_F",
"Land_i_House_Big_01_V1_F",
"Land_i_House_Big_01_V2_F",
"Land_i_House_Big_01_V3_F",
"Land_i_House_Big_02_V1_F",
"Land_i_House_Big_02_V2_F",
"Land_i_House_Big_02_V3_F",
"Land_House_L_1_EP1", // Spliffz edit for OA 
"Land_House_L_3_EP1",
"Land_House_L_4_EP1",
"Land_House_L_6_EP1",
"Land_House_L_7_EP1",
"Land_House_L_8_EP1",
"Land_House_L_9_EP1",
"Land_House_K_1_EP1",
"Land_House_K_3_EP1", 
"Land_House_K_5_EP1", 
"Land_House_K_6_EP1", 
"Land_House_K_7_EP1", 
"Land_House_K_8_EP1", 
"Land_Terrace_K_1_EP1",
"Land_House_C_1_EP1",
"Land_House_C_1_v2_EP1", 
"Land_House_C_2_EP1", 
"Land_House_C_3_EP1",
"Land_House_C_4_EP1", 
"Land_House_C_5_EP1", 
"Land_House_C_5_V1_EP1", 
"Land_House_C_5_V2_EP1", 
"Land_House_C_5_V3_EP1", 
"Land_House_C_9_EP1", 
"Land_House_C_10_EP1", 
"Land_House_C_11_EP1", 
"Land_House_C_12_EP1", 
"Land_A_Villa_EP1",
"Land_A_Mosque_small_1_EP1",
"Land_A_Mosque_small_2_EP1",
"Land_Ind_FuelStation_Feed_EP1",
"Land_Ind_FuelStation_Build_EP1",
"Land_Ind_FuelStation_Shed_EP1",
"Land_Ind_Garage01_EP1",
"Land_HouseV_1I1",  //Reserve edit for A2
"Land_HouseV_1I2",
"Land_HouseV_1I3",
"Land_HouseV_1I4",
"Land_HouseV_1L1",
"Land_HouseV_1L2",
"Land_HouseV_1T",
"Land_HouseV_2I",
"Land_HouseV_2L",
"Land_HouseV_2T1",
"Land_HouseV_2T2",
"Land_HouseV_3I1",
"Land_HouseV_3I2",
"Land_HouseV_3I3",
"Land_HouseV_3I4",
"Land_HouseV2_01A",
"Land_HouseV2_01B",
"Land_HouseV2_02",
"Land_HouseV2_03",
"Land_HouseV2_03B",
"Land_HouseV2_04",
"Land_HouseV2_05",
"Land_HouseBlock_A1",
"Land_HouseBlock_A2",
"Land_HouseBlock_A3",
"Land_HouseBlock_B1",
"Land_HouseBlock_B2",
"Land_HouseBlock_B3",
"Land_HouseBlock_C2",
"Land_HouseBlock_C3",
"Land_HouseBlock_C4",
"Land_HouseBlock_C5",
"Land_Church_02",
"Land_Church_02A",
"Land_Church_03",
"Land_A_FuelStation_Feed",
"Land_A_FuelStation_Build",
"Land_A_FuelStation_Shed"
];

// SUN ANGLE - CarlGustaffa
tpw_houselights_fnc_sunangle =
	{
	private ["_lat","_day","_hour","_sunangle"];
	while {true} do 
		{
		_lat = -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
		_day = 360 * (dateToNumber date);
		_hour = (daytime / 24) * 360;
		tpw_houselights_sunangle = ((12 * cos(_day) - 78) * cos(_lat) * cos(_hour)) - (24 * sin(_lat) * cos(_day));  
		sleep 60; 
		};
	};
	
// SPAWN A LIGHT INTO HOUSE AT CEILING LEVEL	
tpw_houselights_fnc_spawnlight =
	{
	private ["_house","_houselight","_x","_y","_z","_startpos","_testpos","_lightpos","_ctr"];
	_house = _this select 0;
	
	//Determine house's ceiling height	
	_x = ((getposasl _house) select 0);
	_y = ((getposasl _house) select 1);
	_z = ((getposasl _house) select 2) + 1;
	_startpos = [_x,_y,_z];
	_ctr = 0;
	waitUntil 
		{
		_z = _z + 0.5;
		_ctr = _ctr + 1;
		_testpos = [_x,_y,_z];
		(lineintersects [_testpos,_startpos] || _ctr == 100)
		};
	
	//Create light object
	if (_ctr < 100) then 
		{
		_z = _z - 0.5;
		_lightpos = asltoatl [_x,_y,_z];
		_houselight = "#lightpoint" createVehicle _lightpos;   
		sleep 0.2;
		_houselight setLightColor [250,150,50]; //slightly yellow
		_houselight setLightAmbient [1,1,0.2]; 
		_houselight setLightAttenuation [0.3,0,0,500]; 
		_houselight setLightIntensity 40;
		_houselight setLightUseFlare true;
		_houselight setLightFlareSize 0.5;
		_houselight setLightFlareMaxDistance tpw_houselights_radius;
		_house setvariable ["tpw_houselights_status",2];
		_house setvariable ["tpw_houselights_light",_houselight];
		tpw_houselights_housearray set [count tpw_houselights_housearray,_house];	
		};
	};	
	
// PERIODICALLY SCAN NEARBY HOUSES TO LIGHT - ONLY IF DARK
tpw_houselights_fnc_scan =
	{
	private ["_nearhouses","_uninhab","_housestring","_house","_i"];
	while {true} do
		{
		if  (tpw_houselights_sunangle < 0 && tpw_houselights_active) then
			{
			
			// Only select habitable houses
			_nearhouses = nearestObjects [getPosATL (vehicle player),tpw_houselights_lightable,tpw_houselights_radius];	
			for "_i" from 0 to (count _nearhouses - 1) do
				{
				_house = _nearhouses select _i;
				_housestring = str (typeof _house);
				_uninhab = ["_u_house", _housestring] call BIS_fnc_inString; // uninhabited houses
				if (_uninhab) then 
					{
					_nearhouses set [_i,-1];
					}
				};
			_nearhouses = _nearhouses - [-1];	
			
			for "_i" from 0 to (count _nearhouses - 1) do
				{
				_house = _nearhouses select _i;
				// If house has not already been assigned a status then assign it
				if (_house getvariable ["tpw_houselights_status",0] == 0) then 
					{
					_house setvariable ["tpw_houselights_status",2];
					[_house] call tpw_houselights_fnc_spawnlight;
					};
					
				// If house has already been assigned as lightable but is not in player's array 
				if (_house getvariable ["tpw_houselights_status",0] == 1) then 
					{
					[_house] call tpw_houselights_fnc_spawnlight;
					tpw_houselights_housearray set [count tpw_houselights_housearray,_house];				
					};
				};
			};
		sleep 10;
		};
	};

// UNLIGHT OUT OF RANGE HOUSES
tpw_houselights_fnc_unlight =
	{
	private ["_house","_i"];
	while {true} do 
		{
		if (tpw_houselights_debug) then
			{
			hintsilent format ["%1 lit houses",count tpw_houselights_housearray];
			};
		tpw_houselights_removearray = []; // array of houses to remove
		for "_i" from 0 to (count tpw_houselights_housearray - 1) do
			{
			_house = tpw_houselights_housearray select _i;
			if (_house distance player > tpw_houselights_radius) then
				{
				//Remove light from lit house out of range
				_house setvariable ["tpw_houselights_status",1];
				deletevehicle (_house getvariable "tpw_houselights_light");
				tpw_houselights_removearray set [count tpw_houselights_removearray, _house];
				};
			};
		
		// Remove out of range houses from player array
		tpw_houselights_housearray = tpw_houselights_housearray - tpw_houselights_removearray;
		sleep 10;	
		};
	};	
	
// RUN IT
sleep tpw_houselights_sleep;
[] spawn tpw_houselights_fnc_sunangle;
sleep 1;
[] spawn tpw_houselights_fnc_scan;
[] spawn tpw_houselights_fnc_unlight;	

while {true} do
	{
	// dummy loop so script doesn't terminate
	sleep 10;
	};