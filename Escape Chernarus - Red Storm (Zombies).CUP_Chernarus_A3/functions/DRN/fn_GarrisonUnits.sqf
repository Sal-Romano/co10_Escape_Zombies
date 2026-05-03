private ["_side", "_soldiertype", "_markername"];

_side = _this select 0;
_soldiertype = a3e_arr_Escape_InfantryTypes;
_markername = _this select 2;
_locationObject = _this select 3;
_locationPos = _locationObject select 3;

_watchtower1 = _locationPos nearObjects ["Land_GuardTower_01_F", 50];
{
	_group = createGroup _side;
	_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
    //_type = selectRandom _soldierType;
    //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
	_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
	_soldier setVariable ["UseGrid", True];
    //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
	_soldier spawn A3E_fnc_onEnemySoldierSpawn;
	_house1 = selectRandom _watchtower1;
	_bpos = _house1 buildingPos -1;
	_numberofBpos = count _bpos;
	_rbpos = (floor (random _numberofBpos))+1;
	//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
	_soldier setPosATL (_house1 buildingPos _rbpos);
} forEach _watchtower1;

_bunker1 = _locationPos nearObjects ["Land_Bunker_01_HQ_F", 50];
{
	//private _enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	//_enemyCount params ["_minEnemies", "_maxEnemies"];
	_maxEnemies = 2;
	for "_i" from 1 to _maxEnemies step 1 do {
		_group = createGroup _side;
		_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        //_type = selectRandom _soldierType;
        //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
		_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True];
        //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		_house1 = selectRandom _bunker1;
		_bpos = _house1 buildingPos -1;
		_numberofBpos = count _bpos;
		_rbpos = (floor (random _numberofBpos))+1;
		//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
		_soldier setPosATL (_house1 buildingPos _rbpos);
	};
} forEach _bunker1;

_tower1 = _locationPos nearObjects ["Land_GuardTower_02_F", 50];
{
	//private _enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	//_enemyCount params ["_minEnemies", "_maxEnemies"];
	_maxEnemies = 1;
	for "_i" from 1 to _maxEnemies step 1 do {
		_group = createGroup _side;
		_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        //_type = selectRandom _soldierType;
        //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
		_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True];
        //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		_house1 = selectRandom _tower1;
		_bpos = _house1 buildingPos -1;
		_numberofBpos = count _bpos;
		_rbpos = (floor (random _numberofBpos))+1;
		//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
		_soldier setPosATL (_house1 buildingPos _rbpos);
	};
} forEach _tower1;

_bunker2 = _locationPos nearObjects ["Land_Bunker_01_big_F", 50];
{
	//private _enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	//_enemyCount params ["_minEnemies", "_maxEnemies"];
	_maxEnemies = 2;
	for "_i" from 1 to _maxEnemies step 1 do {
		_group = createGroup _side;
		_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
       // _type = selectRandom _soldierType;
        //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
		_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True];
        //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		_house1 = selectRandom _bunker2;
		_bpos = _house1 buildingPos -1;
		_numberofBpos = count _bpos;
		_rbpos = (floor (random _numberofBpos))+1;
		//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
		_soldier setPosATL (_house1 buildingPos _rbpos);
	};
} forEach _bunker2;

_bunker3 = _locationPos nearObjects ["Land_Bunker_01_small_F", 50];
{
	//private _enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	//_enemyCount params ["_minEnemies", "_maxEnemies"];
	_maxEnemies = 1;
	for "_i" from 1 to _maxEnemies step 1 do {
		_group = createGroup _side;
		_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        //_type = selectRandom _soldierType;
        //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
		_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True];
        //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		_house1 = selectRandom _bunker3;
		_bpos = _house1 buildingPos -1;
		_numberofBpos = count _bpos;
		_rbpos = (floor (random _numberofBpos))+1;
		//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
		_soldier setPosATL (_house1 buildingPos _rbpos);
	};
} forEach _bunker3;

_bunker4 = _locationPos nearObjects ["Land_Bunker_01_tall_F", 50];
{
	//private _enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	//_enemyCount params ["_minEnemies", "_maxEnemies"];
	_maxEnemies = 1;
	for "_i" from 1 to _maxEnemies step 1 do {
		_group = createGroup _side;
		_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        //_type = selectRandom _soldierType;
        //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
		_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True];
        //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		_house1 = selectRandom _bunker4;
		_bpos = _house1 buildingPos -1;
		_numberofBpos = count _bpos;
		_rbpos = (floor (random _numberofBpos))+1;
		//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
		_soldier setPosATL (_house1 buildingPos _rbpos);
	};
} forEach _bunker4;

_tower2 = _locationPos nearObjects ["Land_vn_hut_tower_01", 50];
{
	//private _enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	//_enemyCount params ["_minEnemies", "_maxEnemies"];
	_maxEnemies = 1;
	for "_i" from 1 to _maxEnemies step 1 do {
		_group = createGroup _side;
		_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        //_type = selectRandom _soldierType;
        //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
		_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True];
        //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		_house1 = selectRandom _tower2;
		_bpos = _house1 buildingPos -1;
		_numberofBpos = count _bpos;
		_rbpos = (floor (random _numberofBpos))+1;
		//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
		_soldier setPosATL (_house1 buildingPos _rbpos);
	};
} forEach _tower2;

_tower3 = _locationPos nearObjects ["Land_vn_hut_tower_02", 50];
{
	//private _enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	//_enemyCount params ["_minEnemies", "_maxEnemies"];
	_maxEnemies = 1;
	for "_i" from 1 to _maxEnemies step 1 do {
		_group = createGroup _side;
		_spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        //_type = selectRandom _soldierType;
        //_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
		_soldier = _group createUnit [selectRandom _soldierType, _spawnPos, [], 0, "FORM"];
		_soldier setVariable ["UseGrid", True];
        //[_soldier, (compileFinal _init)] spawn BIS_fnc_spawn;
		_soldier spawn A3E_fnc_onEnemySoldierSpawn;
		_house1 = selectRandom _tower3;
		_bpos = _house1 buildingPos -1;
		_numberofBpos = count _bpos;
		_rbpos = (floor (random _numberofBpos))+1;
		//diag_log format["fn_garrisonUnits: building %1 selected, has b-positions %2 at %3, bpos %3 selected",_house1,_numberofBpos,_bpos,_rbpos];
		_soldier setPosATL (_house1 buildingPos _rbpos);
	};
} forEach _tower3;