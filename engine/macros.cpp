// This file will contain macros used along the mission
// Main plugin macros
#define PLUGINF(var1) 				PLUGIN##_fnc_##var1
#define QUOTE(var1) 				#var1
#define PLUGIN_PATH 				plugins\##PLUGIN
#define QPLUGIN_PATH 				QUOTE(PLUGIN_PATH)
#define PLUGIN_PATHFILES 			plugins\##PLUGIN\files
#define QPLUGIN_PATHFILES2(var)		plugins\##var\files
#define QPLUGIN_PATHFILES3(var)		QPLUGIN_PATHFILES2(var)
#define QPLUGIN_PATHFILES			QPLUGIN_PATHFILES3(PLUGIN)
#define PLUGIN_PATHFILE(var2)		plugins\##PLUGIN\files\##var2
#define QPLUGIN_PATHFILE(var2)		QUOTE(PLUGIN_PATHFILE(var2))

// Other macro
#define PLAYERLIST				((allUnits + allDeadMen) select {isPlayer _x && {!(_x isKindOf "HeadlessClient_F")}})
#define ALIVELIST				(PLAYERLIST select {!(_x call respawn_fnc_deadCheck)})
#define DEADLIST				(PLAYERLIST select {(_x call respawn_fnc_deadCheck)})