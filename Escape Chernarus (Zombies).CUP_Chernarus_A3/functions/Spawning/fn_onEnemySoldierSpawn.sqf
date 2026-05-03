private["_nighttime","_timeNum","_sunriseSunsetTime","_sunRiseTime","_sunSetTime","_init"];
//params["_unit"];
_unit = _this;

//diag_log format ["onEnemySoldierSpawn run for %1 ", _unit];

if (isNull _unit) exitWith
{
    diag_log format["onEnemySoldierSpawn _unit is null!!!!"];
};

_type =  typeOf _unit;
_init = [_type,missionNameSpace getVariable ["ForceFlashlights", false]] call ToothFunctions_fnc_getunitloadout;
sleep 0.2;
_handle = [_unit, (compileFinal _init)] spawn BIS_fnc_call;
waitUntil { sleep 0.2; scriptDone _handle;};

_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
_sunRiseTime = _sunriseSunsetTime select 0;
_sunSetTime = _sunriseSunsetTime select 1;
// before sunrise or after sunset, it's night!
_nighttime = false;
if((daytime < _sunRiseTime) || (daytime > _sunSetTime) ) then {
	_nighttime = true;
} else {
	_nighttime = false;
};

_aiSkillBase = 0.5;
switch (A3E_Param_EnemySkill) do
{
    case 0: //conscript very low skill
    {
        _aiSkillBase = 0.2; // 0.07
    };
    case 1: //rebels low skill
    {
        _aiSkillBase = 0.3; // 0.11
    };
    case 2: //regular fair skill
    {
        _aiSkillBase = 0.4; // 0.15
    };
    case 3: //elite soldiers medium skill
    {
        _aiSkillBase = 0.5; // 0.2
    };
    case 4: // specops good skill
    {
        _aiSkillBase = 0.6; // 0.4
    };
    default
    { 
        _aiSkillBase = 0.4;
    };
};

_unit setskill _aiSkillBase;                                // 0=0.20, 1=0.50
_unit setskill ["general",          [(_aiSkillBase * 2.0), 0.0, 1.0] call BIS_fnc_clamp];  // 0=0.20, 1=0.50
_unit setskill ["aimingAccuracy",   [(_aiSkillBase * 0.8), 0.0, 1.0] call BIS_fnc_clamp];  // 0=0.04, 1=0.10
_unit setskill ["aimingShake",      [(_aiSkillBase * 0.8), 0.0, 1.0] call BIS_fnc_clamp];  // 0=0.04, 1=0.10
_unit setskill ["aimingSpeed",      [(_aiSkillBase * 1.5), 0.0, 1.0] call BIS_fnc_clamp];  // used to be 0.4 0=0.08, 1=0.20
_unit setskill ["endurance",        [(_aiSkillBase * 2.0), 0.0, 1.0] call BIS_fnc_clamp];  // 0=0.20, 1=0.50
_unit setskill ["spotDistance",     [(_aiSkillBase * 0.8), 0.0, 1.0] call BIS_fnc_clamp];  // used to be 0.8 0=0.03, 1=0.075
_unit setskill ["spotTime",         [(_aiSkillBase * 1.8), 0.0, 1.0] call BIS_fnc_clamp];  // used to be 1.5 0=0.06, 1=0.15
_unit setskill ["courage",          [(_aiSkillBase * 2.0), 0.0, 1.0] call BIS_fnc_clamp];  // 0=0.20, 1=0.50 
_unit setskill ["reloadSpeed",      [(_aiSkillBase * 2.0), 0.0, 1.0] call BIS_fnc_clamp];  // 0=0.16, 1=0.40
_unit setskill ["commanding",       [(_aiSkillBase * 2.0), 0.0, 1.0] call BIS_fnc_clamp];  // 0=0.15, 1=0.375

/*
_general         = _unit skillFinal "general";
_aimingspeed     = _unit skillFinal "aimingspeed";
_spotdistance    = _unit skillFinal "spotdistance";
_aimingaccuracy  = _unit skillFinal "aimingaccuracy"; 
_aimingshake     = _unit skillFinal "aimingshake"; 
_spottime        = _unit skillFinal "spottime";
_commanding      = _unit skillFinal "commanding"; 
_reloadspeed     = _unit skillFinal "reloadspeed";
_courage         = _unit skillFinal "courage";
_endurance       = _unit skillFinal "endurance";
*/
//diag_log format ["A3E_fnc_onEnemySoldierSpawn set skill for %12 to _aiSkillBase: %13 _general: %1 _aimingspeed: %2 _spotdistance: %3 _aimingaccuracy: %4 _aimingshake: %5 _spottime: %6 _commanding: %7 _general: %8 _reloadspeed: %9 _courage: %10 _endurance: %11",_general,_aimingspeed,_spotdistance,_aimingaccuracy,_aimingshake,_spottime,_commanding,_general,_reloadspeed,_courage,_endurance,_unit,_aiSkillBase];

_unit removeItem "FirstAidKit";
_unit removeItem "vn_b_item_firstaidkit";
_unit removeItem "vn_o_item_firstaidkit";

_unit setVehicleAmmo 0.6 + random 0.4;

private["_nvgs","_primaryWeapon","_primaryWeaponItems","_nvScope","_twsScope"];
private["_scope","_pointer"];

// get primary weapon info then remove all items
_primaryWeapon = primaryWeapon _unit;
_primaryWeaponItems = primaryWeaponItems _unit;
_scope = (_primaryWeaponItems select 2);
_pointer = (_primaryWeaponItems select 1);
removeAllPrimaryWeaponItems _unit;

// Param_NVScopes
// 0 = No NV or TW Scopes, 1 = NV Scopes allowed, 2 = NV and TWS Scopes Allowed
private["_scopeIsNV","_scopeIsTWS"];

_scopeIsNV = false;
// if scope exists and is in a3e_arr_NightScopes, it's a NV scope
if ( !(_scope == "") ) then
{
	if (_scope in a3e_arr_NightScopes) then
	{
		_scopeIsNV = true;
	};
};

_scopeIsTWS = false;
// if scope exists and is in a3e_arr_TWSScopes, it's a NV scope
if ( !(_scope == "") ) then
{
	if (_scope in a3e_arr_TWSScopes) then
	{
		_scopeIsTWS = true;
	};
};

// if scope is NV and allowed, add it back to the gun
if (_scopeIsNV && (A3E_Param_NVScopes > 0)) then
{
	_unit addPrimaryWeaponItem _scope;
};

// if scope is TWS and allowed, add it back to the gun
if (_scopeIsTWS && (A3E_Param_NVScopes > 1)) then
{
	_unit addPrimaryWeaponItem _scope;
};

// if they have no NV or TWS scope, maybe give them a flashlight if it's nighttime 
if ((((primaryWeaponItems _unit) select 2) == "") && ((_nighttime) && (random 100 < 20)) ) then
{
	_unit addPrimaryWeaponItem "acc_flashlight";
	_hmd = hmd _unit;
	_unit unlinkItem _hmd;
};

// if scope is not NV or TWS, add it back on the gun
if (!(_scopeIsNV) && !(_scopeIsTWS)) then
{
	_unit addPrimaryWeaponItem _scope;
};

// 10% Chance for a random scope, or no scope
if(random 100 < 10) then {
	removeAllPrimaryWeaponItems _unit;
	if((random 100 < 50)) then {
		_scopes = A3E_arr_Scopes;
		if(A3E_Param_NVScopes > 1) then {
			_scopes = _scopes + A3E_arr_TWSScopes;
		};
		if(A3E_Param_NVScopes > 0) then {
			_scopes = _scopes + a3e_arr_NightScopes;
		};
		_addScope = selectRandom _scopes;
		_unit addPrimaryWeaponItem _addScope;
	};
};

_newPrimaryWeaponItems = primaryWeaponItems _unit;
_scope = (_newPrimaryWeaponItems select 2);

_scopeIsNV = false;
// if scope exists and is in a3e_arr_NightScopes, it's a NV scope
if ( !(_scope == "") ) then
{
	if (_scope in a3e_arr_NightScopes) then
	{
		_scopeIsNV = true;
	};
};

_scopeIsTWS = false;
// if scope exists and is in a3e_arr_TWSScopes, it's a NV scope
if ( !(_scope == "") ) then
{
	if (_scope in a3e_arr_TWSScopes) then
	{
		_scopeIsTWS = true;
	};
};

// Param_NVGs
// 0 = No NVGs, 1 = NVGs allowed
// if they have no NV or TWS scope after all that and don't have flashlight, maybe give them NVGs if allowed
_nvgs = hmd _unit;
_unit unlinkItem _nvgs;
if ( !(_scopeIsNV || _scopeIsTWS) && (((primaryWeaponItems _unit) select 1) == "") && (A3E_Param_NVGs > 0) && (random 100 < 30)) then
{
	_unit linkItem "NVGoggles_OPFOR";
};

//Bipod chance
if((random 100 < 20)) then {
	_bipod = selectRandom a3e_arr_Bipods;
	_unit addPrimaryWeaponItem _bipod;
};

//Chance for silencers
if(((random 100 < 10) && (!_nighttime)) OR ((random 100 < 40) && (_nighttime))) then
{
	//Not yet
};

// add back attachments if they weren't messed with above
_unit addPrimaryWeaponItem (_primaryWeaponItems select 0); // muzzle
_unit addPrimaryWeaponItem (_primaryWeaponItems select 1); // pointer
_unit addPrimaryWeaponItem (_primaryWeaponItems select 3); // bipod



if (random 100 > 20) then {
	//_unit additem "ItemMap";
	//_unit assignItem "ItemMap";
	_unit unlinkItem "ItemMap";
	_unit unlinkItem "vn_b_item_map";
	_unit unlinkItem "vn_o_item_map";
};
if (random 100 > 10) then {
	//_unit additem "ItemRadio";
	//_unit assignItem "ItemRadio";
	_unit unlinkItem "ItemRadio";
	_unit unlinkItem "vn_o_item_radio_m252";
	_unit unlinkItem "vn_b_item_radio_urc10";
};
if (random 100 > 25) then {
	//_unit additem "ItemCompass";
	//_unit assignItem "ItemCompass";
	_unit unlinkItem "ItemCompass";
	_unit unlinkItem "vn_b_item_compass_sog";
	_unit unlinkItem "vn_b_item_compass";
};
if (random 100 > 5) then {
	//_unit additem "ItemGPS";
   // _unit assignItem "ItemGPS";
	_unit unlinkItem "ItemGPS";
};
if ("Binocular" in (assignedItems _unit)) then {
	if (random 100 > 20) then {
		//_unit additem "ItemGPS";
	   // _unit assignItem "ItemGPS";
		_unit unlinkItem "Binocular";
		_unit unlinkItem "vn_m19_binocs_grn";
		_unit unlinkItem "vn_m19_binocs_grey";
		_unit unlinkItem "vn_mk21_binocs";
		_unit unlinkItem "vn_anpvs2_binoc";
	};
};
if ("Rangefinder" in (assignedItems _unit)) then {
	if (random 100 > 10) then {
		//_unit additem "ItemGPS";
	   // _unit assignItem "ItemGPS";
		_unit unlinkItem "Rangefinder";
	};
};

if(A3E_Param_IntelChance > 0) then
{
	[_unit] call A3E_fnc_AddIntel;
};

// add leftlet if there are no helicopters
if ((A3E_Param_SearchChopper < 3) || A3E_Debug) then
{
	if((random 100 > 95) || A3E_Debug) then {
		_unit addEventHandler ["killed",
		{
			(_this select 0) spawn
			{
				waitUntil {sleep 4; !alive _this};
				_leaflet = "Leaflet_05_New_F" createVehicle (getpos _this);

				[_leaflet] call BIS_fnc_initIntelObject;
				_leaflet setVariable [
					"RscAttributeDiaryRecord_texture",
					"Units\leaflet.paa", // Path to picture
					true
				];
				
				// Diary Title and Description:
				[
					_leaflet,
					"RscAttributeDiaryRecord",
					["Leaflet", "Surrender now!"] // Array in format [Title, Description]
				] call BIS_fnc_setServerVariable;
				
				// Diary entry shared with (follows BIS_fnc_MP target rules):
				_leaflet setVariable ["recipients", A3E_VAR_Side_Blufor, true];
				
				// Sides that can interact with the intel object:
				_leaflet setVariable ["RscAttributeOwners", [A3E_VAR_Side_Blufor], true];
			};
		}];
	};
};

if (isNil "a3e_var_CL_GarbageCollectorUnits") then {
	a3e_var_CL_GarbageCollectorUnits = [];
};

a3e_var_CL_GarbageCollectorUnits pushBackUnique _unit;









