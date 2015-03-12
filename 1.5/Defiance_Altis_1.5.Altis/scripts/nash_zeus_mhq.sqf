mhqAnnounce = {
	[west, "hq"] sideChat "Our MHQ has been destroyed. Preparing new MHQ";
	sleep 60;
	[west, "hq"] sideChat "MHQ Deployed";
};

while {true} do
{
	//create the MHQ
	_grp = createGroup west;
	_spawnLoc = getMarkerPos "b_mhq_spawn";
	b_mhq = createVehicle [BLUFOR_MHQ_TYPE, _spawnLoc, [], 0, "NONE"];
	_driver = _grp createUnit ["B_officer_F", _spawnLoc, [], 0, "NONE"];
	_driver moveInDriver b_mhq;
	if (MHQ_TICKETS > 0) then
	{
		_gunner = _grp createUnit ["B_officer_F", _spawnLoc, [], 0, "NONE"];
		_gunner moveInGunner b_mhq;
	};
	b_mhq lock true;
	b_mhq setDir (markerDir "b_mhq_spawn");
	if (MHQ_TICKETS == -1) then {b_mhq allowDamage false};
	publicvariable "b_mhq";
	_locked = true;
	b_zeus addCuratorEditableObjects [[b_mhq],true];
	if (VIRTUAL_AMMO_BOX_MHQ) then {[[b_mhq,"<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf", nil, 6, True, True, "", "",nil,nil,nil,nil], "addGlobalAction", true, false] spawn BIS_fnc_MP;};

	if (MHQ_TICKETS > 0) then
	{
		b_mhq addMPEventHandler ['mpkilled', format['[] spawn { [west, "hq"] sideChat "Our MHQ has been destroyed. We lost %1 tickets! Preparing new MHQ";
			[resistance, "hq"] sideChat "We destroyed the enemy MHQ, they have lost %1 tickets as a result";
			["MHQDestroyed",["%1"]] call bis_fnc_showNotification;
			sleep 60;
			[west, "hq"] sideChat "MHQ Deployed";};',MHQ_TICKETS]];
	};
	//TODO: Create and Delete respawn_west
	_oldPos = _spawnLoc;
	while { alive b_mhq } do
	{
		_mhqCPos = getPos b_mhq;
		if (_mhqCPos distance _oldPos > 0) then {
			_mhqNWPos = [(_mhqCPos select 0)-45,(_mhqCPos select 1)+45,(_mhqCPos select 2)];
			_mhqNPos = [(_mhqCPos select 0),(_mhqCPos select 1)+45,(_mhqCPos select 2)];
			_mhqNEPos = [(_mhqCPos select 0)+45,(_mhqCPos select 1)+45,(_mhqCPos select 2)];
			_mhqEPos = [(_mhqCPos select 0)+45,(_mhqCPos select 1),(_mhqCPos select 2)];
			_mhqSEPos = [(_mhqCPos select 0)+45,(_mhqCPos select 1)-45,(_mhqCPos select 2)];
			_mhqSPos = [(_mhqCPos select 0),(_mhqCPos select 1)-45,(_mhqCPos select 2)];
			_mhqSWPos = [(_mhqCPos select 0)-45,(_mhqCPos select 1)-45,(_mhqCPos select 2)];
			_mhqWPos = [(_mhqCPos select 0)-45,(_mhqCPos select 1),(_mhqCPos select 2)];

			b_zeus addCuratorEditingArea [2,_mhqNWPos,35];
			b_zeus addCuratorEditingArea [3,_mhqNPos,35];
			b_zeus addCuratorEditingArea [4,_mhqNEPos,35];
			b_zeus addCuratorEditingArea [5,_mhqEPos,35];
			b_zeus addCuratorEditingArea [6,_mhqSEPos,35];
			b_zeus addCuratorEditingArea [7,_mhqSPos,35];
			b_zeus addCuratorEditingArea [8,_mhqSWPos,35];
			b_zeus addCuratorEditingArea [9,_mhqWPos,35];
			_oldPos = _mhqCPos;
		};
		if (((!(alive _driver)) || (!(canMove b_mhq))) && _locked) then { b_mhq lock false; _unlocked = false; publicvariable "b_mhq";};
		sleep 1;
	};
	b_zeus removeCuratorEditingArea 2;
	if (MHQ_TICKETS > 0) then
	{
		_tickets = [west,(-1)*MHQ_TICKETS] call BIS_fnc_respawnTickets;
	};
	sleep 60;
};