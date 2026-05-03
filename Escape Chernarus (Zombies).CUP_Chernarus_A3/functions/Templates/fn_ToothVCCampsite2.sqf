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
	["Land_ClutterCutter_large_F",[-0.188477,-0.179199,0],0,1,0,[],"","",true,false], 
	["Land_Campfire_F",[0.0424805,-0.131836,0.0299988],27.42,1,0,[],"","",true,false], 
	["Land_vn_c_prop_pot_fire_01",[1.30664,0.157715,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_sack_ep1",[1.29932,-0.54248,0],177.193,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[-1.85156,-0.110352,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.97314,0.774902,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[0.373047,-1.97266,0],357.812,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[0.420898,2.00635,0],177.273,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.60107,-1.83984,0],353.429,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.27588,2.104,0],177.273,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_03",[-0.491699,-2.34961,0],274.8,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_03",[-0.310059,2.44824,0],90.5063,1,0,[],"","",true,false], 
	["Land_Canteen_F",[-2.42871,2.31885,0],127.455,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[1.7583,2.88623,0],0,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[-2.92432,-1.79639,0],0,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[3.68066,0.81543,0],260.153,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[2.98975,-3.0332,0],45.2628,1,0,[],"","",true,false]
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
