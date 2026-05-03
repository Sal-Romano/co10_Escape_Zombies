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


[_centerPos,15] call a3e_fnc_cleanupTerrain;


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



// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[1.11914,0.223145,0],0,1,0,[],"","",true,false], 
	["Land_vn_stallwater_f",[-2.51074,0.501465,0],90.6875,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[0.432129,-2.67139,0],265.207,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[-2.51758,1.68701,0],0,1,0,[],"","",true,false], 
	["Land_vn_woodencrate_01_stack_x5_f",[-1.79443,-2.9375,0],0,1,0,[],"","",true,false], 
	["Land_vn_garbage_square3_f",[3.58936,-1.25342,0],0,1,0,[],"","",true,false], 
	//["Box_T_East_WpsSpecial_F",[3.89355,0.247559,0],268.662,1,0,[],"","",true,false], 
	["Land_WoodenTable_large_F",[2.75781,-2.73633,0],270,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-1.5835,3.85156,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_camonet_east",[-4.27002,-0.603516,0],268.957,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.14453,1.67822,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_paperbox_01_small_closed_white_idap_f",[2.59766,3.70117,0],177.193,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.14258,1.94092,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.19775,2.20215,0],176.973,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[4.81348,0.526855,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.56934,1.72266,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_hut_03",[4.69092,-0.680664,0],0,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[-4.95215,-0.0625,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.57324,1.96924,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_sack_ep1",[2.45508,4.57275,0],177.193,1,0,[],"","",true,false], 
	["metalbarrel_burning_f",[0.504883,-5.20166,0],0,1,0,[],"","",true,false], 
	["Land_vn_crateswooden_f",[-4.71826,-2.31934,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[5.00488,1.75049,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.98242,1.98975,0],176.973,1,0,[],"","",true,false], 
	["vn_campfire_burning_f",[-0.951172,5.36377,0.0299988],177.193,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[5.06299,2.46875,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-1.72412,-5.3208,0],0.377776,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-2.25391,5.19482,0],177.193,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[5.40918,1.76611,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_sacks_heap_f",[4.00342,4.05469,0],268.281,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[5.41162,2.00342,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[5.77783,0.154297,0],269.826,1,0,[],"","",true,false], 
	["Land_vn_woodenbox_f",[3.72021,-4.50342,0],0,1,0,[],"","",true,false], 
	["Land_vn_c_prop_pot_fire_01",[2.35303,5.38965,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[5.85352,-1.34375,0],0,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[-0.101074,6.0498,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_cratesshabby_f",[-5.99805,0.980469,0],0,1,0,[],"","",true,false], 
	["vn_o_prop_t102e_01",[5.85205,-2.24463,0],105.864,1,0,[],"","",true,false], 
	["Land_vn_barel8",[6.06445,1.6665,0],0,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[5.36328,-3.37549,0],123.48,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[3.60938,5.33691,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_teapot_ep1",[3.00977,5.81689,0],266.716,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[0.253418,7.00342,0],269.813,1,0,[],"","",true,false], 
	["Land_vn_garbagebags_f",[-5.29248,-5.96777,0],0,1,0,[],"","",true,false], 
	["Land_vn_sacks_goods_f",[5.49023,4.73779,0],248.437,1,0,[],"","",true,false], 
	["Land_vn_garbageheap_02_f",[4.33545,-6.36719,3.33786e-006],135.358,1,0,[],"","",true,false], 
	["Land_vn_b_arundod2s_f",[-0.55127,-7.85156,-1.45],245.004,1,0,[],"","",true,false], 
	//["vn_o_bicycle_02_vcmf",[6.91553,-5.91504,0],193.96,1,0,[],"","",true,false], 
	["Land_vn_woodencart_f",[7.50977,5.33545,0],330.994,1,0,[],"","",true,false], 
	["Land_vn_b_calochlaena_f",[9.45313,-2.25879,0],0,1,0,[],"","",true,false], 
	//["vn_o_nva_static_dshkm_high_01",[-4.8999,8.4248,-0.0749998],328.684,1,0,[],"","",true,false], 
	["Land_vn_o_trapdoor_02",[1.15918,10.2388,0],0,1,0,[],"","",true,false], 
	["Land_vn_hut_tower_02",[4.07617,10.0942,0],183.193,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-6.03613,10.4976,-0.00130129],144.718,1,0,[],"","",true,false]
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


if (random 10 > 1 && count _parkedVehicleClasses > 0) then {
    _car = selectRandom _parkedVehicleClasses;
}
else {
    _car = "";
};

if (_car != "") then {
	//["vn_o_bicycle_02_vcmf",[6.91553,-5.91504,0],193.96,1,0,[],"","",true,false], 
	
    _carData = [
    	[_car,[6.91553,-5.91504,0],193.96,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_ChangeVehicleInventory;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
	
};



// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
	//["vn_o_nva_static_dshkm_high_01",[-4.8999,8.4248,-0.0749998],328.684,1,0,[],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[-4.8999,8.4248,0],328.684,1,0,[0,0],"","",true,false]
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
    private ["_magItem", "_weaponClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
    
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

	//["Box_T_East_WpsSpecial_F",[3.89355,0.247559,0],268.662,1,0,[],"","",true,false], 
	_boxType = a3e_AmmoDepotBox;
	    
	_ammoBoxData = [
		[_boxType,[3.89355,0.247559,0],268.662,1,0,[0,0],"","",true,false]
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


_objArray