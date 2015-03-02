//onLoad = "[_this, 'onLoad'] ExecVM 'GUI\GUI_status.sqf'";

disableSerialization;
if (_this select 1 == 'onLoad') then
{
	_dialog = (_this select 0) select 0;
	(_dialog displayCtrl 1102) ctrlSetText "Not Active in this Mission";
	while {!isNull findDisplay 300} do
	{

		//blu vars
		_bluforNumPlayers = playersNumber west;
		_bluforPlayers = "";
		_bluforCoText = "";
		_bluforupkeep = 100-((b_zeusUpKeep/BLUFOR_ZEUS_UPKEEP_BASE)*100);
		_tickets = [west] call BIS_fnc_respawnTickets;

		//ind vars
		_indforNumPlayers = playersNumber resistance;
		_indforPlayers = "";
		_indforCoText = "";
		_indforupkeep = 100-((i_zeusUpKeep/INDFOR_ZEUS_UPKEEP_BASE)*100);
		if (isNil "CURRENT_NUM_AAF_HQ") then {CURRENT_NUM_AAF_HQ = "Updating"};
		_hqLeft = CURRENT_NUM_AAF_HQ;
		//global vars
		//_civdeaths = tpw_civ_allcas;
		_civText = format ["%1/%2",tpw_civ_allcas,tpw_civ_maxallcas];
		if (tpw_civ_allcas > tpw_civ_maxallcas) then {_civText = "<t color='#c42726'>Next Kill = Penalty</t>"};
		{
			_colorcodeStart = "";
			_colorcodeEnd = "";
			if (group _x == group player) then {_colorcodeStart = "<t color='#99FF00'>"; _colorcodeEnd = "</t>"};
			_name = format ["%1%2%3",_colorcodeStart,name _x,_colorcodeEnd];
			switch (side _X) do
			{
			    case west:
			    {
			    	if (_x in playerOfficers) then
					{

						_text = format["<br/>* %1: %2",_name,_x getVariable ["role", ""]];
						_bluforCoText = _bluforCoText + _text;
					} else {
						_bluforPlayers = _bluforPlayers + _name +", ";
					};
			    };

			    case resistance:
			    {

			     	if (_x in playerOfficers) then
					{


						_text = format["<br/>* %1: %2",_name,_x getVariable ["role", ""]];
						_indforCoText = _indforCoText + _text;
					} else {
						_indforPlayers = _indforPlayers + _name +", ";
					};
			    };
			};
		} foreach playableUnits;

		_bluforPlayers = [_bluforPlayers,0,-2] call BIS_fnc_trimString;
		_indforPlayers = [_indforPlayers,0,-2] call BIS_fnc_trimString;

		_bluforStatus = format["
		# HQs left to deactivate: %1<br/>
		Team Tickets Remaining: %2<br/>
		Hades Bounty Level: %9<br/>
		Team Upkeep: %3<br/>
		Civ Casualties: %4<br/>
		Total # Players on Team: %6<br/>
		<br/>Team Officers: %7<br/>
		<br/>Other Players on the Team:<br/>%8
		",_hqLeft,_tickets,_bluforupkeep,_civText,"",_bluforNumPlayers,_bluforCoText,_bluforPlayers,zeusBounty];

		_isAdmin = serverCommandAvailable "#kick";
		_automatedUnitNum = "";
		if (_isAdmin) Then { _automatedUnitNum = format ["Automated Zeus Groups: %1<br/>",{ _x getvariable ["BIS_fnc_curatorAutomatic",false]} count allGroups]};

		_indforStatus = format["
		Nato Kills remaining to win: %2<br/>
		# HQs left to defend: %1<br/>
		Hades Bounty Level: %9<br/>
		Team Upkeep: %3<br/>
		Civ Casualties: %4<br/>
		Total # Players on Team: %6<br/>
		%10
		<br/>Team Officers: %7<br/>
		<br/>Other Players on the Team:<br/>%8
		",_hqLeft,_tickets,_indforupkeep,_civText,"",_indforNumPlayers,_indforCoText,_indforPlayers,zeusBounty,_automatedUnitNum];

		(_dialog displayCtrl 1100) ctrlSetStructuredText parsetext _bluforStatus;
		(_dialog displayCtrl 1101) ctrlSetStructuredText parsetext _indforStatus;
		sleep 5;
	};
};