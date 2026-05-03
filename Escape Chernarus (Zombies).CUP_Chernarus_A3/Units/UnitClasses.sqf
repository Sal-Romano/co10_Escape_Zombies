/*
 * Description: This file contains the vehicle types and unit types for the units spawned in the mission, and the weapons and magazines found in ammo boxes/cars.
 * "Random array" (used below) means that array will be used to spawn units, and that chance is 1/n that each element will be spawned on each spawn. The array can contain 
 * many elements of the same type, so the example array ["Offroad_DSHKM_INS", "Pickup_PK_INS", "Pickup_PK_INS"] will spawn an Offroad with 1/3 probability, and a 
 * Pickup with 2/3 probability.
 */

private ["_enemyFrequency"];

_enemyFrequency = _this select 0;

A3E_VAR_Side_Blufor = east;
A3E_VAR_Side_Opfor = west;
A3E_VAR_Side_Ind = resistance;
A3E_VAR_Side_Civ = civilian;

A3E_VAR_Flag_Opfor = "\vn\objects_f_vietnam\flags\data\vn_flag_01_pavn_co.paa";
A3E_VAR_Flag_Ind = "\vn\objects_f_vietnam\flags\data\vn_flag_01_vc_dmg_ca.paa";

A3E_VAR_Side_Blufor_Str = format["%1",A3E_VAR_Side_Blufor];
A3E_VAR_Side_Opfor_Str = format["%1",A3E_VAR_Side_Opfor];
A3E_VAR_Side_Ind_Str = format["%1",A3E_VAR_Side_Ind];
A3E_VAR_Side_Civ_Str = format["%1",A3E_VAR_Side_Civ];

// Random array. Start position guard types around the prison.
a3e_arr_Escape_StartPositionGuardTypes = [
	"rhsgref_nat_pmil_crew", 
	"rhsgref_nat_pmil_commander", 
	"rhsgref_nat_pmil_machinegunner", 
	"rhsgref_nat_pmil_medic", 
	"rhsgref_nat_pmil_rifleman_akm", 
	"rhsgref_nat_pmil_rifleman_aksu", 
	"rhsgref_nat_pmil_grenadier", 
	"rhsgref_nat_pmil_saboteur", 
	"rhsgref_nat_pmil_scout", 
	"rhsgref_nat_pmil_hunter", 
	"rhsgref_nat_pmil_rifleman"];

A3E_akMag = "rhs_30Rnd_762x39mm";
A3E_rpkMag = "rhs_75Rnd_762x39mm";

// Prison backpack secondary weapon (and corresponding magazine type).
a3e_arr_PrisonBackpackType = "rhsgref_hidf_alicepack";

a3e_arr_PrisonBackpackWeapons = [];
a3e_arr_PrisonBackpackWeapons pushback ["rhsusf_weap_glock17g4","rhsusf_mag_17Rnd_9x19_JHP"];
a3e_arr_PrisonBackpackWeapons pushback ["rhsusf_weap_m1911a1","rhsusf_mag_7x45acp_MHP"];
a3e_arr_PrisonBackpackWeapons pushback ["rhsusf_weap_m9","rhsusf_mag_15Rnd_9x19_JHP"];
a3e_arr_PrisonBackpackWeapons pushback ["rhsusf_weap_MP7A2_folded","rhsusf_mag_40Rnd_46x30_FMJ"];
a3e_arr_PrisonBackpackWeapons pushback ["CSW_Desert_Eagle","CSW_7Rnd_127x33_AE"];
a3e_arr_PrisonBackpackWeapons pushback ["CUP_hgun_Makarov","CUP_8Rnd_9x18_Makarov_M"];
a3e_arr_PrisonBackpackWeapons pushback ["CUP_hgun_Glock17","CUP_17Rnd_9x19_glock17"];

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
switch (_enemyFrequency) do {
    case 1: {//Few (1-3)
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses = [
		"rhsusf_CGRCAT1A2_usmc_wd", 
		"rhsusf_CGRCAT1A2_M2_usmc_wd", 
		"rhsusf_CGRCAT1A2_Mk19_usmc_wd", 
		"rhsusf_m1025_w_s_m2", 
		"rhsusf_m1025_w_s_Mk19", 
		"rhsusf_m1025_w_s", 
		"rhsusf_m1043_w_s_m2", 
		"rhsusf_m1043_w_s_mk19", 
		"rhsusf_m1043_w_s", 
		"rhsusf_m1045_w_s", 
		"rhsusf_m998_w_s_2dr_halftop", 
		"rhsusf_m998_w_s_2dr", 
		"rhsusf_m998_w_s_2dr_fulltop", 
		"rhsusf_m998_w_s_4dr_halftop", 
		"rhsusf_m998_w_s_4dr", 
		"rhsusf_m998_w_s_4dr_fulltop", 
		"rhsusf_m1151_usmc_wd", 
		"rhsusf_m1151_m2crows_usmc_wd", 
		"rhsusf_m1151_mk19crows_usmc_wd", 
		"rhsusf_m1151_m2_v3_usmc_wd", 
		"rhsusf_m1151_m240_v3_usmc_wd", 
		"rhsusf_m1151_mk19_v3_usmc_wd", 
		"rhsusf_m1152_usmc_wd", 
		"rhsusf_m1152_rsv_usmc_wd", 
		"rhsusf_m1165_usmc_wd", 
		"rhsusf_M1232_MC_M2_usmc_wd", 
		"rhsusf_M1232_MC_MK19_usmc_wd", 
		"rhsusf_m1240a1_usmc_wd", 
		"rhsusf_m1240a1_m2_usmc_wd", 
		"rhsusf_m1240a1_m240_usmc_wd", 
		"rhsusf_m1240a1_mk19_usmc_wd", 
		"rhsusf_m1240a1_m2crows_usmc_wd", 
		"rhsusf_m1240a1_mk19crows_usmc_wd"
		];
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses_IND = [
		"rhsgref_nat_ural_Zu23", 
		"rhsgref_nat_uaz", 
		"rhsgref_nat_uaz_ags", 
		"rhsgref_nat_uaz_dshkm", 
		"rhsgref_nat_uaz_open", 
		"rhsgref_nat_uaz_spg9", 
		"rhsgref_nat_van_fuel", 
		"rhsgref_nat_van", 
		"rhsgref_nat_ural", 
		"rhsgref_nat_ural_open", 
		"rhsgref_nat_ural_work", 
		"rhsgref_nat_ural_work_open"];
    };
    case 2: {//Some (4-6)
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses = [
		"rhsusf_CGRCAT1A2_usmc_wd", 
		"rhsusf_CGRCAT1A2_M2_usmc_wd", 
		"rhsusf_CGRCAT1A2_Mk19_usmc_wd", 
		"rhsusf_m1025_w_s_m2", 
		"rhsusf_m1025_w_s_Mk19", 
		"rhsusf_m1025_w_s", 
		"rhsusf_m1043_w_s_m2", 
		"rhsusf_m1043_w_s_mk19", 
		"rhsusf_m1043_w_s", 
		"rhsusf_m1045_w_s", 
		"rhsusf_m998_w_s_2dr_halftop", 
		"rhsusf_m998_w_s_2dr", 
		"rhsusf_m998_w_s_2dr_fulltop", 
		"rhsusf_m998_w_s_4dr_halftop", 
		"rhsusf_m998_w_s_4dr", 
		"rhsusf_m998_w_s_4dr_fulltop", 
		"rhsusf_m1151_usmc_wd", 
		"rhsusf_m1151_m2crows_usmc_wd", 
		"rhsusf_m1151_mk19crows_usmc_wd", 
		"rhsusf_m1151_m2_v3_usmc_wd", 
		"rhsusf_m1151_m240_v3_usmc_wd", 
		"rhsusf_m1151_mk19_v3_usmc_wd", 
		"rhsusf_m1152_usmc_wd", 
		"rhsusf_m1152_rsv_usmc_wd", 
		"rhsusf_m1165_usmc_wd", 
		"rhsusf_M1232_MC_M2_usmc_wd", 
		"rhsusf_M1232_MC_MK19_usmc_wd", 
		"rhsusf_m1240a1_usmc_wd", 
		"rhsusf_m1240a1_m2_usmc_wd", 
		"rhsusf_m1240a1_m240_usmc_wd", 
		"rhsusf_m1240a1_mk19_usmc_wd", 
		"rhsusf_m1240a1_m2crows_usmc_wd", 
		"rhsusf_m1240a1_mk19crows_usmc_wd"];
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses_IND = [
		"rhsgref_nat_ural_Zu23", 
		"rhsgref_nat_uaz", 
		"rhsgref_nat_uaz_ags", 
		"rhsgref_nat_uaz_dshkm", 
		"rhsgref_nat_uaz_open", 
		"rhsgref_nat_uaz_spg9", 
		"rhsgref_nat_van_fuel", 
		"rhsgref_nat_van", 
		"rhsgref_nat_ural", 
		"rhsgref_nat_ural_open", 
		"rhsgref_nat_ural_work", 
		"rhsgref_nat_ural_work_open"];
    };
    default {//A lot (7-8)
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses = [
		"rhsusf_CGRCAT1A2_usmc_wd", 
		"rhsusf_CGRCAT1A2_M2_usmc_wd", 
		"rhsusf_CGRCAT1A2_Mk19_usmc_wd", 
		"rhsusf_m1025_w_s_m2", 
		"rhsusf_m1025_w_s_Mk19", 
		"rhsusf_m1025_w_s", 
		"rhsusf_m1043_w_s_m2", 
		"rhsusf_m1043_w_s_mk19", 
		"rhsusf_m1043_w_s", 
		"rhsusf_m1045_w_s", 
		"rhsusf_m998_w_s_2dr_halftop", 
		"rhsusf_m998_w_s_2dr", 
		"rhsusf_m998_w_s_2dr_fulltop", 
		"rhsusf_m998_w_s_4dr_halftop", 
		"rhsusf_m998_w_s_4dr", 
		"rhsusf_m998_w_s_4dr_fulltop", 
		"rhsusf_m1151_usmc_wd", 
		"rhsusf_m1151_m2crows_usmc_wd", 
		"rhsusf_m1151_mk19crows_usmc_wd", 
		"rhsusf_m1151_m2_v3_usmc_wd", 
		"rhsusf_m1151_m240_v3_usmc_wd", 
		"rhsusf_m1151_mk19_v3_usmc_wd", 
		"rhsusf_m1152_usmc_wd", 
		"rhsusf_m1152_rsv_usmc_wd", 
		"rhsusf_m1165_usmc_wd", 
		"rhsusf_M1232_MC_M2_usmc_wd", 
		"rhsusf_M1232_MC_MK19_usmc_wd", 
		"rhsusf_m1240a1_usmc_wd", 
		"rhsusf_m1240a1_m2_usmc_wd", 
		"rhsusf_m1240a1_m240_usmc_wd", 
		"rhsusf_m1240a1_mk19_usmc_wd", 
		"rhsusf_m1240a1_m2crows_usmc_wd", 
		"rhsusf_m1240a1_mk19crows_usmc_wd"];
        a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses_IND = [
		"rhsgref_nat_ural_Zu23", 
		"rhsgref_nat_uaz", 
		"rhsgref_nat_uaz_ags", 
		"rhsgref_nat_uaz_dshkm", 
		"rhsgref_nat_uaz_open", 
		"rhsgref_nat_uaz_spg9", 
		"rhsgref_nat_van_fuel", 
		"rhsgref_nat_van", 
		"rhsgref_nat_ural", 
		"rhsgref_nat_ural_open", 
		"rhsgref_nat_ural_work", 
		"rhsgref_nat_ural_work_open"];
    };
};

// Random array. General infantry types. E.g. village patrols, ambient infantry, ammo depot guards, communication center guards, etc.
a3e_arr_Escape_InfantryTypes = [
	"rhsusf_usmc_marpat_wd_stinger", 
	"rhsusf_usmc_marpat_wd_smaw", 
	"rhsusf_usmc_marpat_wd_javelin_assistant", 
	"rhsusf_usmc_marpat_wd_javelin", 
	"rhsusf_usmc_marpat_wd_autorifleman_m249", 
	"rhsusf_usmc_marpat_wd_autorifleman", 
	"rhsusf_usmc_marpat_wd_autorifleman_m249_ass", 
	"rhsusf_usmc_marpat_wd_rifleman_m590", 
	"rhsusf_usmc_marpat_wd_engineer", 
	"rhsusf_usmc_marpat_wd_crewman", 
	"rhsusf_usmc_marpat_wd_combatcrewman", 
	"rhsusf_usmc_marpat_wd_marksman", 
	"rhsusf_usmc_marpat_wd_driver", 
	"rhsusf_usmc_marpat_wd_explosives", 
	"rhsusf_usmc_marpat_wd_fso", 
	"rhsusf_usmc_marpat_wd_grenadier", 
	"rhsusf_usmc_marpat_wd_grenadier_m32", 
	"rhsusf_usmc_marpat_wd_gunner", 
	"rhsusf_usmc_marpat_wd_jfo", 
	"rhsusf_usmc_marpat_wd_machinegunner", 
	"rhsusf_usmc_marpat_wd_machinegunner_ass", 
	"rhsusf_usmc_marpat_wd_officer", 
	"rhsusf_usmc_marpat_wd_rifleman_light", 
	"rhsusf_usmc_marpat_wd_riflemanat", 
	"rhsusf_usmc_marpat_wd_rifleman", 
	"rhsusf_usmc_marpat_wd_rifleman_m4", 
	"rhsusf_usmc_marpat_wd_rifleman_law", 
	"rhsusf_usmc_marpat_wd_sniper_m110", 
	"rhsusf_usmc_marpat_wd_sniper", 
	"rhsusf_usmc_marpat_wd_spotter", 
	"rhsusf_usmc_marpat_wd_sniper_M107", 
	"rhsusf_usmc_marpat_wd_squadleader", 
	"rhsusf_usmc_marpat_wd_teamleader", 
	"rhsusf_usmc_marpat_wd_uav"];
a3e_arr_Escape_InfantryTypes_Ind = [
	"rhsgref_nat_specialist_aa", 
	"rhsgref_nat_grenadier_rpg", 
	"rhsgref_nat_crew", 
	"rhsgref_nat_commander", 
	"rhsgref_nat_hunter", 
	"rhsgref_nat_machinegunner", 
	"rhsgref_nat_machinegunner_mg42", 
	"rhsgref_nat_medic", 
	"rhsgref_nat_militiaman_kar98k", 
	"rhsgref_nat_rifleman_akms", 
	"rhsgref_nat_rifleman_aks74", 
	"rhsgref_nat_grenadier", 
	"rhsgref_nat_rifleman_mp44", 
	"rhsgref_nat_rifleman", 
	"rhsgref_nat_rifleman_vz58", 
	"rhsgref_nat_saboteur", 
	"rhsgref_nat_scout", 
	"rhsgref_nat_warlord"];
a3e_arr_recon_InfantryTypes = [
	"rhsusf_socom_marsoc_elementleader", 
	"rhsusf_socom_marsoc_cso_eod", 
	"rhsusf_socom_marsoc_cso_grenadier", 
	"rhsusf_socom_marsoc_jfo", 
	"rhsusf_socom_marsoc_jtac", 
	"rhsusf_socom_marsoc_marksman", 
	"rhsusf_socom_marsoc_cso_mechanic", 
	"rhsusf_socom_marsoc_cso_breacher", 
	"rhsusf_socom_marsoc_cso_cqb", 
	"rhsusf_socom_marsoc_cso", 
	"rhsusf_socom_marsoc_cso_light", 
	"rhsusf_socom_marsoc_cso_mk17_light", 
	"rhsusf_socom_marsoc_cso_mk17", 
	"rhsusf_socom_marsoc_sniper", 
	"rhsusf_socom_marsoc_spotter", 
	"rhsusf_socom_marsoc_sarc", 
	"rhsusf_socom_marsoc_sniper_m107"];
a3e_arr_recon_I_InfantryTypes = [
	"rhsgref_nat_pmil_specialist_aa", 
	"rhsgref_nat_pmil_grenadier_rpg", 
	"rhsgref_nat_pmil_crew", 
	"rhsgref_nat_pmil_commander", 
	"rhsgref_nat_pmil_machinegunner", 
	"rhsgref_nat_pmil_medic", 
	"rhsgref_nat_pmil_rifleman_akm", 
	"rhsgref_nat_pmil_rifleman_aksu", 
	"rhsgref_nat_pmil_grenadier", 
	"rhsgref_nat_pmil_saboteur", 
	"rhsgref_nat_pmil_scout", 
	"rhsgref_nat_pmil_hunter", 
	"rhsgref_nat_pmil_rifleman"];



// Random array. A roadblock has a manned vehicle. This array contains possible manned vehicles (can be of any kind, like cars, armored and statics).
a3e_arr_Escape_RoadBlock_MannedVehicleTypes = [
	"rhsusf_CGRCAT1A2_usmc_wd", 
	"rhsusf_CGRCAT1A2_M2_usmc_wd", 
	"rhsusf_CGRCAT1A2_Mk19_usmc_wd", 
	"rhsusf_M1232_MC_M2_usmc_wd", 
	"rhsusf_M1232_MC_MK19_usmc_wd", 
	"rhsusf_m1240a1_usmc_wd", 
	"rhsusf_m1240a1_m2_usmc_wd", 
	"rhsusf_m1240a1_m240_usmc_wd", 
	"rhsusf_m1240a1_mk19_usmc_wd", 
	"rhsusf_m1240a1_mk19crows_usmc_wd"];
	
a3e_arr_Escape_RoadBlock_MannedVehicleTypes_Ind = [
	"CUP_I_FENNEK_ION", 
	"CUP_I_FENNEK_GMG_ION", 
	"CUP_I_FENNEK_HMG_ION", 
	"CUP_I_Hilux_AGS30_TK", 
	"CUP_I_Hilux_BMP1_TK", 
	"CUP_I_Hilux_igla_TK", 
	"CUP_I_Hilux_M2_TK", 
	"CUP_I_Hilux_MLRS_TK", 
	"CUP_I_nM1025_M240_DF_ION", 
	"rhssaf_m1025_olive_m2", 
	"rhsgref_nat_ural_Zu23"];
	
a3e_arr_Escape_RoadBlock_StaticTypes_Low = [
	"RHS_MK19_TriPod_USMC_WD", 
	"RHS_M2StaticMG_MiniTripod_USMC_WD", 
	"RHS_TOW_TriPod_USMC_WD", 
	"CUP_B_MK19_TriPod_US", 
	"CUP_B_M134_A_US_ARMY"];
	
a3e_arr_Escape_RoadBlock_StaticTypes_High = [
	"CUP_B_M119_US", 
	"CUP_B_M2StaticMG_US", 
	"RHS_M2StaticMG_USMC_WD", 
	"RHS_Stinger_AA_pod_USMC_WD"];

// Random array. Vehicle classes (preferrably trucks) transporting enemy reinforcements.
a3e_arr_Escape_ReinforcementTruck_vehicleClasses = [
	"B_Truck_01_transport_F", 
	"B_Truck_01_covered_F", 
	"CUP_B_LR_Transport_GB_W", 
	"rhsusf_m998_w_2dr_halftop", 
	"rhsusf_m998_w_4dr", 
	"rhsusf_m1152_usarmy_wd", 
	"CUP_B_MTVR_USMC", 
	"CUP_B_MTVR_BAF_WOOD", 
	"B_G_Van_02_transport_F"];
a3e_arr_Escape_ReinforcementTruck_vehicleClasses_Ind = [
	"B_Truck_01_transport_F", 
	"B_Truck_01_covered_F", 
	"CUP_B_MTVR_BAF_WOOD", 
	"CUP_B_MTVR_USMC"];




// Random array. Motorized search groups are sometimes sent to look for you. This array contains possible class definitions for the vehicles.
a3e_arr_Escape_MotorizedSearchGroup_vehicleClasses = [
	"rhsusf_m1025_w_m2", 
	"rhsusf_m1025_w_mk19", 
	"rhsusf_m1043_w_m2", 
	"rhsusf_m1045_w", 
	"rhsusf_m1151_m2crows_usarmy_wd", 
	"rhsusf_m1151_m2_v1_usarmy_wd", 
	"rhsusf_m1151_m2_v2_usarmy_wd", 
	"rhsusf_m1151_mk19_v2_usarmy_wd"];



// A communication center is guarded by vehicles depending on variable _enemyFrequency. 1 = a random light armor. 2 = a random heavy armor. 3 = a random 
// light *and* a random heavy armor.

// Random array. Light armored vehicles guarding the communication centers.
a3e_arr_ComCenDefence_lightArmorClasses = [
	"rhsusf_M1232_MC_M2_usmc_wd", 
	"rhsusf_m1240a1_m240_usmc_wd", 
	"rhsusf_m1240a1_mk19crows_usmc_wd"];
// Random array. Heavy armored vehicles guarding the communication centers.
a3e_arr_ComCenDefence_heavyArmorClasses = [
	"rhsusf_m1a1fep_wd", 
	"rhsusf_m1a1fep_od", 
	"rhsusf_m1a1hc_wd"];

// A communication center contains two static weapons (in two corners of the communication center).
// Random array. Possible static weapon types for communication centers. Should have a higher tripod to shoot over sandbags
a3e_arr_ComCenStaticWeapons = [
	"RHS_Stinger_AA_pod_USMC_WD", 
	"RHS_M2StaticMG_USMC_WD"];
// A communication center has two parked and empty vehicles of the following possible types.
a3e_arr_ComCenParkedVehicles = [
	"rhsusf_m1025_w_s", 
	"CUP_B_M1030_USA", 
	"rhsusf_m1043_w_s", 
	"rhsusf_m998_w_s_4dr_halftop", 
	"rhsusf_m998_w_s_4dr_fulltop", 
	"rhsusf_m113_usarmy_medical", 
	"rhsusf_m113_usarmy_MK19", 
	"rhsusf_m113_usarmy_unarmed", 
	"rhsusf_m1165_usmc_wd", 
	"rhsusf_M1220_usarmy_wd", 
	"rhsusf_M1230a1_usarmy_wd", 
	"rhsusf_M1232_usarmy_wd", 
	"rhsusf_M142_usarmy_WD"];

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
	"RHS_MK19_TriPod_USMC_WD", 
	"RHS_M2StaticMG_MiniTripod_USMC_WD", 
	"RHS_TOW_TriPod_USMC_WD", 
	"CUP_B_MK19_TriPod_US", 
	"CUP_B_M134_A_US_ARMY",
	"CUP_B_M119_US", 
	"CUP_B_M2StaticMG_US", 
	"RHS_M2StaticMG_USMC_WD", 
	"RHS_Stinger_AA_pod_USMC_WD"];
	
a3e_arr_Escape_RoadBlock_StaticTypes_High = [

	];
// An ammo depot have one parked and empty vehicle of the following possible types.
a3e_arr_Escape_AmmoDepot_ParkedVehicleClasses = [
	"CUP_B_FR_Commander"
	];

//Random array. Types of helicopters to spawn
a3e_arr_O_attack_heli = [
	"RHS_AH1Z"];
a3e_arr_O_transport_heli = [
	"rhsusf_CH53e_USMC_cargo", 
	"RHS_UH1Y_FFAR_d", 
	"RHS_UH1Y_UNARMED_d"];
a3e_arr_O_pilots = [
	"rhsusf_airforce_pilot"];
a3e_arr_I_transport_heli = [
	"CUP_I_UH60L_Unarmed_RACS", 
	"CUP_I_UH60L_Unarmed_FFV_Racs", 
	"CUP_I_UH60L_Unarmed_FFV_MEV_Racs"];
a3e_arr_I_pilots = [
	"rhsgref_cdf_air_pilot"];




// The following arrays define weapons and ammo contained at the ammo depots
// Index 0: Weapon classname.
// Index 1: Weapon's probability of presence (in percent, 0-100).
// Index 2: If weapon exists, crate contains at minimum this number of weapons of current class.
// Index 3: If weapon exists, crate contains at maximum this number of weapons of current class.
// Index 4: Array of magazine classnames. Magazines of these types are present if weapon exists.
// Index 5: Number of magazines per weapon that exists.

// Weapons and ammo in the basic weapons box
a3e_arr_AmmoDepotWeapons = [];
a3e_arr_AmmoDepotWeapons pushback ["rhsusf_weap_m1911a1", 50, 2, 5, ["rhsusf_mag_7x45acp_MHP"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhsusf_weap_MP7A2", 50, 1, 2, ["rhsusf_mag_40Rnd_46x30_FMJ"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m4a1_wd", 100, 3, 5, ["rhs_mag_30Rnd_556x45_M855A1_Stanag","rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m4a1_blockII_KAC_wd", 50, 2, 4, ["rhs_mag_30Rnd_556x45_M855A1_Stanag","rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m4a1_m203s_wd", 75, 2, 4, ["rhs_mag_30Rnd_556x45_M855A1_Stanag","rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red","rhs_mag_M441_HE"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m240B", 20, 1, 2, ["rhsusf_100Rnd_762x51"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_XM2010_wd", 10, 1, 2, ["rhsusf_5Rnd_300winmag_xm2010"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_XM2010_wd_leu", 10, 1, 2, ["rhsusf_5Rnd_300winmag_xm2010"], 6];
// non-CSAT weapons
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m249_pip", 50, 2, 4, ["rhsusf_100Rnd_556x45_soft_pouch"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m16a4_grip", 50, 1, 3, ["rhs_mag_30Rnd_556x45_M855A1_Stanag"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m16a4_carryhandle_M203", 50, 1, 3, ["rhs_mag_30Rnd_556x45_M855A1_Stanag","rhs_mag_M441_HE"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_g36c", 30, 1, 2, ["rhssaf_30rnd_556x45_Tracers_G36"], 8];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m14ebrri_leu", 10, 1, 2, ["rhsusf_20Rnd_762x51_m118_special_Mag"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_g36kv", 50, 1, 2, ["rhssaf_30rnd_556x45_Tracers_G36"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_hk416d10_m320", 10, 1, 2, ["rhs_mag_30Rnd_556x45_M855A1_Stanag","rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red","rhs_mag_M441_HE"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m4_grip", 10, 1, 2, ["rhs_mag_30Rnd_556x45_M855A1_Stanag"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_mk18_KAC_wd", 10, 1, 2, ["rhs_mag_30Rnd_556x45_M855A1_Stanag"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_scorpion", 40, 1, 2, ["rhsgref_20rnd_765x17_vz61"], 6];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m21a_pr", 40, 1, 2, ["rhsgref_30rnd_556x45_m21"], 8];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m70ab2", 40, 1, 2, ["rhssaf_30Rnd_762x39mm_M67"], 8];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_M590_8RD", 10, 1, 2, ["rhsusf_8Rnd_00Buck","rhsusf_8Rnd_Slug"], 10];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_sr25_ec_wd", 20, 2, 4, ["rhsusf_20Rnd_762x51_m118_special_Mag"], 9];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m40a5_wd", 30, 2, 4, ["rhsusf_10Rnd_762x51_m118_special_Mag"], 10];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_hk416d145_wd", 10, 1, 2, ["rhs_mag_30Rnd_556x45_M855A1_Stanag"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m27iar", 30, 1, 2, ["rhs_mag_30Rnd_556x45_M855A1_Stanag"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_XM2010_wd", 30, 2, 4, ["rhsusf_5Rnd_300winmag_xm2010"], 9];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m240B_CAP", 50, 1, 3, ["rhsusf_50Rnd_762x51_m80a1epr","rhsusf_100Rnd_762x51"], 3];
// non-CAST weapons
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m32_usmc", 10, 2, 4, ["rhsusf_mag_6Rnd_M433_HEDP","rhsusf_mag_6Rnd_M576_Buckshot","rhsusf_mag_6Rnd_M713_red"], 5];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m249_pip", 30, 1, 2, ["rhsusf_100Rnd_556x45_soft_pouch"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m84", 50, 1, 2, ["rhs_100Rnd_762x54mmR"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m70b1n", 35, 1, 2, ["rhssaf_30Rnd_762x39mm_M67"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m70b3n", 35, 1, 2, ["rhssaf_30Rnd_762x39mm_M67"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m82a1", 10, 1, 2, ["rhsusf_mag_10Rnd_STD_50BMG_M33","rhsusf_mag_10Rnd_STD_50BMG_mk211"], 4];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_m72a7", 10, 1, 2, ["rhs_m72a7_mag"], 1];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_M136_hedp", 10, 1, 3, ["rhs_m136_hedp_mag"], 3];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_maaws", 10, 1, 2, ["rhs_mag_maaws_HEAT","rhs_mag_maaws_HEDP","rhs_mag_maaws_HE"], 2];
// non-CSAT weapons
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_fgm148", 30, 1, 2, ["rhs_fgm148_magazine_AT"], 2];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_smaw_green", 30, 1, 2, ["rhs_mag_smaw_HEAA","rhs_mag_smaw_HEDP"], 2];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_M136", 50, 1, 3, ["rhs_m136_mag"], 1];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_M136_hedp", 50, 1, 3, ["rhs_m136_hedp_mag"], 1];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_M136_hp", 50, 1, 3, ["rhs_m136_hp_mag"], 1];
a3e_arr_AmmoDepotWeapons pushback ["rhs_weap_fim92", 50, 1, 2, ["rhs_fim92_mag"], 3];
// CUP Weapons - NATO variety (bullpups, battle rifles, SMGs, LMGs, snipers)
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_L85A2", 30, 1, 3, ["CUP_30Rnd_556x45_Stanag"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_L85A2_GL", 15, 1, 2, ["CUP_30Rnd_556x45_Stanag","rhs_mag_M441_HE"], 4];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_FNFAL", 25, 1, 2, ["CUP_20Rnd_762x51_FNFAL_M"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_Mk16_STD", 20, 1, 2, ["CUP_30Rnd_556x45_Stanag"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_Mk17_STD", 15, 1, 2, ["CUP_20Rnd_762x51_FNFAL_M"], 5];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_AUG_A1", 25, 1, 2, ["CUP_30Rnd_556x45_AUG"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_G36A", 20, 1, 2, ["CUP_30Rnd_556x45_G36"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_FAMAS_F1", 20, 1, 2, ["CUP_30Rnd_556x45_Stanag"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_CZ805_A1", 20, 1, 2, ["CUP_30Rnd_556x45_Stanag"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_arifle_Sa58V", 25, 1, 2, ["CUP_30Rnd_Sa58_M"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_smg_MP5A5", 30, 1, 3, ["CUP_30Rnd_9x19_MP5"], 8];
a3e_arr_AmmoDepotWeapons pushback ["CUP_smg_MP5SD6", 10, 1, 1, ["CUP_30Rnd_9x19_MP5"], 8];
a3e_arr_AmmoDepotWeapons pushback ["CUP_smg_UZI", 20, 1, 2, ["CUP_32Rnd_9x19_UZI"], 6];
a3e_arr_AmmoDepotWeapons pushback ["CUP_lmg_minimi", 25, 1, 2, ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249"], 3];
a3e_arr_AmmoDepotWeapons pushback ["CUP_lmg_Mk48_wdl", 15, 1, 2, ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M"], 4];
a3e_arr_AmmoDepotWeapons pushback ["CUP_lmg_M60E4", 15, 1, 2, ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M"], 4];
a3e_arr_AmmoDepotWeapons pushback ["CUP_srifle_M24_wdl", 15, 1, 2, ["CUP_5Rnd_762x51_M24"], 10];
a3e_arr_AmmoDepotWeapons pushback ["CUP_srifle_AWM_wdl", 5, 1, 1, ["CUP_5Rnd_86x70_L115A1"], 8];
a3e_arr_AmmoDepotWeapons pushback ["CUP_srifle_M110", 15, 1, 2, ["CUP_20Rnd_762x51_M110"], 6];


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
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_anpeq15_light", 50, 1, 5];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_anpeq15side_bk", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_pbs1", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_tgpa", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_tgpv", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_muzzleFlash_dtk", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_mrds", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_nt4_black", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_LEUPOLDMK4_2", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_1p63", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_pkas", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_ekp1", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ACOG_USMC", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ACOG2_USMC", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ACOG3", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_pso1m2", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_acc_1p29", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_wmx_bk", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_eotech_xps3", 20, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_SF3P556", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_SFMB556", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_rotex5_grey", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_HAMR", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_LEUPOLDMK4", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ELCAN", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ACOG", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ACOG2", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_M2010S", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_SR25S", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_compm4", 20, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_eotech_552", 20, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_eotech_552_wd", 20, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ACOG3", 10, 1, 3];
if(A3E_Param_NoNightvision==0) then {
	a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_anpas13gv1", 10, 1, 3];
	a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_anpvs27", 10, 1, 3];
	a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_ACOG_anpvs27", 10, 1, 3];
	a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_premier_anpvs27", 10, 1, 3];
};
a3e_arr_AmmoDepotItems pushback ["O_UavTerminal", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_weap_optic_smaw", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhs_optic_maaws", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_grip1", 10, 1, 3];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_grip2", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_grip2_wd", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_grip3", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_rvg_blk", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_tacsac_blk", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_tacsac_blue", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_tdstubby_blk", 10, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhsusf_acc_harris_bipod", 20, 1, 2];
a3e_arr_AmmoDepotItems pushback ["rhs_bipod", 10, 1, 2];
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
// Here is a list of scopes:
a3e_arr_Scopes = [
	"rhsusf_acc_compm4"
	,"rhsusf_acc_eotech_552"
	,"rhsusf_acc_LEUPOLDMK4"
	,"rhsusf_acc_ACOG"
	,"rhsusf_acc_ACOG2"
	,"rhsusf_acc_ACOG3"
	,"rhsusf_acc_T1_high"
	,"rhsusf_acc_g33_T1"
	,"rhsusf_acc_T1_low"
	,"rhsusf_acc_LEUPOLDMK4_2"
	,"rhsusf_acc_eotech_xps3"
	,"rhsusf_acc_eotech_xps3"
	,"rhsusf_acc_eotech_552"
	,"rhsusf_acc_RM05"
	,"rhsusf_acc_eotech_xps3"
	,"rhsusf_acc_eotech_552_wd"
	,"rhsusf_acc_compm4"
	,"rhsusf_acc_eotech_xps3"
	,"rhsusf_acc_eotech_552_wd"
	,"rhsusf_acc_compm4"];
a3e_arr_Scopes_SMG = [
	"rhsusf_acc_eotech_xps3"
	,"rhsusf_acc_eotech_552"
	,"rhsusf_acc_eotech_552_wd"
	,"rhs_m4_compm4"
	,"rhsusf_acc_RM05"];
a3e_arr_Scopes_Sniper = [
	"rhsusf_acc_LEUPOLDMK4"
	,"rhsusf_acc_LEUPOLDMK4_2"];
a3e_arr_NightScopes = [
	"rhsusf_acc_anpvs27"
	,"rhsusf_acc_ACOG_anpvs27"
	,"rhsusf_acc_premier_anpvs27"];
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
//////////////////////////////////////////////////////////////////
a3e_arr_extraction_chopper = [
	"rhs_ka60_c"
	,"RHS_Mi8mt_vvs"];
a3e_arr_extraction_chopper_escort = [
	"RHS_Ka52_vvs"
	,"rhs_mi28n_vvs"
	,"RHS_Mi24P_vvs"
	,"RHS_Mi24V_vvs"];

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
//////////////////////////////////////////////////////////////////
a3e_arr_extraction_car = [
	"vn_b_wheeled_m54_01",	//ToDo
	"vn_b_wheeled_m54_02",	//
	"vn_b_wheeled_m54_01_sog",	//
	"vn_b_wheeled_m54_02_sog"];	//
a3e_arr_extraction_car_escort = [
	"vn_b_armor_m41_01_02"];

a3e_arr_friendly_aircraft = [
	"vn_b_air_f4c_cas"];


//////////////////////////////////////////////////////////////////
// EscapeSurprises.sqf and CreateSearchDrone.sqf
// Classnames of drones
//////////////////////////////////////////////////////////////////
a3e_arr_searchdrone = [
	"B_UAV_02_F"
	,"B_UAV_02_CAS_F"];

//////////////////////////////////////////////////////////////////
// CreateSearchChopper.sqf
// first chopper that's called when you escape
// Two arrays for "Easy" and "Hard" parameter, both used on stadard setting
//////////////////////////////////////////////////////////////////

a3e_arr_searchChopperEasy = [
	"RHS_MELB_MH6M"
	,"RHS_UH1Y_UNARMED"
	,"RHS_UH60M2"
	,"RHS_UH60M_ESSS"];
a3e_arr_searchChopperHard = [
	"RHS_UH1Y"
	,"RHS_UH1Y_FFAR"
	,"RHS_MELB_AH6M"
	,"RHS_UH60M"];
a3e_arr_searchChopper_pilot = [
	"rhsusf_usmc_marpat_wd_helipilot"];
a3e_arr_searchChopper_crew = [
	"rhsusf_usmc_marpat_wd_helicrew"];

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
	"RHS_M252_D"
	,"rhssaf_army_m252"];
a3e_arr_ArtillerySite = [
	"vn_o_nva_static_d44_01"];

//////////////////////////////////////////////////////////////////
// fn_CallCAS.sqf
// Classnames of planes for the CAS module
//////////////////////////////////////////////////////////////////
a3e_arr_CASplane = [
	"RHS_A10"
	,"RHS_A10"
	,"rhsusf_f22"
	,"rhssaf_airforce_l_18"];
a3e_CASModule = "ModuleCAS_F"; // "ModuleCAS_F"

//////////////////////////////////////////////////////////////////
// fn_CrashSite
// Random crashsite of west heli with west weapons
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
	,"Land_rhs_mi28_wreck"
	,"Land_rhs_mi28_wreck2"
	,"Land_rhs_tu95_wreck"
	,"Mi8Wreck"];
a3e_arr_CrashSiteCrew = [
	"rhs_pilot_combat_heli"];
a3e_arr_CrashSiteWrecksCar = [
	"Land_Wreck_BMP2_F"
	,"Land_Wreck_BRDM2_F"
	,"Land_Wreck_T72_hull_F"];
a3e_arr_CrashSiteCrewCar = [
	"rhs_vdv_flora_crew"
	,"rhs_vdv_flora_armoredcrew"
	,"rhs_vdv_flora_combatcrew"];
// Weapons and ammo in crash site box
a3e_arr_CrashSiteWeapons = [];
a3e_arr_CrashSiteItems = [];
a3e_arr_CrashSiteBackpacks = [];
a3e_arr_CrashSiteMags = [];
a3e_crashSiteBox = "vn_b_ammobox_05";





a3e_arr_CrashSiteWeapons pushback ["rhs_weap_ak74m_gp25_1p63", 50, 2, 5, ["rhs_30Rnd_545x39_7N6M_green_AK","rhs_30Rnd_545x39_7N10_2mag_plum_AK","rhs_VOG25"], 4];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_rpg26", 10, 1, 2, ["rhs_rpg26_mag"], 1];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_ak74_3", 100, 3, 5, ["rhs_30Rnd_545x39_7N6_green_AK","rhs_30Rnd_545x39_7N10_2mag_plum_AK"], 4];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_pkm", 10, 1, 2, ["rhs_100Rnd_762x54mmR","rhs_100Rnd_762x54mmR_green"], 3];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_akms", 75, 2, 4, ["rhs_30Rnd_545x39_7N10_AK","rhs_45Rnd_545x39_7N10_AK"], 4];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_svdp_wd_npz", 20, 1, 2, ["rhs_10Rnd_762x54mmR_7N1"], 8];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_asval_grip_npz", 20, 1, 2, ["rhs_20rnd_9x39mm_SP6"], 12];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_svd_pso1", 10, 1, 2, ["rhs_10Rnd_762x54mmR_7N1"], 8];
a3e_arr_CrashSiteWeapons pushback ["rhs_weap_pkp_pkas", 10, 1, 2, ["rhs_100Rnd_762x54mmR"], 6];
// CUP Weapons - Eastern/Russian wreckage variety
a3e_arr_CrashSiteWeapons pushback ["CUP_arifle_AK74M", 60, 2, 4, ["CUP_30Rnd_545x39_AK_M"], 6];
a3e_arr_CrashSiteWeapons pushback ["CUP_arifle_AK103", 40, 1, 3, ["CUP_30Rnd_762x39_AK47M"], 6];
a3e_arr_CrashSiteWeapons pushback ["CUP_arifle_AKS74U", 50, 1, 3, ["CUP_30Rnd_545x39_AK_M"], 6];
a3e_arr_CrashSiteWeapons pushback ["CUP_lmg_Pecheneg", 15, 1, 2, ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M"], 4];
a3e_arr_CrashSiteWeapons pushback ["CUP_srifle_ksvk", 5, 1, 1, ["CUP_5Rnd_127x108_KSVK_M"], 4];
a3e_arr_CrashSiteWeapons pushback ["CUP_srifle_VSSVintorez", 15, 1, 2, ["CUP_10Rnd_9x39_SP5_VSS_M"], 8];
a3e_arr_CrashSiteWeapons pushback ["CUP_smg_bizon", 30, 1, 3, ["CUP_64Rnd_9x19_Bizon_M"], 4];
a3e_arr_CrashSiteWeapons pushback ["CUP_srifle_SVD", 20, 1, 2, ["CUP_10Rnd_762x54_SVD_M"], 8];
// Attachments and other items in crash site box
a3e_arr_CrashSiteItems = [];
a3e_arr_CrashSiteItems pushback ["rhs_acc_ekp1", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_ekp8_02", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_npz", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_pkas", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_pso1m2", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_1p78", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_1p63", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_nita", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_2dpZenit", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_perst1ik", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["hlc_muzzle_545SUP_AK", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_pbs1", 10, 1, 3];
a3e_arr_CrashSiteItems pushback ["rhs_acc_tgpv", 10, 1, 3];

// Attachments and other items in crash site box
if(A3E_Param_NVGs==1) then {
	a3e_arr_CrashSiteItems pushback ["NVGoggles_OPFOR", 10, 1, 3];
};
if(A3E_Param_NVScopes==1) then {
	a3e_arr_CrashSiteItems pushback ["vn_o_anpvs2_m40a1", 30, 1, 1];
	a3e_arr_CrashSiteItems pushback ["vn_o_anpvs2_m16", 30, 1, 1];
};
//a3e_arr_CrashSiteItems pushback ["FirstAidKit", 100, 5, 10];
//a3e_arr_CrashSiteItems pushback ["Medikit", 100, 1, 1];
//a3e_arr_CrashSiteItems pushback ["Toolkit", 100, 1, 1];
a3e_arr_CrashSiteItems pushback ["Binocular", 50, 1, 2];

a3e_arr_CrashSiteItems pushback ["vn_o_9x_m40a1", 10, 1, 1];
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