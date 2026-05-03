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
    //["rhs_gaz66_ammo_msv",[-2.77954,2.71094,-4.76837e-007],40.9727,1,0,[0,0],"","",true,false], 
	
    _carData = [
    	[_car,[-2.77954,2.71094,-4.76837e-007],40.9727,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_ChangeVehicleInventory;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
	
};



// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
	//["rhsgref_tla_DSHKM",[8.24585,9.76367,-0.0749998],0.997294,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[8.24585,9.76367,-0.0749998],0.997294,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};
/*
if (count _staticWeaponClasses > 0) then {
	//["rhsgref_tla_DSHKM",[0.473877,-13.8542,-0.0749998],227.42,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[0.473877,-13.8542,-0.0749998],227.42,1,0,[0,0],"","",true,false]
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

	//["Box_T_East_WpsSpecial_F",[6.29565,-3.72095,0],268.662,1,0,[0,0],"","",true,false], 
	_boxType = a3e_AmmoDepotBox;
	    
	_ammoBoxData = [
		[_boxType,[6.29565,-3.72095,0],268.662,1,0,[0,0],"","",true,false]
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
	["Land_WoodenCrate_01_stack_x5_F",[-1.73999,-0.988281,0],273.73,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[0.00732422,-2.18042,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[2.04077,3.76099,-0.00130129],161.782,1,0,[0,-0],"","",true,false], 
	//["rhs_gaz66_ammo_msv",[-2.77954,2.71094,-4.76837e-007],40.9727,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-0.282227,-4.1084,0],181.113,1,0,[0,0],"","",true,false], 
	[Tooth_enemyFlagPole,[2.33032,2.88843,0],261.332,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[-4.54907,-2.99219,0],0,1,0,[0,0],"","",true,false], 
	["CargoNet_01_barrels_F",[-0.767822,-6.23267,0],181.113,1,0,[0,0],"","",true,false], 
	["CargoNet_01_barrels_F",[1.07642,-6.21533,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[6.60815,-1.71289,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[6.61011,-1.97534,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_ClutterCutter_large_F",[3.86182,5.77759,0],0,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[4.88306,-5.18042,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[7.10083,0.801758,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.03882,-1.68457,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[7.25562,-0.327881,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.03491,-1.93115,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_PaperBox_closed_F",[2.95605,-6.6731,0],177.434,1,0,[0,-0],"","",true,false], 
	//["Box_T_East_WpsSpecial_F",[6.29565,-3.72095,0],268.662,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[7.27026,-1.14819,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_CampingChair_V2_F",[-4.37573,-6.19019,0],97.9758,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[7.3479,2.05884,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.448,-1.66382,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.47046,-1.90356,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.4397,-2.18213,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[7.28003,2.77368,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[-6.07373,4.95557,0],0,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[7.27905,-3.12695,0],0,1,0,[0,0],"","",true,false], 
	["Land_IndFnc_Pole_F",[-0.153564,7.80005,0],0,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.8772,-1.65063,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.87476,-1.8877,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[7.34253,3.55225,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.90845,-2.14355,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_Sign_noentry_big_en_pl_F",[-0.593262,8.30957,0],182.61,1,0,[0,0],"","",true,false], 
	["Land_Net_Fence_Gate_F",[7.96802,7.71265,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[0.23291,-8.48584,0],0.377776,1,0,[0,0],"","",true,false], 
	["Land_Cargo_Patrol_V2_F",[-4.50439,-6.70557,0],0,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[2.15527,-8.58325,0],179.544,1,0,[0,-0],"","",true,false], 
	["Land_WoodenBox_F",[8.24341,-3.49927,0],269.826,1,0,[0,0],"","",true,false], 
	["Land_IndFnc_9_F",[-7.65356,7.77759,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[7.46729,5.45117,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.77124,-5.1626,0],279.092,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[3.92773,-8.60425,0],269.085,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[8.24487,-4.8064,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_IndFnc_9_F",[8.84619,6.37744,0],90,1,0,[0,-0],"","",true,false], 
	["Land_Ammobox_rounds_F",[8.2605,-5.07715,0],176.973,1,0,[0,-0],"","",true,false], 
	["Land_IndFnc_9_F",[-9.07568,0.208008,0],270,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[7.94507,-5.65771,0],299.216,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-2.79907,9.62061,-0.000999928],177.981,1,0,[0,-0],"","",true,false], 
	["Land_Pallets_stack_F",[7.47583,-6.72632,0],272.773,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[7.64136,6.8855,0],179.828,1,0,[0,-0],"","",true,false], 
	["Land_PaperBox_closed_F",[5.64404,-8.57324,0],269.085,1,0,[0,0],"","",true,false], 
	["Land_WoodenTable_large_F",[-7.32593,-7.26123,0],2.04411,1,0,[0,0],"","",true,false], 
	["Land_IndFnc_9_F",[8.81885,-2.5918,0],90,1,0,[0,-0],"","",true,false], 
	["Land_IndFnc_Corner_F",[7.43506,7.7959,0],356.556,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[-8.38354,-6.70996,0],265.207,1,0,[0,0],"","",true,false], 
	["Land_IndFnc_9_F",[-9.04883,-8.73682,0],270,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-10.7832,1.1106,-0.000999928],268.462,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[10.6721,1.99146,-0.000999928],269.519,1,0,[0,0],"","",true,false], 
	["Land_LampShabby_F",[-8.04492,6.86597,0],131.197,1,0,[0,-0],"","",true,false], 
	["Land_IndFnc_9_F",[7.35425,-10.1421,0],180,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-5.76782,9.51611,-0.000999928],177.981,1,0,[0,-0],"","",true,false], 
	["Land_IndFnc_9_F",[-1.57983,-10.144,0],180,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[-8.21997,-7.6123,0],265.207,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-10.6445,-3.76416,-0.000999928],89.0273,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[10.8098,-3.46411,-0.000999928],89.6182,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-10.8389,4.07593,-0.000999928],268.462,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[10.6472,4.96216,-0.000999928],269.519,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-2.2876,-11.905,-0.000999928],179.508,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[2.65283,-11.8096,-0.000999928],359.137,1,0,[0,0],"","",true,false], 
	["Land_LampShabby_F",[7.68701,-9.00195,0],309,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[10.8069,-6.43091,-0.000999928],89.6182,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-10.5938,-6.73267,-0.000999928],89.0273,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-8.7688,9.39551,-0.000999928],177.981,1,0,[0,-0],"","",true,false], 
	//["rhsgref_tla_DSHKM",[8.24585,9.76367,-0.0749998],0.997294,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-10.9102,7.01221,-0.000999928],268.462,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-5.24707,-11.9065,-0.000999928],179.508,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[5.62256,-11.7659,-0.000999928],359.137,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[10.6106,7.96851,-0.000999928],269.519,1,0,[0,0],"","",true,false], 
	//["rhsgref_tla_DSHKM",[0.473877,-13.8542,-0.0749998],227.42,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Corner_F",[-10.9209,9.37769,-0.000999928],268.462,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Corner_F",[10.6477,10.1187,-0.000999928],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[10.8186,-9.36792,-0.000999928],89.6182,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-10.5283,-9.73511,-0.000999928],89.0273,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-8.18408,-11.9238,-0.000999928],179.508,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[8.62549,-11.7058,-0.000999928],359.137,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[9.23584,11.7419,-0.00130129],216.535,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Corner_F",[-10.5461,-11.8887,-0.000999928],179.508,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Corner_F",[10.7788,-11.728,-0.000999928],89.6182,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[0.26123,-15.885,-0.000999928],179.508,1,0,[0,-0],"","",true,false]
];


_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;
