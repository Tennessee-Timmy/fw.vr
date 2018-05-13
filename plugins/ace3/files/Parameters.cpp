class p_ace3_1
{
	title = "ACE3 PARAMETERS:";
	values[] = {0};
	texts[] = {""};
	default = 0;
};
class p_ace3_enabled
{
	title = "      - Enable plugin settings";
	values[] = {0,1};
	texts[] = {"Disabled","Enabled"};
	default = ACE3_PARAM_ENABLED;
};
class p_ace3_srv
{
	title = "      - CBA settings source";
	values[] = {0,1};
	texts[] = {"Mission - Medical level, player health and instead death default values always.","Server - use this if you want to change the paremeters"};
	default = 0;
};
class p_ace3_2
{
	title = "      MEDICAL:";
	values[] = {0};
	texts[] = {""};
	default = 0;
};
class p_ace3_med_everyone
{
	title = "          - Everyone has full medical training";
	values[] = {0,1};
	texts[] = {"Disabled","Enabled"};
	default = ACE3_PARAM_MED_EVERYONE_MEDIC;
};
class p_ace3_med_level
{
	title = "          - Medical Simulation level";
	values[] = {1,2};
	texts[] = {"Basic","Advanced"};
	default = ACE3_PARAM_MED_LEVEL;
};
class p_ace3_med_player
{
	title = "          - Player health Multiplier";
	values[] = {0.5,1,2,3,4,5};
	default = ACE3_PARAM_MED_PLAYER_HEALTH;
};
class p_ace3_med_insta
{
	title = "          - Instant Death";
	values[] = {0,1};
	texts[] = {"Disabled","Enabled"};
	default = ACE3_PARAM_MED_INSTADEATH;
};
class p_ace3_0
{
	title = "";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

