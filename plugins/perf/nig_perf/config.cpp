class CfgPatches
{
	class nig_perf
	{
		units[]={};
		weapons[]={};
		requiredAddons[]={
			"cba_ui",
			"cba_xeh"
		};
		version="1.0";
		author="nigel / BadKneeGrow";
	};
};

class Extended_PostInit_EventHandlers {
    class My_post_init_event {
        init = "call compile preprocessFileLineNumbers 'XEHPOST.sqf'";
    };
};