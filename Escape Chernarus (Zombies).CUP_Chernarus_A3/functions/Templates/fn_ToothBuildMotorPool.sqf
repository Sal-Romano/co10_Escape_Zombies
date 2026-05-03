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
[getPos player, random 360, ["rhsgref_tla_DSHKM"], ["rhs_gaz66_ammo_msv"],["rhs_gaz66_ammo_msv"],["rhsgref_tla_DSHKM"]] execVM "ToothBuildMotorPool.sqf";

*/
if(!isserver) exitwith {};
//params ["_centerPos","_rotateDir","_staticWeaponClasses","_parkedVehicleClasses","_parkedArmorClasses","_staticAAClasses"];

private ["_centerPos", "_rotateDir", "_staticWeaponClasses", "_parkedVehicleClasses", "_index"];
private ["_pos", "_dir", "_posX", "_posY", "_sectionDir", "_guns", "_gun", "_vehicle", "_powerGenerator","_static"];
private ["_fnc_CreateObject", "_parkedArmorClasses", "_armor", "_random", "_objectName", "_hqObject"];
private ["_obj", "_mNumber", "_sarmor", "_objpos", "_guardtower", "_staticAAClasses", "_newpos", "_aaemplacement", "_staticAA"];

_centerPos            = [_this, 0] call bis_fnc_param;
_rotateDir            = [_this, 1] call bis_fnc_param;
_staticWeaponClasses  = [_this, 2, []] call bis_fnc_param;
_parkedVehicleClasses = [_this, 3, []] call bis_fnc_param;
_parkedArmorClasses   = [_this, 4, []] call bis_fnc_param;
_staticAAClasses      = [_this, 5, []] call bis_fnc_param;


// Initial Setup -------------------------------------------------------------------------------------------------------------

_centerPos = _centerPos select 0;

[_centerPos,30] call a3e_fnc_cleanupTerrain;


// Vehicles -------------------------------------------------------------------------------------------------------------


// Armor
_armor = selectRandom _parkedArmorClasses;

if (count _parkedArmorClasses > 0) then {

    //["rhs_t72ba_tv",[-2.5542,-0.377197,0.0628457],0,1,0,[0,0],"","",true,false], 
    
    _armorData = [
        [_armor,[-2.5542,-0.377197,0.0628457],0,1,0,[0,0],"","",true,false]
    ];

    _armors = [_centerPos, _rotateDir, _armorData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        _x setFuel random [0.1, 0.3, 0.5];
    } forEach _armors;
    

};
// setVehicleAmmo cannot be used until Ammo Depots rearm all vehicles


// Other Vehicles
if (count _parkedVehicleClasses > 0) then {
    // Cars
    //["rhs_gaz66_ammo_msv",[8.88794,2.54297,-4.76837e-007],268.242,1,0,[0,0],"","",true,false], 
    _car = selectRandom _parkedVehicleClasses;

    _carData = [
        [_car,[8.88794,2.54297,-4.76837e-007],268.242,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
};

_random = random 1;
if (_random < .3 ) then {
    //["rhs_zil131_msv",[-10.8821,7.63599,0.199999],90.5667,1,0,[0,-0],"","",true,false], 
    _car = selectRandom _parkedVehicleClasses;

    _carData = [
        [_car,[-10.8821,7.63599,0.199999],90.5667,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        _x setfuel random 1;
        _x setdamage random [0, 0.2, 0.5];
    } forEach _cars;

};
if (_random > .9) then {
    //["rhs_zil131_msv",[15.4749,-16.2998,0.199999],214.33,1,0,[0,0],"","",true,false]
    _car = selectRandom _parkedVehicleClasses;

    _carData = [
        [_car,[15.4749,-16.2998,0.199999],214.33,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        _x setfuel random 1;
        _x setdamage random [0, 0.2, 0.5];
    } forEach _cars;
    
};





// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
    //["rhsgref_tla_DSHKM",[9.20776,-12.6013,-0.0749998],180.027,1,0,[0,0],"","",true,false], 


    _gun = selectRandom _staticWeaponClasses;
    
    _staticsData = [
        [_gun,[9.20776,-12.6013,-0.0749998],180.027,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};
if (count _staticWeaponClasses > 0) then {
    //["rhsgref_tla_DSHKM",[-4.73779,15.3701,-0.0749998],6.36926,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
    _staticsData = [
        [_gun,[-4.73779,15.3701,-0.0749998],6.36926,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};



// AA Gun -------------------------------------------------------------------------------------------------------------

if (count _staticAAClasses > 0) then {
    //["rhsgref_tla_ZU23",[-1.25708,-18.6895,-0.07514],180.027,1,0,[0,0],"","",true,false], 
    
    _staticAA = selectRandom _staticAAClasses;
    
    _staticsData = [
        [_staticAA,[-1.25708,-18.6895,-0.07514],180.027,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};














// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
    //["rhs_t72ba_tv",[-2.5542,-0.377197,0.0628457],0,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[1.50977,-0.617432,0],355.678,1,0,[0,0],"","",true,false], 
    ["Land_Tyre_F",[3.65723,-2.36011,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Tyre_F",[4.18018,-1.76953,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Tyre_F",[4.33447,-2.62598,0],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-2.76709,-4.30005,0],0,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[5.61182,-0.731689,0],5.13186,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[4.27173,-3.96143,0],181.113,1,0,[0,0],"","",true,false], 
    ["Land_Shed_Small_F",[7.52417,-9.09448,0],270.234,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[2.98779,-5.61255,0],269.663,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[6.13428,-2.69678,0],172.363,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenTable_large_F",[6.63281,-1.61255,0],269.2,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[6.84375,-0.768311,0],41.7691,1,0,[0,0],"","",true,false], 
    ["Land_GasTank_01_yellow_F",[-6.76025,-2.43286,0],90.0629,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[4.41821,-5.70288,0],181.113,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[7.02734,-2.48853,0],172.363,1,0,[0,-0],"","",true,false], 
    ["Land_LampShabby_F",[-6.55957,-0.762695,0],355.678,1,0,[0,0],"","",true,false], 
    ["Land_RefuelingHose_01_F",[-6.87549,-3.43384,0],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[7.54346,2.20508,0],0,1,0,[0,0],"","",true,false], 
    ["Land_GarbageBarrel_02_F",[-7.88818,-0.778809,0],0,1,0,[0,0],"","",true,false], 
    ["Land_TankRoadWheels_01_single_F",[-7.8374,-1.85181,0],0,1,0,[0,0],"","",true,false], 
    ["Land_TankRoadWheels_01_single_F",[-7.74951,-2.62183,0],0,1,0,[0,0],"","",true,false], 
    ["CargoNet_01_barrels_F",[2.83105,-7.80298,0],181.113,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-3.71875,7.8103,0],0,1,0,[0,0],"","",true,false], 
    ["Land_TankRoadWheels_01_single_F",[-8.38916,-2.7041,0],0,1,0,[0,0],"","",true,false], 
    ["Land_EngineCrane_01_F",[-8.7937,0.593506,0],213.565,1,0,[0,0],"","",true,false], 
    ["Land_GasTank_02_F",[-6.8916,-5.74414,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Workbench_01_F",[-7.83984,-4.51709,0],268.784,1,0,[0,0],"","",true,false], 
    ["CargoNet_01_barrels_F",[4.67529,-7.78564,0],181.113,1,0,[0,0],"","",true,false], 
    //["rhs_gaz66_ammo_msv",[8.88794,2.54297,-4.76837e-007],268.242,1,0,[0,0],"","",true,false], 
    ["Land_TankTracks_01_long_F",[-9.05518,-2.85889,0],0,1,0,[0,0],"","",true,false], 
    ["Land_GasTank_02_F",[-7.09717,-6.65137,0],0,1,0,[0,0],"","",true,false], 
    ["Land_ScrapHeap_1_F",[8.09155,-5.54736,0],0,1,0,[0,0],"","",true,false], 
    ["Land_TankSprocketWheels_01_single_F",[-9.87402,-1.54834,0],0,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[9.55469,-0.739502,0],355.678,1,0,[0,0],"","",true,false], 
    ["Land_MetalBarrel_F",[-10.2979,-0.43042,0],108.899,1,0,[0,-0],"","",true,false], 
    ["Land_TankTracks_01_long_F",[-10.3149,-3.18384,0],172.154,1,0,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-3.96753,-10.3787,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[1.98901,-10.4063,0],0,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[10.8999,-1.38721,0],181.113,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[10.8374,-2.16577,0],181.113,1,0,[0,0],"","",true,false], 
    ["Land_PaperBox_closed_F",[-8.01782,-7.70679,0],177.434,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenBox_F",[10.9053,-2.88062,0],181.113,1,0,[0,0],"","",true,false], 
    ["Land_Pallets_stack_F",[-9.84424,-5.79321,0],272.773,1,0,[0,0],"","",true,false], 
    ["Land_ToolTrolley_02_F",[-11.4639,-0.169678,0],90.5187,1,0,[0,-0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[8.31543,8.05103,0],0,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[10.9539,-4.10376,0],181.113,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[10.709,-5.8606,0],273.73,1,0,[0,0],"","",true,false], 
    ["Land_TankEngine_01_used_F",[-12.1621,-2.51123,0],0,1,0,[0,0],"","",true,false], 
    ["Land_PaperBox_closed_F",[-9.8147,-7.76392,0],269.085,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[0.730469,12.7183,0],0,1,0,[0,0],"","",true,false], 
    ["Land_ToolTrolley_01_F",[-12.8516,-0.0895996,0],268.877,1,0,[0,0],"","",true,false], 
    ["MetalBarrel_burning_F",[-5.73462,11.8604,0],45.7711,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[-11.9094,-5.95947,0],0.377776,1,0,[0,0],"","",true,false], 
    //["rhs_zil131_msv",[-10.8821,7.63599,0.199999],90.5667,1,0,[0,-0],"","",true,false], 
    ["Land_GuardTower_02_F",[10.7961,-9.00098,0],179.663,1,0,[0,-0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[13.1147,-3.78638,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-9.95386,-10.3853,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagBunker_Small_F",[-0.7771,-14.2285,0],358.689,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[7.9729,-10.4043,0],0,1,0,[0,0],"","",true,false], 
    ["Land_i_Garage_V2_F",[9.72461,8.93774,0.156],0,1,0,[0,0],"","",true,false], 
    ["Land_PaperBox_closed_F",[-11.531,-7.79492,0],269.085,1,0,[0,0],"","",true,false], 
    ["Land_RoadBarrier_01_F",[4.85522,13.4465,0],0,1,0,[0,0],"","",true,false], 
    ["Land_WoodenCrate_01_stack_x5_F",[-13.6406,-5.42847,0],1.97365,1,0,[0,0],"","",true,false], 
    ["Land_LampShabby_F",[-14.4478,-0.745361,0],355.678,1,0,[0,0],"","",true,false], 
    ["MetalBarrel_burning_F",[5.08276,-14.1191,0],45.7711,1,0,[0,0],"","",true,false], 
    ["Land_PaperBox_closed_F",[-13.3035,-7.77393,0],179.544,1,0,[0,-0],"","",true,false], 
    ["Land_Sign_noentry_big_en_pl_F",[6.72754,14.0615,0],178.621,1,0,[0,-0],"","",true,false], 
    //["rhsgref_tla_DSHKM",[9.20776,-12.6013,-0.0749998],180.027,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[5.80298,-14.9854,-0.000999928],269.819,1,0,[0,0],"","",true,false], 
    //["rhsgref_tla_DSHKM",[-4.73779,15.3701,-0.0749998],6.36926,1,0,[0,0],"","",true,false], 
    ["Land_CampingChair_V2_F",[-6.13159,-15.0535,0],274.772,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-7.92212,13.6121,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[10.3352,13.4773,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Caravan_01_rust_F",[16.5327,-1.11157,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[-7.10107,-15.3582,-0.000999928],89.5471,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[8.05396,-15.0469,-0.00130129],42.3848,1,0,[0,0],"","",true,false], 
    ["Land_TBox_F",[-15.9177,-6.23413,0],269.838,1,0,[0,0],"","",true,false], 
    ["Land_Loudspeakers_F",[16.2036,4.46826,0],0,1,0,[0,0],"","",true,false], 
    ["MetalBarrel_burning_F",[-6.33276,-16.0913,0],45.7711,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-17.8333,-0.313232,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Round_F",[-3.89575,17.7263,-0.00130129],212.47,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[18.0178,-2.58765,0],270,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-6.4375,17.2534,-0.00130129],121.121,1,0,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-15.9377,-10.3872,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[10.8442,-15.0317,-0.00130129],311.036,1,0,[0,0],"","",true,false], 
    ["Land_Net_Fence_Gate_F",[19.9424,-10.437,0],0,1,0,[0,0],"","",true,false], 
    [Tooth_enemyFlagPole,[8.72949,15.8225,0],261.332,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-17.8459,5.70825,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[18.011,3.36401,0],270,1,0,[0,0],"","",true,false], 
    //["rhsgref_tla_ZU23",[-1.25708,-18.6895,-0.07514],180.027,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-17.8225,-6.28296,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenBox_F",[3.48071,-19.0823,0],326.678,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[9.67578,17.2361,-0.00130129],212.47,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[18.0168,-8.51685,0],270,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[5.98218,-19.3062,-0.00130129],288.781,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-13.7,13.5847,0],180,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[16.113,13.5046,0],180,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[3.72119,-19.9312,0],333.682,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-7.29126,-19.6367,-0.00130129],69.9735,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-5.19971,-20.1106,0],203.167,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[17.5256,9.39307,-0.149854],270,1,0,[0,0],"","",true,false], 
    ["Land_Wall_IndCnc_4_F",[-17.8533,11.6943,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[3.62793,-20.9397,-0.000999928],331.265,1,0,[0,0],"","",true,false], 
    ["Land_Sign_noentry_big_en_pl_F",[18.0496,-11.4365,0],0.469398,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[-4.93506,-21.1262,-0.000999928],23.7095,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[0.809814,-21.803,-0.000999928],179.602,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[-2.14502,-21.8433,-0.000999928],179.602,1,0,[0,-0],"","",true,false] 
    //["rhs_zil131_msv",[15.4749,-16.2998,0.199999],214.33,1,0,[0,0],"","",true,false]
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