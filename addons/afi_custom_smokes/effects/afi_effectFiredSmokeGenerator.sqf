/*
	Name: 		RHS_fnc_effectFiredSmokeGenerator

	Desc:		Muzzle effect for vehicle exhaust smoke generators

	Param(s):	std fired event output

	Returns:	null

	Author:		Jiaan "Bakerman"
*/

private ["_unit", "_lifetime", "_effects", "_class", "_pos", "_dir", "_points"];

// Input
_unit = _this select 0;			// Shooter object

// Effect lifetime
_lifetime = getNumber (configFile >> "cfgWeapons" >> _this select 1 >> "reloadTime");
if (_lifetime == 0) exitWith {};

// Generator requires fuel to operate
if (fuel _unit == 0) exitWith {};

// Generator requires engine to be on
if (!isEngineOn _unit) then {
	if (local _unit) then {
		_unit engineOn true;
	};
};

// Helper function for effects
_effects = {

	private ["_pointPos", "_pointDir", "_unit", "_lifetime", "_count", "_exhaustPos", "_exhaustDir", "_fx1", "_vector"];

	_pointPos = _this select 0;
	_pointDir = _this select 1;
	_unit = _this select 2;
	_lifetime = (_this select 3) + 0.5;
	_count = _this select 4;

	_pointPos = _unit selectionPosition [_pointPos, "Memory"];
	_exhaustPos = _unit modelToWorldVisual _pointPos;
	_exhaustDir = _unit modelToWorldVisual (_unit selectionPosition [_pointDir, "Memory"]);
	_vector = _exhaustPos vectorFromTo _exhaustDir;
	_vector set [2, sqrt((_vector select 2) + 1) - 1];
	_vectorFlat = [_vector select 0, _vector select 1, 0];

	_fx1 = "#particlesource" createVehicleLocal _exhaustPos;
	_fx1 setParticleClass "RHS_SmokeGenerator";
	switch particlesQuality do {
		case 2: {
			_fx1 setDropInterval (0.01 * _count);
		};
		case 1: {
			_fx1 setDropInterval (0.025 * _count);
		};
		default {
			_fx1 setDropInterval (0.1 * _count);
		};
	};
	_fx1 setParticleRandom [
		15,															// lifetime
		[0,0,0], 														// Position
		[1.5,1.5,0], 													// velocity
		1, 																// Rotation velocity
		0.2, 															// Size
		[0, 0, 0, 0], 													// Color
		0.25, 															// Random dir period
		0.05															// Random dir intensity
	];
	_fx1 setParticleParams [
		["\A3\data_f\cl_basic.p3d",1,0,1], 		//object
		"",																//Animation name
		"Billboard",													//Type
		1,																//Timer periods
		45, 															//Life time
		_pointPos,														//Position
		_vectorFlat vectorMultiply (random 2 + 1),						//move velocity
		1, 																//rotation velocity
		2.229,															//weight
		1.75,											//volume
		0.04,															//rubbing
		[0.5, 6, 8],															//size
		[
			[ 1.0, 1.0, 1.0, 0.2 ],
			[ 1.0, 1.0, 1.0, 0.6 ],
			[ 1.0, 1.0, 1.0, 0.8 ],
			[ 1.0, 1.0, 1.0, 0.6 ],
			[ 1.0, 1.0, 1.0, 0.5 ],
			[ 1.0, 1.0, 1.0, 0.0 ]
		], 																//color
		[1],															//Animation Phase
		0,																//Random dir
		0, 																//Random dir intensity
		"", 															//On timer
		"", 															// before destroy
		_unit,
		0, 																//angle
		true, 															//on surface
		0.5 															//bounce on surface
	];

	[_lifetime, [_fx1]] spawn {
		uiSleep (_this select 0);
		{ deleteVehicle _x } forEach (_this select 1);
	};

};

// Call effect for each vehicle exhaust
_points = [];
for "_i" from 1 to 2 do {
	_class = configFile >> "CfgVehicles" >> typeOf _unit >> "Exhausts" >> format["Exhaust%1", _i];
	if (isClass _class) then {
		_pos = getText (_class >> "position");
		_dir = getText (_class >> "direction");
		if (_pos != "" && _dir != "") then {
			_points pushBack [_pos, _dir];
		};
	};
};
{
	[_x select 0, _x select 1, _unit, _lifetime, count _points] spawn _effects;
} forEach _points;