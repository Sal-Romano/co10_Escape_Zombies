if(!isserver) exitwith {};
params ["_centerPos"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];

/*
if (isNil "drn_BuildCampsite_MarkerInstanceNo") then {
	drn_BuildCampsite_MarkerInstanceNo = 0;
}
else {
	drn_BuildCampsite_MarkerInstanceNo = drn_BuildCampsite_MarkerInstanceNo + 1;
};
_instanceNo = drn_BuildCampsite_MarkerInstanceNo;

// Set markers -------------------------------------------------------------------------------------------------------------
["drn_CampsiteMapMarker" + str _instanceNo,_centerPos,"o_unknown"] call A3E_fnc_createLocationMarker;

_marker = createMarkerLocal ["A3E_CampsitePatrolMarker" + str _instanceNo, _centerPos];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];
*/

// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[-0.524414,0.481934,0],0,1,0,[],"","",true,false], 
	["Land_Campfire_F",[-0.20459,-1.10596,0.0557771],27.42,1,0,[],"","",true,false], 
	["Land_Canteen_F",[1.50537,0.75,0],127.455,1,0,[],"","",true,false], 
	["Land_vn_sack_ep1",[-1.54248,-0.734375,0],177.193,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[1.30713,-1.40576,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_c_prop_pot_fire_01",[-1.31201,-1.59717,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_01",[-0.231445,2.29932,0.000524521],90.5079,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-0.138672,1.96826,0],177.273,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[1.39893,1.93994,0],180.58,1,0,[],"","",true,false], 
	["vn_o_item_bedroll_01",[-2.36865,1.74268,0],76.3064,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[0.050293,-2.81299,0],0,1,0,[],"","",true,false], 
	["vn_o_item_bedroll_01",[-2.63672,1.46924,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[0.149902,-3.0127,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.45947,2.10986,0],177.273,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[3.07324,1.3291,0],260.153,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[-2.53711,-2.4165,0],0,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[3.01514,-0.46582,0],269.486,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[2.52051,-2.66064,0],45.2628,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[-3.91553,0.199219,0],183.26,1,0,[],"","",true,false]
];

_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;
_objArray append _spawnedObjects;

{
	if (!(_x isKindOf "House")) then
	{
		_x setVectorUp (surfaceNormal (position _x));
		_x enableDynamicSimulation true;
		[_x, 0, getPos _x, "ATL"] call BIS_fnc_setHeight;
	};
}
forEach _objArray;
