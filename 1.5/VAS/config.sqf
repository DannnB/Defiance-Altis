waitUntil { !(isNull player) && alive player};
NO_TWS = ["VIRTUAL_AMMO_BOX",0] call BIS_fnc_getParamValue >= 2;
TVT_AMMO_BOX = ["VIRTUAL_AMMO_BOX",0] call BIS_fnc_getParamValue == 3;
//Nash - Check for Revive Compat
REVIVE_MODE = ["FAR_REVIVE_MODE",-1] call BIS_fnc_getParamValue;

//Allow player to respawn with his loadout? If true unit will respawn with all ammo from initial save! Set to false to disable this and rely on other scripts!
vas_onRespawn = true;
//Preload Weapon Config?
vas_preload = true;
//If limiting weapons its probably best to set this to true so people aren't loading custom loadouts with restricted gear.
if (!isNil "NO_TWS") then  { vas_disableLoadSave = NO_TWS } else {vas_disableLoadSave = true};
//Amount of save/load slots
vas_customslots = 9; //9 is actually 10 slots, starts from 0 to whatever you set, so always remember when setting a number to minus by 1, i.e 12 will be 11.
//Disable 'VAS hasn't finished loading' Check !!! ONLY RECOMMENDED FOR THOSE THAT USE ACRE AND OTHER LARGE ADDONS !!!
vas_disableSafetyCheck = false;
/*
	NOTES ON EDITING!
	YOU MUST PUT VALID CLASS NAMES IN THE VARIABLES IN AN ARRAY FORMAT, NOT DOING SO WILL RESULT IN BREAKING THE SYSTEM!
	PLACE THE CLASS NAMES OF GUNS/ITEMS/MAGAZINES/BACKPACKS/GOGGLES IN THE CORRECT ARRAYS! TO DISABLE A SELECTION I.E
	GOGGLES vas_goggles = [""]; AND THAT WILL DISABLE THE ITEM SELECTION FOR WHATEVER VARIABLE YOU ARE WANTING TO DISABLE!

														EXAMPLE
	vas_weapons = ["srifle_EBR_ARCO_point_grip_F","arifle_Khaybar_Holo_mzls_F","arifle_TRG21_GL_F","Binocular"];
	vas_magazines = ["30Rnd_65x39_case_mag","20Rnd_762x45_Mag","30Rnd_65x39_caseless_green"];
	vas_items = ["ItemMap","ItemGPS","NVGoggles"];
	vas_backpacks = ["B_Bergen_sgg_Exp","B_AssaultPack_rgr_Medic"];
	vas_goggles = [""];

*/

if (TVT_AMMO_BOX || isNil "TVT_AMMO_BOX") then
{
	_timeout = time + 300;
	waitUntil {playerSide != civilian || time > _timeout};
	//Generic Items first
	vas_weapons = ["arifle_SDAR_F"];
	vas_magazines = ["1Rnd_HE_Grenade_shell","SmokeShell","SmokeShellYellow","SmokeShellPurple","SmokeShellOrange","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","Chemlight_yellow","HandGrenade","MiniGrenade","Laserbatteries","ClaymoreDirectionalMine_Remote_Mag","APERSTripMine_Wire_Mag","20Rnd_556x45_UW_mag","30Rnd_556x45_Stanag","Titan_AT","Titan_AA"];
	vas_items = [];
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_weapons = vas_weapons + ["launch_NLAW_F","arifle_MX_GL_F","arifle_MX_F","arifle_MXC_F","arifle_MX_SW_pointer_F","hgun_P07_F","srifle_LRR_LRPS_F","launch_B_Titan_short_F","launch_B_Titan_F","srifle_EBR_DMS_pointer_snds_F"];
			vas_magazines = vas_magazines + ["1Rnd_SmokeBlue_Grenade_shell","Chemlight_blue","SmokeShellBlue","100Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","7Rnd_408_Mag","NLAW_F","B_IR_Grenade","30Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag_Tracer","20Rnd_762x51_Mag"];
			//vas_items = vas_items + [];
		};
		//Guer
		case resistance:
		{
			vas_weapons = vas_weapons + ["launch_NLAW_F","launch_I_Titan_short_F","launch_I_Titan_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_F","srifle_GM6_LRPS_F","hgun_ACPC2_F","LMG_Mk200_F","hgun_PDW2000_F","srifle_EBR_DMS_pointer_snds_F"];
			vas_magazines = vas_magazines + ["1Rnd_SmokeGreen_Grenade_shell","Chemlight_green","SmokeShellGreen","5Rnd_127x108_Mag","NLAW_F","9Rnd_45ACP_Mag","I_IR_Grenade","30Rnd_556x45_Stanag_Tracer_Yellow","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","5Rnd_127x108_Mag","30Rnd_9x21_Mag","20Rnd_762x51_Mag"];
			//vas_items = vas_items + [];
		};
		//Opfor
		case east:
		{
			vas_weapons = vas_weapons + ["launch_RPG32_F","arifle_Katiba_GL_F","arifle_Katiba_C_F","arifle_Katiba_F","hgun_Rook40_F","srifle_GM6_LRPS_F","launch_O_Titan_short_F","launch_O_Titan_F","SMG_02_F","srifle_DMR_01_DMS_pointer_snds_F","LMG_Zafir_F"];
			vas_magazines = vas_magazines + ["5Rnd_127x108_Mag","16Rnd_9x21_Mag","10Rnd_762x51_Mag","30Rnd_9x21_Mag","RPG32_F","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","150Rnd_762x51_Box","150Rnd_762x51_Box_Tracer","O_IR_Grenade","1Rnd_SmokeRed_Grenade_shell","Chemlight_red","SmokeShellRed"];
			//vas_items = vas_items + [];
		};
	};
} else {
	//If the arrays below are empty (as they are now) all weapons, magazines, items, backpacks and goggles will be available
	//Want to limit VAS to specific weapons? Place the classnames in the array!
	vas_weapons = [];
	//Want to limit VAS to specific magazines? Place the classnames in the array!
	vas_magazines = [];
	//Want to limit VAS to specific items? Place the classnames in the array!
	vas_items = [];
};
	//Want to limit backpacks? Place the classnames in the array!
	vas_backpacks = [];
	//Want to limit goggles? Place the classnames in the array!
	vas_glasses = [];

/*
	NOTES ON EDITING:
	THIS IS THE SAME AS THE ABOVE VARIABLES, YOU NEED TO KNOW THE CLASS NAME OF THE ITEM YOU ARE RESTRICTING. THIS DOES NOT WORK IN
	CONJUNCTION WITH THE ABOVE METHOD, THIs IS ONLY FOR RESTRICTING / LIMITING ITEMS FROM VAS AND NOTHING MORE

														EXAMPLE
	vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
	vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
	vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS

												Example for side specific (TvT)
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
		//Opfor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
	};
*/

//Below are variables you can use to restrict certain items from being used.
//Remove Weapon
vas_r_weapons = [];
vas_r_backpacks = [];
//Magazines to remove from VAS
vas_r_magazines = [];
//Goggles to remove from VAS
vas_r_glasses = [];
//Items to remove from VAS
//vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"];
vas_r_items = [];
if (NO_TWS || isNil "NO_TWS") then {vas_r_items = ["optic_tws","optic_tws_mg","optic_Nightstalker"]};
if (TVT_AMMO_BOX || isNil "TVT_AMMO_BOX") then {vas_r_items = vas_r_items+["Uniform_Base"]};