#include "resource.h"

class ROLCALL_XP_MENU
{
	idd = 88100;
	name = "ROLLCALL_XP_MENU";
	movingEnabled = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable ['ROLCALL_XP_MENU', (_this select 0)];[] call RC_fnc_mainDisplay;";
	class controlsBackground
	{
		class RC_MAIN_BG: RC_IGUIBack
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.3};
			x = 0.0771875 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.830156 * safezoneW;
			h = 0.77 * safezoneH;
		};
		class RC_FRAME: RC_RscFrame
		{
			idc = 1800;
			x = 0.0771875 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.830156 * safezoneW;
			h = 0.77 * safezoneH;
		};
		class RC_TXT_BG: RC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.3};
			x = 0.0926558 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.799219 * safezoneW;
			h = 0.64 * safezoneH;
			text = "";
		};
	};

	class Controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nash, v1.063, #Gamike)
		////////////////////////////////////////////////////////
		
		class RC_BACK: RC_RscButton
		{
			idc = 2200;
			text = "Back";
			action = "closeDialog 0";
			x = 0.0926562 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_LNB_XP_HEAD: RC_RscListNbox
		{
			idc = 1499;
			access = 0;
			//style = LB_MULTI;
			x = 0.0926558 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.799219 * safezoneW;
			h = 0.050 * safezoneH;
			colorText[] = {1,1,1,1.0};
			colorDisabled[] = {1,1,1,1};
			text = "";
			sizeEx = 0.03;
			columns[] = {0,0.02,0.05,0.10,0.25,0.30,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.72,0.77,0.82,0.87,0.93,0.97};
			drawSideArrows = false;
			idcLeft = -1;
			idcRight = -1;
			rowHeight = 0.050;
		};
		class RC_LNB_XP: RC_RscListNbox
		{
			idc = 1500;
			colorBackground[] = {0,0,0,0.3};
			x = 0.0926558 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.799219 * safezoneW;
			h = 0.61 * safezoneH;
			text = "";
			sizeEx = 0.03;
			//columns[] = {0,0.02,0.12,0.17,0.22,0.27,0.32,0.37,0.42,0.47,0.52,0.57,0.62,0.67,0.72,0.77,0.82,0.87};
			columns[] = {0,0.02,0.05,0.10,0.25,0.30,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.72,0.77,0.82,0.87,0.93,0.97};
			drawSideArrows = false;
			idcLeft = -1;
			idcRight = -1;
			rowHeight = 0.050;
		};
		class RC_COMBO_SORT: RC_RscCombo
		{
			idc = 2100;
			x = 0.0926562 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RC_BUT_PROFILE: RC_RscButtonMenu
		{
			idc = 1600;
			text = "Update Profile"; //--- ToDo: Localize;
			x = 0.226718 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.077 * safezoneH;
			action = "_handle = CreateDialog 'ROLCALL_XP_PROFILE'";
		};
		class RC_BUT_GROUPS: RC_RscButtonMenu
		{
			idc = 1601;
			text = "Group Management"; //--- ToDo: Localize;
			action = "_handle = CreateDialog 'ROLLCALL_XP_GROUPS'";
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.077 * safezoneH;
			
		};
		/*class RC_BUT_GMANAGE: RC_RscButtonMenu
		{
			idc = 1602;
			text = "Manage Your Group"; //--- ToDo: Localize;
			x = 0.402032 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.077 * safezoneH;
		};*/
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

		/* #Gamike
		$[
			1.063,
			["RollCall",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
			[1000,"",[2,"",["-21 * GUI_GRID_W + GUI_GRID_X","-5.5 * GUI_GRID_H + GUI_GRID_Y","80.5 * GUI_GRID_W","35 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
			[1800,"RC_FRAME",[1,"",["0.0771875 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.830156 * safezoneW","0.77 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
			[2200,"RC_BACK",[1,"Back",["0.0926562 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
			[1500,"RC_LNB_XP",[1,"",["0.0926558 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.799219 * safezoneW","0.627 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
			[2100,"RC_COMBO_SORT",[1,"",["0.0926562 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.113437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
			[1600,"RC_BUT_PROFILE",[1,"Update Profile",["0.226718 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0773437 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
			[1601,"RC_BUT_GROUPS",[1,"Group Management",["0.314375 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0825 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
		]
		*/
	};
};

class ROLCALL_XP_PROFILE
{
	idd = 88200;
	name = "ROLCALL_XP_PROFILE";
	movingEnabled = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable ['ROLCALL_XP_PROFILE', (_this select 0)];[] call RC_fnc_updateProfileDisplay;";
	class controlsBackground
	{
		class RC_MAIN_BG: RC_IGUIBack
		{
			idc = -1;
			x = 0.159687 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.603281 * safezoneW;
			h = 0.77 * safezoneH;
		};
		class RC_FRAME: RC_RscFrame
		{
			idc = 1800;
			x = 0.159687 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.603281 * safezoneW;
			h = 0.77 * safezoneH;
		};
	};

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nash, v1.063, #Xakina)
		////////////////////////////////////////////////////////
		class RC_LB_NONE: RC_RscListbox
		{
			idc = 1500;
			style = LB_MULTI;
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.528 * safezoneH;
		};
		class RscText_1001: RC_RscText
		{
			idc = 1001;
			text = "None / Unassigned"; //--- ToDo: Localize;
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscPicture_1200: RC_RscPicture
		{
			idc = 1200;
			text = "RC\img\0star.paa";
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.20 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.03 * safezoneH;
		};
		class RscPicture_1201: RC_RscPicture
		{
			idc = 1201;
			text = "RC\img\1star.paa";
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.20 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.03 * safezoneH;
		};
		class RscPicture_1202: RC_RscPicture
		{
			idc = 1202;
			text = "RC\img\2star.paa";
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.20 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.03 * safezoneH;
		};
		class RscPicture_1203: RC_RscPicture
		{
			idc = 1203;
			text = "RC\img\3star.paa";
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.20 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.03 * safezoneH;
		};
		class RscPicture_1205: RC_RscPicture
		{
			idc = 1205;
			text = "RC\img\4star.paa";
			x = 0.665 * safezoneW + safezoneX;
			y = 0.20 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.03 * safezoneH;
		};
		class RC_LB_1STAR: RC_RscListbox
		{
			idc = 1501;
			style = LB_MULTI;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.528 * safezoneH;
		};
		class RC_LB_2STAR: RC_RscListbox
		{
			idc = 1502;
			style = LB_MULTI;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.528 * safezoneH;
		};
		class RC_LB_3STAR: RC_RscListbox
		{
			idc = 1503;
			style = LB_MULTI;
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.528 * safezoneH;
		};
		class RC_LB_4STAR: RC_RscListbox
		{
			idc = 1504;
			style = LB_MULTI;
			x = 0.665 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.528 * safezoneH;
		};
		class RscButton_1600: RC_RscButton
		{
			idc = 1600;
			action = "[0,1,false] call RC_fnc_sendProfileListBoxData;";
			text = "> Limited"; //--- ToDo: Localize;
			style = ST_LEFT;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscButton_1601: RC_RscButton
		{
			idc = 1601;
			action = "[0,2,false] call RC_fnc_sendProfileListBoxData;";
			text = "> Competent"; //--- ToDo: Localize;
			style = ST_LEFT;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscButton_1602: RC_RscButton
		{
			idc = 1602;
			action = "[0,3,false] call RC_fnc_sendProfileListBoxData;";
			text = "> Experienced"; //--- ToDo: Localize;
			style = ST_LEFT;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscButton_1603: RC_RscButton
		{
			idc = 1603;
			style = ST_LEFT;
			action = "[0,4,false] call RC_fnc_sendProfileListBoxData;";
			text = "> Elite"; //--- ToDo: Localize;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		/*class RscButton_1604: RC_RscButton
		{
			idc = 1604;
			text = "Mic: No"; //--- ToDo: Localize;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};*/
		class RC_TXT_PREF_ROLE: RC_RscText
		{
			idc = 1007;
			text = "Preferred Role"; //--- ToDo: Localize;
			//x = 0.175156 * safezoneW + safezoneX;
			//y = 0.786 * safezoneH + safezoneY;
			x = 0.26 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RC_CMB_PREF_ROLE: RC_RscCombo
		{
			idc = 2100;
			//x = 0.175156 * safezoneW + safezoneX;
			//y = 0.819 * safezoneH + safezoneY;
			x = 0.26 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RC_TXT_MIC: RC_RscText
		{
			idc = -1;
			text = "Microphone"; //--- ToDo: Localize;
			//x = 0.175156 * safezoneW + safezoneX;
			//y = 0.786 * safezoneH + safezoneY;
			x = 0.26 * safezoneW + safezoneX;
			y = 0.59 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RC_CMB_MIC: RC_RscCombo
		{
			idc = 2101;
			//x = 0.267969 * safezoneW + safezoneX;
			x = 0.26 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RC_BUT_SAVE: RC_RscButton
		{
			idc = 1605;
			action = "call RC_fnc_saveProfile;";
			text = "APPLY"; //--- ToDo: Localize;
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_CANCEL: RC_RscButton
		{
			idc = 1606;
			action = "closeDialog 0;";
			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.164844 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscText_1000: RC_RscText
		{
			idc = 1000;
			text = "Limited"; //--- ToDo: Localize;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1002: RC_RscText
		{
			idc = 1002;
			text = "Competent"; //--- ToDo: Localize;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1003: RC_RscText
		{
			idc = 1003;
			text = "Experienced"; //--- ToDo: Localize;
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1005: RC_RscText
		{
			idc = 1005;
			text = "Please rate your experience in the following areas"; //--- ToDo: Localize;
			x = 0.242187 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.433125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscText_1006: RC_RscText
		{
			idc = 1006;
			text = "Elite/Mentor"; //--- ToDo: Localize;
			x = 0.665 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RC_BUT_UAS_1STAR: RC_RscButton
		{
			idc = 1607;
			text = "Unassign Selected"; //--- ToDo: Localize;
			action = "[1,0,false] call RC_fnc_sendProfileListBoxData;";
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_UAS_2STAR: RC_RscButton
		{
			idc = 1609;
			text = "Unassign Selected"; //--- ToDo: Localize;
			action = "[2,0,false] call RC_fnc_sendProfileListBoxData;";
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_UAS_3STAR: RC_RscButton
		{
			idc = 1610;
			text = "Unassign Selected"; //--- ToDo: Localize;
			action = "[3,0,false] call RC_fnc_sendProfileListBoxData;";
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_UAS_4STAR: RC_RscButton
		{
			idc = 1611;
			text = "Unassign Selected"; //--- ToDo: Localize;
			action = "[4,0,false] call RC_fnc_sendProfileListBoxData;";
			x = 0.665 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_UAA_1STAR: RC_RscButton
		{
			idc = 1608;
			text = "Unassign All"; //--- ToDo: Localize;
			action = "[1,0,true] call RC_fnc_sendProfileListBoxData;";
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_UAA_2STAR: RC_RscButton
		{
			idc = 1612;
			text = "Unassign All"; //--- ToDo: Localize;
			action = "[2,0,true] call RC_fnc_sendProfileListBoxData;";
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_UAA_3STAR: RC_RscButton
		{
			idc = 1613;
			text = "Unassign All"; //--- ToDo: Localize;
			action = "[3,0,true] call RC_fnc_sendProfileListBoxData;";
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_UAA_4STAR: RC_RscButton
		{
			idc = 1614;
			text = "Unassign All"; //--- ToDo: Localize;
			action = "[4,0,true] call RC_fnc_sendProfileListBoxData;";
			x = 0.665 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
	/* #Xakina
	$[
		1.063,
		["RollCall",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
		[-1800,"RC_FRAME",[1,"",["0.159687 * safezoneW + safezoneX","0.115 * safezoneH + safezoneY","0.603281 * safezoneW","0.77 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1500,"RC_LB_NONE",[1,"",["0.175156 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.0825 * safezoneW","0.528 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1001,"",[1,"None / Unassigned",["0.175156 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1200,"",[1,"RC\img\0star.paa",["0.175156 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1600,"",[1,"> Limited",["0.267969 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1501,"RC_LB_1STAR",[1,"",["0.350469 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.0825 * safezoneW","0.528 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1502,"RC_LB_2STAR",[1,"",["0.453594 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.0825 * safezoneW","0.528 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1503,"RC_LB_3STAR",[1,"",["0.556719 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.0825 * safezoneW","0.528 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1504,"RC_LB_4STAR",[1,"",["0.665 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.0825 * safezoneW","0.528 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1601,"",[1,"> Competent",["0.267969 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1602,"",[1,"> Experienced",["0.267969 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1603,"",[1,"> Elite",["0.267969 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1604,"",[1,"Mic: No",["0.267969 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[2100,"",[1,"",["0.175156 * safezoneW + safezoneX","0.819 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1605,"RC_BUT_SAVE",[1,"APPLY",["0.685625 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0721875 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1606,"RC_BUT_CANCEL",[1,"CANCEL",["0.164844 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0721875 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1607,"",[1,"Unassign Selected",["0.350469 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1608,"",[1,"Unassign All",["0.350469 * safezoneW + safezoneX","0.83 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1000,"",[1,"Limited",["0.350469 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1002,"",[1,"Competent",["0.453594 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1003,"",[1,"Experienced",["0.556719 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1004,"",[1,"",[-0.430555,-0.0104895,0.1,0.1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1005,"",[1,"Please rate your experience in the following areas",["0.242187 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.433125 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1006,"",[1,"Elite/Mentor",["0.665 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1007,"",[1,"Preferred Role",["0.175156 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1609,"",[1,"Unassign Selected",["0.453594 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1610,"",[1,"Unassign Selected",["0.556719 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1611,"",[1,"Unassign Selected",["0.665 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1612,"",[1,"Unassign All",["0.453594 * safezoneW + safezoneX","0.83 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1613,"",[1,"Unassign All",["0.556719 * safezoneW + safezoneX","0.83 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1614,"",[1,"Unassign All",["0.665 * safezoneW + safezoneX","0.83 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1201,"",[1,"RC\img\1star.paa",["0.350469 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1202,"",[1,"RC\img\2star.paa",["0.453594 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1203,"",[1,"RC\img\3star.paa",["0.556719 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1204,"",[1,"RC\img\0star.paa",["0.658854 * safezoneW + safezoneX","0.433654 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
		[1205,"",[1,"RC\img\4star.paa",["0.665 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
	]
	*/
};

class ROLLCALL_XP_GROUPS 
{
	idd = 88300;
	name = "ROLLCALL_XP_GROUPS";
	movingEnabled = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable ['ROLLCALL_XP_GROUPS', (_this select 0)];[] call RC_fnc_groupsDisplay;";
	class controlsBackground
	{
		class RC_MAIN_BG: RC_IGUIBack
		{
			idc = -1;
			x = 0.0771875 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.768281 * safezoneW;
			h = 0.759 * safezoneH;
		};
		class RC_FRAME: RC_RscFrame
		{
			idc = 1800;
			x = 0.0771875 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.768281 * safezoneW;
			h = 0.759 * safezoneH;
		};
	};
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nash, v1.063, #Duzutu)
		////////////////////////////////////////////////////////
		class RC_BACK: RC_RscButton
		{
			idc = 2200;
			text = "Back"; //--- ToDo: Localize;
			action = "closeDialog 0";
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_CREATE: RC_RscButtonMenu
		{
			idc = 1600;
			text = "Create Group"; //--- ToDo: Localize;
			action = "[] call RC_fnc_createGroup; closeDialog 88100; closeDialog 0";
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RC_LB_PLAYERSINGROUP: RC_RscListbox
		{
			idc = 1500;
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.539 * safezoneH;
		};
		class RC_TXT_GROUPNAME: RC_RscText
		{
			idc = 1001;
			text = "Current Group: "; //--- ToDo: Localize;
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_LB_GROUPS: RC_RscListbox
		{
			idc = 1501;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.539 * safezoneH;
		};
		class RC_BUT_JOINGROUP: RC_RscButton
		{
			idc = 1601;
			text = "Join Group"; //--- ToDo: Localize;
			action = "[] call RC_fnc_joinGroup;";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_LEAVEGROUP: RC_RscButton
		{
			idc = 1602;
			text = "Leave Group"; //--- ToDo: Localize;
			action = "[] call RC_fnc_createGroup;";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_TXT_ALLGROUPS: RC_RscText
		{
			idc = 1002;
			text = "All Groups:"; //--- ToDo: Localize;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_TXT_PLAYERSINGROUP: RC_RscListbox
		{
			idc = 1502;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.539 * safezoneH;
		};
		class RscText_1003: RC_RscText
		{
			idc = 1003;
			text = "Players In Selected Group:"; //--- ToDo: Localize;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_REMOVESEL: RC_RscButton
		{
			idc = 1603;
			text = "Remove Selected"; //--- ToDo: Localize;
			action = "[] call RC_fnc_removeUnitFromGroup;";
			x = 0.216406 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_REMOVEALLAI: RC_RscButton
		{
			idc = 1604;
			text = "Remove All AI"; //--- ToDo: Localize;
			action = "[] call RC_fnc_removeAI;";
			x = 0.216406 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_LEADER: RC_RscButtonMenu
		{
			idc = 1605;
			text = "Become Leader"; //--- ToDo: Localize;
			action = "[] call RC_fnc_quitLead;";
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RC_BUT_LOCK: RC_RscButtonMenu
		{
			idc = 1606;
			text = "Lock Group"; //--- ToDo: Localize;
			action = "[] call RC_fnc_lockGroup;";
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RC_BUT_FILTERAI: RC_RscButton
		{
			idc = 1607;
			text = "Hide AI Units"; //--- ToDo: Localize;
			action = "[] call RC_fnc_filterAI;";
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_LB_PLAYERROLESINGROUP: RC_RscListbox
		{
			idc = 1503;
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.539 * safezoneH;
		};
		class RscText_1004: RC_RscText
		{
			idc = 1004;
			text = "Requested Roles (Group)"; //--- ToDo: Localize;
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_ADDROLE: RC_RscButton
		{
			idc = 1608;
			text = "Request Role for Group"; //--- ToDo: Localize;
			action = "[] call RC_fnc_addRoleGroup;";
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_BUT_DELROLE: RC_RscButton
		{
			idc = 1609;
			text = "Remove All Requests"; //--- ToDo: Localize;
			action = "[] call RC_fnc_removeRoleGroup;";
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RC_CMB_ROLES: RC_RscCombo
		{
			idc = 2100;
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.722 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
/* #Duzutu
$[
	1.063,
	["RollCall",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[2,"",["-21 * GUI_GRID_W + GUI_GRID_X","-5.5 * GUI_GRID_H + GUI_GRID_Y","74 * GUI_GRID_W","35 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1800,"RC_FRAME",[1,"",["0.0771875 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.768281 * safezoneW","0.759 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2200,"RC_BACK",[1,"Back",["0.0875 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"RC_BUT_CREATE",[1,"Create Group",["0.0875 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.0825 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"RC_LB_PLAYERSINGROUP",[1,"",["0.185469 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.175313 * safezoneW","0.539 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"RC_TXT_GROUPNAME",[1,"Current Group: ",["0.185469 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.144375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"RC_LB_GROUPS",[1,"",["0.37625 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.113437 * safezoneW","0.539 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"RC_BUT_JOINGROUP",[1,"Join Group",["0.37625 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"RC_BUT_LEAVEGROUP",[1,"Leave Group",["0.37625 * safezoneW + safezoneX","0.797 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"RC_TXT_ALLGROUPS",[1,"All Groups:",["0.37625 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1502,"RC_TXT_PLAYERSINGROUP",[1,"",["0.510312 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.195937 * safezoneW","0.539 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"Players In Selected Group:",["0.510312 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"RC_BUT_REMOVESEL",[1,"Remove Selected",["0.216406 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"RC_BUT_REMOVEALLAI",[1,"Remove All AI",["0.216406 * safezoneW + safezoneX","0.797 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1605,"RC_BUT_LEADER",[1,"Become Leader",["0.0875 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.0825 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1606,"RC_BUT_LOCK",[1,"Lock Group",["0.0875 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.0825 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1607,"RC_BUT_FILTERAI",[1,"Filter AI Units",["0.556719 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1503,"RC_LB_PLAYERROLESINGROUP",[1,"",["0.721719 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.108281 * safezoneW","0.539 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"Requested Roles (Group)",["0.721719 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.108281 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1608,"RC_BUT_ADDROLE",[1,"Request Role for Group",["0.721719 * safezoneW + safezoneX","0.7926 * safezoneH + safezoneY","0.113437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"",[1,"",["0.721719 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
};