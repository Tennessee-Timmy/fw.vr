// usage [myarray,elemnet] call aiMaster_fnc_depend;
params ["_array","_element"];
_array deleteAt (_array find _element);