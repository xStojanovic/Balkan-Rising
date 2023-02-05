
#include <YSI\y_hooks>

//========================================================
/*
                  Balkan Rising
                     0.0.1x
                  Business System
*/
//=========================================================

#define MAX_BUSINESSES (500)

#define FURNITURE_SHOP  (1)
#define AMMUNATION_SHOP (2)
#define RESTAURANT      (3)
#define MARKET_SHOP     (4)
#define BINCO_SHOP      (5)

#define MODEL_SELECTION_BIZ_VEHICLES (6)
#define MODEL_SELECTION_CLOTHES (8)

#define MAX_JOB_REQUESTS (10)

//=========================================================

new Entered_Business[MAX_PLAYERS] = (-1),
    Choosed_Business[MAX_PLAYERS] = (-1),
    Choosed_Biz_Options[MAX_PLAYERS] = (-1);

new Business_Options[MAX_PLAYERS][4];

new Inputed_Furniture_Model[MAX_PLAYERS] = (-1),
    Inputed_Furniture_Price[MAX_PLAYERS] = (-1);

new Editing_Item[MAX_PLAYERS] = (-1),
    Editing_Item_Name[MAX_PLAYERS][32 char];

new Buy_Model[MAX_PLAYERS] = INVALID_PLAYER_ID;         

new Business_Job_Requester[MAX_PLAYERS] = INVALID_PLAYER_ID;

new Business_Job_Accept[MAX_PLAYERS] = INVALID_PLAYER_ID;    

new Vehicle_Sell[MAX_PLAYERS][3];

//=========================================================

new Businesses_Buyable_Vehicles[10][2] =
{
   {609, 5000},
   {403, 10000},
   {414, 6000},
   {456, 8000},
   {498, 5000},
   {499, 4000},
   {514, 10000},
   {515, 15000},
   {435, 5000},
   {591, 5000}
};   

//=========================================================

enum BUSINESS_ENUM{
	BIZ_ID,
	BIZ_CREATED,
	BIZ_OWNED,
	BIZ_OWNER[MAX_PLAYER_NAME + 1],
	BIZ_NAME[32],
	BIZ_PASSWORD[16],
	BIZ_PRICE,
	BIZ_TYPE,
	BIZ_INTERIOR,
	BIZ_EXTERIOR,
	BIZ_EXTERIOR_VW,
	BIZ_LOCKED,
	BIZ_PASSWORD_PROTECT,
	BIZ_MONEY,
	BIZ_WORKERS_SLOT,
	BIZ_WORKERS_PAYDAY,
	BIZ_SHIPMENT,
	BIZ_PRODUCTS,
	BIZ_PRICES[20],

    BIZ_VEHICLE_CREATE,
    BIZ_VEHICLE_SPAWNED,
    BIZ_VEHICLE_MODEL,
    BIZ_VEHICLE_PRICE,
    BIZ_VEHICLE_ID,
    BIZ_VEHICLE_COLOR[2],
    BIZ_VEHICLE_OWNER[MAX_PLAYER_NAME + 1],
    Float:BIZ_VEHICLE_POS[4],

	BIZ_WORKER_1[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_2[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_3[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_4[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_5[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_6[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_7[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_8[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_9[MAX_PLAYER_NAME + 1],
	BIZ_WORKER_10[MAX_PLAYER_NAME + 1],

    BIZ_PICKUP,
	Text3D:BIZ_LABEL,
	Float:BIZ_POS[4],
	Float:BIZ_INT[4],

	BIZ_JOB_PICKUP,
	Text3D:BIZ_JOB_LABEL,
	Float:BIZ_JOB_POS[3],
	BIZ_JOB_PICKUP_ADDED,
};
new BIZ_ENUM[MAX_BUSINESSES][BUSINESS_ENUM];

//============================================================

enum BUSINESS_REQUEST{
   r_Exist,
   r_Name[MAX_PLAYER_NAME + 1],
   r_Message[60],
};
new BUSINESS_JOB_REQUEST[MAX_BUSINESSES][MAX_JOB_REQUESTS][BUSINESS_REQUEST];

//============================================================

new Iterator:Loaded_Business_Array<MAX_BUSINESSES>;

//============================================================

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    static id = (-1);
    if(PRESSED(KEY_SECONDARY_ATTACK))
    {
		if ((id = Business_Nearest(playerid)) != -1)
		{
			if(BIZ_ENUM[id][BIZ_PASSWORD_PROTECT] != (0))
			{
				Dialog_Show(playerid, Business_Protection_Code, DSI, "{FFFFFF}BUSINESS - PROTECTION","{FFFFFF}Ovaj biznis je zakljucan i posjeduje alarm protekciju.\nDa bi ste usli u nju potrebno je da deaktivirate alarm sa pristupnim kodom.\n\n{FC5805}Ako pogresite kod vlasnik ce biti obavesten!","Input","Cancel");
			    Entered_Business[playerid] = id;
			}
			else
			{
				 if(BIZ_ENUM[id][BIZ_LOCKED] != (0) && !Business_IsOwner(playerid, id))
				    return GRESKA(playerid,"Ovaj biznis je zakljucan.");

				 if(BIZ_ENUM[id][BIZ_TYPE] == FURNITURE_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy furniture use ~y~/buyfurniture.", 1500, 5);
				 } 
				 else if(BIZ_ENUM[id][BIZ_TYPE] == AMMUNATION_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy weapons use ~y~/buyweapon.", 1500, 5);
				 }
				 else if(BIZ_ENUM[id][BIZ_TYPE] == RESTAURANT || BIZ_ENUM[id][BIZ_TYPE] == MARKET_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy items use ~y~/buyitems.", 1500, 5);
				 }
				 else if(BIZ_ENUM[id][BIZ_TYPE] == BINCO_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy weapons use ~y~/buyclothes.", 1500, 5);
				 }     

				 SetPlayerPos(playerid,BIZ_ENUM[id][BIZ_INT][0],BIZ_ENUM[id][BIZ_INT][1],BIZ_ENUM[id][BIZ_INT][2]);
		         SetPlayerFacingAngle(playerid,BIZ_ENUM[id][BIZ_INT][3]);

		         SetPlayerInterior(playerid, BIZ_ENUM[id][BIZ_INTERIOR]);
				 SetPlayerVirtualWorld(playerid, BIZ_ENUM[id][BIZ_EXTERIOR]);

				 SetCameraBehindPlayer(playerid); Entered_Business[playerid] = id;

				 TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);    
			}
		}
		else if((id = Business_Inside(playerid)) != (-1) && IsPlayerInRangeOfPoint(playerid, 2.5, BIZ_ENUM[id][BIZ_INT][0],BIZ_ENUM[id][BIZ_INT][1],BIZ_ENUM[id][BIZ_INT][2]))
		{
			    if(BIZ_ENUM[id][BIZ_LOCKED] != (0) && !Business_IsOwner(playerid, id))
				    return GRESKA(playerid,"Ovaj biznis je zakljucan.");

				SetPlayerPos(playerid,BIZ_ENUM[id][BIZ_POS][0],BIZ_ENUM[id][BIZ_POS][1],BIZ_ENUM[id][BIZ_POS][2]);
		        SetPlayerFacingAngle(playerid,BIZ_ENUM[id][BIZ_POS][3]);

		        SetPlayerInterior(playerid,0);
		        SetPlayerVirtualWorld(playerid,BIZ_ENUM[id][BIZ_EXTERIOR_VW]);

		        SetCameraBehindPlayer(playerid); Entered_Business[playerid] = (-1);

				TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);
		}
    }	
    return (true);
}	

//============================================================

YCMD:makebusiness(playerid,params[],help)
{
	static price,type;

	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(GetPlayerInterior(playerid) != 0)
	    return GRESKA(playerid,"Vas interior mora biti 0.");
	if(sscanf(params, "id",price,type))
	{
		USAGE(playerid,"/makebusiness [Price] [Type]");
		INFO(playerid,"(1.Furniture shop) (2.Ammunation shop) (3.Restaurant) (4.Market)");
		INFO(playerid,"(5.Binco)");
		return (true);
	}      
	if(price < 1)
	    return GRESKA(playerid,"Cijena ne moze biti manja od 1$.");
	if(type < 1 || type > 10)
	    return USAGE(playerid,"/makebusiness [Price] [Type]");

	new bID = GetFree_BusinessID(); Iter_Add(Loaded_Business_Array,bID);
	
    Add_Base_Business(bID,"Nema",price);
    Create_Business(bID,playerid,price,type);

    INFO(playerid,"Uspesno ste kreirali biznis ID: %d",bID);
	return (true);
}

YCMD:deletebusiness(playerid,params[],help)
{
	static id,string[64];
	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "d", id))
	    return USAGE(playerid,"/deletebusiness [business ID]");
	if((id < 0 || id >= MAX_BUSINESSES) || !BIZ_ENUM[id][BIZ_CREATED])
	   return GRESKA(playerid,"Uneseni ID nije validan/registrovan.");
	
	format(string, sizeof(string), "DELETE FROM `ug_businesses` WHERE `BIZ_ID` = %d",id);
    mysql_function_query(_dbConnector, string, true, "Delete_Business", "i",BIZ_ENUM[id][BIZ_ID]); string = "\0";

    Iter_Remove(Loaded_Business_Array,id);
    INFO(playerid,"Uspesno ste obirsali firmu: %s ID: %d",BIZ_ENUM[id][BIZ_NAME],id);              
	return (true);
}

YCMD:buybusiness(playerid,params[],help)
{
	static id = (-1);
	new i[2];

	if ((id = Business_Nearest(playerid)) != (-1))
	{
		i[0] = Player_Enum[playerid][p_Property][2];
        i[1] = Player_Enum[playerid][p_Property][3];

        if(i[0] != 9999 && i[1] != 9999)
           return GRESKA(playerid,"Imate maximalan broj ownable biznisa 2/2");
        if(BIZ_ENUM[id][BIZ_OWNED] != (0))
           return GRESKA(playerid,"Ovaj biznis je vec kupljen.");
        if(Player_Enum[playerid][p_Money] < BIZ_ENUM[id][BIZ_PRICE]) 
           return GRESKA(playerid,"Nemate dovoljno nova za kupovinu ovog biznisa: ($%d).",BIZ_ENUM[id][BIZ_PRICE]);

        if(i[0] == 9999)  Player_Enum[playerid][p_Property][2] = id;
        else if(i[1] == 9999)  Player_Enum[playerid][p_Property][3] = id;

        Player_Enum[playerid][p_Money] -= BIZ_ENUM[id][BIZ_PRICE];
        GivePlayerMoney(playerid,-BIZ_ENUM[id][BIZ_PRICE]);

        BIZ_ENUM[id][BIZ_OWNED] = (1);
        SetString(BIZ_ENUM[id][BIZ_OWNER],GetName(playerid));

        INFO(playerid,"Uspesno ste kupili ovu firmu za ($%d) | Za upravljanje firmom kucajte '/business'.",BIZ_ENUM[id][BIZ_PRICE]);

        SavePlayer(playerid); Save_Business(id); Business_Refresh(id);    
	}
	return (true);
}

YCMD:business(playerid,params[],help)
{
	new prop[2],slot;

	prop[0] = Player_Enum[playerid][p_Property][2],
	prop[1] = Player_Enum[playerid][p_Property][3];

	if(prop[0] == 9999 && prop[1] == 9999)
	  return GRESKA(playerid,"Ne posjedujete ni jedan biznis.");

	static bizid = -1;

	if ((bizid = Business_Inside(playerid)) != -1 && Business_IsOwner(playerid, bizid)) 
	{
		if(sscanf(params, "i",slot))
		  return USAGE(playerid,"/business [slot] [2-3]");
		if(slot < 2 || slot > 3)
		  return GRESKA(playerid,"Moguci slotovi samo od [2-3].");
		if(Player_Enum[playerid][p_Property][slot] == 9999)
		  return GRESKA(playerid,"Nemate biznis na ovom slotu!");
		if ((bizid = Business_Inside(playerid)) != Player_Enum[playerid][p_Property][slot])
		   return GRESKA(playerid,"Morate biti u tom biznisu.");  

		Choosed_Business[playerid] = Player_Enum[playerid][p_Property][slot];

		Dialog_Show(playerid, Business_Dialog, DSL, "{FFD000}BUSINESS - {FFFFFF}OPTIONS","{FFFFFF}Informations\nLock\nSell\nProtection\nMoney options\nProducts\nWork options\nJob pickup\nJob requests\nBuy business vehicle\nShipment options","Choose","Cancel");        
	}  
	return (true);
}

YCMD:bizvehicle(playerid,params[],help)
{
	new slot;
	if(sscanf(params,"d",slot))
	   return USAGE(playerid,"/bizvehicle [business slot] [2-3].");
    if(slot < 2 || slot > 3)
       return GRESKA(playerid,"Slotovi samo od 2 do 3.");
	if(BIZ_ENUM[Player_Enum[playerid][p_Property][slot]][BIZ_VEHICLE_ID] == (9999))
       return GRESKA(playerid,"Vasa firma neposjeduje vozilo.");

    Choosed_Business[playerid] = Player_Enum[playerid][p_Property][slot];   

    Dialog_Show(playerid, Business_Vehicle_Dialog, DSL, "{FFD000}VEHICLE - {FFFFFF}OPTIONS","Parkiraj\nLociraj\nSell\nSpawn","Choose","Cancel");   
	return (true);
}

YCMD:jobrequest(playerid,params[],help)
{
	static id = (-1);
	new i[2];

	i[0] = Player_Enum[playerid][p_Property][2],
	i[1] = Player_Enum[playerid][p_Property][3];

	if ((id = Business_Inside(playerid)) != (-1))
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, BIZ_ENUM[id][BIZ_JOB_POS][0], BIZ_ENUM[id][BIZ_JOB_POS][1], BIZ_ENUM[id][BIZ_JOB_POS][2]))
		{
			if(isequal(GetName(playerid), BIZ_ENUM[id][BIZ_OWNER]))
			  return GRESKA(playerid,"Ne mozes se zaposliti u svojem biznisu.");
			if(i[0] != (9999) || i[1] != (9999))
			   return GRESKA(playerid,"Vi imate biznis te vam zaposljenje nije potrebno.");  
			if(GetPlayerIdFromName(BIZ_ENUM[id][BIZ_OWNER]) == IPI)
			  return GRESKA(playerid,"Vlasnik biznisa nije na serveru,pricekajte da dodje.");
			if(BIZ_ENUM[id][BIZ_WORKERS_SLOT] == 10)
			  return GRESKA(playerid,"Sva mesta u ovoj firmi su popunjena.");
			if(IsRequested_Job(id,playerid) != (-1))
	          return GRESKA(playerid,"Vec ste konkurisali za ovaj posao,pricekajte odgovor.");
	        if(Player_Enum[playerid][p_Business_Job] == (id))
	           return GRESKA(playerid,"Ne mozete konkurisati u firmi u kojoj vec radite.");    

			Business_Job_Requester[playerid] = id;    

			Dialog_Show(playerid, Business_Job_Request, DSI, "{FFD000}JOB - {FFFFFF}REQUEST","{FFFFFF}Ako zelite konkurisati za posao u {069935}(%s).\n\n{FFFFFF}Upisite sve vase predispozicije za ovaj posao kako bi nas vlasnik mogao da vam odgovori.","Input","Cancel",BIZ_ENUM[id][BIZ_NAME]);  
		}
	}
	return (true);
}

YCMD:buyweapon(playerid,params[],help)
{
	static bizid = -1;
	if ((bizid = Business_Inside(playerid)) != -1 && BIZ_ENUM[bizid][BIZ_TYPE] == AMMUNATION_SHOP)
    {
			static string[512];

			format(string,sizeof(string),"{FFFFFF}Municija/Magazine - (%s)\nNoz/Knife - (%s)\nPalica/Baseball Bat - (%s)\nDesert Eagle - (%s)\nCountry Rifle - (%s)\nPancirka/Armour - (%s)\nMicro SMG/Uzi - (%s)",
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][0]),
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][1]),
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][2]),
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][3]),
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][4]),
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][5]),
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][6]),
			          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][7])
		    );
		    Dialog_Show(playerid, Business_Buy_Weapon, DSL, "{FFD000}WEAPON - {FFFFFF}BUY",string,"Buy","Cancel");
	}	    
	return (true);
}

YCMD:buyclothes(playerid,params[],help)
{
	static bizid = -1;
	if ((bizid = Business_Inside(playerid)) != -1 && BIZ_ENUM[bizid][BIZ_TYPE] == BINCO_SHOP)
    {
    	    static string[512];

    		format(string,sizeof(string),"Clothes - (%s)\nWatches - (%s)\nHats - (%s)\nBandanda - (%s)\nGlasses - (%s)",
    	           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][0]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][1]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][2]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][3]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][4])
		    );
		    Dialog_Show(playerid, Business_Buy_Clothes, DSL, "{FFD000}CLOTHES - {FFFFFF}BUY",string,"Choose","Cancel");
    }
    return (true);
}

//============================================================

Dialog:Business_Buy_Clothes(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Clothes_Type[playerid] = (1);

				switch(Player_Enum[playerid][p_Gender])
				{
					case 1:
                        ShowModelSelectionMenu(playerid, "Clothes Buy", MODEL_SELECTION_CLOTHES, g_aMaleSkins, sizeof(g_aMaleSkins), -16.0, 0.0, -55.0);

					case 2:
                       	ShowModelSelectionMenu(playerid, "Clothes Buy", MODEL_SELECTION_CLOTHES, g_aFemaleSkins, sizeof(g_aFemaleSkins), -16.0, 0.0, -55.0);
				}
			}
			case 1:
			{
                Clothes_Type[playerid] = (2);
                ShowModelSelectionMenu(playerid, "Watches", MODEL_SELECTION_CLOTHES, {19039,19040,19041,19042,19043,19044,19045,19046,19047,19048,19049,19050,19051,19052,19053}, 15, 0.0, 0.0, 90.0);
			}
			case 2:
			{
                Clothes_Type[playerid] = (3);
                ShowModelSelectionMenu(playerid, "Hats", MODEL_SELECTION_CLOTHES, {18926, 18927, 18928, 18929, 18930, 18931, 18932, 18933, 18934, 18935, 18944, 18945, 18946, 18947, 18948, 18949, 18950, 18951}, 18, -20.0, -90.0, 0.0);
			}
			case 3:
			{
                Clothes_Type[playerid] = (4);
                ShowModelSelectionMenu(playerid, "Bandanas", MODEL_SELECTION_CLOTHES, {18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920}, 10, 80.0, -173.0, 0.0);
			}
			case 4:
			{
				Clothes_Type[playerid] = (5);
                ShowModelSelectionMenu(playerid, "Glasses", MODEL_SELECTION_CLOTHES, {19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030}, 25, 80.0, -173.0, 0.0);
			}
		}
	}
	return (true);		
}

Dialog:Business_Buy_Weapon(playerid, response, listitem, inputtext[])
{
	new bizid = Entered_Business[playerid];
	if(response)
	{
		new price = BIZ_ENUM[bizid][BIZ_PRICES][listitem];

		switch(listitem)
		{
			case 0:
			{
	               if(Inventory_Count(playerid, "Magazine") >= 5)
	                   return GRESKA(playerid,"Imate maximalan broj municije 5/5.");

	               new id = Inventory_Add(playerid, "Magazine", 2039);

				   if(id == -1)
				        return GRESKA(playerid,"Nemate slobodnih slotova u inventaru.");

				   Player_Enum[playerid][p_Money] -= price;
				   GivePlayerMoney(playerid,-price);

				   INFO(playerid,"Uspesno ste kupili (Weapon magazine) za %s.",FormatNumber(price));

				   BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
				   BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

				   Save_Business(bizid);       
			}
			case 1:
			{
				   GiveWeaponToPlayer(playerid, 4, 1);

				   Player_Enum[playerid][p_Money] -= price;
				   GivePlayerMoney(playerid,-price);

				   INFO(playerid,"Uspesno ste kupili (Knife) za %s.",FormatNumber(price));

				   BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
				   BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

				   Save_Business(bizid);       
			}
			case 2:
			{
				   GiveWeaponToPlayer(playerid, 5, 1);
				   
				   Player_Enum[playerid][p_Money] -= price;
				   GivePlayerMoney(playerid,-price);

				   INFO(playerid,"Uspesno ste kupili (Baseball Bat) za %s.",FormatNumber(price));

				   BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
				   BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

				   Save_Business(bizid);     
			}
			case 3:
			{
				   if (Inventory_Count(playerid, "Desert Eagle") > 5)
					    return GRESKA(playerid,"Imate maximalan broj ovog tipa oruzija 5/5.");

				   Inventory_Add(playerid, "Desert Eagle", 348);

				   Player_Enum[playerid][p_Money] -= price;
				   GivePlayerMoney(playerid,-price);

				   INFO(playerid,"Uspesno ste kupili (Desert Eagle) za %s.",FormatNumber(price));

				   BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
				   BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

				   Save_Business(bizid);     
			}
			case 4:
			{
				   GiveWeaponToPlayer(playerid, 33, 15);

				   Player_Enum[playerid][p_Money] -= price;
				   GivePlayerMoney(playerid,-price);

				   INFO(playerid,"Uspesno ste kupili (Country Rifle) za %s.",FormatNumber(price));

				   BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
				   BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

				   Save_Business(bizid);     
			}
			case 5:
			{
				   if (Inventory_Count(playerid, "Armored Vest") >= 3)
				       return GRESKA(playerid,"Imate maximalan broj ovog itema 3/3");

				   new id = Inventory_Add(playerid, "Armored Vest", 19142);

				   if(id == -1)
				        return GRESKA(playerid,"Nemate slobodnih slotova u inventaru.");

				   Player_Enum[playerid][p_Money] -= price;
				   GivePlayerMoney(playerid,-price);

				   INFO(playerid,"Uspesno ste kupili (Pancirku) za %s.",FormatNumber(price));

				   BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
				   BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

				   Save_Business(bizid);              
			}
			case 6:
			{
				   if (Inventory_Count(playerid, "Micro SMG") > 5)
					    return GRESKA(playerid,"Imate maximalan broj ovog tipa oruzija 5/5.");

				   Inventory_Add(playerid, "Micro SMG", 352);

				   Player_Enum[playerid][p_Money] -= price;
				   GivePlayerMoney(playerid,-price);

				   INFO(playerid,"Uspesno ste kupili (Micro SMG) za %s.",FormatNumber(price));

				   BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
				   BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

				   Save_Business(bizid);
			}
		}	
	}
	return (true);
}

//============================================================

Dialog:Business_Job_Request(playerid, response, listitem, inputtext[])
{
	new bizid = Business_Job_Requester[playerid];
	static id = (-1);

	if(response)
	{
		    if(strlen(inputtext) >= 60)
		       return GRESKA(playerid,"Ne mozete unijeti vise od 60 karaktera u predispoziciju.");

		    id = Business_Request_Add(bizid,playerid,inputtext);
            if(id == (-1))
            return GRESKA(playerid,"Nasa firma ima previse upita za posao probajte kasnije.");

            Escape_String(inputtext);
            INFO(playerid,"Uspesno ste konkurisali za posao u nasoj firmi,pricekajte odgovor.");

            if(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_OWNER]) != IPI)
            	SCM(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_OWNER]),-1,"{3A961B}Trenutno je gradjanin %s konkurisao za posao u vasoj firmi,proverite mu formular.",GetName(playerid));
	}
	return (true);
}

Dialog:Business_Job_Requesters(playerid, response, listitem, inputtext[])
{
	static req_string[500];
	new bizid = Choosed_Business[playerid];

	if(response)
	{
		if(BUSINESS_JOB_REQUEST[bizid][listitem][r_Exist] != (0))
		{
			format(req_string,sizeof(req_string),"{FFFFFF}Job requester: {069935}(%s).\n{FFFFFF}Requester message:\n{069935}%s",BUSINESS_JOB_REQUEST[bizid][listitem][r_Name],BUSINESS_JOB_REQUEST[bizid][listitem][r_Message]);
			Dialog_Show(playerid, Business_Choose_Request, DSM, "{FFD000}BUSINESS {FFFFFF}- JOB REQUEST", req_string, "Accept", "Decline");
			Business_Job_Accept[playerid] = listitem; req_string = "\0";		
		}
	}
	return (true);
}

Dialog:Business_Choose_Request(playerid, response, listitem, inputtext[])
{
	new slot = Business_Job_Accept[playerid];
	new bizid = Choosed_Business[playerid];

	if(response)
	{
		if(GetPlayerIdFromName(BUSINESS_JOB_REQUEST[bizid][slot][r_Name]) == IPI)
		   return GRESKA(playerid,"Igrac koji je konkurisao trenutno nije online.");
		if(BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] == (10))
		   return GRESKA(playerid,"Imate maximalan broj zaposlenih 10/10.");

        BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] ++;
        Add_Business_Worker(bizid,GetPlayerIdFromName(BUSINESS_JOB_REQUEST[bizid][slot][r_Name]));

        INFO(playerid,"Uspesno ste zaposlili %s u svoju firmu.",GetPlayerIdFromName(BUSINESS_JOB_REQUEST[bizid][slot][r_Name]));
        INFO(playerid,"%s vlasnik firme %s je prihvatio vasu prijavu za posao.",GetName(playerid),BIZ_ENUM[bizid][BIZ_NAME]);

        Remove_Biz_Request(bizid,slot);
	}
	else
	{
        if(GetPlayerIdFromName(BUSINESS_JOB_REQUEST[bizid][slot][r_Name]) != IPI)
		{
			INFO(GetPlayerIdFromName(BUSINESS_JOB_REQUEST[bizid][slot][r_Name]),"%s vlasnik firme %s je odbio vasu prijavu za posao.",GetName(playerid),BIZ_ENUM[bizid][BIZ_NAME]);
            Remove_Biz_Request(bizid,slot);
		}
	}
	return (true);
}

//============================================================

Dialog:Business_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static biz_string[325];
		new i = Choosed_Business[playerid];

		switch(listitem)
		{
			case 0:
			{
                   format(biz_string,sizeof(biz_string),"{FFD000}Business Name: {FFFFFF}(%s)\n\
                   {FFD000}Business Price:{FFFFFF} (%s)\n\
                   {FFD000}Business Lock:{FFFFFF} (%s)\n\
                   {FFD000}Business Alarm:{FFFFFF} (%s)\n\
                   {FFD000}Business Money:{FFFFFF} (%s)\n\
                   {FFD000}Business Employers:{FFFFFF} (%d/10)\n\
                   {FFD000}Business Employers_Pay: {FFFFFF}(%s)",
                   BIZ_ENUM[i][BIZ_NAME],
                   FormatNumber(BIZ_ENUM[i][BIZ_PRICE]),
                   (BIZ_ENUM[i][BIZ_LOCKED]) ? ("Zakljucano") : ("Otkljucano"),
                   (BIZ_ENUM[i][BIZ_PASSWORD_PROTECT]) ? ("Upaljen") : ("Ugasen"),
                   FormatNumber(BIZ_ENUM[i][BIZ_MONEY]),
                   BIZ_ENUM[i][BIZ_WORKERS_SLOT],
                   FormatNumber(BIZ_ENUM[i][BIZ_WORKERS_PAYDAY]));
                   Dialog_Show(playerid, Show_Only, DSM, "{FFD000}BUSINESS {FFFFFF}- INFO", biz_string, "IZLAZ", "");  biz_string = "\0";
			}
			case 1:
			{
				   if(BIZ_ENUM[i][BIZ_LOCKED] == 0)
				   {
				   	   BIZ_ENUM[i][BIZ_LOCKED] = 1;
				   	   INFO(playerid,"Uspesno ste zakljucali %s.",BIZ_ENUM[i][BIZ_NAME]);
				   	   Save_Business(i);
				   }
				   else if(BIZ_ENUM[i][BIZ_LOCKED] == 1)
				   {
				   	   BIZ_ENUM[i][BIZ_LOCKED] = 0;
				   	   INFO(playerid,"Uspesno ste otkljucali %s.",BIZ_ENUM[i][BIZ_NAME]);
				   	   Save_Business(i);
				   }
				   Dialog_Show(playerid, Business_Dialog, DSL, "{FFD000}BUSINESS - {FFFFFF}OPTIONS","{FFFFFF}Informations\nLock\nSell\nProtection\nProducts\nStorage options\nWork options\nVehicle options\nShipment options","Choose","Cancel");        
			}
			case 2:
			{
				   Dialog_Show(playerid, Business_Sell_Dialog, DSM, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa.\n\n{FFFFFF}Ako zelite prodati biznis drzavi pritisnite {FFD000}'Drzava'\n{FFFFFF}Ili ako zelite da prodate igracu pritisnite {FFD000}'Igrac'", "Drzava", "Igrac");
			}
			case 3:
			{
				   Dialog_Show(playerid, Business_Alarm_Dialog, DSL, "{FFD000}ALARM - {FFFFFF}PROTECTION", "{FFFFFF}Ukljuci zastitu\nIskljuci zastitu", "Choose", "Cancel");
			}
			case 4:
			{
				   Dialog_Show(playerid, Business_Money_Dialog, DSI, "{FFD000}BUSINESS - {FFFFFF}MONEY", "{FFFFFF}Stanje novca u biznisu: {FFD000}($%d).\n\n{FFFFFF}Da podignete novac unesite kolicinu i podigni.\nA da ga ostavite unesite kolicinu i ostavi.", "Choose", "Cancel",BIZ_ENUM[i][BIZ_MONEY]);
			}
			case 5:
			{
				   Businnes_Product_Menu(playerid,Choosed_Business[playerid]);
			}
			case 6:
			{
				   if(BIZ_ENUM[i][BIZ_WORKERS_SLOT] == 0)
        		     return GRESKA(playerid,"Nemate ni jednog radnika!");
				   Dialog_Show(playerid, Business_Work_Dialog, DSL, "{FFD000}WORK - {FFFFFF}OPTIONS", "{FFFFFF}Employers list\nEmployers options\nPay employer\nPay all employers", "Choose", "Cancel");
			}
			case 7:
			{
				    Dialog_Show(playerid, Business_Pickup_Dialog, DSL, "{FFD000}JOB PICKUP - {FFFFFF}OPTIONS","Add job pickup\nEdit pickup position\nDelete job pickup","Choose","Cancel");
			}
			case 8:
			{
                    Show_Job_Requests(playerid,i);
			}
			case 9:
			{
                    new items[10];
                    for(new j = 0; j < 10; ++j)
                    {
                    	items[j] = Businesses_Buyable_Vehicles[j][0];
                    }
                    ShowModelSelectionMenu(playerid, "Purchase Business Vehicle", MODEL_SELECTION_BIZ_VEHICLES, items, sizeof(items), -16.0, 0.0, -55.0, 0.9, 1);
			}
		}
	}
	return (true);
}

//============================================================

Dialog:Business_Pickup_Dialog(playerid,response,listitem, inputtext[])
{
	if(response)
	{
		new i = Choosed_Business[playerid];
		new Float:p_Pos[3];

        switch(listitem)
        {
        	case 0:
        	{
        		 if(BIZ_ENUM[i][BIZ_JOB_PICKUP_ADDED] != (0))
        		 {
        		 	GRESKA(playerid,"Vec ste dodali job pickup.");
        		 	Dialog_Show(playerid, Business_Pickup_Dialog, DSL, "{FFD000}JOB PICKUP - {FFFFFF}OPTIONS","Add job pickup\nEdit pickup pos\nDelete job pickup","Choose","Cancel");
        		 	return (true);
        		 }

        		 GetPlayerPos(playerid,p_Pos[0],p_Pos[1],p_Pos[2]);

        		 BIZ_ENUM[i][BIZ_JOB_POS][0] = p_Pos[0];
        		 BIZ_ENUM[i][BIZ_JOB_POS][1] = p_Pos[1];
        		 BIZ_ENUM[i][BIZ_JOB_POS][2] = p_Pos[2];
        		 BIZ_ENUM[i][BIZ_JOB_PICKUP_ADDED] = (1);
                 
                 Job_Pickup_Refresh(i); Save_Business(i);
        		 INFO(playerid,"Uspesno ste dodali job pickup u svoju firmu."); 
        	}
        	case 1:
        	{
        		 if(BIZ_ENUM[i][BIZ_JOB_PICKUP_ADDED] != (1))
        		   return GRESKA(playerid,"Niste dodali job pickup.");

        		 GetPlayerPos(playerid,p_Pos[0],p_Pos[1],p_Pos[2]);
        		 
        		 BIZ_ENUM[i][BIZ_JOB_POS][0] = p_Pos[0];
        		 BIZ_ENUM[i][BIZ_JOB_POS][1] = p_Pos[1];
        		 BIZ_ENUM[i][BIZ_JOB_POS][2] = p_Pos[2];  

        		 Job_Pickup_Refresh(i); Save_Business(i);
        		 INFO(playerid,"Uspesno ste editovali poziciju job pickup-a.");
        	}
        	case 2:
        	{
        		 if(BIZ_ENUM[i][BIZ_JOB_PICKUP_ADDED] != (1))
        		   return GRESKA(playerid,"Niste dodali job pickup.");

        		 DestroyDynamicPickup(BIZ_ENUM[i][BIZ_JOB_PICKUP]);
        		 DestroyDynamic3DTextLabel(BIZ_ENUM[i][BIZ_JOB_LABEL]);

        		 BIZ_ENUM[i][BIZ_JOB_POS][0] = 0.0;
        		 BIZ_ENUM[i][BIZ_JOB_POS][1] = 0.0;
        		 BIZ_ENUM[i][BIZ_JOB_POS][2] = 0.0;

        		 Save_Business(i);  

        		 INFO(playerid,"Uspesno ste obrisali job pickup");  
        	}
        }
	}
	return (true);
}

//============================================================

Dialog:Business_Vehicle_Dialog(playerid,response,listitem, inputtext[])
{
	if(response)
	{
		new i = Choosed_Business[playerid];

        switch(listitem)
        {
        	case 0:
        	{
        		 static Float:Pos[4];
        		 if(!IsPlayerInVehicle(playerid, BIZ_ENUM[i][BIZ_VEHICLE_CREATE])) 
        		    return GRESKA(playerid,"Morate biti u vozilu firme!!!");
        		 if(IsPlayerInArea(playerid, 1356.934448, -1753.421875, 1393.539916, -1736.147094))
        		    return GRESKA(playerid,"Ne mozete parkirati blizu autosalona!");
        		 if(IsPlayerInArea(playerid, 2051.388183, -1881.555664, 2087.391357, -1860.702636))
			        return GRESKA(playerid,"Ne mozete parkirati blizu moto salona.");

			     GetVehiclePos(BIZ_ENUM[i][BIZ_VEHICLE_CREATE], Pos[0], Pos[1], Pos[2]);
        		 GetVehicleZAngle(BIZ_ENUM[i][BIZ_VEHICLE_CREATE], Pos[3]);

        		 BIZ_ENUM[i][BIZ_VEHICLE_POS][0] = Pos[0];
        		 BIZ_ENUM[i][BIZ_VEHICLE_POS][1] = Pos[1];
        		 BIZ_ENUM[i][BIZ_VEHICLE_POS][2] = Pos[2];
        		 BIZ_ENUM[i][BIZ_VEHICLE_POS][3] = Pos[3];

        		 DestroyVehicle(BIZ_ENUM[i][BIZ_VEHICLE_CREATE]);
        		 BIZ_ENUM[i][BIZ_VEHICLE_CREATE] = AddStaticVehicleEx(BIZ_ENUM[i][BIZ_VEHICLE_MODEL], BIZ_ENUM[i][BIZ_VEHICLE_POS][0],BIZ_ENUM[i][BIZ_VEHICLE_POS][1],BIZ_ENUM[i][BIZ_VEHICLE_POS][2],BIZ_ENUM[i][BIZ_VEHICLE_POS][3], BIZ_ENUM[i][BIZ_VEHICLE_COLOR][0], BIZ_ENUM[i][BIZ_VEHICLE_COLOR][1], 30000);
        		 SetVehicleToRespawn(BIZ_ENUM[i][BIZ_VEHICLE_CREATE]);

        		 INFO(playerid,"Uspesno ste preparkirali vozilo svoje firme.");      
        	}
        	case 1:
        	{
        		  static Float:Pos[3];
        		  GetVehiclePos(BIZ_ENUM[i][BIZ_VEHICLE_CREATE], Pos[0], Pos[1], Pos[2]);

                  INFO(playerid,"Vozilo vase firme je oznaceno na mapi.");
        		  SetPlayerCheckpoint(playerid, Pos[0], Pos[1], Pos[2], 2.0);
        	}
        	case 2:
        	{
                  Dialog_Show(playerid, Business_Vehicle_Sell, DSM, "{FFD000}VEHICLE - {FFFFFF}SELL","{FFFFFF}Odlucili ste prodati vozilo svoje firme.\nOdaberite kome ce te ga prodati Drzavi ili Igracu.","Drzava","Igrac");
        	}
        	case 3:
        	{
        		  new Float:Pos[4];
        		  if(!IsPlayerInRangeOfPoint(playerid, 20.0, BIZ_ENUM[i][BIZ_POS][0], BIZ_ENUM[i][BIZ_POS][1], BIZ_ENUM[i][BIZ_POS][2]))
        		    return GRESKA(playerid,"Morate biti blizu svog biznisa.");
        		  if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
        		    return GRESKA(playerid,"Ne smete bizi u interijeru.");  
        		  if(BIZ_ENUM[i][BIZ_VEHICLE_SPAWNED] != (0))
        		    return GRESKA(playerid,"Biznis vozilo je vec spawnato.");

        		  GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
        		  GetPlayerFacingAngle(playerid,Pos[3]);

        		  BIZ_ENUM[i][BIZ_VEHICLE_POS][0] = Pos[0];
        		  BIZ_ENUM[i][BIZ_VEHICLE_POS][1] = Pos[1];
        		  BIZ_ENUM[i][BIZ_VEHICLE_POS][2] = Pos[2];
        		  BIZ_ENUM[i][BIZ_VEHICLE_POS][3] = Pos[3];

        		  Spawn_Business_Vehicle(i);
        		  Save_Business(i);

        		  INFO(playerid,"Uspesno ste spawnali: (%s)",ReturnVehicleModelName(BIZ_ENUM[i][BIZ_VEHICLE_MODEL]));        
        	}
        }
	}
	return (true);
}

//============================================================

Dialog:Business_Vehicle_Sell(playerid, response, listitem, inputtext[])
{
	new i = Choosed_Business[playerid];
	if(response)
	{

		 new cijena = (BIZ_ENUM[i][BIZ_VEHICLE_PRICE] / 100) * 30;
 
         INFO(playerid,"Uspesno ste prodali vozilo svoje firme (%s) drzavi i dobili 30% od njegove ukupne cene.",ReturnVehicleModelName(BIZ_ENUM[i][BIZ_VEHICLE_MODEL]));
         Player_Enum[playerid][p_Money] += cijena; GivePlayerMoney(playerid,cijena);

		 DestroyVehicle(BIZ_ENUM[i][BIZ_VEHICLE_CREATE]);

		 BIZ_ENUM[i][BIZ_VEHICLE_ID] = (9999);
		 BIZ_ENUM[i][BIZ_VEHICLE_MODEL] = 0;
		 BIZ_ENUM[i][BIZ_VEHICLE_PRICE] = 0;
		 SetString(BIZ_ENUM[i][BIZ_VEHICLE_OWNER],"Nema");
		 Save_Business(i); 
	}
	else
	{
         Dialog_Show(playerid, BizVeh_Igracu, DSI, "{FFD000}VEHICLE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vozila vase firme igracu.\n\nDa ponudite vozilo {FFD000}'Igracu' {FFFFFF}unesite njegov ID i cijenu za to vozilo.", "Ponudi", "Izlaz");  
	}
	return (true);
}

Dialog:BizVeh_Igracu(playerid, response, listitem, inputtext[])
{
	new i = Choosed_Business[playerid];
	if(response)
	{
       new idigraca,cijena,Float:Pos[3];
       if(sscanf(inputtext, "ud", idigraca,cijena))
          return Dialog_Show(playerid, BizVeh_Igracu, DSI, "{FFD000}VEHICLE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vozila vase firme igracu.\n\nDa ponudite vozilo {FFD000}'Igracu' {FFFFFF}unesite njegov ID i cijenu za to vozilo.", "Ponudi", "Izlaz");  
       if(cijena < 1)
          return Dialog_Show(playerid, BizVeh_Igracu, DSI, "{FFD000}VEHICLE {FFFFFF}- PRODAJA IGRACU", "{FFFFFF}Prodaja vozila vase firme igracu.\n\nDa ponudite vozilo {FFD000}'Igracu' {FFFFFF}unesite njegov ID i cijenu za to vozilo.", "Ponudi", "Izlaz");  
       if(idigraca == INVALID_PLAYER_ID)
          return GRESKA(playerid,"ID koji ste unijeli nije konektovan na server.");   
       if(idigraca == playerid)
          return (true);
       if(Player_Enum[idigraca][p_Property][2] == 9999 && Player_Enum[idigraca][p_Property][3] == 9999)
          return GRESKA(playerid,"Igrac nema ni jedan biznis.");   

       GetPlayerPos(idigraca, Pos[0], Pos[1], Pos[2]);

       if(!IsPlayerInRangeOfPoint(playerid, 2.0, Pos[0], Pos[1], Pos[2]))
          return GRESKA(playerid,"Niste blizu igraca kojem prodajete!");

       Vehicle_Sell[idigraca][0] = i;
       Vehicle_Sell[idigraca][1] = playerid;
       Vehicle_Sell[idigraca][2] = cijena;

       INFO(playerid,"Ponudli ste vozilo: (%s) igracu: %s",ReturnVehicleModelName(BIZ_ENUM[i][BIZ_VEHICLE_MODEL]),GetName(idigraca));
       Dialog_Show(idigraca, BizVeh_Response, DSM, "{FFD000}VOZILO {FFFFFF}- PONUDA", "{FFFFFF}Ponudeno vam je vozilo od {1B8F07}(%s).\n\n{FFFFFF}Ime Vozila: {1B8F07}(%s)\n{FFFFFF}Cijena vozila {1B8F07}($%d).", "Prihvati", "Odustani",GetName(playerid),ReturnVehicleModelName(BIZ_ENUM[i][BIZ_VEHICLE_MODEL]),cijena);  
	}
	return (true);
}

Dialog:BizVeh_Response(playerid, response, listitem, inputtext[])
{
	new prodavaoc = Vehicle_Sell[playerid][1],
		cijena = Vehicle_Sell[playerid][2],
		slot = Vehicle_Sell[playerid][0];

	if(response)
	{
		
		if(Player_Enum[playerid][p_Money] < cijena)
		   return GRESKA(playerid,"Nemate dovoljno novca za kupovinu ponudenog vozila!");

		BIZ_ENUM[slot][BIZ_VEHICLE_OWNER] = '\0';
		SetString(BIZ_ENUM[slot][BIZ_VEHICLE_OWNER],"Nema");

		if(Player_Enum[playerid][p_Property][2] != (9999) && BIZ_ENUM[Player_Enum[playerid][p_Property][2]][BIZ_VEHICLE_ID] == (9999))
		{
			BIZ_ENUM[Player_Enum[playerid][p_Property][2]][BIZ_VEHICLE_ID] = BIZ_ENUM[Player_Enum[playerid][p_Property][2]][BIZ_ID];
			Save_Business(Player_Enum[playerid][p_Property][2]);
		}
		else if(Player_Enum[playerid][p_Property][3] != (9999) && BIZ_ENUM[Player_Enum[playerid][p_Property][3]][BIZ_VEHICLE_ID] == (9999))
		{
			BIZ_ENUM[Player_Enum[playerid][p_Property][3]][BIZ_VEHICLE_ID] = BIZ_ENUM[Player_Enum[playerid][p_Property][3]][BIZ_ID];
			Save_Business(Player_Enum[playerid][p_Property][3]);
		}		
		
		Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena); // Onaj ko kupuje.
		Player_Enum[prodavaoc][p_Money] += cijena; GivePlayerMoney(prodavaoc,cijena); // Onaj ko prodaje.

		INFO(playerid,"Uspesno ste kupili (%s) od: %s za: $%d.",ReturnVehicleModelName(BIZ_ENUM[slot][BIZ_VEHICLE_MODEL]),GetName(prodavaoc),cijena);
		INFO(prodavaoc,"Uspesno ste prodali (%s) igracu: %s za: $%d.",ReturnVehicleModelName(BIZ_ENUM[slot][BIZ_VEHICLE_MODEL]),GetName(playerid),cijena);        

        SavePlayer(playerid); SavePlayer(prodavaoc);
        Save_Business(slot);

        Vehicle_Sell[playerid][0] = INVALID_PLAYER_ID;
        Vehicle_Sell[playerid][1] = INVALID_PLAYER_ID;
        Vehicle_Sell[playerid][2] = 0;  
	}
	else
	{
		INFO(playerid,"Prekinuli ste ponudu za vozilo!");
        INFO(prodavaoc,"%s je prekinuo vasu ponudu za: (%s).",GetName(playerid),ReturnVehicleModelName(BIZ_ENUM[slot][BIZ_VEHICLE_MODEL]));

        Vehicle_Sell[playerid][0] = INVALID_PLAYER_ID;
        Vehicle_Sell[playerid][1] = INVALID_PLAYER_ID;
        Vehicle_Sell[playerid][2] = 0;  
	}
	return (true);
}

//============================================================

Dialog:Business_Work_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static string[400];
		new i = Choosed_Business[playerid];

        switch(listitem)
        {
        	case 0:
        	{
                  format(string,sizeof(string),"{FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).\n\
                  {FFD000}Employer Name: {FFFFFF} (%s).",
                  BIZ_ENUM[i][BIZ_WORKER_1],
                  BIZ_ENUM[i][BIZ_WORKER_2],
                  BIZ_ENUM[i][BIZ_WORKER_3],
                  BIZ_ENUM[i][BIZ_WORKER_4],
                  BIZ_ENUM[i][BIZ_WORKER_5],
                  BIZ_ENUM[i][BIZ_WORKER_6],
                  BIZ_ENUM[i][BIZ_WORKER_7],
                  BIZ_ENUM[i][BIZ_WORKER_8],
                  BIZ_ENUM[i][BIZ_WORKER_9],
                  BIZ_ENUM[i][BIZ_WORKER_10]); 
                  Dialog_Show(playerid, Show_Only, DSM, "{FFD000}EMPLOYERS {FFFFFF}- LIST", string, "IZLAZ", ""); string = "\0";
        	}
        	case 1:
        	{
        		  Dialog_Show(playerid, Business_Workers_Options, DSL, "{FFD000}EMPLOYERS - {FFFFFF}OPTIONS","Set employers paycheck\nRelease employer", "Choose", "Cancel");
        	}
        	case 2:
        	{
        		  Dialog_Show(playerid, Business_Worker_Check, DSI,"{FFD000}EMPLOYER - {FFFFFF}PAY","Da platite svog radnika unesite njegovo ime.\n\nListu svih radnika mozete vidjeti na employers list.","Input","Cancel");
        	}
        	case 3:
        	{
        		  PayAllEmployers(i);
        		  INFO(playerid,"Uspesno ste isplatili dostupne zaposlenike.");
        	}
        }
	}
	return (true);
}

//==============================================================

Dialog:Business_Worker_Check(playerid, response, listitem, inputtext[])
{
	if(response)
	{
               new name[32];
               new i = Choosed_Business[playerid];

               if(sscanf(inputtext,"s[32]",name))
                  return  Dialog_Show(playerid, Business_Worker_Check, DSI,"{FFD000}EMPLOYER - {FFFFFF}PAY","Da platite svog radnika unesite njegovo ime.\n\nListu svih radnika mozete vidjeti na employers list.","Input","Cancel");
               if(GetPlayerIdFromName(name) == IPI)
                   return GRESKA(playerid,"Igrac nije konektovan.");

               PayEmployer(playerid,i,name);

               Dialog_Show(playerid, Business_Work_Dialog, DSL, "{FFD000}WORK - {FFFFFF}OPTIONS", "{FFFFFF}Employers list\nEmployers options\nPay employer\nPay all employers", "Choose", "Cancel");       
	
	}
	else
	Dialog_Show(playerid, Business_Work_Dialog, DSL, "{FFD000}WORK - {FFFFFF}OPTIONS", "{FFFFFF}Employers list\nEmployers options\nPay employer\nPay all employers", "Choose", "Cancel");   
	return (true);
}

//==============================================================

Dialog:Business_Workers_Options(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new i = Choosed_Business[playerid];

        switch(listitem)
        {
        	case 0:
        	{
        		Dialog_Show(playerid, Business_Workers_Pay, DSI, "{FFD000}EMPLOYERS - {FFFFFF}PAYCHECK SET","{FFFFFF}Trenutna plata vasih zaposlenika: {15941F}$%d.\n\n{FFFFFF}Da postavite novu unesite je u prazan input.","Input","Cancel",BIZ_ENUM[i][BIZ_WORKERS_PAYDAY]);
        	}
        	case 1:
        	{
        		Dialog_Show(playerid, Business_Worker_Release, DSI,"{FFD000}EMPLOYER - {FFFFFF}RELEASE","{FFFFFF}Da otpustite nekog od svojih radnika unesite njegovo ime u prazan input.\n\nListu svih radnika mozete vidjeti na employers list.","Input","Cancel"); 
        	}
        }
	}
	return (true);
}

Dialog:Business_Workers_Pay(playerid, response, listitem, inputtext[])
{
	new i = Choosed_Business[playerid];

	if(response)
	{
        new paycheck;
        if(sscanf(inputtext,"d",paycheck))
           return Dialog_Show(playerid, Business_Workers_Pay, DSI, "{FFD000}EMPLOYERS - {FFFFFF}PAYCHECK SET","{FFFFFF}Trenutna plata vasih zaposlenika: {15941F}$%d.\n\n{FFFFFF}Da postavite novu unesite je u prazan input.","Input","Cancel",BIZ_ENUM[i][BIZ_WORKERS_PAYDAY]);
	    if(paycheck < 1)
	       return Dialog_Show(playerid, Business_Workers_Pay, DSI, "{FFD000}EMPLOYERS - {FFFFFF}PAYCHECK SET","{FFFFFF}Trenutna plata vasih zaposlenika: {15941F}$%d.\n\n{FFFFFF}Da postavite novu unesite je u prazan input.","Input","Cancel",BIZ_ENUM[i][BIZ_WORKERS_PAYDAY]);

	    BIZ_ENUM[i][BIZ_WORKERS_PAYDAY] = paycheck;
	    Save_Business(i);

	    INFO(playerid,"Postavili ste novu platu za svoje zaposlenike koja sada iznosi: $%d",paycheck);
	    Dialog_Show(playerid, Business_Work_Dialog, DSL, "{FFD000}WORK - {FFFFFF}OPTIONS", "{FFFFFF}Employers list\nEmployers options\nPay employer\nPay all employers", "Choose", "Cancel");   
	}
	else
	Dialog_Show(playerid, Business_Work_Dialog, DSL, "{FFD000}WORK - {FFFFFF}OPTIONS", "{FFFFFF}Employers list\nEmployers options\nPay employer\nPay all employers", "Choose", "Cancel");
	return (true);
}

Dialog:Business_Worker_Release(playerid, response, listitem, inputtext[])
{
	if(response)
	{
          new name[32];
          new i = Choosed_Business[playerid];

          if(sscanf(inputtext,"s[32]",name))
             return Dialog_Show(playerid, Business_Worker_Release, DSI,"{FFD000}EMPLOYER - {FFFFFF}RELEASE","{FFFFFF}Da otpustite nekog od svojih radnika unesite njegovo ime u prazan input.\n\nListu svih radnika mozete vidjeti na employers list.","Input","Cancel");
          if(GetPlayerIdFromName(name) == IPI)
             return GRESKA(playerid,"Igrac nije konektovan.");

          RemoveEmployer(playerid,i,name);

          Dialog_Show(playerid, Business_Work_Dialog, DSL, "{FFD000}WORK - {FFFFFF}OPTIONS", "{FFFFFF}Employers list\nEmployers options\nPay employer\nPay all employers", "Choose", "Cancel");
	}
	else
	Dialog_Show(playerid, Business_Work_Dialog, DSL, "{FFD000}WORK - {FFFFFF}OPTIONS", "{FFFFFF}Employers list\nEmployers options\nPay employer\nPay all employers", "Choose", "Cancel");
	return (true);
}

//============================================================

Dialog:Business_Protection_Code(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           new unos[12];
           new id = Entered_Business[playerid];

           if(sscanf(inputtext,"s[12]",unos))
              return Dialog_Show(playerid, Business_Protection_Code, DSI, "{FFFFFF}BUSINESS - PROTECTION","{FFFFFF}Ovaj biznis je zakljucan i posjeduje alarm protekciju.\nDa bi ste usli u nju potrebno je da deaktivirate alarm sa pristupnim kodom.\n\n{FC5805}Ako pogresite kod vlasnik ce biti obavesten!","Input","Cancel");
           
           if (!strcmp(BIZ_ENUM[id][BIZ_PASSWORD], unos, true))
	       {

	       	     if(BIZ_ENUM[id][BIZ_TYPE] == FURNITURE_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy furniture use ~y~/buyfurniture.", 1500, 5);
				 }
				 else if(BIZ_ENUM[id][BIZ_TYPE] == AMMUNATION_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy weapons use ~y~/buyweapon.", 1500, 5);
				 }
				 else if(BIZ_ENUM[id][BIZ_TYPE] == RESTAURANT || BIZ_ENUM[id][BIZ_TYPE] == MARKET_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy items use ~y~/buyitems.", 1500, 5);
				 }
				 else if(BIZ_ENUM[id][BIZ_TYPE] == BINCO_SHOP)
				 {
				 	 GameTextForPlayer(playerid, "~w~To buy weapons use ~y~/buyclothes.", 1500, 5);
				 }               

	       	     SetPlayerPos(playerid,BIZ_ENUM[id][BIZ_INT][0],BIZ_ENUM[id][BIZ_INT][1],BIZ_ENUM[id][BIZ_INT][2]);
		         SetPlayerFacingAngle(playerid,BIZ_ENUM[id][BIZ_INT][3]);

		         SetPlayerInterior(playerid, BIZ_ENUM[id][BIZ_INTERIOR]);
				 SetPlayerVirtualWorld(playerid, BIZ_ENUM[id][BIZ_EXTERIOR]);

				 SetCameraBehindPlayer(playerid); Entered_Business[playerid] = id;

				 TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);    
	       }
	       else
	       {
                 INFO(playerid,"Unijeli ste pogresan kod vlasnik je obavjesten.");
	   	         GameTextForPlayer(GetPlayerIdFromName(BIZ_ENUM[id][BIZ_OWNER]), "~y~Netko pokusava da vam provali u firmu.", 4000, 5);
	       }   
	}
	return (true);
}

//============================================================

Dialog:Business_Money_Dialog(playerid, response, listitem, inputtext[])
{
	   new unos[8],kolicina;
	   new i = Choosed_Business[playerid];

	   if(response)
	   {
		   if(sscanf(inputtext,"is[8]",kolicina,unos))
		      return Dialog_Show(playerid, Business_Money_Dialog, DSI, "{FFD000}BUSINESS - {FFFFFF}MONEY", "{FFFFFF}Stanje novca u biznisu: {FFD000}($%d).\n\n{FFFFFF}Da podignete novac unesite kolicinu i podigni.\nA da ga ostavite unesite kolicinu i ostavi.", "Choose", "Cancel",BIZ_ENUM[i][BIZ_MONEY]);
	       if(kolicina < 1)
	          return  Dialog_Show(playerid, Business_Money_Dialog, DSI, "{FFD000}BUSINESS - {FFFFFF}MONEY", "{FFFFFF}Stanje novca u biznisu: {FFD000}($%d).\n\n{FFFFFF}Da podignete novac unesite kolicinu i podigni.\nA da ga ostavite unesite kolicinu i ostavi.", "Choose", "Cancel",BIZ_ENUM[i][BIZ_MONEY]);
	       if(!strcmp(unos, "podigni", true))
	       {
	       	     if(kolicina > BIZ_ENUM[i][BIZ_MONEY])
	                return  Dialog_Show(playerid, Business_Money_Dialog, DSI, "{FFD000}BUSINESS - {FFFFFF}MONEY", "{FFFFFF}Stanje novca u biznisu: {FFD000}($%d).\n\n{FFFFFF}Da podignete novac unesite kolicinu i podigni.\nA da ga ostavite unesite kolicinu i ostavi.", "Choose", "Cancel",BIZ_ENUM[i][BIZ_MONEY]);

                 Player_Enum[playerid][p_Money] += kolicina;
                 GivePlayerMoney(playerid,kolicina);

                 BIZ_ENUM[i][BIZ_MONEY] -= kolicina;
                 Save_Business(i);

                 INFO(playerid,"Uspesno ste uzeli $%d iz svog biznisa,preostalo novca: $%d",kolicina,BIZ_ENUM[i][BIZ_MONEY]);
	       }
	       if(!strcmp(unos, "ostavi", true))
	       {
	       	   if(kolicina > Player_Enum[playerid][p_Money])
	       	      return GRESKA(playerid,"Nemate toliko novca kod sebe.");

	       	   Player_Enum[playerid][p_Money] -= kolicina;
               GivePlayerMoney(playerid,-kolicina);

               BIZ_ENUM[i][BIZ_MONEY] += kolicina;
               Save_Business(i); 

               INFO(playerid,"Uspesno ste ostavili $%d u svoju firmu,novo stanje: $%d",kolicina,BIZ_ENUM[i][BIZ_MONEY]);  
	       }
	       else 
	       Dialog_Show(playerid, Business_Money_Dialog, DSI, "{FFD000}BUSINESS - {FFFFFF}MONEY", "{FFFFFF}Stanje novca u biznisu: {FFD000}($%d).\n\n{FFFFFF}Da podignete novac unesite kolicinu i podigni.\nA da ga ostavite unesite kolicinu i ostavi.", "Choose", "Cancel",BIZ_ENUM[i][BIZ_MONEY]);
	   }
	   return (true);
}

//============================================================

Dialog:Business_Sell_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
       Dialog_Show(playerid, Business_Sell_Drzava, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa drzavi.\n\n{FFFFFF}Da prodate biznis drzavi unesite 'slot' sa kojeg ga prodajete.\nDostupni slotovi od {F7234A}[2-3]\n{FFFFFF}Zapamtite prodajom biznisa drzavi dobijate 30% od njegove ukupne cijene.", "Nastavi", "Cancel");
	}
	else
	{
       Dialog_Show(playerid, Business_Sell_Player, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa igracu.\nDa prodate biznis igracu unesite 'idigraca' 'slot' biznisa sa kojeg ga prodajete {F7234A}[2-3] {FFFFFF}i 'cijenu' za koju prodajete svoj biznis.", "Nastavi", "Cancel");
	}
	return (true);
}

Dialog:Business_Sell_Drzava(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        static slot;
		if(sscanf(inputtext,"i",slot))
		   return Dialog_Show(playerid, Business_Sell_Drzava, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa drzavi.\n\n{FFFFFF}Da prodate biznis drzavi unesite 'slot' sa kojeg ga prodajete.\nDostupni slotovi od {F7234A}[2-3]\n{FFFFFF}Zapamtite prodajom biznisa drzavi dobijate 30% od njegove ukupne cijene.", "Nastavi", "Cancel");
		if(slot < 2 || slot > 3)
		   return Dialog_Show(playerid, Business_Sell_Drzava, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa drzavi.\n\n{FFFFFF}Da prodate biznis drzavi unesite 'slot' sa kojeg ga prodajete.\nDostupni slotovi od {F7234A}[2-3]\n{FFFFFF}Zapamtite prodajom biznisa drzavi dobijate 30% od njegove ukupne cijene.", "Nastavi", "Cancel");
		if(Player_Enum[playerid][p_Property][slot] == 9999)
		   return GRESKA(playerid,"Slot sa kojeg prodajete firmu je prazan!!");
		if (Business_Inside(playerid) != Player_Enum[playerid][p_Property][slot])
		   return GRESKA(playerid,"Morate biti u tom biznisu.");     

		new cijena = (BIZ_ENUM[Player_Enum[playerid][p_Property][slot]][BIZ_PRICE] / 100) * 30;

		SetString(BIZ_ENUM[Player_Enum[playerid][p_Property][slot]][BIZ_OWNER],"Nema");
		BIZ_ENUM[Player_Enum[playerid][p_Property][slot]][BIZ_OWNED] = 0;
		BIZ_ENUM[Player_Enum[playerid][p_Property][slot]][BIZ_LOCKED] = 1;

		Player_Enum[playerid][p_Money] += cijena; GivePlayerMoney(playerid,cijena);

		Business_Refresh(Player_Enum[playerid][p_Property][slot]);
		Save_Business(Player_Enum[playerid][p_Property][slot]);
		Exit_Business(playerid,Player_Enum[playerid][p_Property][slot]);

		Player_Enum[playerid][p_Property][slot] = 9999;
		SavePlayer(playerid);

		INFO(playerid,"Uspesno ste prodali firmu sa slota %d za $%d",slot,cijena);         
	}
	return (true);
}

Dialog:Business_Sell_Player(playerid, response, listitem, inputtext[])
{
	if(response)
	{
       static idigraca,slot,cijena,Float:Pos[3];

       if(sscanf(inputtext,"uii",idigraca,slot,cijena))
          return  Dialog_Show(playerid, Business_Sell_Player, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa igracu.\nDa prodate biznis igracu unesite 'idigraca' 'slot' biznisa sa kojeg ga prodajete {F7234A}[2-3] {FFFFFF}i 'cijenu' za koju prodajete svoj biznis.", "Nastavi", "Cancel");
       if(slot < 2 || slot > 3)
          return  Dialog_Show(playerid, Business_Sell_Player, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa igracu.\nDa prodate biznis igracu unesite 'idigraca' 'slot' biznisa sa kojeg ga prodajete {F7234A}[2-3] {FFFFFF}i 'cijenu' za koju prodajete svoj biznis.", "Nastavi", "Cancel");
       if(Player_Enum[playerid][p_Property][slot] == 9999)
		  return GRESKA(playerid,"Nemate biznis na unesenom slotu.");
       if (Business_Inside(playerid) != Player_Enum[playerid][p_Property][slot])
		   return GRESKA(playerid,"Morate biti u tom biznisu.");   
	   if(cijena < 1)
	      return Dialog_Show(playerid, Business_Sell_Player, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa igracu.\nDa prodate biznis igracu unesite 'idigraca' 'slot' biznisa sa kojeg ga prodajete {F7234A}[2-3] {FFFFFF}i 'cijenu' za koju prodajete svoj biznis.", "Nastavi", "Cancel");
	   if(idigraca == IPI)
          return GRESKA(playerid,"ID igraca koji ste unijeli nije konektovan!");
       if(idigraca == playerid)
          return Dialog_Show(playerid, Business_Sell_Player, DSI, "{FFD000}BUSINESS - {FFFFFF}SELL", "{FFFFFF}Prodaja biznisa igracu.\nDa prodate biznis igracu unesite 'idigraca' 'slot' biznisa sa kojeg ga prodajete {F7234A}[2-3] {FFFFFF}i 'cijenu' za koju prodajete svoj biznis.", "Nastavi", "Cancel");

       GetPlayerPos(idigraca, Pos[0], Pos[1], Pos[2]);

       if(!IsPlayerInRangeOfPoint(playerid, 2.0, Pos[0], Pos[1], Pos[2]))
          return GRESKA(playerid,"Morate biti blizu igraca kojem prodajete biznis.");

       Business_Options[idigraca][0] = playerid;
       Business_Options[idigraca][1] = Player_Enum[playerid][p_Property][slot];
       Business_Options[idigraca][2] = cijena;
       Business_Options[idigraca][3] = slot;

       Dialog_Show(idigraca, Business_Sell_Accept, DSM, "{FFD000}BUSINESS - {FFFFFF}ACCEPT", "{FFFFFF}Igrac: {FFD000}(%s) {FFFFFF}vam je ponudio da kupite od njega biznis.\nCijena biznisa: {FFD000}($%d)\n\n{FFFFFF}Da ga kupite pritisnite 'Prihvati' kako bi prihvatili kupovinu.", "Prihvati", "Cancel",GetName(playerid),cijena);    		                         
	}
	return (true);
}

Dialog:Business_Sell_Accept(playerid, response, listitem, inputtext[])
{
	new cijena = Business_Options[playerid][2],
		prodavaoc = Business_Options[playerid][0],
	    idfirme = Business_Options[playerid][1],
		slot = Business_Options[playerid][3];

	if(response)
	{
		if(Player_Enum[playerid][p_Money] < cijena)
            return GRESKA(playerid,"Nemate dovoljno novca da kupite ponudjen biznis!");
            
        if(Player_Enum[playerid][p_Property][2] == 9999) Player_Enum[playerid][p_Property][2] = idfirme;
        else if(Player_Enum[playerid][p_Property][3] == 9999) Player_Enum[playerid][p_Property][3] = idfirme;
        else GRESKA(playerid,"Nemate slobodnih slotova za kupovinu ponudjenog biznisa.");

        Player_Enum[prodavaoc][p_Property][slot] = 9999;

        Player_Enum[playerid][p_Money] -= cijena; GivePlayerMoney(playerid,-cijena);
        Player_Enum[prodavaoc][p_Money] += cijena; GivePlayerMoney(prodavaoc,cijena);

        SetString(BIZ_ENUM[idfirme][BIZ_OWNER],GetName(playerid));
        BIZ_ENUM[idfirme][BIZ_OWNED] = 1;
        Save_Business(idfirme);

        SavePlayer(playerid); SavePlayer(prodavaoc);

        Business_Options[playerid][0] = INVALID_PLAYER_ID;
        Business_Options[playerid][1] = -1;
        Business_Options[playerid][2] =  0;
        Business_Options[playerid][3] = -1;

        INFO(playerid,"Uspesno ste kupili biznis od: %s za $%d.",GetName(prodavaoc),cijena);
        INFO(prodavaoc,"Uspesno ste prodali biznis: %s za $%d",GetName(playerid),cijena);
	}
	else
	{
		INFO(prodavaoc,"%s je odbio vasu ponudu za firmu.",GetName(playerid));
		INFO(playerid,"Odbili ste ponudu za firmu od %s.",GetName(prodavaoc));

		Business_Options[playerid][0] = INVALID_PLAYER_ID;
        Business_Options[playerid][1] = -1;
        Business_Options[playerid][2] =  0;
        Business_Options[playerid][3] = -1;
	}
	return (true);
}

//============================================================

Dialog:Business_Alarm_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new i = Choosed_Business[playerid];
		switch(listitem)
		{
			case 0:
			{
                if(BIZ_ENUM[i][BIZ_PASSWORD_PROTECT] != (0))
                   return GRESKA(playerid,"Vec ste ukljucili protekciju!");
                Dialog_Show(playerid, Business_Alarm_Set, DSI, "{FFD000}ALARM - {FFFFFF}PROTECTION", "{FFFFFF}Postavljanje passworda za alarm.\nUnesite password koji ce moci da deaktivira vas alarmni system.\n\n{F05466}Password moze sadrzavati do 12 znakovni karaktera.", "Choose", "Cancel");      
			}
			case 1:
			{

                if(BIZ_ENUM[i][BIZ_PASSWORD_PROTECT] != (1))
                   return GRESKA(playerid,"Protekcija nije ni ukljucena!");
                BIZ_ENUM[i][BIZ_PASSWORD_PROTECT] = 0;
                INFO(playerid,"Uspesno ste iskljucili alarm protekciju.");
                Save_Business(i);   
			}
		}
	}
	return (true);	
}

Dialog:Business_Alarm_Set(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         new unos[12];
         new i = Choosed_Business[playerid];
         
         if(sscanf(inputtext,"s[12]",unos))
            return Dialog_Show(playerid, Business_Alarm_Set, DSI, "{FFD000}ALARM - {FFFFFF}PROTECTION", "{FFFFFF}Postavljanje passworda za alarm.\nUnesite password koji ce moci da deaktivira vas alarmni system.\n\n{F05466}Password moze sadrzavati do 12 znakovni karaktera.", "Choose", "Cancel");      
         SetString(BIZ_ENUM[i][BIZ_PASSWORD],unos);
         BIZ_ENUM[i][BIZ_PASSWORD_PROTECT] = 1;
         INFO(playerid,"Uspesno ste postavili alarm protekciju,Password glasi: %s",unos);
         Save_Business(i);   
	}
	return (true);
}

//============================================================

Dialog:Business_Product_Edit(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static item[24];

		strmid(item, inputtext, 0, strfind(inputtext, "-") - 1);
		strpack(Editing_Item_Name[playerid], item, 32 char);
		Editing_Item[playerid] = listitem;

		Dialog_Show(playerid, Business_Product_Price, DSI, "{FFD000}PRODUCT - {FFFFFF}PRICE","{FFFFFF}Unesite cijenu koju cete postaviti kao cijenu produkta: {FFD000}(%s)","Input","Cancel",item);

	}
	return (true);
}

Dialog:Business_Product_Price(playerid, response, listitem, inputtext[])
{
	static item[32];
	new bizid = Choosed_Business[playerid];

	if(response)
	{
          strunpack(item, Editing_Item_Name[playerid]);
          if(isnull(inputtext))
             return Dialog_Show(playerid, Business_Product_Price, DSI, "{FFD000}PRODUCT - {FFFFFF}PRICE","{FFFFFF}Unesite cijenu koju cete postaviti kao cijenu produkta: {FFD000}(%s)","Input","Cancel",item);

          BIZ_ENUM[bizid][BIZ_PRICES][Editing_Item[playerid]] = strval(inputtext);
          Save_Business(bizid);

          INFO(playerid,"Uspesno ste promenili cijenu produkta: (%s) u cijenu: (%s)",item,FormatNumber(strval(inputtext)));
          Businnes_Product_Menu(playerid,bizid);   
	}
	else 
	Businnes_Product_Menu(playerid,bizid);
	return (true);
}

//============================================================

stock Businnes_Product_Menu(playerid,bizid)
{
	Choosed_Biz_Options[playerid] = Choosed_Business[playerid];    

	static
	    string[512];
    
    if(BIZ_ENUM[bizid][BIZ_TYPE] == FURNITURE_SHOP)
    {
              Dialog_Show(playerid, Business_Furniture_Edit, DSL, "{FFD000}FURNITURE - {FFFFFF}OPTIONS","Add furniture\nEdit furniture\nFurniture list\nAll furniture list","Choose","Cancel");
    }
    else if(BIZ_ENUM[bizid][BIZ_TYPE] == AMMUNATION_SHOP)
    {
              format(string,sizeof(string),"{FFFFFF}Municija/Magazine - (%s)\nNoz/Knife - (%s)\nPalica/Baseball Bat - (%s)\nDesert Eagle - (%s)\nCountry Rifle - (%s)\nPancirka/Armour - (%s)\nMicro SMG/Uzi - (%s)",
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][0]),
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][1]),
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][2]),
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][3]),
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][4]),
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][5]),
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][6]),
		          FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][7])
	          );
	          Dialog_Show(playerid, Business_Product_Edit, DSL, "{FFD000}PRODUCT - {FFFFFF}OPTIONS",string,"Choose","Cancel");      
    }
    else if(BIZ_ENUM[bizid][BIZ_TYPE] == RESTAURANT)
    {
               format(string,sizeof(string),"{FFFFFF}Coca Cola - (%s)\nOrange Juice - (%s)\nVine - (%s)\nMini pizza - (%s)\nMega pizza - (%s)\nChicken Burger - (%s)\nChicken Nuggets - (%s)\nCheeseburger - (%s)\nRoast chicken - (%s)",
               	   FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][0]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][1]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][2]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][3]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][4]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][5]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][6]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][7]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][8])
		       );  
		       Dialog_Show(playerid, Business_Product_Edit, DSL, "{FFD000}PRODUCT - {FFFFFF}OPTIONS",string,"Choose","Cancel"); 
    }
    else if(BIZ_ENUM[bizid][BIZ_TYPE] == MARKET_SHOP)
    {
    	       format(string,sizeof(string),"{FFFFFF}Mobile Phone - (%s)\nSpray Can - (%s)\nMask - (%s)\nRope - (%s)\nTape - (%s)\nWater - (%s)\nCoca Cola - (%s)\nOrange Juice - (%s)\nCigarettes - (%s)\nLighter - (%s)\nBoombox - (%s)",
    	           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][0]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][1]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][2]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][3]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][4]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][5]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][6]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][7]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][8]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][9]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][10])
		       );
		       Dialog_Show(playerid, Business_Product_Edit, DSL, "{FFD000}PRODUCT - {FFFFFF}OPTIONS",string,"Choose","Cancel");    			
    }
    else if(BIZ_ENUM[bizid][BIZ_TYPE] == BINCO_SHOP)
    {
    	       format(string,sizeof(string),"Clothes - (%s)\nWatches - (%s)\nHats - (%s)\nBandanda - (%s)\nGlasses - (%s)",
    	           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][0]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][1]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][2]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][3]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][4]),
		           FormatNumber(BIZ_ENUM[bizid][BIZ_PRICES][5])	
		       );
		       Dialog_Show(playerid, Business_Product_Edit, DSL, "{FFD000}PRODUCT - {FFFFFF}OPTIONS",string,"Choose","Cancel");
    }
	return (true);
}

//============================================================

function Load_Businesses()
{
	static rows,fields,var_load[32];
	cache_get_data(rows, fields, _dbConnector);

	for (new bID = 0; bID < rows; bID ++) if (bID < MAX_BUSINESSES)
	{
		BIZ_ENUM[bID][BIZ_CREATED] = (1);

		cache_get_field_content(bID, "BIZ_OWNER", BIZ_ENUM[bID][BIZ_OWNER], _dbConnector);
		cache_get_field_content(bID, "BIZ_NAME", BIZ_ENUM[bID][BIZ_NAME], _dbConnector);
		cache_get_field_content(bID, "BIZ_PASSWORD", BIZ_ENUM[bID][BIZ_PASSWORD], _dbConnector);

		cache_get_field_content(bID, "BIZ_ID", var_load); BIZ_ENUM[bID][BIZ_ID] = strval(var_load);
		cache_get_field_content(bID, "BIZ_PRICE", var_load); BIZ_ENUM[bID][BIZ_PRICE] = strval(var_load);
		cache_get_field_content(bID, "BIZ_TYPE", var_load); BIZ_ENUM[bID][BIZ_TYPE] = strval(var_load);
		cache_get_field_content(bID, "BIZ_INTERIOR", var_load); BIZ_ENUM[bID][BIZ_INTERIOR] = strval(var_load);
		cache_get_field_content(bID, "BIZ_EXTERIOR", var_load); BIZ_ENUM[bID][BIZ_EXTERIOR] = strval(var_load);
		cache_get_field_content(bID, "BIZ_EXTERIOR_VW", var_load); BIZ_ENUM[bID][BIZ_EXTERIOR_VW] = strval(var_load);
		cache_get_field_content(bID, "BIZ_LOCKED", var_load); BIZ_ENUM[bID][BIZ_LOCKED] = strval(var_load);
		cache_get_field_content(bID, "BIZ_PASSWORD_PROTECT", var_load); BIZ_ENUM[bID][BIZ_PASSWORD_PROTECT] = strval(var_load);
		cache_get_field_content(bID, "BIZ_MONEY", var_load); BIZ_ENUM[bID][BIZ_MONEY] = strval(var_load);
		cache_get_field_content(bID, "BIZ_WORKERS_SLOT", var_load); BIZ_ENUM[bID][BIZ_WORKERS_SLOT] = strval(var_load);
		cache_get_field_content(bID, "BIZ_WORKERS_PAYDAY", var_load); BIZ_ENUM[bID][BIZ_WORKERS_PAYDAY] = strval(var_load);
		cache_get_field_content(bID, "BIZ_SHIPMENT", var_load); BIZ_ENUM[bID][BIZ_SHIPMENT] = strval(var_load);
		cache_get_field_content(bID, "BIZ_PRODUCTS", var_load); BIZ_ENUM[bID][BIZ_PRODUCTS] = strval(var_load);
		cache_get_field_content(bID, "BIZ_OWNED", var_load); BIZ_ENUM[bID][BIZ_OWNED] = strval(var_load);

		cache_get_field_content(bID, "BIZ_POS_1", var_load); BIZ_ENUM[bID][BIZ_POS][0] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_POS_2", var_load); BIZ_ENUM[bID][BIZ_POS][1] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_POS_3", var_load); BIZ_ENUM[bID][BIZ_POS][2] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_POS_4", var_load); BIZ_ENUM[bID][BIZ_POS][3] = floatstr(var_load);

		cache_get_field_content(bID, "BIZ_INT_1", var_load); BIZ_ENUM[bID][BIZ_INT][0] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_INT_2", var_load); BIZ_ENUM[bID][BIZ_INT][1] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_INT_3", var_load); BIZ_ENUM[bID][BIZ_INT][2] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_INT_4", var_load); BIZ_ENUM[bID][BIZ_INT][3] = floatstr(var_load);

		cache_get_field_content(bID, "BIZ_VEHICLE_POS_1", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_POS][0] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_POS_2", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_POS][1] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_POS_3", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_POS][2] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_POS_4", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_POS][3] = floatstr(var_load);

		cache_get_field_content(bID, "BIZ_JOB_POS_1", var_load); BIZ_ENUM[bID][BIZ_JOB_POS][0] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_JOB_POS_2", var_load); BIZ_ENUM[bID][BIZ_JOB_POS][1] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_JOB_POS_3", var_load); BIZ_ENUM[bID][BIZ_JOB_POS][2] = floatstr(var_load);
		cache_get_field_content(bID, "BIZ_JOB_PICKUP_ADDED", var_load); BIZ_ENUM[bID][BIZ_JOB_PICKUP_ADDED] = strval(var_load);

		cache_get_field_content(bID, "BIZ_VEHICLE_MODEL", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_MODEL] = strval(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_PRICE", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_PRICE] = strval(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_ID", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_ID] = strval(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_COLOR_1", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_COLOR][0] = strval(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_COLOR_2", var_load); BIZ_ENUM[bID][BIZ_VEHICLE_COLOR][1] = strval(var_load);
		cache_get_field_content(bID, "BIZ_VEHICLE_OWNER", BIZ_ENUM[bID][BIZ_VEHICLE_OWNER], _dbConnector);

		cache_get_field_content(bID, "BIZ_WORKER_1", BIZ_ENUM[bID][BIZ_WORKER_1], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_2", BIZ_ENUM[bID][BIZ_WORKER_2], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_3", BIZ_ENUM[bID][BIZ_WORKER_3], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_4", BIZ_ENUM[bID][BIZ_WORKER_4], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_5", BIZ_ENUM[bID][BIZ_WORKER_5], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_6", BIZ_ENUM[bID][BIZ_WORKER_6], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_7", BIZ_ENUM[bID][BIZ_WORKER_7], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_8", BIZ_ENUM[bID][BIZ_WORKER_8], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_9", BIZ_ENUM[bID][BIZ_WORKER_9], _dbConnector);
		cache_get_field_content(bID, "BIZ_WORKER_10",BIZ_ENUM[bID][BIZ_WORKER_10],_dbConnector);

        if(BIZ_ENUM[bID][BIZ_VEHICLE_ID] != (9999)) { Spawn_Business_Vehicle(bID); }

		for (new j = 0; j < 20; j ++)
		{
			format(var_load, sizeof(var_load), "BIZ_PRICES%d", j + 1);
			BIZ_ENUM[bID][BIZ_PRICES][j] = cache_get_field_kurac(bID, var_load);
		}
		Business_Refresh(bID); Job_Pickup_Refresh(bID);
		Iter_Add(Loaded_Business_Array,bID);
		for(new i = 0; i < MAX_BUSINESSES; ++i)
		{
			static str[128];
			if(BIZ_ENUM[i][BIZ_CREATED] != (0))
			{
				if(BIZ_ENUM[i][BIZ_TYPE] == (1))
				{
					format(str, sizeof(str), "SELECT * FROM `ug_business_furniture` WHERE `ID` = '%d'", BIZ_ENUM[i][BIZ_ID]);
			        mysql_function_query(_dbConnector, str, true, "Load_Business_Furniture", "d", i);
				}
			}
		}
	}
	return (true);
}

//=============================================================

stock Save_Business(bID)
{
	static query[2800];

	format(query,sizeof(query),"UPDATE `ug_businesses` SET `BIZ_OWNER` = '%s', `BIZ_NAME` = '%s', `BIZ_PRICE` = '%d', `BIZ_TYPE` = '%d', `BIZ_INTERIOR` = '%d', `BIZ_EXTERIOR` = '%d', `BIZ_EXTERIOR_VW` = '%d',  `BIZ_LOCKED` = '%d', `BIZ_PASSWORD_PROTECT` = '%d', `BIZ_PASSWORD` = '%s', `BIZ_OWNED` = '%d'",
	BIZ_ENUM[bID][BIZ_OWNER],
	BIZ_ENUM[bID][BIZ_NAME],
	BIZ_ENUM[bID][BIZ_PRICE],
	BIZ_ENUM[bID][BIZ_TYPE],
	BIZ_ENUM[bID][BIZ_INTERIOR],
	BIZ_ENUM[bID][BIZ_EXTERIOR],
	BIZ_ENUM[bID][BIZ_EXTERIOR_VW],
	BIZ_ENUM[bID][BIZ_LOCKED],
	BIZ_ENUM[bID][BIZ_PASSWORD_PROTECT],
	BIZ_ENUM[bID][BIZ_PASSWORD],
	BIZ_ENUM[bID][BIZ_OWNED]);
	format(query,sizeof(query),"%s, `BIZ_MONEY` = '%d', `BIZ_WORKERS_SLOT` = '%d', `BIZ_WORKERS_PAYDAY` = '%d', `BIZ_SHIPMENT` = '%d', `BIZ_PRODUCTS` = '%d', `BIZ_POS_1` = '%.4f', `BIZ_POS_2` = '%.4f', `BIZ_POS_3` = '%.4f', `BIZ_POS_4` = '%.4f'",
	query,
	BIZ_ENUM[bID][BIZ_MONEY],
	BIZ_ENUM[bID][BIZ_WORKERS_SLOT],
	BIZ_ENUM[bID][BIZ_WORKERS_PAYDAY],
	BIZ_ENUM[bID][BIZ_SHIPMENT],
	BIZ_ENUM[bID][BIZ_PRODUCTS],
	BIZ_ENUM[bID][BIZ_POS][0],
	BIZ_ENUM[bID][BIZ_POS][1],
	BIZ_ENUM[bID][BIZ_POS][2],
	BIZ_ENUM[bID][BIZ_POS][3]);
	format(query,sizeof(query),"%s, `BIZ_INT_1` = '%.4f', `BIZ_INT_2` = '%.4f', `BIZ_INT_3` = '%.4f', `BIZ_INT_4` = '%.4f', `BIZ_VEHICLE_POS_1` = '%.4f', `BIZ_VEHICLE_POS_2` = '%.4f', `BIZ_VEHICLE_POS_3` = '%.4f', `BIZ_VEHICLE_POS_4` = '%.4f'",
	query,
	BIZ_ENUM[bID][BIZ_INT][0],
	BIZ_ENUM[bID][BIZ_INT][1],
	BIZ_ENUM[bID][BIZ_INT][2],
	BIZ_ENUM[bID][BIZ_INT][3],
	BIZ_ENUM[bID][BIZ_VEHICLE_POS][0],
	BIZ_ENUM[bID][BIZ_VEHICLE_POS][1],
	BIZ_ENUM[bID][BIZ_VEHICLE_POS][2],
	BIZ_ENUM[bID][BIZ_VEHICLE_POS][3]);
	format(query,sizeof(query),"%s, `BIZ_VEHICLE_MODEL` = '%d', `BIZ_VEHICLE_PRICE` = '%d', `BIZ_VEHICLE_ID` = '%d', `BIZ_VEHICLE_COLOR_1` = '%d', `BIZ_VEHICLE_COLOR_2` = '%d', `BIZ_VEHICLE_OWNER` = '%s'",
	query,
	BIZ_ENUM[bID][BIZ_VEHICLE_MODEL],
	BIZ_ENUM[bID][BIZ_VEHICLE_PRICE],
	BIZ_ENUM[bID][BIZ_VEHICLE_ID],
	BIZ_ENUM[bID][BIZ_VEHICLE_COLOR][0],
	BIZ_ENUM[bID][BIZ_VEHICLE_COLOR][1],
	BIZ_ENUM[bID][BIZ_VEHICLE_OWNER]);

	format(query,sizeof(query),"%s, `BIZ_JOB_POS_1` = '%.4f', `BIZ_JOB_POS_2` = '%.4f', `BIZ_JOB_POS_3` = '%.4f', `BIZ_JOB_PICKUP_ADDED` = '%d'",
	query,
	BIZ_ENUM[bID][BIZ_JOB_POS][0],
	BIZ_ENUM[bID][BIZ_JOB_POS][1],
	BIZ_ENUM[bID][BIZ_JOB_POS][2],
	BIZ_ENUM[bID][BIZ_JOB_PICKUP_ADDED]);	

	for (new i = 0; i < 20; i ++) {
		format(query, sizeof(query), "%s, `BIZ_PRICES%d` = '%d'", query, i + 1, BIZ_ENUM[bID][BIZ_PRICES][i]);
	}

	format(query,sizeof(query),"%s, `BIZ_WORKER_1` = '%s', `BIZ_WORKER_2` = '%s', `BIZ_WORKER_3` = '%s', `BIZ_WORKER_4` = '%s', `BIZ_WORKER_5` = '%s', `BIZ_WORKER_6` = '%s', `BIZ_WORKER_7` = '%s', `BIZ_WORKER_8` = '%s', `BIZ_WORKER_9` = '%s', `BIZ_WORKER_10` = '%s' WHERE `BIZ_ID` = '%d'",
	query,
	BIZ_ENUM[bID][BIZ_WORKER_1],
	BIZ_ENUM[bID][BIZ_WORKER_2],
	BIZ_ENUM[bID][BIZ_WORKER_3],
	BIZ_ENUM[bID][BIZ_WORKER_4],
	BIZ_ENUM[bID][BIZ_WORKER_5],
	BIZ_ENUM[bID][BIZ_WORKER_6],
	BIZ_ENUM[bID][BIZ_WORKER_7],
	BIZ_ENUM[bID][BIZ_WORKER_8],
	BIZ_ENUM[bID][BIZ_WORKER_9],
	BIZ_ENUM[bID][BIZ_WORKER_10],bID);
	return mysql_function_query(_dbConnector, query, false, "", "");				
}

//==================================================================

stock GetFree_BusinessID()
{
	new BizID = Iter_Free(Loaded_Business_Array);
	return ((BizID < MAX_BUSINESSES) ? (BizID) : (-1));
}

stock Add_Base_Business(bizID,Owner[],Price)
{
	static query[230];
	format(query, sizeof(query), "INSERT INTO `ug_businesses` (`BIZ_ID`, `BIZ_OWNER`, `BIZ_PRICE`) VALUES(%d, '%s', %d)",bizID,Owner,Price);
    mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";
}

stock Create_Business(bID,playerid,price,type)
{
	static Float:pPos[4];

    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]); 
	GetPlayerFacingAngle(playerid, pPos[3]);

	if(BIZ_ENUM[bID][BIZ_CREATED] != 1)
	{
		BIZ_ENUM[bID][BIZ_POS][0] = pPos[0];
		BIZ_ENUM[bID][BIZ_POS][1] = pPos[1];
		BIZ_ENUM[bID][BIZ_POS][2] = pPos[2];
		BIZ_ENUM[bID][BIZ_POS][3] = pPos[3];

		BIZ_ENUM[bID][BIZ_ID] = bID;
		BIZ_ENUM[bID][BIZ_CREATED] = 1;
		BIZ_ENUM[bID][BIZ_PRICE] = price;
		BIZ_ENUM[bID][BIZ_OWNED] = 0;

		BIZ_ENUM[bID][BIZ_VEHICLE_ID] = 9999;

		SetString(BIZ_ENUM[bID][BIZ_OWNER],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_1],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_2],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_3],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_4],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_5],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_6],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_7],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_8],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_9],"Nema");
		SetString(BIZ_ENUM[bID][BIZ_WORKER_10],"Nema");

		if(type == FURNITURE_SHOP)
        {
		    SetString(BIZ_ENUM[bID][BIZ_NAME],"Furniture shop");
		    BIZ_ENUM[bID][BIZ_TYPE] = FURNITURE_SHOP;

		    BIZ_ENUM[bID][BIZ_INT][0] = 1150.5138;
		    BIZ_ENUM[bID][BIZ_INT][1] = 1280.5154;
		    BIZ_ENUM[bID][BIZ_INT][2] = -76.5331;
		    BIZ_ENUM[bID][BIZ_INT][3] = 264.6243;

		    BIZ_ENUM[bID][BIZ_INTERIOR] = bID + 1;
			BIZ_ENUM[bID][BIZ_EXTERIOR] = bID + 1;
			BIZ_ENUM[bID][BIZ_EXTERIOR_VW] = GetPlayerVirtualWorld(playerid);
		}
		else if(type == AMMUNATION_SHOP)
		{
			SetString(BIZ_ENUM[bID][BIZ_NAME],"Ammunation shop");
		    BIZ_ENUM[bID][BIZ_TYPE] = AMMUNATION_SHOP;

		    BIZ_ENUM[bID][BIZ_INT][0] = 316.524993;
		    BIZ_ENUM[bID][BIZ_INT][1] = -167.706985;
		    BIZ_ENUM[bID][BIZ_INT][2] = 999.593750;
		    BIZ_ENUM[bID][BIZ_INT][3] = 360.000;

		    BIZ_ENUM[bID][BIZ_INTERIOR] = 6;
			BIZ_ENUM[bID][BIZ_EXTERIOR] = bID + 1;
			BIZ_ENUM[bID][BIZ_EXTERIOR_VW] = GetPlayerVirtualWorld(playerid);
		}
		else if(type == RESTAURANT)
		{
			SetString(BIZ_ENUM[bID][BIZ_NAME],"Restaurant");
		    BIZ_ENUM[bID][BIZ_TYPE] = RESTAURANT;

		    BIZ_ENUM[bID][BIZ_INT][0] = 501.980987;
		    BIZ_ENUM[bID][BIZ_INT][1] = -69.150199;
		    BIZ_ENUM[bID][BIZ_INT][2] = 998.757812;
		    BIZ_ENUM[bID][BIZ_INT][3] = 360.000;

		    BIZ_ENUM[bID][BIZ_INTERIOR] = 11;
			BIZ_ENUM[bID][BIZ_EXTERIOR] = bID + 1;
			BIZ_ENUM[bID][BIZ_EXTERIOR_VW] = GetPlayerVirtualWorld(playerid);
		}
		else if(type == MARKET_SHOP)
		{
			SetString(BIZ_ENUM[bID][BIZ_NAME],"Market");
		    BIZ_ENUM[bID][BIZ_TYPE] = MARKET_SHOP;

		    BIZ_ENUM[bID][BIZ_INT][0] = -25.132598;
		    BIZ_ENUM[bID][BIZ_INT][1] = -139.066986;
		    BIZ_ENUM[bID][BIZ_INT][2] = 1003.546875;
		    BIZ_ENUM[bID][BIZ_INT][3] = 360.000;

		    BIZ_ENUM[bID][BIZ_INTERIOR] = 16;
			BIZ_ENUM[bID][BIZ_EXTERIOR] = bID + 1;
			BIZ_ENUM[bID][BIZ_EXTERIOR_VW] = GetPlayerVirtualWorld(playerid);
		}
		else if(type == BINCO_SHOP)
		{
			SetString(BIZ_ENUM[bID][BIZ_NAME],"Binco shop");
		    BIZ_ENUM[bID][BIZ_TYPE] = BINCO_SHOP;

		    BIZ_ENUM[bID][BIZ_INT][0] = 207.737991;
		    BIZ_ENUM[bID][BIZ_INT][1] = -109.019996;
		    BIZ_ENUM[bID][BIZ_INT][2] = 1005.132812;
		    BIZ_ENUM[bID][BIZ_INT][3] = 360.000;

		    BIZ_ENUM[bID][BIZ_INTERIOR] = 15;
			BIZ_ENUM[bID][BIZ_EXTERIOR] = bID + 1;
			BIZ_ENUM[bID][BIZ_EXTERIOR_VW] = GetPlayerVirtualWorld(playerid);
		}
		Save_Business(bID);
		Business_Refresh(bID);    
	}
	return (true);
}

stock RemoveEmployer(playerid,bizid,name[])
{
	if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_1], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_1]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_1])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_1],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_2], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_2]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_2])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_2],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_3], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_3]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_3])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_3],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_4], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_4]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_4])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_4],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_5], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_5]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_5])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_5],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_6], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_6]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_6])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_6],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_7], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_7]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_7])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_7],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_8], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_8]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_8])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_8],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_9], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_9]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_9])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_9],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_10], name, true))
	{
		INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_10]),"Dobili ste otkaz od svog poslodavca (%s).",BIZ_ENUM[bizid][BIZ_NAME]);
		Player_Enum[GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_10])][p_Business_Job] = (9999);

		SetString(BIZ_ENUM[bizid][BIZ_WORKER_10],"Nema");
		BIZ_ENUM[bizid][BIZ_WORKERS_SLOT] --;
	}
	else return GRESKA(playerid,"Uneseni igrac nije zaposlenik vase firme.");
	return (true);
}

stock PayEmployer(playerid,bizid,name[])
{
	// dodati da mu dadne platu na varijablu
	if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_1], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_1]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
            INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_1]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_2], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_2]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_2]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_3], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_3]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_3]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_4], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_4]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_4]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_5], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_5]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_5]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_6], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_6]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_6]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_7], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_7]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_7]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_8], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_8]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_8]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_9], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_9]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_9]);
	}
	else if (!strcmp(BIZ_ENUM[bizid][BIZ_WORKER_10], name, true))
	{
            INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_10]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	        INFO(playerid,"Uspesno ste dali platu zaposleniku: %s",BIZ_ENUM[bizid][BIZ_WORKER_10]);
	}
	else return GRESKA(playerid,"Uneseni igrac nije vas zaposlenik.");
	return (true);
}

stock PayAllEmployers(bizid)
{
	// dodati da mu dadne platu.
	if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_1], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_1]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_1]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_2], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_2]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_2]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_3], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_3]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_3]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_4], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_4]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_4]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_5], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_5]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_5]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_6], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_6]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_6]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_7], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_7]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_7]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_8], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_8]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_8]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_9], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_9]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_9]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_10], "Nema") != 0 && GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_10]) != IPI)
	{
         INFO(GetPlayerIdFromName(BIZ_ENUM[bizid][BIZ_WORKER_10]),"Vas poslodavac %s vam je urucio platu u iznosu od $%d.",BIZ_ENUM[bizid][BIZ_OWNER],BIZ_ENUM[bizid][BIZ_WORKERS_PAYDAY]);
	}
	return (true);
}

stock Business_Refresh(bID)
{
	if(bID != -1 && BIZ_ENUM[bID][BIZ_CREATED] != (0))
	{
            if(IsValidDynamicPickup(BIZ_ENUM[bID][BIZ_PICKUP]))
		       DestroyDynamicPickup(BIZ_ENUM[bID][BIZ_PICKUP]);

		    if(IsValidDynamic3DTextLabel(BIZ_ENUM[bID][BIZ_LABEL]))
		       DestroyDynamic3DTextLabel(BIZ_ENUM[bID][BIZ_LABEL]);

		    static string[200],
		    pickupid;
		    
		    if(BIZ_ENUM[bID][BIZ_OWNED] != (1))
		    {
		          format(string,sizeof(string),"{0A77F5}%s {FFFFFF}na prodaju.\n{0A77F5}Adresa: {FFFFFF}IL-%d\n{0A77F5}Cijena: {FFFFFF}%s\n{0A77F5}Za kupovinu kucajte {FFFFFF}/buybusiness."
		          ,BIZ_ENUM[bID][BIZ_NAME],bID,FormatNumber(BIZ_ENUM[bID][BIZ_PRICE]));
		          BIZ_ENUM[bID][BIZ_LABEL] = CreateDynamic3DTextLabel(string, 0x33AA33FF, BIZ_ENUM[bID][BIZ_POS][0], BIZ_ENUM[bID][BIZ_POS][1], BIZ_ENUM[bID][BIZ_POS][2] + 0.7, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BIZ_ENUM[bID][BIZ_EXTERIOR_VW], 0);
		          BIZ_ENUM[bID][BIZ_PICKUP] = CreateDynamicPickup(1272, 23, BIZ_ENUM[bID][BIZ_POS][0], BIZ_ENUM[bID][BIZ_POS][1], BIZ_ENUM[bID][BIZ_POS][2], BIZ_ENUM[bID][BIZ_EXTERIOR_VW], 0);
		    }
		    else
		    {
		    	format(string,sizeof(string),"{0A77F5}%s\n{0A77F5}Adresa {FFFFFF}IL-%d\n{0A77F5}Vlasnik: {FFFFFF}%s",BIZ_ENUM[bID][BIZ_NAME],bID,BIZ_ENUM[bID][BIZ_OWNER]);
		    	switch(BIZ_ENUM[bID][BIZ_TYPE]){
		    		case 1: pickupid = 2096;
		    		case 2: pickupid = 1313;
		    		case 3..4: pickupid = 1239;
		    		case 5: pickupid = 1275;		    	
		    	}
		    	if(BIZ_ENUM[bID][BIZ_TYPE] == FURNITURE_SHOP)
		    	{
		    		BIZ_ENUM[bID][BIZ_PICKUP] = CreateDynamicPickup(pickupid, 23, BIZ_ENUM[bID][BIZ_POS][0], BIZ_ENUM[bID][BIZ_POS][1], BIZ_ENUM[bID][BIZ_POS][2] - 0.6, BIZ_ENUM[bID][BIZ_EXTERIOR_VW], 0);
		    	}
		    	else
		    	BIZ_ENUM[bID][BIZ_PICKUP] = CreateDynamicPickup(pickupid, 23, BIZ_ENUM[bID][BIZ_POS][0], BIZ_ENUM[bID][BIZ_POS][1], BIZ_ENUM[bID][BIZ_POS][2], BIZ_ENUM[bID][BIZ_EXTERIOR_VW], 0);
		    	BIZ_ENUM[bID][BIZ_LABEL] = CreateDynamic3DTextLabel(string, 0x33AA33FF, BIZ_ENUM[bID][BIZ_POS][0], BIZ_ENUM[bID][BIZ_POS][1], BIZ_ENUM[bID][BIZ_POS][2] + 0.7, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BIZ_ENUM[bID][BIZ_EXTERIOR_VW], 0);
		    }      
	}
    return (true);
}

stock Job_Pickup_Refresh(bID)
{
	if(bID != -1 && BIZ_ENUM[bID][BIZ_CREATED] != (0) && BIZ_ENUM[bID][BIZ_JOB_PICKUP_ADDED] != (0))
	{
		    if(IsValidDynamicPickup(BIZ_ENUM[bID][BIZ_JOB_PICKUP]))
		       DestroyDynamicPickup(BIZ_ENUM[bID][BIZ_JOB_PICKUP]);

		    if(IsValidDynamic3DTextLabel(BIZ_ENUM[bID][BIZ_JOB_LABEL]))
		       DestroyDynamic3DTextLabel(BIZ_ENUM[bID][BIZ_JOB_LABEL]);

		    static string[200];

		    format(string,sizeof(string),"{2DA127}%s\n{FFFFFF}Da se zaposlite u ovom biznisu kucajte {2DA127}/jobrequest",BIZ_ENUM[bID][BIZ_NAME]);
		    BIZ_ENUM[bID][BIZ_JOB_LABEL] = CreateDynamic3DTextLabel(string, 0x33AA33FF, BIZ_ENUM[bID][BIZ_JOB_POS][0], BIZ_ENUM[bID][BIZ_JOB_POS][1], BIZ_ENUM[bID][BIZ_JOB_POS][2] + 0.7, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BIZ_ENUM[bID][BIZ_EXTERIOR], BIZ_ENUM[bID][BIZ_INTERIOR]);
		    BIZ_ENUM[bID][BIZ_JOB_PICKUP] = CreateDynamicPickup(1210, 23, BIZ_ENUM[bID][BIZ_JOB_POS][0], BIZ_ENUM[bID][BIZ_JOB_POS][1], BIZ_ENUM[bID][BIZ_JOB_POS][2], BIZ_ENUM[bID][BIZ_EXTERIOR], BIZ_ENUM[bID][BIZ_INTERIOR]);

	}
	return (true);
}

stock Exit_Business(playerid,id)
{
	SetPlayerPos(playerid,BIZ_ENUM[id][BIZ_POS][0],BIZ_ENUM[id][BIZ_POS][1],BIZ_ENUM[id][BIZ_POS][2]);
	SetPlayerFacingAngle(playerid,BIZ_ENUM[id][BIZ_POS][3]);

	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,BIZ_ENUM[id][BIZ_EXTERIOR_VW]);

	SetCameraBehindPlayer(playerid); Entered_Business[playerid] = (-1);

	TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);
	return (true);
}

function Delete_Business(bID)
{
	if(bID != -1 && BIZ_ENUM[bID][BIZ_CREATED] != (0))
	{
		if(IsValidDynamicPickup(BIZ_ENUM[bID][BIZ_PICKUP]))
		DestroyDynamicPickup(BIZ_ENUM[bID][BIZ_PICKUP]);

		if(IsValidDynamic3DTextLabel(BIZ_ENUM[bID][BIZ_LABEL]))
		DestroyDynamic3DTextLabel(BIZ_ENUM[bID][BIZ_LABEL]);

		BIZ_ENUM[bID][BIZ_CREATED] = 0;
		BIZ_ENUM[bID][BIZ_ID] = -1;
	}
	return (true);	
}

//==================================================================

stock BuyBusiness_Vehicle(bizid,modelid,price)
{
	BIZ_ENUM[bizid][BIZ_VEHICLE_ID] = (bizid);
	BIZ_ENUM[bizid][BIZ_VEHICLE_MODEL] = (modelid);
    BIZ_ENUM[bizid][BIZ_VEHICLE_COLOR][0] = random(10);
    BIZ_ENUM[bizid][BIZ_VEHICLE_COLOR][1] = random(10);
    BIZ_ENUM[bizid][BIZ_VEHICLE_PRICE] = price;
    BIZ_ENUM[bizid][BIZ_VEHICLE_SPAWNED] = 0;
    SetString(BIZ_ENUM[bizid][BIZ_VEHICLE_OWNER],BIZ_ENUM[bizid][BIZ_OWNER]);
    Save_Business(bizid);
	return (true);
}

stock Spawn_Business_Vehicle(i)
{
	BIZ_ENUM[i][BIZ_VEHICLE_CREATE] = AddStaticVehicleEx(BIZ_ENUM[i][BIZ_VEHICLE_MODEL], BIZ_ENUM[i][BIZ_VEHICLE_POS][0],BIZ_ENUM[i][BIZ_VEHICLE_POS][1],BIZ_ENUM[i][BIZ_VEHICLE_POS][2],BIZ_ENUM[i][BIZ_VEHICLE_POS][3], BIZ_ENUM[i][BIZ_VEHICLE_COLOR][0], BIZ_ENUM[i][BIZ_VEHICLE_COLOR][1], 30000);
    SetVehicleToRespawn(BIZ_ENUM[i][BIZ_VEHICLE_CREATE]);
    BIZ_ENUM[i][BIZ_VEHICLE_SPAWNED] = (1);
	return (true);
}

//==================================================================

stock Business_Request_Add(bizid, playerid, text[])
{
	for(new i = 0; i != MAX_JOB_REQUESTS; ++i)
	{
        BUSINESS_JOB_REQUEST[bizid][i][r_Exist] = (1);
        SetString(BUSINESS_JOB_REQUEST[bizid][i][r_Name],GetName(playerid));
        SetString(BUSINESS_JOB_REQUEST[bizid][i][r_Message],text);
        return (i);
	}
	return (-1);
}

stock IsRequested_Job(bizid,playerid)
{
	for(new i = 0; i != MAX_JOB_REQUESTS; i++)
	{
          if(strfind(BUSINESS_JOB_REQUEST[bizid][i][r_Name], GetName(playerid), true) != -1)
		  return (true);
	}
	return (-1);
}

stock Show_Job_Requests(playerid,bizid)
{
	new request_string[350];
	new count = 0;

	for(new i = 0; i != MAX_JOB_REQUESTS; i++)
	{
		if(BUSINESS_JOB_REQUEST[bizid][i][r_Exist] != (0))
		{
            format(request_string,sizeof(request_string),"%s{FFFFFF}Job requester: {069935}(%s)\n",request_string, BUSINESS_JOB_REQUEST[bizid][i][r_Name]);
            count ++;
		}
	}
	if(count == (0))
	  return GRESKA(playerid,"Niko nije konkurisao za posao u vasoj firmi.");
	else
	  Dialog_Show(playerid, Business_Job_Requesters, DSL, "{FFD000}REQUESTERS {FFFFFF}- LIST", request_string, "Choose", "Cancel");  
	return (true);
}


stock Remove_Biz_Request(bizid,reqid)
{
	if(BUSINESS_JOB_REQUEST[bizid][reqid][r_Exist] != 0)
	{
		BUSINESS_JOB_REQUEST[bizid][reqid][r_Exist] = (0);
		SetString(BUSINESS_JOB_REQUEST[bizid][reqid][r_Name],"Nema");
		SetString(BUSINESS_JOB_REQUEST[bizid][reqid][r_Message],"Nema");
	}
	return (true);
}

stock Add_Business_Worker(bizid,playerid)
{
	if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_1], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_1],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_2], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_2],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_3], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_3],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_4], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_4],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_5], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_5],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_6], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_6],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_7], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_7],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_8], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_8],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_9], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_9],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	else if (strcmp(BIZ_ENUM[bizid][BIZ_WORKER_10], "Nema", true) == 0)
	{
		SetString(BIZ_ENUM[bizid][BIZ_WORKER_10],GetName(playerid));
		Player_Enum[playerid][p_Business_Job] = (bizid);
	}
	Save_Business(bizid);
	return (true);
}

//==================================================================


stock Business_Nearest(playerid)
{
    for (new i = 0; i != MAX_BUSINESSES; i ++) if (BIZ_ENUM[i][BIZ_CREATED] != (0) && IsPlayerInRangeOfPoint(playerid, 2.5, BIZ_ENUM[i][BIZ_POS][0], BIZ_ENUM[i][BIZ_POS][1], BIZ_ENUM[i][BIZ_POS][2]))
	{
		if (GetPlayerVirtualWorld(playerid) == BIZ_ENUM[i][BIZ_EXTERIOR_VW])
			return (i);
	}
	return (-1);
}

stock Business_Inside(playerid)
{
	if(Entered_Business[playerid] != (-1))
	{
	    for (new i = 0; i != MAX_BUSINESSES; i ++) if (BIZ_ENUM[i][BIZ_CREATED] != (0) && GetPlayerInterior(playerid) == BIZ_ENUM[i][BIZ_INTERIOR] && GetPlayerVirtualWorld(playerid) == BIZ_ENUM[i][BIZ_EXTERIOR]) {
	        return (i);
		}
	}	
	return (-1);
}

stock Business_IsOwner(playerid,bizid)
{
	if ((BIZ_ENUM[bizid][BIZ_CREATED] && BIZ_ENUM[bizid][BIZ_OWNED] != 0) && !strcmp(BIZ_ENUM[bizid][BIZ_OWNER], GetName(playerid), true))
        return (true);
        
    return (false);
}


//==================================================================	