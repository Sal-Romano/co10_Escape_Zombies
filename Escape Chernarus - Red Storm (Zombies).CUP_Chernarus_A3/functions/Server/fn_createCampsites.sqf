if(!isserver) exitwith {};

private ["_positions", "_i", "_j", "_tooCloseAnotherPos", "_pos", "_countNW", "_countNE", "_countSE", "_countSW", "_isOk","_regionCount"];

_positions = [];
_i = 0;

_countNW = 0;
_countNE = 0;
_countSE = 0;
_countSW = 0;

if(isNil("A3E_CampsiteCountMax")) then {
	A3E_CampsiteCountMax = 8;
};
if(isNil("A3E_CampsiteCountMin")) then {
	A3E_CampsiteCountMin = 4;
};
A3E_CampsiteCountMin = A3E_CampsiteCountMin;
A3E_CampsiteCountMax = A3E_CampsiteCountMax;
private _campsiteCount = A3E_CampsiteCountMin + random (A3E_CampsiteCountMax-A3E_CampsiteCountMin);

_regionCount = ceil(_campsiteCount/4);
while {count _positions < _campsiteCount} do {
    _isOk = false;
    _j = 0;

    while {!_isOk} do {
        _pos = [0.1,300,0.5,0.0] call A3E_fnc_findFlatAreaNew;
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

// Create campsite near prison to get more gunz
private _randomPos = A3E_StartPos vectorAdd [(random 400 * selectRandom [-1,1]),(random 400 * selectRandom [-1,1]),0];
private _camp_pos = [A3E_StartPos, 200.0, 400.0, 1.0, 0, 0.2, 0, [], _randomPos] call BIS_fnc_findSafePos;
_positions pushBack _camp_pos;

{
   _function =  selectRandom [
        A3E_fnc_ToothCampsite1,
        A3E_fnc_ToothCampsite2,
        A3E_fnc_ToothCampsite3,
        A3E_fnc_ToothCampsite4
    ];

    if(A3E_Param_UseDLCSOGPF==1) then
    {
        _function =  selectRandom [
        A3E_fnc_ToothVCCampsite1,
        A3E_fnc_ToothVCCampsite2,
        A3E_fnc_ToothVCCampsite3,
        A3E_fnc_ToothVCCampsite4
        ];
    };

    [_x] call _function;

    diag_log format ["Campsite created at %1", _x];

    _centerPos = _x;

    // Set markers -------------------------------------------------------------------------------------------------------------
    if (isNil "A3E_CampsiteMarkerNumber") then {
	A3E_CampsiteMarkerNumber = 0;
    }
    else {
        A3E_CampsiteMarkerNumber = A3E_CampsiteMarkerNumber + 1;
    };
    A3E_CampsiteMarkerNumber = A3E_CampsiteMarkerNumber;

    ["A3E_CampsiteMapMarker" + str A3E_CampsiteMarkerNumber,_centerPos,"o_unknown"] call A3E_fnc_createLocationMarker;

    diag_log format ["Created %1 at %2", "A3E_CampsiteMapMarker" + str A3E_CampsiteMarkerNumber, _centerPos];

    _marker = createMarkerLocal ["A3E_CampsitePatrolMarker" + str A3E_CampsiteMarkerNumber, _centerPos];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerAlphaLocal 0;
    _marker setMarkerSizeLocal [50, 50];

} foreach _positions;

private _enemyCount = [1.0] call A3E_fnc_GetEnemyCount;
_enemyCount params ["_minEnemies", "_maxEnemies"];

private _playergroup = [] call A3E_fnc_getPlayerGroup;
[_playergroup, "A3E_CampsitePatrolMarker", A3E_VAR_Side_Opfor, "GUE", 1, _minEnemies, _maxEnemies, A3E_Param_EnemySkill, A3E_Param_EnemySkill, A3E_Param_EnemySpawnDistance, A3E_Debug] spawn drn_fnc_InitGuardedLocations;
