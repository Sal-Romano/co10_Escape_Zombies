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
    //["RHS_Ural_MSV_01",[-5.37378,-7.30176,0.2],90.6703,1,0,[0,-0],"","",true,false], 
    
    _carData = [
        [_car,[-5.37378,-7.30176,0.2],90.6703,1,0,[0,0],"","",true,false]
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
    //["uns_pk_bunker_low_VC",[7.82129,0.262939,-0.0749998],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticLowWeaponClasses;
    
    _staticsData = [
        [_gun,[7.21558,0.325684,-0.0749998],0,1,0,[0,0],"","",true,false]
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
    ["Land_MetalBarrel_F",[4.12744,-1.61353,0],0,1,0,[0,0],"","",true,false], 
    ["MetalBarrel_burning_F",[-4.34131,1.19946,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Corner_F",[-3.71411,2.40356,-0.000999928],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Corner_F",[4.38208,2.64258,-0.000999928],270,1,0,[0,0],"","",true,false], 
    ["Land_MetalBarrel_F",[4.56885,-2.56738,0],0,1,0,[0,0],"","",true,false], 
    ["MetalBarrel_burning_F",[5.05298,-4.23657,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[-6.21729,2.46118,-0.000999928],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-7.02686,-0.145264,0],0,1,0,[0,0],"","",true,false], 
    //["uns_dshk_high_VC",[-7.02515,-0.264648,-0.0749998],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[7.61401,-0.618896,0],0,1,0,[0.419637,0],"","",true,false], 
    //["uns_pk_bunker_low_VC",[7.82129,0.262939,-0.0749998],0,1,0,[0,0],"","",true,false], 
    ["Land_Razorwire_F",[-9.72314,3.61279,-2.38419e-006],0,1,0,[0,0],"","",true,false], 
    //["RHS_Ural_MSV_01",[-5.37378,-7.30176,0.2],90.6703,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[-9.23315,2.43286,-0.000999928],0,1,0,[0,0],"","",true,false], 
    ["Land_Razorwire_F",[7.26001,4.02271,-2.38419e-006],0,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-10.0461,0.851074,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_WoodenBox_F",[-10.012,-1.38281,0],90,1,0,[0,-0],"","",true,false], 
    //["Box_T_East_WpsSpecial_F",[-9.94482,-3.41431,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Corner_F",[11.3425,2.55151,-0.000999928],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Long_F",[11.3464,0.351318,-0.000999928],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[11.3157,-2.62012,-0.000999928],90,1,0,[0,-0],"","",true,false], 
    ["Land_Razorwire_F",[-11.4385,-0.0402832,-2.38419e-006],90,1,0,[0,-0],"","",true,false], 
    ["Land_Razorwire_F",[12.6787,0.479492,-2.38419e-006],90,1,0,[0,-0],"","",true,false]
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
