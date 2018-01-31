class CfgPatches {
	class afi_custom_smokes {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F","rhsusf_c_weapons","rhs_c_weapons","rhs_c_heavyweapons"};
	};
};

class CfgFunctions {
	class AFI {
		tag = "AFI";
		class WeaponsEH {
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
		class afi_fnc_effectFiredSmokeGenerator {
			allowedTargets = 0;
		};
		class afi_effectFiredSmokeLauncherUS {
			allowedTargets = 0;
		};
	};
};

class CfgAmmo {
	class GrenadeHand;
	class SmokeLauncherAmmo;
	class SmokeShell: GrenadeHand {
		deflecting =70;
		deflectionSlowDown=0.3;
		timeToLive = 120;
		simulation = "shotSmoke";
	};

	//Vehicle smokes
	class rhs_ammo_smokegen: SmokeLauncherAmmo {
		muzzleEffect = "";
		rhs_muzzleEffect = "afi_fnc_effectFiredSmokeGenerator";
		weaponLockSystem = "2";
		simulation = "shotCM";
		AIAmmoUsageFlags = "4";
		hit = 0;
		indirectHit = 0;
		indirectHitRange = 0;
	};
};

class CfgMods {
	author = "Johnson";
	authorUrl = "www.armafinland.fi";
};