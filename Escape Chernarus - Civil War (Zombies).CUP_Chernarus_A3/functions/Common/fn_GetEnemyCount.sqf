params [["_modifier", 1.0, [0]]];
private ["_enemyFrequency","_minEnemies","_maxEnemies","_return"];
_enemyFrequency = (A3E_Param_EnemyFrequency);
_minEnemies = 3;
_maxEnemies = 10;
if (_modifier < 0) then {_modifier = 1};

private _playergroup = [] call A3E_fnc_getPlayerGroup;
private _numplayers = count units _playergroup;

switch (A3E_Param_EnemyFrequency) do
{
    case 0: // Enemy 0.5:1
    {
        _minEnemies = 3;
        A3E_EnemyFrequency = 1;
    };
    case 1: // Enemy 1.0:1
    {
        _minEnemies = ceil (_numplayers * 1.0  * _modifier);
        A3E_EnemyFrequency = 1;
    };
    case 2: // Enemy 1.5:1
    {
        _minEnemies = ceil (_numplayers * 1.5  * _modifier);
        A3E_EnemyFrequency = 2;
    };
    case 3: // Enemy 2.0:1
    {
        _minEnemies = ceil (_numplayers * 2.0  * _modifier);
        A3E_EnemyFrequency = 2;
    };
    case 4: // Enemy 3.0:1
    {
        _minEnemies = ceil (_numplayers * 3.0  * _modifier);
        A3E_EnemyFrequency = 3;
    };
    case 5: // Enemy 4.0:1
    {
        _minEnemies = ceil (_numplayers * 4.0  * _modifier);
        A3E_EnemyFrequency = 3;
    };
    case 10: // Enemy 10.0:1
    {
        _minEnemies = ceil (_numplayers * 4.0  * _modifier);
        A3E_EnemyFrequency = 3;
    };
    case 20: // Enemy 20.0:1
    {
        _minEnemies = ceil (_numplayers * 10.0  * _modifier);
        A3E_EnemyFrequency = 3;
    };
    default // Enemy 1.0:1
    {
        _minEnemies = ceil (_numplayers * 20.0  * _modifier);
        A3E_EnemyFrequency = 1;
    };
};
//_minEnemies = _minEnemies + 1;
if (_minEnemies < 1) then {_minEnemies = 1};
_maxEnemies = _minEnemies + 2;
_return = [_minEnemies,_maxEnemies];
_return
