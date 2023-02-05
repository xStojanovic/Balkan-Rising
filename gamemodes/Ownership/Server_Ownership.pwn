#include <YSI\y_hooks>

//================================================
/*
                 Balkan Rising
                   0.0.1x
                Car Ownership
*/
//================================================

static string[126];   

new Iterator:Load_Vehicles_Array<MAX_VEHICLES>;

//========= Cos var

new ModelSelected[MAX_PLAYERS] = 0,
    ModelBuy[MAX_PLAYERS] = 0,
    ColorBuy[MAX_PLAYERS][2],
    Katalog_Vehicles = 0,
    Vehicle_Preview[2] = INVALID_VEHICLE_ID;

new Selected_ID[MAX_PLAYERS] = -1,
    Nudi_Slot[4][MAX_PLAYERS];    

new Player_Keys[MAX_PLAYERS][4];    

//=================================================

#define MAX_OWNABLE_VEHICLES (1000)

#define MODEL_SELECTION_CARS (2) 
#define MODEL_SELECTION_COLOR (4)
//================================================

new SalonVozila[84][2] =
{
		{400, 4000},
		{401, 3000},
		{402, 12000},
		{404, 1000},
		{405, 9500},
		{410, 15000},
		{412, 1500},
		{413, 2500},
		{414, 2000},
		{415, 65000},
		{418, 2000},
		{419, 2500},
		{421, 6500},
		{422, 2500},
		{424, 8000},
		{426, 7000},
		{429, 75000},
		{434, 7000},
		{436, 3500},
		{439, 4000},
		{440, 2500},
		{442, 2000},
		{445, 8500},
		{451, 110000},
		{458, 3500},
		{466, 2000},
		{467, 2000},
		{474, 2000},
		{475, 7500},
		{477, 35000},
		{478, 2000},
		{479, 1000},
		{480, 90000},
		{482, 4500},
		{483, 3000},
		{489, 10000},
		{491, 3000},
		{492, 3000},
		{496, 5000},
		{499, 5000},
		{500, 3500},
		{505, 10000},
		{506, 95000},
		{507, 3500},
		{516, 4000},
		{517, 2500},
		{518, 2500},
		{526, 3500},
		{527, 3500},
		{529, 2500},
		{533, 4500},
		{534, 1500},
		{535, 5500},
		{536, 2500},
		{540, 3000},
		{541, 20000},
		{542, 3000},
		{543, 1500},
		{545, 6500},
		{546, 3500},
		{547, 3500},
		{549, 1000},
		{550, 5000},
		{551, 4500},
		{554, 5500},
		{555, 8500},
		{558, 2500},
		{559, 55000},
		{560, 75000},
		{561, 4500},
		{562, 65000},
		{565, 30000},
		{566, 3000},
		{567, 2500},
		{575, 2000},
		{576, 2000},
		{579, 8000},
		{580, 3500},
		{585, 3500},
		{587, 7000},
		{589, 20000},
		{600, 2500},
		{602, 25000},
		{603, 30000}
};

//===============================================

enum COS_VEHICLE_STORAGE{
	 C_MONEY,
	 C_WEAPON[2],
	 C_AMMO[2],
	 C_MATERIALS,
	 C_LSD,
	 C_COCAIN,
	 C_WEED
};

enum COS_VEHICLE_TUNING{
	 C_TUNED,
	 C_PAINTJOB,
	 C_SPOILER,
	 C_HOOD,
	 C_ROOF,
	 C_SKIRT,
	 C_LAMPS,
	 C_NITRO,
	 C_EXHAUST,
	 C_WHEELS,
	 C_STEREO,
	 C_HYDRAULICS,
	 C_FRONT_BUMPER,
	 C_REAR_BUMPER,
	 C_VENTS
};

enum COS_VEHICLE {
	 C_ID,
     C_OWNER[MAX_PLAYER_NAME + 1],
     C_MODEL,
     C_CREATED,
     Float:C_KILOMETERS,
     C_FUEL,
     Float:C_POS[4],
     C_COLOR[2],
     C_TUNING[COS_VEHICLE_TUNING],
     C_STORAGE[COS_VEHICLE_STORAGE],
     C_LOCKED,
     C_PRICE,
     C_PLATE[16],
     C_DESTROYED,
     C_INSURANCE,
     C_ALARM,
     C_LOCK,
     C_IMMOBILISER,
     C_VEHICLE_ID
};
new COS_Enum[MAX_OWNABLE_VEHICLES][COS_VEHICLE];

//====================================================

hook OnGameModeInit(){
	// dodavanje Preview_Vehicle-a
	Vehicle_Preview[0] = AddStaticVehicleEx(400, 1360.9333, -1757.3500, 13.5976, -90.0000, 1, 1, 2000);
	return (true);
}

hook OnPlayerSpawn(playerid){
	if(IsPlayerNPC(playerid)) //Provjerava dali se spawnao NPC.
    {
        new npcname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname, sizeof(npcname));
        if(!strcmp(npcname, "NpcJedan", true))
        {
      		SetPlayerPos(playerid, 1349.1022,-1747.9960,13.4960);
      		SetPlayerFacingAngle(playerid, 89.4104);
      		SetPlayerVirtualWorld(playerid, 150);
      		GiveWeaponToPlayer(playerid,41,100);
      		SetPlayerInterior(playerid, 0);
      		SetPlayerSkin(playerid, 50);
        }
        else if(!strcmp(npcname, "NpcDva", true))
        {
        	SetPlayerVirtualWorld(playerid, 150);
      		SetPlayerInterior(playerid, 0);
      		SetPlayerSkin(playerid, 50);
      		PutPlayerInVehicle(playerid, Vehicle_Preview[1], 0);
        }
	}
	return (true);

}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){

	new Float:pos[3]; GetPlayerPos(playerid,pos[0], pos[1], pos[2]);
    if(vehicleid == Vehicle_Preview[0])
    {
        	return SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    }
    return (true);
}

hook OnVehicleSpawn(vehicleid){
	for(new i = 0; i < MAX_OWNABLE_VEHICLES; i++)
	{
		TuneVehicle(i);
	}
	return (true);
}

hook OnVehicleDeath(vehicleid, killerid){

	new vID = isCOSVehicle(vehicleid);

	if (vID != (9999))
	{
		if(COS_Enum[vID][C_INSURANCE] != 0)
		{
		    COS_Enum[vID][C_INSURANCE] --;
		    Save_Vehicle(vID);
		}
		else
		{
			COS_Enum[vID][C_DESTROYED] ++;
			if(COS_Enum[vID][C_DESTROYED] == 10)
			{
				INFO(GetPlayerIdFromName(COS_Enum[vID][C_OWNER]), "Izgubili ste svoje vozilo jer ste ga slupali (10) puta!");
				ResetCosVehicle(vID);
			}
		}
	}
	return (true);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(PRESSED(KEY_CTRL_BACK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1365.9000,-1765.2555,13.5689))
		{
				if(Player_Enum[playerid][p_Level] < 3)
				   return GRESKA(playerid,"Nemate potreban level za kupovinu vozila!");
				if(Katalog_Vehicles == 1)
				   return GRESKA(playerid,"Neko vec kupuje vozilo sacekajte da zavrsi!");   
				if(ModelBuy[playerid] != 0)
				   return (true);  

				ShowGlobalTDs(playerid,2); Bit_Set(b_Textdraw, playerid, (true));

                TogglePlayerSpectating(playerid, (true));
				InterpolateCameraPos(playerid, 1366.001953, -1760.610473, 13.496230, 1361.229125, -1748.732543, 16.618656, 10000);
                InterpolateCameraLookAt(playerid, 1366.433715, -1765.591064, 13.410296, 1361.224243, -1753.490356, 15.081463, 10000);

		        SetPlayerVirtualWorld(playerid, 150);
              
		        defer Katalog_Priprema(playerid); 
	    }
	}
	if(PRESSED(KEY_ANALOG_RIGHT))
	{
		if(ModelBuy[playerid] != 0)
		{
			if(ModelSelected[playerid] == (sizeof(SalonVozila) - 1)) 
			    return(true);

	        ModelSelected[playerid] ++; Cos_Preview(playerid);

	        DestroyVehicle(Vehicle_Preview[0]);
		    Vehicle_Preview[0] = AddStaticVehicleEx(SalonVozila[ModelSelected[playerid]][0], 1360.9333, -1757.3500, 13.5976, -90.0000, 1, 1, 2000);
			SetVehicleVirtualWorld(Vehicle_Preview[0], 150); 

		}
	}
	if(PRESSED(KEY_ANALOG_LEFT))
	{
		if(ModelBuy[playerid] != 0)
		{
			if(ModelSelected[playerid] == 0)
			    return (true);

			ModelSelected[playerid] --; Cos_Preview(playerid);

	        DestroyVehicle(Vehicle_Preview[0]);
		    Vehicle_Preview[0] = AddStaticVehicleEx(SalonVozila[ModelSelected[playerid]][0], 1360.9333, -1757.3500, 13.5976, -90.0000, 1, 1, 2000);
			SetVehicleVirtualWorld(Vehicle_Preview[0], 150);     
		}
	}
	if(PRESSED(KEY_SECONDARY_ATTACK))
	{
		if(ModelBuy[playerid] == 1)
		{
			 if(Player_Enum[playerid][p_Money] < SalonVozila[ModelSelected[playerid]][1])
			   return GRESKA(playerid,"Ne mozete nastaviti jer nemate dovoljno novca (%s)",FormatNumber(SalonVozila[ModelSelected[playerid]][1]));
             Cos_TDs(playerid,2); Cos_TDs(playerid,1);
	         Cos_Preview(playerid);
	         INFO(playerid,"Odabrali ste vozilo: (%s),kako bi ga kupili pritisnite 'Buy vehicle'.",ReturnVehicleModelName(SalonVozila[ModelSelected[playerid]][0]));
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(ModelBuy[playerid] == 1)
		{
			Reset_Preview_Vehicle(); Cos_TDs(playerid,2);
			TogglePlayerSpectating(playerid, (false)); SetCameraBehindPlayer(playerid);
			ModelBuy[playerid] = 0; ModelSelected[playerid] = 0;
			Katalog_Vehicles = 0; SetPlayerVirtualWorld(playerid, 0);
			INFO(playerid,"Odustali ste od kupovine vozila.");
			SetPlayerPos(playerid,1365.9000,-1765.2555,13.5689);

		}
	}
	return (true);
}

//====================================================

stock Save_Vehicle(vehID)
{
	static query[2126];

	format(query,sizeof(query),"UPDATE `ug_cowner` SET `C_OWNER` = '%s', `C_MODEL` = '%d', `C_POS1` = '%.4f', `C_POS2` = '%.4f', `C_POS3` = '%.4f', `C_POS4` = '%.4f', `C_COLOR1` = '%d', `C_COLOR2` = '%d', `C_LOCKED` = '%d', `C_LOCK` = '%d', `C_PRICE` = '%d', `C_KILOMETERS` = '%.3f', `C_INSURANCE` = '%d'",
	COS_Enum[vehID][C_OWNER],
	COS_Enum[vehID][C_MODEL],
	COS_Enum[vehID][C_POS][0],
	COS_Enum[vehID][C_POS][1],
	COS_Enum[vehID][C_POS][2],
	COS_Enum[vehID][C_POS][3],
	COS_Enum[vehID][C_COLOR][0],
	COS_Enum[vehID][C_COLOR][1],
	COS_Enum[vehID][C_LOCKED],
	COS_Enum[vehID][C_LOCK],
	COS_Enum[vehID][C_PRICE],
	COS_Enum[vehID][C_KILOMETERS],
	COS_Enum[vehID][C_INSURANCE]);
	format(query,sizeof(query),"%s, `C_PLATE` = '%s', `C_DESTROYED` = '%d', `C_ALARM` = '%d', `C_IMMOBILISER` = '%d', `C_FUEL` = '%d', `C_MONEY` = '%d', `C_WEAPON1` = '%d', `C_WEAPON2` = '%d', `C_MATERIALS` = '%d', `C_LSD` = '%d', `C_WEED` = '%d', `C_COCAIN` = '%d'",
	query,
	COS_Enum[vehID][C_PLATE],
	COS_Enum[vehID][C_DESTROYED],
	COS_Enum[vehID][C_ALARM],
	COS_Enum[vehID][C_IMMOBILISER],
	COS_Enum[vehID][C_FUEL],
	COS_Enum[vehID][C_STORAGE][C_MONEY],
	COS_Enum[vehID][C_STORAGE][C_WEAPON][0],
	COS_Enum[vehID][C_STORAGE][C_WEAPON][1],
	COS_Enum[vehID][C_STORAGE][C_MATERIALS],
	COS_Enum[vehID][C_STORAGE][C_LSD],
	COS_Enum[vehID][C_STORAGE][C_WEED],
	COS_Enum[vehID][C_STORAGE][C_COCAIN]);
	format(query,sizeof(query),"%s, `C_TUNED` = '%d', `C_PAINTJOB` = '%d', `C_SPOILER` = '%d', `C_HOOD` = '%d', `C_ROOF` = '%d', `C_SKIRT` = '%d', `C_LAMPS` = '%d', `C_NITRO` = '%d', `C_EXHAUST` = '%d', `C_WHEELS` = '%d'",
	query,
	COS_Enum[vehID][C_TUNING][C_TUNED],
	COS_Enum[vehID][C_TUNING][C_PAINTJOB],
	COS_Enum[vehID][C_TUNING][C_SPOILER],
	COS_Enum[vehID][C_TUNING][C_HOOD],
	COS_Enum[vehID][C_TUNING][C_ROOF],
	COS_Enum[vehID][C_TUNING][C_SKIRT],
	COS_Enum[vehID][C_TUNING][C_LAMPS],
	COS_Enum[vehID][C_TUNING][C_NITRO],
	COS_Enum[vehID][C_TUNING][C_EXHAUST],
	COS_Enum[vehID][C_TUNING][C_WHEELS]);
	format(query,sizeof(query),"%s, `C_STEREO` = '%d', `C_HYDRAULICS` = '%d', `C_FRONT_BUMPER` = '%d', `C_REAR_BUMPER` = '%d', `C_VENTS` = '%d', `C_AMMO1` = '%d', `C_AMMO2` = '%d' WHERE `C_ID` = '%d'",
	query,
	COS_Enum[vehID][C_TUNING][C_STEREO],
	COS_Enum[vehID][C_TUNING][C_HYDRAULICS],
	COS_Enum[vehID][C_TUNING][C_FRONT_BUMPER],
	COS_Enum[vehID][C_TUNING][C_REAR_BUMPER],
	COS_Enum[vehID][C_TUNING][C_VENTS],
	COS_Enum[vehID][C_STORAGE][C_AMMO][0],COS_Enum[vehID][C_STORAGE][C_AMMO][1],
	vehID);
	return mysql_function_query(_dbConnector, query, false, "", "");
}

//===============================================

function Load_Vehicles()
{
	static rows,fields,str[128];

	cache_get_data(rows, fields, _dbConnector);

	for (new vID = 0; vID < rows; vID ++) if (vID < MAX_OWNABLE_VEHICLES)
	{
		  COS_Enum[vID][C_CREATED] = (1);

	      cache_get_field_content(vID, "C_OWNER", COS_Enum[vID][C_OWNER], _dbConnector);
	      cache_get_field_content(vID, "C_PLATE", COS_Enum[vID][C_PLATE], _dbConnector);

	      cache_get_field_content(vID, "C_ID", str); COS_Enum[vID][C_ID] = strval(str);
	      cache_get_field_content(vID, "C_MODEL", str); COS_Enum[vID][C_MODEL] = strval(str);
	      cache_get_field_content(vID, "C_POS1", str); COS_Enum[vID][C_POS][0] = floatstr(str);
	      cache_get_field_content(vID, "C_POS2", str); COS_Enum[vID][C_POS][1] = floatstr(str);	
	      cache_get_field_content(vID, "C_POS3", str); COS_Enum[vID][C_POS][2] = floatstr(str);	
	      cache_get_field_content(vID, "C_POS4", str); COS_Enum[vID][C_POS][3] = floatstr(str);
	      cache_get_field_content(vID, "C_COLOR1", str); COS_Enum[vID][C_COLOR][0] = strval(str);
	      cache_get_field_content(vID, "C_COLOR2", str); COS_Enum[vID][C_COLOR][1] = strval(str);
	      cache_get_field_content(vID, "C_LOCKED", str); COS_Enum[vID][C_LOCKED] = strval(str);
	      cache_get_field_content(vID, "C_LOCK", str); COS_Enum[vID][C_LOCK] = strval(str);
	      cache_get_field_content(vID, "C_PRICE", str); COS_Enum[vID][C_PRICE] = strval(str);
	      cache_get_field_content(vID, "C_DESTROYED", str); COS_Enum[vID][C_DESTROYED] = strval(str);
	      cache_get_field_content(vID, "C_ALARM", str); COS_Enum[vID][C_ALARM] = strval(str);
	      cache_get_field_content(vID, "C_IMMOBILISER", str); COS_Enum[vID][C_IMMOBILISER] = strval(str);
	      cache_get_field_content(vID, "C_KILOMETERS", str); COS_Enum[vID][C_KILOMETERS] = floatstr(str);
	      cache_get_field_content(vID, "C_FUEL", str); COS_Enum[vID][C_FUEL] = strval(str);
	      cache_get_field_content(vID, "C_INSURANCE", str); COS_Enum[vID][C_INSURANCE] = strval(str);

	      cache_get_field_content(vID, "C_MONEY", str); COS_Enum[vID][C_STORAGE][C_MONEY] = strval(str);
	      cache_get_field_content(vID, "C_WEAPON1", str); COS_Enum[vID][C_STORAGE][C_WEAPON][0] = strval(str);
	      cache_get_field_content(vID, "C_WEAPON2", str); COS_Enum[vID][C_STORAGE][C_WEAPON][1] = strval(str);
	      cache_get_field_content(vID, "C_AMMO1", str); COS_Enum[vID][C_STORAGE][C_AMMO][0] = strval(str);
	      cache_get_field_content(vID, "C_AMMO2", str); COS_Enum[vID][C_STORAGE][C_AMMO][1] = strval(str);
	      cache_get_field_content(vID, "C_MATERIALS", str); COS_Enum[vID][C_STORAGE][C_MATERIALS] = strval(str);
	      cache_get_field_content(vID, "C_LSD", str); COS_Enum[vID][C_STORAGE][C_LSD] = strval(str);
	      cache_get_field_content(vID, "C_WEED", str); COS_Enum[vID][C_STORAGE][C_WEED] = strval(str);

	      cache_get_field_content(vID, "C_TUNED", str); COS_Enum[vID][C_TUNING][C_TUNED] = strval(str);
	      cache_get_field_content(vID, "C_PAINTJOB", str); COS_Enum[vID][C_TUNING][C_PAINTJOB] = strval(str);
	      cache_get_field_content(vID, "C_SPOILER", str); COS_Enum[vID][C_TUNING][C_SPOILER] = strval(str);
	      cache_get_field_content(vID, "C_HOOD", str); COS_Enum[vID][C_TUNING][C_HOOD] = strval(str);
	      cache_get_field_content(vID, "C_ROOF", str); COS_Enum[vID][C_TUNING][C_ROOF] = strval(str);
	      cache_get_field_content(vID, "C_SKIRT", str); COS_Enum[vID][C_TUNING][C_SKIRT] = strval(str);
	      cache_get_field_content(vID, "C_LAMPS", str); COS_Enum[vID][C_TUNING][C_LAMPS] = strval(str);
	      cache_get_field_content(vID, "C_NITRO", str); COS_Enum[vID][C_TUNING][C_NITRO] = strval(str);
	      cache_get_field_content(vID, "C_EXHAUST", str); COS_Enum[vID][C_TUNING][C_EXHAUST] = strval(str);
	      cache_get_field_content(vID, "C_WHEELS", str); COS_Enum[vID][C_TUNING][C_WHEELS] = strval(str);
	      cache_get_field_content(vID, "C_STEREO", str); COS_Enum[vID][C_TUNING][C_STEREO] = strval(str);
	      cache_get_field_content(vID, "C_HYDRAULICS", str); COS_Enum[vID][C_TUNING][C_HYDRAULICS] = strval(str);
	      cache_get_field_content(vID, "C_FRONT_BUMPER", str); COS_Enum[vID][C_TUNING][C_FRONT_BUMPER] = strval(str);
	      cache_get_field_content(vID, "C_REAR_BUMPER", str); COS_Enum[vID][C_TUNING][C_REAR_BUMPER] = strval(str);
	      cache_get_field_content(vID, "C_VENTS", str); COS_Enum[vID][C_TUNING][C_VENTS] = strval(str);

	      Iter_Add(Load_Vehicles_Array,vID);


          COS_Enum[vID][C_VEHICLE_ID] = AddStaticVehicleEx(COS_Enum[vID][C_MODEL], COS_Enum[vID][C_POS][0],COS_Enum[vID][C_POS][1],COS_Enum[vID][C_POS][2],COS_Enum[vID][C_POS][3], COS_Enum[vID][C_COLOR][0], COS_Enum[vID][C_COLOR][1], 30000);
          TuneVehicle(vID);

          if(COS_Enum[vID][C_LOCKED] == (1)) SetVehicleParams(COS_Enum[vID][C_VEHICLE_ID], VEHICLE_TYPE_DOORS, 1);	
	}
	return (true);
}

//==================================================================

timer Katalog_Priprema[10100](playerid)
{
    DestroyVehicle(Vehicle_Preview[0]);
    Vehicle_Preview[0] = AddStaticVehicleEx(400, 1360.9333, -1757.3500, 13.5976, -90.0000, 1, 1, 2000);
	SetVehicleVirtualWorld(Vehicle_Preview[0], 150); 

    ModelBuy[playerid] = 1;

    INFO(playerid,"Da listate vozila pritisnite '4'(nazad) ili '6'(napred)");
    INFO(playerid,"Ako ste odabrali vozilo,pritisnite 'F/Enter' kako bi ga mogli kupiti.");
    INFO(playerid,"Ako zelite odustati od kupovine pritisnite 'LALT'.");

	Cos_TDs(playerid,3);
	Cos_Preview(playerid);
	return (true);
}

timer Garaza_Priprema[10100](playerid)
{
	#pragma unused playerid
    MoveDynamicObject(dizalice[0], 1346.72839, -1746.03931, 14.8953, 1.5);
    MoveDynamicObject(dizalice[1], 1346.72839, -1749.59790, 14.8953, 1.5);
    defer Color_Show(playerid);
	return (true);
}

timer Color_Show[1500](playerid)
{
	static colors[256];

	for (new i = 0; i < sizeof(colors); i ++) 
	{
		colors[i] = i;
   	}
   	ShowColorSelectionMenu(playerid, MODEL_SELECTION_COLOR, colors);
	return (true);
}

timer Bot_Show[1500](playerid)
{
	#pragma unused playerid
	ConnectNPC("NpcJedan", "npc_mehanicar");
	defer Bot_Kick(playerid);
	return (true);
}

timer Bot_Kick[9200](playerid)
{
		 foreach (new botid : Bot)
         {
		     Kick(botid);
	     }
         ChangeVehicleColor(Vehicle_Preview[1], ColorBuy[playerid][0], ColorBuy[playerid][1]);
         INFO(playerid,"Nas uposlenik je uspesno obojao vase vozilo!");
         INFO(playerid,"Sad cemo da ga dostavimo ispred autosalona.");

         defer Bot_Show_1(playerid);
         return (true);
}

timer Bot_Kick_1[12000](playerid)
{
	    foreach (new botid : Bot)
        {
		     Kick(botid);
	    }

	    Reset_Preview_Vehicle(); DestroyVehicle(Vehicle_Preview[1]); Cos_TDs(playerid,2);
		TogglePlayerSpectating(playerid, (false)); SetCameraBehindPlayer(playerid);

		ModelBuy[playerid] = 0; Bit_Set(b_Textdraw, playerid, false);
		Katalog_Vehicles = 0; SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid,1365.9000,-1765.2555,13.5689);
		SetPlayerInterior(playerid,0); SetPlayerVirtualWorld(playerid, 0);

		INFO(playerid,"Uspesno ste kupili: %s odite po njega vani!",ReturnVehicleModelName(SalonVozila[ModelSelected[playerid]][0]));
		INFO(playerid,"Za upravljanje vozilo koristite '/veh'");
		INFO(playerid,"Molimo preparkirajte vozilo izvan salona kako vam ga nebi oduzeli!!!!!");
		INFO(playerid,"Ako unistite vozilo 10 puta izgubice te ga!");

		new i = GetFree_CosID(); Iter_Add(Load_Vehicles_Array,i);

        Add_Base_Vehicle(i,GetName(playerid),SalonVozila[ModelSelected[playerid]][0],SalonVozila[ModelSelected[playerid]][1]);
        Set_Vehicle_Var(playerid,i);
	    return (true);
}

timer Bot_Show_1[1000](playerid)
{
	#pragma unused playerid
	ConnectNPC("NpcDva", "npc_mehanicar_voznja");

	InterpolateCameraPos(playerid, 1366.844970, -1718.738037, 45.127239, 1366.844970, -1718.738037, 45.127239, 10000);
    InterpolateCameraLookAt(playerid, 1366.843139, -1721.763793, 41.146652, 1366.843139, -1721.763793, 41.146652, 10000);

    defer Bot_Kick_1(playerid);
	return (true);
}

//=======================================================================//

Dialog:Veh_Opcije(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new i = Selected_ID[playerid],
        d_string[420],Float:vPos[3];

		switch(listitem)
        {
        	case 0:
        	{
        		  format(d_string,sizeof(d_string),
                  "{FFD000}Car Destroyed:{FFFFFF} (%d/10)\n\
                  {FFD000}Car Insurance: {FFFFFF}(%d)\n\
                  {FFD000}Car Kilometres: {FFFFFF}(%.3f KM/s)\n\
                  {FFD000}Car Fuel: {FFFFFF}(%d%)\n\
                  {FFD000}Car Lock: {FFFFFF}(%s)\n\
                  {FFD000}Car Money: {FFFFFF}($%d)\n\
                  {FFD000}Car Weapon: {FFFFFF}(%d) | (%d)\n\
                  {FFD000}Car Materials: {FFFFFF}(%dg)\n\
                  {FFD000}Car LSD: {FFFFFF}(%dg)\n\
                  {FFD000}Car Weed: {FFFFFF}(%dg)\n\
                  {FFD000}Car Cocain: {FFFFFF}(%dg)",
                  COS_Enum[i][C_DESTROYED],
                  COS_Enum[i][C_INSURANCE],
                  COS_Enum[i][C_KILOMETERS],
                  COS_Enum[i][C_FUEL],
                  (COS_Enum[i][C_LOCKED]) ? ("Zakljucano") : ("Otkljucano"),
                  COS_Enum[i][C_STORAGE][C_MONEY],
                  COS_Enum[i][C_STORAGE][C_WEAPON][0],COS_Enum[i][C_STORAGE][C_WEAPON][1],
                  COS_Enum[i][C_STORAGE][C_LSD],COS_Enum[i][C_STORAGE][C_WEED],COS_Enum[i][C_STORAGE][C_COCAIN]);
                  Dialog_Show(playerid, Show_Only, DSM, "{FFD000}VEHICLE {FFFFFF}- INFO", d_string, "IZLAZ", "");  d_string = "\0";
                  
        	}
        	case 1:
        	{

                 GetVehiclePos(COS_Enum[i][C_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);

                 if(!IsPlayerInRangeOfPoint(playerid, 5.0, vPos[0], vPos[1], vPos[2]))
                    return GRESKA(playerid,"Niste blizu svog vozila!");
             
        		 if(COS_Enum[i][C_LOCKED] == 1){
        		 	COS_Enum[i][C_LOCKED] = 0;
        		 	INFO(playerid,"Uspesno ste otkljucali: (%s).",ReturnVehicleModelName(COS_Enum[i][C_MODEL]));
        		 	SetVehicleParams(COS_Enum[i][C_VEHICLE_ID], VEHICLE_TYPE_DOORS, 0);
        		 } else if(COS_Enum[i][C_LOCKED] == 0){
        		 	COS_Enum[i][C_LOCKED] = 1;
        		 	INFO(playerid,"Uspesno ste zakljucali: (%s).",ReturnVehicleModelName(COS_Enum[i][C_MODEL]));
        		 	SetVehicleParams(COS_Enum[i][C_VEHICLE_ID], VEHICLE_TYPE_DOORS, 1);
        		 }	

        	}
        	case 2:
            {
                   GetVehicleBoot(COS_Enum[i][C_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);

                   if(!IsPlayerInRangeOfPoint(playerid, 2.0, vPos[0], vPos[1], vPos[2]))
                      return GRESKA(playerid,"Niste blizu gepeka svog vozila!");

                   SetVehicleParams(COS_Enum[i][C_VEHICLE_ID], VEHICLE_TYPE_BOOT, 1);  

        		   Dialog_Show(playerid, Veh_Spremnik, DSM, "{FFD000}VOZILO {FFFFFF}- SPREMNIK", "{FFFFFF}Spremnik vaseg vozila.\n\nDa uzmete nesto iz spremnika pritisnite {FFD000}'Uzimanje'.\n{FFFFFF}Da ostavite nesto u spremnik pritisnite {FFD000}'Ostavljanje'.", "Uzmimanje", "Ostavljanje");  
        	}
        	case 3:
        	{
        		   Dialog_Show(playerid, Veh_Unapredivanje, DSL, "{FFD000}VOZILO {FFFFFF}- UNAPREDIVANJE", "{FFFFFF}Brava\nAlarm\nImmobiliser", "Odaberi", "Izlaz");
        	}
        	case 4:
        	{
        		   Dialog_Show(playerid, Veh_Prodaja_Igracu, DSI, "{FFD000}VOZILO {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg vozila igracu.\n\nDa ponudite vozilo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete vozilo i cijenu za to vozilo.\n{FFFFFF}Slotovi vozila krecu se od (0-3).", "Ponudi", "Izlaz");  
        	}
        	case 5:
        	{
        		 static Float:Pos[4];
        		 if(!IsPlayerInVehicle(playerid, COS_Enum[i][C_VEHICLE_ID])) 
        		    return GRESKA(playerid,"Morate biti u svom vozilu!!!");
        		 if(IsPlayerInArea(playerid, 1356.934448, -1753.421875, 1393.539916, -1736.147094))
        		    return GRESKA(playerid,"Ne mozete parkirati blizu autosalona!");
        		 if(IsPlayerInArea(playerid, 2051.388183, -1881.555664, 2087.391357, -1860.702636))
			        return GRESKA(playerid,"Ne mozete parkirati blizu moto salona.");      

        		 GetVehiclePos(COS_Enum[i][C_VEHICLE_ID], Pos[0], Pos[1], Pos[2]);
        		 GetVehicleZAngle(COS_Enum[i][C_VEHICLE_ID], Pos[3]);

        		 COS_Enum[i][C_POS][0] = Pos[0];
        		 COS_Enum[i][C_POS][1] = Pos[1];
        		 COS_Enum[i][C_POS][2] = Pos[2];
        		 COS_Enum[i][C_POS][3] = Pos[3];
        		 DestroyVehicle(COS_Enum[i][C_VEHICLE_ID]);
        		 COS_Enum[i][C_VEHICLE_ID] = AddStaticVehicleEx(COS_Enum[i][C_MODEL], COS_Enum[i][C_POS][0],COS_Enum[i][C_POS][1],COS_Enum[i][C_POS][2],COS_Enum[i][C_POS][3], COS_Enum[i][C_COLOR][0], COS_Enum[i][C_COLOR][1], 30000);
        		 SetVehicleToRespawn(COS_Enum[i][C_VEHICLE_ID]);

        		 Save_Vehicle(i); TuneVehicle(i);

        		 INFO(playerid,"Uspesno ste preparkirali: (%s).",ReturnVehicleModelName(COS_Enum[i][C_MODEL]));     
        	}
        	case 6:
        	{
        		GetVehiclePos(COS_Enum[i][C_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);
        		SetPlayerCheckpoint(playerid, vPos[0], vPos[1], vPos[2], 2.0);

                INFO(playerid,"(%s) vam je oznacen na mapi!",ReturnVehicleModelName(COS_Enum[i][C_MODEL]));
        	}
        }
    }
    return (true);
}

Dialog:Veh_Spremnik(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         Dialog_Show(playerid, Veh_Spremnik_Uzimanje, DSL, "{FFD000}SPREMNIK {FFFFFF}- UZIMANJE", "Novac\nOruzije\nMaterijali\nDroga", "Odaberi", "Izlaz");  
	}
	else
	{
         Dialog_Show(playerid, Veh_Spremnik_Ostavljanje, DSL, "{FFD000}SPREMNIK {FFFFFF}- OSTAVLJANJE", "Novac\nOruzije\nMaterijali\nDroga", "Odaberi", "Izlaz");
	}
}

Dialog:Veh_Unapredivanje(playerid, response, listitem, inputtext[])
{
	if(response)
	{
            switch(listitem)
            {
	        	case 0:
	        	{
	        		Dialog_Show(playerid, Veh_Brava_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- BRAVA", "{FFFFFF}Unapredivanje brave.\nAko zelite da unapredite bravu imate 4 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level brave vas vise cuva od provale.", "Odaberi", "Nazad");
	        	}
	        	case 1:
	        	{
	        		Dialog_Show(playerid, Veh_Alarm_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- ALARM", "{FFFFFF}Unapredivanje alarma.\nAko zelite da unapredite alarm imate 3 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level alarma manje sanse za provalu.", "Odaberi", "Nazad");
	        	}
	        	case 2:
	        	{
	        		Dialog_Show(playerid, Veh_Immobiliser_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- IMMOBILISER", "{FFFFFF}Unapredivanje immobilisera.\nAko zelite da unapredite immobiliser imate 5 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level immobilisera manje sanse za provalu.", "Odaberi", "Nazad");
	        	}
	        }	
	}
	return (true);
}

//================================================================================

Dialog:Veh_Prodaja_Igracu(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           new idigraca,slot,cijena,Float:Pos[3];
           if(sscanf(inputtext, "udd", idigraca,slot,cijena))
             return Dialog_Show(playerid, Veh_Prodaja_Igracu, DSI, "{FFD000}VOZILO {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg vozila igracu.\n\nDa ponudite vozilo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete vozilo i cijenu za to vozilo.\n{FFFFFF}Slotovi vozila krecu se od (0-3).", "Ponudi", "Izlaz");
           if(slot < 0 || slot > 3)
             return Dialog_Show(playerid, Veh_Prodaja_Igracu, DSI, "{FFD000}VOZILO {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg vozila igracu.\n\nDa ponudite vozilo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete vozilo i cijenu za to vozilo.\n{FFFFFF}Slotovi vozila krecu se od (0-3).", "Ponudi", "Izlaz");
           if(idigraca == INVALID_PLAYER_ID)
             return GRESKA(playerid,"ID koji ste unijeli nije konektovan na server.");
           if(idigraca == playerid)
             return (true);
           if(cijena < 1)
             return Dialog_Show(playerid, Veh_Prodaja_Igracu, DSI, "{FFD000}VOZILO {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg vozila igracu.\n\nDa ponudite vozilo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete vozilo i cijenu za to vozilo.\n{FFFFFF}Slotovi vozila krecu se od (0-3).", "Ponudi", "Izlaz");

           GetPlayerPos(idigraca, Pos[0], Pos[1], Pos[2]);

           if(!IsPlayerInRangeOfPoint(playerid, 2.0, Pos[0], Pos[1], Pos[2]))
           	  return GRESKA(playerid,"Niste blizu igraca kojem prodajete!");

           if(Player_Enum[playerid][p_Vehicles][slot] == 9999)
             return GRESKA(playerid,"Slot sa kojeg prodajete vozilo je prazan!");

           Nudi_Slot[idigraca][0] = Player_Enum[playerid][p_Vehicles][slot];
           Nudi_Slot[idigraca][1] = cijena;
           Nudi_Slot[idigraca][2] = playerid;
           Nudi_Slot[idigraca][3] = slot;

           INFO(playerid,"Ponudli ste vozilo: (%s) sa slota %d igracu: %s",ReturnVehicleModelName(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_MODEL]),slot,GetName(idigraca));
           Dialog_Show(idigraca, Veh_Prodaja_Response, DSM, "{FFD000}VOZILO {FFFFFF}- PONUDA", "{FFFFFF}Ponudeno vam je vozilo od {1B8F07}(%s).\n\n{FFFFFF}Ime Vozila: {1B8F07}(%s)\n{FFFFFF}Cijena vozila {1B8F07}($%d).", "Prihvati", "Odustani",GetName(playerid),ReturnVehicleModelName(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_MODEL]),cijena);  

	}
	return (true);
}

Dialog:Veh_Prodaja_Response(playerid, response, listitem, inputtext[])
{
	new slot = Nudi_Slot[playerid][0],
	prodavaoc = Nudi_Slot[playerid][2],
	cijena = Nudi_Slot[playerid][1],
	slott = Nudi_Slot[playerid][3];

	if(response)
	{
		if(Player_Enum[playerid][p_Money] < cijena)
		   return GRESKA(playerid,"Nemate dovoljno novca za kupovinu ponudenog vozila!");
		   
		COS_Enum[slot][C_OWNER] = '\0';
		SetString(COS_Enum[slot][C_OWNER],GetName(playerid));

		Player_Enum[prodavaoc][p_Vehicles][slott] = 9999;

		if(Player_Enum[playerid][p_Vehicles][0] == 9999) Player_Enum[playerid][p_Vehicles][0] = slot;
		else if(Player_Enum[playerid][p_Vehicles][1] == 9999) Player_Enum[playerid][p_Vehicles][1] = slot;
		else if(Player_Enum[playerid][p_Vehicles][2] == 9999) Player_Enum[playerid][p_Vehicles][2] = slot;
		else if(Player_Enum[playerid][p_Vehicles][3] == 9999) Player_Enum[playerid][p_Vehicles][3] = slot;
		else return GRESKA(playerid,"Nemate slobodnih slotova!"); 

		Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena); // Onaj ko kupuje.
		Player_Enum[prodavaoc][p_Money] += cijena; GivePlayerMoney(prodavaoc,cijena); // Onaj ko prodaje.

		INFO(playerid,"Uspesno ste kupili (%s) od: %s za: $%d.",ReturnVehicleModelName(COS_Enum[slot][C_MODEL]),GetName(prodavaoc),cijena);
		INFO(prodavaoc,"Uspesno ste prodali (%s) igracu: %s za: $%d.",ReturnVehicleModelName(COS_Enum[slot][C_MODEL]),GetName(playerid),cijena);

		Nudi_Slot[playerid][0] = -1;
        Nudi_Slot[playerid][1] = -1;
        Nudi_Slot[playerid][2] = -1;
        Nudi_Slot[playerid][3] = -1;

		SavePlayer(playerid); SavePlayer(prodavaoc); 
		Save_Vehicle(slot);
	}
	else
	{
        INFO(playerid,"Prekinuli ste ponudu za vozilo!");
        INFO(prodavaoc,"%s je prekinuo vasu ponudu za: (%s).",GetName(playerid),ReturnVehicleModelName(COS_Enum[slot][C_MODEL]));

        Nudi_Slot[playerid][0] = -1;
        Nudi_Slot[playerid][1] = -1;
        Nudi_Slot[playerid][2] = -1;
        Nudi_Slot[playerid][3] = -1;
	}
	return (true);
}

//================================================================================

Dialog:Veh_Brava_Unapredivanje(playerid, response, listitem, inputtext[])
{
	if(response)
	{
          new level,cijena;
          if(sscanf(inputtext, "d", level))
           return Dialog_Show(playerid, Veh_Brava_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- BRAVA", "{FFFFFF}Unapredivanje brave.\nAko zelite da unapredite bravu imate 4 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level brave vas vise cuva od probale.", "Odaberi", "Nazad");
          if(level < 1 || level > 4)
           return  Dialog_Show(playerid, Veh_Brava_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- BRAVA", "{FFFFFF}Unapredivanje brave.\nAko zelite da unapredite bravu imate 4 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level brave vas vise cuva od probale.", "Odaberi", "Nazad");
          if(level == COS_Enum[Selected_ID[playerid]][C_LOCK])
            return GRESKA(playerid,"Vase vozilo vec posjedujte ovaj level zastite!");

          if(level == 1) cijena = 5000;
          else if(level == 2) cijena = 6000;
          else if(level == 3) cijena = 8000;
          else if(level == 4) cijena = 10000;

          if(cijena > Player_Enum[playerid][p_Money])
            return GRESKA(playerid,"Nemate dovoljno novca za ovaj level zastite $%d",cijena);
          Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena);    

          COS_Enum[Selected_ID[playerid]][C_LOCK] = level;
          
          INFO(playerid,"Uspesno ste nadogradili level brave na: (%s) level: %d za: $%d.",ReturnVehicleModelName(COS_Enum[Selected_ID[playerid]][C_MODEL]),level,cijena);

          Save_Vehicle(Selected_ID[playerid]);      
	}
	else 
	{
		 Dialog_Show(playerid, Veh_Unapredivanje, DSL, "{FFD000}VOZILO {FFFFFF}- UNAPREDIVANJE", "{FFFFFF}Brava\nAlarm\nImmobiliser", "Odaberi", "Izlaz");
	}
	return (true);
}

Dialog:Veh_Alarm_Unapredivanje(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         new level,cijena;
         if(sscanf(inputtext, "d", level))
           return Dialog_Show(playerid, Veh_Alarm_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- ALARM", "{FFFFFF}Unapredivanje alarma.\nAko zelite da unapredite alarm imate 3 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level alarma manje sanse za provalu.", "Odaberi", "Nazad");
         if(level < 1 || level > 3)
           return Dialog_Show(playerid, Veh_Alarm_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- ALARM", "{FFFFFF}Unapredivanje alarma.\nAko zelite da unapredite alarm imate 3 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level alarma manje sanse za provalu.", "Odaberi", "Nazad");
         if(level == COS_Enum[Selected_ID[playerid]][C_ALARM])
           return GRESKA(playerid,"Vase vozilo vec posjedujte ovaj level alarm zastite!");

         if(level == 1) cijena = 1200;
         else if(level == 2) cijena = 3000;
         else if(level == 3) cijena = 5000;

         if(cijena > Player_Enum[playerid][p_Money])
            return GRESKA(playerid,"Nemate dovoljno novca za ovaj level zastite $%d",cijena);
         Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena);    

         COS_Enum[Selected_ID[playerid]][C_ALARM] = level;
         
         INFO(playerid,"Uspesno ste nadogradili level alarma na: (%s) level: %d za: $%d.",ReturnVehicleModelName(COS_Enum[Selected_ID[playerid]][C_MODEL]),level,cijena);

         Save_Vehicle(Selected_ID[playerid]);            

	}
	else
	{
		 Dialog_Show(playerid, Veh_Unapredivanje, DSL, "{FFD000}VOZILO {FFFFFF}- UNAPREDIVANJE", "{FFFFFF}Brava\nAlarm\nImmobiliser", "Odaberi", "Izlaz");
	}
	return (true);
}

Dialog:Veh_Immo_Unapredivanje(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new level,cijena;
        if(sscanf(inputtext, "d", level))
          return Dialog_Show(playerid, Veh_Immobiliser_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- IMMOBILISER", "{FFFFFF}Unapredivanje immobilisera.\nAko zelite da unapredite immobiliser imate 5 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level immobilisera manje sanse za provalu.", "Odaberi", "Nazad");
        if(level < 1 || level > 5)
          return Dialog_Show(playerid, Veh_Immobiliser_Unapredivanje, DSI, "{FFD000}UNAPREDIVANJE {FFFFFF}- IMMOBILISER", "{FFFFFF}Unapredivanje immobilisera.\nAko zelite da unapredite immobiliser imate 5 levela.\nUnesite zeljeni level.\n\n{FF3B55}Zapamtite veci level immobilisera manje sanse za provalu.", "Odaberi", "Nazad");
        if(level == COS_Enum[Selected_ID[playerid]][C_IMMOBILISER])
           return GRESKA(playerid,"Vase vozilo vec posjedujte ovaj level immobiliser zastite!");

        if(level == 1) cijena = 1000;
        else if(level == 2) cijena = 2500;
        else if(level == 3) cijena = 3500;
        else if(level == 4) cijena = 5000;
        else if(level == 5) cijena = 10000;

        if(cijena > Player_Enum[playerid][p_Money])
            return GRESKA(playerid,"Nemate dovoljno novca za ovaj level zastite $%d",cijena);
        Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena);     

        COS_Enum[Selected_ID[playerid]][C_IMMOBILISER] = level;
         
        INFO(playerid,"Uspesno ste nadogradili level immobilisera na: (%s) level: %d za: $%d.",ReturnVehicleModelName(COS_Enum[Selected_ID[playerid]][C_MODEL]),level,cijena);

        Save_Vehicle(Selected_ID[playerid]);            
	}
	else
	{
         Dialog_Show(playerid, Veh_Unapredivanje, DSL, "{FFD000}VOZILO {FFFFFF}- UNAPREDIVANJE", "{FFFFFF}Brava\nAlarm\nImmobiliser", "Odaberi", "Izlaz");
	}
	return (true);
}

//================================================================================

Dialog:Veh_Spremnik_Uzimanje(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
        {
        	case 0:
        	{
        		Dialog_Show(playerid, Veh_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Uzimanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite uzeti iz svog vozila.", "Uzmi", "Odustani");  
        	}
        	case 1:
        	{
        		Dialog_Show(playerid, Veh_Uzimanje_Oruzija, DSI, "{FFD000}SPREMNIK {FFFFFF}- ORUZIJE", "{FFFFFF}Uzimanje oruzija.\n\nUpisite slot 'ORUZIJA' koji zelite uzeti.\nDostupni slotovi {FFD000}(0 - 1)", "Uzmi", "Odustani");
        	}
        }
    }
}

Dialog:Veh_Spremnik_Ostavljanje(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
        {
        	case 0:
        	{
        		Dialog_Show(playerid, Veh_Ostavljanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Ostavljanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite ostaviti u svoje vozilo.", "Ostavi", "Odustani");
        	}
        	case 1:
        	{
        		Dialog_Show(playerid, Veh_Ostavljanje_Oruzija, DSI, "{FFD000}SPREMNIK {FFFFFF}- ORUZIJE", "{FFFFFF}Ostavlljanje oruzija.\n\nUpisite slot na koji zelite staviti svoje oruzije.\nDostupni slotovi {FFD000}(0 - 1)", "Ostavi", "Odustani");
        	}
        }
	}
}

//=============================================================================

Dialog:Veh_Uzimanje_Novac(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new kolicina;
        if(sscanf(inputtext, "d", kolicina))
          return Dialog_Show(playerid, Veh_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Uzimanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite uzeti iz svog vozila.", "Uzmi", "Odustani");
        if(kolicina == 0 || kolicina > COS_Enum[Selected_ID[playerid]][C_STORAGE][C_MONEY])
          return Dialog_Show(playerid, Veh_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Uzimanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite uzeti iz svog vozila.", "Uzmi", "Odustani");

        Player_Enum[playerid][p_Money] += kolicina; GivePlayerMoney(playerid,kolicina);
        COS_Enum[Selected_ID[playerid]][C_STORAGE][C_MONEY] -= kolicina;
        SetVehicleParams(COS_Enum[Selected_ID[playerid]][C_VEHICLE_ID], VEHICLE_TYPE_BOOT, 0);
        INFO(playerid,"Uzeli ste $%d iz (%s).",kolicina,ReturnVehicleModelName(COS_Enum[Selected_ID[playerid]][C_MODEL]));

        Save_Vehicle(Selected_ID[playerid]);

	}
    return (true);
}

Dialog:Veh_Uzimanje_Oruzija(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new slot;
		if(sscanf(inputtext, "d", slot))
		  return Dialog_Show(playerid, Veh_Uzimanje_Oruzija, DSI, "{FFD000}SPREMNIK {FFFFFF}- ORUZIJE", "{FFFFFF}Uzimanje oruzija.\n\nUpisite slot 'ORUZIJA' koji zelite uzeti.\nDostupni slotovi {FFD000}(0 - 1)", "Uzmi", "Odustani");
		if(slot < 0 || slot > 1)
		  return Dialog_Show(playerid, Veh_Uzimanje_Oruzija, DSI, "{FFD000}SPREMNIK {FFFFFF}- ORUZIJE", "{FFFFFF}Uzimanje oruzija.\n\nUpisite slot 'ORUZIJA' koji zelite uzeti.\nDostupni slotovi {FFD000}(0 - 1)", "Uzmi", "Odustani");
		if(COS_Enum[Selected_ID[playerid]][C_STORAGE][C_WEAPON][slot] == 0)
		  return GRESKA(playerid,"Slot %d je prazan,pokusajte drugi!");  

		INFO(playerid,"Uzeli ste oruzije %s sa slota %d iz (%s)",ReturnWeaponName(COS_Enum[Selected_ID[playerid]][C_STORAGE][C_WEAPON][slot]),slot,ReturnVehicleModelName(COS_Enum[Selected_ID[playerid]][C_MODEL]));  

		COS_Enum[Selected_ID[playerid]][C_STORAGE][C_WEAPON][slot] = 0;
		COS_Enum[Selected_ID[playerid]][C_STORAGE][C_AMMO][slot] = 0;

		SetVehicleParams(COS_Enum[Selected_ID[playerid]][C_VEHICLE_ID], VEHICLE_TYPE_BOOT, 0);
		GiveWeaponToPlayer(playerid, COS_Enum[Selected_ID[playerid]][C_STORAGE][C_WEAPON][slot], COS_Enum[Selected_ID[playerid]][C_STORAGE][C_AMMO][slot]);

		Save_Vehicle(Selected_ID[playerid]);

	}
	return (true);
}

//=================================================================================

Dialog:Veh_Ostavljanje_Novac(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new kolicina;
        if(sscanf(inputtext, "d", kolicina))
          return Dialog_Show(playerid, Veh_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Ostavljanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite ostaviti u svoje vozilo.", "Ostavi", "Odustani");
        if(kolicina > Player_Enum[playerid][p_Money])  
          return Dialog_Show(playerid, Veh_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Ostavljanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite ostaviti u svoje vozilo.", "Ostavi", "Odustani");
        if(kolicina < 1)
          return Dialog_Show(playerid, Veh_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Ostavljanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite ostaviti u svoje vozilo.", "Ostavi", "Odustani");       
        Player_Enum[playerid][p_Money] -= kolicina; GivePlayerMoney(playerid,-kolicina);
        SetVehicleParams(COS_Enum[Selected_ID[playerid]][C_VEHICLE_ID], VEHICLE_TYPE_BOOT, 0);
        COS_Enum[Selected_ID[playerid]][C_STORAGE][C_MONEY] += kolicina;

        INFO(playerid,"Uspesno ste ostavili $%d u (%s)",kolicina,ReturnVehicleModelName(COS_Enum[Selected_ID[playerid]][C_MODEL]));

        Save_Vehicle(Selected_ID[playerid]);

	}
	return (true);
}

Dialog:Veh_Ostavljanje_Oruzija(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new slot;
        if(sscanf(inputtext, "d", slot))
          return Dialog_Show(playerid, Veh_Ostavljanje_Oruzija, DSI, "{FFD000}SPREMNIK {FFFFFF}- ORUZIJE", "{FFFFFF}Ostavlljanje oruzija.\n\nUpisite slot na koji zelite staviti svoje oruzije.\nDostupni slotovi {FFD000}(0 - 1)", "Ostavi", "Odustani");
        if(slot < 0 || slot > 1)
          return Dialog_Show(playerid, Veh_Ostavljanje_Oruzija, DSI, "{FFD000}SPREMNIK {FFFFFF}- ORUZIJE", "{FFFFFF}Ostavlljanje oruzija.\n\nUpisite slot na koji zelite staviti svoje oruzije.\nDostupni slotovi {FFD000}(0 - 1)", "Ostavi", "Odustani");
        if(GetPlayerWeapon(playerid) == 0)
          return GRESKA(playerid,"Morate imati oruzije u ruci.");

        if(COS_Enum[Selected_ID[playerid]][C_STORAGE][C_WEAPON][slot] > 0)
          return GRESKA(playerid,"Slot %d nije slobodan,probajte drugi!",slot);

        COS_Enum[Selected_ID[playerid]][C_STORAGE][C_WEAPON][slot] = GetPlayerWeapon(playerid);
        COS_Enum[Selected_ID[playerid]][C_STORAGE][C_AMMO][slot] = GetPlayerAmmo(playerid);

        ResetWeapon(playerid,GetWeapon(playerid));

        SetVehicleParams(COS_Enum[Selected_ID[playerid]][C_VEHICLE_ID], VEHICLE_TYPE_BOOT, 0);
        INFO(playerid,"Uspesno ste ostavili oruzije: %s na slot: %d u: (%s)",ReturnWeaponName(GetPlayerWeapon(playerid)),slot,ReturnVehicleModelName(COS_Enum[Selected_ID[playerid]][C_MODEL]));
        
        Save_Vehicle(Selected_ID[playerid]);
	}
	return (true);
}
//================================================================ Komande

YCMD:veh(playerid,params[],help)
{
    new previev_vehicles[4],
	v1 = Player_Enum[playerid][p_Vehicles][0],
	v2 = Player_Enum[playerid][p_Vehicles][1],
	v3 = Player_Enum[playerid][p_Vehicles][2],
	v4 = Player_Enum[playerid][p_Vehicles][3];


	if(v1 == 9999 && v2 == 9999 && v3 == 9999 && v4 == 9999)
	   return GRESKA(playerid,"Ne posjedujete ni jedno vozilo!");


	for(new i = 0; i< 4; ++i)
	{
		if(Player_Enum[playerid][p_Vehicles][i] != 9999)
		{
			previev_vehicles[i] = COS_Enum[Player_Enum[playerid][p_Vehicles][i]][C_MODEL];
		}
	}   
	ShowModelSelectionMenu(playerid, "Vehicle Selection", MODEL_SELECTION_CARS, previev_vehicles, sizeof(previev_vehicles), -16.0, 0.0, -55.0, 0.9, 1);
	return (true);
}

YCMD:takeinsurance(playerid,params[],help)
{
	new slot,paket;
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, 1296.8451,-1870.9634,13.5659))
	    return GRESKA(playerid,"Niste na mestu za osiguravanje vozila!");

	if(sscanf(params, "id", slot,paket))
	{
	   USAGE(playerid,"/takeinsurance [ slot vozila ] [ 0-3 ] [ paket ]");
	   INFO(playerid,"Dostupni paketi:(1.Small (500$), 2.Large (1000$), 3.Mega(3000$))");
	   return (true);
	}

	if(slot < 0 || slot > 3)
	   return GRESKA(playerid,"Dostupni slotovi samo od (0-3)!!");
	if(paket < 1 || paket > 3)
	   return GRESKA(playerid,"Paketi mogu biti od [1-3]!!!");
    if(Player_Enum[playerid][p_Vehicles][slot] == 9999)
       return GRESKA(playerid,"Nemate vozilo na unesenom slotu");
    if(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_INSURANCE] != 0)
        return GRESKA(playerid,"Uneseno vozilo vec ima osiguranje!!!");

    if(paket == 1)
    {
    	COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_INSURANCE] = 10;
    	Player_Enum[playerid][p_Money] -= 500; GivePlayerMoney(playerid,-500);
    	Save_Vehicle(Player_Enum[playerid][p_Vehicles][slot]);

    	INFO(playerid,"Osigurali ste svoj (%s) sa Small osiguranjem.",ReturnVehicleModelName(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_MODEL]));
    } 
    else if(paket == 2)
    {
    	COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_INSURANCE] = 20;
    	Player_Enum[playerid][p_Money] -= 1000; GivePlayerMoney(playerid,-1000);
    	Save_Vehicle(Player_Enum[playerid][p_Vehicles][slot]);

    	INFO(playerid,"Osigurali ste svoj (%s) sa Medium osiguranjem.",ReturnVehicleModelName(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_MODEL]));
    }    
    else if(paket == 3)
    {
    	COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_INSURANCE] = 50;
    	Player_Enum[playerid][p_Money] -= 3000; GivePlayerMoney(playerid,-3000);
    	Save_Vehicle(Player_Enum[playerid][p_Vehicles][slot]);

    	INFO(playerid,"Osigurali ste svoj (%s) sa Large osiguranjem.",ReturnVehicleModelName(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_MODEL]));
    }    
	return (true);
}


YCMD:givevehiclekey(playerid,params[],help)
{
	new idigraca,slot,Float:Pos[3];
	if(sscanf(params, "ud", idigraca,slot))
	   return USAGE(playerid,"/givevehiclekey [ID/Ime_Prezime] [slot vozila] [0-3]");

	if(idigraca == INVALID_PLAYER_ID)
	   return GRESKA(playerid,"ID koji ste unijeli nije registrovan!");
	if(idigraca == playerid)
	   return (true);
	if(Player_Enum[playerid][p_Vehicles][slot] == 9999)
	   return GRESKA(playerid,"Slot sa kojeg zelite dati kljuc je prazan!");

	GetPlayerPos(idigraca,Pos[0], Pos[1], Pos[2]);

	if(!IsPlayerInRangeOfPoint(playerid, 2.0, Pos[0], Pos[1], Pos[2]))
	   return GRESKA(playerid,"Morate biti blizu igraca kojem dajete kljuceve!");   

	for(new i = 0; i<4; ++i) 
	{
		if(Player_Keys[idigraca][i] != 9999)
		{
			Player_Keys[idigraca][i] = Player_Enum[playerid][p_Vehicles][slot];
			INFO(idigraca,"Igrac %s vam je dao kljuc od svog (%s).",GetName(playerid),ReturnVehicleModelName(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_MODEL]));
		}
	}

	INFO(playerid,"Dali ste %s kljuceve od (%s).",GetName(idigraca),ReturnVehicleModelName(COS_Enum[Player_Enum[playerid][p_Vehicles][slot]][C_MODEL]));        
	return (true);
}

//======================================================================

stock Reset_Preview_Vehicle()
{
	DestroyVehicle(Vehicle_Preview[0]);
    Vehicle_Preview[0] = AddStaticVehicleEx(400, 1360.9333, -1757.3500, 13.5976, -90.0000, 1, 1, 2000);
	SetVehicleVirtualWorld(Vehicle_Preview[0], 0);
	return (true);
}

//======================================================================

stock Add_Base_Vehicle(cID,Owner[],Model,Price)
{
	static query[300];
	format(query, sizeof(query), "INSERT INTO `ug_cowner` (`C_ID`, `C_OWNER`,`C_MODEL`,`C_PRICE`) VALUES(%d, '%s', %d, %d)",cID, Owner,Model,Price);
    mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";
    return (true);
}

stock Set_Vehicle_Var(playerid,vID)
{

    if(Player_Enum[playerid][p_Vehicles][0] == 9999)      Player_Enum[playerid][p_Vehicles][0] = vID;
	else if(Player_Enum[playerid][p_Vehicles][1] == 9999) Player_Enum[playerid][p_Vehicles][1] = vID;
	else if(Player_Enum[playerid][p_Vehicles][2] == 9999) Player_Enum[playerid][p_Vehicles][2] = vID;
	else if(Player_Enum[playerid][p_Vehicles][3] == 9999) Player_Enum[playerid][p_Vehicles][3] = vID;

	SavePlayer(playerid);

	SetString(COS_Enum[vID][C_OWNER],GetName(playerid));
	SetString(COS_Enum[vID][C_PLATE],"Nije osigurano");

    COS_Enum[vID][C_CREATED] = (1);
	COS_Enum[vID][C_ID] = vID;
    COS_Enum[vID][C_MODEL] = SalonVozila[ModelSelected[playerid]][0];
    COS_Enum[vID][C_PRICE] = SalonVozila[ModelSelected[playerid]][1];
    COS_Enum[vID][C_FUEL] = 20;

    COS_Enum[vID][C_POS][0] = 1358.9991; 
    COS_Enum[vID][C_POS][1] =-1747.0686;
    COS_Enum[vID][C_POS][2] = 13.3932;
    COS_Enum[vID][C_POS][3] = 269.4607;

    COS_Enum[vID][C_COLOR][0] = ColorBuy[playerid][0];
    COS_Enum[vID][C_COLOR][1] = ColorBuy[playerid][1];

    Player_Enum[playerid][p_Money] -= SalonVozila[ModelSelected[playerid]][1];
    GivePlayerMoney(playerid,-SalonVozila[ModelSelected[playerid]][1]);

    Reset_Preview_Vehicle();
    COS_Enum[vID][C_VEHICLE_ID] = AddStaticVehicleEx(COS_Enum[vID][C_MODEL], COS_Enum[vID][C_POS][0],COS_Enum[vID][C_POS][1],COS_Enum[vID][C_POS][2],COS_Enum[vID][C_POS][3], ColorBuy[playerid][0], ColorBuy[playerid][1], 30000);
    Save_Vehicle(COS_Enum[vID][C_ID]); ModelSelected[playerid] = 0; ModelBuy[playerid] = 0;
	return (true);
}

//========================================================================

stock GetFree_CosID()
{
	new cosID = Iter_Free(Load_Vehicles_Array);
	return ((cosID < MAX_OWNABLE_VEHICLES) ? (cosID) : (-1));
}

stock isCOSVehicle(vID)
{
	foreach(new i:Load_Vehicles_Array)
		if (COS_Enum[i][C_VEHICLE_ID] == vID) return (i);
	return (-1);
}

stock ResetCosVehicle(vID)
{
	static s_string[128];

	DestroyVehicle(COS_Enum[vID][C_VEHICLE_ID]);
	COS_Enum[vID][C_VEHICLE_ID] = (INVALID_VEHICLE_ID);

	for(new i = 0; i < 4; i++)
	{
		if(Player_Enum[GetPlayerIdFromName(COS_Enum[vID][C_OWNER])][p_Vehicles][i] == vID)
		{
			Player_Enum[GetPlayerIdFromName(COS_Enum[vID][C_OWNER])][p_Vehicles][i] = 9999;
		}
	}

	format(s_string, sizeof(s_string), "DELETE FROM `ug_cowner` WHERE `C_ID` = %d",vID);
    mysql_function_query(_dbConnector, s_string, false, "", "");
    
	Iter_Remove(Load_Vehicles_Array,vID);
	return (true);
}

//======================================================================

stock Cos_Preview(playerid)
{
	//=============================================================
	// preview model glavni.
	PlayerTextDrawSetPreviewModel(playerid, Cos_TD[9][playerid], SalonVozila[ModelSelected[playerid]][0]);
	PlayerTextDrawSetPreviewVehCol(playerid, Cos_TD[9][playerid], 1, 1);
	PlayerTextDrawShow(playerid,Cos_TD[9][playerid]);
	// preview model sporedni.
	PlayerTextDrawSetPreviewModel(playerid, Cos_TD[10][playerid], SalonVozila[ModelSelected[playerid]][0]);
	PlayerTextDrawSetPreviewVehCol(playerid, Cos_TD[10][playerid], 1, 1);
	PlayerTextDrawShow(playerid,Cos_TD[10][playerid]);
	// preview model sporedni.
	PlayerTextDrawSetPreviewModel(playerid, Cos_TD[12][playerid], SalonVozila[ModelSelected[playerid]][0]);
	PlayerTextDrawSetPreviewVehCol(playerid, Cos_TD[12][playerid], 1, 1);
	PlayerTextDrawShow(playerid,Cos_TD[12][playerid]);
	// preview name.
	format(string,sizeof(string),"%s",ReturnVehicleModelName(SalonVozila[ModelSelected[playerid]][0]));
	PlayerTextDrawSetString(playerid,Cos_TD[8][playerid],string);
	// preview price.
	PlayerTextDrawSetString(playerid,Cos_TD[11][playerid],FormatNumber(SalonVozila[ModelSelected[playerid]][1]));
	//previev vehicle doors.
	format(string,sizeof(string),"%d",GetVehicleModelSeats(SalonVozila[ModelSelected[playerid]][0]));
	PlayerTextDrawSetString(playerid,Cos_TD[13][playerid],string);
	//==============================================================
	return (true);
}
