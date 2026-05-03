params ["_centerPos"];

private _rotateDir = random 360;
[_centerPos,40] call a3e_fnc_cleanupTerrain;

// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[0.474609,-0.300293,0],0,1,0,[],"","",true,false], 
	//["vn_o_nva_static_d44_01",[0.303711,-0.73584,-0.0750003],14.5173,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[-3.89404,1.05664,0],315.351,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[-1.61084,4.66357,0],182.878,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[4.45361,-2.75781,0],315.351,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[0.738281,5.5874,-0.000999928],0.70998,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[3.32861,4.68457,0],177.706,1,0,[],"","",true,false], 
	["VirtualReammoBox_small_F",[5.72656,1.7959,0],271.41,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[-5.79688,1.75293,0],306.807,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[-2.30615,5.63086,-0.000999928],0.70998,1,0,[],"","",true,false], 
	["Land_Sacks_heap_F",[-4.84473,4.44922,0],277.165,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[3.73145,5.52734,-0.000999928],0.70998,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[6.95361,-0.798828,-0.000999928],270.96,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[-6.03564,3.77002,0],98.4501,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[-1.82422,-6.90625,-0.000999928],13.2869,1,0,[],"","",true,false], 
	["Land_BagFence_Short_F",[-4.67676,5.62158,-0.000999928],0.71,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[-4.50049,-5.7583,-0.000999928],32.2069,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[-7.29199,-0.930664,-0.000999928],270.96,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[7.02881,2.17139,-0.000999928],270.96,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[-6.51807,-3.73877,-0.000999928],57.8664,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[-7.27295,2.13135,-0.000999928],270.96,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[6.96387,-3.68994,-0.000999928],270.96,1,0,[],"","",true,false], 
	["Land_BagFence_Round_F",[6.68799,5.00342,-0.00130129],224.426,1,0,[],"","",true,false], 
	["Land_BagFence_Round_F",[-6.84912,5.14258,-0.00130129],129.84,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[5.03564,-7.35889,0],91.524,1,0,[],"","",true,false], 
	["VirtualReammoBox_small_F",[5.9751,-6.80225,0],271.41,1,0,[],"","",true,false], 
	["Land_WoodenShelter_01_F",[5.60986,-8.72949,0.668807],88.5558,1,0,[],"","",true,false], 
	["VirtualReammoBox_small_F",[5.94727,-8.38818,0],271.41,1,0,[],"","",true,false]
];

_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;

{
	if (!(_x isKindOf "House")) then
	{
		_x setVectorUp (surfaceNormal (position _x));
		_x enableDynamicSimulation true;
        [_x, 0, getPos _x, "ATL"] call BIS_fnc_setHeight;
	};
}
forEach _objArray;

// Gun -------------------------------------------------------------------------------------------------------------

//["vn_o_nva_static_d44_01",[0.303711,-0.73584,-0.0750003],14.5173,1,0,[],"","",true,false], 

_gun = selectRandom a3e_arr_ArtillerySite;

_staticsData = [
	[_gun,[0.303711,-0.73584,-0.0750003],14.5173,1,0,[0,0],"","",true,false]
];

_statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

{
	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
	a3e_var_artillery_units pushBack _x;
} forEach _statics;

_objArray
