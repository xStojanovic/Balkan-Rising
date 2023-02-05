#include <YSI\y_hooks>

//================================================
/*
                 Balkan Rising
                   0.0.1x
                Car Tuning system
*/
//================================================

new In_Tuning_Shop[MAX_PLAYERS] = INVALID_PLAYER_ID;

//================================================

new const
	spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};
//==============================================================================
new const
 	nitro[3][0] = {
    {1008},
    {1009},
    {1010}
};
//==============================================================================
new const
	fbumper[23][0] = {
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1166},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1176},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1190},
    {1191}
};
//==============================================================================
new const
	rbumper[22][0] = {
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1167},
    {1168},
    {1175},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1192},
    {1193}
};
new const
	ventslr[4][0] = {
	{1142},
	{1143},
	{1144},
	{1145}
};
//==============================================================================
new const
	exhaust[29][0] = {
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1034},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};
//==============================================================================
new const
	roof[17][0] = {
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091},
    {1103},
	{1128},
	{1130},
	{1131}
};
//==============================================================================
new const
	lskirt[19][0] = {
    {1017},
    {1027},
    {1030},
    {1040},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};
//==============================================================================
new const
	rskirt[23][0] = {
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1041},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1095},
    {1106},
    {1108},
    {1118},
    {1119},
    {1122},
    {1133},
    {1134}
};
//==============================================================================
new const
	wheels[17][0] = {
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};
//===============================================================================
public OnEnterExitModShop(playerid, enterexit, interiorid){
    if(enterexit == 1){
                In_Tuning_Shop[playerid] = 1;
    }
    else if(enterexit == 0){
                In_Tuning_Shop[playerid] = 0;
                Player_Enum[playerid][p_Money] = GetPlayerMoney(playerid);
    }
    return (true);      
}

public OnVehicleMod(playerid, vehicleid, componentid){
    foreach(new a:Load_Vehicles_Array) 
    {
        if(COS_Enum[a][C_VEHICLE_ID] == vehicleid) 
        {
            if(In_Tuning_Shop[playerid] == 1)
            {
                if(strcmp(GetName(playerid), COS_Enum[a][C_OWNER], true) == 0)
                {
                    SavePlayerVehicleTuning(a, componentid);
                    COS_Enum[a][C_TUNING][C_TUNED] = (1);
                }
                if(!IsComponentidCompatible(GetVehicleModel(vehicleid), componentid)) RemoveVehicleComponent(vehicleid, componentid);
            }
            else
            {
                // dodati za tuning hack.
            }
        }   
    }
    return (true);
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid){
    foreach(new a:Load_Vehicles_Array) 
    {
        if(COS_Enum[a][C_VEHICLE_ID] == vehicleid) 
        {
            if(In_Tuning_Shop[playerid] == 1)
            {
                if(strcmp(GetName(playerid), COS_Enum[a][C_OWNER], true) == 0)
                {
                    COS_Enum[a][C_TUNING][C_PAINTJOB] = paintjobid;
                    COS_Enum[a][C_TUNING][C_TUNED] = (1);
                }   
            }
            else 
            {
                // dodati za tuning hack.
            }
        }   
    }
    return (true);
}

public OnVehicleRespray(playerid, vehicleid, color1, color2){
    foreach(new a:Load_Vehicles_Array) 
    {
        if(COS_Enum[a][C_VEHICLE_ID] == vehicleid) 
        {
            if(strcmp(GetName(playerid), COS_Enum[a][C_OWNER], true) == 0)
            {
                COS_Enum[a][C_COLOR][0] = color1;
                COS_Enum[a][C_COLOR][1] = color2;
                Save_Vehicle(a);
            }
        }   
    }
    return (true);
}
//===============================================================================
stock IsASkirt(componentid)
{
	for(new i = 0; i<sizeof(lskirt); i++)
	{
	    if(componentid == lskirt[i][0])
	    {
	        return (true);
		}
	}
	for(new i = 0; i<sizeof(rskirt); i++)
	{
	    if(componentid == rskirt[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsASpoiler(componentid)
{
	for(new i = 0; i<sizeof(spoiler); i++)
	{
	    if(componentid == spoiler[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsANitro(componentid)
{
	for(new i = 0; i<sizeof(nitro); i++)
	{
	    if(componentid == nitro[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsAFrontBumper(componentid)
{
    for(new i=0; i<sizeof(fbumper); i++)
	{
	    if(componentid == fbumper[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsARearBumper(componentid)
{
    for(new i=0; i<sizeof(rbumper); i++)
	{
	    if(componentid == rbumper[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsAStereo(componentid)
{
	if(componentid == 1086)
 	{
  		return (true);
	}
	return (false);
}
//==============================================================================
stock IsAExhaust(componentid)
{
    for(new i=0; i<sizeof(exhaust); i++)
	{
	    if(componentid == exhaust[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsALamp(componentid)
{
	if(componentid == 1013 || componentid == 1024)
	{
	    return (true);
	}
	return (false);
}
//==============================================================================
stock IsAHydraulic(componentid)
{
	if(componentid == 1087)
	{
	    return (true);
	}
	return (false);
}
//==============================================================================
stock IsAVents(componentid)
{
	for(new i=0; i<sizeof(ventslr); i++)
	{
	    if(componentid == ventslr[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsAHood(componentid)
{
	if(componentid == 1004 || componentid == 1005 || componentid == 1011 || componentid == 1012)
	{
	    return (true);
	}
	return (false);
}
//==============================================================================
stock IsAWheel(componentid)
{
	for(new i=0; i<sizeof(wheels); i++)
	{
	    if(componentid == wheels[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================
stock IsARoof(componentid)
{
	for(new i=0; i<sizeof(roof); i++)
	{
	    if(componentid == roof[i][0])
	    {
	        return (true);
		}
	}
	return (false);
}
//==============================================================================

stock IsComponentidCompatible(modelid, componentid)
{
    if(componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 ||
         componentid == 1077 || componentid == 1078 || componentid == 1079 || componentid == 1080 || componentid == 1081 ||
         componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 ||
         componentid == 1097 || componentid == 1098 || componentid == 1087 || componentid == 1086)
         return (true);

    switch (modelid)
    {
        case 400: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 401: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 114 || componentid == 1020 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 402: return (componentid == 1009 || componentid == 1009 || componentid == 1010);
        case 404: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 405: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1023 || componentid == 1000);
        case 409: return (componentid == 1009);
        case 410: return (componentid == 1019 || componentid == 1021 || componentid == 1020 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 411: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 412: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 415: return (componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 418: return (componentid == 1020 || componentid == 1021 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016);
        case 419: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 420: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1003);
        case 421: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1016 || componentid == 1000);
        case 422: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007);
        case 426: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003);
        case 429: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 436: return (componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 438: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 439: return (componentid == 1003 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1013);
        case 442: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 445: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 451: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 458: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 466: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 467: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 474: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 475: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 477: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 478: return (componentid == 1005 || componentid == 1004 || componentid == 1012 || componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 479: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 480: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 489: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016 || componentid == 1000);
        case 491: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 492: return (componentid == 1005 || componentid == 1004 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1016 || componentid == 1000);
        case 496: return (componentid == 1006 || componentid == 1017 || componentid == 1007 || componentid == 1011 || componentid == 1019 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1003 || componentid == 1002 || componentid == 1142 || componentid == 1143 || componentid == 1020);
        case 500: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 506: return (componentid == 1009);
        case 507: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 516: return (componentid == 1004 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1015 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 517: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 518: return (componentid == 1005 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 526: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 527: return (componentid == 1021 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1015 || componentid == 1017 || componentid == 1007);
        case 529: return (componentid == 1012 || componentid == 1011 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 533: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 534: return (componentid == 1126 || componentid == 1127 || componentid == 1179 || componentid == 1185 || componentid == 1100 || componentid == 1123 || componentid == 1125 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1180 || componentid == 1178 || componentid == 1101 || componentid == 1122 || componentid == 1124 || componentid == 1106);
        case 535: return (componentid == 1109 || componentid == 1110 || componentid == 1113 || componentid == 1114 || componentid == 1115 || componentid == 1116 || componentid == 1117 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1120 || componentid == 1118 || componentid == 1121 || componentid == 1119);
        case 536: return (componentid == 1104 || componentid == 1105 || componentid == 1182 || componentid == 1181 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1184 || componentid == 1183 || componentid == 1128 || componentid == 1103 || componentid == 1107 || componentid == 1108);
        case 540: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 541: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 542: return (componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1015);
        case 545: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 546: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 547: return (componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1016 || componentid == 1003 || componentid == 1000);
        case 549: return (componentid == 1012 || componentid == 1011 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 550: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003);
        case 551: return (componentid == 1005 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003);
        case 555: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 558: return (componentid == 1092 || componentid == 1089 || componentid == 1166 || componentid == 1165 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1168 || componentid == 1167 || componentid == 1088 || componentid == 1091 || componentid == 1164 || componentid == 1163 || componentid == 1094 || componentid == 1090 || componentid == 1095 || componentid == 1093);
        case 559: return (componentid == 1065 || componentid == 1066 || componentid == 1160 || componentid == 1173 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1159 || componentid == 1161 || componentid == 1162 || componentid == 1158 || componentid == 1067 || componentid == 1068 || componentid == 1071 || componentid == 1069 || componentid == 1072 || componentid == 1070 || componentid == 1009);
        case 560: return (componentid == 1028 || componentid == 1029 || componentid == 1169 || componentid == 1170 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1141 || componentid == 1140 || componentid == 1032 || componentid == 1033 || componentid == 1138 || componentid == 1139 || componentid == 1027 || componentid == 1026 || componentid == 1030 || componentid == 1031);
        case 561: return (componentid == 1064 || componentid == 1059 || componentid == 1155 || componentid == 1157 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1154 || componentid == 1156 || componentid == 1055 || componentid == 1061 || componentid == 1058 || componentid == 1060 || componentid == 1062 || componentid == 1056 || componentid == 1063 || componentid == 1057);
        case 562: return (componentid == 1034 || componentid == 1037 || componentid == 1171 || componentid == 1172 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1149 || componentid == 1148 || componentid == 1038 || componentid == 1035 || componentid == 1147 || componentid == 1146 || componentid == 1040 || componentid == 1036 || componentid == 1041 || componentid == 1039);
        case 565: return (componentid == 1046 || componentid == 1045 || componentid == 1153 || componentid == 1152 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1150 || componentid == 1151 || componentid == 1054 || componentid == 1053 || componentid == 1049 || componentid == 1050 || componentid == 1051 || componentid == 1047 || componentid == 1052 || componentid == 1048);
        case 566: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 567: return (componentid == 1129 || componentid == 1132 || componentid == 1189 || componentid == 1188 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1187 || componentid == 1186 || componentid == 1130 || componentid == 1131 || componentid == 1102 || componentid == 1133);
        case 575: return (componentid == 1044 || componentid == 1043 || componentid == 1174 || componentid == 1175 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1176 || componentid == 1177 || componentid == 1099 || componentid == 1042);
        case 576: return (componentid == 1136 || componentid == 1135 || componentid == 1191 || componentid == 1190 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1192 || componentid == 1193 || componentid == 1137 || componentid == 1134);
        case 579: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 580: return (componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 585: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 587: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 589: return (componentid == 1005 || componentid == 1004 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1024 || componentid == 1013 || componentid == 1006 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 600: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1022 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 602: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 603: return (componentid == 1144 || componentid == 1145 || componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
    }
    return (false);
}
//==============================================================================================

SavePlayerVehicleTuning(vehicleid, componentid)
{
 	if(IsASpoiler(componentid))
 	    COS_Enum[vehicleid][C_TUNING][C_SPOILER] = componentid;

	else if(IsANitro(componentid))
        COS_Enum[vehicleid][C_TUNING][C_NITRO] = componentid;

	else if(IsAFrontBumper(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_FRONT_BUMPER] = componentid;

	else if(IsARearBumper(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_REAR_BUMPER] = componentid;

	else if(IsAStereo(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_STEREO] = componentid;

	else if(IsAExhaust(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_EXHAUST] = componentid;

	else if(IsALamp(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_LAMPS] = componentid;

   	else if(IsAHydraulic(componentid))
   		COS_Enum[vehicleid][C_TUNING][C_HYDRAULICS] = componentid;

    else if(IsAVents(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_VENTS] = componentid;

    else if(IsAHood(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_HOOD] = componentid;

	else if(IsAWheel(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_WHEELS] = componentid;

	else if(IsARoof(componentid))
	    COS_Enum[vehicleid][C_TUNING][C_ROOF] = componentid;

	else if(IsASkirt(componentid))
        COS_Enum[vehicleid][C_TUNING][C_SKIRT] = componentid;

	Save_Vehicle(vehicleid);
	return (true);
}

stock TuneVehicle(vehicleid)
{
	if(COS_Enum[vehicleid][C_TUNING][C_TUNED])
	{
		if(COS_Enum[vehicleid][C_TUNING][C_PAINTJOB] >= 0 && COS_Enum[vehicleid][C_TUNING][C_PAINTJOB] < 6)
	        ChangeVehiclePaintjob(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_PAINTJOB]);
	 	if(IsASpoiler(COS_Enum[vehicleid][C_TUNING][C_SPOILER]))
	        AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_SPOILER]);
		if(IsANitro(COS_Enum[vehicleid][C_TUNING][C_NITRO]))
	        AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_NITRO]);
		if(IsAFrontBumper(COS_Enum[vehicleid][C_TUNING][C_FRONT_BUMPER]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_FRONT_BUMPER]);
		if(IsARearBumper(COS_Enum[vehicleid][C_TUNING][C_REAR_BUMPER]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_REAR_BUMPER]);
		if(IsAStereo(COS_Enum[vehicleid][C_TUNING][C_STEREO]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_STEREO]);
		if(IsAExhaust(COS_Enum[vehicleid][C_TUNING][C_EXHAUST]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_EXHAUST]);
		if(IsALamp(COS_Enum[vehicleid][C_TUNING][C_LAMPS]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_LAMPS]);
	    if(IsAHydraulic(COS_Enum[vehicleid][C_TUNING][C_HYDRAULICS]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_HYDRAULICS]);
	    if(IsAVents(COS_Enum[vehicleid][C_TUNING][C_VENTS]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_VENTS]);
	    if(IsAHood(COS_Enum[vehicleid][C_TUNING][C_HOOD]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_HOOD]);
		if(IsAWheel(COS_Enum[vehicleid][C_TUNING][C_WHEELS]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_WHEELS]);
		if(IsARoof(COS_Enum[vehicleid][C_TUNING][C_ROOF]))
		    AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_ROOF]);
		if(IsASkirt(COS_Enum[vehicleid][C_TUNING][C_SKIRT]))
	        AddVehicleComponent(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_TUNING][C_SKIRT]);

        ChangeVehicleColor(COS_Enum[vehicleid][C_VEHICLE_ID], COS_Enum[vehicleid][C_COLOR][0], COS_Enum[vehicleid][C_COLOR][1]);
  	}
  	return (true);
}

//================================================================================================
