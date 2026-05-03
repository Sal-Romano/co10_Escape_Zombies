if(isNil("AT_Revive_StaticRespawns")) then {
	AT_Revive_StaticRespawns = [];
};
if(isNil("AT_Revive_EnableRespawn")) then {
	AT_Revive_EnableRespawn = true;
};
if(isNil("AT_Revive_clearedDistance")) then {
	AT_Revive_clearedDistance = 100;
};
if(isNil("ATHSC_Cam")) then {
	ATHSC_Cam = objNull;
};
if(!isNull ATHSC_Cam) then {
	[] call ATHSC_fnc_exit;
};
ATHSC_Cam = objNull;
ATHSC_CamTarget = player;
ATHSC_AttempRespawn = false;
ATHSC_AttempRespawnCounter = 0;
ATHSC_NVEnabled = false;
ATHSC_CamDir = random 360;
ATHSC_CamDistance = 15;
ATHSC_CamAngle = 45;
ATHSC_Perspective = 1;
ATHSC_KeyPress = [];
ATHSC_Cam = "camera" camCreate (eyePos player);
cutText ["", "BLACK",0.1];
[0] call ATHSC_fnc_updatePerspective;
sleep 0.5;

painscream = player addAction ["<t color='#C00000'>Scream in Agonizing Pain</t>",{

	 _randomElement = selectRandom["Scream","Scream2","Scream3","Scream4","Scream5","Scream6","Scream7","Scream8","Scream9","Scream10","Scream11","Scream12","Scream13","Scream14","Scream15","Scream16","Scream17","Scream18","Scream19","Scream20","Scream21","Scream22","Scream23","Scream24","Scream25","Scream26","Scream27","Scream28","Scream29","Scream30","Scream31","Scream32","Scream33","Scream34","Scream35","Scream36","Scream37","Scream38","Scream39","Scream40","Scream41"];

	 [player, _randomElement, 500] call CBA_fnc_globalSay3d;

},[],1,false]; 


ATHSC_KeyDownHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call ATHSC_FNC_keydown;"];
ATHSC_MouseHandler = (findDisplay 46) displayAddEventHandler ["MouseMoving", "_this call ATHSC_FNC_mouseMove;"];
ATHSC_MouseZHandler = (findDisplay 46) displayAddEventHandler ["MouseZChanged", "_this call ATHSC_FNC_mouseZMove;"];
//ATHSC_MouseKeyHandler = (findDisplay 46) displayAddEventHandler ["MouseButtonClick", "_this call ATHSC_FNC_mousekeyclick;"];


//ATHSC_Cam switchCamera "Internal";

showCinemaBorder false;
ATHSC_Cam camSetPos ((getpos player) vectorAdd ([[0,1,0],[ATHSC_CamAngle,0,ATHSC_CamDir]] call ATHSC_FNC_rotateVector));
ATHSC_Cam cameraEffect ["internal", "back"];
ATHSC_Cam camCommit 0;
ATHSC_Cam camSetTarget player;
[] spawn {
	sleep 0.5;
	cutText ["", "BLACK IN"];
	sleep 1.0;
	("HSC" call BIS_fnc_rscLayer) cutRsc ["HSC_View", "PLAIN", 2, false];
};
private _distance = ATHSC_CamDistance;
for[{_i=1},{_i<ATHSC_CamDistance},{_i=_i+1}] do {
	private _camVector = [[0,1,0],[ATHSC_CamAngle,0,ATHSC_CamDir]] call ATHSC_FNC_rotateVector;
	ATHSC_Cam camSetPos ((getpos player) vectorAdd (_camVector vectorMultiply _i));
	ATHSC_Cam camCommit 0.1;
	sleep 0.1;
};
ATHSC_CamDistance = _distance;
ATHSC_Run = true;

[] spawn ATHSC_fnc_camLoop;
