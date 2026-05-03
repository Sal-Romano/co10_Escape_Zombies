//waituntil{!isNil("BIS_fnc_init")};
if(!isServer) exitwith {};
["Server started."] spawn a3e_fnc_debugmsg;
if(isNil("a3e_var_commonLibInitialized")) then {
	call compile preprocessFileLineNumbers "Scripts\DRN\CommonLib\CommonLib.sqf";
};


//Parse the parameters
call a3e_fnc_parameterInit;

execVM "initGridCachingSystem.sqf";


call compile preprocessFileLineNumbers "Scripts\Escape\Functions.sqf";
//call compile preprocessFileLineNumbers "Scripts\Escape\AIskills.sqf";

if(!isNil("A3E_Param_Debug")) then {
	if((A3E_Param_Debug)==0 && !(missionNamespace getVariable ["a3e_debug_overwrite",false])) then {
		A3E_Debug = false;
	} else {
		A3E_Debug = true;
		["Debug mode active!."] spawn a3e_fnc_debugmsg;
	};
} else {
	A3E_Debug = true;
	["Warning! Debug was set to true because of missing param!."] spawn a3e_fnc_debugmsg;
};
publicVariable "A3E_Debug";

//ACE Revive
AT_Revive_Camera = A3E_Param_ReviveView; //Needs to be stored on server now
ACE_MedicalServer = false;
if (isClass(configFile >> "CfgPatches" >> "ACE_Medical")) then {
	ACE_MedicalServer = true;
	["ace_unconscious", {params["_unit", "_isDown"]; [_unit,_isDown] spawn ACE_fnc_HandleUnconscious;}] call CBA_fnc_addEventHandler;
};
publicVariable "ACE_MedicalServer";

//Load Statistics
[] spawn A3E_fnc_LoadStatistics;



// Add crashsite here
//##############


private ["_villagePatrolSpawnArea","_EnemyCount","_enemyMinSkill", "_enemyMaxSkill", "_searchChopperSearchTimeMin", "_searchChopperRefuelTimeMin", "_enemySpawnDistance", "_playerGroup", "_enemyFrequency", "_scriptHandle"];

A3E_EnemyFrequency = 1;
[1] call A3E_fnc_GetEnemyCount;
_enemyFrequency = A3E_EnemyFrequency;
_enemySpawnDistance = (A3E_Param_EnemySpawnDistance);

[_enemyFrequency] call compile preprocessFileLineNumbers "Units\UnitClasses.sqf";

// prison is created locally, clients need flag texture path
publicVariable "A3E_VAR_Flag_Ind";

// Developer Variables
A3E_A3E_Param_ReducePlayerDamage = (["A3E_A3E_Param_ReducePlayerDamage",2] call BIS_fnc_getParamValue);
AT_Revive_PlayerDamage = 0.60;
if (A3E_Param_ReducePlayerDamage == 0) then
{
	AT_Revive_PlayerDamage = 1.0;
};
if (A3E_Param_ReducePlayerDamage == 1) then
{
	AT_Revive_PlayerDamage = 0.75;
};
if (A3E_Param_ReducePlayerDamage == 2) then
{
	AT_Revive_PlayerDamage = 0.60;
};
if (A3E_Param_ReducePlayerDamage == 3) then
{
	AT_Revive_PlayerDamage = 0.50;
};
if (A3E_Param_ReducePlayerDamage == 4) then
{
	AT_Revive_PlayerDamage = 0.40;
};
if (A3E_Param_ReducePlayerDamage == 5) then
{
	AT_Revive_PlayerDamage = 0.0;
};
publicVariable "AT_Revive_PlayerDamage";

switch (A3E_Param_ForceEnemyFlashlights) do
{
    case 0: // no flashlights
    {
        ForceFlashlights = false;
    };
    case 1: // force on flashlights
    {
    	ForceFlashlights = true;
    };
    default
    { 
        ForceFlashlights = false;
    };
};
publicVariable "ForceFlashlights";
missionNameSpace setVariable ["ForceFlashlights", false];

createCenter A3E_VAR_Side_Opfor;
createCenter A3E_VAR_Side_Ind;
createCenter A3E_VAR_Side_Civ;

if(isNil("A3E_Param_War_Torn")) then {
	A3E_Param_War_Torn = 0;
};
A3E_VAR_Side_Blufor setFriend [A3E_VAR_Side_Ind, 0];
A3E_VAR_Side_Ind setFriend [A3E_VAR_Side_Blufor, 0];

A3E_VAR_Side_Blufor setFriend [A3E_VAR_Side_Opfor, 0];
A3E_VAR_Side_Opfor setFriend [A3E_VAR_Side_Blufor, 0];
	
if(A3E_Param_War_Torn == 0) then {
	A3E_VAR_Side_Opfor Setfriend [A3E_VAR_Side_Ind, 1];
	A3E_VAR_Side_Ind setFriend [A3E_VAR_Side_Opfor, 1];
} else {
	A3E_VAR_Side_Opfor Setfriend [A3E_VAR_Side_Ind, 0];
	A3E_VAR_Side_Ind setFriend [A3E_VAR_Side_Opfor, 0];
};

private ["_hour","_earliest","_latest","_date","_sunriseSunsetTime","_sunRiseTime","_sunSetTime","_possibleTimes","_tempDate"];

_tempDate = date;
if (A3E_Param_UseCustomDate == 1) then
{
	_tempDate set [0,Tooth_year]; // set fixed year
	_tempDate set [1,Tooth_month]; // set fixed month
	_tempDate set [2,Tooth_day]; // set fixed day
}
else
{
	_tempDate set [0, Tooth_year]; // set fixed year no matter what
	_randomMonth = [1,12] call BIS_fnc_randomInt;
	_tempDate set [1, _randomMonth]; // set random month
	_tempDate set [2, [1,[Tooth_year,_randomMonth] call BIS_fnc_monthDays] call BIS_fnc_randomInt]; // set random day
};

// figure out hour based on sunrise and sunset
_sunriseSunsetTime = _tempDate call BIS_fnc_sunriseSunsetTime;
_sunRiseTime = _sunriseSunsetTime select 0;
_sunSetTime = _sunriseSunsetTime select 1;
_hour = (["A3E_Param_TimeOfDay",12] call BIS_fnc_getParamValue);
switch (A3E_Param_TimeOfDay) do {
    case 24: { // random
		_hour = round(random(24));
		_tempDate set [3,_hour]; // set hour
	};
    case 25: { // daytime
		//_randHour = 6+round(random(10));  //Between 0600 and 1600
		_hour = 0;
		_earliest = ceil _sunRiseTime;
		_latest = floor _sunSetTime;
		_hour = [_earliest, _latest] call BIS_fnc_randomInt;
		_tempDate set [3,_hour]; // set hour
	};
	case 26: { // nighttime
		//_hour = 17 + round(random(11)); //Between 1700 and 0400
		//_hour = _hour % 24;
		_hour = 0;
		_possibleTimes = [];
		_earliest = 0;
		_latest = floor _sunRiseTime;
		_possibleTimes pushBack ([_earliest, _latest] call BIS_fnc_randomInt);

		_earliest = ceil _sunSetTime;
		_latest = 23;
		_possibleTimes pushBack ([_earliest, _latest] call BIS_fnc_randomInt);
		
		_hour = selectRandom _possibleTimes;
		_tempDate set [3,_hour]; // set hour
	};
    default {
		_hour = A3E_Param_TimeOfDay;
		_tempDate set [3,_hour]; // set hour
	};
};
//_tempDate set [3,_hour]; // set hour
_tempDate set [4,0]; // set minute
[_tempDate] call bis_fnc_setDate;
[[], {setDate _tempDate}] remoteExec ["call",0,"JIP_id_setDate"];

sleep 0.1;

if (!(A3E_Param_UseCustomWeather == 1)) then
{
	[true] spawn A3E_fnc_weather;
	//[] spawn DRN_fnc_DynamicWeatherEffects;
};


setTimeMultiplier A3E_Param_TimeMultiplier;
call compile preprocessFileLineNumbers ("Island\CommunicationCenterMarkers.sqf");


// Game Control Variables, do not edit!

a3e_var_Escape_AllPlayersDead = false;
a3e_var_Escape_MissionComplete = false;
publicVariable "a3e_var_Escape_AllPlayersDead";
publicVariable "a3e_var_Escape_MissionComplete";

a3e_var_GrpNumber = 0;

A3E_Param_EnemySkill = (["A3E_Param_EnemySkill",2] call BIS_fnc_getParamValue);

_enemyMinSkill = 0.1;
_enemyMaxSkill = 0.2;

//Kudos to Semiconductor

switch (A3E_Param_EnemySkill) do { 
    // Convert value from params.hpp into acceptable range 
    case 0: { _enemyMinSkill = 0.02; _enemyMaxSkill = 0.05; }; 
    case 1: { _enemyMinSkill = 0.05; _enemyMaxSkill = 0.1; }; 
    case 2: { _enemyMinSkill = 0.1; _enemyMaxSkill = 0.2; }; 
    case 3: { _enemyMinSkill = 0.2; _enemyMaxSkill = 0.30; }; 
    case 4: { _enemyMinSkill = 0.40; _enemyMaxSkill = 0.50; }; 
    default { _enemyMinSkill = 0.1; _enemyMaxSkill = 0.2; }; 
}; 

a3e_var_Escape_enemyMinSkill = _enemyMinSkill; 
a3e_var_Escape_enemyMaxSkill = _enemyMaxSkill; 

_searchChopperSearchTimeMin = (5 + random 10);
_searchChopperRefuelTimeMin = (5 + random 10);


_villagePatrolSpawnArea = (A3E_Param_VillageSpawnCount);

drn_searchAreaMarkerName = "drn_searchAreaMarker";

//Getting exclusion zones
if(isNil("A3E_ExclusionZones")) then {
  A3E_ExclusionZones = [];
  {
    if("A3E_ExclusionZone" in _x && _x != "A3E_ExclusionZone_") then {
      A3E_ExclusionZones pushback _x;
	  if(!A3E_Debug) then {_x setMarkerAlpha 0;};
    };
  } foreach allMapMarkers;
};

// Choose a start position
if(isNil("A3E_ClearedPositionDistance")) then {
	A3E_ClearedPositionDistance = 500;
};

// Choose a start position near a town or village


_towns = nearestLocations [getPosATL center, ["NameVillage","NameCity","NameCityCapital","Strategic","CivilDefense","StrongpointArea","NameLocal"], 100000];
_randomTownPos = position (selectRandom _towns);
A3E_StartPos = [_randomTownPos,4.0,400,1000,0.1,10.0,4000] call A3E_fnc_findFlatAreaNearNew;
while {{A3E_StartPos inArea _x} count A3E_ExclusionZones > 0} do {
	_randomTownPos = position (selectRandom _towns);
	A3E_StartPos = [_randomTownPos,4.0,400,1000,0.1,10.0,4000] call A3E_fnc_findFlatAreaNearNew;
};
publicVariable "A3E_StartPos";


A3E_Var_ClearedPositions = [];
A3E_Var_ClearedPositions pushBack A3E_StartPos;
A3E_Var_ClearedPositions pushBack (getMarkerPos "drn_insurgentAirfieldMarker");

if(isNil("A3E_ClearedPositionDistance")) then {
	A3E_ClearedPositionDistance = 500;
};

private _backpack = [] call A3E_fnc_createStartpos;
A3E_PrisonBackpack = _backpack;
publicVariable "A3E_PrisonBackpack";












//### The following is a mission function now

[true] call drn_fnc_InitVillageMarkers; 
[true] call drn_fnc_InitAquaticPatrolMarkers; 

//Wait for players to actually arrive ingame. This may be a long time if server is set to persistent
waituntil{uisleep 1; count([] call A3E_FNC_GetPlayers)>0};

_playerGroup = [] call A3E_fnc_GetPlayerGroup;


[_enemyMinSkill, _enemyMaxSkill, _enemyFrequency, A3E_Debug] execVM "Scripts\Escape\EscapeSurprises.sqf";


// Initialize communication centers
[] call A3E_fnc_createComCenters;

// Initialize Motor Pools
private _UseMotorPools = A3E_Param_MotorPools;
if (_UseMotorPools == 1) then {
	[] call A3E_fnc_createMotorPools;
};


// Initialize armor defence at communication centers
[_playerGroup, a3e_var_Escape_communicationCenterPositions, _enemySpawnDistance, _enemyFrequency] call drn_fnc_Escape_InitializeComCenArmor;



// Initialize ammo depots
[_enemyMinSkill, _enemyMaxSkill, _enemySpawnDistance, _playerGroup, _enemyFrequency] spawn
{
	params ["_enemyMinSkill", "_enemyMaxSkill", "_enemySpawnDistance", "_playerGroup", "_enemyFrequency"];
	private ["_playerGroup", "_minEnemies", "_maxEnemies", "_bannedPositions", "_scriptHandle"];

	_bannedPositions = + a3e_var_Escape_communicationCenterPositions + [A3E_StartPos, getMarkerPos "drn_insurgentAirfieldMarker"];
	a3e_var_Escape_ammoDepotPositions = _bannedPositions call drn_fnc_Escape_FindAmmoDepotPositions;
	
	[] call A3E_fnc_createAmmoDepots;
};


// Initialize search leader
[drn_searchAreaMarkerName, A3E_Debug] execVM "Scripts\Escape\SearchLeader.sqf";

// Start garbage collector
[_playerGroup, _enemySpawnDistance, (5*60), A3E_Debug] spawn drn_fnc_CL_RunGarbageCollector;


// Run initialization for scripts that need the players to be gathered at the start position
[] spawn A3E_fnc_initVillages;

[_enemyMinSkill, _enemyMaxSkill, _enemySpawnDistance, _enemyFrequency] spawn {
	params ["_enemyMinSkill", "_enemyMaxSkill", "_enemySpawnDistance", "_enemyFrequency"];

    private ["_fnc_OnSpawnAmbientInfantryGroup", "_fnc_OnSpawnAmbientInfantryUnit", "_scriptHandle"];
    private ["_playerGroup", "_minEnemiesPerGroup", "_maxEnemiesPerGroup", "_fnc_OnSpawnGroup"];
    
    _playerGroup = [] call A3E_fnc_GetPlayerGroup;
        
	_fnc_OnSpawnGroup = {
		{
			_x spawn A3E_fnc_onEnemySoldierSpawn;
		} foreach units _this;
	};
	
	private _enemyCount = [1.5] call A3E_fnc_GetEnemyCount;
	_enemyCount params ["_minEnemies", "_maxEnemies"];
	[(units _playerGroup) select 0, A3E_VAR_Side_Opfor, a3e_arr_Escape_InfantryTypes, _minEnemies, _maxEnemies, 500000, _enemyMinSkill, _enemyMaxSkill, _enemySpawnDistance + 250, _fnc_OnSpawnGroup, A3E_Debug] call drn_fnc_InitAquaticPatrols;

    
   

    // Initialize ambient infantry groups

	_fnc_OnSpawnAmbientInfantryUnit = {
		_this spawn A3E_fnc_onEnemySoldierSpawn;
	};
	
	_fnc_OnSpawnAmbientInfantryGroup = {
		private ["_unit", "_enemyUnit"];
		private ["_scriptHandle"];
		
		_unit = units _this select 0;
		
		while {!(isNull _unit)} do {
			_enemyUnit = _unit findNearestEnemy (getPos _unit);
			if (!(isNull _enemyUnit)) exitWith {
				
				private _i = 0;
				for [{_i = (count waypoints _this) - 1}, {_i >= 0}, {_i = _i - 1}] do {
					deleteWaypoint [_this, _i];
				};
				
				_scriptHandle = [_this, drn_searchAreaMarkerName, (getPos _enemyUnit), A3E_Debug] spawn drn_fnc_searchGroup;
				_this setVariable ["drn_scriptHandle", _scriptHandle];
			};
			
			sleep 5;
		};
	};
	
	private ["_infantryGroupsCount", "_radius", "_groupsPerSqkm"];

	switch (_enemyFrequency) do
	{
		case 1: // 1-2 players
		{
			_groupsPerSqkm = 1;
		};
		case 2: // 3-5 players
		{
			_groupsPerSqkm = 1.2;
		};
		default // 6-8 players
		{
			_groupsPerSqkm = 1.4;
		};
	};

	private _enemyCount = [1.5] call A3E_fnc_GetEnemyCount;
	_enemyCount params ["_minEnemies", "_maxEnemies"];

	_radius = (_enemySpawnDistance + 500) / 1000;
	_infantryGroupsCount = round (_groupsPerSqkm * _radius * _radius * 3.141592);
	
	[_playerGroup, A3E_VAR_Side_Opfor, a3e_arr_Escape_InfantryTypes, _infantryGroupsCount, _enemySpawnDistance + 200, _enemySpawnDistance + 500, _minEnemies, _maxEnemies, _enemyMinSkill, _enemyMaxSkill, 750, _fnc_OnSpawnAmbientInfantryUnit, _fnc_OnSpawnAmbientInfantryGroup, A3E_Debug] spawn drn_fnc_AmbientInfantry;

    
    // Initialize the Escape military and civilian traffic
	private ["_vehiclesPerSqkm", "_radius", "_vehiclesCount", "_fnc_onSpawnCivilian"];
	
	// Civilian traffic
	
	switch (_enemyFrequency) do
	{
		case 1: // 1-3 players
		{
			_vehiclesPerSqkm = 3.6;
		};
		case 2: // 4-6 players
		{
			_vehiclesPerSqkm = 3.4;
		};
		default // 7-8 players
		{
			_vehiclesPerSqkm = 3.2;
		};
	};
	
	_radius = _enemySpawnDistance + 500;
	_vehiclesCount = round (_vehiclesPerSqkm * (_radius / 1000) * (_radius / 1000) * 3.141592);
	
	_fnc_onSpawnCivilian = {
		private ["_vehicle", "_crew"];
		_vehicle = _this select 0;
		_crew = _this select 1;
		//_vehiclesGroup = _result select 2;
		
		{
			{
				_x removeWeapon "ItemMap";
				_x unassignItem "ItemMap";
				_x removeItem "ItemMap";
				_x removeWeapon "vn_b_item_map";
				_x unassignItem "vn_b_item_map";
				_x removeItem "vn_b_item_map";
				_x removeWeapon "vn_o_item_map";
				_x unassignItem "vn_o_item_map";
				_x removeItem "vn_o_item_map";
			} foreach _crew; // foreach crew
			
			_x addeventhandler ["killed",{
				if ((_this select 1) in (call A3E_fnc_GetPlayers)) then {
					if((isNil("a3e_var_Escape_SearchLeader_civilianReporting"))||!a3e_var_Escape_SearchLeader_civilianReporting) then {
						a3e_var_Escape_SearchLeader_civilianReporting = true;
						publicVariable "a3e_var_Escape_SearchLeader_civilianReporting";
						(_this select 1) addScore -5;
					} else {
						(_this select 1) addScore -1;
					};
					(_this select 1) addRating 1000; //Even out the minus score by killing civilians
					[name (_this select 1) + " has killed a civilian."] call drn_fnc_CL_ShowCommandTextAllClients;
				};
				if (isClass(configFile >> "CfgPatches" >> "ACE_Medical")) then {
					_killer = (_this select 0) getVariable ["ace_medical_lastDamageSource", objNull];
					if (_killer in (call A3E_fnc_GetPlayers)) then {
						if((isNil("a3e_var_Escape_SearchLeader_civilianReporting"))||!a3e_var_Escape_SearchLeader_civilianReporting) then {
								a3e_var_Escape_SearchLeader_civilianReporting = true;
								publicVariable "a3e_var_Escape_SearchLeader_civilianReporting";
								(_killer) addScore -5;
							} else {
								(_killer) addScore -1;
							};
							(_killer) addRating 1000; //Even out the minus score by killing civilians
							[name (_killer) + " has killed a civilian."] call drn_fnc_CL_ShowCommandTextAllClients;
					};
				};
			}];
		} foreach _crew;
		
		clearitemcargoglobal _vehicle;
        clearWeaponCargoGlobal _vehicle;
        clearMagazineCargoGlobal _vehicle;			
		
		if (random 100 < 20) then {
			private ["_weaponItem"];
			
			_weaponItem = selectRandom a3e_arr_CivilianCarWeapons;
			
			_vehicle addWeaponCargoGlobal [_weaponItem select 0, 1];
			_vehicle addMagazineCargoGlobal [_weaponItem select 1, _weaponItem select 2];
		};	
		if (random 100 < 80) then {
           _vehicle addItemCargoglobal ["firstaidkit", 3];	
		};
		if (random 100 < 80) then {
           _vehicle addMagazineCargoglobal ["smokeshellRed", 2];	
		};
		if (random 100 < 80) then {
           _vehicle addMagazineCargoglobal ["Chemlight_green", 5];	
		};
	};
	
	[civilian, [], _vehiclesCount, _enemySpawnDistance, _radius, 0.5, 0.5, _fnc_onSpawnCivilian, A3E_Debug] spawn drn_fnc_MilitaryTraffic;

	
	// Enemy military traffic
	
	switch (_enemyFrequency) do
	{
		case 1: // 1-3 players
		{
			_vehiclesPerSqkm = 0.6;
		};
		case 2: // 4-6 players
		{
			_vehiclesPerSqkm = 0.8;
		};
		default // 7-8 players
		{
			_vehiclesPerSqkm = 1;
		};
	};
	
	_radius = _enemySpawnDistance + 500;
	_vehiclesCount = round (_vehiclesPerSqkm * (_radius / 1000) * (_radius / 1000) * 3.141592);
	[_vehiclesCount,_enemySpawnDistance,_radius,_enemyMinSkill, _enemyMaxSkill] spawn {
		params["_vehiclesCount","_enemySpawnDistance","_radius","_enemyMinSkill", "_enemyMaxSkill"];
		sleep 60*15; //Wait 15 Minutes before heavy vehicles may arrive 
		[A3E_VAR_Side_Opfor, [], _vehiclesCount/2, _enemySpawnDistance, _radius, _enemyMinSkill, _enemyMaxSkill, drn_fnc_Escape_TrafficSearch, A3E_Debug] spawn drn_fnc_MilitaryTraffic;
		[A3E_VAR_Side_Ind, [], _vehiclesCount/2, _enemySpawnDistance, _radius, _enemyMinSkill, _enemyMaxSkill, drn_fnc_Escape_TrafficSearch, A3E_Debug] spawn drn_fnc_MilitaryTraffic;
    };

	private ["_areaPerRoadBlock", "_maxEnemySpawnDistanceKm", "_roadBlockCount"];
	private ["_fnc_OnSpawnInfantryGroup", "_fnc_OnSpawnMannedVehicle"];
	
	_fnc_OnSpawnInfantryGroup = {{_x spawn A3E_fnc_onEnemySoldierSpawn;} foreach units _this;};
	_fnc_OnSpawnMannedVehicle = {{_x spawn A3E_fnc_onEnemySoldierSpawn;} foreach (_this select 1);};
	
	switch (_enemyFrequency) do {
		case 1: {
			_areaPerRoadBlock = 4.19;
		};
		case 2: {
			_areaPerRoadBlock = 3.14;
		};
		default {
			_areaPerRoadBlock = 2.5;
		};
	};
	
	_maxEnemySpawnDistanceKm = (_enemySpawnDistance + 500) / 1000;
	_roadBlockCount = round ((_maxEnemySpawnDistanceKm * _maxEnemySpawnDistanceKm * 3.141592) / _areaPerRoadBlock);
	
	if (_roadBlockCount < 1) then {
		_roadBlockCount = 1;
	};
	//A3E_VAR_Side_Ind
	[a3e_arr_Escape_InfantryTypes, a3e_arr_Escape_RoadBlock_MannedVehicleTypes, _fnc_OnSpawnInfantryGroup, _fnc_OnSpawnMannedVehicle, A3E_Debug] spawn A3E_fnc_RoadBlocks;

	//Spawn crashsites

	_maxCrashSites = missionNamespace getvariable["CrashSiteCountMax",3];
	//_minCrashSites = [(_maxCrashSites - 2), 1, _maxCrashSites] call BIS_fnc_clamp;
	//_crashSiteCount = [_minCrashSites, _maxCrashSites] call BIS_fnc_randomInt;
	for "_i" from 1 to _maxCrashSites step 1 do {
		_towns = nearestLocations [getPosATL center, ["Hill","SafetyZone","VegetationPalm","VegetationVineyard","VegetationBroadleaf","VegetationFir","RockArea","NameVillage","Name"], 100000];
		_randomTownPos = position (selectRandom _towns);
		_pos = [_randomTownPos,5.0,100,500,0.4,5.0,4000] call A3E_fnc_findFlatAreaNearNew;
		[_pos] call A3E_fnc_crashSite;
	};

	//Spawn mortar sites
	[] spawn A3E_fnc_createMortarSites;

	//Spawn artillery sites
	[] spawn A3E_fnc_createArtillerySites;

	//Spawn AAA sites
	[] spawn A3E_fnc_createAntiAircraftSites;
	
	//Spawn ammo caches
	[] spawn A3E_fnc_createAmmoCacheSites;

	//Spawn campsites
	[] spawn A3E_fnc_createCampsites;
	
};


// Create search chopper
if ((A3E_Param_SearchChopper < 3) || A3E_Debug) then
{
	private ["_scriptHandle"];
	_scriptHandle = [getMarkerPos "drn_searchChopperStartPosMarker", A3E_VAR_Side_Opfor, drn_searchAreaMarkerName, _searchChopperSearchTimeMin, _searchChopperRefuelTimeMin, _enemyMinSkill, _enemyMaxSkill, [], A3E_Debug] execVM "Scripts\Escape\CreateSearchChopper.sqf";
	waitUntil {scriptDone _scriptHandle};
};

/*
// add trackers instead of chopper
if ((A3E_Param_SearchChopper == 3 && A3E_Param_UseDLCSOGPF == 1 && A3E_Param_Trackers == 1) || A3E_Debug) then
{
	private ["_scriptHandle"];
	_scriptHandle = [drn_searchAreaMarkerName, 1200, A3E_Debug] execVM "Scripts\Escape\CreateTrackers.sqf";
	waitUntil {scriptDone _scriptHandle};
};
*/

// add motorized search instead of chopper
if ((A3E_Param_SearchChopper == 3) || A3E_Debug) then
{
	[_enemyFrequency, _enemyMinSkill, _enemyMaxSkill] spawn {
		params ["_enemyFrequency", "_enemyMinSkill", "_enemyMaxSkill"];
		waitUntil {([drn_searchAreaMarkerName] call drn_fnc_CL_MarkerExists)};
		_spawnSegment = [] call A3E_fnc_FindSpawnRoad;
		if(!isNull _spawnSegment) then
		{
			[getPos _spawnSegment, drn_searchAreaMarkerName, _enemyFrequency, _enemyMinSkill, _enemyMaxSkill, A3E_Debug] execVM "Scripts\Escape\CreateMotorizedSearchGroup.sqf";
		}
		else
		{
			diag_log "ESCAPE SURPRISE: Unable to find spawn road for Motorized Searchgroup";
		};
	};
};

// add ambient flybys
if ((A3E_Param_AmbientFlybys == 1) || A3E_Debug) then
{
	private ["_scriptHandle"];
	_vehicleArray = a3e_arr_extraction_chopper + a3e_arr_friendly_aircraft;
	_scriptHandle = [drn_searchAreaMarkerName, 4000, 200, "NORMAL", selectRandom _vehicleArray, A3E_VAR_Side_Blufor, [2,4] call BIS_fnc_randomInt, 1200, A3E_Debug] execVM "Scripts\Escape\CreateAmbientFlyby.sqf";
	waitUntil {scriptDone _scriptHandle};
};


// Spawn creation of start position settings
[A3E_StartPos, _backPack, _enemyFrequency] spawn {
	params ["_startPos", "_backPack", "_enemyFrequency"];
    private ["_guardGroup", "_marker", "_guardCount", "_guardGroups", "_unit", "_createNewGroup"];
    
	 
    // Spawn guard

	private _i = 0;	
	for [{_i = 0}, {_i < (_enemyFrequency*2)}, {_i = _i + 1}] do {
		private _weapon = a3e_arr_PrisonBackpackWeapons select floor(random(count(a3e_arr_PrisonBackpackWeapons)));
		_backpack addWeaponCargoGlobal[(_weapon select 0),1];
		_backpack addMagazineCargoGlobal[(_weapon select 1),3];
        {
          _array = _x;
          _item = _array select 0;
          _num = _array select 1;
          _backpack addItemCargoGlobal [_item, _num];
        } forEach a3e_arr_PrisonBackpackItems;
	};
	
    // Spawn more guards
    _marker = createMarkerLocal ["drn_guardAreaMarker", _startPos];
    _marker setMarkerAlphaLocal 0;
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerSizeLocal [50, 50];
    
    //_guardCount = (2 + (_enemyFrequency)) + floor (random 2);
	_enemyCount = [1.25] call A3E_fnc_GetEnemyCount;
	_enemyCount params ["_minEnemies", "_maxEnemies"];
	_guardCount = [_minEnemies, _maxEnemies] call BIS_fnc_randomInt;

    _guardGroups = [];
    _createNewGroup = true;
    
	for "_i" from 1 to _guardCount step 1 do
	{
    //for [{_i = 1}, {_i < _guardCount}, {_i = _i + 1}] do {
        private ["_pos"];
        
        _pos = [_marker] call drn_fnc_CL_GetRandomMarkerPos;
        while {_pos distance _startPos < 10} do {
            _pos = [_marker] call drn_fnc_CL_GetRandomMarkerPos;
        };
        
        if (_createNewGroup) then {
            _guardGroup = createGroup A3E_VAR_Side_Ind;
            _guardGroups set [count _guardGroups, _guardGroup];
            _createNewGroup = false;
        };
        
        //(a3e_arr_Escape_StartPositionGuardTypes select floor (random count a3e_arr_Escape_StartPositionGuardTypes)) createUnit [_pos, _guardGroup, "", (0.5), "CAPTAIN"];
        _unit = _guardGroup createUnit [(a3e_arr_Escape_StartPositionGuardTypes select floor (random count a3e_arr_Escape_StartPositionGuardTypes)), _pos, [], 0, "FORM"];
		_unit setVariable ["UseGrid", True]; //SALSET
		_unit spawn A3E_fnc_onEnemySoldierSpawn;

        if (count units _guardGroup >= 2) then {
            _createNewGroup = true;
        };
    };
    
    {
        _guardGroup = _x;
        
        _guardGroup setFormDir floor (random 360);
        
        {
            _unit = _x;
            _unit setUnitRank "CAPTAIN";
			_unit unlinkItem "ItemMap";
			_unit unlinkItem "vn_b_item_map";
			_unit unlinkItem "vn_o_item_map";
            _unit unlinkItem "vn_b_item_compass_sog";
			_unit unlinkItem "vn_b_item_compass";
			_unit unlinkItem "ItemCompass";
            _unit unlinkItem "ItemGPS";
			_unit unlinkItem "ItemRadio";
			_unit unlinkItem "vn_o_item_radio_m252";
			_unit unlinkItem "vn_b_item_radio_urc10";
			_unit removeWeaponGlobal "Binocular";
			_unit removeWeaponGlobal "ItemMap";
			_unit removeWeaponGlobal "vn_b_item_map";
			_unit removeWeaponGlobal "vn_o_item_map";
			_unit removeWeaponGlobal "ItemCompass";
			_unit removeWeaponGlobal "vn_b_item_compass";
			_unit removeWeaponGlobal "vn_b_item_compass_sog";
			_unit removeWeaponGlobal "ItemGPS";
			_unit removeWeaponGlobal "ItemRadio";
			_unit removeWeaponGlobal "vn_o_item_radio_m252";
			_unit removeWeaponGlobal "vn_b_item_radio_urc10";

			_unit removeItem "ItemMap";
			_unit removeItem "vn_b_item_map";
			_unit removeItem "vn_o_item_map";
            _unit removeItem "ItemCompass";
			_unit removeItem "vn_b_item_compass";
			_unit removeItem "vn_b_item_compass_sog";
            _unit removeItem "ItemGPS";
			_unit removeItem "ItemRadio";
			_unit removeItem "vn_o_item_radio_m252";
			_unit removeItem "vn_b_item_radio_urc10";
			_unit removeItem "FirstAidKit";
			_unit removeItem "vn_b_item_firstaidkit";
			_unit removeItem "vn_o_item_firstaidkit";

			for "_i" from 1 to 3 do {
				_unit removeMagazines "rhs_mag_rgd5";
				_unit removeMagazines "rhs_mag_rgn";
				_unit removeMagazines "rhs_mag_rgo";
				_unit removeMagazines "rhs_mag_rdg2_white";
				_unit removeMagazines "rhs_mag_rdg2_black";
				_unit removeMagazines "SmokeShellRed";
				_unit removeMagazines "SmokeShell";
				_unit removeMagazines "rhs_mag_nspn_yellow";
				_unit removeMagazines "rhs_grenade_mkii_mag";
				_unit removeMagazines "rhs_grenade_mkiiia1_mag";
				_unit removeMagazines "rhs_mag_f1";
				_unit removeMagazines "rhs_grenade_anm8_mag";
				_unit removeMagazines "vn_molotov_grenade_mag";
				_unit removeMagazines "vn_chicom_grenade_mag";
				_unit removeMagazines "vn_f1_grenade_mag";
				_unit removeMagazines "vn_m14_grenade_mag";
				_unit removeMagazines "vn_m14_early_grenade_mag";
				_unit removeMagazines "vn_m34_grenade_mag";
				_unit removeMagazines "vn_m61_grenade_mag";
				_unit removeMagazines "vn_m67_grenade_mag";
				_unit removeMagazines "vn_m7_grenade_mag";
				_unit removeMagazines "vn_rdg2_mag";
				_unit removeMagazines "vn_rg42_grenade_mag";
				_unit removeMagazines "vn_rgd33_grenade_mag";
				_unit removeMagazines "vn_rgd5_grenade_mag";
				_unit removeMagazines "vn_rkg3_grenade_mag";
				_unit removeMagazines "vn_m18_green_mag";
				_unit removeMagazines "vn_m18_purple_mag";
				_unit removeMagazines "vn_m18_red_mag";
				_unit removeMagazines "vn_m18_white_mag";
				_unit removeMagazines "vn_m18_yellow_mag";
				_unit removeMagazines "vn_t67_grenade_mag";
				_unit removeMagazines "vn_v40_grenade_mag";
			};

			if (ACE_MedicalServer) then {_unit addItem "ACE_epinephrine"};//Add Epinephrine for each unit
			removeBackpackGlobal _unit;
			
			if(random 100 < 80) then
			{
				removeAllPrimaryWeaponItems _unit;
				
			};
			private["_hmd","_nighttime"];
			_hmd = hmd _unit;
			// 0 = NVG not allowed, 1 = NVG allowed
            if ((random 100 > 20) || (A3E_Param_NVGs==0)) then
			{
				if(_hmd != "") then
				{
					_unit unlinkItem _hmd;
				};
            };

			if ((random 100 > 20) || (A3E_Param_NVScopes==0)) then
			{
				_primaryWeaponItems = primaryWeaponItems _unit;
				{
					if ( (_x in a3e_arr_NightScopes) || (_x in a3e_arr_TWSScopes)) then
					{
						_unit removePrimaryWeaponItem _x;
					};
				} forEach _primaryWeaponItems;
			};

			_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
			_sunRiseTime = _sunriseSunsetTime select 0;
			_sunSetTime = _sunriseSunsetTime select 1;
			// before sunrise or after sunset, it's night!
			_nighttime = false;
			if((daytime < _sunRiseTime) || (daytime > _sunSetTime) ) then
			{
				_nighttime = true;
			}
			else
			{
				_nighttime = false;
			};

			// maybe give them a flashlight if it's nighttime 
			if (_nighttime) then
			{
				_unit addPrimaryWeaponItem "rhs_acc_2dpZenit";
				_unit addPrimaryWeaponItem "rhs_acc_2dpZenit_ris";
				_unit addPrimaryWeaponItem "acc_flashlight";
				_hmd = hmd _unit;
				_unit unlinkItem _hmd;
				_unit enablegunlights "forceOn";
				_guardGroup enableGunLights "forceOn"; 
			};
			
			//This should remove all types of handgrenades and launchers (for example RHS)
            _unit removeMagazines "Handgrenade";
            
            _unit setVehicleAmmo 0.5 + random 0.5;

        } foreach units _guardGroup;
        
        [_guardGroup, _marker] spawn A3E_fnc_Patrol;
        
    } foreach _guardGroups;
        
	//Add an alert trigger to the prison
	A3E_fnc_revealPlayers = {
		private _guardGroup = _this;
		{
			_guardGroup reveal [_x,1.5];
		} foreach call A3E_fnc_GetPlayers;
	};
	A3E_fnc_soundAlarm = {
		params ["_guardGroups"];
		if(isNil("A3E_SoundPrisonAlarm")) then {
			A3E_SoundPrisonAlarm = true;
			publicvariable "A3E_SoundPrisonAlarm";
			{
				_x spawn A3E_fnc_revealPlayers;
			} foreach _guardGroups;
			sleep 30;
			A3E_SoundPrisonAlarm = false;
			publicvariable "A3E_SoundPrisonAlarm";
		};
	};
    // Start thread that waits for escape to start
    [_guardGroups] spawn {
        params ["_guardGroups"];
        
        sleep 5;
        
        while {isNil("A3E_EscapeHasStarted")} do {
			sleep 1;
            // If any member of the group is to far away from fence, then escape has started
            {
				if(_x getvariable ["A3E_PlayerInitializedServer",false]) then {
					if ((_x distance A3E_StartPos) > 15 && (_x distance A3E_StartPos) < 100) exitWith {
						A3E_EscapeHasStarted = true;
						publicVariable "A3E_EscapeHasStarted";
					};
					// If any player have picked up a weapon, escape has started
					if (count weapons _x > 0) exitWith {
						A3E_EscapeHasStarted = true;
						publicVariable "A3E_EscapeHasStarted";
					};
				};
            } foreach call A3E_FNC_GetPlayers;
        };
        
        // ESCAPE HAS STARTED
	   diag_log "Server: Escape has started.";
    };
	//Spawn alarm watchdog
	[_guardGroups] spawn {
		params ["_guardGroups"];
		while{isNil("A3E_SoundPrisonAlarm")} do {
			if(!isNil("A3E_EscapeHasStarted")) then {
				{
					private ["_guardGroup"];					
					_guardGroup = _x;
					{
						if((_guardGroup knowsAbout _x)>2.5) exitwith {
							[_guardGroups] call A3E_fnc_soundAlarm;
						};
					} foreach call A3E_fnc_GetPlayers;
				} foreach _guardGroups;
			};
			if(!isNil("A3E_PrisonGateObject")) then {
				if((A3E_PrisonGateObject animationPhase "Door_1_rot") > 0.5 ||
				(A3E_PrisonGateObject animationPhase "Door_2_rot") > 0.5) then {
					if(isNil("A3E_EscapeHasStarted")) then {
						A3E_EscapeHasStarted = true;
						publicVariable "A3E_EscapeHasStarted";
					};
					[_guardGroups] call A3E_fnc_soundAlarm;
				};
			};
			sleep 0.5;
		};
	};
	
	//Watch for captive state
	[] spawn {
		while{isNil("A3E_EscapeHasStarted")} do {
			{
				if(isNil("A3E_EscapeHasStarted") && !(captive _x)) then {
					[_x, true] remoteExec ["setCaptive", _x, false];
				};
			} foreach call A3E_fnc_GetPlayers;
			sleep 0.5;
		};
		{
			[_x, false] remoteExec ["setCaptive", _x, false];
		} foreach call A3E_fnc_GetPlayers;
	};
};

//Init trap spawning system for mines and other roadside surprises
[] spawn 
{
	waituntil{!isNil("A3E_CronProcesses")};
	call A3E_fnc_initTraps;
};


// --------------------------------------  START UP ARTILLERY
RydFFE_Debug = false;
RydFFE_ShellView = false;
RydFFE_Manual = false;
RydFFE_FO = [objNull];
RydFFE_FOClass = [
"vn_o_men_nva_65_27",
"vn_o_men_nva_65_15",
"vn_o_men_nva_65_01",
"vn_o_men_nva_65_13",
"vn_o_men_nva_15",
"vn_o_men_nva_27",
"vn_o_men_nva_13",
"vn_o_men_nva_01",
"vn_o_men_nva_dc_13",
"vn_o_men_nva_dc_01",
"vn_o_men_vc_regional_13",
"vn_o_men_vc_regional_01",
"vn_o_men_vc_13",
"vn_o_men_vc_01",
"vn_o_men_vc_local_27",
"vn_o_men_vc_local_13",
"vn_o_men_vc_local_01",
"vn_o_men_vc_local_15",
"vn_b_men_army_28",
"vn_b_men_army_01",
"vn_b_men_army_08",
"vn_b_men_army_02"
]; // if this array is set as not empty (even with objNull), limited spotting modebecomes active, so only members of groups, which names are inside this array or whichleaders are of proper class (see below), will have ability of spotting targets for batteries.
RydFFE_Monogamy = false;
RydFFE_Interval = 60;
RydFFE_Amount = 3;
RydFFE_Acc = 3.0;
RydFFE_Safe = 100.0;
RydFFE_Add_Other =
[
[["vn_o_nva_65_static_mortar_type63","vn_o_nva_static_mortar_type63","vn_o_nva_navy_static_mortar_type63","vn_o_vc_static_mortar_type63"],["vn_mortar_type63_mag_he_x8","vn_mortar_type63_mag_he_x8","vn_mortar_type63_mag_he_x8","vn_mortar_type63_mag_wp_x8","vn_mortar_type63_mag_lume_x8"]],
[["vn_o_nva_65_static_mortar_type53","vn_o_nva_static_mortar_type53","vn_o_nva_navy_static_mortar_type53","vn_o_vc_static_mortar_type53"],["vn_mortar_type53_mag_he_x8","vn_mortar_type53_mag_he_x8","vn_mortar_type53_mag_he_x8","vn_mortar_type53_mag_wp_x8","vn_mortar_type53_mag_lume_x8"]],
[["vn_o_nva_65_static_d44_01","vn_o_nva_static_d44_01","vn_o_nva_navy_static_d44_01","vn_o_vc_static_d44_01"],["vn_cannon_d44_mag_he_x12","vn_cannon_d44_mag_he_x12","vn_cannon_d44_mag_he_x12","vn_cannon_d44_mag_wp_x12","vn_cannon_d44_mag_lume_x12"]],
[["vn_b_army_static_mortar_m2","vn_b_sf_static_mortar_m2","vn_i_army_static_mortar_m2"],["vn_mortar_m2_mag_he_x8","vn_mortar_m2_mag_he_x8","vn_mortar_m2_mag_he_x8","vn_mortar_m2_mag_wp_x8","vn_mortar_m2_mag_lume_x8"]],
[["vn_b_army_static_mortar_m29","vn_b_sf_static_mortar_m29","vn_i_army_static_mortar_m29"],["vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_he_x8","vn_mortar_m29_mag_wp_x8","vn_mortar_m29_mag_lume_x8"]],
[["vn_b_army_static_m101_02","vn_b_sf_static_m101_02","vn_b_i_static_m101_02"],["vn_cannon_m101_mag_he_x8","vn_cannon_m101_mag_frag_x8","vn_cannon_m101_mag_he_x8","vn_cannon_m101_mag_wp_x8","vn_cannon_m101_mag_lume_x8"]]
];
[] execVM "RYD_FFE\FFE.sqf";

[] spawn 
{
	sleep 20.0;
	setTimeMultiplier (["A3E_Param_TimeMultiplier",6] call BIS_fnc_getParamValue);
};
