params["_unit"];
private _intelItems = missionnamespace getvariable ["A3E_IntelItems",["DocumentsSecret"]];
private _chance = missionnamespace getvariable ["A3E_Param_IntelChance",50];

if(_chance >= random 100) then {
	private _intAmount = selectRandom [1,1,1,1,2];
	for [{ _i = 0 }, { _i < _intAmount }, { _i = _i + 1 }] do {
		_unit addMagazineGlobal (selectRandom _intelItems);
	};
};



