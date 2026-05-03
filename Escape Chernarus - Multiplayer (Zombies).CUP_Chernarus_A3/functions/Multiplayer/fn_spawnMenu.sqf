// fn_spawnMenu.sqf
// Shows spawn city selection to player

private _cities = [
    ["Chernogorsk", [6731, 2570, 0]],
    ["Elektrozavodsk", [10500, 2100, 0]],
    ["Berezino", [12300, 9100, 0]],
    ["Solnichniy", [13300, 6200, 0]],
    ["Kamyshovo", [12100, 3500, 0]],
    ["Balota", [4500, 2400, 0]],
    ["Kamenka", [1900, 2200, 0]],
    ["Zelenogorsk", [2700, 5300, 0]],
    ["Vybor", [4500, 8200, 0]],
    ["Stary Sobor", [6100, 7700, 0]],
    ["Novy Sobor", [7100, 7700, 0]],
    ["Gorka", [9700, 8800, 0]],
    ["Polana", [10700, 8100, 0]],
    ["Krasnostav", [11300, 12200, 0]],
    ["Severograd", [8600, 12700, 0]],
    ["Novodmitrovsk", [11200, 14600, 0]],
    ["Svetlojarsk", [13900, 13200, 0]],
    ["Dubrovka", [10400, 9800, 0]],
    ["Pustoshka", [3100, 7900, 0]],
    ["Nadezhdino", [5800, 4700, 0]]
];

A3E_MP_Cities = _cities;

// Check for alive group members
private _canSpawnOnGroup = false;
private _groupMembers = (units group player) - [player];
{
    if (alive _x && !(_x getVariable ["A3E_MP_InLobby", true])) exitWith {
        _canSpawnOnGroup = true;
    };
} forEach _groupMembers;

// Wait for main display to be ready
waitUntil {sleep 0.1; !isNull (findDisplay 46)};
sleep 1;

// Clear all overlays
titleText ["", "PLAIN", 0.01];
cutText ["", "PLAIN", 0.01];
sleep 0.3;

// Add city markers BEFORE opening map so they're visible immediately
private _markers = [];
{
    _x params ["_name", "_pos"];
    private _mkr = createMarkerLocal [format["spawn_city_%1", _forEachIndex], _pos];
    _mkr setMarkerTypeLocal "mil_flag";
    _mkr setMarkerColorLocal "ColorGreen";
    _mkr setMarkerTextLocal format ["  %1", _name];
    _mkr setMarkerSizeLocal [0.7, 0.7];
    _markers pushBack _mkr;
} forEach _cities;

if (_canSpawnOnGroup) then {
    private _leader = objNull;
    {
        if (alive _x && !(_x getVariable ["A3E_MP_InLobby", true])) exitWith {
            _leader = _x;
        };
    } forEach _groupMembers;

    if (!isNull _leader) then {
        private _mkr = createMarkerLocal ["spawn_on_group", getPos _leader];
        _mkr setMarkerTypeLocal "mil_join";
        _mkr setMarkerColorLocal "ColorYellow";
        _mkr setMarkerTextLocal "  SPAWN ON GROUP";
        _mkr setMarkerSizeLocal [1, 1];
        _markers pushBack _mkr;
    };
};

// Force map open - keep trying until it's actually open
openMap true;
waitUntil {sleep 0.1; visibleMap};

hint "Click a GREEN marker to select your spawn city.\nYou will start as a prisoner there.\n\nYELLOW marker = Spawn on your group.";

// Wait for map click
A3E_MP_SpawnSelected = false;
A3E_MP_SpawnPos = [0,0,0];
A3E_MP_SpawnType = "city";

onMapSingleClick {
    private _clickPos = _pos;
    private _minDist = 500;
    private _selectedCity = "";
    private _selectedPos = [0,0,0];

    if (!isNil "A3E_MP_Cities") then {
        private _grpMkrPos = getMarkerPos "spawn_on_group";
        if (_grpMkrPos distance2D _clickPos < _minDist && _grpMkrPos distance2D [0,0,0] > 1) then {
            A3E_MP_SpawnPos = _grpMkrPos;
            A3E_MP_SpawnType = "group";
            A3E_MP_SpawnSelected = true;
        } else {
            {
                _x params ["_name", "_cityPos"];
                if (_cityPos distance2D _clickPos < _minDist) then {
                    _minDist = _cityPos distance2D _clickPos;
                    _selectedCity = _name;
                    _selectedPos = _cityPos;
                };
            } forEach A3E_MP_Cities;

            if (_selectedCity != "") then {
                A3E_MP_SpawnPos = _selectedPos;
                A3E_MP_SpawnType = "city";
                A3E_MP_SpawnSelected = true;
                systemChat format ["Selected: %1", _selectedCity];
            };
        };
    };

    if (A3E_MP_SpawnSelected) then {
        onMapSingleClick "";
        openMap false;
    };
};

// Keep map open if player closes it
[] spawn {
    while {!A3E_MP_SpawnSelected} do {
        if (!visibleMap) then {
            openMap true;
            hint "You must select a spawn location first!";
        };
        sleep 0.3;
    };
};

waitUntil {sleep 0.1; A3E_MP_SpawnSelected};

{deleteMarkerLocal _x} forEach _markers;
hint "";

[A3E_MP_SpawnPos, A3E_MP_SpawnType]
