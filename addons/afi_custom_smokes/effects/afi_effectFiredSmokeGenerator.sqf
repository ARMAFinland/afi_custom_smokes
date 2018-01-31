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

	private ["_pointPos", "_pointDir", "_unit", "_lifetime", "_count", "_exhaustPos", "_exhaustDir", "_fx1", "_fx2", "_fx3", "_fx4", "_vector"];

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
	_fx1 setDropInterval 0.025;
	_fx1 setParticleRandom [
		1,																// lifetime
		[0,0,0], 														// Position
		[1,1,1], 														// velocity
		1, 																// Rotation velocity
		0, 																// Size
		[0, 0, 0, 0], 													// Color
		0.15, 															// Random dir period
		0.10															// Random dir intensity
	];
	_fx1 setParticleParams [
		["\A3\data_f\ParticleEffects\Universal\smoke.p3d",1,0,1], 		//object
		"",																//Animation name
		"Billboard",													//Type
		1,																//Timer periods
		4, 																//Life time
		_pointPos,														//Position
		_vector vectorMultiply (random 2 + 4),							//move velocity
		1, 																//rotation velocity
		1.277,															//weight
		0.950 + random 0.025,											//volume
		0.075,															//rubbing
		[
			0.4,
			3,
			4
		],																//size
		[
			[ 0.8, 0.8, 0.8, 0.15 ],
			[ 0.8, 0.8, 0.8, 0.10 ],
			[ 0.8, 0.8, 0.8, 0.05 ],
			[ 0.8, 0.8, 0.8, 0.01 ],
			[ 0.8, 0.8, 0.8, 0.0 ]
		], 																//color
		[1],															//Animation Phase
		0,																//Random dir
		0, 																//Random dir intensity
		"", 															//On timer
		"", 															// before destroy
		_unit
	];

	_fx2 = "#particlesource" createVehicleLocal _exhaustPos;
	_fx2 setDropInterval 0.025;
	_fx2 setParticleRandom [
		1,																// lifetime
		[0,0,0], 														// Position
		[1,1,1], 														// velocity
		1, 																// Rotation velocity
		0, 																// Size
		[0, 0, 0, 0], 													// Color
		0.15, 															// Random dir period
		0.10															// Random dir intensity
	];
	_fx2 setParticleParams [
		["\A3\data_f\ParticleEffects\Universal\smoke.p3d",1,0,1], 		//object
		"",																//Animation name
		"Billboard",													//Type
		1,																//Timer periods
		4, 																//Life time
		_pointPos,														//Position
		_vectorFlat vectorMultiply (random 2 + 4),							//move velocity
		1, 																//rotation velocity
		1.277,															//weight
		0.990 + random 0.045,											//volume
		0.075,															//rubbing
		[
			0.4,
			3,
			4
		],																//size
		[
			[ 0.8, 0.8, 0.8, 0.15 ],
			[ 0.8, 0.8, 0.8, 0.10 ],
			[ 0.8, 0.8, 0.8, 0.05 ],
			[ 0.8, 0.8, 0.8, 0.01 ],
			[ 0.8, 0.8, 0.8, 0.0 ]
		], 																//color
		[1],															//Animation Phase
		0,																//Random dir
		0, 																//Random dir intensity
		"", 															//On timer
		"", 															// before destroy
		_unit
	];

	_fx3 = "#particlesource" createVehicleLocal _exhaustPos;
	switch particlesQuality do {
		case 2: {
			_fx3 setDropInterval (0.050 * _count);
		};
		case 1: {
			_fx3 setDropInterval (0.075 * _count);
		};
		default {
			_fx3 setDropInterval (0.100 * _count);
		};
	};
	_fx3 setParticleRandom [
		1,															// lifetime
		[0,0,0], 														// Position
		[1.5,1.5,0], 													// velocity
		1, 																// Rotation velocity
		0.4, 															// Size
		[0, 0, 0, 0], 													// Color
		0.15, 															// Random dir period
		0.025															// Random dir intensity
	];
	_fx3 setParticleParams [
		["\A3\data_f\cl_basic.p3d",1,0,1], 		//object
		"",																//Animation name
		"Billboard",													//Type
		1,																//Timer periods
		6, 															//Life time
		_pointPos,														//Position
		_vectorFlat vectorMultiply (random 3 + 2),							//move velocity
		1, 																//rotation velocity
		1.277,															//weight
		0.985 + random 0.035,											//volume
		0.075,															//rubbing
		[
			1,
			3,
			4
		],																//size
		[
			[ 1.0, 1.0, 1.0, 0.0 ],
			[ 1.0, 1.0, 1.0, 0.10 ],
			[ 1.0, 1.0, 1.0, 0.15 ],
			[ 1.0, 1.0, 1.0, 0.10 ],
			[ 1.0, 1.0, 1.0, 0.05 ],
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
		0.25 															//bounce on surface
	];

	_fx4 = "#particlesource" createVehicleLocal _exhaustPos;
	_fx4 setParticleClass "RHS_SmokeGenerator";
	switch particlesQuality do {
		case 2: {
			_fx4 setDropInterval (0.035 * _count);
		};
		case 1: {
			_fx4 setDropInterval (0.045 * _count);
		};
		default {
			_fx4 setDropInterval (0.100 * _count);
		};
	};
	_fx4 setParticleRandom [
		0.5,															// lifetime
		[0,0,0], 														// Position
		[1.5,1.5,0], 													// velocity
		1, 																// Rotation velocity
		0.6, 															// Size
		[0, 0, 0, 0], 													// Color
		0.5, 															// Random dir period
		0.05															// Random dir intensity
	];
	_fx4 setParticleParams [
		["\A3\data_f\cl_basic.p3d",1,0,1], 		//object
		"",																//Animation name
		"Billboard",													//Type
		1,																//Timer periods
		60, 															//Life time
		_pointPos,														//Position
		_vectorFlat vectorMultiply (random 3 + 2),							//move velocity
		1, 																//rotation velocity
		1.299,															//weight
		0.985 + random 0.045,											//volume
		0.05,															//rubbing
		[
			0.2,
			6
		],																//size
		[
			[ 1.0, 1.0, 1.0, 0.01 ],
			[ 1.0, 1.0, 1.0, 0.25 ],
			[ 1.0, 1.0, 1.0, 0.50 ],
			[ 1.0, 1.0, 1.0, 1 ],
			[ 1.0, 1.0, 1.0, 0.75 ],
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
		0.25 															//bounce on surface
	];

	[_lifetime, [_fx1, _fx2, _fx3, _fx4]] spawn {
		sleep (_this select 0);
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