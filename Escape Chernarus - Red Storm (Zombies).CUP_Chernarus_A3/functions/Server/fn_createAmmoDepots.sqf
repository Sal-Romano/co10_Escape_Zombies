if(!isserver) exitwith {};

private ["_positions", "_i", "_j", "_tooCloseAnotherPos", "_pos", "_countNW", "_countNE", "_countSE", "_countSW", "_isOk","_regionCount"];

_positions = [];
_i = 0;

_countNW = 0;
_countNE = 0;
_countSE = 0;
_countSW = 0;

if(isNil("A3E_AmmoDepotCount")) then {
            A3E_AmmoDepotCount = 8;
    };
_regionCount = ceil(A3E_AmmoDepotCount/4);
while {count _positions < A3E_AmmoDepotCount} do {
    _isOk = false;
    _j = 0;

    while {!_isOk} do {
        _pos = call A3E_fnc_findFlatAreaNew;
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
        if (_pos distance _x < A3E_ClearedPositionDistance) then {
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
                //A3E_fnc_AmmoDepot,
                //A3E_fnc_AmmoDepot2,
                //A3E_fnc_AmmoDepot3,
                //A3E_fnc_AmmoDepot4,
                //A3E_fnc_AmmoDepot5
                A3E_fnc_ToothAmmoDepot1,
                A3E_fnc_ToothAmmoDepot2,
                A3E_fnc_ToothAmmoDepot3,
                A3E_fnc_ToothAmmoDepot4];

    if(A3E_Param_UseDLCSOGPF==1) then
    {
        _function =  selectRandom [
                A3E_fnc_ToothVCAmmoDepot1,
                A3E_fnc_ToothVCAmmoDepot2
                ];
    };

    [_x, a3e_arr_Escape_AmmoDepot_StaticWeaponClasses, a3e_arr_Escape_AmmoDepot_ParkedVehicleClasses] call _function;

    _centerPos = _x;

    diag_log format["Ammo Depot created at %1", _x];

    if (isNil "A3E_AmmoDepotMarkerNumber") then {
	A3E_AmmoDepotMarkerNumber = 0;
    }
    else {
        A3E_AmmoDepotMarkerNumber = A3E_AmmoDepotMarkerNumber + 1;
    };

    // Set markers -------------------------------------------------------------------------------------------------------------
    ["A3E_AmmoDepotMapMarker" + str A3E_AmmoDepotMarkerNumber,_centerPos,"o_installation"] call A3E_fnc_createLocationMarker;

    diag_log format ["Created %1 at %2", "A3E_AmmoDepotMapMarker" + str A3E_AmmoDepotMarkerNumber, _centerPos];

    _marker = createMarkerLocal ["drn_AmmoDepotPatrolMarker" + str A3E_AmmoDepotMarkerNumber, _centerPos];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerAlphaLocal 0;
    _marker setMarkerSizeLocal [50, 50];
   
} foreach _positions;

a3e_var_Escape_AmmoDepotPositions = _positions;
publicVariable "a3e_var_Escape_AmmoDepotPositions";


private _enemyCount = [3] call A3E_fnc_GetEnemyCount;
_enemyCount params ["_minEnemies", "_maxEnemies"];

_playerGroup = [] call A3E_fnc_GetPlayerGroup;
[_playerGroup, "drn_AmmoDepotPatrolMarker", A3E_VAR_Side_Opfor , "INS", 3, _minEnemies, _maxEnemies, A3E_Param_EnemySkill, A3E_Param_EnemySkill, _enemySpawnDistance, A3E_Debug] spawn drn_fnc_InitGuardedLocations;