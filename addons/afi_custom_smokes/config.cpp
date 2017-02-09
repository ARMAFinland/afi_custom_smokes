class CfgPatches {
	class afi_custom_smokes {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F","rhsusf_c_weapons","rhs_c_weapons","rhs_c_heavyweapons","Blastcore_SmokeCS"};
	};
};

class CfgFunctions {
	class AFI {
		tag = "AFI";
		class WeaponsEH {
			class effectFiredSmokeLauncher {
				file = "\afi_custom_smokes\effects\afi_effectFiredSmokeLauncher.sqf";
				description = "Effects for smoke launcher";
			};
			class effectFiredSmokeLauncherBoat {
				file = "\afi_custom_smokes\effects\afi_effectFiredSmokeLauncher.sqf";
				description = "Effects for boat smoke launcher";
			};
			class effectFiredSmokeLauncherAFRF {
				file = "\afi_custom_smokes\effects\afi_effectFiredSmokeLauncherAFRF.sqf";
				description = "Effects for russian smoke launcher";
			};
			class effectFiredSmokeGenerator{
				file = "\afi_custom_smokes\effects\afi_effectFiredSmokeGenerator.sqf";
				description = "Effects for smoke generator";
			};
		};
	};
};

class CfgRemoteExec {
	class Functions {
		mode = 2;
		jip = 1;
		class afi_fnc_effectFiredSmokeLauncher {
			allowedTargets = 0;
		};
		class afi_fnc_effectFiredSmokeLauncherBoat {
			allowedTargets = 0;
		};
		class afi__fnc_effectFiredSmokeLauncherAFRF {
			allowedTargets = 0;
		};
		class afi_fnc_effectFiredSmokeGenerator {
			allowedTargets = 0;
		};
	};
};

class CfgAmmo {
	class GrenadeHand;
	class Grenade;
	class SmokeShellRed;
	class SmokeShellGreen;
	class SmokeShellYellow;
	class SmokeShell: GrenadeHand {
		deflecting =70;
		deflectionSlowDown=0.3;
		timeToLive = 120;
		simulation = "shotSmoke";
	};

	//USF
	//GL smokes
	class rhs_40mm_smoke_red: SmokeShellRed {
		smokeColor[] = {0.9,0.1,0.1,0.3};
	};
	class rhs_40mm_smoke_green: SmokeShellGreen	{
		smokeColor[] = {0.2,0.9,0.2,0.3};
	};
	//Throwable
	class rhs_ammo_m18_green: SmokeShell {
		smokeColor[] = {0.2,0.9,0.2,0.3};
	};
	class rhs_ammo_m18_purple: rhs_ammo_m18_green {
		smokeColor[] = {0.4341,0.1388,0.4144,0.3};
	};
	class rhs_ammo_m18_red: rhs_ammo_m18_green {
		smokeColor[] = {0.9,0.1,0.1,0.3};
	};
	class rhs_ammo_m18_yellow: rhs_ammo_m18_green {
		smokeColor[] = {0.9883,0.8606,0.0719,0.3};
	};

	//AFRF
	//GL smokes
	class rhs_g_vog25;
	class rhs_g_vg40md_white: rhs_g_vog25 {
		deflecting =70;
		deflectionSlowDown=0.3;
		simulation = "shotSmoke";
	};
	class rhs_g_vg40md_green: rhs_g_vg40md_white {
		smokeColor[] = {0.2,0.9,0.2,0.3};
		effectsSmoke = "SmokeShellGreenEffect";
	};
	class rhs_g_vg40md_red: rhs_g_vg40md_white {
		smokeColor[] = {0.9,0.1,0.1,0.3};
		effectsSmoke = "SmokeShellRedEffect";
	};

	//Vehicle smokes
	class BulletBase;
	class SmokeLauncherAmmo: BulletBase	{
		muzzleEffect="";
		rhs_muzzleEffect = "afi_fnc_effectFiredSmokeLauncher";
		effectsSmoke = "";
		timeToLive = 10.0;
		thrustTime = 10.0;
		airFriction = -0.1;
		initTime = 1;
	};
	class rhs_ammo_3d17: SmokeLauncherAmmo {
		rhs_muzzleEffect = "afi__fnc_effectFiredSmokeLauncherAFRF";
	};
	class rhs_ammo_smokegen: SmokeLauncherAmmo {
		muzzleEffect = "";
		rhs_muzzleEffect = "afi_fnc_effectFiredSmokeGenerator";
	};
	class SmokeShellVehicle: SmokeShell	{
		effectsSmoke = "";
		timeToLive=60;

	};
	class rhs_ammo_3d17_shell: Grenade {
		hit = 0;
		indirectHit = 0;
		indirectHitRange = 0;

	};
};

class CfgMagazines {
	class VehicleMagazine;
	class SmokeLauncherMag: VehicleMagazine	{
		ammo = "SmokeLauncherAmmo";
		initSpeed = 30;
		count = 1;
	};
	class rhs_mag_3d17: SmokeLauncherMag {
		initSpeed = 30;
		ammo = "rhs_ammo_3d17";
	};
};

class CfgCloudlets {
	class Default;
	class SmokeShellWhite: Default {
		interval=0.07;
		size[]={0.5,6,7};
		color[]= {{1,1,1,0.9}, {1,1,1,0}
		};
		weight=10.09;
		volume=7.9;
		rubbing=1;
		OnSurface=1;
		BounceOnSurface=1;
		lifeTime=45;
		lifeTimeVar=15;
		randomDirectionPeriodVar = 0;
   		randomDirectionIntensityVar = 0;
   		moveVelocityVar[] = {0, 0, 0};
   		moveVelocityVarConst[] = {0, 0, 0};
	};
	class SmokeShellWhiteLong: Default {
		interval=0.2;
		size[]={0.5,6,7};
		color[]= {{0.9,0.9,0.9,0.9}, {1,1,1,0}
		};
		weight=10.09;
		volume=7.9;
		rubbing=1;
		OnSurface=1;
		BounceOnSurface=1;
		lifeTime=45;
		lifeTimeVar=15;
		randomDirectionPeriodVar = 0;
    	randomDirectionIntensityVar = 0;
    	moveVelocityVar[] = {0, 0, 0};
    	moveVelocityVarConst[] = {0, 0, 0};
	};
};

class SmokeShellVehicleEffect {
	class SmokeShell {
		simulation = "particles";
		type = "SmokeShellVehicleWhite";
		position[] = {0,0,0};
		intensity = 1;
		interval = 1;
	};
};
class CfgMods {
	author = "Johnson";
	authorUrl = "www.armafinland.fi";
};