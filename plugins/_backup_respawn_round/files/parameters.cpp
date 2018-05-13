class p_respawn_round_1
{
	title = "RESPAWN ROUND:";
	values[] = {0};
	texts[] = {""};
	default = 0;
};
class p_respawn_round_time
{
	title = "      - Round Time (minutes)";
	values[] = {999,1000,1,1001,2,1002,3,5,10,15,20,30,60,120};
	texts[] = {"0.1","0.5","1","1.5","2","2.5","3","5","10","15","20","30","60","120"};
	default = RESPAWN_ROUND_PARAM_TIME;
};
class p_respawn_round_prepTime
{
	title = "      - Preperation time before Rounds (seconds)";
	values[] = {1,5,10,15,20,30,60,120};
	default = RESPAWN_ROUND_PARAM_PREPTIME;
};
class p_respawn_round_count
{
	title = "      - Total rounds";
	values[] = {0,1,2,3,4,5,10,1000};
	default = RESPAWN_ROUND_PARAM_COUNT;
};
class p_respawn_round_count_win
{
	title = "      - Rounds victories needed to win";
	values[] = {0,1,2,3,4,5,10,1000};
	default = RESPAWN_ROUND_PARAM_COUNT_WIN;
};
class p_respawn_round_0
{
	title = "";
	values[] = {0};
	texts[] = {""};
	default = 0;
};