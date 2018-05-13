//---	HOW TO CREATER A CONTROL WITH SCRIPT / default control / template
/*
	DIALOG SIZE
	w = 14  * GUI_GRID_W;
	h = 20  * GUI_GRID_H;
*/
/*
	// Create structured text
	_titleTextCtrl = _display ctrlCreate ["RscStructuredText", 4111, _controlGroup];

	// set the text with parseText
	_titleTextCtrl ctrlSetStructuredText parseText "<t size='1' align='center'>MISSION MENU</t>";

	// Position for better readability
	_titleTextPos = [
		(_GUI_GRID_X + 0 * (_GUI_GRID_W)),
		(_GUI_GRID_Y + 0 * (_GUI_GRID_H)),
		14*(_GUI_GRID_W),
		5*(_GUI_GRID_H)
	];

	// Set the position
	_titleTextCtrl ctrlSetPosition _titleTextPos;

	// Move the control to new position in 0 seconds
	_titleTextCtrl ctrlCommit 0;
*/

// Disable serilization to use displays and controls as variables
disableSerialization;

//	Get display and ctrlgroup
private _display = (findDisplay 304000);
private _controlGroup = _display displayCtrl 4110;

//	Define grid for use if controls are created / edited in this dialog
private _GUI_GRID_W = (safezoneW / 40);
private _GUI_GRID_H = (safezoneH / 25);
private _GUI_GRID_X = (0);
private _GUI_GRID_Y = (0);

// Create a control already defined in dialogs.hpp

// Create a text control which is in the control group
private _textCtrl = _display ctrlCreate ["menus_template_text", 4112, _controlGroup];
_textCtrl ctrlEnable false;

// Text for the control
private _text = parseText "
This is the mission menu.<br/><br/>
Here you will be able to use the extra features of this mission.<br/>
Some options are only available for certain roles.<br/>
<br/><br/>
";

// Set the text
_textCtrl ctrlSetStructuredText _text;

// Create a title
private _titleCtrl = _display ctrlCreate ["menus_template_title", 4113, _controlGroup];
_titleCtrl ctrlEnable false;

// Title text
private _title = parseText "
MISSION MENU
";

// Set title text
_titleCtrl ctrlSetStructuredText _title;

// Craete the title bar (just looks nice)
private _titleBarCtrl = _display ctrlCreate ["menus_template_titleBar", 4114, _controlGroup];
_titleBarCtrl ctrlEnable false;



/*
// Create a button
private _buttonCtrl = _display ctrlCreate ["menus_template_button", 4115, _controlGroup];

// change button size
(ctrlPosition _buttonCtrl) params ['_x','_y','_w','_h'];
_buttonCtrl ctrlSetPosition [(_x + (1 * _GUI_GRID_W)), (_y + (0.5 * _GUI_GRID_H)),(3*_GUI_GRID_W),(0.7*_GUI_GRID_H)];
_buttonCtrl ctrlCommit 0;
ctrlSetFocus _buttonCtrl;

ctrlSetFocus _buttonCtrl;
// Button text
private _buttonText = "Menu 1";
// Set button text
_buttonCtrl ctrlSetText _buttonText;
// Set action to button
_buttonCtrl ctrlSetEventHandler ["buttonClick","
	_this spawn {
		disableSerialization;

		params ['_control'];
		_control ctrlShow false;
		(ctrlPosition _control) params ['_x','_y','_w','_h'];

		private _display = (findDisplay 304000);
		private _controlGroup = _display displayCtrl 4110;
		private _ctrlMenu = _display ctrlcreate ['menus_template_listBox',41151,_controlGroup];


		_index = _ctrlMenu lbAdd 'eww';
		_index = _ctrlMenu lbAdd 'poop';
		lbSort _ctrlMenu;

		_ctrlMenu ctrlSetPosition [(_x), (_y),(_w),(_h)];
		_ctrlMenu ctrlCommit 0;

		private _hMod = ((lbSize _ctrlMenu)min 10)max 1;
		_ctrlMenu ctrlSetPosition [(_x), (_y),(_w),(_h*_hMod)];
		_ctrlMenu ctrlCommit 0.1;

		ctrlSetFocus _ctrlMenu;
		_ctrlMenu ctrlSetEventHandler [""LBSelChanged"",""
			_this spawn {
				disableSerialization;

				params ['_control','_index'];

				private _display = (findDisplay 304000);
				private _button = _display displayCtrl 4115;
				_button ctrlSetText (_control lbText _index);
				_button setVariable ['button_data',(_control lbData _index)];
				ctrlDelete _control;
				_button ctrlShow true;
			};
			false
		""];
		_ctrlMenu ctrlSetEventHandler [""KillFocus"",""
			_this spawn {
				disableSerialization;

				params ['_control','_index'];

				private _display = (findDisplay 304000);
				private _button = _display displayCtrl 4115;
				ctrlDelete _control;
				_button ctrlShow true;
			};
			false
		""];
	};
	false
"];
*/