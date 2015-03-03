_case = _this select 0;
_actionId = _this select 2;

intelfound = true;
intelOwner = player;
intelLocation = getPos _case;
	
deleteMarker (_case getVariable "marker");
deleteVehicle _case;
	
publicvariable "intelOwner";
publicvariable "intelfound";
publicvariable "intelLocation";