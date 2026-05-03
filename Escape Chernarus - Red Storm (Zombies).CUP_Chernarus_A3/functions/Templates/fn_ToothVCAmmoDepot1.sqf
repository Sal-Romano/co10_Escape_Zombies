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
	["Land_ClutterCutter_large_F",[-0.460449,-0.751953,0],0,1,0,[],"","",true,false], 
	//["Box_T_East_WpsSpecial_F",[2.31396,-0.727539,0],268.662,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.56494,0.703125,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_o_trapdoor_02",[-2.70605,-0.374512,0.0996504],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.56299,0.96582,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.61816,1.22705,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_paperbox_01_small_closed_white_idap_f",[1.01807,2.72607,0],177.193,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.98975,0.747559,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_garbage_square3_f",[2.00977,-2.22852,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.99365,0.994141,0],176.973,1,0,[],"","",true,false], 
	["Land_ClutterCutter_large_F",[3.23389,-0.448242,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[3.42529,0.775391,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[3.40283,1.01465,0],176.973,1,0,[],"","",true,false], 
	["Land_vn_sack_ep1",[0.875488,3.59766,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_hut_03",[3.11133,-1.65576,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[3.4834,1.49365,0],176.973,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[-1.14746,-3.64648,0],265.207,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[3.82959,0.791016,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenTable_large_F",[1.17822,-3.71143,0],270,1,0,[],"","",true,false], 
	["Land_vn_sacks_heap_f",[2.42383,3.07959,0],268.281,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[3.83203,1.02832,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[4.19824,-0.820801,0],269.826,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-3.16309,2.87646,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_c_prop_pot_fire_01",[0.773438,4.41455,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_barel8",[4.48486,0.691406,0],0,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[2.02979,4.36182,0],177.193,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[4.27393,-2.31885,0],0,1,0,[],"","",true,false], 
	["Land_vn_teapot_ep1",[1.43018,4.8418,0],266.716,1,0,[],"","",true,false], 
	["vn_campfire_burning_f",[-2.53076,4.38867,0.0299988],177.193,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[-1.68066,5.07471,0],177.193,1,0,[],"","",true,false], 
	["vn_o_prop_t102e_01",[4.27246,-3.21973,0],105.864,1,0,[],"","",true,false], 
	["Land_vn_sacks_goods_f",[3.91064,3.7627,0],248.437,1,0,[],"","",true,false], 
	["Land_vn_crateswooden_f",[-0.369141,-5.44434,0],0,1,0,[],"","",true,false], 
	//["vn_o_bicycle_02_vcmf",[-3.78467,-3.66162,0],261.273,1,0,[],"","",true,false], 
	["Land_WoodenLog_F",[-3.8335,4.21973,0],177.193,1,0,[],"","",true,false], 
	["Land_CampingChair_V2_F",[3.78369,-4.35059,0],123.48,1,0,[],"","",true,false], 
	["Land_vn_woodenbox_f",[2.14063,-5.47852,0],0,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-2.71582,-5.20117,0],0.377776,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[-5.95215,0.0878906,0],0,1,0,[],"","",true,false], 
	["Land_vn_stallwater_f",[-6.00098,-1.09326,0],90.6875,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[-6.55566,1.10107,0],0,1,0,[],"","",true,false], 
	["Land_WoodPile_F",[-2.31885,6.16602,0],269.813,1,0,[],"","",true,false], 
	["metalbarrel_burning_f",[-6.47314,-2.4707,0],0,1,0,[],"","",true,false], 
	["Land_vn_woodencrate_01_stack_x5_f",[0.598145,-7.38428,0],0,1,0,[],"","",true,false], 
	["Land_vn_cratesshabby_f",[-7.40088,0.530273,0],0,1,0,[],"","",true,false], 
	["Land_vn_hut_tower_01",[-7.07861,3.73682,0],135.453,1,0,[],"","",true,false], 
	["Land_vn_nipa_palm_tree_02",[5.87305,4.95703,0],307.589,1,0,[],"","",true,false], 
	["Land_vn_woodencart_f",[2.87305,7.62354,0],265.173,1,0,[],"","",true,false], 
	["Land_vn_garbageheap_02_f",[3.76855,-7.54004,0.0443168],135.358,1,0,[],"","",true,false], 
	["Land_vn_garbagebags_f",[-2.53174,-8.94043,0],0,1,0,[],"","",true,false], 
	//["vn_o_nva_static_dshkm_high_01",[-6.46484,-5.46094,-0.0749998],227.322,1,0,[],"","",true,false], 
	["Land_vn_b_arundod2s_f",[-4.38818,8.04688,-1.45],245.004,1,0,[],"","",true,false], 
	["Land_vn_b_leucaena_f",[-9.15039,-1.15332,0],0,1,0,[],"","",true,false], 
	["Land_vn_b_caragana_arborescens",[8.21484,-3.68652,0],0,1,0,[],"","",true,false], 
	["Land_vn_b_calochlaena_f",[0.769043,-10.478,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-8.56348,-7.71143,-0.00130129],45.0173,1,0,[],"","",true,false]
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
	//["vn_o_bicycle_02_vcmf",[-3.78467,-3.66162,0],261.273,1,0,[],"","",true,false], 
	
    _carData = [
    	[_car,[-3.78467,-3.66162,0],261.273,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_ChangeVehicleInventory;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
	
};



// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
	//["vn_o_nva_static_dshkm_high_01",[-6.46484,-5.46094,-0.0749998],227.322,1,0,[],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[-6.46484,-5.46094,0],227.322,1,0,[0,0],"","",true,false]
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

	//["Box_T_East_WpsSpecial_F",[2.31396,-0.727539,0],268.662,1,0,[],"","",true,false], 
	_boxType = a3e_AmmoDepotBox;
	    
	_ammoBoxData = [
		[_boxType,[2.31396,-0.727539,0],268.662,1,0,[0,0],"","",true,false]
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