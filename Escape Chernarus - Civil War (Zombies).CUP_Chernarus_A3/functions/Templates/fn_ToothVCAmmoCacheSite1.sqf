if(!isserver) exitwith {};
params ["_centerPos","_ammoBoxClasses"];
private ["_object", "_pos", "_marker", "_instanceNo", "_randomNo", "_gun", "_statics", "_staticsData", "_angle", "_car", "_cars", "_carData", "_boxType", "_ammoBoxData", "_ammoBoxes", "_box"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];


// Ammo Boxes -------------------------------------------------------------------------------------------------------------

_ammoBoxDatas = [
	[selectRandom _ammoBoxClasses,[-0.572266,-1.29395,0.00320339],0,1,0,[],"","",true,false], 
	[selectRandom _ammoBoxClasses,[1.70508,-2.99121,0.00320339],0,1,0,[],"","",true,false],
	[selectRandom _ammoBoxClasses,[2.10742,3.16406,0.00320339],224.647,1,0,[],"","",true,false]
];


_index = 0;
for "_i" from 1 to ([1,3] call BIS_fnc_randomInt) step 1 do {
	_ammoBoxData = [_ammoBoxDatas select _index];

	_boxArray = [_centerPos, _rotateDir, _ammoBoxData] call BIS_fnc_objectsMapper;
	_box = _boxArray select 0;

	if (!isNull _box) then
	{

		_weapons = [];
		_weaponMagazines = [];

		for "_i" from 0 to 3 do {
			private ["_gunItem", "_weaponClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
			
			_gunItem = selectRandom a3e_arr_AmmoDepotWeapons;
			
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

		for "_i" from 0 to 1 do {
			private ["_magItem", "_magClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];
			
			_magItem = selectRandom a3e_arr_AmmoDepotMags;
			
			_magClassName = _magItem select 0;
			_probabilityOfPrecence = _magItem select 1;
			_minCount = _magItem select 2;
			_maxCount = _magItem select 3;
			
			if (random 100 <= _probabilityOfPrecence) then {
				_magCount = floor (_minCount + random (_maxCount - _minCount));
				_weaponMagazines pushBack [_magClassName, _magCount];
				
			};
		};

		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearItemCargoGlobal _box;
		clearBackpackCargoGlobal _box;

		if (count _weapons > 0 || count _weaponMagazines > 0) then {
			{
				_box addWeaponCargoGlobal _x;
			} foreach _weapons;
			{
				_box addMagazineCargoGlobal _x;
			} foreach _weaponMagazines;
		};
	};

	_index = _index + 1;
};



// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["Land_ClutterCutter_large_F",[-0.0756836,-0.217285,0],0,1,0,[],"","",true,false], 
	["Land_vn_garbage_square3_f",[-0.45166,0.837402,0],0,1,0,[],"","",true,false], 
	//["vn_o_ammobox_06",[-0.572266,-1.29395,0.00320339],0,1,0,[],"","",true,false], 
	["Land_vn_hut_03",[-1.23779,0.828125,0],0,1,0,[],"","",true,false], 
	["Land_vn_sacks_goods_f",[1.41357,-0.844727,0],248.437,1,0,[],"","",true,false], 
	["Land_vn_sack_ep1",[2.26514,1.12598,0],267.202,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[-2.47803,-1.48633,0],269.826,1,0,[],"","",true,false], 
	["Land_vn_crateswooden_f",[-1.59668,2.51221,0],0,1,0,[],"","",true,false], 
	["Land_vn_bowl_ep1",[3.02881,-0.0283203,0],267.202,1,0,[],"","",true,false], 
	["Land_vn_c_prop_pot_fire_01",[2.98193,1.1748,0],267.202,1,0,[],"","",true,false], 
	//["vn_o_ammobox_06",[1.70508,-2.99121,0.00320339],0,1,0,[],"","",true,false], 
	["Land_vn_teapot_ep1",[3.50879,0.571289,0],356.725,1,0,[],"","",true,false], 
	["Land_vn_sacks_heap_f",[-3.69531,0.572266,0],268.281,1,0,[],"","",true,false]
	//["vn_o_ammobox_06",[2.10742,3.16406,0.00320339],224.647,1,0,[],"","",true,false]
];

_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;
_objArray append _spawnedObjects;

{
	if (!(_x isKindOf "House")) then
	{
		_x setVectorUp (surfaceNormal (position _x));
		_x enableDynamicSimulation true;
		[_x, 0, getPos _x, "ATL"] call BIS_fnc_setHeight;
	};
}
forEach _objArray;
