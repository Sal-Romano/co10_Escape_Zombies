if(!isserver) exitwith {};
params ["_centerPos"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];


// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_Campfire_F",[-0.0107422,0.100586,0.0299988],27.42,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[-0.241699,0.0532227,0],0,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.83887,-0.35498,0],177.193,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[-1.50684,-2.05029,0],0,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[0.367676,2.23877,0],177.273,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.58545,-2.56934,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[-1.3291,2.33643,0],177.273,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[2.83496,0.183594,0],266.046,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[0.836914,-3.27197,0],177.193,1,0,[],"","",true,false], 
	["Land_Sleeping_bag_F",[2.38232,-1.62158,0],309.56,1,0,[],"","",true,false], 
	["Land_Canteen_F",[-2.48193,2.55127,0],127.455,1,0,[],"","",true,false], 
	["Land_WoodenShelter_01_F",[-0.433594,3.54395,0],180.066,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[-3.69873,-1.67969,0],0,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[-4.33301,0.0498047,0],0.0418162,1,0,[],"","",true,false]
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
