// by sabersnack

params [
	["_searchAreaMarkerName",""],
	["_trackerRadius",1000],
	["_debug",false]
];

if (_debug) then {
    systemchat "Starting tracker script...";
};

while {!([_searchAreaMarkerName] call drn_fnc_CL_MarkerExists)} do {
	sleep 5;
};

// check if players are within _trackerRadius + offset of _searchAreaMarkerName
_searchMarkerPos = [_searchAreaMarkerName] call drn_fnc_CL_GetRandomMarkerPos;
_playerGroup = [] call A3E_fnc_GetPlayerGroup;
_leader = (units _playerGroup) select 0;
_distanceToPlayer = _leader distance2D _searchMarkerPos;
_extraOffset = 250;

_createTrackerObject = false;

sleep 3.0;

if (_debug) then {
	diag_log (format ["Player is %1 distance from tracker marker. Limit: %2", _distanceToPlayer, _trackerRadius + _extraOffset]);
};

sleep 3.0;

if (_distanceToPlayer < (_trackerRadius + _extraOffset)) then
{
	_createTrackerObject = true;
	if (_debug) then {
		diag_log "Should create tracker module...";
	};
};

_thisTracker = objNull;
_trackerCreated = false;
_trackerName = "";
// if so, create a tracker logic object
if (_createTrackerObject) then
{
	// setup tracker name
	if (isNil "trackerNo") then {
		trackerNo = 0;
	}
	else {
		trackerNo = trackerNo + 1;
	};
	publicVariable "tunnelNo";
	_trackerName = format["tracker%1", trackerNo];

	// setup tracker init string
	_trackerString = format ["this setVariable ['BIS_fnc_initModules_disableAutoActivation', true, true]; %1 = this; publicVariable '%1'", _trackerName];

	// create group
	_grp = createGroup [sideLogic, true];

	// create tracker logic object
	"vn_module_mission_tracker_ao" createUnit [_searchMarkerPos, _grp, _trackerString];
	//setVariable ["UseGrid", True]; //SALSET
	// determine size of tracker squads
	_enemyCount = [0.5] call A3E_fnc_GetEnemyCount;
	_enemyCount params ["_minEnemies", "_maxEnemies"];
	_trackeGroupsize = 1; // 1 = 2 man patrol
	if (_maxEnemies == 2) then
	{
		_trackeGroupsize = 0; // 1 man?
	};

	// set tracker logic settings
	sleep 0.5;
	_thisTracker = missionNameSpace getVariable [_trackerName, objNull];
	_thisTracker setVariable ['VN_Alert',_trackeGroupsize,true];
	_thisTracker setVariable ['VN_RunConditionCode',"true",true];
	_thisTracker setVariable ['objectarea',[_trackerRadius,_trackerRadius,0,false,0],true];
	_thisTracker setVariable ['vn_runConditionCode',{true},true];
	//call {hint format ["area: %1", (this getVariable ["objectarea",100])]};
	//call {hint format ["area: %1", (allVariables this)]};

	[_thisTracker, [], true] call VN_ms_module_fnc_tracker_ao;
	_trackerCreated = true;

	if (_debug) then {
		diag_log (format ["Created tracker module %1", _thisTracker]);
	};
};


// if tracker exists, run this script until players exit the area
if (_trackerCreated) then
{
	_playersNearTrackerArea = true;

	while {_playersNearTrackerArea} do
	{
		_thisTracker = missionNameSpace getVariable [_trackerName, objNull];

		if (_debug) then
		{
			diag_log (format ["Updating tracker %1", _thisTracker]);
		};
		_playerGroup = [] call A3E_fnc_GetPlayerGroup;
		_leader = (units _playerGroup) select 0;
		_distanceToPlayer = _leader distance2D _thisTracker;

		[_thisTracker, true] call VN_ms_module_fnc_tracker_aoDynamicSimToggle;
		[getPos _leader, 300] call VN_ms_fnc_tracker_getHiddenPos;
		_arrayOfShit = [_thisTracker] call VN_ms_module_fnc_tracker_aoGroups;
		{
			_groupArray = _x;
			{
				_group = _x;
				if ((typeName _group) == "GROUP") then
				{
					{
						_soldierObj = _x;
						_soldierObj spawn A3E_fnc_onEnemySoldierSpawn;
					} forEach units _group;
				};
			} forEach _groupArray;
		} forEach _arrayOfShit;

		if (_distanceToPlayer > (_trackerRadius + _extraOffset)) then
		{
			_playersNearTrackerArea = false;
		};
		sleep 30;
	};

	if (!_playersNearTrackerArea) then
	{
		_thisTracker = missionNameSpace getVariable [_trackerName, objNull];
		[_thisTracker, [], false] call VN_ms_module_fnc_tracker_ao;
		if (_debug) then
		{
			diag_log (format ["Deleting tracker %1", _thisTracker]);
		};
		deleteVehicle _thisTracker;
	};
};

