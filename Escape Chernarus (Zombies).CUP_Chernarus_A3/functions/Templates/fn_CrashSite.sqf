if(!isserver) exitwith {};

private ["_object", "_position", "_marker", "_instanceNo", "_randomNo", "_gun", "_angle", "_car","_dir","_boxpos","_boxType","_TypeOfWreck"];

_position = [_this,0] call bis_fnc_param;

_TypeOfWreck = [];
_typeOfUnit = [];
if (count a3e_arr_CrashSiteWrecksCar >0) then {
	_blah=floor(random 2);
	if (_blah == 0) then {
	_TypeOfWreck = a3e_arr_CrashSiteWrecks;
	_typeOfUnit = a3e_arr_CrashSiteCrew;
	} else {
	_TypeOfWreck = a3e_arr_CrashSiteWrecksCar;
	_typeOfUnit = a3e_arr_CrashSiteCrewCar;
	};
} else { 
	_TypeOfWreck = a3e_arr_CrashSiteWrecks;
	_typeOfUnit = a3e_arr_CrashSiteCrew;
};

//Create a crashed object
_dir = random 360;
_object = createVehicle [_TypeOfWreck select(floor(random(count(_TypeOfWreck)))), _position, [], 0, "NONE"];
_object setPos _position;
_object setDir _dir;

if(isNil("a3e_CrashSiteMarkerNo")) then {
	a3e_CrashSiteMarkerNo = 0;
} else {
	a3e_CrashSiteMarkerNo = a3e_CrashSiteMarkerNo + 1;
};

//["a3e_CrashSiteMarker" + str a3e_CrashSiteMarkerNo,_position,"hd_warning","ColorGreen",_showMarker] call A3E_fnc_createLocationMarker;

//Create Smoke
private _effect = selectRandom ["SMOKE_SMALL", "SMOKE_MEDIUM", "SMOKE_BIG"];
_fx = [_position, _effect];
_fx remoteExec ["A3E_fnc_FireSmokeFX",0,true];


_boxType = a3e_crashSiteBox;
_boxpos = _position findEmptyPosition [3,15,_boxType];
 if(count _boxpos >0) then {
	_box = createVehicle [_boxType, _boxpos, [], 0, "NONE"];
 
	private ["_weapons", "_weaponMagazines", "_box", "_weaponCount","_items"];
	
    clearWeaponCargoGlobal _box;
    clearMagazineCargoGlobal _box;
    clearItemCargoGlobal _box;
    clearBackpackCargoGlobal  _box;
    // Basic Weapon Box
    _weapons = [];
    _weaponMagazines = [];
    _items = [];
    _backpacks = [];
    _mags = [];
    for "_i" from 0 to (count a3e_arr_CrashSiteWeapons - 1) do {
        private ["_handGunItem", "_weaponClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
        
        _handGunItem = a3e_arr_CrashSiteWeapons select _i;
        
        _weaponClassName = _handGunItem select 0;
        _probabilityOfPrecence = _handGunItem select 1;
        _minCount = _handGunItem select 2;
        _maxCount = _handGunItem select 3;
        _magazines = _handGunItem select 4;
        _magazinesPerWeapon = _handGunItem select 5;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _weaponCount = floor (_minCount + random (_maxCount - _minCount));
            _weapons pushBack [_weaponClassName, _weaponCount];
            
            for "_j" from 0 to (count _magazines) - 1 do {
                _weaponMagazines pushBack [_magazines select _j, _weaponCount * _magazinesPerWeapon];
            };
        };
    };
	 for "_i" from 0 to (count a3e_arr_CrashSiteItems - 1) do {
        private ["_item", "_itemClassName", "_probabilityOfPrecence", "_minCount", "_maxCount"];
        
        _item = a3e_arr_CrashSiteItems select _i;
        
        _itemClassName = _item select 0;
        _probabilityOfPrecence = _item select 1;
        _minCount = _item select 2;
        _maxCount = _item select 3;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _itemCount = floor (_minCount + random (_maxCount - _minCount));
            _items pushback [_itemClassName, _itemCount];
        };
    };
     for "_i" from 0 to (count a3e_arr_CrashSiteBackpacks - 1) do {
        private ["_backpack", "_backpackClassName", "_probabilityOfPrecence", "_minCount", "_maxCount"];
        
        _backpack = a3e_arr_CrashSiteBackpacks select _i;
        
        _backpackClassName = _backpack select 0;
        _probabilityOfPrecence = _backpack select 1;
        _minCount = _backpack select 2;
        _maxCount = _backpack select 3;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _backpackCount = floor (_minCount + random (_maxCount - _minCount));
            _backpacks pushback [_backpackClassName, _backpackCount];
        };
    };
    for "_i" from 0 to (count a3e_arr_CrashSiteMags - 1) do {
        private ["_item", "_itemClassName", "_probabilityOfPrecence", "_minCount", "_maxCount"];
        
        _item = a3e_arr_CrashSiteMags select _i;
        
        _itemClassName = _item select 0;
        _probabilityOfPrecence = _item select 1;
        _minCount = _item select 2;
        _maxCount = _item select 3;
        
        if (random 100 <= _probabilityOfPrecence) then {
            _itemCount = floor (_minCount + random (_maxCount - _minCount));
            _mags pushback [_itemClassName, _itemCount];
        };
    };
	{
		_box addWeaponCargoGlobal _x;
	} foreach _weapons;
	{
		_box addMagazineCargoGlobal _x;
	} foreach _weaponMagazines;
	{
		_box addItemCargoGlobal _x;
	} foreach _items;
	{
		_box addBackpackCargoGlobal _x;
	} foreach _backpacks;
    {
        _box addMagazineCargoGlobal _x;
    } foreach _mags;

	
	_grp = createGroup A3E_VAR_Side_Blufor;

    _soldierType = selectRandom _typeOfUnit;
    _init = [_soldierType,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
	_deadcrew = _grp createUnit [_soldierType, getpos _box, [], 15, "FORM"] ;
	_deadcrew setVariable ["UseGrid", True]; //SALSET
    [_deadcrew, (compileFinal _init)] spawn BIS_fnc_spawn;
	_deadcrew setdammage 1;

    _soldierType = selectRandom _typeOfUnit;
    _init = [_soldierType,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
	_deadcrew = _grp createUnit [_soldierType, getpos _box, [], 15, "FORM"] ;   
	_deadcrew setVariable ["UseGrid", True]; //SALSET
    [_deadcrew, (compileFinal _init)] spawn BIS_fnc_spawn;
	_deadcrew setdammage 1;
	

    revealCrashSiteMarkers = missionNamespace getvariable["A3E_Param_RevealCrashSiteMarkers",2];


    diag_log format["fn_CrashSite: Crash site created at %1", getpos _box];
    _marker = createMarker ["a3e_CrashSiteMarker" + str a3e_CrashSiteMarkerNo, getpos _box];
    _marker setMarkerColor "ColorGreen";
    _marker setMarkerType "hd_unknown";
    //_marker setMarkerAlpha 1.0;

    if (revealCrashSiteMarkers == 0) then // Never
    {
        _marker setMarkerAlpha 0.0;
    };
    if (revealCrashSiteMarkers == 1) then // Upon detection
    {
        _marker setMarkerAlpha 1.0;

        _trigger = createTrigger["EmptyDetector", getpos _box, false];
        _trigger setTriggerArea[400, 400, 0, false];
        _trigger setTriggerActivation["GROUP", "PRESENT", false];
        _trigger triggerAttachVehicle [([] call A3E_FNC_getPlayers) select 0];
        _activation = format["%1 setMarkerAlpha %2",str _marker, 1.0];
        _trigger setTriggerStatements["this",_activation ,""];
    };
    if (revealCrashSiteMarkers == 3) then // Always
    {
        _marker setMarkerAlpha 1.0;
    };
    if (revealCrashSiteMarkers > 3 || revealCrashSiteMarkers < 0) then
    {
        diag_log "Unknown type of A3E_Param_RevealMarkers";
    };

 };
 
