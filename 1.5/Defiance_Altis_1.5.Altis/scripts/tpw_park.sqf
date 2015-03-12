/*
TPW PARK
Version: 1.07
Author: tpw
Date: 20140326
	
Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works. 

To use: 
1 - Save this script into your mission directory as eg tpw_park.sqf
2 - Call it with 0 = [25,300,150,20,10] execvm "\scripts\tpw_park.sqf"; where 25 = percentage of houses to spawn cars near (0 = no cars, >50 inadvisable), 300 = radius (m) around player to scan for houses to spawn cars, 150 = radius (m) around player beyond which cars are hidden, 20 = player must be closer than this (m) to a car for it to have its simulation enabled, 10 = maximum cars to spawn regardless of settings 

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS
*/

if (isDedicated) exitWith {};
if (count _this < 5) exitwith {hint "TPW PARK incorrect/no config, exiting."};
//if !(isnil "tpw_park_active") exitwith {hint "TPW PARK already running."};
if (_this select 0 == 0) exitwith {};
WaitUntil {!isNull FindDisplay 46};

// READ IN VARIABLES
tpw_park_perc = _this select 0; // percentage of houses with parked cars.
tpw_park_createdist = _this select 1; // cars created within this distance, completely removed past it.
tpw_park_hidedist = _this select 2; // cars closer than this are shown, further than this are hidden.
tpw_park_simdist = _this select 3; // cars closer than this have simulation enabled.
tpw_park_max = _this select 4; // maximum cars to spawn regardless (not irregardless, that's not a word even if you're American).

tpw_park_version = "1.07"; // version string

tpw_park_active = true; // global enable/disable
tpw_park_cararray = []; // Array of parked cars
tpw_park_oldpos = [0,0,0];

tpw_park_habitable = [ // Habitable houses with white walls, red roofs, intact doors and windows
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
"Land_A_FuelStation_Shed",
"Land_dum_istan2",// Fallujah
"Land_dum_istan2b",
"Land_dum_istan2_01",
"Land_dum_istan2_02",
"Land_dum_istan2_03",
"Land_dum_istan2_03a",
"Land_dum_istan2_04a",
"Land_dum_istan3",
"Land_dum_istan3_hromada",
"Land_dum_istan4",
"Land_dum_istan4_big",
"Land_dum_istan4_big_inverse",
"Land_dum_istan4_detaily1",
"Land_dum_istan4_inverse",
"Land_dum_mesto3_istan",
"Land_hotel",
"Land_stanek_1",
"Land_stanek_1b",
"Land_stanek_1c",
"Land_stanek_2",
"Land_stanek_2b",
"Land_stanek_2c",
"Land_stanek_3",
"Land_stanek_3b",
"Land_stanek_3c"
];

tpw_park_civcarlist = [
"C_Hatchback_01_F",
"C_Offroad_01_F",
"C_SUV_01_F"
]; 

// SCAN HOUSES AND ASSIGN PARKED CARS
[] spawn
	{
	while {true} do 
		{
		private ["_houses","_housestring","_uninhab","_house","_car","_nearroads","_road","_connected","_conroad1","_conroad2","_roaddir","_housedir","_roadpos","_posx","_posy","_spawncar","_spawnpos"];
		if (tpw_park_oldpos distance position player > (tpw_park_createdist / 2)) then // only if player has moved more than 1/2 a spawn radius
			{
			tpw_park_oldpos = position player;
			_houses = nearestObjects [position player,tpw_park_habitable,tpw_park_createdist]; // grab habitable houses
			for "_i" from 0 to (count _houses - 1) do
				{
				_house = _houses select _i;
				_housestring = str (typeof _house);
				_uninhab = ["_u_house", _housestring] call BIS_fnc_inString; // uninhabited houses
				if !(_uninhab) then 
					{
					//_house = _x;
					if (_house getvariable ["tpw_park_assigned",0] == 0) then // if house has not been assigned
						{
						if (random 100 < tpw_park_perc) then // percentage
							{	
							_car = tpw_park_civcarlist  select (floor (random (count tpw_park_civcarlist )));
							_nearRoads = _house nearRoads 20;	
							if(count _nearRoads > 0) then
								{
								_road = _nearRoads select 0;
								if (count (_road nearentities ["car_f",20]) == 0) then // if there is a road near the house
									{
									_connected = roadsConnectedTo _road;
									_conroad1 = _connected select 0;
									_conroad2 = _connected select 1;
									_roaddir = [_road, _conroad1] call BIS_fnc_DirTo;
									_roaddir = _roaddir + (180 * round (random 1));
									_housedir = _roaddir + 90;
									_roadpos = getposasl _road;
									_posx = (_roadpos select 0) + (4 * sin _housedir);
									_posy = (_roadpos select 1) +  (4 * cos _housedir);
									_spawnpos = [_posx,_posy,0];
									_spawncar = _car createVehicle _spawnpos;
									_spawncar allowdamage false;
									_spawncar setfuel random 0.5;
									_spawncar setdir _roaddir;
									_house setvariable ["tpw_park_car",_spawncar];
									_spawncar setvariable ["tpw_park_house",_house];
									_house setvariable ["tpw_park_assigned",1];
									tpw_park_cararray set [count tpw_park_cararray, _spawncar];
									[_spawncar] spawn 
										{
										sleep 1;
										(_this select 0) enablesimulation false; 
										(_this select 0) allowdamage true;
										};
									};
								};
							}
						else
							{
							_house setvariable ["tpw_park_assigned",1];
							}				
						};
					};	 
				if (count tpw_park_cararray > tpw_park_max) exitwith {};		
				} ;
			};	
		sleep 10;		
		};	
	};	
	
// SHOW HIDE PARKED CARS AS APPROPRIATE
while {true} do
	{
	if (tpw_park_active) then
		{
		for "_i" from 0 to (count tpw_park_cararray - 1) do
			{
			_car = tpw_park_cararray select _i;
			if (_car distance player < tpw_park_hidedist) then 
				{
				_car hideobject false; // unhide near car 		
				// Enable simulation only when people nearby
				if (driver _car in units group player || player distance _car < tpw_park_simdist) then
					{
					_car enablesimulation true; 
					}
				else
					{
					_car enablesimulation false; 
					};
				}
			else
				{
				_car hideobject true; // hide far car
				};

			// delete distant car and unassign its house	
			if (_car distance player > tpw_park_createdist) then 
				{
				(_car getvariable "tpw_park_house") setvariable ["tpw_park_assigned",0];
				deletevehicle _car;
				tpw_park_cararray set [_i,-1];
				};
			};
		tpw_park_cararray = tpw_park_cararray - [-1];		
		sleep 10;		
		};
	};		
