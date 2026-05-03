params ["_centerPos"];
private["_gun","_staticsData","_statics","_objects","_marker","_marker","_rotateDir","_number"];
_rotateDir = random 360;


[_centerPos,50] call a3e_fnc_cleanupTerrain;



// Launcher / Gun -------------------------------------------------------------------------------------------------------------

if (count a3e_arr_AntiAircraftSiteLaunchers > 0) then {
	//["uns_sa2_static_NVA",[-0.316895,6.07275,-0.0749998],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom a3e_arr_AntiAircraftSiteLaunchers;
    
	_staticsData = [
    	[_gun,[-0.316895,6.07275,-0.0749998],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    	//[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};

// Radar -------------------------------------------------------------------------------------------------------------

if (count a3e_arr_AntiAircraftSiteRadars > 0) then {
	//["rhs_prv13",[-0.303955,-4.13184,0],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom a3e_arr_AntiAircraftSiteRadars;
    
	_staticsData = [
    	[_gun,[-0.303955,-4.13184,0],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    	[_x,A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner;
    } forEach _statics;

};


// Power Van -------------------------------------------------------------------------------------------------------------

if (count a3e_arr_AntiAircraftSiteVans > 0) then {
	//["rhs_2P3_2",[6.49829,-0.362305,0],0,1,0,[0,0],"","",true,false], 

    _gun = selectRandom a3e_arr_AntiAircraftSiteVans;
    
	_staticsData = [
    	[_gun,[6.49829,-0.362305,0],0,1,0,[0,0],"","",true,false]
    ];

    _statics = [_centerPos, _rotateDir, _staticsData] call BIS_fnc_objectsMapper;

    {
    	[_x] call a3e_fnc_onVehicleSpawn;
    } forEach _statics;

};




// All Other Objects -------------------------------------------------------------------------------------------------------------


_objects = 
[
	["MetalBarrel_burning_F",[-3.8894,-0.634521,0],0,1,0,[0,0],"","",true,false], 
	//["rhs_prv13",[-0.303955,-4.13184,0],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[4.31177,3.22607,-0.000999928],312.214,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-4.39258,3.14502,-0.000999928],226.559,1,0,[0,0],"","",true,false], 
	["MetalBarrel_burning_F",[5.45728,1.01733,0],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[4.36157,-3.48413,-0.000999928],45.9926,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-4.34277,-3.63501,-0.000999928],131.648,1,0,[0,-0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-5.71558,1.48926,0],181.113,1,0,[0,0],"","",true,false], 
	["Land_WoodenCrate_01_stack_x5_F",[-5.7666,-1.28955,0],181.113,1,0,[0,0],"","",true,false], 
	//["uns_sa2_static_NVA",[-0.316895,6.07275,-0.0749998],0,1,0,[0,0],"","",true,false], 
	//["rhs_2P3_2",[6.49829,-0.362305,0],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[4.22437,5.40234,-0.000999928],45.9926,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-4.47998,5.25146,-0.000999928],131.648,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[-4.25537,-5.74146,-0.000999928],226.559,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[4.44897,-5.6604,-0.000999928],312.214,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[2.30444,7.38232,-0.000999928],45.9926,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-2.53003,7.41162,-0.000999928],131.648,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[-2.35547,-7.7312,-0.000999928],226.559,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[2.479,-7.81079,-0.000999928],312.214,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[-7.86133,2.34912,-2.38419e-006],269.325,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[-7.72412,-6.53735,-2.38419e-006],269.325,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[9.09521,1.25586,-0.000999928],90,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[9.10229,-1.66455,-0.000999928],90,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[-0.257324,9.85449,-0.000999928],2.31409,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-0.0100098,-10.4519,-0.000999928],2.31409,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[10.429,-2.15308,-2.38419e-006],269.325,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[-6.27539,8.8457,-2.38419e-006],318.594,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[3.38672,11.3818,-2.38419e-006],36.5227,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[-5.97607,-9.42456,-2.38419e-006],36.5227,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[3.79175,-11.5906,-2.38419e-006],318.594,1,0,[0,0],"","",true,false]
];


_objArray = [_centerPos, _rotateDir, _objects] call BIS_fnc_objectsMapper;


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