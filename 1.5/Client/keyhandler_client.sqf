private['_handled'];
_handled = false;
switch (_this select 1) do
{
	//L key
	case 38:
	{
		{
			if (vehicle _x isKindOf "Helicopter") then
			{
				deleteWaypoint [driver vehicle _x, all];
				vehicle _x land "Land";
			};
		} forEach curatorSelected;
		_handled = true;
	};
};
hint str(_this select 1);
_handled;