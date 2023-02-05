
#include <YSI\y_hooks>

//========================================================
/*
                  Balkan Rising
                     0.0.1x
             Business Furniture System
*/
//=========================================================

#define MAX_FURNITURE_ITEMS (40)

#define MODEL_SELECTION_ALL_FURNITURE_LIST (5)
#define MODEL_SELECTION_FURNITURE_BUY (7)


new Editing_Furniture_Item[MAX_PLAYERS] = (-1);

new Iterator:Loaded_Furniture_Array<MAX_FURNITURE_ITEMS>;

//=========================================================

enum BUSSINES_FURNITURE{
	Furniture_ID,
	Furniture_Name[32],
	Furniture_Model,
	Furniture_Price,
	Furniture_Slots,
	Furniture_Added
};
new BIZ_FURNITURE[MAX_BUSINESSES][MAX_FURNITURE_ITEMS][BUSSINES_FURNITURE];

enum e_FurnitureData {
	e_FurnitureType,
	e_FurnitureName[32],
	e_FurnitureModel
};

static const g_aFurnitureData[][e_FurnitureData] = {
	{1, "Frame 1", 2289},
	{1, "Frame 2", 2288},
	{1, "Frame 3", 2287},
	{1, "Frame 4", 2286},
	{1, "Frame 5", 2285},
	{1, "Frame 6", 2284},
    {1, "Frame 7", 2283},
    {1, "Frame 8", 2282},
    {1, "Frame 9", 2281},
    {1, "Frame 10", 2280},
    {1, "Frame 11", 2279},
	{1, "Frame 12", 2278},
	{1, "Frame 13", 2277},
	{1, "Frame 14", 2276},
	{1, "Frame 15", 2275},
	{1, "Frame 16", 2274},
    {1, "Frame 17", 2273},
    {1, "Frame 18", 2272},
    {1, "Frame 19", 2271},
    {1, "Frame 20", 2270},
    {2, "Table 1", 1433},
	{2, "Table 2", 1998},
	{2, "Table 3", 2008},
	{2, "Table 4", 2180},
	{2, "Table 5", 2185},
    {2, "Table 6", 2205},
    {2, "Table 7", 2314},
    {2, "Table 8", 2635},
    {2, "Table 9", 2637},
    {2, "Table 10", 2644},
	{2, "Table 11", 2747},
	{2, "Table 12", 2764},
	{2, "Table 13", 2763},
	{2, "Table 14", 2762},
	{2, "Table 15", 936},
	{2, "Table 16", 937},
	{2, "Table 17", 941},
	{2, "Table 18", 2115},
	{2, "Table 19", 2116},
	{2, "Table 20", 2112},
	{2, "Table 21", 2111},
	{2, "Table 22", 2110},
	{2, "Table 23", 2109},
	{2, "Table 24", 2085},
	{2, "Table 25", 2032},
	{2, "Table 26", 2031},
	{2, "Table 27", 2030},
	{2, "Table 28", 2029},
    {3, "Chair 1", 1671},
    {3, "Chair 2", 1704},
    {3, "Chair 3", 1705},
    {3, "Chair 4", 1708},
    {3, "Chair 5", 1711},
    {3, "Chair 6", 1715},
    {3, "Chair 7", 1721},
    {3, "Chair 8", 1724},
    {3, "Chair 9", },
    {3, "Chair 10", 1729},
    {3, "Chair 11", 1735},
    {3, "Chair 12", 1739},
    {3, "Chair 13", 1805},
    {3, "Chair 14", 1806},
    {3, "Chair 15", 1810},
    {3, "Chair 16", 1811},
    {3, "Chair 17", 2079},
    {3, "Chair 18", 2120},
    {3, "Chair 19", 2124},
    {3, "Chair 20", 2356},
    {3, "Chair 21", 1768},
    {3, "Chair 22", 1766},
    {3, "Chair 23", 1764},
    {3, "Chair 24", 1763},
    {3, "Chair 25", 1761},
    {3, "Chair 26", 1760},
    {3, "Chair 27", 1757},
    {3, "Chair 28", 1756},
    {3, "Chair 29", 1753},
    {3, "Chair 30", 1713},
    {3, "Chair 31", 1712},
    {3, "Chair 32", 1706},
    {3, "Chair 33", 1703},
    {3, "Chair 34", 1702},
    {3, "Chair 35", 1754},
    {3, "Chair 36", 1755},
    {3, "Chair 37", 1758},
    {3, "Chair 38", 1759},
    {3, "Chair 39", 1762},
    {3, "Chair 40", 1765},
    {3, "Chair 41", 1767},
    {3, "Chair 42", 1769},
	{4, "Bed 1", 1700},
	{4, "Bed 2", 1701},
	{4, "Bed 3", 1725},
	{4, "Bed 4", 1745},
	{4, "Bed 5", 1793},
	{4, "Bed 6", 1794},
	{4, "Bed 7", 1795},
	{4, "Bed 8", 1796},
	{4, "Bed 9", 1797},
	{4, "Bed 10", 1771},
	{4, "Bed 11", 1798},
	{4, "Bed 12", 1799},
    {4, "Bed 13", 1800},
    {4, "Bed 14", 1801},
    {4, "Bed 15", 1802},
    {4, "Bed 16", 1812},
    {4, "Bed 17", 2090},
    {4, "Bed 18", 2299},
    {5, "Cabinet 1", 1416},
	{5, "Cabinet 2", 1417},
	{5, "Cabinet 3", 1741},
	{5, "Cabinet 4", 1742},
	{5, "Cabinet 5", 1743},
	{5, "Cabinet 6", 2025},
	{5, "Cabinet 7", 2065},
	{5, "Cabinet 8", 2066},
	{5, "Cabinet 9", 2067},
	{5, "Cabinet 10", 2087},
    {5, "Cabinet 11", 2088},
    {5, "Cabinet 12", 2094},
    {5, "Cabinet 13", 2095},
    {5, "Cabinet 14", 2306},
    {5, "Cabinet 15", 2307},
	{5, "Cabinet 16", 2323},
	{5, "Cabinet 17", 2328},
	{5, "Cabinet 18", 2329},
	{5, "Cabinet 19", 2330},
	{5, "Cabinet 20", 2708},
	{6, "Television 1", 1518},
	{6, "Television 2", 1717},
	{6, "Television 3", 1747},
	{6, "Television 4", 1748},
	{6, "Television 5", 1749},
	{6, "Television 6", 1750},
	{6, "Television 7", 1752},
	{6, "Television 8", 1781},
	{6, "Television 9", 1791},
	{6, "Television 10", 1792},
    {6, "Television 11", 2312},
	{6, "Television 12", 2316},
	{6, "Television 13", 2317},
	{6, "Television 14", 2318},
	{6, "Television 15", 2320},
	{6, "Television 16", 2595},
	{6, "Television 17", 16377},
	{7, "Kitchen 1", 2013},
	{7, "Kitchen 2", 2017},
	{7, "Kitchen 3", 2127},
	{7, "Kitchen 4", 2130},
	{7, "Kitchen 5", 2131},
	{7, "Kitchen 6", 2132},
	{7, "Kitchen 7", 2135},
	{7, "Kitchen 8", 2136},
	{7, "Kitchen 9", 2144},
	{7, "Kitchen 10", 2147},
    {7, "Kitchen 11", 2149},
    {7, "Kitchen 12", 2150},
    {7, "Kitchen 13", 2415},
    {7, "Kitchen 14", 2417},
    {7, "Kitchen 15", 2421},
    {7, "Kitchen 16", 2426},
    {7, "Kitchen 17", 2014},
    {7, "Kitchen 18", 2015},
    {7, "Kitchen 19", 2016},
    {7, "Kitchen 20", 2018},
    {7, "Kitchen 21", 2019},
    {7, "Kitchen 22", 2022},
    {7, "Kitchen 23", 2133},
    {7, "Kitchen 24", 2134},
	{7, "Kitchen 25", 2137},
	{7, "Kitchen 26", 2138},
	{7, "Kitchen 27", 2139},
	{7, "Kitchen 28", 2140},
	{7, "Kitchen 29", 2141},
	{7, "Kitchen 30", 2142},
	{7, "Kitchen 31", 2143},
	{7, "Kitchen 32", 2145},
	{7, "Kitchen 33", 2148},
	{7, "Kitchen 34", 2151},
	{7, "Kitchen 35", 2152},
	{7, "Kitchen 36", 2153},
	{7, "Kitchen 37", 2154},
	{7, "Kitchen 38", 2155},
	{7, "Kitchen 39", 2156},
	{7, "Kitchen 40", 2157},
	{7, "Kitchen 41", 2158},
	{7, "Kitchen 42", 2159},
	{7, "Kitchen 43", 2160},
	{7, "Kitchen 44", 2134},
	{7, "Kitchen 45", 2135},
	{7, "Kitchen 46", 2338},
	{7, "Kitchen 47", 2341},
	{8, "Bathroom 1", 2514},
	{8, "Bathroom 2", 2516},
	{8, "Bathroom 3", 2517},
	{8, "Bathroom 4", 2518},
	{8, "Bathroom 5", 2520},
	{8, "Bathroom 6", 2521},
	{8, "Bathroom 7", 2522},
	{8, "Bathroom 8", 2523},
	{8, "Bathroom 9", 2524},
	{8, "Bathroom 10", 2525},
    {8, "Bathroom 11", 2526},
    {8, "Bathroom 12", 2527},
    {8, "Bathroom 13", 2528},
    {8, "Bathroom 14", 2738},
    {8, "Bathroom 15", 2739},
	{9, "Washer", 1208},
	{9, "Ceiling Fan", 1661},
	{9, "Moose Head", 1736},
	{9, "Radiator", 1738},
	{9, "Mop and Pail", 1778},
	{9, "Water Cooler", 1808},
	{9, "Water Cooler 2", 2002},
	{9, "Money Safe", 1829},
	{9, "Printer", 2186},
	{9, "Computer", 2190},
	{9, "Treadmill", 2627},
	{9, "Bench Press", 2629},
	{9, "Exercise Bike", 2630},
	{9, "Mat 1", 2631},
	{9, "Mat 2", 2632},
	{9, "Mat 3", 2817},
	{9, "Mat 4", 2818},
	{9, "Mat 5", 2833},
	{9, "Mat 6", 2834},
	{9, "Mat 7", 2835},
	{9, "Mat 8", 2836},
	{9, "Mat 9", 2841},
	{9, "Mat 10", 2842},
	{9, "Mat 11", 2847},
	{9, "Book Pile 1", 2824},
	{9, "Book Pile 2", 2826},
	{9, "Book Pile 3", 2827},
	{9, "Basketball", 2114},
	{9, "Lamp 1", 2108},
	{9, "Lamp 2", 2106},
	{9, "Lamp 3", 2069},
	{9, "Dresser 1", 2569},
	{9, "Dresser 2", 2570},
	{9, "Dresser 3", 2573},
	{9, "Dresser 4", 2574},
	{9, "Dresser 5", 2576},
	{9, "Book", 2894}
};

//================================================================================

YCMD:buyfurniture(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Property][0] == 9999 && Player_Enum[playerid][p_Property][1] == 9999)
	   return GRESKA(playerid,"Nemate ni jednu kucu u vlasnistvu.");
	   
	static id = (-1);
	new items[MAX_FURNITURE_ITEMS],
	count;

	if ((id = Business_Inside(playerid)) != (-1))
	{
		if(BIZ_ENUM[id][BIZ_TYPE] == FURNITURE_SHOP)
		{
			for(new i = 0; i != MAX_FURNITURE_ITEMS; ++i)
	        {
	        	  if(BIZ_FURNITURE[id][i][Furniture_Added] != 0)
             	  {
             	  	  items[count++] = BIZ_FURNITURE[id][i][Furniture_Model]; 
             	  }
	        }
	        ShowModelSelectionMenu(playerid, "Furniture Shop", MODEL_SELECTION_FURNITURE_BUY, items, count, -12.0, 0.0, 0.0);
		}
	}	
	return (true);
}

//================================================================================

stock GetFurnitureNameByModel(model)
{
	new
	    name[32];

	for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if (g_aFurnitureData[i][e_FurnitureModel] == model) {
		strcat(name, g_aFurnitureData[i][e_FurnitureName]);

		break;
	}
	return (name);
}

stock GetFurnitureModelByName(const name[])
{
	for (new i = 0; i < sizeof(g_aFurnitureData); i ++)
	{
	    if (strfind(g_aFurnitureData[i][e_FurnitureName], name, true) != -1)
	    {
	        return (g_aFurnitureData[i][e_FurnitureModel]);
		}
	}
	return (false);
}

stock IsFurnitureItem(item[])
{
    for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if (!strcmp(g_aFurnitureData[i][e_FurnitureName], item)) {
        return (true);
	}
	return (false);
}

stock IsFurnitureAdded(bizid,name[])
{
	for(new i = 0; i != MAX_FURNITURE_ITEMS; ++i)
	{
		if(strfind(BIZ_FURNITURE[bizid][i][Furniture_Name], name, true) != -1)
		return (true);
	}
	return (-1);	
}

stock Add_Business_Furniture(playerid,bizid,modelname[],modelid,price)
{
	static query[256];

	new i = GetFree_FurnitureID();

	if(i == (-1))
	   return GRESKA(playerid,"Ne mozete dodati vise furniture itema jer ih imate maximalno.");

	if(BIZ_FURNITURE[bizid][i][Furniture_Added] != 1)
    {
         BIZ_FURNITURE[bizid][i][Furniture_Added] = (1);
         BIZ_FURNITURE[bizid][i][Furniture_Model] = modelid;
         BIZ_FURNITURE[bizid][i][Furniture_Price] = price;
         BIZ_FURNITURE[bizid][i][Furniture_Slots] = (1);

         SetString(BIZ_FURNITURE[bizid][i][Furniture_Name],modelname);

         format(query, sizeof(query), "INSERT INTO `ug_business_furniture` (`ID`, `Furniture_Name`, `Furniture_Model`, `Furniture_Price`, `Furniture_Added`, `Furniture_Slots`) VALUES('%d', '%s', '%d', '%d', 1, 1)",
         BIZ_ENUM[bizid][BIZ_ID],modelname,modelid, price);
         mysql_function_query(_dbConnector, query, false, "OnFurnitureAdd", "dd", bizid, i);
    }
    Iter_Add(Loaded_Furniture_Array,i);   
	return (true);
}

function OnFurnitureAdd(bizid,slot)
{
	BIZ_FURNITURE[bizid][slot][Furniture_ID] = mysql_insert_id();
	return (true); 
}

//===============================================================================================

stock Furniture_Info(playerid,index)
{
	SCM(playerid,-1,"{D19D0F}Furniture name: {FFFFFF}(%s)\n{D19D0F}Furniture Model: {FFFFFF}%d",g_aFurnitureData[index][e_FurnitureName], g_aFurnitureData[index][e_FurnitureModel]);
	return (true);
}

//===============================================================================================

Dialog:Business_Furniture_Edit(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		 new i = Choosed_Biz_Options[playerid];
         if(i != (-1) && BIZ_ENUM[i][BIZ_TYPE] == (1))
         {
         	switch(listitem)
         	{
         		case 0:
         		{
                       Dialog_Show(playerid, Business_Furniture_Add, DSI, "{FFD000}FURNITURE - {FFFFFF}ADD","{FFFFFF}Unesite ime koje zelite da dodate kao prodajni artikal vase firme.\n\n{F7234A}Da vidite moguce objekte za dodavanje kliknite na {FFFFFF}All furniture list {F7234A}gdje cete vidjeti ID i ime objekata.","Input","Cancel");
         		}
         		case 1:
         		{
         		       Business_Edit_Furniture(playerid,i,1);
         		}
         		case 2:
         		{
         			   Business_Edit_Furniture(playerid,i,2);
         		}
         		case 3:
         		{
         			   Business_Edit_Furniture(playerid,i,3);
         		}
         	}
         }
	}
	return (true);
}

Dialog:Business_Furniture_Add(playerid, response, listitem, inputtext[])
{
	if(response)
	{
               new i = Choosed_Biz_Options[playerid];
	           if(i != (-1) && BIZ_ENUM[i][BIZ_TYPE] == (1))
	           {
	           	    if(isnull(inputtext))
	           	      return Dialog_Show(playerid, Business_Furniture_Add, DSI, "{FFD000}FURNITURE - {FFFFFF}ADD","{FFFFFF}Unesite ime koje zelite da dodate kao prodajni artikal vase firme.\n\n{F7234A}Da vidite moguce objekte za dodavanje kliknite na {FFFFFF}All furniture list {F7234A}gdje cete vidjeti ID i ime objekata.","Input","Cancel");

	           	    new model = GetFurnitureModelByName(inputtext);

	           	    if(!model)
	           	       return Dialog_Show(playerid, Business_Furniture_Add, DSI, "{FFD000}FURNITURE - {FFFFFF}ADD","{FF0000}Pogresan model furniture itema.\n{FFFFFF}Unesite ime koje zelite da dodate kao prodajni artikal vase firme.\n\n{F7234A}Da vidite moguce objekte za dodavanje kliknite na {FFFFFF}All furniture list {F7234A}gdje cete vidjeti ID i ime objekata.","Input","Cancel");

	           	    if(IsFurnitureAdded(i,GetFurnitureNameByModel(model)) != -1)
	           	    	return GRESKA(playerid,"Ovaj furniture item je vec dodan kao prodajni artikal u vasoj firmi.");

	           	    Inputed_Furniture_Model[playerid] = (model);

	           	    Dialog_Show(playerid, Business_Furniture_Add_P, DSI, "{FFD000}FURNITURE - {FFFFFF}ADD PRICE","{FFFFFF}Unesite cijenu za (%s).","Input","Cancel",GetFurnitureNameByModel(model));     
	           }
	}
	else
	Dialog_Show(playerid, Business_Furniture_Edit, DSL, "{FFD000}FURNITURE - {FFFFFF}OPTIONS","Add furniture\nEdit furniture\nFurniture list\nAll furniture list","Choose","Cancel");
	return (true);
}

Dialog:Business_Furniture_Add_P(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         if(isnull(inputtext) || strval(inputtext) < 1)
           return Dialog_Show(playerid, Business_Furniture_Add_P, DSI, "{FFD000}FURNITURE - {FFFFFF}ADD PRICE","{FFFFFF}Unesite cijenu za (%s).","Input","Cancel",GetFurnitureNameByModel(Inputed_Furniture_Model[playerid]));
         
         Inputed_Furniture_Price[playerid] = strval(inputtext);

         Dialog_Show(playerid, Business_Furniture_Add_R, DSM, "{FFD000}FURNITURE - {FFFFFF}ADD","{FFD000}Furniture item: {FFFFFF}(%s).\n{FFD000}Furniture price: {FFFFFF}$%d\n\nDa dodate ovaj item u prodaju pritisnite Add","Add","Cancel",GetFurnitureNameByModel(Inputed_Furniture_Model[playerid]),Inputed_Furniture_Price[playerid]);     
	}
	return (true);
}

Dialog:Business_Furniture_Add_R(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           Add_Business_Furniture(playerid,Choosed_Biz_Options[playerid],GetFurnitureNameByModel(Inputed_Furniture_Model[playerid]),Inputed_Furniture_Model[playerid],Inputed_Furniture_Price[playerid]);

	       INFO(playerid,"Uspesno ste dodali (%s) na prodaju.",GetFurnitureNameByModel(Inputed_Furniture_Model[playerid]));
	}
	return (true);
}

//====================================================================================

Dialog:Furniture_Edition_Dialog(playerid, response, listitem, inputtext[])
{
	new i = Choosed_Biz_Options[playerid];
	if(response)
	{
          	    if(BIZ_FURNITURE[i][listitem][Furniture_Model] != 0)
             	{
                     Editing_Furniture_Item[playerid] = listitem;
                     Dialog_Show(playerid, Furniture_Edition_R, DSL, "{FFD000}FURNITURE - {FFFFFF}EDITION","Edit price\nEdit quantity\nDelete furniture","Choose","Cancel");
             	}
	}
	return (true);
}

Dialog:Furniture_Edition_R(playerid, response, listitem, inputtext[])
{
	new i = Choosed_Biz_Options[playerid];
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Dialog_Show(playerid, Furniture_Edit_Price, DSI, "{FFD000}FURNITURE - {FFFFFF}PRICE EDIT","{FFD000}Furniture Name: {FFFFFF}(%s) {FFD000}Model: {FFFFFF}(%d) {FFD000}Price: {FFFFFF}($%d)\nAko zelite promeniti cijenu ovog furniture itema unesite novu.","Input","Cancel",BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Name],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Model],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Price]);
			}
			case 1:
			{
				Dialog_Show(playerid, Furniture_Edition_Slots, DSI,"{FFD000}FURNITURE - {FFFFFF}QUANTITY EDIT","{FFD000}Dodavanje kolicine ovog modela: {FFFFFF}(%s).\nSvako dodavanje kolicine modela kosta {FFD000}500$\n{FFFFFF}Unesite kolicinu za ovaj furniture item.","Input","Cancel",BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Name]);
			}
			case 2:
			{
				INFO(playerid,"Uspesno ste obrisali %s iz prodajnog kataloga.",BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Name]);
                Business_Remove_Furniture(i,BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Model]);
			}
		}
	}
}

Dialog:Furniture_Edit_Price(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new price;
        new i = Choosed_Biz_Options[playerid];

        static query[128];

        if(sscanf(inputtext,"d",price))
          return Dialog_Show(playerid, Furniture_Edit_Price, DSI, "{FFD000}FURNITURE - {FFFFFF}PRICE EDIT","{FFD000}Furniture Name: {FFFFFF}(%s) {FFD000}Model: {FFFFFF}(%d) {FFD000}Price: {FFFFFF}($%d)\nAko zelite promeniti cijenu ovog furniture itema unesite novu.","Input","Cancel",BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Name],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Model],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Price]);
        if(price < 1)
           return Dialog_Show(playerid, Furniture_Edit_Price, DSI, "{FFD000}FURNITURE - {FFFFFF}PRICE EDIT","{FFD000}Furniture Name: {FFFFFF}(%s) {FFD000}Model: {FFFFFF}(%d) {FFD000}Price: {FFFFFF}($%d)\nAko zelite promeniti cijenu ovog furniture itema unesite novu.","Input","Cancel",BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Name],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Model],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Price]);

        BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Price] = price;

        INFO(playerid,"Uspesno ste promenili cijenu %s: u $%d",BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Name],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Price]);  
	
	    format(query, sizeof(query), "UPDATE `ug_business_furniture` SET `Furniture_Price` = '%d' WHERE `ID` = '%d' AND `Furniture_ID` = '%d'",
        BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Price],BIZ_ENUM[i][BIZ_ID],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_ID]);
        mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";

	}
	return (true);
}

Dialog:Furniture_Edition_Slots(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         new kolicina;
         new i = Choosed_Biz_Options[playerid];

         static query[128];

         if(sscanf(inputtext,"d",kolicina))
           return Dialog_Show(playerid, Furniture_Edition_Slots, DSI,"{FFD000}FURNITURE - {FFFFFF}QUANTITY EDIT","{FFD000}Dodavanje kolicine ovog modela: {FFFFFF}(%s).\nSvako dodavanje kolicine modela kosta {FFD000}500$\n{FFFFFF}Unesite kolicinu za ovaj furniture item.","Input","Cancel",BIZ_FURNITURE[i][i][Furniture_Name]);
	
         new cijena = kolicina * 500;

         if(cijena > BIZ_ENUM[i][BIZ_MONEY])
            return GRESKA(playerid,"Nemate dovoljno novca u kasi kako bi platili nadogranju,potrebno $%d.",cijena);

         BIZ_ENUM[i][BIZ_MONEY] -= cijena;
         Save_Business(i);

         BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Slots] += kolicina;

         format(query, sizeof(query), "UPDATE `ug_business_furniture` SET `Furniture_Slots` = '%d' WHERE `ID` = '%d' AND `Furniture_ID` = '%d'",
         BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Slots],BIZ_ENUM[i][BIZ_ID],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_ID]);
         mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";

         INFO(playerid,"Uspesno ste nadogradili slotove furniture itema: (%s) na %d.",BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Name],BIZ_FURNITURE[i][Editing_Furniture_Item[playerid]][Furniture_Slots]);  
	}
	return (true);
}

//====================================================================================

stock Business_Edit_Furniture(playerid,bizid,option)
{
	static string[1000];

	string[0] = 0;

	if(option == (1))
	{
             foreach(new i: Loaded_Furniture_Array)
             {
             	if(BIZ_FURNITURE[bizid][i][Furniture_Model] != 0)
             	{
             	  	   format(string, sizeof(string),"%s {FFFFFF}Furniture Name: %s Model: (%d) Price: ($%d) Quantity: (%d)\n",
             	  	   string,
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Name],
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Model],
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Price],
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Slots]);
             	}  	   
             	Dialog_Show(playerid, Furniture_Edition_Dialog, DSL, "{FFD000}FURNITURE - {FFFFFF}EDIT", string, "Choose", "Cancel");
             }
	}
	else if(option == (2))
	{
		     foreach(new i: Loaded_Furniture_Array)
             {
             	  if(BIZ_FURNITURE[bizid][i][Furniture_Model] != 0)
             	  {
             	  	   format(string, sizeof(string),"%s{FFFFFF}Furniture Name: %s Model: (%d) Price: ($%d) Quantity: (%d)\n",
             	  	   string,
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Name],
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Model],
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Price],
             	  	   BIZ_FURNITURE[bizid][i][Furniture_Slots]);
             	  }
             	  Dialog_Show(playerid, Show_Only, DSM, "{FFD000}FURNITURE {FFFFFF}- LIST", string, "IZLAZ", "");
            } 	  	   
	}
	else if(option == (3))
	{
		    static items[sizeof(g_aFurnitureData)];

		    for (new i = 0; i < sizeof(g_aFurnitureData); i ++)
	        {
	        	items[i] = g_aFurnitureData[i][e_FurnitureModel];
	        }
	        ShowModelSelectionMenu(playerid, "All available furnitures", MODEL_SELECTION_ALL_FURNITURE_LIST, items, sizeof(items), -12.0, 0.0, 0.0);
	}
	string = "\0";
	return (true);
}

stock Business_Remove_Furniture(bizid,model)
{
	static query[128];

	for(new i = 0; i != MAX_FURNITURE_ITEMS; ++i) if(BIZ_FURNITURE[bizid][i][Furniture_Model] == model)
    {
    	format(query, sizeof(query), "DELETE FROM `ug_business_furniture` WHERE `ID` = '%d' AND `Furniture_ID` = '%d'",
        BIZ_ENUM[bizid][BIZ_ID],BIZ_FURNITURE[bizid][i][Furniture_ID]);
        mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";

        BIZ_FURNITURE[bizid][i][Furniture_Name] = '\0';
        BIZ_FURNITURE[bizid][i][Furniture_Model] = 0;
    	BIZ_FURNITURE[bizid][i][Furniture_Price] = 0;
    	BIZ_FURNITURE[bizid][i][Furniture_ID] = (-1);
    	BIZ_FURNITURE[bizid][i][Furniture_Slots] = 0;
    	BIZ_FURNITURE[bizid][i][Furniture_Added] = (-1);

        Iter_Remove(Loaded_Furniture_Array,i); 
    }
	return (true);
}

//====================================================================================

stock GetFree_FurnitureID()
{
	new fID = Iter_Free(Loaded_Furniture_Array);
	return ((fID < MAX_FURNITURE_ITEMS) ? (fID) : (-1));
}

//====================================================================================

function Load_Business_Furniture(bizid)
{
	static rows,fields;

	cache_get_data(rows, fields, _dbConnector);

	for (new i = 0; i != rows; i ++) 
	{
		cache_get_field_content(i, "Furniture_Name", BIZ_FURNITURE[bizid][i][Furniture_Name], _dbConnector);

		BIZ_FURNITURE[bizid][i][Furniture_ID] = cache_get_field_kurac(i, "Furniture_ID");
		BIZ_FURNITURE[bizid][i][Furniture_Model] = cache_get_field_kurac(i, "Furniture_Model");
		BIZ_FURNITURE[bizid][i][Furniture_Price] = cache_get_field_kurac(i, "Furniture_Price");
		BIZ_FURNITURE[bizid][i][Furniture_Slots] = cache_get_field_kurac(i, "Furniture_Slots");
		BIZ_FURNITURE[bizid][i][Furniture_Added] = cache_get_field_kurac(i, "Furniture_Added");

		Iter_Add(Loaded_Furniture_Array,i); 
	}
	return (true);
}

//====================================================================================