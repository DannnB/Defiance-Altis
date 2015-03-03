/*
	File: fn_initProfile.sqf
	Author: Nashable (@m_nash)

	Description:
	Init named var for starting profile
*/
_varName = (_this select 0);
switch (_varName) do
{
    case "rollcall_xp":
    {

    	//["rollcall_xp",ROLLCALL_XP_DEFAULT_VALUES] call RC_fnc_BroadcastStat;
        player setVariable ["rollcall_xp",ROLLCALL_XP_DEFAULT_VALUES];
    };
    case "rollcall_pref":
    {
    	//["rollcall_pref","None"] call RC_fnc_BroadcastStat;
        player setVariable ["rollcall_pref",-1];
    };

    case "rollcall_hasMic":
    {
    	//["rollcall_hasMic",false] call RC_fnc_BroadcastStat;
        player setVariable ["rollcall_hasMic",false];
    };

    case "rollcall_version":
    {
        //["rollcall_version",-1] call RC_fnc_BroadcastStat;
        player setVariable ["rollcall_version",RC_DATA_VERSION];
    };

    case "rollcall_rank":
    {
        //["rollcall_version",-1] call RC_fnc_BroadcastStat;
        player setVariable ["rollcall_rank",0];
        ["rollcall_rank",0] call RC_fnc_saveStat;
    };


    default
    {
     	/* STATEMENT */
    };
};