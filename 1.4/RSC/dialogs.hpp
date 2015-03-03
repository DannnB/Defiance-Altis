class DEF_CO_VOTE
{
    idd = 1;
    movingenable = true;
	onLoad = "[_this, 'onLoad'] ExecVM 'GUI\GUI_Vote.sqf'";
	
	class Controls
	{
		class DEF_VOTE_BOX: BOX
		{
			idc = -1;
			text = "";
			x = (0.25 * safezoneW + safezoneX)-0.025;
			y = 0.175 * safezoneH + safezoneY;
			w = (0.359375 * safezoneW)+0.05;
			h = 0.65 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nash, v1.063, #Cerowu)
		////////////////////////////////////////////////////////
		class DEF_VOTE_CO_FRAME: RscFrame
		{
			idc = 1800;
			text = "Vote For Your Commanding Officer"; //--- ToDo: Localize;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.175 * safezoneH + safezoneY;
			w = 0.359375 * safezoneW;
			h = 0.65 * safezoneH;
		};
		class DEF_VOTE_LIST: RscListbox
		{
			idc = 1500;
			x = 0.265625 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.15625 * safezoneW;
			h = 0.6 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Current CO:"; //--- ToDo: Localize;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.078125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class DEF_VOTE_COTEXT: RscText
		{
			idc = 1002;
			text = "PlayerName"; //--- ToDo: Localize;
			x = 0.515625 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.21875 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "Officers:"; //--- ToDo: Localize;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class DEF_OFFICER_LIST: RscListbox
		{
			idc = 1501;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.3 * safezoneH + safezoneY;
			w = 0.15625 * safezoneW;
			h = 0.15 * safezoneH;
			sizeEx = 0.02;
		};
		class DEF_VOTE_BUTTON: RscButton
		{
			idc = 1600;
			text = "Vote"; //--- ToDo: Localize;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.475 * safezoneH + safezoneY;
			w = 0.15625 * safezoneW;
			h = 0.05 * safezoneH;
			action = "[_this, 'vote'] ExecVM 'GUI\GUI_Vote.sqf';";
		};
		class DEF_APPOINT_OFFICER: RscButton
		{
			idc = 1601;
			text = "Appoint Officer"; //--- ToDo: Localize;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.15625 * safezoneW;
			h = 0.05 * safezoneH;
			action = "[_this, 'appointXO'] ExecVM 'GUI\GUI_Vote.sqf';";
		};
		class DEF_RESIGN: RscButton
		{
			idc = 1604;
			text = "Relinquish Command"; //--- ToDo: Localize;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.15625 * safezoneW;
			h = 0.05 * safezoneH;
			action = "[_this, 'resign'] ExecVM 'GUI\GUI_Vote.sqf';";
		};
		class DEF_VOTE_CANCEL_BUTTON: RscButton
		{
			idc = 1602;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.15625 * safezoneW;
			h = 0.05 * safezoneH;
			action = "closeDialog 0;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
		class DEF_VOTE_RESET_BUTTON: RscButton
		{
			idc = 1605;
			text = "Reset COs"; //--- ToDo: Localize;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.19 * safezoneH + safezoneY;
			//w = 0.15625 * safezoneW;
			w = 0.075 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {1,0,0,0.8};
    		colorBackgroundDisabled[] = {0.4,0.4,0.4,0};
    		colorBackgroundActive[] = {1,0,0,1};
			action = "closeDialog 0;[[(serverCommandAvailable '#kick')], 'resetOfficers', true, false] spawn BIS_fnc_MP;";
		};
		class DEF_VOTE_RESET_TEAM_LOCK: RscButton
		{
			idc = 1606;
			text = "Reset TK/Teams"; //--- ToDo: Localize;
			x = 0.52 * safezoneW + safezoneX;
			y = 0.19 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {1,0,0,0.8};
    		colorBackgroundDisabled[] = {0.4,0.4,0.4,0};
    		colorBackgroundActive[] = {1,0,0,1};
			action = "closeDialog 0;[[(serverCommandAvailable '#kick')], 'cmn_resetTeams', true, false] spawn BIS_fnc_MP;";
		};
	};
	
	/* #Cerowu
$[
	1.063,
	["DEF_CO_VOTE",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 32","safezoneH / 20","GUI_GRID"],0,0,0],
	[-1001,"GroupText",[2,"",["0 * GUI_GRID_W","0 * GUI_GRID_H","19 * GUI_GRID_W","15 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"DEF_VOTE_CO_FRAME",[1,"Vote For Your Commanding Officer",["0.25 * safezoneW + safezoneX","0.175 * safezoneH + safezoneY","0.359375 * safezoneW","0.65 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"DEF_VOTE_LIST",[1,"",["0.265625 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.15625 * safezoneW","0.6 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Current CO:",["0.4375 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.078125 * safezoneW","0.025 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"DEF_VOTE_COTEXT",[1,"PlayerName",["0.515625 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.21875 * safezoneW","0.025 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"Officers:",["0.4375 * safezoneW + safezoneX","0.25 * safezoneH + safezoneY","0.109375 * safezoneW","0.025 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"",[1,"",["0.4375 * safezoneW + safezoneX","0.3 * safezoneH + safezoneY","0.15625 * safezoneW","0.15 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"DEF_VOTE_BUTTON",[1,"Vote",["0.4375 * safezoneW + safezoneX","0.475 * safezoneH + safezoneY","0.15625 * safezoneW","0.05 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"DEF_APPOINT_OFFICER",[1,"Appoint Officer",["0.4375 * safezoneW + safezoneX","0.55 * safezoneH + safezoneY","0.15625 * safezoneW","0.05 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"DEF_VOTE_CANCEL_BUTTON",[1,"Cancel",["0.4375 * safezoneW + safezoneX","0.75 * safezoneH + safezoneY","0.15625 * safezoneW","0.05 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]

	*/
};


class DEF_SITREP
{
	idd = 300;
    movingenable = true;
	onLoad = "[_this, 'onLoad'] ExecVM 'GUI\GUI_Status.sqf'";
	
	class Controls
	{
		class DEF_STATUS_BOX: BOX
		{
			idc = -1;
			text = "";
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.525 * safezoneW;
			h = 0.7 * safezoneH;
		};

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nash, v1.063, #Gozibi)
		////////////////////////////////////////////////////////

		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.525 * safezoneW;
			h = 0.7 * safezoneH;
		};
		class RscPicture_1202: RscPicture
		{
			idc = 1202;
			text = "#(argb,8,8,3)color(1,0,0,1)";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.14 * safezoneH;
		};
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,1,1)";
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.14 * safezoneH;
		};
		class RscPicture_1201: RscPicture
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(0,1,0,1)";
			x = 0.427813 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.14 * safezoneH;
		};
		class RscButtonM_2400: RscButton
		{
			idc = 2400;
			text = "Close"; //--- ToDo: Localize;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.794 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.042 * safezoneH;
			action = "closeDialog 0;";
		};
		class DEF_BLUFOR_STATUS: RscStructuredText
		{
			idc = 1100;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.434 * safezoneH;
		};
		class DEF_INDFOR_STATUS: RscStructuredText
		{
			idc = 1101;
			x = 0.427813 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.434 * safezoneH;
		};
		class DEF_OPFOR_STATUS: RscStructuredText
		{
			idc = 1102;
			x = 0.605 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.434 * safezoneH;
		};
		class b_team: RscText
		{
			idc = 1000;
			style = ST_CENTER + ST_SHADOW;
			SizeEx = 0.060;
			text = "BLUFOR"; //--- ToDo: Localize;
			x = 0.257187 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
		};
		class i_team: RscText
		{
			idc = 1001;
			style = ST_CENTER + ST_SHADOW;
			SizeEx = 0.060;
			text = "INDFOR"; //--- ToDo: Localize;
			x = 0.434375 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
		};
		class o_team: RscText
		{
			idc = 1002;
			style = ST_CENTER + ST_SHADOW;
			SizeEx = 0.060;
			text = "OPFOR"; //--- ToDo: Localize;
			x = 0.611562 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
/* #Timabe
$[
	1.063,
	["sitrep",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1800,"",[1,"",["0.2375 * safezoneW + safezoneX","0.15 * safezoneH + safezoneY","0.525 * safezoneW","0.7 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1202,"",[1,"#(argb,8,8,3)color(1,0,0,1)",["0.605 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.144375 * safezoneW","0.14 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1200,"",[1,"#(argb,8,8,3)color(0,0,1,1)",["0.250625 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.144375 * safezoneW","0.14 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1201,"",[1,"#(argb,8,8,3)color(0,1,0,1)",["0.427813 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.144375 * safezoneW","0.14 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-2400,"",[1,"Close",["0.244062 * safezoneW + safezoneX","0.794 * safezoneH + safezoneY","0.511875 * safezoneW","0.042 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1100,"DEF_BLUFOR_STATUS",[1,"",["0.250625 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.144375 * safezoneW","0.434 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1101,"DEF_INDFOR_STATUS",[1,"",["0.427813 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.144375 * safezoneW","0.434 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1102,"DEF_OPFOR_STATUS",[1,"",["0.605 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.144375 * safezoneW","0.434 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"b_team",[1,"BLUFOR",["0.257187 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.13125 * safezoneW","0.07 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"i_team",[1,"INDFOR",["0.434375 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.13125 * safezoneW","0.07 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"o_team",[1,"OPFOR",["0.611562 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.13125 * safezoneW","0.07 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]

*/
};
