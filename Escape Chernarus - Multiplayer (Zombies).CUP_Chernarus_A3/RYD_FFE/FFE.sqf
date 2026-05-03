
sleep 5;

missionNameSpace setVariable ["RydFFE_FiredShells",[]];

if (isNil "RydFFE_Active") then {RydFFE_Active = true};
if (isNil "RydFFE_Manual") then {RydFFE_Manual = false};
if (isNil "RydFFE_NoControl") then {RydFFE_NoControl = []};
if (isNil "RydFFE_ArtyShells") then {RydFFE_ArtyShells = 1};
if (isNil "RydFFE_Interval") then {RydFFE_Interval = 10};
if (isNil "RydFFE_Debug") then {RydFFE_Debug = false};
if (isNil "RydFFE_FO") then {RydFFE_FO = []};
if (isNil "RydFFE_2PhWithoutFO") then {RydFFE_2PhWithoutFO = false};
if (isNil "RydFFE_OnePhase") then {RydFFE_OnePhase = false};

if (isNil ("RydFFE_Amount")) then {RydFFE_Amount = 6};
//if (isNil ("RydFFE_Disp")) then {RydFFE_Disp = 0.4};
if (isNil ("RydFFE_Acc")) then {RydFFE_Acc = 2};
if (isNil ("RydFFE_Safe")) then {RydFFE_Safe = 100};
if (isNil ("RydFFE_Monogamy")) then {RydFFE_Monogamy = true};
if (isNil ("RydFFE_ShellView")) then {RydFFE_ShellView = false};
if (isNil ("RydFFE_FOAccGain")) then {RydFFE_FOAccGain = 1};
if (isNil ("RydFFE_FOClass")) then {RydFFE_FOClass =
	[
	"i_spotter_f",
	"o_spotter_f",
	"b_spotter_f",
	"o_recon_jtac_f",
	"b_recon_jtac_f",
	"i_sniper_f",
	"o_sniper_f",
	"b_sniper_f",
	"i_soldier_m_f",
	"o_soldier_m_f",
	"b_g_soldier_m_f",
	"b_soldier_m_f",
	"o_recon_m_f",
	"b_recon_m_f",
	"o_soldieru_m_f",
	"i_uav_01_f",
	"i_uav_02_cas_f",
	"i_uav_02_f",
	"o_uav_01_f",
	"o_uav_02_cas_f",
	"o_uav_02_f",
	"b_uav_01_f",
	"b_uav_02_cas_f",
	"b_uav_02_f"
	]};

if (isNil "RydFFE_Add_SPMortar") then {RydFFE_Add_SPMortar = []};
if (isNil "RydFFE_Add_Mortar") then {RydFFE_Add_Mortar = []};
if (isNil "RydFFE_Add_Rocket") then {RydFFE_Add_Rocket = []};
if (isNil "RydFFE_Add_Other") then {RydFFE_Add_Other = []};
if (isNil "RydFFE_IowaMode") then {RydFFE_IowaMode = false};

RydFFE_SPMortar = ["o_mbt_02_arty_f","b_mbt_01_arty_f"] + RydFFE_Add_SPMortar;
RydFFE_Mortar = ["i_mortar_01_f","o_mortar_01_f","b_g_mortar_01_f","b_mortar_01_f"] + RydFFE_Add_Mortar;
RydFFE_Rocket = ["b_mbt_01_mlrs_f"] + RydFFE_Add_Rocket;
RydFFE_Other = [] + RydFFE_Add_Other;

_allArty = RydFFE_SPMortar + RydFFE_Mortar + RydFFE_Rocket;

	{
	_allArty = _allArty + (_x select 0)
	}
foreach RydFFE_Other;


[] call compile preprocessFile "RYD_FFE\FFE_fnc.sqf";
Shellview = compile preprocessFile "RYD_FFE\Shellview.sqf";

_allArty = [_allArty] call RydFFE_AutoConfig;

_civF = ["civ_f","civ","civ_ru","bis_tk_civ","bis_civ_special"];
_sides = [west,east,resistance];

_enemyGroups = [];
_friends = [];
RydFFE_Fire = false;

if (isNil ("RydFFE_SVRange")) then {RydFFE_SVRange = 3000};

if (RydFFE_ShellView) then {[] spawn Shellview};

while {RydFFE_Active} do
	{
	if (RydFFE_Manual) then {waitUntil {sleep 0.1;((RydFFE_Fire) or not (RydFFE_Manual))};RydFFE_Fire = false};

		if (RydFFE_Debug) then
		{
			diag_log format ["FFE_Artillery Main_function: RydFFE_Manual: %1 RydFFE_Fire: %2", RydFFE_Manual, RydFFE_Fire];
		};

		{
		_side = _x;

		_eSides = [sideEnemy];
		_fSides = [sideFriendly];

			{
			_getF = _side getFriend _x;
			if (_getF >= 0.6) then
				{
				_fSides set [(count _fSides),_x]
				}
			else
				{
				_eSides set [(count _eSides),_x]
				}
			}
		foreach _sides;

		if (({((side _x) == _side)} count AllGroups) > 0) then
			{
			_artyGroups = [];
			_enemyGroups = [];
			_friends = [];

				{
				_gp = _x;

				if ((side _gp) == _side) then
					{
					if not (_gp in RydFFE_NoControl) then
						{
							{
							if ((toLower (typeOf (vehicle _x))) in _allArty) exitWith
								{
								if not (_gp in _artyGroups) then
									{
									_artyGroups pushBack _gp
									}
								}
							}
						foreach (units _gp)
						}
					};

				_isCiv = false;
				if ((toLower (faction (leader _gp))) in _civF) then {_isCiv = true};

				if not (_isCiv) then
					{
					if (not (isNull _gp) and (alive (leader _gp))) then
						{
						if ((side _gp) in _eSides) then
							{
							if not (_gp in _enemyGroups) then
								{
								_enemyGroups pushBack _gp;
								}
							}
						else
							{
							if ((side _gp) in _fSides) then
								{
								if not (_gp in _friends) then
									{
									_friends pushBack _gp;
									if ((toLower (typeOf (leader _x))) in RydFFE_FOClass) then
										{
										if ((count RydFFE_FO) > 0) then
											{
											if not (_gp in RydFFE_FO) then
												{
												RydFFE_FO pushBack _gp
												}
											}
										}
									}
								}
							}
						}
					}
				}
			foreach allGroups;

			// get known enemies
			_knownEnemies = [];
			{
				_enemyGroup = _x;
				{	
					_enenmyUnit = _x;
					_enemyVehicle = vehicle _enenmyUnit;
					{
						_friendlyGroup = _x;
						if not ((toLower (faction (leader _friendlyGroup))) in _civF) then
						{
							if (((count RydFFE_FO) == 0) or (_friendlyGroup in RydFFE_FO)) then
							{
								if ((_friendlyGroup knowsAbout _enemyVehicle) >= 0.05) then
								{
									if not (_enemyVehicle in _knownEnemies) then
									{
										_enemyVehicle setVariable ["RydFFE_MyFO",(leader _friendlyGroup)];
										_knownEnemies pushBack _enemyVehicle;
									};
								};
							};
						};
					} foreach _friends;
				} foreach (units _enemyGroup);
			} foreach _enemyGroups;

			// get enemy armor
			_enemyArmor = [];
			{
			if ((_x isKindOf "Tank") or (_x isKindOf "Wheeled_APC")) then
				{
					if not (_x in _enemyArmor) then
					{
						_enemyArmor pushBack _x;
					};
				};
			} foreach _knownEnemies;

			if (RydFFE_Debug) then
			{
				diag_log format ["FFE_Artillery Main_function: _side: %1 _knownEnemies: %2 _enemyArmor: %3", _side, _knownEnemies, _enemyArmor];
			};

			[_artyGroups,RydFFE_ArtyShells] call RYD_ArtyPrep;

			[_artyGroups,_knownEnemies,_enemyArmor,_friends,RydFFE_Debug,RydFFE_Amount] call RYD_CFF
			}
		}
	foreach _sides;

	if (RydFFE_Debug) then
	{
		diag_log format ["FFE_Artillery Main_function: sleeping for %1 sec", RydFFE_Interval];
	};

	sleep RydFFE_Interval;

	_shells = missionNameSpace getVariable ["RydFFE_FiredShells",[]];

		{
		_shell = _x;
		if (isNil "_shell") then
			{
			_shells set [_foreachIndex,0]
			}
		else
			{
			if (isNull _x) then
				{
				_shells set [_foreachIndex,0]
				}
			}
		}
	foreach _shells;

	_shells = _shells - [0];
	missionNameSpace setVariable ["RydFFE_FiredShells",_shells];
	
	_allArty = [_allArty] call RydFFE_AutoConfig
	};