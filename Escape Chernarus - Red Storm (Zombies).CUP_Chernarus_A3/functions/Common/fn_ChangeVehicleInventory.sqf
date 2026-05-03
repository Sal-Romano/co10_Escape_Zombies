params["_vehicle"];


_vehicleWeapons = a3e_arr_CarWeapons;
_vehicleMags = a3e_arr_CarMags;
_VehicleItems = a3e_arr_CarItems;
_vehicleBackpacks = a3e_arr_CarBackpacks;

if (_vehicle isKindOf "Car" || _vehicle isKindOf "Car_F") then
{
    _vehicleWeapons = a3e_arr_CarWeapons;
    _vehicleMags = a3e_arr_CarMags;
    _VehicleItems = a3e_arr_CarItems;
    _vehicleBackpacks = a3e_arr_CarBackpacks;
};

if (_vehicle isKindOf "Wheeled_APC" || _vehicle isKindOf "Wheeled_APC_F") then
{
    _vehicleWeapons = a3e_arr_WheeledAPCWeapons;
    _vehicleMags = a3e_arr_WheeledAPCMags;
    _VehicleItems = a3e_arr_WheeledAPCItems;
    _vehicleBackpacks = a3e_arr_WheeledAPCBackpacks;
};


if (_vehicle isKindOf "Tank" || _vehicle isKindOf "Tank_F") then
{
    _vehicleWeapons = a3e_arr_TankWeapons;
    _vehicleMags = a3e_arr_TankMags;
    _VehicleItems = a3e_arr_TankItems;
    _vehicleBackpacks = a3e_arr_TankBackpacks;
};

if (_vehicle isKindOf "Truck" || _vehicle isKindOf "Truck_F") then
{
    _vehicleWeapons = a3e_arr_TruckWeapons;
    _vehicleMags = a3e_arr_TruckMags;
    _VehicleItems = a3e_arr_TruckItems;
    _vehicleBackpacks = a3e_arr_TruckBackpacks;
};

if (_vehicle isKindOf "Helicopter" || _vehicle isKindOf "Helicopter_F") then
{
    _vehicleWeapons = a3e_arr_HelicopterWeapons;
    _vehicleMags = a3e_arr_HelicopterMags;
    _VehicleItems = a3e_arr_HelicopterItems;
    _vehicleBackpacks = a3e_arr_HelicopterBackpacks;
};

_weapons = [];
_weaponMagazines = [];
_items = [];
_backpacks = [];

if (count _VehicleWeapons > 0) then
{
    for "_i" from 0 to (count _VehicleWeapons - 1) do {
        private ["_gunItem", "_weaponClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
        
        _gunItem = _VehicleWeapons select _i;
        
        _weaponClassName = _gunItem select 0;
        _probabilityOfPrecence = _gunItem select 1;
        _minCount = _gunItem select 2;
        _maxCount = _gunItem select 3;
        _magazines = _gunItem select 4;
        _magazinesPerWeapon = _gunItem select 5;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _weaponCount = floor (_minCount + random (_maxCount - _minCount));
            _weapons pushBack [_weaponClassName, _weaponCount];
            
            for "_j" from 0 to (count _magazines) - 1 do {
                _weaponMagazines pushBack [_magazines select _j, _weaponCount * _magazinesPerWeapon];
            };
        };
    };
};

if (count _VehicleMags > 0) then
{
    for "_i" from 0 to (count _VehicleMags - 1) do {
        private ["_magItem", "_weaponClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
        
        _magItem = _VehicleMags select _i;
        
        _magClassName = _magItem select 0;
        _probabilityOfPrecence = _magItem select 1;
        _minCount = _magItem select 2;
        _maxCount = _magItem select 3;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _magCount = floor (_minCount + random (_maxCount - _minCount));
            _weaponMagazines pushBack [_magClassName, _magCount];
            
        };
    };
};

if (count _VehicleItems > 0) then
{
    for "_i" from 0 to (count _VehicleItems - 1) do {
        private ["_item", "_itemClassName", "_probabilityOfPrecence", "_minCount", "_maxCount"];
        
        _item = _VehicleItems select _i;
        
        _itemClassName = _item select 0;
        _probabilityOfPrecence = _item select 1;
        _minCount = _item select 2;
        _maxCount = _item select 3;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _itemCount = floor (_minCount + random (_maxCount - _minCount));
            _items pushback [_itemClassName, _itemCount];
        };
    };
};

if (count _VehicleBackpacks > 0) then
{
    for "_i" from 0 to (count _VehicleBackpacks - 1) do {
        private ["_backpack", "_backpackClassName", "_probabilityOfPrecence", "_minCount", "_maxCount"];
        
        _backpack = _VehicleBackpacks select _i;
        
        _backpackClassName = _backpack select 0;
        _probabilityOfPrecence = _backpack select 1;
        _minCount = _backpack select 2;
        _maxCount = _backpack select 3;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _backpackCount = floor (_minCount + random (_maxCount - _minCount));
            _backpacks pushback [_backpackClassName, _backpackCount];
        };
    };
};

if (count _weapons > 0) then {

    clearWeaponCargoGlobal _vehicle;

    {
        _vehicle addWeaponCargoGlobal _x;
    } foreach _weapons;
};


if (count _weaponMagazines > 0) then {

    clearMagazineCargoGlobal _vehicle;
    
    {
        _vehicle addMagazineCargoGlobal _x;
    } foreach _weaponMagazines;

};

if (count _items > 0) then {

    clearItemCargoGlobal _vehicle;
    
    {
        _vehicle addItemCargoGlobal _x;
    } foreach _items;
};


if (count _backpacks > 0) then {

    clearBackpackCargoGlobal _vehicle;
    
    {
        _vehicle addBackpackCargoGlobal _x;
    } foreach _backpacks;
};

true;