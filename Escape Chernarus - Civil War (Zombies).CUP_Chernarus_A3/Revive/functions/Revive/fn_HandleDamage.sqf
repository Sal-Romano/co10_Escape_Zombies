params["_unit","_hitSelection","_damage","_source","_projectile","_hitPartIndex","_instigator","_hitPoint"];
//["HitFace","HitNeck","HitPelvis","HitAbdomen","HitDiaphragm","HitChest","HitArms","HitHead","HitBody","HitHands","HitLegs"]
//["face_hub","neck","pelvis","spine1","spine2","spine3","arms","head","body","hands","legs"]

private ["_damageMultiplier","_limitHead","_limitBody","_limitLimbs","_limitHands","_limitOverall","_upperLimit","_oldDamage","_newDamage","_injuredAnimations"];

_oldDamage = 0.0;
_newDamage = 0.0;
_upperLimit = 1.0;
_damageMultiplier = 0.75;

// Damage multipliers.  The damage of each projectile will be multiplied by this number.
_damageMultiplier = AT_Revive_PlayerDamage;

/*
_limitHead =_upperLimit * _damageMultiplier;
_limitBody = _upperLimit * _damageMultiplier;
_limitLimbs = _upperLimit * _damageMultiplier;
_limitHands = _upperLimit * _damageMultiplier;
_limitOverall = _upperLimit * _damageMultiplier;
*/


_limitHead = 0.9 * _damageMultiplier;
_limitBody = 0.8 * _damageMultiplier;
_limitLimbs = 0.6 * _damageMultiplier;
_limitHands = 0.3 * _damageMultiplier;
_limitOverall = 0.9 * _damageMultiplier;

if ((headgear _unit) in A3E_arr_PlayerHelmets) then
{
	_limitHead = 0.5 * _damageMultiplier;
};

if ((vest _unit) in A3E_arr_PlayerVests) then
{
	_limitBody = 0.4 * _damageMultiplier;
};

if (_hitSelection isEqualTo "") then {_oldDamage = damage _unit} else {_oldDamage = _unit getHit _hitSelection};
_newDamage = _damage - _oldDamage max 0;

// Infantry selections
// Keep in mind that if revive is enabled then incapacitation may occur at around 0.7 damage.
// "": The overall damage that determines the damage value of the unit. Unit dies at damage equal to or above 1
// "face_hub": Unit dies at damage equal to or above 1
// "neck": Unit dies at damage equal to or above 1
// "head": Unit dies at damage equal to or above 1
// "pelvis": Unit dies at damage equal to or above 1
// "spine1": Unit dies at damage equal to or above 1
// "spine2": Unit dies at damage equal to or above 1
// "spine3": Unit dies at damage equal to or above 1
// "body": Unit dies at damage equal to or above 1
// "arms": Unit doesn't die with damage to this part
// "hands": Unit doesn't die with damage to this part
// "legs": Unit doesn't die with damage to this part

// Do any other damage calculations here
// _damage is the previous damage plus any new damage and will be applied
// as the total damage the unit has for this selection once this EH returns

// Only modify damage if it is a known projectile (leave falling damage etc alone)
//if (_newDamage > 0 && !(_projectile isEqualTo "")) then { // original
if (_newDamage > 0) then {
	// Reduce damage by damage multiplier
	switch (_hitSelection) do {
		case "face_hub": {
			_upperLimit = _limitHead;
		};
		case "head": {
			_upperLimit = _limitHead;
		};
		case "arms": {
			_upperLimit = _limitLimbs;
		};
		case "hands": {
			_upperLimit = _limitHands;
		};
		case "legs": {
			_upperLimit = _limitLimbs;
		};
		case "": {
			_upperLimit = 1.0;
		};
		default { 
			_upperLimit = _limitBody;
		};
	};
};

_newDamage = _newDamage * _damageMultiplier;

// Place an upper limit on projectile damage done at once
if (_newDamage >= _upperLimit) then
{
	_newDamage = _upperLimit;
};

_injuredAnimations = [
	"amovpknlmstpsraswrfldnon",
	"amovppnemstpsnonwnondnon_amovppnemstpsraswpstdnon_end",
	"amovpercmrunsraswpstdfl",
	"amovpercmtacsraswpstdl",
	"amovppnemstpsraswpstdnon_turnr",
	"AmovPpneMstpSrasWpstDnon_turnL",
	"amovpercmrunsraswrfldl",
	"amovpercmevasraswrfldf",
	"amovpercmrunsraswrfldf",
	"amovpercmstpsraswrfldnon",
	"amovpknlmrunsraswrfldf",
	"amovpknlmtacsraswrfldl",
	"amovpercmstpsraswpstdnon",
	"amovpknlmwlksraswrfldl",
	"amovPpneMstpSrasWrflDnon",
	"AmovPercMrunSlowWrflDf_AmovPpneMstpSrasWrflDnon",
	"AmovPercMrunSlowWrflDnon_transition",
	"unconscious",
	"unconsciousoutprone"
];

if (((animationState _unit) in _injuredAnimations) && (stance _unit == "PRONE")) then
{
    _newDamage = 0.0;
    diag_log "Damage is blocked!";
};


_damage = _oldDamage + _newDamage;

diag_log format ["HandleDamage: _source: %1 _projectile: %2 _hitSelection: %3 _instigator: %4 _damage: %5 _newDamage: %6 _upperLimit: %7, _damageMultiplier: %8",_source, _projectile, _hitSelection, _instigator, _damage, _newDamage, _upperLimit, _damageMultiplier];


if (alive _unit
	&& {_damage >= 1}
	&& {!(_unit getVariable ["AT_Revive_isUnconscious",false])}
	&& {_hitSelection in ["","head","face_hub","head_hit","neck","spine1","spine2","spine3","pelvis","body"]}
) then {
	_unit setDamage 0;
	_unit allowDamage false;
	_damage = 0;
	[_unit, _source] spawn ATR_FNC_Unconscious;
	diag_log format ["%1 SHOULD BE DEAD NOW",_unit];
};
_damage;
