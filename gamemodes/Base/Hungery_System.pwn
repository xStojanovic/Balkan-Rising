
#include <YSI\y_hooks>

//========================================================
/*
                  Balkan Rising
                     0.0.1x
                 Hungary System
*/
//=========================================================

new Food_Buying[MAX_PLAYERS],
	Food_Placed[MAX_PLAYERS],
	Food_Deleting[MAX_PLAYERS],
	Food_Eating[MAX_PLAYERS],
	Food_Foodest[MAX_PLAYERS],
	Food_Objects[MAX_PLAYERS],
	Food_Placedider[MAX_PLAYERS],
	Food_Created[MAX_PLAYERS],
	Float:Food_Object[3][MAX_PLAYERS],
	Float:Food_Objectss[3][MAX_PLAYERS];

//==========================================================

new food_Strings[][] =
{
	"{41B6F0}Cluckin' Little Meal\n\
	{FFFFFF}Small meals enriched with exceptional ingredients.\n\
	{FFFFFF}With this small meal goes juice and Sprite.\n\
	{FFFFFF}If you are very hungry this meal is perfect for you.\n\
	{FFFFFF}Portion Price: {41F075}${FF0000}200\n\
	{FFFFFF}Health: {FF0000}+10",

	"{41B6F0}Cluckin' Big Meal\n\
	{FFFFFF}First of all, this is a workers' meal.\n\
	{FFFFFF}With the meal, of course, you also get our drink Sprite.\n\
	{FFFFFF}This meal is great but not enriched with ingredients.\n\
	{FFFFFF}Portion Price: {41F075}${FF0000}220\n\
	{FFFFFF}Health: {FF0000}+15",

	"{41B6F0}Cluckin' Huge Meal\n\
	{FFFFFF}Meal to recommend.\n\
	{FFFFFF}With the meal you get a great sauce dressing the house.\n\
	{FFFFFF}Of course, here goes our drink Sprite.\n\
	{FFFFFF}Portion Price: {41F075}${FF0000}225\n\
	{FFFFFF}Health: {FF0000}+15",

	"{41B6F0}Salad Meal\n\
	{FFFFFF}The specialty of the house.\n\
	{FFFFFF}Mixed salad with vegetables and rolled hanger.\n\
	{FFFFFF}Portion Price: {41F075}${FF0000}250\n\
	{FFFFFF}Health: {FF0000}+20",

	"{41B6F0}Double D-Lux\n\
	{FFFFFF}The two pizzas for the price of one.\n\
	{FFFFFF}Drinks with sausage and Capricciosa.\n\
	{FFFFFF}In addition to well-known juice goes home Sprite.\n\
	{FFFFFF}Portion Price: {41F075}${FF0000}275\n\
	{FFFFFF}Health: {FF0000}+20"

};

//==========================================================

YCMD:buyfood(playerid,params[],help)
{
	/* Dodati da mora biti u BurgerShootu */
	if(Food_Buying[playerid] == 1) return GRESKA(playerid,"Prvo pojedite hranu koju ste kupili.");
	
	Dialog_Show(playerid, Buy_Food, DSL, "{FFFFFF}KUPOVINA - HRANE", "Cluckin' Little Meal\n\
	Cluckin' Big Meal\n\
	Cluckin' Huge Meal\n\
	Salad Meal\n\
	Double D-Lux", "Izaberi", "Odustani");
	
	INFO(playerid,"Dobrodosli u BurgerShoot...");
	INFO(playerid,"Izbacena vam je lista jela u ponudi.");
	INFO(playerid,"Odaberite kako bi ste pogledali/kupili neko od ponudjenih jela.");
	return (true);
}

//==========================================================

/* Dodati u enum BR moda preload za animaciju EAT_Pizza */

YCMD:meal(playerid,params[],help)
{
	new izbor[32],Float:playerPos[3];
	    
    if(sscanf(params, "s[32]", izbor))
	{
	   	USAGE(playerid,"/meal [ place/delete/eat ]");
	   	return (true);
	}
    if(strcmp(izbor,"place",true) == 0)
	{
		if(Food_Buying[playerid] == 0) return GRESKA(playerid,"Morate prvo kupiti hranu.");
		else if(Food_Placed[playerid] == 1) return GRESKA(playerid,"Vec ste je postavili.");
	
		GetPlayerPos(playerid,playerPos[0],playerPos[1],playerPos[2]);
		Food_Created[playerid] = CreateDynamicObject(Food_Objects[playerid],playerPos[0]+1,playerPos[1]+1,playerPos[2],0.0,0.0,0.0,-1,-1,-1,100.0);
	
		Food_Object[0][playerid] = 0.0;
		Food_Object[1][playerid] = 0.0;
		Food_Object[2][playerid] = 0.0;

		Food_Objectss[0][playerid] = playerPos[0];
		Food_Objectss[1][playerid] = playerPos[1];
		Food_Objectss[2][playerid] = playerPos[2];
	
		EditDynamicObject(playerid,Food_Objects[playerid]);
	
		Food_Placedider[playerid] = 1;
	
		INFO(playerid,"Molimo vas postavite hranu na jedan od praznih stolova.");
	}
	if(strcmp(izbor,"eat",true) == 0)
	{
		if(Food_Buying[playerid] == 0) return GRESKA(playerid,"Morate prvo kupiti hranu.");
    	else if(Food_Foodest[playerid] == 0) return GRESKA(playerid,"Nemate hranu.");
    	else if(Food_Placed[playerid] == 0) return GRESKA(playerid,"Morate postaviti hranu.");
    
    	INFO(playerid,"Poceli ste sa jelom vase hrane.");
    	INFO(playerid,"Nemojte da zaboravite da bacite ostatke kada zavrsite.");
    
    	TogglePlayerControllable(playerid, true);
    	ApplyAnimation(playerid,"FOOD","EAT_Pizza",4.1,0,1,1,0,0);
    
    	PreloadAnimations(playerid);
		SetCameraBehindPlayer(playerid);
    	defer Food_EatingBat(playerid);
	}
	if(strcmp(izbor,"delete",true) == 0)
	{
    	if(Food_Buying[playerid] == 0) return GRESKA(playerid,"Morate prvo kupiti hranu.");
    	else if(Food_Placed[playerid] == 0) return GRESKA(playerid,"Niste ni poceli sa ruckom.");
    	else if(Food_Deleting[playerid] == 1) return GRESKA(playerid,"Vasa hrana je vec bacena.");
    
    	INFO(playerid,"Uspesno ste bacili ostatke hrane.");
    
    	Food_Foodest[playerid] = 0;
		Food_Buying[playerid] = 0;
		Food_Placed[playerid] = 0;
		Food_Deleting[playerid] = 0;
	
		Food_Objectss[0][playerid] = 0.0;
		Food_Objectss[1][playerid] = 0.0;
		Food_Objectss[2][playerid] = 0.0;
	
		Food_Object[0][playerid] = 0.0;
		Food_Object[1][playerid] = 0.0;
		Food_Object[2][playerid] = 0.0;
	
		DestroyDynamicObject(Food_Created[playerid]);
	}
	return (true);
}

timer Food_EatingBat[10000](playerid)
{
	if(Food_Placed[playerid] == 1)
	{
   	 	new Float:Health;
    	GetPlayerHealth(playerid,Health);
		TogglePlayerControllable(playerid, false);
		SetCameraBehindPlayer(playerid);
	
		if(Food_Foodest[playerid] == 1) { INFO(playerid,"Uspesno ste zavrsili sa obrokom,sada kucajte '/meal delete'."); SetPlayerHealth(playerid,Health + 10.0);}
		else if(Food_Foodest[playerid] == 2) { INFO(playerid,"Uspesno ste zavrsili sa obrokom,sada kucajte '/meal delete'."); SetPlayerHealth(playerid,Health + 15.0); }
		else if(Food_Foodest[playerid] == 3) { INFO(playerid,"Uspesno ste zavrsili sa obrokom,sada kucajte '/meal delete'."); SetPlayerHealth(playerid,Health + 15.0); }
		else if(Food_Foodest[playerid] == 4) { INFO(playerid,"Uspesno ste zavrsili sa obrokom,sada kucajte '/meal delete'."); SetPlayerHealth(playerid,Health + 20.0); }
		else if(Food_Foodest[playerid] == 5) { INFO(playerid,"Uspesno ste zavrsili sa obrokom,sada kucajte '/meal delete'."); SetPlayerHealth(playerid,Health + 20.0); }
	}
	return (true);
}

//==========================================================

Dialog:Buy_Food(playerid, response, listitem, inputtext[])
{
    if (response)
	{
		 switch (listitem)
	     {
                 case 0:
	             {
	                Dialog_Show(playerid,Little_Meal,DSM,"{FFFFFF}INFORMACIJE - O HRANI",food_Strings[0],"Kupi","Odustani");
	             }
	             case 1:
	             {
                    Dialog_Show(playerid,Big_Meal,DSM,"{FFFFFF}INFORMACIJE - O HRANI",food_Strings[1],"Kupi","Odustani");
	             }
	             case 2:
	             {
                    Dialog_Show(playerid,Huge_Meal,DSM,"{FFFFFF}INFORMACIJE - O HRANI",food_Strings[2],"Kupi","Odustani");
	             }
	             case 3:
	             {
                    Dialog_Show(playerid,Salad_Meal,DSM,"{FFFFFF}INFORMACIJE - O HRANI",food_Strings[3],"Kupi","Odustani");
	             }
	             case 4:
	             {
                    Dialog_Show(playerid,Double_Dlux,DSM,"{FFFFFF}INFORMACIJE - O HRANI",food_Strings[4],"Kupi","Odustani");
	             }
	     }
	}
	return (true);
}

//==========================================================

Dialog:Little_Meal(playerid, response, listitem, inputtext[])
{
	  if(response)
	  {
			if(Player_Enum[playerid][p_Money] < 200) return GRESKA(playerid,"Nemate dovoljno novca!");
			INFO(playerid,"Uspesno ste kupili Cluckin' Little Meal.");
			INFO(playerid,"Idite do stola i kucajte '/meal place'.");
			INFO(playerid,"Nemojte zaboraviti kada jedete da bacite ostatke hrane '/meal delete'.");
			
			c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s uzima Cluckin' Little Meal... ))", GetName(playerid));
			
			Food_Foodest[playerid] = 1;
			Food_Buying[playerid] = 1;
			Food_Placed[playerid] = 0;
			Food_Deleting[playerid] = 0;
			Food_Objects[playerid] = 2212;
	  }
	  else
	  {
			INFO(playerid,"Odustali ste od kupovine,prijatan dan.");
	  }
	  return (true);
}

//==========================================================

Dialog:Big_Meal(playerid, response, listitem, inputtext[])
{
	  if(response)
	  {
			if(Player_Enum[playerid][p_Money] < 220) return GRESKA(playerid,"Nemate dovoljno novca!");
			INFO(playerid,"Uspesno ste kupili Cluckin' Big Meal.");
			INFO(playerid,"Idite do stola i kucajte '/meal place'.");
			INFO(playerid,"Nemojte zaboraviti kada jedete da bacite ostatke hrane '/meal delete'.");
			
			c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s uzima Cluckin' Big Meal... ))", GetName(playerid));
			
			Food_Foodest[playerid] = 2;
			Food_Buying[playerid] = 1;
			Food_Placed[playerid] = 0;
			Food_Deleting[playerid] = 0;
			Food_Objects[playerid] = 2213;
	  }
	  else
	  {
			INFO(playerid,"Odustali ste od kupovine,prijatan dan.");
	  }
	  return (true);
}

//==========================================================

Dialog:Huge_Meal(playerid, response, listitem, inputtext[])
{
	  if(response)
	  {
			if(Player_Enum[playerid][p_Money] < 225) return GRESKA(playerid,"Nemate dovoljno novca!");
			INFO(playerid,"Uspesno ste kupili Cluckin' Huge Meal.");
			INFO(playerid,"Idite do stola i kucajte '/meal place'.");
			INFO(playerid,"Nemojte zaboraviti kada jedete da bacite ostatke hrane '/meal delete'.");
			
			c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s uzima Cluckin' Huge Meal... ))", GetName(playerid));
			
			Food_Foodest[playerid] = 3;
			Food_Buying[playerid] = 1;
			Food_Placed[playerid] = 0;
			Food_Deleting[playerid] = 0;
			Food_Objects[playerid] = 2217;
	  }
	  else
	  {
			INFO(playerid,"Odustali ste od kupovine,prijatan dan.");
	  }
	  return (true);
}

//==========================================================

Dialog:Salad_Meal(playerid, response, listitem, inputtext[])
{
	  if(response)
	  {
			if(Player_Enum[playerid][p_Money] < 250) return GRESKA(playerid,"Nemate dovoljno novca!");
			INFO(playerid,"Uspesno ste kupili Salad Meal.");
			INFO(playerid,"Idite do stola i kucajte '/meal place'.");
			INFO(playerid,"Nemojte zaboraviti kada jedete da bacite ostatke hrane '/meal delete'.");
			
			c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s uzima Salad Meal... ))", GetName(playerid));
			
			Food_Foodest[playerid] = 4;
			Food_Buying[playerid] = 1;
			Food_Placed[playerid] = 0;
			Food_Deleting[playerid] = 0;
			Food_Objects[playerid] = 2355;
	  }
	  else
	  {
			INFO(playerid,"Odustali ste od kupovine,prijatan dan.");
	  }
	  return (true);
}

//==========================================================

Dialog:Double_Dlux(playerid, response, listitem, inputtext[])
{
	  if(response)
	  {
			if(Player_Enum[playerid][p_Money] < 275) return GRESKA(playerid,"Nemate dovoljno novca!");
			INFO(playerid,"Uspesno ste kupili Double D-Lux.");
			INFO(playerid,"Idite do stola i kucajte '/meal place'.");
			INFO(playerid,"Nemojte zaboraviti kada jedete da bacite ostatke hrane '/meal delete'.");
			
			c_SendMessage(playerid, 5.0, 0xD0AEEBFF, "(( %s uzima Double D-Lux... ))", GetName(playerid));
			
			Food_Foodest[playerid] = 5;
			Food_Buying[playerid] = 1;
			Food_Placed[playerid] = 0;
			Food_Deleting[playerid] = 0;
			Food_Objects[playerid] = 2218;
	  }
	  else
	  {
			INFO(playerid,"Odustali ste od kupovine,prijatan dan.");
	  }
	  return (true);
}

//==========================================================

hook OnPlayerEditDynamicObject(playerid, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(response == EDIT_RESPONSE_FINAL)
   	{
   	    if(Food_Placedider[playerid] == 1)
		{
   	    	Food_Objectss[0][playerid] = fX;
			Food_Objectss[1][playerid] = fY;
			Food_Objectss[2][playerid] = fZ;

			Food_Object[0][playerid] = fRotX;
			Food_Object[1][playerid] = fRotY;
			Food_Object[2][playerid] = fRotZ;
		
			DestroyDynamicObject(Food_Created[playerid]);
		
			Food_Created[playerid] = CreateDynamicObject(Food_Objects[playerid],fX,fY,fZ,fRotX,fRotY,fRotZ,-1,-1,-1,100.0);
	
    		Food_Placed[playerid] = 1;
    		Food_Placedider[playerid] = 0;
    		CancelEdit(playerid);
    		INFO(playerid,"Uspesno ste postavili obrok na zeljnu poziciju,sada kucajte '/meal eat'.");
    	}
   	}
	return (true);
}

//==========================================================
