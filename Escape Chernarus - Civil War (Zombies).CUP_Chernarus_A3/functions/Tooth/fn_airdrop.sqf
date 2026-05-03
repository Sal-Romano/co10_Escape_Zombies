params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

//_unitHasRadio = "ItemRadio" in assignedItems _unit;

(if ((_magazine) in Tooth_arr_airdropGrenades)) then
{
    _grenadeObj = _projectile;
    _doArsenalCrateDrop = [_grenadeObj,_unit] spawn
    {
        ///////////////////////////////////////////////////////////////////////////////////////
        private ["_grenadePos","_grenadeObj"];
        params ["_grenadeObj","_unit"];
        waitUntil {speed _grenadeObj <= .001}; // wait until smoke grenade has stopped moving
        sleep 2.0;
        _grenadePos = getPosATL _grenadeObj; // get position of smoke grenade
        // if night, spawn flare
        _sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
        _sunriseTime = _sunriseSunsetTime select 0;
        _sunsetTime = _sunriseSunsetTime select 1;
        _currentTime = daytime;
        _spawnFlare = !((_sunriseTime < _currentTime) && (_currentTime < _sunsetTime));
        diag_log format ["SHOULD SPAWN FLARE: %1",_spawnFlare];
        if (_spawnFlare) then
        {
            _flare = "F_40mm_Yellow" createVehicle [_grenadePos select 0, _grenadePos select 1, 3];
            _flare attachTo [_grenadeObj, [0,0,0]];
        };
        ///////////////////////////////////////////////////////////////////////////////////////
        _arsenalCrateType = selectRandom ["B_supplyCrate_F"]; // crate type(s)
        _arsenalParachuteType = selectRandom ["O_Parachute_02_F"]; // parachute type(s)
        ///////////////////////////////////////////////////////////////////////////////////////
        // Spawn C-130
        _c130Pos = _grenadeObj getPos [2500, 180.0];
        _c130Pos set [2,500];
        _vehArray = [_c130Pos, 0, Tooth_airdropAircraft, Tooth_airdropAircraftSide] call BIS_fnc_spawnVehicle;
        waitUntil {!isNull (_vehArray select 0)}; // wait until crate actually exists
        _vehName    = _vehArray select 0;
        _vehCrew    = _vehArray select 1;
        _vehGroup   = _vehArray select 2;
        missionNamespace setVariable ["c130name", _vehName];
        c130name = _vehName;
        publicVariable "c130name";
        _vehGroup setFormation 'WEDGE';
        _vehGroup setBehaviour 'CARELESS';
        _vehGroup setSpeedMode 'NORMAL';
        _vehGroup deleteGroupWhenEmpty true;
        _vehName allowDamage false;
        _vehName limitSpeed 230;
        _vehName flyInHeightASL [150, 150, 150];
        //_vehName flyInHeight 0;
        _wpName = "Airdrop";
        _wp0 = _vehGroup addWaypoint [_grenadePos, 50.0];
        _wp0 setWaypointCombatMode "BLUE";
        _wp0 setWaypointBehaviour "CARELESS";
        _wp0 setWaypointSpeed "NORMAL";
        _wp0 setWaypointType "MOVE";
        _wp0 setWaypointTimeout [1, 1.5, 2];
        _wp0 setWaypointStatements ["true","missionNamespace setVariable ['Tooth_airdrop', true]; Tooth_airdrop = true; publicVariable 'Tooth_airdrop';"];
        _wpName = "Egress";
        _egressPos = _grenadeObj getPos [5000, 90];
        _wp1 = _vehGroup addWaypoint [_egressPos, 0.0];
        _wp1 setWaypointCombatMode "BLUE";
        _wp1 setWaypointBehaviour "CARELESS";
        _wp1 setWaypointSpeed "NORMAL";
        _wp1 setWaypointType "MOVE";
        _wp1 setWaypointTimeout [0, 0, 0];
        _wp1 setWaypointStatements ["true","{deleteVehicle _x} forEach crew (missionNamespace getVariable ['c130name', objNull]); deleteVehicle (missionNamespace getVariable ['c130name', objNull]);"];
    
        sleep 3.0;
        [(_vehCrew select 0),"Roger that, supplies incoming."] remoteExec ["sideChat",0,false];

        // wait until right moment to trigger spawning of crate
        sleep 1.0;
        //hint "WAITING FOR AIRDROP";
        //diag_log "WAITING FOR AIRDROP";
        waitUntil {(missionNameSpace getVariable ["Tooth_airdrop",false])};
        
        //waitUntil {(_grenadeObj distance2D _vehName) < 2000.0; false};
        //hint "C-130 APPROACHING";
        //diag_log "C-130 APPROACHING";
        //waitUntil {(_grenadeObj distance2D _vehName) < 1000.0; false};

        _c130DropPos = getPosATL _vehName;
        //_c130DropPos set [2,200];
        _arsenalCrate = createVehicle [ _arsenalCrateType, _c130DropPos, [], 0, "CAN_COLLIDE" ]; // create the crate
        //_arsenalCrate = createVehicle [ _arsenalCrateType, [(_grenadePos select 0),(_grenadePos select 1), (_grenadePos select 2) + 150], [], 0, "CAN_COLLIDE" ]; // create the crate
        ///////////////////////////////////////////////////////////////////////////////////////
        waitUntil {!isNull _arsenalCrate}; // wait until crate actually exists
        ///////////////////////////////////////////////////////////////////////////////////////
        [(_vehCrew select 0),"Supplies out!"] remoteExec ["sideChat",0,false];
        _c130Velocity = velocity _vehName;
        _arsenalCrate setVelocity _c130Velocity;
        clearWeaponCargoGlobal _arsenalCrate; // empty crate contents
        clearItemCargoGlobal _arsenalCrate; // empty crate contents
        clearBackpackCargoGlobal _arsenalCrate; // empty crate contents
        clearMagazineCargoGlobal _arsenalCrate; // empty crate contents
        _arsenalCrate allowDamage false; // disallow damage to crate
        _arsenalCrate disableCollisionWith _vehName;
        
        //hint format ["SHOULD HAVE SPAWNED CRATE AT %1, %2 meters from player",(_c130DropPos),(_grenadeObj distance2D _arsenalCrate)];
        diag_log format ["SHOULD HAVE SPAWNED CRATE AT %1, %2 meters from player",(_c130DropPos),(_grenadeObj distance2D _arsenalCrate)];
        _arsenalChute = createVehicle [ _arsenalParachuteType, [(getPosATL _arsenalCrate select 0),(getPosATL _arsenalCrate select 1), (getPosATL _arsenalCrate select 2)], [], 0, "CAN_COLLIDE" ]; // create the parachute
        _arsenalChute allowDamage false; // disallow damage to parachute
        _arsenalCrate attachTo [_arsenalChute, [0,0,0]]; // attach the crate to the parachute
        ///////////////////////////////////////////////////////////////////////////////////////

        if (_spawnFlare) then
        {
            _flare0 = "F_40mm_Yellow" createVehicle _c130DropPos;
            _flare0 attachTo [_arsenalCrate, [0,0,1]];
        };
        _smoke0 = "SmokeShellRed" createVehicle _c130DropPos;
        _smoke0 attachTo [_arsenalCrate, [0,0,1]];

        waitUntil {getPosATL _arsenalCrate select 2 < 60.0};
        if (_spawnFlare) then
        {
            _flare3 = "F_40mm_Yellow" createVehicle _c130DropPos;
            _flare3 attachTo [_arsenalCrate, [0,0,1]];
        };

        ///////////////////////////////////////////////////////////////////////////////////////
        waitUntil {getPosATL _arsenalCrate select 2 < 0.2}; // wait until the crate is less than 20cm above terrain level
        detach _arsenalChute;
        //deleteVehicle _arsenalChute;
        deleteVehicle _arsenalCrate;

        _arsenalCrateNew = createVehicle [ _arsenalCrateType, (getPosATL _arsenalCrate), [], 0, "NONE" ]; // create the crate
        waitUntil {!isNull _arsenalCrateNew}; // wait until crate actually exists
        clearWeaponCargoGlobal _arsenalCrateNew; // empty crate contents
        clearItemCargoGlobal _arsenalCrateNew; // empty crate contents
        clearBackpackCargoGlobal _arsenalCrateNew; // empty crate contents
        clearMagazineCargoGlobal _arsenalCrateNew; // empty crate contents
        _arsenalCrateNew allowDamage false; // disallow damage to crate
        // put weapons in crate
        {
          _array = _x;
          _gun = _array select 0;
          _num = _array select 1;
          _arsenalCrateNew addWeaponCargoGlobal [_gun, _num];
        } forEach Tooth_arr_AirdropCrateWeapons;
        {
          _array = _x;
          _mag = _array select 0;
          _num = _array select 1;
          _arsenalCrateNew addMagazineCargoGlobal  [_mag, _num];
        } forEach Tooth_arr_AirdropCrateMags;
        {
          _array = _x;
          _item = _array select 0;
          _num = _array select 1;
          _arsenalCrateNew addItemCargoGlobal [_item, _num];
        } forEach Tooth_arr_AirdropCrateItems;
        {
          _array = _x;
          _pack = _array select 0;
          _num = _array select 1;
          _arsenalCrateNew addBackpackCargoGlobal  [_pack, _num];
        } forEach Tooth_arr_AirdropCrateBackpacks;

        if (_spawnFlare) then
        {
            _flare1 = "F_40mm_Yellow" createVehicle (getPos _arsenalCrateNew);
            _flare1 attachTo [_arsenalCrateNew, [0,0,0]];
        };
        _smoke1 = "SmokeShellRed" createVehicle (getPos _arsenalCrateNew);
        _smoke1 attachTo [_arsenalCrateNew, [0,0,0]];
        uiSleep 20;
        if (_spawnFlare) then
        {
            _flare2 = "F_40mm_Yellow" createVehicle (getPos _arsenalCrateNew);
            _flare2 attachTo [_arsenalCrateNew, [0,0,0]];
        };

    };
};
