// Variables:

Krok_minimum_lock_size = 2;			// The minimum number of people needed in a squad before it can be locked.
Krok_maximum_group_size = 6;	   	// The maximum number of people that a squad can hold.
Krok_solo_check_intervals = 0;		// The time between server checks for solo group leaders (if set to 0 then solo group leaders are not removed).
Krok_solo_timeout = 30;				// How long the server waits to remove them.
Krok_refresh_time = 1;			// The time in seconds between each dialog refresh.

Krok_Custom_GrpNames = false;		// Use custom group names (if false then defaults are Alpha, Bravo and Charlie).

// The custom group names to be used if Krok_Custom_GrpNames = true.
// Format is [west, east, independent]:
Krok_grpName_1 = ["Alpha-1", "Alef-1", "Alpha-1"];
Krok_grpName_2 = ["Alpha-2", "Alef-2", "Alpha-2"];
Krok_grpName_3 = ["Alpha-3", "Alef-3", "Alpha-3"];

Krok_grpName_4 = ["Bravo-1", "Be-1", "Beta-1"];
Krok_grpName_5 = ["Bravo-2", "Be-2", "Beta-2"];
Krok_grpName_6 = ["Bravo-3", "Be-3", "Beta-3"];

Krok_grpName_7 = ["Charlie-1", "Pe-1", "Gamma-1"];
Krok_grpName_8 = ["Charlie-2", "Pe-2", "Gamma-2"];
Krok_grpName_9 = ["Charlie-3", "Pe-3", "Gamma-3"];


/*
 If you want to change any of the colours in the group manager:
 
1. Go to the "groupManagerDefinitions.hpp" file.

2. Find under each class (e.g. class RscTextGrMn) the variables that start with "color", e.g.:
	colorBackground[] = {0.4765,0.5,0.3515,1};
    colorText[] = {1,1,1,1};
	
3. Edit these numbers, bearing in mind the format is [r, g, b, a].



If you want to change the key binds for bringing up the dialog:

1. Go to the "groupScriptInit.sqf" file.

2. Find the section commented by "KEY BINDINGS AREA".

3. In this area find this line: "if (((_key == 20 && _this select 3) or (_key == 35 && _this select 3)))"

4. You can change the key numbers to anything you want. Keys are in this format: https://community.bistudio.com/wiki/ListOfKeyCodes
	_shiftState =  _this select 2; // boolean
	_ctrlState =   _this select 3; // boolean
	_altState =    _this select 4; // boolean
	
	
	
If you want to change any of the header, footer or help text in the dialog:

1. Go to the "groupManagerDialogs.hpp" file.

2. Find the class for what you want to change, and edit this line:
	text="Example of text.";
	
3. Be aware that button and group name text is sometimes edited through methods, so editing that will have unpredictable effects.
*/