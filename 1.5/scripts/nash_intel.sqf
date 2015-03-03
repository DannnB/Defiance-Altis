createIntel = {
	_lt = _this select 0;
	_id = _this select 1;
	_map = "Land_Map_altis_F";

	if (isServer) then {
		_case = _map createVehicle position (_lt);
		_case allowDamage false;
		_case addAction["Gather Intel", "scripts\nash_grab_intel.sqf", nil, 6, True, True, "", "(_target distance _this) < 3"];
		_marker = createMarker ["intel_" + str(time), getPos _case];
		_marker setMarkerType "hd_unknown";
		_marker setMarkerColor "ColorYellow";
		_case setVariable ["marker", _marker, true];
	};
	if (side player == resistance) then { deleteMarkerLocal _marker;};

	i_zeus removeCuratorEditingArea _id;
	deleteMarker format["respawn_guerrila%1",_id];

	[west, "hq"] sideChat "Enemy Officer has been KIA. Location marked on map.";
	[resistance, "hq"] sideChat "The Enemy has killed one of our Officers";
};
/* Old Pickup Intel
pickupIntel = {

//determine the next clue for civ intel
		_nextCivIntel = "";
		_lts = intelOwner nearEntities ["I_officer_F", 25000];
		if (count _lts == 0) exitWith {};
		_towns = nearestLocations [getPos (_lts select 0), ["NameVillage","NameCity","NameCityCapital"], (intelRange*0.75)];
		if (count _towns > 0) then
		{
			_nextCivIntel = position (_towns select ((count _towns) -1));
		}
		else
		{
			_nextCivIntel = position (_lts select 0);
		};
		if (side player == west) then
		{
			//civ intel

			_marker = createMarkerLocal ["civintel" + str(time), _nextCivIntel];
			_marker setMarkerTypeLocal "hd_flag";
			_marker setMarkerColorLocal "ColorWhite";
			_marker setMarkerTextLocal "Possible Intel (Interview Civs)";

			zeusTrackingTime = time + 1800;
			[nil, 'zeusTracking', west, false] spawn BIS_fnc_MP;
			[west,"hq"] sideChat format ["%1 retrieved the intel. We can now track the enemy leader for 30 minutes or until we claim the bounty.",name intelOwner];
			sleep 5;
			[west,"hq"] sideChat "Intel also gave us a possible lead on a new area of operations. Check map for details.";
		};

};
*/