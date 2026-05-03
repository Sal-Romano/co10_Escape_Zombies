class Params
{
    class A3E_Param_Loadparams
    {
		title = "Parameter Load and Save (save params between sessions, see readme!)";
		values[] = {0, 1, 2};
		texts[] = {"Use settings below and save (settings will be restored on mission restart)", "Load previously saved settings (Use below if none found)", "Use settings below without saving"};
		default = 2;
	};
	class A3E_Param_Spacer1
    {
            title = "==================== Difficulty Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
    class A3E_Param_EnemySkill
	{
		title = "Enemy Skill";
		values[] = {0, 1, 2, 3, 4};
		texts[] = {"Cadet", "Easy", "Normal", "Hard", "Extreme"};
		livechanges = 1;
		default = 4;
	};
	class A3E_Param_EnemyFrequency
	{
		title="Enemy Groupsize Ratio";
		values[]={0,1,2,3,4,5,10,20};
		texts[]={"Enemy 0.5:1", "Enemy 1:1", "Enemy 1.5:1", "Enemy 2:1", "Enemy 3:1", "Enemy 4:1","Enemy 10:1","Enemy 20:1"};
		livechanges = 1;
		default = 0;
	};
	class A3E_Param_EnemySpawnDistance
	{
		title="Enemy Spawn Distance";
		values[]={500,800,1200};
		texts[]={"Short (500 - better performance, spawn in view possible)", "Medium - 800", "Far (1200 - for good rigs)"};
		default = 500;
	};
	class A3E_Param_VillageSpawnCount
	{
		title="Village Patrol Spawns";
		values[]={1, 2, 3};
		texts[]={"Low (better performance)", "Medium", "High (Very demanding)"};
		livechanges = 1;
		default = 1;
	};
	class A3E_Param_ReducePlayerDamage
	{
		title="Reduce damage taken by players";
		values[]={0,1,2,3,4,5};
		texts[]={"100% (normal)","75%", "60%","50%", "40%", "0% (invincible)"};
		default = 1;
	};
	class A3E_Param_NoStaminaAndFatigue
	{
		title="Player stamina & fatigue";
		values[]={0,1};
		texts[]={"On","Off"};
		default = 0;
	};
	class A3E_Param_SearchChopper
	{
		title="Search Chopper Type";
		values[]={0,1,2,3};
		texts[]={"Standard","Easy","Hard","Disable all enemy helicopters & aircraft"};
		default = 0;
	};
	class A3E_Param_Spacer2
    {
            title = "==================== Environment Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
	class A3E_Param_TimeOfDay	
	{	
	    title="Time Of Day";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26};
		texts[]={"00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","Random","Daytime","Nighttime"};
		default = 8;
		//function = "A3E_fnc_paramDaytime"; // (Optional) Function called when player joins, selected value is passed as an argument
	};
	class A3E_Param_TimeMultiplier	
	{	
	    title="Time Multiplier (Fasttime)";
		values[]={1,4,6,12,24,36};
		texts[]={"1:1 (Normal)","1:4 (Day = 6 Hours)","1:6 (Day = 4 Hours)","1:12 (Day = 2 Hours)","1:24 (Day = 1 Hour)","1:36 (Day = 40 Minutes)"};
		livechanges = 1;
		code = "if(isserver) then {setTimeMultiplier _this;};";
		default = 12;
	};
	class A3E_Param_Weather {
		title="Weather";
		values[] = {0,1,2,3,4,-1};
		texts[] = {"Clear","Overcast","Rain","Fog","Storm","Random"};
		default = -1;
	};
    class A3E_Param_UseCustomWeather {
		title="Use Custom Weather";
		values[] = {0,1};
		texts[] = {"Use mission managed weather","Use custom weather"};
		default = 0;
	};
    class A3E_Param_UseCustomDate {
		title="Use Custom Date (usually for guaranteed full moon)";
		values[] = {0,1};
		texts[] = {"Use mission managed date","Use custom date"};
		default = 1;
	};
	class A3E_Param_DynamicWeather {
		title="Dynamic Weather";
		values[] = {0,1};
		texts[] = {"Constant","Random"};
		default = 1;
	};
	class A3E_Param_Grass
	{	
		title="Grass Visibility (setTerrainGrid)";
        // Low = 50 (NoGrass)
        // Standard = 25
        // High = 12.5
        // Very High = 6.25
        // Ultra = 3.125
		values[]={16,8,4,2,1};
		texts[]={"No Grass (50.0)", "Proximity (25.0)", "Normal (12.5)", "Far (6.25)", "Very Far (3.125)"};
		default = 8;
	};
    class A3E_Param_ViewDistance
	{	
		title="View Distance (setViewDistance)";
		values[]={2000,4000,6000,10000};
		texts[]={"Close (2000)", "Normal (4000)", "Far (6000)", "Very Far (10000)"};
		default = 2000;
	};
    class A3E_Param_ObjectViewDistance
	{	
		title="Object View Distance (setObjectViewDistance)";
		values[]={1000, 2000, 2500,4000,5000};
		texts[]={"Super Close (1000)", "Close (2000)","Normal (2500)", "Far (4000)", "Very Far (5000)"};
		default = 1000;
	};
    class A3E_Param_ShadowViewDistance
	{	
		title="Shadow Draw Distance (setObjectViewDistance)";
		values[]={50,75,100,150,200,500};
		texts[]={"Super Close (50)", "Close (75)","Normal (100)", "Far (150)", "Very Far (200)", "Insane (500)"};
		default = 75;
	};
    class A3E_Param_DetailBlend
	{	
		title="Detail Blend Distance (setDetailMapBlendPars)";
		values[]={12,25,50,100,200};
		texts[]={"Super Close (12)","Close (25)", "Normal (50)", "Far (100)", "Very Far (200)"};
		default = 12;
	};
	class A3E_Param_Spacer3
    {
            title = "==================== Gameplay Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
	class A3E_Param_ForceEnemyFlashlights
	{
		title="Force Enemy soldiers to use flashlights";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 1;
	};
	class A3E_Param_UseIntel
	{
		title="Collect intel to reveal markers on map";
		values[]={0,1};
		texts[]={"Disabled","Enabled"};
		default = 1;
		tooltip = "This will enable the collection of intel from enemies. Intel will reveal locations on the map.";
	};
	class A3E_Param_IntelChance
	{
		title="Chance an enemy carries intel";
		values[]={0,5,10,20,30,40,50,100};
		texts[]={"0%","5%","10%","20%","30%","40%","50%","100%"};
		livechanges = 1;
		default = 10;
	};
	class A3E_Param_RevealMarkers
	{
		title="Display of markers on map";
		values[]={0,1,2,3};
		texts[]={"Always show (with type)","Always show marker but hide type (questionmark)","Show marker upon discovery","Never show markers"};
		default = 1;
	};
    class A3E_Param_RevealCrashSiteMarkers
	{
		title="Display of crash site markers on map";
		values[]={0,1,2};
		texts[]={"Never show","Show marker upon discovery","Always show"};
		default = 0;
	};
    class A3E_Param_MotorPools
	{
        title="Enable Motor Pools";
        values[]={0,1};
        texts[]={"Disabled - No motor pools","Random - Spawns motor pools, works for all maps"};
        default = 1;
	};
	class A3E_Param_VehicleLock
	{
		title="Lock Vehicles";
		values[]={0, 1, 2};
		texts[]={"None", "Armed", "All"};
		default = 0;
	};
	class A3E_Param_Artillery
	{
		title="Artillery";
		values[]={0.5,1,2};
		texts[]={"Reduced","Default","Death in fire"};
		livechanges = 1;
		default = 1;
	};
	class A3E_Param_War_Torn
	{
		title="War-Torn mode (CSAT and AAF are fighting each other)";
		values[]={0,1};
		texts[]={"Disabled","Enabled"};
		default = 1;
	};
	class A3E_Param_AmbientFlybys
	{
		title="Enable Ambient Flybys";
		values[]={0,1};
		texts[]={"Disabled","Enabled"};
		livechanges = 1;
		default = 1;
	};
	class A3E_Param_ReviveView
	{
		title="Unconscious View";
		values[]={0,1};
		texts[]={"First-/Third-Person","Hindsight Cam"};
		default = 1;
	};
	class A3E_Param_ExtractionSelection
	{
		title="Extraction Points";
		values[]={0, 1, 2};
		texts[]={"Random", "Close", "Far"};
		livechanges = 1;
		default = 2;
	};
	class A3E_Param_Waffelbox
	{
		title="Additional Weaponbox (with less random content) at depots";
		values[]={0,1};
		texts[]={"Off", "On"};
		default = 0;
	};
	class A3E_Param_NoNightvision
	{
		title="NVG-Goggles and TWS Scopes";
		values[]={0,1};
		texts[]={"All", "No Goggles and TWS"};
		livechanges = 1;
		default = 0;
	};
	class A3E_Param_NVGs
	{
		title="NV Goggles Allowed";
		values[]={0,1};
		texts[]={"No NVGs", "NVGs allowed"};
		default = 1;
	};
	class A3E_Param_NVScopes
	{
		title="NV and TWS Scopes";
		values[]={0,1,2};
		texts[]={"No NV or TW Scopes", "NV Scopes allowed", "NV and TWS Scopes Allowed"};
		default = 1;
	};
    class A3E_Param_Cigarettes
	{
		title="Add cigarettes to players";
		values[]={0,1};
		texts[]={"Cigarettes disabled","Cigarettes enabled"};
		default = 0;
	};
	class A3E_Param_Propaganda
	{
		title="Play propaganda at prison";
		values[]={0,1};
		texts[]={"Propaganda disabled","Propaganda enabled"};
		default = 1;
	};
	class A3E_Param_Spacer4
    {
            title = "==================== Statistic Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
	class A3E_Param_SendStatistics
	{
		title="Send statistics at mission end";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 1;
	};
	class A3E_Param_Spacer5
    {
            title = "==================== DLC Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
	class A3E_Param_UseDLCApex
	{
		title="Allow usage of units from Apex DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 0;
	};
	class A3E_Param_UseDLCHelis
	{
		title="Allow usage of units from Helicopters DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 0;
	};
	class A3E_Param_UseDLCMarksmen
	{
		title="Allow usage of premium classes from Marksmen DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 0;
	};
	/*class A3E_Param_UseDLCJets
	{
		title="Allow usage of units from Jets DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 0;
	};*/
	class A3E_Param_UseDLCLaws
	{
		title="Allow usage of units from Laws of War DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 0;
	};
	class A3E_Param_UseDLCTanks
	{
		title="Allow usage of units from Tanks DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 0;
	};
	class A3E_Param_UseDLCContact
	{
		title="Allow usage of units from Contact DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 1;
	};
	class A3E_Param_UseDLCSOGPF
	{
		title="Allow usage of units from S.O.G. Prairie Fire DLC";
		values[]={0,1};
		texts[]={"No", "Yes"};
		default = 0;
	};
	class A3E_Param_Spacer6
	{
            title = "==================== 3rd-party scripts ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
	class A3E_Param_Magrepack
	{
		title="Mag repack";
		values[]={0,1};
		texts[]={"Disabled", "Enabled"};
		default = 1;
	};
	class A3E_Param_Spacer7
    {
            title = "==================== Debug Settings ====================";
            values[] = {0};
            texts[] = {""};
            default = 0;
	};
	class A3E_Param_Debug
	{
		title="Debug (you should keep this off)";
		values[]={0,1};
		texts[]={"Off","On"};
		livechanges = 1;
		default = 0;
	};
	class PersistenceResetOnStart
	{
		title = "Reset persistence on mission start";
		values[] = {0,1}; 
		texts[] = {"false","true"}; // Description of each selectable item
		default = 0;
	};
};
