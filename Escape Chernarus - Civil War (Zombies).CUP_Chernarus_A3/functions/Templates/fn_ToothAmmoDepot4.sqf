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
params ["_centerPos","_staticWeaponClasses","_parkedVehicleClasses"];
private ["_object", "_pos", "_marker", "_instanceNo", "_randomNo", "_gun", "_statics", "_staticsData", "_angle", "_car", "_cars", "_carData", "_boxType", "_ammoBoxData", "_ammoBoxes", "_box"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,15] call a3e_fnc_cleanupTerrain;

/*
if (isNil "drn_BuildAmmoDepot_MarkerInstanceNo") then {
	drn_BuildAmmoDepot_MarkerInstanceNo = 0;
}
else {
	drn_BuildAmmoDepot_MarkerInstanceNo = drn_BuildAmmoDepot_MarkerInstanceNo + 1;
};
_instanceNo = drn_BuildAmmoDepot_MarkerInstanceNo;



// Set markers -------------------------------------------------------------------------------------------------------------
["drn_AmmoDepotMapMarker" + str _instanceNo,_centerPos,"o_installation"] call A3E_fnc_createLocationMarker;


_marker = createMarkerLocal ["drn_AmmoDepotPatrolMarker" + str _instanceNo, _centerPos];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];
*/


// Vehicles -------------------------------------------------------------------------------------------------------------


if (random 10 > 1 && count _parkedVehicleClasses > 0) then {
    _car = selectRandom _parkedVehicleClasses;
}
else {
    _car = "";
};

if (_car != "") then {
	//["rhs_gaz66_ammo_msv",[-0.191406,-3.14795,-4.76837e-007],179.318,1,0,[0,-0],"","",true,false], 
	
    _carData = [
    	[_car,[-0.191406,-3.14795,-4.76837e-007],179.318,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_ChangeVehicleInventory;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
	
};







// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
	//["rhsgref_tla_DSHKM",[6.38477,-10.4915,-0.0749998],187.461,1,0,[0,0],"","",true,false], 
 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[6.38477,-10.4915,-0.0749998],187.461,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};



// Ammo Box -------------------------------------------------------------------------------------------------------------


_weapons = [];
_weaponMagazines = [];
_items = [];
_backpacks = [];

for "_i" from 0 to (count a3e_arr_AmmoDepotWeapons - 1) do {
    private ["_gunItem", "_weaponClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
    
    _gunItem = a3e_arr_AmmoDepotWeapons select _i;
    
    _weaponClassName = _gunItem select 0;
    _probabilityOfPrecence = _gunItem select 1;
    _minCount = _gunItem select 2;
    _maxCount = _gunItem select 3;
    _magazines = _gunItem select 4;
    _magazinesPerWeapon = _gunItem select 5;
    
    if (random 100 <= _probabilityOfPrecence) then {
        _weaponCount = floor (_minCount + random (_maxCount - _minCount));
        _weapons pushBack [_weaponClassName, _weaponCount];
        
        for "_j" from 0 to (count _magazines) - 1 do {
            _weaponMagazines pushBack [_magazines select _j, _weaponCount * _magazinesPerWeapon];
        };
    };
};

for "_i" from 0 to (count a3e_arr_AmmoDepotMags - 1) do {
    private ["_magItem", "_magClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
    
    _magItem = a3e_arr_AmmoDepotMags select _i;
    
    _magClassName = _magItem select 0;
    _probabilityOfPrecence = _magItem select 1;
    _minCount = _magItem select 2;
    _maxCount = _magItem select 3;
    
    if (random 100 <= _probabilityOfPrecence) then {
        _magCount = floor (_minCount + random (_maxCount - _minCount));
        _weaponMagazines pushBack [_magClassName, _magCount];
        
    };
};

for "_i" from 0 to (count a3e_arr_AmmoDepotItems - 1) do {
    private ["_item", "_itemClassName", "_probabilityOfPrecence", "_minCount", "_maxCount"];
    
    _item = a3e_arr_AmmoDepotItems select _i;
    
    _itemClassName = _item select 0;
    _probabilityOfPrecence = _item select 1;
    _minCount = _item select 2;
    _maxCount = _item select 3;
    
    if (random 100 <= _probabilityOfPrecence) then {
        _itemCount = floor (_minCount + random (_maxCount - _minCount));
        _items pushback [_itemClassName, _itemCount];
    };
};

for "_i" from 0 to (count a3e_arr_AmmoDepotBackpacks - 1) do {
    private ["_backpack", "_backpackClassName", "_probabilityOfPrecence", "_minCount", "_maxCount"];
    
    _backpack = a3e_arr_AmmoDepotBackpacks select _i;
    
    _backpackClassName = _backpack select 0;
    _probabilityOfPrecence = _backpack select 1;
    _minCount = _backpack select 2;
    _maxCount = _backpack select 3;
    
    if (random 100 <= _probabilityOfPrecence) then {
        _backpackCount = floor (_minCount + random (_maxCount - _minCount));
        _backpacks pushback [_backpackClassName, _backpackCount];
    };
};

if (count _weapons > 0 || count _weaponMagazines > 0 || count _items > 0 || count _backpacks > 0) then {

	//["Box_T_East_WpsSpecial_F",[-7.1499,-1.00366,0],92.3555,1,0,[0,-0],"","",true,false], 
	_boxType = a3e_AmmoDepotBox;
	    
	_ammoBoxData = [
		[_boxType,[-7.1499,-1.00366,0],92.3555,1,0,[0,0],"","",true,false]
	];

	_ammoBoxes = [_centerPos, _rotateDir, _ammoBoxData] call BIS_fnc_objectsMapper;
	_box = _ammoBoxes select 0;

	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;
    
    {
        _box addWeaponCargoGlobal _x;
    } foreach _weapons;
    {
        _box addMagazineCargoGlobal _x;
    } foreach _weaponMagazines;
    {
        _box addBackpackCargoGlobal _x,;
    } foreach _backpacks;
    {
        _box addItemCargoGlobal _x;
    } foreach _items;
};


// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_CampingChair_V2_F",[0.0454102,2.76172,0],172.363,1,0,[0,-0],"","",true,false], 
	["Land_ClutterCutter_large_F",[-2.5835,-1.21826,0],182.256,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[0.938477,2.96997,0],172.363,1,0,[0,-0],"","",true,false], 
	//["rhs_gaz66_ammo_msv",[-0.191406,-3.14795,-4.76837e-007],179.318,1,0,[0,-0],"","",true,false], 
	["Land_WoodenTable_large_F",[0.543945,3.84595,0],269.2,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[3.17139,2.68823,0],172.363,1,0,[0,-0],"","",true,false], 
	["Land_CampingChair_V2_F",[0.754883,4.69019,0],41.7691,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[-0.477051,4.72681,0],5.13186,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[-0.498535,-4.96582,0],0,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[4.15039,2.82153,0],164.545,1,0,[0,-0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-4.39331,2.89453,0],3.36965,1,0,[0,0],"","",true,false], 
	["Land_WoodenTable_large_F",[3.7666,3.79712,0],269.2,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[2.80029,4.81934,0],269.2,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[3.37158,4.89673,0],7.15434,1,0,[0,0],"","",true,false], 
	["CamoNet_BLUFOR_open_F",[-1.48633,5.27759,0],0.741902,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-4.17139,4.79028,0],3.36965,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-4.07813,5.56567,0],3.36965,1,0,[0,0],"","",true,false], 
	["Land_Pallets_F",[4.21265,-6.5835,0],0,1,0,[0,0],"","",true,false], 
	//["Box_T_East_WpsSpecial_F",[-7.1499,-1.00366,0],92.3555,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[-6.7251,2.70361,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-4.11768,6.28271,0],3.36965,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-6.70752,3.52393,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-6.47852,4.04785,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_MetalBarrel_F",[2.8916,-7.10156,0],271.738,1,0,[0,0],"","",true,false], 
	["Land_Pallets_F",[6.24487,-5.15991,0],0,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-6.46484,4.29395,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_MetalBarrel_F",[3.75928,-6.9917,0],108.899,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-6.88818,4.04321,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-7.57373,-2.72363,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-6.90137,4.28369,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-7.58887,-2.98584,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-6.85938,4.56079,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.31445,1.39087,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.00049,-2.74048,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.30566,1.65332,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-7.30615,4.28369,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.52637,0.531738,0],102.785,1,0,[0,-0],"","",true,false], 
	["Land_ShootingPos_Roof_01_F",[-7.66455,-1.38232,0],92.2411,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.02002,-2.98633,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-2.73535,8.0769,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-7.32959,4.54077,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.66797,1.03735,0],122.909,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.38818,-2.46387,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.68604,-1.05835,0],273.431,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.77881,0.697754,0],2.9727,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.53516,2.28174,0],101.348,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.43652,-2.73999,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.4292,-2.98071,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Pallets_stack_F",[6.62109,-6.0332,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-8.26074,-3.50415,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-9.02246,0.206787,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.54492,-2.8252,0],2.9727,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-9.01953,0.478516,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.68896,2.7832,0],121.472,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[-9.08057,-1.09521,0],93.5195,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.85742,-2.47217,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-9.02246,1.94434,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.84033,-2.72925,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-9.02734,2.21558,0],359.229,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-8.8584,-2.96582,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-8.2998,-4.32373,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_Pallets_stack_F",[0.152344,9.38721,0],95.0296,1,0,[0,-0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-4.93311,8.0332,0],359.071,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.45947,-4.53955,0],2.9727,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-7.86865,5.66162,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-8.23975,-5.46338,0],0.666653,1,0,[0,0],"","",true,false], 
	["Land_RoadBarrier_01_F",[2.823,-9.50684,0],0,1,0,[0,0],"","",true,false], 
	["Land_Pallets_stack_F",[6.42383,-7.91748,0],0,1,0,[0,0],"","",true,false], 
	["Land_LampShabby_F",[-9.03687,3.78931,0],79.0866,1,0,[0,0],"","",true,false], 
	["Land_Cargo20_sand_F",[8.54346,5.84961,0],272.626,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_pole_F",[4.70996,-9.31079,0],0,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.39478,-6.33643,0],271.322,1,0,[0,0],"","",true,false], 
	["Land_Sign_noentry_big_en_pl_F",[3.9165,-9.91626,0],0,1,0,[0,0],"","",true,false], 
	["Land_GuardTower_02_F",[-8.71167,-7.74292,0],270.853,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[10.1472,0.748291,-2.86102e-006],92.3398,1,0,[0,-0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[-10.2732,-9.32886,-2.86102e-006],272.308,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[-9.8645,0.679443,-2.86102e-006],272.308,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_open_full_F",[8.3125,-8.01196,0],91.247,1,0,[0,-0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[-9.51099,10.7422,-2.86102e-006],0,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_5m_F",[9.73877,-9.34912,1.43051e-006],180.032,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[10.5618,10.7563,-2.86102e-006],92.3398,1,0,[0,-0],"","",true,false], 
	//["rhsgref_tla_DSHKM",[6.38477,-10.4915,-0.0749998],187.461,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[0.505615,10.7371,-2.86102e-006],0,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_5m_F",[-5.26563,-9.35254,1.43051e-006],180.032,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-6.56152,-11.1389,-0.00130129],52.73,1,0,[0,0],"","",true,false], 
	[Tooth_enemyFlagPole,[-5.48657,-10.6106,0],267.172,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[5.60156,-12.3684,-0.000999928],180.247,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[8.37085,-11.5398,-0.00130129],295.752,1,0,[0,0],"","",true,false]
];


_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;













