//POSTINIT
//
//
if !(mission_headless_controller) exitWith { };

//
// [[*spawn logic*,*patrol logic*],*spawn distance*,*patrol distance*,[*side*,*unitArray*],[*patrol buildings*,*stance*,*speed*],*outer spawn*,[*min*,*max*],*offencive*,*skill*,[*startCached*,*limit*,*disabled*],*wave_var*] call aiMaster_fnc_aiSpawnInf;
// [[*spawn logic*,*patrol logic*],*spawn distance*,*patrol distance*,[*side*,*unitArray*],[*only roads*,*stance*,*speed*,*trans*],*outer spawn*,*road spawn*,[*min*,*max*],*offencive*,*skill*,[*startCached*,*limit*,*disabled*],*wave_var*] call aiMaster_fnc_aiSpawnVeh;



//first town
[town_1,100,100,[resistance,2],[true,"SAFE","LIMITED"],false,[8,8],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_1,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[4,4],[true,true],0.5,[true,101,false,false,[1300,1500]]] call aiMaster_fnc_aiSpawnInf;

// first oilfield
base_1_attack = false;
[base_1,100,100,[resistance,2],[true,"SAFE","LIMITED"],false,[1,1],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[base_1,200,200,[resistance,3],[true,"SAFE","LIMITED"],true,[4,4],[false,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[base_1,200,200,[resistance,3],[true,"SAFE","LIMITED"],false,[4,4],[false,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[base_1,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[3,3],[false,true],0.5,[true,101,false,false,[1000,1200]]] call aiMaster_fnc_aiSpawnInf;
[base_1,800,600,[resistance,1],[false,"SAFE","LIMITED"],true,[2,4],[true,false],0.5,[true,101,false,false,[1300,1500]]] call aiMaster_fnc_aiSpawnInf;

[base_1,250,250,[resistance,1],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,2],[true,true],0.5,[true,101,false,false,[1400,1600]]] call aiMaster_fnc_aiSpawnVeh;
[base_1,250,250,[resistance,2],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,2],[true,true],0.5,[true,101,false,false,[1400,1600]]] call aiMaster_fnc_aiSpawnVeh;
[base_1,500,500,[resistance,4],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1400,1600]]] call aiMaster_fnc_aiSpawnVeh;

// backup for oilfield
[[attack_2,base_1],250,250,[resistance,2],[false,"AWARE","FULL",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1400,1600]],'base_1_attack'] call aiMaster_fnc_aiSpawnVeh;
[[attack_2,base_1],250,250,[resistance,7],[false,"AWARE","FULL",true],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1800,2000]],'base_1_attack'] call aiMaster_fnc_aiSpawnVeh;
[[attack_1,base_1],500,250,[resistance,4],[false,"AWARE","FULL",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1800,2000]],'base_1_attack'] call aiMaster_fnc_aiSpawnVeh;
[[attack_1,base_1],750,250,[resistance,2],[false,"AWARE","FULL",false],[false,[0,1]],false,[1,3],[true,true],0.5,[true,101,false,false,[1800,2000]],'base_1_attack'] call aiMaster_fnc_aiSpawnVeh;
[[attack_1,base_1],1000,250,[resistance,7],[false,"AWARE","FULL",true],[false,[0,1]],false,[1,3],[true,true],0.5,[true,101,false,false,[1800,2000]],'base_1_attack'] call aiMaster_fnc_aiSpawnVeh;

// infantry attack
[attack_4,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.5,[true,101,false,false,[1200,1400]]] call aiMaster_fnc_aiSpawnInf;
[attack_4,500,500,[resistance,5],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1400,1600]]] call aiMaster_fnc_aiSpawnVeh;


// oepn field houses
[mid_1,250,250,[resistance,2],[false,"SAFE","LIMITED"],false,[1,1],[true,false],0.5,[true,101,false,false,[1000,1200]]] call aiMaster_fnc_aiSpawnInf;
[mid_1,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[1000,1200]]] call aiMaster_fnc_aiSpawnInf;

// on hill
[mid_2,500,500,[resistance,1],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.5,[true,101,false,false,[1000,1200]]] call aiMaster_fnc_aiSpawnInf;

// vehicle patrols near attack
[attack_1,1500,1500,[resistance,2],[true,"AWARE","LIMITED",false],[false,[0,1]],false,[2,2],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;



// timurkulay
[town_2,50,50,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_2,250,250,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_2,250,250,[resistance,3],[true,"SAFE","LIMITED"],false,[3,3],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_2,250,250,[resistance,3],[true,"SAFE","LIMITED"],true,[3,3],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_2,500,500,[resistance,1],[false,"SAFE","LIMITED"],false,[3,3],[true,true],0.5,[true,101,false,false,[1300,1500]]] call aiMaster_fnc_aiSpawnInf;
[town_2,250,250,[resistance,2],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,2],[true,true],0.5,[true,101,false,false,[1400,1600]]] call aiMaster_fnc_aiSpawnVeh;
[town_2,250,250,[resistance,3],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;

// south of timurkulay
[mid_3,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[1100,1300]]] call aiMaster_fnc_aiSpawnInf;
[mid_13,150,500,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[1100,1300]]] call aiMaster_fnc_aiSpawnInf;


// Landay
[town_3,101,50,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_3,150,150,[resistance,3],[true,"SAFE","LIMITED"],false,[4,4],[false,false],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_3,750,500,[resistance,2],[false,"SAFE","LIMITED"],false,[5,5],[true,true],0.5,[true,101,false,false,[1300,1500]]] call aiMaster_fnc_aiSpawnInf;
[town_3,250,250,[resistance,2],[false,"SAFE","LIMITED"],false,[5,5],[false,true],0.5,[true,101,false,false,[1100,1300]]] call aiMaster_fnc_aiSpawnInf;

// ahmaday
[mid_15,50,150,[resistance,3],[true,"SAFE","LIMITED"],false,[3,3],[false,true],0.5,[true,101,false,false,[400,500]]] call aiMaster_fnc_aiSpawnInf;
[mid_15,50,150,[resistance,3],[false,"SAFE","LIMITED"],false,[3,3],[false,true],0.5,[true,101,false,false,[500,600]]] call aiMaster_fnc_aiSpawnInf;

[town_3,300,300,[resistance,4],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;
[town_3,1500,750,[resistance,2],[true,"AWARE","LIMITED",false],[false,[0,1]],false,[1,4],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;

// near landay
[mid_4,300,300,[resistance,1],[false,"SAFE","NORMAL"],false,[3,3],[true,true],0.5,[true,101,false,false,[1200,1400]]] call aiMaster_fnc_aiSpawnInf;
[mid_4,750,750,[resistance,2],[false,"SAFE","NORMAL"],false,[3,6],[true,true],0.5,[true,101,false,false,[1100,1300]]] call aiMaster_fnc_aiSpawnInf;
[mid_4,750,750,[resistance,5],[false,"AWARE","NORMAL",false],[false,[0,1]],false,[1,2],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;


// Chak Chak
[town_4,50,50,[resistance,1],[true,"SAFE","LIMITED"],false,[1,1],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_4,300,300,[resistance,3],[true,"SAFE","LIMITED"],true,[10,10],[false,true],0.5,[true,101,false,false,[500,600]]] call aiMaster_fnc_aiSpawnInf;
[town_4,750,750,[resistance,2],[false,"SAFE","LIMITED"],true,[5,5],[true,true],0.5,[true,101,false,false,[1300,1500]]] call aiMaster_fnc_aiSpawnInf;
[town_4,750,750,[resistance,2],[false,"SAFE","LIMITED"],true,[1,1],[true,false],0.5,[true,101,false,false,[1300,1500]]] call aiMaster_fnc_aiSpawnInf;
[town_4,300,300,[resistance,2],[false,"SAFE","LIMITED"],false,[5,5],[false,true],0.5,[true,101,false,false,[1100,1300]]] call aiMaster_fnc_aiSpawnInf;

[town_4,750,750,[resistance,2],[true,"AWARE","LIMITED",false],[false,[0,1]],false,[1,5],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;
[town_4,250,250,[resistance,4],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;
[town_4,250,250,[resistance,5],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,2],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;
[town_4,250,250,[resistance,6],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[1,2],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;


// under chak chak
[mid_14,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[1200,1400]]] call aiMaster_fnc_aiSpawnInf;



// radars
[radar_1,25,25,[resistance,2],[false,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[radar_1,25,25,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[radar_2,25,25,[resistance,2],[false,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[radar_2,25,25,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[radar_3,25,25,[resistance,2],[false,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[radar_3,25,25,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;


// north of chak chka
[mid_5,500,500,[resistance,1],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;

// resistance of chak chak
[mid_6,500,500,[resistance,1],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;


// huzurtiman
[mid_7,250,250,[resistance,2],[false,"SAFE","LIMITED"],false,[3,3],[true,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;


// sultansafe
[mid_8,250,250,[resistance,2],[false,"SAFE","LIMITED"],false,[3,3],[true,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;



// loy manara oilfield
base_2_attack = false;
[base_2,100,100,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[base_2,50,50,[resistance,2],[false,"SAFE","LIMITED"],false,[2,2],[false,false],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;
[base_2,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[4,4],[false,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;
[base_2,800,800,[resistance,2],[false,"SAFE","LIMITED"],true,[4,4],[true,true],0.5,[true,101,false,false,[1300,1500]]] call aiMaster_fnc_aiSpawnInf;

[base_2,1000,1000,[resistance,4],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[3,3],[true,true],0.5,[true,101,false,false,[1400,1600]]] call aiMaster_fnc_aiSpawnVeh;

// backup for oilfield
[[attack_3,base_2],250,250,[resistance,6],[false,"AWARE","NORMAL",false],[false,[0,1]],false,[2,2],[true,true],0.5,[true,101,false,false,[1400,1600]],'base_2_attack'] call aiMaster_fnc_aiSpawnVeh;
[[attack_3,base_2],250,250,[resistance,4],[false,"AWARE","NORMAL",false],[false,[0,1]],false,[3,3],[true,true],0.5,[true,101,false,false,[1400,1600]],'base_2_attack'] call aiMaster_fnc_aiSpawnVeh;
[[attack_3,base_2],250,250,[resistance,1],[false,"AWARE","NORMAL",false],[false,[0,1]],false,[1,3],[true,true],0.5,[true,101,false,false,[1400,1600]],'base_2_attack'] call aiMaster_fnc_aiSpawnVeh;
[[attack_3,base_2],250,250,[resistance,7],[false,"AWARE","NORMAL",true],[false,[0,1]],false,[2,5],[true,true],0.5,[true,101,false,false,[1400,1600]],'base_2_attack'] call aiMaster_fnc_aiSpawnVeh;


// oil storage
[base_3,200,200,[resistance,2],[true,"SAFE","LIMITED"],false,[2,2],[false,true],0.5,[true,101,false,false,[700,800]]] call aiMaster_fnc_aiSpawnInf;
[base_3,100,100,[resistance,2],[false,"SAFE","LIMITED"],false,[3,3],[false,true],0.5,[true,101,false,false,[700,800]]] call aiMaster_fnc_aiSpawnInf;
[base_3,100,100,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[base_3,400,400,[resistance,1],[false,"SAFE","LIMITED"],true,[2,2],[true,false],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;



// Airfield
[base_4,200,200,[resistance,3],[true,"SAFE","LIMITED"],false,[4,4],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[base_4,100,100,[resistance,2],[true,"SAFE","LIMITED"],false,[3,3],[false,true],0.5,[true,101,false,false,[700,800]]] call aiMaster_fnc_aiSpawnInf;
[base_4,100,100,[resistance,2],[false,"SAFE","LIMITED"],false,[4,4],[false,false],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[base_4,250,250,[resistance,2],[false,"SAFE","LIMITED"],true,[2,2],[false,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;
[base_4,1000,1000,[resistance,2],[false,"SAFE","LIMITED"],true,[5,5],[true,true],0.5,[true,101,false,false,[1100,1300]]] call aiMaster_fnc_aiSpawnInf;
[base_4,1000,1000,[resistance,2],[false,"SAFE","LIMITED"],true,[1,1],[true,false],0.5,[true,101,false,false,[1100,1300]]] call aiMaster_fnc_aiSpawnInf;

[base_4,750,750,[resistance,2],[true,"AWARE","LIMITED",false],[false,[0,1]],false,[1,5],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;
[base_4,250,250,[resistance,4],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[3,3],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;
[base_4,250,250,[resistance,6],[false,"AWARE","LIMITED",false],[false,[0,1]],false,[3,3],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;

// loy manara
[mid_9,150,150,[resistance,2],[false,"SAFE","LIMITED"],false,[4,4],[true,true],0.5,[true,101,false,false,[700,800]]] call aiMaster_fnc_aiSpawnInf;
[mid_9,150,150,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;

// Jaza
[mid_10,100,100,[resistance,2],[true,"SAFE","LIMITED"],false,[1,1],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[mid_10,100,100,[resistance,2],[false,"SAFE","LIMITED"],false,[3,3],[true,true],0.5,[true,101,false,false,[800,900]]] call aiMaster_fnc_aiSpawnInf;
[mid_10,100,100,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;



// hazar bagh
[town_5,50,50,[resistance,1],[true,"SAFE","LIMITED"],false,[1,1],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_5,50,50,[resistance,2],[false,"SAFE","LIMITED"],false,[1,1],[false,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
[town_5,150,150,[resistance,3],[true,"SAFE","LIMITED"],false,[10,10],[false,true],0.5,[true,101,false,false,[500,600]]] call aiMaster_fnc_aiSpawnInf;
[town_5,150,150,[resistance,1],[false,"SAFE","LIMITED"],true,[2,2],[false,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;
[town_5,750,750,[resistance,1],[false,"SAFE","LIMITED"],false,[3,3],[true,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;

[town_5,750,750,[resistance,2],[true,"AWARE","LIMITED",false],[false,[0,1]],false,[5,5],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;


// near hazar bagh
[mid_11,250,250,[resistance,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.5,[true,101,false,false,[900,1100]]] call aiMaster_fnc_aiSpawnInf;
[mid_11,300,750,[resistance,3],[true,"AWARE","LIMITED",false],[false,[0,1]],false,[2,2],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;
[mid_11,300,1000,[resistance,4],[true,"AWARE","LIMITED",false],[false,[0,1]],false,[1,1],[true,true],0.5,[true,101,false,false,[1700,1900]]] call aiMaster_fnc_aiSpawnVeh;

// chardarakht
[mid_12,350,350,[resistance,2],[false,"SAFE","LIMITED"],false,[6,6],[true,true],0.5,[true,101,false,false,[700,900]]] call aiMaster_fnc_aiSpawnInf;
[mid_12,350,350,[resistance,2],[false,"SAFE","LIMITED"],false,[1,1],[true,false],0.5,[true,101,false,false,[700,900]]] call aiMaster_fnc_aiSpawnInf;
[mid_12,150,150,[resistance,3],[false,"SAFE","LIMITED"],false,[6,6],[true,true],0.5,[true,101,false,false,[500,600]]] call aiMaster_fnc_aiSpawnInf;
[mid_12,250,250,[resistance,2],[true,"SAFE","LIMITED"],true,[2,2],[true,true],0.5,[true,101,false,false,[600,700]]] call aiMaster_fnc_aiSpawnInf;
