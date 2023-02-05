#include <YSI\y_hooks>

//================================================
/*
				Balkan Rising
                   0.0.1x
                Breaking system
*/
//================================================

new Attached_Item[MAX_PLAYERS][5],
    Player_Break_Enabled[MAX_PLAYERS] = 0,
    Player_Started_Breaking[MAX_PLAYERS] = 0,
    Player_Breaking_Steps[MAX_PLAYERS] = 1,
    Player_Breaking_Time[MAX_PLAYERS] = 0; 

//===========================================================//

hook OnPlayerConnect(playerid){
	for(new i = 0; i<5; ++i)
	{
         Attached_Item[playerid][i] = 0;
	}
	return (true);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    
    new td_string[10];
	if(PRESSED(KEY_YES))
	{
         if(Player_Started_Breaking[playerid] == 1)
         {
                SetPlayerProgressBarValue(playerid, Breaking_Bar, GetPlayerProgressBarValue(playerid,Breaking_Bar) + random(7));
                if(GetPlayerProgressBarValue(playerid,Breaking_Bar) >= 100)
                {
                	SetPlayerProgressBarValue(playerid, Breaking_Bar, 0.0);
                    Player_Breaking_Steps[playerid]++; Player_Breaking_Time[playerid] += random(15);

                	format(td_string,sizeof(td_string),"~y~%d/5",Player_Breaking_Steps[playerid]);
                	PlayerTextDrawSetString(playerid, Vehicle_Breaking_TD[8][playerid], td_string);

                	if(Player_Breaking_Steps[playerid] == 5)
                	{
                		new vehicleid = GetNearestVehicle(playerid);
                		new carid = isCOSVehicle(vehicleid);

                        COS_Enum[carid][C_LOCKED] = 0;
                        INFO(playerid,"Uspesno ste provalili u (%s).",ReturnVehicleModelName(COS_Enum[carid][C_MODEL]));

                        Breaking_TDs(playerid,2); ClearAnimations(playerid);
                        Player_Break_Enabled[playerid] = 0; Player_Started_Breaking[playerid] = 0;
                        Player_Breaking_Steps[playerid] = 0;  Player_Breaking_Time[playerid] = 0;
                        HidePlayerProgressBar(playerid, Breaking_Bar);
                        PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/x3fo146yg0/Car_Lock_Sound_Effect.mp3");
                	}
                }
         }
	}
	return (true);
}


//================================================

YCMD:storagebuy(playerid,params[],help)
{
	new tip[10];
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, 1296.9827,-990.8821,32.6953))
	   return GRESKA(playerid,"Morate biti na storage buy mestu! (Okolica burga)!");
	if(sscanf(params,"s[10]",tip))
	   return USAGE(playerid,"/storagebuy [type] [crowbar(30$)]"); // za sad samo pajser

	if(strcmp(tip,"crowbar",true) == 0)
	{
		if (Inventory_HasItem(playerid, "Crowbar"))
		    return GRESKA(playerid, "Vec imate crowbar u inventaru.");
		if(Player_Enum[playerid][p_Money] < 30)
		   return GRESKA(playerid,"Potrebno vam je $30 za crowbar!!");

		Player_Enum[playerid][p_Money] -= 30; GivePlayerMoney(playerid,-30);   

	    new id = Inventory_Add(playerid, "Crowbar", 18634);

		if (id == -1)
        	return GRESKA(playerid, "Nemate praznih slotova u inventaru.");

	    INFO(playerid,"Uspesno ste kupili crowbar.");	      
	}
	return (true);         
}

//==============================================

YCMD:breakvehicle(playerid,params[],help)
{
	new vehicleid = GetNearestVehicle(playerid),br_string[30],Float:Pos[3];
	new carid = isCOSVehicle(vehicleid);

    if(carid != (-1))
    {
    	GetVehiclePos(vehicleid, Pos[0], Pos[1], Pos[2]);
    	if(COS_Enum[carid][C_LOCKED] == 1 && IsPlayerInRangeOfPoint(playerid, 1.5, Pos[0], Pos[1], Pos[2]))
    	{
	    	if (!Inventory_HasItem(playerid, "Crowbar"))
		           return GRESKA(playerid,"Nemate crowbar u inventaru!");
			if(Attached_Item[playerid][0] != 1)
			       return GRESKA(playerid,"Morate drzati crowbar u ruci!");	   

			if(isequal(GetName(playerid), COS_Enum[carid][C_OWNER]))
			   return GRESKA(playerid,"Ne mozes obiti svoje vozilo!");

			if(COS_Enum[carid][C_LOCK] == 1) Player_Breaking_Time[playerid] = 50;
			else if(COS_Enum[carid][C_LOCK] == 2) Player_Breaking_Time[playerid] = 70;    
			if(COS_Enum[carid][C_LOCK] == 3) Player_Breaking_Time[playerid] = 90;

			INFO(playerid,"Da odustanete od provale kucajte /cancelbreaking!");  Player_Started_Breaking[playerid] = 1;

			format(br_string,sizeof(br_string),"~y~%d sec",Player_Breaking_Time[playerid]);
			PlayerTextDrawSetString(playerid, Vehicle_Breaking_TD[6][playerid], br_string);

			Breaking_TDs(playerid,1); ShowPlayerProgressBar(playerid, Breaking_Bar);

			ApplyAnimation(playerid,"PED","CAR_doorlocked_RHS",4.1,1,0,0,0,180000);
	    }
	}    
	return (true);
}

YCMD:cancelbreaking(playerid,params[],help)
{
	if(Player_Started_Breaking[playerid] == 1)
	{
		ClearAnimations(playerid);
        Player_Started_Breaking[playerid] = 0;

		Breaking_TDs(playerid,2); HidePlayerProgressBar(playerid, Breaking_Bar);

		INFO(playerid,"Odustali ste od obijanja ovog vozila!");
	}
	return (true);
}

//=============================================

task Breaking_Timer[370]()
{
	new br_string[64],Float:Pos[3];
	foreach(new i: Player)
	{
		if(Player_Started_Breaking[i] == 1)
		{
			new vehicleid = GetNearestVehicle(i);
		    new carid = isCOSVehicle(vehicleid);

			Player_Breaking_Time[i] --;
			
			format(br_string,sizeof(br_string),"~y~%d",Player_Breaking_Time[i]);
	        PlayerTextDrawSetString(i, Vehicle_Breaking_TD[6][i], br_string);

	        if(Player_Breaking_Time[i] == 0)
	        {
	        	   GetPlayerPos(i, Pos[0],Pos[1],Pos[2]);

                   if(carid != (-1))
                   {
                   	     if(COS_Enum[carid][C_ALARM] != 0)
                   	     {
                                PlayAudioStreamForPlayer(i, "http://k003.kiwi6.com/hotlink/2xg0nfdkgq/alarmzaug.mp3", Pos[0],Pos[1],Pos[2], 50.0, 1);
                                Breaking_TDs(i,2); Player_Started_Breaking[i] = 0; Player_Breaking_Time[i] = 0; ClearAnimations(i);
                                Player_Breaking_Steps[i] = 0;
                                HidePlayerProgressBar(i, Breaking_Bar); defer Alarm_Off(i);
                   	     }
                   }
	        }
		}
	}
	return (true);
}

//===============================================================================

timer Alarm_Off[7000](playerid)
{
	return StopAudioStreamForPlayer(playerid);
}

//===============================================================================
