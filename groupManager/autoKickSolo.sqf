// Every "Krok_solo_check_intervals" seconds, remove solo group leaders(after period of "Krok_solo_timeout" seconds):

private ["_scriptHandle","_groupSide","_grpArray","_soloGrpArray"];
if(isServer) then{
	while{Krok_solo_check_intervals != 0}do{
		_grpArray = [alphaGroup1, alphaGroup2, alphaGroup3, bravoGroup1, bravoGroup2, bravoGroup3, charlieGroup1, charlieGroup2, charlieGroup3,
		alphaOGroup1, alphaOGroup2, alphaOGroup3, bravoOGroup1, bravoOGroup2, bravoOGroup3, charlieOGroup1, charlieOGroup2, charlieOGroup3,
		alphaIGroup1, alphaIGroup2, alphaIGroup3, bravoIGroup1, bravoIGroup2, bravoIGroup3, charlieIGroup1, charlieIGroup2, charlieIGroup3];
		_soloGrpArray = [];
		
			 // Populate the array with groups that need solo leaders removed:
			{
				if(count units _x == 1)then{
					_soloGrpArray set [count _soloGrpArray, _x];
				};
			}forEach _grpArray;
			
			// Wait "Krok_solo_timeout" seconds (so that if a player joins a group, and then the removal script runs that same second, he won't be immediately kicked out):
			uisleep Krok_solo_timeout;
			
			{
			_groupSide = side _x;
				if(count units _x == 1)then{
					[leader _x] joinSilent grpNull;
					
					// After kicking group leader, have to make sure the group is re-initialised as it has been left empty (and thus is now a null group)
					// This is done through BIS_fnc_MP function so that only the server is responsible for groups being created.
					switch (_groupSide) do {
					  case west: {
							_scriptHandle = [[[1],"eutw_gui\groupManager\defineGroups.sqf"],"BIS_fnc_execVM",false, false] spawn BIS_fnc_MP;
							waitUntil {scriptDone _scriptHandle};
					  };
					  case east: {
							_scriptHandle = [[[2],"eutw_gui\groupManager\defineGroups.sqf"],"BIS_fnc_execVM",false, false] spawn BIS_fnc_MP;
							waitUntil {scriptDone _scriptHandle};
					  };
					  case resistance: {
							_scriptHandle = [[[3],"eutw_gui\groupManager\defineGroups.sqf"],"BIS_fnc_execVM",false, false] spawn BIS_fnc_MP;
							waitUntil {scriptDone _scriptHandle};
					  };
					};
				};
			}forEach _soloGrpArray;
			
			// Wait "Krok_solo_check_intervals" seconds before running this script again (to reduce server load):
			uisleep Krok_solo_check_intervals;
	};
};