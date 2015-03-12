/*
	File: fn_sendProfileListBoxData.sqf
	Author: Nashable (@m_nash)

	Description:
	Sends list items from one listbox to another
*/
disableSerialization;
_toList = _this select 0;
_fromList = _this select 1;
_assignAll = _this select 2;

//load display
_display = (uiNamespace getVariable "ROLCALL_XP_PROFILE");
_controlSource = _display displayCtrl (1500+_toList);
_controlTarget = _display displayCtrl (1500+_fromList);

if (_assignAll) then
{
	_size = lbSize _controlSource;
	for [{_i=0}, {_i<_size}, {_i=_i+1}] do
	{
		_value = (_controlSource lbvalue _i);
		_ind = _controlTarget lbAdd (ROLLCALL_XP_LABELS select _value);
		_controlTarget lbSetValue [_ind,_value];
		_controlSource lbDelete _i;
	};
} else {
	_index = lbCurSel _controlSource;
	_value = (_controlSource lbvalue _index);
	_id = _controlTarget lbAdd (ROLLCALL_XP_LABELS select _value);
	_controlTarget lbSetValue [_id,_value];
	_controlSource lbDelete _index;
};