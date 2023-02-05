
#include <YSI\y_hooks>

//========================================================
/*
                  Balkan Rising
                     0.0.1x
                 Inventory System
*/
//=========================================================

#define MAX_INVENTORY (30)
#define MAX_LISTED_ITEMS (10)
#define MODEL_SELECTION_INVENTORY (4)

//=========================================================

#define MAX_DROPPED_ITEMS (5000)

//=========================================================

new Item_ID[MAX_PLAYERS] = INVALID_PLAYER_ID;
new Item_ID_Give[MAX_PLAYERS] = INVALID_PLAYER_ID;
new NearestItems[MAX_PLAYERS][MAX_LISTED_ITEMS];

//=========================================================

new Holding_Weapon[MAX_PLAYERS] = (-1);

//=========================================================

enum inventoryData{
	invExists,
	invID,
	invOwner[32 char],
	invItem[32 char],
	invModel,
	invQuantity
};
new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];

//==========================================================

enum droppedItems
{
	droppedID,
	droppedItem[32],
	droppedPlayer[24],
	droppedModel,
	droppedQuantity,
	Float:droppedPos[3],
	droppedWeapon,
	droppedAmmo,
	droppedInt,
	droppedWorld,
	droppedObject
};

new DroppedItems[MAX_DROPPED_ITEMS][droppedItems];

//===========================================================

YCMD:inventory(playerid,params[],help)
{
	OpenPlayerInventory(playerid);
	return (true);
}

YCMD:pickupitem(playerid,params[],help)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK)
    {
        	  new count = 0,string[256],id = Get_Nearest_Item(playerid);

        	  if (id != (-1))
		      {
		      	     string = "\0";
                     for (new i = 0; i < MAX_DROPPED_ITEMS; i ++) if (count < MAX_LISTED_ITEMS && DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]) && GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld])
                     {
                         NearestItems[playerid][count++] = i;
                         strcat(string, DroppedItems[i][droppedItem]);
		                 strcat(string, "\n");
                     }
		             if (count == 1)
		             {
		                    if (DroppedItems[id][droppedWeapon] != 0)
							{
				                    new invidd = Inventory_Add(playerid, ReturnWeaponName(DroppedItems[id][droppedWeapon]), InventoryData[playerid][id][invModel]);
								    if (invidd == -1)
							             return GRESKA(playerid,"Nemate slobodnih slotova u inventaru!");  

							        c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s se spusta i uzima: %s ))", GetName(playerid), ReturnWeaponName(DroppedItems[id][droppedWeapon]));     

									Delete_Droped_Item(id);
							}
							else if (PickupItem(playerid, id))
							{
				                  c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s se spusta i uzima: %s ))", GetName(playerid), DroppedItems[id][droppedItem]);
							}
							else GRESKA(playerid,"Nemate vise mjesta u svom inventaru!");
					 }
					 else Dialog_Show(playerid, Pickup_Items, DIALOG_STYLE_LIST, "{ECFAA0}Podizanje itema:", string, "Podigni", "Odustani");	   
		      }
    }    
	return (true);
}

YCMD:putback(playerid,params[],help)
{
	if(Holding_Weapon[playerid] != (-1))
	{
		HoldWeapon(playerid,0);
		INFO(playerid,"Uspesno ste vratili oruzije u inventar.");
	}
	else if(Attached_Item[playerid][0] != (0))
	{
		Attached_Item[playerid][0] = 0;
	}
	return (true);
}

YCMD:deleteitem(playerid,params[],help)
{
	static id = -1;

	if(Player_Enum[playerid][p_Admin] < 6)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if ((id = Get_Nearest_Item(playerid)) == -1)
	   return GRESKA(playerid,"Niste u blizi ni jednog itema!!");

	INFO(playerid,"Uspesno ste obrisali item (%s).",DroppedItems[id][droppedItem]);   

    Item_Delete(id);	       
	return (true);
}

YCMD:test(playerid,params[],help)
{
	Inventory_Add(playerid, "Desert Eagle", 348);
	Inventory_Add(playerid, "Magazine", 2039);
	return (true);
}

//==========================================================

Dialog:Player_Inventory(playerid, response, listitem, inputtext[])
{
    if (response)
	{
		 new itemid = Item_ID[playerid],string[64];
		 strunpack(string, InventoryData[playerid][itemid][invItem]);
		 switch (listitem)
	     {
                 case 0:
	             {
	             	  CallLocalFunction("OnPlayerUseItem", "dds", playerid, itemid, string);
	             }
	             case 1:
	             {
	             	  Dialog_Show(playerid, Give_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Unesite ime ili ID igraca kojem dajete item.", "Nastavi", "Odustani");
	             }
	             case 2:
	             {
                        if(InventoryData[playerid][itemid][invQuantity] == 1)
					          DropPlayerItem(playerid, itemid);
					    else
                              Dialog_Show(playerid, Drop_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item drop:", "{FFFFFF}Item: {ECFAA0}(( %s ))\n{FFFFFF}Kolicina ovog itema: {ECFAA0}(( %d )).\n\n{FFFFFF}Unesite kolicinu ovog itema, koju cete izbaciti.", "Izbaci", "Odustani",string,InventoryData[playerid][itemid][invQuantity]);
	             }
	             case 3:
	             {
	             	   
	             }
	     }       
	}
	return (true);
}

Dialog:Give_Item(playerid, response, listitem, inputtext[])
{
    if (response)
	{
          static idigraca = -1,itemid = -1,string[32];
          if (sscanf(inputtext, "u", idigraca))
			  return Dialog_Show(playerid, Give_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Unesite ime ili ID igraca kojem dajete item.", "Nastavi", "Odustani");
          if (idigraca == INVALID_PLAYER_ID)
			  return Dialog_Show(playerid, Give_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Unesite ime ili ID igraca kojem dajete item.", "Nastavi", "Odustani");
          if (!IsPlayerNearPlayer(playerid, idigraca, 6.0))
			  return Dialog_Show(playerid, Give_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Unesite ime ili ID igraca kojem dajete item.", "Nastavi", "Odustani");
          if (idigraca == playerid)
			  return Dialog_Show(playerid, Give_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Unesite ime ili ID igraca kojem dajete item.", "Nastavi", "Odustani");

		  itemid = Item_ID[playerid];

		  if (itemid == -1)
		    return (false);

		  strunpack(string, InventoryData[playerid][itemid][invItem]);

		  if (InventoryData[playerid][itemid][invQuantity] == 1)
		  {
              new id = Inventory_Add(idigraca, string, InventoryData[playerid][itemid][invModel]);
              if (id == -1)
				  return GRESKA(playerid,"Svi slotovi ovog igraca su popunjeni!");
				  
			  Inventory_Remove(playerid, string);
				  
		  }
		  else
		  {
              Dialog_Show(playerid, Give_Item_Kolicina, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Item: {ECFAA0}(( %s ))\n{FFFFFF}Kolicina ovog itema: {ECFAA0}(( %d )).\n\n{FFFFFF}Unesite kolicinu ovog itema, koji cete dati {ECFAA0}(( %s )).", "Nastavi", "Odustani",string,InventoryData[playerid][itemid][invQuantity],GetName(idigraca));
              Item_ID_Give[playerid] = idigraca;
		  }
	}
	return (true);
}

Dialog:Give_Item_Kolicina(playerid, response, listitem, inputtext[])
{
    if (response && Item_ID_Give[playerid] != INVALID_PLAYER_ID)
	{
		  new  idigraca = Item_ID_Give[playerid],itemid = Item_ID[playerid],string[32];

		  strunpack(string, InventoryData[playerid][itemid][invItem]);
		  if (isnull(inputtext))
			  return Dialog_Show(playerid, Give_Item_Kolicina, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Item: {ECFAA0}(( %s ))\n{FFFFFF}Kolicina ovog itema: {ECFAA0}(( %d )).\n\n{FFFFFF}Unesite kolicinu ovog itema, koji cete dati {ECFAA0}(( %s )).", "Nastavi", "Odustani",string,InventoryData[playerid][itemid][invQuantity],GetName(idigraca));
          if (strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][invQuantity])
			  return Dialog_Show(playerid, Give_Item_Kolicina, DIALOG_STYLE_INPUT, "{ECFAA0}Item give:", "{FFFFFF}Item: {ECFAA0}(( %s ))\n{FFFFFF}Kolicina ovog itema: {ECFAA0}(( %d )).\n\n{FFFFFF}Unesite kolicinu ovog itema, koji cete dati {ECFAA0}(( %s )).", "Nastavi", "Odustani",string,InventoryData[playerid][itemid][invQuantity],GetName(idigraca));

		  new id = Inventory_Add(idigraca, string, InventoryData[playerid][itemid][invModel], strval(inputtext));
		  if (id == -1)
			  return GRESKA(playerid,"Igrac kojem pokusavate dati item nema slobodnih slotova!");

		  INFO(playerid,"Uspesno ste dali item: (%s), kolicina: %d igracu (%s).",string,inputtext,GetName(idigraca));	  
			  
          Inventory_Remove(playerid, string, strval(inputtext));
	}
	return (true);
}

Dialog:Drop_Item(playerid, response, listitem, inputtext[])
{
    new itemid = Item_ID[playerid],string[32];

    strunpack(string, InventoryData[playerid][itemid][invItem]);
    if (response)
	{
        if (isnull(inputtext))
			return Dialog_Show(playerid, Drop_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item drop:", "{FFFFFF}Item: {ECFAA0}(( %s ))\n{FFFFFF}Kolicina ovog itema: {ECFAA0}(( %d )).\n\n{FFFFFF}Unesite kolicinu ovog itema, koju cete izbaciti.", "Izbaci", "Odustani",string,InventoryData[playerid][itemid][invQuantity]);
		if (strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][invQuantity])
			return Dialog_Show(playerid, Drop_Item, DIALOG_STYLE_INPUT, "{ECFAA0}Item drop:", "{FFFFFF}Item: {ECFAA0}(( %s ))\n{FFFFFF}Kolicina ovog itema: {ECFAA0}(( %d )).\n\n{FFFFFF}Unesite kolicinu ovog itema, koju cete izbaciti.", "Izbaci", "Odustani",string,InventoryData[playerid][itemid][invQuantity]);

		DropPlayerItem(playerid, itemid, strval(inputtext));
	}
	return (true);
}

Dialog:Pickup_Items(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		  new id = NearestItems[playerid][listitem];
          if (id != -1 && DroppedItems[id][droppedModel])
		  {
		  	             if (DroppedItems[id][droppedWeapon] != 0)
						 {
                               new invidd = Inventory_Add(playerid, ReturnWeaponName(DroppedItems[id][droppedWeapon]), InventoryData[playerid][id][invModel]);
				               if(invidd == -1)
								  return GRESKA(playerid,"Nemate slobodnih slotova u inventaru!");  

							   Delete_Droped_Item(id);
							   c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s se spusta i uzima: %s ))", GetName(playerid), ReturnWeaponName(DroppedItems[id][droppedWeapon]));
						 }
						 else if (PickupItem(playerid, id))
						 {
                               c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s se spusta i uzima: %s ))", GetName(playerid), DroppedItems[id][droppedItem]);
						 }
						 else GRESKA(playerid,"Nemate vise mjesta u svom inventaru!");
		  }
	}
	return (true);
}


//==========================================================

stock OpenPlayerInventory(playerid)
{
   static items[MAX_INVENTORY],amounts[MAX_INVENTORY];

   for (new i = 0; i < 30; i ++)
   {
 		if (InventoryData[playerid][i][invExists] == 1)
	    {
   			items[i] = InventoryData[playerid][i][invModel];
   			amounts[i] = InventoryData[playerid][i][invQuantity];
		}
		else
		{
		    items[i] = -1;
		    amounts[i] = -1;
		}
   }
   ShowModelSelectionMenu(playerid, "", MODEL_SELECTION_INVENTORY, items, sizeof(items), 0.0, 0.0, 0.0, 1.0, -1, true, amounts);
   return (true);
}

//============================================================

stock Inventory_Add(playerid, item[], model, quantity = 1)
{
   new itemid = Inventory_GetItemID(playerid, item),db_string[256];

   if (itemid == (-1))
   {
        itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
                InventoryData[playerid][itemid][invID] = itemid;
                InventoryData[playerid][itemid][invExists] = true;
		        InventoryData[playerid][itemid][invModel] = model;
		        InventoryData[playerid][itemid][invQuantity] = quantity;

		        strpack(InventoryData[playerid][itemid][invItem], item, 32 char);
		        
                format(db_string, sizeof(db_string), "INSERT INTO `ug_inventory` (`invItem`, `invID`, `invOwner`, `invModel`, `invQuantity`) VALUES('%s', %d, '%s', %d, %d)", item,InventoryData[playerid][itemid][invID], Escape_String(GetName(playerid)), model, quantity);
                mysql_function_query(_dbConnector, db_string, false, "", "");
		        return (itemid);
	    }
	    return (-1);
   }
   else
   {
        format(db_string, sizeof(db_string), "UPDATE `ug_inventory` SET `invQuantity` = `invQuantity` + %d WHERE `invOwner` = '%s'",quantity, Escape_String(GetName(playerid)));
	    mysql_function_query(_dbConnector, db_string, false, "", "");
	    
	    InventoryData[playerid][itemid][invQuantity] += quantity;
   }
   return (itemid);
}

stock Inventory_Remove(playerid, item[], quantity = 1)
{
    new itemid = Inventory_GetItemID(playerid, item),db_string[128];

    if (itemid != (-1))
	{
                if (InventoryData[playerid][itemid][invQuantity] > 0)
			    {
			        InventoryData[playerid][itemid][invQuantity] -= quantity;
				}
				if (quantity == -1 || InventoryData[playerid][itemid][invQuantity] < 1)
		        {
                    InventoryData[playerid][itemid][invExists] = 0;
				    InventoryData[playerid][itemid][invModel] = 0;
				    InventoryData[playerid][itemid][invQuantity] = 0;
				    
				    format(db_string, sizeof(db_string), "DELETE FROM `ug_inventory` WHERE `invOwner` = '%s' AND `invID` = '%d'",GetName(playerid),InventoryData[playerid][itemid][invID]);
                    mysql_function_query(_dbConnector, db_string, false, "", ""); db_string = "\0";
                    
                    InventoryData[playerid][itemid][invID] = 0;
				    
		        }
		        else if (quantity != -1 && InventoryData[playerid][itemid][invQuantity] > 0)
		        {
                    format(db_string, sizeof(db_string), "UPDATE `ug_inventory` SET `invQuantity` = `invQuantity` - %d WHERE `invOwner` = '%s' AND `invID` = '%d'",quantity,GetName(playerid),InventoryData[playerid][itemid][invID]);
                    mysql_function_query(_dbConnector, db_string, false, "", ""); db_string = "\0";
		        }
		        return (true);
	}
	return (false);
}

//================================================================

stock Attach_Inventory_Bag(playerid)
{
	SetPlayerAttachedObject(playerid, 0, 371, 1, 0.025000, -0.115999, -0.010000, 0.000000, 86.899978, 0.000000, 1.000000, 1.000000, 1.000000, 0, 0);
	return (true);
}

stock PlayReloadAnimation(playerid, weaponid)
{
	switch (weaponid)
	{
	    case 22: ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0);
		case 23: ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.0, 0, 0, 0, 0, 0);
		case 24: ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0);
		case 25, 27: ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0);
		case 26: ApplyAnimation(playerid, "COLT45", "sawnoff_reload", 4.0, 0, 0, 0, 0, 0);
		case 29..31, 33, 34: ApplyAnimation(playerid, "RIFLE", "rifle_load", 4.0, 0, 0, 0, 0, 0);
		case 28, 32: ApplyAnimation(playerid, "TEC", "tec_reload", 4.0, 0, 0, 0, 0, 0);
	}
	return (true);
}

//=================================================================

stock Inventory_GetItemID(playerid, item[])
{
	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        continue;

		if (!strcmp(InventoryData[playerid][i][invItem], item)) return (i);
	}
	return (-1);
}

stock Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= 30)
		return (-1);

	for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        return (i);
	}
	return (-1);
}

stock Inventory_Items(playerid)
{
    new count;
    for (new i = 0; i != MAX_INVENTORY; i ++)
    {
		if (InventoryData[playerid][i][invExists])
		{
	        count ++;
		}
	}
	return (count);
}

stock Inventory_Count(playerid, item[])
{
	new itemid = Inventory_GetItemID(playerid, item);
	if (itemid != -1)
	    return (InventoryData[playerid][itemid][invQuantity]);

	return (false);
}

stock Inventory_HasItem(playerid, item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

//==============================================================

stock Reset_Inventory_Var(playerid)
{
	for (new i = 0; i != MAX_INVENTORY; i ++)
	{
		    InventoryData[playerid][i][invExists] = 0;
		    InventoryData[playerid][i][invModel] = 0;
		    InventoryData[playerid][i][invQuantity] = 0;
	}
	for (new i = 0; i < MAX_LISTED_ITEMS; i ++)
	{
	        NearestItems[playerid][i] = -1;
	}
	for (new i = 0; i < 12; i ++) 
	{
	    Player_Enum[playerid][pGuns][i] = 0;
	    Player_Enum[playerid][pAmmo][i] = 0;
	}
	return (true);
}

stock Inventory_Clear(playerid)
{
	static db_string[64];
    for (new i = 0; i < MAX_INVENTORY; i ++)
	{
	    if (InventoryData[playerid][i][invExists])
	    {
	        InventoryData[playerid][i][invExists] = 0;
	        InventoryData[playerid][i][invModel] = 0;
	        InventoryData[playerid][i][invQuantity] = 0;
		}
	}
	format(db_string, sizeof(db_string), "DELETE FROM `ug_inventory` WHERE `invOwner` = '%s'",GetName(playerid));
	return mysql_function_query(_dbConnector, db_string, false, "", "");
}

//===============================================================

stock Use_Magazine(playerid)
{
	new weaponid = Holding_Weapon[playerid];

    if(weaponid != (-1))
    {
    		if (!Inventory_HasItem(playerid, "Magazine"))
	          return GRESKA(playerid, "Nemate ni jedan paket municije u inventaru.");
	        if(GetPlayerWeapon(playerid) != 0)
	          return GRESKA(playerid,"vec drzite oruzije u ruci.");  

	        switch (weaponid)
	        {
	               case 22:
	               {
	               	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "Colt 45");

	               	      GiveWeaponToPlayer(playerid, weaponid, 20);

	               }
	               case 24:
	               {
	               	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "Desert Eagle");

	               	      GiveWeaponToPlayer(playerid, weaponid, 10);
	               }
	               case 25:
	               {
	               	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "Shotgun");

	               	      GiveWeaponToPlayer(playerid, weaponid, 5);
	               }
	               case 28:
	               {
	               	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "Micro SMG");

	               	      GiveWeaponToPlayer(playerid, weaponid, 50);
	               }
	               case 29:
	               {
	               	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "MP5");

	               	      GiveWeaponToPlayer(playerid, weaponid, 50);
	               }
	               case 32:
			       {
			       	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "Tec-9");

	               	      GiveWeaponToPlayer(playerid, weaponid, 50);
			       }
			       case 30:
			       {
			       	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "AK-47");

	               	      GiveWeaponToPlayer(playerid, weaponid, 20);
			       }
			       case 31:
			       {
			       	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "M4");

	               	      GiveWeaponToPlayer(playerid, weaponid, 20);
			       }
			       case 34:
			       {
			       	      HoldWeapon(playerid, 0);

	               	      PlayReloadAnimation(playerid, weaponid);

	               	      Inventory_Remove(playerid, "Magazine");
	               	      Inventory_Remove(playerid, "Sniper");

	               	      GiveWeaponToPlayer(playerid, weaponid, 5);
                   }
	               default:
	                   return GRESKA(playerid,"Municija ne moze biti dodana na ovo oruzije!!");
	        }
    }
	return (true);
}

//===============================================================

stock HoldWeapon(playerid, weaponid)
{
	RemovePlayerAttachedObject(playerid, 1);

	if (weaponid != (0))
	{
		Holding_Weapon[playerid] = (weaponid);
		SetPlayerAttachedObject(playerid, 1, GetWeaponModel(weaponid), 6);
  		SetPlayerArmedWeapon(playerid, 0);
	}
	else
	Holding_Weapon[playerid] = (-1);
	return (true);
}

stock EquipWeaponToPlayer(playerid, weapon[])
{
	if(IsPlayerInAnyVehicle(playerid))
	   return GRESKA(playerid,"Morate biti van vozila!!");

	if (!strcmp(weapon, "Colt 45", true))
	{
		   if (!Inventory_HasItem(playerid, "Colt 45"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 22))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");

           HoldWeapon(playerid, 22);  
	}
	else if (!strcmp(weapon, "Desert Eagle", true))
	{
		   if (!Inventory_HasItem(playerid, "Desert Eagle"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 24))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");      
             
           HoldWeapon(playerid, 24);  
	}
	else if (!strcmp(weapon, "Shotgun", true))
	{
           if (!Inventory_HasItem(playerid, "Shotgun"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 25))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");       
             
           HoldWeapon(playerid, 25);  
	}
	else if (!strcmp(weapon, "Micro SMG", true))
	{
		   if (!Inventory_HasItem(playerid, "Micro SMG"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 28))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");
             
           HoldWeapon(playerid, 28);  
	}
	else if (!strcmp(weapon, "Tec-9", true))
	{
		   if (!Inventory_HasItem(playerid, "Tec-9"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 32))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");   
             
           HoldWeapon(playerid, 32);  
	}
	else if (!strcmp(weapon, "MP5", true))
	{
		   if (!Inventory_HasItem(playerid, "MP5"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 29))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");      
             
           HoldWeapon(playerid, 29);  
	}
	else if (!strcmp(weapon, "AK-47", true))
	{
		   if (!Inventory_HasItem(playerid, "AK-47"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 30))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))"); 
             
           HoldWeapon(playerid, 30);  
	}
	else if (!strcmp(weapon, "M4", true))
	{
		   if (!Inventory_HasItem(playerid, "M4"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 31))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");    
             
           HoldWeapon(playerid, 31);  
	}
	else if (!strcmp(weapon, "Sniper", true))
	{
		   if (!Inventory_HasItem(playerid, "Sniper"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 34))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           INFO(playerid,"Da vratite oruzije u inventar kucajte '/putback'.");
           SCM(playerid,-1,"((Da bi mogli koristit ovo oruzije morate imati i municiju za njega.))");    
             
           HoldWeapon(playerid, 34);  
	}
	else if (!strcmp(weapon, "Golf Club", true))
	{
		   if (!Inventory_HasItem(playerid, "Golf Club"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 2))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           GiveWeaponToPlayer(playerid, 2, 1);    
             
           Inventory_Remove(playerid, "Golf Club");  
	}
	else if (!strcmp(weapon, "Shovel", true))
	{
		   if (!Inventory_HasItem(playerid, "Shovel"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 6))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           GiveWeaponToPlayer(playerid, 6, 1);    
             
           Inventory_Remove(playerid, "Shovel");  
	}
	else if (!strcmp(weapon, "Knife", true))
	{
		   if (!Inventory_HasItem(playerid, "Knife"))
             return GRESKA(playerid,"Nemate ovo oruzije u inventaru!!");
           if(PlayerHasWeapon(playerid, 4))  
             return GRESKA(playerid,"Vec imate ovo oruzije!");  
           if(Holding_Weapon[playerid] != (-1))
             return GRESKA(playerid,"Vec drzite oruzije u ruci,da ga vratite u inventar kucajte '/putback'");

           GiveWeaponToPlayer(playerid, 4, 1);    
             
           Inventory_Remove(playerid, "Knife");  
	}      
	return (true);	
}

//===============================================================

function OnPlayerUseItem(playerid, itemid, name[])
{
    if (!strcmp(name, "Colt 45", true)) { EquipWeaponToPlayer(playerid, "Colt 45"); }
    else if (!strcmp(name, "Desert Eagle", true)) { EquipWeaponToPlayer(playerid, "Desert Eagle"); }
    else if (!strcmp(name, "Shotgun", true)) { EquipWeaponToPlayer(playerid, "Shotgun"); }
    else if (!strcmp(name, "Micro SMG", true)) { EquipWeaponToPlayer(playerid, "Micro SMG"); }
    else if (!strcmp(name, "Tec-9", true))  { EquipWeaponToPlayer(playerid, "Tec-9");  }
    else if (!strcmp(name, "MP5", true))    { EquipWeaponToPlayer(playerid, "MP5");    }
    else if (!strcmp(name, "AK-47", true))  { EquipWeaponToPlayer(playerid, "AK-47");  }
    else if (!strcmp(name, "M4", true))  { EquipWeaponToPlayer(playerid, "M4");  }
    else if (!strcmp(name, "Sniper", true)) { EquipWeaponToPlayer(playerid, "Sniper"); }
    else if (!strcmp(name, "Golf Club", true)) { EquipWeaponToPlayer(playerid, "Golf Club"); }
    else if (!strcmp(name, "Knife", true))  { EquipWeaponToPlayer(playerid, "Knife");  }
    else if (!strcmp(name, "Shovel", true)) { EquipWeaponToPlayer(playerid, "Shovel"); }
    else if (!strcmp(name, "Magazine", true)) { Use_Magazine(playerid); }
    else if (!strcmp(name, "Crowbar", true)) 
    { 
    	if(Holding_Weapon[playerid] == (-1))
        {
        	if(Attached_Item[playerid][0] != (0))
        	 return GRESKA(playerid,"Vec imate crowbar u ruci.");
            Attached_Item[playerid][0] = 1;
      	    SetPlayerAttachedObject(playerid, 0, 18634, 6, 0.072999, 0.053999, -0.083999, 101.899978, 0.000000, 1.500000, 1.000000, 1.000000, 1.000000, 0, 0);
      	    INFO(playerid,"Da vratite crowbar u inventar kucajte '/putback'.");
        }
        else GRESKA(playerid,"Vec drzite oruzije u ruci prvo ga vratite sa '/putback'."); 
    }
    return (true);
}

//===============================================================

function Load_dropped_items()
{
   static rows,fields,temp[30];

   cache_get_data(rows, fields, _dbConnector);
   for (new i = 0; i < rows; i ++) if (i < MAX_DROPPED_ITEMS)
   {
        cache_get_field_content(i, "ID", temp); DroppedItems[i][droppedID] = strval(temp);
        
        cache_get_field_content(i, "itemName", DroppedItems[i][droppedItem], _dbConnector);
		cache_get_field_content(i, "itemPlayer", DroppedItems[i][droppedPlayer], _dbConnector);
		
		cache_get_field_content(i, "itemModel", temp); DroppedItems[i][droppedModel] = strval(temp);
		cache_get_field_content(i, "itemQuantity", temp); DroppedItems[i][droppedQuantity] = strval(temp);
		cache_get_field_content(i, "itemWeapon", temp); DroppedItems[i][droppedWeapon] = strval(temp);
		cache_get_field_content(i, "itemAmmo", temp); DroppedItems[i][droppedAmmo] = strval(temp);
		cache_get_field_content(i, "itemX", temp); DroppedItems[i][droppedPos][0] = floatstr(temp);
		cache_get_field_content(i, "itemY", temp); DroppedItems[i][droppedPos][1] = floatstr(temp);
		cache_get_field_content(i, "itemZ", temp); DroppedItems[i][droppedPos][2] = floatstr(temp);
		cache_get_field_content(i, "itemInt", temp); DroppedItems[i][droppedInt] = strval(temp);
		cache_get_field_content(i, "itemWorld", temp); DroppedItems[i][droppedWorld] = strval(temp);
		
		if (IsWeaponModel(DroppedItems[i][droppedModel]))
		{
    	   	DroppedItems[i][droppedObject] = CreateDynamicObject(DroppedItems[i][droppedModel], DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2], 93.7, 120.0, 120.0, DroppedItems[i][droppedWorld], DroppedItems[i][droppedInt]);
		}
		else
		{
			DroppedItems[i][droppedObject] = CreateDynamicObject(DroppedItems[i][droppedModel], DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2], 0.0, 0.0, 0.0, DroppedItems[i][droppedWorld], DroppedItems[i][droppedInt]);
		}
   }
   return (true);
}

//==========================================================

stock DropPlayerItem(playerid, itemid, quantity = 1)
{
   if (itemid == -1 || !InventoryData[playerid][itemid][invExists])
	    return (false);

   static Float:Pos[4],string[32];

   strunpack(string, InventoryData[playerid][itemid][invItem]);
   
   /*if (InventoryData[playerid][itemid][invQuantity] < 2)
   {
   	    if (!strcmp(string, "Colt 45") && Holding_Weapon[playerid] == 22)
			HoldWeapon(playerid, 0);

		else if (!strcmp(string, "Desert Eagle") && Holding_Weapon[playerid] == 24)
			HoldWeapon(playerid, 0);

		else if (!strcmp(string, "Shotgun") && Holding_Weapon[playerid] == 25)
			HoldWeapon(playerid, 0);
			
		else if (!strcmp(string, "Micro SMG") && Holding_Weapon[playerid] == 28)
			HoldWeapon(playerid, 0);

		else if (!strcmp(string, "MP5") && Holding_Weapon[playerid] == 29)
			HoldWeapon(playerid, 0);

		else if (!strcmp(string, "Tec-9") && Holding_Weapon[playerid] == 32)
			HoldWeapon(playerid, 0);

		else if (!strcmp(string, "AK-47") && Holding_Weapon[playerid] == 30)
			HoldWeapon(playerid, 0);

	 	else if (!strcmp(string, "M4") && Holding_Weapon[playerid] == 31)
		 	HoldWeapon(playerid, 0);

		else if (!strcmp(string, "Sniper") && Holding_Weapon[playerid] == 34)
			HoldWeapon(playerid, 0);
   }*/

   
   GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]); GetPlayerFacingAngle(playerid, Pos[3]);

   if(IsWeaponModel(InventoryData[playerid][itemid][invModel]))
   {
   	   HoldWeapon(playerid, 0);
   }
   DropItem(string, GetName(playerid), InventoryData[playerid][itemid][invModel], quantity, Pos[0], Pos[1], Pos[2] - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
   Inventory_Remove(playerid, string, quantity);

   ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1); 
   return (true);
}

stock DropItem(item[], playere[], model, quantity, Float:x, Float:y, Float:z, interior, world, weaponid = 0, ammo = 0)
{
   static string[300];

   for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (!DroppedItems[i][droppedModel])
   {
        format(DroppedItems[i][droppedItem], 32, item);
	    format(DroppedItems[i][droppedPlayer], 24, playere);

		DroppedItems[i][droppedModel] = model;
		DroppedItems[i][droppedQuantity] = quantity;
		DroppedItems[i][droppedWeapon] = weaponid;
  		DroppedItems[i][droppedAmmo] = ammo;
		DroppedItems[i][droppedPos][0] = x;
		DroppedItems[i][droppedPos][1] = y;
		DroppedItems[i][droppedPos][2] = z;
		
		DroppedItems[i][droppedInt] = interior;
		DroppedItems[i][droppedWorld] = world;
		
		if (IsWeaponModel(model))
		{
			DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 93.7, 120.0, 120.0, world, interior);
		}
		else
		{
			DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0, world, interior);
		}
		format(string, sizeof(string), "INSERT INTO `ug_inventory_drop` (`itemName`, `itemPlayer`, `itemModel`, `itemQuantity`, `itemWeapon`, `itemAmmo`, `itemX`, `itemY`, `itemZ`, `itemInt`, `itemWorld`) VALUES('%s', '%s', '%d', '%d', '%d', '%d', '%.4f', '%.4f', '%.4f', '%d', '%d')", item, playere, model, quantity, weaponid, ammo, x, y, z, interior, world);
		mysql_function_query(_dbConnector, string, false, "OnItemDrop", "d", i); string = "\0";
		return (i);
   }
   return (-1);
}

stock Item_Delete(itemid)
{
    static
	    query[64];

    if (itemid != -1 && DroppedItems[itemid][droppedModel])
	{
        DroppedItems[itemid][droppedModel] = 0;
		DroppedItems[itemid][droppedQuantity] = 0;
	    DroppedItems[itemid][droppedPos][0] = 0.0;
	    DroppedItems[itemid][droppedPos][1] = 0.0;
	    DroppedItems[itemid][droppedPos][2] = 0.0;
	    DroppedItems[itemid][droppedInt] = 0;
	    DroppedItems[itemid][droppedWorld] = 0;

	    format(query, sizeof(query), "DELETE FROM `ug_inventory_drop` WHERE `ID` = '%d'", DroppedItems[itemid][droppedID]);
	    mysql_function_query(_dbConnector, query, false, "", "");
	}
	return (true);
}

//==========================================================

stock Set_Item_Quantity(itemid, amount)
{
   static string[64];

   if (itemid != -1 && DroppedItems[itemid][droppedModel])
   {
        DroppedItems[itemid][droppedQuantity] = amount;

	    format(string, sizeof(string), "UPDATE `ug_inventory_drop` SET `itemQuantity` = %d WHERE `ID` = '%d'", amount, DroppedItems[itemid][droppedID]);
		mysql_function_query(_dbConnector, string, false, "", "");

		string = "\0";
   }
   return (true);
}

//===============================================================

stock Get_Nearest_Item(playerid)
{
   for (new i = 0; i != MAX_DROPPED_ITEMS; i ++) if (DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]))
   {
	    if (GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld])
	        return (i);
   }
   return (-1);
}

stock IsWeaponModel(model) {
    static const g_aWeaponModels[] = {
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
    };
    for (new i = 0; i < sizeof(g_aWeaponModels); i ++) if (g_aWeaponModels[i] == model) {
        return (true);
	}
	return (false);
}

//===============================================================

stock PickupItem(playerid, itemid)
{
   if (itemid != -1 && DroppedItems[itemid][droppedModel])
   {
	    new id = Inventory_Add(playerid, DroppedItems[itemid][droppedItem], DroppedItems[itemid][droppedModel], DroppedItems[itemid][droppedQuantity]);

	    if (id == -1)
	        return GRESKA(playerid,"Nemate slobodnih slotova u inventaru!");

	    Delete_Droped_Item(itemid);
   }
   return (true);
}

stock Delete_Droped_Item(itemid)
{
   static string[64];

   if (itemid != -1 && DroppedItems[itemid][droppedModel])
   {
        DroppedItems[itemid][droppedModel] = 0;
		DroppedItems[itemid][droppedQuantity] = 0;
	    DroppedItems[itemid][droppedPos][0] = 0.0;
	    DroppedItems[itemid][droppedPos][1] = 0.0;
	    DroppedItems[itemid][droppedPos][2] = 0.0;
	    DroppedItems[itemid][droppedInt] = 0;
	    DroppedItems[itemid][droppedWorld] = 0;

	    DestroyDynamicObject(DroppedItems[itemid][droppedObject]);
	    
	    format(string, sizeof(string), "DELETE FROM `ug_inventory_drop` WHERE `ID` = '%d'", DroppedItems[itemid][droppedID]);
	    mysql_function_query(_dbConnector, string, false, "", "");

	    string = "\0";
   }
   return (true);
}

//================================================================

function OnItemDrop(itemid)
{
   if (itemid == -1 || !DroppedItems[itemid][droppedModel])
	    return (false);

   DroppedItems[itemid][droppedID] = mysql_insert_id();
   return (true);
}
