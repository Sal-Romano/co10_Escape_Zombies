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
    //["rhs_gaz66_ammo_msv",[4.31104,-7.02686,-4.76837e-007],273.913,1,0,[0,0],"","",true,false], 
	
    _carData = [
    	[_car,[4.31104,-7.02686,-4.76837e-007],273.913,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_ChangeVehicleInventory;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _cars;
	
};







// Statics -------------------------------------------------------------------------------------------------------------

if (count _staticWeaponClasses > 0) then {
	//["rhsgref_tla_DSHKM",[-0.730957,12.0876,-0.0749998],9.95873,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[-0.730957,12.0876,-0.0749998],9.95873,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};
/*
if (count _staticWeaponClasses > 0) then {
	//["rhsgref_tla_DSHKM",[6.5957,-11.8516,-0.0749998],187.461,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticWeaponClasses;
    
	_staticsData = [
    	[_gun,[6.5957,-11.8516,-0.0749998],187.461,1,0,[0,0],"","",true,false]
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

	//["Box_T_East_WpsSpecial_F",[2.92896,7.00903,0],180.889,1,0,[0,0],"","",true,false], 
	_boxType = a3e_AmmoDepotBox;
	    
	_ammoBoxData = [
		[_boxType,[2.92896,7.00903,0],180.889,1,0,[0,0],"","",true,false]
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
	["Land_CampingChair_V2_F",[0.175537,2.37036,0],172.363,1,0,[0,-0],"","",true,false], 
	["Land_CampingChair_V2_F",[1.0686,2.57861,0],172.363,1,0,[0,-0],"","",true,false], 
	["Land_MetalBarrel_F",[3.21753,-1.10474,0],271.738,1,0,[0,0],"","",true,false], 
	["Land_WoodenTable_large_F",[0.674072,3.45459,0],269.2,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[3.30151,2.29688,0],172.363,1,0,[0,-0],"","",true,false], 
	["Land_MetalBarrel_F",[4.08521,-0.994873,0],108.899,1,0,[0,-0],"","",true,false], 
	["Land_CampingChair_V2_F",[-0.346924,4.33545,0],5.13186,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[0.88501,4.29883,0],41.7691,1,0,[0,0],"","",true,false], 
	["Land_Pallets_F",[4.53857,-0.58667,0],0,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[4.28052,2.43018,0],164.545,1,0,[0,-0],"","",true,false], 
	["Land_WoodenTable_large_F",[3.89673,3.40576,0],269.2,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[2.93042,4.42798,0],269.2,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[-0.368408,-5.35718,0],0,1,0,[0,0],"","",true,false], 
	["Land_CampingChair_V2_F",[3.50171,4.50537,0],7.15434,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-5.74927,0.432129,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-5.7019,1.21167,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-5.78345,1.92505,0],0,1,0,[0,0],"","",true,false], 
	["Land_Pallets_stack_F",[6.63892,-0.566406,0],0,1,0,[0,0],"","",true,false], 
	["Land_Cargo20_sand_F",[6.03101,-2.95605,0],2.64339,1,0,[0,0],"","",true,false], 
	["Land_Pallets_stack_F",[6.83618,1.31787,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-6.8269,-1.47729,0],88.5494,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.936768,7.39795,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_Pallets_F",[6.45996,2.19116,0],0,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.19946,7.3894,0],89.2004,1,0,[0,0],"","",true,false], 
	["CargoNet_01_barrels_F",[-6.4729,-3.85718,0],0,1,0,[0,0],"","",true,false], 
	//["Box_T_East_WpsSpecial_F",[2.92896,7.00903,0],180.889,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.925537,7.82886,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.17163,7.81616,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_ShootingPos_Roof_01_F",[2.53906,7.51587,0],180.775,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[0.411865,8.07031,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-0.408447,8.08813,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-8.11011,-0.0939941,0],92.6167,1,0,[0,-0],"","",true,false], 
	["Land_Pallets_stack_F",[-4.24585,6.93628,0],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-1.55542,7.98608,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-7.95386,1.73877,0],0,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.920654,8.23853,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.16089,8.2522,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.43823,8.21069,0],89.2004,1,0,[0,0],"","",true,false], 
	//["rhs_gaz66_ammo_msv",[4.31104,-7.02686,-4.76837e-007],273.913,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-8.24194,-2.06226,0],0,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_open_full_F",[8.52759,-0.660889,0],91.247,1,0,[0,-0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.60986,1.01465,0],271.322,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[0.924561,8.66772,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.16138,8.65601,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.41821,8.67944,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-8.30591,3.5354,0],0,1,0,[0,0],"","",true,false], 
	["CargoNet_01_barrels_F",[-8.24243,-3.81714,0],0,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.67456,2.81152,0],2.9727,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[2.79907,8.95142,0],182.053,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-7.73853,5.27026,0],0,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.42944,8.42554,0],191.319,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.09204,8.9126,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_WoodenTable_02_large_F",[6.56812,7.2876,0],0,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.76001,4.52588,0],2.9727,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.9314,8.57959,0],211.443,1,0,[0,0],"","",true,false], 
	["Land_Ammobox_rounds_F",[4.36353,8.91724,0],89.2004,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-4.5083,8.99512,0],87.6046,1,0,[0,0],"","",true,false], 
	["Land_TBox_F",[-7.36621,-7.41626,0],269.467,1,0,[0,0],"","",true,false], 
	["Land_RoadBarrier_01_F",[2.95313,-9.89819,0],0,1,0,[0,0],"","",true,false], 
	["Land_LampShabby_F",[9.01807,-4.96387,0],278.514,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_pole_F",[4.84009,-9.70215,0],0,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.90112,6.29272,0],273.431,1,0,[0,0],"","",true,false], 
	["Land_GuardTower_02_F",[-7.52979,8.91724,0],0.728408,1,0,[0,0],"","",true,false], 
	["Land_Sign_noentry_big_en_pl_F",[4.04663,-10.3076,0],0,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[-9.73438,0.288086,-2.86102e-006],272.308,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[-10.1431,-9.72021,-2.86102e-006],272.308,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[10.2773,0.356934,-2.86102e-006],92.3398,1,0,[0,-0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[-9.38086,10.3508,-2.86102e-006],0,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[8.9939,8.04883,0],2.9727,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[0.635742,10.3457,-2.86102e-006],0,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_10m_F",[10.6919,10.365,-2.86102e-006],92.3398,1,0,[0,-0],"","",true,false], 
	//["rhsgref_tla_DSHKM",[-0.730957,12.0876,-0.0749998],9.95873,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_5m_F",[9.8689,-9.74048,1.43051e-006],180.032,1,0,[0,0],"","",true,false], 
	["Land_New_WiredFence_5m_F",[-5.1355,-9.7439,1.43051e-006],180.032,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-6.4314,-11.5303,-0.00130129],52.73,1,0,[0,0],"","",true,false], 
	[Tooth_enemyFlagPole,[-5.35645,-11.002,0],267.172,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-2.66943,13.2217,-0.00130129],118.25,1,0,[0,-0],"","",true,false], 
	//["rhsgref_tla_DSHKM",[6.5957,-11.8516,-0.0749998],187.461,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[0.133301,13.9285,-0.000999928],2.74467,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[5.8125,-13.7285,-0.000999928],180.247,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[8.58179,-12.8999,-0.00130129],295.752,1,0,[0,0],"","",true,false]
];


_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;













