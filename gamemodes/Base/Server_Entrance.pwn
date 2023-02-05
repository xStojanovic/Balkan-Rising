
#include <YSI\y_hooks>

//=========================================
/*
           Dynamic Enterence
                0.0.1x
*/
//=========================================

#define MAX_ENTRANCES (200)

//=========================================

new LoadedEntrances = 0;

new Player_EntranceID[MAX_PLAYERS] = {-1, ...};

//=========================================

enum E_DATA{
	 E_ID,
	 E_NAME[32],
	 E_ICON,
	 E_TYPE,
	 E_CREATED,
	 E_LOCKED,
	 Float:E_EXT_POS[4],
	 Float:E_INT_POS[4],
	 E_INT_ID,
	 E_EXT_ID,
	 E_INTERIOR_ID,
	 E_VIRTUALWORLD_ID,
	 E_PICKUP,
	 E_MAPICON,
	 Text3D:E_LABEL
};
new Entrance_Enum[MAX_ENTRANCES][E_DATA];

//========================================

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ((newkeys & KEY_SECONDARY_ATTACK))
	{
		static id = -1;

		if ((id = Nearest_Entrance(playerid)) != -1)
	    {
	    	if(Entrance_Enum[id][E_LOCKED] == 1)
	    	   return GRESKA(playerid,"Ulaz u ovaj objekat je trenutno zakljucan.");

	    	SetPlayerPos(playerid, Entrance_Enum[id][E_INT_POS][0], Entrance_Enum[id][E_INT_POS][1], Entrance_Enum[id][E_INT_POS][2]);
			SetPlayerFacingAngle(playerid, Entrance_Enum[id][E_INT_POS][3]);
			SetPlayerInterior(playerid, Entrance_Enum[id][E_INTERIOR_ID]);
			SetPlayerVirtualWorld(playerid, Entrance_Enum[id][E_VIRTUALWORLD_ID]);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);

			Player_EntranceID[playerid] = Entrance_Enum[id][E_ID];
			return (true);   
	    }
	    else if ((id = Inside_Entrance(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 3.2, Entrance_Enum[id][E_INT_POS][0], Entrance_Enum[id][E_INT_POS][1], Entrance_Enum[id][E_INT_POS][2]))
	    {
	    	SetPlayerPos(playerid, Entrance_Enum[id][E_EXT_POS][0], Entrance_Enum[id][E_EXT_POS][1], Entrance_Enum[id][E_EXT_POS][2]);
	    	SetPlayerFacingAngle(playerid, Entrance_Enum[id][E_EXT_POS][3] - 180.0);
	    	SetPlayerInterior(playerid, Entrance_Enum[id][E_INT_ID]);
			SetPlayerVirtualWorld(playerid, Entrance_Enum[id][E_EXT_ID]);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);

			Player_EntranceID[playerid] = 0;
			return (true);
	    }

	}
	return (true);
}

//========================================

YCMD:makeentrance(playerid,params[],help)
{

	static ime[30],Float:x,Float:y,Float:z,interiorid;

	if(Player_Enum[playerid][p_Admin] < 5)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");   
	if(sscanf(params, "s[30]fffd",ime,x,y,z,interiorid))
	   return USAGE(playerid,"/makeentrance [Ime Ulaza/Izlaza] [Int x] [Int y] [Int z] [Interior ID]");

	new id = Insert_Entrance(playerid,ime,x,y,z,interiorid);

	if(id == -1)
	   return GRESKA(playerid,"Skripta je dosla u limitirano stanje kreiranja Ulaza/Izlaza!");

	INFO(playerid,"Uspjesno ste napravili Ulaz/Izlaz: (%s)",ime);      
	return (true);
}

YCMD:editentrance(playerid,params[],help)
{
	static id,type[24],string[128];

	if(Player_Enum[playerid][p_Admin] < 5)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");   
	if(sscanf(params, "ds[24]S()[128]", id, type, string))
	{
       USAGE(playerid,"/editentrance [ID] [odabir]");
       INFO(playerid,"DOSTUPNO: (lokacija,ime,lock,mapicon,tip,interior)"); // uraditi jos tip posle.
       return (true);
	}
    if((id < 0 || id >= MAX_ENTRANCES) || !Entrance_Enum[id][E_CREATED])
	   return GRESKA(playerid,"Uneseni ID nije validan/registrovan.");

	if (!strcmp(type, "lokacija", true))
	{
		GetPlayerPos(playerid,Entrance_Enum[id][E_EXT_POS][0], Entrance_Enum[id][E_EXT_POS][1], Entrance_Enum[id][E_EXT_POS][2]);
		GetPlayerFacingAngle(playerid, Entrance_Enum[id][E_EXT_POS][3]);

		Entrance_Enum[id][E_INT_ID] = GetPlayerInterior(playerid);
		Entrance_Enum[id][E_EXT_ID] = GetPlayerVirtualWorld(playerid);

		Entrance_Refresh(id); Save_Entrance(id);

		INFO(playerid,"Uspjesno ste premestili lokaciju (%s).",Entrance_Enum[id][E_NAME]);
	}
	else if (!strcmp(type, "ime", true))
	{
		static name[32];

		if(sscanf(string, "s[32]", name))
		  return USAGE(playerid,"/editentrance [ID] [name] [Novo ime]");

		format(Entrance_Enum[id][E_NAME], (32), name);
		
		Entrance_Refresh(id); Save_Entrance(id);

		INFO(playerid,"Uspesno ste promenili ime ovog ulaza/izlaza u (%s)",name);  
	}
	else if (!strcmp(type, "lock", true))
	{
		static locked;

		if(sscanf(string, "d", locked))
		  return USAGE(playerid,"/editentrance [ID] [lock] [0-Otkljucano || 1-Zakljucano]");

        Entrance_Enum[id][E_LOCKED] = locked; 
        Save_Entrance(id);

		if(locked == 0)
            INFO(playerid,"Uspesno ste otkljucali ovaj objekat.");
        else
            INFO(playerid,"Uspesno ste zakljucali ovaj objekat.");    
	}
	else if (!strcmp(type, "mapicon", true))
	{
		static icon;

		if(sscanf(string, "d", icon))
		   return USAGE(playerid,"editentrance [ID] [mapicon] [ID]");
		if(icon < 0 || icon > 63)
		   return USAGE(playerid,"Nepoznat ID!");

		Entrance_Enum[id][E_ICON] = icon;
		Entrance_Refresh(id); Save_Entrance(id);

		INFO(playerid,"Uspesno ste promenili/postavili mapiconu ovom objektu!");      
	} 
	else if (!strcmp(type, "interior", true))
	{
		GetPlayerPos(playerid,Entrance_Enum[id][E_INT_POS][0], Entrance_Enum[id][E_INT_POS][1], Entrance_Enum[id][E_INT_POS][2]);
		GetPlayerFacingAngle(playerid, Entrance_Enum[id][E_INT_POS][3]);

		Entrance_Enum[id][E_INTERIOR_ID] = GetPlayerInterior(playerid);

		foreach (new i : Player)
		{
			if (Player_EntranceID[i] == Entrance_Enum[id][E_ID])
			{
				SetPlayerPos(i, Entrance_Enum[id][E_INT_POS][0], Entrance_Enum[id][E_INT_POS][1], Entrance_Enum[id][E_INT_POS][2]);
				SetPlayerFacingAngle(i, Entrance_Enum[id][E_INT_POS][3]);

				SetPlayerInterior(i, Entrance_Enum[id][E_INTERIOR_ID]);
				SetCameraBehindPlayer(i);
			}
		}
		Save_Entrance(id);
		INFO(playerid,"Uspesno ste promenili interijer ovog objekta!");
	}    
	return (true);
}

YCMD:deleteentrance(playerid,params[],help)
{
	static id,string[200];

	if(Player_Enum[playerid][p_Admin] < 5)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");   
	if(sscanf(params, "d", id))
	   return USAGE(playerid,"/deleteentrance [Entrance ID]");
	if((id < 0 || id >= MAX_ENTRANCES) || !Entrance_Enum[id][E_CREATED])
	   return GRESKA(playerid,"Uneseni ID nije validan/registrovan."); 

	format(string, sizeof(string), "DELETE FROM `br_entrance` WHERE `E_ID` = %d",id);
    mysql_function_query(_dbConnector, string, true, "Delete_Entrance", "i",Entrance_Enum[id][E_ID]);

    INFO(playerid,"Uspjesno ste obrisali entrance ID: (%d)",id);         
	return (true);
}

//========================================

stock Insert_Entrance(playerid,lokacija[],Float:intX,Float:intY,Float:intZ,interior)
{
	static Float:x,Float:y,Float:z,Float:angle,query[128];
	GetPlayerPos(playerid, x, y, z); GetPlayerFacingAngle(playerid, angle);

    LoadedEntrances += 1;

	for (new i = 0; i != MAX_ENTRANCES; i ++)
	{
	        if (!Entrance_Enum[i][E_CREATED])
		    {
		    	Entrance_Enum[i][E_ID] = LoadedEntrances;
		    	Entrance_Enum[i][E_CREATED] = 1;
		    	Entrance_Enum[i][E_ICON] = 0;
		    	Entrance_Enum[i][E_LOCKED] = 0;

		    	Entrance_Enum[i][E_EXT_POS][0] = x;
		    	Entrance_Enum[i][E_EXT_POS][1] = y;
		    	Entrance_Enum[i][E_EXT_POS][2] = z;
		    	Entrance_Enum[i][E_EXT_POS][3] = angle;

		    	Entrance_Enum[i][E_INT_POS][0] = intX;
		    	Entrance_Enum[i][E_INT_POS][1] = intY;
		    	Entrance_Enum[i][E_INT_POS][2] = intZ;
		    	Entrance_Enum[i][E_INT_POS][3] = 0.0;

		    	Entrance_Enum[i][E_INT_ID] = GetPlayerInterior(playerid);
		    	Entrance_Enum[i][E_EXT_ID] = GetPlayerVirtualWorld(playerid);
		    	Entrance_Enum[i][E_INTERIOR_ID] = interior;
		    	Entrance_Enum[i][E_VIRTUALWORLD_ID] = LoadedEntrances; 

		    	format(Entrance_Enum[i][E_NAME], (32), lokacija);

                format(query, sizeof(query), "INSERT INTO `br_entrance` (`E_NAME`,`E_ID`) VALUES('%s', %d)",Entrance_Enum[i][E_NAME],LoadedEntrances);
                mysql_function_query(_dbConnector, query, false, "", "");
 
		    	Entrance_Refresh(i); Save_Entrance(i);
		    	return (i);
		    }
	}
	return (-1);
}

//===========================================

stock Entrance_Refresh(ID)
{
	static string[200];

	if (ID != -1 && Entrance_Enum[ID][E_CREATED])
	{
		if (IsValidDynamic3DTextLabel(Entrance_Enum[ID][E_LABEL]))
		    DestroyDynamic3DTextLabel(Entrance_Enum[ID][E_LABEL]);

		if (IsValidDynamicPickup(Entrance_Enum[ID][E_PICKUP]))
		    DestroyDynamicPickup(Entrance_Enum[ID][E_PICKUP]);

		if (IsValidDynamicMapIcon(Entrance_Enum[ID][E_MAPICON]))
		    DestroyDynamicMapIcon(Entrance_Enum[ID][E_MAPICON]);

        format(string,sizeof(string),"{A7D93B}%s\nKako bi ste usli u ovaj objekat pritisnite {FFFFFF}'F/Enter'",Entrance_Enum[ID][E_NAME]);
		Entrance_Enum[ID][E_LABEL] = CreateDynamic3DTextLabel(string, 0xFAEBD7FF, Entrance_Enum[ID][E_EXT_POS][0], Entrance_Enum[ID][E_EXT_POS][1], Entrance_Enum[ID][E_EXT_POS][2], 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Entrance_Enum[ID][E_EXT_ID], Entrance_Enum[ID][E_INT_ID]); 
		Entrance_Enum[ID][E_PICKUP] = CreateDynamicPickup(1559, 23, Entrance_Enum[ID][E_EXT_POS][0], Entrance_Enum[ID][E_EXT_POS][1], Entrance_Enum[ID][E_EXT_POS][2] + 0.7, Entrance_Enum[ID][E_EXT_ID], Entrance_Enum[ID][E_INT_ID]);
		if(Entrance_Enum[ID][E_ICON] != 0)
		Entrance_Enum[ID][E_MAPICON] = CreateDynamicMapIcon(Entrance_Enum[ID][E_EXT_POS][0], Entrance_Enum[ID][E_EXT_POS][1], Entrance_Enum[ID][E_EXT_POS][2], Entrance_Enum[ID][E_ICON], 0, Entrance_Enum[ID][E_EXT_ID], Entrance_Enum[ID][E_INT_ID]);   
	}
	return (true);
}

//============================================

stock Save_Entrance(ID)
{
	static query[1000];

	format(query,sizeof(query),"UPDATE `br_entrance` SET `E_NAME` = '%s', `E_ICON` = '%d', `E_TYPE` = '%d', `E_CREATED` = '%d', `E_LOCKED` = '%d', `E_INT_ID` = '%d', `E_EXT_ID` = '%d', `E_INTERIOR_ID` = '%d', `E_VIRTUALWORLD_ID` = '%d'",
	Escape_String(Entrance_Enum[ID][E_NAME]),Entrance_Enum[ID][E_ICON],Entrance_Enum[ID][E_TYPE],Entrance_Enum[ID][E_CREATED],Entrance_Enum[ID][E_LOCKED],Entrance_Enum[ID][E_INT_ID],Entrance_Enum[ID][E_EXT_ID],Entrance_Enum[ID][E_INTERIOR_ID],Entrance_Enum[ID][E_VIRTUALWORLD_ID]);
	format(query,sizeof(query),"%s, `E_EXT_POS1` = '%.4f', `E_EXT_POS2` = '%.4f', `E_EXT_POS3` = '%.4f', `E_EXT_POS4` = '%.4f', `E_INT_POS1` = '%.4f', `E_INT_POS2` = '%.4f', `E_INT_POS3` = '%.4f', `E_INT_POS4` = '%.4f' WHERE `E_ID` = '%d'",
	query,Entrance_Enum[ID][E_EXT_POS][0],Entrance_Enum[ID][E_EXT_POS][1],Entrance_Enum[ID][E_EXT_POS][2],Entrance_Enum[ID][E_EXT_POS][3],Entrance_Enum[ID][E_INT_POS][0],Entrance_Enum[ID][E_INT_POS][1],Entrance_Enum[ID][E_INT_POS][2],Entrance_Enum[ID][E_INT_POS][3],Entrance_Enum[ID][E_ID]);
	return mysql_function_query(_dbConnector, query, false, "", "");
}

function Delete_Entrance(ID)
{
	if (ID != -1 && Entrance_Enum[ID][E_CREATED])
	{
		if (IsValidDynamic3DTextLabel(Entrance_Enum[ID][E_LABEL]))
		    DestroyDynamic3DTextLabel(Entrance_Enum[ID][E_LABEL]);

		if (IsValidDynamicPickup(Entrance_Enum[ID][E_PICKUP]))
		    DestroyDynamicPickup(Entrance_Enum[ID][E_PICKUP]);

		if (IsValidDynamicMapIcon(Entrance_Enum[ID][E_MAPICON]))
		    DestroyDynamicMapIcon(Entrance_Enum[ID][E_MAPICON]);

		Entrance_Enum[ID][E_CREATED] = 0;
		Entrance_Enum[ID][E_ID] = -1;    
	}
	return (true);
} 

//=============================================

function Load_Entrance()
{
	static rows,fields,var_load[20];
	cache_get_data(rows, fields, _dbConnector);

	for (new i = 0; i < rows; i ++) if (i < MAX_ENTRANCES)
	{
		Entrance_Enum[i][E_CREATED] = (1);

		cache_get_field_content(i, "E_NAME", Entrance_Enum[i][E_NAME], _dbConnector);
		cache_get_field_content(0, "E_ID", var_load); Entrance_Enum[i][E_ID] = strval(var_load);
		cache_get_field_content(0, "E_ICON", var_load); Entrance_Enum[i][E_ICON] = strval(var_load);
		cache_get_field_content(0, "E_TYPE", var_load); Entrance_Enum[i][E_TYPE] = strval(var_load);
		cache_get_field_content(0, "E_LOCKED", var_load); Entrance_Enum[i][E_LOCKED] = strval(var_load);
		cache_get_field_content(0, "E_INT_ID", var_load); Entrance_Enum[i][E_INT_ID] = strval(var_load);
		cache_get_field_content(0, "E_EXT_ID", var_load); Entrance_Enum[i][E_EXT_ID] = strval(var_load);
		cache_get_field_content(0, "E_INTERIOR_ID", var_load); Entrance_Enum[i][E_INTERIOR_ID] = strval(var_load);
		cache_get_field_content(0, "E_VIRTUALWORLD_ID", var_load); Entrance_Enum[i][E_VIRTUALWORLD_ID] = strval(var_load);
		cache_get_field_content(0, "E_EXT_POS1", var_load); Entrance_Enum[i][E_EXT_POS][0] = floatstr(var_load);
		cache_get_field_content(0, "E_EXT_POS2", var_load); Entrance_Enum[i][E_EXT_POS][1] = floatstr(var_load);
		cache_get_field_content(0, "E_EXT_POS3", var_load); Entrance_Enum[i][E_EXT_POS][2] = floatstr(var_load);
		cache_get_field_content(0, "E_EXT_POS4", var_load); Entrance_Enum[i][E_EXT_POS][3] = floatstr(var_load);
		cache_get_field_content(0, "E_INT_POS1", var_load); Entrance_Enum[i][E_INT_POS][0] = floatstr(var_load);
		cache_get_field_content(0, "E_INT_POS2", var_load); Entrance_Enum[i][E_INT_POS][1] = floatstr(var_load);
		cache_get_field_content(0, "E_INT_POS3", var_load); Entrance_Enum[i][E_INT_POS][2] = floatstr(var_load);
		cache_get_field_content(0, "E_INT_POS4", var_load); Entrance_Enum[i][E_INT_POS][3] = floatstr(var_load);

		printf("(Entrance Load): ID: %d uspesno ucitan.",i);
		Entrance_Refresh(i);

		LoadedEntrances = rows;
	}
	return (true);
}

//=============================================================================

stock Nearest_Entrance(playerid)
{
	for (new i = 0; i != MAX_ENTRANCES; i ++) if (Entrance_Enum[i][E_CREATED] && IsPlayerInRangeOfPoint(playerid, 2.5, Entrance_Enum[i][E_EXT_POS][0], Entrance_Enum[i][E_EXT_POS][1], Entrance_Enum[i][E_EXT_POS][2]))
	{
		if (GetPlayerInterior(playerid) == Entrance_Enum[i][E_INT_ID] && GetPlayerVirtualWorld(playerid) == Entrance_Enum[i][E_EXT_ID])
			return (i);
	}
	return (-1);
}

stock Inside_Entrance(playerid)
{
	if(Player_EntranceID[playerid] != (-1))
	{
		for (new i = 0; i != MAX_ENTRANCES; i ++) if (Entrance_Enum[i][E_CREATED] && Entrance_Enum[i][E_ID] == Player_EntranceID[playerid] && GetPlayerInterior(playerid) == Entrance_Enum[i][E_INTERIOR_ID] && GetPlayerVirtualWorld(playerid) == Entrance_Enum[i][E_VIRTUALWORLD_ID])
	        return (i);
	}
	return (-1);
}

//==============================================================================
