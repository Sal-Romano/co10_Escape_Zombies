if (!isServer) exitWith {};

private ["_markerName", "_soldierObjects", "_skill", "_soldierType", "_spawned", "_damage", "_group"];
private ["_script", "_groupMemberCount", "_fortify", "_noFollow", "_locationPos", "_maxGroupSize"];
private ["_spawnPos", "_firstGroup", "_createNewGroup"];

params [
    "_locationObject",
    "_side",
    ["_maxGroupsCount", 10],
    ["_debug", false]
];

_markerName = _locationObject select 0;
_soldierObjects = _locationObject select 2;
_locationPos = _locationObject select 3;

_maxGroupSize = ceil ((count _soldierObjects) / _maxGroupsCount);

if (_debug) then {
    diag_log format ["Populating location: %1", _markerName];
    diag_log format ["Populate _maxGroupsCount: %1", _maxGroupsCount];
    diag_log format ["Populate num _soldierObjects: %1", count _soldierObjects];
    diag_log format ["Populate _maxGroupSize: %1", _maxGroupSize];
    diag_log format ["Populate _soldierObjects: %1", _soldierObjects];
};

_groupMemberCount = 0;
_fortify = "";
_noFollow = "noFollow";
_firstGroup = true;
_createNewGroup = true;
_spawnedGroups = [];
_group = grpNull;

{
    private ["_soldierObject", "_soldier"];

    _continueLoop = true;
    _numGroups = count _spawnedGroups;
    if (_numGroups > _maxGroupsCount) then
    {
        _continueLoop = false;
        diag_log format ["Populate already spawned more groups (%1) than we were allowed to (%2)!!!!!!!!!!!!!!!", _numGroups, _maxGroupsCount];
    };

	_soldierObject = _x;

	_soldierType = _soldierObject select 0;
	_skill = _soldierObject select 1;
	_spawned = _soldierObject select 2;
	_damage = _soldierObject select 3;

    // if soldier object is not currently spawned and is "alive"
    if ((!_spawned) && _damage < 0.75 && _continueLoop) then
    {
        // if the current group's size is at max capacity, make a new group in a sec
        _groupMemberCount = count units _group;
        if (_groupMemberCount == _maxGroupSize) then
        {
            if (_debug) then
            {
                diag_log format ["Populate group %1 has reached its limit with %2 members", _group, _groupMemberCount];
            };
            _createNewGroup = true;
        };

        // if new group is needed or it's the first group, create a new group
        if ((_firstGroup || _createNewGroup) && _numGroups < _maxGroupsCount) then
        {
            _group = createGroup _side;
            _spawnedGroups pushBack _group;
            _createNewGroup = false;
            _firstGroup = false;
            if (_debug) then
            {
                diag_log format ["Populate created new group %1 at %2", _group, _markerName];
            };
        };
        
        _spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        
        _markerName setMarkerPosLocal _locationPos; // upsmon moves this away for some reason, so we need to reset it
        
        _soldier = _group createUnit [_soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True]; //SALSET

        _soldier setDamage _damage;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		
        if (_groupMemberCount == 1) then
        {
			_soldier setUnitRank "SERGEANT";
			//No UPSMON anymore!
            //_script = [_soldier, _markerName,false] spawn A3E_fnc_RandomPatrolRoute;
            //_soldierObject set [5, _script];
            //_soldierObject set [6, true];
			_script = [_group, _markerName] spawn A3E_fnc_Patrol;
			_group setvariable["A3E_GroupPatrolScript",_script];
        };

        _soldierObject set [2, true];
		_soldierObject set [4, _soldier];

        if (_debug) then
        {
            diag_log format ["Populate spawned %1 at %2", _soldierObject, _markerName];
        };
	};

    sleep 0.1;
} foreach _soldierObjects;

_garrison = [_side, _soldiertype, _markername, _locationObject] spawn drn_fnc_GarrisonUnits;
