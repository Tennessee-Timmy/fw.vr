params ["_unit","_skills"];

_unit setSkill ["aimingAccuracy",(_skills select 0)];
_unit setSkill ["aimingShake",(_skills select 1)];
_unit setSkill ["aimingSpeed",(_skills select 2)];
_unit setSkill ["endurance",(_skills select 3)];
_unit setSkill ["spotDistance",(_skills select 4)];
_unit setSkill ["spotTime",(_skills select 5)];
_unit setSkill ["courage",(_skills select 6)];
_unit setSkill ["reloadSpeed",(_skills select 7)];
_unit setSkill ["commanding",(_skills select 8)];
_unit setSkill ["general",(_skills select 9)];
_unit allowFleeing 0;