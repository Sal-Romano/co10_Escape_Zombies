params["_vehicle"];
private _lockParam = missionNamespace getvariable["A3E_Param_VehicleLock",0];

switch (_lockParam) do {
	case 1: {
		if(count (allTurrets _vehicle) > 0) then {
			_vehicle lock 3;
		};
	};
    case 2: {
		_vehicle lock 3;
	};
    default {  };
};


if (side _vehicle == A3E_VAR_Side_Civ) exitWith{};
private _loadoutChanged = false;


if (_vehicle isKindOf "Tank" || _vehicle isKindOf "Tank_F") then
{
	_loadoutChanged = [_vehicle] call a3e_fnc_ChangeVehicleInventory;
};
if (_loadoutChanged) exitWith {};

if (_vehicle isKindOf "Wheeled_APC" || _vehicle isKindOf "Wheeled_APC_F") then
{
	_loadoutChanged = [_vehicle] call a3e_fnc_ChangeVehicleInventory;
};
if (_loadoutChanged) exitWith {};

if (_vehicle isKindOf "Truck" || _vehicle isKindOf "Truck_F") then
{
	_loadoutChanged = [_vehicle] call a3e_fnc_ChangeVehicleInventory;
};
if (_loadoutChanged) exitWith {};

if (_vehicle isKindOf "Car" || _vehicle isKindOf "Car_F") then
{
	_loadoutChanged = [_vehicle] call a3e_fnc_ChangeVehicleInventory;
};
if (_loadoutChanged) exitWith {};

if (_vehicle isKindOf "Helicopter" || _vehicle isKindOf "Helicopter_F") then
{
	_loadoutChanged = [_vehicle] call a3e_fnc_ChangeVehicleInventory;
};
if (_loadoutChanged) exitWith {};
