/*
	File: fn_broadcastStat.sqf
	Author: Nashable (@m_nash)

	Description:
	Transmit var to other players
*/
_varName = _this select 0;
_value = _this select 1;
player setVariable [_varName,_value,true];