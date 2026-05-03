params ["_centerPos"];

private _rotateDir = random 360;
[_centerPos,25] call a3e_fnc_cleanupTerrain;

// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[0.0644531,0.00341797,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-2.07959,0.578125,-0.000999928],55.5671,1,0,[],"","",true,false], 
	//["vn_o_nva_65_static_mortar_type63",[0.19043,2.18945,-0.0754771],358.026,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[2.1582,0.967285,-0.000999928],125.911,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[0.0185547,-2.70947,0],2.08318,1,0,[],"","",true,false], 
	["vn_o_ammobox_06",[-3.22314,-0.172363,0.00320339],56.7092,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-0.0322266,-3.52393,-0.000999928],358.348,1,0,[],"","",true,false], 
	["Land_vn_sacks_heap_f",[3.80078,1.08301,0],307.977,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-0.143555,4.02197,-0.000999928],179.958,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[3.45996,-2.09277,0],306.807,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-2.77441,3.27148,-0.00130129],120.304,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[2.57764,3.57715,-0.00130129],224.426,1,0,[],"","",true,false]
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

// Mortar -------------------------------------------------------------------------------------------------------------

//["vn_o_nva_65_static_mortar_type63",[0.19043,2.18945,-0.0754771],358.026,1,0,[],"","",true,false], 

_gun = selectRandom a3e_arr_MortarSite;

_staticsData = [
	[_gun,[0.19043,2.18945,-0.0754771],358.026,1,0,[0,0],"","",true,false]
];

_statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

{
	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
	a3e_var_artillery_units pushBack _x;
} forEach _statics;
