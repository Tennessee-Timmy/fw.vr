//credits to commy2
params ["_origin", "_objects"];
private _distances = _objects apply {_x distanceSqr _origin};
_objects select (_distances find selectMin _distances)