#include <YSI\y_hooks>

//==============================================================================
/*
                   Balkan Rising
                     0.0.1x
                    Textdraws
*/
//==============================================================================

hook OnPlayerConnect(playerid){
     CreatePlayerTD(playerid);
     return (true);
}

hook OnGameModeInit(){
	CreateGlobalTextdraws();
	return (true);
}	

//==============================================================================

stock CreatePlayerTD(playerid){

// register textdraws
Register_TD[0][playerid] = CreatePlayerTextDraw(playerid,230.000000, 0.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[0][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[0][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[0][playerid], 0.300000, 50.000000);
PlayerTextDrawColor(playerid,Register_TD[0][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[0][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[0][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[0][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[0][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[0][playerid], -1347440828);
PlayerTextDrawTextSize(playerid,Register_TD[0][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[0][playerid], 0);

Register_TD[1][playerid] = CreatePlayerTextDraw(playerid,230.000000, 190.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[1][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[1][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[1][playerid], 0.300000, 2.000000);
PlayerTextDrawColor(playerid,Register_TD[1][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[1][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[1][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[1][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[1][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[1][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[1][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[1][playerid], 0);

Register_TD[2][playerid] = CreatePlayerTextDraw(playerid,107.000000, 194.000000, "REGISTRACIJA");
PlayerTextDrawBackgroundColor(playerid,Register_TD[2][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[2][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[2][playerid], 0.180000, 1.100000);
PlayerTextDrawColor(playerid,Register_TD[2][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[2][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[2][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[2][playerid], true);

Register_TD[3][playerid] = CreatePlayerTextDraw(playerid,230.000000, 7.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[3][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[3][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[3][playerid], 0.000000, 4.199997);
PlayerTextDrawColor(playerid,Register_TD[3][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[3][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[3][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[3][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[3][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[3][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[3][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[3][playerid], 0);

Register_TD[4][playerid] = CreatePlayerTextDraw(playerid,230.000000, 215.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[4][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[4][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[4][playerid], 0.300000, 2.000000);
PlayerTextDrawColor(playerid,Register_TD[4][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[4][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[4][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[4][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[4][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[4][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[4][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[4][playerid], 0);

Register_TD[5][playerid] = CreatePlayerTextDraw(playerid,103.000000, 219.000000, "Prijavljivanje");
PlayerTextDrawBackgroundColor(playerid,Register_TD[5][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[5][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[5][playerid], 0.180000, 1.100000);
PlayerTextDrawColor(playerid,Register_TD[5][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[5][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[5][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[5][playerid], true);

Register_TD[6][playerid] = CreatePlayerTextDraw(playerid,84.000000, 18.000000, "Balkan");
PlayerTextDrawBackgroundColor(playerid,Register_TD[6][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[6][playerid], 3);
PlayerTextDrawLetterSize(playerid,Register_TD[6][playerid], 0.289999, 1.399999);
PlayerTextDrawColor(playerid,Register_TD[6][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[6][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[6][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[6][playerid], 0);

Register_TD[8][playerid] = CreatePlayerTextDraw(playerid,230.000000, 240.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[8][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[8][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[8][playerid], 0.300000, 2.000000);
PlayerTextDrawColor(playerid,Register_TD[8][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[8][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[8][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[8][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[8][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[8][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[8][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[8][playerid], 0);

Register_TD[9][playerid] = CreatePlayerTextDraw(playerid,113.000000, 245.000000, "Tutorial");
PlayerTextDrawBackgroundColor(playerid,Register_TD[9][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[9][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[9][playerid], 0.180000, 1.100000);
PlayerTextDrawColor(playerid,Register_TD[9][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[9][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[9][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[9][playerid], true);

Register_TD[10][playerid] = CreatePlayerTextDraw(playerid,230.000000, 265.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[10][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[10][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[10][playerid], 0.300000, 2.000000);
PlayerTextDrawColor(playerid,Register_TD[10][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[10][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[10][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[10][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[10][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[10][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[10][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[10][playerid], 0);

Register_TD[11][playerid] = CreatePlayerTextDraw(playerid,108.000000, 269.000000, "Informacije");
PlayerTextDrawBackgroundColor(playerid,Register_TD[11][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[11][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[11][playerid], 0.180000, 1.100000);
PlayerTextDrawColor(playerid,Register_TD[11][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[11][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[11][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[11][playerid], true);

Register_TD[12][playerid] = CreatePlayerTextDraw(playerid,230.000000, 290.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[12][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[12][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[12][playerid], 0.300000, 2.000000);
PlayerTextDrawColor(playerid,Register_TD[12][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[12][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[12][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[12][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[12][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[12][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[12][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[12][playerid], 0);

Register_TD[13][playerid] = CreatePlayerTextDraw(playerid,115.000000, 294.000000, "CREDITS");
PlayerTextDrawBackgroundColor(playerid,Register_TD[13][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[13][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[13][playerid], 0.180000, 1.100000);
PlayerTextDrawColor(playerid,Register_TD[13][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[13][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[13][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[13][playerid], true);

Register_TD[14][playerid] = CreatePlayerTextDraw(playerid,230.000000, 315.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[14][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[14][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[14][playerid], 0.300000, 2.000000);
PlayerTextDrawColor(playerid,Register_TD[14][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[14][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[14][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[14][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[14][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[14][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[14][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[14][playerid], 0);

Register_TD[15][playerid] = CreatePlayerTextDraw(playerid,119.000000, 319.000000, "Izlaz");
PlayerTextDrawBackgroundColor(playerid,Register_TD[15][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[15][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[15][playerid], 0.180000, 1.100000);
PlayerTextDrawColor(playerid,Register_TD[15][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[15][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[15][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[15][playerid], true);

Register_TD[16][playerid] = CreatePlayerTextDraw(playerid,230.000000, 83.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[16][playerid], 255);
PlayerTextDrawFont(playerid,Register_TD[16][playerid], 1);
PlayerTextDrawLetterSize(playerid,Register_TD[16][playerid], 0.000000, 9.000000);
PlayerTextDrawColor(playerid,Register_TD[16][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[16][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[16][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[16][playerid], 1);
PlayerTextDrawUseBox(playerid,Register_TD[16][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[16][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[16][playerid], 40.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[16][playerid], 0);

Register_TD[17][playerid] = CreatePlayerTextDraw(playerid,58.000000, 98.000000, "Hector_Jeferson");
PlayerTextDrawBackgroundColor(playerid,Register_TD[17][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[17][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[17][playerid], 0.150000, 0.899999);
PlayerTextDrawColor(playerid,Register_TD[17][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[17][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[17][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[17][playerid], 0);

Register_TD[18][playerid] = CreatePlayerTextDraw(playerid,58.000000, 108.000000, "1000$");
PlayerTextDrawBackgroundColor(playerid,Register_TD[18][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[18][playerid], 2);
PlayerTextDrawLetterSize(playerid,Register_TD[18][playerid], 0.150000, 0.899999);
PlayerTextDrawColor(playerid,Register_TD[18][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[18][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[18][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[18][playerid], 0);

Register_TD[19][playerid] = CreatePlayerTextDraw(playerid,150.000000, 18.000000, "Rising");
PlayerTextDrawBackgroundColor(playerid,Register_TD[19][playerid], 51);
PlayerTextDrawFont(playerid,Register_TD[19][playerid], 3);
PlayerTextDrawLetterSize(playerid,Register_TD[19][playerid], 0.289999, 1.399999);
PlayerTextDrawColor(playerid,Register_TD[19][playerid], -527348481);
PlayerTextDrawSetOutline(playerid,Register_TD[19][playerid], 1);
PlayerTextDrawSetProportional(playerid,Register_TD[19][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Register_TD[19][playerid], 0);

Register_TD[20][playerid] = CreatePlayerTextDraw(playerid,167.000000, 83.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Register_TD[20][playerid], (0x00000000));
PlayerTextDrawFont(playerid,Register_TD[20][playerid], 5);
PlayerTextDrawLetterSize(playerid,Register_TD[20][playerid], 0.000000, 9.000000);
PlayerTextDrawColor(playerid,Register_TD[20][playerid], -1);
PlayerTextDrawSetOutline(playerid,Register_TD[20][playerid], 0);
PlayerTextDrawSetProportional(playerid,Register_TD[20][playerid], 1);
PlayerTextDrawSetShadow(playerid,Register_TD[20][playerid], 1);
PlayerTextDrawBoxColor(playerid,Register_TD[20][playerid], 170);
PlayerTextDrawTextSize(playerid,Register_TD[20][playerid], 70.000000, 81.000000);
PlayerTextDrawSetSelectable(playerid,Register_TD[20][playerid], 0);
// ban textdraws
Ban_TD[0][playerid] = CreatePlayerTextDraw(playerid,440.000000, 129.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[0][playerid], 255);
PlayerTextDrawFont(playerid,Ban_TD[0][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[0][playerid], 0.500000, 15.199999);
PlayerTextDrawColor(playerid,Ban_TD[0][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[0][playerid], 0);
PlayerTextDrawSetProportional(playerid,Ban_TD[0][playerid], 1);
PlayerTextDrawSetShadow(playerid,Ban_TD[0][playerid], 1);
PlayerTextDrawUseBox(playerid,Ban_TD[0][playerid], 1);
PlayerTextDrawBoxColor(playerid,Ban_TD[0][playerid], 85);
PlayerTextDrawTextSize(playerid,Ban_TD[0][playerid], 180.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Ban_TD[0][playerid], 0);

Ban_TD[1][playerid] = CreatePlayerTextDraw(playerid,439.000000, 130.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[1][playerid], 255);
PlayerTextDrawFont(playerid,Ban_TD[1][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[1][playerid], 0.300000, -0.599997);
PlayerTextDrawColor(playerid,Ban_TD[1][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[1][playerid], 0);
PlayerTextDrawSetProportional(playerid,Ban_TD[1][playerid], 1);
PlayerTextDrawSetShadow(playerid,Ban_TD[1][playerid], 1);
PlayerTextDrawUseBox(playerid,Ban_TD[1][playerid], 1);
PlayerTextDrawBoxColor(playerid,Ban_TD[1][playerid], 170);
PlayerTextDrawTextSize(playerid,Ban_TD[1][playerid], 180.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Ban_TD[1][playerid], 0);

Ban_TD[2][playerid] = CreatePlayerTextDraw(playerid,200.000000, 150.000000, "Korisnik:");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[2][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[2][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[2][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[2][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[2][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[2][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[2][playerid], 0);

Ban_TD[3][playerid] = CreatePlayerTextDraw(playerid,234.000000, 150.000000, "Hector_Jeferson");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[3][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[3][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[3][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[3][playerid], -5373697);
PlayerTextDrawSetOutline(playerid,Ban_TD[3][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[3][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[3][playerid], 0);

Ban_TD[4][playerid] = CreatePlayerTextDraw(playerid,199.000000, 170.000000, "Administrator:");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[4][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[4][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[4][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[4][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[4][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[4][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[4][playerid], 0);

Ban_TD[5][playerid] = CreatePlayerTextDraw(playerid,254.000000, 170.000000, "Hector_Jeferson");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[5][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[5][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[5][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[5][playerid], -5373697);
PlayerTextDrawSetOutline(playerid,Ban_TD[5][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[5][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[5][playerid], 0);

Ban_TD[6][playerid] = CreatePlayerTextDraw(playerid,200.000000, 190.000000, "Datum:");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[6][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[6][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[6][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[6][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[6][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[6][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[6][playerid], 0);

Ban_TD[7][playerid] = CreatePlayerTextDraw(playerid,227.000000, 190.000000, "13/8/1998");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[7][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[7][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[7][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[7][playerid], -5373697);
PlayerTextDrawSetOutline(playerid,Ban_TD[7][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[7][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[7][playerid], 0);

Ban_TD[8][playerid] = CreatePlayerTextDraw(playerid,200.000000, 210.000000, "Razlog:");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[8][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[8][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[8][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[8][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[8][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[8][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[8][playerid], 0);

Ban_TD[9][playerid] = CreatePlayerTextDraw(playerid,228.000000, 210.000000, "Pusi kurac");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[9][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[9][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[9][playerid], 0.209999, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[9][playerid], -5373697);
PlayerTextDrawSetOutline(playerid,Ban_TD[9][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[9][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[9][playerid], 0);

Ban_TD[10][playerid] = CreatePlayerTextDraw(playerid,440.000000, 256.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[10][playerid], 255);
PlayerTextDrawFont(playerid,Ban_TD[10][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[10][playerid], 0.500000, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[10][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[10][playerid], 0);
PlayerTextDrawSetProportional(playerid,Ban_TD[10][playerid], 1);
PlayerTextDrawSetShadow(playerid,Ban_TD[10][playerid], 1);
PlayerTextDrawUseBox(playerid,Ban_TD[10][playerid], 1);
PlayerTextDrawBoxColor(playerid,Ban_TD[10][playerid], 85);
PlayerTextDrawTextSize(playerid,Ban_TD[10][playerid], 180.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Ban_TD[10][playerid], 0);

Ban_TD[11][playerid] = CreatePlayerTextDraw(playerid,193.000000, 255.000000, "Ako mislite da je doslo do nekog vida pogreske obratite nam se na forum.");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[11][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[11][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[11][playerid], 0.180000, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[11][playerid], -16776961);
PlayerTextDrawSetOutline(playerid,Ban_TD[11][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[11][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[11][playerid], 0);

Ban_TD[12][playerid] = CreatePlayerTextDraw(playerid,440.000000, 129.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[12][playerid], 255);
PlayerTextDrawFont(playerid,Ban_TD[12][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[12][playerid], 0.500000, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[12][playerid], -1);
PlayerTextDrawSetOutline(playerid,Ban_TD[12][playerid], 0);
PlayerTextDrawSetProportional(playerid,Ban_TD[12][playerid], 1);
PlayerTextDrawSetShadow(playerid,Ban_TD[12][playerid], 1);
PlayerTextDrawUseBox(playerid,Ban_TD[12][playerid], 1);
PlayerTextDrawBoxColor(playerid,Ban_TD[12][playerid], 85);
PlayerTextDrawTextSize(playerid,Ban_TD[12][playerid], 180.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Ban_TD[12][playerid], 0);

Ban_TD[13][playerid] = CreatePlayerTextDraw(playerid,290.000000, 128.000000, "Ban Info:");
PlayerTextDrawBackgroundColor(playerid,Ban_TD[13][playerid], 51);
PlayerTextDrawFont(playerid,Ban_TD[13][playerid], 1);
PlayerTextDrawLetterSize(playerid,Ban_TD[13][playerid], 0.180000, 1.000000);
PlayerTextDrawColor(playerid,Ban_TD[13][playerid], -16776961);
PlayerTextDrawSetOutline(playerid,Ban_TD[13][playerid], 1);
PlayerTextDrawSetProportional(playerid,Ban_TD[13][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Ban_TD[13][playerid], 0);
// cos td
Cos_TD[0][playerid] = CreatePlayerTextDraw(playerid,500.000000, 350.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Cos_TD[0][playerid], 255);
PlayerTextDrawFont(playerid,Cos_TD[0][playerid], 1);
PlayerTextDrawLetterSize(playerid,Cos_TD[0][playerid], 0.500000, 11.000000);
PlayerTextDrawColor(playerid,Cos_TD[0][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[0][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[0][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[0][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[0][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[0][playerid], 102);
PlayerTextDrawTextSize(playerid,Cos_TD[0][playerid], 170.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[0][playerid], 0);

Cos_TD[1][playerid] = CreatePlayerTextDraw(playerid,500.000000, 350.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Cos_TD[1][playerid], 255);
PlayerTextDrawFont(playerid,Cos_TD[1][playerid], 1);
PlayerTextDrawLetterSize(playerid,Cos_TD[1][playerid], 0.500000, -0.600000);
PlayerTextDrawColor(playerid,Cos_TD[1][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[1][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[1][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[1][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[1][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[1][playerid], 170);
PlayerTextDrawTextSize(playerid,Cos_TD[1][playerid], 170.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[1][playerid], 0);

Cos_TD[2][playerid] = CreatePlayerTextDraw(playerid,174.000000, 349.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Cos_TD[2][playerid], 255);
PlayerTextDrawFont(playerid,Cos_TD[2][playerid], 1);
PlayerTextDrawLetterSize(playerid,Cos_TD[2][playerid], 0.500000, 11.399998);
PlayerTextDrawColor(playerid,Cos_TD[2][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[2][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[2][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[2][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[2][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[2][playerid], 170);
PlayerTextDrawTextSize(playerid,Cos_TD[2][playerid], 170.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[2][playerid], 0);

Cos_TD[3][playerid] = CreatePlayerTextDraw(playerid,499.000000, 349.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Cos_TD[3][playerid], 255);
PlayerTextDrawFont(playerid,Cos_TD[3][playerid], 1);
PlayerTextDrawLetterSize(playerid,Cos_TD[3][playerid], 0.500000, 11.399998);
PlayerTextDrawColor(playerid,Cos_TD[3][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[3][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[3][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[3][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[3][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[3][playerid], 170);
PlayerTextDrawTextSize(playerid,Cos_TD[3][playerid], 495.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[3][playerid], 0);

Cos_TD[4][playerid] = CreatePlayerTextDraw(playerid,356.000000, 434.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Cos_TD[4][playerid], 255);
PlayerTextDrawFont(playerid,Cos_TD[4][playerid], 1);
PlayerTextDrawLetterSize(playerid,Cos_TD[4][playerid], 0.500000, 1.000000);
PlayerTextDrawColor(playerid,Cos_TD[4][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[4][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[4][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[4][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[4][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[4][playerid], 102);
PlayerTextDrawTextSize(playerid,Cos_TD[4][playerid], 308.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[4][playerid], 0);

Cos_TD[5][playerid] = CreatePlayerTextDraw(playerid,332.000000, 434.000000, "Buy Vehicle");
PlayerTextDrawAlignment(playerid,Cos_TD[5][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Cos_TD[5][playerid], 51);
PlayerTextDrawFont(playerid,Cos_TD[5][playerid], 2);
PlayerTextDrawLetterSize(playerid,Cos_TD[5][playerid], 0.139999, 0.899996);
PlayerTextDrawColor(playerid,Cos_TD[5][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[5][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[5][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[5][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Cos_TD[5][playerid], 1);

Cos_TD[6][playerid] = CreatePlayerTextDraw(playerid,500.000000, 434.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Cos_TD[6][playerid], 255);
PlayerTextDrawFont(playerid,Cos_TD[6][playerid], 1);
PlayerTextDrawLetterSize(playerid,Cos_TD[6][playerid], 0.500000, -0.600000);
PlayerTextDrawColor(playerid,Cos_TD[6][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[6][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[6][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[6][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[6][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[6][playerid], 170);
PlayerTextDrawTextSize(playerid,Cos_TD[6][playerid], 170.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[6][playerid], 0);

Cos_TD[7][playerid] = CreatePlayerTextDraw(playerid,372.000000, 415.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Cos_TD[7][playerid], 255);
PlayerTextDrawFont(playerid,Cos_TD[7][playerid], 1);
PlayerTextDrawLetterSize(playerid,Cos_TD[7][playerid], 0.500000, 1.000000);
PlayerTextDrawColor(playerid,Cos_TD[7][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[7][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[7][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[7][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[7][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[7][playerid], 102);
PlayerTextDrawTextSize(playerid,Cos_TD[7][playerid], 296.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[7][playerid], 0);

Cos_TD[8][playerid] = CreatePlayerTextDraw(playerid,335.000000, 414.000000, "Infernus");
PlayerTextDrawAlignment(playerid,Cos_TD[8][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Cos_TD[8][playerid], 51);
PlayerTextDrawFont(playerid,Cos_TD[8][playerid], 2);
PlayerTextDrawLetterSize(playerid,Cos_TD[8][playerid], 0.140000, 0.999998);
PlayerTextDrawColor(playerid,Cos_TD[8][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[8][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[8][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[8][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Cos_TD[8][playerid], 0);

Cos_TD[9][playerid] = CreatePlayerTextDraw(playerid,299.000000, 353.000000, "previev model");
PlayerTextDrawAlignment(playerid,Cos_TD[9][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Cos_TD[9][playerid], 51);
PlayerTextDrawFont(playerid,Cos_TD[9][playerid], 5);
PlayerTextDrawLetterSize(playerid,Cos_TD[9][playerid], 0.140000, 4.900000);
PlayerTextDrawColor(playerid,Cos_TD[9][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[9][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[9][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[9][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[9][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[9][playerid], 255);
PlayerTextDrawTextSize(playerid,Cos_TD[9][playerid], 70.000000, 60.000000);
PlayerTextDrawSetPreviewModel(playerid, Cos_TD[9][playerid], 411);
PlayerTextDrawSetPreviewRot(playerid, Cos_TD[9][playerid], -16.000000, 0.000000, -55.000000, 1.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[9][playerid], 0);

Cos_TD[10][playerid] = CreatePlayerTextDraw(playerid,186.000000, 353.000000, "nepotreban prev");
PlayerTextDrawAlignment(playerid,Cos_TD[10][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Cos_TD[10][playerid], 51);
PlayerTextDrawFont(playerid,Cos_TD[10][playerid], 5);
PlayerTextDrawLetterSize(playerid,Cos_TD[10][playerid], 0.140000, 4.900000);
PlayerTextDrawColor(playerid,Cos_TD[10][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[10][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[10][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[10][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[10][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[10][playerid], 255);
PlayerTextDrawTextSize(playerid,Cos_TD[10][playerid], 60.000000, 57.000000);
PlayerTextDrawSetPreviewModel(playerid, Cos_TD[10][playerid], 411);
PlayerTextDrawSetPreviewRot(playerid, Cos_TD[10][playerid], 500.000000, 500.000000, 500.000000, 1.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[10][playerid], 0);

Cos_TD[11][playerid] = CreatePlayerTextDraw(playerid,369.000000, 404.000000, "1,0000$");
PlayerTextDrawAlignment(playerid,Cos_TD[11][playerid], 3);
PlayerTextDrawBackgroundColor(playerid,Cos_TD[11][playerid], 51);
PlayerTextDrawFont(playerid,Cos_TD[11][playerid], 2);
PlayerTextDrawLetterSize(playerid,Cos_TD[11][playerid], 0.140000, 0.899999);
PlayerTextDrawColor(playerid,Cos_TD[11][playerid], 1640459775);
PlayerTextDrawSetOutline(playerid,Cos_TD[11][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[11][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[11][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Cos_TD[11][playerid], 0);

Cos_TD[12][playerid] = CreatePlayerTextDraw(playerid,425.000000, 353.000000, "nepotreban prev");
PlayerTextDrawAlignment(playerid,Cos_TD[12][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Cos_TD[12][playerid], 51);
PlayerTextDrawFont(playerid,Cos_TD[12][playerid], 5);
PlayerTextDrawLetterSize(playerid,Cos_TD[12][playerid], 0.140000, 4.900000);
PlayerTextDrawColor(playerid,Cos_TD[12][playerid], -1);
PlayerTextDrawSetOutline(playerid,Cos_TD[12][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[12][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[12][playerid], 1);
PlayerTextDrawUseBox(playerid,Cos_TD[12][playerid], 1);
PlayerTextDrawBoxColor(playerid,Cos_TD[12][playerid], 255);
PlayerTextDrawTextSize(playerid,Cos_TD[12][playerid], 60.000000, 57.000000);
PlayerTextDrawSetPreviewModel(playerid, Cos_TD[12][playerid], 411);
PlayerTextDrawSetPreviewRot(playerid, Cos_TD[12][playerid], 0.000000, 690.000000, 1000.000000, 1.000000);
PlayerTextDrawSetSelectable(playerid,Cos_TD[12][playerid], 0);

Cos_TD[13][playerid] = CreatePlayerTextDraw(playerid,365.000000, 353.000000, "4");
PlayerTextDrawAlignment(playerid,Cos_TD[13][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Cos_TD[13][playerid], 51);
PlayerTextDrawFont(playerid,Cos_TD[13][playerid], 2);
PlayerTextDrawLetterSize(playerid,Cos_TD[13][playerid], 0.140000, 0.899999);
PlayerTextDrawColor(playerid,Cos_TD[13][playerid], 1640459775);
PlayerTextDrawSetOutline(playerid,Cos_TD[13][playerid], 0);
PlayerTextDrawSetProportional(playerid,Cos_TD[13][playerid], 1);
PlayerTextDrawSetShadow(playerid,Cos_TD[13][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Cos_TD[13][playerid], 0);

//====================== speedo td-s
Speedo_TD[0][playerid] = CreatePlayerTextDraw(playerid,650.000000, 350.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[0][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[0][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[0][playerid], 0.500000, -0.500000);
PlayerTextDrawColor(playerid,Speedo_TD[0][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[0][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[0][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[0][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[0][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[0][playerid], 255);
PlayerTextDrawTextSize(playerid,Speedo_TD[0][playerid], 480.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[0][playerid], 0);

Speedo_TD[1][playerid] = CreatePlayerTextDraw(playerid,650.000000, 350.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[1][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[1][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[1][playerid], 0.500000, 8.500000);
PlayerTextDrawColor(playerid,Speedo_TD[1][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[1][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[1][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[1][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[1][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[1][playerid], 85);
PlayerTextDrawTextSize(playerid,Speedo_TD[1][playerid], 480.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[1][playerid], 0);

Speedo_TD[2][playerid] = CreatePlayerTextDraw(playerid,484.000000, 350.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[2][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[2][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[2][playerid], 0.500000, 8.500000);
PlayerTextDrawColor(playerid,Speedo_TD[2][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[2][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[2][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[2][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[2][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[2][playerid], 255);
PlayerTextDrawTextSize(playerid,Speedo_TD[2][playerid], 480.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[2][playerid], 0);

Speedo_TD[3][playerid] = CreatePlayerTextDraw(playerid,644.000000, 409.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[3][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[3][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[3][playerid], 0.500000, 0.699999);
PlayerTextDrawColor(playerid,Speedo_TD[3][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[3][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[3][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[3][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[3][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[3][playerid], 85);
PlayerTextDrawTextSize(playerid,Speedo_TD[3][playerid], 600.000000, -79.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[3][playerid], 0);

Speedo_TD[4][playerid] = CreatePlayerTextDraw(playerid,622.000000, 408.000000, "00000000");
PlayerTextDrawAlignment(playerid,Speedo_TD[4][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[4][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[4][playerid], 2);
PlayerTextDrawLetterSize(playerid,Speedo_TD[4][playerid], 0.149998, 1.000000);
PlayerTextDrawColor(playerid,Speedo_TD[4][playerid], -3273985);
PlayerTextDrawSetOutline(playerid,Speedo_TD[4][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[4][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[4][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[4][playerid], 0);

Speedo_TD[5][playerid] = CreatePlayerTextDraw(playerid,644.000000, 420.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[5][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[5][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[5][playerid], 0.500000, 0.800001);
PlayerTextDrawColor(playerid,Speedo_TD[5][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[5][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[5][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[5][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[5][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[5][playerid], 85);
PlayerTextDrawTextSize(playerid,Speedo_TD[5][playerid], 480.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[5][playerid], 0);

Speedo_TD[6][playerid] = CreatePlayerTextDraw(playerid,650.000000, 420.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[6][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[6][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[6][playerid], 0.500000, -0.500000);
PlayerTextDrawColor(playerid,Speedo_TD[6][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[6][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[6][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[6][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[6][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[6][playerid], 255);
PlayerTextDrawTextSize(playerid,Speedo_TD[6][playerid], 479.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[6][playerid], 0);

Speedo_TD[7][playerid] = CreatePlayerTextDraw(playerid,509.000000, 419.000000, "!S");
PlayerTextDrawAlignment(playerid,Speedo_TD[7][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[7][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[7][playerid], 2);
PlayerTextDrawLetterSize(playerid,Speedo_TD[7][playerid], 0.170000, 1.000000);
PlayerTextDrawColor(playerid,Speedo_TD[7][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[7][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[7][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[7][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[7][playerid], 0);

Speedo_TD[8][playerid] = CreatePlayerTextDraw(playerid,562.000000, 419.000000, "!F");
PlayerTextDrawAlignment(playerid,Speedo_TD[8][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[8][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[8][playerid], 2);
PlayerTextDrawLetterSize(playerid,Speedo_TD[8][playerid], 0.170000, 1.000000);
PlayerTextDrawColor(playerid,Speedo_TD[8][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[8][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[8][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[8][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[8][playerid], 0);

Speedo_TD[9][playerid] = CreatePlayerTextDraw(playerid,607.000000, 419.000000, "~r~!E");
PlayerTextDrawAlignment(playerid,Speedo_TD[9][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[9][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[9][playerid], 2);
PlayerTextDrawLetterSize(playerid,Speedo_TD[9][playerid], 0.170000, 1.000000);
PlayerTextDrawColor(playerid,Speedo_TD[9][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[9][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[9][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[9][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[9][playerid], 0);

Speedo_TD[10][playerid] = CreatePlayerTextDraw(playerid,544.000000, 409.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[10][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[10][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[10][playerid], 0.500000, 0.699999);
PlayerTextDrawColor(playerid,Speedo_TD[10][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[10][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[10][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[10][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[10][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[10][playerid], 85);
PlayerTextDrawTextSize(playerid,Speedo_TD[10][playerid], 580.000000, -79.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[10][playerid], 0);

Speedo_TD[11][playerid] = CreatePlayerTextDraw(playerid,562.000000, 408.000000, "18:20");
PlayerTextDrawAlignment(playerid,Speedo_TD[11][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[11][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[11][playerid], 2);
PlayerTextDrawLetterSize(playerid,Speedo_TD[11][playerid], 0.149998, 1.000000);
PlayerTextDrawColor(playerid,Speedo_TD[11][playerid], -3273985);
PlayerTextDrawSetOutline(playerid,Speedo_TD[11][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[11][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[11][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[11][playerid], 0);

Speedo_TD[12][playerid] = CreatePlayerTextDraw(playerid,518.000000, 409.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[12][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[12][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[12][playerid], 0.500000, 0.699999);
PlayerTextDrawColor(playerid,Speedo_TD[12][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[12][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[12][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[12][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[12][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[12][playerid], 85);
PlayerTextDrawTextSize(playerid,Speedo_TD[12][playerid], 480.000000, -79.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[12][playerid], 0);

Speedo_TD[13][playerid] = CreatePlayerTextDraw(playerid,498.000000, 408.000000, "12/12/2015");
PlayerTextDrawAlignment(playerid,Speedo_TD[13][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[13][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[13][playerid], 2);
PlayerTextDrawLetterSize(playerid,Speedo_TD[13][playerid], 0.139998, 1.000000);
PlayerTextDrawColor(playerid,Speedo_TD[13][playerid], -3273985);
PlayerTextDrawSetOutline(playerid,Speedo_TD[13][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[13][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[13][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[13][playerid], 0);

Speedo_TD[14][playerid] = CreatePlayerTextDraw(playerid,600.000000, 350.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[14][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[14][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[14][playerid], 0.500000, 4.500000);
PlayerTextDrawColor(playerid,Speedo_TD[14][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[14][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[14][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[14][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[14][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[14][playerid], 85);
PlayerTextDrawTextSize(playerid,Speedo_TD[14][playerid], 526.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[14][playerid], 0);

Speedo_TD[15][playerid] = CreatePlayerTextDraw(playerid,564.000000, 356.000000, "300");
PlayerTextDrawAlignment(playerid,Speedo_TD[15][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[15][playerid], 51);
PlayerTextDrawFont(playerid,Speedo_TD[15][playerid], 3);
PlayerTextDrawLetterSize(playerid,Speedo_TD[15][playerid], 0.349999, 1.100000);
PlayerTextDrawColor(playerid,Speedo_TD[15][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[15][playerid], 1);
PlayerTextDrawSetProportional(playerid,Speedo_TD[15][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[15][playerid], 0);

Speedo_TD[16][playerid] = CreatePlayerTextDraw(playerid,531.000000, 369.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[16][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[16][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[16][playerid], 0.500000, 2.400001);
PlayerTextDrawColor(playerid,Speedo_TD[16][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[16][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[16][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[16][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[16][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[16][playerid], 170);
PlayerTextDrawTextSize(playerid,Speedo_TD[16][playerid], 541.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[16][playerid], 0);

Speedo_TD[17][playerid] = CreatePlayerTextDraw(playerid,535.000000, 372.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[17][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[17][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[17][playerid], 0.500000, 0.300000);
PlayerTextDrawColor(playerid,Speedo_TD[17][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[17][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[17][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[17][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[17][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[17][playerid], -86);
PlayerTextDrawTextSize(playerid,Speedo_TD[17][playerid], 537.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[17][playerid], 0);

Speedo_TD[18][playerid] = CreatePlayerTextDraw(playerid,600.000000, 369.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[18][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[18][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[18][playerid], 0.500000, -0.599997);
PlayerTextDrawColor(playerid,Speedo_TD[18][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[18][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[18][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[18][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[18][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[18][playerid], 170);
PlayerTextDrawTextSize(playerid,Speedo_TD[18][playerid], 526.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[18][playerid], 0);

Speedo_TD[19][playerid] = CreatePlayerTextDraw(playerid,552.000000, 386.000000, "40.4");
PlayerTextDrawAlignment(playerid,Speedo_TD[19][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[19][playerid], 51);
PlayerTextDrawFont(playerid,Speedo_TD[19][playerid], 3);
PlayerTextDrawLetterSize(playerid,Speedo_TD[19][playerid], 0.219999, 0.699998);
PlayerTextDrawColor(playerid,Speedo_TD[19][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[19][playerid], 1);
PlayerTextDrawSetProportional(playerid,Speedo_TD[19][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[19][playerid], 0);

Speedo_TD[20][playerid] = CreatePlayerTextDraw(playerid,600.000000, 373.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[20][playerid], 255);
PlayerTextDrawFont(playerid,Speedo_TD[20][playerid], 1);
PlayerTextDrawLetterSize(playerid,Speedo_TD[20][playerid], 0.500000, 1.300001);
PlayerTextDrawColor(playerid,Speedo_TD[20][playerid], -1);
PlayerTextDrawSetOutline(playerid,Speedo_TD[20][playerid], 0);
PlayerTextDrawSetProportional(playerid,Speedo_TD[20][playerid], 1);
PlayerTextDrawSetShadow(playerid,Speedo_TD[20][playerid], 1);
PlayerTextDrawUseBox(playerid,Speedo_TD[20][playerid], 1);
PlayerTextDrawBoxColor(playerid,Speedo_TD[20][playerid], 170);
PlayerTextDrawTextSize(playerid,Speedo_TD[20][playerid], 576.000000, -80.000000);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[20][playerid], 0);

Speedo_TD[21][playerid] = CreatePlayerTextDraw(playerid,588.000000, 376.000000, "~r~0");
PlayerTextDrawAlignment(playerid,Speedo_TD[21][playerid], 2);
PlayerTextDrawBackgroundColor(playerid,Speedo_TD[21][playerid], 51);
PlayerTextDrawFont(playerid,Speedo_TD[21][playerid], 3);
PlayerTextDrawLetterSize(playerid,Speedo_TD[21][playerid], 0.219999, 0.699998);
PlayerTextDrawColor(playerid,Speedo_TD[21][playerid], -3273985);
PlayerTextDrawSetOutline(playerid,Speedo_TD[21][playerid], 1);
PlayerTextDrawSetProportional(playerid,Speedo_TD[21][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Speedo_TD[21][playerid], 0);
// vehicle breaking tds
Vehicle_Breaking_TD[0][playerid] = CreatePlayerTextDraw(playerid,660.000000, 180.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[0][playerid], 255);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[0][playerid], 1);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[0][playerid], 0.500000, 7.099999);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[0][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[0][playerid], 0);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[0][playerid], 1);
PlayerTextDrawSetShadow(playerid,Vehicle_Breaking_TD[0][playerid], 1);
PlayerTextDrawUseBox(playerid,Vehicle_Breaking_TD[0][playerid], 1);
PlayerTextDrawBoxColor(playerid,Vehicle_Breaking_TD[0][playerid], 85);
PlayerTextDrawTextSize(playerid,Vehicle_Breaking_TD[0][playerid], 510.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[0][playerid], 0);

Vehicle_Breaking_TD[1][playerid] = CreatePlayerTextDraw(playerid,660.000000, 180.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[1][playerid], 255);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[1][playerid], 1);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[1][playerid], 0.500000, -0.600000);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[1][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[1][playerid], 0);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[1][playerid], 1);
PlayerTextDrawSetShadow(playerid,Vehicle_Breaking_TD[1][playerid], 1);
PlayerTextDrawUseBox(playerid,Vehicle_Breaking_TD[1][playerid], 1);
PlayerTextDrawBoxColor(playerid,Vehicle_Breaking_TD[1][playerid], 170);
PlayerTextDrawTextSize(playerid,Vehicle_Breaking_TD[1][playerid], 509.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[1][playerid], 0);

Vehicle_Breaking_TD[2][playerid] = CreatePlayerTextDraw(playerid,660.000000, 249.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[2][playerid], 255);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[2][playerid], 1);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[2][playerid], 0.500000, -0.600000);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[2][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[2][playerid], 0);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[2][playerid], 1);
PlayerTextDrawSetShadow(playerid,Vehicle_Breaking_TD[2][playerid], 1);
PlayerTextDrawUseBox(playerid,Vehicle_Breaking_TD[2][playerid], 1);
PlayerTextDrawBoxColor(playerid,Vehicle_Breaking_TD[2][playerid], 170);
PlayerTextDrawTextSize(playerid,Vehicle_Breaking_TD[2][playerid], 510.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[2][playerid], 0);

Vehicle_Breaking_TD[3][playerid] = CreatePlayerTextDraw(playerid,514.000000, 180.000000, "_");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[3][playerid], 255);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[3][playerid], 1);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[3][playerid], 0.500000, 7.099999);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[3][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[3][playerid], 0);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[3][playerid], 1);
PlayerTextDrawSetShadow(playerid,Vehicle_Breaking_TD[3][playerid], 1);
PlayerTextDrawUseBox(playerid,Vehicle_Breaking_TD[3][playerid], 1);
PlayerTextDrawBoxColor(playerid,Vehicle_Breaking_TD[3][playerid], 170);
PlayerTextDrawTextSize(playerid,Vehicle_Breaking_TD[3][playerid], 510.000000, 0.000000);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[3][playerid], 0);

Vehicle_Breaking_TD[4][playerid] = CreatePlayerTextDraw(playerid,518.000000, 180.000000, "Breaking status:");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[4][playerid], 51);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[4][playerid], 2);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[4][playerid], 0.159999, 0.799999);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[4][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[4][playerid], 1);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[4][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[4][playerid], 0);

Vehicle_Breaking_TD[5][playerid] = CreatePlayerTextDraw(playerid,518.000000, 236.000000, "Time until alarm sounds:");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[5][playerid], 51);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[5][playerid], 2);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[5][playerid], 0.159999, 0.799999);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[5][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[5][playerid], 1);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[5][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[5][playerid], 0);

Vehicle_Breaking_TD[6][playerid] = CreatePlayerTextDraw(playerid,612.000000, 236.000000, "~y~50s");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[6][playerid], 51);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[6][playerid], 2);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[6][playerid], 0.159999, 0.799999);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[6][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[6][playerid], 1);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[6][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[6][playerid], 0);

Vehicle_Breaking_TD[7][playerid] = CreatePlayerTextDraw(playerid,568.000000, 193.000000, "Press ~y~ 'Y'");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[7][playerid], 51);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[7][playerid], 2);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[7][playerid], 0.159999, 0.799999);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[7][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[7][playerid], 1);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[7][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[7][playerid], 0);

Vehicle_Breaking_TD[8][playerid] = CreatePlayerTextDraw(playerid,583.000000, 180.000000, "~y~1/5");
PlayerTextDrawBackgroundColor(playerid,Vehicle_Breaking_TD[8][playerid], 51);
PlayerTextDrawFont(playerid,Vehicle_Breaking_TD[8][playerid], 2);
PlayerTextDrawLetterSize(playerid,Vehicle_Breaking_TD[8][playerid], 0.159998, 0.799998);
PlayerTextDrawColor(playerid,Vehicle_Breaking_TD[8][playerid], -1);
PlayerTextDrawSetOutline(playerid,Vehicle_Breaking_TD[8][playerid], 1);
PlayerTextDrawSetProportional(playerid,Vehicle_Breaking_TD[8][playerid], 1);
PlayerTextDrawSetSelectable(playerid,Vehicle_Breaking_TD[8][playerid], 0);
// house lights
House_L_TD[playerid] = CreatePlayerTextDraw(playerid, 644.000000, 1.000000, "_");
PlayerTextDrawBackgroundColor(playerid, House_L_TD[playerid], 255);
PlayerTextDrawFont(playerid, House_L_TD[playerid], 1);
PlayerTextDrawLetterSize(playerid, House_L_TD[playerid], 0.530000, 51.000000);
PlayerTextDrawColor(playerid, House_L_TD[playerid], -1);
PlayerTextDrawSetOutline(playerid, House_L_TD[playerid], 0);
PlayerTextDrawSetProportional(playerid, House_L_TD[playerid], 1);
PlayerTextDrawSetShadow(playerid, House_L_TD[playerid], 1);
PlayerTextDrawUseBox(playerid, House_L_TD[playerid], 1);
PlayerTextDrawBoxColor(playerid, House_L_TD[playerid], 119);
PlayerTextDrawTextSize(playerid, House_L_TD[playerid], -6.000000, 30.000000);
PlayerTextDrawSetSelectable(playerid, House_L_TD[playerid], 0);
return (true);
}

//================================================================================================

stock RegisterPanel(playerid,opcija)
{
	if(opcija == 1)
	{
		for(new i = 0; i < 21; ++i)
        PlayerTextDrawShow(playerid,Register_TD[i][playerid]); SelectTextDraw(playerid, (0xFFFFFFFF));
	}
	else if(opcija == 2)
	{
        for(new i = 0; i < 21; ++i)
        PlayerTextDrawHide(playerid,Register_TD[i][playerid]); CancelSelectTextDraw(playerid);
	}
	return (true);
}

stock Cos_TDs(playerid,opcija)
{
	if(opcija == 1)
	{
        for(new i = 0; i < 14; ++i)
        PlayerTextDrawShow(playerid,Cos_TD[i][playerid]); SelectTextDraw(playerid, (0xFFFFFFFF));
	}
	else if(opcija == 2)
	{
        for(new i = 0; i < 14; ++i)
        PlayerTextDrawHide(playerid,Cos_TD[i][playerid]); CancelSelectTextDraw(playerid);
	}
	else if(opcija == 3)
	{
		for(new i = 0; i < 14; ++i)
        PlayerTextDrawShow(playerid,Cos_TD[i][playerid]);
	}
	return (true);
}

stock Speedo_TDs(playerid,opcija)
{
	if(opcija == 1)
	{
           for(new i = 0; i < 22; ++i)
           PlayerTextDrawShow(playerid,Speedo_TD[i][playerid]);
	}
	else if(opcija == 2)
	{
           for(new i = 0; i < 22; ++i)
           PlayerTextDrawHide(playerid,Speedo_TD[i][playerid]);
	}
	return (true);
}

stock Breaking_TDs(playerid,opcija)
{
	if(opcija == 1)
	{
           for(new i = 0; i < 9; ++i)
           PlayerTextDrawShow(playerid,Vehicle_Breaking_TD[i][playerid]);
	}
	else if(opcija == 2)
	{
           for(new i = 0; i < 9; ++i)
           PlayerTextDrawHide(playerid,Vehicle_Breaking_TD[i][playerid]);
	}
	return (true);
}

stock BanTextdraws(playerid,opcija)
{
	if(opcija == 1)
	{
          for(new i = 0; i < 14; ++i)
          PlayerTextDrawShow(playerid,Ban_TD[i][playerid]);
	}
	else if(opcija == 2)
	{
          for(new i = 0; i < 14; ++i)
          PlayerTextDrawHide(playerid,Ban_TD[i][playerid]);
	}
	return (true);
}

//================================================================================================

stock CreateGlobalTextdraws()
{
	ServerLogo[0] = TextDrawCreate(650.000000, 432.000000, "_");
	TextDrawBackgroundColor(ServerLogo[0], 255);
	TextDrawFont(ServerLogo[0], 1);
	TextDrawLetterSize(ServerLogo[0], 0.500000, 1.300000);
	TextDrawColor(ServerLogo[0], -1);
	TextDrawSetOutline(ServerLogo[0], 0);
	TextDrawSetProportional(ServerLogo[0], 1);
	TextDrawSetShadow(ServerLogo[0], 1);
	TextDrawUseBox(ServerLogo[0], 1);
	TextDrawBoxColor(ServerLogo[0], 85);
	TextDrawTextSize(ServerLogo[0], -10.000000, 0.000000);
	TextDrawSetSelectable(ServerLogo[0], 0);

	ServerLogo[1] = TextDrawCreate(15.000000, 432.000000, "BR");
	TextDrawBackgroundColor(ServerLogo[1], 51);
	TextDrawFont(ServerLogo[1], 3);
	TextDrawLetterSize(ServerLogo[1], 0.260000, 1.000000);
	TextDrawColor(ServerLogo[1], -5373697);
	TextDrawSetOutline(ServerLogo[1], 1);
	TextDrawSetProportional(ServerLogo[1], 1);
	TextDrawSetSelectable(ServerLogo[1], 0);

	ServerLogo[2] = TextDrawCreate(11.000000, 439.000000, "Poruke:");
	TextDrawBackgroundColor(ServerLogo[2], 51);
	TextDrawFont(ServerLogo[2], 2);
	TextDrawLetterSize(ServerLogo[2], 0.110000, 0.699999);
	TextDrawColor(ServerLogo[2], -1);
	TextDrawSetOutline(ServerLogo[2], 1);
	TextDrawSetProportional(ServerLogo[2], 1);
	TextDrawSetSelectable(ServerLogo[2], 0);

	ServerLogo[3] = TextDrawCreate(321.000000, 434.000000, "Dobrodosli na Balkan Rising Roleplay.");
	TextDrawAlignment(ServerLogo[3], 2);
	TextDrawBackgroundColor(ServerLogo[3], 51);
	TextDrawFont(ServerLogo[3], 1);
	TextDrawLetterSize(ServerLogo[3], 0.189999, 1.000000);
	TextDrawColor(ServerLogo[3], -1);
	TextDrawSetOutline(ServerLogo[3], 1);
	TextDrawSetProportional(ServerLogo[3], 1);
	TextDrawSetSelectable(ServerLogo[3], 0);

	ServerLogo[4] = TextDrawCreate(650.000000, 432.000000, "_");
	TextDrawBackgroundColor(ServerLogo[4], 255);
	TextDrawFont(ServerLogo[4], 1);
	TextDrawLetterSize(ServerLogo[4], 0.500000, -0.599999);
	TextDrawColor(ServerLogo[4], -1);
	TextDrawSetOutline(ServerLogo[4], 0);
	TextDrawSetProportional(ServerLogo[4], 1);
	TextDrawSetShadow(ServerLogo[4], 1);
	TextDrawUseBox(ServerLogo[4], 1);
	TextDrawBoxColor(ServerLogo[4], 170);
	TextDrawTextSize(ServerLogo[4], -10.000000, 0.000000);
	TextDrawSetSelectable(ServerLogo[4], 0);
    return (true);
}

//================================================================================================

stock ShowGlobalTDs(playerid,opcija)
{
	if(opcija == 1)
	  for(new i = 0; i < 4; i++) { TextDrawShowForPlayer(playerid,ServerLogo[i]);}
	else if(opcija == 2)
	  for(new i = 0; i < 4; i++) { TextDrawHideForPlayer(playerid,ServerLogo[i]);}
	return (true);    
}

//================================================================================================