// Find Flat area: picks a random location on the map, then searches
// for a flat area within a grid of +/- _offset_radius. The "radius"
// is meant in the sense of "chessboard" (or Chebyshev) distance (in
// other words, the region searched is always a square).
// 
// 
// Parameters:
//   _flat_area_radius         (default is 3):  the radius of the area of
//                                              flatness to search for
//
//   _offset_radius         (default is 1000):  the radius of the search area
//                                              after a random map point is
//                                              selected (meters)
//
//   _gradient               (default is 0.1):  the max allowed gradient over
//                                              the flatness radius
//
//   _max_tries_within_grid (default is 1000):  the maximum number of random
//                                              locations in the grid square
//                                              to search
// 
//  _max_num_search_areas   (default is 1000):  the maximum number of areas 
//                                              to search before giving up
//                                              altogether. A value of 0 will 
//                                              indicate to try forever.
// 
// Returns:
//   a 2D map location representing the center of the flat area, or an empty
//   array if no suitable location is found.

params [["_flat_area_radius", 4.0],
        ["_offset_radius", 300],
        ["_gradient", 0.1],
        ["_objectDistance", 5.0],
        ["_max_tries_within_grid", 2000],
        ["_max_num_search_areas", 0],
        ["_minDistFromRoad",15.0],
        ["_mustbeNearShore",false]
];


// southwest corner of the map
private _sw = (getPos SouthWest) vectorAdd [_offset_radius, _offset_radius, 0];
// northeast corner of the map
private _ne = (getPos NorthEast) vectorDiff [_offset_radius, _offset_radius, 0];

private _mapsize = _ne vectorDiff _sw;

private _final_pos = [0,0,0];

private _ii = 0;
private _max_num_search_areas_excceded = false;

private _keepSearching = true;

// keep looping until a position is found or until max
while {_keepSearching} do { // NEW
    private _initialPos = _sw vectoradd [random (_mapsize select 0), random (_mapsize select 1), 0];
    // TODO: integrate this into a general purpose common debug logging system

    // NEW
    _final_pos = [_initialPos, 0.0, _offset_radius, _objectDistance, 0, _gradient, 0, [], [0,0,0]] call BIS_fnc_findSafePos;

    if (_final_pos isEqualType 0) then
    {
        _final_pos = [0,0,0];
    };

    // check if water is nearby
    private _overShore = !(_final_pos isFlatEmpty [-1, -1, -1, -1, -1, true] isEqualTo []);
    private _surfaceIsWater = surfaceIsWater _final_pos;

    private _waterCloseBy = true;
    if (!_overShore && !_surfaceIsWater) then
    {
        _waterCloseBy = false;
    };

    private _waterCheckPassed = true;
    if (_mustbeNearShore && !_waterCloseBy) then
    {
        _waterCheckPassed = false;
    };

    private _road_segments = _final_pos nearRoads _minDistFromRoad;
    private _isOnRoad = isOnRoad _final_pos;
    private _nearestRoadObj = [_final_pos, _minDistFromRoad, []] call BIS_fnc_nearestRoad;
    private _nearObjects = nearestTerrainObjects [_final_pos, [], _minDistFromRoad, false, true];
    private _nearbyBannedObjects = [];
    {
        if (str _x find "road" != -1) then
        {
            _nearbyBannedObjects pushBack _x;
        };
        if (str _x find "track" != -1) then
        {
            _nearbyBannedObjects pushBack _x;
        };
        if (str _x find "trail" != -1) then
        {
            _nearbyBannedObjects pushBack _x;
        };
        if (str _x find "train" != -1) then
        {
            _nearbyBannedObjects pushBack _x;
        };
        if (str _x find "bridge" != -1) then
        {
            _nearbyBannedObjects pushBack _x;
        };
    }
    forEach _nearObjects;

    _keepSearching = call {(_final_pos isEqualTo [0,0,0])} || {count _road_segments > 0} || 
                            {!_waterCheckPassed} || {count _nearbyBannedObjects > 0} || {_isOnRoad} ||
                            {!(isNull _nearestRoadObj)};

    _ii = _ii + 1;
    if (_ii > _max_num_search_areas) then {
        _max_num_search_areas_excceded = true;
        //_keepSearching = false;
        //diag_log format ["fn_findFlatAreaNew _max_num_search_areas_excceded!!!!!!!!!: %1", _ii];
    };
    //_retval = [_final_pos select 0, _final_pos select 1, 0];
};

// error case, return [] if not found
private _retval = [];


if (_max_num_search_areas_excceded) then {
    // convert to 2D position vector
    _retval = [_final_pos select 0, _final_pos select 1, 0];
};


//diag_log format ["fn_findFlatAreaNew _retval: %1 _initialPos: %2", _retval, _initialPos];
_retval;