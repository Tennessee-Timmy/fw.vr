class p_respawn_timer_1
{
	title = "RESPAWN TIMER:";
	values[] = {0};
	texts[] = {""};
	default = 0;
};
class p_respawn_timer_time
{
	title = "      - Respawn Timer Time (seconds)";
	values[] = {0,5,10,30,60,120,240,300,600,3600};
	default = RESPAWN_TIMER_PARAM_TIME;
};
class p_respawn_timer_lives
{
	title = "      - Respawn Timer Lives";
	values[] = {0,1,3,5,10,30,1000};
	default = RESPAWN_TIMER_PARAM_LIVES;
};
class p_respawn_timer_0
{
	title = "";
	values[] = {0};
	texts[] = {""};
	default = 0;
};