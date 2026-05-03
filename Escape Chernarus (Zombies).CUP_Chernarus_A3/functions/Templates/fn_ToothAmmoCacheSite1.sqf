if(!isserver) exitwith {};
params ["_centerPos","_ammoBoxClasses"];
private ["_object", "_pos", "_marker", "_instanceNo", "_randomNo", "_gun", "_statics", "_staticsData", "_angle", "_car", "_cars", "_carData", "_boxType", "_ammoBoxData", "_ammoBoxes", "_box"];


// Initial Setup -------------------------------------------------------------------------------------------------------------

private _rotateDir = random 360;
[_centerPos,5] call a3e_fnc_cleanupTerrain;
_spawnedObjects = [];


// Ammo Boxes -------------------------------------------------------------------------------------------------------------

_ammoBoxDatas = [
	[selectRandom _ammoBoxClasses,[-3.21484,-0.154297,0],0,1,0,[],"","",true,false], 
	[selectRandom _ammoBoxClasses,[2.49854,-3.25781,0],0,1,0,[],"","",true,false], 
	[selectRandom _ammoBoxClasses,[-3.18164,-2.79443,0],0,1,0,[],"","",true,false]
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
	["Land_ClutterCutter_large_F",[-0.0336914,0.130371,0],0,1,0,[],"","",true,false], 
	["Land_Garbage_square3_F",[-0.215332,1.43555,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[1.82666,1.47314,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[2.62549,-0.608887,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[2.4707,0.520996,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.11572,1.78662,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.4873,1.49707,0],176.973,1,0,[],"","",true,false], 
	["Land_WoodenBox_F",[2.64014,-1.4292,0],176.973,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[2.76318,1.78174,0],176.973,1,0,[],"","",true,false], 
	["Land_Pallets_stack_F",[0.130371,-3.40771,0],272.773,1,0,[],"","",true,false], 
	["MetalBarrel_burning_F",[2.2251,2.6084,0],0,1,0,[],"","",true,false], 
	["Land_Ammobox_rounds_F",[3.12109,1.52686,0],176.973,1,0,[],"","",true,false], 
	//["Box_FIA_Ammo_F",[-3.21484,-0.154297,0],0,1,0,[],"","",true,false], 
	["CargoNet_01_barrels_F",[-3.3335,1.86621,0],181.113,1,0,[],"","",true,false], 
	["Land_BagFence_Corner_F",[4.05078,1.90674,-0.000999928],0,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[4.01367,-0.243164,-0.000999928],269.519,1,0,[],"","",true,false], 
	["Land_BagFence_Round_F",[2.63916,3.53027,-0.00130129],216.535,1,0,[],"","",true,false], 
	//["Box_FIA_Ammo_F",[2.49854,-3.25781,0],0,1,0,[],"","",true,false], 
	//["Box_FIA_Ammo_F",[-3.18164,-2.79443,0],0,1,0,[],"","",true,false], 
	["Land_WoodenCart_F",[-3.38232,4.18506,0],106.603,1,0,[],"","",true,false]
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

_objArray
