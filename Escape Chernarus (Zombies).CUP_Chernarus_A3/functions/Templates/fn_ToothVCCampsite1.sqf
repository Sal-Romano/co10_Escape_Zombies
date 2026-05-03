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
	["Land_ClutterCutter_large_F",[-0.325195,0.303711,0],0,1,0,[],"","",true,false], 
	["Land_Campfire_F",[-0.0942383,0.351074,0],27.42,1,0,[],"","",true,false], 
	["Land_vn_c_prop_pot_fire_01",[-0.151367,-0.733398,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_sack_ep1",[0.524902,-0.762207,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[1.21387,-0.665527,0],0,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[0.485352,-1.48438,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.92236,-0.104492,0],177.193,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[-1.59033,-1.7998,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.66895,-2.31885,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[0.28418,2.48926,0],177.273,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[0.753418,-3.02148,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[2.29883,-1.37109,0],309.56,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[2.75146,0.434082,0],266.046,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.4126,2.58691,0],177.273,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_03",[-0.541016,2.91895,0],90.5063,1,0,[],"","",true,false], 
	["Land_Canteen_F",[-2.56543,2.80176,0],127.455,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[-3.78223,-1.4292,0],0,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[-4.4165,0.300293,0],0.0418162,1,0,[],"","",true,false]
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
