// Build start position
private _fenceRotateDir = random 360;

private _backPack = a3e_arr_PrisonBackpackType createvehicle A3E_StartPos;
private _light = "Chemlight_red" createvehicle A3E_StartPos;

private _template = selectRandom(["a3e_fnc_BuildPrison1", "a3e_fnc_BuildPrison2", "a3e_fnc_BuildPrison3", "a3e_fnc_BuildPrison4", "a3e_fnc_BuildPrison5"]);

[A3E_StartPos, _fenceRotateDir, _backPack, _light] remoteExec [_template, 0, true];

A3E_FenceIsCreated = true;
publicVariable "A3E_FenceIsCreated";

_backPack;