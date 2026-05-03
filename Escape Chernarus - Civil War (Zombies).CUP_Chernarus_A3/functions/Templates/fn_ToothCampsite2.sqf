if(!isserver) exitwith {};
params ["_centerPos"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];


// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[-0.214844,-0.266113,0],0,1,0,[],"","",true,false], 
	["Land_Campfire_F",[0.0161133,-0.21875,0.0299988],27.42,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[-1.87793,-0.197266,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.99951,0.687988,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[0.394531,1.91943,0],177.273,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[0.34668,-2.05957,0],357.812,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.62744,-1.92676,0],353.429,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.30225,2.01709,0],177.273,1,0,[],"","",true,false], 
	["Land_TentA_F",[2.84814,1.18408,0],254.317,1,0,[],"","",true,false], 
	["Land_Canteen_F",[-2.45508,2.23193,0],127.455,1,0,[],"","",true,false], 
	["Land_TentA_F",[2.96045,-1.56494,0],282.678,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[-3.86523,0.267578,0],260.153,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[-3.90576,-1.646,0],156.382,1,0,[],"","",true,false]
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
