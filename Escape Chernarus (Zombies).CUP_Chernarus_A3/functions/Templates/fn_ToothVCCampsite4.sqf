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
	["Land_ClutterCutter_large_F",[-0.19043,0.379883,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.01123,-0.126953,0],177.193,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[1.06885,0.0258789,0],177.193,1,0,[],"","",true,false], 
	["Land_Campfire_F",[0.129395,-1.20801,0.0557771],27.42,1,0,[],"","",true,false], 
	["Land_vn_sack_ep1",[-1.2085,-0.836426,0],177.193,1,0,[],"","",true,false], 
	["Land_Canteen_F",[-2.06396,0.388672,0],127.455,1,0,[],"","",true,false], 
	["Land_vn_c_prop_pot_fire_01",[-0.930664,-1.90967,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_02",[0.248047,2.78809,0],0,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[-0.712402,1.95459,0],183.26,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[1.22461,2.07813,0],173.258,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[2.85352,-0.683105,0],0,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[-2.67676,-0.564941,0],96.1329,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[-2.29053,-2.39648,0],0,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[1.64111,-3.20117,0],338.472,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[-0.366211,-3.82813,0],274.156,1,0,[],"","",true,false], 
	["vn_o_item_bedroll_01",[0.715332,4.06641,0],76.3064,1,0,[],"","",true,false], 
	["vn_o_item_bedroll_01",[-0.702637,4.20361,0],0,1,0,[],"","",true,false]
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
