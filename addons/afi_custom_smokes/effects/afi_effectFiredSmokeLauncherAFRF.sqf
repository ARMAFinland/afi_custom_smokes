/*
	Name: 		RHS_fnc_effectFiredSmokeLauncher

	Desc:		Muzzle effect for vehicle smoke launchers

	Param(s):	std fired event output

	Returns:	null

	Author:		Jiaan "Bakerman"
*/

private ["_unit", "_launcher", "_ammo", "_mag", "_count", "_curnt", "_speed", "_posBeg", "_posEnd", "_vector", "_launchPos", "_launchVel", "_shell", "_particle"];

// Input
_unit = _this select 0;			// Shooter object
_launcher = _this select 1;		// Weapon string
_ammo = _this select 4;			// Ammo string
_mag = _this select 5;			// Magazine string

// Ammo count
_count = getNumber (configFile >> "cfgMagazines" >> _mag >> "count");
_curnt = _count - (_unit ammo _launcher);
if (_curnt == 0) then { _curnt = _count; };

// Shell speed
_speed = getNumber (configFile >> "cfgMagazines" >> _mag >> "initSpeed");

// Position & Vector
_posBeg = _unit modelToWorldVisual (_unit selectionPosition [format ["smoke%1", _curnt], "Memory"]);
_posEnd = _unit modelToWorldVisual (_unit selectionPosition [format ["smoke%1_dir", _curnt], "Memory"]);
_vector = _posBeg vectorFromTo _posEnd;

// Get launch position and velocity for shell
_launchPos = _posBeg vectorAdd _vector;
_launchVel = _vector vectorMultiply _speed;

// Fire shells where main turret is local
if (_unit turretLocal [0]) then {
	// Create and fire shell from launcher
	_shell = createVehicle [getText(configFile >> "cfgAmmo" >> _ammo >> "rhs_smokeShell"), _launchPos, [], 0, "CAN_COLLIDE"];
	_shell setVectorUp _vector;
	_shell setVelocity _launchVel;
};

// Crate and fire smoke cap particle
_particle = "#particlesource" createVehicleLocal _posBeg;
_particle setParticleClass "RHS_tank_Catridge";
_particle setParticleParams
[
	["\A3\data_f\cl_basic.p3d", 1, 0, 1], //shape name
	"", //animation name
	"Billboard", //type
	1, 45, //timer period & life time
	[0, 0, 0], //position
	(velocity _unit) vectorAdd (_vector vectorMultiply (10 + random 10)), //moveVelocity
	3 + random 3, 2.23, 1.75, 0.04, //rotation velocity, weight, volume, rubbing
	[4, 8, 10, 12], //size
	[[ 1.0, 1.0, 1.0, 0.2 ], [ 1.0, 1.0, 1.0, 0.6 ], [ 1.0, 1.0, 1.0, 0.8 ], [ 1.0, 1.0, 1.0, 0.6 ], [ 1.0, 1.0, 1.0, 0.5 ], [ 1.0, 1.0, 1.0, 0.0 ]], //color
	[0], //animationPhase (animation speed in config)
	0.3, //randomdirection period
	1, //random direction intensity
	"", //onTimer
	"", //before destroy
	_particle, //object
	0, //angle
	true, //on surface
	1 //bounce on surface
];
_particle setDropInterval 10;
_particle spawn {
	uiSleep 1;
	deleteVehicle _this;
};