//
// allows ai to use statics. Only if static is set as UNLOCKED
params ["_group","_patrol"];
_val = _patrol;
_val params ["_loc","_dist","_val2","_out"];
_leader = leader _group;
private _statics = nearestObjects [(_leader),["staticWeapon"],_dist];
if (count _statics isEqualTo 0) exitWith {};
{
	if (!isNull (gunner _x) || (!(side _x isEqualTo civilian) && !(side _x isEqualTo (side _leader))) && ((locked _x) isEqualTo 0)) then {_statics = _statics - [_x]};
}count _statics;
if (count _statics isEqualTo 0) exitWith {};
{
	_x assignAsGunner (_statics deleteAt 0);
	[_x] orderGetIn true;
	true
}count units _group;
true