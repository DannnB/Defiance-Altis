private ["_hqs","_hq","_towns","_town"];

// Phrases the Civs will use. %1 is the name of the town
_civText = ["You should investigate %1","I heard the AAF were operating in %1","I saw guys in uniforms near %1","I heard gunfire coming from %1 earlier","My friend was attacked by thugs in uniforms. He lives near %1. Please help"];

_civ = _this select 0;
_actionId = _this select 2;

_interviewed = _civ getVariable ["interview",false];
if (!_interviewed) then {
	_hqs = _civ nearEntities [INDFOR_HQ_UNIT, CIV_INTEL_RANGE];
	_hqs = [_hqs] call cmn_rmv_inactive_Hqs_from_array;
	if (count _hqs > 0 && random 100 <= CIV_INTEL_CHANCE) then
	{
		//Find closet town to the civ
		_hq = _hqs select 0;
		_towns = nearestLocations [getPos _hq, ["NameVillage","NameCity","NameCityCapital"], CIV_INTEL_RANGE];
		if (count _towns > 0) then
		{
			_town = _towns select 0;
	        titleText [format[_civText select (floor (random (count _civText))),text _town], "PLAIN DOWN"];
			hintSilent format["%2 is in grid: %1",mapGridPosition (position _town),text _town];
			_hqPos = getPos _hq;
			_numOfIntel = _hq getVariable ["intelNum",0];
			[_hq,true] call createHouseIntelMarker;
			_hq setVariable ["intelNum",_numOfIntel+1,true];
		}
		else
		{
			titleText ["Let me mark a location on your map", "PLAIN DOWN"];
			_marker = createMarkerLocal [str(time), getPos _hq];
			_marker setMarkerTypeLocal "hd_flag";
			_marker setMarkerColorLocal "ColorGreen";
		};
	}
	else
	{
		//check for false intel
		if (random 100 <= CIV_FALSE_INTEL_CHANCE && FAKE_INTEL) then
		{
	        _array = [_civ,false] call createHouseIntelMarker;
	        if (count _array > 0) then
	        {
		        _pos = getMarkerPos (_array select (((count _array)-1) max 0));
		        _towns = nearestLocations [_pos, ["NameVillage","NameCity","NameCityCapital"], CIV_INTEL_RANGE];
		        _town = _towns select 0;
		        titleText [format[_civText select (floor (random (count _civText))),text _town], "PLAIN DOWN"];
				hintSilent format["%2 is in grid: %1",mapGridPosition (position _town),text _town];
			};
		}
		else
		{
			titleText ["Sorry I haven't seen or heard anything suspicious around here", "PLAIN DOWN"];
		};
	};
//Stop him from talking
	_civ setVariable ["interview",true,true];
} else {
	titleText ["Sorry I already spoke with one of the other soldiers", "PLAIN DOWN"];
};

//remove action
_civ removeAction _actionId;