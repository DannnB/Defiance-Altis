#define BG_COLOR_OCHRE 0.76,0.50,0.078
#define BG_COLOR_LIGHT_GREY 0.95,0.95,0.95
#define TXT_JOIN "JOIN"
#define ICO_UNLOCKED "eutw_gui\groupManager\Images\unlocked.paa"
#define ICO_EXIT "eutw_gui\groupManager\Images\icon_exit_ca.paa"
#define ICO_SERGEANT "eutw_gui\groupManager\Images\sergeant_gs.paa"

class groupManagementDialog
{
    idd=-1;
	movingenable = false;
	onLoad="uiNamespace setVariable ['KroK_group_dialog_handle', _this select 0]; for '_hlp' from 150 to 156 step 1 do {((_this select 0) displayCtrl _hlp) ctrlShow false;}";
    onUnLoad="uiNamespace setVariable ['KroK_group_dialog_handle', nil]";

	class controls
	{
		class background: BOXGrMn
		{
			idc = -1;
			text = ""; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class RscFrameGrMn_full: RscFrameGrMn
		{
			idc = 1800;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class RscFrameGrMn_1: RscFrameGrMn
		{
			idc = 1801;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.504 * safezoneH;
		};
		class RscFrameGrMn_2: RscFrameGrMn
		{
			idc = 1802;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.504 * safezoneH;
		};
		class RscFrameGrMn_3: RscFrameGrMn
		{
			idc = 1803;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.504 * safezoneH;
		};
		class RscFrameGrMn_4: RscFrameGrMn
		{
			idc = 1804;
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.504 * safezoneH;
		};
		class header_text: RscTextGrMn
		{
			idc = 1000;
			text = "-[EUTW]- GROUP MANAGER"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class footer_text: RscStructuredTextGrMn
		{
			idc = 1001;
			class Attributes {
				 font = "PuristaMedium";
				 color = "#808080";
				 align = "left";
				 valign = "middle";
				 shadow = false;
				 shadowColor = "#808080";
				 size = "1";
			};
			size = "0.023 / ((getResolution select 5)/0.55)";
			// If you edit this group manager, feel free to add your name to authors here. However, following the licensing terms, please keep the original creator name here as well (-[EUTW]- KroKodile).
			// Relevant license information:
			// Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
			// You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 
			text = "<t align='LEFT'>www.EUTW.net</t><t align='RIGHT'>by -[EUTW]- KroKodile</t>"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.015 * safezoneH;
		};
		class group_1_text: RscTextGrMn
		{
			idc = 1002;
			text = "Alpha 1"; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_1_list: RscListBoxGrMn
		{
			idc = 1500;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.288 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_1_button: RscShortcutButtonGrMn
		{
			idc = 1600;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.393 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1600, alphaGroup1, alphaOGroup1, alphaIGroup1, locked1, lockedO1, lockedI1] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_1_leader_button: RscShortcutButtonGrMn
		{
			idc = 1650;
			text = ""; //--- ToDo: Localize;
			x = 0.36125 * safezoneW + safezoneX;
			y = 0.393 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1200, 1600, 1500, alphaGroup1, alphaOGroup1, alphaIGroup1] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture1: RscPictureGrMn
		{
			idc = 1200;
			text = ICO_SERGEANT;
			x = 0.36375 * safezoneW + safezoneX;
			y = 0.396 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_1_lock_button: RscShortcutButtonGrMn
		{
			idc = 1675;
			text = ""; //--- ToDo: Localize;
			x = 0.36125 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1250, alphaGroup1, alphaOGroup1, alphaIGroup1, 1] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_1_lock: RscPictureGrMn
		{
			idc = 1250;
			text = ICO_UNLOCKED;
			x = 0.36375 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_1_kick_button: RscShortcutButtonGrMn
		{
			idc = 1625;
			text = ""; //--- ToDo: Localize;
			x = 0.34625 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1200, 1625, 1500, alphaGroup1, alphaOGroup1, alphaIGroup1] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_1_kick: RscPictureGrMn
		{
			idc = 1275;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.35 + 0.002) * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_2_text: RscTextGrMn
		{
			idc = 1003;
			text = "Alpha 2"; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_2_list: RscListBoxGrMn
		{
			idc = 1501;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.455 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_2_button: RscShortcutButtonGrMn
		{
			idc = 1601;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.560 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action="[player, 1601, alphaGroup2, alphaOGroup2, alphaIGroup2, locked2, lockedO2, lockedI2] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_2_leader_button: RscShortcutButtonGrMn
		{
			idc = 1651;
			text = ""; //--- ToDo: Localize;
			x = 0.36125 * safezoneW + safezoneX;
			y = 0.560 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1201, 1601, 1501, alphaGroup2, alphaOGroup2, alphaIGroup2] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture2: RscPictureGrMn
		{
			idc = 1201;
			text = ICO_SERGEANT;
			x = 0.36375 * safezoneW + safezoneX;
			y = 0.563 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_2_lock_button: RscShortcutButtonGrMn
		{
			idc = 1676;
			text = ""; //--- ToDo: Localize;
			x = 0.36125 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1251, alphaGroup2, alphaOGroup2, alphaIGroup2, 2] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_2_lock: RscPictureGrMn
		{
			idc = 1251;
			text = ICO_UNLOCKED;
			x = 0.36375 * safezoneW + safezoneX;
			y = 0.436 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_2_kick_button: RscShortcutButtonGrMn
		{
			idc = 1626;
			text = ""; //--- ToDo: Localize;
			x = 0.34625 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1201, 1601, 1501, alphaGroup2, alphaOGroup2, alphaIGroup2] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_2_kick: RscPictureGrMn
		{
			idc = 1276;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.35 + 0.002) * safezoneW + safezoneX;
			y = 0.437 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_3_text: RscTextGrMn
		{
			idc = 1004;
			text = "Alpha 3"; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_3_list: RscListBoxGrMn
		{
			idc = 1502;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_3_button: RscShortcutButtonGrMn
		{
			idc = 1602;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.726 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1602, alphaGroup3, alphaOGroup3, alphaIGroup3, locked3, lockedO3, lockedI3] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_3_leader_button: RscShortcutButtonGrMn
		{
			idc = 1652;
			text = ""; //--- ToDo: Localize;
			x = 0.36125 * safezoneW + safezoneX;
			y = 0.726 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1202, 1602, 1502, alphaGroup3, alphaOGroup3, alphaIGroup3] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture3: RscPictureGrMn
		{
			idc = 1202;
			text = ICO_SERGEANT;
			x = 0.36375 * safezoneW + safezoneX;
			y = 0.729 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_3_lock_button: RscShortcutButtonGrMn
		{
			idc = 1677;
			text = ""; //--- ToDo: Localize;
			x = 0.36125 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1252, alphaGroup3, alphaOGroup3, alphaIGroup3, 3] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_3_lock: RscPictureGrMn
		{
			idc = 1252;
			text = ICO_UNLOCKED;
			x = 0.36375 * safezoneW + safezoneX;
			y = 0.602 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_3_kick_button: RscShortcutButtonGrMn
		{
			idc = 1627;
			text = ""; //--- ToDo: Localize;
			x = 0.34625 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1202, 1602, 1502, alphaGroup3, alphaOGroup3, alphaIGroup3] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_3_kick: RscPictureGrMn
		{
			idc = 1277;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.35 + 0.002) * safezoneW + safezoneX;
			y = 0.603 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_4_text: RscTextGrMn
		{
			idc = 1005;
			text = "Bravo 1"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_4_list: RscListBoxGrMn
		{
			idc = 1503;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.288 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_4_button: RscShortcutButtonGrMn
		{
			idc = 1603;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.393 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1603, bravoGroup1, bravoOGroup1, bravoIGroup1, locked4, lockedO4, lockedI4] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_4_leader_button: RscShortcutButtonGrMn
		{
			idc = 1653;
			text = ""; //--- ToDo: Localize;
			x = 0.464375 * safezoneW + safezoneX;
			y = 0.393 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1203, 1603, 1503, bravoGroup1, bravoOGroup1, bravoIGroup1] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture4: RscPictureGrMn
		{
			idc = 1203;
			text = ICO_SERGEANT;
			x = 0.466875 * safezoneW + safezoneX;
			y = 0.396 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_4_lock_button: RscShortcutButtonGrMn
		{
			idc = 1678;
			text = ""; //--- ToDo: Localize;
			x = 0.464375 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1253, bravoGroup1, bravoOGroup1, bravoIGroup1, 4] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_4_lock: RscPictureGrMn
		{
			idc = 1253;
			text = ICO_UNLOCKED;
			x = 0.466875 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_4_kick_button: RscShortcutButtonGrMn
		{
			idc = 1628;
			text = ""; //--- ToDo: Localize;
			x = 0.449375 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1203, 1603, 1503, bravoGroup1, bravoOGroup1, bravoIGroup1] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_4_kick: RscPictureGrMn
		{
			idc = 1278;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.453125 + 0.002) * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_5_text: RscTextGrMn
		{
			idc = 1006;
			text = "Bravo 2"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_5_list: RscListBoxGrMn
		{
			idc = 1504;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.455 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_5_button: RscShortcutButtonGrMn
		{
			idc = 1604;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.560 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1604, bravoGroup2, bravoOGroup2, bravoIGroup2, locked5, lockedO5, lockedI5] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_5_leader_button: RscShortcutButtonGrMn
		{
			idc = 1654;
			text = ""; //--- ToDo: Localize;
			x = 0.464375 * safezoneW + safezoneX;
			y = 0.560 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1204, 1604, 1504, bravoGroup2, bravoOGroup2, bravoIGroup2] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture5: RscPictureGrMn
		{
			idc = 1204;
			text = ICO_SERGEANT;
			x = 0.466875 * safezoneW + safezoneX;
			y = 0.563 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_5_lock_button: RscShortcutButtonGrMn
		{
			idc = 1679;
			text = ""; //--- ToDo: Localize;
			x = 0.464375 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1254, bravoGroup2, bravoOGroup2, bravoIGroup2, 5] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_5_lock: RscPictureGrMn
		{
			idc = 1254;
			text = ICO_UNLOCKED;
			x = 0.466875 * safezoneW + safezoneX;
			y = 0.436 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_5_kick_button: RscShortcutButtonGrMn
		{
			idc = 1629;
			text = ""; //--- ToDo: Localize;
			x = 0.449375 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1204, 1604, 1504, bravoGroup2, bravoOGroup2, bravoIGroup2] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_5_kick: RscPictureGrMn
		{
			idc = 1279;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.453125 + 0.002) * safezoneW + safezoneX;
			y = 0.437 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_6_text: RscTextGrMn
		{
			idc = 1007;
			text = "Bravo 3"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_6_list: RscListBoxGrMn
		{
			idc = 1505;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_6_button: RscShortcutButtonGrMn
		{
			idc = 1605;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.726 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1605, bravoGroup3, bravoOGroup3, bravoIGroup3, locked6, lockedO6, lockedI6] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_6_leader_button: RscShortcutButtonGrMn
		{
			idc = 1655;
			text = ""; //--- ToDo: Localize;
			x = 0.464375 * safezoneW + safezoneX;
			y = 0.726 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1205, 1605, 1505, bravoGroup3, bravoOGroup3, bravoIGroup3] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture6: RscPictureGrMn
		{
			idc = 1205;
			text = ICO_SERGEANT;
			x = 0.466875 * safezoneW + safezoneX;
			y = 0.729 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_6_lock_button: RscShortcutButtonGrMn
		{
			idc = 1680;
			text = ""; //--- ToDo: Localize;
			x = 0.464375 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1255, bravoGroup3, bravoOGroup3, bravoIGroup3, 6] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_6_lock: RscPictureGrMn
		{
			idc = 1255;
			text = ICO_UNLOCKED;
			x = 0.466875 * safezoneW + safezoneX;
			y = 0.602 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_6_kick_button: RscShortcutButtonGrMn
		{
			idc = 1630;
			text = ""; //--- ToDo: Localize;
			x = 0.449375 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1205, 1605, 1505, bravoGroup3, bravoOGroup3, bravoIGroup3] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_6_kick: RscPictureGrMn
		{
			idc = 1280;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.453125 + 0.002) * safezoneW + safezoneX;
			y = 0.603 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_7_text: RscTextGrMn
		{
			idc = 1008;
			text = "Charlie 1"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_7_list: RscListBoxGrMn
		{
			idc = 1506;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.288 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_7_button: RscShortcutButtonGrMn
		{
			idc = 1606;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.393 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1606, charlieGroup1, charlieOGroup1, charlieIGroup1, locked7, lockedO7, lockedI7] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_7_leader_button: RscShortcutButtonGrMn
		{
			idc = 1656;
			text = ""; //--- ToDo: Localize;
			x = 0.567495 * safezoneW + safezoneX;
			y = 0.393 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1206, 1606, 1506, charlieGroup1, charlieOGroup1, charlieIGroup1] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture7: RscPictureGrMn
		{
			idc = 1206;
			text = ICO_SERGEANT;
			x = 0.569995 * safezoneW + safezoneX;
			y = 0.396 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_7_lock_button: RscShortcutButtonGrMn
		{
			idc = 1681;
			text = ""; //--- ToDo: Localize;
			x = 0.567495 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1256, charlieGroup1, charlieOGroup1, charlieIGroup1, 7] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_7_lock: RscPictureGrMn
		{
			idc = 1256;
			text = ICO_UNLOCKED;
			x = 0.569995 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_7_kick_button: RscShortcutButtonGrMn
		{
			idc = 1631;
			text = ""; //--- ToDo: Localize;
			x = 0.552495 * safezoneW + safezoneX;
			y = 0.266 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1206, 1606, 1506, charlieGroup1, charlieOGroup1, charlieIGroup1] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_7_kick: RscPictureGrMn
		{
			idc = 1281;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.556245 + 0.002) * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_8_text: RscTextGrMn
		{
			idc = 1009;
			text = "Charlie 2"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_8_list: RscListBoxGrMn
		{
			idc = 1507;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.455 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_8_button: RscShortcutButtonGrMn
		{
			idc = 1607;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.560 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1607, charlieGroup2, charlieOGroup2, charlieIGroup2, locked8, lockedO8, lockedI8] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_8_leader_button: RscShortcutButtonGrMn
		{
			idc = 1657;
			text = ""; //--- ToDo: Localize;
			x = 0.567495 * safezoneW + safezoneX;
			y = 0.560 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1207, 1607, 1507, charlieGroup2, charlieOGroup2, charlieIGroup2] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture8: RscPictureGrMn
		{
			idc = 1207;
			text = ICO_SERGEANT;
			x = 0.569995 * safezoneW + safezoneX;
			y = 0.563 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_8_lock_button: RscShortcutButtonGrMn
		{
			idc = 1682;
			text = ""; //--- ToDo: Localize;
			x = 0.567495 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1257, charlieGroup2, charlieOGroup2, charlieIGroup2, 8] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_8_lock: RscPictureGrMn
		{
			idc = 1257;
			text = ICO_UNLOCKED;
			x = 0.569995 * safezoneW + safezoneX;
			y = 0.436 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_8_kick_button: RscShortcutButtonGrMn
		{
			idc = 1632;
			text = ""; //--- ToDo: Localize;
			x = 0.552495 * safezoneW + safezoneX;
			y = 0.433 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1207, 1607, 1507, charlieGroup2, charlieOGroup2, charlieIGroup2] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_8_kick: RscPictureGrMn
		{
			idc = 1282;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.556245 + 0.002) * safezoneW + safezoneX;
			y = 0.437 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_9_text: RscTextGrMn
		{
			idc = 1010;
			text = "Charlie 3"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_9_list: RscListBoxGrMn
		{
			idc = 1508;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class group_9_button: RscShortcutButtonGrMn
		{
			idc = 1608;
			text = TXT_JOIN; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.726 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1608, charlieGroup3, charlieOGroup3, charlieIGroup3, locked9, lockedO9, lockedI9] execVM 'eutw_gui\groupManager\buttonJoinLeave.sqf';";
		};
		class group_9_leader_button: RscShortcutButtonGrMn
		{
			idc = 1658;
			text = ""; //--- ToDo: Localize;
			x = 0.567495 * safezoneW + safezoneX;
			y = 0.726 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1208, 1608, 1508, charlieGroup3, charlieOGroup3, charlieIGroup3] execVM 'eutw_gui\groupManager\leaderButton.sqf';";
		};
		class picture9: RscPictureGrMn
		{
			idc = 1208;
			text = ICO_SERGEANT;
			x = 0.569995 * safezoneW + safezoneX;
			y = 0.729 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_9_lock_button: RscShortcutButtonGrMn
		{
			idc = 1683;
			text = ""; //--- ToDo: Localize;
			x = 0.567495 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1258, charlieGroup3, charlieOGroup3, charlieIGroup3, 9] execVM 'eutw_gui\groupManager\lockButton.sqf';";
		};
		class picture_9_lock: RscPictureGrMn
		{
			idc = 1258;
			text = ICO_UNLOCKED;
			x = 0.569995 * safezoneW + safezoneX;
			y = 0.602 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		class group_9_kick_button: RscShortcutButtonGrMn
		{
			idc = 1633;
			text = ""; //--- ToDo: Localize;
			x = 0.552495 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[player, 1208, 1608, 1508, charlieGroup3, charlieOGroup3, charlieIGroup3] execVM 'eutw_gui\groupManager\kickButton.sqf';";
		};
		class picture_9_kick: RscPictureGrMn
		{
			idc = 1283;
			colorText[] = {1,1,1,0};
			text = ICO_EXIT;
			x = (0.556245 + 0.002) * safezoneW + safezoneX;
			y = 0.603 * safezoneH + safezoneY;
			w = 0.010 * safezoneW;
			h = 0.016 * safezoneH;
		};
		
		class group_10_text: RscTextGrMn
		{
			idc = 1011;
			text = "Unassigned"; //--- ToDo: Localize;
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.264 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class group_10_list: RscListBoxGrMn
		{
			idc = 1509;
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.288 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.44 * safezoneH;
			colorSelect2[] ={1,1,1,1};
		};
		class exit_button: RscButtonGrMn
		{
			idc = 1609;
			text = "X"; //--- ToDo: Localize;
			x = 0.6947 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.018 * safezoneH;
			colorBackground[] = {BG_COLOR_LIGHT_GREY,0};
			colorBackgroundDisabled[] = {0,0.0,0};
			colorBackgroundActive[] = {BG_COLOR_LIGHT_GREY,0};
			colorFocused[] = {BG_COLOR_LIGHT_GREY,0};
			colorShadow[] = {0.023529,0,0.0313725,0};
			colorBorder[] = {0.023529,0,0.0313725,0};
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			action = "closeDialog 0";
		};
		class help_button: RscButtonGrMn
		{
			idc = 1610;
			text = "?"; //--- ToDo: Localize;
			x = 0.6847 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.018 * safezoneH;
			colorBackground[] = {BG_COLOR_LIGHT_GREY,0};
			colorBackgroundDisabled[] = {0,0.0,0};
			colorBackgroundActive[] = {BG_COLOR_LIGHT_GREY,0};
			colorFocused[] = {BG_COLOR_LIGHT_GREY,0};
			colorShadow[] = {0.023529,0,0.0313725,0};
			colorBorder[] = {0.023529,0,0.0313725,0};
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			action = "for '_hlp' from 150 to 156 step 1 do {ctrlShow [_hlp, true]}";
		};
		// HELP DIALOG BELOW:
		class help_background: BOXGrMn
		{
			idc = 150;
			text = ""; //--- ToDo: Localize;
			x = 0.73 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class help_frame: RscFrameGrMn
		{
			idc = 151;
			x = 0.73 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class help_header_text: RscTextGrMn
		{
			idc = 152;
			text = "Help"; //--- ToDo: Localize;
			x = 0.73 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class help_frame2: RscFrameGrMn
		{
			idc = 153;
			x = 0.74 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.504 * safezoneH;
		};
		
		class help_text_main: RscStructuredTextGrMn
		{
			idc = 154;
			text = "Squad leaders can:<br/><br/>-Give leadership to a different player by clicking their name in your squad list and then clicking on the chevron button [<img image='eutw_gui\groupManager\Images\sergeant_gs.paa'/>].<br/><br/>-Lock your group, if your squad has the minimum amount of members in it, by pressing the lock icon [<img image='eutw_gui\groupManager\Images\unlocked.paa'/>].<br/><br/>-Kick squad members by selecting them in the list, then clicking the kick icon [<img image='eutw_gui\groupManager\Images\icon_exit_ca.paa'/>].<br/><br/>Solo squad leaders are removed automatically after a short period of time.<br/><br/>Alternate way to open this manager is through User Key 10.";
			x = 0.74 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.490 * safezoneH;
		};
		class help_text_footer: RscStructuredTextGrMn
		{
			idc = 155;
			size = "0.02 / ((getResolution select 5)/0.55)";
			text = "<t align='CENTER'>V1.4 (CC BY-NC-SA 4.0)</t>";
			x = 0.74 * safezoneW + safezoneX;
			y = 0.748 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.014 * safezoneH;
		};
		class help_exit: RscButtonGrMn
		{
			idc = 156;
			text = "X"; //--- ToDo: Localize;
			x = 0.82 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.018 * safezoneH;
			colorBackground[] = {BG_COLOR_LIGHT_GREY,0};
			colorBackgroundDisabled[] = {0,0.0,0};
			colorBackgroundActive[] = {BG_COLOR_LIGHT_GREY,0};
			colorFocused[] = {BG_COLOR_LIGHT_GREY,0};
			colorShadow[] = {0.023529,0,0.0313725,0};
			colorBorder[] = {0.023529,0,0.0313725,0};
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			action = "for '_hlp' from 150 to 156 step 1 do {ctrlShow [_hlp, false]}";
		};
    };
};
