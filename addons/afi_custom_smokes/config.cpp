class CfgPatches {
	class afi_custom_smokes {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F","rhsusf_c_weapons","rhs_c_weapons","ace_particles"};
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
	};
	class rhs_g_vg40md_red: rhs_g_vg40md_white {
		smokeColor[] = {0.9,0.1,0.1,0.3};
	};
};

class CfgCloudlets {
	class Default;
	class ACE_SmokeBaseLarge: Default {
		lifeTime = 45;
		lifeTimeVar = 15;
	};
};

class CfgMods {
	author = "Johnson";
	authorUrl = "www.armafinland.fi";
};