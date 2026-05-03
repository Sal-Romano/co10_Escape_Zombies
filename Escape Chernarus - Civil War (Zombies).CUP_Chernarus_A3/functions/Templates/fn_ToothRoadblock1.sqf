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
	//["RHS_Ural_MSV_01",[-4.83081,-8.8772,0.2],0,1,0,[0,0],"","",true,false], 
	
    _carData = [
    	[_car,[-4.83081,-8.8772,0.2],0,1,0,[0,0],"","",true,false]
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
	//["uns_pk_bunker_low_VC",[7.21558,0.325684,-0.0749998],0,1,0,[0,0],"","",true,false], 

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
/*
if (count _staticHighWeaponClasses > 0) then {
	//["uns_dshk_high_VC",[-6.2146,-0.919922,-0.0749998],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom _staticHighWeaponClasses;
    
	_staticsData = [
    	[_gun,[-6.2146,-0.919922,-0.0749998],0,1,0,[0,0],"","",true,false]
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
	["Land_BagFence_Corner_F",[-3.47437,2.9519,-0.000999928],0,1,0,[0,0],"","",true,false], 
	["MetalBarrel_burning_F",[-4.69238,-1.96338,0],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Corner_F",[4.38232,2.64282,-0.000999928],270,1,0,[0,0],"","",true,false], 
	["MetalBarrel_burning_F",[5.12085,-3.354,0],0,1,0,[0,0],"","",true,false], 
	//["uns_dshk_high_VC",[-6.2146,-0.919922,-0.0749998],0,1,0,[0,0],"","",true,false], 
	["Land_BagBunker_Small_F",[-6.42749,0.705322,0],180,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[-6.82446,-1.55005,0],0,1,0,[0,0],"","",true,false], 
	//["uns_pk_bunker_low_VC",[7.21558,0.325684,-0.0749998],0,1,0,[0,0],"","",true,false], 
	["Land_ClutterCutter_large_F",[7.05103,-1.54175,0],0,1,0,[-0.25793,0],"","",true,false], 
	["Land_Razorwire_F",[-9.7229,3.61304,-2.38419e-006],0,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[7.26025,4.02295,-2.38419e-006],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[9.43384,-3.87207,0],90,1,0,[0,-0],"","",true,false], 
	//["RHS_Ural_MSV_01",[-4.83081,-8.8772,0.2],0,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[10.3499,-4.23511,0],90,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Corner_F",[11.3428,2.55176,-0.000999928],0,1,0,[0,0],"","",true,false], 
	//["Box_T_East_WpsSpecial_F",[9.46216,-6.17603,0],90,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[11.3467,0.351563,-0.000999928],90,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[11.3159,-2.61987,-0.000999928],90,1,0,[0,-0],"","",true,false], 
	["Land_Razorwire_F",[-11.4382,-0.0400391,-2.38419e-006],90,1,0,[0,-0],"","",true,false], 
	["Land_Razorwire_F",[12.679,0.479736,-2.38419e-006],90,1,0,[0,-0],"","",true,false]
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
