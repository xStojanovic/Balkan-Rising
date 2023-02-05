#include <YSI\y_hooks>

//================================================
/*
                 Balkan Rising
                   0.0.1x
               Server Protection
*/
//================================================

new createCar[MAX_PLAYERS];
static Float:pPos[3],string[128],PlayerIP[16];

//================================================

hook OnPlayerSpawn(playerid){
	defer Sobeit_Check(playerid);
	return (true);
}

//================================================

timer Sobeit_Check[5](playerid)
{
    GetPlayerPos(playerid,pPos[0],pPos[1],pPos[2]);

    createCar[playerid] = AddStaticVehicleEx (457, pPos[0],pPos[1],pPos[2],180.0, random(200), random(200), 15);
    PutPlayerInVehicle(playerid, createCar[playerid], 0);

    defer Sobeit_Check_1(playerid);
	return (true);
}

//================================================

timer Sobeit_Check_1[5](playerid)
{
    RemovePlayerFromVehicle(playerid);
    DestroyVehicle(createCar[playerid]);

    defer Sobeit_Check_2(playerid);
	return (true);
}

//================================================

timer Sobeit_Check_2[500](playerid)
{
	if(FindWeapon(playerid,2)){
		GetPlayerIp(playerid,PlayerIP,sizeof(PlayerIP));
		PlayerBan(PlayerIP,GetName(playerid),"Server","Cheat detected");
		BanString(playerid,"Server",GetName(playerid),"Cheat detected");
		BanTextdraws(playerid,1);

		TogglePlayerSpectating(playerid, (true));
	    InterpolateCameraPos(playerid, 2301.460205, -850.211303, 158.525146, 2840.348632, -1409.012695, 158.525146, 70000);
	    InterpolateCameraLookAt(playerid, 2300.764404, -855.068176, 157.562438, 2835.906738, -1411.096557, 157.562438, 70000); 

		format(string, sizeof(string),"{F77E7E}[!]staffwarning - %s banovan od AntiCheat-a.",GetName(playerid));
		StaffMessage(-1,string);
	    defer Ban_Kick(playerid);  
    }
	return (true);
}

//================================================

stock FindWeapon(playerid, weaponid)
{
	new opcija[2];

	for (new i = 0; i < 13; i ++) 
	{
	    GetPlayerWeaponData(playerid, i, opcija[0], opcija[1]);
	    if (opcija[0] == weaponid) return (true);
	}
	return (false);
}              

//=================================================
