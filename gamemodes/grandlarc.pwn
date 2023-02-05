//----------------------------------------------------------
//
//  GRAND LARCENY  1.0
//  A freeroam gamemode for SA-MP 0.3
//
//----------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>
#include <YSI\y_timers>


#pragma tabsize 0

//----------------------------------------------------------

#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_NORMAL_PLAYER 0xFFBB7777

#define CITY_LOS_SANTOS 	0
#define CITY_SAN_FIERRO 	1
#define CITY_LAS_VENTURAS 	2

new total_vehicles_from_files=0;

// Class selection globals
new gPlayerCitySelection[MAX_PLAYERS];
new gPlayerHasCitySelected[MAX_PLAYERS];
new gPlayerLastCitySelectionTick[MAX_PLAYERS];

new PlayerText:Login_TD[MAX_PLAYERS][17];

new Text:txtClassSelHelper;
new Text:txtLosSantos;
new Text:txtSanFierro;
new Text:txtLasVenturas;

new thisanimid=0;
new lastanimid=0;

new createCar;
static Float:pPos[3];

//----------------------------------------------------------

main()
{
	print("\n---------------------------------------");
	print("Running Grand Larceny - by the SA-MP team\n");
	print("---------------------------------------\n");
}

//----------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~Grand Larceny",3000,4);
  	SendClientMessage(playerid,COLOR_WHITE,"Welcome to {88AA88}G{FFFFFF}rand {88AA88}L{FFFFFF}arceny");
  	
  	// class selection init vars
  	gPlayerCitySelection[playerid] = -1;
	gPlayerHasCitySelected[playerid] = 0;
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();

	//SetPlayerColor(playerid,COLOR_NORMAL_PLAYER);

	//Kick(playerid);
	
	/*
	Removes vending machines
	RemoveBuildingForPlayer(playerid, 1302, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 1209, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 955, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 1775, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 1776, 0.0, 0.0, 0.0, 6000.0);
	*/
	
	/*
	new ClientVersion[32];
	GetPlayerVersion(playerid, ClientVersion, 32);
	printf("Player %d reports client version: %s", playerid, ClientVersion);*/

 	return 1;
}

//----------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	
	new randSpawn = 0;
	
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
 	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, 30000);

	if(CITY_LOS_SANTOS == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_LosSantos));
 	    SetPlayerPos(playerid,
		 gRandomSpawns_LosSantos[randSpawn][0],
		 gRandomSpawns_LosSantos[randSpawn][1],
		 gRandomSpawns_LosSantos[randSpawn][2]);
		SetPlayerFacingAngle(playerid,gRandomSpawns_LosSantos[randSpawn][3]);
	}
	else if(CITY_SAN_FIERRO == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_SanFierro));
 	    SetPlayerPos(playerid,
		 gRandomSpawns_SanFierro[randSpawn][0],
		 gRandomSpawns_SanFierro[randSpawn][1],
		 gRandomSpawns_SanFierro[randSpawn][2]);
		SetPlayerFacingAngle(playerid,gRandomSpawns_SanFierro[randSpawn][3]);
	}
	else if(CITY_LAS_VENTURAS == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_LasVenturas));
 	    SetPlayerPos(playerid,
		 gRandomSpawns_LasVenturas[randSpawn][0],
		 gRandomSpawns_LasVenturas[randSpawn][1],
		 gRandomSpawns_LasVenturas[randSpawn][2]);
		SetPlayerFacingAngle(playerid,gRandomSpawns_LasVenturas[randSpawn][3]);
	}
	TogglePlayerClock(playerid, 0);
	
	defer Sobeit_Check(playerid);
	return 1;
}

//----------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
    
    // if they ever return to class selection make them city
	// select again first
	gPlayerHasCitySelected[playerid] = 0;
    
	if(killerid == INVALID_PLAYER_ID) {
        ResetPlayerMoney(playerid);
	} else {
		playercash = GetPlayerMoney(playerid);
		if(playercash > 0)  {
			GivePlayerMoney(killerid, playercash);
			ResetPlayerMoney(playerid);
		}
	}
   	return 1;
}

//----------------------------------------------------------

ClassSel_SetupCharSelection(playerid)
{
   	if(gPlayerCitySelection[playerid] == CITY_LOS_SANTOS) {
		SetPlayerInterior(playerid,11);
		SetPlayerPos(playerid,508.7362,-87.4335,998.9609);
		SetPlayerFacingAngle(playerid,0.0);
    	SetPlayerCameraPos(playerid,508.7362,-83.4335,998.9609);
		SetPlayerCameraLookAt(playerid,508.7362,-87.4335,998.9609);
	}
	else if(gPlayerCitySelection[playerid] == CITY_SAN_FIERRO) {
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,-2673.8381,1399.7424,918.3516);
		SetPlayerFacingAngle(playerid,181.0);
    	SetPlayerCameraPos(playerid,-2673.2776,1394.3859,918.3516);
		SetPlayerCameraLookAt(playerid,-2673.8381,1399.7424,918.3516);
	}
	else if(gPlayerCitySelection[playerid] == CITY_LAS_VENTURAS) {
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,349.0453,193.2271,1014.1797);
		SetPlayerFacingAngle(playerid,286.25);
    	SetPlayerCameraPos(playerid,352.9164,194.5702,1014.1875);
		SetPlayerCameraLookAt(playerid,349.0453,193.2271,1014.1797);
	}
	
}

//----------------------------------------------------------
// Used to init textdraws of city names

ClassSel_InitCityNameText(Text:txtInit)
{
  	TextDrawUseBox(txtInit, 0);
	TextDrawLetterSize(txtInit,1.25,3.0);
	TextDrawFont(txtInit, 0);
	TextDrawSetShadow(txtInit,0);
    TextDrawSetOutline(txtInit,1);
    TextDrawColor(txtInit,0xEEEEEEFF);
    TextDrawBackgroundColor(txtClassSelHelper,0x000000FF);
}

//----------------------------------------------------------

ClassSel_InitTextDraws()
{
    // Init our observer helper text display
	txtLosSantos = TextDrawCreate(10.0, 380.0, "Los Santos");
	ClassSel_InitCityNameText(txtLosSantos);
	txtSanFierro = TextDrawCreate(10.0, 380.0, "San Fierro");
	ClassSel_InitCityNameText(txtSanFierro);
	txtLasVenturas = TextDrawCreate(10.0, 380.0, "Las Venturas");
	ClassSel_InitCityNameText(txtLasVenturas);

    // Init our observer helper text display
	txtClassSelHelper = TextDrawCreate(10.0, 415.0,
	   " Press ~b~~k~~GO_LEFT~ ~w~or ~b~~k~~GO_RIGHT~ ~w~to switch cities.~n~ Press ~r~~k~~PED_FIREWEAPON~ ~w~to select.");
	TextDrawUseBox(txtClassSelHelper, 1);
	TextDrawBoxColor(txtClassSelHelper,0x222222BB);
	TextDrawLetterSize(txtClassSelHelper,0.3,1.0);
	TextDrawTextSize(txtClassSelHelper,400.0,40.0);
	TextDrawFont(txtClassSelHelper, 2);
	TextDrawSetShadow(txtClassSelHelper,0);
    TextDrawSetOutline(txtClassSelHelper,1);
    TextDrawBackgroundColor(txtClassSelHelper,0x000000FF);
    TextDrawColor(txtClassSelHelper,0xFFFFFFFF);
}

//----------------------------------------------------------

ClassSel_SetupSelectedCity(playerid)
{
	if(gPlayerCitySelection[playerid] == -1) {
		gPlayerCitySelection[playerid] = CITY_LOS_SANTOS;
	}
	
	if(gPlayerCitySelection[playerid] == CITY_LOS_SANTOS) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,1630.6136,-2286.0298,110.0);
		SetPlayerCameraLookAt(playerid,1887.6034,-1682.1442,47.6167);
		
		TextDrawShowForPlayer(playerid,txtLosSantos);
		TextDrawHideForPlayer(playerid,txtSanFierro);
		TextDrawHideForPlayer(playerid,txtLasVenturas);
	}
	else if(gPlayerCitySelection[playerid] == CITY_SAN_FIERRO) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,-1300.8754,68.0546,129.4823);
		SetPlayerCameraLookAt(playerid,-1817.9412,769.3878,132.6589);
		
		TextDrawHideForPlayer(playerid,txtLosSantos);
		TextDrawShowForPlayer(playerid,txtSanFierro);
		TextDrawHideForPlayer(playerid,txtLasVenturas);
	}
	else if(gPlayerCitySelection[playerid] == CITY_LAS_VENTURAS) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,1310.6155,1675.9182,110.7390);
		SetPlayerCameraLookAt(playerid,2285.2944,1919.3756,68.2275);
		
		TextDrawHideForPlayer(playerid,txtLosSantos);
		TextDrawHideForPlayer(playerid,txtSanFierro);
		TextDrawShowForPlayer(playerid,txtLasVenturas);
	}
}

//----------------------------------------------------------

ClassSel_SwitchToNextCity(playerid)
{
    gPlayerCitySelection[playerid]++;
	if(gPlayerCitySelection[playerid] > CITY_LAS_VENTURAS) {
	    gPlayerCitySelection[playerid] = CITY_LOS_SANTOS;
	}
	PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();
	ClassSel_SetupSelectedCity(playerid);
}

//----------------------------------------------------------

ClassSel_SwitchToPreviousCity(playerid)
{
    gPlayerCitySelection[playerid]--;
	if(gPlayerCitySelection[playerid] < CITY_LOS_SANTOS) {
	    gPlayerCitySelection[playerid] = CITY_LAS_VENTURAS;
	}
	PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();
	ClassSel_SetupSelectedCity(playerid);
}

//----------------------------------------------------------

ClassSel_HandleCitySelection(playerid)
{
	new Keys,ud,lr;
    GetPlayerKeys(playerid,Keys,ud,lr);
    
    if(gPlayerCitySelection[playerid] == -1) {
		ClassSel_SwitchToNextCity(playerid);
		return;
	}

	// only allow new selection every ~500 ms
	if( (GetTickCount() - gPlayerLastCitySelectionTick[playerid]) < 500 ) return;
	
	if(Keys & KEY_FIRE) {
	    gPlayerHasCitySelected[playerid] = 1;
	    TextDrawHideForPlayer(playerid,txtClassSelHelper);
		TextDrawHideForPlayer(playerid,txtLosSantos);
		TextDrawHideForPlayer(playerid,txtSanFierro);
		TextDrawHideForPlayer(playerid,txtLasVenturas);
	    TogglePlayerSpectating(playerid,0);
	    return;
	}
	
	if(lr > 0) {
	   ClassSel_SwitchToNextCity(playerid);
	}
	else if(lr < 0) {
	   ClassSel_SwitchToPreviousCity(playerid);
	}
}

//----------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid)) return 1;

	if(gPlayerHasCitySelected[playerid]) {
		ClassSel_SetupCharSelection(playerid);
		return 1;
	} else {
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) {
			TogglePlayerSpectating(playerid,1);
    		TextDrawShowForPlayer(playerid, txtClassSelHelper);
    		gPlayerCitySelection[playerid] = -1;
		}
  	}
    
	return 0;
}

//----------------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("Grand Larceny");
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	ShowNameTags(1);
	SetNameTagDrawDistance(40.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetWeather(2);
	SetWorldTime(11);

	UsePlayerPedAnims();
	//ManualVehicleEngineAndLights();
	//LimitGlobalChatRadius(300.0);
	
	ClassSel_InitTextDraws();

	// Player Class
	AddPlayerClass(281,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(282,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(283,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(284,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(285,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(286,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(287,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(288,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(289,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(265,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(266,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(267,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(268,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(269,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(270,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(1,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(2,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(3,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(4,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(5,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(6,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(8,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(42,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(65,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	//AddPlayerClass(74,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(86,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(119,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
 	AddPlayerClass(149,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(208,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(273,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(289,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	
	AddPlayerClass(47,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(48,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(49,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(50,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(51,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(52,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(53,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(54,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(55,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(56,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(57,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(58,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
   	AddPlayerClass(68,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(69,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(70,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(71,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(72,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(73,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(75,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(76,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(78,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(79,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(80,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(81,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(82,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(83,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(84,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(85,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(87,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(88,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(89,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(91,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(92,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(93,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(95,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(96,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(97,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(98,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(99,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);

	// SPECIAL
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/trains.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/pilots.txt");

   	// LAS VENTURAS
     total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_gen.txt");
    
    // SAN FIERRO
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/sf_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/sf_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/sf_gen.txt");
    
    // LOS SANTOS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_gen_inner.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_gen_outer.txt");
    
    // OTHER AREAS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/whetstone.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/bone.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/flint.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/tierra.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/red_county.txt");

    printf("Total vehicles from files: %d",total_vehicles_from_files);

	return 1;
}

//----------------------------------------------------------

public OnPlayerUpdate(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(IsPlayerNPC(playerid)) return 1;

	// changing cities by inputs
	if( !gPlayerHasCitySelected[playerid] &&
	    GetPlayerState(playerid) == PLAYER_STATE_SPECTATING ) {
	    ClassSel_HandleCitySelection(playerid);
	    return 1;
	}
	
	// No weapons in interiors
	if(GetPlayerInterior(playerid) != 0 && GetPlayerWeapon(playerid) != 0) {
	    SetPlayerArmedWeapon(playerid,0); // fists
	    return 0; // no syncing until they change their weapon
	}
	
	// Don't allow minigun
	if(GetPlayerWeapon(playerid) == WEAPON_MINIGUN) {
	    Kick(playerid);
	    return 0;
	}
	
	/* No jetpacks allowed
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
	    Kick(playerid);
	    return 0;
	}*/

	/* For testing animations
    new msg[128+1];
	new animlib[32+1];
	new animname[32+1];

	thisanimid = GetPlayerAnimationIndex(playerid);
	if(lastanimid != thisanimid)
	{
		GetAnimationName(thisanimid,animlib,32,animname,32);
		format(msg, 128, "anim(%d,%d): %s %s", lastanimid, thisanimid, animlib, animname);
		lastanimid = thisanimid;
		SendClientMessage(playerid, 0xFFFFFFFF, msg);
	}*/

	return 1;
}


timer Sobeit_Check[5](playerid)
{
    GetPlayerPos(playerid,pPos[0],pPos[1],pPos[2]);

    createCar = AddStaticVehicleEx ( 457, pPos[0],pPos[1],pPos[2],180.0, random(200), random(200), 15 );
    PutPlayerInVehicle(playerid, createCar, 0);

    defer Sobeit_Check_1(playerid);
	return (true);
}

timer Sobeit_Check_1[5](playerid)
{
    RemovePlayerFromVehicle(playerid);
    DestroyVehicle(createCar);

    defer Sobeit_Check_2(playerid);
	return (true);
}

timer Sobeit_Check_2[150](playerid)
{
	if(FindWeapon(playerid,2))
	{
		SendClientMessage(playerid,-1,"{FC586E}Nas sobeit detector je otkrio da posjedujete ovaj cheat!");
	}
	return (true);
}

timer Ban_Kick[500](playerid)
{
	Ban(playerid);
	return (true);
}

stock FindWeapon(playerid, weaponid)
{
	new
	    weapon,
	    ammo;

	for (new i = 0; i < 13; i ++)
	{
	    GetPlayerWeaponData(playerid, i, weapon, ammo);
	    if (weapon == weaponid) return (true);
	}
	return (false);
}

stock CreateTextdraws(playerid)
{
    Login_TD[0][playerid] = CreatePlayerTextDraw(playerid,217.000000, 13.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[0][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[0][playerid], 0.000000, 5.399999);
	PlayerTextDrawColor(playerid,Login_TD[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[0][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[0][playerid], 926365495);
	PlayerTextDrawTextSize(playerid,Login_TD[0][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[0][playerid], 0);

	Login_TD[1][playerid] = CreatePlayerTextDraw(playerid,217.000000, 136.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[1][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[1][playerid], 0.000000, 1.999999);
	PlayerTextDrawColor(playerid,Login_TD[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[1][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[1][playerid], 926365495);
	PlayerTextDrawTextSize(playerid,Login_TD[1][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[1][playerid], 0);

	Login_TD[2][playerid] = CreatePlayerTextDraw(playerid,217.000000, 198.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[2][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[2][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[2][playerid], 0.000000, 1.999999);
	PlayerTextDrawColor(playerid,Login_TD[2][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[2][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[2][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[2][playerid], 926365495);
	PlayerTextDrawTextSize(playerid,Login_TD[2][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[2][playerid], 0);

	Login_TD[3][playerid] = CreatePlayerTextDraw(playerid,181.000000, 148.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[3][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[3][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[3][playerid], 0.000000, 0.699999);
	PlayerTextDrawColor(playerid,Login_TD[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[3][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[3][playerid], 757935405);
	PlayerTextDrawTextSize(playerid,Login_TD[3][playerid], 54.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[3][playerid], 0);

	Login_TD[4][playerid] = CreatePlayerTextDraw(playerid,84.000000, 147.000000, "password");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[4][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[4][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Login_TD[4][playerid], 0.290000, 1.300000);
	PlayerTextDrawColor(playerid,Login_TD[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[4][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[4][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Login_TD[4][playerid], true);

	Login_TD[5][playerid] = CreatePlayerTextDraw(playerid,99.000000, 208.000000, "login");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[5][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[5][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Login_TD[5][playerid], 0.290000, 1.300000);
	PlayerTextDrawColor(playerid,Login_TD[5][playerid], -527348481);
	PlayerTextDrawSetOutline(playerid,Login_TD[5][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[5][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Login_TD[5][playerid], true);

	Login_TD[6][playerid] = CreatePlayerTextDraw(playerid,181.000000, 208.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[6][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[6][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[6][playerid], 0.000000, 0.699999);
	PlayerTextDrawColor(playerid,Login_TD[6][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[6][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[6][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[6][playerid], 757935405);
	PlayerTextDrawTextSize(playerid,Login_TD[6][playerid], 54.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[6][playerid], 0);

	Login_TD[7][playerid] = CreatePlayerTextDraw(playerid,81.000000, 24.000000, "BALKAN");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[7][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[7][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Login_TD[7][playerid], 0.490000, 3.199999);
	PlayerTextDrawColor(playerid,Login_TD[7][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[7][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[7][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[7][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Login_TD[7][playerid], 0);

	Login_TD[8][playerid] = CreatePlayerTextDraw(playerid,88.000000, 46.000000, "RISING");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[8][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[8][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Login_TD[8][playerid], 0.490000, 3.199999);
	PlayerTextDrawColor(playerid,Login_TD[8][playerid], -527348481);
	PlayerTextDrawSetOutline(playerid,Login_TD[8][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[8][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[8][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Login_TD[8][playerid], 0);

	Login_TD[9][playerid] = CreatePlayerTextDraw(playerid,43.000000, 99.000000, "www.balkan-rising.com");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[9][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[9][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Login_TD[9][playerid], 0.290000, 1.300000);
	PlayerTextDrawColor(playerid,Login_TD[9][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[9][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[9][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[9][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Login_TD[9][playerid], 0);

	Login_TD[10][playerid] = CreatePlayerTextDraw(playerid,149.000000, 68.000000, "x1.0");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[10][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[10][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Login_TD[10][playerid], 0.360000, 1.800000);
	PlayerTextDrawColor(playerid,Login_TD[10][playerid], -527348481);
	PlayerTextDrawSetOutline(playerid,Login_TD[10][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[10][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[10][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Login_TD[10][playerid], 0);

	Login_TD[11][playerid] = CreatePlayerTextDraw(playerid,217.000000, 197.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[11][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[11][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[11][playerid], 0.000000, -0.100000);
	PlayerTextDrawColor(playerid,Login_TD[11][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[11][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[11][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[11][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[11][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[11][playerid], 255);
	PlayerTextDrawTextSize(playerid,Login_TD[11][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[11][playerid], 0);

	Login_TD[12][playerid] = CreatePlayerTextDraw(playerid,217.000000, 236.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[12][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[12][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[12][playerid], 0.000000, -0.100000);
	PlayerTextDrawColor(playerid,Login_TD[12][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[12][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[12][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[12][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[12][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[12][playerid], 255);
	PlayerTextDrawTextSize(playerid,Login_TD[12][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[12][playerid], 0);

	Login_TD[13][playerid] = CreatePlayerTextDraw(playerid,217.000000, 174.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[13][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[13][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[13][playerid], 0.000000, -0.100000);
	PlayerTextDrawColor(playerid,Login_TD[13][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[13][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[13][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[13][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[13][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[13][playerid], 255);
	PlayerTextDrawTextSize(playerid,Login_TD[13][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[13][playerid], 0);

	Login_TD[14][playerid] = CreatePlayerTextDraw(playerid,217.000000, 136.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[14][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[14][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[14][playerid], 0.000000, -0.100000);
	PlayerTextDrawColor(playerid,Login_TD[14][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[14][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[14][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[14][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[14][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[14][playerid], 255);
	PlayerTextDrawTextSize(playerid,Login_TD[14][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[14][playerid], 0);

	Login_TD[15][playerid] = CreatePlayerTextDraw(playerid,217.000000, 113.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[15][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[15][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[15][playerid], 0.000000, -0.100000);
	PlayerTextDrawColor(playerid,Login_TD[15][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[15][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[15][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[15][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[15][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[15][playerid], 255);
	PlayerTextDrawTextSize(playerid,Login_TD[15][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[15][playerid], 0);

	Login_TD[16][playerid] = CreatePlayerTextDraw(playerid,217.000000, 12.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,Login_TD[16][playerid], 255);
	PlayerTextDrawFont(playerid,Login_TD[16][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Login_TD[16][playerid], 0.000000, -0.100000);
	PlayerTextDrawColor(playerid,Login_TD[16][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Login_TD[16][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Login_TD[16][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Login_TD[16][playerid], 1);
	PlayerTextDrawUseBox(playerid,Login_TD[16][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Login_TD[16][playerid], 255);
	PlayerTextDrawTextSize(playerid,Login_TD[16][playerid], 13.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Login_TD[16][playerid], 0);
	return (true);
}
//----------------------------------------------------------
public OnPlayerClickTextDraw(playerid, Text:clickedid){

     if(clickedid == Text:INVALID_TEXT_DRAW)
     {
		SelectTextDraw(playerid,(0x52734848));
     }
	 return (true);
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid){

      if(_:playertextid != INVALID_TEXT_DRAW)
	  {
			   if(playertextid == Login_TD[4][playerid])
			   {
                       SendClientMessage(playerid,-1,"Popusi mi kurac Lukenzi.");
                       CancelSelectTextDraw(playerid);
			   }
			   else if(playertextid == RLogin_TD[5][playerid])
			   {
                       SendClientMessage(playerid,-1,"Popusi mi kurac Doz-e.");
                       CancelSelectTextDraw(playerid);
			   }

      }
	  return (true);
}

stock RegisterPanel(playerid,opcija)
{
	if(opcija == 1)
	{
		for(new i = 0; i < 17; ++i)
        PlayerTextDrawShow(playerid,Login_TD[i][playerid]); SelectTextDraw(playerid,(0x52734848));
	}
	else if(opcija == 2)
	{
        for(new i = 0; i < 17; ++i)
        PlayerTextDrawHide(playerid,Login_TD[i][playerid]); CancelSelectTextDraw(playerid);
	}
	return (true);
}

