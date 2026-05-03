// by sabersnack

params [
	["_searchAreaMarkerName",""],
	["_trackerRadius",1000],
	["_debug",false]
];

if (!isServer) exitWith {};


[_searchAreaMarkerName, _trackerRadius, _debug] spawn DRN_fnc_NVATrackers;


