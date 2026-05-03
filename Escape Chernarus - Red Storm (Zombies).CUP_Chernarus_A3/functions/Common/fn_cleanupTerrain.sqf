// A3E_fnc_cleanupTerrain
//
// Removes all the objects within the radius distance of the _position specified on all clients.
//
// This creates a bunch of JIP remoteExec's so it can be a touch expensive
//
// Usage: [<position list>, <radius>] call A3E_fnc_cleanupTerrain
params [["_position", [], [[]]], ["_radius", 0, [0]]];

private _objectTypes = [
"TREE", "SMALL TREE", "BUSH", "BUILDING", "HOUSE", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "FENCE", "WALL", "HIDE", "BUSSTOP", "FOREST", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "ROCK", "ROCKS", "POWER LINES", "POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK"
];

{
	[_x, true] remoteExec ["hideObject", 0, true];
} forEach nearestTerrainObjects [_position, _objectTypes, _radius, false, true];
