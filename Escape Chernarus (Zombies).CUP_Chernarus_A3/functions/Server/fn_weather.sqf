if (A3E_Param_UseCustomWeather == 1) exitWith {};

params[["_initial",true]];
_weatherTemplates = [];
_overcastTemplates = [];
_niceTemplates = [];
//[overcast,rain,fog,lightnings]

// fog value = 0...1.0
// fog decay = 0...0.1

//no fog
_noFog = [0,0.0,0];
//overcast fog
_overcastFog = [0.005,0.005,1000];
//light rain fog
_lightRainFog = [0.01,0.01,500];
//heavy rain fog
_heavyRainFog = [0.05,0.01,500];
// pea soup fog
_peaSoupFog = [0.002,0.01,1000];
// night fog
_nightFog = [0.01,0.015,400];
// morning fog
_morningFog = [0.03,0.01,400];
// morning fog
_morningFog2 = [0.05,0.01,200];
// light fog
_lightFog = [0.005,0.01,500];

_heavyFog = [0.08,0.01,600];

_stormSetting = [0.9,0.7,_heavyRainFog,1];
_rainSetting = [0.9,0.3,_lightRainFog,0];

//Clear
_niceTemplates pushBack [0.05,0,_noFog,0];
//Overcast
_overcastTemplates pushBack [0.5,0,_morningFog,0];
//Rain
_overcastTemplates pushBack _rainSetting;
//Fog
_niceTemplates pushBack [0.4,0,_lightRainFog,0];
//Storm
_overcastTemplates pushBack _stormSetting;
//Nightmare
_overcastTemplates pushBack [0.9,0,_peaSoupFog,1];
//Partly cloudy
_niceTemplates pushBack [0.2,0,_noFog,0];
//Cloudy
_niceTemplates pushBack [0.4,0,_overcastFog,0];
//Could get rainy
_overcastTemplates pushBack [0.5,0.1,_morningFog2,0];
//Nice
_niceTemplates pushBack [0.1,0,_noFog,0];
//Morningmood
_niceTemplates pushBack [0.2,0,_morningFog,0];
//Morningmood2
_niceTemplates pushBack [0.2,0,_morningFog2,0];
//Clear
_niceTemplates pushBack [0.3,0,_noFog,0];
//Clear
_niceTemplates pushBack [0,0,_morningFog,0];
//Clear
_niceTemplates pushBack [0.1,0,_noFog,0];
//Overcast
_niceTemplates pushBack [0.4,0,_nightFog,0];
//Overcast
_overcastTemplates pushBack [0.5,0,_overcastFog,0];
//Cloudy
_niceTemplates pushBack [0.3,0,_lightFog,0];
//Cloudy
_niceTemplates pushBack [0.4,0,_morningFog2,0];


// get daytime/nighttime
_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
_sunRiseTime = _sunriseSunsetTime select 0;
_sunSetTime = _sunriseSunsetTime select 1;
// before sunrise or after sunset, it's night!
_nighttime = false;
if((daytime < _sunRiseTime - 1) || (daytime > _sunSetTime + 1) ) then
{
	_nighttime = true;
};

_morningtime = false;
if((daytime > _sunRiseTime - 1) && (daytime < _sunRiseTime + 1) ) then
{
	_morningtime = true;
};

_dusktime = false;
if((daytime > _sunSetTime - 1) && (daytime < _sunSetTime + 1) ) then
{
	_dusktime = true;
};

// diable storms at night because you can't see 2 inches in front of your damn face
_weatherTemplates = _niceTemplates;
if (!_nighttime && !_morningtime && !_dusktime) then
{
	_weatherTemplates append _overcastTemplates;
};

diag_log format ["WEATHER!!!!!!!!!!!!!!! _weatherTemplates: %1", _weatherTemplates];

//Make sure all used vars are initialised
if(isNil("A3E_Param_Weather")) then {
	A3E_Param_Weather = -1;
};
if(isNil("A3E_Param_DynamicWeather")) then {
	A3E_Param_DynamicWeather = 1;
};
if(isNil("A3E_Param_TimeMultiplier")) then {
	A3E_Param_TimeMultiplier = 1;
};
_currentTemplate = [];
/*
if(A3E_Param_Weather<0) then {
	_currentTemplate = selectRandom _weatherTemplates;
} else {
	if(A3E_Param_Weather<count(_weatherTemplates)) then {
		_currentTemplate = _weatherTemplates select A3E_Param_Weather;
	} else {
		_currentTemplate = selectRandom _weatherTemplates;
	};
};
*/

switch (A3E_Param_Weather) do
{
	case 0: // clear
	{ 
		_currentTemplate = [0.05,0,_noFog,0];
	};
	case 1: // overcast
	{ 
		_currentTemplate = [0.7,0,_overcastFog,0];
	};
	case 2: // rain
	{ 
		_currentTemplate = _rainSetting;
	};
	case 3: // fog
	{ 
		_currentTemplate = [0.6,0,_heavyFog,0];
	};
	case 4: // storm
	{ 
		_currentTemplate = _stormSetting;
	};
	case -1: // random
	{ 
		_currentTemplate = selectRandom _weatherTemplates;
	};
	default // random
	{ 
		_currentTemplate = selectRandom _weatherTemplates;
	};
};


private _weatherTransitionTime = 1800;
private _weatherWaitTime = 600;
private _rainDelay = 120; //Delay rainchange
if(_initial) then {
	_weatherTransitionTime = 0;
};
if(A3E_Param_DynamicWeather == 0) then {
	_weatherWaitTime = 60*60*24*A3E_Param_TimeMultiplier;
};

//Transition in _weatherTransitionTime ingame seconds
_weatherTransitionTime setovercast (_currentTemplate select 0);
if(abs(rain-(_currentTemplate select 1))<0.2 || _initial) then {
	_weatherTransitionTime setrain (_currentTemplate select 1);
} else {
	//Delay rain a bit of rainchange is to heavy. Otherwise rain will start before clouds appear or vice versa
	[(_currentTemplate select 1),_rainDelay/A3E_Param_TimeMultiplier,_weatherTransitionTime-(_rainDelay/A3E_Param_TimeMultiplier)] spawn {
		params["_rain","_time","_change"];
		systemchat ("Delaying rain by "+ str _time + " seconds");
		sleep _time;
		_change setrain _rain;
	};
};

diag_log format ["WEATHER!!!!!!!!!!!!!!! _nighttime: %1 _morningtime: %2 _dusktime: %3 _sunRiseTime: %4 _sunSetTime: %5 daytime: %6", _nighttime, _morningtime, _dusktime, _sunRiseTime, _sunSetTime, daytime];

_overcastSetting = _currentTemplate select 0;
_fogSetting = _currentTemplate select 2;
/*
_overcast = (_currentTemplate select 0) >= 0.5;
if (_nighttime && !_overcast) then
{
	_fogSetting = _nightFog;
};
if (_morningtime && !_overcast) then
{
	_fogSetting = _morningFog;
};
*/

// fog settings from DRO
_fogSetting = if (_overcastSetting < 0.7) then
{ // if not super overcast
	diag_log format ["WEATHER!!!!!!!!!!!!!!! its nice"];
	if (_nighttime || _morningtime) then // nighttime
	{
		if (random 1 > 0.2) then // 80% chance for a little low lying fog
		{ 
			diag_log format ["WEATHER!!!!!!!!!!!!!!! fog"];
			[0.5, (random [0.02, 0.05, 0.035]), 50];
		}
		else // 10% chance maybe a little haze
		{
			diag_log format ["WEATHER!!!!!!!!!!!!!!! haze"];
			[random(0.005), random(0.005), 50];
		};
	}
	else // daytime
	{
		if (random 1 > 0.8) then // 20% chance for a little fog
		{
			diag_log format ["WEATHER!!!!!!!!!!!!!!! fog"];
			[(random 0.1), (random [0.03, 0.05, 0.04]), 40];
		}
		else // 90% chance maybe a little haze
		{
			diag_log format ["WEATHER!!!!!!!!!!!!!!! haze"];
			[random(0.005), random(0.005), random(100)];
		};
	};	
}
else // it's super overcast
{
	diag_log format ["WEATHER!!!!!!!!!!!!!!! overcast"];
	if (random 1 > 0.6) then // 40% chance of heavy fog
	{
		diag_log format ["WEATHER!!!!!!!!!!!!!!! fog"];
		[(random 0.65), (random [0.03, 0.05, 0.04]), 40];
	}
	else
	{
		diag_log format ["WEATHER!!!!!!!!!!!!!!! haze"];
		[0.005, 0.005, 500];
	};
};

_rainSetting = _currentTemplate select 1;
if (_rainSetting > 0.1) then
{
	_fogSetting = _lightRainFog;
	diag_log format ["WEATHER!!!!!!!!!!!!!!! just kidding, light fog"];
};
if (_rainSetting > 0.4) then
{
	_fogSetting = _heavyRainFog;
	diag_log format ["WEATHER!!!!!!!!!!!!!!! just kidding, heavy fog"];
};

if (A3E_Param_Weather == 3) then
{
	diag_log format ["WEATHER!!!!!!!!!!!!!!! just kidding, heavy fog"];
	_fogSetting = _heavyFog; // [(random [0.04, 0.06, 0.05]),(random [0.01, 0.015, 0.012]),400];
};

_currentTemplate set [2, _fogSetting];
diag_log format ["WEATHER!!!!!!!!!!!!!!! _fogSetting: %1", _fogSetting];
diag_log format ["WEATHER!!!!!!!!!!!!!!! _currentTemplate: %1", _currentTemplate];

//_weatherTransitionTime setfog _fogSetting;
//_weatherTransitionTime setlightnings (_currentTemplate select 3);

systemchat str _currentTemplate;

if(_initial) then {
	skiptime -24;
	skiptime 24;
	0*A3E_Param_TimeMultiplier setovercast (_currentTemplate select 0);
	0*A3E_Param_TimeMultiplier setrain _rainSetting;
	0*A3E_Param_TimeMultiplier setfog _fogSetting;
	0*A3E_Param_TimeMultiplier setlightnings (_currentTemplate select 3);
	simulWeatherSync;
	forceWeatherChange;
};

sleep 1.0;


//Sleep _weatherTransitionTime ingame seconds
systemchat ("Weatherchange in "+str (_weatherTransitionTime/A3E_Param_TimeMultiplier) + " seconds");
sleep (_weatherTransitionTime/A3E_Param_TimeMultiplier);

//Keep the weather 10 realtime minutes
_weatherWaitTime*A3E_Param_TimeMultiplier setovercast (_currentTemplate select 0);
_weatherWaitTime*A3E_Param_TimeMultiplier setrain _rainSetting;
_weatherWaitTime*A3E_Param_TimeMultiplier setfog _fogSetting;
_weatherWaitTime*A3E_Param_TimeMultiplier setlightnings (_currentTemplate select 3);
simulWeatherSync;

//Keep the weather 10 minutes
systemchat ("Keeping weather for "+str (_weatherWaitTime) + " seconds");
sleep _weatherWaitTime;

if(A3E_Param_DynamicWeather == 1) then {
	systemchat "Restarting weather script";
	[false] spawn A3E_fnc_Weather;
} else {
	systemchat "Keeping weather constant";
};
