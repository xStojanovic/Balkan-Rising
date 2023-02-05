
#include <YSI\y_hooks>

//========================================================
/*
                  Balkan Rising
                     0.0.1x
                  Player System
*/
//=========================================================

static Text[50],string[350],Float:PlayerPos[3][MAX_PLAYERS];

//=========================================================

YCMD:b(playerid, params[], help)
{
    if(sscanf(params,"s[32]",Text)) return USAGE(playerid,"/b [Text]");
    format(string,sizeof(string),"[%d] %s: %s.",playerid,GetName(playerid),text);
	ProxDetector(5.0,playerid,string,-1,-1,-1,-1,-1);
    return (true);
}

YCMD:ame(playerid, params[], help)
{
    if(sscanf(params,"s[32]",Text)) return USAGE(playerid,"/ame [Text]");
    format(string,sizeof(string),"* %s %s",GetName(playerid),text);
	SetPlayerChatBubble(playerid,string,0xC2A2DAAA,5.0,10000);
    return (true);
}

YCMD:me(playerid, params[], help)
{
    if(sscanf(params,"s[32]",Text)) return USAGE(playerid,"/me [Text]");
    format(string,sizeof(string),"* %s %s",GetName(playerid),text);
	ProxDetector(5.0,playerid,string,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
    return (true);
}

YCMD:do(playerid, params[], help)
{
    if(sscanf(params,"s[32]",Text)) return USAGE(playerid,"/do [Text]");
    format(string,sizeof(string),"* %s ((%s))",text,GetName(playerid));
	ProxDetector(5.0,playerid,string,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
    return (true);
}

YCMD:s(playerid, params[], help)
{
    if(sscanf(params,"s[32]",Text)) return USAGE(playerid,"/s [Text]");
    format(string,sizeof(string),"%s se dere: %s",GetName(playerid),text);
	ProxDetector(5.0,playerid,string,-1,-1,-1,-1,-1);
    return (true);
}

YCMD:c(playerid, params[], help)
{
    if(sscanf(params,"s[32]",Text)) return USAGE(playerid,"/c [Text]");
    format(string,sizeof(string),"(tiho)%s kaze: %s",GetName(playerid),text);
	ProxDetector(5.0,playerid,string,-1,-1,-1,-1,-1);
    return (true);
}

YCMD:w(playerid, params[], help)
{
   	static idigraca;
    GetPlayerPos(idigraca,PlayerPos[0],PlayerPos[1],PlayerPos[2]);
    if(sscanf(params,"us[32]",idigraca,Text)) return USAGE(playerid,"/w [Ime_Prezime/ID] [Text]");
    if(idigraca == playerid) return GRESKA(playerid,"Ne mozes to!");
    if(idigraca == IPI) return GRESKA(playerid,"Taj igrac nije na serveru.");
    if(!IsPlayerInRangeOfPoint(playerid,3.0,PlayerPos[0],PlayerPos[1],PlayerPos[2])) return GRESKA(playerid,"Nije blizu vas.");
    format(string,sizeof(string),"* %s sapuce nesto...",GetName(playerid));
	SetPlayerChatBubble(playerid,string,0xC2A2DAAA,5.0,10000);
    format(string,sizeof(string),"{E8F56F}[/W]Igrac '%s' vam je sapnuo - '%s'.",GetName(playerid),GetName(idigraca)); SCM(idigraca,-1,string);
    return (true);
}

YCMD:komande(playerid, params[], help)
{
    new strsa[300];
    strcat(strsa, "/b - /me - /ame - /do - /c - /s - /w\n", sizeof(strsa));
    strcat(strsa, "/clothes - /storagebuy - /breakvehicle - /cancelbreaking - /engine\n", sizeof(strsa));
    strcat(strsa, "/vmanage - /veh - /takeinsurance - /givevehiclekey - /bike - /inventory\n", sizeof(strsa));
    strcat(strsa, "/pickupitem - /putback - /buyfurniture - /pozvoni - /renthouse - /unrent\n", sizeof(strsa));
    strcat(strsa, "/buyhouse - /house - /buybusiness - /business - /bizvehicle - /jobrequest - /buyweapon - /buyclothes\n", sizeof(strsa));
    Dialog_Show(playerid, Show_Only, DSM, "{FFFFFF}SERVER - KOMANDE",strsa,"Izlaz","");
    return (true);
}
//=========================================================

function ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5){

	if(IsPlayerConnected(playerid)){
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	for(new i = 0; i < MAX_PLAYERS; i++){
	if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))){
	GetPlayerPos(i, posx, posy, posz);
	tempposx = (oldposx -posx);
	tempposy = (oldposy -posy);
	tempposz = (oldposz -posz);
	if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))){ SCM(i,col1,string); }
	else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))){ SCM(i,col2,string); }
	else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))){ SCM(i,col3,string); }
	else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))){ SCM(i,col4,string); }
	else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))){ SCM(i,col5,string); }}}}
	return (true);
}

//=========================================================
