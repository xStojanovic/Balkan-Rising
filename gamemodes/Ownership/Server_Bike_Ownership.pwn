#include <YSI\y_hooks>

//================================================
/*
                 Balkan Rising
                   0.0.1x
                Bike Ownership
*/
//================================================ 

new Katalog_Bikes = 0;

new Katalog_Bikess[7];

new Iterator:Load_Bikes_Array<MAX_VEHICLES>;

new Nudi_Bike_Slot[MAX_PLAYERS][4];

#define MODEL_SELECTION_BIKES_BUY (1)
#define MODEL_SELECTION_BIKES (3)

#define MAX_OWNABLE_BIKES (1000)

//================================================

new Salon_Bikes[12][2] = 
{
        {462, 800},
		{581, 15000},
		{522, 20000},
		{461, 1200},
		{521, 1500},
		{463, 2000},
		{586, 3000},
		{468, 3500},
		{471, 4000},
		{509, 200},
		{481, 300},
		{510, 500}
};

//================================================

new Float:random_Bike_Spawn[8][4] =
{
      { 2070.2434,-1864.8732,13.1237,181.7092 },
	  { 2068.3572,-1864.8859,13.1272,177.8349 },
	  { 2066.4160,-1864.7090,13.1230,177.1600 },
	  { 2064.5847,-1864.8981,13.1213,180.2914 },
	  { 2062.2617,-1864.8899,13.1270,179.2071 },
	  { 2060.2808,-1864.7552,13.1264,179.0865 },
	  { 2057.9111,-1864.7174,13.1260,179.0760 },
	  { 2056.0317,-1864.6740,13.1240,178.7208 }
};

//================================================

enum BIKE_STORAGE_ENUM{
	 BIKE_MONEY,
	 BIKE_WEAPON,
	 BIKE_AMMO,
	 BIKE_MATERIALS,
	 BIKE_LSD,
	 BIKE_COCAIN,
	 BIKE_WEED
};

enum BIKE_VEHICLE{
	B_ID,
	B_CREATED,
	BIKE_OWNER[MAX_PLAYER_NAME + 1],
	BIKE_PLATE[16],
	BIKE_PRICE,
	BIKE_MODEL,	
	Float:BIKE_POS[4],
	BIKE_FUEL,
	Float:BIKE_KILOMETERS,
	BIKE_LOCKED,
	BIKE_STORAGE[BIKE_STORAGE_ENUM],
	BIKE_COLORS[2],
	B_VEHICLE_ID,
};
new BIKE_Enum[MAX_OWNABLE_BIKES][BIKE_VEHICLE];

//============================================================================================================

hook OnGameModeInit(){
	Katalog_Bikess[0] = AddStaticVehicleEx(461,2037.3000488,-1866.9000244,13.3000002,225.0000000,-1,-1,15); //PCJ-600
	Katalog_Bikess[1] = AddStaticVehicleEx(463,2025.0000000,-1879.8000488,13.1999998,315.0000000,-1,-1,15); //Freeway
	Katalog_Bikess[2] = AddStaticVehicleEx(468,2031.1999512,-1869.9000244,13.3000002,235.0000000,-1,-1,15); //Sanchez
	Katalog_Bikess[3] = AddStaticVehicleEx(471,2025.0999756,-1867.0000000,13.1999998,240.0000000,-1,-1,15); //Quad
	Katalog_Bikess[4] = AddStaticVehicleEx(521,2037.4000244,-1879.6999512,13.1999998,315.0000000,-1,-1,15); //FCR-900
	Katalog_Bikess[5] = AddStaticVehicleEx(522,2037.4000244,-1873.4000244,13.1999998,270.0000000,-1,-1,15); //NRG-500
	Katalog_Bikess[6] = AddStaticVehicleEx(581,2025.0999756,-1873.4000244,13.3000002,270.0000000,-1,-1,15); //BF-400
	return (true);
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
	new Float:Pos[3]; GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);

	for(new i = 0; i<7; ++i)
	{
		if(vehicleid == Katalog_Bikess[i])
		   return SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	}
	return (true);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(PRESSED(KEY_CTRL_BACK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 2016.0305,-1879.5741,13.5859))
		{
			        static salon_bikes[12];

                    if(Player_Enum[playerid][p_Level] < 3)
				       return GRESKA(playerid,"Nemate potreban level za kupovinu vozila!");
				    if(Katalog_Bikes == 1)
				       return GRESKA(playerid,"Neko vec kupuje motor sacekajte da zavrsi!");

				    Katalog_Bikes = 1;   

				    for(new i = 0; i < 12; ++i)
				    {
                            salon_bikes[i] = Salon_Bikes[i][0];
				    }   
				    ShowModelSelectionMenu(playerid, "Purchase Bike", MODEL_SELECTION_BIKES_BUY, salon_bikes, sizeof(salon_bikes), -16.0, 0.0, -55.0, 0.9, 1);           
		}
	}
	return (true);
}

//============================================================================================================

function Load_Bikes()
{
	static rows,fields,str[128];

	cache_get_data(rows, fields, _dbConnector);

	for (new bID = 0; bID < rows; bID ++) if (bID < MAX_OWNABLE_VEHICLES)
	{
		BIKE_Enum[bID][B_CREATED] = (1);
		cache_get_field_content(bID, "BIKE_OWNER", BIKE_Enum[bID][BIKE_OWNER], _dbConnector);
	    cache_get_field_content(bID, "BIKE_PLATE", BIKE_Enum[bID][BIKE_PLATE], _dbConnector);

	    cache_get_field_content(bID, "B_ID", str); BIKE_Enum[bID][B_ID] = strval(str);
	    cache_get_field_content(bID, "BIKE_MODEL", str); BIKE_Enum[bID][BIKE_MODEL] = strval(str);
	    cache_get_field_content(bID, "BIKE_PRICE", str); BIKE_Enum[bID][BIKE_PRICE] = strval(str);
	    cache_get_field_content(bID, "BIKE_COLOR1", str); BIKE_Enum[bID][BIKE_COLORS][0] = strval(str);
	    cache_get_field_content(bID, "BIKE_COLOR2", str); BIKE_Enum[bID][BIKE_COLORS][1] = strval(str);
	    cache_get_field_content(bID, "BIKE_FUEL", str); BIKE_Enum[bID][BIKE_FUEL] = strval(str);
	    cache_get_field_content(bID, "BIKE_KILOMETERS", str); BIKE_Enum[bID][BIKE_KILOMETERS] = floatstr(str);
	    cache_get_field_content(bID, "BIKE_LOCKED", str); BIKE_Enum[bID][BIKE_LOCKED] = strval(str);

	    cache_get_field_content(bID, "BIKE_MONEY", str); BIKE_Enum[bID][BIKE_STORAGE][BIKE_MONEY] = strval(str);
	    cache_get_field_content(bID, "BIKE_WEAPON", str); BIKE_Enum[bID][BIKE_STORAGE][BIKE_WEAPON] = strval(str);
	    cache_get_field_content(bID, "BIKE_AMMO", str); BIKE_Enum[bID][BIKE_STORAGE][BIKE_AMMO] = strval(str);
	    cache_get_field_content(bID, "BIKE_MATERIALS", str); BIKE_Enum[bID][BIKE_STORAGE][BIKE_MATERIALS] = strval(str);
	    cache_get_field_content(bID, "BIKE_LSD", str); BIKE_Enum[bID][BIKE_STORAGE][BIKE_LSD] = strval(str);
	    cache_get_field_content(bID, "BIKE_WEED", str); BIKE_Enum[bID][BIKE_STORAGE][BIKE_WEED] = strval(str);
	    cache_get_field_content(bID, "BIKE_COCAIN", str); BIKE_Enum[bID][BIKE_STORAGE][BIKE_COCAIN] = strval(str);

	    cache_get_field_content(bID, "BIKE_POS1", str); BIKE_Enum[bID][BIKE_POS][0]= floatstr(str);
	    cache_get_field_content(bID, "BIKE_POS2", str); BIKE_Enum[bID][BIKE_POS][1]= floatstr(str);
	    cache_get_field_content(bID, "BIKE_POS3", str); BIKE_Enum[bID][BIKE_POS][2]= floatstr(str);
	    cache_get_field_content(bID, "BIKE_POS4", str); BIKE_Enum[bID][BIKE_POS][3]= floatstr(str);

	    Iter_Add(Load_Bikes_Array,bID);

	    BIKE_Enum[bID][B_VEHICLE_ID] = AddStaticVehicleEx(BIKE_Enum[bID][BIKE_MODEL], BIKE_Enum[bID][BIKE_POS][0],BIKE_Enum[bID][BIKE_POS][1],BIKE_Enum[bID][BIKE_POS][2],BIKE_Enum[bID][BIKE_POS][3], BIKE_Enum[bID][BIKE_COLORS][0], BIKE_Enum[bID][BIKE_COLORS][1], 30000);

	    printf("(Bike Load) ID: %d Vozilo %s Model %d Vlasnik: %s",bID,ReturnVehicleModelName(BIKE_Enum[bID][BIKE_MODEL]),BIKE_Enum[bID][BIKE_MODEL],BIKE_Enum[bID][BIKE_OWNER]);
	}
	return (true);
}

//=============================================================================================================

stock Save_Bike(bID)
{
	static query[2126];

	format(query,sizeof(query),"UPDATE `ug_bowner` SET `BIKE_OWNER` = '%s', `BIKE_MODEL` = '%d', `BIKE_PRICE` = '%d', `BIKE_POS1` = '%.4f', `BIKE_POS2` = '%.4f', `BIKE_POS3` = '%.4f', `BIKE_POS4` = '%.4f', `BIKE_COLOR1` = '%d', `BIKE_COLOR2` = '%d', `BIKE_LOCKED` = '%d', `BIKE_KILOMETERS` = '%.3f'",
    BIKE_Enum[bID][BIKE_OWNER],
    BIKE_Enum[bID][BIKE_MODEL],
    BIKE_Enum[bID][BIKE_PRICE],
    BIKE_Enum[bID][BIKE_POS][0],
    BIKE_Enum[bID][BIKE_POS][1],
    BIKE_Enum[bID][BIKE_POS][2],
    BIKE_Enum[bID][BIKE_POS][3],
    BIKE_Enum[bID][BIKE_COLORS][0],
    BIKE_Enum[bID][BIKE_COLORS][1],
    BIKE_Enum[bID][BIKE_LOCKED],
    BIKE_Enum[bID][BIKE_KILOMETERS]);
    format(query,sizeof(query),"%s, `BIKE_FUEL` = '%d', `BIKE_PLATE` = '%s', `BIKE_MONEY` = '%d', `BIKE_WEAPON` = '%d', `BIKE_AMMO` = '%d', `BIKE_MATERIALS` = '%d', `BIKE_LSD` = '%d', `BIKE_WEED` = '%d', `BIKE_COCAIN` = '%d' WHERE `B_ID` = '%d'",
    query,
    BIKE_Enum[bID][BIKE_FUEL],
    BIKE_Enum[bID][BIKE_PLATE],
    BIKE_Enum[bID][BIKE_STORAGE][BIKE_MONEY],
    BIKE_Enum[bID][BIKE_STORAGE][BIKE_WEAPON],
    BIKE_Enum[bID][BIKE_STORAGE][BIKE_AMMO],
    BIKE_Enum[bID][BIKE_STORAGE][BIKE_MATERIALS],
    BIKE_Enum[bID][BIKE_STORAGE][BIKE_LSD],
    BIKE_Enum[bID][BIKE_STORAGE][BIKE_WEED],
    BIKE_Enum[bID][BIKE_STORAGE][BIKE_COCAIN],bID);	
	return mysql_function_query(_dbConnector, query, false, "", "");
}

//===============================================================================================================

stock Add_Base_Bike(bID,Owner[],Model,Price)
{
	static query[300];
	format(query, sizeof(query), "INSERT INTO `ug_bowner` (`B_ID`, `BIKE_OWNER`,`BIKE_MODEL`,`BIKE_PRICE`) VALUES(%d, '%s', %d, %d)",bID, Owner,Model,Price);
    mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";
	return (true);
}

stock GetFree_BosID()
{
	new bosID = Iter_Free(Load_Bikes_Array);
	return ((bosID < MAX_OWNABLE_BIKES) ? (bosID) : (-1));
}

stock isBOSVehicle(vID)
{
	foreach(new i:Load_Bikes_Array)
		if (BIKE_Enum[i][B_VEHICLE_ID]  == vID) return (i);
	return (-1);
}

//===============================================================================================================

stock Set_Bike_Var(playerid,bID,index)
{
	new rand_spawn = random(sizeof(random_Bike_Spawn));

	if(Player_Enum[playerid][p_Bikes][0] == 9999)      Player_Enum[playerid][p_Bikes][0] = bID;
	else if(Player_Enum[playerid][p_Bikes][1] == 9999) Player_Enum[playerid][p_Bikes][1] = bID;
	else if(Player_Enum[playerid][p_Bikes][2] == 9999) Player_Enum[playerid][p_Bikes][2] = bID;
	else if(Player_Enum[playerid][p_Bikes][3] == 9999) Player_Enum[playerid][p_Bikes][3] = bID;

	SavePlayer(playerid);

	BIKE_Enum[bID][B_CREATED] = (1);
	BIKE_Enum[bID][B_ID] = bID;

	SetString(BIKE_Enum[bID][BIKE_OWNER],GetName(playerid));
	SetString(BIKE_Enum[bID][BIKE_PLATE],"Nije osigurano");

	BIKE_Enum[bID][BIKE_MODEL] = Salon_Bikes[index][0];
	BIKE_Enum[bID][BIKE_PRICE] = Salon_Bikes[index][1];
	BIKE_Enum[bID][BIKE_FUEL] = (20);

	BIKE_Enum[bID][BIKE_COLORS][0] = random(6);
	BIKE_Enum[bID][BIKE_COLORS][1] = random(6);

	BIKE_Enum[bID][BIKE_POS][0] = random_Bike_Spawn[rand_spawn][0];
	BIKE_Enum[bID][BIKE_POS][1] = random_Bike_Spawn[rand_spawn][1];
	BIKE_Enum[bID][BIKE_POS][2] = random_Bike_Spawn[rand_spawn][2];
	BIKE_Enum[bID][BIKE_POS][3] = random_Bike_Spawn[rand_spawn][3];

	Player_Enum[playerid][p_Money] -= Salon_Bikes[index][1]; 
	GivePlayerMoney(playerid,-Salon_Bikes[index][1]);

	INFO(playerid,"Uspesno ste kupili (%s) za $%d",ReturnVehicleModelName(Salon_Bikes[index][0]),Salon_Bikes[index][1]);
	INFO(playerid,"Da upravljate kupljenim vozilom kucajte '/bike'");
	INFO(playerid,"Vase vozilo se nalazi ispred naseg salona.");

	Save_Bike(bID);

	BIKE_Enum[bID][B_VEHICLE_ID] = AddStaticVehicleEx(BIKE_Enum[bID][BIKE_MODEL], BIKE_Enum[bID][BIKE_POS][0],BIKE_Enum[bID][BIKE_POS][1],BIKE_Enum[bID][BIKE_POS][2],BIKE_Enum[bID][BIKE_POS][3], BIKE_Enum[bID][BIKE_COLORS][0], BIKE_Enum[bID][BIKE_COLORS][1], 30000);
	return (true);
}

//===================================================================================================

YCMD:bike(playerid,params[],help)
{
	new previev_bikes[4],
	v1 = Player_Enum[playerid][p_Bikes][0],
	v2 = Player_Enum[playerid][p_Bikes][1],
	v3 = Player_Enum[playerid][p_Bikes][2],
	v4 = Player_Enum[playerid][p_Bikes][3];

	if(v1 == 9999 && v2 == 9999 && v3 == 9999 && v4 == 9999)
	   return GRESKA(playerid,"Ne posjedujete ni jedan motor/bicikl!");

	for(new i = 0; i< 4; ++i)
	{
		if(Player_Enum[playerid][p_Bikes][i] != 9999)
		{
			previev_bikes[i] = BIKE_Enum[Player_Enum[playerid][p_Bikes][i]][BIKE_MODEL];
		}
	}   
	ShowModelSelectionMenu(playerid, "Bikes Selection", MODEL_SELECTION_BIKES, previev_bikes, sizeof(previev_bikes), -16.0, 0.0, -55.0, 0.9, 1);   
	return (true);
}

//====================================================================================================

Dialog:Bike_Opcije(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new i = Selected_ID[playerid],
		d_string[350],Float:vPos[3];

		switch(listitem)
        {
        	case 0:
        	{
        		  format(d_string,sizeof(d_string),
        		  "{FFD000}Bike Fuel: {FFFFFF}(%d %)\n\
        		  {FFD000}Bike Kilometers: {FFFFFF}(%.3f)\n\
                  {FFD000}Bike Lock: {FFFFFF}(%s)\n\
                  {FFD000}Bike Money: {FFFFFF}($%d)\n\
                  {FFD000}Bike Weapon: {FFFFFF}(%d) | (%d)\n\
                  {FFD000}Bike Materials: {FFFFFF}(%dg)\n\
                  {FFD000}Bike LSD: {FFFFFF}(%dg)\n\
                  {FFD000}Bikes Weed: {FFFFFF}(%dg)\n\
                  {FFD000}Bike Cocain: {FFFFFF}(%dg)",BIKE_Enum[i][BIKE_FUEL],BIKE_Enum[i][BIKE_KILOMETERS],(BIKE_Enum[i][BIKE_LOCKED]) ? ("Zakljucano") : ("Otkljucano"),
                  BIKE_Enum[i][BIKE_STORAGE][BIKE_MONEY],
			      BIKE_Enum[i][BIKE_STORAGE][BIKE_WEAPON],
			      BIKE_Enum[i][BIKE_STORAGE][BIKE_AMMO],
			      BIKE_Enum[i][BIKE_STORAGE][BIKE_MATERIALS],
			      BIKE_Enum[i][BIKE_STORAGE][BIKE_LSD],
			      BIKE_Enum[i][BIKE_STORAGE][BIKE_WEED],
			      BIKE_Enum[i][BIKE_STORAGE][BIKE_COCAIN]);
			      Dialog_Show(playerid, Show_Only, DSM, "{FFD000}BIKE {FFFFFF}- INFO", d_string, "IZLAZ", "");
            }
            case 1:
            {
            	  GetVehiclePos(BIKE_Enum[i][B_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);

                  if(!IsPlayerInRangeOfPoint(playerid, 2.0, vPos[0], vPos[1], vPos[2]))
                    return GRESKA(playerid,"Niste blizu svog motora!");

                  if(BIKE_Enum[i][BIKE_LOCKED] == 1)  {
                  	BIKE_Enum[i][BIKE_LOCKED] = 0;
                  	INFO(playerid,"Uspesno ste otkljucali svoj motor!");
                  	SetVehicleParams(BIKE_Enum[i][B_VEHICLE_ID], VEHICLE_TYPE_DOORS, 0);
                  }
                  else if(BIKE_Enum[i][BIKE_LOCKED] == 0)  {
                  	BIKE_Enum[i][BIKE_LOCKED] = 1;
                  	INFO(playerid,"Uspesno ste zakljucali svoj motor!");
                  	SetVehicleParams(BIKE_Enum[i][B_VEHICLE_ID], VEHICLE_TYPE_DOORS, 1);
                  }	
            }
            case 2:
            {
                  GetVehiclePos(BIKE_Enum[i][B_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);

                  if(!IsPlayerInRangeOfPoint(playerid, 2.0, vPos[0], vPos[1], vPos[2]))
                    return GRESKA(playerid,"Niste blizu svog motora!");

                  Dialog_Show(playerid, Bike_Spremnik, DSM, "{FFD000}MOTOR {FFFFFF}- SPREMNIK", "{FFFFFF}Spremnik vaseg motora.\n\nDa uzmete nesto iz spremnika pritisnite {FFD000}'Uzimanje'.\n{FFFFFF}Da ostavite nesto u spremnik pritisnite {FFD000}'Ostavljanje'.", "Uzmimanje", "Ostavljanje");    
            }
            case 3:
            {
            	  Dialog_Show(playerid, Bike_Prodaja_Igracu, DSI, "{FFD000}BIKE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg motora/bicikla igracu.\n\nDa ponudite motor/biciklo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete motor/biciklo i cijenu za taj motor/biciklo.\n{FFFFFF}Slotovi se krecu od (0-3).", "Ponudi", "Izlaz");
            }
            case 4:
            {
            	  static Float:Pos[4];

        		  if(!IsPlayerInVehicle(playerid, BIKE_Enum[i][B_VEHICLE_ID])) 
        		    return GRESKA(playerid,"Morate biti u svom motoru!!!");
        		  if(IsPlayerInArea(playerid, 2051.388183, -1881.555664, 2087.391357, -1860.702636))
			        return GRESKA(playerid,"Ne mozete parkirati blizu moto salona.");
			      if(IsPlayerInArea(playerid, 1356.934448, -1753.421875, 1393.539916, -1736.147094))
        		    return GRESKA(playerid,"Ne mozete parkirati blizu autosalona!");   

        		  GetVehiclePos(BIKE_Enum[i][B_VEHICLE_ID], Pos[0], Pos[1], Pos[2]);
        		  GetVehicleZAngle(BIKE_Enum[i][B_VEHICLE_ID], Pos[3]);

        		  BIKE_Enum[i][BIKE_POS][0] = Pos[0];
        		  BIKE_Enum[i][BIKE_POS][1] = Pos[1];
        		  BIKE_Enum[i][BIKE_POS][2] = Pos[2];
        		  BIKE_Enum[i][BIKE_POS][3] = Pos[3];

        		  DestroyVehicle(BIKE_Enum[i][B_VEHICLE_ID]);
        		  BIKE_Enum[i][B_VEHICLE_ID] = AddStaticVehicleEx(BIKE_Enum[i][BIKE_MODEL], BIKE_Enum[i][BIKE_POS][0],BIKE_Enum[i][BIKE_POS][1],BIKE_Enum[i][BIKE_POS][2],BIKE_Enum[i][BIKE_POS][3], BIKE_Enum[i][BIKE_COLORS][0], BIKE_Enum[i][BIKE_COLORS][1], 30000);

        		  Save_Bike(i);

        		  INFO(playerid,"Uspesno ste preparkirali (%s).",ReturnVehicleModelName(BIKE_Enum[i][BIKE_MODEL]));
            }
            case 5:
            {
            	  GetVehiclePos(BIKE_Enum[i][B_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);

            	  SetPlayerCheckpoint(playerid, vPos[0], vPos[1], vPos[2], 2.0);

                  INFO(playerid,"(%s) vam je oznacen na mapi!",ReturnVehicleModelName(BIKE_Enum[i][BIKE_MODEL]));
            }
        }	
	}
	return (true);
}


Dialog:Biciklo_Opcije(playerid, response, listitem, inputtext[])
{
	if(response)
	{
                new i = Selected_ID[playerid],Float:vPos[3];
				switch(listitem)
		        {
		        	case 0:
		        	{
		        		  GetVehiclePos(BIKE_Enum[i][B_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);

		                  if(!IsPlayerInRangeOfPoint(playerid, 2.0, vPos[0], vPos[1], vPos[2]))
		                    return GRESKA(playerid,"Niste blizu svog motora!");

		                  if(BIKE_Enum[i][BIKE_LOCKED] == 1)  {
		                  	BIKE_Enum[i][BIKE_LOCKED] = 0;
		                  	INFO(playerid,"Uspesno ste otkljucali svoje biciklo!");
		                  	SetVehicleParams(BIKE_Enum[i][B_VEHICLE_ID], VEHICLE_TYPE_DOORS, 0);
		                  }
		                  else if(BIKE_Enum[i][BIKE_LOCKED] == 0)  {
		                  	BIKE_Enum[i][BIKE_LOCKED] = 1;
		                  	INFO(playerid,"Uspesno ste zakljucali svoje biciklo!");
		                  	SetVehicleParams(BIKE_Enum[i][B_VEHICLE_ID], VEHICLE_TYPE_DOORS, 0);
		                  }	
		        	}
		        	case 1:
		        	{
                          Dialog_Show(playerid, Bike_Prodaja_Igracu, DSI, "{FFD000}BIKE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg motora/bicikla igracu.\n\nDa ponudite motor/biciklo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete motor/biciklo i cijenu za taj motor/biciklo.\n{FFFFFF}Slotovi se krecu od (0-3).", "Ponudi", "Izlaz");  
		        	}
		        	case 2:
		        	{
		        		      static Float:Pos[4];

			        		  if(!IsPlayerInVehicle(playerid, BIKE_Enum[i][B_VEHICLE_ID])) 
			        		    return GRESKA(playerid,"Morate biti na svom biciklu!!!");
			        		  if(IsPlayerInArea(playerid, 2051.388183, -1881.555664, 2087.391357, -1860.702636))
			        		    return GRESKA(playerid,"Ne mozete parkirati blizu moto salona.");  

			        		  GetVehiclePos(BIKE_Enum[i][B_VEHICLE_ID], Pos[0], Pos[1], Pos[2]);
			        		  GetVehicleZAngle(BIKE_Enum[i][B_VEHICLE_ID], Pos[3]);

			        		  BIKE_Enum[i][BIKE_POS][0] = Pos[0];
			        		  BIKE_Enum[i][BIKE_POS][1] = Pos[1];
			        		  BIKE_Enum[i][BIKE_POS][2] = Pos[2];
			        		  BIKE_Enum[i][BIKE_POS][3] = Pos[3];

			        		  DestroyVehicle(BIKE_Enum[i][B_VEHICLE_ID]);
			        		  BIKE_Enum[i][B_VEHICLE_ID] = AddStaticVehicleEx(BIKE_Enum[i][BIKE_MODEL], BIKE_Enum[i][BIKE_POS][0],BIKE_Enum[i][BIKE_POS][1],BIKE_Enum[i][BIKE_POS][2],BIKE_Enum[i][BIKE_POS][3], BIKE_Enum[i][BIKE_COLORS][0], BIKE_Enum[i][BIKE_COLORS][1], 30000);

			        		  Save_Bike(i);

			        		  INFO(playerid,"Uspesno ste preparkirali (%s).",ReturnVehicleModelName(BIKE_Enum[i][BIKE_MODEL]));
		        	}
		        	case 3:
		        	{
		        		      GetVehiclePos(BIKE_Enum[i][B_VEHICLE_ID], vPos[0], vPos[1], vPos[2]);

			            	  SetPlayerCheckpoint(playerid, vPos[0], vPos[1], vPos[2], 2.0);

			                  INFO(playerid,"(%s) vam je oznacen na mapi!",ReturnVehicleModelName(BIKE_Enum[i][BIKE_MODEL]));
		        	}

		        }
	}
	return (true);
}

//=======================================================================================

Dialog:Bike_Prodaja_Igracu(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           new idigraca,slot,cijena,Float:Pos[3];
           if(sscanf(inputtext, "udd", idigraca,slot,cijena))
              return Dialog_Show(playerid, Bike_Prodaja_Igracu, DSI, "{FFD000}BIKE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg motora/bicikla igracu.\n\nDa ponudite motor/biciklo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete motor/biciklo i cijenu za taj motor/biciklo.\n{FFFFFF}Slotovi se krecu od (0-3).", "Ponudi", "Izlaz");
           if(slot < 0 || slot > 3)
              return Dialog_Show(playerid, Bike_Prodaja_Igracu, DSI, "{FFD000}BIKE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg motora/bicikla igracu.\n\nDa ponudite motor/biciklo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete motor/biciklo i cijenu za taj motor/biciklo.\n{FFFFFF}Slotovi se krecu od (0-3).", "Ponudi", "Izlaz");
           if(idigraca == INVALID_PLAYER_ID)
             return GRESKA(playerid,"ID koji ste unijeli nije konektovan na server.");
           if(idigraca == playerid)
             return (true);
           if(cijena < 1)
             return  Dialog_Show(playerid, Bike_Prodaja_Igracu, DSI, "{FFD000}BIKE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vaseg motora/bicikla igracu.\n\nDa ponudite motor/biciklo {FFD000}'Igracu' {FFFFFF}unesite njegov ID, slot sa kojeg prodajete motor/biciklo i cijenu za taj motor/biciklo.\n{FFFFFF}Slotovi se krecu od (0-3).", "Ponudi", "Izlaz");

           GetPlayerPos(idigraca, Pos[0], Pos[1], Pos[2]);

           if(!IsPlayerInRangeOfPoint(playerid, 2.0, Pos[0], Pos[1], Pos[2]))
           	  return GRESKA(playerid,"Niste blizu igraca kojem prodajete!");

           if(Player_Enum[playerid][p_Bikes][slot] == 9999)
             return GRESKA(playerid,"Slot sa kojeg prodajete motor/biciklo je prazan!");

           Nudi_Bike_Slot[idigraca][0] = Player_Enum[playerid][p_Bikes][slot];
           Nudi_Bike_Slot[idigraca][1] = cijena;
           Nudi_Bike_Slot[idigraca][2] = playerid;
           Nudi_Bike_Slot[idigraca][3] = slot;

           INFO(playerid,"Ponudli ste: (%s) sa slota %d igracu: %s",ReturnVehicleModelName(BIKE_Enum[Player_Enum[playerid][p_Bikes][slot]][BIKE_MODEL]),slot,GetName(idigraca));
           Dialog_Show(idigraca, Bike_Prodaja_Response, DSM, "{1B8F07}VOZILO {FFFFFF}- PONUDA", "{FFFFFF}Ponudeno vam je vozilo od {1B8F07}(%s).\n\n{FFFFFF}Ime Vozila: {1B8F07}(%s)\n{FFFFFF}Cijena vozila {1B8F07}($%d).", "Prihvati", "Odustani",GetName(playerid),ReturnVehicleModelName(BIKE_Enum[Player_Enum[playerid][p_Bikes][slot]][BIKE_MODEL]),cijena);          
	}
	return (true);
}

Dialog:Bike_Prodaja_Response(playerid, response, listitem, inputtext[])
{
	new slot = Nudi_Bike_Slot[playerid][0],
	    cijena = Nudi_Bike_Slot[playerid][1],
	    prodavaoc = Nudi_Bike_Slot[playerid][2],
	    slott = Nudi_Bike_Slot[playerid][3];

	if(response)
	{
		if(Player_Enum[playerid][p_Money] < cijena)
		   return GRESKA(playerid,"Nemate dovoljno novca za kupovinu ponudeno vozila!");

		Player_Enum[prodavaoc][p_Bikes][slott] = 9999;   

		BIKE_Enum[slot][BIKE_OWNER] = '\0';
		SetString(BIKE_Enum[slot][BIKE_OWNER],GetName(playerid));

		if(Player_Enum[playerid][p_Bikes][0] == 9999) Player_Enum[playerid][p_Bikes][0] = slot;
		else if(Player_Enum[playerid][p_Bikes][1] == 9999) Player_Enum[playerid][p_Bikes][1] = slot;
		else if(Player_Enum[playerid][p_Bikes][2] == 9999) Player_Enum[playerid][p_Bikes][2] = slot;
		else if(Player_Enum[playerid][p_Bikes][3] == 9999) Player_Enum[playerid][p_Bikes][3] = slot;
		else return GRESKA(playerid,"Nemate slobodnih slotova!");

		Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena); // Onaj ko kupuje.
		Player_Enum[prodavaoc][p_Money] += cijena; GivePlayerMoney(prodavaoc,cijena); // Onaj ko prodaje.

		INFO(playerid,"Uspesno ste kupili (%s) od: %s za: $%d.",ReturnVehicleModelName(BIKE_Enum[slot][BIKE_MODEL]),GetName(prodavaoc),cijena);
		INFO(prodavaoc,"Uspesno ste prodali (%s) igracu: %s za: $%d.",ReturnVehicleModelName(BIKE_Enum[slot][BIKE_MODEL]),GetName(playerid),cijena);

		Nudi_Bike_Slot[playerid][0] = -1;
        Nudi_Bike_Slot[playerid][1] = -1;
        Nudi_Bike_Slot[playerid][2] = -1;
        Nudi_Bike_Slot[playerid][3] = -1;

		SavePlayer(playerid); SavePlayer(prodavaoc); 
		Save_Bike(slot);    
	}
	else
	{
        INFO(playerid,"Prekinuli ste ponudu za ponudeno vozilo!");
        INFO(prodavaoc,"%s je prekinuo vasu ponudu za: (%s).",GetName(playerid),ReturnVehicleModelName(COS_Enum[slot][C_MODEL]));

		Nudi_Bike_Slot[playerid][0] = -1;
        Nudi_Bike_Slot[playerid][1] = -1;
        Nudi_Bike_Slot[playerid][2] = -1;
        Nudi_Bike_Slot[playerid][3] = -1;
	}
	return (true);	   
}

//=======================================================================================

Dialog:Bike_Spremnik(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         Dialog_Show(playerid, Bike_Spremnik_Uzimanje, DSL, "{FFD000}SPREMNIK {FFFFFF}- UZIMANJE", "Novac\nOruzije\nMaterijali\nDroga", "Odaberi", "Izlaz");  
	}
	else
	{
         Dialog_Show(playerid, Bike_Spremnik_Ost, DSL, "{FFD000}SPREMNIK {FFFFFF}- OSTAVLJANJE", "Novac\nOruzije\nMaterijali\nDroga", "Odaberi", "Izlaz");
	}
	return (true);
}

//===============================================================================================

Dialog:Bike_Spremnik_Uzimanje(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new i = Selected_ID[playerid];
		switch(listitem)
        {
        	case 0:
        	{
        		Dialog_Show(playerid, Bike_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Uzimanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite uzeti iz svog motora.", "Uzmi", "Odustani");  
        	}
        	case 1:
        	{
        		if(BIKE_Enum[i][BIKE_STORAGE][BIKE_WEAPON] == 0)
        		   return GRESKA(playerid,"U spremniku nemate oruzije!");

        		INFO(playerid,"Uspesno ste uzeli (%s) iz svog spremnika.",ReturnWeaponName(BIKE_Enum[i][BIKE_STORAGE][BIKE_WEAPON]));   

        		BIKE_Enum[i][BIKE_STORAGE][BIKE_WEAPON] = 0; BIKE_Enum[i][BIKE_STORAGE][BIKE_AMMO] = 0;   

                GiveWeaponToPlayer(playerid, BIKE_Enum[i][BIKE_STORAGE][BIKE_WEAPON], BIKE_Enum[i][BIKE_STORAGE][BIKE_AMMO]);

                Save_Bike(i);
        	}
        }
    }
    return (true);
}

Dialog:Bike_Uzimanje_Novac(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new kolicina;
		if(sscanf(inputtext, "d", kolicina))
		   return Dialog_Show(playerid, Bike_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Uzimanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite uzeti iz svog motora.", "Uzmi", "Odustani");

		if(kolicina < 1)
		   return Dialog_Show(playerid, Bike_Uzimanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Uzimanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite uzeti iz svog motora.", "Uzmi", "Odustani");

		if(BIKE_Enum[Selected_ID[playerid]][BIKE_STORAGE][BIKE_MONEY] == 0)
           return GRESKA(playerid,"Nemate novca u spremniku!");

        if(BIKE_Enum[Selected_ID[playerid]][BIKE_STORAGE][BIKE_MONEY] < kolicina)
           return GRESKA(playerid,"Nemate toliko u spremniku ($%d)",BIKE_Enum[Selected_ID[playerid]][BIKE_STORAGE][BIKE_MONEY]);

        BIKE_Enum[Selected_ID[playerid]][BIKE_STORAGE][BIKE_MONEY] -= kolicina;

        Player_Enum[playerid][p_Money] += kolicina;   
        GivePlayerMoney(playerid,kolicina);

        INFO(playerid,"Uspesno ste uzeli ($%d) iz svog spremnika.",kolicina);

        Save_Bike(Selected_ID[playerid]);
	}
	return (true);
}

//===========================================================================================

Dialog:Bike_Spremnik_Ost(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new i = Selected_ID[playerid];
		switch(listitem)
        {
        	case 0:
        	{
        		Dialog_Show(playerid, Bike_Ostavljanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Ostavljanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite ostaviti u svoj motor.", "Ostavi", "Odustani");
        	}
        	case 1:
        	{
        	    if(BIKE_Enum[i][BIKE_STORAGE][BIKE_WEAPON] != 0)
        		   return GRESKA(playerid,"U spremniku vec imate oruzije!");

        		if(GetPlayerWeapon(playerid) == 0)
        		   return GRESKA(playerid,"Morate imati oruzije u ruci!");   

        		INFO(playerid,"Uspesno ste ostavili: (%s) u svoj spremnik.",ReturnWeaponName(GetPlayerWeapon(playerid)));   

        		BIKE_Enum[i][BIKE_STORAGE][BIKE_WEAPON] = GetPlayerWeapon(playerid); BIKE_Enum[i][BIKE_STORAGE][BIKE_AMMO] = GetPlayerAmmo(playerid);   

                ResetWeapon(playerid,GetWeapon(playerid));

                Save_Bike(i);
        	}
        }
	}
	return (true);
}

Dialog:Bike_Ostavljanje_Novac(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new kolicina;
        if(sscanf(inputtext, "d", kolicina))
           return Dialog_Show(playerid, Bike_Ostavljanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Ostavljanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite ostaviti u svoj motor.", "Ostavi", "Odustani");
        
        if(kolicina < 1)
           return Dialog_Show(playerid, Bike_Ostavljanje_Novac, DSI, "{FFD000}SPREMNIK {FFFFFF}- NOVAC", "{FFFFFF}Ostavljanje novca.\n\nUpisite kolicinu 'NOVCA' koju zelite ostaviti u svoj motor.", "Ostavi", "Odustani");
  
        if(kolicina >Player_Enum[playerid][p_Money] )
            return GRESKA(playerid,"Nemate toliko novca kod sebe!");

        BIKE_Enum[Selected_ID[playerid]][BIKE_STORAGE][BIKE_MONEY] += kolicina;

        Player_Enum[playerid][p_Money] -= kolicina;
        GivePlayerMoney(playerid,-kolicina);

        INFO(playerid,"Uspesno ste ostavili $%d u spremnik svog motora!",kolicina);

        Save_Bike(Selected_ID[playerid]);
           
	}
	return (true);
}

//================================================================================================