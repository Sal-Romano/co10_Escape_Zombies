/*
Grab data:
Mission: tempMissionSP
World: VR
Anchor position: [3654.85, 3565.78]
Area size: 50
Using orientation of objects: no

// to capture a collection/composition of objects, place your player in the middle of the composition with this code in his init
[getPos player, 50, true] call BIS_fnc_objectsGrabber;

// to test the spawning of the objects
[getPos player, ["rhsgref_tla_DSHKM"], ["rhs_gaz66_ammo_msv"]] execVM "Tooth_AmmoDepot1.sqf";

*/

if(!isserver) exitwith {};
params ["_centerPos","_rotateDir","_staticWeaponClasses","_parkedVehicleClasses","_staticAAClasses"];
private ["_object", "_pos", "_marker", "_instanceNo", "_randomNo", "_gun", "_statics", "_staticsData", "_angle", "_car", "_cars", "_carData", "_boxType", "_ammoBoxData", "_ammoBoxes", "_box"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

//private _rotateDir = random 360;
[_centerPos,35] call a3e_fnc_cleanupTerrain;




// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
    ["Land_BagFence_Round_F",[-1.21387,-2.6189,-0.00130129],38.0674,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-2.78735,-0.810303,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[1.60547,-2.79297,-0.00130129],325.329,1,0,[0,0],"","",true,false], 
    [Tooth_enemyFlagPole,[-0.383545,-1.40503,0],94.752,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[-5.16675,2.0188,0],358.115,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-5.1189,3.92603,0],358.115,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-4.69458,4.55933,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-5.09741,4.70654,0],358.115,1,0,[0,0],"","",true,false], 
    //["rhs_gaz66_ammo_msv",[6.19946,3.55298,-4.76837e-007],4.35002,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-5.20239,5.41699,0],358.115,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-7.47095,1.61426,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-7.52856,2.43262,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[-7.34888,2.97632,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[-7.35767,3.22266,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-1.57275,-8.13232,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[-7.7561,2.93433,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[-7.79126,3.17236,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[-3.99023,7.3313,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[-7.77515,3.45215,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[-8.19458,3.1355,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[-8.24146,3.38916,0],353.974,1,0,[0,0],"","",true,false], 
    ["Land_GuardTower_01_F",[-3.45483,12.4915,0],178.826,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[-6.1748,7.08667,0],353.816,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[-8.88086,4.45605,0],354.745,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[9.3147,-3.45264,0],272.19,1,0,[0,0],"","",true,false], 
    ["CargoNet_01_barrels_F",[-8.77954,7.03174,0],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-10.9075,3.28369,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_WoodenTable_02_large_F",[-5.95532,-9.7002,0],270.393,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[0.330078,-11.1541,0],359.276,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[5.71021,10.2078,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[11.5095,-2.76611,0],45.0279,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-14.0022,-2.47388,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[14.3845,-1.68872,0],0,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[14.3342,2.68604,0],278.319,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[14.4392,3.91406,0],314.956,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[14.428,5.97168,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_WoodenTable_large_F",[15.2712,3.65796,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[14.3787,6.53833,0],280.341,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_big_F",[-2.74463,-18.0659,0.122345],0,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[0.57373,15.9626,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Cargo20_sand_F",[6.00317,-14.998,0.145],90,1,0,[0,-0],"","",true,false], 
    ["Land_FloodLight_F",[11.4866,-11.5234,0],333.18,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[12.1584,10.8469,0],269.44,1,0,[0,0],"","",true,false], 
    //["rhs_gaz66_ammo_msv",[-15.0657,-6.52905,-4.76837e-007],178.997,1,0,[0,-0],"","",true,false], 
    ["CamoNet_BLUFOR_open_F",[15.3787,7.53931,0],266.112,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[16.3254,3.09863,0],85.5501,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[16.1672,4.00146,0],85.5501,1,0,[0,0],"","",true,false], 
    ["Land_WoodenTable_large_F",[15.4993,6.8728,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_Net_Fence_Gate_F",[10.6887,15.989,0],0,1,0,[0,0],"","",true,false], 
    ["Land_GuardTower_02_F",[-10.7717,-14.4661,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-5.2041,15.9353,0],180,1,0,[0,0],"","",true,false], 
    ["Land_MobileRadar_01_radar_F",[-14.0383,11.9805,0],180,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[16.5725,6.21558,0],85.5501,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[15.636,8.42505,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[12.1287,13.0449,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_HQ_F",[16.1294,-7.36084,0.130144],0,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[15.6189,8.89502,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[15.8933,8.44653,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[16.4939,7.20044,0],77.7323,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[13.927,11.6416,0],273.739,1,0,[0,0],"","",true,false], 
    //["Land_DataTerminal_01_F",[16.844,-6.85474,0],269.962,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[15.8958,8.85156,0],269.599,1,0,[0,0],"","",true,false], 
    ["CargoNet_01_barrels_F",[-18.3303,0.270264,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[15.8884,9.28809,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[16.1365,8.86304,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[10.1199,15.2429,0],181.516,1,0,[0,0],"","",true,false], 
    ["Land_Ammobox_rounds_F",[16.1345,9.27271,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[14.6443,11.6765,0],273.739,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[16.6692,9.03394,0],269.599,1,0,[0,0],"","",true,false], 
    //["rhsgref_tla_DSHKM",[0.426025,19.0012,-0.0749998],7.1711,1,0,[0,0],"","",true,false], 
    ["Land_MobileRadar_01_generator_F",[-18.5588,4.47168,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Sign_noentry_big_en_pl_F",[9.57422,16.7434,0],181.571,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[15.4192,11.5781,0],273.739,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-11.8313,-16.0781,0],0,1,0,[0,0],"","",true,false], 
    ["MetalBarrel_burning_F",[2.56616,19.2493,0],46.5729,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[17.489,9.01123,0],269.599,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[-2.29199,-19.5725,0],306.204,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[-3.34277,-19.4873,0],200.339,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[12.7915,15.9326,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[4.99487,-19.0747,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-1.39771,20.2688,-0.00130129],121.923,1,0,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-11.1992,15.9995,0],180,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[1.1499,20.7058,-0.00130129],213.272,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[20.5049,-0.142822,0],270,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[-20.4756,0.354736,0],87.7455,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[17.3005,11.3538,0],273.739,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[18.9583,-8.34155,0],183.477,1,0,[0,0],"","",true,false], 
    ["Land_GuardTower_02_F",[13.4016,-16.9583,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-21.0835,2.08911,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[20.5059,5.78638,0],270,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[-21.198,-5.01782,0],187.789,1,0,[0.00267923,-0.0195878],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[17.0862,13.728,0],270.369,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[15.1116,-17.189,0],270,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-17.5261,-13.6592,0],182.387,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-21.0942,8.05884,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[10.9812,-19.0681,0],0,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[-20.2612,-10.6633,0],87.7455,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_small_F",[-22.5681,-5.9021,0],90,1,0.141495,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[18.5693,15.96,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-16.9771,15.9722,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[20.499,11.738,0],270,1,0,[0,0],"","",true,false], 
    ["Land_RoadBarrier_01_F",[-14.5479,-16.8044,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-20.9448,-13.9897,0],270,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-21.1069,14.0803,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Communication_F",[18.5378,0.0861816,0],0,1,0,[0,0],"","",true,false], 
    //["rhsgref_ins_ZU23",[20.0034,-16.6389,-0.07514],107.017,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Round_F",[23.0261,-13.7415,-0.00130129],219.516,1,0,[0,0],"","",true,false], 
    ["Land_Sign_noentry_big_en_pl_F",[-21.8132,-17.8843,0],0,1,0,[0,0],"","",true,false], 
    //["rhsgref_tla_DSHKM",[-24.3264,-14.9761,-0.0749998],249.323,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[23.4216,-16.5891,-0.000999928],271.483,1,0,[0,0],"","",true,false], 
    ["MetalBarrel_burning_F",[-26.1306,-13.6348,0],288.725,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-24.5493,-17.1697,-0.00130129],4.07464,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-26.1262,-15.1213,-0.00130129],95.4235,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Round_F",[23.1152,-19.6663,-0.00130129],305.003,1,0,[0,0],"","",true,false]
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


    //["rhs_gaz66_ammo_msv",[6.19946,3.55298,-4.76837e-007],4.35002,1,0,[0,0],"","",true,false], 
    //["rhs_gaz66_ammo_msv",[-15.0657,-6.52905,-4.76837e-007],178.997,1,0,[0,-0],"","",true,false], 

// Vehicles -------------------------------------------------------------------------------------------------------------


_car = selectRandom _parkedVehicleClasses;

if (_car != "") then {
    //["rhs_gaz66_ammo_msv",[6.19946,3.55298,-4.76837e-007],4.35002,1,0,[0,0],"","",true,false], 
    
    _carData = [
        [_car,[6.19946,3.55298,-4.76837e-007],4.35002,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
    
};

_car = selectRandom _parkedVehicleClasses;

if (_car != "") then {
    //["rhs_gaz66_ammo_msv",[-15.0657,-6.52905,-4.76837e-007],178.997,1,0,[0,-0],"","",true,false], 
    
    _carData = [
        [_car,[-15.0657,-6.52905,-4.76837e-007],178.997,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
    
};





// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
    //["rhsgref_tla_DSHKM",[0.426025,19.0012,-0.0749998],7.1711,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
    _staticsData = [
        [_gun,[0.426025,19.0012,-0.0749998],7.1711,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};
if (count _staticWeaponClasses > 0) then {
    //["rhsgref_tla_DSHKM",[-24.3264,-14.9761,-0.0749998],249.323,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
    _staticsData = [
        [_gun,[-24.3264,-14.9761,-0.0749998],249.323,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};



// AA -------------------------------------------------------------------------------------------------------------


if (count _staticAAClasses > 0 && random 100 < 10) then {
    //["rhsgref_ins_ZU23",[20.0034,-16.6389,-0.07514],107.017,1,0,[0,-0],"","",true,false], 

    _gun = selectRandom _staticAAClasses;
    
    _staticsData = [
        [_gun,[20.0034,-16.6389,-0.07514],107.017,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};


// Data Terminal -------------------------------------------------------------------------------------------------------------

    //["Land_DataTerminal_01_F",[16.844,-6.85474,0],269.962,1,0,[0,0],"","",true,false], 

_terminal = A3E_DataTerminal;

_staticsData = [
    [_terminal,[16.844,-6.85474,1.0],269.962,1,0,[0,0],"","",true,false]
];

_terminals = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

_obj = _terminals select 0;
_obj setvariable ["A3E_isTerminal",true,true];
_obj allowDamage false;
[_obj,"green","green","green"] call BIS_fnc_DataTerminalColor;


_objArray