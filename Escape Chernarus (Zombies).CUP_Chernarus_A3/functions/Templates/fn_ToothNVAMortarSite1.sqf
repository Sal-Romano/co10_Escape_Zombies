params ["_centerPos"];

private _rotateDir = random 360;
[_centerPos,25] call a3e_fnc_cleanupTerrain;

// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[0.0107422,-0.467285,0],0,1,0,[],"","",true,false], 
	//["vn_o_nva_65_static_mortar_type63",[0.207031,1.41455,-0.0754771],358.026,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[1.94434,1.01904,0],302.282,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-2.39502,0.149414,-0.000999928],33.9863,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[2.61914,0.70752,-0.000999928],124.725,1,0,[],"","",true,false], 
	["vn_o_ammobox_06",[-0.308594,-2.79102,0.00320339],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-2.50293,2.23193,-0.000999928],124.725,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[1.99414,2.86621,-0.000999928],217.138,1,0,[],"","",true,false], 
	["Land_vn_garbageheap_02_f",[2.55615,-2.62354,0.0443168],315.351,1,0,[],"","",true,false], 
	["Land_vn_sacks_heap_f",[3.74707,0.612305,0],307.977,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_03",[-0.119629,-3.0874,0],271.685,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-0.583496,4.23047,-0.00130129],168.584,1,0,[],"","",true,false]
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

//["vn_o_nva_65_static_mortar_type63",[0.207031,1.41455,-0.0754771],358.026,1,0,[],"","",true,false], 

_gun = selectRandom a3e_arr_MortarSite;

_staticsData = [
	[_gun,[0.207031,1.41455,-0.0754771],358.026,1,0,[0,0],"","",true,false]
];

_statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

{
	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
	a3e_var_artillery_units pushBack _x;
} forEach _statics;
