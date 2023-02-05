//==============================================================================

#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <sscanf2>

#include <strlib>
#include <progress>
#include <easyDialog>
#include <eSelection>
#include <eDistance>
#include <libRegEx>

#include <YSI\y_bit>
#include <YSI\y_iterate>
#include <YSI\y_bintree>
#include <YSI\y_va>
#include <YSI\y_timers>
#include <YSI\y_commands>

//==============================================================================

#undef MAX_PLAYERS
#define MAX_PLAYERS (100)

#define function%0(%1)\
forward%0(%1); public%0(%1)

#define PRESSED(%0)\
(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0)\
((newkeys & (%0)) == (%0))
#define RELEASED(%0) \
(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define DSL DIALOG_STYLE_LIST
#define DSM DIALOG_STYLE_MSGBOX
#define DSI DIALOG_STYLE_INPUT
#define DSP DIALOG_STYLE_PASSWORD
#define SCM va_SendClientMessage
#define SCMTA va_SendClientMessageToAll
#define IPI INVALID_PLAYER_ID

#define GRESKA(%0,%1) SCM(%0, 0xfa5555AA, "[ERROR]:{FFFFFF} "%1)
#define USAGE(%0,%1) SCM(%0, 0xDEDEA6FF, "{1B8254}[USSAGE]:{FFFFFF} "%1)
#define INFO(%0,%1) SCM(%0, 0xFFAB52FF, "{1C8287}[INFO]:{FFFFFF} "%1)

#define MOD_NAME "fun-mode BETA"
#define MAP_NAME "San Adreas"
#define FRM_NAME "www.balkan-rising.info"
#define SCR_NAME "v0.1"

#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define MYSQL_PASS ""
#define MYSQL_DB "funmode_db"

//==============================================================================

enum info
{
	 player_Name[MAX_PLAYER_NAME+1],
	 player_Password[14],
	 player_LastLogin[36],
	 player_Level,
	 player_Money,
	 player_Skin,
	 player_Admin,
};
new P_E[MAX_PLAYERS][info];

//==============================================================================

new _dbConnector;
new PlayerPassword[MAX_PLAYERS][14];
new PlayerLooged[MAX_PLAYERS];
new PlayerTeam[MAX_PLAYERS];
new PlayerAdver[MAX_PLAYERS];
new PlayerBlocked[MAX_PLAYERS];
new Degree[MAX_PLAYERS];

new bool:CSTDMode[MAX_PLAYERS];
new bool:DERBYMode[MAX_PLAYERS];
new bool:RACEMode[MAX_PLAYERS];
new bool:FREEROAMMode[MAX_PLAYERS];
new bool:SURVIVALMode[MAX_PLAYERS];
new bool:SELFIEMode[MAX_PLAYERS];

new player_CS;
new player_DERBY;
new player_RACE;
new player_FREEROAM;
new player_SURVIVAL;

new server_CS;
new server_DERBY;
new server_RACE;
new server_FREEROAM;
new server_SURVIVAL;

new const Float:Radius = 1.4;
new	const Float:Speed  = 1.20;
new	const Float:Height = 1.0;

//==============================================================================

new PlayerText:TDEditor_TD[MAX_PLAYERS][25];

//==============================================================================

static PlayerIP[16];

//==============================================================================

new const AllSkins[] = {

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
	print("===================================");
	print("- Balkan Rising Fun Mode -");
	print("- MODE BY: caupton        -");
	print("- www.balkan-rising.info  -");
	print("===================================");
}

//==============================================================================

public OnGameModeInit()
{
	SetGameModeText(MOD_NAME);
	SendRconCommand("mapname "MAP_NAME"");
	SendRconCommand("weburl "FRM_NAME"");
	DisableInteriorEnterExits();
 	EnableStuntBonusForAll(false);
 	ShowPlayerMarkers(false);
 	AllowInteriorWeapons(1);
 	ManualVehicleEngineAndLights();
	Mysql_Connect();
	
	/* CT - TT class */
	AddPlayerClass(301, 508.7362, -87.4335, 998.9609, 0.0, 30, 500, 23, 250, 0, 0);
	AddPlayerClass(293, 508.7362, -87.4335, 998.9609, 0.0, 30, 500, 23, 250, 0, 0);
	return (true);
}

//==============================================================================

public OnGameModeExit()
{
	return (true);
}

//==============================================================================

public OnPlayerRequestClass(playerid, classid)
{
	if(CSTDMode[playerid] == true)
	{
    if(0 <= classid <= 3)
	{
		GameTextForPlayer(playerid, "~b~CT TEAM",2000,4);
		SetPlayerTeam(playerid,1);
	}
	else
	{
		GameTextForPlayer(playerid, "~r~TT TEAM",2000,4);
		SetPlayerTeam(playerid,2);
	}
	}
	return (true);
}

//==============================================================================

public OnPlayerRequestSpawn(playerid)
{
	if(PlayerLooged[playerid] == 0) return GRESKA(playerid,"Morate se prvo ulogovati - Kikovani ste!"),Kick(playerid);
	return (true);
}

//==============================================================================

public OnPlayerConnect(playerid)
{
    static string[100];
   	format(string, sizeof(string), "SELECT * FROM `korisnici` WHERE `Player_Name` = '%s' LIMIT 0,1", GetName(playerid));
    mysql_function_query(_dbConnector, string, true, "CheckPlayerAccount", "i", playerid);
    
	string = "\0";
	
	TogglePlayerSpectating(playerid, true);
	CreateMenuTextDraws(playerid);
	return (true);
}

//==============================================================================

public OnPlayerDisconnect(playerid, reason)
{
	if(CSTDMode[playerid] == true) { player_CS--; }
	else if(DERBYMode[playerid] == true) { player_DERBY--; }
	else if(RACEMode[playerid] == true) { player_RACE--; }
	else if(FREEROAMMode[playerid] == true) { player_FREEROAM--; }
	else if(SURVIVALMode[playerid] == true) { player_SURVIVAL--; }
	return (true);
}

//==============================================================================

public OnPlayerSpawn(playerid)
{
    if(GetPlayerTeam(playerid) == 1)
	{
		SetPlayerInterior(playerid, 0); SetPlayerColor(playerid, (0x0079F2FF)); INFO(playerid,"Vi ste 'CT TEAM' da kupite oruzije kucajte '/buyweapon'."); PlayerTeam[playerid] = 1; SetPlayerSkin(playerid,301);
		/* SetPlayerPos za CT */
	}
	else if(GetPlayerTeam(playerid) == 2)
	{
		SetPlayerInterior(playerid, 0); SetPlayerColor(playerid, (0xF2002CFF)); INFO(playerid,"Vi ste 'TT TEAM' da kupite oruzije kucajte '/buyweapon'."); PlayerTeam[playerid] = 2; SetPlayerSkin(playerid,293);
		/* SetPlayerPos za TT */
	}
	return (true);
}

//==============================================================================

public OnPlayerDeath(playerid, killerid, reason)
{
	static string[325];
    if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
	{
	if(GetVehicleModel(GetPlayerVehicleID(killerid)) != 425 || GetVehicleModel(GetPlayerVehicleID(killerid)) != 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) != 432)
	{
		format(string,sizeof(string),"{86B1DE}Kikovan si sa servera!\n\
		{FFFFFF}Nick:{86B1DE}%s\n\
		{FFFFFF}Razlog:{86B1DE}JP-Hack.\n\
		{FFFFFF}Ukoliko mislis da je bug ili greska,\n\
		{FFFFFF}postavi na nasem forumu:{86B1DE}"FRM_NAME"",GetName(killerid));
		Dialog_Show(killerid, Show_Only, DSM, "{86B1DE}c_protect{FFFFFF} - KICKED",string,"Izlaz","");
		GameTextForPlayer(killerid,"~r~KICKED!",1000,4); player_Kick(killerid);
	}
	}
	return (true);
}

//==============================================================================

public OnVehicleSpawn(vehicleid)
{
	return (true);
}

//==============================================================================

public OnVehicleDeath(vehicleid, killerid)
{
	return (true);
}

//==============================================================================

public OnPlayerText(playerid, text[])
{
    if(IsAdvertisement(text)){ GRESKA(playerid,"Poruka je reklamatorskog karaktera zato nije ni ispisana - ukoliko budete imali 3 opomene dobicete 'KICK'."); PlayerAdver[playerid]++; return (false); }
	else if(PlayerAdver[playerid] == 3) { Kick(playerid); }
	return (true);
}

//==============================================================================

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return (true);
}

//==============================================================================

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return (true);
}

//==============================================================================

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return (true);
}

//==============================================================================

public OnPlayerEnterCheckpoint(playerid)
{
	return (true);
}

//==============================================================================

public OnPlayerLeaveCheckpoint(playerid)
{
	return (true);
}

//==============================================================================

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return (true);
}

//==============================================================================

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return (true);
}

//==============================================================================

public OnRconCommand(cmd[])
{
	return (true);
}

//==============================================================================

public OnObjectMoved(objectid)
{
	return (true);
}

//==============================================================================

public OnPlayerObjectMoved(playerid, objectid)
{
	return (true);
}

//==============================================================================

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return (true);
}

//==============================================================================

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return (true);
}

//==============================================================================

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return (true);
}

//==============================================================================

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return (true);
}

//==============================================================================

public OnPlayerSelectedMenuRow(playerid, row)
{
	return (true);
}

//==============================================================================

public OnPlayerExitedMenu(playerid)
{
	return (true);
}

//==============================================================================

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return (true);
}

//==============================================================================

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(SELFIEMode[playerid] == true)
	{
	    new Float:sPos[3][MAX_PLAYERS];
		static Float:n1X,Float:n1Y;
		if(PRESSED(KEY_ANALOG_RIGHT))
		{
			GetPlayerPos(playerid,sPos[0][playerid],sPos[1][playerid],sPos[2][playerid]);
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] += Speed;
		    n1X = sPos[0][playerid]+Radius*floatcos(Degree[playerid],degrees);
			n1Y = sPos[1][playerid]+Radius*floatsin(Degree[playerid],degrees);
			SetPlayerCameraPos(playerid,n1X,n1Y,sPos[2][playerid]+Height);
			SetPlayerCameraLookAt(playerid,sPos[0][playerid],sPos[1][playerid],sPos[2][playerid]+1);
			SetPlayerFacingAngle(playerid,Degree[playerid]-90.0);
		}
		if(PRESSED(KEY_ANALOG_LEFT))
		{
		    GetPlayerPos(playerid,sPos[0][playerid],sPos[1][playerid],sPos[2][playerid]);
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] -= Speed;
			n1X = sPos[0][playerid]+Radius*floatcos(Degree[playerid],degrees);
			n1Y = sPos[1][playerid]+Radius*floatsin(Degree[playerid],degrees);
			SetPlayerCameraPos(playerid,n1X,n1Y,sPos[2][playerid]+Height);
			SetPlayerCameraLookAt(playerid,sPos[0][playerid],sPos[1][playerid],sPos[2][playerid]+1);
			SetPlayerFacingAngle(playerid,Degree[playerid]-90.0);
		}
	}
	return (true);
}

//==============================================================================

public OnRconLoginAttempt(ip[], password[], success)
{
	return (true);
}

//==============================================================================

public OnPlayerUpdate(playerid)
{
	static string[325];
    foreach(Player,i)
	{
    if(P_E[i][player_Admin] == 0)
	{
	if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
	{
	format(string,sizeof(string),"{86B1DE}Kikovan si sa servera!\n\
	{FFFFFF}Nick:{86B1DE}%s\n\
	{FFFFFF}Razlog:{86B1DE}JP-Hack.\n\
	{FFFFFF}Ukoliko mislis da je bug ili greska,\n\
	{FFFFFF}postavi na nasem forumu:{86B1DE}"FRM_NAME"",GetName(i));
	Dialog_Show(i, Show_Only, DSM, "{86B1DE}c_protect{FFFFFF} - KICKED",string,"Izlaz","");
	GameTextForPlayer(i,"~r~KICKED!",1000,4); player_Kick(i);
	}
	}
	}
	return (true);
}

//==============================================================================

public OnPlayerStreamIn(playerid, forplayerid)
{
	return (true);
}

//==============================================================================

public OnPlayerStreamOut(playerid, forplayerid)
{
	return (true);
}

//==============================================================================

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return (true);
}

//==============================================================================

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return (true);
}

//==============================================================================

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return (true);
}

//==============================================================================

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return (true);
}

//==============================================================================

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
      if(_:playertextid != INVALID_TEXT_DRAW)
	  {
			   if(playertextid == TDEditor_TD[10][playerid])
			   {
			        if(server_SURVIVAL == 1) return GRESKA(playerid,"Onemogucen je konekt na Survival mode."),Kick(playerid);
					else if(player_SURVIVAL == 20) return GRESKA(playerid,"Trenutno nema slobodnih slotova!");
			        SetPlayerColor(playerid, (0xFFFFFFFF));
			        TogglePlayerSpectating(playerid, false);
			        TogglePlayerControllable(playerid, true);
			        SetCameraBehindPlayer(playerid);
					CancelSelectTextDraw(playerid);
                    MenuChoosen(playerid,2);
                    SetPlayerInterior(playerid,0);
					SetPlayerVirtualWorld(playerid, 1);
					player_SURVIVAL++;
					SURVIVALMode[playerid] = true;
			   }
			   else if(playertextid == TDEditor_TD[11][playerid])
			   {
			    	if(server_RACE == 1) return GRESKA(playerid,"Onemogucen je konekt na Race mode."),Kick(playerid);
					else if(player_RACE == 20) return GRESKA(playerid,"Trenutno nema slobodnih slotova!");
			        SetPlayerColor(playerid, (0xFFFFFFFF));
			        TogglePlayerSpectating(playerid, false);
			        TogglePlayerControllable(playerid, true);
			        SetCameraBehindPlayer(playerid);
					CancelSelectTextDraw(playerid);
                    MenuChoosen(playerid,2);
                    SetPlayerInterior(playerid,0);
					SetPlayerVirtualWorld(playerid, 2);
					player_RACE++;
					RACEMode[playerid] = true;
			   }
			   else if(playertextid == TDEditor_TD[12][playerid])
			   {
			        if(server_FREEROAM == 1) return GRESKA(playerid,"Onemogucen je konekt na Freeroam mode."),Kick(playerid);
					else if(player_FREEROAM == 20) return GRESKA(playerid,"Trenutno nema slobodnih slotova!");
			        SetPlayerColor(playerid, (0xFFFFFFFF));
			        TogglePlayerSpectating(playerid, false);
			        TogglePlayerControllable(playerid, true);
			        SetCameraBehindPlayer(playerid);
					CancelSelectTextDraw(playerid);
                    MenuChoosen(playerid,2);
                    SetPlayerInterior(playerid,0);
					SetPlayerVirtualWorld(playerid, 3);
					SetPlayerPos(playerid,1473.1124,1187.7810,12.8558);
					player_FREEROAM++;
					FREEROAMMode[playerid] = true;
			   }
			   else if(playertextid == TDEditor_TD[13][playerid])
			   {
			        if(server_CS == 1) return GRESKA(playerid,"Onemogucen je konekt na CS mode."),Kick(playerid);
					else if(player_CS == 20) return GRESKA(playerid,"Trenutno nema slobodnih slotova!");
			        SetPlayerColor(playerid, (0xFFFFFFFF));
			        TogglePlayerSpectating(playerid, false);
			        TogglePlayerControllable(playerid, true);
			        SetCameraBehindPlayer(playerid);
					CancelSelectTextDraw(playerid);
                    MenuChoosen(playerid,2);
                    CSTDMode[playerid] = true;
                    
					SetPlayerVirtualWorld(playerid, 4);
					SetPlayerCameraPos(playerid,508.7076, -83.5983, 999.5430);
					SetPlayerCameraLookAt(playerid,508.7362, -87.4335, 998.9609);
					SetPlayerInterior(playerid, 11);
					SetPlayerPos(playerid,508.7362, -87.4335, 998.9609);
					SetPlayerFacingAngle(playerid,0.0);
					player_CS++;
			   }
			   else if(playertextid == TDEditor_TD[14][playerid])
			   {
			        if(server_DERBY == 1) return GRESKA(playerid,"Onemogucen je konekt na Derby mode."),Kick(playerid);
					else if(player_DERBY == 20) return GRESKA(playerid,"Trenutno nema slobodnih slotova!");
			        SetPlayerColor(playerid, (0xFFFFFFFF));
			        TogglePlayerSpectating(playerid, false);
			        TogglePlayerControllable(playerid, true);
			        SetCameraBehindPlayer(playerid);
					CancelSelectTextDraw(playerid);
                    MenuChoosen(playerid,2);
                    SetPlayerInterior(playerid,0);
					SetPlayerVirtualWorld(playerid, 5);
					DERBYMode[playerid] = true;
					player_DERBY++;
			   }

      }
	  return (true);
}

//==============================================================================

timer player_Kick[1000](playerid)
{
	return Kick(playerid);
}

//==============================================================================

stock Mysql_Connect()
{
	_dbConnector = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	if (mysql_ping(_dbConnector) < 1) return printf("Konekcija sa '%s' bazom prekinuta.\a",MYSQL_HOST);
	else return printf("Konekcija sa '%s' bazom - uspostavljena.\a",MYSQL_HOST);
}

//==============================================================================

stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return (name);
}

//==============================================================================

stock ReturnDate()
{
	static date[36];
	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);
	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d", date[0], date[1], date[2], date[3], date[4]);
	return date;
}

//==============================================================================

stock FormatNumber(number, prefix[] = "$")
{
	static value[32],length;
	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));
	if((length = strlen(value)) > 3) { for(new i = length, l = 0; --i >= 0; l ++) { if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1); } }
	if(prefix[0] != 0) strins(value, prefix, 0);
	if(number < 0) strins(value, "-", 0);
	return (value);
}

//==============================================================================

stock CreateAccount(User[],Password[],IP[],Skin)
{
	static query[350];
	format(query, sizeof(query), "INSERT INTO `korisnici` (Player_Name,Player_Password,Player_IP,Player_Skin,Register_Date,Login_Date,Player_Money,Player_Level,player_Admin) VALUES('%s','%s','%s',%d,%d,'%s','%s',1000,1,%d)",
	Escape_String(User),Escape_String(Password),Escape_String(IP),Skin,ReturnDate(),ReturnDate());
	mysql_function_query(_dbConnector, query, false, "", "");
	
	query = "\0";
	return (true);
}

//==============================================================================

stock SetString(obj[], string[])
{
    strmid(obj, string, 0, strlen(string), 255);
    return (true);
}

//==============================================================================

stock Escape_String(const string[])
{
	static entry[256];
	mysql_real_escape_string(string, entry, _dbConnector);
	return (entry);
}

//==============================================================================

stock IsAdvertisement(text[])
{
    new message[128], build, expression[] = "(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.+){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)", start, end;
    format(message, sizeof(message), "%s", text);
    for(new i = 0; i < strlen(message); i ++)
    {
   	if(message[i] != '1' && message[i] != '2' && message[i] != '3' && message[i] != '4' && message[i] != '5' && message[i] != '6' && message[i] != '7' &&\
	message[i] != '8' && message[i] != '9' && message[i] != '0')
    {
    strdel(message, i, i + 1); strins(message, ".", i);
    }
    }
    build = regex_exbuild(expression);
    regex_exmatch(message, build);
    regex_exsearch(message, build, start, end);
    if(start >= 0) return (true);
    return(false);
}

//==============================================================================

stock CreateMenuTextDraws(playerid)
{
    TDEditor_TD[0][playerid] = CreatePlayerTextDraw(playerid,189.500000, 194.812500, "Balkan");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[0][playerid], 1.038499, 4.470001);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[0][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[0][playerid], -5963521);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[0][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[0][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[0][playerid], 3);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[0][playerid], 0);

	TDEditor_TD[1][playerid] = CreatePlayerTextDraw(playerid,307.500000, 212.312500, "Rising");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[1][playerid], 1.038499, 4.470001);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[1][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[1][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[1][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[1][playerid], 3);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[1][playerid], 0);

	TDEditor_TD[2][playerid] = CreatePlayerTextDraw(playerid,323.000000, 250.375000, "Fun_mode");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[2][playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[2][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[2][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[2][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[2][playerid], 3);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[2][playerid], 0);

	TDEditor_TD[3][playerid] = CreatePlayerTextDraw(playerid,380.900482, 209.350006, "v");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[3][playerid], 0.388500, 1.075000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[3][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[3][playerid], -5963521);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[3][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[3][playerid], 3);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[3][playerid], 0);

	TDEditor_TD[4][playerid] = CreatePlayerTextDraw(playerid,390.200073, 205.012481, "0.1");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[4][playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[4][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[4][playerid], -5963521);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[4][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[4][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[4][playerid], 3);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[4][playerid], 0);

	TDEditor_TD[5][playerid] = CreatePlayerTextDraw(playerid,213.299468, 291.199981, "box");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[5][playerid], 0.000000, 4.500000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[5][playerid], 273.799468, 0.000000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[5][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[5][playerid], -1);
	PlayerTextDrawUseBox(playerid,TDEditor_TD[5][playerid], 1);
	PlayerTextDrawBoxColor(playerid,TDEditor_TD[5][playerid], 95);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[5][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[5][playerid], 50);
	PlayerTextDrawFont(playerid,TDEditor_TD[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[5][playerid], 0);

	TDEditor_TD[6][playerid] = CreatePlayerTextDraw(playerid,133.499359, 291.062500, "box");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[6][playerid], 0.000000, 4.500000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[6][playerid], 193.999359, 0.000000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[6][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[6][playerid], -1);
	PlayerTextDrawUseBox(playerid,TDEditor_TD[6][playerid], 1);
	PlayerTextDrawBoxColor(playerid,TDEditor_TD[6][playerid], 95);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[6][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[6][playerid], 50);
	PlayerTextDrawFont(playerid,TDEditor_TD[6][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[6][playerid], 0);

	TDEditor_TD[7][playerid] = CreatePlayerTextDraw(playerid,293.704376, 291.299987, "box");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[7][playerid], 0.000000, 4.500000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[7][playerid], 354.204376, 0.000000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[7][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[7][playerid], -1);
	PlayerTextDrawUseBox(playerid,TDEditor_TD[7][playerid], 1);
	PlayerTextDrawBoxColor(playerid,TDEditor_TD[7][playerid], 95);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[7][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[7][playerid], 50);
	PlayerTextDrawFont(playerid,TDEditor_TD[7][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[7][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[7][playerid], 0);

	TDEditor_TD[8][playerid] = CreatePlayerTextDraw(playerid,374.409301, 291.737487, "box");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[8][playerid], 0.000000, 4.500000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[8][playerid], 434.909301, 0.000000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[8][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[8][playerid], -1);
	PlayerTextDrawUseBox(playerid,TDEditor_TD[8][playerid], 1);
	PlayerTextDrawBoxColor(playerid,TDEditor_TD[8][playerid], 95);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[8][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[8][playerid], 50);
	PlayerTextDrawFont(playerid,TDEditor_TD[8][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[8][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[8][playerid], 0);

	TDEditor_TD[9][playerid] = CreatePlayerTextDraw(playerid,456.209167, 291.700225, "box");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[9][playerid], 0.000000, 4.500000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[9][playerid], 516.710693, 0.000000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[9][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[9][playerid], -1);
	PlayerTextDrawUseBox(playerid,TDEditor_TD[9][playerid], 1);
	PlayerTextDrawBoxColor(playerid,TDEditor_TD[9][playerid], 95);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[9][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[9][playerid], 50);
	PlayerTextDrawFont(playerid,TDEditor_TD[9][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[9][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[9][playerid], 0);

	TDEditor_TD[10][playerid] = CreatePlayerTextDraw(playerid,138.799987, 333.287567, "Survival");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[10][playerid], 0.356500, 1.398750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[10][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[10][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[10][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[10][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[10][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[10][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[10][playerid], 0);
	PlayerTextDrawSetSelectable(playerid,TDEditor_TD[10][playerid], true);

	TDEditor_TD[11][playerid] = CreatePlayerTextDraw(playerid,231.105651, 333.462524, "Race");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[11][playerid], 0.356500, 1.398750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[11][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[11][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[11][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[11][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[11][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[11][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[11][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[11][playerid], 0);
	PlayerTextDrawSetSelectable(playerid,TDEditor_TD[11][playerid], true);

	TDEditor_TD[12][playerid] = CreatePlayerTextDraw(playerid,294.309509, 333.462524, "Freeroam");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[12][playerid], 0.356500, 1.398750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[12][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[12][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[12][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[12][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[12][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[12][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[12][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[12][playerid], 0);
	PlayerTextDrawSetSelectable(playerid,TDEditor_TD[12][playerid], true);

	TDEditor_TD[13][playerid] = CreatePlayerTextDraw(playerid,382.314880, 333.462524, "CS_Tdm");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[13][playerid], 0.356500, 1.398750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[13][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[13][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[13][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[13][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[13][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[13][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[13][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[13][playerid], 0);
	PlayerTextDrawSetSelectable(playerid,TDEditor_TD[13][playerid], true);

	TDEditor_TD[14][playerid] = CreatePlayerTextDraw(playerid,468.820159, 333.462524, "Derby");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[14][playerid], 0.356500, 1.398750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[14][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[14][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[14][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[14][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[14][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[14][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[14][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[14][playerid], 0);
	PlayerTextDrawSetSelectable(playerid,TDEditor_TD[14][playerid], true);

	TDEditor_TD[15][playerid] = CreatePlayerTextDraw(playerid,151.000000, 345.912536, "~r~(0/20)");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[15][playerid], 0.273500, 1.118750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[15][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[15][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[15][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[15][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[15][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[15][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[15][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[15][playerid], 0);

	TDEditor_TD[16][playerid] = CreatePlayerTextDraw(playerid,231.204895, 345.912536, "~r~(0/20)");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[16][playerid], 0.273500, 1.118750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[16][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[16][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[16][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[16][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[16][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[16][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[16][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[16][playerid], 0);

	TDEditor_TD[17][playerid] = CreatePlayerTextDraw(playerid,310.609741, 345.912536, "~r~(0/20)");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[17][playerid], 0.273500, 1.118750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[17][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[17][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[17][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[17][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[17][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[17][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[17][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[17][playerid], 0);

	TDEditor_TD[18][playerid] = CreatePlayerTextDraw(playerid,392.314727, 345.912536, "~r~(0/20)");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[18][playerid], 0.273500, 1.118750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[18][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[18][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[18][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[18][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[18][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[18][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[18][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[18][playerid], 0);

	TDEditor_TD[19][playerid] = CreatePlayerTextDraw(playerid,473.319671, 345.912536, "~r~(0/20)");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[19][playerid], 0.273500, 1.118750);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[19][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[19][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[19][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[19][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[19][playerid], 255);
	PlayerTextDrawFont(playerid,TDEditor_TD[19][playerid], 1);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[19][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[19][playerid], 0);

	TDEditor_TD[20][playerid] = CreatePlayerTextDraw(playerid,198.000000, 265.250000, "");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[20][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[20][playerid], 83.739730, 90.995025);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[20][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[20][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[20][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[20][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[20][playerid], 0);
	PlayerTextDrawFont(playerid,TDEditor_TD[20][playerid], 5);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[20][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[20][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid,TDEditor_TD[20][playerid], 541);
	PlayerTextDrawSetPreviewRot(playerid,TDEditor_TD[20][playerid], 0.000000, 0.000000, 50.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,TDEditor_TD[20][playerid], 3, 1);

	TDEditor_TD[21][playerid] = CreatePlayerTextDraw(playerid,136.000000, 275.312500, "");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[21][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[21][playerid], 88.500000, 69.000000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[21][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[21][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[21][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[21][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[21][playerid], 0);
	PlayerTextDrawFont(playerid,TDEditor_TD[21][playerid], 5);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[21][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[21][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid,TDEditor_TD[21][playerid], 335);
	PlayerTextDrawSetPreviewRot(playerid,TDEditor_TD[21][playerid], 0.000000, 50.000000, 0.000000, 1.000000);

	TDEditor_TD[22][playerid] = CreatePlayerTextDraw(playerid,298.899963, 288.000000, "");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[22][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[22][playerid], 49.500000, 45.812500);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[22][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[22][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[22][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[22][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[22][playerid], 0);
	PlayerTextDrawFont(playerid,TDEditor_TD[22][playerid], 5);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[22][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[22][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid,TDEditor_TD[22][playerid], 13592);
	PlayerTextDrawSetPreviewRot(playerid,TDEditor_TD[22][playerid], 0.000000, 0.000000, 0.000000, 1.000000);

	TDEditor_TD[23][playerid] = CreatePlayerTextDraw(playerid,371.500000, 270.500000, "");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[23][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[23][playerid], 88.000000, 72.500000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[23][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[23][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[23][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[23][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[23][playerid], 0);
	PlayerTextDrawFont(playerid,TDEditor_TD[23][playerid], 5);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[23][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[23][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid,TDEditor_TD[23][playerid], 355);
	PlayerTextDrawSetPreviewRot(playerid,TDEditor_TD[23][playerid], 0.000000, 50.000000, 0.000000, 2.500000);

	TDEditor_TD[24][playerid] = CreatePlayerTextDraw(playerid,443.500000, 276.625000, "");
	PlayerTextDrawLetterSize(playerid,TDEditor_TD[24][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid,TDEditor_TD[24][playerid], 84.500000, 75.125000);
	PlayerTextDrawAlignment(playerid,TDEditor_TD[24][playerid], 1);
	PlayerTextDrawColor(playerid,TDEditor_TD[24][playerid], -1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[24][playerid], 0);
	PlayerTextDrawSetOutline(playerid,TDEditor_TD[24][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,TDEditor_TD[24][playerid], 0);
	PlayerTextDrawFont(playerid,TDEditor_TD[24][playerid], 5);
	PlayerTextDrawSetProportional(playerid,TDEditor_TD[24][playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDEditor_TD[24][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid,TDEditor_TD[24][playerid], 557);
	PlayerTextDrawSetPreviewRot(playerid,TDEditor_TD[24][playerid], 0.000000, 0.000000, 50.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,TDEditor_TD[24][playerid], 1, 1);
	return (true);
}

//==============================================================================

stock MenuChoosen(playerid,opcija)
{
	if(opcija == 1)
	{
		for(new i = 0; i < 25; ++i)
        PlayerTextDrawShow(playerid,TDEditor_TD[i][playerid]);
		SelectTextDraw(playerid, (0xFFFFFFFF));
	}
	else if(opcija == 2)
	{
        for(new i = 0; i < 25; ++i)
        PlayerTextDrawHide(playerid,TDEditor_TD[i][playerid]);
		CancelSelectTextDraw(playerid);
	}
	return (true);
}

//==============================================================================

function CheckPlayerAccount(playerid)
{
    new rows,fields;
	static var_load[20],string[400];
    cache_get_data(rows,fields);

    if(!rows)
    {
           Dialog_Show(playerid, Register_Dialog, DSP, "{A7CEF0}FUN MODE {FFFFFF}- {A7CEF0}REGISTER", "{FFFFFF}Dobrodosli na Balkan Rising '{A7CEF0}fun mode{FFFFFF}' server.\n\
		   {FFFFFF}Kako bi ste pristupili potrebno je da unesete\n\
		   {FFFFFF}sifru koju ce te koristiti za ovaj nalog.\n\
		   {FFFFFF}Ukucajte sifru kako bi ste nastavili sa registracijom.", "Register", "Odustani");
    }
	else
	{
		   cache_get_field_content(0, "Player_Money", var_load);
   		   cache_get_field_content(0, "Player_Skin", var_load);
   		   cache_get_field_content(0, "player_Admin", var_load);
		   cache_get_field_content(0, "Player_Level", var_load);
		   cache_get_field_content(0, "Login_Date", P_E[playerid][player_LastLogin], _dbConnector);
		   cache_get_field_content(0, "Player_Password", P_E[playerid][player_Password], _dbConnector);
		   cache_get_field_content(0, "Player_Name", P_E[playerid][player_Name], _dbConnector);
		   
		   P_E[playerid][player_Money] = strval(var_load); GivePlayerMoney(playerid,P_E[playerid][player_Money]);
		   P_E[playerid][player_Skin]  = strval(var_load); SetPlayerSkin(playerid,P_E[playerid][player_Skin]);
		   P_E[playerid][player_Level] = strval(var_load); SetPlayerScore(playerid,P_E[playerid][player_Level]);
	       
	       format(string,sizeof(string),"{FFFFFF}'{A7CEF0}%s{FFFFFF}' dobrodosli nazad..\n\
	       {FFFFFF}Kako bi ste pristupili nalogu ukucajte sifru.",GetName(playerid));
	       Dialog_Show(playerid, Login_Dialog, DSP, "{A7CEF0}FUN MODE {FFFFFF}- {A7CEF0}LOGIN", string, "Login", "Odustani");
	       
	       string = "\0";
	}
	return (true);
}

//==============================================================================

Dialog:Show_Only(playerid, response, listitem, inputtext[])
{
		playerid = INVALID_PLAYER_ID;
		response = 0;
		listitem = 0;
		inputtext[0] = '\0';
}

//==============================================================================

Dialog:Login_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
 		if(!strcmp(P_E[playerid][player_Password], inputtext, false))
	  	{
	  	    SetPlayerInterior(playerid, 0);
        	TogglePlayerSpectating(playerid, true);
        	SetString(P_E[playerid][player_LastLogin],ReturnDate());
	   		INFO(playerid,"Zadnji put ste bili prijavljeni - '%s'.",P_E[playerid][player_LastLogin]);
	   		MenuChoosen(playerid,1);
	   		
	   		SetPlayerScore(playerid,P_E[playerid][player_Level]);
	   		GivePlayerMoney(playerid,P_E[playerid][player_Money]);
	   		SetPlayerSkin(playerid,P_E[playerid][player_Skin]);
	   		PlayerLooged[playerid] = 1;
	   		
	   		static string[10];
	   		static string1[10];
	   		static string2[10];
	   		static string3[10];
	   		static string4[10];
	   		
	   		format(string,sizeof(string),"%d/20",player_SURVIVAL);
	   		PlayerTextDrawSetString(playerid,TDEditor_TD[15][playerid],string);
	   		format(string1,sizeof(string1),"%d/20",player_RACE);
	   		PlayerTextDrawSetString(playerid,TDEditor_TD[16][playerid],string1);
	   		format(string2,sizeof(string2),"%d/20",player_FREEROAM);
	   		PlayerTextDrawSetString(playerid,TDEditor_TD[17][playerid],string2);
	   		format(string3,sizeof(string3),"%d/20",player_CS);
	   		PlayerTextDrawSetString(playerid,TDEditor_TD[18][playerid],string3);
	   		format(string4,sizeof(string4),"%d/20",player_DERBY);
	   		PlayerTextDrawSetString(playerid,TDEditor_TD[19][playerid],string4);
  		}
	  	else
	  	{
	  		static string[150];
	  	
    		format(string,sizeof(string),"{FFFFFF}'{A7CEF0}%s{FFFFFF}' dobrodosli nazad..\n\
	   		{FFFFFF}Kako bi ste pristupili nalogu ukucajte sifru.",GetName(playerid));
	   		Dialog_Show(playerid, Login_Dialog, DSP, "{A7CEF0}FUN MODE {FFFFFF}- {A7CEF0}LOGIN", string, "Login", "Odustani");
    		GRESKA(playerid,"Lozinka nije validna!");
    	
    		string = "\0";
    		return (true);
	  	}
	}
	return (true);
}

//==============================================================================

Dialog:Register_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
			if(strlen(inputtext) < 6 || strlen(inputtext) > 14) return Dialog_Show(playerid, Register_Dialog, DSP, "{A7CEF0}FUN MODE {FFFFFF}- {A7CEF0}REGISTER", "{FFFFFF}Dobrodosli na Balkan Rising '{A7CEF0}fun mode{FFFFFF}' server.\n\
  			{FFFFFF}Kako bi ste pristupili potrebno je da unesete\n\
	   		{FFFFFF}sifru koju ce te koristiti za ovaj nalog.\n\
	   		{FFFFFF}Ukucajte sifru kako bi ste nastavili sa registracijom.", "Register", "Odustani");
	   	
   			SetString(PlayerPassword[playerid],Escape_String(inputtext));
   			PlayerPassword[playerid][0] = '\0';

			CreateAccount(GetName(playerid),PlayerPassword[playerid],PlayerIP,P_E[playerid][player_Skin]);
		
			INFO(playerid,"Uspesno ste se registrovali na 'Balkan Rising' fun mode server.");
			INFO(playerid,"Ukoliko vam nesto nije jasno obratite se adminima '/report'.");
			INFO(playerid,"Da izaberete klasu pod kojom ce te igrati stisnite na neki od TD-ova,ukoliko nisu ucitani '/class'.");
			INFO(playerid,""FRM_NAME"");
			INFO(playerid,"Script Version - "SCR_NAME"");
			
			SetPlayerInterior(playerid, 0);
        	TogglePlayerSpectating(playerid, true);
			MenuChoosen(playerid,1);
			PlayerLooged[playerid] = 1;
			
			P_E[playerid][player_Money] = 1000; GivePlayerMoney(playerid,1000);
     		P_E[playerid][player_Level] = 1; SetPlayerScore(playerid,1);
     		
			new rand = random(sizeof(AllSkins));
   			P_E[playerid][player_Skin] = AllSkins[rand]; SetPlayerSkin(playerid,P_E[playerid][player_Skin]);
	}
	else
	{
			Kick(playerid);
	}
	return (true);
}

//==============================================================================

Dialog:Weapon_Dialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
        {
        	case 0:
        	{
				if(P_E[playerid][player_Money] < 200) return GRESKA(playerid,"Nemas novca!");
				P_E[playerid][player_Money] -= 200;
				GivePlayerMoney(playerid,-200);
				GivePlayerWeapon(playerid,24,50);
				INFO(playerid,"Uspesno ste kupili 'Deagle' (-$200).");
        	}
        	case 1:
        	{
				if(P_E[playerid][player_Money] < 250) return GRESKA(playerid,"Nemas novca!");
				P_E[playerid][player_Money] -= 250;
				GivePlayerMoney(playerid,-250);
				GivePlayerWeapon(playerid,29,50);
				INFO(playerid,"Uspesno ste kupili 'MP5' (-$250).");
        	}
        	case 2:
        	{
				if(P_E[playerid][player_Money] < 500) return GRESKA(playerid,"Nemas novca!");
				P_E[playerid][player_Money] -= 500;
				GivePlayerMoney(playerid,-500);
				GivePlayerWeapon(playerid,33,50);
				INFO(playerid,"Uspesno ste kupili 'Rifle' (-$500).");
        	}
        	case 3:
        	{
				if(P_E[playerid][player_Money] < 1000) return GRESKA(playerid,"Nemas novca!");
				P_E[playerid][player_Money] -= 1000;
				GivePlayerMoney(playerid,-1000);
				GivePlayerWeapon(playerid,34,10);
				INFO(playerid,"Uspesno ste kupili 'Sniper' (-$1000).");
        	}
        	case 4:
        	{
				if(P_E[playerid][player_Money] < 700) return GRESKA(playerid,"Nemas novca!");
				P_E[playerid][player_Money] -= 700;
				GivePlayerMoney(playerid,-700);
				GivePlayerWeapon(playerid,30,50);
				INFO(playerid,"Uspesno ste kupili 'AK-47' (-$700).");
        	}
        	case 5:
        	{
				if(P_E[playerid][player_Money] < 700) return GRESKA(playerid,"Nemas novca!");
				P_E[playerid][player_Money] -= 700;
				GivePlayerMoney(playerid,-700);
				GivePlayerWeapon(playerid,31,50);
				INFO(playerid,"Uspesno ste kupili 'M4' (-$700).");
        	}
        	case 6:
        	{
				if(P_E[playerid][player_Money] < 1000) return GRESKA(playerid,"Nemas novca!");
				P_E[playerid][player_Money] -= 1000;
				GivePlayerMoney(playerid,-1000);
				SetPlayerArmour(playerid,100);
				INFO(playerid,"Uspesno ste kupili 'Armour' (-$1000).");
        	}
        }
    }
    return (true);
}

//==============================================================================

YCMD:makeadmin(playerid,params[],help)
{
	static idigraca,level;
    if(PlayerLooged[playerid] == 0) return(false);
	if(P_E[playerid][player_Admin] < 5) return GRESKA(playerid,"Nisi ovlascen!");
	if(sscanf(params, "ui", idigraca,level)) return USAGE(playerid,"/makeadmin [Ime_Prezime/ID] [0-6]");
	if(idigraca == INVALID_PLAYER_ID) return GRESKA(playerid,"Nije online!");
	if(level < 0 || level > 6) return USAGE(playerid,"/makeadmin [Ime_Prezime/ID] [0-6]");
    if(level == 0)
	{
		INFO(idigraca,"Skinut vam je administrator,hvala za sve sto ste ucinili za BR!");
		INFO(playerid,"Uspesno si skinuo administratora igracu - '%s'.",GetName(idigraca));
		P_E[idigraca][player_Admin] = 0;
	}
	else
	{
	    INFO(idigraca,"Cestitamo uspesno ste postali administrator('%d') - BR servera.",level);
	    INFO(playerid,"Uspesno si dodelio administratora('%d') igracu - '%s'.",level,GetName(idigraca));
		P_E[idigraca][player_Admin] = level;
	}
	return (true);
}

//==============================================================================

YCMD:servercs(playerid, params[], help)
{
	static izbor[25];
	if(PlayerLooged[playerid] == 0) return(false);
	if(P_E[playerid][player_Admin] < 5) return GRESKA(playerid,"Nisi ovlascen!");
	if(sscanf(params,"s[25]",izbor)) return USAGE(playerid,"/servercs [on/off]");
	if(strcmp(izbor,"on",true) == 0){ if(server_CS == 0) return GRESKA(playerid,"Vec je omogucen!"); server_CS = 0; }
	if(strcmp(izbor,"off",true) == 0){ if(server_CS == 1) return GRESKA(playerid,"Vec je onemogucen!"); server_CS = 1; }
	return (true);
}

//==============================================================================

YCMD:serverderby(playerid, params[], help)
{
	static izbor[25];
	if(PlayerLooged[playerid] == 0) return(false);
	if(P_E[playerid][player_Admin] < 5) return GRESKA(playerid,"Nisi ovlascen!");
	if(sscanf(params,"s[25]",izbor)) return USAGE(playerid,"/serverderby [on/off]");
	if(strcmp(izbor,"on",true) == 0){ if(server_DERBY == 0) return GRESKA(playerid,"Vec je omogucen!"); server_DERBY = 0; }
	if(strcmp(izbor,"off",true) == 0){ if(server_DERBY == 1) return GRESKA(playerid,"Vec je onemogucen!"); server_DERBY = 1; }
	return (true);
}

//==============================================================================

YCMD:serverrace(playerid, params[], help)
{
	static izbor[25];
	if(PlayerLooged[playerid] == 0) return(false);
	if(P_E[playerid][player_Admin] < 5) return GRESKA(playerid,"Nisi ovlascen!");
	if(sscanf(params,"s[25]",izbor)) return USAGE(playerid,"/serverrace [on/off]");
	if(strcmp(izbor,"on",true) == 0){ if(server_RACE == 0) return GRESKA(playerid,"Vec je omogucen!"); server_RACE = 0; }
	if(strcmp(izbor,"off",true) == 0){ if(server_RACE == 1) return GRESKA(playerid,"Vec je onemogucen!"); server_RACE = 1; }
	return (true);
}

//==============================================================================

YCMD:serverfreeroam(playerid, params[], help)
{
	static izbor[25];
	if(PlayerLooged[playerid] == 0) return(false);
	if(P_E[playerid][player_Admin] < 5) return GRESKA(playerid,"Nisi ovlascen!");
	if(sscanf(params,"s[25]",izbor)) return USAGE(playerid,"/serverfreeroam [on/off]");
	if(strcmp(izbor,"on",true) == 0){ if(server_FREEROAM == 0) return GRESKA(playerid,"Vec je omogucen!"); server_FREEROAM = 0; }
	if(strcmp(izbor,"off",true) == 0){ if(server_FREEROAM == 1) return GRESKA(playerid,"Vec je onemogucen!"); server_FREEROAM = 1; }
	return (true);
}

//==============================================================================

YCMD:serversurvival(playerid, params[], help)
{
	static izbor[25];
	if(PlayerLooged[playerid] == 0) return(false);
	if(P_E[playerid][player_Admin] < 5) return GRESKA(playerid,"Nisi ovlascen!");
	if(sscanf(params,"s[25]",izbor)) return USAGE(playerid,"/serversurvival [on/off]");
	if(strcmp(izbor,"on",true) == 0){ if(server_SURVIVAL == 0) return GRESKA(playerid,"Vec je omogucen!"); server_SURVIVAL = 0; }
	if(strcmp(izbor,"off",true) == 0){ if(server_SURVIVAL == 1) return GRESKA(playerid,"Vec je onemogucen!"); server_SURVIVAL = 1; }
	return (true);
}

//==============================================================================

YCMD:pm(playerid,params[],help)
{
	static idigraca;
	new text[64],string[124];
    if(PlayerLooged[playerid] == 0) return(false);
    if(PlayerBlocked[playerid] == 1) return GRESKA(playerid,"Moras '/blockpm'.");
	if(sscanf(params, "ui", idigraca,text)) return USAGE(playerid,"/pm [Ime_Prezime/ID] [Text]");
	if(idigraca == INVALID_PLAYER_ID) return GRESKA(playerid,"Nije online!");
	if(PlayerBlocked[idigraca] == 1) return GRESKA(playerid,"Blokirao je '/pm'.");
	format(string,sizeof(string),"{EBBE2A}[PM]: od igraca '%s' - Text:'%s'.",GetName(playerid),text); SCM(idigraca,-1,string);
	INFO(playerid,"Uspesno ste poslali 'PM' igracu '%s'.",GetName(idigraca));
	return (true);
}

//==============================================================================

YCMD:blockpm(playerid,params[],help)
{
	if(PlayerLooged[playerid] == 0) return(false);
	if(PlayerBlocked[playerid] == 0){ INFO(playerid,"Blokirao si komandu '/pm'."); PlayerBlocked[playerid] = 1; }
	else if(PlayerBlocked[playerid] == 1){ INFO(playerid,"Odblokirao si komandu '/pm'."); PlayerBlocked[playerid] = 0; }
	return (true);
}

//==============================================================================

YCMD:buyweapon(playerid,params[],help)
{
    if(PlayerLooged[playerid] == 0) return(false);
	if(CSTDMode[playerid] == true) return(false);
	Dialog_Show(playerid, Weapon_Dialog, DSL, "{A7CEF0}WEAPON {FFFFFF}- {A7CEF0}SHOP", "{FFFFFF}Deagle - {0F9929}${FFFFFF}200\n\
	{FFFFFF}MP5 -    {0F9929}${FFFFFF}250\n\
	{FFFFFF}Rifle -  {0F9929}${FFFFFF}500\n\
	{FFFFFF}Sniper - {0F9929}${FFFFFF}1000\n\
	{FFFFFF}AK-47 -  {0F9929}${FFFFFF}700\n\
	{FFFFFF}M4 -     {0F9929}${FFFFFF}700\n\
	{FFFFFF}Armour - {0F9929}${FFFFFF}2000", "Kupi", "Odustani");
	return (true);
}

//==============================================================================

YCMD:selfie(playerid,params[],help)
{
	new Float:sPos[3][MAX_PLAYERS];
	static Float:n1X,Float:n1Y;
    if(PlayerLooged[playerid] == 0) return(false);
    if(SELFIEMode[playerid] == false)
    {
    GetPlayerPos(playerid,sPos[0][playerid],sPos[1][playerid],sPos[2][playerid]);
	if(Degree[playerid] >= 360) Degree[playerid] = 0;
	Degree[playerid] += Speed;
	n1X = sPos[0][playerid]+Radius*floatcos(Degree[playerid],degrees);
	n1Y = sPos[1][playerid]+Radius*floatsin(Degree[playerid],degrees);
	SetPlayerCameraPos(playerid,n1X,n1Y,sPos[2][playerid]+Height);
	SetPlayerCameraLookAt(playerid,sPos[0][playerid],sPos[1][playerid],sPos[2][playerid]+1);
	SetPlayerFacingAngle(playerid,Degree[playerid]-90.0);
	
	SELFIEMode[playerid] = true;
	ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 1, 1, 1, 1, 1, 1);
 	TogglePlayerControllable(playerid,(false));
 	INFO(playerid,"Koristi numpad '4' - '6' da pomeras kameru.");
 	INFO(playerid,"Da ugasis '/selfie' ponovo ukucaj '/selfie'!");
    }
    else if(SELFIEMode[playerid] == true)
    {
    TogglePlayerControllable(playerid,(true));
	SetCameraBehindPlayer(playerid);
 	SELFIEMode[playerid] = false;
 	INFO(playerid,"Ugasili ste vas '/selfie'.");
    }
	return (true);
}

//==============================================================================
