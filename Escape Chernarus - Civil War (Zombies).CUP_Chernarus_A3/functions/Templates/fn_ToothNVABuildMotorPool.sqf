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

/*
// Set markers -------------------------------------------------------------------------------------------------------------
if(isNil("A3E_MotorPoolMarkerNumber")) then {
    A3E_MotorPoolMarkerNumber = 0;
} else {
    A3E_MotorPoolMarkerNumber = A3E_MotorPoolMarkerNumber + 1;
};

["A3E_MotorPoolMapMarker" + str A3E_MotorPoolMarkerNumber,_centerPos,"o_service"] call A3E_fnc_createLocationMarker;

diag_log format ["Created %1 at %2", "A3E_MotorPoolPatrolMarker" + str A3E_MotorPoolMarkerNumber, _centerPos];

_marker = createMarkerLocal ["A3E_MotorPoolPatrolMarker" + str A3E_MotorPoolMarkerNumber, _centerPos];
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [40, 38];
*/


// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_vn_camonetb_east",[-0.189453,-0.065918,0.7],0,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[0.268555,-2.72949,0],0,1,0,[],"","",true,false], 
	["Land_vn_garbage_square3_f",[-3.3042,-0.726074,0],0,1,0,[],"","",true,false], 
	["Land_Tyre_F",[-4.12891,-1.03418,0],0,1,0,[],"","",true,false], 
	["Land_Tyre_F",[-4.2832,-0.177734,0],0,1,0,[],"","",true,false], 
	["Land_vn_wf_vehicle_service_point_east",[0.0336914,3.98242,0],180.996,1,0,[],"","",true,false], 
	["Land_Tyre_F",[-4.80615,-0.768555,0],0,1,0,[],"","",true,false], 
	["Land_RefuelingHose_01_F",[-4.97363,0.753418,0],0,1,0,[],"","",true,false], 
	["Land_vn_garbage_square3_f",[3.90381,-3.10498,0],0,1,0,[],"","",true,false], 
	["Land_GasTank_01_yellow_F",[-4.8584,1.75439,0],90.0629,1,0,[],"","",true,false], 
	["Land_GasTank_02_F",[-4.98975,-1.55713,0],0,1,0,[],"","",true,false], 
	//["vn_o_armor_type63_01",[0.0693359,-4.98096,0.0749989],179.842,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[5.62939,0.119141,0],5.13186,1,0,[],"","",true,false], 
	["Land_GasTank_02_F",[-5.19531,-2.46436,0],0,1,0,[],"","",true,false], 
	["Land_Workbench_01_F",[-5.93799,-0.330078,0],268.784,1,0,[],"","",true,false], 
	["Land_TankRoadWheels_01_single_F",[-5.84766,1.56494,0],0,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-5.0918,-3.77881,0],181.113,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[6.15186,-1.84619,0],172.363,1,0,[],"","",true,false], 
	["Land_TankSprocketWheels_01_single_F",[-5.60352,3.25244,0],0,1,0,[],"","",true,false], 
	["Land_TankRoadWheels_01_single_F",[-6.4873,1.48291,0],0,1,0,[],"","",true,false], 
	["Land_WoodenTable_large_F",[6.65039,-0.761719,0],269.2,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[6.86133,0.0820313,0],41.7691,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[-4.56299,-5.15381,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[5.6499,4.03613,0],269.663,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[-4.99463,-4.93506,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[-5.37012,-4.70215,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[-4.99854,-5.18164,0],176.973,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[7.04492,-1.6377,0],172.363,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[-5.42529,-4.96338,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[-5.42334,-5.22607,0],176.973,1,0,[],"","",true,false], 
	["metalbarrel_burning_f",[8.17383,2.93359,0],0,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[8.20947,-3.74268,0],0,1,0,[],"","",true,false], 
	["Land_vn_stallwater_f",[7.72705,-5.7251,0],90.6875,1,0,[],"","",true,false], 
	["Land_vn_barel8",[-6.64502,-7.39209,0],0,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[8.76465,4.68994,0],181.113,1,0,[],"","",true,false], 
	["metalbarrel_burning_f",[-9.44385,-3.33887,0],0,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[-7.50537,-6.8877,0],269.826,1,0,[],"","",true,false], 
	["Land_vn_garbagebags_f",[-8.98584,4.83008,0],0,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[-9.15186,-4.87891,0],0,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[-10.3965,-1.46826,0],0,1,0,[],"","",true,false], 
	["Land_vn_b_leucaena_f",[-6.62793,8.12598,0],269.363,1,0,[],"","",true,false], 
	["CargoNet_01_barrels_F",[-11.1152,-4.53271,0],181.113,1,0,[],"","",true,false], 
	//["vn_o_wheeled_z157_fuel",[11.9014,-0.543945,0.18],8.4017,1,0,[],"","",true,false], 
	["Land_vn_garbage_square3_f",[-9.99512,-6.67285,0],0,1,0,[],"","",true,false], 
	["Land_vn_woodenshelter_01_f",[-10.1055,-6.9082,0],0,1,0,[],"","",true,false], 
	["Land_WoodenTable_large_F",[-10.1821,-6.96924,0],270,1,0,[],"","",true,false], 
	["metalbarrel_burning_f",[7.60498,-10.0059,0],183.825,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-12.4312,3.9375,-0.00130129],200.662,1,0,[],"","",true,false], 
	["Land_vn_b_caragana_arborescens",[11.0835,7.97266,0],104.252,1,0,[],"","",true,false], 
	["Land_vn_garbageheap_02_f",[12.0327,4.72656,3.33786e-006],170.749,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[-10.3877,-8.41699,0],186.836,1,0,[],"","",true,false], 
	//["vn_o_nva_static_zpu4",[-13.3906,0.245117,-0.0749998],272.004,1,0,[],"","",true,false], 
	["Land_vn_b_arundod2s_f",[-11.1006,7.78027,-1.45],245.004,1,0,[],"","",true,false], 
	//["vn_o_nva_static_dshkm_high_01",[10.9658,-8.09277,-0.0749998],137.269,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[9.68457,-10.6509,-0.000999928],183.825,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-14.3062,-3.54346,-0.00130129],12.1902,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-15.0044,3.0542,-0.000999928],327.532,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[13.2432,-7.79248,-0.000999928],273.825,1,0,[],"","",true,false], 
	["Land_vn_bagfence_long_f",[-16.1807,-1.35596,-0.000999928],57.5324,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[12.6626,-10.4482,-0.00130129],318.825,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-17.2847,1.12793,-0.00130129],102.532,1,0,[],"","",true,false]
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


// Armor
_armor = selectRandom _parkedArmorClasses;

if (count _parkedArmorClasses > 0) then {

	//["vn_o_armor_type63_01",[0.0693359,-4.98096,0.0749989],179.842,1,0,[],"","",true,false], 
    
    _armorData = [
        [_armor,[0.0693359,-4.98096,0],179.842,1,0,[0,0],"","",true,false]
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
	//["vn_o_wheeled_z157_fuel",[11.9014,-0.543945,0.18],8.4017,1,0,[],"","",true,false], 
    _car = selectRandom _parkedVehicleClasses;

    _carData = [
        [_car,[11.9014,-0.543945,0],8.4017,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
};






// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
	//["vn_o_nva_static_dshkm_high_01",[10.9658,-8.09277,-0.0749998],137.269,1,0,[],"","",true,false], 


    _gun = selectRandom _staticWeaponClasses;
    
    _staticsData = [
        [_gun,[10.9658,-8.09277,0],137.269,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};



// AA Gun -------------------------------------------------------------------------------------------------------------

if (count _staticAAClasses > 0) then {
	//["vn_o_nva_static_zpu4",[-13.3906,0.245117,-0.0749998],272.004,1,0,[],"","",true,false], 
    
    _staticAA = selectRandom _staticAAClasses;
    
    _staticsData = [
        [_staticAA,[-13.3906,0.245117,0],272.004,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};

_objArray