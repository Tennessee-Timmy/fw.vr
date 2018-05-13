class p_safe_1
{
	title = "SAFE ZONE PARAMETERS:";
	values[] = {0};
	texts[] = {""};
	default = 0;
};
class p_safe_time
{
	title = "      - Duration safe zones are enabled for";
	values[] = {60000,0,10,30,60,120,300,600};
	texts[] = {"Infinite","Disabled","10 seconds","30 seconds","1 minute","2 minutes","5 minutes","10 minutes"};
	default = SAFE_PARAM_TIME;
};
class p_safe_restrict_time
{
	title = "      - Duration movement restrictions are enabled for";
	values[] = {60000,0,10,30,60,120,300,600};
	texts[] = {"Infinite","Disabled","10 seconds","30 seconds","1 minute","2 minutes","5 minutes","10 minutes"};
	default = SAFE_PARAM_RESTRICT_TIME;
};
class p_safe_0
{
	title = "";
	values[] = {0};
	texts[] = {""};
	default = 0;
};