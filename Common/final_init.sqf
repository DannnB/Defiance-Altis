/////////////////
//FINAL COMMON MISSION INIT
/////////////////
if (ALLOW_SAVING) then
{
	enableSaving [true, true];
} else { enableSaving [false, false]};

/////////////////
//COMMON LOCAL VARS
/////////////////
intelfound = false;
intelOwner = player;
zeusBounty = 0;
zeusTrackingTime = 0;
intelLocation = objNull;
playerCOs = [];
playerOfficers = [];

//DEBUG
//_debugTeleport = createTrigger["EmptyDetector",getPos player];
//_debugTeleport setTriggerActivation["ALPHA","PRESENT",true];
//_debugTeleport setTriggerStatements["this", "onMapSingleClick 'player setPos _pos'", ""];
//_debugTeleport setTriggerStatements["this", "hintC format ['%1', BLUFOR_ZEUS_UNITS select 0];", ""];
//_debugTeleport setTriggerStatements["this", "hintC format ['%1', curatoreditingarea (INDFOR_ZEUS_LOGIC select 0)];", ""];
//[_zeus,[resistance],0.01,0.5,0.9,0.1,0.1] call bis_fnc_curatorAutomatic;

//ZEUS COST TABLES
#include "cfg_costTable.sqf";
