class p_respawn_wave_1
{
	title = "RESPAWN WAVE:";
	values[] = {0};
	texts[] = {""};
	default = 0;
};
class p_respawn_wave_time
{
	title = "      - Wave Time (minutes)";
	values[] = {0,1,5,10,20,30,60,120};
	default = RESPAWN_WAVE_PARAM_TIME;
};
class p_respawn_wave_delay
{
	title = "      - Wave spawn duration (seconds)";
	values[] = {1,5,10,20,30,60,120};
	default = RESPAWN_WAVE_PARAM_DELAY;
};
class p_respawn_wave_count
{
	title = "      - Wave Count";
	values[] = {0,1,2,3,4,5,10,1000};
	default = RESPAWN_WAVE_PARAM_COUNT;
};
class p_respawn_wave_0
{
	title = "";
	values[] = {0};
	texts[] = {""};
	default = 0;
};