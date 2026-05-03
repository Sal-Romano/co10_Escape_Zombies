if(!isserver) exitwith {};
params ["_centerPos","_ammoBoxClasses"];
private ["_object", "_pos", "_marker", "_instanceNo", "_randomNo", "_gun", "_statics", "_staticsData", "_angle", "_car", "_cars", "_carData", "_boxType", "_ammoBoxData", "_ammoBoxes", "_box"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];


// Ammo Boxes -------------------------------------------------------------------------------------------------------------

_ammoBoxDatas = [
	[selectRandom _ammoBoxClasses,[-2.32422,-1.01367,0.00320339],0,1,0,[],"","",true,false], 
	[selectRandom _ammoBoxClasses,[0.206543,-3.44531,0.00320339],0,1,0,[],"","",true,false], 
	[selectRandom _ammoBoxClasses,[3.12598,2.83447,0.00320339],224.647,1,0,[],"","",true,false]
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
	["Land_ClutterCutter_large_F",[-0.140137,0.207031,0],0,1,0,[],"","",true,false], 
	["Land_vn_sacks_heap_f",[2.48584,0.212891,0],268.281,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_01",[2.53125,-0.0366211,0],0,1,0,[],"","",true,false], 
	//["vn_o_ammobox_06",[-2.32422,-1.01367,0.00320339],0,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_03",[-2.63428,-0.129883,-0.259882],0,1,0,[],"","",true,false], 
	["Land_vn_garbageheap_02_f",[2.82861,-1.979,3.33786e-006],315.351,1,0,[],"","",true,false], 
	//["vn_o_ammobox_06",[0.206543,-3.44531,0.00320339],0,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[-3.59375,0.956543,0],269.826,1,0,[],"","",true,false], 
	["Land_vn_woodencrate_01_stack_x5_f",[-1.8999,-3.31689,0],0,1,0,[],"","",true,false], 
	["Land_vn_basket_f",[-3.18457,-2.2041,0],0,1,0,[],"","",true,false], 
	["Land_vn_bagfence_round_f",[-2.75098,3.04199,-0.00130129],168.584,1,0,[],"","",true,false], 
	//["vn_o_ammobox_06",[3.12598,2.83447,0.00320339],224.647,1,0,[],"","",true,false], 
	["Land_vn_woodencart_f",[0.168457,4.17285,0],356.279,1,0,[],"","",true,false], 
	["Land_vn_o_trapdoor_02",[4.09814,0.73877,0],0,1,0,[],"","",true,false]
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


