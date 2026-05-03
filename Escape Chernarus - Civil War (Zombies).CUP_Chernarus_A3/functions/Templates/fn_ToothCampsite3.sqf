if(!isserver) exitwith {};
params ["_centerPos"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];


// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[-0.515137,0.678223,0],0,1,0,[],"","",true,false], 
	["Land_Campfire_F",[-0.195313,-0.909668,0.0557771],27.42,1,0,[],"","",true,false], 
	["Land_Canteen_F",[1.51465,0.946289,0],127.455,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[1.31641,-1.20947,0],177.193,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[0.0595703,-2.6167,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[0.15918,-2.81641,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[0.175293,2.71777,0],177.273,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[3.08252,1.52539,0],260.153,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.36719,2.63232,0],177.273,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[1.53174,2.64453,0],180.58,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[2.52979,-2.46436,0],45.2628,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[3.02441,-0.269531,0],269.486,1,0,[],"","",true,false], 
	["Land_TentA_F",[-2.94678,-1.96924,0],229.138,1,0,[],"","",true,false], 
	["Land_TentA_F",[-3.76367,0.809082,0],281.305,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_brown_F",[-2.85449,2.71533,0],183.26,1,0,[],"","",true,false]
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
