class p_acre_1
{
	title = "ACRE PARAMETERS:";
	values[] = {0};
	texts[] = {""};
	default = 0;
};
class p_acre_enabled
{
	title = "      - Enable plugin settings";
	values[] = {0,1};
	texts[] = {"Disabled","Enabled"};
	default = ACRE_PARAM_ENABLED;
};
class p_acre_add
{
	title = "      - ADD radios";
	values[] = {0,1,2};
	texts[] = {"Automatically add radios","Don't automatically add radios","ADDING DISABLED"};
	default = ACRE_PARAM_GIVERADIOS;
};
class p_acre_setup
{
	title = "      - SETUP radios (frequencies etc.)";
	values[] = {0,1,2};
	texts[] = {"Automatic setup","Automatic disabled","SETUP DISABLED"};
	default = ACRE_PARAM_SETUPRADIOS;
};
class p_acre_0
{
	title = "";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

