#include <YSI\y_hooks>

//================================================
/*
                 Balkan Rising
                   0.0.1x
                Server Speedo
*/
//================================================

new Brzina_Level[MAX_PLAYERS] = 0,
    Paljenje_Time[MAX_PLAYERS] = 0,
	Float:g_fSpeedCap[MAX_PLAYERS] = { 0.0, ... };	

//================================================

hook OnPlayerStateChange(playerid, newstate, oldstate){

	new date_string[64],br_string[10];
	static date[36];

	getdate(date[2], date[1], date[0]);

	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(!IsABiciklo(GetPlayerVehicleID(playerid)))
		{
			Speedo_TDs(playerid,1); // pokazuje Speedo.
			format(date_string,sizeof(date_string),"%02d/%02d/%d",date[0], date[1], date[2]);
			PlayerTextDrawSetString(playerid, Speedo_TD[13][playerid], date_string);

			format(br_string,sizeof(br_string),"~r~%d",Brzina_Level[playerid]);
			PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], br_string);
		}	


	}
	else
	{
		Speedo_TDs(playerid,2); // sakriva Speedo.
	}
	return (true);
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
	if(!IsABiciklo(vehicleid))
	SetPlayerSpeedCap(playerid, 0.0000000001);
	else
	SetPlayerSpeedCap(playerid, 6.0); 
	return (true);
}

hook OnPlayerExitVehicle(playerid, vehicleid){
	Brzina_Level[playerid] = 0;
	return (true);
}

hook  OnPlayerKeyStateChange(playerid, newkeys, oldkeys){

    new vehicleid = GetPlayerVehicleID(playerid);

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABiciklo(vehicleid))
    {
		if(PRESSED(KEY_YES))
		{
	            if(Brzina_Level[playerid] == 0 && GetPlayerSpeed(playerid) == 0)
	            {
	            	Brzina_Level[playerid] = 1; SetPlayerSpeedCap(playerid, 0.1);
	            	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~1");
	            }
	            else if(Brzina_Level[playerid] == 1 && GetPlayerSpeed(playerid) >= 20)
	            {
	            	Brzina_Level[playerid] = 2; SetPlayerSpeedCap(playerid, 0.2);
	            	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~2");
	            }
	            else if(Brzina_Level[playerid] == 2 && GetPlayerSpeed(playerid) >= 40)
	            {
	            	Brzina_Level[playerid] = 3; SetPlayerSpeedCap(playerid, 0.3);
	            	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~3");
	            }
	            else if(Brzina_Level[playerid] == 3 && GetPlayerSpeed(playerid) >= 60)
	            {
	            	Brzina_Level[playerid] = 4; SetPlayerSpeedCap(playerid, 0.4);
	            	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~4");
	            }
	            else if(Brzina_Level[playerid] == 4 && GetPlayerSpeed(playerid) >= 80)
	            {
	            	Brzina_Level[playerid] = 5; SetPlayerSpeedCap(playerid, 0.5);
	            	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~5");
	            }
	            else if(Brzina_Level[playerid] == 5 && GetPlayerSpeed(playerid) >= 96)
	            {
	            	Brzina_Level[playerid] = 6; SetPlayerSpeedCap(playerid, 6.0);
	            	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~6");
	            }
		}
		else if(PRESSED(KEY_NO) && !IsABiciklo(vehicleid))
		{
			    if(Brzina_Level[playerid] == 1)
			    {
			    	SetVehicleParams(GetPlayerVehicleID(playerid), VEHICLE_TYPE_ENGINE, 0);
			    	Brzina_Level[playerid] = 0;
			    	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~r~0");
			    }
			    else if(Brzina_Level[playerid] == 2)
			    {
			    	Brzina_Level[playerid] = 1; SetPlayerSpeedCap(playerid, 0.1);
			    	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~1");
			    }
			    else if(Brzina_Level[playerid] == 3)
			    {
			    	Brzina_Level[playerid] = 2; SetPlayerSpeedCap(playerid, 0.2);
			    	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~2");
			    }
			    else if(Brzina_Level[playerid] == 4)
			    {
			    	Brzina_Level[playerid] = 3; SetPlayerSpeedCap(playerid, 0.3);
			    	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~3");
			    }
			    else if(Brzina_Level[playerid] == 5)
			    {
			    	Brzina_Level[playerid] = 4; SetPlayerSpeedCap(playerid, 0.4);
			    	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~4");
			    }
			    else if(Brzina_Level[playerid] == 6)
			    {
			    	Brzina_Level[playerid] = 5; SetPlayerSpeedCap(playerid, 0.5);
			    	PlayerTextDrawSetString(playerid, Speedo_TD[21][playerid], "~g~5");
			    }
		}
    }	
	return (true);
}

hook OnPlayerUpdate(playerid){

	static
		s_iVehicle
	;

	if ( g_fSpeedCap[ playerid ] != 0.0 && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
	{
		s_iVehicle = GetPlayerVehicleID( playerid );

		if ( s_iVehicle )
		{
			static
				Float:s_fX,
				Float:s_fY,
				Float:s_fZ,
				Float:s_fVX,
				Float:s_fVY,
				Float:s_fVZ
			;

			GetVehiclePos( s_iVehicle, s_fX, s_fY, s_fZ );
			GetVehicleVelocity( s_iVehicle, s_fVX, s_fVY, s_fVZ );

			if ( !IsPlayerInRangeOfPoint( playerid, g_fSpeedCap[ playerid ] + 0.05, s_fX + s_fVX, s_fY + s_fVY, s_fZ + s_fVZ ) )
			{
				static
					Float:s_fLength
				;

				s_fLength = floatsqroot( ( s_fVX * s_fVX ) + ( s_fVY * s_fVY ) + ( s_fVZ * s_fVZ ) );

				s_fVX = ( s_fVX / s_fLength ) * g_fSpeedCap[ playerid ];
				s_fVY = ( s_fVY / s_fLength ) * g_fSpeedCap[ playerid ];
				s_fVZ = ( s_fVZ / s_fLength ) * g_fSpeedCap[ playerid ];

				if ( s_iVehicle )
					SetVehicleVelocity( s_iVehicle, s_fVX, s_fVY, s_fVZ );
				else
					SetPlayerVelocity( playerid, s_fVX, s_fVY, s_fVZ );
			}
		}
	}
	return (true);
}

//=================================================

YCMD:engine(playerid,params[],help)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid),carid = INVALID_VEHICLE_ID,bikeid = INVALID_VEHICLE_ID,Float:health;
		if(!IsABiciklo(vehicleid))
		{
			    new bool: ownableVehicle = (false);
			    new bool: ownableBike = (false);

                if(Paljenje_Time[playerid] != 0 && (gettime() - Paljenje_Time[playerid]) < 5)
                   return GRESKA(playerid,"Ovu komandu mozete koristit svaki 5 sekundi!");

                carid = isCOSVehicle(vehicleid);
                bikeid = isBOSVehicle(vehicleid);
                
                if(carid != (-1)) ownableVehicle = (true);
                if(bikeid != (-1) && !IsABiciklo(vehicleid)) ownableBike = (true);

                GetVehicleHealth(vehicleid, health);

                if (!GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE))
                {
                	if(health < 300)
                		   return GRESKA(playerid,"Vozilo je previse osteceno!");

                	if(ownableVehicle == (true))
                	{
                		if(carid != (-1) && !isequal(GetName(playerid), COS_Enum[carid][C_OWNER]) && !Get_Player_Keys(playerid,carid))
                		   return GRESKA(playerid,"Nemate kljuceve ovog vozila!");
                	}
                	else if(ownableBike == (true))
                	{
                		if(bikeid != (-1) && !isequal(GetName(playerid), BIKE_Enum[bikeid][BIKE_OWNER]) && !Get_Player_Keys(playerid,bikeid))
                		   return GRESKA(playerid,"Nemate kljuceve ovog motora!");
                	}

                	SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, 1); Paljenje_Time[playerid] = gettime();

                	PlayerTextDrawSetString(playerid, Speedo_TD[9][playerid], "~g~!E");
                	PlayerTextDrawSetString(playerid, Speedo_TD[7][playerid], "~g~!S");     
                }
                else
                {
                	SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, 0); Paljenje_Time[playerid] = gettime();

                	PlayerTextDrawSetString(playerid, Speedo_TD[9][playerid], "~r~!E");
                }   
		}
	}
	return (true);
}

YCMD:vmanage(playerid,params[],help)
{
	new tip[10],vehicleid = GetPlayerVehicleID(playerid);

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	  return GRESKA(playerid,"Morate biti na mestu vozaca!");
	if(sscanf(params, "s[10]", tip))
	  return USAGE(playerid,"/vmenage [type] [lights,boot,bonnet]");

	if(strcmp(tip,"lights",true) == 0)
	{
		if (!GetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS))
        {
        	SetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS, 1);
        	INFO(playerid,"Uspesno ste upalili svetla na ovom vozilu.");
        }
        else
        {
        	SetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS, 0);
        	INFO(playerid,"Uspesno ste ugasili svetla na ovom vozilu.");

        }
	} 
	else if(strcmp(tip,"boot",true) == 0)
	{
		if (!GetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT))
        {
        	SetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT, 1);
        	INFO(playerid,"Uspesno ste otvorili gepek na ovom vozilu.");
        }
        else
        {
        	SetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT, 0);
        	INFO(playerid,"Uspesno ste zatvorili gepek na ovom vozilu.");
        }
	} 
	else if(strcmp(tip,"bonnet",true) == 0)
	{
		if (!GetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET))
        {
        	SetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET, 1);
        	INFO(playerid,"Uspesno ste otvorili haubu na ovom vozilu.");
        }
        else
        {
        	SetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET, 0);
        	INFO(playerid,"Uspesno ste zatvorili haubu na ovom vozilu.");
        }
	}
	return (true);
}

//==================================================

task Speedo_Timer[1000]()
{
	new speedo_string[64],Float:health;
	static date[20];

	gettime(date[3], date[4], date[5]);

	foreach (new i:Player)
    {
    	new vehicleid = GetPlayerVehicleID(i);
    	if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
    	{
    		GetVehicleHealth(vehicleid, health);

	    	format(speedo_string,sizeof(speedo_string),"%d",GetPlayerSpeed(i)); // brzina string.
	    	PlayerTextDrawSetString(i, Speedo_TD[15][i], speedo_string);

	    	format(speedo_string,sizeof(speedo_string),"%s",GetKilometers(GetPlayerVehicleID(i))); // kilometri string.
	    	PlayerTextDrawSetString(i, Speedo_TD[4][i], speedo_string);

	    	format(speedo_string,sizeof(speedo_string),"%02d:%02d",date[3], date[4]); // time string.
	    	PlayerTextDrawSetString(i, Speedo_TD[11][i], speedo_string);

	    	if(health < 400)
	    	{
	    		PlayerTextDrawSetString(i, Speedo_TD[7][i], "~s~!S");
	    	}
	    	else
	    	{
	    		PlayerTextDrawSetString(i, Speedo_TD[7][i], "~g~!S");
	    	}

            new carid = isCOSVehicle(vehicleid);

	    	if(carid != (-1))
	    	{
	    		format(speedo_string,sizeof(speedo_string),"%s",GetKilometers(vehicleid)); // kilometri string.
	    	    PlayerTextDrawSetString(i, Speedo_TD[4][i], speedo_string);
	    	}
	    	else if(!IsABiciklo(vehicleid))
	    	{
	    	    format(speedo_string,sizeof(speedo_string),"%s",GetKilometers(vehicleid)); // kilometri string.
	    	    PlayerTextDrawSetString(i, Speedo_TD[4][i], speedo_string);
	    	}    

	    }	
    }
	return (true);
}

//==================================================

stock Get_Player_Keys(playerid,carid)
{
	for(new i = 0; i<4; ++i)
    {
           if(Player_Keys[playerid][i] == carid)
               return (true);
    }
	return (false);
}

stock GetPlayerSpeed(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}

//==================================================

function SetPlayerSpeedCap( playerid, Float:value )
{
	if ( 0 <= playerid < sizeof( g_fSpeedCap ) )
		g_fSpeedCap[ playerid ] = value;
}

//==================================================
