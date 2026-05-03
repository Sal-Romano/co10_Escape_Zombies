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
    //["rhs_gaz66_ammo_msv",[-7.03711,0.290283,-4.76837e-007],0.430625,1,0,[0,0],"","",true,false], 

	
    _carData = [
    	[_car,[-7.03711,0.290283,-4.76837e-007],0.430625,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_ChangeVehicleInventory;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
	
};





// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
	//["rhsgref_tla_DSHKM",[-0.244629,9.69873,-0.0749998],0.997294,1,0,[0,0],"","",true,false],

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[-0.244629,9.69873,-0.0749998],0.997294,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};
/*
if (count _staticWeaponClasses > 0) then {
	//["rhsgref_tla_DSHKM",[-10.2974,9.23877,-0.0749998],320.598,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[-10.2974,9.23877,-0.0749998],320.598,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;
};
*/


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

	//["Box_T_East_WpsSpecial_F",[0.958008,1.16382,0],93.6625,1,0,[0,-0],"","",true,false], 
	_boxType = a3e_AmmoDepotBox;
	    
	_ammoBoxData = [
		[_boxType,[0.958008,1.16382,0],93.6625,1,0,[0,0],"","",true,false]
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
	["Land_Ammobox_rounds_F",[-0.312012,-0.268555,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.0693359,-0.553955,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.366699,-0.543457,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.496582,-0.546875,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.0444336,-0.799072,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.78125,-0.266113,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.365234,-0.78418,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.77002,-0.523926,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.475586,-0.808594,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.792969,-0.76001,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-0.208496,-1.31104,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-0.973145,1.11597,0],94.8265,1,0,[0,-0],"","",true,false], 
	//["Box_T_East_WpsSpecial_F",[0.958008,1.16382,0],93.6625,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[-0.265625,-2.12939,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.884277,2.41577,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.382324,2.72949,0],104.092,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.875977,2.68701,0],1.97365,1,0,[0,0],"","",true,false], 
	["CamoNet_BLUFOR_open_F",[0.236084,-2.88135,0],272.525,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[-0.51123,3.23779,0],124.216,1,0,[0,-0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-0.231934,-3.27051,0],1.97365,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[2.34717,-2.52905,0],0,1,0,[0,0],"","",true,false], 
	["Land_Pallets_stack_F",[0.682617,-6.00464,0],272.773,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-1.38257,-6.1709,0],0.377776,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[6.77246,0.978271,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[6.84033,0.263428,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[6.88892,-0.959717,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[6.83496,1.75684,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[6.64404,-2.71655,0],273.73,1,0,[0,0],"","",true,false], 
	//["rhs_gaz66_ammo_msv",[-7.03711,0.290283,-4.76837e-007],0.430625,1,0,[0,0],"","",true,false], 
	["Land_MetalBarrel_F",[-1.80176,7.62939,0],52.0865,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[0.712158,-7.97534,0],269.085,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[-1.00415,-8.00635,0],269.085,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[6.73755,-4.50464,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_MetalBarrel_F",[-2.71045,7.74927,0],108.899,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[5.45361,-6.15576,0],269.663,1,0,[0,0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[0.672607,8.2439,0],180,1,0,[0,0],"","",true,false], 
	["Land_TBox_F",[6.00464,5.96875,0],90.5803,1,0,[0,-0],"","",true,false], 
	["Land_PaperBox_closed_F",[2.50903,-7.91821,0],177.434,1,0,[0,-0],"","",true,false], 
	[Tooth_enemyFlagPole,[0.420898,7.34058,0],261.332,1,0,[0,0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[8.38696,-1.90234,0],270,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[-2.77661,-7.98535,0],179.544,1,0,[0,-0],"","",true,false], 
	["Land_LampShabby_F",[7.39575,2.80103,0],270.465,1,0,[0,0],"","",true,false], 
	["Land_MetalBarrel_F",[4.25049,7.68213,0],108.899,1,0,[0,-0],"","",true,false], 
	["Land_CampingChair_V2_F",[-6.57617,-6.44824,0],41.7691,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[6.88403,-6.24609,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[-9.53491,0.367188,0],90,1,0,[0,-0],"","",true,false], 
	["Land_Sign_noentry_big_en_pl_F",[-3.01514,9.16748,0],178.621,1,0,[0,-0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[-1.65796,-9.71899,0],0,1,0,[0,0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[8.38013,4.04932,0],270,1,0,[0,0],"","",true,false], 
	//["rhsgref_tla_DSHKM",[-0.244629,9.69873,-0.0749998],0.997294,1,0,[0,0],"","",true,false], 
	["CargoNet_01_barrels_F",[5.29688,-8.34619,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[6.45044,8.27124,0],180,1,0,[0,0],"","",true,false], 
	["Land_WoodenTable_large_F",[-6.78711,-7.29248,0],269.2,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[-7.80811,-6.41162,0],5.13186,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[-6.39258,-8.16846,0],172.363,1,0,[0,-0],"","",true,false], 
	["Land_WoodenShelter_01_F",[-7.00171,-7.58862,-0.864592],0,1,0,[0,0],"","",true,false], 
	["Land_Net_Fence_Gate_F",[-1.43018,8.30029,0],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[0.633789,10.9973,-0.00130129],223.355,1,0,[0,0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[8.38599,-7.83154,0],270,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-1.9187,11.0708,-0.00130129],132.006,1,0,[0,-0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[-9.54761,6.38867,0],90,1,0,[0,-0],"","",true,false], 
	["CargoNet_01_barrels_F",[7.14111,-8.32886,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[4.32837,-9.7124,0],0,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[-7.28564,-8.37671,0],172.363,1,0,[0,-0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[-9.52417,-5.60254,0],90,1,0,[0,-0],"","",true,false], 
	["Land_Wall_IndCnc_4_F",[-7.64185,-9.72095,0],0,1,0,[0,0],"","",true,false], 
	//["rhsgref_tla_DSHKM",[-10.2974,9.23877,-0.0749998],320.598,1,0,[0,0],"","",true,false], 
	["MetalBarrel_burning_F",[-9.61377,11.428,0],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-12.4526,8.80225,-0.00130129],75.3499,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-11.0186,10.9534,-0.00130129],166.699,1,0,[0,-0],"","",true,false]
];


_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;













