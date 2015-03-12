/*
	File: fn_getRankLevel.sqf
	Author: Nashable (@m_nash)

	Description:
	Used to calculate how many hours played is required for the next level
*/
_rankLevel = _this select 0;
_y = 1e10;
if (_rankLevel < 8) then
{
	//Rank Progression
	_y = round ((10*exp(0.6593*_rankLevel))-10);
	//systemChat format ["DEBUG: RANK %1 TIME CALC %2",_rankLevel, _y];
};
_y