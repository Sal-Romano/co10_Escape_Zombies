if(!isserver) exitwith {};

private ["_positions", "_i", "_j", "_tooCloseAnotherPos", "_pos", "_countNW", "_countNE", "_countSE", "_countSW", "_isOk","_regionCount"];

_positions = [];
_i = 0;

_countNW = 0;
_countNE = 0;
_countSE = 0;
_countSW = 0;

if(isNil("A3E_AmmoCacheCountMax")) then {
	A3E_AmmoCacheCountMax = 4;
};
if(isNil("A3E_AmmoCacheCountMin")) then {
	A3E_AmmoCacheCountMin = 2;
};
A3E_AmmoCacheCountMin = A3E_AmmoCacheCountMin;
A3E_AmmoCacheCountMax = A3E_AmmoCacheCountMax;
private _ammoCacheSiteCount = A3E_AmmoCacheCountMin + random (A3E_AmmoCacheCountMax-A3E_AmmoCacheCountMin);

_regionCount = ceil(_ammoCacheSiteCount/4);
while {count _positions < _ammoCacheSiteCount} do {
    _isOk = false;
    _j = 0;

    while {!_isOk} do {
        _pos = [1.0,200,0.4,0.0] call A3E_fnc_findFlatAreaNew;
        _isOk = true;


        if (_pos select 0 <= ((getpos center) select 0) && _pos select 1 > ((getpos center)select 1)) then {
            if (_countNW <= _regionCount) then {
                _countNW = _countNW + 1;
            }
            else {
                _isOk = false;
            };
        };
        if (_pos select 0 > ((getpos center)select 0) && _pos select 1 > ((getpos center) select 1)) then {
            if (_countNE <= _regionCount) then {
                _countNE = _countNE + 1;
            }
            else {
                _isOk = false;
            };
        };
        if (_pos select 0 > ((getpos center)select 0) && _pos select 1 <= ((getpos center) select 1)) then {
            if (_countSE <= _regionCount) then {
                _countSE = _countSE + 1;
            }
            else {
                _isOk = false;
            };
        };
        if (_pos select 0 <= ((getpos center)select 0) && _pos select 1 <= ((getpos center) select 1)) then {
            if (_countSW <= _regionCount) then {
                _countSW = _countSW + 1;
            }
            else {
                _isOk = false;
            };
        };

        _j = _j + 1;
        if (_j > 100) then {
            _isOk = true;
        };
    };

    _tooCloseAnotherPos = false;

	//Check if too close to another depot, comcenter or start
	{
        if (_pos distance _x < A3E_ClearedPositionDistance/2.0) then {
            _tooCloseAnotherPos = true;
        };
    } foreach A3E_Var_ClearedPositions;


    if (!_tooCloseAnotherPos) then {
        _positions pushBack  _pos;
		A3E_Var_ClearedPositions pushBack _pos;
    };

    _i = _i + 1;
    if (_i > 100) exitWith {
        _positions
    };
};

{
   _function =  selectRandom [
        A3E_fnc_ToothAmmoCacheSite1,
        A3E_fnc_ToothAmmoCacheSite2
    ];

    if(A3E_Param_UseDLCSOGPF==1) then
    {
        _function =  selectRandom [
            A3E_fnc_ToothVCAmmoCacheSite1,
            A3E_fnc_ToothVCAmmoCacheSite2
        ];
    };

    [_x,[a3e_AmmoDepotBox]] call _function;

    _centerPos =_x;

    diag_log format["Ammo Cache created at %1", _centerPos];
    
    if (isNil "A3E_AmmoCacheMarkerNumber") then {
        A3E_AmmoCacheMarkerNumber = 0;
    }
    else {
        A3E_AmmoCacheMarkerNumber = A3E_AmmoCacheMarkerNumber + 1;
    };

    // Set markers -------------------------------------------------------------------------------------------------------------
    ["drn_AmmoCacheMapMarker" + str A3E_AmmoCacheMarkerNumber, _centerPos, "o_support"] call A3E_fnc_createLocationMarker;

    diag_log format ["Created %1 at %2", "drn_AmmoCacheMapMarker" + str A3E_AmmoCacheMarkerNumber, _centerPos];

    _marker = createMarkerLocal ["A3E_AmmoCachePatrolMarker" + str A3E_AmmoCacheMarkerNumber, _centerPos];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerAlphaLocal 0;
    _marker setMarkerSizeLocal [50, 50];

} foreach _positions;

private _enemyCount = [1.5] call A3E_fnc_GetEnemyCount;
_enemyCount params ["_minEnemies", "_maxEnemies"];

private _playergroup = [] call A3E_fnc_getPlayerGroup;
[_playergroup, "A3E_AmmoCachePatrolMarker", A3E_VAR_Side_Opfor, "GUE", 1, _minEnemies, _maxEnemies, A3E_Param_EnemySkill, A3E_Param_EnemySkill, A3E_Param_EnemySpawnDistance, A3E_Debug] spawn drn_fnc_InitGuardedLocations;
