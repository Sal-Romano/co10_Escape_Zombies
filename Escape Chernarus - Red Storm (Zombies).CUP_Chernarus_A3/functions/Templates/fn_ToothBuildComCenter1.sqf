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
    ["Land_BagFence_Round_F",[1.10669,0.759033,-0.00130129],49.4477,1,0,[0,0],"","",true,false], 
    ["Land_PaperBox_closed_F",[2.14453,-0.937988,0],179.436,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Round_F",[0.990723,3.5813,-0.00130129],122.186,1,0,[0,-0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-4.19165,0.0983887,0],0,1,0,[0,0],"","",true,false], 
    [Tooth_enemyFlagPole,[2.28345,2.87964,0],178.87,1,0,[0,-0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-0.270996,-5.32813,0],0,1,0,[0,0],"","",true,false], 
    //["rhs_gaz66_ammo_msv",[-2.76465,5.00659,-4.76837e-007],359.829,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[5.61304,2.33545,0],0,1,0,[0,0],"","",true,false], 
    //["rhs_gaz66_ammo_msv",[-4.99097,-4.35938,-4.76837e-007],268.595,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[-2.65088,-8.18701,0],41.7691,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[2.76074,8.30176,0],0,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[-3.88281,-8.15039,0],5.13186,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-6.51758,6.34912,0],0,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[9.21973,0.996094,0],333.18,1,0,[0,0],"","",true,false], 
    ["Land_WoodenTable_large_F",[-2.86182,-9.03125,0],269.2,1,0,[0,0],"","",true,false], 
    ["Land_GuardTower_01_F",[10.8926,-4.56543,0],269.753,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-9.62158,1.23535,0],0,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[-2.46729,-9.90723,0],172.363,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenTable_02_large_F",[3.49121,9.63623,0],270.393,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[-3.36035,-10.1155,0],172.363,1,0,[0,-0],"","",true,false], 
    ["Land_LampShabby_F",[7.04785,9.06689,0],272.19,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[-12.0144,-1.81348,0],99.4668,1,0,[0,-0],"","",true,false], 
    ["Land_PaperBox_closed_F",[6.72534,-10.8342,0],179.436,1,0,[0,-0],"","",true,false], 
    ["CargoNet_01_barrels_F",[12.7402,-2.33472,0],0,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[9.24268,9.75342,0],45.0279,1,0,[0,0],"","",true,false], 
    ["Land_MobileRadar_01_generator_F",[-11.7998,6.23486,0],0,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[8.9939,-9.82471,0],272.561,1,0,[0,0],"","",true,false], 
    ["CargoNet_01_barrels_F",[10.2964,-9.45752,0],0,1,0,[0,0],"","",true,false], 
    ["Land_PaperBox_closed_F",[8.9458,-11.0723,0],273.518,1,0,[0,0],"","",true,false], 
    //["Land_DataTerminal_01_F",[13.1987,5.44312,0],88.5367,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[-14.0361,2.70532,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_FloodLight_F",[2.09326,14.2732,0],219.023,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_big_F",[-0.851074,-16.9553,0.122345],0,1,0,[0,0],"","",true,false], 
    ["Land_GuardTower_02_F",[-8.37061,-13.0686,0],180,1,0,[0,0],"","",true,false], 
    ["Land_PaperBox_closed_F",[6.81812,-12.9045,0],89.8943,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-10.9595,-9.87476,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[14.4233,-2.67163,0],270,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_HQ_F",[13.8625,5.15869,0.130144],0,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[-3.83789,-14.6929,0],53.9508,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[3.72559,-14.7925,0],135.791,1,0,[0,-0],"","",true,false], 
    ["Land_PaperBox_closed_F",[10.7419,-11.1545,0],181.867,1,0,[0,0],"","",true,false], 
    ["CargoNet_01_barrels_F",[12.3105,-9.39404,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_small_F",[-0.594482,15.4822,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Pallets_F",[9.54517,-13.2927,0],270.546,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[5.86011,14.4971,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[-14.0518,7.80908,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[12.1177,10.8308,0],0,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[-12.3518,10.4648,0],87.7455,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[14.4429,-7.7605,0],270,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-7.82275,14.5818,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Pallets_stack_F",[10.4204,-12.9302,0],270.546,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[7.54761,-14.8037,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_tall_F",[-15.5522,-3.33154,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_PaperBox_open_full_F",[12.4167,-11.2524,0],1.79258,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[-14.752,-6.09131,9.53674e-007],191.75,1,0,[0,0],"","",true,false], 
    ["Land_GuardTower_02_F",[-12.1731,13.1445,0],270,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[16.6914,4.17798,0],183.477,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[-9.34106,-14.9299,0],0,1,0,[0,0],"","",true,false], 
    //["rhsgref_tla_DSHKM",[17.6543,-3.0791,-0.0749998],119.723,1,0,[0,-0],"","",true,false], 
    ["Land_Pallets_stack_F",[12.3027,-13.1453,0],270.546,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_1_F",[-16.3843,-7.58862,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[10.9348,14.5005,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[-14.0269,12.7634,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[14.4565,-12.7029,0],270,1,0,[0,0],"","",true,false], 
    ["Land_Sign_noentry_big_en_pl_F",[-10.0078,16.6787,0],180,1,0,[0,0],"","",true,false], 
    ["Land_FloodLight_F",[-18.6934,-5.15601,0],357.845,1,0,[0,0],"","",true,false], 
    ["Land_Sign_noentry_big_en_pl_F",[-17.855,-7.82837,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[12.5959,-14.7861,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[-12.1907,15.2935,0],180,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[19.8542,-1.79175,-0.000999928],274.81,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[19.7205,-4.68994,-0.00130129],294.551,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[-14.8154,-13.7678,0],11.9747,1,0,[0,0],"","",true,false], 
    ["Land_Communication_F",[-12.0781,2.16284,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[-14.3894,-14.9475,0],0,1,0,[0,0],"","",true,false], 
    ["Land_RoadBarrier_01_F",[-4.8689,18.9475,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_1_F",[-16.2881,-14.218,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[16.0525,14.4685,0],180,1,0,[0,0],"","",true,false], 
    ["Land_WaterTower_01_F",[11.801,-18.1021,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Bunker_01_blocks_3_F",[18.4458,12.6069,0],270,1,0,[0,0],"","",true,false], 
    ["Land_RoadBarrier_01_F",[-19.2505,-8.02686,0],270,1,0,[0,0],"","",true,false], 
    //["rhsgref_tla_DSHKM",[-13.3118,18.1401,-0.0749998],290.222,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[-13.4727,19.6597,-0.000999928],351.921,1,0,[0,0],"","",true,false], 
    //["rhsgref_ins_ZU23",[-13.04,-20.1997,-0.07514],230.617,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-16.0928,18.439,-0.00130129],107.426,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[-12.9932,-23.0737,-0.000999928],357.868,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[-16.9548,-20.4509,-0.000999928],268.017,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-16.0193,-23.186,-0.00130129],23.5218,1,0,[0,0],"","",true,false]
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


// Vehicles -------------------------------------------------------------------------------------------------------------

_car = selectRandom _parkedVehicleClasses;

if (_car != "") then {
    //["rhs_gaz66_ammo_msv",[-2.76465,5.00659,-4.76837e-007],359.829,1,0,[0,0],"","",true,false], 
    
    _carData = [
        [_car,[-2.76465,5.00659,-4.76837e-007],359.829,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
    
};

_car = selectRandom _parkedVehicleClasses;

if (_car != "") then {
    //["rhs_gaz66_ammo_msv",[-4.99097,-4.35938,-4.76837e-007],268.595,1,0,[0,0],"","",true,false], 
    
    _carData = [
        [_car,[-4.99097,-4.35938,-4.76837e-007],268.595,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
    
};



// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
    //["rhsgref_tla_DSHKM",[17.6543,-3.0791,-0.0749998],119.723,1,0,[0,-0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
    _staticsData = [
        [_gun,[17.6543,-3.0791,-0.0749998],119.723,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};
if (count _staticWeaponClasses > 0) then {
    //["rhsgref_tla_DSHKM",[-13.3118,18.1401,-0.0749998],290.222,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
    _staticsData = [
        [_gun,[-13.3118,18.1401,-0.0749998],290.222,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};


// AA -------------------------------------------------------------------------------------------------------------


if (count _staticAAClasses > 0 && random 100 < 10) then {
    //["rhsgref_ins_ZU23",[-13.04,-20.1997,-0.07514],230.617,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticAAClasses;
    
    _staticsData = [
        [_gun,[-13.04,-20.1997,-0.07514],230.617,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};


// Data Terminal -------------------------------------------------------------------------------------------------------------

    //["Land_DataTerminal_01_F",[13.1987,5.44312,0],88.5367,1,0,[0,0],"","",true,false], 

_terminal = A3E_DataTerminal;

_staticsData = [
    [_terminal,[13.1987,5.44312,1.0],88.5367,1,0,[0,0],"","",true,false]
];

_terminals = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

_obj = _terminals select 0;
_obj setvariable ["A3E_isTerminal",true,true];
_obj allowDamage false;
[_obj,"green","green","green"] call BIS_fnc_DataTerminalColor;


_objArray