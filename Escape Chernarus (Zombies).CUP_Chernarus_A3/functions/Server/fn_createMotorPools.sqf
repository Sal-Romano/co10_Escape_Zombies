if(!isserver) exitwith {};

private ["_mpPosition", "_createMPcount", "_mapsize", "_mpc"];

_mpPosition = [];
_createMPcount = 0;

private _mapsize = (getPos NorthEast) distance (getPos SouthWest);
if (_mapsize < 5000) then 
	{
		_mpc = 0;
	}
	else
	{
		if (_mapsize < 10000) then
		{
			_mpc = 1;
		}
		else
		{
			if (_mapsize < 15000) then
			{
				_mpc = 2;
			}
			else
			{
				if (_mapsize < 20000) then
				{
					_mpc = 3;
				}
				else
				{
					if (_mapsize < 25000) then
					{
						_mpc = 4;
					}
					else
					{
						_mpc = 5;
					};
				};
			};
		};
	};

if(isNil("A3E_MotorPoolCount")) then {

		private _playergroup = [] call A3E_fnc_getPlayerGroup;
		private _numplayers = count units _playergroup;
		private _additionalMotorPools = ceil(_numplayers/2);
        A3E_MotorPoolCount = ((floor random _mpc)+_additionalMotorPools);
		diag_log format ["Should create %1 Motor Pool including %2 additional", A3E_MotorPoolCount, _additionalMotorPools];
    };
private _sites = [] + a3e_communicationCenterMarkers;



while {_createMPcount < A3E_MotorPoolCount && count(_sites)>0} do {
    private _siteMarker = _sites deleteAt floor(random (count _sites)); //Get a random position and remove it from possible pos
	private _pos = _siteMarker select 0;
	private _dir = _siteMarker select 1;
	
	private _tooCloseAnotherPos = false;
	//Check if too close to another depot, comcenter or start
	{
        if (_pos distance _x < A3E_ClearedPositionDistance) then {
            _tooCloseAnotherPos = true;
        };
    } foreach A3E_Var_ClearedPositions;


    if (!_tooCloseAnotherPos) then {
        _mpPosition pushBack  _siteMarker;
		_createMPcount = (_createMPcount + 1);
		A3E_Var_ClearedPositions pushBack _pos;
    };
};
if(count(_sites)==0 && _createMPcount<A3E_MotorPoolCount) then {
	diag_log "Escape Warning: Not enough sites left to place all motorpools.";
};

a3e_var_Escape_MotorPoolPositions = [];

diag_log format ["Motor Pool sites available: %1 at %2", count _mpPosition, _mpPosition];


private _playergroup = [] call A3E_fnc_getPlayerGroup;
{
    // Fixme: hard coding to 180° orientation for now

	_function = A3E_fnc_ToothBuildMotorPool;
	if(A3E_Param_UseDLCSOGPF==1) then
	{
		_function = A3E_fnc_ToothNVABuildMotorPool;
	};

	[_x, 180, a3e_arr_ComCenStaticWeapons,
		a3e_arr_Escape_ReinforcementTruck_vehicleClasses, 
		a3e_arr_ComCenDefence_lightArmorClasses + a3e_arr_ComCenDefence_heavyArmorClasses,
		a3e_arr_StaticAAWeapons] call _function;

	_centerPos = _x select 0;

	diag_log format ["Motor Pool created at %1", _centerPos];

	// Set markers -------------------------------------------------------------------------------------------------------------
	if(isNil("A3E_MotorPoolMarkerNumber")) then {
		A3E_MotorPoolMarkerNumber = 0;
	} else {
		A3E_MotorPoolMarkerNumber = A3E_MotorPoolMarkerNumber + 1;
	};

	["A3E_MotorPoolMapMarker" + str A3E_MotorPoolMarkerNumber,_centerPos,"o_service"] call A3E_fnc_createLocationMarker;

	diag_log format ["Created %1 at %2", "A3E_MotorPoolMapMarker" + str A3E_MotorPoolMarkerNumber, _centerPos];

	_marker = createMarkerLocal ["A3E_MotorPoolPatrolMarker" + str A3E_MotorPoolMarkerNumber, _centerPos];
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerAlphaLocal 0;
	_marker setMarkerSizeLocal [40, 38];

	a3e_var_Escape_MotorPoolPositions pushBack _centerPos;
} foreach _mpPosition;

sleep 1.0;
private _enemyCount = [3.5] call A3E_fnc_GetEnemyCount;
_enemyCount params ["_minEnemies", "_maxEnemies"];

private _playergroup = [] call A3E_fnc_getPlayerGroup;
[_playergroup, "A3E_MotorPoolPatrolMarker", A3E_VAR_Side_Opfor, "INS", 4, 6, 8, A3E_Param_EnemySkill, A3E_Param_EnemySkill, A3E_Param_EnemySpawnDistance, A3E_Debug] spawn drn_fnc_InitGuardedLocations;

//a3e_var_Escape_MotorPoolPositions = _mpPosition;
publicVariable "a3e_var_Escape_MotorPoolPositions";
