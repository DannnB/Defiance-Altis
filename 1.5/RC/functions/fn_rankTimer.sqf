/*
	File: fn_rankTimer.sqf
	Author: Nashable (@m_nash)

	Description:
	Loop to update the time the player has spent playing a Roll Call enabled mission
*/
_time = profileNameSpace getVariable ["RC_TIMEPLAYED",0];
systemChat format ["ROLL CALL: You currently have %1 hours played on file", _time];
_rank = player getVariable ["rollcall_rank",0];
_nextLevel = [_rank+1] call RC_fnc_getRankLevel;
systemChat format ["ROLL CALL: You will recieve a promotion in %1 hours", (_nextLevel-_time)];
while {true} do {
	//Check at the start and every hour
	if (_time > _nextLevel) then
	{
		_rank = _rank + 1;
		systemChat format ["ROLL CALL: Congratulations, you have been promoted to the rank of %1!", [_rank,"displayName"] call BIS_fnc_rankParams];
		systemChat "This announcement is just placeholder for now. There will be better notifications in the future";
		["rollcall_rank",_rank] call RC_fnc_saveStat;
		_nextLevel = [_rank+1] call RC_fnc_getRankLevel;
		_time = profileNameSpace getVariable "RC_TIMEPLAYED";
	};
	// loop in 6 minute intervals, 10 times before checking again
	for [{_i=0}, {_i<10}, {_i=_i+1}] do
	{
		sleep 360;
		_time = _time + 0.1; // save 6 mins to lifetime
		profileNameSpace setVariable ["RC_TIMEPLAYED",_time];
	};

};