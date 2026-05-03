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
    //["RHS_Ural_MSV_01",[3.38745,-9.16943,0.2],0,1,0,[0,0],"","",true,false], 
    
    _carData = [
        [_car,[3.38745,-9.16943,0.2],0,1,0,[0,0],"","",true,false]
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

if (count _staticLowWeaponClasses > 0) then {
    //["uns_pk_bunker_low_VC",[-6.84033,0.32959,-0.0749998],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticLowWeaponClasses;
    
    _staticsData = [
        [_gun,[-6.84033,0.32959,-0.0749998],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
        [_x,_side] spawn A3E_fnc_AddStaticGunner;
        [_x] call a3e_fnc_onVehicleSpawn;
        _x setVectorUp surfaceNormal getPos _x;
        _objects pushBack gunner _x;
    } forEach _statics;

};
/*
if (count _staticHighWeaponClasses > 0) then {
    //["uns_dshk_high_VC",[7.88843,-0.533936,-0.0749998],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticHighWeaponClasses;
    
    _staticsData = [
        [_gun,[7.88843,-0.533936,-0.0749998],0,1,0,[0,0],"","",true,false]
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





// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
    //["uns_nvatruck_mg",[0,0,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_CncBarrier_F",[-3.48853,-0.685059,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_MetalBarrel_F",[-3.12354,-2.31104,0],0,1,0,[0,0],"","",true,false], 
    ["Land_CncBarrier_F",[-3.5127,1.94019,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_BagFence_Long_F",[4.46631,-1.10522,-0.000999928],90,1,0,[0,-0],"","",true,false], 
    ["Land_SandbagBarricade_01_F",[5.36206,1.11182,0],0,1,0,[0,0],"","",true,false], 
    ["Land_BagFence_Round_F",[-3.15576,-4.5293,-0.00130129],180,1,0,[0,0],"","",true,false], 
    //["uns_pk_bunker_low_VC",[-6.84033,0.32959,-0.0749998],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[6.6875,-2.75781,0],0,1,0,[0,0],"","",true,false], 
    ["Land_ClutterCutter_large_F",[-7.03955,-3.22754,0],0,1,0,[0,0],"","",true,false], 
    ["Land_SandbagBarricade_01_half_F",[7.69751,1.15234,0],0,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[-5.15649,-6.07764,0],90,1,0,[0,-0],"","",true,false], 
    //["uns_dshk_high_VC",[7.88843,-0.533936,-0.0749998],0,1,0,[0,0],"","",true,false], 
    //["Box_T_East_WpsSpecial_F",[7.09375,-4.21997,0],0,1,0,[0,0],"","",true,false], 
    ["Land_Razorwire_F",[-9.52612,3.28394,-2.38419e-006],0,1,0,[0,0],"","",true,false], 
    ["Land_WoodenBox_F",[8.33887,-2.19751,0],90,1,0,[0,-0],"","",true,false], 
    ["MetalBarrel_burning_F",[8.51025,-3.91675,0],0,1,0,[0,0],"","",true,false], 
    ["Land_SandbagBarricade_01_F",[9.4397,0.300537,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_SandbagBarricade_01_F",[9.44971,-2.14771,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_MetalBarrel_F",[-8.96533,-3.7002,0],0,1,0,[0,0],"","",true,false], 
    //["RHS_Ural_MSV_01",[3.38745,-9.16943,0.2],0,1,0,[0,0],"","",true,false], 
    ["Land_CncBarrier_F",[-10.1753,0.793701,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_CncBarrier_F",[-10.1968,-1.80396,0],90,1,0,[0,-0],"","",true,false], 
    ["Land_CncBarrier_F",[-10.1921,-4.40479,0],90,1,0,[0,-0],"","",true,false]
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
