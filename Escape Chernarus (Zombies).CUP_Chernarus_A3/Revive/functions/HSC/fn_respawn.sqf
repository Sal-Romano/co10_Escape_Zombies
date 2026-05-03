player setpos getpos ATHSC_CamTarget;
[player] call AT_FNC_Revive_InstantRevive;
player removeaction painscream;

[] call ATHSC_fnc_exit;

// stamina stuff
if (A3E_Param_NoStaminaAndFatigue == 1) then
{
	player setFatigue 0.0;
	player enableStamina false;
	if (A3E_Param_UseDLCSOGPF == 1) then
	{
		[0] call VN_ms_fnc_params_stamina;
	};
};
