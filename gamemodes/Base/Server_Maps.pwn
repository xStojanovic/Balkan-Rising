#include <YSI\y_hooks>

//====================================
/*
              Balkan Rising
                 0.0.1x
                  Maps
*/                  
//====================================                  

new ugspawnbylevu,autosalon,motel,dizalice[2],osiguranjemap,osiguranjevrata;

new nalpovrata = 0;

new parking[23],pod[8],vrata[1],zidovi[22],mstalak[8],mdrzac[4],monitor[7], reklama[1], televizor[1], tastatura[3],mis[3], salter[7], office[2];

hook OnPlayerConnect(playerid)
{
	SetPlayerMapIcon( playerid, 0, 1365.9000,-1765.2555,13.5689, 55, 0, MAPICON_LOCAL ); //autosalon
	SetPlayerMapIcon( playerid, 0, 2016.0305,-1879.5741,13.5859, 55, 0, MAPICON_LOCAL ); //motosalon

	RemoveBuildings(playerid);
	return (true);
}

hook OnGameModeInit()
{
	LoadMapCode();
	return (true);
}

stock RemoveBuildings(playerid)
{
    //////////spawn
	RemoveBuildingForPlayer(playerid, 5955, 1301.187, -1257.062, 21.507, 0.250);
	RemoveBuildingForPlayer(playerid, 5709, 1301.187, -1257.062, 21.507, 0.250);
	RemoveBuildingForPlayer(playerid, 1227, 1322.187, -1235.882, 13.437, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1327.429, -1239.984, 13.937, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1327.429, -1234.742, 13.937, 0.250);
	RemoveBuildingForPlayer(playerid, 1219, 1332.835, -1241.718, 13.414, 0.250);
	// levu autosalon
	RemoveBuildingForPlayer(playerid, 4051, 1371.8203, -1754.8203, 19.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 4191, 1353.2578, -1764.5313, 15.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 4022, 1353.2578, -1764.5313, 15.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1532, 1353.1328, -1759.6563, 12.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1341.4531, -1755.4844, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1345.7656, -1740.6172, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 4021, 1371.8203, -1754.8203, 19.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1388.3594, -1745.4453, 15.6250, 0.25);
	// levu motel
	RemoveBuildingForPlayer(playerid, 5551, 2140.515, -1735.140, 15.890, 0.250);
	RemoveBuildingForPlayer(playerid, 5633, 2089.359, -1643.929, 18.218, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2116.726, -1713.460, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2118.093, -1718.546, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2121.375, -1721.687, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2126.578, -1722.468, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2131.843, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 5410, 2140.515, -1735.140, 15.890, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2137.109, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2142.312, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2147.593, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2152.875, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2158.148, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2163.429, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 2175.312, -1730.890, 12.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2168.765, -1722.656, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2173.234, -1720.820, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2175.132, -1716.289, 13.703, 0.250);
	// bolnica
	RemoveBuildingForPlayer(playerid, 617, 1178.6016, -1332.0703, 12.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.0078, -1353.5000, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.0078, -1343.2656, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 618, 1177.7344, -1315.6641, 13.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.8125, -1292.9141, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.8125, -1303.1484, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1190.7734, -1320.8594, 15.9453, 0.25);
	// bolnica park
	RemoveBuildingForPlayer(playerid, 5929, 1230.8906, -1337.9844, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1341.8516, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1328.0938, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1356.2109, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5812, 1230.8906, -1337.9844, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1300.9219, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1300.9219, 12.2969, 0.25);
    return (true);
}

stock LoadMapCode()
{
// spawn
	ugspawnbylevu = CreateDynamicObjectEx(18981,1320.313,-1258.471,12.057,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10355, "haight1_sfs", "drivetile_02", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18981,1320.306,-1233.495,12.057,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10355, "haight1_sfs", "drivetile_02", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18981,1295.332,-1258.472,12.057,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10355, "haight1_sfs", "drivetile_02", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18766,1327.860,-1270.507,10.663,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18766,1312.003,-1270.504,10.663,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18981,1332.364,-1258.502,0.660,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18981,1307.484,-1258.502,0.660,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18981,1320.363,-1246.495,0.660,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1314.756,-1252.238,12.485,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14771, "int_brothelint3", "GB_nastybar12", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1325.246,-1252.258,12.485,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14771, "int_brothelint3", "GB_nastybar12", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19391,1320.041,-1256.850,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1329.714,-1257.010,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1328.123,-1256.850,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1310.299,-1257.010,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1311.884,-1257.010,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1330.430,-1252.268,10.733,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1325.268,-1247.538,11.170,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1314.789,-1247.538,11.170,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1309.584,-1252.241,10.733,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1309.587,-1266.935,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1311.273,-1266.935,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1309.525,-1263.843,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1311.273,-1263.843,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1309.507,-1260.914,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1311.273,-1260.914,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1309.435,-1258.054,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1311.273,-1258.054,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.417,-1266.935,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1328.736,-1266.935,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.417,-1263.843,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1328.736,-1263.843,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.417,-1260.914,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1328.736,-1260.914,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.417,-1258.054,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1328.736,-1258.054,11.755,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14865, "gf2", "mp_bobbie_carpwhite", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19391,1320.041,-1257.010,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1329.714,-1256.850,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1328.123,-1257.010,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1311.884,-1256.850,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1310.299,-1256.850,14.230,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1309.604,-1252.241,10.733,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1330.450,-1252.268,10.733,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1325.268,-1247.518,11.170,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1314.789,-1247.518,11.170,90.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1325.246,-1252.258,15.904,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19377,1314.756,-1252.238,15.904,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1314.371,-1257.010,11.016,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1325.620,-1257.010,11.016,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 14859, "gf1", "mp_cooch_carp", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18980,1316.520,-1270.502,2.353,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18980,1323.344,-1270.508,2.353,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18980,1332.362,-1270.512,2.353,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18980,1307.442,-1270.508,2.353,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1311.901,-1270.505,13.065,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1328.007,-1270.519,13.065,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1307.409,-1265.286,13.065,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18980,1307.442,-1260.584,2.353,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1307.409,-1255.691,13.065,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18766,1307.442,-1248.497,9.864,0.000,90.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1332.365,-1265.299,13.065,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18980,1332.362,-1260.148,2.353,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1332.384,-1255.509,13.065,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18766,1332.362,-1248.484,9.864,0.000,90.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1327.159,-1246.472,13.065,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18980,1322.046,-1246.494,2.353,0.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19454,1316.721,-1246.519,13.065,0.000,0.000,90.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 6293, "lawland2", "lightglass", 0);
	ugspawnbylevu = CreateDynamicObjectEx(18766,1309.438,-1246.481,9.864,0.000,90.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.395,-1252.446,14.250,90.000,0.000,0.000,300.000,300.000);//ekran
	SetDynamicObjectMaterial(ugspawnbylevu, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.405,-1252.446,14.150,90.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu , 0, 2361, "shopping_freezers", "white", 0xFF7d6d59);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.405,-1252.446,14.350,90.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu , 0, 2361, "shopping_freezers", "white", 0xFF7d6d59);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.405,-1252.366,14.350,90.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu , 0, 2361, "shopping_freezers", "white", 0xFF7d6d59);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.405,-1252.366,14.150,90.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu , 0, 2361, "shopping_freezers", "white", 0xFF7d6d59);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.405,-1252.526,14.350,90.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu , 0, 2361, "shopping_freezers", "white", 0xFF7d6d59);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1330.405,-1252.526,14.150,90.000,0.000,0.000,300.000,300.000);
	SetDynamicObjectMaterial(ugspawnbylevu , 0, 2361, "shopping_freezers", "white", 0xFF7d6d59);
	//////////bez textura deo spawna
	ugspawnbylevu = CreateDynamicObjectEx(5709,1291.817,-1240.533,21.487,0.000,0.000,-90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(19425,1321.244,-1270.721,12.546,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(19425,1317.966,-1270.727,12.546,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(19325,1324.846,-1257.057,13.915,0.000,0.000,90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(19325,1315.161,-1257.046,13.915,0.000,0.000,90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(16151,1314.489,-1248.629,12.896,0.000,0.000,90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(2266,1323.872,-1248.124,14.271,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(2267,1309.712,-1252.065,14.271,0.000,0.000,90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(2002,1329.875,-1248.633,12.531,0.000,0.000,-90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1726,1310.204,-1255.179,12.489,0.000,0.000,90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1823,1311.909,-1254.631,12.531,0.000,0.000,90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1726,1321.157,-1248.190,12.489,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1726,1324.720,-1248.152,12.489,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1823,1321.615,-1249.824,12.531,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1823,1325.209,-1249.822,12.531,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1726,1323.192,-1256.315,12.489,0.000,0.000,180.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1823,1321.717,-1255.600,12.531,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1726,1326.532,-1256.294,12.489,0.000,0.000,180.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(1823,1325.038,-1255.579,12.531,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(2231,1324.187,-1247.547,12.551,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(19435,1328.123,-1256.850,1256.850,0.000,0.000,90.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(2855,1322.215,-1255.102,13.006,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(2813,1325.674,-1249.315,13.023,0.000,0.000,0.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(18873,1322.004,-1249.207,13.015,0.000,0.000,150.000,300.000,300.000);
	ugspawnbylevu = CreateDynamicObjectEx(18075,1320.058,-1251.890,15.826,0.000,0.000,90.000,300.000,300.000);
	// levu autosalon
	//////////////
	new tuningparts = CreateDynamicObject(19353, 1353.3699, -1747.4963, 15.1260, 0.0000, 0.0000, -179.9742);
	SetObjectMaterialText(tuningparts, "TUNING PARTS", 0, 140, "Arial", 80, 1, -16777216, 0, 1);

	new tires = CreateDynamicObject(19353, 1343.3991, -1747.9221, 16.1259, 0.0000, 0.0000, 0.0215);
	SetObjectMaterialText(tires, "TIRES", 0, 140, "Arial", 80, 1, -16777216, 0, 1);

	new garage = CreateDynamicObject(19353, 1338.2467, -1742.0192, 14.9028, 0.0000, 0.0000, 89.9911);
	SetObjectMaterialText(garage, "GROTTI GARAGE", 0, 140, "Arial", 70, 1, -1, 0, 1);

	new quality = CreateDynamicObject(19353, 1370.2263, -1759.6768, 14.1860, 0.0000, 0.0000, 89.9381);
	SetObjectMaterialText(quality, "Quality & safety cars", 0, 140, "Arial", 60, 1, -16777216, 0, 1);

	autosalon = CreateDynamicObject(18981,1366.806,-1754.458,12.056,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 3979, "civic01_lan", "airportwall_256128", 0);
	autosalon = CreateDynamicObject(18981,1366.846,-1779.368,12.056,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 3979, "civic01_lan", "airportwall_256128", 0);
	autosalon = CreateDynamicObject(18981,1366.809,-1742.435,0.853,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(18981,1354.798,-1754.439,0.853,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(18981,1378.821,-1762.119,0.853,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(18981, 1354.79797, -1779.42053, 0.85300,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(19377,1362.396,-1764.425,12.483,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2028, "cj_games", "CJ_speaker4", 0);
	autosalon = CreateDynamicObject(19377,1372.874,-1764.429,12.483,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2028, "cj_games", "CJ_speaker4", 0);
	autosalon = CreateDynamicObject(19377,1374.039,-1764.406,14.834,0.000,-60.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377,1364.294,-1764.406,17.443,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19391,1365.800,-1759.687,14.296,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19435,1368.227,-1759.687,16.435,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454,1369.086,-1759.687,12.089,-60.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19435,1368.029,-1759.687,16.555,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19435,1364.661,-1759.687,16.555,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454,1369.086,-1769.164,12.089,-60.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19435,1368.029,-1769.164,16.555,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19435,1368.227,-1769.164,16.435,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454,1365.791,-1769.164,12.700,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454,1373.054,-1759.687,10.878,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454,1373.054,-1769.164,10.878,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377,1364.237,-1764.432,12.194,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 14846, "genintintpoliceb", "p_floor4", 0);
	autosalon = CreateDynamicObject(18980,1378.821,-1742.432,2.917,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(19325,1375.237,-1742.438,13.298,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19325,1358.493,-1742.471,13.298,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(18766,1366.918,-1742.432,12.919,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(18980,1354.778,-1742.432,2.917,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(19325,1354.758,-1746.078,13.298,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19325,1354.757,-1752.700,13.298,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19325,1354.764,-1759.307,13.298,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(18980,1378.826,-1750.123,2.917,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	autosalon = CreateDynamicObject(19325,1378.816,-1753.722,13.298,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19325,1378.815,-1760.325,13.298,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19325,1378.819,-1766.958,13.298,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19325,1378.835,-1773.592,13.298,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19435,1359.020,-1758.876,12.625,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 1717, "cj_tv", "CJ_STEEL", 0);
	autosalon = CreateDynamicObject(19435,1362.506,-1758.875,12.625,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 1717, "cj_tv", "CJ_STEEL", 0);
	autosalon = CreateDynamicObject(19435,1362.506,-1757.281,12.625,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 1717, "cj_tv", "CJ_STEEL", 0);
	autosalon = CreateDynamicObject(19435,1359.020,-1757.281,12.625,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 1717, "cj_tv", "CJ_STEEL", 0);
	autosalon = CreateDynamicObject(19435,1359.020,-1755.698,12.625,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 1717, "cj_tv", "CJ_STEEL", 0);
	autosalon = CreateDynamicObject(19435,1362.506,-1755.698,12.625,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 1717, "cj_tv", "CJ_STEEL", 0);
	autosalon = CreateDynamicObject(2773,1364.205,-1758.589,12.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 11088, "crackfactdem_sfs", "ws_altz_wall7_top_burn", 0);
	autosalon = CreateDynamicObject(2773,1364.207,-1755.918,12.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 11088, "crackfactdem_sfs", "ws_altz_wall7_top_burn", 0);
	autosalon = CreateDynamicObject(2773,1363.182,-1754.958,12.759,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 11088, "crackfactdem_sfs", "ws_altz_wall7_top_burn", 0);
	autosalon = CreateDynamicObject(2773,1358.300,-1754.948,12.759,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 11088, "crackfactdem_sfs", "ws_altz_wall7_top_burn", 0);
	autosalon = CreateDynamicObject(2773,1360.741,-1754.953,12.759,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 11088, "crackfactdem_sfs", "ws_altz_wall7_top_burn", 0);
	autosalon = CreateDynamicObject(2773,1357.319,-1756.008,12.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 11088, "crackfactdem_sfs", "ws_altz_wall7_top_burn", 0);
	autosalon = CreateDynamicObject(2773,1357.297,-1758.554,12.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 11088, "crackfactdem_sfs", "ws_altz_wall7_top_burn", 0);
	autosalon = CreateDynamicObjectEx(3354, 1360.80908, -1759.63025, 15.42460,   0.00000, 0.00000, 90.00000, 300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6336, "sunset02_law2", "SunBillB08", 0);
	autosalon = CreateDynamicObject(19454, 1362.88232, -1759.68701, 12.68560,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454, 1359.59534, -1759.68701, 12.68560,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377, 1356.14380, -1764.42297, 12.27400,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454, 1362.88232, -1769.16394, 12.68560,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454, 1360.79797, -1769.16394, 12.68560,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377, 1361.32983, -1764.40601, 17.44300,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454, 1357.82422, -1759.68701, 12.68560,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19454, 1357.82422, -1769.16394, 12.68560,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19325, 1354.76404, -1765.93652, 13.29800,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(19325, 1354.76404, -1772.53955, 13.29800,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	autosalon = CreateDynamicObject(3354,1348.364,-1756.122,15.588,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 6336, "sunset02_law2", "SunBillB08", 0);
	autosalon = CreateDynamicObject(18981,1340.931,-1756.600,4.865,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1351.802,-1742.432,12.374,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18981,1344.203,-1749.816,11.996,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 9514, "711_sfw", "ws_carpark2", 0);
	autosalon = CreateDynamicObject(18980, 1343.94153, -1742.43201, 4.87700,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18980, 1349.75305, -1742.43201, 4.87700,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1340.945,-1742.432,12.374,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1335.963,-1742.432,12.374,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1331.255,-1743.184,12.374,0.000,90.000,18.719,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1353.802,-1745.397,12.374,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1353.802,-1750.359,12.374,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1353.802,-1755.310,12.374,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1351.789,-1757.336,12.374,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1346.816,-1757.336,12.374,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1341.832,-1757.336,12.374,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1336.866,-1757.336,12.374,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1342.976,-1746.934,14.876,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766,1342.957,-1752.744,14.876,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF120f0a);
	autosalon = CreateDynamicObject(18766, 1352.65503, -1747.73401, 12.69120,   90.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 16640, "a51", "metpat64", 0);
	autosalon = CreateDynamicObject(19377,1349.034,-1746.768,17.305,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0);
	autosalon = CreateDynamicObject(19377,1338.567,-1746.767,17.305,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0);
	autosalon = CreateDynamicObject(19377,1349.034,-1753.012,17.305,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0);
	autosalon = CreateDynamicObject(19377,1338.532,-1753.012,17.305,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(autosalon, 0, 10765, "airportgnd_sfse", "ws_bridgepavement2", 0);
	autosalon = CreateDynamicObject(19377, 1353.37207, -1747.70752, 12.13970,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377, 1353.37207, -1751.47095, 12.13970,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377, 1348.56421, -1756.17517, 12.13970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377, 1339.12646, -1756.17517, 12.13970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377, 1343.39026, -1747.69080, 12.13970,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(19377, 1343.39026, -1751.61292, 12.13970,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	autosalon = CreateDynamicObject(1742, 1352.86609, -1755.59216, 12.47340,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 2, 10282, "michgar", "tool_store", 0);
	autosalon = CreateDynamicObject(2087, 1353.40283, -1753.10999, 12.47340,   0.00000, 0.00000, -90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 10282, "michgar", "tool_store", 0);
	autosalon = CreateDynamicObject(2960, 1344.97729, -1749.47205, 13.52070,   180.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF500100);
	autosalon = CreateDynamicObject(2960, 1348.45679, -1749.51270, 13.52069,   180.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF500100);
	autosalon = CreateDynamicObject(2960, 1348.45569, -1745.90308, 13.52070,   180.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF500100);
	autosalon = CreateDynamicObject(2960, 1344.97729, -1745.87476, 13.52070,   180.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(autosalon, 0, 2361, "shopping_freezers", "white", 0xFF500100);

	// dizalice

	dizalice[0] = CreateDynamicObject(19435, 1346.72839, -1746.03931, 12.43150,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(dizalice[0], 0, 13131, "cunte_blockammo", "metpat64", 0);
	dizalice[1] = CreateDynamicObject(19435, 1346.72839, -1749.59790, 12.43150,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(dizalice[1], 0, 13131, "cunte_blockammo", "metpat64", 0);

	///////deo bez tekstura
	CreateDynamicObject(19325, 1374.57104, -1759.64502, 12.15300,   30.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1368.65906, -1759.61597, 13.40400,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1374.57104, -1769.23804, 12.15300,   30.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 1364.66101, -1759.68701, 1769.16394,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1368.65906, -1769.23804, 13.40400,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1368.59900, -1742.44299, 13.29800,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1365.10901, -1742.46802, 13.29800,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2165, 1364.72595, -1766.45996, 12.52900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1714, 1365.10205, -1767.51697, 12.55000,   0.00000, 0.00000, 141.53900);
	CreateDynamicObject(1722, 1365.08496, -1764.93298, 12.56500,   0.00000, 0.00000, 196.74001);
	CreateDynamicObject(1726, 1368.40796, -1760.40796, 12.49100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1726, 1371.43896, -1761.76501, 12.49100,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1827, 1369.46704, -1762.60095, 12.48700,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18075, 1362.39404, -1764.48706, 17.28300,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1726, 1371.49597, -1765.27197, 12.49100,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1726, 1370.54602, -1768.16504, 12.49100,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1827, 1369.50696, -1766.06299, 12.48700,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2485, 1365.90796, -1766.39294, 13.36000,   0.00000, 0.00000, -133.25900);
	CreateDynamicObject(2464, 1369.39795, -1765.91101, 13.05600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2164, 1366.42297, -1769.06299, 12.56000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2254, 1364.33997, -1764.23901, 15.64800,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1693, 1357.18005, -1751.30701, 11.07100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1693, 1357.18005, -1748.15906, 11.07100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1693, 1357.18005, -1745.07898, 11.07100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1693, 1376.07104, -1749.49597, 11.07100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1693, 1376.07104, -1752.36096, 11.07100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1693, 1376.07104, -1755.55200, 11.07100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11392, 1346.55603, -1751.46997, 12.50200,   0.00000, 0.00000, 18.95900);
	CreateDynamicObject(1066, 1353.87622, -1748.87976, 13.66920,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1074, 1343.56604, -1745.50098, 15.04600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1076, 1343.54297, -1750.30701, 15.04600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1060, 1351.91003, -1744.15295, 13.18920,   0.00000, 0.00000, 89.03900);
	CreateDynamicObject(1061, 1352.03699, -1745.98303, 13.22920,   0.00000, 0.00000, 89.04000);
	CreateDynamicObject(1348, 1351.73499, -1751.64197, 13.86000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(918, 1352.31921, -1750.41309, 13.52920,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(918, 1351.29980, -1750.39478, 13.52920,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1055, 1351.99695, -1747.31006, 13.22920,   0.00000, 0.00000, 89.04000);
	CreateDynamicObject(2961, 1353.29846, -1754.20886, 13.90101,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(927, 1343.50977, -1755.31274, 14.70900,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(914, 1343.48169, -1754.35364, 13.82200,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3354, 1346.85522, -1741.99304, 17.27250,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1079, 1343.56604, -1748.83008, 15.04600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1081, 1343.56604, -1746.98975, 15.04600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1650, 1351.29810, -1755.99780, 12.79980,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1650, 1350.98621, -1755.99780, 12.79980,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1650, 1351.59558, -1755.99780, 12.79980,   0.00000, 0.00000, 0.00000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// levu motel
	new mrecepcija = CreateDynamicObject(19353, 2132.6948, -1734.4898, 14.8869, 0.0000, 0.0000, -89.9564);
	SetObjectMaterialText(mrecepcija, "RECEPCIJA", 0, 140, "Arial", 70, 1, -1, 0, 1);

	new tripaco = CreateDynamicObject(7914, 2151.9499, -1741.4677, 17.7599, 0.0000, 0.0000, 0.0867);
	SetObjectMaterialText(tripaco, "TRIPACO", 0, 140, "Comic Sans MS", 80, 1, -1, 0, 1);

	new tmotel = CreateDynamicObject(19353, 2152.4692, -1741.8187, 18.9495, 0.0000, 0.0000, -89.9862);
	SetObjectMaterialText(tmotel, "MOTEL", 0, 140, "Arial", 120, 1, -1, 0, 1);

	new mparking = CreateDynamicObject(19353, 2163.8576, -1742.1046, 12.4809, -0.0999, -89.9000, -90.9399);
	SetObjectMaterialText(mparking, "PARKING", 0, 140, "Arial", 125, 1, -1, 0, 1);

	motel = CreateDynamicObject(18981,2162.520,-1730.176,12.067,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 14846, "genintintpoliceb", "p_floor3", 0);
	motel = CreateDynamicObject(18981,2137.534,-1730.173,12.067,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 14846, "genintintpoliceb", "p_floor3", 0);
	motel = CreateDynamicObject(19381,2120.823,-1737.914,12.482,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	motel = CreateDynamicObject(19381,2120.830,-1728.364,12.482,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	motel = CreateDynamicObject(19381,2121.714,-1722.621,12.481,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	motel = CreateDynamicObject(19377,2142.756,-1741.817,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19391,2136.357,-1741.817,14.275,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2129.968,-1741.817,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2147.489,-1737.084,14.247,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2147.489,-1727.461,14.247,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2125.237,-1737.084,14.247,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2125.237,-1727.461,14.247,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2142.760,-1722.733,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2129.966,-1722.733,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19391,2136.339,-1722.733,14.275,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19435,2136.336,-1722.733,13.286,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2142.664,-1734.481,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 8639, "chinatownmall", "ctmall10_64", 0);
	motel = CreateDynamicObject(19377,2141.559,-1736.838,14.247,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 9525, "boigas_sfw", "GEwhite1_64", 0);
	motel = CreateDynamicObject(19377,2142.756,-1741.717,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 8639, "chinatownmall", "ctmall10_64", 0);
	motel = CreateDynamicObject(19391,2136.357,-1741.717,14.275,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 9525, "boigas_sfw", "GEwhite1_64", 0);
	motel = CreateDynamicObject(19377,2129.968,-1741.717,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 8639, "chinatownmall", "ctmall10_64", 0);
	motel = CreateDynamicObject(19377,2125.336,-1737.002,14.247,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 8639, "chinatownmall", "ctmall10_64", 0);
	motel = CreateDynamicObject(19377,2133.061,-1734.481,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 8639, "chinatownmall", "ctmall10_64", 0);
	motel = CreateDynamicObject(19377,2126.867,-1729.947,14.247,0.000,0.000,17.639,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 8639, "chinatownmall", "ctmall10_64", 0);
	motel = CreateDynamicObject(19377,2130.171,-1732.816,14.247,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 9525, "boigas_sfw", "GEwhite1_64", 0);
	motel = CreateDynamicObject(19377,2130.414,-1737.073,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19377,2140.884,-1737.073,15.928,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 3967, "cj_airprt", "ceiling_256", 0);
	motel = CreateDynamicObject(19377,2130.414,-1737.073,15.928,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 3967, "cj_airprt", "ceiling_256", 0);
	motel = CreateDynamicObject(19377,2142.321,-1737.072,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19377,2142.321,-1727.516,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19377,2130.425,-1727.516,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19377,2137.697,-1727.516,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19454,2152.348,-1741.817,17.752,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2138.632,-1737.072,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19454,2152.348,-1722.733,17.752,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19454,2157.100,-1727.472,17.752,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19454,2157.100,-1737.067,17.752,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2151.927,-1737.071,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19377,2151.932,-1727.516,19.427,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_hngr_jsts", 0);
	motel = CreateDynamicObject(19377,2151.927,-1737.071,16.082,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(19377,2151.932,-1727.516,16.082,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	motel = CreateDynamicObject(18980,2156.688,-1741.358,6.987,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 11395, "corvinsign_sfse", "shutters", 0);
	motel = CreateDynamicObject(18980,2156.677,-1723.155,6.987,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 11395, "corvinsign_sfse", "shutters", 0);
	motel = CreateDynamicObject(19377,2140.884,-1737.073,12.491,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 11013, "crackdrive_sfse", "ws_asphalt2", 0);
	motel = CreateDynamicObject(19377,2130.414,-1737.073,12.491,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 11013, "crackdrive_sfse", "ws_asphalt2", 0);
	motel = CreateDynamicObject(1506,2125.833,-1732.897,12.548,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2130.621,-1736.485,12.526,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(1491,2130.510,-1736.050,11.057,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(1491, 2135.57983, -1741.82861, 12.50800,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2450,2130.621,-1737.489,12.526,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2131.318,-1737.248,12.526,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2132.306,-1737.248,12.526,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2133.301,-1737.248,12.526,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2134.283,-1737.248,12.526,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2450,2135.271,-1737.248,12.526,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2135.026,-1736.546,12.526,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2135.026,-1735.546,12.526,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2446,2135.026,-1734.563,12.526,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2315,2138.677,-1739.479,12.538,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(2315,2138.616,-1736.796,12.538,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 1730, "cj_furniture", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(motel, 1, 1730, "cj_furniture", "CJ_WOOD5", 0);
	motel = CreateDynamicObject(18766,2130.531,-1742.290,10.803,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18766,2120.549,-1742.290,10.803,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18981,2116.039,-1730.274,0.813,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18981,2128.057,-1718.259,0.813,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18981,2149.610,-1742.290,0.813,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18766,2170.542,-1742.215,10.803,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18981,2163.039,-1723.207,0.813,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18981,2138.043,-1723.207,0.813,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18766,2175.054,-1737.699,10.823,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18766,2175.054,-1727.717,10.823,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18766,2126.250,-1718.257,11.701,0.000,-10.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18766,2136.090,-1718.257,13.432,0.000,-10.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(19454,2125.229,-1732.434,15.809,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0);
	motel = CreateDynamicObject(19454,2136.347,-1741.807,17.743,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0);
	motel = CreateDynamicObject(19454,2139.510,-1722.725,17.743,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0);
	motel = CreateDynamicObject(19435,2145.515,-1741.837,16.273,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0);
	motel = CreateDynamicObject(19435,2143.910,-1741.837,16.273,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0);
	motel = CreateDynamicObject(19435, 2128.68018, -1741.83704, 16.27300,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(motel, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0);
	motel = CreateDynamicObject(19435, 2130.27148, -1741.83704, 16.27300,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(motel, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0);
	motel = CreateDynamicObject(18766,2157.676,-1737.732,10.803,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(18766,2157.676,-1727.765,10.803,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2127, "cj_kitchen", "marble2", 0);
	motel = CreateDynamicObject(2737,2141.425,-1738.402,14.344,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	//tv
	SetDynamicObjectMaterial(motel, 1, 2361, "shopping_freezers", "white", 0xFF120f0a); //ekran
	SetDynamicObjectMaterial(motel, 0, 2361, "shopping_freezers", "white", 0xFF6d6150); //belospolja
	//laptop
	motel = CreateDynamicObject(2266,2132.756,-1737.003,14.076,-90.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	SetDynamicObjectMaterial(motel, 1, 16644, "a51_detailstuff", "Gen_Keyboard", 0);
	motel = CreateDynamicObject(2266,2132.756,-1737.243,13.816,-30.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	SetDynamicObjectMaterial(motel, 1, 2361, "shopping_freezers", "white", 0xFF120f0a);
	motel = CreateDynamicObject(2266,2132.736,-1738.099,13.321,30.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(motel, 0, 2361, "shopping_freezers", "white", 0xFF6d6150);
	SetDynamicObjectMaterial(motel, 1, 2361, "shopping_freezers", "white", 0xFF6d6150);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	motel = CreateDynamicObject(19325,2136.120,-1741.817,17.415,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(19325,2136.064,-1722.733,17.415,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1714,2132.680,-1736.005,12.577,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(2164,2133.506,-1734.566,12.547,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(2894,2131.930,-1737.276,13.569,0.000,0.000,160.260,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(2196,2131.638,-1736.894,13.550,0.000,0.000,19.020,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1726,2140.371,-1741.008,12.518,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1726,2138.353,-1735.142,12.518,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(2854,2139.229,-1736.832,13.032,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(2855,2139.362,-1739.465,13.012,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(2267,2125.464,-1737.320,14.305,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(2400,2134.169,-1734.377,14.208,0.000,180.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1955,2131.283,-1734.823,13.285,90.000,0.000,21.299,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1955,2131.885,-1734.835,13.285,90.000,0.000,21.299,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1955,2132.466,-1734.845,13.285,90.000,0.000,21.299,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(18075,2134.134,-1738.064,15.853,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(8991,2120.494,-1732.855,13.075,0.000,0.000,-88.560,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(6965,2121.334,-1732.096,9.067,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(673,2121.004,-1739.972,10.717,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(673,2120.356,-1725.938,10.717,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1412,2175.145,-1714.944,13.703,3.141,0.000,1.616,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2172.244,-1738.341,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2172.244,-1735.381,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2172.244,-1732.662,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2172.244,-1729.941,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2172.244,-1727.084,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2160.059,-1727.084,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2160.059,-1729.941,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2160.059,-1732.662,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2160.059,-1735.381,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	motel = CreateDynamicObject(1693,2160.059,-1738.341,11.070,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
    // pederski nalpo
    new nalpo = CreateDynamicObject(19353, 1296.7370, -1871.6926, 13.1259, 0.0000, 0.0000, 89.9153);
	SetObjectMaterialText(nalpo, "NALPO OSIGURANJE", 0, 140, "Impact", 50, 1, -16777216, 0, 1);

	new nalpospolja = CreateDynamicObject(7914, 1296.3073, -1862.6145, 18.3528, 0.0000, 0.0000, -179.9313);
	SetObjectMaterialText(nalpospolja, "NALPO OSIGURANJE", 0, 140, "Impact", 60, 1, -16777216, 0, 1);

	new nalpokomp1 = CreateDynamicObject(19327, 1296.0944, -1872.0290, 13.9159, 0.0000, 0.0000, 0.0332);
	SetObjectMaterialText(nalpokomp1, "NALPO", 0, 140, "Arial", 30, 1, -16777216, 0, 1);

	new nalpokomp2 = CreateDynamicObject(19327, 1297.57422, -1872.02905, 13.91590, 0.0000, 0.0000, 0.0332);
	SetObjectMaterialText(nalpokomp2, "NALPO", 0, 140, "Arial", 30, 1, -16777216, 0, 1);

	osiguranjemap = CreateDynamicObject(19379,1289.302,-1867.100,12.480,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 3979, "civic01_lan", "sl_concretewall1", 0);
	osiguranjemap = CreateDynamicObject(19379,1299.805,-1876.714,12.480,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 3979, "civic01_lan", "sl_concretewall1", 0);
	osiguranjemap = CreateDynamicObject(19379,1299.803,-1867.101,12.480,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 3979, "civic01_lan", "sl_concretewall1", 0);
	osiguranjemap = CreateDynamicObject(19379,1289.310,-1876.714,12.480,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 3979, "civic01_lan", "sl_concretewall1", 0);
	osiguranjemap = CreateDynamicObject(19391,1295.788,-1862.292,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19325,1291.662,-1862.240,13.924,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 18065, "ab_sfammumain", "shelf_glas", 0);
	osiguranjemap = CreateDynamicObject(19325,1300.512,-1862.222,13.924,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 18065, "ab_sfammumain", "shelf_glas", 0);
	osiguranjemap = CreateDynamicObject(19435,1288.236,-1862.300,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19435,1304.263,-1862.271,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19454,1287.534,-1867.037,14.255,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 14674, "civic02cj", "ab_hosWallUpr", 0);
	osiguranjemap = CreateDynamicObject(19391,1295.789,-1862.467,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19435,1288.234,-1862.460,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19435,1304.263,-1862.447,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1290.70605, -1876.87903, 17.54800,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1284.14099, -1878.08997, 14.26800,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1300.25000, -1876.87903, 17.54800,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1299.12012, -1862.46228, 8.10800,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1290.06006, -1862.46228, 11.16400,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1302.54700, -1862.46228, 8.10800,   90.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1289.88403, -1862.45251, 17.53920,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1301.92627, -1862.45251, 17.53920,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1305.21289, -1867.32764, 14.10573,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1305.21289, -1876.94055, 14.10570,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1285.91504, -1869.37524, 11.56190,   90.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454, 1285.91504, -1864.80383, 11.56190,   90.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454,1290.060,-1862.301,11.164,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19454,1299.060,-1862.300,8.108,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19454,1302.547,-1862.300,8.108,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19454,1292.319,-1873.900,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454,1301.919,-1873.900,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(2229,1298.817,-1871.608,12.564,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2229,1298.202,-1872.439,12.564,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2229,1298.202,-1872.699,12.564,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2229,1295.420,-1871.615,12.564,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2229,1294.804,-1872.408,12.564,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2229,1294.804,-1872.699,12.564,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(19454,1286.142,-1871.811,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 14674, "civic02cj", "ab_hosWallUpr", 0);
	osiguranjemap = CreateDynamicObject(19454,1290.885,-1876.552,14.255,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(19454,1303.631,-1867.035,14.255,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 14674, "civic02cj", "ab_hosWallUpr", 0);
	osiguranjemap = CreateDynamicObject(19454,1303.631,-1876.666,14.255,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 14674, "civic02cj", "ab_hosWallUpr", 0);
	osiguranjemap = CreateDynamicObject(19379,1299.815,-1867.031,15.926,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0);
	osiguranjemap = CreateDynamicObject(19379,1289.324,-1867.031,15.926,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0);
	osiguranjemap = CreateDynamicObject(19454,1290.706,-1862.277,17.548,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19454,1300.250,-1862.277,17.548,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19379,1299.815,-1876.654,15.926,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0);
	osiguranjemap = CreateDynamicObject(19379,1289.324,-1876.654,15.926,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0);
	osiguranjemap = CreateDynamicObject(19377,1290.590,-1867.447,19.222,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19377,1300.217,-1867.447,19.222,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19377,1290.590,-1871.688,19.221,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19377,1300.217,-1871.688,19.221,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19371,1296.831,-1871.697,11.929,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFbdbdbd);
	osiguranjemap = CreateDynamicObject(2293,1288.138,-1865.717,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2293,1288.138,-1867.578,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2293,1288.138,-1866.637,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2293,1288.138,-1868.498,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2293,1303.013,-1865.717,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2293,1303.013,-1866.637,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2293,1303.013,-1867.578,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2293,1303.013,-1868.498,12.560,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10948, "skyscrapper_sfs", "ws_asphalt", 0xFF404040);
	SetDynamicObjectMaterial(osiguranjemap, 1, 8843, "vegasarrows", "dirtywhite", 0);
	osiguranjemap = CreateDynamicObject(2315,1289.539,-1867.901,12.424,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5", 0xFF707070);
	osiguranjemap = CreateDynamicObject(2315,1301.619,-1867.850,12.424,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5", 0xFF707070);
	osiguranjemap = CreateDynamicObject(2040,1297.585,-1871.994,13.456,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2040,1296.103,-1871.994,13.456,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2752,1296.081,-1871.990,13.449,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2752,1295.950,-1871.992,13.752,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2752,1297.567,-1871.990,13.449,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2752,1297.428,-1871.992,13.752,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2268,1297.927,-1871.517,13.921,0.000,90.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2268,1296.437,-1871.517,13.921,0.000,90.000,180.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFF000000);
	osiguranjemap = CreateDynamicObject(2268,1295.774,-1872.514,13.921,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFFc8e1f2);
	osiguranjemap = CreateDynamicObject(2268,1297.262,-1872.514,13.921,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFFc8e1f2);
	osiguranjemap = CreateDynamicObject(18873,1296.526,-1872.330,13.536,0.000,0.000,12.779,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	SetDynamicObjectMaterial(osiguranjemap, 2, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(18873,1298.009,-1872.313,13.536,0.000,0.000,12.779,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	SetDynamicObjectMaterial(osiguranjemap, 1, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	SetDynamicObjectMaterial(osiguranjemap, 2, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(1581,1297.598,-1872.283,13.546,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 16644, "a51_detailstuff", "Gen_Keyboard", 0);
	osiguranjemap = CreateDynamicObject(1581,1296.110,-1872.283,13.546,-90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 16644, "a51_detailstuff", "Gen_Keyboard", 0);
	osiguranjemap = CreateDynamicObject(19454,1290.706,-1876.879,17.548,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19454,1300.250,-1876.879,17.548,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1223, "dynsigns", "white64", 0xFFd3d3d3);
	osiguranjemap = CreateDynamicObject(19454,1284.141,-1878.090,14.268,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 1736, "cj_ammo", "CJ_Black_metal", 0);
	osiguranjemap = CreateDynamicObject(1783,1298.018,-1871.858,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1297.378,-1871.858,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1296.737,-1871.858,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1296.093,-1871.858,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1295.452,-1871.858,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1295.452,-1872.289,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1296.093,-1872.289,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1296.737,-1872.289,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1297.378,-1872.289,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	osiguranjemap = CreateDynamicObject(1783,1298.016,-1872.289,13.483,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjemap, 0, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 1, 10226, "sfeship1", "CJ_WOOD5");
	SetDynamicObjectMaterial(osiguranjemap, 2, 10226, "sfeship1", "CJ_WOOD5");
	/////////////////////////////
	//stavis ako je igrac u blizini njih da se pomeraju na ove kordinate 1295.003,-1862.269,10.7067
	osiguranjevrata = CreateDynamicObject(1566,1295.003,-1862.269,13.680,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(osiguranjevrata, 0, 18065, "ab_sfammumain", "shelf_glas", 0);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	osiguranjemap = CreateDynamicObject(18075, 1295.19617, -1868.35303, 15.85100,   0.00000, 0.00000, 90.00000);
	osiguranjemap = CreateDynamicObject(19454,1287.527,-1876.654,14.255,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(19454,1305.023,-1867.084,14.255,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(19454,1305.024,-1876.715,14.255,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(19454,1292.341,-1880.606,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(19454,1301.967,-1880.608,14.255,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(1714,1297.658,-1873.061,12.548,0.000,0.000,184.500,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(1714,1296.122,-1873.076,12.548,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(2852,1289.496,-1867.210,12.918,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(2854,1301.616,-1867.070,12.917,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(2164,1300.409,-1873.800,12.551,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(2164,1293.980,-1873.800,12.551,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(2267,1303.520,-1867.105,14.880,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	osiguranjemap = CreateDynamicObject(2267,1287.646,-1867.047,14.880,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// stand za uzimanje pajsera/zice
	CreateDynamicObject(3860, 1296.98560, -992.85034, 32.36080,   0.00000, 0.00000, 180.00000);
    // elemental motosalon
    zidovi[0] = CreateDynamicObject(19453,2045.9316406,-1863.3115234,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (1)
	SetDynamicObjectMaterial(zidovi[0], 0, 16385, "des_stownmain3", "newall11-1", 0);
	CreateDynamicObject(19377,2066.4052734,-1868.0400391,12.4700003,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (1)
	CreateDynamicObject(970,2069.5498047,-1863.2421875,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (1)
	CreateDynamicObject(19377,2066.4052734,-1877.5996094,12.4700003,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (2)
	CreateDynamicObject(19377,2056.0000000,-1868.0400391,12.4700003,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (3)
	CreateDynamicObject(19377,2056.0000000,-1877.5999756,12.4700003,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (4)
	CreateDynamicObject(970,2065.3730469,-1863.2421875,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (2)
	CreateDynamicObject(970,2061.1943359,-1863.2421875,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (3)
	CreateDynamicObject(970,2057.0175781,-1863.2421875,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (4)
	CreateDynamicObject(970,2052.8408203,-1863.2421875,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (5)
	zidovi[1] = CreateDynamicObject(19453,2036.2998047,-1863.3115234,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (3)
	SetDynamicObjectMaterial(zidovi[1], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[2] = CreateDynamicObject(19453,2026.6650391,-1863.3115234,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (4)
	SetDynamicObjectMaterial(zidovi[2], 0, 16385, "des_stownmain3", "newall11-1", 0);
	pod[0] = CreateDynamicObject(19377,2045.5000000,-1868.0400391,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (5)
	SetDynamicObjectMaterial(pod[0], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	pod[1] = CreateDynamicObject(19377,2035.0000000,-1868.0400391,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (6)
	SetDynamicObjectMaterial(pod[1], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	pod[2] = CreateDynamicObject(19377,2024.5000000,-1868.0400391,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (7)
	SetDynamicObjectMaterial(pod[2], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	pod[3] = CreateDynamicObject(19377,2045.5000000,-1877.5996094,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (8)
	SetDynamicObjectMaterial(pod[3], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	pod[4] = CreateDynamicObject(19377,2035.0000000,-1877.5996094,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (9)
	SetDynamicObjectMaterial(pod[4], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	pod[5] = CreateDynamicObject(19377,2024.5000000,-1877.5996094,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (10)
	SetDynamicObjectMaterial(pod[5], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	zidovi[3] = CreateDynamicObject(19361,2050.6599121,-1864.8280029,11.3000002,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(zidovi[3], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[4] = CreateDynamicObject(19361,2050.6599121,-1868.0000000,11.3000002,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(zidovi[4], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[5] = CreateDynamicObject(19361,2050.6599121,-1870.4000244,11.3000002,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (8)
	SetDynamicObjectMaterial(zidovi[5], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[6] = CreateDynamicObject(19390,2050.6599121,-1872.8000488,14.3000002,0.0000000,0.0000000,0.0000000); //object(road_16_sfw) (1)
	SetDynamicObjectMaterial(zidovi[6], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[7] = CreateDynamicObject(19361,2050.6599121,-1875.1999512,11.3000002,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (7)
	SetDynamicObjectMaterial(zidovi[7], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[8] = CreateDynamicObject(19361,2050.6599121,-1877.5999756,11.3000002,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(zidovi[8], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[9] = CreateDynamicObject(19361,2050.6599121,-1880.8000488,11.3000002,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(zidovi[9], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[10] = CreateDynamicObject(19453,2045.9316406,-1882.3170166,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (1)
	SetDynamicObjectMaterial(zidovi[10], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[11] = CreateDynamicObject(19453,2036.2998047,-1882.3170166,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (3)
	SetDynamicObjectMaterial(zidovi[11], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[12] = CreateDynamicObject(19453,2026.6650391,-1882.3170166,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (4)
	SetDynamicObjectMaterial(zidovi[12], 0, 16385, "des_stownmain3", "newall11-1", 0);
	salter[0] = CreateDynamicObject(2435,2042.8000488,-1881.7790527,12.5799999,0.0000000,0.0000000,270.0000000); //object(cj_ff_conter_2) (1)
	SetDynamicObjectMaterial(salter[0], 2, -1, "none", "none", 0xFF0a4fae);
	SetDynamicObjectMaterial(salter[0], 1, -1, "none", "none", 0xFF525252);
	SetDynamicObjectMaterial(salter[0], 0, -1, "none", "none", 0xFFb31313);
	salter[1] = CreateDynamicObject(2434,2042.9653320,-1879.7141113,12.5799999,0.0000000,0.0000000,180.0000000); //object(cj_ff_conter_2b) (1)
	SetDynamicObjectMaterial(salter[1], 2, -1, "none", "none", 0xFF0a4fae);
	SetDynamicObjectMaterial(salter[1], 1, -1, "none", "none", 0xFF525252);
	SetDynamicObjectMaterial(salter[1], 0, -1, "none", "none", 0xFFb31313);
	salter[2] = CreateDynamicObject(2435,2042.7998047,-1880.8477783,12.5799999,0.0000000,0.0000000,270.0000000); //object(cj_ff_conter_2) (2)
	SetDynamicObjectMaterial(salter[2], 2, -1, "none", "none", 0xFF0a4fae);
	SetDynamicObjectMaterial(salter[2], 1, -1, "none", "none", 0xFF525252);
	SetDynamicObjectMaterial(salter[2], 0, -1, "none", "none", 0xFFb31313);
	salter[3] = CreateDynamicObject(2435,2043.8969727,-1879.7154541,12.5799999,0.0000000,0.0000000,180.0000000); //object(cj_ff_conter_2) (3)
	SetDynamicObjectMaterial(salter[3], 2, -1, "none", "none", 0xFF0a4fae);
	SetDynamicObjectMaterial(salter[3], 1, -1, "none", "none", 0xFF525252);
	SetDynamicObjectMaterial(salter[3], 0, -1, "none", "none", 0xFFb31313);
	salter[4] = CreateDynamicObject(2435,2044.8280029,-1879.7154541,12.5799999,0.0000000,0.0000000,179.9945068); //object(cj_ff_conter_2) (4)
	SetDynamicObjectMaterial(salter[4], 2, -1, "none", "none", 0xFF0a4fae);
	SetDynamicObjectMaterial(salter[4], 1, -1, "none", "none", 0xFF525252);
	SetDynamicObjectMaterial(salter[4], 0, -1, "none", "none", 0xFFb31313);
	salter[5] = CreateDynamicObject(2435,2045.7592773,-1879.7154541,12.5799999,0.0000000,0.0000000,179.9945068); //object(cj_ff_conter_2) (5)
	SetDynamicObjectMaterial(salter[5], 2, -1, "none", "none", 0xFF0a4fae);
	SetDynamicObjectMaterial(salter[5], 1, -1, "none", "none", 0xFF525252);
	SetDynamicObjectMaterial(salter[5], 0, -1, "none", "none", 0xFFb31313);
	salter[6] = CreateDynamicObject(2435,2046.6899414,-1879.7154541,12.5799999,0.0000000,0.0000000,179.9945068); //object(cj_ff_conter_2) (6)
	SetDynamicObjectMaterial(salter[6], 2, -1, "none", "none", 0xFF0a4fae);
	SetDynamicObjectMaterial(salter[6], 1, -1, "none", "none", 0xFF525252);
	SetDynamicObjectMaterial(salter[6], 0, -1, "none", "none", 0xFFb31313);
	mstalak[0] = CreateDynamicObject(328,2044.4200439,-1879.5999756,13.6000004,91.0000000,0.0000000,94.0000000); //object(1)
	SetDynamicObjectMaterial(mstalak[0], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mstalak[1] = CreateDynamicObject(328,2044.4200439,-1879.6700439,13.6000004,91.0000000,0.0000000,94.0000000); //object(2)
	SetDynamicObjectMaterial(mstalak[1], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mdrzac[0] = CreateDynamicObject(2749,2044.4200439,-1879.5949707,13.6499996,0.0000000,0.0000000,0.0000000); //object(cj_hairspray) (1)
	SetDynamicObjectMaterial(mdrzac[0], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	monitor[0] = CreateDynamicObject(2268,2014.5999756,-1879.5999756,13.9499998,350.0000000,90.0000000,250.0000000); //object(frame_wood_2) (1)
	SetDynamicObjectMaterial(monitor[0], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	SetDynamicObjectMaterial(monitor[0], 1, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	monitor[1] = CreateDynamicObject(2268,2044.7645264,-1879.1400146,13.9309998,10.0000000,90.0000000,180.0000000); //object(frame_wood_2) (2)
	SetDynamicObjectMaterial(monitor[1], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	SetDynamicObjectMaterial(monitor[1], 1, 3924, "rc_warhoose", "black", 0xFF121212);
	CreateDynamicObject(1444,2047.5999756,-1879.8000488,13.3999996,0.0000000,0.0000000,0.0000000); //object(dyn_street_sign_2) (1)
	CreateDynamicObject(1714,2044.4300537,-1881.1999512,12.6000004,0.0000000,0.0000000,180.0000000); //object(kb_swivelchair1) (1)
	televizor[0] = CreateDynamicObject(2267,2048.0000000,-1863.6500244,13.5500002,0.0000000,0.0000000,0.0000000); //object(frame_wood_3) (1)
	SetDynamicObjectMaterial(televizor[0], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	SetDynamicObjectMaterial(televizor[0], 1, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	CreateDynamicObject(1703,2050.0000000,-1865.1999512,12.5900002,0.0000000,0.0000000,270.0000000); //object(kb_couch02) (1)
	CreateDynamicObject(2319,2047.2299805,-1863.9000244,12.4923401,0.0000000,0.0000000,0.0000000); //object(cj_tv_table5) (1)
	mstalak[2] = CreateDynamicObject(328,2048.0000000,-1863.6700439,12.9600000,90.9997559,0.0000000,93.9990234); //object(3)
	SetDynamicObjectMaterial(mstalak[2], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mstalak[3] = CreateDynamicObject(328,2048.0000000,-1863.5996094,12.9600000,90.9997559,0.0000000,93.9990234); //object(4)
	SetDynamicObjectMaterial(mstalak[3], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mdrzac[1] = CreateDynamicObject(2752,2048.0000000,-1863.5970459,13.0100002,0.0000000,0.0000000,0.0000000); //object(cj_hairspray2) (1)
	SetDynamicObjectMaterial(mdrzac[1], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	CreateDynamicObject(1703,2046.0000000,-1867.2180176,12.6000004,0.0000000,0.0000000,90.0000000); //object(kb_couch02) (2)
	CreateDynamicObject(1827,2048.0000000,-1866.1999512,12.6000004,0.0000000,0.0000000,0.0000000); //object(man_sdr_tables) (1)
	CreateDynamicObject(2773,2039.3000488,-1867.9000244,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (1)
	CreateDynamicObject(2773,2039.3000488,-1865.9780273,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (2)
	CreateDynamicObject(2773,2032.1999512,-1868.0000000,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (3)
	CreateDynamicObject(2773,2036.4379883,-1865.0200195,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (4)
	CreateDynamicObject(2773,2035.4534912,-1865.9775391,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (5)
	CreateDynamicObject(2773,2035.4534912,-1867.8994141,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (6)
	CreateDynamicObject(2773,2038.3630371,-1875.3070068,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (7)
	CreateDynamicObject(2773,2036.4375000,-1868.8649902,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (8)
	CreateDynamicObject(2773,2038.3593750,-1865.0195312,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (10)
	CreateDynamicObject(2773,2030.2800293,-1868.0000000,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (11)
	CreateDynamicObject(2773,2033.1379395,-1868.9560547,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (12)
	CreateDynamicObject(2773,2033.1376953,-1870.8780518,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (13)
	CreateDynamicObject(2773,2029.2960205,-1868.9560547,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (14)
	CreateDynamicObject(2773,2029.2960205,-1870.8779297,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (15)
	CreateDynamicObject(2773,2030.2792969,-1878.9000244,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (16)
	CreateDynamicObject(2773,2032.1992188,-1871.8420410,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (17)
	CreateDynamicObject(2773,2038.3642578,-1868.8642578,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (18)
	CreateDynamicObject(2773,2036.4375000,-1871.4649658,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (19)
	CreateDynamicObject(2773,2039.2998047,-1872.4229736,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (20)
	CreateDynamicObject(2773,2039.2998047,-1874.3428955,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (21)
	CreateDynamicObject(2773,2035.4534912,-1872.4228516,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (22)
	CreateDynamicObject(2773,2035.4534912,-1874.3427734,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (23)
	CreateDynamicObject(2773,2038.3642578,-1871.4648438,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (24)
	CreateDynamicObject(2773,2036.4375000,-1875.3070068,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (26)
	tastatura[0] = CreateDynamicObject(1210,2044.4300537,-1880.0000000,13.6899996,90.0000000,90.0000000,90.0000000); //object(cj_food_post4) (1)
	SetDynamicObjectMaterial(tastatura[0], 0, 10249, "ottos2_sfw", "of_key_256", 0);
	mis[0] = CreateDynamicObject(18866,2044.8000488,-1880.0000000,13.6199999,0.0000000,0.0000000,0.0000000); //object(bdupsnew_int) (1)
	SetDynamicObjectMaterial(mis[0], 1, 3924, "rc_warhoose", "black", 0xFF121212);
	CreateDynamicObject(2773,2038.3623047,-1877.9066162,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (27)
	CreateDynamicObject(2773,2036.4375000,-1877.9066162,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (28)
	CreateDynamicObject(2773,2039.2998047,-1878.8630371,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (29)
	CreateDynamicObject(2773,2039.3000488,-1880.7840576,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (30)
	CreateDynamicObject(2773,2035.4534912,-1878.8623047,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (31)
	CreateDynamicObject(2773,2035.4534912,-1880.7832031,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (32)
	CreateDynamicObject(2773,2038.3623047,-1881.7469482,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (33)
	CreateDynamicObject(2773,2036.4375000,-1881.7469482,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (34)
	CreateDynamicObject(2773,2032.1992188,-1878.9000244,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (35)
	CreateDynamicObject(2773,2030.2792969,-1871.8417969,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (36)
	CreateDynamicObject(2773,2033.1650391,-1877.9160156,13.1000004,0.0000000,0.0000000,180.0000000); //object(cj_airprt_bar) (37)
	CreateDynamicObject(2773,2033.1650391,-1875.9949951,13.1000004,0.0000000,0.0000000,179.9945068); //object(cj_airprt_bar) (38)
	CreateDynamicObject(2773,2032.1800537,-1875.0310059,13.1000004,0.0000000,0.0000000,269.9945068); //object(cj_airprt_bar) (40)
	CreateDynamicObject(2773,2030.2792969,-1875.0578613,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (41)
	CreateDynamicObject(2773,2029.3229980,-1875.9941406,13.1000004,0.0000000,0.0000000,179.9945068); //object(cj_airprt_bar) (42)
	CreateDynamicObject(2773,2029.3229980,-1877.9160156,13.1000004,0.0000000,0.0000000,179.9945068); //object(cj_airprt_bar) (43)
	CreateDynamicObject(2773,2027.0000000,-1867.8994141,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (47)
	CreateDynamicObject(2773,2027.0000000,-1865.9775391,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (48)
	CreateDynamicObject(2773,2026.0629883,-1865.0209961,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (49)
	CreateDynamicObject(2773,2024.1419678,-1865.0209961,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (50)
	CreateDynamicObject(2773,2026.0625000,-1868.8642578,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (51)
	CreateDynamicObject(2773,2024.1416016,-1868.8642578,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (52)
	CreateDynamicObject(2773,2023.15719377,-1867.8994141,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (53)
	CreateDynamicObject(2773,2023.15719377,-1865.9775391,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (54)
	CreateDynamicObject(2773,2027.0000000,-1874.3427734,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (55)
	CreateDynamicObject(2773,2027.0000000,-1872.4228516,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (56)
	CreateDynamicObject(2773,2026.0625000,-1871.4649658,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (57)
	CreateDynamicObject(2773,2024.1416016,-1871.4649658,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (58)
	CreateDynamicObject(2773,2023.15719377,-1872.4228516,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (59)
	CreateDynamicObject(2773,2023.15719377,-1874.3427734,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (60)
	CreateDynamicObject(2773,2026.0625000,-1875.3070068,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (61)
	CreateDynamicObject(2773,2024.1416016,-1875.3070068,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (62)
	CreateDynamicObject(2773,2027.0000000,-1880.7832031,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (63)
	CreateDynamicObject(2773,2027.0000000,-1878.8623047,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (64)
	CreateDynamicObject(2773,2026.0625000,-1877.9066162,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (65)
	CreateDynamicObject(2773,2024.1416016,-1877.9066162,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (66)
	CreateDynamicObject(2773,2023.15719377,-1878.8623047,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (67)
	CreateDynamicObject(2773,2023.15719377,-1880.7832031,13.1000004,0.0000000,0.0000000,0.0000000); //object(cj_airprt_bar) (68)
	CreateDynamicObject(2773,2026.0625000,-1881.7469482,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (69)
	CreateDynamicObject(2773,2024.1416016,-1881.7469482,13.1000004,0.0000000,0.0000000,90.0000000); //object(cj_airprt_bar) (70)
	pod[6] = CreateDynamicObject(19377,2017.5000000,-1877.5996094,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (7)
	SetDynamicObjectMaterial(pod[6], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	pod[7] = CreateDynamicObject(19377,2017.5000000,-1868.0400391,12.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (7)
	SetDynamicObjectMaterial(pod[7], 0, 16150, "ufo_bar", "dinerfloor01_128", 0);
	zidovi[13] = CreateDynamicObject(19453,2017.0999756,-1882.3170166,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (4)
	SetDynamicObjectMaterial(zidovi[13], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[14] = CreateDynamicObject(19453,2017.0996094,-1863.3115234,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (4)
	SetDynamicObjectMaterial(zidovi[14], 0, 16385, "des_stownmain3", "newall11-1", 0);
	CreateDynamicObject(1649,2019.5000000,-1864.8994141,13.8999996,0.0000000,90.0000000,90.0000000); //object(wglasssmash) (1)
	CreateDynamicObject(1649,2019.5000000,-1868.1992188,13.8999996,0.0000000,90.0000000,90.0000000); //object(wglasssmash) (2)
	CreateDynamicObject(1649,2019.5000000,-1880.6992188,13.8999996,0.0000000,90.0000000,90.0000000); //object(wglasssmash) (3)
	CreateDynamicObject(1649,2019.5000000,-1877.3994141,13.8999996,0.0000000,90.0000000,90.0000000); //object(wglasssmash) (4)
	zidovi[15] = CreateDynamicObject(19390,2019.4300537,-1874.5000000,14.3000002,0.0000000,0.0000000,0.0000000); //object(road_16_sfw) (2)
	SetDynamicObjectMaterial(zidovi[15], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[16] = CreateDynamicObject(19390,2019.4300537,-1871.3000488,14.3000002,0.0000000,0.0000000,0.0000000); //object(road_16_sfw) (3)
	SetDynamicObjectMaterial(zidovi[16], 0, 16385, "des_stownmain3", "newall11-1", 0);
	CreateDynamicObject(1649,2019.3447266,-1868.1992188,13.8999996,0.0000000,90.0000000,270.0000000); //object(wglasssmash) (5)
	CreateDynamicObject(1649,2019.3447266,-1864.8994141,13.8999996,0.0000000,90.0000000,270.0000000); //object(wglasssmash) (6)
	CreateDynamicObject(1649,2019.3447266,-1877.3994141,13.8999996,0.0000000,90.0000000,270.0000000); //object(wglasssmash) (7)
	CreateDynamicObject(1649,2019.3447266,-1880.6992188,13.8999996,0.0000000,90.0000000,270.0000000); //object(wglasssmash) (8)
	zidovi[17] = CreateDynamicObject(19361,2017.8000488,-1872.9000244,14.3000002,0.0000000,0.0000000,90.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(zidovi[17], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[18] = CreateDynamicObject(19361,2014.5999756,-1872.9000244,14.3000002,0.0000000,0.0000000,90.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(zidovi[18], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[19] = CreateDynamicObject(19434,2013.0999756,-1872.9000244,14.3000002,0.0000000,0.0000000,90.0000000); //object(cs_landbit_50b_a) (3)
	SetDynamicObjectMaterial(zidovi[19], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[20] = CreateDynamicObject(19453,2012.3719482,-1868.0396729,14.3000002,0.0000000,0.0000000,180.0000000); //object(cs_detrok07) (4)
	SetDynamicObjectMaterial(zidovi[20], 0, 16385, "des_stownmain3", "newall11-1", 0);
	zidovi[21] = CreateDynamicObject(19453,2012.3719482,-1877.5899658,14.3000002,0.0000000,0.0000000,179.9945068); //object(cs_detrok07) (4)
	SetDynamicObjectMaterial(zidovi[21], 0, 16385, "des_stownmain3", "newall11-1", 0);
	CreateDynamicObject(1649,2050.7099609,-1875.8299561,14.5000000,0.0000000,0.0000000,90.0000000); //object(wglasssmash) (9)
	CreateDynamicObject(1649,2050.7099609,-1880.1800537,14.5000000,0.0000000,0.0000000,90.0000000); //object(wglasssmash) (10)
	CreateDynamicObject(19377,2045.5000000,-1877.5996094,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (8)
	CreateDynamicObject(19377,2045.5000000,-1868.0400391,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (5)
	CreateDynamicObject(19377,2035.0000000,-1868.0400391,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (6)
	CreateDynamicObject(19377,2035.0000000,-1877.5996094,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (9)
	CreateDynamicObject(19377,2024.5000000,-1868.0400391,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (7)
	CreateDynamicObject(19377,2024.5000000,-1877.5996094,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (10)
	CreateDynamicObject(19377,2017.5000000,-1877.5996094,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (7)
	CreateDynamicObject(19377,2017.5000000,-1868.0400391,16.1000004,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw) (7)
	CreateDynamicObject(1649,2050.5900879,-1875.8291016,14.5000000,0.0000000,0.0000000,270.0000000); //object(wglasssmash) (11)
	CreateDynamicObject(1649,2050.5900879,-1880.1796875,14.5000000,0.0000000,0.0000000,270.0000000); //object(wglasssmash) (12)
	CreateDynamicObject(1649,2050.7099609,-1869.8000488,14.5000000,0.0000000,0.0000000,90.0000000); //object(wglasssmash) (13)
	CreateDynamicObject(1649,2050.7099609,-1865.4499512,14.5000000,0.0000000,0.0000000,90.0000000); //object(wglasssmash) (14)
	CreateDynamicObject(1649,2050.5900879,-1869.7998047,14.5000000,0.0000000,0.0000000,270.0000000); //object(wglasssmash) (15)
	CreateDynamicObject(1649,2050.5900879,-1865.4492188,14.5000000,0.0000000,0.0000000,270.0000000); //object(wglasssmash) (16)
	vrata[0] = CreateDynamicObject(1491,2050.6699219,-1873.5429688,12.5500002,0.0000000,0.0000000,90.0000000); //object(gen_doorint01) (1)
	SetDynamicObjectMaterial(vrata[0], 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0);
	CreateDynamicObject(1491,2019.4200439,-1873.7180176,12.5500002,0.0000000,0.0000000,270.0000000); //object(gen_doorint01) (2)
	CreateDynamicObject(1491,2019.4499512,-1872.0439453,12.5500002,0.0000000,0.0000000,90.0000000); //object(gen_doorint01) (3)
	office[0] = CreateDynamicObject(941,2014.9000244,-1879.8000488,13.0000000,0.0000000,0.0000000,90.0000000); //object(cj_df_worktop_3) (1)
	SetDynamicObjectMaterial(office[0], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	monitor[2] = CreateDynamicObject(2268,2044.0996094,-1880.0996094,14.1000004,349.9969482,90.0000000,0.0000000); //object(frame_wood_2) (3)
	SetDynamicObjectMaterial(monitor[2], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	SetDynamicObjectMaterial(monitor[2], 1, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(monitor[2], 2, "Premium Deluxe\n   Motorcycles", OBJECT_MATERIAL_SIZE_32x32, "Arial", 12, 1, 0xFF121212, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	monitor[3] = CreateDynamicObject(2268,2015.3000488,-1880.5620117,13.7760000,10.0000000,90.0000000,70.0000000); //object(frame_wood_2) (4)
	SetDynamicObjectMaterial(monitor[3], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	SetDynamicObjectMaterial(monitor[3], 1, 3924, "rc_warhoose", "black", 0xFF121212);
	mdrzac[2] = CreateDynamicObject(2749,2014.9699707,-1880.0999756,13.5000000,0.0000000,0.0000000,0.0000000); //object(cj_hairspray) (2)
	SetDynamicObjectMaterial(mdrzac[2], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mstalak[4] = CreateDynamicObject(328,2015.0000000,-1880.0799561,13.4499998,91.0000000,0.0000000,344.0000000); //object(5)
	SetDynamicObjectMaterial(mstalak[4], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mstalak[5] = CreateDynamicObject(328,2014.9300537,-1880.0539551,13.4499998,90.9997559,0.0000000,343.9984131); //object(6)
	SetDynamicObjectMaterial(mstalak[5], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	tastatura[1] = CreateDynamicObject(1210,2014.5996094,-1879.5000000,13.3999996,270.0000000,90.0000000,350.0000000); //object(cj_food_post4) (2)
	SetDynamicObjectMaterial(tastatura[1], 0, 10249, "ottos2_sfw", "of_key_256", 0);
	mis[1] = CreateDynamicObject(18866,2014.5000000,-1880.0999756,13.4600000,0.0000000,0.0000000,270.0000000); //object(bdupsnew_int) (2)
	SetDynamicObjectMaterial(mis[1], 1, 3924, "rc_warhoose", "black", 0xFF121212);
	CreateDynamicObject(1714,2013.4000244,-1879.6999512,12.6000004,0.0000000,0.0000000,89.9945068); //object(kb_swivelchair1) (2)
	CreateDynamicObject(2007,2012.9599609,-1881.6999512,12.6000004,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu01) (1)
	CreateDynamicObject(1704,2017.1999512,-1880.3000488,12.6000004,0.0000000,0.0000000,250.0000000); //object(kb_chair03) (1)
	CreateDynamicObject(1704,2016.9000244,-1878.0000000,12.6000004,0.0000000,0.0000000,289.9993896); //object(kb_chair03) (2)
	CreateDynamicObject(948,2012.8000488,-1873.3000488,12.6000004,0.0000000,0.0000000,0.0000000); //object(plant_pot_10) (1)
	office[1] = CreateDynamicObject(941,2014.9000244,-1865.9000244,13.0000000,0.0000000,0.0000000,90.0000000); //object(cj_df_worktop_3) (2)
	SetDynamicObjectMaterial(office[1], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	monitor[4] = CreateDynamicObject(2268,2014.5999756,-1864.9000244,13.9499998,349.9969482,90.0000000,270.0000000); //object(frame_wood_2) (5)
	SetDynamicObjectMaterial(monitor[4], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	SetDynamicObjectMaterial(monitor[4], 1, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterialText(monitor[4], 2, "Premium Deluxe\n   Motorcycles", OBJECT_MATERIAL_SIZE_32x32, "Arial", 12, 1, 0xFF121212, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	monitor[5] = CreateDynamicObject(2268,2015.5600586,-1865.5660400,13.7810001,9.9975586,90.0000000,90.0000000); //object(frame_wood_2) (6)
	SetDynamicObjectMaterial(monitor[5], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	SetDynamicObjectMaterial(monitor[5], 1, 3924, "rc_warhoose", "black", 0xFF121212);
	mdrzac[3] = CreateDynamicObject(2749,2015.1099854,-1865.2500000,13.5000000,0.0000000,0.0000000,0.0000000); //object(cj_hairspray) (3)
	SetDynamicObjectMaterial(mdrzac[3], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mstalak[6] = CreateDynamicObject(328,2015.0999756,-1865.2230225,13.4499998,91.0000000,0.0000000,4.0000000); //object(7)
	SetDynamicObjectMaterial(mstalak[6], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	mstalak[7] = CreateDynamicObject(328,2015.0300293,-1865.2226562,13.4499998,90.9997559,0.0000000,3.9990234); //object(8)
	SetDynamicObjectMaterial(mstalak[7], 0, 3924, "rc_warhoose", "black", 0xFF121212);
	tastatura[2] = CreateDynamicObject(1210,2014.6992188,-1865.1992188,13.3999996,270.0000000,90.0000000,0.0000000); //object(cj_food_post4) (3)
	SetDynamicObjectMaterial(tastatura[2], 0, 10249, "ottos2_sfw", "of_key_256", 0);
	mis[2] = CreateDynamicObject(18866,2014.5999756,-1865.6999512,13.4600000,0.0000000,0.0000000,270.0000000); //object(bdupsnew_int) (3)
	SetDynamicObjectMaterial(mis[2], 1, 3924, "rc_warhoose", "black", 0xFF121212);
	CreateDynamicObject(1704,2016.9000244,-1866.3000488,12.6000004,0.0000000,0.0000000,249.9993896); //object(kb_chair03) (3)
	CreateDynamicObject(1704,2016.5999756,-1864.0999756,12.6000004,0.0000000,0.0000000,289.9993896); //object(kb_chair03) (4)
	CreateDynamicObject(1714,2013.4000244,-1865.4000244,12.6000004,0.0000000,0.0000000,89.9945068); //object(kb_swivelchair1) (3)
	CreateDynamicObject(950,2012.9000244,-1872.5999756,13.1000004,0.0000000,0.0000000,0.0000000); //object(plant_pot_12) (1)
	CreateDynamicObject(970,2071.6398926,-1880.3100586,13.1000004,0.0000000,0.0000000,90.0000000); //object(fencesmallb) (1)
	CreateDynamicObject(970,2069.5498047,-1882.4000244,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (1)
	CreateDynamicObject(970,2065.3730469,-1882.4000244,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (2)
	CreateDynamicObject(970,2061.1943359,-1882.4000244,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (3)
	CreateDynamicObject(970,2057.0175781,-1882.4000244,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (4)
	CreateDynamicObject(970,2052.8408203,-1882.4000244,13.1000004,0.0000000,0.0000000,0.0000000); //object(fencesmallb) (5)
	CreateDynamicObject(970,2071.6398926,-1878.2199707,13.1000004,0.0000000,0.0000000,90.0000000); //object(fencesmallb) (1)
	CreateDynamicObject(970,2071.6398926,-1865.3299561,13.1000004,0.0000000,0.0000000,90.0000000); //object(fencesmallb) (1)
	CreateDynamicObject(970,2071.6398926,-1867.4200439,13.1000004,0.0000000,0.0000000,90.0000000); //object(fencesmallb) (1)
	parking[0] = CreateDynamicObject(19361,2067.4599609,-1880.8000488,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
 	SetDynamicObjectMaterial(parking[0], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[1] = CreateDynamicObject(19361,2067.4599609,-1877.6999512,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
 	SetDynamicObjectMaterial(parking[1], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
 	parking[2] = CreateDynamicObject(19361,2063.2849121,-1880.8000488,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[2], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[3] = CreateDynamicObject(19361,2063.2849121,-1877.6992188,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[3], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[4] = CreateDynamicObject(19361,2059.1059570,-1880.8000488,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[4], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[5] = CreateDynamicObject(19361,2059.1059570,-1877.6992188,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[5], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[6] = CreateDynamicObject(19361,2054.9279785,-1880.8000488,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[6], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[7] = CreateDynamicObject(19361,2054.9279785,-1877.6992188,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[7], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[8] = CreateDynamicObject(19361,2071.5500488,-1880.8000488,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[8], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[9] = CreateDynamicObject(19361,2071.5500488,-1877.6992188,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[9], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[10] = CreateDynamicObject(19453,2066.8000488,-1882.3170166,10.8199997,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (1)
	SetDynamicObjectMaterial(parking[10], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[11] = CreateDynamicObject(19453,2057.1999512,-1882.3170166,10.8199997,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (1)
	SetDynamicObjectMaterial(parking[11], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[12] = CreateDynamicObject(19453,2047.5999756,-1882.3170166,10.8199997,0.0000000,0.0000000,90.0000000); //object(cs_detrok07) (1)
	SetDynamicObjectMaterial(parking[12], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[13] = CreateDynamicObject(19361,2067.4699707,-1864.8800049,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[13], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[14] = CreateDynamicObject(19361,2071.5498047,-1864.8800049,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[14], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[15] = CreateDynamicObject(19361,2063.2841797,-1864.8800049,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[15], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[16] = CreateDynamicObject(19361,2059.1054688,-1864.8800049,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[16], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[17] = CreateDynamicObject(19361,2054.9277344,-1864.8800049,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[17], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[18] = CreateDynamicObject(19361,2071.5498047,-1868.0899658,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[18], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[19] = CreateDynamicObject(19361,2067.4599609,-1868.0899658,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[19], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[20] = CreateDynamicObject(19361,2063.2841797,-1868.0899658,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[20], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[21] = CreateDynamicObject(19361,2059.1054688,-1868.0899658,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[21], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	parking[22] = CreateDynamicObject(19361,2054.9277344,-1868.0899658,10.8199997,0.0000000,0.0000000,0.0000000); //object(lod_new1sfw) (1)
	SetDynamicObjectMaterial(parking[22], 0, 3924, "rc_warhoose", "white", 0xFFFFFFFF);
	reklama[0] = CreateDynamicObject(19435,2045.4000244,-1882.3150166,13.5,0.0000000,0.0000000,270.0000000); //object(cs_landbit_58_a) (34)
	SetDynamicObjectMaterial(reklama[0], 0, 16385, "des_stownmain3", "newall11-1", 0);
	SetDynamicObjectMaterialText(reklama[0], 0, "Premium Deluxe\n      Motorcycles", OBJECT_MATERIAL_SIZE_512x512, "Arial", 38, 1, 0xFFFFFFFF, 0, OBJECT_MATERIAL_TEXT_ALIGN_LEFT);
	// 1
	CreateDynamicObject(19379, 329.25162, 1034.42834, 12.06570,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 329.27280, 1044.02258, 12.06570,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, 319.92526, 1037.52051, 13.89928,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1557, 319.96921, 1036.01514, 12.14890,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1557, 319.96509, 1039.01514, 12.14890,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19362, 321.51675, 1032.79663, 13.91775,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 322.42654, 1032.78174, 13.93189,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 324.08780, 1031.22449, 13.85782,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 322.80350, 1029.71375, 13.85763,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 330.87051, 1029.71179, 13.90047,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 334.52451, 1034.44751, 13.91282,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 334.52399, 1040.47241, 13.91286,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 329.82980, 1045.20203, 13.92550,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 325.29575, 1045.21350, 13.92419,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 321.42319, 1042.39429, 13.88190,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 322.47586, 1042.38245, 13.85967,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 324.03168, 1043.54602, 13.81464,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2558, 325.85413, 1044.70276, 13.44174,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2558, 331.56570, 1044.70288, 13.44174,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19362, 329.20380, 1043.53699, 13.93190,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19362, 329.19531, 1040.75903, 13.93190,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19362, 324.02609, 1040.39929, 13.74878,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19362, 324.03000, 1034.10193, 13.87495,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19391, 324.03531, 1037.25232, 13.90852,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19391, 326.49197, 1039.25000, 13.89535,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 328.37857, 1039.27014, 13.88504,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 324.79663, 1039.22314, 13.88504,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19391, 332.07584, 1039.27771, 13.89535,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 330.08914, 1039.26526, 13.88504,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 334.39224, 1039.29749, 13.88504,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19431, 326.33041, 1046.84998, 14.19109,   88.00000, 1.00000, 0.00000);
	CreateDynamicObject(19431, 332.01727, 1046.84705, 14.19109,   88.00000, 1.00000, 0.00000);
	CreateDynamicObject(19380, 329.20850, 1040.53357, 15.70478,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19380, 329.42841, 1030.91968, 15.65840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19380, 318.93427, 1037.57471, 15.70478,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 318.76520, 1037.53943, 12.06570,   0.00000, 90.00000, 0.00000);

	new furnitureshopmap;
	/////////////FURNITURE SHOP
	furnitureshopmap = CreateDynamicObject(19377,1153.136,1280.981,-77.619,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	furnitureshopmap = CreateDynamicObject(19377,1153.595,1285.792,-77.599,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	furnitureshopmap = CreateDynamicObject(19377,1158.316,1281.044,-77.599,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	furnitureshopmap = CreateDynamicObject(19377,1154.957,1272.891,-77.599,0.000,0.000,-45.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	furnitureshopmap = CreateDynamicObject(19377,1148.835,1281.053,-77.599,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	furnitureshopmap = CreateDynamicObject(19377,1152.175,1272.931,-77.599,0.000,0.000,45.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	furnitureshopmap = CreateDynamicObject(19454,1153.542,1276.320,-78.573,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	furnitureshopmap = CreateDynamicObject(19377,1153.817,1271.566,-76.903,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 10765, "airportgnd_sfse", "ws_runwaytarmac", 0);
	furnitureshopmap = CreateDynamicObject(19377,1157.669,1283.940,-77.599,0.000,0.000,60.419,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	furnitureshopmap = CreateDynamicObject(19377,1153.136,1280.981,-73.685,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 14668, "711c", "gun_ceiling3", 0);
	furnitureshopmap = CreateDynamicObject(19377,1153.138,1271.343,-73.685,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(furnitureshopmap, 0, 14668, "711c", "gun_ceiling3", 0);
	//
	furnitureshopmap = CreateDynamicObject(19377,1153.138,1271.343,-77.619,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(1569,1148.928,1279.976,-77.553,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(1726,1154.473,1275.139,-76.875,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(1726,1150.450,1285.102,-77.558,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(1827,1151.406,1283.317,-77.572,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(2165,1156.580,1282.197,-77.532,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(1714,1157.765,1282.743,-77.550,0.000,0.000,-73.860,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(1721,1155.219,1283.364,-77.557,0.000,0.000,-133.740,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(2257,1158.209,1279.719,-75.352,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	furnitureshopmap = CreateDynamicObject(18075,1155.573,1280.119,-73.781,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	//
	CreateDynamicObject(19379, 518.14502, 1868.52588, -10.16004,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 518.17383, 1858.93457, -10.16004,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 507.73288, 1858.92175, -10.16004,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 507.71320, 1868.53662, -10.16004,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, 507.59970, 1856.05945, -8.38529,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 502.56799, 1868.50427, -8.42834,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 507.59961, 1864.03589, -4.97297,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 502.55850, 1858.88745, -8.41869,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 507.31650, 1854.14575, -8.39380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 507.32574, 1873.28870, -8.42859,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 516.74579, 1873.28271, -8.43633,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 526.02588, 1873.27710, -8.43773,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 516.80103, 1854.14014, -8.42797,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 526.25421, 1854.13367, -8.42807,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 507.60022, 1871.82776, -8.42436,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 523.35101, 1868.51563, -8.42174,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 523.35773, 1858.91345, -8.40993,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1557, 502.61676, 1862.34692, -10.07580,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1557, 502.61890, 1865.37000, -10.07580,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19391, 505.12704, 1858.11951, -8.38102,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 506.72430, 1858.09314, -8.38496,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 502.79401, 1858.11218, -8.40962,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 504.30481, 1858.11084, -10.13800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19391, 505.22125, 1868.82935, -8.40845,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 502.90366, 1868.84314, -8.40555,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 504.40540, 1868.80261, -10.13800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19435, 506.84366, 1868.84839, -8.40555,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 509.13879, 1860.79810, -8.40380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 516.49518, 1860.84534, -8.40380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 523.25037, 1860.93176, -8.40380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19391, 511.64401, 1867.01917, -8.40850,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 509.12866, 1867.03430, -8.40380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 513.95740, 1867.00854, -8.40380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19391, 516.34277, 1867.00391, -8.40850,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19362, 518.70007, 1867.01160, -8.40380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19391, 521.62512, 1867.00269, -8.40850,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 510.83514, 1866.93140, -10.13800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1502, 515.56714, 1866.91150, -10.13800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1502, 520.84442, 1866.90234, -10.13800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 518.18640, 1858.84143, -6.71480,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 518.15942, 1868.46533, -6.71480,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 507.73520, 1868.47559, -6.71480,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 507.72769, 1858.83911, -6.71480,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, 518.95129, 1871.80920, -8.42174,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 513.65057, 1871.75854, -8.42170,   0.00000, 0.00000, 0.00000);
	// bolnica
	CreateDynamicObject(1256, 1186.45996, -1302.37292, 13.20524,   0.00000, 0.00000, -180.66006);
	CreateDynamicObject(4141, 1162.94336, -1322.75208, -8.05430,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(4141, 1162.93726, -1345.03564, -8.05162,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(4141, 1162.93213, -1316.72180, -8.07429,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(4141, 1162.88965, -1316.23083, -8.09421,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(4141, 1172.33167, -1332.58459, -6.90330,   1800.00000, 0.00000, 180.41998);
	CreateDynamicObject(4141, 1172.38281, -1356.56848, -6.90330,   1800.00000, 0.00000, 180.41998);
	CreateDynamicObject(1256, 1186.62805, -1345.22498, 13.20524,   0.00000, 0.00000, -180.66006);
	CreateDynamicObject(3515, 1180.22827, -1338.84082, 12.14668,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1178.10120, -1332.42859, 13.51037,   0.00000, 0.00000, -101.52002);
	CreateDynamicObject(870, 1182.96985, -1337.31274, 13.20428,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19381, 1179.50793, -1340.45935, 12.90972,   0.00000, 90.00000, 0.42000);
	CreateDynamicObject(19381, 1180.33423, -1306.90247, 12.92865,   0.00000, 90.00000, -0.48000);
	CreateDynamicObject(19461, 1184.69531, -1340.51758, 11.41403,   0.00000, 0.00000, -179.81999);
	CreateDynamicObject(19369, 1183.16321, -1335.64063, 11.43098,   0.00000, 0.00000, 90.11999);
	CreateDynamicObject(19369, 1182.16370, -1335.63635, 11.42465,   0.00000, 0.00000, 90.11999);
	CreateDynamicObject(747, 1180.97461, -1338.31873, 11.93876,   0.00000, 0.00000, -162.47997);
	CreateDynamicObject(747, 1180.02429, -1337.62988, 11.93876,   0.00000, 0.00000, -116.63999);
	CreateDynamicObject(747, 1179.11414, -1338.15881, 11.93876,   0.00000, 0.00000, -53.09999);
	CreateDynamicObject(747, 1179.28455, -1339.29724, 11.93876,   0.00000, 0.00000, 11.94001);
	CreateDynamicObject(747, 1180.42297, -1340.05737, 11.93876,   0.00000, 0.00000, 57.90001);
	CreateDynamicObject(747, 1181.05920, -1339.20300, 11.93876,   0.00000, 0.00000, 118.80000);
	CreateDynamicObject(870, 1183.12183, -1340.71912, 13.20428,   0.00000, 0.00000, -45.12000);
	CreateDynamicObject(870, 1177.66260, -1340.46375, 13.20428,   0.00000, 0.00000, -112.49999);
	CreateDynamicObject(870, 1177.47119, -1337.35510, 13.20428,   0.00000, 0.00000, -161.87997);
	CreateDynamicObject(19369, 1183.94055, -1311.71082, 11.42465,   0.00000, 0.00000, 90.11999);
	CreateDynamicObject(19369, 1182.07922, -1311.71350, 11.41876,   0.00000, 0.00000, 90.11999);
	CreateDynamicObject(19461, 1185.49707, -1306.93164, 11.41403,   0.00000, 0.00000, -180.47997);
	CreateDynamicObject(3515, 1181.01318, -1308.29492, 12.14668,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(747, 1179.71094, -1307.98328, 11.93876,   0.00000, 0.00000, -53.09999);
	CreateDynamicObject(747, 1180.69751, -1307.29297, 11.93876,   0.00000, 0.00000, -105.84001);
	CreateDynamicObject(747, 1181.75562, -1307.71899, 11.93876,   0.00000, 0.00000, -149.93999);
	CreateDynamicObject(747, 1182.11255, -1308.76416, 11.93876,   0.00000, 0.00000, -216.71996);
	CreateDynamicObject(747, 1181.35010, -1309.27808, 11.93876,   0.00000, 0.00000, -288.83990);
	CreateDynamicObject(747, 1180.01550, -1309.01660, 11.93876,   0.00000, 0.00000, -333.35968);
	CreateDynamicObject(869, 1178.05798, -1315.05811, 13.51037,   0.00000, 0.00000, -101.52002);
	CreateDynamicObject(870, 1183.94958, -1310.00647, 13.20428,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(870, 1183.67395, -1306.65967, 13.20428,   0.00000, 0.00000, 56.34000);
	CreateDynamicObject(870, 1177.41821, -1310.19092, 13.20428,   0.00000, 0.00000, 56.34000);
	CreateDynamicObject(870, 1177.22852, -1306.84668, 13.20428,   0.00000, 0.00000, -9.30000);
	CreateDynamicObject(3508, 1179.45068, -1360.71973, 12.97379,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(870, 1183.48230, -1344.65552, 13.36028,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(870, 1183.50317, -1348.45154, 13.36028,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(870, 1183.71594, -1352.16650, 13.36028,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(870, 1178.61963, -1359.55457, 13.36028,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(870, 1179.07190, -1362.18359, 13.36028,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(870, 1180.66394, -1360.45276, 13.36028,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1182.51917, -1302.34534, 13.64138,   0.00000, 0.00000, -12.18003);
	CreateDynamicObject(869, 1181.46643, -1298.05774, 13.64138,   0.00000, 0.00000, -98.10001);
	CreateDynamicObject(869, 1182.58398, -1293.66565, 13.64138,   0.00000, 0.00000, -12.18003);
	// bolnica park
	CreateDynamicObject(19377, 1221.20129, -1380.29639, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.66406, -1380.29797, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1240.69067, -1380.28967, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.11279, -1370.68201, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.58997, -1370.67542, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1240.67383, -1370.66003, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.14258, -1361.07837, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.13965, -1351.46948, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.13745, -1341.85852, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.13782, -1332.24304, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.13086, -1322.63293, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.13306, -1313.01111, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1221.13110, -1303.40796, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.59778, -1312.99011, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.60181, -1303.36145, 12.33161,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1240.49951, -1312.98950, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1240.66187, -1303.35742, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1240.64355, -1295.61633, 12.38038,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1219.67896, -1293.82483, 12.38038,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(9131, 1245.61719, -1384.78076, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1243.68726, -1385.12305, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1239.51123, -1385.12390, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1235.35693, -1385.12769, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1231.17664, -1385.12415, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1227.01221, -1385.12537, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1222.87170, -1385.12610, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1218.70374, -1385.12939, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9131, 1231.15857, -1384.82483, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9131, 1216.24719, -1384.92078, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9131, 1216.41138, -1291.14392, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1218.86230, -1290.83813, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1223.00342, -1290.83691, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1227.14990, -1290.84094, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1231.31299, -1290.83923, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1235.48608, -1290.83875, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1239.65295, -1290.83533, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1243.80725, -1290.83643, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 1230.17712, -1293.78369, 12.37638,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(9131, 1245.62366, -1291.09692, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9131, 1231.24304, -1291.06763, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 1222.85962, -1383.28906, 12.41216,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 1229.71484, -1383.28931, 12.41216,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 1236.57458, -1383.28833, 12.41216,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 1239.95459, -1379.91150, 12.41220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1251, 1235.82910, -1379.90820, 12.41220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1251, 1231.72205, -1379.90503, 12.41220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1251, 1227.59460, -1379.91602, 12.41220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1251, 1219.37939, -1379.91272, 12.41220,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1251, 1222.93250, -1293.32739, 12.50719,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 1229.75696, -1293.33032, 12.50719,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 1236.60754, -1293.32617, 12.50719,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 1219.55640, -1296.82983, 12.50720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 1223.67566, -1296.81384, 12.50720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 1227.75317, -1296.80261, 12.50720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 1231.85876, -1296.81714, 12.50720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 1235.94556, -1296.80737, 12.50720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 1240.06287, -1296.80139, 12.50720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1245.62927, -1384.79211, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1231.14197, -1384.83533, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1216.25110, -1384.92334, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1216.35413, -1291.13989, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1231.22131, -1291.09473, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1245.63379, -1291.07312, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 1231.62659, -1361.05811, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.62219, -1351.42310, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.62231, -1341.78906, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.63269, -1332.16406, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1231.63354, -1322.57349, 12.31266,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1240.67737, -1361.03516, 12.29940,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1242.11597, -1351.41333, 12.29940,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1242.12463, -1341.78711, 12.29940,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1242.10413, -1332.16956, 12.29940,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 1242.08472, -1322.56055, 12.29940,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(6965, 1230.69580, -1337.25281, 15.82407,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6964, 1230.65723, -1337.17224, 11.81393,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 1244.70862, -1374.60327, 14.65384,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3660, 1244.66663, -1337.77747, 14.65384,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3660, 1244.70740, -1301.22534, 14.65384,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(717, 1245.15308, -1364.02734, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(717, 1245.15979, -1348.30664, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(717, 1245.01013, -1327.19800, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(717, 1245.18787, -1311.75842, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19373, 1230.49219, -1348.65332, 12.34835,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19373, 1230.49048, -1351.84839, 12.34835,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19373, 1230.49072, -1355.05737, 12.34835,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19373, 1230.48901, -1358.25537, 12.34835,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19373, 1230.44824, -1325.88940, 12.39865,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19373, 1230.44788, -1322.67957, 12.39865,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19373, 1230.45044, -1319.48022, 12.39865,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19373, 1230.45093, -1316.28430, 12.39865,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(9131, 1232.44604, -1314.94653, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9131, 1228.43933, -1314.96045, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1230.50037, -1314.68030, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9131, 1232.51453, -1359.66858, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 1230.55933, -1359.86682, 12.85477,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9131, 1228.53320, -1359.64246, 12.59972,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(828, 1228.70825, -1359.02368, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.67651, -1358.32153, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.63733, -1357.58142, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.70288, -1357.01648, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.68701, -1356.25647, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.72705, -1355.53772, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.70129, -1354.95337, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.69360, -1354.34827, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.67969, -1353.89709, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.68506, -1353.25000, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.68262, -1352.52979, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.66187, -1351.88989, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.66467, -1351.20984, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.66345, -1350.51001, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.63342, -1349.85071, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.62061, -1349.19055, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.60974, -1348.61108, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.68518, -1347.95056, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.75989, -1359.01807, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.75635, -1358.35657, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.75195, -1357.75647, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.73547, -1357.17615, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.71912, -1356.57617, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.72290, -1355.95593, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.71448, -1355.37476, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.69397, -1354.77209, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.69360, -1354.17078, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.66724, -1353.55713, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.64905, -1352.95764, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.63831, -1352.31738, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.60510, -1351.63806, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.58374, -1351.01868, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.55444, -1350.43921, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.54016, -1349.82056, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.51709, -1349.25293, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.49402, -1348.67334, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.48792, -1348.05188, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.48706, -1347.77124, 12.37840,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(717, 1230.36414, -1353.52563, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(717, 1230.49182, -1321.29932, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 1216.61243, -1374.75537, 14.65384,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(717, 1216.69275, -1364.18127, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 1216.69958, -1337.76843, 14.65384,   0.00000, 0.00000, 89.64002);
	CreateDynamicObject(717, 1216.63391, -1348.31897, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(717, 1216.79248, -1327.19531, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 1216.77905, -1301.27124, 14.65384,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(717, 1216.88440, -1311.81799, 12.53663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(828, 1229.07007, -1326.83643, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1229.05811, -1326.07666, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1229.06128, -1325.33667, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1229.04370, -1324.65649, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1229.02930, -1323.97717, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1229.01355, -1323.25732, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1229.00378, -1322.55762, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.99084, -1321.87744, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.97937, -1321.17688, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.98328, -1320.43652, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.96887, -1319.77661, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.96863, -1319.05554, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.95129, -1318.39539, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.93542, -1317.75537, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.93506, -1317.03430, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.91956, -1316.39404, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1228.88879, -1315.83435, 12.40408,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.47681, -1326.91943, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.48962, -1326.46448, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.49060, -1326.05945, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.50513, -1325.57910, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.51208, -1325.09778, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.50647, -1324.65784, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.49182, -1324.21777, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.49512, -1323.71643, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.50024, -1323.25452, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.51062, -1322.73364, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.49524, -1322.31421, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.48438, -1321.87341, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.47241, -1321.43323, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.45972, -1321.03308, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.45044, -1320.61328, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.44263, -1320.21338, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.43481, -1319.77368, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.42957, -1319.30920, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.43237, -1318.82715, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.43579, -1318.36536, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.42468, -1317.96570, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.44006, -1317.48523, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.43481, -1316.98486, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.45190, -1316.50354, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(828, 1232.44666, -1315.83887, 12.36414,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19122, 1228.42407, -1314.96216, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1232.44604, -1314.96570, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1232.49280, -1359.67310, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19122, 1228.51050, -1359.62219, 13.96324,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 1223.47778, -1379.91638, 12.41220,   0.00000, 0.00000, 180.00000);
    return (true);
}
