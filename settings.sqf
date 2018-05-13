// --- EDIT THIS FILE ---
// Please CHANGE all the descriptions and names
// loadScreen and overviewPicture should be the same. (to keep size smaller)
briefingName = "briefingName (same as overview name) - Change this in the settings file inside the main mission folder!";

//--- LOADING SCREEN
// https://i.imgur.com/7JtkCKr.jpg
// Loading screen shows during loading, overview shows in the mission selection screen
onLoadName = "onLoadName - Change this in the settings file inside the main mission folder!";
onLoadMission = "onLoadMission - Change this in the settings file inside the main mission folder!";
loadScreen =  "images\loading-screen.jpg";

//--- OVERVIEW
// https://i.imgur.com/sytS2Ps.jpg
// Mission selection screen
// NAME - briefingName
author = "author - Change this in the settings file inside the main mission folder!";
overviewText = "overviewText - Change this in the settings file inside the main mission folder!";
//overviewPicture = "images\loading-screen.jpg";

//--- LOBBY
// https://i.imgur.com/8wsLlGk.jpg
// To change NAME: in editor > Attributes > General > Title [ POSSIBLE BUG, MIGHT OVERRIDE briefingName ]
// To change DESCRIPTION: in editor > Attributes > Multiplayer > Summary
// examples of configuring these:
// https://i.imgur.com/jVSR58T.jpg
// https://i.imgur.com/C3L9paj.jpg
//

//--- MISSION HEADER
// https://community.bistudio.com/wiki/Multiplayer_Game_Types
// Define your mission type and player count
class Header {
	gameType = Coop; // Game type, see 'class' columns in the table below
	minPlayers = 1; //min # of players the mission supports
	maxPlayers = 50; //max # of players the mission supports
};


//--- Disable Chat
// Voice is usually disabled because TFR/acre
// You can disable these to increase immersion or in case of TVTs
/*
	LEGEND:
	0 = Global
	1 = Side
	2 = Command
	3 = Group
	4 = Vehicle
	5 = Direct
	6 = System

	EXAMPLE:
	{0,true,true}
	{global,disableChat,disableVoice}
*/

disableChannels[]={
	{0,false,true},
	{1,false,true},
	{2,false,true},
	{3,false,true},
	{4,false,true},
	{5,false,true},
	{6,false,true}
};
