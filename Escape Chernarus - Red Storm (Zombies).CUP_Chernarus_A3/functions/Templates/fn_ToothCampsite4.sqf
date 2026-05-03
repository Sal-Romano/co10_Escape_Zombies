if(!isserver) exitwith {};
params ["_centerPos"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];


// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[-0.21582,0.450195,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.03662,-0.0566406,0],177.193,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[1.04346,0.0961914,0],177.193,1,0,[],"","",true,false], 
	["Land_Campfire_F",[0.104004,-1.1377,0.0557771],27.42,1,0,[],"","",true,false], 
	["Land_Canteen_F",[-1.8501,1.90625,0],127.455,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[-0.737793,2.0249,0],183.26,1,0,[],"","",true,false], 
	["Land_WoodenShelter_01_F",[0.440918,2.65088,0],0,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[1.19922,2.14844,0],173.258,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[2.82813,-0.612793,0],0,1,0,[],"","",true,false], 
	["Land_TentA_F",[-2.60449,-2,0],239.762,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[-2.76904,1.17041,0],149.607,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[1.61572,-3.13086,0],338.472,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[-0.391602,-3.75781,0],274.156,1,0,[],"","",true,false]
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
