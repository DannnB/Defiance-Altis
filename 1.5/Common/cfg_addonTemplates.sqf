//--- Respawn inventory settings
// INDFOR
[resistance,"I_Soldier_TL_F"] call bis_fnc_addrespawninventory;
[resistance,"I_soldier_F"] call bis_fnc_addrespawninventory;
[resistance,"I_medic_F"] call bis_fnc_addrespawninventory;
[resistance,"I_Soldier_AT_F"] call bis_fnc_addrespawninventory;
[resistance,"I_Soldier_AR_F"] call bis_fnc_addrespawninventory;
[resistance,"I_Sniper_F"] call bis_fnc_addrespawninventory;
[resistance,"I_engineer_F"] call bis_fnc_addrespawninventory;
[resistance,"I_Soldier_GL_F"] call bis_fnc_addrespawninventory;
[resistance,"I_Soldier_AA_F"] call bis_fnc_addrespawninventory;

//--- Rifleman
[west,"b_soldier_f"] call bis_fnc_addrespawninventory;
//--- Autorifleman
[west,"b_soldier_ar_f"] call bis_fnc_addrespawninventory;
//--- Grenadier
[west,"b_soldier_gl_f"] call bis_fnc_addrespawninventory;
//--- Sniper
[west,"B_sniper_F"] call bis_fnc_addrespawninventory;
//---  AT soldier
[west,"b_soldier_at_f"] call bis_fnc_addrespawninventory;
//---  AA soldier
[west,"b_soldier_aa_f"] call bis_fnc_addrespawninventory;
//--- Explosive specialist
[west,"b_soldier_exp_f"] call bis_fnc_addrespawninventory;
//--- Engineer
[west,"B_engineer_F"] call bis_fnc_addrespawninventory;
//--- UAV Operator
[west,"b_soldier_uav_f"] call bis_fnc_addrespawninventory;
//--- Medic
[west,"B_medic_F"] call bis_fnc_addrespawninventory;
//--- Diver
[west,"B_diver_F"] call bis_fnc_addrespawninventory;
//--- Team Leader
[west,"B_Soldier_TL_F"] call bis_fnc_addrespawninventory;

_WEAPONS = [
	"A3_Weapons_F_EBR",
	"A3_Weapons_F_EPA_EBR",
	"A3_Weapons_F_EPA_LongRangeRifles_DMR_01",
	"A3_Weapons_F_EPA_LongRangeRifles_GM6",
	"A3_Weapons_F_EPB_LongRangeRifles_GM3",
	"A3_Weapons_F_EPB_LongRangeRifles_M320",
	"A3_Weapons_F_Explosives",
	"A3_Weapons_F_Items",
	"A3_Weapons_F_Launchers_LAW",
	"A3_Weapons_F_Launchers_NLAW",
	"A3_Weapons_F_Launchers_Titan",
	"A3_Weapons_F_LongRangeRifles_GM6",
	"A3_Weapons_F_LongRangeRifles_M320",
	"A3_Weapons_F_Machineguns_M200",
	"A3_Weapons_F_Machineguns_Zafir",
	"A3_Weapons_F_Pistols_ACPC2",
	"A3_Weapons_F_Pistols_P07",
	"A3_Weapons_F_Pistols_PDW2000",
	"A3_Weapons_F_Pistols_Pistol_heavy_01",
	"A3_Weapons_F_Pistols_Pistol_heavy_02",
	"A3_Weapons_F_Pistols_Rook40",
	"A3_Weapons_F_Rifles_Mk20",
	"A3_Weapons_F_Rifles_MX",
	"A3_Weapons_F_Rifles_SDAR",
	"A3_weapons_f_rifles_SMG_02",
	"A3_Weapons_F_Rifles_TRG20",
	"A3_Weapons_F_Rifles_Vector",
	"A3_Weapons_F",
	"A3_Weapons_F_Acc",
	"A3_Weapons_F_ItemHolders",
	"A3_Weapons_F_Headgear",
	"A3_Weapons_F_Vests"
];
// BLUFOR Zeus Addons
_WEST = [
	"A3_Modules_F_Curator_Misc",
	"A3_Structures_F_Mil_BagFence",
	"A3_Signs_F",
	"A3_UAV_F_Characters_F_Gamma",
	"A3_Characters_F_BLUFOR",
	"A3_Static_F_Mortar_01",
	"A3_Static_F",
	"A3_Soft_F_MRAP_01",
	"A3_Soft_F_Quadbike",
	"A3_Soft_F_HEMTT",
	"A3_Soft_F_Gamma_HEMTT",
	"A3_Modules_F_Curator_Flares",
	"A3_Modules_F_Curator_Chemlights",
	"A3_Modules_F_Curator_Mines",
	"A3_Modules_F_Curator_Ordnance",
	"A3_Modules_F_Curator_Smokeshells",
	"A3_Structures_F_Mil_BagBunker",
				"A3_Structures_F_Mil_Barracks",
				"A3_Structures_F_Mil_Bunker",
				"A3_Structures_F_Mil_Cargo",
				"A3_Structures_F_Mil_Fortification",
				"A3_Structures_F_Mil_Offices",
				"A3_Structures_F_Mil_Radar",
				"A3_Structures_F_Mil_Shelters",
				"A3_Structures_F_Mil_TentHangar",
				"A3_Structures_F_Research",
				"A3_Structures_F_EPA_Mil_Scrapyard",
				"A3_Armor_F_AMV",
				"A3_Boat_F_Boat_Armed_01",
				"A3_Boat_F_Boat_Transport_01",
				"A3_Soft_F_Crusher_UGV",
				"A3_Air_F_Gamma_UAV_01",
	"A3_Modules_F_Curator_Objectives",
	"A3_Structures_F_Ind_Transmitter_Tower",
	"A3_Armor_F_Panther",
	"A3_Armor_F_EPC_MBT_01",
	"A3_Air_F_Beta_Heli_Transport_01",
	"A3_Boat_F_SDV_01",
	"A3_Characters_F_Common"
];
if (!(NO_TWS || TVT_AMMO_BOX)) then {_WEST = _WEST + ["A3_Weapons_F_Ammoboxes","A3_Weapons_F_Gamma_Ammoboxes","A3_Weapons_F_NATO","A3_Weapons_F_EPA_Ammoboxes","A3_Weapons_F_EPB_Ammoboxes"]};
_WEST = _WEST + _WEAPONS;
if (!SINGLE_CO_MODE) then {[b_zeus,_WEST] call bis_fnc_manageCuratorAddons};
//_y = [_WEST,"ods"] spawn bis_fnc_exportCuratorCostTable;

// BLUFOR Zeus Addons
_WESTAIR = [
	"A3_Air_F_Beta_Heli_Transport_01",
	"A3_Air_F_Heli_Light_01",
	"A3_Air_F_Beta_Heli_Attack_01",
	"A3_Modules_F_Curator_Misc",
	"A3_Characters_F_BLUFOR",
	"A3_Soft_F_HEMTT",
	"A3_Soft_F_Gamma_HEMTT",
	"A3_Modules_F_Curator_Flares",
	"A3_Modules_F_Curator_Chemlights",
	"A3_Modules_F_Curator_Smokeshells",
	"A3_Air_F_Gamma_UAV_01",
	"A3_Air_F_Gamma_UAV_02",
	"A3_Structures_F_Mil_Helipads",
	"A3_Modules_F_Curator_Objectives",
	"A3_Air_F_EPC_Plane_CAS_01",
	"A3_Characters_F_Common"
];
if (SINGLE_CO_MODE) then {
	_WEST = _WEST + _WESTAIR;
	[b_zeus,_WEST] call bis_fnc_manageCuratorAddons;
} else { [b_ATC,_WESTAIR] call bis_fnc_manageCuratorAddons};
//_y = [_WESTAIR,"ods"] spawn bis_fnc_exportCuratorCostTable;

// INDFOR Zeus Addons
_GUER = [
	"A3_Modules_F_Curator_Misc",
	"A3_Modules_F_Curator_Objectives",
	"A3_Characters_F_INDEP",
	//"A3_Characters_F_Civil",
	"A3_Signs_F",
	"A3_Static_F_Gamma",
	"A3_Soft_F_Offroad_01",
	"A3_Soft_F_Quadbike",
	"A3_Soft_F_MRAP_03",
	"A3_Soft_F_TruckHeavy",
	"A3_Soft_F_Gamma_Offroad",
	"A3_Soft_F_Gamma_TruckHeavy",
	"A3_Soft_F_Truck",
	"A3_Soft_F_Car",
	"A3_Modules_F_Curator_Flares",
	"A3_Modules_F_Curator_Chemlights",
	"A3_Modules_F_Curator_Mines",
	"A3_Modules_F_Curator_Ordnance",
	"A3_Modules_F_Curator_Smokeshells",
	"A3_Boat_F_Beta_Boat_Armed_01",
	"A3_Boat_F_Boat_Transport_01",
	"A3_Armor_F_APC_Wheeled_03",
	"A3_Static_F_Mortar_01",
	//new additions 1.1
	"A3_Air_F_EPB_Heli_Light_03",
	"A3_Armor_F_EPB_APC_tracked_03",
	//statics
	"A3_Static_F_Gamma_AA",
	"A3_Static_F_Gamma_AT",
	"A3_Armor_F_EPB_MBT_03"

];
if (!(NO_TWS || TVT_AMMO_BOX)) then {_GUER = _GUER + ["A3_Weapons_F_Ammoboxes","A3_Weapons_F_AAF","A3_weapons_F_FIA","A3_Weapons_F_EPA_Ammoboxes","A3_Weapons_F_EPB_Ammoboxes"]};
_GUER = _GUER + _WEAPONS;
[i_zeus,_GUER] call bis_fnc_manageCuratorAddons;

//_y = [_GUER,"ods"] spawn bis_fnc_exportCuratorCostTable;