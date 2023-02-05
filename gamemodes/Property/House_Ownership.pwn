
#include <YSI\y_hooks>

//========================================================
/*
                  Balkan Rising
                     0.0.1x
                  House System
*/
//=========================================================

#define MAX_HOUSES (500)
#define MAX_HOUSE_FURNITURE (40)
#define MAX_FURNITURE (5000)
#define MAX_HOUSE_STORAGE (10)

new Iterator:Loaded_Houses_Array<MAX_HOUSES>;

new Entered_House[MAX_PLAYERS] = (-1),
    Choosed_House[MAX_PLAYERS] = (-1);

new Furniture_Edit[MAX_PLAYERS] = INVALID_OBJECT_ID;
new Furniture_Index[MAX_PLAYERS] = INVALID_PLAYER_ID;    

new House_Options[MAX_PLAYERS][4];

//=========================================================

enum HOUSE_STORAGE{
	 H_CLOTHES[5],
	 H_WEAPON[10],
	 H_AMMO[10],
	 H_WEED,
	 H_COCAIN,
	 H_LSD,
	 H_MATERIALS,
	 H_MONEY
};


enum HOUSE_DATA{
	 H_ID,
	 H_CREATED,
	 H_OWNED,
	 H_OWNER[MAX_PLAYER_NAME + 1],
	 H_PRICE,
	 H_LIGHTS,
	 H_LOCKED,
	 H_RENTABLE,
	 H_RENT_PRICE,
	 H_PASSWORD_PROTECT,
	 H_PASSWORD[12],

	 H_STORAGE[HOUSE_STORAGE],

	 H_RENTER_1[MAX_PLAYER_NAME + 1],
	 H_RENTER_2[MAX_PLAYER_NAME + 1],
	 H_RENTER_3[MAX_PLAYER_NAME + 1],
	 H_RENTER_4[MAX_PLAYER_NAME + 1],
	 H_RENTER_5[MAX_PLAYER_NAME + 1],
	 H_RENTERS_SLOT,

	 Float:H_POS[4],
	 Float:H_INT_POS[4],

	 H_INTERIOR,
	 H_EXTERIOR,
	 H_EXTERIOR_VW,

	 H_MAP_ICON,
	 H_PICKUP,
	 Text3D:H_LABEL
};
new HOUSE_ENUM[MAX_HOUSES][HOUSE_DATA];

//==========================================================

enum furnitureData {
	furnitureID,
	furnitureHouse,
	furnitureExists,
	furnitureModel,
	furnitureSpawned,
	furnitureName[32],
	Float:furniturePos[3],
	Float:furnitureRot[3],
	furnitureObject
};
new FurnitureData[MAX_FURNITURE][furnitureData];
new ListedFurniture[MAX_PLAYERS][MAX_HOUSE_FURNITURE];

//=========================================================

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	static id = (-1);

	if(PRESSED(KEY_SECONDARY_ATTACK))
	{
          if((id = House_Nearest(playerid)) != (-1))
	      {
                if(HOUSE_ENUM[id][H_PASSWORD_PROTECT] == (1))
                {
                    Dialog_Show(playerid, Protection_Code, DSI, "{FFFFFF}HOUSE - PROTECTION","{FFFFFF}Ova kuca je zakljucana i posjeduje alarm protekciju.\nDa bi ste usli u nju potrebno je da deaktivirate alarm sa pristupnim kodom.\n\n{FC5805}Ako pogresite kod vlasnik ce biti obavesten!","Input","Cancel");
                    Entered_House[playerid] = id;
                    return (true);
                }
                else
                {   
                	if(HOUSE_ENUM[id][H_LOCKED] == (0) && !House_IsOwner(playerid, id))
                	  return GRESKA(playerid,"Kuca je zakljucana!");

	                SetPlayerPos(playerid,HOUSE_ENUM[id][H_INT_POS][0],HOUSE_ENUM[id][H_INT_POS][1],HOUSE_ENUM[id][H_INT_POS][2]);
	                SetPlayerFacingAngle(playerid,HOUSE_ENUM[id][H_INT_POS][3]);

	                SetPlayerInterior(playerid, HOUSE_ENUM[id][H_INTERIOR]);
				    SetPlayerVirtualWorld(playerid, HOUSE_ENUM[id][H_EXTERIOR]);

				    SetCameraBehindPlayer(playerid); Entered_House[playerid] = id;

				    if(HOUSE_ENUM[id][H_LIGHTS] == 0) PlayerTextDrawShow(playerid, House_L_TD[playerid]);

				    TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);
			    }
	      }
	      if((id = House_Inside(playerid)) != (-1) && IsPlayerInRangeOfPoint(playerid, 2.5, HOUSE_ENUM[id][H_INT_POS][0],HOUSE_ENUM[id][H_INT_POS][1],HOUSE_ENUM[id][H_INT_POS][2]))
	      {

		      	    if(HOUSE_ENUM[id][H_LOCKED] == (0) && !House_IsOwner(playerid, id))
	                	return GRESKA(playerid,"Kuca je zakljucana!");

		      	    SetPlayerPos(playerid,HOUSE_ENUM[id][H_POS][0],HOUSE_ENUM[id][H_POS][1],HOUSE_ENUM[id][H_POS][2]);
	                SetPlayerFacingAngle(playerid,HOUSE_ENUM[id][H_POS][3]);

	                SetPlayerInterior(playerid,0);
	                SetPlayerVirtualWorld(playerid,HOUSE_ENUM[id][H_EXTERIOR_VW]);

	                SetCameraBehindPlayer(playerid); Entered_House[playerid] = (-1);

	                PlayerTextDrawHide(playerid, House_L_TD[playerid]);

	                TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);
	      }
	}
	return (true);
}

//=========================================================

YCMD:makehouse(playerid,params[],help)
{
	static price,Float:houseint[4];
    
	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(GetPlayerInterior(playerid) != 0)
	    return GRESKA(playerid,"Vas interior mora biti 0.");    
	if(sscanf(params, "iffff", price,houseint[0],houseint[1],houseint[2],houseint[3]))
	    return USAGE(playerid,"/makehouse [Price] [Int X] [Int Y] [Int Z] [Int A]");
	if(price < 1)
	   return GRESKA(playerid,"Cijena ne moze biti manja od 1$.");

	new hID = GetFree_HouseID(); Iter_Add(Loaded_Houses_Array,hID);

    Add_Base_House(hID,"Nema",price);
    Create_House(hID,playerid,price,houseint[0],houseint[1],houseint[2],houseint[3]);

    INFO(playerid,"Uspesno ste kreirali kucu ID: %d.",hID);
    return (true);       
}

YCMD:deletehouse(playerid,params[],help)
{
	static id,string[64];
	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "d", id))
	    return USAGE(playerid,"/deletehouse [house ID]");

	if((id < 0 || id >= MAX_HOUSES) || !HOUSE_ENUM[id][H_CREATED])
	   return GRESKA(playerid,"Uneseni ID nije validan/registrovan.");

	format(string, sizeof(string), "DELETE FROM `ug_houses` WHERE `H_ID` = %d",id);
    mysql_function_query(_dbConnector, string, true, "Delete_House", "i",HOUSE_ENUM[id][H_ID]); string = "\0";

    Iter_Remove(Loaded_Houses_Array,id);
    INFO(playerid,"Uspesno ste obirsali kucu ID: %d",id);         
	return (true);
}

YCMD:pozvoni(playerid,params[],help)
{
	new id = House_Nearest(playerid);
	if(id == -1)
	  return GRESKA(playerid,"Morate biti blizu neke kuce.");

    foreach (new i : Player) if (House_Inside(i) == id) {
	    INFO(i,"Netko zvoni na ulazna vrata!");
	    PlayerPlaySound(i, 20801, 0, 0, 0);
	}
	PlayerPlaySoundEx(playerid, 20801);
	INFO(playerid,"Zvonite...");
	return (true);
}

YCMD:renthouse(playerid,params[],help)
{
	new id = House_Nearest(playerid);
	if(id == -1)
	  return GRESKA(playerid,"Morate biti blizu neke kuce.");

	if(Player_Enum[playerid][p_Property_Rent] != 9999)
	  return GRESKA(playerid,"Vec rentate kod nekog!");
	if(HOUSE_ENUM[id][H_RENTABLE] != 1)
	  return GRESKA(playerid,"Ova kuca ne iznajmljuje sobe gradanima.");  
	if(HOUSE_ENUM[id][H_RENTERS_SLOT] == 5)
	  return GRESKA(playerid,"Ova kuca ima maximalan broj iznajmljenih soba,probajte sa drugom.");
	if(isequal(GetName(playerid), HOUSE_ENUM[id][H_OWNER]))
	  return GRESKA(playerid,"Ne mozete rentati u svojoj kuci!");
	if(HOUSE_ENUM[id][H_RENT_PRICE] > Player_Enum[playerid][p_Money])
	  return GRESKA(playerid,"Nemate dovoljno novca za rentanje u ovoj kuci. ($%d)",HOUSE_ENUM[id][H_RENT_PRICE]);

	if(!strcmp(HOUSE_ENUM[id][H_RENTER_1], "Niko", false)) { SetString(HOUSE_ENUM[id][H_RENTER_1], GetName(playerid)); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_2], "Niko", false)) { SetString(HOUSE_ENUM[id][H_RENTER_2], GetName(playerid)); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_3], "Niko", false)) { SetString(HOUSE_ENUM[id][H_RENTER_3], GetName(playerid)); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_4], "Niko", false)) { SetString(HOUSE_ENUM[id][H_RENTER_4], GetName(playerid)); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_5], "Niko", false)) { SetString(HOUSE_ENUM[id][H_RENTER_5], GetName(playerid)); }
	HOUSE_ENUM[id][H_RENTERS_SLOT] ++;

    Save_House(id);

    Player_Enum[playerid][p_Money] -= HOUSE_ENUM[id][H_RENT_PRICE];
    GivePlayerMoney(playerid,-HOUSE_ENUM[id][H_RENT_PRICE]);

	Player_Enum[playerid][p_Property_Rent] = id; 

	INFO(GetPlayerIdFromName(HOUSE_ENUM[id][H_OWNER]), "%s je uplatio rentanje u vasoj kuci!",GetName(playerid));
	INFO(playerid,"Uspesno ste rentali kucu od stanovnika (%s).",HOUSE_ENUM[id][H_OWNER]);
	INFO(playerid,"Da un-rentate prostor kucajte /unrent.");     
	return (true);
}

YCMD:unrent(playerid,params[],help)
{
	new id = House_Nearest(playerid);
	if(id == -1)
	  return GRESKA(playerid,"Morate biti blizu neke kuce.");
	if(Player_Enum[playerid][p_Property_Rent] == 9999)
	  return GRESKA(playerid,"Vi ne rentate nigdje!");

	HOUSE_ENUM[id][H_RENTERS_SLOT] --;

	if(!strcmp(HOUSE_ENUM[id][H_RENTER_1], GetName(playerid), false)) { SetString(HOUSE_ENUM[id][H_RENTER_1], "Niko"); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_2], GetName(playerid), false)) { SetString(HOUSE_ENUM[id][H_RENTER_2], "Niko"); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_3], GetName(playerid), false)) { SetString(HOUSE_ENUM[id][H_RENTER_3], "Niko"); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_4], GetName(playerid), false)) { SetString(HOUSE_ENUM[id][H_RENTER_4], "Niko"); }
	else if(!strcmp(HOUSE_ENUM[id][H_RENTER_5], GetName(playerid), false)) { SetString(HOUSE_ENUM[id][H_RENTER_5], "Niko"); } 

	Save_House(id);

	Player_Enum[playerid][p_Property_Rent] = 9999;

	INFO(GetPlayerIdFromName(HOUSE_ENUM[id][H_OWNER]), "%s je odlucio da prekine rentanje kod vas!",GetName(playerid));
	INFO(playerid,"Uspesno ste un-rentali kucu kod stanovnika (%s).",HOUSE_ENUM[id][H_OWNER]);      
	return (true);  
}

//=========================================================

YCMD:buyhouse(playerid,params[],help)
{
	static id = (-1);
	new i[2];

	if ((id = House_Nearest(playerid)) != (-1))
	{
          i[0] = Player_Enum[playerid][p_Property][0];
          i[1] = Player_Enum[playerid][p_Property][1];

          if(i[0] != 9999 && i[1] != 9999)
            return GRESKA(playerid,"Imate maximalan broj ownable kuca 2/2.");
          if(HOUSE_ENUM[id][H_OWNED] != 0)
            return GRESKA(playerid,"Ova kuca je vec kupljena!");
          if(Player_Enum[playerid][p_Money] < HOUSE_ENUM[id][H_PRICE])
            return GRESKA(playerid,"Nemate dovoljno novca za kupovinu ove kuce: ($%d).",HOUSE_ENUM[id][H_PRICE]);

          if(i[0] == 9999)  Player_Enum[playerid][p_Property][0] = id;
          else if(i[1] == 9999)  Player_Enum[playerid][p_Property][1] = id;

          Player_Enum[playerid][p_Money] -= HOUSE_ENUM[id][H_PRICE];
          GivePlayerMoney(playerid,-HOUSE_ENUM[id][H_PRICE]);

          HOUSE_ENUM[id][H_OWNED] = (1);
          SetString(HOUSE_ENUM[id][H_OWNER],GetName(playerid));

          INFO(playerid,"Uspesno ste kupili ovu kucu za ($%d) | Za upravljanje kucom kucajte '/house'.",HOUSE_ENUM[id][H_PRICE]);

          SavePlayer(playerid);
          Save_House(id); House_Refresh(id);      
	}
	return (true);
}

YCMD:house(playerid,params[],help)
{
	new prop[2],slot;
	static houseid = -1;

	prop[0] = Player_Enum[playerid][p_Property][0],
	prop[1] = Player_Enum[playerid][p_Property][1];

	if(prop[0] == 9999 && prop[1] == 9999)
	  return GRESKA(playerid,"Ne posjedujete ni jednu kucu.");

	if ((houseid = House_Inside(playerid)) != -1 && (House_IsOwner(playerid, houseid)))
	{
		if(sscanf(params, "i",slot))
		  return USAGE(playerid,"/house [slot] [0-1]");

		if(slot < 0 || slot > 1)
		  return GRESKA(playerid,"Moguci slotovi samo od [0-1].");  

		if(Player_Enum[playerid][p_Property][slot] == 9999)
		  return GRESKA(playerid,"Nemate kucu na ovom slotu!");

		Choosed_House[playerid] = Player_Enum[playerid][p_Property][slot];       

	    Dialog_Show(playerid, House_Dialog, DSL, "{FFD000}HOUSE - {FFFFFF}OPTIONS", "{FFFFFF}Informations\nLock\nLights\nRent Options\nClothes\nSell\nStorage\nAlarm protect\nFurniture", "Odaberi", "Cancel");
	}    
	return (true);
}

//=========================================================

Dialog:House_Dialog(playerid, response, listitem, inputtext[])
{
	static h_string[400];
	new i = Choosed_House[playerid];

	if(response)
	{
		switch(listitem)
		{
             case 0:
             {
                     format(h_string,sizeof(h_string),
                     "{FFD000}House Price:{FFFFFF} (%s)\n\
                     {FFD000}House Lock:{FFFFFF} (%s)\n\
                     {FFD000}House Lights:{FFFFFF} (%s)\n\
                     {FFD000}House Alarm:{FFFFFF} (%s)\n\
                     {FFD000}House Weed:{FFFFFF} (%dg)\n\
                     {FFD000}House Cocain:{FFFFFF} (%dg)\n\
                     {FFD000}House LSD:{FFFFFF} (%dg)\n\
                     {FFD000}House Materials: {FFFFFF}(%dg)\n\
                     {FFD000}House Money: {FFFFFF}(%dg)",
                     FormatNumber(HOUSE_ENUM[i][H_PRICE]),
                     (HOUSE_ENUM[i][H_LOCKED]) ? ("Otkljucano") : ("Zakljucano"),
                     (HOUSE_ENUM[i][H_LIGHTS]) ? ("Upaljena") : ("Ugasena"),
                     (HOUSE_ENUM[i][H_PASSWORD_PROTECT]) ? ("Ugasen") : ("Upaljen"),
                     HOUSE_ENUM[i][H_STORAGE][H_WEED],
                     HOUSE_ENUM[i][H_STORAGE][H_COCAIN],
                     HOUSE_ENUM[i][H_STORAGE][H_LSD],
                     HOUSE_ENUM[i][H_STORAGE][H_MATERIALS],
                     HOUSE_ENUM[i][H_STORAGE][H_MONEY]);
                     Dialog_Show(playerid, Show_Only, DSM, "{FFD000}HOUSE {FFFFFF}- INFO", h_string, "IZLAZ", "");  h_string = "\0";
             }
             case 1:
             {
	                 	  if(HOUSE_ENUM[i][H_LOCKED] == 0)
	                 	  {
	                 	  	  HOUSE_ENUM[i][H_LOCKED] = (1); Save_House(i);
	                 	  	  INFO(playerid,"Uspesno ste otkljucali svoju kucu!");
	                 	  	  PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	
	                 	  }
	                 	  else if(HOUSE_ENUM[i][H_LOCKED] == 1)
	                 	  {
	                 	  	  HOUSE_ENUM[i][H_LOCKED] = (0); Save_House(i);
	                 	  	  INFO(playerid,"Uspesno ste zakljucali svoju kucu!");
	                 	  	  PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
	   
	                 	  }
             }
             case 2:
             {
             	     if (HOUSE_ENUM[i][H_LIGHTS] == 1)
			         {
			         	  foreach (new j : Player) if (House_Inside(j) == i) {
		                    PlayerTextDrawShow(j, House_L_TD[j]);
		                  }
			         	  HOUSE_ENUM[i][H_LIGHTS] = (0); Save_House(i);
			         	  INFO(playerid,"Uspesno ste ugasili svetla u svojoj kuci.");
			         }
			         else if (HOUSE_ENUM[i][H_LIGHTS] == 0)
			         {
			         	  foreach (new j : Player) if (House_Inside(j) == i) {
		                    PlayerTextDrawHide(j, House_L_TD[j]);
		                  }
			         	  HOUSE_ENUM[i][H_LIGHTS] = (1); Save_House(i);
			         	  INFO(playerid,"Uspesno ste upalili svetla u svojoj kuci.");
			         }
             }
             case 3:
             {
             	     Dialog_Show(playerid, House_Rent_Dialog, DSL, "{FFD000}RENT - {FFFFFF}OPTIONS", "{FFFFFF}Rent info\nRentable\nRent Price\nRenter Kick", "Odaberi", "Cancel");
             }
             case 4:
             {
             	    Dialog_Show(playerid, House_Clothes_Dialog, DSL, "{FFD000}CLOTHES - {FFFFFF}OPTIONS", "{FFFFFF}Clothes Info\nPut clothes\nTake clothes", "Odaberi", "Cancel");
             }
             case 5:
             {
             	    Dialog_Show(playerid, House_Sell_Dialog, DSM, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce.\n\n{FFFFFF}Ako zelite prodati kucu drzavi pritisnite {FFD000}'Drzava'\n{FFFFFF}Ili ako zelite da prodate igracu pritisnite {FFD000}'Igrac'", "Drzava", "Igrac");
             }
             case 6:
             {
             	    Dialog_Show(playerid, House_Storage_Dialog, DSL, "{FFD000}STORAGE - {FFFFFF}OPTIONS", "{FFFFFF}Weapon storage\nOther storage", "Odaberi", "Cancel");
             }
             case 7:
             {
             	    Dialog_Show(playerid, House_Alarm_Dialog, DSL, "{FFD000}ALARM - {FFFFFF}PROTECTION", "{FFFFFF}Ukljuci zastitu\nIskljuci zastitu", "Odaberi", "Cancel");
             }
             case 8:
             {
             	    new count = 0,string[MAX_HOUSE_FURNITURE * 32];

             	    for (new j = 0; j != MAX_FURNITURE; j ++) if (count < MAX_HOUSE_FURNITURE && FurnitureData[j][furnitureExists] == (1) && FurnitureData[j][furnitureHouse] == i) {
	    		        ListedFurniture[playerid][count++] = j;

	    		        format(string, sizeof(string), "%s{FFD000}Furniture Name: {FFFFFF}%s {FFD000}Furniture Model: {FFFFFF}%d\n", string, FurnitureData[j][furnitureName],FurnitureData[j][furnitureModel]);
    		        }
    		        if (count)
			             Dialog_Show(playerid, ListedFurniture, DIALOG_STYLE_LIST, "{FFFFFF}HOUSE FURNITURE", string, "Choose", "Cancel");
			        else return GRESKA(playerid,"Ova kuca nema ni jedan furniture item.");            
             }
		}
	}
	return (true);
}

//=========================================================

Dialog:ListedFurniture(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           Furniture_Edit[playerid] = ListedFurniture[playerid][listitem];
           Dialog_Show(playerid, FurnitureList, DIALOG_STYLE_LIST, FurnitureData[Furniture_Edit[playerid]][furnitureName], "Spawn furniture item\nEdit furniture position\nDestroy furniture\nDelete furniture", "Choose", "Cancel");
	}
	for (new i = 0; i != MAX_FURNITURE; i ++) {
	    ListedFurniture[playerid][i] = -1;
	}    
	return (true);
}

Dialog:FurnitureList(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	   		switch (listitem)
		    {
		    	case 0:
		    	{
                            if(FurnitureData[Furniture_Edit[playerid]][furnitureSpawned] != 0)
                              return GRESKA(playerid,"Ovaj item je vec spawnat.");

                            static Float:x,Float:y,Float:z,Float:angle;

					        GetPlayerPos(playerid, x, y, z);
					        GetPlayerFacingAngle(playerid, angle);

					        x += 5.0 * floatsin(-angle, degrees);
					        y += 5.0 * floatcos(-angle, degrees);

					        SCM(playerid,-1,"Spawnali ste furniture item: (%s).",FurnitureData[Furniture_Edit[playerid]][furnitureName]);

					        Update_Furniture(Furniture_Edit[playerid],x, y, z);

					        EditDynamicObject(playerid, FurnitureData[Furniture_Edit[playerid]][furnitureObject]);  
		    	}
		        case 1:
				{
					if(FurnitureData[Furniture_Edit[playerid]][furnitureSpawned] != 1)
                        return GRESKA(playerid,"Ovaj item nije spawnat.");

					EditDynamicObject(playerid, FurnitureData[Furniture_Edit[playerid]][furnitureObject]);
					SCM(playerid,-1,"Poceli ste editovati: (%s).",FurnitureData[Furniture_Edit[playerid]][furnitureName]);
				}
				case 2:
				{
                    DestroyDynamicObject(FurnitureData[Furniture_Edit[playerid]][furnitureObject]);
                    SCM(playerid,-1,"Uspesno ste unistili furniture objekat (%s).",FurnitureData[Furniture_Edit[playerid]][furnitureName]);
                    FurnitureData[Furniture_Edit[playerid]][furnitureSpawned] = (0);
                    Furniture_Save(Furniture_Edit[playerid]);
				}
				case 3:
				{
                    Furniture_Delete(Furniture_Edit[playerid]);
                    SCM(playerid,-1,"Uspesno ste obrisali furniture: (%s).",FurnitureData[Furniture_Edit[playerid]][furnitureName]);
                    CancelEdit(playerid);
                    Furniture_Edit[playerid] = (-1);
				}
			}
	}
	else 
	  Furniture_Edit[playerid] = (-1);
	return (true);			
}

//=========================================================

Dialog:House_Alarm_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
             case 0:
             {
             	if(HOUSE_ENUM[Choosed_House[playerid]][H_PASSWORD_PROTECT] != 0)
             	   return GRESKA(playerid,"Vec ste ukljucili protekciju!");
             	Dialog_Show(playerid, House_Alarm_Set, DSI, "{FFD000}ALARM - {FFFFFF}PROTECTION", "{FFFFFF}Postavljanje passworda za alarm.\nUnesite password koji ce moci da deaktivira vas alarmni system.\n\n{F05466}Password moze sadrzavati do 12 znakovni karaktera.", "Odaberi", "Cancel");   
             }
             case 1:
             {
             	if(HOUSE_ENUM[Choosed_House[playerid]][H_PASSWORD_PROTECT] != 1)
             	   return GRESKA(playerid,"Alarm protekcija nije ni postavljena!");
             	HOUSE_ENUM[Choosed_House[playerid]][H_PASSWORD_PROTECT] = 0;
             	INFO(playerid,"Uspesno ste uklonili alarm protekciju na svojoj kuci.");
             	Save_House(Choosed_House[playerid]);   
             }
        }
    }
    return (true);         
}


Dialog:House_Alarm_Set(playerid, response, listitem, inputtext[])
{
   if(response)
   {
        new unos[12];
        if(sscanf(inputtext,"s[12]",unos))
          return Dialog_Show(playerid, House_Alarm_Set, DSI, "{FFD000}ALARM - {FFFFFF}PROTECTION", "{FFFFFF}Postavljanje passworda za alarm.\nUnesite password koji ce moci da deaktivira vas alarmni system.\n\n{F05466}Password moze sadrzavati do 12znakovni karaktera.", "Odaberi", "Cancel");
        SetString(HOUSE_ENUM[Choosed_House[playerid]][H_PASSWORD],unos);
        HOUSE_ENUM[Choosed_House[playerid]][H_PASSWORD_PROTECT] = 1;
        INFO(playerid,"Uspesno ste postavili alarm protekciju,Password glasi: %s",unos);
        Save_House(Choosed_House[playerid]);  
   }
   return (true);
}

Dialog:Protection_Code(playerid, response, listitem, inputtext[])
{
	if(response)
	{
       new unos[12];
       new id = Entered_House[playerid];

       if(sscanf(inputtext,"s[12]",unos))
          return Dialog_Show(playerid, Protection_Code, DSI, "{FFFFFF}HOUSE - PROTECTION","{FFFFFF}Ova kuca je zakljucana i posjeduje alarm protekciju.\nDa bi ste usli u nju potrebno je da deaktivirate alarm sa pristupnim kodom.\n\n{FC5805}Ako pogresite kod 3puta alarm ce se oglasiti!","Input","Cancel");

       if (!strcmp(HOUSE_ENUM[id][H_PASSWORD], unos, true))
	   {
	   	            SetPlayerPos(playerid,HOUSE_ENUM[id][H_INT_POS][0],HOUSE_ENUM[id][H_INT_POS][1],HOUSE_ENUM[id][H_INT_POS][2]);
	                SetPlayerFacingAngle(playerid,HOUSE_ENUM[id][H_INT_POS][3]);

	                SetPlayerInterior(playerid, HOUSE_ENUM[id][H_INTERIOR]);
				    SetPlayerVirtualWorld(playerid, HOUSE_ENUM[id][H_EXTERIOR]);

				    SetCameraBehindPlayer(playerid); Entered_House[playerid] = id;

				    if(HOUSE_ENUM[id][H_LIGHTS] == 0) PlayerTextDrawShow(playerid, House_L_TD[playerid]);

				    TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);

				    INFO(playerid,"Uspesno ste usli u ovu kucu....");
	   }
	   else
	   {
	   	            INFO(playerid,"Unijeli ste pogresan kod vlasnik je obavjesten.");
	   	            GameTextForPlayer(GetPlayerIdFromName(HOUSE_ENUM[id][H_OWNER]), "~y~Netko pokusava da vam provali u kucu.", 4000, 5);
	   }   
	}
	return (true);
}

//=========================================================

Dialog:House_Storage_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         switch(listitem)
         {
         	  case 0:
         	  {
                    House_WeaponStorage(playerid, Choosed_House[playerid]);
         	  }
         	  case 1:
         	  {
         	  	    Dialog_Show(playerid, House_OtherS_Dialog, DSL, "{FFD000}STORAGE - {FFFFFF}OPTIONS", "{FFFFFF}Uzimanje\nOstavljanje", "Odaberi", "Cancel");
         	  }
         }
	}
	return (true);
}

//=========================================================

Dialog:House_OtherS_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         switch(listitem)
         {
         	  case 0:
         	  {
         	  	   Dialog_Show(playerid, House_OtherS_Take, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Uzimanje itema.\nDa uzmete iteme iz house inventara unesite sta uzimate i kolicinu koju uzimate.\n\nDostupno za uzimanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");
         	  }
         	  case 1:
         	  {
         	  	   Dialog_Show(playerid, House_OtherS_Put, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Ostavljanje itema.\nDa ostavite item u house inventar unesite sta ostavljate i kolicinu koju ostavljate.\n\nDostupno za ostavljanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");
         	  }
         }
    }     	  
	return (true);
}

//=========================================================

Dialog:House_OtherS_Take(playerid, response, listitem, inputtext[])
{
	if(response)
	{
       new kolicina,uzimanje[16];
       new i = Choosed_House[playerid];

       if(sscanf(inputtext, "is[16]",kolicina,uzimanje))
         return Dialog_Show(playerid, House_OtherS_Take, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Uzimanje itema.\nDa uzmete iteme iz house inventara unesite sta uzimate i kolicinu koju uzimate.\n\nDostupno za uzimanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");
       if(kolicina < 1)
         return Dialog_Show(playerid, House_OtherS_Take, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Uzimanje itema.\nDa uzmete iteme iz house inventara unesite sta uzimate i kolicinu koju uzimate.\n\nDostupno za uzimanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");

       if(!strcmp(uzimanje, "novac", true))
	   {
	   	    if(HOUSE_ENUM[i][H_STORAGE][H_MONEY] < kolicina)
	   	    {
	   	    	Dialog_Show(playerid, House_OtherS_Take, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Uzimanje itema.\nDa uzmete iteme iz house inventara unesite sta uzimate i kolicinu koju uzimate.\n\nDostupno za uzimanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");
	   	    	GRESKA(playerid,"Nemate toliko novca u invenaru.");
	   	    	return (true);
	   	    }
	   	    HOUSE_ENUM[i][H_STORAGE][H_MONEY] -= kolicina;
	   	    Player_Enum[playerid][p_Money] += kolicina;
	   	    GivePlayerMoney(playerid,kolicina);
	   	    Save_House(i);
	   	    INFO(playerid,"Uspesno ste uzeli $%d iz inventara kuce.",kolicina);
	   }    
	}
	return (true);
}

Dialog:House_OtherS_Put(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new kolicina,uzimanje[16];
        new i = Choosed_House[playerid];
        if(sscanf(inputtext, "is[16]",kolicina,uzimanje))
          return Dialog_Show(playerid, House_OtherS_Put, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Ostavljanje itema.\nDa ostavite item u house inventar unesite sta ostavljate i kolicinu koju ostavljate.\n\nDostupno za ostavljanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");
        if(kolicina < 1)
          return Dialog_Show(playerid, House_OtherS_Put, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Ostavljanje itema.\nDa ostavite item u house inventar unesite sta ostavljate i kolicinu koju ostavljate.\n\nDostupno za ostavljanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");
        if(!strcmp(uzimanje, "novac", true))
	    {
	        if(Player_Enum[playerid][p_Money] < kolicina)
	        {
	        	Dialog_Show(playerid, House_OtherS_Put, DSI, "{FFD000}STORAGE - {FFFFFF}TAKE", "{FFFFFF}Ostavljanje itema.\nDa ostavite item u house inventar unesite sta ostavljate i kolicinu koju ostavljate.\n\nDostupno za ostavljanje {F54C5D}[novac,materijali,weed,cocain,lsd]", "Uzmi", "Cancel");
	        	GRESKA(playerid,"Nemate toliko novca kod sebe!");
	        	return (true);
	        } 
	        Player_Enum[playerid][p_Money] -= kolicina;
	        GivePlayerMoney(playerid,-kolicina);
	        HOUSE_ENUM[i][H_STORAGE][H_MONEY] += kolicina;
	        Save_House(i);
	        INFO(playerid,"Uspesno ste ostavili $%d uz svoj kucni inventar.");
	    }       
	}
	return (true);
}		

//=========================================================

Dialog:House_Weapons_Dialog(playerid, response, listitem, inputtext[])
{
	new houseid = Choosed_House[playerid];
    if(response)
	{
		    if (HOUSE_ENUM[houseid][H_STORAGE][H_WEAPON][listitem] != 0)
		    {
		    	GiveWeaponToPlayer(playerid, HOUSE_ENUM[houseid][H_STORAGE][H_WEAPON][listitem], HOUSE_ENUM[houseid][H_STORAGE][H_AMMO][listitem]);
		    	HOUSE_ENUM[houseid][H_STORAGE][H_WEAPON][listitem] = 0;
		    	HOUSE_ENUM[houseid][H_STORAGE][H_AMMO][listitem] = 0;

		    	Save_House(houseid);
		    	House_WeaponStorage(playerid, houseid);
		    }
		    else
		    {
		    	new weaponid = GetWeapon(playerid),
					ammo = GetPlayerAmmo(playerid);

				if(!weaponid)
                    return GRESKA(playerid,"Nemate ni jedno oruzije u ruci!");

                ResetWeapon(playerid, weaponid);
                
                HOUSE_ENUM[houseid][H_STORAGE][H_WEAPON][listitem] = weaponid;
				HOUSE_ENUM[houseid][H_STORAGE][H_AMMO][listitem]  = ammo;

				Save_House(houseid);
		    	House_WeaponStorage(playerid, houseid);  
		    }
	}
	return (true);	    
}

//=========================================================

Dialog:House_Sell_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        Dialog_Show(playerid, House_Sell_Drzava, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce drzavi.\n\n{FFFFFF}Da prodate kucu drzavi unesite 'slot' sa kojeg je prodajete.\nDostupni slotovi od {F7234A}[0-1]\n{FFFFFF}Zapamtite prodajom kuce drzavi dobijate 30% od njene ukupne cijene.", "Nastavi", "Cancel");
	}
	else
	{
       Dialog_Show(playerid, House_Sell_Player, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce igracu.\nDa prodate kucu igracu unesite 'idigraca' 'slot' kuce sa koje je prodajete {F7234A}[0-1] {FFFFFF}i 'cijenu' za koju prodajete svoju kucu.", "Nastavi", "Cancel");
	}
	return (true);
}

//=========================================================

Dialog:House_Sell_Drzava(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static slot;
		if(sscanf(inputtext,"i",slot))
		   return Dialog_Show(playerid, House_Sell_Drzava, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce drzavi.\n\n{FFFFFF}Da prodate kucu drzavi unesite slot sa kojeg je prodajete.\nDostupni slotovi od {F7234A}[0-1]\n{FFFFFF}Zapamtite prodajom kuce drzavi dobijate 30% od njene prodajne cijene.", "Nastavi", "Cancel");
		if(slot < 0 || slot > 1)
		   return Dialog_Show(playerid, House_Sell_Drzava, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce drzavi.\n\n{FFFFFF}Da prodate kucu drzavi unesite slot sa kojeg je prodajete.\nDostupni slotovi od {F7234A}[0-1]\n{FFFFFF}Zapamtite prodajom kuce drzavi dobijate 30% od njene prodajne cijene.", "Nastavi", "Cancel");
		if(Player_Enum[playerid][p_Property][slot] == 9999)
		   return GRESKA(playerid,"Slot sa kojeg prodajete kucu je prazan!!");

		new cijena = (HOUSE_ENUM[Player_Enum[playerid][p_Property][slot]][H_PRICE] / 100) * 30;

		SetString(HOUSE_ENUM[Player_Enum[playerid][p_Property][slot]][H_OWNER],"Nema");
		HOUSE_ENUM[Player_Enum[playerid][p_Property][slot]][H_OWNED] = 0;
		HOUSE_ENUM[Player_Enum[playerid][p_Property][slot]][H_LOCKED] = 0;
		
		Player_Enum[playerid][p_Money] += cijena; GivePlayerMoney(playerid,cijena);

		House_Refresh(Player_Enum[playerid][p_Property][slot]);
		Save_House(Player_Enum[playerid][p_Property][slot]); 
		Exit_House(playerid,Player_Enum[playerid][p_Property][slot]);  

		Player_Enum[playerid][p_Property][slot] = 9999;
		SavePlayer(playerid);

		INFO(playerid,"Uspesno ste prodali kucu sa slota %d za $%d",slot,cijena);        
	}
	return (true);
}

Dialog:House_Sell_Player(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static idigraca,slot,cijena,Float:Pos[3];
		if(sscanf(inputtext,"uii",idigraca,slot,cijena))
		  return  Dialog_Show(playerid, House_Sell_Player, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce igracu.\nDa prodate kucu igracu unesite 'idigraca' 'slot' kuce sa koje je prodajete {F7234A}[0-1] {FFFFFF}i 'cijenu' za koju prodajete svoju kucu.", "Nastavi", "Cancel");
		if(slot < 0 || slot > 1)
		  return  Dialog_Show(playerid, House_Sell_Player, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce igracu.\nDa prodate kucu igracu unesite 'idigraca' 'slot' kuce sa koje je prodajete {F7234A}[0-1] {FFFFFF}i 'cijenu' za koju prodajete svoju kucu.", "Nastavi", "Cancel");
		if(Player_Enum[playerid][p_Property][slot] == 9999)
		  return GRESKA(playerid,"Nemate kucu na unesenom slotu.");
		if(cijena < 1)
		  return  Dialog_Show(playerid, House_Sell_Player, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce igracu.\nDa prodate kucu igracu unesite 'idigraca' 'slot' kuce sa koje je prodajete {F7234A}[0-1] {FFFFFF}i 'cijenu' za koju prodajete svoju kucu.", "Nastavi", "Cancel");
        if(idigraca == IPI)
          return GRESKA(playerid,"ID igraca koji ste unijeli nije konektovan!");
        if(idigraca == playerid)
          return  Dialog_Show(playerid, House_Sell_Player, DSI, "{FFD000}HOUSE - {FFFFFF}SELL", "{FFFFFF}Prodaja kuce igracu.\nDa prodate kucu igracu unesite 'idigraca' 'slot' kuce sa koje je prodajete {F7234A}[0-1] {FFFFFF}i 'cijenu' za koju prodajete svoju kucu.", "Nastavi", "Cancel");
        
        GetPlayerPos(idigraca, Pos[0], Pos[1], Pos[2]);

        if(!IsPlayerInRangeOfPoint(playerid, 2.0, Pos[0], Pos[1], Pos[2]))
          return GRESKA(playerid,"Morate biti blizu igraca kojem prodajete kucu.");
       
        House_Options[idigraca][0] = playerid;
        House_Options[idigraca][1] = Player_Enum[playerid][p_Property][slot];
        House_Options[idigraca][2] = cijena;
        House_Options[idigraca][3] = slot;

        Dialog_Show(idigraca, House_Sell_Accept, DSM, "{FFD000}HOUSE - {FFFFFF}ACCEPT", "{FFFFFF}Igrac: {FFD000}(%s) {FFFFFF}vam je ponudio da kupite od njega kucu.\nCijena kuce: {FFD000}($%d)\n\n{FFFFFF}Da je kupite pritisnite 'Prihvati' kako bi prihvatili kupovinu.", "Prihvati", "Cancel",GetName(playerid),cijena);    		    
	}
	return (true);
}

Dialog:House_Sell_Accept(playerid, response, listitem, inputtext[])
{
	new cijena = House_Options[playerid][2],
        prodavaoc = House_Options[playerid][0],
        idkuce = House_Options[playerid][1],
        slot = House_Options[playerid][3];
        
	if(response)
	{
          if(Player_Enum[playerid][p_Money] < cijena)
            return GRESKA(playerid,"Nemate dovoljno novca da kupite ponudjenu kucu!");

          if(Player_Enum[playerid][p_Property][0] == 9999) Player_Enum[playerid][p_Property][0] = idkuce;
          else if(Player_Enum[playerid][p_Property][1] == 9999) Player_Enum[playerid][p_Property][1] = idkuce;
          else GRESKA(playerid,"Nemate slobodnih slotova za kupovinu ponudjene kuce.");

          Player_Enum[prodavaoc][p_Property][slot] = 9999;

          Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena);
          Player_Enum[prodavaoc][p_Money] += cijena; GivePlayerMoney(prodavaoc,cijena);

          SetString(HOUSE_ENUM[idkuce][H_OWNER],GetName(playerid));
		  HOUSE_ENUM[idkuce][H_OWNED] = 1;
		  Save_House(idkuce);

		  SavePlayer(playerid); SavePlayer(prodavaoc);

		  House_Options[playerid][0] = INVALID_PLAYER_ID;
          House_Options[playerid][1] = -1;
          House_Options[playerid][2] = 0;
          House_Options[playerid][3] = -1;

          INFO(playerid,"Uspesno ste kupili kucu od: %s za $%d.",GetName(prodavaoc),cijena);
          INFO(prodavaoc,"Uspesno ste prodali kucu: %s za $%d",GetName(playerid),cijena);
             
	}
	else
	{
		  INFO(prodavaoc,"%s je odbio vasu ponudu za kucu.",GetName(playerid));
		  INFO(playerid,"Odbili ste ponudu za kucu od %s.",GetName(prodavaoc));

		  House_Options[playerid][0] = INVALID_PLAYER_ID;
          House_Options[playerid][1] = -1;
          House_Options[playerid][2] = 0;
          House_Options[playerid][3] = -1;
	}
	return (true);
}

//=========================================================

Dialog:House_Clothes_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new i = Choosed_House[playerid];
		static clothes_string[250];

		switch(listitem)
		{
             case 0:
             {
             	    format(clothes_string,sizeof(clothes_string),
             	    "{FFD000}Slot 1: {FFFFFF}(%d)\n\
             	    {FFD000}Slot 2: {FFFFFF}(%d)\n\
             	    {FFD000}Slot 3: {FFFFFF}(%d)\n\
             	    {FFD000}Slot 4: {FFFFFF}(%d)\n\
             	    {FFD000}Slot 5: {FFFFFF}(%d)",
             	    HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][0],
             	    HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][1],
             	    HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][2],
             	    HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][3],
             	    HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][4]);
                    Dialog_Show(playerid, Show_Only, DSM, "{FFD000}CLOTHES {FFFFFF}- INFO", clothes_string, "IZLAZ", ""); clothes_string = "\0";
             }
             case 1:
             {
             	    Dialog_Show(playerid, House_Clotes_Choose, DSI, "{FFD000}CLOTHES - {FFFFFF}PUT", "{FFFFFF}Ostavljanje odjece u kucu.\n\n{FFFFFF}Da ostavite odjecu unesite slot na koji ga zelite ostavit {FF5330}[0-4].", "Ostavi", "Cancel");
             }
             case 2:
             {
                   Dialog_Show(playerid, House_Clotes_Take, DSI, "{FFD000}CLOTHES - {FFFFFF}TAKE", "{FFFFFF}Uzimanje odjece u kuci.\n\n{FFFFFF}Da uzmete odjecu unesite slot sa kojeg zelite uzeti odjecu {FF5330}[0-4].", "Uzmi", "Cancel");
             }
        }
    }
    return (true);         
}

Dialog:House_Clotes_Choose(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new slot;
		new i = Choosed_House[playerid];

		if(sscanf(inputtext, "i",slot))
		  return Dialog_Show(playerid, House_Clothes_Choose_Dialog, DSI, "{FFD000}CLOTHES - {FFFFFF}PUT", "{FFFFFF}Ostavljanje odjece u kucu.\n\n{FFFFFF}Da ostavite skin unesite slot na koji ga zelite ostavit {FF5330}[0-4].", "Ostavi", "Cancel");
		if(slot < 0 || slot > 4)
		  return Dialog_Show(playerid, House_Clothes_Choose_Dialog, DSI, "{FFD000}CLOTHES - {FFFFFF}PUT", "{FFFFFF}Ostavljanje odjece u kucu.\n\n{FFFFFF}Da ostavite skin unesite slot na koji ga zelite ostavit {FF5330}[0-4].", "Ostavi", "Cancel");
		if(HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][slot] != 0)
		  return GRESKA(playerid,"Vec imate odjecu na ovom slotu!");
		if(HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][slot] == GetPlayerSkin(playerid))
		  return GRESKA(playerid,"Vec imate ovu odjecu u kuci!");  

		HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][slot] = GetPlayerSkin(playerid);
		
		Player_Enum[playerid][p_Skin] = 0; SetPlayerSkin(playerid, 0);

		INFO(playerid,"Uspesno ste ostavili odjecu u svojoj kuci na slot broj: %d",slot);
		Save_House(i);      
	}
	return (true);
}

Dialog:House_Clotes_Take(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new slot;
		new i = Choosed_House[playerid];

		if(sscanf(inputtext, "i",slot))
		  return Dialog_Show(playerid, House_Clotes_Take, DSI, "{FFD000}CLOTHES - {FFFFFF}TAKE", "{FFFFFF}Uzimanje odjece u kuci.\n\n{FFFFFF}Da uzmete odjecu unesite slot sa kojeg zelite uzeti odjecu {FF5330}[0-4].", "Uzmi", "Cancel");
		if(slot < 0 || slot > 4)
		  return Dialog_Show(playerid, House_Clotes_Take, DSI, "{FFD000}CLOTHES - {FFFFFF}TAKE", "{FFFFFF}Uzimanje odjece u kuci.\n\n{FFFFFF}Da uzmete odjecu unesite slot sa kojeg zelite uzeti odjecu {FF5330}[0-4].", "Uzmi", "Cancel");
        if(HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][slot] == 0)
		  return GRESKA(playerid,"Nemate odjecu na ovom slotu!");

		Player_Enum[playerid][p_Skin] = HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][slot];
		SetPlayerSkin(playerid, Player_Enum[playerid][p_Skin]); 

		HOUSE_ENUM[i][H_STORAGE][H_CLOTHES][slot] = 0;

		INFO(playerid,"Uspesno ste uzeli odjecu iz svoje kuce sa slota: %d",slot);
		ApplyAnimation(playerid,"CLOTHES","CLO_Pose_Watch",4.1,1,0,0,0,4000);

		Save_House(i);
	}
	return (true);
}

//=========================================================

Dialog:House_Rent_Dialog(playerid, response, listitem, inputtext[])
{
	static r_string[400],rent_string[300];

	new i = Choosed_House[playerid];

	if(response)
	{
		switch(listitem)
		{
             case 0:
             {
             	      format(r_string,sizeof(r_string),
                      "{FFFFFF}House Rentable: (%s{FFFFFF})\n\
                      {FFFFFF}Rent Price: (%s)\n\n\n\
                      {FFD000}Renter slot 1: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 2: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 3: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 4: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 5: {FFFFFF}(%s)",
                      (HOUSE_ENUM[i][H_RENTABLE]) ? ("Rentable") : ("{FF0000}Non rentable"),
                      FormatNumber(HOUSE_ENUM[i][H_RENT_PRICE]),
                      HOUSE_ENUM[i][H_RENTER_1],
                      HOUSE_ENUM[i][H_RENTER_2],
                      HOUSE_ENUM[i][H_RENTER_3],
                      HOUSE_ENUM[i][H_RENTER_4],
                      HOUSE_ENUM[i][H_RENTER_5]);
             	      Dialog_Show(playerid, Show_Only, DSM, "{FFD000}RENT {FFFFFF}- INFO", r_string, "IZLAZ", "");  r_string = "\0";
             }
             case 1:
             {
                      if (HOUSE_ENUM[i][H_RENTABLE] == 0)
			          {
				          	   HOUSE_ENUM[i][H_RENTABLE] = 1; Save_House(i);
				          	   INFO(playerid,"Uspesno ste omogucili rent u svojoj kuci.");
				          	   Dialog_Show(playerid, House_Rent_Dialog, DSL, "{FFD000}RENT - {FFFFFF}OPTIONS", "{FFFFFF}Rent info\nRentable\nRent Price\nRenter Kick", "Odaberi", "Cancel");
				           	   
			          }
			          else if (HOUSE_ENUM[i][H_RENTABLE] == 1)
			          {
			          	   HOUSE_ENUM[i][H_RENTABLE] = 0; Save_House(i);
			          	   INFO(playerid,"Uspesno ste onemogucili rent u svojoj kuci.");
			          	   Dialog_Show(playerid, House_Rent_Dialog, DSL, "{FFD000}RENT - {FFFFFF}OPTIONS", "{FFFFFF}Rent info\nRentable\nRent Price\nRenter Kick", "Odaberi", "Cancel");
			          }
             }
             case 2:
             {
             	      if (HOUSE_ENUM[i][H_RENTABLE] != 1)
             	        return GRESKA(playerid,"Niste omogucili rentanje svoje kuce!");
             	      Dialog_Show(playerid, House_Rent_Price, DSI, "{FFD000}RENT - {FFFFFF}PRICE", "{FFFFFF}Trenutna cijena renta: {FFD000}(%s).\n\n{FFFFFF}Da promenite cenu unesite novu u input.", "Unesi", "Cancel",FormatNumber(HOUSE_ENUM[i][H_RENT_PRICE])); 
             }
             case 3:
             {
                      if(HOUSE_ENUM[i][H_RENTERS_SLOT] == 0)
                        return GRESKA(playerid,"Niko nije iznajmio u vasoj kuci.");

                      format(rent_string,sizeof(rent_string),
                      "{FFD000}Renter slot 1: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 2: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 3: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 4: {FFFFFF}(%s)\n\
                      {FFD000}Renter slot 5: {FFFFFF}(%s)\n\n\
                      {FFFFFF}Da nekog izbacite iz svoje kuce unesite ime u input.",
                      HOUSE_ENUM[i][H_RENTER_1],HOUSE_ENUM[i][H_RENTER_2],HOUSE_ENUM[i][H_RENTER_3],HOUSE_ENUM[i][H_RENTER_4],HOUSE_ENUM[i][H_RENTER_5]);

                      Dialog_Show(playerid, House_Rent_Kick, DSI, "{FFD000}RENT {FFFFFF}- INFO", rent_string, "Nastavi", "Cancel"); 
                      rent_string = "\0";
             }
        }
    }   
    else { Dialog_Show(playerid, House_Dialog, DSL, "{FFD000}HOUSE - {FFFFFF}OPTIONS", "{FFFFFF}Info\nLock\nLights\nRent Options\nSell\nStorage\nClothes\nFurniture", "Odaberi", "Cancel"); }      
    return (true);         
}

Dialog:House_Rent_Price(playerid, response, listitem, inputtext[])
{
	new i = Choosed_House[playerid];
	if(response)
	{
		new price;
		if(sscanf(inputtext, "i",price))
		  return Dialog_Show(playerid, House_Rent_Price_Dialog, DSI, "{FFD000}RENT - {FFFFFF}PRICE", "{FFFFFF}Trenutna cijena renta: {FFD000}(%s).\n\n{FFFFFF}Da promenite cenu unesite novu u input.", "Unesi", "Cancel");
		if(price < 1)
		  return Dialog_Show(playerid, House_Rent_Price_Dialog, DSI, "{FFD000}RENT - {FFFFFF}PRICE", "{FFFFFF}Trenutna cijena renta: {FFD000}(%s).\n\n{FFFFFF}Da promenite cenu unesite novu u input.", "Unesi", "Cancel");
        
        HOUSE_ENUM[i][H_RENT_PRICE] = price;
        Save_House(i);

        INFO(playerid,"Uspesno ste promenili cenu renta kuce u (%s).",FormatNumber(HOUSE_ENUM[i][H_RENT_PRICE]));
        Dialog_Show(playerid, House_Rent_Dialog, DSL, "{FFD000}RENT - {FFFFFF}OPTIONS", "{FFFFFF}Rent info\nRentable\nRent Price\nRenter Kick", "Odaberi", "Cancel");
	}
	else
    Dialog_Show(playerid, House_Rent_Dialog, DSL, "{FFD000}RENT - {FFFFFF}OPTIONS", "{FFFFFF}Rent info\nRentable\nRent Price\nRenter Kick", "Odaberi", "Cancel");
	return (true);
}

Dialog:House_Rent_Kick(playerid, response, listitem, inputtext[])
{
    if(response)
    {
     	 static name[32],rent_string[300];
     	 new i = Choosed_House[playerid];

	     if(sscanf(inputtext, "s[32]",name))
	     {
	     	 format(rent_string,sizeof(rent_string),
	     	 "{FFD000}Renter slot 1: {FFFFFF}(%s)\n\
	         {FFD000}Renter slot 2: {FFFFFF}(%s)\n\
	         {FFD000}Renter slot 3: {FFFFFF}(%s)\n\
	         {FFD000}Renter slot 4: {FFFFFF}(%s)\n\
	         {FFD000}Renter slot 5: {FFFFFF}(%s)\n\n\
	         {FFFFFF}Da nekog izbacite iz svoje kuce unesite ime u input.",
	         HOUSE_ENUM[i][H_RENTER_1],
	         HOUSE_ENUM[i][H_RENTER_2],
	         HOUSE_ENUM[i][H_RENTER_3],
	         HOUSE_ENUM[i][H_RENTER_4],
	         HOUSE_ENUM[i][H_RENTER_5]);
	         Dialog_Show(playerid, House_Rent_Kick, DSI, "{FFD000}RENT {FFFFFF}- INFO", rent_string, "Nastavi", "Cancel"); rent_string = "\0"; name = "\0";
	         return (true);
	     }
	     if(GetPlayerIdFromName(name) == IPI)
             return GRESKA(playerid,"Igrac nije na serveru.");

	     if (!strcmp(HOUSE_ENUM[i][H_RENTER_1], name, true))
	     {
	     	 HOUSE_ENUM[i][H_RENTERS_SLOT] --;
	     	 INFO(playerid,"Uspesno ste izbacili %s iz svoje kuce.",GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_1]));

	     	 INFO(GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_1]),"%s vas je izbacio iz svoje kuce.",GetName(playerid));
	     	 SetString(HOUSE_ENUM[i][H_RENTER_1],"Niko");
	     	 Player_Enum[GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_1])][p_Property_Rent] = 9999;
	     }
	     else if (!strcmp(HOUSE_ENUM[i][H_RENTER_2], name, true))
	     {
	     	 HOUSE_ENUM[i][H_RENTERS_SLOT] --;
	     	 INFO(playerid,"Uspesno ste izbacili %s iz svoje kuce.",GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_2]));

	     	 INFO(GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_2]),"%s vas je izbacio iz svoje kuce.",GetName(playerid));
	     	 SetString(HOUSE_ENUM[i][H_RENTER_2],"Niko");
	     	 Player_Enum[GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_3])][p_Property_Rent] = 9999;
	     }
	     else if (!strcmp(HOUSE_ENUM[i][H_RENTER_3], name, true))
	     {
	     	 HOUSE_ENUM[i][H_RENTERS_SLOT] --;
	     	 INFO(playerid,"Uspesno ste izbacili %s iz svoje kuce.",GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_3]));

	     	 INFO(GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_3]),"%s vas je izbacio iz svoje kuce.",GetName(playerid));
	     	 SetString(HOUSE_ENUM[i][H_RENTER_3],"Niko");
	     	 Player_Enum[GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_3])][p_Property_Rent] = 9999;
	     }
	     else if (!strcmp(HOUSE_ENUM[i][H_RENTER_4], name, true))
	     {
	     	 HOUSE_ENUM[i][H_RENTERS_SLOT] --;
	     	 INFO(playerid,"Uspesno ste izbacili %s iz svoje kuce.",GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_4]));

	     	 INFO(GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_4]),"%s vas je izbacio iz svoje kuce.",GetName(playerid));
	     	 SetString(HOUSE_ENUM[i][H_RENTER_4],"Niko");
	     	 Player_Enum[GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_4])][p_Property_Rent] = 9999;
	     }
	     else if (!strcmp(HOUSE_ENUM[i][H_RENTER_5], name, true))
	     {
	     	 HOUSE_ENUM[i][H_RENTERS_SLOT] --;
	     	 INFO(playerid,"Uspesno ste izbacili %s iz svoje kuce.",GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_5]));

	     	 INFO(GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_5]),"%s vas je izbacio iz svoje kuce.",GetName(playerid));
	     	 SetString(HOUSE_ENUM[i][H_RENTER_5],"Niko");
	     	 Player_Enum[GetPlayerIdFromName(HOUSE_ENUM[i][H_RENTER_5])][p_Property_Rent] = 9999;
	     }
	     Save_House(i);
	}  
	return (true);   
}

//================================================================

stock House_WeaponStorage(playerid, houseid)
{
	if(houseid == -1 || HOUSE_ENUM[houseid][H_CREATED] != 1)
	    return (false);

	static string[320];

	string[0] = 0;

	for (new i = 0; i < 10; i ++)
	{
	    if (!HOUSE_ENUM[houseid][H_STORAGE][H_WEAPON][i])
	        format(string, sizeof(string), "%sPrazan slot\n", string);

		else
			format(string, sizeof(string), "%s%s (Municija: %d)\n", string, ReturnWeaponName(HOUSE_ENUM[houseid][H_STORAGE][H_WEAPON][i]), HOUSE_ENUM[houseid][H_STORAGE][H_AMMO][i]);
	}
	Dialog_Show(playerid, House_Weapons_Dialog, DIALOG_STYLE_LIST, "{FFD000}HOUSE - {FFFFFF}WEAPON STORAGE", string, "Choose", "Cancel"); string = "\0";
	return (true);
}

//=========================================================

function Delete_House(houseid)
{
	if (houseid != -1 && HOUSE_ENUM[houseid][H_CREATED] != (0))
	{
		if(IsValidDynamicPickup(HOUSE_ENUM[houseid][H_PICKUP]))
		    DestroyDynamicPickup(HOUSE_ENUM[houseid][H_PICKUP]);

		if(IsValidDynamicMapIcon(HOUSE_ENUM[houseid][H_MAP_ICON]))
		    DestroyDynamicMapIcon(HOUSE_ENUM[houseid][H_MAP_ICON]);

		HOUSE_ENUM[houseid][H_CREATED] = 0;
		HOUSE_ENUM[houseid][H_ID] = -1;    
	}
	return (true);	    
}

//=========================================================

stock GetFree_HouseID()
{
	new HouseID = Iter_Free(Loaded_Houses_Array);
	return ((HouseID < MAX_HOUSES) ? (HouseID) : (-1));
}

//=========================================================

stock Add_Base_House(houseID,Owner[],Price)
{
	static query[230];
	format(query, sizeof(query), "INSERT INTO `ug_houses` (`H_ID`, `H_OWNER`, `H_PRICE`) VALUES(%d, '%s', %d)",houseID, Owner,Price);
    mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";
    return (true);
}

stock Create_House(hID,playerid,price,Float:x,Float:y,Float:z,Float:a)
{
	    static Float:pPos[4];

		GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]); 
		GetPlayerFacingAngle(playerid, pPos[3]);

		if(HOUSE_ENUM[hID][H_CREATED] != 1)
		{
                HOUSE_ENUM[hID][H_INT_POS][0] = x;
                HOUSE_ENUM[hID][H_INT_POS][1] = y;
                HOUSE_ENUM[hID][H_INT_POS][2] = z;
                HOUSE_ENUM[hID][H_INT_POS][3] = a;
					
				HOUSE_ENUM[hID][H_ID] = hID;
				HOUSE_ENUM[hID][H_CREATED] = (1);
				HOUSE_ENUM[hID][H_PRICE] = (price);
				HOUSE_ENUM[hID][H_PASSWORD_PROTECT] = (0);

				HOUSE_ENUM[hID][H_RENTABLE] = (false);
				HOUSE_ENUM[hID][H_LOCKED] = (false);
				HOUSE_ENUM[hID][H_LIGHTS] = (false);

                HOUSE_ENUM[hID][H_POS][0] = pPos[0];
                HOUSE_ENUM[hID][H_POS][1] = pPos[1];
                HOUSE_ENUM[hID][H_POS][2] = pPos[2];
                HOUSE_ENUM[hID][H_POS][3] = pPos[3];

                HOUSE_ENUM[hID][H_INTERIOR] = hID + 1;
                HOUSE_ENUM[hID][H_EXTERIOR] = hID + 1;
                HOUSE_ENUM[hID][H_EXTERIOR_VW] = GetPlayerVirtualWorld(playerid);

                SetString(HOUSE_ENUM[hID][H_OWNER],"Nema");
                SetString(HOUSE_ENUM[hID][H_RENTER_1],"Niko");
                SetString(HOUSE_ENUM[hID][H_RENTER_2],"Niko");
                SetString(HOUSE_ENUM[hID][H_RENTER_3],"Niko");
                SetString(HOUSE_ENUM[hID][H_RENTER_4],"Niko");
                SetString(HOUSE_ENUM[hID][H_RENTER_5],"Niko");

                House_Refresh(hID); Save_House(hID);

		}
	    return (-1);
}

//=========================================================

stock Exit_House(playerid,id)
{
	   SetPlayerPos(playerid,HOUSE_ENUM[id][H_POS][0],HOUSE_ENUM[id][H_POS][1],HOUSE_ENUM[id][H_POS][2]);
       SetPlayerFacingAngle(playerid,HOUSE_ENUM[id][H_POS][3]);

       SetPlayerInterior(playerid,0);
       SetPlayerVirtualWorld(playerid,HOUSE_ENUM[id][H_EXTERIOR_VW]);

       SetCameraBehindPlayer(playerid); Entered_House[playerid] = (-1);

       PlayerTextDrawHide(playerid, House_L_TD[playerid]);

       TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);
       return (true);
}                

//=========================================================

stock House_Refresh(houseid)
{
	if (houseid != -1 && HOUSE_ENUM[houseid][H_CREATED] != (0))
	{
		if(IsValidDynamicPickup(HOUSE_ENUM[houseid][H_PICKUP]))
		    DestroyDynamicPickup(HOUSE_ENUM[houseid][H_PICKUP]);

		if(IsValidDynamicMapIcon(HOUSE_ENUM[houseid][H_MAP_ICON]))
		    DestroyDynamicMapIcon(HOUSE_ENUM[houseid][H_MAP_ICON]);

		if(IsValidDynamic3DTextLabel(HOUSE_ENUM[houseid][H_LABEL]))
		    DestroyDynamic3DTextLabel(HOUSE_ENUM[houseid][H_LABEL]);    

        static string[160];

		if(HOUSE_ENUM[houseid][H_OWNED] != (1)){
			format(string,sizeof(string),"{00FF1E}Kuca na prodaju.\n{00FF1E}Adresa: {FFFFFF}LS-%d\n{00FF1E}Cijena: {FFFFFF}%s\n{00FF1E}Ako zelite kupiti ovu kucu kucajte {FFFFFF}/buyhouse.",houseid,FormatNumber(HOUSE_ENUM[houseid][H_PRICE]));
			HOUSE_ENUM[houseid][H_PICKUP] = CreateDynamicPickup(1273, 23, HOUSE_ENUM[houseid][H_POS][0], HOUSE_ENUM[houseid][H_POS][1], HOUSE_ENUM[houseid][H_POS][2], HOUSE_ENUM[houseid][H_EXTERIOR_VW], 0);
		    HOUSE_ENUM[houseid][H_LABEL] = CreateDynamic3DTextLabel(string, 0x33AA33FF, HOUSE_ENUM[houseid][H_POS][0], HOUSE_ENUM[houseid][H_POS][1], HOUSE_ENUM[houseid][H_POS][2] + 0.7, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HOUSE_ENUM[houseid][H_EXTERIOR_VW], 0);
		}
		else{
			format(string, sizeof(string),"{00FF1E}Adresa: {FFFFFF}LS-%d\n{00FF1E}Vlasnik: {FFFFFF}%s",houseid,HOUSE_ENUM[houseid][H_OWNER]);
			HOUSE_ENUM[houseid][H_PICKUP] = CreateDynamicPickup(1559, 23, HOUSE_ENUM[houseid][H_POS][0], HOUSE_ENUM[houseid][H_POS][1], HOUSE_ENUM[houseid][H_POS][2], HOUSE_ENUM[houseid][H_EXTERIOR_VW], 0);
		    HOUSE_ENUM[houseid][H_LABEL] = CreateDynamic3DTextLabel(string, 0x33AA33FF, HOUSE_ENUM[houseid][H_POS][0], HOUSE_ENUM[houseid][H_POS][1], HOUSE_ENUM[houseid][H_POS][2], 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HOUSE_ENUM[houseid][H_EXTERIOR_VW], 0);
		}
        HOUSE_ENUM[houseid][H_MAP_ICON] = CreateDynamicMapIcon(HOUSE_ENUM[houseid][H_POS][0], HOUSE_ENUM[houseid][H_POS][1], HOUSE_ENUM[houseid][H_POS][2], (HOUSE_ENUM[houseid][H_OWNED] != 0) ? (32) : (31), 0, HOUSE_ENUM[houseid][H_EXTERIOR_VW], 0);    
	}
	return (true);
}

stock House_Nearest(playerid)
{
    for(new i = 0; i != MAX_HOUSES; i ++) if (HOUSE_ENUM[i][H_CREATED] && IsPlayerInRangeOfPoint(playerid, 2.5, HOUSE_ENUM[i][H_POS][0], HOUSE_ENUM[i][H_POS][1], HOUSE_ENUM[i][H_POS][2]))
	{
		if (GetPlayerVirtualWorld(playerid) == HOUSE_ENUM[i][H_EXTERIOR_VW])
			return (i);
	}
	return (-1);
}

stock House_Inside(playerid)
{
	if(Entered_House[playerid] != (-1))
	{
	    for (new i = 0; i != MAX_HOUSES; i ++) if (HOUSE_ENUM[i][H_CREATED] && GetPlayerInterior(playerid) == HOUSE_ENUM[i][H_INTERIOR] && GetPlayerVirtualWorld(playerid) == HOUSE_ENUM[i][H_EXTERIOR]) {
	        return (i);
		}
	}
	return (-1);
}

stock House_IsOwner(playerid, houseid)
{
   if ((HOUSE_ENUM[houseid][H_CREATED] && HOUSE_ENUM[houseid][H_OWNED] != 0) && !strcmp(HOUSE_ENUM[houseid][H_OWNER], GetName(playerid), true))
        return (true);
        
   return (false);
}

//==========================================================

stock Save_House(hID)
{
	static query[2028];

	format(query,sizeof(query),"UPDATE `ug_houses` SET `H_OWNER` = '%s', `H_PRICE` = '%d', `H_LIGHTS` = '%d', `H_LOCKED` = '%d', `H_OWNED` = '%d', `H_POS1` = '%.4f', `H_POS2` = '%.4f', `H_POS3` = '%.4f', `H_POS4` = '%.4f'",
	HOUSE_ENUM[hID][H_OWNER],
	HOUSE_ENUM[hID][H_PRICE],
	HOUSE_ENUM[hID][H_LIGHTS],
	HOUSE_ENUM[hID][H_LOCKED],
	HOUSE_ENUM[hID][H_OWNED],
	HOUSE_ENUM[hID][H_POS][0],
	HOUSE_ENUM[hID][H_POS][1],
	HOUSE_ENUM[hID][H_POS][2],
	HOUSE_ENUM[hID][H_POS][3]);
	format(query,sizeof(query),"%s, `H_RENTABLE` = '%d', `H_RENT_PRICE` = '%d', `H_WEED` = '%d', `H_COCAIN` = '%d', `H_LSD` = '%d', `H_MATERIALS` = '%d', `H_MONEY` = '%d', `H_INTERIOR` = '%d', `H_EXTERIOR` = '%d', `H_EXTERIOR_VW` = '%d', `H_PASSWORD` = '%s', `H_PASSWORD_PROTECT` = '%d', `H_RENTERS_SLOT` = '%d'",
	query,
	HOUSE_ENUM[hID][H_RENTABLE],
	HOUSE_ENUM[hID][H_RENT_PRICE],
	HOUSE_ENUM[hID][H_STORAGE][H_WEED],
	HOUSE_ENUM[hID][H_STORAGE][H_COCAIN],
	HOUSE_ENUM[hID][H_STORAGE][H_LSD],
	HOUSE_ENUM[hID][H_STORAGE][H_MATERIALS],
	HOUSE_ENUM[hID][H_STORAGE][H_MONEY],
	HOUSE_ENUM[hID][H_INTERIOR],
	HOUSE_ENUM[hID][H_EXTERIOR],
	HOUSE_ENUM[hID][H_EXTERIOR_VW],
	HOUSE_ENUM[hID][H_PASSWORD],
	HOUSE_ENUM[hID][H_PASSWORD_PROTECT],
	HOUSE_ENUM[hID][H_RENTERS_SLOT]);

	for (new i = 0; i < 5; i ++) {
	  format(query, sizeof(query), "%s, `H_CLOTHES%d` = '%d'",query,i + 1, HOUSE_ENUM[hID][H_STORAGE][H_CLOTHES][i]); }

	for (new j = 0; j < 10; j ++) {
	  format(query, sizeof(query), "%s, `H_WEAPON%d` = '%d', `H_AMMO%d` = '%d'",query,j + 1,HOUSE_ENUM[hID][H_STORAGE][H_WEAPON][j],j + 1,HOUSE_ENUM[hID][H_STORAGE][H_AMMO][j]); }

	format(query,sizeof(query),"%s,	`H_INT_POS1` = '%.4f', `H_INT_POS2` = '%.4f', `H_INT_POS3` = '%.4f', `H_INT_POS4` = '%.4f', `H_RENTERS1` = '%s', `H_RENTERS2` = '%s', `H_RENTERS3` = '%s', `H_RENTERS4` = '%s', `H_RENTERS5` = '%s' WHERE `H_ID` = '%d'",
	query,
	HOUSE_ENUM[hID][H_INT_POS][0],
	HOUSE_ENUM[hID][H_INT_POS][1],
	HOUSE_ENUM[hID][H_INT_POS][2],
	HOUSE_ENUM[hID][H_INT_POS][3],
	HOUSE_ENUM[hID][H_RENTER_1],
	HOUSE_ENUM[hID][H_RENTER_2],
	HOUSE_ENUM[hID][H_RENTER_3],
	HOUSE_ENUM[hID][H_RENTER_4],
	HOUSE_ENUM[hID][H_RENTER_5],hID);
	return mysql_function_query(_dbConnector, query, false, "", "");	
}

//=================================================================

function Load_Houses()
{
	static rows,fields,var_load[24],str[128];
	cache_get_data(rows, fields, _dbConnector);

	for (new hID = 0; hID < rows; hID ++) if (hID < MAX_HOUSES)
	{
		HOUSE_ENUM[hID][H_CREATED] = (1);

		cache_get_field_content(hID, "H_OWNER", HOUSE_ENUM[hID][H_OWNER], _dbConnector);

		cache_get_field_content(hID, "H_RENTERS1", HOUSE_ENUM[hID][H_RENTER_1], _dbConnector);
		cache_get_field_content(hID, "H_RENTERS2", HOUSE_ENUM[hID][H_RENTER_2], _dbConnector);
		cache_get_field_content(hID, "H_RENTERS3", HOUSE_ENUM[hID][H_RENTER_3], _dbConnector);
		cache_get_field_content(hID, "H_RENTERS4", HOUSE_ENUM[hID][H_RENTER_4], _dbConnector);
		cache_get_field_content(hID, "H_RENTERS5", HOUSE_ENUM[hID][H_RENTER_5], _dbConnector);

		cache_get_field_content(hID, "H_ID", var_load); HOUSE_ENUM[hID][H_ID] = strval(var_load);
		cache_get_field_content(hID, "H_PRICE",var_load); HOUSE_ENUM[hID][H_PRICE] = strval(var_load);
		cache_get_field_content(hID, "H_LIGHTS", var_load); HOUSE_ENUM[hID][H_LIGHTS] = strval(var_load);
		cache_get_field_content(hID, "H_LOCKED", var_load); HOUSE_ENUM[hID][H_LOCKED] = strval(var_load);
		cache_get_field_content(hID, "H_OWNED", var_load); HOUSE_ENUM[hID][H_OWNED] = strval(var_load);
		cache_get_field_content(hID, "H_RENTABLE", var_load); HOUSE_ENUM[hID][H_RENTABLE] = strval(var_load);
		cache_get_field_content(hID, "H_RENT_PRICE",var_load); HOUSE_ENUM[hID][H_RENT_PRICE] = strval(var_load);

		cache_get_field_content(hID, "H_WEED", var_load); HOUSE_ENUM[hID][H_STORAGE][H_WEED] = strval(var_load);
		cache_get_field_content(hID, "H_COCAIN",var_load); HOUSE_ENUM[hID][H_STORAGE][H_COCAIN] = strval(var_load);
		cache_get_field_content(hID, "H_LSD", var_load); HOUSE_ENUM[hID][H_STORAGE][H_LSD] = strval(var_load);
		cache_get_field_content(hID, "H_MATERIALS", var_load); HOUSE_ENUM[hID][H_STORAGE][H_MATERIALS] = strval(var_load);
		cache_get_field_content(hID, "H_MONEY", var_load); HOUSE_ENUM[hID][H_STORAGE][H_MONEY] = strval(var_load);

		cache_get_field_content(hID, "H_INTERIOR", var_load); HOUSE_ENUM[hID][H_INTERIOR] = strval(var_load);
		cache_get_field_content(hID, "H_EXTERIOR", var_load); HOUSE_ENUM[hID][H_EXTERIOR] = strval(var_load);
		cache_get_field_content(hID, "H_EXTERIOR_VW", var_load); HOUSE_ENUM[hID][H_EXTERIOR_VW] = strval(var_load);

		cache_get_field_content(hID, "H_PASSWORD", HOUSE_ENUM[hID][H_PASSWORD], _dbConnector);
		cache_get_field_content(hID, "H_PASSWORD_PROTECT", var_load); HOUSE_ENUM[hID][H_PASSWORD_PROTECT] = strval(var_load);

		cache_get_field_content(hID, "H_RENTERS_SLOT", var_load); HOUSE_ENUM[hID][H_RENTERS_SLOT] = strval(var_load);

		cache_get_field_content(hID, "H_POS1", var_load); HOUSE_ENUM[hID][H_POS][0] = floatstr(var_load);
		cache_get_field_content(hID, "H_POS2", var_load); HOUSE_ENUM[hID][H_POS][1] = floatstr(var_load);
		cache_get_field_content(hID, "H_POS3", var_load); HOUSE_ENUM[hID][H_POS][2] = floatstr(var_load);
		cache_get_field_content(hID, "H_POS4", var_load); HOUSE_ENUM[hID][H_POS][3] = floatstr(var_load);

		cache_get_field_content(hID, "H_INT_POS1", var_load); HOUSE_ENUM[hID][H_INT_POS][0] = floatstr(var_load);
		cache_get_field_content(hID, "H_INT_POS2", var_load); HOUSE_ENUM[hID][H_INT_POS][1] = floatstr(var_load);
		cache_get_field_content(hID, "H_INT_POS3", var_load); HOUSE_ENUM[hID][H_INT_POS][2] = floatstr(var_load);
		cache_get_field_content(hID, "H_INT_POS4", var_load); HOUSE_ENUM[hID][H_INT_POS][3] = floatstr(var_load);

		//------------------------------------------------------------------------------

		for (new j = 0; j < 10; j ++)
		{
            format(var_load, 24, "H_WEAPON%d", j + 1);
            HOUSE_ENUM[hID][H_STORAGE][H_WEAPON][j] = cache_get_field_kurac(hID, var_load);

            format(var_load, 24, "H_AMMO%d", j + 1);
            HOUSE_ENUM[hID][H_STORAGE][H_AMMO][j] = cache_get_field_kurac(hID, var_load);
		}
		for (new k = 0; k < 5; k ++)
		{
			format(var_load, 24, "H_CLOTHES%d", k + 1);
            HOUSE_ENUM[hID][H_STORAGE][H_CLOTHES][k] = cache_get_field_kurac(hID, var_load);
		}

		//-----------------------------------------------------------------------------

		House_Refresh(hID);
        Iter_Add(Loaded_Houses_Array,hID);

		//-----------------------------------------------------------------------------

		for (new i = 0; i < MAX_HOUSES; i ++) if (HOUSE_ENUM[i][H_CREATED]) {
              format(str, sizeof(str), "SELECT * FROM `ug_furniture` WHERE `ID` = '%d'", HOUSE_ENUM[i][H_ID]);
		      mysql_function_query(_dbConnector, str, true, "OnLoadFurniture", "d", i);
		}
	}
	return (true);
}

//==================================================================

stock Furniture_Add(houseid, name[], modelid)
{
	static string[64],id = -1;

	if((id = Furniture_GetFreeID()) != -1)
	{
		 FurnitureData[id][furnitureExists] = true;
	     SetString(FurnitureData[id][furnitureName],name);

         FurnitureData[id][furnitureHouse] = houseid;
	     FurnitureData[id][furnitureModel] = modelid; 

	     format(string, sizeof(string), "INSERT INTO `ug_furniture` (`ID`) VALUES (%d)", HOUSE_ENUM[houseid][H_ID]);
		 mysql_function_query(_dbConnector, string, false, "OnFurnitureCreated", "d", id);
		 return (id);
	}
	return (-1);    
}

stock Furniture_Refresh(furnitureid)
{
	if (furnitureid != -1 && FurnitureData[furnitureid][furnitureExists])
	{
	        if(IsValidDynamicObject(FurnitureData[furnitureid][furnitureObject]))
	           DestroyDynamicObject(FurnitureData[furnitureid][furnitureObject]);

	        FurnitureData[furnitureid][furnitureObject] = CreateDynamicObject(
			FurnitureData[furnitureid][furnitureModel],
			FurnitureData[furnitureid][furniturePos][0],
			FurnitureData[furnitureid][furniturePos][1],
			FurnitureData[furnitureid][furniturePos][2],
			FurnitureData[furnitureid][furnitureRot][0],
			FurnitureData[furnitureid][furnitureRot][1],
			FurnitureData[furnitureid][furnitureRot][2],
			HOUSE_ENUM[FurnitureData[furnitureid][furnitureHouse]][H_EXTERIOR],
			HOUSE_ENUM[FurnitureData[furnitureid][furnitureHouse]][H_INTERIOR]);
	}
	return (true);
}

stock Update_Furniture(furnitureid,Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0)
{
	        if(IsValidDynamicObject(FurnitureData[furnitureid][furnitureObject]))
	           DestroyDynamicObject(FurnitureData[furnitureid][furnitureObject]);

	        FurnitureData[furnitureid][furniturePos][0] = x;
			FurnitureData[furnitureid][furniturePos][1] = y;
			FurnitureData[furnitureid][furniturePos][2] = z;
			FurnitureData[furnitureid][furnitureRot][0] = rx;
			FurnitureData[furnitureid][furnitureRot][1] = ry;
			FurnitureData[furnitureid][furnitureRot][2] = rz;

	        FurnitureData[furnitureid][furnitureObject] = CreateDynamicObject(
			FurnitureData[furnitureid][furnitureModel],
			FurnitureData[furnitureid][furniturePos][0],
			FurnitureData[furnitureid][furniturePos][1],
			FurnitureData[furnitureid][furniturePos][2],
			FurnitureData[furnitureid][furnitureRot][0],
			FurnitureData[furnitureid][furnitureRot][1],
			FurnitureData[furnitureid][furnitureRot][2],
			HOUSE_ENUM[FurnitureData[furnitureid][furnitureHouse]][H_EXTERIOR],
			HOUSE_ENUM[FurnitureData[furnitureid][furnitureHouse]][H_INTERIOR]);
}

stock Furniture_Save(furnitureid)
{
	static
	    string[400];

	format(string, sizeof(string), "UPDATE `ug_furniture` SET `furnitureModel` = '%d', `furnitureName` = '%s', `furnitureSpawned` = '%d', `furnitureX` = '%.4f', `furnitureY` = '%.4f', `furnitureZ` = '%.4f', `furnitureRX` = '%.4f', `furnitureRY` = '%.4f', `furnitureRZ` = '%.4f' WHERE `ID` = '%d' AND `furnitureID` = '%d'",
	    FurnitureData[furnitureid][furnitureModel],
	    FurnitureData[furnitureid][furnitureName],
	    FurnitureData[furnitureid][furnitureSpawned],
	    FurnitureData[furnitureid][furniturePos][0],
	    FurnitureData[furnitureid][furniturePos][1],
	    FurnitureData[furnitureid][furniturePos][2],
	    FurnitureData[furnitureid][furnitureRot][0],
	    FurnitureData[furnitureid][furnitureRot][1],
	    FurnitureData[furnitureid][furnitureRot][2],
	    HOUSE_ENUM[FurnitureData[furnitureid][furnitureHouse]][H_ID],
	    FurnitureData[furnitureid][furnitureID]
	);
	return mysql_function_query(_dbConnector, string, false, "", "");
}

stock Furniture_Delete(furnitureid)
{
	static
	    string[72];

	if (furnitureid != -1 && FurnitureData[furnitureid][furnitureExists])
	{
	    format(string, sizeof(string), "DELETE FROM `ug_furniture` WHERE `ID` = '%d' AND `furnitureID` = '%d'", HOUSE_ENUM[FurnitureData[furnitureid][furnitureHouse]][H_ID], FurnitureData[furnitureid][furnitureID]);
		mysql_function_query(_dbConnector, string, false, "", "");

		FurnitureData[furnitureid][furnitureExists] = false;
		FurnitureData[furnitureid][furnitureModel] = 0;

		DestroyDynamicObject(FurnitureData[furnitureid][furnitureObject]);
	}
	return (true);
}

stock Furniture_GetFreeID()
{
	for (new i = 0; i != MAX_FURNITURE; i ++) if (!FurnitureData[i][furnitureExists]) {
	    return (i);
	}
	return (-1);
}

stock Furniture_GetCount(houseid)
{
	new count;

	for (new i = 0; i < MAX_FURNITURE; i ++) if (FurnitureData[i][furnitureExists] && FurnitureData[i][furnitureHouse] == houseid) {
	    count++;
	}
	return (count);
}

function OnFurnitureCreated(furnitureid)
{
	FurnitureData[furnitureid][furnitureID] = mysql_insert_id();
	Furniture_Save(furnitureid);
	return (true);
}

function OnLoadFurniture(houseid)
{
	static
	    rows,
	    fields,
		id = -1;

	cache_get_data(rows, fields, _dbConnector);

	for (new i = 0; i != rows; i ++) if ((id = Furniture_GetFreeID()) != -1) {
	    FurnitureData[id][furnitureExists] = true;
	    FurnitureData[id][furnitureHouse] = houseid;
	    FurnitureData[id][furnitureSpawned] = 1;

	    cache_get_field_content(i, "furnitureName", FurnitureData[id][furnitureName], _dbConnector);

	    FurnitureData[id][furnitureID] = cache_get_field_kurac(i, "furnitureID");
	    FurnitureData[id][furnitureModel] = cache_get_field_kurac(i, "furnitureModel");
	    FurnitureData[id][furnitureSpawned] = cache_get_field_kurac(i, "furnitureSpawned");
	    FurnitureData[id][furniturePos][0] = cache_get_field_kurton(i, "furnitureX");
	    FurnitureData[id][furniturePos][1] = cache_get_field_kurton(i, "furnitureY");
	    FurnitureData[id][furniturePos][2] = cache_get_field_kurton(i, "furnitureZ");
	    FurnitureData[id][furnitureRot][0] = cache_get_field_kurton(i, "furnitureRX");
	    FurnitureData[id][furnitureRot][1] = cache_get_field_kurton(i, "furnitureRY");
	    FurnitureData[id][furnitureRot][2] = cache_get_field_kurton(i, "furnitureRZ");

        if(FurnitureData[id][furnitureSpawned] != 0){
        	Furniture_Refresh(id);
        }
	}
	return (true);
}

//=====================================================================================