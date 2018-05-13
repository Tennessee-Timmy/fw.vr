// This is the 2nd test item...
//	Disable serilization to use displays and controls as variables
disableSerialization;
//	Define grid available
_GUI_GRID_W = (safezoneW / 40);
_GUI_GRID_H = (safezoneH / 25);
_GUI_GRID_X = (0);
_GUI_GRID_Y = (0);
/*
DIALOG SIZE
w = 14  * GUI_GRID_W;
h = 20  * GUI_GRID_H;
*/
//	Get display and ctrlgroup
_display = (findDisplay 304000);
_controlGroup = _display displayCtrl 4110;
//_controlGroup = _display ctrlCreate ["menus_template_group", 4111];	// this must be 4111 every time ( as it will be deleted )
/*
//---	Create structured text
_titleTextCtrl = _display ctrlCreate ["RscStructuredText", 4111, _controlGroup];
//	set the text with parseText
_titleTextCtrl ctrlSetStructuredText parseText "<t size='1' align='center'>MISSION MENU</t>";
//	Position for better readability
_titleTextPos = [
	(_GUI_GRID_X + 0 * (_GUI_GRID_W)),
	(_GUI_GRID_Y + 0 * (_GUI_GRID_H)),
	14*(_GUI_GRID_W),
	5*(_GUI_GRID_H)
];
//	Set the position
_titleTextCtrl ctrlSetPosition _titleTextPos;
//	Move the control to new position in 0 seconds
_titleTextCtrl ctrlCommit 0;
*/
//---	Create a control already defined in dialogs.hpp
_textCtrl = _display ctrlCreate ["menus_template_text", 4112, _controlGroup];
_text = parseText "
LOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUMLOREM IPSUM
";
_textCtrl ctrlSetStructuredText _text;
_textCtrl ctrlCommit 0;

_titleCtrl = _display ctrlCreate ["menus_template_title", 4113, _controlGroup];
_title = parseText "
TEST
";
_titleCtrl ctrlSetStructuredText _title;
_titleCtrl ctrlCommit 0;

_titleBarCtrl = _display ctrlCreate ["menus_template_titleBar", 4114, _controlGroup];
_checkBoxCtrl = _display ctrlCreate ["menus_template_checkBox", 4115, _controlGroup];
_checkBoxesCtrl = _display ctrlCreate ["menus_template_checkBoxes", 4116, _controlGroup];
_checkBoxesCtrl = _display ctrlCreate ["menus_template_editBox", 4117, _controlGroup];