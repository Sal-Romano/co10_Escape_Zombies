// Search Chopper v1.0
// Author: Engima of Östgöta Ops

params [
	["_searchAreaMarkerName",""],
	["_distance",4000],
	["_altitude",100],
	["_speedMode","NORMAL"],
	["_classname","B_Heli_Light_01_F"],
	["_side",EAST],
	["_numberOfAircraft",2],
	["_sleepTime",1200],
	["_debug",false]
];

if (_debug) then {
    systemchat "Starting ambient flyby script...";
};

while {!([_searchAreaMarkerName] call drn_fnc_CL_MarkerExists)} do {
	sleep 5;
};

_randomSleep = [-120, 120] call BIS_fnc_randomInt;
_sleepTime = _sleepTime + _randomSleep;
_sleepTimeClamped = [_sleepTime, 60, 60*60*6] call BIS_fnc_clamp;
while {true} do
{
	_altitude = [_altitude, 20, 5000] call BIS_fnc_clamp;
	_numberOfAircraft = [_numberOfAircraft, 1, 4] call BIS_fnc_clamp;

	_flybyPos = [0,0,0];
	if ([_searchAreaMarkerName] call drn_fnc_CL_MarkerExists) then
	{
		_flybyPos = [_searchAreaMarkerName] call drn_fnc_CL_GetRandomMarkerPos;
	}
	else
	{
		_playerGroup = [] call A3E_fnc_GetPlayerGroup;
		_leader = (units _playerGroup) select 0;
		_flybyPos = getPos _leader;
	};

	// get random pos _distance away from players
	_randomBearing = random 360;
	_startPosArray = [];
	_startPos0 = _flybyPos getPos [_distance, _randomBearing];
	_startPosArray pushBack _startPos0;
	_startPosArray pushBack (_startPos0 getPos [100, 90]);
	_startPosArray pushBack (_startPos0 getPos [100, 180]);
	_startPosArray pushBack (_startPos0 getPos [100, 270]);

	_oppositeBearing = _randomBearing - 180;
	_endPosArray = [];
	_endPos0 = _flybyPos getPos [_distance, _oppositeBearing];
	_endPosArray pushBack _endPos0;
	_endPosArray pushBack (_endPos0 getPos [100, 90]);
	_endPosArray pushBack (_endPos0 getPos [100, 180]);
	_endPosArray pushBack (_endPos0 getPos [100, 270]);

	for "_i" from 0 to (_numberOfAircraft - 1) do
	{
		_startPos = _startPosArray select _i;
		_endPos = _endPosArray select _i;
		_randomAlt = [-10, 10] call BIS_fnc_randomInt;
		_flyInAltitude = _altitude + _randomAlt;
		[_startPos, _endPos, _flyInAltitude, _speedMode, _classname, _side] call BIS_fnc_ambientFlyby;
	};

	sleep _sleepTimeClamped;
};
