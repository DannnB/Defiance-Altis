////////////////////////////////////////////////////////
// "GROUP MANAGEMENT GUI" by -[EUTW]- KroKodile, v1.4
// This group management script is licensed under:
// Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
// Details: http://creativecommons.org/licenses/by-nc-sa/4.0/
////////////////////////////////////////////////////////



How to use:

- Use ctrl-t or ctrl-h to open the dialog (and "u" to switch between playable characters to join other people to groups).

- You can change script parameters in the "variableDefinitions.sqf" script.

- Click on the "?" button at the top right in the dialog for more help.




To integrate with any mission:

1. Paste the "KroKodile" folder into your mission directory.

2. Add this to your "init.sqf":

	[] call compile PreProcessFile "eutw_gui\groupManager\groupScriptInit.sqf";

3. Add this to your "description.ext":

	#include "eutw_gui\groupManager\Dialogs\groupManagerDefinitions.hpp"
	#include "eutw_gui\groupManager\Dialogs\groupManagerDialogs.hpp"
	
4. It should be working now (if not, download the test mission in the ArmaGroupGUI repository and see what's different or leave me a message on github).



KNOWN BUGS:

- Loading a saved game will not init the group manager for the server.
- If you have the dialog open as you respawn, it will clear everything from the lists, requiring the player to re-open it to fix.
- If a player disconnects and he was the last one in the group, the group will not get reinitialised until someone presses a join button.
- If a player exits the dialog as "refreshLists.sqf" is running, a script error message will show (even though it all exits correctly).
