//================================================================
/*
                    	Balkan Rising
                       		0.0.1x
                    Developer:C++,caupton
*/                                              
//================================================================
/*
         PLAN RADA:
                    1.Register/Login system (90%)
                    2.Admin system (80%)
                    3.Entrance system (90%)
                    7.Inventory system (70%)
                    
                    4.Car Ownership (80%)
                    {
	                          Uraditi ostavljanje droge materijala,
	                          Uraditi uzimanje droge materijala.
	                          Uraditi fuel system.

	                          Kad dodju systemi.

	                          5.Tuning system (100%)
	                          6.System unistenja (100%)
	                          7.System osiguranja (100%)
	                          8.System obijanja (100%)
	                }          
                    5.Bike Ownership (80%)        
                    {
	                          Uraditi ostavljanje droge materijala,
	                          Uraditi uzimanje droge materijala.
	                          Uraditi fuel system.

	                          Kad dodju systemi.
                    }
                    6.House system (80%)
                    {
	                          Uraditi ostavljanje droge materijala,
	                          Uraditi uzimanje droge materijala.
                    }
                    7.Business System (50%)
                    {
	                         Odraditi shipment kad dodju poslovi.
                    } 

*/
//================================================================                      

#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <sscanf2>  

#include <regex>
#include <strlib>
#include <progress>
#include <easyDialog>
#include <eSelection>
#include <cfunctions>
#include <eDistance>

#include <YSI\y_bit>
#include <YSI\y_iterate>
#include <YSI\y_bintree>
#include <YSI\y_va>
#include <YSI\y_timers>
#include <YSI\y_commands>

//================================================================

#undef MAX_PLAYERS
     #define MAX_PLAYERS (100)

#define function%0(%1)\
     forward%0(%1); public%0(%1)
     
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define HOLDING(%0) \
     ((newkeys & (%0)) == (%0))
     
#define RELEASED(%0) \
     (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

//================================================================= 

#define DSL               	DIALOG_STYLE_LIST
#define DSM               	DIALOG_STYLE_MSGBOX
#define DSI 			  	DIALOG_STYLE_INPUT
#define DSP 			  	DIALOG_STYLE_PASSWORD
#define SCM               	va_SendClientMessage
#define SCMTA             	va_SendClientMessageToAll
#define IPI               	INVALID_PLAYER_ID

//==============================================================================

#define GRESKA(%0,%1)            SCM(%0, 0xfa5555AA, "(ERROR):{FFFFFF} "%1)
#define USAGE(%0,%1)             SCM(%0, 0xDEDEA6FF, "{FCD77E}(USAGE):{FFFFFF} "%1)
#define INFO(%0,%1)              SCM(%0, 0xFFAB52FF, "{C7AF46}(INFO):{FFFFFF} "%1)

//==============================================================================

#define IsValidEmail(%1) \
    regex_match(%1, "[a-zA-Z0-9_\\.]+@([a-zA-Z0-9\\-]+\\.)+[a-zA-Z]{2,4}")
    
#define IsValidRpName(%1) \
    regex_match(%1, "([A-Z]{1,1})[a-z]{2,9}+_([A-Z]{1,1})[a-z]{2,9}")
    
#define IsValidText(%1) \
    regex_match(%1, "[ à-ÿÀ-ßa-zA-Z0-9_,!\\.\\?\\-\\+\\(\\)]+")
     
//==============================================================================


#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define MYSQL_PASS ""
#define MYSQL_DB "balkan_rising_db"

/*
#define MYSQL_HOST "localhost"
#define MYSQL_USER "armin11"
#define MYSQL_PASS "TC73630818078821645606380"
#define MYSQL_DB "193.192.58.147:7779"
*/

//==============================================================================

#define MOD_NAME "BR 0.0.1x BETA"
#define MAP_NAME "San Andreas"
#define FRM_NAME "www.balkan-rising.info"

//==============================================================================

enum player {
	 p_Name[MAX_PLAYER_NAME + 1],
	 p_Password[14],
	 p_Mail[24],
	 p_IP[16],
	 p_LastLogin[36],
	 p_Level,
	 p_Money,
	 p_Skin,
	 p_Gender,
	 p_Admin,
     p_Gamemaster,
     p_StaffKod,
     p_Warns,
     p_Muted,
     p_Vehicles[4],
     p_Bikes[4],
     p_Property[4],
     p_Property_Rent,
     p_Business_Job,
     pGuns[13],
	 pAmmo[13],
	 pWatches[3],
	 pHats[3],
	 pBandanda[3],
	 pGlasses[3]
};
new Player_Enum[MAX_PLAYERS][player];

new Float:AccessoryData[MAX_PLAYERS][12][9];
new AccesorySlot[MAX_PLAYERS] = INVALID_PLAYER_ID;

//==============================================================================

AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

//==============================================================================

native IsValidVehicle(vehicleid);

//==============================================================================    

main()
{
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print(" ");
	print("Balkan Rising Roleplay");
    print("============================");
	print("VERZIJA:    0.0.1x     ");
	print("UPDATED:    7.3.2015  ");
	print("DEVELOPER:  C++,caupton  ");
	print("============================");
}

//===============================================================================

new _dbConnector;

//===============================================================================

new PlayerPassword[MAX_PLAYERS][14],
    PlayerEmail[MAX_PLAYERS][24],
    PlayerGender[MAX_PLAYERS] = INVALID_PLAYER_ID,
    PlayerPokusaji[MAX_PLAYERS] = 0;

new PlayerDied[MAX_PLAYERS] = INVALID_PLAYER_ID;

new Editing_Type[MAX_PLAYERS] = INVALID_PLAYER_ID;
new Editing_Slot[MAX_PLAYERS] = INVALID_PLAYER_ID;
new Player_Editing[MAX_PLAYERS] = INVALID_PLAYER_ID;

new Clothes_Type[MAX_PLAYERS] = INVALID_PLAYER_ID;     

//===============================================================================

new const
          MaleSkins[] = {6, 7, 15, 22, 20, 37},
          FemaleSkins[] = {9, 10, 12, 13, 41, 40};


new g_aMaleSkins[185] = {
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
	30, 32, 33, 34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60,
	61, 62, 66, 68, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102,
	103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
	121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146,
	147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170, 171, 173, 174, 175, 176,
	177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203, 204, 206,
	208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240,
	241, 242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289,
	290, 291, 292, 293, 294, 295, 296, 297, 299
};

new g_aFemaleSkins[77] = {
    9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69,
    75, 76, 77, 85, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 140, 141,
    145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195,
    196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225,
    226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263,
    298
};                    

//===============================================================================

static PlayerIP[16];         

//===============================================================================

new BitArray:b_Textdraw<MAX_PLAYERS>,
    BitArray:b_Enabled<MAX_PLAYERS>,
    BitArray:b_sLogged<MAX_PLAYERS>,
    BitArray:b_Spawned<MAX_PLAYERS>,
    BitArray:b_Spectating<MAX_PLAYERS>;

//===============================================================================

new PlayerText:Register_TD[MAX_PLAYERS][21],
    PlayerText:Ban_TD[MAX_PLAYERS][14],
    PlayerText:Cos_TD[MAX_PLAYERS][27],
    PlayerText:Speedo_TD[MAX_PLAYERS][22],
    PlayerText:Vehicle_Breaking_TD[MAX_PLAYERS][9],
    PlayerText:House_L_TD[MAX_PLAYERS];

new Text:ServerLogo[5];

//===============================================================================

new PlayerBar:Breaking_Bar;

//===============================================================================

new Float:random_Spawn[5][4] =
{
      { 1327.2889,-1249.5424,13.5709,173.7332 },
	  { 1323.7695,-1250.1000,13.5709,193.1601 },
	  { 1319.3635,-1249.0177,13.5709,162.7665 },
	  { 1311.2271,-1251.1199,13.5709,251.7540 },
	  { 1318.2288,-1253.2455,13.5709,217.2870 }
};

new Float:random_Spawn_1[5][4] =
{
      { 2140.2249,-1738.4595,13.5769,86.6260  },
	  { 2133.4636,-1738.2797,13.5769,198.8004 },
	  { 2129.5232,-1736.1193,13.5769,174.9868 },
	  { 2126.6523,-1740.4794,13.5769,266.7710 },
	  { 2134.2947,-1736.2708,13.5769,187.4968 }
};

//===============================================================================

new g_Strings[][] =
{
	"{FFFFFF}Dobrodosao/la na {FFAE00}Balkan Rising {FFFFFF}Roleplay.\n\n\
	 Kako bi se mogli registrovati na nas server...\n\
	 Potrebno je da unesete zeljeni password.\n\
	 Password moze imati max 14 karaktera ili minimalno 6.\n\
	 Potrudite se da unesete odgovarajuci password kako posle nebi imali problema.",

	"{FFAE00}OWNER - {FFFFFF}Ralph\n\
	{FFAE00}SCRIPTER - {FFFFFF}C++(Adis Catic)\n\
	{FFAE00}LAST UPDATED - {FFFFFF}7.3.2015\n\
	{FFAE00}SCRIPT VERSION - {FFFFFF} 0.0.1x BETA\n\
	{FFAE00}NEXT UPDATE - {FFFFFF} Soon",

	"{FFAE00}DEVELOPER - {FFFFFF}C++,CautponS\n\
	{FFAE00}MAPER - {FFFFFF}Djordevic\n\n\
	Ako vas zanima nesto oko skripte obratite se C++-u, CautponS, Ralph na forum.\n\
	Ako trebate IG pomoc oko nekog dijela moda obratite se staff teamu.",

	"{FFFFFF}Uspesno ste registrovali svoj password u nasu {FF0000}BAZU PODATAKA.\n\
	{FFFFFF}Vas sledeci korak jeste da unesete svoju email adresu.\n\
	Email adresa vam je potrebna u slucaju gubitka/zaborava vaseg passworda.\n\
	Ako unesete pogresnu email adresu i zelite povrat passworda to nece biti moguce.\n\
	Nasa zajednica se ograduje od vaseg email-a i nece ga koristiti u nedozvoljenje svrhe\n\
	Vasa email adresa mora biti u formatu {FF0000}www.vasmail@hotmail/gmail.com",

	"{FFFFFF}Nakon sto ste unijeli svoju email adresu..\n\
	Sad je potrebno da odaberete spol za vaseg IG karaktera.\n\
	Prakticno spol sluzi samo za dobijanje karakternog skina,\n\
	te ne utjece na vas napredak u igri,zato na vama je odluka sta odabrati.",

	"{FFFFFF}Dobrodosao/la na {FFAE00}Balkan Rising {FFFFFF}Roleplay.\n\n\
	Vas racun je pronadjen u nasoj bazi podataka.\n\
	Kako bi ste mu pristupili molimo unesite svoj password.\n\
	Ako ste zaboravili password ili vam je racun provaljen obratite nam se na forum.\n\n\
	{FFFFFF}Sretan napredak u igri zeli vam nas staff team."

};

new r_Strings[][] =
{
	"Ako imate kakva pitanja obratite nam se preko ~r~/pitaj.",
	"Ako ste pronasli bug prijavite ga na ~r~/bugreport ~w~ili na nas forum.",
	"Zaboravili ste neku od komandi,kucajte ~r~/komande ~w~za sve komande.",
	"Usli ste u novcanu krizu tu je BANKA kako bi vam pomogla.",
	"Ukoliko vidite citera prijavite ga na ~r~/report ~w~ili na nas forum.",
	"Ako ne znate gdje se koja lokacija nalazi kupite gps u obliznjem ducanu.",
	"Ukoliko imate pitanja oko skripte ili predlog,postavite ga na nas forum.",
	"Svaki 7 dana vrsi se update moda i bug fix.",
	"Vasa pozicija na nasem serveru zavisi od vaseg zalaganja za ovu zajednicu.",
	"Da otvorite svoj inventar kucajte ~y~/inventory.",
	"Da pokupite neki item sa poda kucajte ~y~/pickupitem.",
	"Da otvorite vas clothes inventory kucajte ~y~/clothes."
};

//===============================================================================

static stock vehicle_Names[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

static const g_Preload_Anims[][] =
{
	"AIRPORT",      "ATTRACTORS",   "BAR",          "BASEBALL",     "BD_FIRE",
	"BEACH",        "BENCHPRESS",   "BF_INJECTION", "BIKE_DBZ",     "BIKED",
	"BIKEH",        "BIKELEAP",     "BIKES",        "BIKEV",        "BLOWJOBZ",
	"BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
	"BUS",          "CAMERA",       "CAR",          "CAR_CHAT",     "CARRY",
	"CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
	"COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
	"DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
	"DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
	"FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
	"FLOWERS",      "FOOD",         "FREEWEIGHTS",  "GANGS",        "GFUNK",
	"GHANDS",       "GHETTO_DB",    "GOGGLES",      "GRAFFITI",     "GRAVEYARD",
	"GRENADE",      "GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",
	"INT_OFFICE",   "INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",
	"KNIFE",        "LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",
	"MD_CHASE",     "MD_END",       "MEDIC",        "MISC",         "MTB",
	"MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
	"PARK",         "PAULNMAC",     "PED",          "PLAYER_DVBYS", "PLAYIDLES",
	"POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
	"QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",
	"ROCKET",       "RUNNINGMAN",   "RUSTLER",      "RYDER",        "SCRATCHING",
	"SEX",          "SHAMAL",       "SHOP",         "SHOTGUN",      "SILENCED",
	"SKATE",        "SMOKING",      "SNIPER",       "SNM",          "SPRAYCAN",
	"STRIP",        "SUNBATHE",     "SWAT",         "SWEET",        "SWIM",
	"SWORD",        "TANK",         "TATTOOS",      "TEC",          "TRAIN",
	"TRUCK",        "UZI",          "VAN",          "VENDING",      "VORTEX",
	"WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};

static const g_aWeaponSlots[] = {
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

//===============================================================================

// osnovni moduli
#include "Base/Server_Textdraws.pwn"
#include "Base/Server_Maps.pwn"
#include "Base/Server_Entrance.pwn"
#include "Base/Admin_System.pwn"
#include "Base/Hungery_System.pwn"

// ownership dio
#include "Ownership/Server_Ownership.pwn"
#include "Ownership/Server_Bike_Ownership.pwn"
#include "Ownership/Breaking_System.pwn"
#include "Ownership/Server_Tuning.pwn"
#include "Ownership/Server_Speedo.pwn"

//property dio
#include "Property/House_Ownership.pwn"
#include "Property/Business_Ownership.pwn"
#include "Property/Business_Furniture_System.pwn"

// inventory dio
#include "Inventory/Server_Inventory.pwn"

//===============================================================================

public OnGameModeInit() {
     SetGameModeText(MOD_NAME);SendRconCommand("mapname "MAP_NAME""); SendRconCommand("weburl "FRM_NAME"");DisableInteriorEnterExits(); AntiDeAMX();
     EnableStuntBonusForAll(false);ShowPlayerMarkers(false);SetNameTagDrawDistance(20);AllowInteriorWeapons(1);ManualVehicleEngineAndLights();

     Mysql_Connect(); LoadTables();

     CreatePickupLabel();
     return (true);
}

public OnGameModeExit(){
     mysql_close(_dbConnector);

     DestroyAllDynamicPickups(); DestroyAllDynamic3DTextLabels();
     DestroyAllDynamicMapIcons(); DestroyAllDynamicObjects();
     return (true);
}

public OnPlayerConnect(playerid){
	defer Priprema_Osnove(playerid);
	return (true);
}

public OnPlayerDisconnect(playerid, reason){
	if(Bit_Get(b_Spawned, playerid) == true) { 
		UpdateWeapons(playerid); SavePlayer(playerid); 
    }
	return (true);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){   
	return (true);
}

public OnPlayerDeath(playerid, killerid, reason){
	ShowGlobalTDs(playerid,2);
	PlayerDied[playerid] = (1);
	return (true);
}

public OnPlayerSpawn(playerid){
	if(!IsPlayerNPC(playerid)) //Provjerava dali je igrac NPC.
    {
	        ShowGlobalTDs(playerid,1); 
	        PreloadAnimations(playerid);
	        Attach_Inventory_Bag(playerid);
	        SetWeapons(playerid);
	        Streamer_Update(playerid);

	        if(PlayerDied[playerid] == (1))
            {
               PlayerDied[playerid] = (0);

               SetPlayerInterior(playerid, 0);
               TogglePlayerSpectating(playerid, false);
	           SetPlayerPos(playerid, 1177.3741,-1323.4473,14.0675);
	           SetPlayerFacingAngle(playerid,270.5543);
	           SetPlayerSkin(playerid, Player_Enum[playerid][p_Skin]);
	           SetCameraBehindPlayer(playerid);
	        }   
    }
    return (true);
}

public OnPlayerUpdate(playerid){
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1295.003,-1862.269,13.680)) // nalpo
	{
		MoveDynamicObject(osiguranjevrata, 1295.003,-1862.269,10.7067, 1.5);
		nalpovrata = 1;
	}
	return (true);
}

public OnPlayerEnterCheckpoint(playerid){
	DisablePlayerCheckpoint(playerid);
	return (true);
}

//====================================================//

public OnVehicleCreated(vehicleid){
	if(IsABiciklo(vehicleid))
	{
         SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, 1);
	}
    return (true);
}

//=====================================================//

public OnModelSelectionResponse(playerid, extraid, index, modelid, response){
	if ((extraid == MODEL_SELECTION_BIKES_BUY && response))
	{
		if(Player_Enum[playerid][p_Money] < Salon_Bikes[index][1])
		   { GRESKA(playerid,"Nemate dovoljno novca za kupovinu (%s) $%d.",ReturnVehicleModelName(Salon_Bikes[index][0]),Salon_Bikes[index][1]); Katalog_Bikes = 0; return (true); }

		new i = GetFree_BosID(); Iter_Add(Load_Bikes_Array,i);

		Add_Base_Bike(i,GetName(playerid),Salon_Bikes[index][0],Salon_Bikes[index][1]);

		Set_Bike_Var(playerid,i,index); Katalog_Bikes = 0;
	} 
	else if ((extraid == MODEL_SELECTION_CARS && response))
	{
			 if(COS_Enum[index][C_CREATED] == 0)
			    return GRESKA(playerid,"Prazan slot!");

			 Selected_ID[playerid] = Player_Enum[playerid][p_Vehicles][index];

			 Dialog_Show(playerid, Veh_Opcije, DSL, "{FFD000}VOZILO {FFFFFF}- MANAGE", "{FFFFFF}Informacije\nBrava\nSpremnik\nNadogradjivanje\nProdaja\nParkiraj\nLociraj", "Odaberi", "Odustani");  
	}
	else if ((extraid == MODEL_SELECTION_BIKES && response))
	{
		     if(BIKE_Enum[index][B_CREATED] == 0)
		        return GRESKA(playerid,"Prazan slot!");

		     Selected_ID[playerid] = Player_Enum[playerid][p_Bikes][index];

		     if(!IsABiciklo(BIKE_Enum[Selected_ID[playerid]][B_VEHICLE_ID]))
		     Dialog_Show(playerid, Bike_Opcije, DSL, "{FFD000}BIKE {FFFFFF}- MANAGE", "{FFFFFF}Informacije\nBrava\nSpremnik\nProdaja\nParkiraj\nLociraj", "Odaberi", "Odustani"); 

		     else
		     Dialog_Show(playerid, Biciklo_Opcije, DSL, "{FFD000}BIKE {FFFFFF}- MANAGE", "{FFFFFF}Brava\nProdaja\nParkiraj\nLociraj", "Odaberi", "Odustani");    
	}
	else if ((extraid == MODEL_SELECTION_INVENTORY && response) && InventoryData[playerid][index][invExists])
    {
    	static itemname[50];

        Item_ID[playerid] = (index);
        
    	strunpack(itemname, InventoryData[playerid][index][invItem]);
	    format(itemname, sizeof(itemname), "{ECFAA0}Item name: {FFFFFF}(%s)", itemname);
	    Dialog_Show(playerid, Player_Inventory, DSL, itemname, "{FFFFFF}Use item\nGive item\nDrop item\nSell item", "Odaberi", "Odustani");

	    itemname = "\0";
    }
    else if ((response) && (extraid == MODEL_SELECTION_COLOR))
	{
		ColorBuy[playerid][0] = modelid; ColorBuy[playerid][1] = modelid;

		MoveDynamicObject(dizalice[0], 1346.72839, -1746.03931, 12.43150, 1.5);
		MoveDynamicObject(dizalice[1], 1346.72839, -1749.59790, 12.43150, 1.5);

		ConnectNPC("NpcJedan", "npc_mehanicar");
		defer Bot_Show(playerid);
	}
	else if ((response) && (extraid == MODEL_SELECTION_ALL_FURNITURE_LIST))
	{
		Furniture_Info(playerid,index);
	}
	else if ((response) && (extraid ==  MODEL_SELECTION_BIZ_VEHICLES))
	{
		new i = Choosed_Business[playerid];

		if(i != (9999) && BIZ_ENUM[i][BIZ_VEHICLE_ID] == (9999))
		{
			if(Businesses_Buyable_Vehicles[index][1] > BIZ_ENUM[i][BIZ_MONEY])
			  return GRESKA(playerid,"Nemate dovoljno novca u biznisu, potrebno: $%d",Businesses_Buyable_Vehicles[index][1]);
			
			BuyBusiness_Vehicle(i,Businesses_Buyable_Vehicles[index][0],Businesses_Buyable_Vehicles[index][1]);
			BIZ_ENUM[i][BIZ_MONEY] -= Businesses_Buyable_Vehicles[index][1];
			Save_Business(i);
			INFO(playerid,"Uspesno ste kupili vozilo za svoj biznis. (%s)",ReturnVehicleModelName(Businesses_Buyable_Vehicles[index][0]));
		}
		else return GRESKA(playerid,"Vas biznis vec ima vozilo.");
	}
	else if((response) && (extraid == MODEL_SELECTION_FURNITURE_BUY))
	{
            new
			id = Business_Inside(playerid),
			price;

			price = BIZ_FURNITURE[id][index][Furniture_Price];

            if(BIZ_FURNITURE[id][index][Furniture_Slots] < 1)
               return GRESKA(playerid,"Nemamo vise zaliha ovog proizvoda.");
			if(Player_Enum[playerid][p_Money] < price)
			   return GRESKA(playerid,"Nemate dovoljno novca za kupovinu: (%s)",BIZ_FURNITURE[id][index][Furniture_Name]);
			if(BIZ_ENUM[id][BIZ_PRODUCTS] < 1)
			   return GRESKA(playerid,"Ovaj biznis nema vise produkata,zao nam je.");

            Furniture_Index[playerid] = (index);
            SCM(playerid,-1,"Sad odaberite slot kuce na koji zelite dodati ovaj artikal.");
			Dialog_Show(playerid, Furniture_Buy_Dialog, DSL, "{FFFFFF}FURNITURE CHOOSE HOUSE", "House Slot 1\nHouse Slot 2", "Choose", "Cancel");   
	}
	else if((response) && (extraid == MODEL_SELECTION_CLOTHES))
	{
		    new bizid = Business_Inside(playerid),
		    price;

		    price = BIZ_ENUM[bizid][BIZ_PRICES][Clothes_Type[playerid] - 1];

		    if(BIZ_ENUM[bizid][BIZ_PRODUCTS] < 1)
		       return GRESKA(playerid,"Ova firma nema vise produkata.");
		    if(Player_Enum[playerid][p_Money] < price)
		       return GRESKA(playerid,"Nemate dovoljno novca za kupovinu.");

		    Player_Enum[playerid][p_Money] -= price;
		    GivePlayerMoney(playerid,-price);   

		    BIZ_ENUM[bizid][BIZ_PRODUCTS] --;
			BIZ_ENUM[bizid][BIZ_MONEY] += Tax_Percent(price);

			Save_Business(bizid);    

			switch(Clothes_Type[playerid])
			{
				case 1:{
					Player_Enum[playerid][p_Skin] = modelid;
					SetPlayerSkin(playerid, modelid);

					INFO(playerid,"Kupili ste odjecu ID: (%d)",modelid);
			    }
			    case 2:
			    {
			    	Buy_Model[playerid] = modelid;
                    Dialog_Show(playerid, Clothes_Buy_Watches, DSI,"{FFFFFF}WATCHES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sat.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");  
			    }
			    case 3:
			    {
			    	Buy_Model[playerid] = modelid;
                    Dialog_Show(playerid, Clothes_Buy_Hats, DSI,"{FFFFFF}HATS SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sesir.\n\nSlotovi se krecu od {F51B4A}[3-5]","Input","Cancel");  
			    }   
			    case 4:
			    {
			    	Buy_Model[playerid] = modelid;
                    Dialog_Show(playerid, Clothes_Buy_Bandanda, DSI,"{FFFFFF}BANDANDA SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas bandanda.\n\nSlotovi se krecu od {F51B4A}[6-8]","Input","Cancel");  
			    }
			    case 5:
			    {
			    	Buy_Model[playerid] = modelid;
                    Dialog_Show(playerid, Clothes_Buy_Glasses, DSI,"{FFFFFF}GLASSES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vase naocare.\n\nSlotovi se krecu od {F51B4A}[9-11]","Input","Cancel");  
			    }
			}
	}
	return (true);
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz){
	if(response == EDIT_RESPONSE_FINAL)
	{
		if(Furniture_Edit[playerid] != (-1))
		{
			    FurnitureData[Furniture_Edit[playerid]][furniturePos][0] = x;
			    FurnitureData[Furniture_Edit[playerid]][furniturePos][1] = y;
			    FurnitureData[Furniture_Edit[playerid]][furniturePos][2] = z;
                FurnitureData[Furniture_Edit[playerid]][furnitureRot][0] = rx;
                FurnitureData[Furniture_Edit[playerid]][furnitureRot][1] = ry;
                FurnitureData[Furniture_Edit[playerid]][furnitureRot][2] = rz;
                FurnitureData[Furniture_Edit[playerid]][furnitureSpawned] = 1;

				Furniture_Refresh(Furniture_Edit[playerid]);
				Furniture_Save(Furniture_Edit[playerid]);

				SCM(playerid,-1,"Uspesno ste editovali furniture item: (%s).",FurnitureData[Furniture_Edit[playerid]][furnitureName]);
		}
	}
	return (true);
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ){
   if (response)
   {
   	      if(Editing_Type[playerid] != 0)
   	      {
   	      	    AccessoryData[playerid][Editing_Slot[playerid]][0] = fOffsetX;
	       		AccessoryData[playerid][Editing_Slot[playerid]][1] = fOffsetY;
	         	AccessoryData[playerid][Editing_Slot[playerid]][2] = fOffsetZ;

	          	AccessoryData[playerid][Editing_Slot[playerid]][3] = fRotX;
	           	AccessoryData[playerid][Editing_Slot[playerid]][4] = fRotY;
	           	AccessoryData[playerid][Editing_Slot[playerid]][5] = fRotZ;

	            AccessoryData[playerid][Editing_Slot[playerid]][6] = (fScaleX > 3.0) ? (3.0) : (fScaleX);
	            AccessoryData[playerid][Editing_Slot[playerid]][7] = (fScaleY > 3.0) ? (3.0) : (fScaleY);
				AccessoryData[playerid][Editing_Slot[playerid]][8] = (fScaleZ > 3.0) ? (3.0) : (fScaleZ);

				switch(Editing_Type[playerid])
				{
					case 1:
						INFO(playerid,"Uspesno ste editovali sat na slotu: (%d)",Editing_Slot[playerid]);
					case 2:
						INFO(playerid,"Uspesno ste editovali sesir na slotu: (%d)",Player_Editing[playerid]);
					case 3:
						INFO(playerid,"Uspesno ste editovali bandanda na slotu: (%d)",Player_Editing[playerid]);
					case 4:
						INFO(playerid,"Uspesno ste editovali naocare na slotu: (%d)",Player_Editing[playerid]);			
				}
   	      }
   }
   return (true);
}

//====================================================//

public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success){
    if (success == COMMAND_UNDEFINED)
    {
		  GRESKA(playerid,"Komanda koju ste unijeli ne postoji,za listu komandi kucajte (( /help ))");
		  return e_COMMAND_ERRORS:(true);
    }
    else if(Bit_Get(b_Spawned, playerid) == false)
    {
		  GRESKA(playerid,"Da bi koristili ovu komandu potrebno je da budete ulogovani!");
		  return e_COMMAND_ERRORS:(false);
    }
    return e_COMMAND_ERRORS:(true);
}

public e_COMMAND_ERRORS:OnPlayerCommandPerformed(playerid, cmdtext[], e_COMMAND_ERRORS:success){
    return e_COMMAND_ERRORS:(true);
}

public OnPlayerClickTextDraw(playerid, Text:clickedid){

     if(clickedid == Text:INVALID_TEXT_DRAW)
     {
		if(Bit_Get(b_Textdraw, playerid) == true) return SelectTextDraw(playerid, (0xFFFFFFFF));
     }
	 return (true);
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid){

      if(_:playertextid != INVALID_TEXT_DRAW)
	  {
			   if(playertextid == Register_TD[2][playerid]) // REGISTER TD
			   {
                       if(Bit_Get(b_Enabled, playerid) == true)
						  return (true);
					   RegisterPanel(playerid,2);
					   Dialog_Show(playerid, Register_Dialog, DSP, "{FFFFFF}REGISTRACIJA - KORAK 1", g_Strings[0], "Nastavi", "Odustani");
			   }
			   else if(playertextid == Register_TD[5][playerid]) // LOGIN TD
			   {
                       if(Bit_Get(b_Enabled, playerid) == false)
						  return (true);
					   RegisterPanel(playerid,2);	  
					   Dialog_Show(playerid, Login_Dialog, DSP, "{FFFFFF}PRIJAVLJIVANJE - KORISNIKA", g_Strings[5], "Nastavi", "Odustani");  
			   }
			   else if(playertextid == Register_TD[9][playerid]) // TUTORIAL TD
			   {
			   }
			   else if(playertextid == Register_TD[11][playerid]) // INFORMACIJE TD
			   {
			   	       Dialog_Show(playerid, Show_Only, DSM, "{FFFFFF}SERVER - INFORMACIJE",g_Strings[1],"Izlaz","");
			   }
			   else if(playertextid == Register_TD[13][playerid]) // CREDITS TD
			   {
			   	       Dialog_Show(playerid, Show_Only, DSM, "{FFFFFF}SERVER - CREDITS",g_Strings[2],"Izlaz","");
			   }
			   else if(playertextid == Register_TD[15][playerid]) // IZLAZ TD
			   {
                       RegisterPanel(playerid,2); defer Kick_Player(playerid);
			   }
			   else if(playertextid == Cos_TD[5][playerid])
			   {
			   	       DestroyVehicle(Vehicle_Preview[0]); Cos_TDs(playerid,2);
			   	       defer Garaza_Priprema(playerid);

                       Vehicle_Preview[1] = AddStaticVehicleEx(SalonVozila[ModelSelected[playerid]][0], 1346.8235, -1747.8521, 13.4219, 0.0000, 1, 1, 2000);
	                   SetVehicleVirtualWorld(Vehicle_Preview[1], 150); 

			   	       InterpolateCameraPos(playerid, 1342.264404, -1734.371582, 14.929660, 1353.248535, -1744.686401, 15.860092, 10000);
                       InterpolateCameraLookAt(playerid, 1345.494018, -1738.126586, 14.244324, 1348.697021, -1746.493774, 14.851435, 10000);
			   }

      }
	  return (true);
}

//===============================================================================

timer Priprema_Osnove[2000](playerid)
{
	TogglePlayerSpectating(playerid, (true)); 
	SetPlayerColor(playerid, (0xFFAB52FF));

	Breaking_Bar = CreatePlayerProgressBar(playerid, 540.000000, 212.000000, 84.000000, 5.000000, -353745153, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarValue(playerid, Breaking_Bar, 0.0); SetPlayerProgressBarMaxValue(playerid, Breaking_Bar, 100.000);
	HidePlayerProgressBar(playerid, Breaking_Bar); 

	defer Priprema_Registracije(playerid);
	return (true);
}

timer Priprema_Registracije[4000](playerid)
{
    InterpolateCameraPos(playerid, 2301.460205, -850.211303, 158.525146, 2840.348632, -1409.012695, 158.525146, 70000);
    InterpolateCameraLookAt(playerid, 2300.764404, -855.068176, 157.562438, 2835.906738, -1411.096557, 157.562438, 70000);

    Reset_Inventory_Var(playerid);
    
    defer Registracija_step2(playerid);
	return (true);
}

timer Registracija_step2[3000](playerid)
{
	static string[100];

	GetPlayerIp(playerid,PlayerIP,sizeof(PlayerIP));

	format(string, sizeof(string), "SELECT * FROM `br_bans` WHERE `User` = '%s' OR `IP` = '%s'",GetName(playerid),PlayerIP);
    mysql_function_query(_dbConnector, string, true, "OnPlayerBanCheck", "i", playerid); string = "\0";
	return (true);
}

timer Kick_Player[1000](playerid)
{
	return Kick(playerid);
}

timer Ban_Kick[5000](playerid)
{
	Kick(playerid);
	return (true);
}

timer Objects_Load[4000](playerid)
{
	TogglePlayerControllable(playerid, true);
	return (true);
}

timer Spawn_Player[2000](playerid)
{
	new rand1spawn = random(sizeof(random_Spawn)),rand2spawn = random(sizeof(random_Spawn_1));

    SetString(Player_Enum[playerid][p_LastLogin],ReturnDate());

    INFO(playerid,"Dobrodosao/la nazada %s,lijepo je opet vidjeti vas na nasem serveru.",GetName(playerid));
    INFO(playerid,"Zadnji put ste bili na serveru ( %s ).",Player_Enum[playerid][p_LastLogin]);
    INFO(playerid,"Ugodnu igru zele vam clanovi naseg staff team-a.");

    static query[128];
    format(query,sizeof(query), "UPDATE `br_users` SET `Login_Date` = '%s' WHERE `Player_Name` = '%s'", Player_Enum[playerid][p_LastLogin],GetName(playerid));
	mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";

	if(playerid % 2 == 0)
	{
          SetSpawnInfo(playerid,0, Player_Enum[playerid][p_Skin], random_Spawn[rand1spawn][0], random_Spawn[rand1spawn][1], random_Spawn[rand1spawn][2], random_Spawn[rand1spawn][3], 0,0,0,0,0,0);
          SpawnPlayer(playerid);
	}
	else
	{
		SetSpawnInfo(playerid,0, Player_Enum[playerid][p_Skin], random_Spawn_1[rand2spawn][0], random_Spawn_1[rand2spawn][1], random_Spawn_1[rand2spawn][2], random_Spawn_1[rand2spawn][3], 0,0,0,0,0,0);
		SpawnPlayer(playerid);
	}	

	TogglePlayerSpectating(playerid, false); SetCameraBehindPlayer(playerid); CancelSelectTextDraw(playerid);
    Bit_Set(b_Textdraw, playerid, false); Bit_Set(b_Spawned, playerid, true); SetPlayerColor(playerid, (0xFFFFFFFF));
	SetPlayerInterior(playerid,0); SetPlayerVirtualWorld(playerid, 0); 

	TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);
	return (true);
}

timer Player_Spawn[2000](playerid)
{
    new rand1spawn = random(sizeof(random_Spawn)),rand2spawn = random(sizeof(random_Spawn_1));

    CancelSelectTextDraw(playerid); SetPlayerInterior(playerid,0); SetPlayerVirtualWorld(playerid, 0);
    TogglePlayerSpectating(playerid, false); Bit_Set(b_Textdraw, playerid, false); Bit_Set(b_Spawned, playerid, true); SetPlayerColor(playerid, (0xFFFFFFFF));

    if(playerid % 2 == 0)
    {
	          SetSpawnInfo(playerid,0, Player_Enum[playerid][p_Skin], random_Spawn[rand1spawn][0], random_Spawn[rand1spawn][1], random_Spawn[rand1spawn][2], random_Spawn[rand1spawn][3], 0,0,0,0,0,0);
	          SpawnPlayer(playerid);
	}
	else
	{
			SetSpawnInfo(playerid,0, Player_Enum[playerid][p_Skin], random_Spawn_1[rand2spawn][0], random_Spawn_1[rand2spawn][1], random_Spawn_1[rand2spawn][2], random_Spawn_1[rand2spawn][3], 0,0,0,0,0,0);
			SpawnPlayer(playerid);
	}	
	TogglePlayerControllable(playerid, false); defer Objects_Load(playerid);
	return (true);
}

//=========================================================//


task VarCount[1000]()
{
	foreach (new i:Player)
    {
		  if(Player_Enum[i][p_Muted] != 0) Player_Enum[i][p_Muted] --;
	}
	return (true);
}

task Random_Messages[5000]()
{
	TextDrawSetString(ServerLogo[3], r_Strings[random(sizeof(r_Strings))]);
	return (true);
}

task Save_Systems[1800000]()
{
	foreach(new i: Player)
	{
		SavePlayer(i);
		SavePlayer_Ownerships(i);
		SavePlayer_Property(i);
		UpdateWeapons(i);
	}
	SCMTA(-1,"{1CAD2F}[DYNAMIC SAVE]{FFFFFF} Dinamicno spremanje imovine i igraca zavrseno.");
	return (true);
}

task Doors_Timer[3000](playerid)
{
	if(nalpovrata == 1)
	{
         MoveDynamicObject(osiguranjevrata, 1295.003,-1862.269,13.680, 1.5);
         nalpovrata = 0;
	}
	return (true);
}

//===============================================================================


Dialog:Show_Only(playerid, response, listitem, inputtext[])
{
	playerid = INVALID_PLAYER_ID;
	response = 0;
	listitem = 0;
	inputtext[0] = '\0';
}

Dialog:Register_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) < 6 || strlen(inputtext) > 14)
			return Dialog_Show(playerid, Register_Dialog, DSP, "{FFFFFF}REGISTRACIJA - KORAK 1", g_Strings[0], "Nastavi", "Odustani");

		PlayerPassword[playerid][0] = '\0';
        SetString(PlayerPassword[playerid],Escape_String(inputtext));

        Dialog_Show(playerid, Email_Dialog, DSI, "{FFFFFF}REGISTRACIJA - KORAK 2", g_Strings[3], "Nastavi", "Odustani");
	}
	else
	{
		PlayerPassword[playerid][0] = '\0';
		RegisterPanel(playerid,1); 
	}
	return (true);
}

Dialog:Email_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
         if(!IsValidEmail(inputtext))
             return Dialog_Show(playerid, Email_Dialog, DSI, "{FFFFFF}REGISTRACIJA - KORAK 2", g_Strings[3], "Nastavi", "Odustani");
         PlayerEmail[playerid][0] = '\0';
         SetString(PlayerEmail[playerid],Escape_String(inputtext));

         Dialog_Show(playerid, Gender_Dialog, DSM, "{FFFFFF}REGISTRACIJA - KORAK 3", g_Strings[4], "MUSKO", "ZENSKO");    
	}
	else
	{
		 PlayerEmail[playerid][0] = '\0';
         RegisterPanel(playerid,1);
	}
	return (true);
}

Dialog:Gender_Dialog(playerid, response, listitem, inputtext[])
{
	new rand = random(sizeof(MaleSkins)),rand1 = random(sizeof(FemaleSkins));
	GetPlayerIp(playerid,PlayerIP,sizeof(PlayerIP));

	if(response)
	{

		 PlayerGender[playerid] = 1;
		 Player_Enum[playerid][p_Gender] = 1;
         Player_Enum[playerid][p_Money] = 1000; GivePlayerMoney(playerid,1000);
         Player_Enum[playerid][p_Level] = 1; SetPlayerScore(playerid,1);
         Player_Enum[playerid][p_Skin] = MaleSkins[rand];

         Set_Prop_Var(playerid);

         CreateAccount(GetName(playerid),PlayerPassword[playerid],PlayerEmail[playerid],PlayerIP,PlayerGender[playerid],Player_Enum[playerid][p_Skin]);

         INFO(playerid,"Uspjesno ste se registrovali na nas server.");
         INFO(playerid,"Ako trebate pomoc u vezi nekog dijela moda obratite se nasem staff teamu.");
         INFO(playerid,"Ugodnu igru zele vam clanovi naseg staff team-a.");

         SetString(Player_Enum[playerid][p_LastLogin],ReturnDate());
         defer Player_Spawn(playerid);
	}
	else
	{
         PlayerGender[playerid] = 2;

         Player_Enum[playerid][p_Gender] = 2;
         Player_Enum[playerid][p_Money] = 1000; GivePlayerMoney(playerid,1000);
         Player_Enum[playerid][p_Level] = 1; SetPlayerScore(playerid,1);
         Player_Enum[playerid][p_Skin] = FemaleSkins[rand1];

         Set_Prop_Var(playerid);

         CreateAccount(GetName(playerid),PlayerPassword[playerid],PlayerEmail[playerid],PlayerIP,PlayerGender[playerid],Player_Enum[playerid][p_Skin]);

         INFO(playerid,"Uspjesno ste se registrovali na nas server.");
         INFO(playerid,"Ako trebate pomoc u vezi nekog dijela moda obratite se nasem staff teamu.");
         INFO(playerid,"Ugodnu igru zele vam clanovi naseg staff team-a.");

         SetString(Player_Enum[playerid][p_LastLogin],ReturnDate());

         defer Player_Spawn(playerid);

	}
	return (true);
}

Dialog:Login_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
              if(!strcmp(Player_Enum[playerid][p_Password], inputtext, false))
    		  {
    		  	   Spawn_Player(playerid);
    		  }
    		  else
    		  {
                   Dialog_Show(playerid, Login_Dialog, DSP, "{FFFFFF}PRIJAVLJIVANJE - KORISNIKA", g_Strings[5], "Nastavi", "Odustani"); 
                   PlayerPokusaji[playerid] ++;
                   GRESKA(playerid,"Lozinka koju ste uneli je pogresna - Preostalo pokusaja:(%d/3).",PlayerPokusaji[playerid]);

                   if(PlayerPokusaji[playerid] == 3)
                   {
                   	   RegisterPanel(playerid,2); defer Kick_Player(playerid);
                   }
                   return (true);
    		  }
	}
	else
	{
         RegisterPanel(playerid,1);
	}
	return (true);
}

//===============================================================================


Dialog:Furniture_Buy_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[150];

		new index = Furniture_Index[playerid],
		id = Business_Inside(playerid),
		price = BIZ_FURNITURE[id][index][Furniture_Price];

		switch(listitem)
		{
			case 0:
			{
				    if(Player_Enum[playerid][p_Property][0] == (9999))
				       return GRESKA(playerid,"Nemate kucu na ovom slotu.");

                    new furniture = Furniture_Add(Player_Enum[playerid][p_Property][0], BIZ_FURNITURE[id][index][Furniture_Name], BIZ_FURNITURE[id][index][Furniture_Model]);
		            
		            if(furniture == -1)
		               return GRESKA(playerid,"Server je dosao u limitirano stanje furniture objekata!");

                    Player_Enum[playerid][p_Money] -= price; GivePlayerMoney(playerid,-price);

					BIZ_FURNITURE[id][index][Furniture_Slots] --;
		            BIZ_ENUM[id][BIZ_PRODUCTS] --;
		            BIZ_ENUM[id][BIZ_MONEY] += Tax_Percent(price);

		            format(query, sizeof(query), "UPDATE `br_business_furniture` SET `Furniture_Slots` = '%d' WHERE `ID` = '%d' AND `Furniture_ID` = '%d'",
			        BIZ_FURNITURE[id][index][Furniture_Slots],BIZ_ENUM[id][BIZ_ID],BIZ_FURNITURE[id][index][Furniture_ID]);
			        mysql_function_query(_dbConnector, query, false, "", "");

					Save_Business(id);

					INFO(playerid,"Uspesno ste kupili furniture:(%s).",BIZ_FURNITURE[id][index][Furniture_Name]);

			}
			case 1:
			{
				    if(Player_Enum[playerid][p_Property][1] == (9999))
				       return GRESKA(playerid,"Nemate kucu na ovom slotu.");

                    new furniture = Furniture_Add(Player_Enum[playerid][p_Property][1], BIZ_FURNITURE[id][index][Furniture_Name], BIZ_FURNITURE[id][index][Furniture_Model]);
		            
		            if(furniture == -1)
		               return GRESKA(playerid,"Server je dosao u limitirano stanje furniture objekata!");

		            Player_Enum[playerid][p_Money] -= price; GivePlayerMoney(playerid,-price);

					BIZ_FURNITURE[id][index][Furniture_Slots] --;
		            BIZ_ENUM[id][BIZ_PRODUCTS] --;
		            BIZ_ENUM[id][BIZ_MONEY] += Tax_Percent(price);

		            format(query, sizeof(query), "UPDATE `br_business_furniture` SET `Furniture_Slots` = '%d' WHERE `ID` = '%d' AND `Furniture_ID` = '%d'",
			        BIZ_FURNITURE[id][index][Furniture_Slots],BIZ_ENUM[id][BIZ_ID],BIZ_FURNITURE[id][index][Furniture_ID]);
			        mysql_function_query(_dbConnector, query, false, "", "");

					Save_Business(id);

					INFO(playerid,"Uspesno ste kupili furniture:(%s).",BIZ_FURNITURE[id][index][Furniture_Name]);
			}
		}
	}
	return (true);
}

//===============================================================================

YCMD:clothes(playerid,params[],help)
{
	Dialog_Show(playerid, Clothes_Selection, DSL,"{E3C334}CLOTHES SELECTION","Watches\nHats\nBandanda\nGlasses","Choose","Cancel");
	return (true);
}

Dialog:Clothes_Selection(playerid, response, listitem, inputtext[])
{
	if(response)
	{
              switch(listitem)
              {
              	       case 0:
              	       {
              	       	      Dialog_Show(playerid, Clothes_Take_Watches, DSI,"{FFFFFF}WATCHES SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas sat.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
              	       }
              	       case 1:
              	       {
                              Dialog_Show(playerid, Clothes_Take_Hats, DSI,"{FFFFFF}HATS SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas sesir.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
              	       }
              	       case 2:
              	       { 
                              Dialog_Show(playerid, Clothes_Take_Bandanda, DSI,"{FFFFFF}BANDANDA SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas bandanda.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
              	       }
              	       case 3:
              	       {
                              Dialog_Show(playerid, Clothes_Take_Glasses, DSI,"{FFFFFF}GLASSES SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vase naocare.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
              	       }
              }
	}
	return (true);
}

Dialog:Clothes_Watches(playerid, response, listitem, inputtext[])
{
	new slot = AccesorySlot[playerid];

	if(response)
	{
           switch(listitem)
           {
               case 0:
               {                  
                        if(IsPlayerAttachedObjectSlotUsed(playerid, 1))
                        {
                        	INFO(playerid,"Uspesno ste skinuli sat sa slota:(%d)",slot);
                        	RemovePlayerAttachedObject(playerid, 1);
                        }
                        else
                        {
                        	SetPlayerAttachedObject(playerid, 1, Player_Enum[playerid][pWatches][slot], 6, AccessoryData[playerid][slot][0], AccessoryData[playerid][slot][1], AccessoryData[playerid][slot][2], AccessoryData[playerid][slot][3], AccessoryData[playerid][slot][4], AccessoryData[playerid][slot][5], AccessoryData[playerid][slot][6], AccessoryData[playerid][slot][7], AccessoryData[playerid][slot][8]);
                            INFO(playerid,"Uspesno ste stavili sat sa slota:(%d)",slot);
                        }   
               }
               case 1:
               {
               	        if(!IsPlayerAttachedObjectSlotUsed(playerid, 1))
               	           return GRESKA(playerid,"Prvo si stavite sat kako bi ga mogli editovati");

               	        EditAttachedObject(playerid, 1);
               	        Editing_Type[playerid] = 1;
               	        Editing_Slot[playerid] = slot;
               	        INFO(playerid,"Poceli ste editovati sat sa slota:(%d)",slot);
               }
               case 2:
               {
               	        RemovePlayerAttachedObject(playerid, 1);
               	        Player_Enum[playerid][pWatches][slot] = 0;
               	        INFO(playerid,"Uspesno ste obrisali sat sa slota:(%d)",slot);
               }
           }
	}
	return (true);
}

Dialog:Clothes_Hats(playerid, response, listitem, inputtext[])
{
	new slot = AccesorySlot[playerid];
	new slotina;

	if(slot == 0) slotina = 3;
	else if(slot == 1) slotina = 4;
	else if(slot == 2) slotina = 5;

	if(response)
	{
           switch(listitem)
           {
               case 0:
               {                  
                        if(IsPlayerAttachedObjectSlotUsed(playerid, 2))
                        {
                        	INFO(playerid,"Uspesno ste skinuli sesir sa slota:(%d)",slot);
                        	RemovePlayerAttachedObject(playerid, 2);
                        }
                        else
                        {
                        	SetPlayerAttachedObject(playerid, 2, Player_Enum[playerid][pHats][slot], 2, AccessoryData[playerid][slotina][0], AccessoryData[playerid][slotina][1], AccessoryData[playerid][slotina][2], AccessoryData[playerid][slotina][3], AccessoryData[playerid][slotina][4], AccessoryData[playerid][slotina][5], AccessoryData[playerid][slotina][6], AccessoryData[playerid][slotina][7], AccessoryData[playerid][slotina][8]);
                            INFO(playerid,"Uspesno ste stavili sesir sa slota:(%d)",slot);
                        }   
               }
               case 1:
               {
               	        if(!IsPlayerAttachedObjectSlotUsed(playerid, 2))
               	           return GRESKA(playerid,"Prvo si stavite sesir kako bi ga mogli editovati");

               	        EditAttachedObject(playerid, 2);
               	        Editing_Type[playerid] = 2;
               	        Editing_Slot[playerid] = slotina;
               	        INFO(playerid,"Poceli ste editovati sat sa slota:(%d)",slot);
               }
               case 2:
               {
               	        RemovePlayerAttachedObject(playerid, 2);
               	        Player_Enum[playerid][pHats][slot] = 0;
               	        INFO(playerid,"Uspesno ste obrisali sesir sa slota:(%d)",slot);
               }
           }
	}
	return (true);
}

Dialog:Clothes_Bandada(playerid, response, listitem, inputtext[])
{
	new slot = AccesorySlot[playerid];
	new slotina;

	if(slot == 0) slotina = 6;
	else if(slot == 1) slotina = 7;
	else if(slot == 2) slotina = 8;

	if(response)
	{
           switch(listitem)
           {
               case 0:
               {                  
                        if(IsPlayerAttachedObjectSlotUsed(playerid, 3))
                        {
                        	INFO(playerid,"Uspesno ste skinuli bandanda sa slota:(%d)",slot);
                        	RemovePlayerAttachedObject(playerid, 3);
                        }
                        else
                        {
                        	SetPlayerAttachedObject(playerid, 3, Player_Enum[playerid][pBandanda][slot], 2, AccessoryData[playerid][slotina][0], AccessoryData[playerid][slotina][1], AccessoryData[playerid][slotina][2], AccessoryData[playerid][slotina][3], AccessoryData[playerid][slotina][4], AccessoryData[playerid][slotina][5], AccessoryData[playerid][slotina][6], AccessoryData[playerid][slotina][7], AccessoryData[playerid][slotina][8]);
                            INFO(playerid,"Uspesno ste stavili bandanda sa slota:(%d)",slot);
                        }   
               }
               case 1:
               {
               	        if(!IsPlayerAttachedObjectSlotUsed(playerid, 3))
               	           return GRESKA(playerid,"Prvo si stavite bandanda kako bi je ga mogli editovati");

               	        EditAttachedObject(playerid, 3);
               	        Editing_Type[playerid] = 3;
               	        Editing_Slot[playerid] = slotina;
               	        INFO(playerid,"Poceli ste editovati bandanda sa slota:(%d)",slot);
               }
               case 2:
               {
               	        RemovePlayerAttachedObject(playerid, 3);
               	        Player_Enum[playerid][pBandanda][slot] = 0;
               	        INFO(playerid,"Uspesno ste obrisali bandanda sa slota:(%d)",slot);
               }
           }
	}
	return (true);
}

Dialog:Clothes_Glasses(playerid, response, listitem, inputtext[])
{
	new slot = AccesorySlot[playerid];
	new slotina;

	if(slot == 0) slotina = 9;
	else if(slot == 1) slotina = 10;
	else if(slot == 2) slotina = 11;

	if(response)
	{
           switch(listitem)
           {
               case 0:
               {                  
                        if(IsPlayerAttachedObjectSlotUsed(playerid, 4))
                        {
                        	INFO(playerid,"Uspesno ste skinuli naocare sa slota:(%d)",slot);
                        	RemovePlayerAttachedObject(playerid, 4);
                        }
                        else
                        {
                        	SetPlayerAttachedObject(playerid, 4, Player_Enum[playerid][pGlasses][slot], 2, AccessoryData[playerid][slotina][0], AccessoryData[playerid][slotina][1], AccessoryData[playerid][slotina][2], AccessoryData[playerid][slotina][3], AccessoryData[playerid][slotina][4], AccessoryData[playerid][slotina][5], AccessoryData[playerid][slotina][6], AccessoryData[playerid][slotina][7], AccessoryData[playerid][slotina][8]);
                            INFO(playerid,"Uspesno ste stavili naocare sa slota:(%d)",slot);
                        }   
               }
               case 1:
               {
               	        if(!IsPlayerAttachedObjectSlotUsed(playerid, 4))
               	           return GRESKA(playerid,"Prvo si stavite naocare kako bi ih mogli editovati");

               	        EditAttachedObject(playerid, 4);
               	        Editing_Type[playerid] = 4;
               	        Editing_Slot[playerid] = slotina;
               	        INFO(playerid,"Poceli ste editovati naocare sa slota:(%d)",slot);
               }
               case 2:
               {
               	        RemovePlayerAttachedObject(playerid, 4);
               	        Player_Enum[playerid][pBandanda][slot] = 0;
               	        INFO(playerid,"Uspesno ste obrisali naocare sa slota:(%d)",slot);
               }
           }
	}
	return (true);
}


Dialog:Clothes_Take_Watches(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           new slot;
           if(sscanf(inputtext,"d",slot))
              return Dialog_Show(playerid, Clothes_Take_Watches, DSI,"{FFFFFF}WATCHES SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas sat.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
           if(slot < 0 || slot > 2)
              return Dialog_Show(playerid, Clothes_Take_Watches, DSI,"{FFFFFF}WATCHES SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas sat.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");

           if(Player_Enum[playerid][pWatches][slot] == 0)
              return GRESKA(playerid,"Uneseni slot je prazan.");

           AccesorySlot[playerid] = slot;

           Dialog_Show(playerid, Clothes_Watches, DSL,"{FFFFFF}WATCHES OPTIONS","{FFFFFF}Use watch\nEdit watch\nDelete watch","Choose","Cancel");
	}
	return (true);
}

Dialog:Clothes_Take_Hats(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           new slot;
           if(sscanf(inputtext,"d",slot))
              return Dialog_Show(playerid, Clothes_Take_Hats, DSI,"{FFFFFF}HATS SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas sesir.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
           if(slot < 0 || slot > 2)
              return Dialog_Show(playerid, Clothes_Take_Hats, DSI,"{FFFFFF}HATS SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas sesir.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");

           if(Player_Enum[playerid][pHats][slot] == 0)
              return GRESKA(playerid,"Uneseni slot je prazan.");

           AccesorySlot[playerid] = slot;

           Dialog_Show(playerid, Clothes_Hats, DSL,"{FFFFFF}HATS OPTIONS","{FFFFFF}Use hat\nEdit hat\nDelete hat","Choose","Cancel");
	}
	return (true);
}

Dialog:Clothes_Take_Bandanda(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           new slot;
           if(sscanf(inputtext,"d",slot))
              return Dialog_Show(playerid, Clothes_Take_Bandanda, DSI,"{FFFFFF}BANDANDA SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas bandanda.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
           if(slot < 0 || slot > 2)
              return Dialog_Show(playerid, Clothes_Take_Bandanda, DSI,"{FFFFFF}BANDANDA SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vas bandanda.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");

           if(Player_Enum[playerid][pBandanda][slot] == 0)
              return GRESKA(playerid,"Uneseni slot je prazan.");

           AccesorySlot[playerid] = slot;

           Dialog_Show(playerid, Clothes_Bandada, DSL,"{FFFFFF}BANDANDA OPTIONS","{FFFFFF}Use bandanda\nEdit bandanda\nDelete bandanda","Choose","Cancel");
	}
	return (true);
}

Dialog:Clothes_Take_Glasses(playerid, response, listitem, inputtext[])
{
	if(response)
	{
           new slot;
           if(sscanf(inputtext,"d",slot))
              return Dialog_Show(playerid, Clothes_Take_Glasses, DSI,"{FFFFFF}GLASSES SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vase naocare.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");
           if(slot < 0 || slot > 2)
              return Dialog_Show(playerid, Clothes_Take_Glasses, DSI,"{FFFFFF}GLASSES SLOT USE","{FFFFFF}Unesite slot na na koji zelite uzeti vase naocare.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");

           if(Player_Enum[playerid][pGlasses][slot] == 0)
              return GRESKA(playerid,"Uneseni slot je prazan.");

           AccesorySlot[playerid] = slot;

           Dialog_Show(playerid, Clothes_Glasses, DSL,"{FFFFFF}GLASSES OPTIONS","{FFFFFF}Use glasses\nEdit glasses\nDelete glasses","Choose","Cancel");
	}
	return (true);
}

//===================================================================

Dialog:Clothes_Buy_Watches(playerid, response, listitem, inputtext[])
{
	new slot;
	new bizid = Business_Inside(playerid);

	if(response)
	{
          if (sscanf(inputtext, "d", slot))
              return Dialog_Show(playerid, Clothes_Buy_Watches, DSI,"{FFFFFF}WATCHES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sat.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");  
          if(slot < 0 || slot > 2)
              return Dialog_Show(playerid, Clothes_Buy_Watches, DSI,"{FFFFFF}WATCHES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sat.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");  

          if(Player_Enum[playerid][pWatches][slot] != 0)
          {
          	   Dialog_Show(playerid, Clothes_Buy_Watches, DSI,"{FFFFFF}WATCHES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sat.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");  
          	   GRESKA(playerid,"Odabrani slot je zauzet pokusajte sa drugim.");
          	   return (true);
          }

          Player_Enum[playerid][p_Money] -= BIZ_ENUM[bizid][BIZ_PRICES][1];
          GivePlayerMoney(playerid,-BIZ_ENUM[bizid][BIZ_PRICES][1]);

          BIZ_ENUM[bizid][BIZ_PRODUCTS] --; 
          BIZ_ENUM[bizid][BIZ_MONEY] += BIZ_ENUM[bizid][BIZ_PRICES][1];
          Save_Business(bizid);

          Editing_Type[playerid] = 1; Editing_Slot[playerid] = slot;
          Player_Enum[playerid][pWatches][slot] = Buy_Model[playerid];

          SetPlayerAttachedObject(playerid, 1, Buy_Model[playerid], 6, 0.000000, 0.004999, 0.004000, -6.399999, -88.900100, -141.399978, 1.000000, 1.000000, 1.000000, 0, 0);
          EditAttachedObject(playerid, 1);     

          INFO(playerid,"Uspesno ste kupili sat na slot:(%d),editujte ga.",slot);
	}
	return (true);
}

Dialog:Clothes_Buy_Hats(playerid, response, listitem, inputtext[])
{
	new slot;
	new slotina;
	new bizid = Business_Inside(playerid);

	if(response)
	{
          if (sscanf(inputtext, "d", slot))
              return Dialog_Show(playerid, Clothes_Buy_Hats, DSI,"{FFFFFF}HATS SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sesir.\n\nSlotovi se krecu od {F51B4A}[3-5]","Input","Cancel");  
          if(slot < 3 || slot > 5)
              return Dialog_Show(playerid, Clothes_Buy_Hats, DSI,"{FFFFFF}HATS SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sesir.\n\nSlotovi se krecu od {F51B4A}[3-5]","Input","Cancel");    

          if(slot == 3) slotina = 0;
          else if(slot == 4) slotina = 1;
          if(slot == 5) slotina = 2;

          if(Player_Enum[playerid][pHats][slotina] != 0)
          {
          	   Dialog_Show(playerid, Clothes_Buy_Hats, DSI,"{FFFFFF}HATS SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas sesir.\n\nSlotovi se krecu od {F51B4A}[3-5]","Input","Cancel");    
          	   GRESKA(playerid,"Odabrani slot je zauzet pokusajte sa drugim.");
          	   return (true);
          }

          Player_Enum[playerid][p_Money] -= BIZ_ENUM[bizid][BIZ_PRICES][1];
          GivePlayerMoney(playerid,-BIZ_ENUM[bizid][BIZ_PRICES][1]);

          BIZ_ENUM[bizid][BIZ_PRODUCTS] --; 
          BIZ_ENUM[bizid][BIZ_MONEY] += BIZ_ENUM[bizid][BIZ_PRICES][1];
          Save_Business(bizid);

          Editing_Type[playerid] = 2; Editing_Slot[playerid] = slot; Player_Editing[playerid] = slotina;
          Player_Enum[playerid][pHats][slotina] = Buy_Model[playerid];

          SetPlayerAttachedObject(playerid, 2, Buy_Model[playerid], 2, 0.1565, 0.0273, -0.0002, -7.9245, -1.3224, 15.0999);
          EditAttachedObject(playerid, 2);     

          INFO(playerid,"Uspesno ste kupili sesir na slot:(%d),editujte ga.",slotina);
	}
	return (true);
}

Dialog:Clothes_Buy_Bandanda(playerid, response, listitem, inputtext[])
{
	new slot;
	new slotina;
	new bizid = Business_Inside(playerid);

	if(response)
	{
          if (sscanf(inputtext, "d", slot))
              return Dialog_Show(playerid, Clothes_Buy_Bandanda, DSI,"{FFFFFF}BANDANDA SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas bandanda.\n\nSlotovi se krecu od {F51B4A}[6-8]","Input","Cancel");  
          if(slot < 6 || slot > 8)
              return Dialog_Show(playerid, Clothes_Buy_Bandanda, DSI,"{FFFFFF}BANDANDA SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas bandanda.\n\nSlotovi se krecu od {F51B4A}[6-8]","Input","Cancel");     
     
          if(slot == 6) slotina = 0;
          else if(slot == 7) slotina = 1;
          if(slot == 8) slotina = 2;

          if(Player_Enum[playerid][pBandanda][slotina] != 0)
          {
          	   Dialog_Show(playerid, Clothes_Buy_Bandanda, DSI,"{FFFFFF}BANDANDA SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vas bandanda.\n\nSlotovi se krecu od {F51B4A}[6-8]","Input","Cancel");      
          	   GRESKA(playerid,"Odabrani slot je zauzet pokusajte sa drugim.");
          	   return (true);
          }

          Player_Enum[playerid][p_Money] -= BIZ_ENUM[bizid][BIZ_PRICES][1];
          GivePlayerMoney(playerid,-BIZ_ENUM[bizid][BIZ_PRICES][1]);

          BIZ_ENUM[bizid][BIZ_PRODUCTS] --; 
          BIZ_ENUM[bizid][BIZ_MONEY] += BIZ_ENUM[bizid][BIZ_PRICES][1];
          Save_Business(bizid);

          Editing_Type[playerid] = 3; Editing_Slot[playerid] = slot; Player_Editing[playerid] = slotina;
          Player_Enum[playerid][pBandanda][slotina] = Buy_Model[playerid];

          SetPlayerAttachedObject(playerid, 3, Buy_Model[playerid], 2, 0.099553, 0.044356, -0.000285, 89.675476, 84.277572, 0.000000);
          EditAttachedObject(playerid, 3);     

          INFO(playerid,"Uspesno ste kupili bandanda na slot:(%d),editujte ga.",slotina);
	}
	return (true);
}

Dialog:Clothes_Buy_Glasses(playerid, response, listitem, inputtext[])
{
	new slot;
	new slotina;
	new bizid = Business_Inside(playerid);

	if(response)
	{
          if (sscanf(inputtext, "d", slot))
              return Dialog_Show(playerid, Clothes_Buy_Glasses, DSI,"{FFFFFF}GLASSES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vase naocare.\n\nSlotovi se krecu od {F51B4A}[9-11]","Input","Cancel");  
          if(slot < 9 || slot > 11)
              return Dialog_Show(playerid, Clothes_Buy_Glasses, DSI,"{FFFFFF}GLASSES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vase naocare.\n\nSlotovi se krecu od {F51B4A}[9-11]","Input","Cancel");     

          if(slot == 9) slotina = 0;
          else if(slot == 10) slotina = 1;
          if(slot == 11) slotina = 2;

          if(Player_Enum[playerid][pGlasses][slotina] != 0)
          {
          	   Dialog_Show(playerid, Clothes_Buy_Glasses, DSI,"{FFFFFF}GLASSES SLOT","{FFFFFF}Unesite slot na na koji zelite sacuvate vase naocare.\n\nSlotovi se krecu od {F51B4A}[0-2]","Input","Cancel");      
          	   GRESKA(playerid,"Odabrani slot je zauzet pokusajte sa drugim.");
          	   return (true);
          }

          Player_Enum[playerid][p_Money] -= BIZ_ENUM[bizid][BIZ_PRICES][1];
          GivePlayerMoney(playerid,-BIZ_ENUM[bizid][BIZ_PRICES][1]);

          BIZ_ENUM[bizid][BIZ_PRODUCTS] --; 
          BIZ_ENUM[bizid][BIZ_MONEY] += BIZ_ENUM[bizid][BIZ_PRICES][1];
          Save_Business(bizid);

          Editing_Type[playerid] = 4; Editing_Slot[playerid] = slot; Player_Editing[playerid] = slotina;
          Player_Enum[playerid][pGlasses][slotina] = Buy_Model[playerid];

          SetPlayerAttachedObject(playerid, 4, Buy_Model[playerid], 2, 0.099553, 0.044356, -0.000285, 89.675476, 84.277572, 0.000000);
          EditAttachedObject(playerid, 4);     

          INFO(playerid,"Uspesno ste kupili naocare na slot:(%d),editujte ih.",slotina);
	}
	return (true);
}

//===============================================================================

function OnPlayerBanCheck(playerid)
{
	new rows,fields;
    cache_get_data(rows,fields);

    if(rows)
    {
	       static datum[36],razlog[30],username[24],banner[24];
	       cache_get_field_content(0, "User", username);
	       cache_get_field_content(0, "BanovanOd", banner);
		   cache_get_field_content(0, "Razlog", razlog);
		   cache_get_field_content(0, "Datum", datum);

		   if (!strcmp(username, "NULL", true) || !username[0])
	       {
	       	 PlayerBan(PlayerIP,banner,username,razlog);
		     BanString(playerid,username,banner,razlog);

		     BanTextdraws(playerid,1);
		     defer Ban_Kick(playerid); 
	       }
	       else
	       {
	       	 PlayerBan(PlayerIP,banner,username,razlog);
		     BanString(playerid,username,banner,razlog);

		     BanTextdraws(playerid,1);
		     defer Ban_Kick(playerid);
	       }
    }
    else
    {
    	    static string[100];
		    format(string, sizeof(string), "SELECT * FROM `br_users` WHERE `Player_Name` = '%s' LIMIT 0,1", Escape_String(GetName(playerid)));
		    mysql_function_query(_dbConnector, string, true, "CheckPlayerAccount", "i", playerid); string = "\0";
    }
	return (true);
}

function CheckPlayerAccount(playerid)
{
    new rows, fields; static var_load[20],string[400];
    cache_get_data(rows,fields);

    if(!rows)
    {
           PlayerTextDrawSetPreviewModel(playerid, Register_TD[20][playerid], (100000005564494949949));
	       PlayerTextDrawSetString(playerid,Register_TD[18][playerid], ("0000000$"));
	       PlayerTextDrawColor(playerid,Register_TD[5][playerid], (0xAA3333AA));
	       PlayerTextDrawSetString(playerid,Register_TD[17][playerid], GetName(playerid));
           RegisterPanel(playerid,1); Bit_Set(b_Enabled, playerid, false); Bit_Set(b_Textdraw, playerid, true);
    }
	else
	{
		   cache_get_field_content(0, "Player_Money", var_load); Player_Enum[playerid][p_Money] = strval(var_load); GivePlayerMoney(playerid,Player_Enum[playerid][p_Money]);
		   cache_get_field_content(0, "Player_Skin", var_load);  Player_Enum[playerid][p_Skin]  = strval(var_load); SetPlayerSkin(playerid,Player_Enum[playerid][p_Skin]);
		   cache_get_field_content(0, "Player_Level", var_load); Player_Enum[playerid][p_Level] = strval(var_load); SetPlayerScore(playerid,Player_Enum[playerid][p_Level]);
		   cache_get_field_content(0, "Player_Admin", var_load); Player_Enum[playerid][p_Admin] = strval(var_load);
		   cache_get_field_content(0, "Player_Gamemaster", var_load); Player_Enum[playerid][p_Gamemaster] = strval(var_load);
		   cache_get_field_content(0, "Player_StaffKod", var_load); Player_Enum[playerid][p_StaffKod] = strval(var_load);
		   cache_get_field_content(0, "Player_Warns", var_load); Player_Enum[playerid][p_Warns] = strval(var_load);
		   cache_get_field_content(0, "Player_Muted", var_load); Player_Enum[playerid][p_Muted] = strval(var_load);
		   cache_get_field_content(0, "Player_Business_Job", var_load); Player_Enum[playerid][p_Business_Job] = strval(var_load);
		   cache_get_field_content(0, "Player_Gender", var_load); Player_Enum[playerid][p_Gender] = strval(var_load);

           cache_get_field_content(0, "Player_Vehicle1", var_load); Player_Enum[playerid][p_Vehicles][0] = strval(var_load); 
           cache_get_field_content(0, "Player_Vehicle2", var_load); Player_Enum[playerid][p_Vehicles][1] = strval(var_load); 
           cache_get_field_content(0, "Player_Vehicle3", var_load); Player_Enum[playerid][p_Vehicles][2] = strval(var_load);
           cache_get_field_content(0, "Player_Vehicle4", var_load); Player_Enum[playerid][p_Vehicles][3] = strval(var_load);

           cache_get_field_content(0, "Player_Bike1", var_load); Player_Enum[playerid][p_Bikes][0] = strval(var_load); 
           cache_get_field_content(0, "Player_Bike2", var_load); Player_Enum[playerid][p_Bikes][1] = strval(var_load); 
           cache_get_field_content(0, "Player_Bike3", var_load); Player_Enum[playerid][p_Bikes][2] = strval(var_load); 
           cache_get_field_content(0, "Player_Bike4", var_load); Player_Enum[playerid][p_Bikes][3] = strval(var_load);

           cache_get_field_content(0, "Player_Property1", var_load); Player_Enum[playerid][p_Property][0] = strval(var_load); 
           cache_get_field_content(0, "Player_Property2", var_load); Player_Enum[playerid][p_Property][1] = strval(var_load); 
           cache_get_field_content(0, "Player_Property3", var_load); Player_Enum[playerid][p_Property][2] = strval(var_load); 
           cache_get_field_content(0, "Player_Property4", var_load); Player_Enum[playerid][p_Property][3] = strval(var_load);
           cache_get_field_content(0, "Player_Property_Rent", var_load); Player_Enum[playerid][p_Property_Rent] = strval(var_load);

           cache_get_field_content(0, "Watch1Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][0][0], AccessoryData[playerid][0][1], AccessoryData[playerid][0][2], AccessoryData[playerid][0][3], AccessoryData[playerid][0][4], AccessoryData[playerid][0][5], AccessoryData[playerid][0][6], AccessoryData[playerid][0][7], AccessoryData[playerid][0][8]);
           cache_get_field_content(0, "Watch2Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][1][0], AccessoryData[playerid][1][1], AccessoryData[playerid][1][2], AccessoryData[playerid][1][3], AccessoryData[playerid][1][4], AccessoryData[playerid][1][5], AccessoryData[playerid][1][6], AccessoryData[playerid][1][7], AccessoryData[playerid][1][8]);
           cache_get_field_content(0, "Watch3Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][2][0], AccessoryData[playerid][2][1], AccessoryData[playerid][2][2], AccessoryData[playerid][2][3], AccessoryData[playerid][2][4], AccessoryData[playerid][2][5], AccessoryData[playerid][2][6], AccessoryData[playerid][2][7], AccessoryData[playerid][2][8]);

           cache_get_field_content(0, "Hat1Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][3][0], AccessoryData[playerid][3][1], AccessoryData[playerid][3][2], AccessoryData[playerid][3][3], AccessoryData[playerid][3][4], AccessoryData[playerid][3][5], AccessoryData[playerid][3][6], AccessoryData[playerid][3][7], AccessoryData[playerid][3][8]);
           cache_get_field_content(0, "Hat2Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][4][0], AccessoryData[playerid][4][1], AccessoryData[playerid][4][2], AccessoryData[playerid][4][3], AccessoryData[playerid][4][4], AccessoryData[playerid][4][5], AccessoryData[playerid][4][6], AccessoryData[playerid][4][7], AccessoryData[playerid][4][8]);
           cache_get_field_content(0, "Hat3Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][5][0], AccessoryData[playerid][5][1], AccessoryData[playerid][5][2], AccessoryData[playerid][5][3], AccessoryData[playerid][5][4], AccessoryData[playerid][5][5], AccessoryData[playerid][5][6], AccessoryData[playerid][5][7], AccessoryData[playerid][5][8]);

           cache_get_field_content(0, "Bandanda1Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][6][0], AccessoryData[playerid][6][1], AccessoryData[playerid][6][2], AccessoryData[playerid][6][3], AccessoryData[playerid][6][4], AccessoryData[playerid][6][5], AccessoryData[playerid][6][6], AccessoryData[playerid][6][7], AccessoryData[playerid][6][8]);
           cache_get_field_content(0, "Bandanda2Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][7][0], AccessoryData[playerid][7][1], AccessoryData[playerid][7][2], AccessoryData[playerid][7][3], AccessoryData[playerid][7][4], AccessoryData[playerid][7][5], AccessoryData[playerid][7][6], AccessoryData[playerid][7][7], AccessoryData[playerid][7][8]);
           cache_get_field_content(0, "Bandanda3Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][8][0], AccessoryData[playerid][8][1], AccessoryData[playerid][8][2], AccessoryData[playerid][8][3], AccessoryData[playerid][8][4], AccessoryData[playerid][8][5], AccessoryData[playerid][8][6], AccessoryData[playerid][8][7], AccessoryData[playerid][8][8]);

           cache_get_field_content(0, "Glasses1Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][9][0], AccessoryData[playerid][9][1], AccessoryData[playerid][9][2], AccessoryData[playerid][9][3], AccessoryData[playerid][9][4], AccessoryData[playerid][9][5], AccessoryData[playerid][9][6], AccessoryData[playerid][9][7], AccessoryData[playerid][9][8]);
           cache_get_field_content(0, "Glasses2Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][10][0], AccessoryData[playerid][10][1], AccessoryData[playerid][10][2], AccessoryData[playerid][10][3], AccessoryData[playerid][10][4], AccessoryData[playerid][10][5], AccessoryData[playerid][10][6], AccessoryData[playerid][10][7], AccessoryData[playerid][10][8]);
           cache_get_field_content(0, "Glasses3Pos", string, _dbConnector);
           sscanf(string, "p<|>fffffffff", AccessoryData[playerid][11][0], AccessoryData[playerid][11][1], AccessoryData[playerid][11][2], AccessoryData[playerid][11][3], AccessoryData[playerid][11][4], AccessoryData[playerid][11][5], AccessoryData[playerid][11][6], AccessoryData[playerid][11][7], AccessoryData[playerid][11][8]);

           for(new i = 0; i<3; i++){
	           format(string, sizeof(string), "Watch%dPos", i + 1);
			   Player_Enum[playerid][pWatches][i] = cache_get_field_kurac(0, string);
			   format(string, sizeof(string), "Hat%dPos", i + 1);
			   Player_Enum[playerid][pHats][i] = cache_get_field_kurac(0, string);
			   format(string, sizeof(string), "Bandanda%dPos", i + 1);
			   Player_Enum[playerid][pBandanda][i] = cache_get_field_kurac(0, string);
	           format(string, sizeof(string), "Glasses%dPos", i + 1);
			   Player_Enum[playerid][pGlasses][i] = cache_get_field_kurac(0, string);
           }

           for (new i = 0; i < 13; i ++) {
		   format(string, sizeof(string), "Gun%d", i + 1);
		   Player_Enum[playerid][pGuns][i] = cache_get_field_kurac(0, string);

		   format(string, sizeof(string), "Ammo%d", i + 1);
		   Player_Enum[playerid][pAmmo][i] = cache_get_field_kurac(0, string);
		   }  

		   cache_get_field_content(0, "Login_Date", Player_Enum[playerid][p_LastLogin], _dbConnector);
		   cache_get_field_content(0, "Player_Password", Player_Enum[playerid][p_Password], _dbConnector);
		   cache_get_field_content(0, "Player_Name", Player_Enum[playerid][p_Name], _dbConnector);

		   PlayerTextDrawSetPreviewModel(playerid, Register_TD[20][playerid], Player_Enum[playerid][p_Skin]);
		   PlayerTextDrawSetString(playerid,Register_TD[18][playerid], FormatNumber(Player_Enum[playerid][p_Money]));
		   PlayerTextDrawColor(playerid,Register_TD[2][playerid], (0xAA3333AA));
		   PlayerTextDrawSetString(playerid,Register_TD[17][playerid], GetName(playerid));
		   RegisterPanel(playerid,1);  Bit_Set(b_Enabled, playerid, true); Bit_Set(b_Textdraw, playerid, true);

		   format(string, sizeof(string), "SELECT * FROM `br_inventory` WHERE `invOwner` = '%s'",Escape_String(GetName(playerid)));
           mysql_function_query(_dbConnector, string, true, "OnPlayerInventoryLoad", "i", playerid); string = "\0";
	}
	return (true);
}

//===============================================================================

stock CreateAccount(User[],Password[],Mail[],IP[],Gender,Skin)
{
	static query[350];
	format(query, sizeof(query), "INSERT INTO `br_users` (Player_Name, Player_Password, Player_Mail, Player_IP, Player_Gender, Player_Skin, Register_Date, Login_Date, Player_Money, Player_Level) VALUES('%s', '%s', '%s', '%s', %d, %d, '%s', '%s', 1000, 1)",
	Escape_String(User),Escape_String(Password),Escape_String(Mail),Escape_String(IP),Gender,Skin,ReturnDate(),ReturnDate());
	mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";
	return (true);
}

stock CharacterRemove(username[])
{
    static string[50];
    format(string, sizeof(string), "DELETE FROM `br_users` WHERE `Player_Name` = '%s'", Escape_String(username));
    mysql_function_query(_dbConnector, string, false, "", ""); string = "\0";
	return (true);
}

stock SavePlayer(playerid)
{
	static query[2300];

	format(query,sizeof(query), "UPDATE `br_users` SET  `Player_Level` = '%d', `Player_Money` = '%d', `Player_Skin` = '%d', `Player_Admin` = '%d', `Player_Gamemaster` = '%d', `Player_StaffKod` = '%d', `Player_Warns` = '%d', `Player_Muted` = '%d', `Player_Business_Job` = '%d'",
	Player_Enum[playerid][p_Level],
	Player_Enum[playerid][p_Money],
	Player_Enum[playerid][p_Skin],
	Player_Enum[playerid][p_Admin],
	Player_Enum[playerid][p_Gamemaster],
	Player_Enum[playerid][p_StaffKod],
	Player_Enum[playerid][p_Warns],
	Player_Enum[playerid][p_Muted],
	Player_Enum[playerid][p_Business_Job]);
	format(query,sizeof(query),"%s, `Player_Vehicle1` = '%d', `Player_Vehicle2` = '%d', `Player_Vehicle3` = '%d', `Player_Vehicle4` = '%d', `Player_Bike1` = '%d', `Player_Bike2` = '%d', `Player_Bike3` = '%d', `Player_Bike4` = '%d'",
	query,
	Player_Enum[playerid][p_Vehicles][0],
	Player_Enum[playerid][p_Vehicles][1],
	Player_Enum[playerid][p_Vehicles][2],
	Player_Enum[playerid][p_Vehicles][3],
	Player_Enum[playerid][p_Bikes][0],
	Player_Enum[playerid][p_Bikes][1],
	Player_Enum[playerid][p_Bikes][2],
	Player_Enum[playerid][p_Bikes][3]);
	for (new i = 0; i < 13; i ++) {
		format(query, sizeof(query), "%s, `Gun%d` = '%d', `Ammo%d` = '%d'", query, i + 1, Player_Enum[playerid][pGuns][i], i + 1, Player_Enum[playerid][pAmmo][i]);
	}
	format(query,sizeof(query),"%s, `Player_Property1` = '%d', `Player_Property2` = '%d', `Player_Property3` = '%d', `Player_Property4` = '%d', `Player_Property_Rent` = '%d' WHERE `Player_Name` = '%s'",
	query,
	Player_Enum[playerid][p_Property][0],
	Player_Enum[playerid][p_Property][1],
	Player_Enum[playerid][p_Property][2],
	Player_Enum[playerid][p_Property][3],
	Player_Enum[playerid][p_Property_Rent],GetName(playerid));
    mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";

    SavePlayer_Ownerships(playerid);
    SavePlayer_Property(playerid);
    SavePlayer_Accessories(playerid);
	return (true);
}

stock SavePlayer_Accessories(playerid)
{
	static query[3000];

	format(query,sizeof(query), "UPDATE `br_users` SET `PlayerWatch1` = '%d', `PlayerWatch2` = '%d', `PlayerWatch3` = '%d', `PlayerHat1` = '%d', `PlayerHat2` = '%d', `PlayerHat3` = '%d'",
	Player_Enum[playerid][pWatches][0],Player_Enum[playerid][pWatches][1],Player_Enum[playerid][pWatches][2],Player_Enum[playerid][pHats][0],Player_Enum[playerid][pHats][1],Player_Enum[playerid][pHats][2]);
	
	format(query, sizeof(query), "%s,`PlayerBandanda1` = '%d', `PlayerBandanda2` = '%d', `PlayerBandanda3` = '%d', `PlayerGlasses1` = '%d', `PlayerGlasses2` = '%d', `PlayerGlasses3` = '%d'",
	query,Player_Enum[playerid][pBandanda][0],Player_Enum[playerid][pBandanda][1],Player_Enum[playerid][pBandanda][2],Player_Enum[playerid][pGlasses][0],Player_Enum[playerid][pGlasses][1],Player_Enum[playerid][pGlasses][2]);

    format(query, sizeof(query), "%s, `Watch1Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f', `Watch2Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
    query,
    AccessoryData[playerid][0][0],
    AccessoryData[playerid][0][1],
    AccessoryData[playerid][0][2],
    AccessoryData[playerid][0][3],
    AccessoryData[playerid][0][4],
    AccessoryData[playerid][0][5],
    AccessoryData[playerid][0][6],
    AccessoryData[playerid][0][7],
    AccessoryData[playerid][0][8],
    AccessoryData[playerid][1][0],
    AccessoryData[playerid][1][1],
    AccessoryData[playerid][1][2],
    AccessoryData[playerid][1][3],
    AccessoryData[playerid][1][4],
    AccessoryData[playerid][1][5],
    AccessoryData[playerid][1][6],
    AccessoryData[playerid][1][7],
    AccessoryData[playerid][1][8]);

    format(query, sizeof(query), "%s, `Watch3Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f', `Hat1Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
    query,
    AccessoryData[playerid][2][0],
    AccessoryData[playerid][2][1],
    AccessoryData[playerid][2][2],
    AccessoryData[playerid][2][3],
    AccessoryData[playerid][2][4],
    AccessoryData[playerid][2][5],
    AccessoryData[playerid][2][6],
    AccessoryData[playerid][2][7],
    AccessoryData[playerid][2][8],
    AccessoryData[playerid][3][0],
    AccessoryData[playerid][3][1],
    AccessoryData[playerid][3][2],
    AccessoryData[playerid][3][3],
    AccessoryData[playerid][3][4],
    AccessoryData[playerid][3][5],
    AccessoryData[playerid][3][6],
    AccessoryData[playerid][3][7],
    AccessoryData[playerid][3][8]); 

    format(query, sizeof(query), "%s, `Hat2Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f', `Hat3Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
    query,
    AccessoryData[playerid][4][0],
    AccessoryData[playerid][4][1],
    AccessoryData[playerid][4][2],
    AccessoryData[playerid][4][3],
    AccessoryData[playerid][4][4],
    AccessoryData[playerid][4][5],
    AccessoryData[playerid][4][6],
    AccessoryData[playerid][4][7],
    AccessoryData[playerid][4][8],
    AccessoryData[playerid][5][0],
    AccessoryData[playerid][5][1],
    AccessoryData[playerid][5][2],
    AccessoryData[playerid][5][3],
    AccessoryData[playerid][5][4],
    AccessoryData[playerid][5][5],
    AccessoryData[playerid][5][6],
    AccessoryData[playerid][5][7],
    AccessoryData[playerid][5][8]);

    format(query, sizeof(query), "%s, `Bandanda1Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f', `Bandanda2Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
    query,
    AccessoryData[playerid][6][0],
    AccessoryData[playerid][6][1],
    AccessoryData[playerid][6][2],
    AccessoryData[playerid][6][3],
    AccessoryData[playerid][6][4],
    AccessoryData[playerid][6][5],
    AccessoryData[playerid][6][6],
    AccessoryData[playerid][6][7],
    AccessoryData[playerid][6][8],
    AccessoryData[playerid][7][0],
    AccessoryData[playerid][7][1],
    AccessoryData[playerid][7][2],
    AccessoryData[playerid][7][3],
    AccessoryData[playerid][7][4],
    AccessoryData[playerid][7][5],
    AccessoryData[playerid][7][6],
    AccessoryData[playerid][7][7],
    AccessoryData[playerid][7][8]);

    format(query, sizeof(query), "%s, `Bandanda3Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f', `Glasses1Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",	
    query,
    AccessoryData[playerid][8][0],
    AccessoryData[playerid][8][1],
    AccessoryData[playerid][8][2],
    AccessoryData[playerid][8][3],
    AccessoryData[playerid][8][4],
    AccessoryData[playerid][8][5],
    AccessoryData[playerid][8][6],
    AccessoryData[playerid][8][7],
    AccessoryData[playerid][8][8],
    AccessoryData[playerid][9][0],
    AccessoryData[playerid][9][1],
    AccessoryData[playerid][9][2],
    AccessoryData[playerid][9][3],
    AccessoryData[playerid][9][4],
    AccessoryData[playerid][9][5],
    AccessoryData[playerid][9][6],
    AccessoryData[playerid][9][7],
    AccessoryData[playerid][9][8]);

    format(query, sizeof(query), "%s, `Glasses2Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f', `Glasses3Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f' WHERE `Player_Name` = '%s'",
    query,
    AccessoryData[playerid][10][0],
    AccessoryData[playerid][10][1],
    AccessoryData[playerid][10][2],
    AccessoryData[playerid][10][3],
    AccessoryData[playerid][10][4],
    AccessoryData[playerid][10][5],
    AccessoryData[playerid][10][6],
    AccessoryData[playerid][10][7],
    AccessoryData[playerid][10][8],
    AccessoryData[playerid][11][0],
    AccessoryData[playerid][11][1],
    AccessoryData[playerid][11][2],
    AccessoryData[playerid][11][3],
    AccessoryData[playerid][11][4],
    AccessoryData[playerid][11][5],
    AccessoryData[playerid][11][6],
    AccessoryData[playerid][11][7],
    AccessoryData[playerid][11][8],GetName(playerid));  
    mysql_function_query(_dbConnector, query, false, "", ""); query = "\0";
    return (true);	
}

stock Set_Prop_Var(playerid)
{
	Player_Enum[playerid][p_Vehicles][0] = 9999;
 	Player_Enum[playerid][p_Vehicles][1] = 9999;
 	Player_Enum[playerid][p_Vehicles][2] = 9999;
 	Player_Enum[playerid][p_Vehicles][3] = 9999;

	Player_Enum[playerid][p_Bikes][0] = 9999;
	Player_Enum[playerid][p_Bikes][1] = 9999;
	Player_Enum[playerid][p_Bikes][2] = 9999;
	Player_Enum[playerid][p_Bikes][3] = 9999;

	Player_Enum[playerid][p_Property][0] = 9999;
	Player_Enum[playerid][p_Property][1] = 9999;
	Player_Enum[playerid][p_Property][2] = 9999;
	Player_Enum[playerid][p_Property][3] = 9999;
	Player_Enum[playerid][p_Property_Rent] = 9999;

	// za Business job
	Player_Enum[playerid][p_Business_Job] = 9999;
	return (true);
}

//===============================================================================

function OnPlayerInventoryLoad(playerid)
{
   new rows,fields,temp[30]; cache_get_data(rows, fields);
   static name[32];
   if(rows)
   {
           for (new i = 0; i < rows && i < MAX_INVENTORY; i ++)
		   {
                    InventoryData[playerid][i][invExists] = 1;
				    cache_get_field_content(i, "invModel", temp); InventoryData[playerid][i][invModel] = strval(temp);
				    cache_get_field_content(i, "invQuantity", temp); InventoryData[playerid][i][invQuantity] = strval(temp);
	                cache_get_field_content(i, "invItem", name, _dbConnector);
	                strpack(InventoryData[playerid][i][invItem], name, 32 char);
		   }
   }
   return (true);
}


//===============================================================================

stock SavePlayer_Ownerships(playerid)
{
    if(Player_Enum[playerid][p_Vehicles][0] != 9999) Save_Vehicle(Player_Enum[playerid][p_Vehicles][0]);
    else if(Player_Enum[playerid][p_Vehicles][1] != 9999) Save_Vehicle(Player_Enum[playerid][p_Vehicles][1]);
    else if(Player_Enum[playerid][p_Vehicles][2] != 9999) Save_Vehicle(Player_Enum[playerid][p_Vehicles][2]);
    else if(Player_Enum[playerid][p_Vehicles][3] != 9999) Save_Vehicle(Player_Enum[playerid][p_Vehicles][3]);

    if(Player_Enum[playerid][p_Bikes][0] != 9999) Save_Bike(Player_Enum[playerid][p_Bikes][0]);
    else if(Player_Enum[playerid][p_Bikes][1] != 9999) Save_Bike(Player_Enum[playerid][p_Bikes][1]);
    else if(Player_Enum[playerid][p_Bikes][2] != 9999) Save_Bike(Player_Enum[playerid][p_Bikes][2]);
    else if(Player_Enum[playerid][p_Bikes][3] != 9999) Save_Bike(Player_Enum[playerid][p_Bikes][3]);
    return (true);
}

stock SavePlayer_Property(playerid)
{
	if(Player_Enum[playerid][p_Property][0] != 9999) Save_House(Player_Enum[playerid][p_Property][0]);
	else if(Player_Enum[playerid][p_Property][1] != 9999) Save_House(Player_Enum[playerid][p_Property][1]);
	if(Player_Enum[playerid][p_Property][2] != 9999) Save_Business(Player_Enum[playerid][p_Property][2]);
	else if(Player_Enum[playerid][p_Property][3] != 9999) Save_Business(Player_Enum[playerid][p_Property][3]);
	return (true);
}    

//===============================================================================

stock Mysql_Connect()
{
	_dbConnector = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	if (mysql_ping(_dbConnector) < 1)
	   return printf("Konekcija sa (%s) bazom nije uspostavljena.\a",MYSQL_HOST);
	else
	   return printf("Konekcija sa (%s) bazom uspjesno uspostavljena.\a",MYSQL_HOST);
}

stock LoadTables()
{
	mysql_function_query(_dbConnector, "SELECT * FROM `br_entrance`", true, "Load_Entrance", "");
	mysql_function_query(_dbConnector, "SELECT * FROM `br_cowner`", true, "Load_Vehicles", "");
	mysql_function_query(_dbConnector, "SELECT * FROM `br_bowner`", true, "Load_Bikes", "");

	mysql_function_query(_dbConnector, "SELECT * FROM `br_houses`", true, "Load_Houses", "");
	mysql_function_query(_dbConnector, "SELECT * FROM `br_businesses`", true, "Load_Businesses", "");

	mysql_function_query(_dbConnector, "SELECT * FROM `br_inventory_drop`", true, "Load_dropped_items", "");
	return (true);
}

//===============================================================================

stock CreatePickupLabel()
{
	// autosalon pickup/labels
	CreateDynamic3DTextLabel("{A7D93B}Autosalon\nKako bi otvorili katalog pritisnite {FFFFFF}'H'", -1, 1365.9000,-1765.2555,13.5689, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	CreateDynamicPickup(1239, 1, 1365.9000,-1765.2555,13.5689, 0);
	// motosalon pickup/labels
	CreateDynamic3DTextLabel("{A7D93B}Motosalon\nKako bi otvorili katalog pritisnite {FFFFFF}'H'", -1, 2016.0305,-1879.5741,13.5859, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	CreateDynamicPickup(1239, 1, 2016.0305,-1879.5741,13.5859, 0);
	// naplo osiguranje
	CreateDynamic3DTextLabel("{A7D93B}Osiguravajuca Kuca\nKako bi ste osigurali svoje vozilo kucajte {FFFFFF}'/takeinsurance'", -1, 1296.8451,-1870.9634,13.5659, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	CreateDynamicPickup(1239, 1, 1296.8451,-1870.9634,13.5659, 0);
	// uzimanje kalauza
	CreateDynamic3DTextLabel("{A7D93B}Off storage\nKako bi ste kupili dostupne stvari kucajte {FFFFFF}'/storagebuy'", -1, 1296.9827,-990.8821,32.6953, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	CreateDynamicPickup(1239, 1, 1296.9827,-990.8821,32.6953, 0);
	return (true);
}

//===============================================================================

stock cache_get_field_kurac(row, const field_name[])
{
	static
	    strinss[12];

	cache_get_field_content(row, field_name, strinss, _dbConnector);
	return strval(strinss);
}

function Float:cache_get_field_kurton(row, const field_name[])
{
	static
	    str[25];

	cache_get_field_content(row, field_name, str, _dbConnector);
	return floatstr(str);
}

//===============================================================================

stock Escape_String(const string[])
{
	static
	    entry[256];

	mysql_real_escape_string(string, entry, _dbConnector);
	return (entry);
}

stock GetName(playerid)
{
    new
	    name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return (name);
}

stock SetString(obj[], string[])
{
    strmid(obj, string, 0, strlen(string), 255);
    return (true);
}

stock ReturnDate()
{
	static
	    date[36];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d", date[0], date[1], date[2], date[3], date[4]);
	return date;
}

stock FormatNumber(number, prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return (value);
}

stock GetPlayerIdFromName(playername[])
{
	foreach(new i : Player)
	{
		if(strcmp(GetName(i), playername, false, strlen(playername)) == 0)
			return i;
	}
  	return INVALID_PLAYER_ID;
}

stock GetElapsedTime(time, &hours, &minutes, &seconds)
{
	hours = 0;
	minutes = 0;
	seconds = 0;

	if (time >= 3600)
	{
		hours = (time / 3600);
		time -= (hours * 3600);
	}
	while (time >= 60)
	{
	    minutes++;
	    time -= 60;
	}
	return (seconds = time);
}

stock IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return (false);
	}
	return (true);
}

stock IsAnIP(str[])
{
	if (!str[0] || str[0] == '\1')
		return (false);

	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if ((str[i] < '0' || str[i] > '9') && str[i] != '.')
	        return (false);

	    if (0 < ((i == 0) ? (strval(str)) : (strval(str[i + 1]))) > 255)
	        return (false);
	}
	return (true);
}

stock PreloadAnimations(playerid)
{
	for (new i = 0; i < sizeof(g_Preload_Anims); i ++)
	{
	    ApplyAnimation(playerid, g_Preload_Anims[i], "null", 4.0, 0, 0, 0, 0, 0, 1);
	}
	return (true);
}

stock FlipVehicle(vehicleid)
{
	static
	    Float:fAngle;

	GetVehicleZAngle(vehicleid, fAngle);

	SetVehicleZAngle(vehicleid, fAngle);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
	return (true);
}

stock GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(vehicle_Names); i ++)
	{
	    if (strfind(vehicle_Names[i], name, true) != -1)
	    {
	        return (i + 400);
		}
	}
	return (false);
}

stock ReturnVehicleModelName(model)
{
	new
	    name[32] = "Nepoznat";

    if (model < 400 || model > 611)
	    return (name);

	format(name, sizeof(name), vehicle_Names[model - 400]);
	return (name);
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock ReturnWeaponName(weaponid)
{
	static
		name[32];

	GetWeaponName(weaponid, name, sizeof(name));

	if (!weaponid)
	    name = "None";

	else if (weaponid == 18)
	    name = "Molotov Cocktail";

	else if (weaponid == 44)
	    name = "Nightvision";

	else if (weaponid == 45)
	    name = "Infrared";

	return (name);
}

stock GetWeaponModel(weaponid) {
    static const g_aWeaponModels[] = {
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
    };
    if (1 <= weaponid <= 46)
        return g_aWeaponModels[weaponid];

	return (false);
}

stock ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) {
		Player_Enum[playerid][pGuns][i] = 0;
		Player_Enum[playerid][pAmmo][i] = 0;
	}
	return (true);
}

stock GiveWeaponToPlayer(playerid, weaponid, ammo)
{
	if (weaponid < 0 || weaponid > 46)
	    return (false);

	Player_Enum[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	Player_Enum[playerid][pAmmo][g_aWeaponSlots[weaponid]] += ammo;

	return GivePlayerWeapon(playerid, weaponid, ammo);
}

stock Tax_Percent(price)
{
	return floatround((float(price) / 100) * 85);
}

stock SetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) if (Player_Enum[playerid][pGuns][i] > 0 && Player_Enum[playerid][pAmmo][i] > 0) {
	    GivePlayerWeapon(playerid, Player_Enum[playerid][pGuns][i], Player_Enum[playerid][pAmmo][i]);
	}
	return (true);
}

stock PlayerHasWeapon(playerid, weaponid)
{
	new
	    weapon,
	    ammo;

	for (new i = 0; i < 13; i ++) if (Player_Enum[playerid][pGuns][i] == weaponid) {
	    GetPlayerWeaponData(playerid, i, weapon, ammo);

	    if (weapon == weaponid && ammo > 0) return (true);
	}
	return (false);
}

stock UpdateWeapons(playerid)
{
	for (new i = 0; i < 13; i ++) if (Player_Enum[playerid][pGuns][i])
    {

        GetPlayerWeaponData(playerid, i, Player_Enum[playerid][pGuns][i], Player_Enum[playerid][pAmmo][i]);

        if (Player_Enum[playerid][pGuns][i] != 0 && !Player_Enum[playerid][pAmmo][i]) {
            Player_Enum[playerid][pGuns][i] = 0;
		}
	}
	return (true);
}

stock GetWeapon(playerid)
{
	new weaponid = GetPlayerWeapon(playerid);

	if (1 <= weaponid <= 46 && Player_Enum[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
 		return weaponid;

	return (false);
}

stock ResetWeapon(playerid, weaponid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) {
	    if (Player_Enum[playerid][pGuns][i] != weaponid) {
	        GivePlayerWeapon(playerid, Player_Enum[playerid][pGuns][i], Player_Enum[playerid][pAmmo][i]);
		}
		else {
            Player_Enum[playerid][pGuns][i] = 0;
            Player_Enum[playerid][pAmmo][i] = 0;
	    }
	}
	return (true);
}


stock IsPlayerInArea(playerid, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	new Float:Poz[3];
	GetPlayerPos(playerid, Poz[0], Poz[1], Poz[2]);
	if(Poz[0] > minx && Poz[0] < maxx && Poz[1] > miny && Poz[1] < maxy) return (true);
	return (false);
}

stock PlayerPlaySoundEx(playerid, sound)
{
	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 20.0, x, y, z)) {
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return (true);
}

stock IsPlayerNearBoot(playerid, vehicleid)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ);
}

stock IsLoadableVehicle(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);
	
	if (GetVehicleTrailer(vehicleid))
	    modelid = GetVehicleModel(GetVehicleTrailer(vehicleid));

	switch (modelid) {
	    case 609, 403, 414, 456, 498, 499, 514, 515, 435, 591: return (true);
	}
	return (false);
}

stock GetMaxCrates(vehicleid)
{
	new crates;

	switch (GetVehicleModel(vehicleid)) {
	    case 498, 609: crates = 10;
	    case 414: crates = 8;
	    case 456, 499: crates = 6;
	    case 435, 591: crates = 15;
	}
	return (crates);
}    

stock IsABoat(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return (true);
	}
	return (false);
}


stock IsABiciklo(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 481, 509, 510: return (true);
	}
	return (false);	
}

stock IsABike(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510: return (true);
	}
	return (false);
}

stock IsAPlane(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return (true);
	}
	return (false);
}

stock IsAHelicopter(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return (true);
	}
	return (false);
}

stock c_SendMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius))
			{
  				SendClientMessage(i, color, string);
			}
		}
		return (true);
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius))
		{
			SendClientMessage(i, color, str);
		}
	}
	return (true);
}

//===============================================================================

stock BanString(playerid,Banner[],Banovani[],Razlog[])
{
	PlayerTextDrawSetString(playerid, Ban_TD[3][playerid], Banovani);
	PlayerTextDrawSetString(playerid, Ban_TD[5][playerid], Banner);
	PlayerTextDrawSetString(playerid, Ban_TD[7][playerid], ReturnDate());
	PlayerTextDrawSetString(playerid, Ban_TD[9][playerid], Razlog);
	return (true);
}

//===============================================================================
