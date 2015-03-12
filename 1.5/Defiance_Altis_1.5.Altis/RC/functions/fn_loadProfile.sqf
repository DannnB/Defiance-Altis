/*
	File: fn_loadProfile.sqf
	Author: Nashable (@m_nash)

	Description:
	Load Roll Call Variables from Profile
*/
systemChat "ROLL CALL: Loading Profile";
["rollcall_version"] call RC_fnc_LoadStat;
["rollcall_xp"] call RC_fnc_LoadStat;
["rollcall_pref"] call RC_fnc_LoadStat;
["rollcall_hasMic"] call RC_fnc_LoadStat;
["rollcall_rank"] call RC_fnc_LoadStat;
systemChat "ROLL CALL: Profile Loading Complete";