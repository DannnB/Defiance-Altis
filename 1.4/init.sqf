[] call compileFinal PreProcessFile "scripts\outlw_magRepack\MagRepack_init_sv.sqf";
[] call compileFinal PreProcessFile "scripts\zlt_fastrope.sqf";
[] call compileFinal PreProcessFile "scripts\group_manager.sqf";
[] call compile PreProcessFile "groupManager\groupScriptInit.sqf";

// forEach selects all units in an array, eg all players
{ _x enableFatigue false; } forEach (player);

// MOTD
[] call compileFinal preprocessFile "scripts\motdRCG.sqf"


// Might be fun to do somethign with...
// player addEventHandler ["HandleDamage", { hint format ["You just sustained %1%2 damage!", ceil ((_this select 2) * 100), "%"]; }];
