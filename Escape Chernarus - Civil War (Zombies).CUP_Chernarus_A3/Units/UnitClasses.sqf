/*
 * Description: This file contains the vehicle types and unit types for the units spawned in the mission, and the weapons and magazines found in ammo boxes/cars.
 * "Random array" (used below) means that array will be used to spawn units, and that chance is 1/n that each element will be spawned on each spawn. The array can contain
 * many elements of the same type, so the example array ["Offroad_DSHKM_INS", "Pickup_PK_INS", "Pickup_PK_INS"] will spawn an Offroad with 1/3 probability, and a
 * Pickup with 2/3 probability.
 *
 * Chernarussian Civil War variant:
 * BLUFOR (west) = CDF government forces (your allies, extraction)
 * OPFOR (east) = ChDKZ/Chedaki communist rebels (main enemy)
 * IND (resistance) = NAPA nationalist partisans (secondary enemy)
 */

private ["_enemyFrequency"];

_enemyFrequency = _this select 0;

A3E_VAR_Side_Blufor = west;
A3E_VAR_Side_Opfor = east;
A3E_VAR_Side_Ind = resistance;
A3E_VAR_Side_Civ = civilian;

A3E_VAR_Flag_Opfor = "\A3\Data_F\Flags\Flag_CSAT_CO.paa";
A3E_VAR_Flag_Ind = "\A3\Data_F\Flags\Flag_FIA_CO.paa";

A3E_VAR_Side_Blufor_Str = format["%1",A3E_VAR_Side_Blufor];
A3E_VAR_Side_Opfor_Str = format["%1",A3E_VAR_Side_Opfor];
A3E_VAR_Side_Ind_Str = format["%1",A3E_VAR_Side_Ind];
A3E_VAR_Side_Civ_Str = format["%1",A3E_VAR_Side_Civ];

// Random array. Start position guard types around the prison.
// NAPA partisan guards (lower-tier)
a3e_arr_Escape_StartPositionGuardTypes = [
	"rhsgref_nat_pmil_rifleman",
	"rhsgref_nat_pmil_rifleman_akm",
	"rhsgref_nat_pmil_rifleman_aksu",
	"rhsgref_nat_pmil_grenadier",
	"rhsgref_nat_pmil_machinegunner",
	"rhsgref_nat_pmil_commander",
	"rhsgref_nat_pmil_medic",
	"rhsgref_nat_pmil_saboteur",
	"rhsgref_nat_pmil_scout",
	"rhsgref_nat_pmil_hunter"];

A3E_akMag = "rhs_30Rnd_762x39mm";
A3E_rpkMag = "rhs_75Rnd_762x39mm";

// Prison backpack secondary weapon (and corresponding magazine type).
a3e_arr_PrisonBackpackType = "rhs_sidor";

a3e_arr_PrisonBackpackWeapons = [];
a3e_arr_PrisonBackpackWeapons pushback ["rhs_weap_makarov_pmm","rhs_mag_9x18_12_57N181S"];
a3e_arr_PrisonBackpackWeapons pushback ["CUP_hgun_Makarov","CUP_8Rnd_9x18_Makarov_M"];
a3e_arr_PrisonBackpackWeapons pushback ["rhs_weap_pya","rhs_mag_9x19_17"];
a3e_arr_PrisonBackpackWeapons pushback ["rhs_weap_savz61","rhsgref_20rnd_765x17_vz61"];

a3e_arr_PrisonBackpackItems = [];
a3e_arr_PrisonBackpackItems pushback ["FirstAidKit",1];
a3e_arr_PrisonBackpackItems pushback ["Chemlight_green",1];

A3E_arr_PlayerVests = [
	"rvg_legstrapbag_1",
	"rvg_legstrapbag_2",
	"rvg_legstrapbag_3",
	"rvg_legstrapbag_4"
	];

A3E_arr_PlayerHelmets = [
	"Item_rhsusf_lwh_helmet_M1942",
	"Item_rhsusf_lwh_helmet_marpatd",
	"Item_rhsusf_lwh_helmet_marpatd_ess",
	"Item_rhsusf_lwh_helmet_marpatd_headset",
	"Item_rhsusf_lwh_helmet_marpatwd",
	"Item_rhsusf_lwh_helmet_marpatwd_blk_ess",
	"Item_rhsusf_lwh_helmet_marpatwd_headset_blk2",
	"Item_rhsusf_lwh_helmet_marpatwd_headset_blk",
	"Item_rhsusf_lwh_helmet_marpatwd_headset",
	"Item_rhsusf_lwh_helmet_marpatwd_ess"
	];

A3E_DataTerminal = "Land_DataTerminal_01_F"; // "Land_DataTerminal_01_F"; // "Vysilacka";

// Random array. Civilian vehicle classes for ambient traffic.
a3e_arr_Escape_MilitaryTraffic_CivilianVehicleClasses = [
	"CUP_C_Skoda_CR_CIV",
	"CUP_C_Skoda_Blue_CIV",
	"CUP_C_Skoda_Green_CIV",
	"CUP_C_Skoda_Red_CIV",
	"CUP_C_Skoda_White_CIV",
	"CUP_C_S1203_CIV_CR",
	"ford_e350_stock",
	"ford_e350_red",
	"NDS_6x6_ATV_CIV",
	"CUP_C_Datsun",
	"CUP_C_Datsun_4seat",
	"CUP_C_Datsun_Covered",
	"CUP_C_Volha_CR_CIV",
	"CUP_C_Golf4_black_Civ",
	"CUP_C_Golf4_blue_Civ",
	"CUP_C_Golf4_green_Civ",
	"CUP_C_Golf4_camodark_Civ",
	"CUP_C_Golf4_camodigital_Civ",
	"CUP_C_Golf4_white_Civ",
	"CUP_C_Golf4_yellow_Civ",
	"CUP_C_Golf4_random_Civ",
	"CUP_C_Golf4_Sport_random_Civ",
	"CUP_O_Hilux_unarmed_CR_CIV",
	"CUP_C_Ikarus_Chernarus",
	"CUP_C_Bus_City_CRCIV",
	"CUP_C_LR_Transport_CTK",
	"CUP_C_V3S_Open_TKC",
	"CUP_C_SUV_TK",
	"CUP_C_SUV_CIV",
	"CUP_C_Tractor_CIV",
	"CUP_C_Tractor_Old_CIV",
	"C_Van_01_transport_F",
	"C_Van_01_box_F",
	"CUP_C_TT650_RU",
	"CUP_C_Ural_Civ_03",
	"CUP_C_Ural_Open_Civ_03",
	"C_Van_02_transport_F",
	"CUP_C_Lada_CIV",
	"CUP_C_Lada_GreenTK_CIV",
	"CUP_C_Lada_TK2_CIV",
	"CUP_C_Lada_Red_CIV",
	"CUP_C_Lada_White_CIV",
	"C_Truck_02_fuel_F",
	"C_Truck_02_box_F",
	"C_Truck_02_transport_F",
	"C_Truck_02_covered_F"];


a3e_arr_Escape_MilitaryTraffic_CivilianClasses = [
    "mgsr_prisoner_olive_dirty",
    "mgsr_prisoner_olive_muddy",
    "mgsr_prisoner_olive",
    "C_man_polo_1_F",
    "C_man_polo_2_F",
    "C_man_polo_3_F",
    "C_man_polo_4_F",
    "C_Man_smart_casual_1_F",
    "C_Man_smart_casual_2_F",
    "C_Man_formal_1_F",
	"C_Man_formal_2_F",
	"C_Man_formal_3_F",
	"C_Man_formal_4_F",
	"C_Man_casual_1_F",
	"C_Man_casual_2_F",
	"C_Man_casual_3_F",
	"C_Man_casual_4_v2_F",
	"C_Man_casual_6_v2_F",
	"C_Man_casual_7_F",
	"C_Man_casual_8_F",
	"C_Man_casual_9_F"
    ];

// Random arrays. Enemy vehicle classes for ambient traffic.
// Variable _enemyFrequency applies to server parameter, and can be one of the values 1 (Few), 2 (Some) or 3 (A lot).
// Main enemy: ChDKZ/Chedaki insurgent vehicles (old Soviet equipment, technicals)
// IND: NAPA nationalist partisan vehicles
switch (_enemyFrequency) do {
    case 1: {//Few (1-3)
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses = [
		"rhsgref_ins_uaz",
		"rhsgref_ins_uaz",
		"rhsgref_ins_uaz_open",
		"rhsgref_ins_uaz_dshkm",
		"rhsgref_ins_uaz_dshkm",
		"rhsgref_ins_uaz_spg9",
		"rhsgref_ins_uaz_ags",
		"rhsgref_ins_ural",
		"rhsgref_ins_ural_open",
		"rhsgref_ins_gaz66",
		"rhsgref_ins_gaz66o",
		"rhsgref_ins_btr60",
		"rhsgref_ins_btr70",
		"rhsgref_ins_bmp1p",
		"rhsgref_ins_bmp1d",
		"rhsgref_ins_t72ba",
		"rhsgref_ins_zsu234"
		];
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses_IND = [
		"rhsgref_nat_uaz",
		"rhsgref_nat_uaz_open",
		"rhsgref_nat_uaz_dshkm",
		"rhsgref_nat_uaz_spg9",
		"rhsgref_nat_ural",
		"rhsgref_nat_ural_open",
		"rhsgref_nat_ural_work",
		"rhsgref_nat_ural_work_open",
		"rhsgref_nat_van",
		"rhsgref_nat_van_fuel",
		"rhsgref_nat_ural_Zu23"];
    };
    case 2: {//Some (4-6)
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses = [
		"rhsgref_ins_uaz",
		"rhsgref_ins_uaz",
		"rhsgref_ins_uaz_open",
		"rhsgref_ins_uaz_dshkm",
		"rhsgref_ins_uaz_dshkm",
		"rhsgref_ins_uaz_spg9",
		"rhsgref_ins_uaz_ags",
		"rhsgref_ins_ural",
		"rhsgref_ins_ural_open",
		"rhsgref_ins_gaz66",
		"rhsgref_ins_gaz66o",
		"rhsgref_ins_btr60",
		"rhsgref_ins_btr70",
		"rhsgref_ins_bmp1p",
		"rhsgref_ins_bmp1d",
		"rhsgref_ins_t72ba",
		"rhsgref_ins_zsu234"
		];
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses_IND = [
		"rhsgref_nat_uaz",
		"rhsgref_nat_uaz_open",
		"rhsgref_nat_uaz_dshkm",
		"rhsgref_nat_uaz_spg9",
		"rhsgref_nat_ural",
		"rhsgref_nat_ural_open",
		"rhsgref_nat_ural_work",
		"rhsgref_nat_ural_work_open",
		"rhsgref_nat_van",
		"rhsgref_nat_van_fuel",
		"rhsgref_nat_ural_Zu23"];
    };
    default {//A lot (7-8)
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses = [
		"rhsgref_ins_uaz",
		"rhsgref_ins_uaz",
		"rhsgref_ins_uaz_open",
		"rhsgref_ins_uaz_dshkm",
		"rhsgref_ins_uaz_dshkm",
		"rhsgref_ins_uaz_spg9",
		"rhsgref_ins_uaz_ags",
		"rhsgref_ins_ural",
		"rhsgref_ins_ural_open",
		"rhsgref_ins_gaz66",
		"rhsgref_ins_gaz66o",
		"rhsgref_ins_btr60",
		"rhsgref_ins_btr70",
		"rhsgref_ins_bmp1p",
		"rhsgref_ins_bmp1d",
		"rhsgref_ins_t72ba",
		"rhsgref_ins_zsu234"
		];
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses_IND = [
		"rhsgref_nat_uaz",
		"rhsgref_nat_uaz_open",
		"rhsgref_nat_uaz_dshkm",
		"rhsgref_nat_uaz_spg9",
		"rhsgref_nat_ural",
		"rhsgref_nat_ural_open",
		"rhsgref_nat_ural_work",
		"rhsgref_nat_ural_work_open",
		"rhsgref_nat_van",
		"rhsgref_nat_van_fuel",
		"rhsgref_nat_ural_Zu23"];
    };
};

// Random array. General infantry types. E.g. village patrols, ambient infantry, ammo depot guards, communication center guards, etc.
// Main enemy: ChDKZ/Chedaki communist rebels (RHSGREF insurgents)
a3e_arr_Escape_InfantryTypes = [
	"rhsgref_ins_rifleman",
	"rhsgref_ins_rifleman",
	"rhsgref_ins_rifleman",
	"rhsgref_ins_rifleman_akm",
	"rhsgref_ins_rifleman_akm",
	"rhsgref_ins_rifleman_aks74",
	"rhsgref_ins_rifleman_aks74",
	"rhsgref_ins_grenadier",
	"rhsgref_ins_grenadier",
	"rhsgref_ins_grenadier_rpg",
	"rhsgref_ins_machinegunner",
	"rhsgref_ins_machinegunner",
	"rhsgref_ins_medic",
	"rhsgref_ins_commander",
	"rhsgref_ins_commander",
	"rhsgref_ins_saboteur",
	"rhsgref_ins_scout",
	"rhsgref_ins_hunter",
	"rhsgref_ins_specialist_aa",
	"rhsgref_ins_sniper",
	"rhsgref_ins_militiaman",
	"rhsgref_ins_crew",
	"rhsgref_ins_spotter",
	"rhsgref_ins_squadleader",
	"rhsgref_ins_engineer"];
// Secondary enemy: NAPA nationalist partisans (RHSGREF nationalists)
a3e_arr_Escape_InfantryTypes_Ind = [
	"rhsgref_nat_rifleman",
	"rhsgref_nat_rifleman",
	"rhsgref_nat_rifleman_akms",
	"rhsgref_nat_rifleman_aks74",
	"rhsgref_nat_rifleman_vz58",
	"rhsgref_nat_rifleman_mp44",
	"rhsgref_nat_militiaman_kar98k",
	"rhsgref_nat_grenadier",
	"rhsgref_nat_grenadier_rpg",
	"rhsgref_nat_machinegunner",
	"rhsgref_nat_machinegunner_mg42",
	"rhsgref_nat_medic",
	"rhsgref_nat_commander",
	"rhsgref_nat_saboteur",
	"rhsgref_nat_scout",
	"rhsgref_nat_hunter",
	"rhsgref_nat_specialist_aa",
	"rhsgref_nat_warlord",
	"rhsgref_nat_crew"];
// Recon: Chedaki veterans
a3e_arr_recon_InfantryTypes = [
	"rhsgref_ins_commander",
	"rhsgref_ins_squadleader",
	"rhsgref_ins_sniper",
	"rhsgref_ins_machinegunner",
	"rhsgref_ins_grenadier_rpg",
	"rhsgref_ins_rifleman_akm",
	"rhsgref_ins_rifleman_aks74",
	"rhsgref_ins_saboteur",
	"rhsgref_ins_scout",
	"rhsgref_ins_hunter",
	"rhsgref_ins_specialist_aa",
	"rhsgref_ins_spotter"];
// Recon: NAPA partisans (paramilitary)
a3e_arr_recon_I_InfantryTypes = [
	"rhsgref_nat_pmil_commander",
	"rhsgref_nat_pmil_machinegunner",
	"rhsgref_nat_pmil_rifleman_akm",
	"rhsgref_nat_pmil_rifleman_aksu",
	"rhsgref_nat_pmil_grenadier",
	"rhsgref_nat_pmil_grenadier_rpg",
	"rhsgref_nat_pmil_saboteur",
	"rhsgref_nat_pmil_scout",
	"rhsgref_nat_pmil_hunter",
	"rhsgref_nat_pmil_specialist_aa",
	"rhsgref_nat_pmil_medic",
	"rhsgref_nat_pmil_crew",
	"rhsgref_nat_pmil_rifleman"];



// Random array. A roadblock has a manned vehicle. This array contains possible manned vehicles (can be of any kind, like cars, armored and statics).
// Chedaki roadblock vehicles
a3e_arr_Escape_RoadBlock_MannedVehicleTypes = [
	"rhsgref_ins_uaz_dshkm",
	"rhsgref_ins_uaz_dshkm",
	"rhsgref_ins_uaz_spg9",
	"rhsgref_ins_uaz_ags",
	"rhsgref_ins_btr60",
	"rhsgref_ins_btr70",
	"rhsgref_ins_bmp1p"];

// NAPA roadblock vehicles
a3e_arr_Escape_RoadBlock_MannedVehicleTypes_Ind = [
	"rhsgref_nat_uaz_dshkm",
	"rhsgref_nat_uaz_dshkm",
	"rhsgref_nat_uaz_spg9",
	"rhsgref_nat_ural_Zu23",
	"rhsgref_nat_uaz",
	"rhsgref_nat_ural"];

// Roadblock statics - Soviet-era weapons
a3e_arr_Escape_RoadBlock_StaticTypes_Low = [
	"rhs_KORD_high_MSV",
	"rhs_KORD_MSV",
	"rhs_AGS30_TriPod_MSV",
	"rhs_SPG9M_MSV"];

a3e_arr_Escape_RoadBlock_StaticTypes_High = [
	"rhs_ZU23_MSV",
	"rhs_KORD_high_MSV"];

// Random array. Vehicle classes (preferrably trucks) transporting enemy reinforcements.
// Chedaki reinforcement trucks
a3e_arr_Escape_ReinforcementTruck_vehicleClasses = [
	"rhsgref_ins_ural",
	"rhsgref_ins_ural_open",
	"rhsgref_ins_gaz66",
	"rhsgref_ins_gaz66o",
	"rhsgref_ins_uaz",
	"rhsgref_ins_uaz_open"];
// NAPA reinforcement trucks
a3e_arr_Escape_ReinforcementTruck_vehicleClasses_Ind = [
	"rhsgref_nat_ural",
	"rhsgref_nat_ural_open",
	"rhsgref_nat_ural_work",
	"rhsgref_nat_ural_work_open"];




// Random array. Motorized search groups are sometimes sent to look for you. This array contains possible class definitions for the vehicles.
// Chedaki motorized patrols
a3e_arr_Escape_MotorizedSearchGroup_vehicleClasses = [
	"rhsgref_ins_uaz_dshkm",
	"rhsgref_ins_uaz_ags",
	"rhsgref_ins_uaz_spg9",
	"rhsgref_ins_btr60"];



// A communication center is guarded by vehicles depending on variable _enemyFrequency. 1 = a random light armor. 2 = a random heavy armor. 3 = a random
// light *and* a random heavy armor.

// Random array. Light armored vehicles guarding the communication centers.
a3e_arr_ComCenDefence_lightArmorClasses = [
	"rhsgref_ins_btr60",
	"rhsgref_ins_btr70",
	"rhsgref_ins_bmp1p"];
// Random array. Heavy armored vehicles guarding the communication centers.
a3e_arr_ComCenDefence_heavyArmorClasses = [
	"rhsgref_ins_t72ba",
	"rhsgref_ins_t72ba",
	"rhsgref_ins_zsu234"];

// A communication center contains two static weapons (in two corners of the communication center).
// Random array. Possible static weapon types for communication centers. Should have a higher tripod to shoot over sandbags
a3e_arr_ComCenStaticWeapons = [
	"rhs_KORD_high_MSV",
	"rhs_KORD_MSV"];
// A communication center has two parked and empty vehicles of the following possible types.
a3e_arr_ComCenParkedVehicles = [
	"rhsgref_ins_uaz",
	"rhsgref_ins_uaz_open",
	"rhsgref_ins_gaz66",
	"rhsgref_ins_ural",
	"rhsgref_ins_bmp1d",
	"rhsgref_ins_gaz66o"];

// Random array. Enemies sometimes use civilian vehicles in their unconventional search for players. The following car types may be used.
a3e_arr_Escape_EnemyCivilianCarTypes = [
	"CUP_C_Datsun_Plain",
	"CUP_C_Datsun_Tubeframe",
	"CUP_O_Hilux_unarmed_CR_CIV",
	"CUP_O_Hilux_unarmed_CR_CIV_Red",
	"CUP_O_Hilux_unarmed_CR_CIV_White",
	"CUP_C_SUV_CIV",
	"CUP_C_Ural_Civ_03",
	"CUP_C_Ural_Open_Civ_03",
	"CUP_C_Lada_CIV",
	"CUP_C_TT650_RU",
	"CUP_C_SUV_TK"];

// Vehicles, weapons and ammo at ammo depots

// Random array. An ammo depot contains one static weapon of the following types:
a3e_arr_Escape_AmmoDepot_StaticWeaponClasses = [
	"rhs_KORD_high_MSV",
	"rhs_KORD_MSV",
	"rhs_AGS30_TriPod_MSV",
	"rhs_SPG9M_MSV",
	"rhs_ZU23_MSV"];

// An ammo depot have one parked and empty vehicle of the following possible types.
a3e_arr_Escape_AmmoDepot_ParkedVehicleClasses = [
	"rhsgref_ins_uaz"
	];

//Random array. Types of helicopters to spawn
// Chedaki captured Soviet helicopters
a3e_arr_O_attack_heli = [
	"RHS_Mi24V_vvs",
	"RHS_Mi24P_vvs"];
a3e_arr_O_transport_heli = [
	"RHS_Mi8mt_vvs",
	"RHS_Mi8mt_vvs"];
a3e_arr_O_pilots = [
	"rhs_pilot_combat_heli"];
// NAPA transport helicopters
a3e_arr_I_transport_heli = [
	"RHS_Mi8mt_vvs"];
a3e_arr_I_pilots = [
	"rhs_pilot_combat_heli"];




// The following arrays define weapons and ammo contained at the ammo depots
// Index 0: Weapon classname.
// Index 1: Weapon's probability of presence (in percent, 0-100).
// Index 2: If weapon exists, crate contains at minimum this number of weapons of current class.
// Index 3: If weapon exists, crate contains at maximum this number of weapons of current class.
// Index 4: Array of magazine classnames. Magazines of these types are present if weapon exists.
// Index 5: Number of magazines per weapon that exists.

// Weapons and ammo in the basic weapons box
// Soviet-era weapons (rebel captured stockpiles) - older, grittier mix
a3e_arr_AmmoDepotWeapons = [];
// Soviet pistols
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_makarov_pmm", 60, 2, 5, ["rhs_mag_9x18_12_57N181S"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_pya", 30, 1, 3, ["rhs_mag_9x19_17"], 6];
// AK variants - the bread and butter
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_akm", 100, 3, 5, ["rhs_30Rnd_762x39mm"], 8];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_akms", 80, 2, 4, ["rhs_30Rnd_762x39mm"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_ak74", 75, 2, 4, ["rhs_30Rnd_545x39_7N6M_AK"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_ak74n_gp25", 40, 1, 2, ["rhs_30Rnd_545x39_7N6M_AK","rhs_VOG25"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_aks74un", 30, 1, 2, ["rhs_30Rnd_545x39_7N6M_AK"], 6];
// LMGs
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_pkm", 40, 1, 2, ["rhs_100Rnd_762x54mmR"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_rpk74m", 30, 1, 2, ["rhs_45Rnd_545x39_7N6M_AK"], 6];
// DMR/Sniper
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_svdp_wd", 25, 1, 2, ["rhs_10Rnd_762x54mmR_7N1"], 8];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_mosin_sbr", 30, 1, 2, ["rhsgref_5Rnd_762x54_m38"], 10];
// Shotguns
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_Izh18", 40, 1, 2, ["rhsgref_1Rnd_00Buck","rhsgref_1Rnd_Slug"], 10];
// AT/RPG
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_rpg7", 30, 1, 2, ["rhs_rpg7_PG7VL_mag"], 2];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_rpg26", 40, 1, 3, ["rhs_rpg26_mag"], 1];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_rshg2", 20, 1, 2, ["rhs_rshg2_mag"], 1];
// SMGs
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_savz61", 30, 1, 2, ["rhsgref_20rnd_765x17_vz61"], 8];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_pp2000", 20, 1, 2, ["rhs_mag_9x19mm_7n31_44"], 6];
// CUP Eastern weapons for variety
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_AKM", 60, 2, 4, ["CUP_30Rnd_762x39_AK47M"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_AKS74U", 40, 1, 3, ["CUP_30Rnd_545x39_AK_M"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_Sa58V", 35, 1, 2, ["CUP_30Rnd_Sa58_M"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_Sa58P", 35, 1, 2, ["CUP_30Rnd_Sa58_M"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_lmg_PKM", 25, 1, 2, ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M"], 4];
a3e_arr_AmmoDepotWeapons pushback ["CUP_srifle_SVD", 20, 1, 2, ["CUP_10Rnd_762x54_SVD_M"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_smg_bizon", 25, 1, 3, ["CUP_64Rnd_9x19_Bizon_M"], 4];
a3e_arr_AmmoDepotWeapons pushback ["CUP_srifle_LeeEnfield", 15, 1, 2, ["CUP_10Rnd_303British"], 10];
a3e_arr_AmmoDepotWeapons pushback ["CUP_smg_SA61", 20, 1, 2, ["CUP_20Rnd_B_765x17_Ball_M"], 8];
// WWII leftovers
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_MP44", 15, 1, 2, ["rhsgref_30Rnd_792x33_SmE_StG"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_kar98k", 20, 1, 2, ["rhsgref_5Rnd_792x57_kar98k"], 12];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m1garand_sa43", 20, 1, 2, ["rhsgref_8Rnd_762x63_M2B_M1rifle"], 10];
// Yugoslav weapons (smuggled from Serbia)
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m70ab2", 30, 1, 2, ["rhssaf_30Rnd_762x39mm_M67"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m70b3n", 25, 1, 2, ["rhssaf_30Rnd_762x39mm_M67"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m84", 20, 1, 2, ["rhs_100Rnd_762x54mmR"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m76", 15, 1, 1, ["rhssaf_10Rnd_792x57_m76"], 8];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m21a_pr", 25, 1, 2, ["rhsgref_30rnd_556x45_m21"], 6];


a3e_arr_AmmoDepotMags= [];
a3e_arr_AmmoDepotMags pushback ["vn_f1_grenade_mag", 50, 5, 10];
a3e_arr_AmmoDepotMags pushback ["vn_rgd5_grenade_mag", 50, 5, 10];
a3e_arr_AmmoDepotMags pushback ["vn_v40_grenade_mag", 50, 1, 5];
a3e_arr_AmmoDepotMags pushback ["SmokeShell", 30,  5, 10];
a3e_arr_AmmoDepotMags pushback ["SmokeShellYellow", 30, 1, 2];
a3e_arr_AmmoDepotMags pushback ["SmokeShellRed", 30, 1, 2];
a3e_arr_AmmoDepotMags pushback ["SmokeShellGreen", 30, 1, 2];
a3e_arr_AmmoDepotMags pushback ["SmokeShellPurple", 30, 1, 2];
a3e_arr_AmmoDepotMags pushback ["DemoCharge_Remote_Mag", 10, 1, 2];
a3e_arr_AmmoDepotMags pushback ["SatchelCharge_Remote_Mag", 10, 1, 2];
a3e_arr_AmmoDepotMags pushback ["vn_mine_tripwire_arty_mag", 20, 1, 2];
a3e_arr_AmmoDepotMags pushback ["vn_mine_tripwire_f1_04_mag", 20, 1, 2];
a3e_arr_AmmoDepotMags pushback ["vn_mine_tripwire_f1_02_mag", 20, 1, 2];
a3e_arr_AmmoDepotMags pushback ["vn_mine_punji_01_mag", 10, 1, 2];


// Ammo depot items - Russian/Eastern optics and accessories
a3e_arr_AmmoDepotItems = [];
a3e_arr_AmmoDepotItems pushback ["Laserdesignator", 10, 1, 2];
if(A3E_Param_NoNightvision==0) then {
	a3e_arr_AmmoDepotItems pushback ["NVGoggles", 10, 1, 3];
};
a3e_arr_AmmoDepotItems pushback ["Rangefinder", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["lerca_1200_black", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["Leupold_Mk4", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["Binocular", 50, 2, 3, [], 0];
a3e_arr_AmmoDepotItems pushback ["ItemCompass", 50, 1, 3];
a3e_arr_AmmoDepotItems pushback ["ItemGPS", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["ItemMap", 50, 1, 3];
a3e_arr_AmmoDepotItems pushback ["ItemRadio", 50, 1, 10];
a3e_arr_AmmoDepotItems pushback ["ItemWatch", 50, 1, 10];
// Russian/Eastern optics
a3e_arr_AmmoDepotItems pushback ["rhs_acc_1p63", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_pkas", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_ekp1", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_pso1m2", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_1p29", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_ekp8_02", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_1p78", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_nita", 10, 1, 3];
// Suppressors
a3e_arr_AmmoDepotItems pushback ["rhs_acc_pbs1", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_tgpa", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_tgpv", 10, 1, 3];
// Bipod
a3e_arr_AmmoDepotItems pushback ["rhs_bipod", 10, 1, 2];
// Night vision scopes
if(A3E_Param_NoNightvision==0) then {
	a3e_arr_AmmoDepotItems pushback ["rhs_acc_1pn93_1", 10, 1, 3];
	a3e_arr_AmmoDepotItems pushback ["rhs_acc_1pn93_2", 10, 1, 3];
};
a3e_arr_AmmoDepotItems pushback ["O_UavTerminal", 10, 1, 3];
a3e_arr_AmmoDepotBackpacks = [];
a3e_arr_AmmoDepotBackpacks pushback ["vn_o_pack_07", 20, 5, 6];
a3e_arr_AmmoDepotBackpacks pushback ["vn_o_pack_05", 20, 1, 2];

a3e_AmmoDepotBox = "vn_o_ammobox_06";



// Weapons that may show up in civilian cars

// Index 0: Weapon classname.
// Index 1: Magazine classname.
// Index 2: Number of magazines.
a3e_arr_CivilianCarWeapons = [];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_makarov_pmm", "rhs_mag_9x18_12_57N181S", 5];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_m3a1_specops", "rhsgref_30rnd_1143x23_M1911B_2mag_SMG", 5];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_M590_5RD", "rhsusf_5Rnd_00Buck", 11];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_M590_8RD", "rhsusf_8Rnd_00Buck", 9];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_mk18_grip2_eotech_usmc", "rhs_mag_30Rnd_556x45_Mk318_Stanag", 9];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_m4a1_blockII_KAC_SU230", "rhs_mag_30Rnd_556x45_Mk318_Stanag", 8];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_M320", "rhs_mag_M433_HEDP", 10];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_MP44", "rhsgref_30Rnd_792x33_SmE_StG", 7];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_m240b_usmc", "rhsusf_100Rnd_762x51", 5];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_m16a4_grip_acog_usmc", "rhs_mag_30Rnd_556x45_Mk318_Stanag", 8];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_XM2010_wd_leu", "rhsusf_5Rnd_300winmag_xm2010", 10];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_sr25_sup_marsoc", "rhsusf_20Rnd_762x51_m118_special_Mag", 12];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_rshg2","rhs_rshg2_mag", 2];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_kar98k", "rhsgref_5Rnd_792x57_kar98k", 12];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_m1garand_sa43", "rhsgref_8Rnd_762x63_M2B_M1rifle", 12];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_mosin_sbr", "rhsgref_5Rnd_762x54_m38", 12];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_Izh18", "rhsgref_1Rnd_00Buck", 12];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_Izh18", "rhsgref_1Rnd_Slug", 12];
// CUP Weapons - scavenged variety in civilian vehicles
a3e_arr_CivilianCarWeapons pushback ["CUP_arifle_AKM", "CUP_30Rnd_762x39_AK47M", 7];
a3e_arr_CivilianCarWeapons pushback ["CUP_arifle_AKS74U", "CUP_30Rnd_545x39_AK_M", 7];
a3e_arr_CivilianCarWeapons pushback ["CUP_arifle_Sa58V", "CUP_30Rnd_Sa58_M", 7];
a3e_arr_CivilianCarWeapons pushback ["CUP_smg_bizon", "CUP_64Rnd_9x19_Bizon_M", 4];
a3e_arr_CivilianCarWeapons pushback ["CUP_srifle_LeeEnfield", "CUP_10Rnd_303British", 10];
a3e_arr_CivilianCarWeapons pushback ["CUP_smg_SA61", "CUP_20Rnd_B_765x17_Ball_M", 8];
a3e_arr_CivilianCarWeapons pushback ["CUP_hgun_Glock17", "CUP_17Rnd_9x19_glock17", 5];
a3e_arr_CivilianCarWeapons pushback ["CUP_hgun_Makarov", "CUP_8Rnd_9x18_Makarov_M", 5];
a3e_arr_CivilianCarWeapons pushback ["CUP_arifle_FNFAL", "CUP_20Rnd_762x51_FNFAL_M", 6];
a3e_arr_CivilianCarWeapons pushback ["CUP_smg_MP5A5", "CUP_30Rnd_9x19_MP5", 6];
a3e_arr_CivilianCarWeapons pushback ["rhs_weap_panzerfaust60", objNull, 0];
a3e_arr_CivilianCarWeapons pushback ["MineDetector", objNull, 0];
//a3e_arr_CivilianCarWeapons pushback ["Medikit", objNull, 0];
//a3e_arr_CivilianCarWeapons pushback ["Toolkit", objNull, 0];
a3e_arr_CivilianCarWeapons pushback ["Binocular", objNull, 0];
a3e_arr_CivilianCarWeapons pushback [objNull, "SatchelCharge_Remote_Mag", 2];
a3e_arr_CivilianCarWeapons pushback [objNull, "HandGrenade", 5];
a3e_arr_CivilianCarWeapons pushback [objNull, "SmokeShell", 5];

// Here is a list of scopes:
// Eastern optics for the civil war setting
a3e_arr_Scopes = [
	"rhs_acc_1p63"
	,"rhs_acc_pkas"
	,"rhs_acc_ekp1"
	,"rhs_acc_ekp8_02"
	,"rhs_acc_1p78"
	,"rhs_acc_1p29"
	,"rhs_acc_pso1m2"
	,"rhs_acc_nita"
	,"rhs_acc_1p63"
	,"rhs_acc_pkas"
	,"rhs_acc_ekp1"];
a3e_arr_Scopes_SMG = [
	"rhs_acc_ekp1"
	,"rhs_acc_pkas"
	,"rhs_acc_1p63"];
a3e_arr_Scopes_Sniper = [
	"rhs_acc_pso1m2"
	,"rhs_acc_pso1m21"];
a3e_arr_NightScopes = [
	"rhs_acc_1pn93_1"
	,"rhs_acc_1pn93_2"];
a3e_arr_TWSScopes = [
	""];

// Here is a list of bipods, might get randomly added to enemy patrols:
a3e_arr_Bipods = [
	"rhs_bipod"
	];

//////////////////////////////////////////////////////////////////
// SelectExtractionZone.sqf
// Which type of extractions are supported/preferred by this unitclasses version?
// Only if supported by terrain, so if corresponding markers are placed
// Basic fallback is always Heli extraction
// Available types: a3e_arr_extractiontypes = ["air","land","sea"];
//////////////////////////////////////////////////////////////////
a3e_arr_extractiontypes = [
	"air",
	//"land",
	"sea"
	];

//////////////////////////////////////////////////////////////////
// RunExtraction.sqf
// Helicopters that come to pick you up
// CDF government forces rescue you with Soviet-era aircraft
//////////////////////////////////////////////////////////////////
a3e_arr_extraction_chopper = [
	"RHS_Mi8mt_vvs"
	,"RHS_Mi8mt_vvs"
	,"CUP_I_UH60L_Unarmed_RACS"];
a3e_arr_extraction_chopper_escort = [
	"RHS_Mi24V_vvs"
	,"RHS_Mi24P_vvs"];

//////////////////////////////////////////////////////////////////
// RunExtractionBoat.sqf
// Boats that come to pick you up
//////////////////////////////////////////////////////////////////
a3e_arr_extraction_boat = [
	"vn_b_boat_06_02"
	,"vn_b_boat_06_01"
	,"vn_b_boat_05_02"
	,"vn_b_boat_05_01"];
a3e_arr_extraction_boat_escort = [
	"vn_b_boat_06_02"
	,"vn_b_boat_06_01"
	,"vn_b_boat_05_02"
	,"vn_b_boat_05_01"];

//////////////////////////////////////////////////////////////////
// RunExtractionLand.sqf
//
// Cars that come to pick you up
// Using ins_ prefix Soviet vehicles (same vehicles CDF would use)
//////////////////////////////////////////////////////////////////
a3e_arr_extraction_car = [
	"rhsgref_ins_ural",
	"rhsgref_ins_ural_open",
	"rhsgref_ins_gaz66",
	"rhsgref_ins_gaz66o"];
a3e_arr_extraction_car_escort = [
	"rhsgref_ins_bmp1p"];

a3e_arr_friendly_aircraft = [
	"rhssaf_airforce_l_18"];


//////////////////////////////////////////////////////////////////
// EscapeSurprises.sqf and CreateSearchDrone.sqf
// Classnames of drones
// OPFOR drones since main enemy is EAST
//////////////////////////////////////////////////////////////////
a3e_arr_searchdrone = [
	"O_UAV_02_F"
	,"O_UAV_02_CAS_F"];

//////////////////////////////////////////////////////////////////
// CreateSearchChopper.sqf
// first chopper that's called when you escape
// Two arrays for "Easy" and "Hard" parameter, both used on stadard setting
// Chedaki captured Soviet helicopters
//////////////////////////////////////////////////////////////////

a3e_arr_searchChopperEasy = [
	"RHS_Mi8mt_vvs"
	,"RHS_Mi8mt_vvs"];
a3e_arr_searchChopperHard = [
	"RHS_Mi24V_vvs"
	,"RHS_Mi24P_vvs"];
a3e_arr_searchChopper_pilot = [
	"rhs_pilot_combat_heli"];
a3e_arr_searchChopper_crew = [
	"rhs_pilot_combat_heli"];

if(A3E_Param_SearchChopper==0) then {
	a3e_arr_searchChopper = a3e_arr_searchChopperEasy + a3e_arr_searchChopperHard;
};
if(A3E_Param_SearchChopper==1) then {
	a3e_arr_searchChopper = a3e_arr_searchChopperEasy;
};
if(A3E_Param_SearchChopper >= 2) then {
	a3e_arr_searchChopper = a3e_arr_searchChopperHard;
};



//////////////////////////////////////////////////////////////////
// fn_AmbientInfantry
// only INS is used
//is this even used?
//////////////////////////////////////////////////////////////////
a3e_arr_AmbientInfantry_Inf_INS = a3e_arr_Escape_InfantryTypes;
a3e_arr_AmbientInfantry_Inf_GUE = a3e_arr_Escape_InfantryTypes_Ind;

//////////////////////////////////////////////////////////////////
// fn_InitGuardedLocations
// Units spawned to guard ammo camps and com centers
// Only INS used
//////////////////////////////////////////////////////////////////
a3e_arr_InitGuardedLocations_Inf_INS = a3e_arr_Escape_InfantryTypes;
a3e_arr_InitGuardedLocations_Inf_GUE = a3e_arr_Escape_InfantryTypes_Ind;

//////////////////////////////////////////////////////////////////
// fn_roadblocks
// units spawned on roadblocks
// Only INS used
// vehicle arrays not used, uses a3e_arr_Escape_RoadBlock_MannedVehicleTypes and a3e_arr_Escape_RoadBlock_MannedVehicleTypes_Ind instead
//////////////////////////////////////////////////////////////////
a3e_arr_roadblocks_Inf_INS = a3e_arr_Escape_InfantryTypes;
a3e_arr_roadblocks_Inf_GUE = a3e_arr_Escape_InfantryTypes_Ind;

a3e_arr_roadblocks_Veh_INS = a3e_arr_Escape_RoadBlock_MannedVehicleTypes;
a3e_arr_roadblocks_Veh_GUE = a3e_arr_Escape_RoadBlock_MannedVehicleTypes_Ind;

//////////////////////////////////////////////////////////////////
// fn_PopulateAquaticPatrol
// boats that are spawned
//////////////////////////////////////////////////////////////////
a3e_arr_AquaticPatrols = [
	"rhsusf_mkvsoc"];

//////////////////////////////////////////////////////////////////
// fn_AmmoDepot
// What kind of weapon boxes are spawned when the parameter "additional weapons" is activated
// use to add boxes from mods to the ammo depots
//////////////////////////////////////////////////////////////////
a3e_additional_weapon_box_1 = "rhsusf_weapon_crate";
a3e_additional_weapon_box_2 = "rhsusf_mags_crate";

//////////////////////////////////////////////////////////////////
// fn_MortarSite
// mortar spawned in the mortar camps
//////////////////////////////////////////////////////////////////
a3e_arr_MortarSite = [
	"rhs_2b14_82mm_msv"];
a3e_arr_ArtillerySite = [
	"vn_o_nva_static_d44_01"];

//////////////////////////////////////////////////////////////////
// fn_CallCAS.sqf
// Classnames of planes for the CAS module
// Less air power available in a civil war
//////////////////////////////////////////////////////////////////
a3e_arr_CASplane = [
	"rhssaf_airforce_l_18"];
a3e_CASModule = "ModuleCAS_F"; // "ModuleCAS_F"

//////////////////////////////////////////////////////////////////
// fn_CrashSite
// Random crashsite of CDF government equipment that was shot down
//////////////////////////////////////////////////////////////////
// The following arrays define weapons and ammo contained at crash sites
// Index 0: Weapon classname.
// Index 1: Weapon's probability of presence (in percent, 0-100).
// Index 2: If weapon exists, crate contains at minimum this number of weapons of current class.
// Index 3: If weapon exists, crate contains at maximum this number of weapons of current class.
// Index 4: Array of magazine classnames. Magazines of these types are present if weapon exists.
// Index 5: Number of magazines per weapon that exists.
a3e_arr_CrashSiteWrecks = [
	"Land_Wreck_Heli_Attack_02_F"
	,"Mi8Wreck"];
a3e_arr_CrashSiteCrew = [
	"rhsgref_cdf_air_pilot"];
a3e_arr_CrashSiteWrecksCar = [
	"Land_Wreck_BMP2_F"
	,"Land_Wreck_BRDM2_F"];
a3e_arr_CrashSiteCrewCar = [
	"rhs_vdv_flora_crew"
	,"rhs_vdv_flora_combatcrew"];
// Weapons and ammo in crash site box
// CDF government military equipment (mix of Western aid and Soviet stockpiles)
a3e_arr_CrashSiteWeapons = [];
a3e_arr_CrashSiteItems = [];
a3e_arr_CrashSiteBackpacks = [];
a3e_arr_CrashSiteMags = [];
a3e_crashSiteBox = "vn_b_ammobox_05";

a3e_arr_CrashSiteWeapons pushback ["rhs_weap_ak74m", 100, 3, 5, ["rhs_30Rnd_545x39_7N10_AK"], 6];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_ak74m_gp25", 50, 2, 3, ["rhs_30Rnd_545x39_7N10_AK","rhs_VOG25"], 4];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_pkm", 30, 1, 2, ["rhs_100Rnd_762x54mmR"], 4];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_svdp_wd", 20, 1, 2, ["rhs_10Rnd_762x54mmR_7N1"], 8];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_rpg7", 20, 1, 2, ["rhs_rpg7_PG7VL_mag"], 2];
// NATO aid weapons mixed in
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_m4a1_wd", 40, 1, 3, ["rhs_mag_30Rnd_556x45_M855A1_Stanag"], 6];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_m249_pip", 20, 1, 2, ["rhsusf_100Rnd_556x45_soft_pouch"], 3];
a3e_arr_CrashSiteWeapons pushback ["CUP_arifle_FNFAL", 20, 1, 2, ["CUP_20Rnd_762x51_FNFAL_M"], 6];
a3e_arr_CrashSiteWeapons pushback ["CUP_arifle_Sa58V", 30, 1, 3, ["CUP_30Rnd_Sa58_M"], 6];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_m21a_pr", 25, 1, 2, ["rhsgref_30rnd_556x45_m21"], 6];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_M136", 20, 1, 2, ["rhs_m136_mag"], 1];

// Attachments and other items in crash site box
a3e_arr_CrashSiteItems = [];
a3e_arr_CrashSiteItems pushback ["rhs_acc_1p63", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_pkas", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_ekp1", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_pso1m2", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_1p29", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhsusf_acc_compm4", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhsusf_acc_ACOG_USMC", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_bipod", 10, 1, 2];
a3e_arr_CrashSiteItems pushback ["Binocular", 50, 1, 2];

// NVG and night scope checks
if(A3E_Param_NVGs==1) then {
	a3e_arr_CrashSiteItems pushback ["NVGoggles_OPFOR", 10, 1, 3];
};
if(A3E_Param_NVScopes==1) then {
	a3e_arr_CrashSiteItems pushback ["vn_o_anpvs2_m40a1", 30, 1, 1];
	a3e_arr_CrashSiteItems pushback ["vn_o_anpvs2_m16", 30, 1, 1];
};

// Helmets and vests from crash sites
a3e_arr_CrashSiteItems pushback ["vn_b_helmet_m1_06_01", 100, 2, 2];
a3e_arr_CrashSiteItems pushback ["vn_b_helmet_m1_05_01", 75, 1, 2];

a3e_arr_CrashSiteItems pushback ["murshun_cigs_cigpack", 100, 3, 3];
a3e_arr_CrashSiteItems pushback ["murshun_cigs_lighter", 100, 3, 3];

a3e_arr_CrashSiteItems pushback ["vn_b_vest_usarmy_11", 50, 1, 1];
a3e_arr_CrashSiteItems pushback ["vn_b_vest_usarmy_12", 50, 1, 1];
a3e_arr_CrashSiteItems pushback ["vn_b_vest_usarmy_13", 50, 1, 1];
a3e_arr_CrashSiteItems pushback ["vn_b_vest_usarmy_14", 50, 1, 1];
a3e_arr_CrashSiteItems pushback ["vn_b_vest_usarmy_02", 50, 1, 1];

a3e_arr_CrashSiteBackpacks pushback ["vn_b_pack_lw_01", 75, 4, 4];
a3e_arr_CrashSiteBackpacks pushback ["vn_b_pack_lw_06", 10, 1, 1];

a3e_arr_CrashSiteMags pushback ["vn_m61_grenade_mag", 80, 20, 40];
a3e_arr_CrashSiteMags pushback ["SmokeShell", 50, 5, 10];
a3e_arr_CrashSiteMags pushback ["SmokeShellRed", 50, 5, 10];
a3e_arr_CrashSiteMags pushback ["SmokeShellBlue", 50, 5, 10];
a3e_arr_CrashSiteMags pushback ["SmokeShellYellow", 50, 1, 2];
a3e_arr_CrashSiteMags pushback ["SmokeShellGreen", 50, 1, 2];
a3e_arr_CrashSiteMags pushback ["SmokeShellPurple", 50, 1, 2];
a3e_arr_CrashSiteMags pushback ["vn_m34_grenade_mag", 50, 4, 6];


//New stuff for VN

A3E_Trap_Classes = [["random","vn_mine_punji_03"],["random","vn_mine_punji_01"],["random","vn_mine_punji_02"],["random","vn_mine_m14"]];//,["roadcenter","vn_mine_tripwire_m16_04"],["roadcenter","vn_mine_tripwire_arty"],["roadside","vn_mine_tripwire_f1_02"]]; Classnames ofd traps and mines. String or array in form [classname, trigger range, scriptcode]
A3E_Trap_Pathes = ["TRACK", "TRAIL"]; //Classnames of roads and pathes for the traps to spawn



// Weapons and ammo in tanks
a3e_arr_TankWeapons = [];

a3e_arr_TankMags= [];

a3e_arr_TankItems = [];

a3e_arr_TankBackpacks = [];


// Weapons and ammo in wheeled APCs
a3e_arr_WheeledAPCWeapons = [];

a3e_arr_WheeledAPCMags= [];

a3e_arr_WheeledAPCItems = [];

a3e_arr_WheeledAPCBackpacks = [];


// Weapons and ammo in trucks
a3e_arr_TruckWeapons = a3e_arr_WheeledAPCWeapons;
a3e_arr_TruckMags= a3e_arr_WheeledAPCMags;
a3e_arr_TruckItems = a3e_arr_WheeledAPCItems;
a3e_arr_TruckBackpacks = a3e_arr_WheeledAPCBackpacks;



// Weapons and ammo in cars
a3e_arr_CarWeapons = [];

a3e_arr_CarMags= [];

a3e_arr_CarItems = [];

a3e_arr_CarBackpacks = [];

// Weapons and ammo in Helicopters
a3e_arr_HelicopterWeapons = a3e_arr_WheeledAPCWeapons;
a3e_arr_HelicopterMags= a3e_arr_WheeledAPCMags;
a3e_arr_HelicopterItems = a3e_arr_WheeledAPCItems;
a3e_arr_HelicopterBackpacks = a3e_arr_WheeledAPCBackpacks;


a3e_arr_StaticAAWeapons = [
	"vn_o_nva_static_zpu4"];

a3e_arr_AntiAircraftSiteLaunchers = [
	"vn_sa2"];

a3e_arr_AntiAircraftSiteRadars = [
	"vn_o_static_rsna75"];

a3e_arr_AntiAircraftSiteVans = [
	"vn_o_wheeled_z157_03",
	"vn_o_wheeled_z157_04"];


a3e_arr_faks = ["FirstAidKit", "vn_b_item_firstaidkit", "vn_o_item_firstaidkit"];

a3e_arr_medkits = ["Medikit","vn_b_item_medikit_01"];


A3E_IntelItems = [
	"Files"
	,"FileTopSecret"
	,"FilesSecret"
	,"FlashDisk"
	,"DocumentsSecret"
	//,"Wallet_ID"
	//,"FileNetworkStructure"
	,"MobilePhone"
	,"SmartPhone"
	];
