params ["_centerPos", "_rotateDir", "_staticLowWeaponClasses", "_staticHighWeaponClasses", "_mannedVehicleClasses", "_side"];
private ["_objects", "_pos", "_vehicles", "_instanceNo", "_randomNo", "_gun", "_statics", "_staticsData", "_angle", "_car", "_cars", "_carData", "_crew",  "_boxType", "_ammoBoxData", "_ammoBoxes", "_box"];

[_centerPos,15] call a3e_fnc_cleanupTerrain;

_objects = [];
_pos = [];
_vehicles = [];
_return = [];


// Vehicles -------------------------------------------------------------------------------------------------------------


if (random 10 > 1 && count _mannedVehicleClasses > 0) then {
    _car = selectRandom _mannedVehicleClasses;
}
else {
    _car = "";
};

if (_car != "") then {
    //["RHS_Ural_MSV_01",[-6.84375,-7.34497,0.2],0,1,0,[0,0],"","",true,false], 
    
    _carData = [
        [_car,[-6.84375,-7.34497,0.2],0,1,0,[0,0],"","",true,false]
    ];

    _cars = [_centerPos, _rotateDir, _carData] call BIS_fnc_objectsMapper;

    {
        [_x] call a3e_fnc_ChangeVehicleInventory;
        [_x,_side] spawn A3E_fnc_AddStaticGunner;
        _objects pushBack _x;

        _crew = crew _x;
        {
            //_soldierType  = typeOf _x;
            //_init = [_soldierType,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
            //[_x, (compileFinal _init)] spawn BIS_fnc_spawn;
            _x spawn A3E_fnc_onEnemySoldierSpawn;
            _objects pushback _x;
        } forEach _crew;

    _vehicles pushBack _x;
    } forEach _cars;
    
};



// Statics -------------------------------------------------------------------------------------------------------------

/*
if (count _staticLowWeaponClasses > 0) then {
    //["uns_pk_bunker_low_VC",[6.04053,3.65527,-0.0749998],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticLowWeaponClasses;
    
    _staticsData = [
        [_gun,[6.04053,3.65527,-0.0749998],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,_side] spawn A3E_fnc_AddStaticGunner;
        [_x] call a3e_fnc_onVehicleSpawn;
        _x setVectorUp surfaceNormal getPos _x;
        _objects pushBack gunner _x;
    } forEach _statics;

};
*/
if (count _staticHighWeaponClasses > 0) then {
    //["uns_dshk_high_VC",[-7.02515,-0.264648,-0.0749998],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticHighWeaponClasses;
    
    _staticsData = [
        [_gun,[-7.02515,-0.264648,-0.0749998],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,_side] spawn A3E_fnc_AddStaticGunner;
        [_x] call a3e_fnc_onVehicleSpawn;
        _x setVectorUp surfaceNormal getPos _x;
        _objects pushBack gunner _x;
    } forEach _statics;
};





// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
    //["uns_nvatruck_mg",[0,0,0],90,1,0,[0,-0],"","",true,false], 
    ["MetalBarrel_burning_F",[4.18188,0.0305176,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Corner_F",[-3.71411,2.40356,-0.000999928],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[5.85938,0.550293,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[-6.21729,2.46118,-0.000999928],0,1,0,[0,0],"","",true,false], 
    //["uns_pk_bunker_low_VC",[6.04053,3.65527,-0.0749998],0,1,0,[0,0],"","",true,false], 
    //["uns_dshk_high_VC",[-7.02515,-0.264648,-0.0749998],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-7.24365,-0.933838,0],0,1,0,[0,0],"","",true,false], 
    ["Land_MetalBarrel_F",[7.11816,-1.59351,0],0,1,0,[0,0],"","",true,false], 
    ["Land_MetalBarrel_F",[7.01001,-2.53735,0],0,1,0,[0,0],"","",true,false], 
    //["Box_T_East_WpsSpecial_F",[6.26904,-4.15552,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[8.04126,-0.803223,-0.000999928],90,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenBox_F",[7.18066,-4.18921,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[8.0105,-3.77466,-0.000999928],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[-9.23315,2.43286,-0.000999928],0,1,0,[0,0],"","",true,false], 
    ["Land_Razorwire_F",[9.37354,-0.675049,-2.38419e-006],90,1,0,[0,-0],"","",true,false], 
    ["MetalBarrel_burning_F",[-9.6748,1.32617,0],0,1,0,[0,0],"","",true,false], 
    //["RHS_Ural_MSV_01",[-6.84375,-7.34497,0.2],0,1,0,[0,0],"","",true,false], 
    ["Land_Razorwire_F",[-11.4385,-0.0402832,-2.38419e-006],90,1,0,[0,-0],"","",true,false]
];


_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;

{
	_return pushBack _x;
} forEach _objArray;

{
	if (!(_x isKindOf "House")) then
	{
		_x setVectorUp (surfaceNormal (position _x));
		_x enableDynamicSimulation true;
        [_x, 0, getPos _x, "ATL"] call BIS_fnc_setHeight;
	};
}
forEach _objArray;

[_return,_vehicles];
