// by sabersnack

params [
	["_searchAreaMarkerName",""],
	["_distance",4000],
	["_altitude",100],
	["_speedMode","NORMAL"],
	["_classname","B_Heli_Light_01_F"],
	["_side",WEST],
	["_numberOfAircraft",2],
	["_sleepTime",1200],
	["_debug",false]
];

if (!isServer) exitWith {};


[_searchAreaMarkerName, _distance, _altitude, _speedMode, _classname, _side, _numberOfAircraft, _sleepTime, _debug] spawn DRN_fnc_AmbientFlyby;


