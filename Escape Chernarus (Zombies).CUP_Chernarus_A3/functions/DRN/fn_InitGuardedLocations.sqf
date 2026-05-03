if (!isServer) exitWith {};

private ["_locationNo", "_locationFullName", "_locationExists", "_isFaction", "_location", "_soldierType", "_soldierCount", "_soldier", "_soldiers", "_i"];
private ["_locationPos", "_possibleInfantryTypes"];


params [
    ["_referenceGroup", grpNull],
    ["_locationMarkerName", ""],
    ["_side", "BLUFOR"],
    ["_infantryClasses", "INS"],
    ["_maxGroupsCount", 10],
    ["_minSoldierCount", 5],
    ["_maxSoldierCount", 10],
    ["_minSkill", 0.05],
    ["_maxSkill", 0.5],
    ["_spawnRadius", 750.0],
    ["_debug", false]
];

_minSkill = 0.1;
_maxSkill = 0.2;

switch (A3E_Param_EnemySkill) do { 
    // Convert value from params.hpp into acceptable range 
    case 0: { _minSkill = 0.02; _maxSkill = 0.05; }; 
    case 1: { _minSkill = 0.05; _maxSkill = 0.1; }; 
    case 2: { _minSkill = 0.1; _maxSkill = 0.2; }; 
    case 3: { _minSkill = 0.2; _maxSkill = 0.30; }; 
    case 4: { _minSkill = 0.40; _maxSkill = 0.50; }; 
    default { _minSkill = 0.1; _maxSkill = 0.2; }; 
}; 

if (isNil "a3e_var_commonLibInitialized") then {
    [] spawn {
        while {true} do { player sideChat "Script AmbientInfantry.sqf needs CommonLib version 1.02"; sleep 5; };
    };
};

_isFaction = false;
if (str _infantryClasses == """USMC""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_USMC;
    _isFaction = true;
};
if (str _infantryClasses == """CDF""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_CDF;
    _isFaction = true;
};
if (str _infantryClasses == """RU""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_RU;
    _isFaction = true;
};
if (str _infantryClasses == """INS""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_INS;
    _isFaction = true;
};
if (str _infantryClasses == """GUE""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_GUE;
    _isFaction = true;
};

if (!_isFaction) then {
    _possibleInfantryTypes =+ _infantryClasses;
};

// Initialize global variable
sleep random 0.1;
if (isNil "a3e_var_guardedLocationsInstanceNo") then {
    a3e_var_guardedLocationsInstanceNo = 0;
}
else {
    a3e_var_guardedLocationsInstanceNo = a3e_var_guardedLocationsInstanceNo + 1;
};

//_instanceNo = a3e_var_guardedLocationsInstanceNo;
call compile format ["a3e_var_guardedLocations%1 = [];", a3e_var_guardedLocationsInstanceNo];

_locationNo = 0;
_locationFullName = _locationMarkerName + str _locationNo;


if (_debug) then
{
    diag_log format ["InitGuarded called for %1 at %2", _locationMarkerName, getMarkerPos _locationFullName];
};


if (((getMarkerPos _locationFullName) select 0) != 0 || ((getMarkerPos _locationFullName) select 1 != 0)) then
{
	_locationExists = true;
}
else {
	_locationExists = false;
};


if (isNil "a3e_var_guardedLocationsTriggerNames") then {
    a3e_var_guardedLocationsTriggerNames = [];
};

/*
if (_debug) then
{
    diag_log format ["InitGuarded a3e_var_guardedLocationsTriggerNames: %1", a3e_var_guardedLocationsTriggerNames];
};
*/

while {_locationExists} do {
	_locationPos = getMarkerPos _locationFullName;

    if (!(_locationFullName in a3e_var_guardedLocationsTriggerNames)) then
    {
        _soldierCount = [_minSoldierCount, _maxSoldierCount] call BIS_fnc_randomInt;

        if (_soldierCount < 1) then
        {
            _soldierCount = 1;
        };
        _soldiers = [];

        for "_i" from 1 to _soldierCount step 1 do
        {
            _soldierType = _possibleInfantryTypes select (floor (random (count _possibleInfantryTypes)));

            // soldier: [type, skill, spawned, damage, obj, scriptHandle, hasScript]
            _soldier = [_soldierType, (_minSkill + random (_maxSkill - _minSkill)), false, 0, objNull, objNull, false];
            _soldiers pushback _soldier;
        };

        _location = [_locationFullName, "", _soldiers, _locationPos];

        _location call compile format ["a3e_var_guardedLocations%1 set [count a3e_var_guardedLocations%2, _this];", a3e_var_guardedLocationsInstanceNo, a3e_var_guardedLocationsInstanceNo];

        // Set ammo depot trigger
        private ["_marker", "_count", "_populated", "_trigger"];
        
        _trigger = createTrigger["EmptyDetector", getMarkerPos _locationFullName, false];
        _trigger setTriggerInterval 5;
        _trigger triggerAttachVehicle [vehicle (units _referenceGroup select 0)];
        _trigger setTriggerArea[_spawnRadius, _spawnRadius, 0, false];
        _trigger setTriggerActivation["MEMBER", "PRESENT", true];
        _trigger setTriggerTimeout [1, 1, 1, true];
        private _activationString = format ["_nil = [a3e_var_guardedLocations%1 select %2, %3, %4, %5] spawn drn_fnc_PopulateLocation; diag_log 'PopulateLocation triggered for %6';", str a3e_var_guardedLocationsInstanceNo, str _locationNo, str _side, str _maxGroupsCount, str _debug, _locationFullName];
        private _deactivationString = format ["_nil = [a3e_var_guardedLocations%1 select %2, %3] spawn drn_fnc_DepopulateLocation; diag_log 'DepopulateLocation triggered for %4';", str a3e_var_guardedLocationsInstanceNo, str _locationNo, str _debug, _locationFullName];
        _trigger setTriggerStatements["this", _activationString, _deactivationString];
        
        if (_debug) then
        {
            diag_log format ["InitGuarded creating %1 trigger with _maxGroupsCount: %2 _soldierCount: %3 _soldiers: %4", _locationFullName, _maxGroupsCount, _soldierCount, _soldiers];
        };

        a3e_var_guardedLocationsTriggerNames pushBackUnique _locationFullName;

        if (_debug) then
        {
            diag_log format ["InitGuarded added %1 to a3e_var_guardedLocationsTriggerNames", _locationFullName];
            diag_log format ["InitGuarded a3e_var_guardedLocationsTriggerNames: ["];
            {
                diag_log format ["%1", _x];
            } forEach a3e_var_guardedLocationsTriggerNames;
            diag_log format ["]"]; 
        };

        // Get next guarded position
        _locationNo = _locationNo + 1;
        _locationFullName = _locationMarkerName + str _locationNo;
    };	

    if (((getMarkerPos _locationFullName) select 0) != 0 || ((getMarkerPos _locationFullName) select 1 != 0)) then
    {
        _locationExists = true;
    }
    else {
        _locationExists = false;
    };
};

