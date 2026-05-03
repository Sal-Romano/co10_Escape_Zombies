// fn_createDynamicPrison.sqf
// Spawns a dynamic prison at a given position
// Called on server, position passed from client
// params: [_pos, _player]

params ["_pos", "_player"];

if (!isServer) exitWith {};

// Find a flat spot near the position (within 200m, away from water)
private _spawnPos = _pos;
for "_i" from 0 to 50 do {
    private _testPos = _pos getPos [random 200, random 360];
    if (!surfaceIsWater _testPos && {(_testPos select 2) > 0}) exitWith {
        _spawnPos = _testPos;
    };
};
_spawnPos set [2, 0];

// Create prison objects - simple box of walls
private _objects = [];
private _wallType = "Land_Mil_WallBig_4m_F";

// Create a 12m x 12m prison box
private _walls = [
    // North wall (3 segments)
    [_wallType, [_spawnPos select 0, (_spawnPos select 1) + 6, 0], 0],
    [_wallType, [(_spawnPos select 0) + 4, (_spawnPos select 1) + 6, 0], 0],
    [_wallType, [(_spawnPos select 0) - 4, (_spawnPos select 1) + 6, 0], 0],
    // South wall (3 segments)
    [_wallType, [_spawnPos select 0, (_spawnPos select 1) - 6, 0], 0],
    [_wallType, [(_spawnPos select 0) + 4, (_spawnPos select 1) - 6, 0], 0],
    [_wallType, [(_spawnPos select 0) - 4, (_spawnPos select 1) - 6, 0], 0],
    // East wall (3 segments)
    [_wallType, [(_spawnPos select 0) + 6, _spawnPos select 1, 0], 90],
    [_wallType, [(_spawnPos select 0) + 6, (_spawnPos select 1) + 4, 0], 90],
    [_wallType, [(_spawnPos select 0) + 6, (_spawnPos select 1) - 4, 0], 90],
    // West wall (2 segments + gap for gate)
    [_wallType, [(_spawnPos select 0) - 6, (_spawnPos select 1) + 4, 0], 90],
    [_wallType, [(_spawnPos select 0) - 6, (_spawnPos select 1) - 4, 0], 90]
];

{
    _x params ["_type", "_wallPos", "_dir"];
    private _obj = createVehicle [_type, _wallPos, [], 0, "CAN_COLLIDE"];
    _obj setDir _dir;
    _obj setPos _wallPos;
    _obj enableSimulationGlobal true;
    _objects pushBack _obj;
} forEach _walls;

// Spawn guards around the prison
private _guardTypes = missionNamespace getVariable ["a3e_arr_Escape_StartPositionGuardTypes",
    ["CUP_O_RU_Soldier_GL", "CUP_O_RU_Soldier_MG", "CUP_O_RU_Soldier_TL", "CUP_O_RU_Soldier"]
];

private _guardGroup = createGroup [A3E_VAR_Side_Opfor, true];
for "_i" from 0 to 3 do {
    private _guardPos = _spawnPos getPos [10 + random 5, _i * 90];
    private _guard = _guardGroup createUnit [selectRandom _guardTypes, _guardPos, [], 0, "FORM"];
    _guard setDir (random 360);
    _guard setSkill 0.3;
    _guard setBehaviour "SAFE";
    _guard setCombatMode "YELLOW";
};

// Set up patrol for guards
private _wp = _guardGroup addWaypoint [_spawnPos, 15];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointBehaviour "SAFE";
private _wp2 = _guardGroup addWaypoint [_spawnPos getPos [20, random 360], 15];
_wp2 setWaypointType "MOVE";
private _wp3 = _guardGroup addWaypoint [_spawnPos, 15];
_wp3 setWaypointType "CYCLE";

// Move player inside the prison
_player setPos _spawnPos;
_player setCaptive true;
_player setVariable ["A3E_MP_InLobby", false, true];
_player setVariable ["A3E_MP_PrisonPos", _spawnPos, true];
_player setVariable ["A3E_MP_PrisonObjects", _objects, true];

// Return spawn position
_spawnPos
