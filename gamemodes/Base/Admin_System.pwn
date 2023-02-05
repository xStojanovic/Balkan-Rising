
#include <YSI\y_hooks>

//========================================================
/*
                  Balkan Rising
                     0.0.1x
                  Admin System
*/
//=========================================================

static Text[50],string[350],Rank[25],PlayerIP[16],Float:SpecPos[3][MAX_PLAYERS],
PlayerInterior[MAX_PLAYERS],PlayerVW[MAX_PLAYERS];

//=========================================================

YCMD:ahelp(playerid,params[],help)
{
	new strah[1000];

	if(Player_Enum[playerid][p_Admin] == 0)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");

	if(Player_Enum[playerid][p_Admin] >= 1)
    {
		  strcat(strah, "{FCD77E}(Zajednicko): {FFFFFF}/a /ao /aodg /stafflogin\n\n", sizeof(strah));
		  strcat(strah, "{FCD77E}(Admin Level 1): {FFFFFF}/goto, /freeze, /unfreeze, /setskin, /kick\n", sizeof(strah));
          strcat(strah, "{FCD77E}(Admin Level 1): {FFFFFF}/spectate, /unspec, /setinterior, /setvw, /kill\n\n", sizeof(strah));
    }
    if(Player_Enum[playerid][p_Admin] >= 2)
    {
    	  strcat(strah, "{FCD77E}(Admin Level 2): {FFFFFF}/gethere, /aslap, /cc, /sethp, /setarmour, /rtc, /dtc\n", sizeof(strah));
    	  strcat(strah, "{FCD77E}(Admin Level 2): {FFFFFF}/mute, /unmute, /warn, /unwarn, /ban, /respawn, /richlist\n\n", sizeof(strah));
    }
    if(Player_Enum[playerid][p_Admin] >= 3)
    {
    	  strcat(strah, "{FCD77E}(Admin Level 3): {FFFFFF}/respawnradius, /repairradius, /getip, /repaircar, /repaircarid, /flipcar, /aveh, /warn, /unwarn\n\n", sizeof(strah));
    }
    if(Player_Enum[playerid][p_Admin] >= 4)
    {
    	  strcat(strah, "{FCD77E}(Admin Level 4): {FFFFFF}/checkstaffcode, /healall, /jetpack, /givemoney, /giveweapon, /setlevel, /unban, /unpanip\n\n", sizeof(strah));
    }
    if(Player_Enum[playerid][p_Admin] >= 5)
    {
    	  strcat(strah, "{FCD77E}(Admin Level 5): {FFFFFF}/makeadmin, /makegamemaster, /changestaffcode, /saveall, /deleteaccount, /xgoto\n", sizeof(strah));
    	  strcat(strah, "{FCD77E}(Admin Level 5): {FFFFFF}/makeentrance, /deleteentrance, /editentrance, /makehouse, /deletehouse\n", sizeof(strah));
    	  strcat(strah, "{FCD77E}(Admin Level 5): {FFFFFF}/makebusiness /deletebusiness\n\n", sizeof(strah));
    }
    if(Player_Enum[playerid][p_Admin] >= 6)
    {
    	  strcat(strah, "{FCD77E}(Admin Level 6): {FFFFFF}/clearinventory, /deleteitem\n", sizeof(strah));
    }
    Dialog_Show(playerid,Show_Only,DSM,"{FFFFFF}ADMINISTRATOR - KOMANDE",strah,"Izlaz","");   
	return (true);
}

YCMD:gmhelp(playerid,params[],help)
{

    new strah[500];

	if(Player_Enum[playerid][p_Gamemaster] == 0)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");

	if(Player_Enum[playerid][p_Gamemaster] >= 1)
	{
		strcat(strah, "{ECFAA0}(Zajednicko): {FFFFFF}/g, /go, /godg, /stafflogin\n", sizeof(strah));
		strcat(strah, "{ECFAA0}(GameMaster Level 1): {FFFFFF}/goto, /spectate, /unspectate\n\n", sizeof(strah));
	}
	if(Player_Enum[playerid][p_Gamemaster] >= 2)
	{
		strcat(strah, "{ECFAA0}(GameMaster Level 2): {FFFFFF}/setinterior, /setvw, /kick, /kill\n\n", sizeof(strah));
	}
	if(Player_Enum[playerid][p_Gamemaster] >= 3)
	{
		strcat(strah, "{ECFAA0}(GameMaster Level 3): {FFFFFF}/gethere, /aslap, /rtc, /dtc, /mute, /unmute\n\n", sizeof(strah));
	}
	if(Player_Enum[playerid][p_Gamemaster] >= 4)
	{
		strcat(strah, "{ECFAA0}(GameMaster Level 4): {FFFFFF}/freeze, /unfreeze, /repaircar, /repaircarid, /flipcar, /respawn\n\n", sizeof(strah));
	}
	Dialog_Show(playerid,Show_Only,DSM,"{FFFFFF}GAMEMASTER - KOMANDE",strah,"Izlaz","");    
	return (true);
}

//=========================================================

YCMD:makeadmin(playerid,params[],help)
{
	static idigraca,level;

	/*if(Player_Enum[playerid][p_Admin] < 5)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");*/
	if(sscanf(params, "ui", idigraca,level))
	   return USAGE(playerid,"/makeadmin [Ime_Prezime/ID] [0-6]");
	if(idigraca == INVALID_PLAYER_ID)
	   return GRESKA(playerid,"Igrac nije konektovan!");
	if(level < 0 || level > 6)
	   return USAGE(playerid,"/makeadmin [Ime_Prezime/ID] [0-6]");

	SetAdmin(idigraca,playerid,level,1000 + random(9999));
	return (true);              
}

YCMD:makegamemaster(playerid,params[],help)
{
	static idigraca,level;

	if(Player_Enum[playerid][p_Admin] < 5)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "ui", idigraca,level))
	   return USAGE(playerid,"/makegamemaster [Ime_Prezime/ID] [0-4]");
	if(idigraca == INVALID_PLAYER_ID)
	   return GRESKA(playerid,"Igrac nije konektovan!");
	if(level < 0 || level > 4)
	   return USAGE(playerid,"/makegamemaster [Ime_Prezime/ID] [0-4]");

	SetGamemaster(idigraca,playerid,level,1000 + random(9999));
	return (true);       
}

YCMD:changestaffcode(playerid,params[],help)
{
	static idigraca,staffkod;

	if(Player_Enum[playerid][p_Admin] < 5)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "ui", idigraca,staffkod))
	   return USAGE(playerid,"/changestaffcode [Ime_Prezime/ID] [Staff code]");
	if(idigraca == INVALID_PLAYER_ID)
	   return GRESKA(playerid,"Igrac nije konektovan!");
	if(Player_Enum[idigraca][p_Admin] > Player_Enum[playerid][p_Admin])
	   return GRESKA(playerid,"Ne mozete mjenjati password adminu veceg levela.");   
	if(Player_Enum[idigraca][p_Admin] == 0 && Player_Enum[idigraca][p_Gamemaster] == 0)
	   return GRESKA(playerid,"Ovaj igrac nije clan staff team-a.");

	Player_Enum[idigraca][p_StaffKod] = staffkod;

	INFO(idigraca,"Administrator %s vam je promenio staffkod.",GetName(playerid));
	INFO(idigraca,"Vas novi staff kod je: [%d]",staffkod);         
	return (true);
}

YCMD:checkstaffcode(playerid,params[],help)
{
	static idigraca;

	if(Player_Enum[playerid][p_Admin] < 4)
	   return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(sscanf(params, "u", idigraca))
	   return USAGE(playerid,"/checkstaffcode [Ime_Prezime/ID]");
	if(idigraca == INVALID_PLAYER_ID)
	   return GRESKA(playerid,"Igrac nije konektovan!");
	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] == 0)
	   return GRESKA(playerid,"Igrac kojeg ste unijeli nije clan naseg staff team-a.");

	INFO(playerid,"(STAFF KOD) od %s glasi %d",GetName(idigraca),Player_Enum[idigraca][p_StaffKod]);
	return (true);         
}

//===============================================================================================

YCMD:a(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] == 0) 
	    return GRESKA(playerid,"Niste ovlasteni za ovu komandu!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "s[50]", Text)) 
	    return USAGE(playerid,"/a [text]");

	if(Player_Enum[playerid][p_Admin] == 1) { Rank = "Admin Level 1"; }
    else if(Player_Enum[playerid][p_Admin] == 2) { Rank = "Admin Level 2"; }
    else if(Player_Enum[playerid][p_Admin] == 3) { Rank = "Admin Level 3"; }
    else if(Player_Enum[playerid][p_Admin] == 4) { Rank = "Admin Level 4"; }
    else if(Player_Enum[playerid][p_Admin] == 5) { Rank = "Co-Administrator"; }
    else if(Player_Enum[playerid][p_Admin] == 6) { Rank = "Developer"; }
    
    format(string,sizeof(string),"{FFAF00}[ {FFFFFF}%s{FFAF00} | {FFFFFF}%s{FFAF00} ]{FFFFFF}: {FFAF00}%s",Rank,GetName(playerid),Text);
    StaffMessage(-1,string);
	return (true);      
}

YCMD:ao(playerid,params[],help)
{
    if(Player_Enum[playerid][p_Admin] == 0) 
        return GRESKA(playerid,"Niste ovlasteni za ovu komandu!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "s[50]", Text)) 
	    return USAGE(playerid,"/ao ( text )");

	format(string,sizeof(string),"{00C0FF}(( [A-OOC] {FFFFFF}Admin {F00C17}%s: {FFFFFF}%s {00C0FF}))",GetName(playerid),Text);
    SCMTA(-1,string);
	return (true);
}

YCMD:aodg(playerid,params[],help)
{
    static idigraca;

    if(Player_Enum[playerid][p_Admin] == 0) 
        return GRESKA(playerid,"Niste ovlasteni za ovu komandu!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "us[50]",idigraca, Text)) 
	    return USAGE(playerid,"/aodg [ID/Ime_Prezime] [text]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	format(string,sizeof(string),"{7AB0EA}PM:{FFFFFF} Administrator %s ti je poslao PM sa porukom - {7AB0EA}'%s'.",GetName( playerid ),Text);
	SCM(idigraca,-1,string);
	return (true);
}

//===============================================================================================

YCMD:g(playerid,params[],help)
{
    if(Player_Enum[playerid][p_Gamemaster] == 0) 
        return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "s[50]", Text)) 
	    return USAGE(playerid,"/g [text]");
	
	if(Player_Enum[playerid][p_Gamemaster] == 1) { Rank = "GameMaster Level 1"; }
    else if(Player_Enum[playerid][p_Gamemaster] == 2) { Rank = "GameMaster Level 2"; }
    else if(Player_Enum[playerid][p_Gamemaster] == 3) { Rank = "GameMaster Level 3"; }
    else if(Player_Enum[playerid][p_Gamemaster] == 4) { Rank = "GameMaster Level 4"; }
    
    format(string,sizeof(string),"{02F71F}[ {FFFFFF}%s{02F71F} | {FFFFFF}%s{02F71F} ]{FFFFFF}: {02F71F}%s",Rank,GetName(playerid),Text);
    StaffMessage(-1,string);
	return (true);
}

YCMD:go(playerid,params[],help)
{
    if(Player_Enum[playerid][p_Gamemaster] == 0) 
        return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "s[50]", Text)) 
	    return USAGE(playerid,"/go [text]");

	format(string,sizeof(string),"{02F71F}(( [G-OOC] {FFFFFF}GameMaster {02F71F}%s: {FFFFFF}%s {02F71F}))",GetName(playerid),Text);
    SCMTA(-1,string);
	return (true);
}

YCMD:godg(playerid,params[],help)
{
    static idigraca;

    if(Player_Enum[playerid][p_Gamemaster] == 0) 
        return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "us[50]",idigraca, Text)) 
	    return USAGE(playerid,"/godg [ID/Ime_Prezime] [text]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	format(string,sizeof(string),"{02F71F}PM:{FFFFFF} GameMaster %s ti je poslao PM sa porukom - {02F71F}'%s'.",GetName( playerid ),Text);
	SCM(idigraca,-1,string);
	return (true);
}

//===============================================================================================

YCMD:stafflogin(playerid,params[],help)
{
	static password;

	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] == 0)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == true) 
	    return GRESKA(playerid,"Vec ste ulogovani u staff panel!");    
    if(sscanf(params, "i", password))
        return USAGE(playerid,"/stafflogin [password]");
    if(password != Player_Enum[playerid][p_StaffKod])
        return GRESKA(playerid,"(KOD) koji ste unijeli je netocan!!"); 

    INFO(playerid,"Uspesno ste se ulogovali u staff panel."); Bit_Set(b_sLogged, playerid, true);    
	return (true);
}

//===============================================================================================

YCMD:kick(playerid,params[],help)
{
	static idigraca,razlog[40];

	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] < 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "us[40]", idigraca,razlog)) 
	    return USAGE(playerid,"/kick [ID/Ime_Prezime] [Razlog]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(idigraca == playerid)
	    return (true);
	if(Player_Enum[idigraca][p_Admin] > Player_Enum[playerid][p_Admin])
	    return GRESKA(playerid,"Ne mozes kikovati igraca veceg admin levela!");    

	GetPlayerIp(idigraca,PlayerIP,sizeof(PlayerIP));

	TogglePlayerSpectating(idigraca, (true));
    InterpolateCameraPos(idigraca, 2301.460205, -850.211303, 158.525146, 2840.348632, -1409.012695, 158.525146, 70000);
    InterpolateCameraLookAt(idigraca, 2300.764404, -855.068176, 157.562438, 2835.906738, -1411.096557, 157.562438, 70000);    
	    
	format(string,sizeof(string),"{FFFFFF} - Ime_Prezime: {FF4557}%s.\n\
	{FFFFFF}- IP: {FF4557}%s.\n\n\
	{FFFFFF}Kikovan si sa servera zbog {FF4557}'%s'.\n\
	{FFFFFF}Ako mislis da je ovo greska,\n\
	{FFFFFF}slikaj i postavi ovo na nas forum.",GetName(idigraca),PlayerIP,razlog);
	Dialog_Show(idigraca,Show_Only,DSM,"{FFFFFF}SERVER - KICK",string,"Izlaz","");

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je kikovao igraca %s | Razlog: %s |.",GetName(playerid), GetName(idigraca),razlog);
	StaffMessage(-1,string);

	defer Kick_Player(idigraca);           
	return (true);
}

YCMD:kill(playerid,params[],help)
{
	static idigraca;

	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] < 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/kill [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(Player_Enum[idigraca][p_Admin] > Player_Enum[playerid][p_Admin])
	    return GRESKA(playerid,"Ne mozes ubiti igraca veceg admin levela!");

	SetPlayerHealth(idigraca,0.0); INFO(idigraca,"Ubijeni ste od %s",GetName(playerid));
	
	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je ubio igraca %s.",GetName(playerid), GetName(idigraca));
	StaffMessage(-1,string);      
	return (true);
}

YCMD:goto(playerid,params[],help)
{
    static idigraca,Float:Pos[3];

    if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] == 0)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/goto [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(idigraca == playerid)
	    return (true);

	GetPlayerPos(idigraca,Pos[0],Pos[1],Pos[2]); 

    if(IsPlayerInAnyVehicle(playerid))
	{
             SetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2] );
	         SetPlayerInterior(playerid, GetPlayerInterior(idigraca));
	         SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(idigraca));
    }
    else
	{
             SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		     SetPlayerInterior(playerid, GetPlayerInterior(idigraca));
			 SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(idigraca));
    }
    return (true);
}

YCMD:freeze(playerid,params[],help)
{
	static idigraca;

	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/freeze [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(idigraca == playerid)
	    return (true);

	TogglePlayerControllable(idigraca, false);    

	INFO(idigraca,"Freezovani ste od administratora %s.",GetName(playerid));

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je zamrznuo igraca %s.",GetName(playerid), GetName(idigraca));
	StaffMessage(-1,string);   
	return (true);
}

YCMD:unfreeze(playerid,params[],help)
{
     static idigraca;

     if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	 if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	 if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/freeze [ID/Ime_Prezime]");
	 if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	 if(idigraca == playerid)
	    return (true);

     TogglePlayerControllable(idigraca, true);    

	 format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je odmrznuo igraca %s.",GetName(playerid), GetName(idigraca));
	 StaffMessage(-1,string);
	 return (true);    
}

YCMD:setskin(playerid,params[],help)
{
	static idigraca,skinid;

	if(Player_Enum[playerid][p_Admin] == 0)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
    if(sscanf(params, "ui", idigraca,skinid)) 
	    return USAGE(playerid,"/setskin [ID/Ime_Prezime] [Skin ID]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	Player_Enum[idigraca][p_Skin] = skinid; SetPlayerSkin(idigraca,skinid);    
    
    format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je postavio skin igracu %s | SkinID %d |.",GetName(playerid), GetName(idigraca),skinid);
	StaffMessage(-1,string);
	return (true);
}

YCMD:spectate(playerid,params[],help)
{
	static idigraca,Float:Pos[3];
	GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);

	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] == 0)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(Bit_Get(b_Spectating, playerid) == true)
	    return GRESKA(playerid,"Vec specate nekoga!"); 
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/spectate [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");     
    if(idigraca == playerid)
	    return (true);

	SpecPos[0][playerid] = Pos[0]; SpecPos[1][playerid] = Pos[1]; SpecPos[2][playerid] = Pos[2];
	PlayerInterior[playerid] = GetPlayerInterior(playerid);
	PlayerVW[playerid] = GetPlayerVirtualWorld(playerid);

	if(!IsPlayerInAnyVehicle(idigraca))
	{
	       TogglePlayerSpectating(playerid, true);
		   PlayerSpectatePlayer(playerid, idigraca);
		   SetPlayerInterior(playerid,GetPlayerInterior(idigraca));
		   SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(idigraca));
    }
    else
	{
		   TogglePlayerSpectating(playerid, true);
		   PlayerSpectateVehicle(playerid, GetPlayerVehicleID(idigraca));
		   SetPlayerInterior(playerid,GetPlayerInterior(idigraca));
		   SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(idigraca));
    }
    INFO(playerid,"Poceli ste specati igraca %s.",GetName(idigraca)); Bit_Set(b_Spectating, playerid, true);

    format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je poceo specati igraca %s.",GetName(playerid), GetName(idigraca));
	StaffMessage(-1,string);    
	return (true);
}

YCMD:unspectate(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] == 0)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(Bit_Get(b_Spectating, playerid) == false)
	    return GRESKA(playerid,"Nespecate nikoga!");

	TogglePlayerSpectating(playerid, false);
	SetPlayerInterior(playerid, PlayerInterior[playerid]);
    SetPlayerVirtualWorld(playerid, PlayerVW[playerid]);
    
    SetPlayerPos(playerid, SpecPos[0][playerid], SpecPos[1][playerid], SpecPos[2][playerid]);
    SetPlayerSkin(playerid, Player_Enum[playerid][p_Skin]);
	
	Bit_Set(b_Spectating, playerid, false); INFO(playerid,"Prestali ste sa specanjem ovo igraca!");  
	return (true);
}

YCMD:setinterior(playerid,params[],help)
{
	static idigraca,interiorid;

	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] < 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "ud", idigraca, interiorid)) 
	    return USAGE(playerid,"/setinterior [ID/Ime_Prezime] [Interior ID]");
    if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

    SetPlayerInterior(idigraca,interiorid);

    INFO(playerid,"Uspesno ste promenili Interior igracu %s.",GetName(idigraca));
	return (true);
}

YCMD:setvw(playerid,params[],help)
{
	static idigraca,vwid;

	if(Player_Enum[playerid][p_Admin] == 0 && Player_Enum[playerid][p_Gamemaster] < 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "ud", idigraca, vwid)) 
	    return USAGE(playerid,"/setvw [ID/Ime_Prezime] [VirtualWorld ID]");
    if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	SetPlayerVirtualWorld(idigraca,vwid);

	INFO(playerid,"Uspesno ste promenili VirtualWorld igracu %s.",GetName(idigraca));    
	return (true);
}

YCMD:ban(playerid,params[],help)
{
	static idigraca,razlog[36];

	if(Player_Enum[playerid][p_Admin] == 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "us[36]", idigraca, razlog)) 
	    return USAGE(playerid,"/ban [ID/Ime_Prezime] [Razlog]");
    if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
    if(idigraca == playerid)
	    return (true);
	if(Player_Enum[idigraca][p_Admin] > Player_Enum[playerid][p_Admin])
	    return GRESKA(playerid,"Ne mozes banovati igraca veceg admin levela!");

	GetPlayerIp(idigraca,PlayerIP,sizeof(PlayerIP));
	PlayerBan(PlayerIP,GetName(playerid),GetName(idigraca),razlog);
	BanString(idigraca,GetName(playerid),GetName(idigraca),razlog);

	BanTextdraws(idigraca,1);

	TogglePlayerSpectating(idigraca, (true));
    InterpolateCameraPos(idigraca, 2301.460205, -850.211303, 158.525146, 2840.348632, -1409.012695, 158.525146, 70000);
    InterpolateCameraLookAt(idigraca, 2300.764404, -855.068176, 157.562438, 2835.906738, -1411.096557, 157.562438, 70000); 

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je banovao igraca %s.",GetName(playerid), GetName(idigraca));
	StaffMessage(-1,string);

	defer Ban_Kick(idigraca);    
	return (true);
}

//===============================================================================================

YCMD:gethere(playerid,params[],help)
{
	static idigraca;

	if(Player_Enum[playerid][p_Admin] < 2 && Player_Enum[playerid][p_Gamemaster] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/gethere [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(idigraca == playerid)
	    return (true);

	SendPlayerToPlayer(idigraca, playerid); INFO(playerid,"Portao si: %s do sebe.",GetName(idigraca));
	return (true);                
}

YCMD:richlist(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");

	new playerMoney[MAX_PLAYERS][E_BINTREE_INPUT],
		index = 0; 

	foreach(new i:Player)
	{
		playerMoney[index][E_BINTREE_INPUT_POINTER] = i;
		playerMoney[index][E_BINTREE_INPUT_VALUE] = Player_Enum[i][p_Money];

		index++;
	}	   

	Bintree_Sort(playerMoney, index);

	new playerList[491];

	for(new i = (index - 1), j = (index <= 10) ? (0) : (index - 10); i >= j; i--)
	{
		strcat(playerList, sprintf("{FFFFFF}Player: {FFBD24}%s {FFFFFF}Money: {1C9C0B}$%i\n", GetName(playerMoney[i][E_BINTREE_INPUT_POINTER]), playerMoney[i][E_BINTREE_INPUT_VALUE]), 490);
	}

	playerList[strlen(playerList) - 1] = '\0';

	Dialog_Show(playerid,Show_Only,DSM,"{FFFFFF}Richest Players",playerList,"Exit","");
	return (true);
}

YCMD:respawn(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 2 && Player_Enum[playerid][p_Gamemaster] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");

	new count;

	for (new i = 1; i != MAX_VEHICLES; i ++)
	{
	    if (IsValidVehicle(i) && GetVehicleDriver(i) == INVALID_PLAYER_ID)
	    {
	        SetVehicleToRespawn(i);
			count++;
		}
	}
	if (!count)
	    return GRESKA(playerid,"Nema praznih vozila za respawn.");
	SCMTA(-1,"Respawn vozila uspesno izvrsen.");
	return (true);     
}

YCMD:mute(playerid,params[],help)
{
	static idigraca,vreme;

	if(Player_Enum[playerid][p_Admin] < 2 && Player_Enum[playerid][p_Gamemaster] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "ui", idigraca, vreme)) 
	    return USAGE(playerid,"/mute [ID/Ime_Prezime] [Vreme]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(idigraca == playerid)
	    return (true);
	if(vreme < 1 || vreme > 200)
	    return GRESKA(playerid,"Vreme ne moze biti manje od 1 i vece od 200 sec");
	if(Player_Enum[idigraca][p_Muted] > 0)
	    return GRESKA(playerid,"Ovaj igrac je vec mutiran!");
    
    Player_Enum[idigraca][p_Muted] = vreme*(60);

    INFO(idigraca,"Mutirani ste od %s na %d minuta.",GetName(playerid),vreme);

    format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je mutirao igraca %s | Vreme: %dmin |.",GetName(playerid), GetName(idigraca),vreme);
	StaffMessage(-1,string);
	return (true);
}

YCMD:unmute(playerid,params[],help)
{
	static idigraca;

	if(Player_Enum[playerid][p_Admin] < 2 && Player_Enum[playerid][p_Gamemaster] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/mute [ID/Ime_Prezime] [Vreme]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(idigraca == playerid)
	    return (true);
	if(Player_Enum[idigraca][p_Muted] == 0)
	    return GRESKA(playerid,"Ovaj igrac nije mutiran!");

	Player_Enum[idigraca][p_Muted] = 0; INFO(idigraca,"%s vas je unmutirao.",GetName(playerid));

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je unmutirao %s.",GetName(playerid), GetName(idigraca));
	StaffMessage(-1,string);        
	return (true);
}

YCMD:aslap(playerid,params[],help)
{
	static idigraca,Float:xyz[3];

	if(Player_Enum[playerid][p_Admin] < 2 && Player_Enum[playerid][p_Gamemaster] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/aslap [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	GetPlayerPos(idigraca, xyz[0], xyz[1], xyz[2]);
	SetPlayerPos(idigraca, xyz[0], xyz[1], xyz[2] + 5);
	PlayerPlaySound(idigraca, 1130, 0.0, 0.0, 0.0);  

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je slapovao igraca %s.",GetName(playerid), GetName(idigraca));
	StaffMessage(-1,string);   
    return (true);
}

YCMD:sethp(playerid,params[],help)
{
	static idigraca,kolicina;

	if(Player_Enum[playerid][p_Admin] < 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "ui", idigraca, kolicina)) 
	    return USAGE(playerid,"/sethp [ID/Ime_Prezime] [Kolicina]");    
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(kolicina > 99)
	    return GRESKA(playerid,"Kolicina ne moze biti preko 99%.");

	SetPlayerHealth(idigraca, kolicina);

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je postavio health igraca %s | (%d) |.",GetName(playerid), GetName(idigraca),kolicina);
	StaffMessage(-1,string);                
	return (true);
}

YCMD:setarmour(playerid,params[],help)
{
	static idigraca,kolicina;

	if(Player_Enum[playerid][p_Admin] < 2)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "ui", idigraca, kolicina)) 
	    return USAGE(playerid,"/setarmour [ID/Ime_Prezime] [Kolicina]");    
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(kolicina > 99)
	    return GRESKA(playerid,"Kolicina ne moze biti preko 99%.");

	SetPlayerArmour(idigraca, kolicina);

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je postavio armour igraca %s | (%d) |.",GetName(playerid), GetName(idigraca),kolicina);
	StaffMessage(-1,string);                
	return (true);
}

YCMD:rtc(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 2 && Player_Enum[playerid][p_Gamemaster] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(!IsPlayerInAnyVehicle(playerid))  
	    return GRESKA(playerid,"Morate biti u nekom vozilu!");

	SetVehicleToRespawn(GetPlayerVehicleID(playerid)); RemovePlayerFromVehicle(playerid);
	INFO(playerid,"Uspesno ste respawnali ovo vozilo.");      
	return (true);
}

YCMD:dtc(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 2 && Player_Enum[playerid][p_Gamemaster] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(!IsPlayerInAnyVehicle(playerid))  
	    return GRESKA(playerid,"Morate biti u nekom vozilu!");

	DestroyVehicle(GetPlayerVehicleID(playerid)); RemovePlayerFromVehicle(playerid);
	INFO(playerid,"Vozilo uspjesno unisteno!");    
	return (true);
}

//===============================================================================================

YCMD:respawnradius(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");

    new count = 0,Float:xyz[3];

	for (new i = 1; i != MAX_VEHICLES; i ++)
	{
         if (IsValidVehicle(i) && GetVehicleDriver(i) == INVALID_PLAYER_ID)
		 {
               GetVehiclePos(i, xyz[0], xyz[1], xyz[2]);
               
               if (IsPlayerInRangeOfPoint(playerid, 50.0, xyz[0], xyz[1], xyz[2]))
			   {
			        SetVehicleToRespawn(i);
					count++;
			   }
		 }
	}
	if (!count) return GRESKA(playerid,"Nema vozila u vasoj blizini!");
	INFO(playerid,"Uspesno si respawnao %d vozila.",count);
	return (true);
}

YCMD:repairradius(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");

    new count = 0,Float:xyz[3];

	for (new i = 1; i != MAX_VEHICLES; i ++)
	{
         if (IsValidVehicle(i) && GetVehicleDriver(i) == INVALID_PLAYER_ID)
		 {
               GetVehiclePos(i, xyz[0], xyz[1], xyz[2]);
               
               if (IsPlayerInRangeOfPoint(playerid, 50.0, xyz[0], xyz[1], xyz[2]))
			   {
			        RepairVehicle(i);
					count++;
			   }
		 }
	}
	if (!count) return GRESKA(playerid,"Nema vozila u vasoj blizini!");
	INFO(playerid,"Uspesno si popravio %d vozila.",count);
	return (true);
}

YCMD:getip(playerid,params[],help)
{
    static idigraca;

	if(Player_Enum[playerid][p_Admin] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/getip [ID/Ime_Prezime]");    
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	
	GetPlayerIp(idigraca,PlayerIP,sizeof(PlayerIP));
	INFO(playerid,"IP adresa ovog igraca je: %s",PlayerIP);        
	return (true);
}

YCMD:repaircar(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 3 && Player_Enum[playerid][p_Gamemaster] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(!IsPlayerInAnyVehicle(playerid))  
	    return GRESKA(playerid,"Morate biti u nekom vozilu!");

	RepairVehicle(GetPlayerVehicleID(playerid)); INFO(playerid,"Uspesno ste popravili ovo vozilo!");    
	return (true);
}

YCMD:repaircarid(playerid,params[],help)
{
    static vehicleid;

	if(Player_Enum[playerid][p_Admin] < 3 && Player_Enum[playerid][p_Gamemaster] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if (sscanf(params, "d", vehicleid)) 
	    return USAGE(playerid,"/repaircarid [ID vozila]");
	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid)) 
	    return GRESKA(playerid,"Pogresan ID vozila!");

	RepairVehicle(vehicleid); INFO(playerid,"Uspesno ste popravili vozilo ID: %d",vehicleid);    
	return (true);
}

YCMD:flipcar(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 3 && Player_Enum[playerid][p_Gamemaster] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(!IsPlayerInAnyVehicle(playerid))  
	    return GRESKA(playerid,"Morate biti u nekom vozilu!");

	FlipVehicle(GetPlayerVehicleID(playerid));    
	return (true);
}

YCMD:aveh(playerid,params[],help)
{
	static model[32],boja1,boja2,Float:xyza[4],vehcreate;

	if(Player_Enum[playerid][p_Admin] < 3 && Player_Enum[playerid][p_Gamemaster] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if (sscanf(params, "s[32]I(-1)I(-1)", model, boja1, boja2)) 
	    return USAGE(playerid,"/veh [Model ID/Model Name] [boja 1] [boja 2]");
	if ((model[0] = GetVehicleModelByName(model)) == 0) 
	    return GRESKA(playerid,"Nepoznat model vozila!");
	
	GetPlayerPos(playerid, xyza[0], xyza[1], xyza[2]);
	GetPlayerFacingAngle(playerid, xyza[3]);
	
	vehcreate = CreateVehicle(model[0], xyza[0], xyza[1] + 2, xyza[2], xyza[3], boja1, boja2, -1);
	SetVehicleParams(vehcreate, VEHICLE_TYPE_ENGINE, 1);
	
	if (GetPlayerInterior(playerid) != 0)
	    LinkVehicleToInterior(vehcreate, GetPlayerInterior(playerid));
	if (GetPlayerVirtualWorld(playerid) != 0)
		SetVehicleVirtualWorld(vehcreate, GetPlayerVirtualWorld(playerid));
		
	if (IsABoat(vehcreate) || IsAPlane(vehcreate) || IsAHelicopter(vehcreate))
	    PutPlayerInVehicle(playerid, vehcreate, 0);

    PlayerTextDrawSetString(playerid, Speedo_TD[9][playerid], "~g~!E");
    PlayerTextDrawSetString(playerid, Speedo_TD[7][playerid], "~g~!S");     	    
	    
	INFO(playerid,"Uspesno ste spawnali vozilo: %s | ( boja1: %d ) ( boja2: %d )",ReturnVehicleModelName(model[0]),boja1,boja2);    
	return (true);
}

YCMD:warn(playerid,params[],help)
{
	static idigraca,razlog[24];

	if(Player_Enum[playerid][p_Admin] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "us[24]", idigraca,razlog)) 
	    return USAGE(playerid,"/warn [ID/Ime_Prezime] [Razlog]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	if(Player_Enum[idigraca][p_Admin] > Player_Enum[playerid][p_Admin])
	    return GRESKA(playerid,"Ne mozes banovati igraca veceg admin levela!");

	Player_Enum[idigraca][p_Warns] ++;    
	
	INFO(idigraca,"Dobio si warn od: %s razlog: %s",GetName(playerid),razlog);
	INFO(idigraca,"Ukupni warnovi: %d/5.",Player_Enum[idigraca][p_Warns]);

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je dao warn %s razlog %s.",GetName(playerid),GetName(idigraca),razlog);
	StaffMessage(-1,string);

	if(Player_Enum[idigraca][p_Warns] == 5)
	{
		GetPlayerIp(idigraca,PlayerIP,sizeof(PlayerIP));
		PlayerBan(PlayerIP,GetName(idigraca),GetName(playerid),"Max Warned");
		BanString(idigraca,GetName(playerid),GetName(idigraca),"Max Warned");

		BanTextdraws(idigraca,1);

		TogglePlayerSpectating(idigraca, (true));
	    InterpolateCameraPos(idigraca, 2301.460205, -850.211303, 158.525146, 2840.348632, -1409.012695, 158.525146, 70000);
	    InterpolateCameraLookAt(idigraca, 2300.764404, -855.068176, 157.562438, 2835.906738, -1411.096557, 157.562438, 70000);

	    defer Ban_Kick(idigraca);  
	}                
	return (true);
}

YCMD:unwarn(playerid,params[],help)
{
	static idigraca;

	if(Player_Enum[playerid][p_Admin] < 3)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca)) 
	    return USAGE(playerid,"/unwarn [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	Player_Enum[idigraca][p_Warns] --;

	INFO(idigraca,"%s vam je uklonio warn %d/5.",GetName(playerid),Player_Enum[idigraca][p_Warns]);

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je uklonio warn igracu %s.",GetName(playerid),GetName(idigraca));
	StaffMessage(-1,string);    
	return (true);
}

//===============================================================================================

YCMD:giveweapon(playerid,params[],help)
{
	static idigraca,weaponid,ammo;

	if(Player_Enum[playerid][p_Admin] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "udI(100)", idigraca, weaponid, ammo))
	    return USAGE(playerid,"/giveweapon [ID/Ime_Prezime] [weaponid] [ammo]");
	if(idigraca == IPI)
	    return GRESKA(playerid,"Igrac nije na serveru!");
	if(weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21)) 
	    return GRESKA(playerid,"Nepoznat id oruzija!");

	GiveWeaponToPlayer(idigraca, weaponid, ammo); 
	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je dao oruzije igracu: %s.",GetName(playerid),GetName(idigraca));
	StaffMessage(-1,string);                    
    return (true);
}

YCMD:healall(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");

	foreach (new i : Player) { SetPlayerHealth(i, 99.0); }
	
	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je izlecio sve igrace na serveru.",GetName(playerid));
	StaffMessage(-1,string);     
	return (true);
}

YCMD:jetpack(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	INFO(playerid,"Uspesno ste spawnali jetpack.");    
	return (true);
}

YCMD:givemoney(playerid,params[],help)
{
	static idigraca,kolicina;

	if(Player_Enum[playerid][p_Admin] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "ud", idigraca, kolicina))
	    return USAGE(playerid,"/givemoney [ID/Ime_Prezime] [Kolicina]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");
	    
	Player_Enum[idigraca][p_Money] += kolicina; GivePlayerMoney(idigraca,kolicina);

	INFO(idigraca,"Administrator %s vam je dao $%d",GetName(playerid),kolicina);

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je dao %s novac: $%d.",GetName(playerid),GetName(idigraca),kolicina);
	StaffMessage(-1,string);            
	return (true);
}

YCMD:setlevel(playerid,params[],help)
{
	static idigraca,kolicina;

	if(Player_Enum[playerid][p_Admin] < 4)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "ud", idigraca, kolicina))
	    return USAGE(playerid,"/setlevel [ID/Ime_Prezime] [Kolicina]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	Player_Enum[idigraca][p_Level] = kolicina; SetPlayerScore(idigraca,kolicina);

	INFO(idigraca,"Administrator %s vam je postavio level: %d",GetName(playerid),kolicina);
	
	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je postavio %s level: %d.",GetName(playerid),GetName(idigraca),kolicina);
	StaffMessage(-1,string);      
	return (true);
}

YCMD:saveall(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");

	foreach (new i : Player) { SavePlayer(i); }
	
	INFO(playerid,"Uspesno ste sacuvali sve online racune!");
	
	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je sacuvao sve online racune.",GetName(playerid));
	StaffMessage(-1,string);          
	return (true);
}

YCMD:deleteaccount(playerid,params[],help)
{
	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
    if (isnull(params) || strlen(params) > 24)
        return USAGE(playerid,"/deleteaccount [Ime_Prezime]");
    if(!IsValidRpName(params))
        return GRESKA(playerid,"Unesite ime u pravilnom formatu.");
    foreach (new i : Player) { if (!strcmp(Player_Enum[i][p_Name], params, true)) {
	    return GRESKA(playerid,"Ne mozete obrisati online racun!"); }
    }
  
    INFO(playerid,"Uspjesno ste obrisali racun pod imenom: %s",params);

	CharacterRemove(params);          
	return (true);
}

YCMD:unban(playerid,params[],help)
{
	static playername[MAX_PLAYER_NAME + 1];

	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "s[30]",playername))
	    return USAGE(playerid,"/unban [Ime_Prezime]");
	if(!IsValidRpName(playername))
	    return USAGE(playerid,"/unban [Ime_Prezime]");

    BanRemove(playername);  INFO(playerid,"Uspesno ste unbanali igraca: %s",playername);

    format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je unbanovao %s.",GetName(playerid),playername);
	StaffMessage(-1,string);    
	return (true);
}

YCMD:unbanip(playerid,params[],help)
{
	static playerip[16];

	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(!IsAnIP(playerip))
	    return GRESKA(playerid,"Unesite pravilan format IP adrese.");

	IPRemove(playerip); INFO(playerid,"Uspesno ste unbanovali IP: %s",playerip);
	
	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je unbanovao IP %s.",GetName(playerid),playerip);
	StaffMessage(-1,string);         
	return (true);
}

YCMD:xgoto(playerid,params[],help)
{
	static Float:Poz[3];
	if(Player_Enum[playerid][p_Admin] < 5)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params,"fff", Poz[0], Poz[1], Poz[2] ) ) 
	    return USAGE(playerid,"/xgoto [x] [y] [z]");
    if(IsPlayerInAnyVehicle( playerid ) ) { SetVehiclePos( GetPlayerVehicleID(playerid), Poz[0], Poz[1], Poz[2] ); }
    else { SetPlayerPos(playerid, Poz[0], Poz[1], Poz[2 ]); }    
	return (true);
}

//===============================================================================================

YCMD:clearinventory(playerid,params[],help)
{
	static idigraca;

	if(Player_Enum[playerid][p_Admin] < 6)
	    return GRESKA(playerid,"Niste ovlasteni za koristenje ove komande!");
	if(Bit_Get(b_sLogged, playerid) == false) 
	    return GRESKA(playerid,"Niste ulogovani u staff panel: /stafflogin!");
	if(sscanf(params, "u", idigraca))
	    return USAGE(playerid,"/clearinventory [ID/Ime_Prezime]");
	if(idigraca == INVALID_PLAYER_ID) 
	    return GRESKA(playerid,"Igrac nije konektovan!!");

	Inventory_Clear(idigraca);
	
	INFO(playerid,"Uspesno ste obrisali cijeli inventar igracu (%s).",GetName(idigraca));
	INFO(idigraca,"Administrator %s, vam je obrisao cijeli inventar.",GetName(playerid));

	format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s je obrisao Inventory igracu %s.",GetName(playerid),GetName(idigraca));
	StaffMessage(-1,string);            
	return (true);
}

//===============================================================================================

stock SetAdmin(igrac,giverid,level,akod)
{
	if(level == 0)
	{
		INFO(igrac,"Administrator %s vam je skinuo administrator poziciju.",GetName(giverid));
		INFO(giverid,"Uspesno ste skinuli administrator poziciju igracu %s.",GetName(igrac));

		Player_Enum[igrac][p_Admin] = 0; Player_Enum[igrac][p_StaffKod] = 0;
	}
	else
	{

		Player_Enum[igrac][p_Admin] = level; Player_Enum[igrac][p_StaffKod] = akod;

		format(string,sizeof(string),"{C7AF46}OBAVESTENJE:\n\
		  {FFFFFF}Administrator {C7AF46}%s {FFFFFF}vam je postavio admin poziciju.\n\
		  {FFFFFF}Dobili ste svoj Staff(CODE) sve ce vam dole biti objasnjeno.\n\n\
		  {C7AF46}CODE:\n\
		  {FFFFFF}Bez ovog koda necete moci da upravljate staff komandama.\n\
		  {FFFFFF}CODE:{C7AF46} (%d) - {FFFFFF}LEVEL:{C7AF46} (%d).",GetName(giverid),akod,level);
		Dialog_Show(igrac,Show_Only,DSM,"{FFFFFF}ADMINISTRATOR - POZICIJA",string,"Uredu","");
	}
	return (true);
}

stock SetGamemaster(igrac,giverid,level,akod)
{
	if(level == 0)
	{
		INFO(igrac,"Administrator %s vam je skinuo gamemaster poziciju.",GetName(giverid));
		INFO(giverid,"Uspesno ste skinuli gamemaster poziciju igracu %s.",GetName(igrac));

		Player_Enum[igrac][p_Gamemaster] = 0; Player_Enum[igrac][p_StaffKod] = 0;
	}
	else
	{

		Player_Enum[igrac][p_Gamemaster] = level; Player_Enum[igrac][p_StaffKod] = akod;

		format(string,sizeof(string),"{C7AF46}OBAVESTENJE:\n\
		  {FFFFFF}Administrator {C7AF46}%s {FFFFFF}vam je postavio gamemaster poziciju.\n\
		  {FFFFFF}Dobili ste svoj Staff(CODE) sve ce vam dole biti objasnjeno.\n\n\
		  {C7AF46}CODE:\n\
		  {FFFFFF}Bez ovog koda necete moci da upravljate staff komandama.\n\
		  {FFFFFF}CODE:{C7AF46} (%d) - {FFFFFF}LEVEL:{C7AF46} (%d).",GetName(giverid),akod,level);
		Dialog_Show(igrac,Show_Only,DSM,"{FFFFFF}GAMEMASTER - POZICIJA",string,"Uredu","");
	}
	return (true);
}

//===============================================================================================

stock PlayerBan(ip[],username[],banner[],razlog[])
{
	static i_string[250];
    format(i_string, sizeof(i_string), "INSERT INTO `br_bans` (`IP`, `User`, `BanovanOd`, `Razlog`, `Datum`) VALUES('%s', '%s', '%s', '%s', '%s')",
    Escape_String(ip),
    Escape_String(username),
    Escape_String(banner),
    Escape_String(razlog),
    ReturnDate());
    mysql_function_query(_dbConnector, i_string, false, "", "");
	return (true);
}

stock BanRemove(username[])
{
    static i_string[64];
    format(i_string, sizeof(i_string), "DELETE FROM `br_bans` WHERE `User` = '%s'", Escape_String(username));
    mysql_function_query(_dbConnector, i_string, false, "", "");
	return (true);
}

stock IPRemove(playerip[])
{
    static i_string[64];
    format(i_string, sizeof(i_string), "DELETE FROM `br_bans` WHERE `IP` = '%s'", Escape_String(playerip));
    mysql_function_query(_dbConnector, i_string, false, "", "");
	return (true);
}

stock StaffMessage(color, c_string[])
{
    foreach (new i : Player)
    { if(Player_Enum[i][p_Admin] > 0 || Player_Enum[i][p_Gamemaster] > 0 || IsPlayerAdmin(i)) {SCM(i, color, c_string); } }
    return (true);
}

stock SendPlayerToPlayer(playerid, targetid)
{
	static
	    Float:xyz[3];

	GetPlayerPos(targetid, xyz[0], xyz[1], xyz[2]);

	if (IsPlayerInAnyVehicle(playerid))
	{
	    SetVehiclePos(GetPlayerVehicleID(playerid), xyz[0], xyz[1] + 2, xyz[2]);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
	}
	else
		SetPlayerPos(playerid, xyz[0] + 1, xyz[1], xyz[2]);

	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
}

//=================================================================================================              
