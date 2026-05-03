diag_log format["initClient run for %1 (%2)", name player, str _this];

if(!hasInterface) exitwith {};

waituntil {!isnull player};

call A3E_FNC_Briefing;

sleep 0.5;

[player] remoteExec ["a3e_fnc_initPlayer", 2];

[] spawn {
	disableSerialization;
	waitUntil {!isNull(findDisplay 46)};
	(findDisplay 46) displayAddEventHandler ["keyDown", "_this call a3e_fnc_KeyDown"];
};


AT_Revive_StaticRespawns = [];
AT_Revive_enableRespawn = false;
AT_Revive_clearedDistance = 0;
AT_Revive_Camera = 1;


[] call A3E_fnc_addUserActions;

removeAllAssignedItems player;
removeAllWeapons player;
removeAllItems player;
removeUniform player;
removeBackpack player;
removeVest player;
removeHeadgear player;
removeGoggles player;
if(hmd player != "") then {
	private _hmd = hmd player;
	player unlinkItem _hmd;
};

player addeventhandler["HandleRating","_this call A3E_FNC_handleRating;"];

player addeventhandler["InventoryClosed","_this call A3E_FNC_collectIntel;"];


if (count Tooth_playerUniform > 0) then
{
	player forceAddUniform (selectRandom Tooth_playerUniform);
};
if (count Tooth_playerVest > 0) then
{
	_vest = selectRandom Tooth_playerVest;
	if (_vest != "") then
	{
		player addVest _vest;
	};
};
if (count Tooth_playerHeadgear > 0) then
{
	_headgear = selectRandom Tooth_playerHeadgear;
	if (_headgear != "") then
	{
		player addHeadgear _headgear;
	};
};
if (count Tooth_playerGoggles > 0) then
{
	_goggles = selectRandom Tooth_playerGoggles;
	if (_goggles != "") then
	{
		player addGoggles _goggles;
	};
};
if (Tooth_playerBackpack != "") then
{
	player addBackpack Tooth_playerBackpack;
};
if (count Tooth_playerNVG > 0) then
{
	player addWeapon (selectRandom Tooth_playerNVG);
};

if (Tooth_playersHaveRadio) then
{
	player addItem "ItemRadio";
	player assignItem "ItemRadio";
};

if (Tooth_playersHaveWatch) then
{
	player addItem "ItemWatch";
	player assignItem "ItemWatch";
};

if (Tooth_playersHaveMap) then
{
	player addItem "ItemMap";
	player assignItem "ItemMap";
};

if (Tooth_playersHaveCompass) then
{
	player addItem "ItemCompass";
	player assignItem "ItemCompass";
};

if (Tooth_playersHaveGPS) then
{
	player addItem "ItemGPS";
	player assignItem "ItemGPS";
};

if (count Tooth_playerFaces > 0 && count Tooth_playerVoices > 0) then
{
	[player, selectRandom Tooth_playerFaces, selectRandom Tooth_playerVoices] call BIS_fnc_setIdentity;
};


drn_fnc_Escape_DisableLeaderSetWaypoints = {
	if (!visibleMap) exitwith {};
	
	{
		player groupSelectUnit [_x, false]; 
	} foreach units group player;
};

// If multiplayer, then disable the cheating "move to" waypoint feature.
if (isMultiplayer) then {
	[] spawn {
		waitUntil {!isNull(findDisplay 46)}; 
		// (findDisplay 46) displayAddEventHandler ["KeyDown","_nil=[_this select 1] call drn_fnc_Escape_DisableLeaderSetWaypoints"];
		(findDisplay 46) displayAddEventHandler ["MouseButtonDown","_nil=[_this select 1] call drn_fnc_Escape_DisableLeaderSetWaypoints"];
	};
};

waituntil{sleep 0.1;!isNil("A3E_ParamsParsed")};
AT_Revive_Camera = A3E_Param_ReviveView;

//If no ACE use ATR revive
if (isClass(configFile >> "CfgPatches" >> "ACE_Medical")) then {
	player setVariable ["ACE_Revive_isUnconscious", false, true];
} else {
	call ATR_FNC_ReviveInit;
};


setTerrainGrid (A3E_Param_Grass*3.125);
setViewDistance (A3E_Param_ViewDistance);
setObjectViewDistance [A3E_Param_ObjectViewDistance,A3E_Param_ShadowViewDistance];
setDetailMapBlendPars [A3E_Param_DetailBlend,A3E_Param_DetailBlend*2.5];

if (A3E_Param_Magrepack == 1) then {
	[] execVM "Scripts\outlw_magRepack\MagRepack_init_sv.sqf";
};

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

player setUnitTrait ["engineer", true];
player setUnitTrait ["medic", true];
player setUnitTrait ["explosiveSpecialist", true];

[] spawn {
	disableSerialization;
	waitUntil {!isNull(findDisplay 46)};
	(findDisplay 46) displayAddEventHandler ["keyDown", "_this call a3e_fnc_KeyDown"];
};
player setvariable["A3E_PlayerInitializedLocal",true,true];


waituntil{sleep 0.1;(player getvariable["A3E_PlayerInitializedServer",false])};

diag_log format["Escape debug: %1 is now ready (clientside).", name player];


[] spawn {
	waituntil{sleep 0.5;!isNil("A3E_EscapeHasStarted")};


	//Player needs to be taken out of captivity if they rejoin
	if (isClass(configFile >> "CfgPatches" >> "ACE_Medical")) then {
	player setCaptive false;
	};

	//Message delayed to make sure ACE_MedicalServer is broadcasted
	if ((isClass(configFile >> "CfgPatches" >> "ACE_Medical")) && !(ACE_MedicalServer)) then {systemChat "Player is running ACE on unsupported server! Please deactivate or gameplay could be servilely affected.";};
	if (!(isClass(configFile >> "CfgPatches" >> "ACE_Medical")) && (ACE_MedicalServer)) then {systemChat "Server is running ACE! Please install the compatible version and reconnect to prevent gamebreaking issues.";};
};

[] spawn {
	waituntil{sleep 0.5;A3E_Task_Prison_Complete};


	if (Tooth_introMusic != "") then
	{
		playMusic Tooth_introMusic;
	};
	_monthString = [] call Toothfunctions_fnc_monthToString;
	["Somewhere in", "Hillary's America" , format ["%1 %2, %3 %4:00",_monthString,(date select 2),(date select 0),(date select 3)] ] spawn BIS_fnc_infoText;
	//[localize "STR_A3E_initLocalPlayer_somewhereOn", A3E_WorldName , str (date select 2) + "/" + str (date select 1) + "/" + str (date select 0) + " " + str (date select 3) + ":00"] spawn BIS_fnc_infoText;
};

if(!isNil("CBA_fnc_addKeybind")) then {
	[] spawn {
		disableSerialization;
		["A3E Earplugs", "toggle_earplugs_key", localize "STR_A3E_initLocalPlayer_toggleEarplugs", {_this call A3E_fnc_toggleEarplugs}, ""] call CBA_fnc_addKeybind;
	};
};

[] spawn {
    if (Tooth_prisonPropaganda != "" && A3E_Param_Propaganda == 1) then
    {
        waituntil{sleep 0.1;!isNil("A3E_PrisonLoudspeakerObject")};
        _trigger = createTrigger["EmptyDetector", ((getposASL A3E_PrisonLoudspeakerObject) vectorAdd [0,0,4]), false];
        _trigger setTriggerArea[25, 25, 0, false];
        _trigger setTriggerActivation["NONE", "PRESENT", false];
        _trigger setSoundEffect ["$NONE$", "", "", Tooth_prisonPropaganda];
    };
};


if (A3E_Param_Cigarettes == 1) then
{
    [player] spawn murshun_cigs_fnc_start_cig; // added cigs
};

