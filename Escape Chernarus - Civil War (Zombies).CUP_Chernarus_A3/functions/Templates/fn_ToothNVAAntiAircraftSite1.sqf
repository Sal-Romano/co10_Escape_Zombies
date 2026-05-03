params ["_centerPos"];
private["_gun","_staticsData","_statics","_objects","_marker","_marker","_rotateDir","_number"];
_rotateDir = random 360;

[_centerPos,50] call a3e_fnc_cleanupTerrain;




// Launchers -------------------------------------------------------------------------------------------------------------

if (count a3e_arr_AntiAircraftSiteLaunchers > 0) then {
	//["vn_sa2",[7.48535,3.95996,-0.0749998],41.5481,1,0,[],"","",true,false], 

    _gun = selectRandom a3e_arr_AntiAircraftSiteLaunchers;
    
	_staticsData = [
    	[_gun,[7.48535,3.95996,0],41.5481,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    	//[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;



	//["vn_sa2",[-9.69287,5.05566,-0.0749998],321.573,1,0,[],"","",true,false], 

    _gun = selectRandom a3e_arr_AntiAircraftSiteLaunchers;
    
	_staticsData = [
    	[_gun,[-9.69287,5.05566,0],321.573,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    	//[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};


// Guns -------------------------------------------------------------------------------------------------------------

if (count a3e_arr_Escape_AmmoDepot_StaticWeaponClasses > 0) then {

	//["vn_o_nva_static_dshkm_high_01",[-1.59375,6.07813,-0.0749998],0,1,0,[],"","",true,false], 

    _gun = selectRandom a3e_arr_Escape_AmmoDepot_StaticWeaponClasses;
    
	_staticsData = [
    	[_gun,[-1.59375,6.07813,0],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};

// Radar -------------------------------------------------------------------------------------------------------------

if (count a3e_arr_AntiAircraftSiteRadars > 0) then {
	//["vn_o_static_rsna75",[1.76074,-8.5249,-5.17678],0,1,0,[],"","",true,false], 

    _gun = selectRandom a3e_arr_AntiAircraftSiteRadars;
    
	_staticsData = [
    	[_gun,[1.76074,-8.5249,0],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    	//[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};


// Power Van -------------------------------------------------------------------------------------------------------------

if (count a3e_arr_AntiAircraftSiteVans > 0) then {
	//["vn_o_wheeled_z157_04",[-8.07715,-5.21631,0.220597],235.776,1,0,[],"","",true,false], 

    _gun = selectRandom a3e_arr_AntiAircraftSiteVans;
    
	_staticsData = [
    	[_gun,[-8.07715,-5.21631,0],235.776,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    } forEach _statics;

};



// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_vn_barel8",[1.4458,4.67773,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.3374,5.40137,0],90.8644,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.21582,5.81396,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[3.48096,5.00342,-0.000999928],317.647,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[2.6167,5.75,0],316.899,1,0,[],"","",true,false], 
	//["vn_o_nva_static_dshkm_high_01",[-1.59375,6.07813,-0.0749998],0,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[6.11182,2.35596,0],0,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[-6.38867,-3.23145,0],0,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[5.36377,-5.67725,0],0,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[-7.36133,4.12939,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[8.61377,0.288086,-0.000999928],317.647,1,0,[],"","",true,false], 
	//["vn_sa2",[7.48535,3.95996,-0.0749998],41.5481,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-6.19482,6.30859,-0.000999928],233.69,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[5.98633,-6.71533,0],265.207,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[5.67285,7.06689,-0.000999928],317.647,1,0,[],"","",true,false], 
	["Land_WoodenTable_large_F",[7.3623,-5.60791,0],270,1,0,[],"","",true,false], 
	//["vn_o_wheeled_z157_04",[-8.07715,-5.21631,0.220597],235.776,1,0,[],"","",true,false], 
	//["vn_o_static_rsna75",[1.76074,-8.5249,-5.17678],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[10.0864,-4.49658,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[10.8057,2.35156,-0.000999928],317.647,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[10.084,-4.73389,0],176.973,1,0,[],"","",true,false], 
	//["vn_sa2",[-9.69287,5.05566,-0.0749998],321.573,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[9.48828,-5.97314,0],0,1,0,[],"","",true,false], 
	["Land_vn_woodencart_f",[-11.0645,-1.97852,0],58.4909,1,0,[],"","",true,false], 
	["Land_vn_garbage_square3_f",[8.26416,-7.75342,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-11.4243,1.70068,-0.000999928],233.69,1,0,[],"","",true,false], 
	["Land_vn_barel8",[10.7393,-4.8335,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-8.01611,8.70557,-0.000999928],233.69,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[8.46338,8.4292,-0.000999928],351.959,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-12.0337,0.241211,0],145.968,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[10.4526,-6.3457,0],269.826,1,0,[],"","",true,false], 
	["Land_vn_crateswooden_f",[0.844727,-12.2979,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-4.74121,-11.8896,-0.000999928],31.9677,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[11.936,4.8877,-0.000999928],274.314,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[10.5283,-7.84375,0],0,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-13.0073,1.6709,0],233.35,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[10.9707,7.4917,-0.000999928],227.109,1,0,[],"","",true,false], 
	["Land_vn_camonet_east",[9.32568,-9.92432,0],90.3927,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-2.16211,-13.4424,-0.000999928],31.9677,1,0,[],"","",true,false], 
	["vn_o_prop_t102e_01",[10.5269,-8.74463,0],105.864,1,0,[],"","",true,false], 
	["Land_vn_woodenbox_f",[8.39502,-11.0034,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-13.2456,4.09766,-0.000999928],233.69,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[10.0381,-9.87549,0],123.48,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[0.450195,-14.2197,-0.000999928],177.612,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[3.45557,-14.0459,-0.000999928],177.612,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-10.4194,10.0967,-0.000999928],190.357,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-14.3066,7.01611,-0.000999928],268.002,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-13.1104,9.41064,-0.000999928],143.151,1,0,[],"","",true,false], 
	["Land_vn_garbageheap_02_f",[10.0229,-13.0649,0.132944],135.358,1,0,[],"","",true,false]
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


_objArray